FROM ubuntu
MAINTAINER dincer salih kurnaz 
 
RUN apt-get update && apt-get install -y wget build-essential python python-dev python-pip python-virtualenv
RUN pip install gunicorn==18.0
COPY requirements.txt /tmp/ 
RUN pip install -r /tmp/requirements.txt
ENV foo /project/
ENV doo /project/templates/
WORKDIR ${foo}  
COPY server.py  ${foo} 
COPY chat.html ${doo}
COPY login.html ${doo}
EXPOSE 80
CMD gunicorn -b 0.0.0.0:80 --worker-class socketio.sgunicorn.GeventSocketIOWorker server:app
