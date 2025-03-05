import json

json_data = None
with open('commands_updated.json') as f:
    json_data = json.load(f)


types = set([v['type'] for v in json_data['syntax']])
print(types)
