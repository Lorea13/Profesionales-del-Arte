from typing import Optional
from pydantic import BaseModel
from datetime import date

class Person(BaseModel):
    id : Optional[str]
    type: int
    name : str
    contactDate : date
    contactDescription : str
    projects : str
    webPage : str
    email : str
    phone : str
    notes : str