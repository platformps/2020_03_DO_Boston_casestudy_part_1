pipeline {
	//agent any
	agent {
		docker {
			image 'nmm131/flask-docker-jenkins-ansible-k8:29'
			args '-v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
		}
	}
	environment {
		DOCKER_HUB_REPO = "nmm131/git-ansible-vb-k8-docker-jenkins"
	}
	stages {
		//stage('SCM Checkout') {
		//	steps {
		//		script {
		//			sh 'git clone https://github.com/nmm131/2020_03_DO_Boston_casestudy_part_1.git git-ansible-vb-k8-docker-jenkins'
		//		}
		//	}
		//}
		stage('Compile-Package-Test') {
			steps {
				script {
					//dir('./git-ansible-vb-k8-docker-jenkins') {
					sh "python app.py"
					// install curl in Dockerfile and test port 5000 with curl, if not working stop pipeline
					//env is Jenkins build parameter
					//sh '`gen-hosts-list $env` > /path/to/hosts_list'
					//sh 'ansible-playbook ./kuberplaybook.yml -i /path/to/hosts_list -u AUTO_USER --private-key=/path/to/private-key'
					//sh 'minikube start'
					//sh 'kubectl apply -f kubernetes.yaml'
					//}
				}
			}
		}
		stage('Build') {
			steps {
				script {
					// Build new image
					withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER1', passwordVariable: 'PASS1')]) {
					sh 'docker login -u "$USER1" -p "$PASS1"'
					}
					sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
					//todo: upgrade pip, clone project, install requirements, ignore Dockerfile and git-ansible-vb-k8-docker-jenkins@tmp from build
					//commits empty workspace directories -> sh 'docker commit `cat /etc/hostname` $DOCKER_HUB_REPO:latest'
					sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'

					// Push image to repository
					sh 'docker push $DOCKER_HUB_REPO:$BUILD_NUMBER'
					sh 'docker push $DOCKER_HUB_REPO:latest'

					echo "Image built and pushed to repository"
				}
			}
		}
		//stage('Deploy') {
		//	steps {
		//		script {
		//			ansible-playbook playbook-app.yaml
		//		}
		//	}
		//}
	}
}