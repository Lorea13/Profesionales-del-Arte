from typing import Optional
from pydantic import BaseModel
from datetime import date

class PersonType(BaseModel):
    id : Optional[str]
    name : str