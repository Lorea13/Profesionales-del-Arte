from typing import Optional
from pydantic import BaseModel
from datetime import date

class Casting(BaseModel):
    id : Optional[str]
    castingDate : date
    name : str
    castingDirector : int
    director : int
    inPerson : bool
    inProcess : bool
    notes: str