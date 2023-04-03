from typing import Optional
from pydantic import BaseModel
from datetime import date

class User(BaseModel):
    id : Optional[str]
    name : str
    psss : str