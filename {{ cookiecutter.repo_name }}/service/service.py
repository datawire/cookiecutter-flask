#!/usr/bin/env python

import time

from flask import Flask, jsonify
app = Flask(__name__)


@app.route('/<name>', methods=['GET'])
def hello(name):
    return jsonify(message="Hello, {}!".format(name), time=time.time() * 1000)


def main():
    app.run(debug=True)


if __name__ == '__main__':
    main()
