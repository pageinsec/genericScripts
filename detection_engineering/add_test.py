# Simple script to add a single test case to Panther Python detection YAML files
# Use quotes on test name if there are spaces in the name
# Use True/False for boolean values
# Format: python add_test.py <path_to_test_file> <result> <test_name> <path_to_detection_yaml_file>
# If this is in panther-analysis/scripts and running from that directory, with the test file in custom_tests directory:
# python add_test.py ../custom_tests/new_test.json True "New Test" ../rules/aws_cloudtrail_rules/aws_add_malicious_lambda_extension.yml
# This will work with json copied directly out of Panther

import json
import yaml
import fire

def convert_and_update(json_file, result, testname, config_file):
	event_prep = {"Expected Result": result, "Name": testname, "Log":{},}
	with open(config_file, 'r+') as config:
		old = yaml.safe_load(config)
		newtest = format_event(event_prep, json_file)
		old["Tests"].append(newtest)
		config.seek(0)
		config.write(yaml.safe_dump(old, sort_keys=False))
		config.truncate()
	
def format_event(event_prep, json_file):
	with open(json_file) as nte:
		event_prep["Log"] = json.load(nte)
		return yaml.safe_load(yaml.safe_dump(event_prep, allow_unicode=True, sort_keys=False))

if __name__=='__main__':
	fire.Fire(convert_and_update)
