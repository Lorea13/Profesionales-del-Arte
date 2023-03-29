from fastapi import APIRouter
from config.db import conn
from models.activityType import activityTypes
from schemas.activityType_schema import ActivityType

activityType = APIRouter()

@activityType.get("/activityTypes", response_model= list[ActivityType], tags= ["ActivityTypes"], description= "**Return all** the activityTypes", response_description="All the activityTypes")
def get_activityTypes():
    return conn.execute(activityTypes.select()).fetchall()

@activityType.post("/activityTypes", response_model= ActivityType, tags= ["ActivityTypes"], description="**Create** a activityType.", response_description="Created activityType")
def create_activityType(activityType: ActivityType):
    new_activityType = {"id": activityType.id, "name": activityType.name}
    result = conn.execute(activityTypes.insert().values(new_activityType))
    return conn.execute(activityTypes.select().where(activityTypes.c.id == result.lastrowid)).first()

@activityType.get("/activityTypes/{id}", response_model= ActivityType, tags= ["ActivityTypes"], description="**Return one** activityType with Id.", response_description="ActivityType with given Id")
def get_activityType(id: str):
    return conn.execute(activityTypes.select().where(activityTypes.c.id == id)).first()

@activityType.get("/activityTypes/delete/{id}", response_model= str, tags= ["ActivityTypes"], description="**Delete one** activityType with Id.", response_description="String with message: delated activityType and Id")
def delete_activityType(id: str):
    result = conn.execute(activityTypes.delete().where(activityTypes.c.id == id))
    return ("deleted activityType with id = " + id)

@activityType.put("/activityTypes/update/{id}", response_model= ActivityType, tags= ["ActivityTypes"], description="**Update** activityType with Id.", response_description="Updated activityType")
def update_activityType(id: str, activityType: ActivityType):
    result = conn.execute(activityTypes.update().values(name= activityType.name))
    return conn.execute(activityTypes.select().where(activityTypes.c.id == id)).first()