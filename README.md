# Docker-Learnings_and_Examples

## commands
- ```docker info``` -> to get information about running docker
- ```docker container``` ls -> list of running docker machines
- ```docker version``` -> provide docker client and server versions
- ```docker images``` -> show all local images 
-```docker run <image_name>:<tag>``` -> create a container using specified image and run
- ```docker run <image_name>:<tag> <command>``` -  command that we need to run inside that container  like  - echo "hello-world"
- ```docker run -i -t <image>:<tag> ```- '-i' start and interactive container '-t' psuedo-TTY that attach stdin and stdout
- ``` docker run -d <image and tag> sleep 1000``` - '-d' means deatached mode and it started in background. default mode is foreground. sleep can be used to delay
- ``` docker ps``` - show all running containers
- ``` docker ps -a``` - show all with previously run containers.
- ``` docker run rm <imagedockerId>``` - remove image
- ``` docekr run --name <name> <imageName>: <id> ``` -  to provide a name for image
- ``` docker inspect <container_id>``` - display the low level inforamtion about a container or image 
-``` docker run -it -p <host_port> : <container_port>``` - run container with given port, can see running address and port using ``` docker ps -a```
-``` docker logs <image id>```- to see logs
- ``` docker history <imagename>:<tag> ``` - can use to see image layers
- ``` docker commit <container_id> <repo_name>:<tag>``` - to commit new docker image
- ``` docker build -t <repo_name>:<tag> <path of image>``` - to build image
-``` docker build -t <image_name>:<tag> . --no-cache= true ``` - build image without using cache
-``` docker tag <imageid> <new name for image>:<new tag for image>``` - can use to add new name or tag





### useful links
- official documentation - https://docs.docker.com/
- docker installation - https://docs.docker.com/install/linux/docker-ce/ubuntu/
- docker hub - https://hub.docker.com/
- 


### hypervisor based virtualization (before docker)
- A hypervisor, also known as a virtual machine monitor, is a process that creates and runs virtual machines (VMs). A hypervisor allows one host computer to support multiple guest VMs by virtually sharing its resources, like memory and processing.
-  each vm can have different OS
pros
- easy to scale
- cost effiecient
cons 
- kernel resource duplication
- application protability issue

### container based virtualization
- shared one kernal
- runtime isolation
- less cpu, vms
- faster
- guranteed portability

![hypervisor_vs_container](https://github.com/PushpikaWan/Docker-Learnings_and_Examples/blob/master/assets/01.hypervisor_vs_container.png)

### docker deamon
- is a docker server

### docker images
- images are readonly templates that used to create containers
- ``` docker build``` is used to create images
- are stored in a docker registry such as docker hub

### containers
- is a instance of images
- lightweight and portable encapsulated environment that can be used to run applications

### registries and repositories
- registry used to store images
- can host own registery or can use dockerhub (public)
- inside registry images are stored in repositories (registry <- repositories <- images)


### options
- If requested image already in local images repo. It will get an image from local repo. Otherwise image will be downloaded

- docker foreground and detached modes
- port mapping and logging

### docker image layers
- docker container has several image layers
- first image layer called as a base image
- layer by layer putting like stack

```
docker history <imagename>:<tag> can use to see image layers
```
- all changes made into running container will be written into the writable layer
- when container is deleted those writable layers also delete. but underline image layers doen't change
- multiple containers can share access to the same underline image

### ways to build a docker image
There are two ways
#### 01. commit changes made in the docker image
01. spain up a container from a base image
02. install git 
03. commit changes made in the container

~~~
 sudo docker run -it debian:jessie
 sudo apt-get update && sudo apt-get install git  //inside the image
 sudo docker commit 054534b741c9 pushpikawan/debian:1.00
 sudo docker images //can see our image
~~~

#### 02. write a docker image
- docker file is a text document that contains all instrcutions
- each instruction create new image layer to existing image
- name docker file start with capital
01.  create docker file
~~~
touch Dockerfile
//add stuf inside the docker file
FROM debian:jessie
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y vim
//

~~~
02. build docker image
~~~
docker build -t pushpikawan/debian_fromImage:1.00 .
sudo docker images //can see our image
~~~

### Chain of Run (Best practices)
- each run command create new layer on current layer. Therfore we can chain run to reduce number of image layers
~~~
RUN apt-get update && apt-get install -y  \
    git \
    vim
~~~
- sort multiline argument alphanumerically, it avoids duplicates and easy to update
- CMD instruction specify what command need to run when startup
- CMD only run container starts up
- command canbe exec or shell type
- this startup command can be override by giving command while starting
~~~
docker run <image>:<tag> echo "new thing"
~~~

### Docker cache
- if instructions doesn't change for image it simply reuse prv one
- There are aggressive caching scenarios. Therfore we need to forcefully invalidate cache like below
~~~
docker build -t <image_name>:<tag> . --no-cache= true
~~~

### COPY instruction
- copy files form build context and add them to the file system of the container
~~~
COPY abc.txt /src/abc.txt
~~~ 

### ADD instruction
- same as copy and in addition to that it allows to download file from internet and copy it to container
- this has ability to autmatically update compressed file
~~~
ADD abc.txt /src/abc.txt
~~~ 

### Upload image to docker hub
- need to create image with ```<dockerhubuserid>/<imagename> ```
- need to login docker hub account in terminal and push
~~~
docker login --username=pushpikawan
docker push <image_name>:<tag>
~~~

** do not use default tag. It is not updated when new version pushed to repo. Therfore use specific version




