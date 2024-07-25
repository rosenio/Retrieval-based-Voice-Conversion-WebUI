# syntax=docker/dockerfile:1

FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04

EXPOSE 7865


WORKDIR /app

COPY . .


# Install dependenceis to add PPAs
RUN apt-get update
RUN apt-get install -y -qq ffmpeg 
RUN apt-get install -y software-properties-common 
RUN apt-get install -y python3 python3-pip
RUN apt-get install -y git

#RUN git clone https://github.com/rosenio/Retrieval-based-Voice-Conversion-WebUI.git

#WORKDIR Retrieval-based-Voice-Conversion-WebUI

# Create a symbolic link for python

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN python -m pip install requests



VOLUME [ "/app/weights", "/app/opt", "/app/logs", "/app/assets", "/app/configs" ]


RUN python3 -m pip install --no-cache-dir -r requirements.txt



CMD ["python3", "infer-web.py"]
