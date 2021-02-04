# 2020 03 DO Boston casestudy part 1

2020 03 DO Boston casestudy part 1 is a DevOps Pipeline for building, testing and deploying a python flask application.

Its process follows the steps below:
```
1. DevOps install Ansible and VirtualBox on bare metal.
2. DevOps create a single Master and as many Client Virtual Machines (VMs) as required.
3. DevOps run Ansible playbook to install Docker and Kubernetes with Jenkins configured as code in a Deployment (with jobs setup) on all client VMs.
4. Developers use Git to update the Jenkins' job's project on Source Control Management (SCM).
5. Jenkins (running in Kubernetes Deployment) receives a web-hook or polls SCM every so often to checkout updated SCM.
6. Jenkins compiles, packages and tests the checked out project.
7. If compiling, packaging and testing is successful, Jenkins pushes the project's image, newly tagged to DockerHUB.
8. Jenkins calls Ansible playbook to create another Kubernetes Deployment with the final application running.
```

## Installation

Download or Clone the repository to your local system using GitHub.com, GitHub Desktop application, Bitbucket.com, GitHub SourceTree application, or .zip

Ensure that the steps to install Ansible are followed: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html or AWX: https://github.com/ansible/awx/blob/devel/INSTALL.md

Ensure that the steps to install VirtualBox are followed: https://www.virtualbox.org/manual/ch02.html

Ensure you setup a Master VM and Client VM(s) (Client VM can be your Master if deploying to localhost/Master's IP Address)

Ensure that the steps to install Jenkins Configuration as Code are followed: https://github.com/nmm131/jcasc

NOTE: VM orchestration can be achieved using Vagrant.

Ensure tools below exist within "./src/sqlite/" before running the application:
```
database.db
dataFile.csv
dataFile-Bad.csv
```

You can edit db_initialization.sql to view/copy/paste commands into cmd/SQLite3.exe in the case database.db does not exist with a created table called records.

## Usage

Made with Git, Ansible, VirtualBox, Kubernetes, Docker, Jenkins Configuration as Code and the SCMs (sources of truth) below:
```
1. GitHub
2. DockerHUB
```

2020 03 DO Boston casestudy part 1 is re-runnable. Processing is automated and optimized using:
```
1. Git and DockerHUB repositories
2. Ansible playbooks and its VMs
3. Docker and Kubernetes running Jenkins Configuration as Code
4. Jenkins Poll SCM for its jobs
```

More details follow:
```
1. Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency. 
2. Ansible is the simplest way to automate apps and IT infrastructure. Application Deployment + Configuration Management + Continuous Delivery.
3. VirtualBox is a powerful x86 and AMD64/Intel64 virtualization product for enterprise as well as home use.
4. Docker is an open platform for developing, shipping, and running applications.
5. Kubernetes, also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications.
6. Jenkins is an open source automation server which enables developers around the world to reliably build, test, and deploy their software.
7. GitHub is where over 56 million developers shape the future of software, together. 
8. Docker Hub is the world's easiest way to create, manage, and deliver your teams' container applications. 
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
