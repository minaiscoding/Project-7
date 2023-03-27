from flask import Flask, jsonify

import time
import influxdb_client
from influxdb_client.client.write_api import SYNCHRONOUS

app = Flask(__name__)

bucket = "tanks"
org = "Esi"
token = "ol5mrXy-T5LzEa6wJVMlq1YASlBa9kPOcZZBvm963HIGO6bts0_BUHJT8pqN1MbKo2TQe8-2YqGrS-_J_5N84A=="
# Store the URL of your InfluxDB instance
url="http://localhost:8086"

client = influxdb_client.InfluxDBClient(
    url=url,
    token=token,
    org=org
)

# Query script
query_api = client.query_api()

@app.route('/water-level')
def get_water_level():
    query = f'from(bucket:"{bucket}")\
    |> range(start: -5s)\
    |> filter(fn: (r) => r["_measurement"] == "water_level")\
    |> filter(fn: (r) => r["_field"] == "value")\
    |> filter(fn: (r) => r["sensor"] == "\'001\'")'
    result = query_api.query(org=org, query=query)
    for table in result:
        for record in table.records:
            if record.get_field() == 'value' and float(record.get_value()) < 20:
                return jsonify({'water_level': float(record.get_value())}), 200
    return '', 204

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True, threaded=True)
