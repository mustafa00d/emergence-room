from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.api.deps import require_roles
from app.core.security import create_access_token, get_password_hash, verify_password
from app.db.session import get_db
from app.models.patient import Patient
from app.models.room import Room
from app.models.user import User
from app.schemas.auth import LoginRequest, TokenResponse
from app.schemas.domain import PatientCreate, PatientOut, RoomCreate, RoomOut
from app.schemas.user import UserCreate, UserOut

router = APIRouter(prefix='/api/v1')


@router.post('/auth/register', response_model=UserOut, status_code=status.HTTP_201_CREATED)
def register(payload: UserCreate, db: Session = Depends(get_db)):
    exists = db.scalar(select(User).where(User.email == payload.email))
    if exists:
        raise HTTPException(status_code=409, detail='Email already exists')
    user = User(
        full_name=payload.full_name,
        email=payload.email,
        hashed_password=get_password_hash(payload.password),
        role=payload.role,
    )
    db.add(user)
    db.commit()
    db.refresh(user)
    return user


@router.post('/auth/login', response_model=TokenResponse)
def login(payload: LoginRequest, db: Session = Depends(get_db)):
    user = db.scalar(select(User).where(User.email == payload.email))
    if not user or not verify_password(payload.password, user.hashed_password):
        raise HTTPException(status_code=401, detail='Invalid credentials')
    return TokenResponse(access_token=create_access_token(str(user.id)))


@router.post('/rooms', response_model=RoomOut, dependencies=[Depends(require_roles('admin', 'receptionist'))])
def create_room(payload: RoomCreate, db: Session = Depends(get_db)):
    room = Room(**payload.model_dump())
    db.add(room)
    db.commit()
    db.refresh(room)
    return room


@router.get('/rooms', response_model=list[RoomOut], dependencies=[Depends(require_roles('admin', 'doctor', 'nurse', 'receptionist'))])
def list_rooms(db: Session = Depends(get_db)):
    return list(db.scalars(select(Room)).all())


@router.post('/patients', response_model=PatientOut, dependencies=[Depends(require_roles('admin', 'doctor', 'nurse', 'receptionist'))])
def create_patient(payload: PatientCreate, db: Session = Depends(get_db)):
    patient = Patient(**payload.model_dump())
    db.add(patient)
    db.commit()
    db.refresh(patient)
    return patient
