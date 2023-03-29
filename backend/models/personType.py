from sqlalchemy import ForeignKey, Table, Column
from sqlalchemy.sql.sqltypes import Integer, String, Float, Date
from config.db import meta, engine

personTypes = Table("personTypes", meta, 
    Column("id", Integer, primary_key=True), 
    Column("name", String(255)))

meta.create_all(engine)