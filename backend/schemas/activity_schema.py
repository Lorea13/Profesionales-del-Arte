from typing import Optional
from pydantic import BaseModel
from datetime import date

class Activity(BaseModel):
    id : Optional[str]
    type: int
    activityDate : date
    name : str
    company : int
    hours : int
    price : int
    iva : int
    invoice : bool
    getPaid : bool
    notes : str