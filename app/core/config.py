from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file='.env', env_file_encoding='utf-8', case_sensitive=True)

    APP_NAME: str = 'Emergency Room API'
    DEBUG: bool = False
    SECRET_KEY: str
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60
    DATABASE_URL: str = 'sqlite:///./er.db'
    CORS_ORIGINS: str = 'http://localhost:3000'
    RATE_LIMIT: str = '100/minute'


settings = Settings()
