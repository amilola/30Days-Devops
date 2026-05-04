from fastapi import FastAPI
from app.routes import router
import os


def create_app():
    app = FastAPI()
    app.include_router(router)
    return app


port = int(os.environ.get("PORT", 8000))
app = create_app()
