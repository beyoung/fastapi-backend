# -*- coding: utf-8 -*-
import socket
from datetime import datetime

import psutil
from fastapi import FastAPI, APIRouter

app = FastAPI()

main_router = APIRouter()

common_router = APIRouter()


@main_router.get("/")
def index():
    return {"Hello": "World"}


@common_router.get("/stats/")
def stats():
    return {"datetime": datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            "hostname": socket.gethostname(),
            "stats": {
                'cpu_percent': psutil.cpu_percent(),
                'memory_percent': psutil.virtual_memory().percent,
                'cache_percent': psutil.virtual_memory().cached / psutil.virtual_memory().total * 100,
                'swap_percent': psutil.swap_memory().percent,
                'disk_percent': psutil.disk_usage('/').percent,
                'net_fds': len(psutil.net_connections()),
                'pids': len(psutil.pids())
            }}


@common_router.get("/health/")
def health():
    return {'status': 'ok'}


app.include_router(main_router)
app.include_router(common_router)
