from mongoengine import *
from datetime import datetime

class Project(EmbeddedDocument):
    title = StringField(required=True)
    description = StringField()

class Task(Document):
    title = StringField(required=True)
    description = StringField()
    completed = BooleanField(default=False)
    created_at = DateTimeField(default=datetime.now())