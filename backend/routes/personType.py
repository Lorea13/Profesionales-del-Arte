from fastapi import APIRouter
from config.db import conn
from models.personType import personTypes
from schemas.personType_schema import PersonType

personType = APIRouter()

@personType.get("/personTypes", response_model= list[PersonType], tags= ["PersonTypes"], description= "**Return all** the personTypes", response_description="All the personTypes")
def get_personTypes():
    return conn.execute(personTypes.select()).fetchall()

@personType.post("/personTypes", response_model= PersonType, tags= ["PersonTypes"], description="**Create** a personType.", response_description="Created personType")
def create_personType(personType: PersonType):
    new_personType = {"id": personType.id, "name": personType.name}
    result = conn.execute(personTypes.insert().values(new_personType))
    return conn.execute(personTypes.select().where(personTypes.c.id == result.lastrowid)).first()

@personType.get("/personTypes/{id}", response_model= PersonType, tags= ["PersonTypes"], description="**Return one** personType with Id.", response_description="PersonType with given Id")
def get_personType(id: str):
    return conn.execute(personTypes.select().where(personTypes.c.id == id)).first()

@personType.get("/personTypes/delete/{id}", response_model= str, tags= ["PersonTypes"], description="**Delete one** personType with Id.", response_description="String with message: delated personType and Id")
def delete_personType(id: str):
    result = conn.execute(personTypes.delete().where(personTypes.c.id == id))
    return ("deleted personType with id = " + id)

@personType.put("/personTypes/update/{id}", response_model= PersonType, tags= ["PersonTypes"], description="**Update** personType with Id.", response_description="Updated personType")
def update_personType(id: str, personType: PersonType):
    result = conn.execute(personTypes.update().values(name= personType.name).where(personTypes.c.id == id))
    return conn.execute(personTypes.select().where(personTypes.c.id == id)).first()