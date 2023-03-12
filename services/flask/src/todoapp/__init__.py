import logging
import os
from mongoengine import *
from flask import Flask

logging.basicConfig(
    level=logging.DEBUG,
    format='[%(asctime)s]: {} %(levelname)s %(message)s'.format(os.getpid()),
    datefmt='%Y-%m-%d %H:%M:%S', handlers=[logging.StreamHandler()])

logger = logging.getLogger()

def create_app():
    app = Flask(__name__)

    username = 'dark0ne'
    password = 'AdminnimdA'
    server = '34.88.216.43'
    port = '16985'
    db_name = 'todo-app'
    uri = f'mongodb://{username}:{password}@{server}:{port}/{db_name}?authSource=admin&retryWrites=true&w=majority'
    connect(db=db_name, 
            username=username,
            password=password,
            host=uri)

    @app.route("/")
    def homepage():
        return "Hello"
        # return jsonify(
        #     {"status": "OK", "hostname": os.environ.get("PARENT_HOSTNAME"), "request": request.headers})

    from todoapp import api

    return app

if __name__ == "__main__":
   app = create_app()
   app.app_context()
   app.run(host='0.0.0.0', debug=True)
