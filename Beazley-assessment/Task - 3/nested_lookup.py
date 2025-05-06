import logging
from typing import Any, Optional

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)

def get_nested_value(data: dict, path: str, separator: str = "/") -> Optional[Any]:
    """
    Retrieves a nested value from a dictionary using a '/'-separated key path.
    """
    if not isinstance(data, dict):
        logging.error("Input is not a dictionary.")
        return None

    if not path:
        logging.error("Path is empty.")
        return None

    keys = path.split(separator)
    current = data

    for key in keys:
        if not isinstance(current, dict):
            logging.warning(f"Expected dict at key '{key}', got: {type(current)}")
            return None
        try:
            print(key, current, current[key])
            current = current[key]
        except KeyError:
            logging.warning(f"Key '{key}' not found.")
            return None

    logging.info(f"Successfully resolved path '{path}' to: {current}")
    return current
