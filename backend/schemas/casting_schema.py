from typing import Optional
from pydantic import BaseModel

class Casting(BaseModel):
    id : Optional[str]
    name : str