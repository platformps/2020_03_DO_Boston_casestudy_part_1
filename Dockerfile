FROM python:3.7-alpine

#set working directory
WORKDIR /usr/src/app

#copy all files to the container
COPY . .

#install dependencies
RUN pip install -r requirements.txt

#expose the port 
EXPOSE 9090

#run the app
CMD ["python", "./web.py"]
