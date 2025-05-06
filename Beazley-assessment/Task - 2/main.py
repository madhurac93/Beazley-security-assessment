import requests
import json
import argparse
import logging

# Setup logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)

AZURE_METADATA_URL = "http://169.254.169.254/metadata/instance?api-version=2021-02-01"
HEADERS = {"Metadata": "true"}

def fetch_metadata():
    try:
        logging.info("Fetching Azure instance metadata...")
        response = requests.get(AZURE_METADATA_URL, headers=HEADERS, timeout=5)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        logging.error(f"Failed to retrieve metadata: {e}")
        return None

def get_nested_value(data, path, separator="/"):
    keys = path.strip().split(separator)
    try:
        for key in keys:
            data = data[key]
        return data
    except (KeyError, TypeError) as e:
        logging.warning(f"Path '{path}' not found: {e}")
        return None

def main():
    parser = argparse.ArgumentParser(description="Query Azure VM instance metadata")
    parser.add_argument("--key", help="Nested key path to retrieve (e.g. compute/name)")
    parser.add_argument("--sep", default="/", help="Separator for key path (default: '/')")
    parser.add_argument("--verbose", action="store_true", help="Enable debug logging")

    args = parser.parse_args()

    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)

    metadata = fetch_metadata()
    if metadata is None:
        return

    if args.key:
        result = get_nested_value(metadata, args.key, args.sep)
        if result is not None:
            print(json.dumps(result, indent=2) if isinstance(result, dict) else f"Result: {result}")
        else:
            print(f"Key '{args.key}' not found.")
    else:
        print(json.dumps(metadata, indent=2))

if __name__ == "__main__":
    main()
