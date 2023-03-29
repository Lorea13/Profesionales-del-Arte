from typing import Optional
from pydantic import BaseModel
from datetime import date

class Client(BaseModel):
    id : Optional[str]
    name : str