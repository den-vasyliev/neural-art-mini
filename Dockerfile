FROM python:3.7-slim as builder
RUN mkdir /install
WORKDIR /install
RUN apt-get update && apt-get install -qq -y \
  build-essential libpq-dev libffi-dev --no-install-recommends
RUN pip install mxnet scikit-image --prefix="/install"
FROM python:3.7-slim
COPY --from=builder /install /usr/local
RUN apt-get update && apt-get install -qq -y libgomp1
COPY . /app
WORKDIR /app
CMD ["python", "run.py"]
