from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routes.personType import personType
from routes.person import person
from routes.casting import casting

from config.db import conn

#from tests.execute_tests import execute_all_test

from models.personType import personTypes
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
        },
        {
            "name": "PersonTypes", 
            "description": "These are the routes of the person types"
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

app.include_router(personType)
app.include_router(person)
app.include_router(casting)

@app.on_event("startup")
def startup_seedData_db():
    
    conn.execute(castings.delete())
    conn.execute(people.delete())
    conn.execute(personTypes.delete())

    personType_Init = [
        {"id": "1", "name": "castingDirector"},
        {"id": "2", "name": "director"},
        {"id": "3", "name": "theatreCompany"},
        {"id": "4", "name": "productionCompany"},
        {"id": "5", "name": "manager"},
    ]
    
    person_Init = [
        {"id": "1", "type": 1, "name": "Jorge Galerón", "contactDate": "2022-08-15", "contactDescription": "Casting Campeones", "projects": "Campeones", "webPage": "", "email": "", "phone": "", "notes": ""},
    ]
    
    casting_Init = [
        {"id": "1", "date": "2022-07-15", "name": "Campeones", "castingDirector": 1, "director": 1, "inPerson": True, "inProcess": False, "notes": "Fase final"},
        {"id": "2", "date": "2022-06-25", "name": "Detective Romi", "castingDirector": 1, "director": 1, "inPerson": False, "inProcess": False, "notes": "Buscaban mas mayores"},
    ]

    conn.execute(personTypes.insert().values(personType_Init))
    conn.execute(people.insert().values(person_Init))
    conn.execute(castings.insert().values(casting_Init))

  #  execute_all_test()