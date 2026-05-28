# Emergency Room Management System

A production-oriented Emergency Room management backend built with FastAPI, PostgreSQL, JWT auth, RBAC, and security best practices.

## Features
- Secure authentication (JWT, password hashing)
- Role-based access control (admin, doctor, nurse, receptionist)
- ER room management
- Patient and triage management
- Visit lifecycle and room assignment
- Audit-friendly timestamps
- Alembic migrations
- Security hardening headers, CORS control, rate limiting

## Tech Stack
- FastAPI
- SQLAlchemy 2.x
- PostgreSQL (default) / SQLite (dev)
- Alembic
- Pydantic v2
- SlowAPI rate limiting

## Quick Start

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env
alembic upgrade head
uvicorn app.main:app --reload
```

Open: http://127.0.0.1:8000/docs

## Security Notes
- Set a strong `SECRET_KEY` in `.env`
- Use HTTPS in production
- Restrict `CORS_ORIGINS`
- Use strong DB credentials and private networking

## Default Roles
- `admin`
- `doctor`
- `nurse`
- `receptionist`

## Testing
```bash
pytest
```
