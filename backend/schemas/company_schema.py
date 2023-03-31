from typing import Optional
from pydantic import BaseModel
from datetime import date

class Company(BaseModel):
    id : Optional[str]
    name : str