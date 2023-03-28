from flask import Flask, request, jsonify
import influxdb_client
from influxdb_client.client.write_api import SYNCHRONOUS
import hashlib


def hash_password(password):
    salt = "some_random_salt"
    hash_obj = hashlib.sha256((password + salt).encode())
    return hash_obj.hexdigest()


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


@app.route('/signup', methods=['POST'])
def signup():
    data = request.json
    required_fields = ['full_name', 'tank_number', 'phone_number',
                       'password', 'confirm_password']
    if not all([field in data for field in required_fields]):
        return jsonify({'error': 'Missing required fields'}), 400

    full_name = data['full_name']
    tank_number = data['tank_number']
    phone_number = data['phone_number']
    password = data['password']
    confirm_password = data['confirm_password']

    if password != confirm_password:
        return jsonify({'error': 'Passwords do not match'}), 400

    query = f'SELECT * FROM "users" WHERE tank_number=\'{tank_number}\' OR phone_number=\'{phone_number}\''
    result = client.query(query)

    if result:
        for r in result.get_points():
            if r['tank_number'] == tank_number:
                return jsonify({'error': 'User with this tank number already exists'}), 400
            elif r['phone_number'] == phone_number:
                return jsonify({'error': 'User with this phone number already exists'}), 400

    data = [
        {
            'measurement': 'users',
            'fields': {
                'full_name': full_name,
                'tank_number': tank_number,
                'phone_number': phone_number,
                'password_hash': hash_password(password)
            }
        }
    ]

    write_api = client.write_api(write_options=SYNCHRONOUS)
    write_api.write(bucket=bucket, org=org, record=data)

    return jsonify({'message': 'User created successfully'}), 201


@app.route('/signin', methods=['POST'])
def signin():
    data = request.json
    required_fields = ['tank_number', 'password']
    if not all([field in data for field in required_fields]):
        return jsonify({'error': 'Missing required fields'}), 400

    tank_number = data['tank_number']
    password = data['password']

    query = f'SELECT * FROM "users" WHERE tank_number=\'{tank_number}\''
    result = client.query(query)

    if result:
        for r in result.get_points():
            if r['password_hash'] == hash_password(password):
                return jsonify({
                    'full_name': r['full_name'],
                    'tank_number': r['tank_number'],
                    'phone_number': r['phone_number']
                }), 200
            else:
                return jsonify({'error': 'Incorrect password'}), 401
    else:
        return jsonify({'error': 'User not found'}), 401


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True, threaded=True)
