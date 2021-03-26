# set base image (host OS)
FROM python:3.8

# set the working directory in the container
WORKDIR /auth

# copy the dependencies file to the working directory
COPY requirements.txt .

# update packages prior to installing requirements
RUN pip install --upgrade pip
# RUN apt-get update
# RUN apt-get install libffi-dev build-essential libssl-dev libffi-dev python-dev -y

# install dependencies
RUN pip install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY authenticator/ .

# command to run to build and test authenticator
RUN dev/venv/make-venv.sh
RUN . dev/venv/activate-project.src
RUN dev/venv/provision-venv.sh
RUN dev/lint.sh
RUN dev/runtests.sh

# command to run on container start
CMD [ "authenticator", "generate" ]