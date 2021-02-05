FROM ubuntu
#pulls down latest ubuntu image
RUN apt-get update
#runs updates on new image
RUN apt-get install -y python3 python3-pip
#installs python
RUN pip3 install flask
#installs flask
EXPOSE 8081
#exposes port 8081 
CMD ["python3","web.py"]
#runs the web.py flask application
