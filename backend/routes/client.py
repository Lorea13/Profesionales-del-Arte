from fastapi import APIRouter
from config.db import conn
from models.client import clients
from schemas.activityType_schema import ActivityType

client = APIRouter()

@client.get("/clients", response_model= list[ActivityType], tags= ["Clients"], description= "**Return all** the clients", response_description="All the clients")
def get_clients():
    return conn.execute(clients.select()).fetchall()

@client.post("/clients", response_model= ActivityType, tags= ["Clients"], description="**Create** a client.", response_description="Created client")
def create_client(client: ActivityType):
    new_client = {"id": client.id, "name": client.name}
    result = conn.execute(clients.insert().values(new_client))
    return conn.execute(clients.select().where(clients.c.id == result.lastrowid)).first()

@client.get("/clients/{id}", response_model= ActivityType, tags= ["Clients"], description="**Return one** client with Id.", response_description="ActivityType with given Id")
def get_client(id: str):
    return conn.execute(clients.select().where(clients.c.id == id)).first()

@client.get("/clients/delete/{id}", response_model= str, tags= ["Clients"], description="**Delete one** client with Id.", response_description="String with message: delated client and Id")
def delete_client(id: str):
    result = conn.execute(clients.delete().where(clients.c.id == id))
    return ("deleted client with id = " + id)

@client.put("/clients/update/{id}", response_model= ActivityType, tags= ["Clients"], description="**Update** client with Id.", response_description="Updated client")
def update_client (id: str, client: ActivityType):
    result = conn.execute(clients.update().values(name= client.name))
    return conn.execute(clients.select().where(clients.c.id == id)).first()