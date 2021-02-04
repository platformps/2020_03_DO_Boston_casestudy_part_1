Please follow the live [document](https://docs.google.com/document/d/17OwlITE-yPWNj3Vi5RtQfz3ItvSkOfnbaVMnzlZyGTg)
a
#  Documentation for Case study  #

----------
Liang Liu 

## Design Phase ##

 My design

1.   Set up git-hub repository, everything will be push to the remote repository
 
2.   Building a CI/CD pipeline using Jenkins. Jenkins will check the git-hub repository every 15 minutes, if any changes were made, it will trigger a new build.
   
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

2. Testing the dockerized flask-app by building the image and run it directly through Docker, make sure the dockerized app works. Then push it to docker-hub for later.

3. Testing the Ansible by runing an Ansible ping to target machine, make sure the connection is fine.

4. Set up the pipeline in Jenkins, so Jenkins will clone down the repository and trigger the Ansible to run a dummy playbook(this playbook is not doing any deployment, just for testing). Store the pipeline script in the Jenkinsfile.

5. Write the corresponding yaml file for both Ansible and kubernetes. 

6. Any failures in the sources code will stop the pipeline.
failed dockerfile or app code will cause Docker trigger errors and stop the image building or container running, failed kubernetes yaml file will cause failed deployment on target machine, failed ansible playbook will cause connection error or failed deployment  

7. Succeed and failed pipeline
    ![](https://github.com/kg0529/2020_03_DO_Boston_casestudy_part_1/blob/main/screenshots/s5.png)




## Deploy Phase ##

1. First deploy the application on target machine using kubernates by applying the kubernetes.yml file. Making sure this yaml file is working fine. Then delete the deployment.

2. First issue encounter is that since we are using Jenkins for the pipeline, we need to add "jenkins" user to passwordless sudo list.

3. Then need to add "jenkins" user docker group since we need it to run docker, even it is Jenkins triggering Ansible to use Docker for buidling and uploading images.

4. Modify the ansible playbook accordingly whenever an issue coming up.

# Testing Pipeline #

1. All files and tools should be ready at this point,

2. Run the pipeline, should get a success result
     
![](https://github.com/kg0529/2020_03_DO_Boston_casestudy_part_1/blob/main/screenshots/s3.png)

3. Rolling a new deployment by modify yaml file, to have 2 old(blue) deployment and 1 new(green) deployment, push it to git-hub, and wait for the Pipeline to be triggered.

4. Should be the deployment changed for 2 old and 1 new (blue and green deployment) 
![](https://github.com/kg0529/2020_03_DO_Boston_casestudy_part_1/blob/main/screenshots/s6.png)



# Continuous Deployment #

1. This Step is very similar to previous step, but instead of creating new(green), we just scale the replica from 3 to 5

2. Modify the ansible playbook, scale replica by adding kubectl scale command.

3. Push code to github and wait for pipeline to trigger.

4. result should be as below
![](https://github.com/kg0529/2020_03_DO_Boston_casestudy_part_1/blob/main/screenshots/s7.png)


# Problems encountered #
1. Originally want to use dockerized Jenkins, and let Jenkins interact with both docker and ansible, but couldn't get jenkins to work with ansible unless install ansible and tons of other tools in the container that running jenkins. However, this approach seems to much work and would cause even more problems. I give up this idea and just install Jenkins on host machine instead, making ansible to handle the job to build and upload image through docker.

2. Another big problem is getting permission denied when ansible interact with docker to build and upload image. Found out that when we run ansible in a Jenkins pipeline, the user that running command is not my current user, but the user "jenkins" instead. Giving all permission and credential it needs to user "jenkins" will solve this problem.

# Improvisation #

1. Ansible is so powerful, for this project, I configure the target machine and install docker, minikube manually. I could just write an ansible playbook yaml file to make the ansible configure the target machine for me. Doing it this way could save tons of time if I need multiple target machines and have a homogeneous environment on target machine. 

