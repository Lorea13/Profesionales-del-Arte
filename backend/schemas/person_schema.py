from typing import Optional
from pydantic import BaseModel

class Person(BaseModel):
    id : Optional[str]
    name : str