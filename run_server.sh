#!/bin/sh
uvicorn app:app --workers 4 --host 0.0.0.0 --port 80
