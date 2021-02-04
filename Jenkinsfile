pipeline {
	agent {
		docker {
			image 'nmm131/git-ansible-vb-k8-docker-jenkins'
			args '-v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
		}
	}
	environment {
		DOCKER_HUB_REPO = "nmm131/git-ansible-vb-k8-docker-jenkins"
	}
	stages {
		stage('Compile-Package-Test') {
			steps {
				script {
					sh "python app.py"
				}
			}
		}
		stage('Build') {
			steps {
				script {
					withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER1', passwordVariable: 'PASS1')]) {
					sh 'docker login -u "$USER1" -p "$PASS1"'
					}
					sh 'docker image build -t $DOCKER_HUB_REPO:latest .'

					sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'

					sh 'docker push $DOCKER_HUB_REPO:$BUILD_NUMBER'
					sh 'docker push $DOCKER_HUB_REPO:latest'

					echo "Image built and pushed to repository"
				}
			}
		}
		stage('Deploy') {
			steps {
				script {
					sh 'echo "DEPLOY"'
				}
			}
		}
	}
}