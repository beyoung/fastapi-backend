# -*- coding: utf-8 -*-
from datetime import datetime
from fastapi import FastAPI, APIRouter

app = FastAPI()

main_router = APIRouter()

common_router = APIRouter()


@main_router.get("/")
def index():
    return {"Hello": "World"}


@common_router.get("/now/")
def now():
    return {"datetime": datetime.now().strftime('%Y-%m-%d %H:%M:%S')}


@common_router.get("/health/")
def health():
    return {'status': 'ok'}


app.include_router(main_router)
app.include_router(common_router)
