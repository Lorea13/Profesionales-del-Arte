from sqlalchemy import ForeignKey, Table, Column
from sqlalchemy.sql.sqltypes import Integer, String, Float, Boolean, Date
from config.db import meta, engine

castings = Table("castings", meta, 
    Column("id", Integer, primary_key=True),
    Column("castingDate", Date),
    Column("name", String(255)),
    Column("castingDirector", Integer, ForeignKey("people.id")),
    Column("director", Integer, ForeignKey("people.id")),
    Column("inPerson", Boolean),
    Column("inProcess", Boolean),
    Column("notes", String(355)))

meta.create_all(engine)