FROM ubuntu

RUN apt-get update
RUN apt-get install -y python3 python3-pip
RUN pip3 install flask
EXPOSE 8081
CMD ["python","web.py"]


