from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routes.castingDirector import castingDirector
from routes.casting import casting

from config.db import conn

from tests.execute_tests import execute_all_test

from models.castingDirector import castingDirector
from models.casting import castings

app = FastAPI(
    title= "Profesionales del arte API",
    description= """
    This is the arts profesionals API. It helps you do awesome stuff.
    
    Items

    The different items are: castings and casting directors.

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
            "name": "CastingDirectors", 
            "description": "These are the routes of the casting directors"
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

app.include_router(castingDirector)
app.include_router(casting)

@app.on_event("startup")
def startup_seedData_db():
    
    conn.execute(castings.delete())
    conn.execute(castingDirectors.delete())
    
    castingDirector_Init = [
        {"id": "1", "name": "Jorge Galerón"},
        {"id": "2", "name": "Flor y Txabe"}
    ]
    
    casting_Init = [
        {"id": "1", "name": "Campeones", "castingDirector": 1, "inProcess": False},
        {"id": "2", 'name': 'Detective Romi', "castingDirector": 2, "inProcess": False},
    ]

    conn.execute(castingDirectors.insert().values(castingDirector_Init))
    conn.execute(castings.insert().values(casting_Init))

    execute_all_test()