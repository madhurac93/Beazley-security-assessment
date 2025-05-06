import json
import argparse
import logging
from nested_lookup import get_nested_value

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)

def main():
    parser = argparse.ArgumentParser(description="Nested JSON key path lookup tool")
    parser.add_argument("--json", help="JSON string (e.g. '{\"a\": {\"b\": {\"c\": \"value\"}}}')")
    parser.add_argument("--json-file", help="Path to JSON file")
    parser.add_argument("--path", required=True, help="Key path using '/' (e.g. a/b/c)")
    parser.add_argument("--sep", default="/", help="Path separator (default: '/')")
    parser.add_argument("--verbose", action="store_true", help="Enable debug logging")

    args = parser.parse_args()

    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)

    if not args.json and not args.json_file:
        logging.error("Please provide either --json or --json-file.")
        return

    # Load from JSON string
    if args.json:
        try:
            input_data = json.loads(args.json)
        except json.JSONDecodeError as e:
            logging.error(f"Invalid JSON format: {e}")
            return

    # Load from file
    elif args.json_file:
        try:
            with open(args.json_file, 'r') as f:
                input_data = json.load(f)
        except Exception as e:
            logging.error(f"Failed to load JSON file: {e}")
            return

    result = get_nested_value(input_data, args.path, args.sep)

    if result is not None:
        print(json.dumps(result, indent=2) if isinstance(result, dict) else f"Result: {result}")
    else:
        print("Value not found for the given path.")

if __name__ == "__main__":
    main()
