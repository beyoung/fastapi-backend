FROM python:3.8-alpine
ENV PYTHONUNBUFFERED 1

ENV WORKDIR /app
WORKDIR /app
COPY pip.conf /root/.pip/pip.conf
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache gcc musl-dev make curl git linux-headers

COPY requirements.txt /app/
RUN pip install -U pip \
    && pip install -r requirements.txt

COPY run_server.sh app.py /app/

ENTRYPOINT ["./run_server.sh"]

HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD curl -fs http://0.0.0.0:80/health/ || exit 1

