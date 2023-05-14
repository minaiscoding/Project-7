from flask import Flask, request, jsonify
import influxdb_client
from influxdb_client.client.write_api import SYNCHRONOUS
import hashlib

app = Flask(__name__)

bucket = "UserData"
org = "Fluid"
token = "8jtFDtDrQpDKrjceYg8ZKAyRL90Muwa1H0xm1dGsyNKPEbNUnG-Oz4t5XILOJAf2nZAu9lZIxZMfgvUuxOvY1g=="
url = "https://us-east-1-1.aws.cloud2.influxdata.com"

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
    tank_number = data['tank_number']
    phone_number = (data['phone_number'])
    password = (data['password'])
    confirm_password = (data['confirm_password'])

    if password != confirm_password:
        return jsonify({'error': 'Passwords do not match'}), 400

    # check if the tank number or the phone number already exist in the users measurement

    query = f'from(bucket:"{bucket}") \
     |> range(start: -1h) \
     |> filter(fn: (r) => r["_measurement"] == "users1") \
     |> filter(fn: (r) => r["phone_number"] == "{phone_number}")'

    result = query_api.query(org=org, query=query)
    if len(result) > 0:
        return jsonify({'error': 'User with this phone number already exists'}), 400

    # create new user
    write_api = client.write_api(write_options=SYNCHRONOUS)

    data = [
        {
            "measurement": "users1",
            "tags": {
               "phone_number": phone_number,
            },
            "fields": {
                "full_name": full_name,
                "tank_number": tank_number,
                
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

    tank_number = data['tank_number']
    tank_height = float(data['tank_height'])
    tank_width = float(data['base_width'])
    tank_length = float(data['base_length'])

    # Store the tank information in the 'tanks' measurement
    write_api = client.write_api(write_options=SYNCHRONOUS)

    data = [
        {
            "measurement": "tanks",
            "tags": {
                "tank_number": tank_number,
            },
            "fields": {
                "tank_shape":"Cuboid",
                "tank_height": tank_height,
                "tank_width": tank_width,
                "tank_length": tank_length,
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

    tank_number = (data['tank_number'])
    tank_height = float(data['tank_height'])
    tank_baseDiameter = float(data['tank_width'])

    # Store the tank information in the 'tanks-cylinder' measurement
    write_api = client.write_api(write_options=SYNCHRONOUS)

    data = [
        {
            "measurement": "tanks",
            "tags": {
                "tank_number": tank_number,
            },
            "fields": {
                "tank_shape" : "Cylinder",
                "tank_height": tank_height,
                "tank_baseDiameter": tank_baseDiameter,
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

    phone_number = (data['phone_number'])
    password = (data['password'])

    query = f'from(bucket:"{bucket}") \
     |> range(start: -1h) \
     |> filter(fn: (r) => r["_measurement"] == "users1") \
     |> filter(fn: (r) => r["phone_number"] == "{phone_number}") \
     |> filter(fn: (r) => r["_field"] == "password_hash") \
     |> filter(fn: (r) => r["_value"] == "{password}")'

    result = query_api.query(org=org, query=query)

    if len(result) > 0:
        return jsonify({'success':'correct'} ), 200
    else:
        return jsonify({'error': 'Incorrect password or phone number'}), 401


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True, threaded=True)