from flask import Flask
import random

app = Flask(__name__)

@app.route('/')
def get_number():
    number = random.randint(1, 100)
    return str(number)

if __name__ == '__main__':
    app.run(host='0.0.0.0')
