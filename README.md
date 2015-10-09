http://code.tutsplus.com/tutorials/build-a-real-time-chat-application-with-modulus-and-python--cms-24462

$ docker-machine ls
NAME            ACTIVE   DRIVER       STATE     URL                         SWARM
default         *        virtualbox   Running   tcp://192.168.99.100:2376   

$ ls
Dockerfile		chat.html		login.html		requirements.txt	server.py

$ cat Dockerfile 
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

$ docker build -t pytondev .
Sending build context to Docker daemon 12.29 kB
Step 0 : FROM ubuntu
 ---> 91e54dfb1179
Step 1 : MAINTAINER dincer salih kurnaz
 ---> Using cache
 ---> 8be980b9ce01
Step 2 : RUN apt-get update && apt-get install -y wget build-essential python python-dev python-pip python-virtualenv
 ---> Using cache
 ---> 35eb10d0edb2
Step 3 : RUN pip install gunicorn==18.0
 ---> Using cache
 ---> b458b748745b
Step 4 : COPY requirements.txt /tmp/
 ---> Using cache
 ---> 11254527ad5c
Step 5 : RUN pip install -r /tmp/requirements.txt
 ---> Using cache
 ---> 97fe7606f577
Step 6 : ENV foo /project/
 ---> Using cache
 ---> 1169087ff0c1
Step 7 : ENV doo /project/templates/
 ---> Running in b2bf8938d429
 ---> 4c1ebe6b75a8
Removing intermediate container b2bf8938d429
Step 8 : WORKDIR ${foo}
 ---> Running in f0c810cd64aa
 ---> d1a26ff706d6
Removing intermediate container f0c810cd64aa
Step 9 : COPY server.py ${foo}
 ---> 32c2217e1f0e
Removing intermediate container 85d27087ff7b
Step 10 : COPY chat.html ${doo}
 ---> 66368023e67f
Removing intermediate container 41030dbe5e5a
Step 11 : COPY login.html ${doo}
 ---> b9ec061f08c5
Removing intermediate container ef3fd9009229
Step 12 : EXPOSE 80
 ---> Running in 669d678f427e
 ---> 5e9860a70897
Removing intermediate container 669d678f427e
Step 13 : CMD gunicorn -b 0.0.0.0:80 --worker-class socketio.sgunicorn.GeventSocketIOWorker server:app
 ---> Running in 87c1bf1fecf9
 ---> e96ad068e1e5
Removing intermediate container 87c1bf1fecf9
Successfully built e96ad068e1e5

$ docker run -tid -P pytondev
888f0b5daf5ed84336ea965d6d2dc3fddc50a960c5213cb89c1bd6455fc23998

$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                   NAMES
888f0b5daf5e        pytondev            "/bin/sh -c 'gunicorn"   3 seconds ago       Up 3 seconds        0.0.0.0:32775->80/tcp   sick_wilson

$ docker exec -ti 888f0b5daf5e bash
root@888f0b5daf5e:/project# ps auxf
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root        15  0.3  0.1  18180  3352 ?        Ss   08:31   0:00 bash
root        29  0.0  0.1  15568  2232 ?        R+   08:31   0:00  \_ ps auxf
root         1  0.0  0.0   4448   760 ?        Ss+  08:30   0:00 /bin/sh -c gunicorn -b 0.0.0.0:80 --worker-class socketio.sgunicorn.GeventSocketIOWorker server:app
root         6  0.3  0.8  58360 17008 ?        S+   08:30   0:00 /usr/bin/python /usr/local/bin/gunicorn -b 0.0.0.0:80 --worker-class socketio.sgunicorn.GeventSocketIOWorker serv
root        11  0.2  0.9 143544 20104 ?        Sl+  08:30   0:00  \_ /usr/bin/python /usr/local/bin/gunicorn -b 0.0.0.0:80 --worker-class socketio.sgunicorn.GeventSocketIOWorker

http://192.168.99.100:32775