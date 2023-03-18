from sqlalchemy import ForeignKey, Table, Column
from sqlalchemy.sql.sqltypes import Integer, String, Float
from config.db import meta, engine

castings = Table("castings", meta, 
    Column("id", Integer, primary_key=True), 
    Column("name", String(255)),  
    Column("castingDirector", Integer, ForeignKey("castingDirector.id")),
    Column("inProcess", Boolean))

meta.create_all(engine)