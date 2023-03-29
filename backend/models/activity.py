from sqlalchemy import ForeignKey, Table, Column
from sqlalchemy.sql.sqltypes import Integer, String, Float, Boolean, Date
from config.db import meta, engine

activities = Table("activities", meta, 
    Column("id", Integer, primary_key=True),
    Column("type", Integer, ForeignKey("activityTypes.id")),
    Column("date", Date),
    Column("name", String(255)),
    Column("hours", Integer),
    Column("price", Integer),
    Column("iva", Integer),
    Column("invoice", Boolean),
    Column("getPaid", Boolean),
    Column("notes", String(355)))

meta.create_all(engine)