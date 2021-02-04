pipeline {
	// Run application in container with dependencies installed
	agent {
		// Build Image from Dockerfile in checkedout repository
		dockerfile {
			// Mount volumes, especially Docker volume
			args '-v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
		}
	}
	// Set name of image to push to DockerHUB
	environment {
		DOCKER_HUB_REPO = "nmm131/git-ansible-vb-k8-docker-jenkins"
	}
	stages {
		stage('Compile-Package-Test') {
			steps {
				script {
					// Run application
					sh "python app.py"
					// If install Curl, it is possible to curl localhost:5000 (or similar) to check response of application afer running
				}
			}
		}
		stage('Build') {
			steps {
				script {
					// Login to DockerHUB using Jenkins Credentials
					withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER1', passwordVariable: 'PASS1')]) {
					sh 'docker login -u "$USER1" -p "$PASS1"'
					}
					// Build Docker image and name it value of DOCKER_HUB_REPO variable
					sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
					// Tag build number to built Docker image
					sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'

					// Push image to DockerHUB repository
					sh 'docker push $DOCKER_HUB_REPO:$BUILD_NUMBER'
					sh 'docker push $DOCKER_HUB_REPO:latest'
					
					// Print message in logs
					echo "Image built and pushed to repository"
				}
			}
		}
		stage('Deploy') {
			steps {
				script {
					// Deploy application using
					//ansible-playbook playbook-app.yaml
					sh 'echo "Need to manually test Deploy stage"'
				}
			}
		}
	}
}