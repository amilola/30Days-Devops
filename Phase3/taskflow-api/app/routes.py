from fastapi import APIRouter
from app.models import Task


router = APIRouter()

tasks = []
id_counter = 1


@router.get("/health")
def health():
    return {"status": "ok"}


@router.get("/tasks")
def get_tasks():
    return tasks


@router.post("/tasks")
def create_task(task: Task):
    global id_counter
    new_task = {"id": id_counter, "title": task.title}
    tasks.append(new_task)
    id_counter += 1
    return new_task
