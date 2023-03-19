FROM python:3.9
WORKDIR /code
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
RUN pip install uvicorn
RUN pip install mysqlclient
RUN pip install pymysql
RUN pip install cryptography
RUN pip install sqlalchemy_utils
RUN pip install requests
COPY ./backend /code/backend
ENV PYTHONPATH "${PYTHONPATH}:/code/backend/"
CMD ["uvicorn", "backend.app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]