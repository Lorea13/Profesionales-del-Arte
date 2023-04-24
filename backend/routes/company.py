from fastapi import APIRouter
from config.db import conn
from models.company import companys
from schemas.company_schema import Company

company = APIRouter()

@company.get("/companys", response_model= list[Company], tags= ["Companys"], description= "**Return all** the companys", response_description="All the companys")
def get_companys():
    return conn.execute(companys.select()).fetchall()

@company.post("/companys", response_model= Company, tags= ["Companys"], description="**Create** a company.", response_description="Created company")
def create_company(company: Company):
    new_company = {"id": company.id, "name": company.name}
    result = conn.execute(companys.insert().values(new_company))
    return conn.execute(companys.select().where(companys.c.id == result.lastrowid)).first()

@company.get("/companys/{id}", response_model= Company, tags= ["Companys"], description="**Return one** company with Id.", response_description="Company with given Id")
def get_company(id: str):
    return conn.execute(companys.select().where(companys.c.id == id)).first()

@company.get("/companys/delete/{id}", response_model= str, tags= ["Companys"], description="**Delete one** company with Id.", response_description="String with message: delated company and Id")
def delete_company(id: str):
    result = conn.execute(companys.delete().where(companys.c.id == id))
    return ("deleted company with id = " + id)

@company.put("/companys/update/{id}", response_model= Company, tags= ["Companys"], description="**Update** company with Id.", response_description="Updated company")
def update_company (id: str, company: Company):
    result = conn.execute(companys.update().values(name= company.name).where(companys.c.id == id))
    return conn.execute(companys.select().where(companys.c.id == id)).first()