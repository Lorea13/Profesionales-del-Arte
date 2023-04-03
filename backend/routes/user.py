from fastapi import APIRouter
from config.db import conn
from models.user import users
from schemas.user_schema import User

user = APIRouter()

@user.get("/users", response_model= list[User], tags= ["Users"], description= "**Return all** the users", response_description="All the users")
def get_users():
    return conn.execute(users.select()).fetchall()

@user.get("/users/{id}", response_model= User, tags= ["Users"], description="**Return one** user with Id.", response_description="user with given Id")
def get_user(id: str):
    return conn.execute(users.select().where(users.c.id == id)).first()