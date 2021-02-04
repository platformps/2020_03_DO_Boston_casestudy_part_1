Please follow the live [document](https://docs.google.com/document/d/17OwlITE-yPWNj3Vi5RtQfz3ItvSkOfnbaVMnzlZyGTg)
a
#  Documentation for Case study  #

----------

## Design Phase ##

  Set up git-hub repository, everything will be push to the remote repository
 
  Building a CI/CD pipeline using Jenkins. Jenkins will check the git-hub repository every 15 minutes, if any changes were made, it will trigger a new deployment.
  
  Host machine and target machine will be connected through SSH
  
  Jenkins on the host machine will start the Ansible with the flask-playbook.yml file 
   
  Ansible will clone down the repository(to build the image), build the image and push it to docker-hub using Docker, all those are done on the host machine.

  Then, Ansible will configure the target machine through SSH connection, clone down the repository(need the kubernetes.yml file), start up kubernetes and kubernetes will deploy the application using kubernetes.yml file. During the process, kubernetes will pull image from docker-hub.



![](https://github.com/kg0529/2020_03_DO_Boston_casestudy_part_1/blob/main/flask-app.png)