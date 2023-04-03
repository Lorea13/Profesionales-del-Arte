from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routes.personType import personType
from routes.person import person
from routes.casting import casting
from routes.company import company
from routes.activityType import activityType
from routes.activity import activity
from routes.user import user

from config.db import conn

#from tests.execute_tests import execute_all_test

from models.personType import personTypes
from models.person import people
from models.casting import castings
from models.company import companys
from models.activityType import activityTypes
from models.activity import activities
from models.user import users


app = FastAPI(
    title= "Profesionales del arte API",
    description= """
    This is the arts profesionals API. It helps you do awesome stuff.
    
    Items

    The different items are: castings, activity types, activities, personTypes, people, companies and users.

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
            "name": "Companys", 
            "description": "These are the routes of the companies"
        },
        {
            "name": "ActivityTypes", 
            "description": "These are the routes of the activity types"
        }, 
        {
            "name": "Activities", 
            "description": "These are the routes of the activities"
        },
        {
            "name": "Users", 
            "description": "These are the routes of the users"
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
app.include_router(company)
app.include_router(activityType)
app.include_router(activity)
app.include_router(user)

@app.on_event("startup")
def startup_seedData_db():
    
    conn.execute(castings.delete())
    conn.execute(people.delete())
    conn.execute(personTypes.delete())
    conn.execute(companys.delete())
    conn.execute(activityTypes.delete())
    conn.execute(activities.delete())
    conn.execute(users.delete())

    personType_Init = [
        {"id": "1", "name": "castingDirector"},
        {"id": "2", "name": "director"},
        {"id": "3", "name": "theatreCompany"},
        {"id": "4", "name": "productionCompany"},
        {"id": "5", "name": "manager"},
    ]
    
    person_Init = [
        {"id": "1", "type": 1, "name": "Jorge Galeron", "contactDate": "2022-08-15", "contactDescription": "Casting Campeones", "projects": "Campeones", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "2", "type": 1, "name": "Txabe Atxa", "contactDate": "2022-06-15", "contactDescription": "Casting Las buenas companias", "projects": "Akelarre", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "3", "type": 1, "name": "Elena Arnau", "contactDate": "2010-01-01", "contactDescription": "", "projects": "La que se avecina", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "4", "type": 1, "name": "Josu Bilbao", "contactDate": "2022-09-15", "contactDescription": "Casting publi", "projects": "Publicidad", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "5", "type": 1, "name": "Carmen Utrilla", "contactDate": "2021-11-26", "contactDescription": "Casting el club de los lectores criminales", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "6", "type": 1, "name": "Veló casting", "contactDate": "2022-08-25", "contactDescription": "Casting Somos fuego", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "7", "type": 1, "name": "Tonucha Vidal", "contactDate": "2022-02-08", "contactDescription": "Casting Upa dance", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
    

        {"id": "8", "type": 2, "name": "Javier Fesser", "contactDate": "2022-08-15", "contactDescription": "Casting Campeones", "projects": "Campeones", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "9", "type": 2, "name": "Silvia Munt", "contactDate": "2022-06-15", "contactDescription": "Casting Las buenas companias", "projects": "Las buenas companias", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "10", "type": 2, "name": "Desconocido", "contactDate": "2010-01-01", "contactDescription": "", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "11", "type": 2, "name": "Carlos Alonso-Ojea", "contactDate": "2021-11-26", "contactDescription": "Casting el club de los lectores criminale", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "12", "type": 2, "name": "Dani de la orden", "contactDate": "2022-08-25", "contactDescription": "Casting Somos fuego", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "13", "type": 2, "name": "Lara Izagirre", "contactDate": "2022-02-22", "contactDescription": "Casting pelikula baten bila", "projects": "Un otoño sin Berlin", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "14", "type": 2, "name": "Ines Paris", "contactDate": "2022-06-25", "contactDescription": "Casting Detective romi", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        

        {"id": "15", "type": 3, "name": "Teatro en vilo", "contactDate": "2021-10-25", "contactDescription": "Casting blast CDN", "projects": "Hoy puede ser tu gran noche", "webPage": "", "email": "", "phone": "", "notes": "Andrea y Noemi"},
        
    ]
    
    casting_Init = [
        {"id": "1", "date": "2022-07-15", "name": "Campeones", "castingDirector": 1, "director": 8, "inPerson": True, "inProcess": False, "notes": "Fase final"},
        {"id": "2", "date": "2022-06-15", "name": "Buenas companias", "castingDirector": 2, "director": 9, "inPerson": True, "inProcess": False, "notes": "Binahi"},
        {"id": "3", "date": "2022-06-25", "name": "Detective Romi", "castingDirector": 2, "director": 14, "inPerson": False, "inProcess": False, "notes": "Mas mayores"},
        {"id": "4", "date": "2022-09-15", "name": "Netflix", "castingDirector": 4, "director": 10, "inPerson": True, "inProcess": False, "notes": ""},
        {"id": "5", "date": "2021-11-26", "name": "CL criminales", "castingDirector": 5, "director": 11, "inPerson": False, "inProcess": False, "notes": ""},
        {"id": "6", "date": "2021-09-26", "name": "Somos fuego", "castingDirector": 6, "director": 12, "inPerson": False, "inProcess": False, "notes": "Produccion para"},
        {"id": "7", "date": "2021-10-25", "name": "Blast", "castingDirector": 15, "director": 15, "inPerson": True, "inProcess": False, "notes": ""},
        {"id": "8", "date": "2022-02-08", "name": "Upa Dance", "castingDirector": 7, "director": 10, "inPerson": False, "inProcess": False, "notes": ""},
        {"id": "9", "date": "2022-02-22", "name": "Pelikula bila", "castingDirector": 13, "director": 13, "inPerson": False, "inProcess": False, "notes": ""},
        
    ]

    company_Init = [
        {"id": "1", "name": "Pausoka"},
        {"id": "2", "name": "Erre produkzioak"},
        {"id": "3", "name": "Nor gira"},
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
        {"id": "1", "type": 1, "date": "2022-08-15", "name": "Elorrio concierto", "company": 1, "hours": 10, "price": 350, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "2", "type": 1, "date": "2023-04-01", "name": "Belauntza", "company": 3, "hours": 3, "price": 300, "iva": 30, "invoice": False, "getPaid": False, "notes": "Asier hace factura"},
    
    ]

    user_Init = [
        {"id": "1", "name": "lorea", "pass": "seguridad"},
    ]

    conn.execute(personTypes.insert().values(personType_Init))
    conn.execute(people.insert().values(person_Init))
    conn.execute(castings.insert().values(casting_Init))
    conn.execute(companys.insert().values(company_Init))
    conn.execute(activityTypes.insert().values(activityType_Init))
    conn.execute(activities.insert().values(activity_Init))
    conn.execute(users.insert().values(user_Init))

  #  execute_all_test()