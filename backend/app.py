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
        {"id": "6", "type": 1, "name": "Velo casting", "contactDate": "2022-08-25", "contactDescription": "Casting Somos fuego", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "7", "type": 1, "name": "Tonucha Vidal", "contactDate": "2022-02-08", "contactDescription": "Casting Upa dance", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "8", "type": 1, "name": "Itziar Gomez", "contactDate": "2019-03-10", "contactDescription": "Casting Go!azen", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "9", "type": 1, "name": "Asier Sancho", "contactDate": "2014-09-13", "contactDescription": "Casting Gaztetxo", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "10", "type": 1, "name": "Unai Landeta", "contactDate": "2021-04-13", "contactDescription": "Casting Anaiak", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "11", "type": 1, "name": "Diego Betancour", "contactDate": "2021-09-13", "contactDescription": "Casting Elite", "projects": "Todas las veces que me enamore", "webPage": "", "email": "", "phone": "", "notes": ""},
        

        {"id": "12", "type": 2, "name": "Javier Fesser", "contactDate": "2022-08-15", "contactDescription": "Casting Campeones", "projects": "Campeones", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "13", "type": 2, "name": "Silvia Munt", "contactDate": "2022-06-15", "contactDescription": "Casting Las buenas companias", "projects": "Las buenas companias", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "14", "type": 2, "name": "Carlos Alonso-Ojea", "contactDate": "2021-11-26", "contactDescription": "Casting el club de los lectores criminale", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "15", "type": 2, "name": "Dani de la orden", "contactDate": "2022-08-25", "contactDescription": "Casting Somos fuego", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "16", "type": 2, "name": "Lara Izagirre", "contactDate": "2022-02-22", "contactDescription": "Casting pelikula baten bila", "projects": "Un otonyo sin Berlin", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "17", "type": 2, "name": "Ines Paris", "contactDate": "2022-06-25", "contactDescription": "Casting Detective romi", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "18", "type": 2, "name": "Itziar Gomez", "contactDate": "2019-03-10", "contactDescription": "Casting Go!azen", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "19", "type": 2, "name": "Jose Amaya", "contactDate": "2014-09-13", "contactDescription": "Casting Gaztetxo", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "20", "type": 2, "name": "Aroa Saiz", "contactDate": "2021-04-13", "contactDescription": "Casting Anaiak", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "21", "type": 2, "name": "Carlota Pereda", "contactDate": "2022-10-13", "contactDescription": "Rodaje La ermita", "projects": "La Ermita", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "22", "type": 2, "name": "Alauda Ruiz de Azua", "contactDate": "2010-01-01", "contactDescription": "", "projects": "Cinco lobitos", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "23", "type": 2, "name": "Carla Simon", "contactDate": "2010-01-01", "contactDescription": "", "projects": "Alcarras", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "24", "type": 2, "name": "Esti Urresola", "contactDate": "2010-01-01", "contactDescription": "", "projects": "20.000 especies de abejas", "webPage": "", "email": "", "phone": "", "notes": ""},
        
        {"id": "25", "type": 2, "name": "Desconocido", "contactDate": "2010-01-01", "contactDescription": "", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
       


        {"id": "26", "type": 3, "name": "Teatro en vilo", "contactDate": "2021-10-25", "contactDescription": "Casting blast CDN", "projects": "Hoy puede ser tu gran noche", "webPage": "", "email": "", "phone": "", "notes": "Andrea y Noemi"},
        {"id": "27", "type": 3, "name": "Ados teatroa", "contactDate": "2010-10-10", "contactDescription": "", "projects": "Derechos humanos teatro", "webPage": "", "email": "", "phone": "", "notes": "Garbi Losada"},
        {"id": "28", "type": 3, "name": "Tanttaka", "contactDate": "2022-03-15", "contactDescription": "Dferia", "projects": "Mi hijo camina", "webPage": "", "email": "", "phone": "", "notes": "Mireia y Fernando"},
        {"id": "29", "type": 3, "name": "Tartean teatroa", "contactDate": "2010-10-10", "contactDescription": "", "projects": "Derechos humanos teatro", "webPage": "", "email": "", "phone": "", "notes": "Garbi Losada"},
        {"id": "30", "type": 3, "name": "Vaiven", "contactDate": "2010-10-10", "contactDescription": "", "projects": "Redada familiar", "webPage": "", "email": "", "phone": "", "notes": "Ana Pimienta"},
        
        {"id": "31", "type": 4, "name": "Bixagu Entertainment", "contactDate": "2023-04-08", "contactDescription": "Trabajo como project manager", "projects": "La Ermita", "webPage": "bixagu.com", "email": "inaki@bixagu.com", "phone": "", "notes": "Inaki y Pablo"},
        {"id": "32", "type": 4, "name": "Filmax", "contactDate": "2022-10-08", "contactDescription": "Rodaje la Ermita", "projects": "La Ermita", "webPage": "", "email": "", "phone": "", "notes": "Laura y Carlos"},
        {"id": "33", "type": 4, "name": "Morena Films", "contactDate": "2010-01-01", "contactDescription": "", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        

        {"id": "34", "type": 5, "name": "Mc artistas", "contactDate": "2023-04-08", "contactDescription": "Representada por ellos", "projects": "", "webPage": "mcartistas.com", "email": "info@mcartistas.com", "phone": "", "notes": "Mariluz y Antonela"},
        {"id": "35", "type": 5, "name": "Loinaz", "contactDate": "2022-09-01", "contactDescription": "Zinemaldi El Vasco", "projects": "", "webPage": "", "email": "", "phone": "", "notes": ""},
        {"id": "36", "type": 5, "name": "Trauko", "contactDate": "2021-01-01", "contactDescription": "Clases doblaje", "projects": "", "webPage": "", "email": "", "phone": "", "notes": "Nahiara"},
        
    ]
    
    casting_Init = [
        {"id": "1", "castingDate": "2022-07-15", "name": "Campeones 2", "castingDirector": 1, "director": 12, "inPerson": True, "inProcess": True, "notes": "Fase final"},
        {"id": "2", "castingDate": "2022-06-15", "name": "Buenas companias", "castingDirector": 2, "director": 13, "inPerson": True, "inProcess": False, "notes": "Binahi"},
        {"id": "3", "castingDate": "2022-06-25", "name": "Detective Romi", "castingDirector": 2, "director": 14, "inPerson": False, "inProcess": True, "notes": "Mas mayores"},
        {"id": "4", "castingDate": "2022-09-15", "name": "Netflix", "castingDirector": 4, "director": 25, "inPerson": True, "inProcess": False, "notes": ""},
        {"id": "5", "castingDate": "2021-11-26", "name": "CL criminales", "castingDirector": 5, "director": 17, "inPerson": False, "inProcess": False, "notes": ""},
        {"id": "6", "castingDate": "2021-09-26", "name": "Somos fuego", "castingDirector": 6, "director": 15, "inPerson": False, "inProcess": True, "notes": "Produccion para"},
        {"id": "7", "castingDate": "2021-10-25", "name": "Blast", "castingDirector": 26, "director": 26, "inPerson": True, "inProcess": False, "notes": ""},
        {"id": "8", "castingDate": "2022-02-08", "name": "Upa Dance", "castingDirector": 7, "director": 25, "inPerson": False, "inProcess": False, "notes": ""},
        {"id": "9", "castingDate": "2022-02-22", "name": "Pelikula bila", "castingDirector": 16, "director": 16, "inPerson": False, "inProcess": False, "notes": ""},
        {"id": "10", "castingDate": "2019-03-10", "name": "Go!azen", "castingDirector": 8, "director": 18, "inPerson": True, "inProcess": False, "notes": ""},
        {"id": "11", "castingDate": "2014-09-13", "name": "Gaztetxo Charlie", "castingDirector": 9, "director": 19, "inPerson": True, "inProcess": False, "notes": ""},
        {"id": "12", "castingDate": "2021-04-13", "name": "Anaiak corto", "castingDirector": 25, "director": 20, "inPerson": True, "inProcess": False, "notes": ""},
        {"id": "13", "castingDate": "2021-09-10", "name": "Elite", "castingDirector": 11, "director": 15, "inPerson": False, "inProcess": False, "notes": ""},
        
    ]

    company_Init = [
        {"id": "1", "name": "Pausoka"},
        {"id": "2", "name": "Erre produkzioak"},
        {"id": "3", "name": "Nor gira"},
        {"id": "4", "name": "LadyRed Producciones"},
        {"id": "5", "name": "Topagunea"},
        {"id": "6", "name": "Ikertze"},
        {"id": "7", "name": "Ayuntamiento de Urnieta"},
        {"id": "8", "name": "New media"},
        {"id": "9", "name": "On time"},
    ]

    activityType_Init = [
        {"id": "1", "name": "Funciones"},
        {"id": "2", "name": "Rodajes"},
        {"id": "3", "name": "Promociones"},
        {"id": "4", "name": "Ensayos"},
        {"id": "5", "name": "Grabaciones de voz"},
        {"id": "6", "name": "Otros"},
    ]

    activity_Init = [
        {"id": "1", "type": 1, "activityDate": "2022-08-15", "name": "Concierto de Go!azen en Elorrio", "company": 1, "hours": 10, "price": 350, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "2", "type": 1, "activityDate": "2023-04-01", "name": "Dantza festa en Belauntza", "company": 3, "hours": 3, "price": 300, "iva": 0, "invoice": True, "getPaid": False, "notes": ""},
        {"id": "3", "type": 1, "activityDate": "2023-03-27", "name": "Fake Trampantojo en Hernani", "company": 2, "hours": 5, "price": 250, "iva": 0, "invoice": False, "getPaid": True, "notes": "Ultima funcion"},
        {"id": "4", "type": 1, "activityDate": "2022-10-10", "name": "Gala de clasura del festival Begiradak", "company": 6, "hours": 20, "price": 1000, "iva": 100, "invoice": True, "getPaid": True, "notes": ""},
        {"id": "5", "type": 3, "activityDate": "2023-03-21", "name": "Entrevista en el programa Biba Zuek", "company": 8, "hours": 2, "price": 0, "iva": 0, "invoice": False, "getPaid": False, "notes": ""},
        {"id": "6", "type": 2, "activityDate": "2022-08-01", "name": "Rodaje Go!azen 9.0. Dia 1", "company": 1, "hours": 10, "price": 295, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "7", "type": 2, "activityDate": "2022-08-02", "name": "Rodaje Go!azen 9.0. Dia 2", "company": 1, "hours": 10, "price": 295, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "8", "type": 2, "activityDate": "2022-08-03", "name": "Rodaje Go!azen 9.0. Dia 3", "company": 1, "hours": 10, "price": 295, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "9", "type": 2, "activityDate": "2022-08-04", "name": "Rodaje Go!azen 9.0. Dia 4", "company": 1, "hours": 10, "price": 295, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "10", "type": 2, "activityDate": "2021-08-01", "name": "Rodaje Go!azen 8.0. Dia 1", "company": 1, "hours": 10, "price": 295, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "11", "type": 2, "activityDate": "2021-08-02", "name": "Rodaje Go!azen 8.0. Dia 2", "company": 1, "hours": 10, "price": 295, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "12", "type": 2, "activityDate": "2021-08-03", "name": "Rodaje Go!azen 8.0. Dia 3", "company": 1, "hours": 10, "price": 295, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "13", "type": 1, "activityDate": "2021-11-03", "name": "Concierto de Go!azen en Azpeitia", "company": 1, "hours": 10, "price": 350, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "14", "type": 1, "activityDate": "2021-12-03", "name": "Concierto de Go!azen en el BEC", "company": 1, "hours": 10, "price": 350, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "15", "type": 1, "activityDate": "2021-11-03", "name": "Concierto de Go!azen en el Kursaal", "company": 1, "hours": 10, "price": 350, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "16", "type": 2, "activityDate": "2020-11-03", "name": "Rodaje de Vaya Semanita. Dia 1", "company": 1, "hours": 10, "price": 450, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "17", "type": 2, "activityDate": "2020-11-10", "name": "Rodaje de Vaya Semanita. Dia 2", "company": 1, "hours": 10, "price": 450, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "18", "type": 2, "activityDate": "2020-11-17", "name": "Rodaje de Vaya Semanita. Dia 3", "company": 1, "hours": 10, "price": 450, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "19", "type": 4, "activityDate": "2021-08-23", "name": "Ensayo de Fake Trampantojo. Dia 1", "company": 2, "hours": 4, "price": 50, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "20", "type": 4, "activityDate": "2021-08-24", "name": "Ensayo de Fake Trampantojo. Dia 2", "company": 2, "hours": 4, "price": 50, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "21", "type": 4, "activityDate": "2021-08-25", "name": "Ensayo de Fake Trampantojo. Dia 3", "company": 2, "hours": 4, "price": 50, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "22", "type": 4, "activityDate": "2021-08-26", "name": "Ensayo de Fake Trampantojo. Dia 4", "company": 2, "hours": 4, "price": 50, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "23", "type": 5, "activityDate": "2022-10-26", "name": "Doblaje de la pelicula Nire Zirkua", "company": 9, "hours": 3, "price": 70, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "24", "type": 5, "activityDate": "2022-11-26", "name": "Publicidad EITB", "company": 9, "hours": 2, "price": 750, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        {"id": "25", "type": 5, "activityDate": "2022-12-26", "name": "Sara eta Paulen abenturak podcast", "company": 9, "hours": 3, "price": 150, "iva": 0, "invoice": False, "getPaid": True, "notes": ""},
        
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