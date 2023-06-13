FROM python:3.9

ENV app /app

RUN mkdir $app
WORKDIR $app
COPY . $app

RUN pip install -r requirements.txt

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - &&\
apt-get install -y nodejs

RUN npm i -g openapi-to-postmanv2

RUN openapi2postmanv2 --test

WORKDIR API/

EXPOSE 8094
ENTRYPOINT ["python", "./api.py"]
CMD ["tail -f /app/logs/scan.log"]

