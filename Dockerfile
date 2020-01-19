FROM debian:jessie
RUN apt-get update && apt-get install -y  \
    git \
    vim
COPY abc.txt /src/abc.txt

# need to comment CMD command to run -it
CMD ["echo", "Hello world"]

