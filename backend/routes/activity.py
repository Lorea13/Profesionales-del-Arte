from fastapi import APIRouter
from config.db import conn
from models.activity import activities
from schemas.activity_schema import Activity

activity = APIRouter()

@activity.get("/activities", response_model= list[Activity], tags= ["Activities"], description= "**Return all** the activities", response_description="All the activities")
def get_activities():
    return conn.execute(activities.select()).fetchall()

@activity.post("/activities", response_model= Activity, tags= ["Activities"], description="**Create** an activity.", response_description="Created activity")
def create_activity(activity: Activity):
    new_activity = {"id": activity.id, "type": activity.type, "activityDate": activity.activityDate, "name": activity.name, "company": activity.company, "hours": activity.hours, "price": activity.price, "iva": activity.iva, "invoice": activity.invoice, "getPaid": activity.getPaid, "notes": activity.notes}
    result = conn.execute(activities.insert().values(new_activity))
    return conn.execute(activities.select().where(activities.c.id == result.lastrowid)).first()

@activity.get("/activities/{id}", response_model= Activity, tags= ["Activities"], description="**Return one** activity with Id.", response_description="Activity with given Id")
def get_activity(id: str):
    return conn.execute(activities.select().where(activities.c.id == id)).first()

@activity.get("/activities/delete/{id}", response_model= str, tags= ["Activities"], description="**Delete one** activity with Id.", response_description="String with message: delated activity and Id")
def delete_activity(id: str):
    print("Estoy en routes")
    result = conn.execute(activities.delete().where(activities.c.id == id))
    print(result)
    return ("deleted activity with id = " + id)

@activity.put("/activities/update/{id}", response_model= Activity, tags= ["Activities"], description="**Update** activity with Id.", response_description="Updated activity")
def update_activity(id: str, activity: Activity):
    print("Estoy en routes")
    result = conn.execute(activities.update().values(type= activity.type,
    activityDate= activity.activityDate,
    name= activity.name,
    company= activity.company,
    hours= activity.hours,
    price= activity.price,
    iva= activity.iva,
    invoice= activity.invoice,
    getPaid= activity.getPaid,
    notes= activity.notes).where(activities.c.id == id))
    print("Estoy en routes. He hecho execute")
    return conn.execute(activities.select().where(activities.c.id == id)).first()