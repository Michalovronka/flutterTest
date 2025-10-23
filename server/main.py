from typing import Union
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # You can restrict this to specific domains later
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

todos = {
    "1": {"title": "todo 1", "isCompleted": False},
    "2": {"title": "todo 2", "isCompleted": False},
    "3": {"title": "todo 3", "isCompleted": False},
    "4": {"title": "todo 4", "isCompleted": False},
    "5": {"title": "todo 5", "isCompleted": False},
}

max_index = 6


@app.get("/todos")
def read_root():
    return todos


@app.post("/todos")
def create_todo(title: str):
    global max_index
    key = str(max_index)
    todos[key] = {
        "title": title,
        "isCompleted": False
    }
    max_index += 1
    return todos