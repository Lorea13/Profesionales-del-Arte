from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routes.person import person
from routes.casting import casting

from config.db import conn

#from tests.execute_tests import execute_all_test

from models.person import people
from models.casting import castings

app = FastAPI(
    title= "Profesionales del arte API",
    description= """
    This is the arts profesionals API. It helps you do awesome stuff.
    
    Items

    The different items are: castings and people.

    Methods

    You will be able to use the following methods in the previous items:

    *Get all
    *Create
    *Get one
    *Delete one
    *Update one

    """,
    version="0.0.1",
    contact={
        "name":"Lorea Intxausti",
        "url": "https://github.com/Lorea13/Profesionales-del-Arte.git",
        "email": "lorea.intxausti@opendeusto.es"
    },
    openapi_tags=[
        {
            "name": "Castings",
            "description": "These are the routes of the castings"
        },
        {
            "name": "People", 
            "description": "These are the routes of the people"
        }
    ]
)

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins = origins,
    allow_credentials = True,
    allow_methods = ["*"],
    allow_headers = ["*"],
    
)

app.include_router(person)
app.include_router(casting)

@app.on_event("startup")
def startup_seedData_db():
    
    conn.execute(castings.delete())
    conn.execute(people.delete())
    
    person_Init = [
        {"id": "1", "name": "Jorge Galerón"},
        {"id": "2", "name": "Flor y Txabe"}
    ]
    
    casting_Init = [
        {"id": "1", "date": "2022-07-15", "name": "Campeones", "inPerson": True, "inProcess": False, "notes": "Fase final"},
        {"id": "2", "date": "2022-06-25", "name": "Detective Romi", "inPerson": False, "inProcess": False, "notes": "Buscaban mas mayores"},
    ]

    conn.execute(people.insert().values(person_Init))
    conn.execute(castings.insert().values(casting_Init))

  #  execute_all_test()