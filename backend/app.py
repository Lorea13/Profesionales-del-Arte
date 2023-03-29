from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routes.personType import personType
from routes.person import person
from routes.casting import casting
from routes.client import client
from routes.activityType import activityType
from routes.activity import activity

from config.db import conn

#from tests.execute_tests import execute_all_test

from models.personType import personTypes
from models.person import people
from models.casting import castings
from models.client import clients
from models.activityType import activityTypes
from models.activity import activities


app = FastAPI(
    title= "Profesionales del arte API",
    description= """
    This is the arts profesionals API. It helps you do awesome stuff.
    
    Items

    The different items are: castings, activity types, activities, personTypes, people and clients.

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
        },
        {
            "name": "clients", 
            "description": "These are the routes of the clients"
        },
        {
            "name": "ActivityTypes", 
            "description": "These are the routes of the activity types"
        }, 
        {
            "name": "Activities", 
            "description": "These are the routes of the activities"
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
app.include_router(client)
app.include_router(activityType)
app.include_router(activity)

@app.on_event("startup")
def startup_seedData_db():
    
    conn.execute(castings.delete())
    conn.execute(people.delete())
    conn.execute(personTypes.delete())
    conn.execute(clients.delete())
    conn.execute(activityTypes.delete())
    conn.execute(activities.delete())

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

    client_Init = [
        {"id": "1", "name": "Pausoka"},
        {"id": "2", "name": "Erre produkzioak"},
    ]

    activityType_Init = [
        {"id": "1", "name": "show"},
        {"id": "2", "name": "shooting"},
        {"id": "3", "name": "promotion"},
        {"id": "4", "name": "rehearsal"},
        {"id": "5", "name": "voice recording"},
        {"id": "6", "name": "other"},
    ]

    activity_Init = [
        {"id": "1", "type": 1, "date": "2022-08-15", "name": "Elorrio concierto", "company": 1, "hours": "10", "price": 350, "iva": 35, "invoice": False, "getPaid": True, "notes": ""},
    ]

    conn.execute(personTypes.insert().values(personType_Init))
    conn.execute(people.insert().values(person_Init))
    conn.execute(castings.insert().values(casting_Init))
    conn.execute(clients.insert().values(client_Init))
    conn.execute(activityTypes.insert().values(activityType_Init))
    conn.execute(activities.insert().values(activity_Init))

  #  execute_all_test()