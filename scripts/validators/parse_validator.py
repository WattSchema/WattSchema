"""RDF parse-only validator using rdflib."""

import sys
from pathlib import Path
from typing import Tuple
from rdflib import Graph
from rdflib.exceptions import ParserError


def validate_parse(filepath: str) -> Tuple[bool, str]:
    """
    Validate that an RDF file can be parsed successfully.
    
    Args:
        filepath: Path to the RDF file to validate
        
    Returns:
        Tuple of (success: bool, message: str)
    """
    file_path = Path(filepath)
    
    if not file_path.exists():
        return False, f"File not found: {filepath}"
    
    try:
        g = Graph()
        # Guess format from extension, or let rdflib auto-detect
        format_hint = None
        if file_path.suffix == '.ttl':
            format_hint = 'turtle'
        elif file_path.suffix == '.rdf':
            format_hint = 'xml'
        elif file_path.suffix == '.jsonld':
            format_hint = 'json-ld'
        elif file_path.suffix == '.nt':
            format_hint = 'nt'
        
        g.parse(str(file_path), format=format_hint)
        
        triple_count = len(g)
        return True, f"✓ Successfully parsed {triple_count} triples"
        
    except ParserError as e:
        return False, f"Parse error: {str(e)}"
    except Exception as e:
        return False, f"Unexpected error: {type(e).__name__}: {str(e)}"


def main():
    """CLI entry point for testing individual files."""
    if len(sys.argv) < 2:
        print("Usage: python -m validators.parse_validator <file.ttl>")
        sys.exit(1)
    
    filepath = sys.argv[1]
    success, message = validate_parse(filepath)
    
    print(f"{filepath}: {message}")
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
