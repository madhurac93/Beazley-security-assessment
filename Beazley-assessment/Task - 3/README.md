## RUN
python3 main.py --json '{"a": {"b": {"c": "value"}}}' --path a/b/c
python3 main.py --json-file input.json --path a/b/c


## Function
get_nested_value - Takes in the input dictionary and splist the path based on specified separator (default is /). It loop through the dictionary and checks if the value exists for the specified key through path value, else raises error 