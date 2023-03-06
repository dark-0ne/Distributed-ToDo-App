import logging
import os

from flask import Flask, jsonify, request

logging.basicConfig(
    level=logging.DEBUG,
    format='[%(asctime)s]: {} %(levelname)s %(message)s'.format(os.getpid()),
    datefmt='%Y-%m-%d %H:%M:%S', handlers=[logging.StreamHandler()])

logger = logging.getLogger()


def create_app():
   app = Flask(__name__)

   @app.route("/")
   def homepage():
       return jsonify(
           {"status": "OK", "hostname": os.environ.get("PARENT_HOSTNAME")})

   return app


if __name__ == "__main__":
   app = create_app()
   app.run(host='0.0.0.0', debug=True)
