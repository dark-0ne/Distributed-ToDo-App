from todoapp import models
from flask import request, Flask
from flask import current_app as app

with app.app_context():
    @app.route("/api/tasks/create", methods=["POST"])
    def task_create():
        for i in range(1,10000):
            print(f'iteration {i}')
            model = models.Task(title=f'{request.json["title"]}-{i}')
            try:
                model.save()
                # return model.to_json()
            except Exception as e:
                print(str(e))
        return "OK"