Please follow the live [document](https://docs.google.com/document/d/17OwlITE-yPWNj3Vi5RtQfz3ItvSkOfnbaVMnzlZyGTg)
a
#  Documentation for Case study  #

----------

## Design Phase ##
  My design

1.   Set up git-hub repository, everything will be push to the remote repository
 
2.   Building a CI/CD pipeline using Jenkins. Jenkins will check the git-hub repository every 15 minutes, if any changes were made, it will trigger a new deployment.
   
3.   Host machine and target machine will be connected through SSH
  
4.   Jenkins on the host machine will start the Ansible with the flask-playbook.yml file 
  
5.   Ansible will clone down the repository(to build the image), build the image and push it to docker-hub using Docker, all those are done on the host machine.
 
5.   Then, Ansible will configure the target machine through SSH connection, clone down the repository(need the kubernetes.yml file), start up kubernetes and kubernetes will deploy the application using kubernetes.yml file. During the process, kubernetes will pull image from docker-hub.

![](https://github.com/kg0529/2020_03_DO_Boston_casestudy_part_1/blob/main/flask-app.png)

## Setup Phase ##
1. Fork then clone the case study project repository on my actual machine, setting up the remote git-hub repository for this case study project. 

1. Setup two virtual machines, one is host machine using normal ubuntu since we need GUI on this one, one is target machine using uBuntu server version, since we will only need CLI on this one. Install all necessary tools on both such as ssh net tools, Dockers, ifconifg and etc.

2. Set up passwordless sudo on both machines, set up SSH connections 

3. On the host machine, install Jenkins, Ansible, java(openjdk),   (original idea was using dockerized Jenkins, but idea abandoned due to need to use Ansible and ssh and other issues.). Install all recommanded plugins for Jenkins
Do a docker login as well, since we will be using Ansible to command docker to build the image then push it to docker-hub

4. On the target machine, install Kubernetes(minikube), and install kubectl(somehow installing minikube didn't install kubectl on linux machine)

## Pipeline Building ##
1. Writing the pipeline in Jenkinsfile for a test run, by deploy the flask-app directly through jenkins without dockerized the flask-app. Do the Git-Poll for every 15 minutes, make sure this basic pipeline works.

2. Testing the dockerized flask-app by building the image and run it directly through Docker, make sure the dockerized app works.

3. Testing the Ansible by runing an Ansible ping to target machine, make sure the connection is fine.

4. Set up the pipeline in Jenkins, so Jenkins will clone down the repository and trigger the Ansible to run a dummy playbook(this playbook is not doing any deployment, just for testing). Store the pipeline script in the Jenkinsfile.

5. Successes and fails
    ![](https://github.com/kg0529/2020_03_DO_Boston_casestudy_part_1/blob/main/screenshots/s5.png)





