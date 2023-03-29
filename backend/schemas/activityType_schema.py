from typing import Optional
from pydantic import BaseModel
from datetime import date

class ActivityType(BaseModel):
    id : Optional[str]
    name : str