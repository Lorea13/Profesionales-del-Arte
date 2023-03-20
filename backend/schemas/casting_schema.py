from typing import Optional
from pydantic import BaseModel
from datetime import date

class Casting(BaseModel):
    id : Optional[str]
    date : date
    name : str
    inPerson : bool
    inProcess : bool
    notes: str