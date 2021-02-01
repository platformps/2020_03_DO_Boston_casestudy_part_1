pipeline {
	agent {
		dockerfile {
			args '-v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
	}
}
	environment {
		DOCKER_HUB_REPO = "nmm131/git-ansible-vb-k8-docker-jenkins"
	}
	stages {
		//stage('Set Up') {
		//	steps {
		//		script {
		//			dir('../') {
		//				sh 'rm -rf workspace && rm -rf workspace@tmp'
		//			}
		//		}
		//	}
		//}
		stage('SCM Checkout') {
			steps {
				script {
					sh 'python3 -m pip install --upgrade pip'
					sh 'git clone https://github.com/nmm131/2020_03_DO_Boston_casestudy_part_1.git git-ansible-vb-k8-docker-jenkins'
					sh 'pip install -r ./git-ansible-vb-k8-docker-jenkins/requirements.txt'
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
		stage('Compile-Package-Test') {
			steps {
				script {
					//dir('./git-ansible-vb-k8-docker-jenkins') {
					sh "python app.py"
					//env is Jenkins build parameter
					//sh '`gen-hosts-list $env` > /path/to/hosts_list'
					//sh 'ansible-playbook ./kuberplaybook.yml -i /path/to/hosts_list -u AUTO_USER --private-key=/path/to/private-key'
					sh 'minikube start'
					sh 'kubectl apply -f kubernetes.yaml'
					//}
				}
			}
		}
	}
}