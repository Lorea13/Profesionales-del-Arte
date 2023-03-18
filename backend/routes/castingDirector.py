from fastapi import APIRouter
from config.db import conn
from models.castingDirector import castingDirectors
from schemas.castingDirector_schema import CastingDirector

castingDirector = APIRouter()

@castingDirector.get("/castingDirectors", response_model= list[CastingDirector], tags= ["CastingDirectors"], description= "**Return all** the casting directors", response_description="All the casting directors")
def get_castings():
    return conn.execute(castingDirectors.select()).fetchall()

@castingDirector.post("/castingDirectors", response_model= CastingDirector, tags= ["CastingDirectors"], description="**Create** a casting director.", response_description="Created casting director")
def create_casting(castingDirector: CastingDirector):
    new_casting = {"id": castingDirector.id, "name": castingDirector.name}
    result = conn.execute(castingDirectors.insert().values(new_casting))
    return conn.execute(castingDirectors.select().where(castingDirectors.c.id == result.lastrowid)).first()

@castingDirector.get("/castingDirectors/{id}", response_model= CastingDirector, tags= ["CastingDirectors"], description="**Return one** casting director with Id.", response_description="Casting director with given Id")
def get_casting(id: str):
    return conn.execute(castingDirectors.select().where(castingDirectors.c.id == id)).first()

@castingDirector.get("/castingDirectors/delete/{id}", response_model= str, tags= ["CastingDirectors"], description="**Delete one** casting director with Id.", response_description="String with message: delated casting director and Id")
def delete_casting(id: str):
    result = conn.execute(castingDirectors.delete().where(castingDirectors.c.id == id))
    return ("deleted castingDirector with id = " + id)

@castingDirector.put("/castingDirectors/update/{id}", response_model= CastingDirector, tags= ["CastingDirectors"], description="**Update** casting director with Id.", response_description="Updated casting director")
def update_casting(id: str, castingDirector: CastingDirector):
    result = conn.execute(castingDirectors.update().values(name= castingDirector.name))
    return conn.execute(castingDirectors.select().where(castingDirectors.c.id == id)).first()