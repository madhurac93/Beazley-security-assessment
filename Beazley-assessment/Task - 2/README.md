Metadata is read from: http://169.254.169.254/metadata/instance


##RUN
python3 main.py 
or
python main.py --key compute/name 
or 
python main.py --key compute.name --sep .

fetch_metadata - gets the response from metadata url, else raises an error
get_nested_value - it retrieves a specified nested value from a JSON dictionary(metadata response) using a human-readable path like "compute/name" or "network/interface/0/ipv4/ipAddress/0/privateIpAddress".

