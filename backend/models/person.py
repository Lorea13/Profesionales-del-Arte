from sqlalchemy import ForeignKey, Table, Column
from sqlalchemy.sql.sqltypes import Integer, String, Float, Date
from config.db import meta, engine

people = Table("people", meta, 
    Column("id", Integer, primary_key=True), 
    Column("type", Integer, ForeignKey("personTypes.id")),
    Column("name", String(255)),
    Column("contactDate", Date),
    Column("contactDescription", String(355)),
    Column("projects", String(355)),
    Column("webPage", String(255)),
    Column("email", String(255)),
    Column("phone", String(255)),
    Column("notes", String(355)))

meta.create_all(engine)