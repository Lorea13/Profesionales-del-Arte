from fastapi import APIRouter
from config.db import conn
from models.casting import castings
from schemas.casting_schema import Casting

casting = APIRouter()

@casting.get("/castings", response_model= list[Casting], tags= ["Castings"], description= "**Return all** the castings", response_description="All the castings")
def get_castings():
    return conn.execute(castings.select()).fetchall()

@casting.post("/castings", response_model= Casting, tags= ["Castings"], description="**Create** a casting.", response_description="Created casting")
def create_casting(casting: Casting):
    new_casting = {"id": casting.id, "name": casting.name}
    result = conn.execute(castings.insert().values(new_casting))
    return conn.execute(castings.select().where(castings.c.id == result.lastrowid)).first()

@casting.get("/castings/{id}", response_model= Casting, tags= ["Castings"], description="**Return one** casting with Id.", response_description="Casting with given Id")
def get_casting(id: str):
    return conn.execute(castings.select().where(castings.c.id == id)).first()

@casting.get("/castings/delete/{id}", response_model= str, tags= ["Castings"], description="**Delete one** casting with Id.", response_description="String with message: delated casting and Id")
def delete_casting(id: str):
    result = conn.execute(castings.delete().where(castings.c.id == id))
    return ("deleted casting with id = " + id)

@casting.put("/castings/update/{id}", response_model= Casting, tags= ["Castings"], description="**Update** casting with Id.", response_description="Updated casting")
def update_casting(id: str, casting: Casting):
    result = conn.execute(castings.update().values(name= casting.name))
    return conn.execute(castings.select().where(castings.c.id == id)).first()