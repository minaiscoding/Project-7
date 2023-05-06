from flask import Flask, request, jsonify
import influxdb_client
from influxdb_client.client.write_api import SYNCHRONOUS
import hashlib



app = Flask(__name__)
bucket = "myusers"
org = "2cpProject"
token = "m-RlxCAkiz-d4tvcVFll9ml5pNpB654vi2XtsSx_2pV_OCASVCEF6naraD8JErGcOsp6qH56nD7NTWnYcPpeCA=="
# Store the URL of your InfluxDB instance
url = "http://localhost:8086"

client = influxdb_client.InfluxDBClient(
    url=url,
    token=token,
    org=org
)
query_api = client.query_api()


@app.route('/signup', methods=['POST'])
def signup():
    data = request.json
    required_fields = ['full_name', 'tank_number', 'phone_number',
                       'password', 'confirm_password']
    for field in required_fields:
        if (data.get(field) == ""):
            field = field.replace("_", " ")
            return jsonify({'error': f'{field} is required'}), 400

    full_name = data['full_name']
    tank_number = int(data['tank_number'])
    phone_number = int(data['phone_number'])
    password = (data['password'])
    confirm_password = (data['confirm_password'])

    if password != confirm_password:
        return jsonify({'error': 'Passwords do not match'}), 400

    # check if the tank number or the phone number already exist in the users measurement

    query = f'from(bucket:"{bucket}") \
     |> range(start: -1h) \
     |> filter(fn: (r) => r["_measurement"] == "users1") \
     |> filter(fn: (r) => r["_field"] == "phone_number" )\
     |> filter(fn: (r) => r["_value"] == {phone_number})'

    result = query_api.query(org=org, query=query)
    if len(result) > 0:
        return jsonify({'error': 'User with this phone number already exists'}), 400

    # create new user
    write_api = client.write_api(write_options=SYNCHRONOUS)

    data = [
        {
            "measurement": "users1",
            "tags": {
                "org": org,
                "bucket": bucket
            },
            "fields": {
                "full_name": full_name,
                "tank_number": tank_number,
                "phone_number": phone_number,
                "password_hash": password
            }
        }
    ]

    write_api.write(bucket=bucket, org=org, record=data)

    return jsonify({'message': 'User created successfully'}), 201


@app.route('/add_tank_cuboid', methods=['POST'])
def add_tank_cuboid():
    data = request.json
    required_fields = ['tank_number',
                       'tank_height', 'base_width', 'base_length']
    for field in required_fields:
        if (data.get(field) == ""):
            field = field.replace("_", " ")
            return jsonify({'error': f'{field} is required'}), 400

    tank_number = int(data['tank_number'])
    tank_volume = float(data['tank_height'])*float(data['base_width'])*float(data['base_length'])

    # Store the tank information in the 'tanks' measurement
    write_api = client.write_api(write_options=SYNCHRONOUS)

    data = [
        {
            "measurement": "tanks",
            "tags": {
                "org": org,
                "bucket": bucket
            },
            "fields": {
                "tank_number": tank_number,
                "tank_volume": tank_volume
            }
        }
    ]

    write_api.write(bucket=bucket, org=org, record=data)

    return jsonify({'message': 'Tank information stored successfully'}), 201


@app.route('/add_tank_cylinder', methods=['POST']) # for the cylinder shape
def add_tank_cylinder():
    data = request.json
    
    required_fields = ['tank_number',
                       'tank_height', 'tank_width']
    for field in required_fields:
        if (data.get(field) == ""):
            field = field.replace("_", " ")
            return jsonify({'error': f'{field} is required'}), 400

    tank_number = int(data['tank_number'])
    tank_volume = float(data['tank_height'])*3.14*(float(data['tank_width'])/2)**2

    # Store the tank information in the 'tanks-cylinder' measurement
    write_api = client.write_api(write_options=SYNCHRONOUS)

    data = [
        {
            "measurement": "tanks",
            "tags": {
                "org": org,
                "bucket": bucket
            },
            "fields": {
                "tank_number": tank_number,
                "tank_volume": tank_volume
            }
        }
    ]

    write_api.write(bucket=bucket, org=org, record=data)

    return jsonify({'message': 'Tank information stored successfully'}), 201

@app.route('/signin', methods=['POST'])
def signin():
    data = request.json
    required_fields = ['phone_number', 'password']
    for field in required_fields:
        if (data.get(field) == ""):
            field = field.replace("_", " ")
            return jsonify({'error': f'{field} is required'}), 400

    phone_number = int(data['phone_number'])
    password = (data['password'])

    query = f'from(bucket:"{bucket}") \
     |> range(start: -1h) \
     |> filter(fn: (r) => r["_measurement"] == "users1") \
     |> pivot(rowKey:["_time"], columnKey:["_field"], valueColumn:"_value")\
     |> filter(fn: (r) => r.password_hash == "{password}" and r.phone_number == {phone_number})'

    result = query_api.query(org=org, query=query)

    if len(result) > 0:
        tank_number = result[0].get('tank_number')
        return jsonify({'tank_number': str(tank_number)}), 200
    else:
        return jsonify({'error': 'Incorrect password or phone number'}), 401


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True, threaded=True)
