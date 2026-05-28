from pydantic import BaseModel, Field


class RoomCreate(BaseModel):
    code: str = Field(min_length=1, max_length=32)
    status: str = 'available'
    notes: str | None = None


class RoomOut(RoomCreate):
    id: int
    model_config = {'from_attributes': True}


class PatientCreate(BaseModel):
    full_name: str
    age: int = Field(ge=0, le=130)
    gender: str
    phone: str | None = None
    triage_level: int = Field(ge=1, le=5)


class PatientOut(PatientCreate):
    id: int
    model_config = {'from_attributes': True}
