from fastapi import APIRouter
from config.db import conn
from models.person import people
from schemas.person_schema import Person

person = APIRouter()

@person.get("/people", response_model= list[Person], tags= ["People"], description= "**Return all** the people", response_description="All the people")
def get_people():
    return conn.execute(people.select()).fetchall()

@person.post("/people", response_model= Person, tags= ["People"], description="**Create** a person.", response_description="Created person")
def create_person(person: Person):
    new_person = {"id": person.id, "type": person.type, "name": person.name, "contactDate": person.contactDate, "contactDescription": person.contactDescription, "projects": person.projects, "webPage": person.webPage, "email": person.email, "phone": person.phone, "notes": person.notes}
    result = conn.execute(people.insert().values(new_person))
    return conn.execute(people.select().where(people.c.id == result.lastrowid)).first()

@person.get("/people/{id}", response_model= Person, tags= ["People"], description="**Return one** person with Id.", response_description="Person with given Id")
def get_person(id: str):
    return conn.execute(people.select().where(people.c.id == id)).first()

@person.get("/people/delete/{id}", response_model= str, tags= ["People"], description="**Delete one** person with Id.", response_description="String with message: delated person and Id")
def delete_person(id: str):
    result = conn.execute(people.delete().where(people.c.id == id))
    return ("deleted person with id = " + id)

@person.put("/people/update/{id}", response_model= Person, tags= ["People"], description="**Update** person with Id.", response_description="Updated person")
def update_person(id: str, person: Person):
    result = conn.execute(people.update().values(type= person.type,
    name= person.name,
    contactDate= person.contactDate,
    contactDescription= person.contactDescription,
    projects= person.projects,
    webPage= person.webPage,
    email= person.email,
    phone= person.phone,
    notes= person.notes))
    return conn.execute(people.select().where(people.c.id == id)).first()