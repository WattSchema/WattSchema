#!/usr/bin/env python3
"""
RDF validation script for ontology and instance files.

This script validates RDF files by parsing them and checking their structure.
It can be run locally or in CI/CD pipelines.
"""

import sys
import argparse
from pathlib import Path
from dataclasses import dataclass
from typing import List, Literal, Optional, Union

# Add the scripts directory to the path so we can import validators
sys.path.insert(0, str(Path(__file__).parent))

from validators import validate_parse, validate_shacl


@dataclass
class ValidationRule:
    """Configuration for a group of files to validate."""
    name: str
    files: List[str]
    validator_type: Literal["parse", "shacl"]
    shacl_shapes: Optional[Union[str, List[str]]] = None
    ont_files: Optional[Union[str, List[str]]] = None


# Validation configuration
# This is the source of truth for which files get validated and how
VALIDATION_RULES = [
    ValidationRule(
        name="DCPM Core Ontologies",
        files=[
            "DCPM/ontology/DCPM_Core/DataCenterPowerManagement_Ontology_CORE.ttl"
        ],
        validator_type="parse"
    ),
    ValidationRule(
        name="DCPM Simple Mock (v1 SHACL)",
        files=[
            "DCPM/ontology/example_models/simple_mock_dc.ttl",
        ],
        validator_type="shacl",
        shacl_shapes=["DCPM/ontology/shacl_profiles/example_profile/example_profile_shacl.ttl",
                      "DCPM/ontology/DCPM_Core/DataCenterPowerManagement_Ontology_CORE.ttl"],
        ont_files=["DCPM/ontology/DCPM_Core/DataCenterPowerManagement_Ontology_CORE.ttl",
                   "DCPM/ontology/DCPM_Core/DCPM_Brick_Ext.ttl"],
    ),
]


@dataclass
class ValidationResult:
    """Result of validating a single file."""
    filepath: str
    passed: bool
    message: str


@dataclass
class RuleResult:
    """Result of validating all files in a rule."""
    rule_name: str
    results: List[ValidationResult]
    
    @property
    def passed(self) -> bool:
        return all(r.passed for r in self.results)
    
    def summary(self) -> str:
        """Generate a human-readable summary."""
        status = "✓ PASSED" if self.passed else "✗ FAILED"
        lines = [f"\n{status}: {self.rule_name}"]
        for result in self.results:
            icon = "  ✓" if result.passed else "  ✗"
            lines.append(f"{icon} {result.filepath}")
            if not result.passed or args.verbose:
                lines.append(f"    {result.message}")
        return "\n".join(lines)


def validate_file(
    filepath: str,
    validator_type: str,
    shacl_shapes: Optional[Union[str, List[str]]] = None,
    ont_files: Optional[Union[str, List[str]]] = None,
) -> ValidationResult:
    """
    Validate a single file using the specified validator.

    Args:
        filepath: Path to the file to validate
        validator_type: Type of validation ("parse" or "shacl")
        shacl_shapes: Path(s) to SHACL shapes file(s) (if validator_type is "shacl")
        ont_files: Path(s) to ontology file(s) for class-hierarchy inference

    Returns:
        ValidationResult with the outcome
    """
    if validator_type == "parse":
        passed, message = validate_parse(filepath)
    elif validator_type == "shacl":
        passed, message = validate_shacl(filepath, shacl_shapes, ont_files)
    else:
        passed, message = False, f"Unknown validator type: {validator_type}"

    return ValidationResult(filepath=filepath, passed=passed, message=message)


def validate_rule(rule: ValidationRule) -> RuleResult:
    """
    Validate all files in a rule.
    
    Args:
        rule: ValidationRule to execute
        
    Returns:
        RuleResult with outcomes for all files
    """
    results = []
    for filepath in rule.files:
        result = validate_file(filepath, rule.validator_type, rule.shacl_shapes, rule.ont_files)
        results.append(result)
    
    return RuleResult(rule_name=rule.name, results=results)


def main():
    """Main entry point for the validation script."""
    parser = argparse.ArgumentParser(
        description="Validate RDF files (ontologies and instances)"
    )
    parser.add_argument(
        "--file",
        help="Validate a single file (bypasses validation rules)"
    )
    parser.add_argument(
        "--validator",
        choices=["parse", "shacl"],
        default="parse",
        help="Validator type to use with --file (default: parse)"
    )
    parser.add_argument(
        "--shacl-shapes",
        nargs="+",
        help="Path(s) to SHACL shapes file(s), space-separated (required when --validator shacl with --file)"
    )
    parser.add_argument(
        "--rule",
        help="Run only the validation rule with this name"
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Show detailed output even for passing validations"
    )
    
    global args
    args = parser.parse_args()
    
    # Change to repo root (script is in scripts/ directory)
    repo_root = Path(__file__).parent.parent
    import os
    os.chdir(repo_root)
    
    # Single file validation mode
    if args.file:
        print(f"Validating single file: {args.file}")
        if args.validator == "shacl" and not args.shacl_shapes:
            print("Error: --shacl-shapes is required when using --validator shacl with --file")
            sys.exit(1)

        result = validate_file(args.file, args.validator, args.shacl_shapes)
        print(f"{result.filepath}: {result.message}")
        sys.exit(0 if result.passed else 1)
    
    # Normal mode: validate all rules (or specific rule)
    rules_to_run = VALIDATION_RULES
    if args.rule:
        rules_to_run = [r for r in VALIDATION_RULES if r.name == args.rule]
        if not rules_to_run:
            print(f"Error: No rule found with name '{args.rule}'")
            print("\nAvailable rules:")
            for rule in VALIDATION_RULES:
                print(f"  - {rule.name}")
            sys.exit(1)
    
    print("=" * 60)
    print("RDF Validation Report")
    print("=" * 60)
    
    all_passed = True
    for rule in rules_to_run:
        result = validate_rule(rule)
        print(result.summary())
        if not result.passed:
            all_passed = False
    
    print("\n" + "=" * 60)
    if all_passed:
        print("✓ ALL VALIDATIONS PASSED")
    else:
        print("✗ SOME VALIDATIONS FAILED")
    print("=" * 60)
    
    sys.exit(0 if all_passed else 1)


if __name__ == "__main__":
    main()
