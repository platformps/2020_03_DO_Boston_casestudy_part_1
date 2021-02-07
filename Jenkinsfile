pipeline {
	agent {
		any
	}
	stages {
		stage('docker') {
			// Run application in container with dependencies installed
			agent {
				dockerfile {
					// '-e HOME=/tmp' fixes withCredentials' "mkdir /.docker permission denied" error
					args '-e HOME=/tmp -v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
				}
			}
			// Set name of image to push to DockerHUB
			environment {
				DOCKER_HUB_REPO = "nmm131/git-jenkins-ansible-vb-docker-k8"
			}
			stages {
				stage('Compile-Package-Test') {
					steps {
						script {
							// Run application
							sh 'python3 app.py &'
							sh 'sleep 1'
							// Check response of application after running
							// Stop Jenkins Build if application is not responding
							sh '''
								if [ curl -sL --fail http://localhost:5000 -o /dev/null ]
								then
									echo "Application successfully running!"
								else
									echo "Application isn't responding!"
									#currentBuild.result = 'ABORTED'
									#error('Application isn't responding! Stopping early…')
								fi
								'''
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
			}
		}
		stage('Deploy') {
			steps {
				script {
					sh 'echo "PWD: `pwd` and ls: `ls`"'
					// Deploy application using ansible and kubernetes
					sh 'ansible-playbook playbook-deploy-app.yaml'
				}
			}
		}
	}
}