from fastapi import FastAPI
from app.routes import router
import os
import uvicorn


def create_app():
    app = FastAPI()
    app.include_router(router)
    return app


app = create_app()

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)



