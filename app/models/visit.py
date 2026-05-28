from sqlalchemy import ForeignKey, String
from sqlalchemy.orm import Mapped, mapped_column

from app.models.base import Base, TimestampMixin


class Visit(Base, TimestampMixin):
    __tablename__ = 'visits'

    id: Mapped[int] = mapped_column(primary_key=True)
    patient_id: Mapped[int] = mapped_column(ForeignKey('patients.id', ondelete='RESTRICT'), nullable=False, index=True)
    room_id: Mapped[int | None] = mapped_column(ForeignKey('rooms.id', ondelete='SET NULL'), nullable=True, index=True)
    attending_doctor_id: Mapped[int | None] = mapped_column(ForeignKey('users.id', ondelete='SET NULL'), nullable=True)
    status: Mapped[str] = mapped_column(String(20), nullable=False, default='waiting')
    complaint: Mapped[str] = mapped_column(String(255), nullable=False)
