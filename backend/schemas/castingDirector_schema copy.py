from typing import Optional
from pydantic import BaseModel

class CastingDirector(BaseModel):
    id : Optional[str]
    name : str