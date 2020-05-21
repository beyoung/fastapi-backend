FROM python:3.8-alpine
ENV PYTHONUNBUFFERED 1

ENV WORKDIR /app
WORKDIR /app
COPY app.py requirements.txt /app/
COPY pip.conf /root/.pip/pip.conf
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add gcc musl-dev make curl \
    && pip install -U pip \
    && pip install -r requirements.txt

COPY run_server.sh /app/

ENTRYPOINT ["./run_server.sh"]

HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD curl -fs http://0.0.0.0:8000/health/ || exit 1

