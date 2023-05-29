FROM python:3.7-alpine

RUN pip install flask

COPY main.py /main.py

CMD ["python3", "/main.py"]