# set base image (host OS)
FROM python:3.8

# set the working directory in the container
WORKDIR /auth

# copy the dependencies file to the working directory
COPY requirements.txt .

# update packages prior to installing requirements
RUN apk --update add build-base libffi-dev openssl-dev python-dev py-pip

RUN apk add --no-cache libressl-dev musl-dev libffi-dev

# install dependencies
RUN pip install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY src/ ./src

COPY dev/ ./dev

# command to run on container start
CMD [ "dev/venv/make-venv.sh" ]
CMD [ ". dev/venv/activate-project.src" ]
CMD [ "dev/venv/provision-venv.sh" ]
CMD [ "dev/lint.sh" ]
CMD [ "dev/runtests.sh" ]