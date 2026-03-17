"""SHACL validator for RDF instance data using pyshacl."""

from pathlib import Path
from typing import List, Optional, Tuple, Union

from pyshacl import validate
from rdflib import Graph


def _guess_rdf_format(path: Path) -> Optional[str]:
    """Infer rdflib format from file extension."""
    if path.suffix == ".ttl":
        return "turtle"
    if path.suffix == ".rdf":
        return "xml"
    if path.suffix == ".jsonld":
        return "json-ld"
    if path.suffix == ".nt":
        return "nt"
    return None


def _normalize_shapes_files(shapes_file: Union[str, List[str], None]) -> List[Path]:
    """Normalize one or more SHACL shape file paths into Path objects."""
    if shapes_file is None:
        return []

    if isinstance(shapes_file, str):
        return [Path(shapes_file)]

    return [Path(shape_path) for shape_path in shapes_file]


def validate_shacl(
    filepath: str,
    shapes_file: Union[str, List[str], None] = None,
    ont_file: Union[str, List[str], None] = None,
) -> Tuple[bool, str]:
    """
    Validate an RDF data file against SHACL shapes.

    Args:
        filepath: Path to the RDF data file to validate
        shapes_file: Path(s) to SHACL shapes file(s)
        ont_file: Path(s) to ontology file(s) used for class-hierarchy inference

    Returns:
        Tuple of (success: bool, message: str)
    """
    data_path = Path(filepath)
    if not data_path.exists():
        return False, f"Data file not found: {filepath}"

    shapes_paths = _normalize_shapes_files(shapes_file)
    if not shapes_paths:
        return False, "At least one SHACL shapes file path is required for SHACL validation"

    missing_shapes = [str(shape_path) for shape_path in shapes_paths if not shape_path.exists()]
    if missing_shapes:
        return False, f"SHACL shapes file(s) not found: {', '.join(missing_shapes)}"

    ont_paths = _normalize_shapes_files(ont_file)
    missing_ont = [str(p) for p in ont_paths if not p.exists()]
    if missing_ont:
        return False, f"Ontology file(s) not found: {', '.join(missing_ont)}"

    try:
        data_graph = Graph()
        data_graph.parse(str(data_path), format=_guess_rdf_format(data_path))

        shapes_graph = Graph()
        for shapes_path in shapes_paths:
            shapes_graph.parse(str(shapes_path), format=_guess_rdf_format(shapes_path))

        ont_graph = None
        if ont_paths:
            ont_graph = Graph()
            for ont_path in ont_paths:
                ont_graph.parse(str(ont_path), format=_guess_rdf_format(ont_path))

        shapes_desc = ", ".join(str(shape_path) for shape_path in shapes_paths)

        conforms, _, results_text = validate(
            data_graph=data_graph,
            shacl_graph=shapes_graph,
            ont_graph=ont_graph,
            inference="rdfs",
            abort_on_first=False,
            meta_shacl=False,
            advanced=True,
            js=False,
            debug=False,
            do_owl_imports=False,
        )

        if conforms:
            return (
                True,
                f"✓ SHACL validation passed against {shapes_desc}"
                f" (data triples: {len(data_graph)}, shapes triples: {len(shapes_graph)})",
            )

        return False, (
            f"SHACL validation failed against {shapes_desc}\n"
            f"{results_text.strip()}"
        )
    except Exception as err:
        return False, f"Unexpected SHACL validation error: {type(err).__name__}: {err}"
