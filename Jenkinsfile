pipeline{
	agent any	
	environment {
		REGISTRY_CREDENTIAL = "dockerhub"
	}
	stages{
		stage('check-out'){
			steps{
				sh 'rm -rf 2020_03_DO_Boston_casestudy_part_1'
				sh 'git clone https://github.com/kg0529/2020_03_DO_Boston_casestudy_part_1.git'
			}
		}
		stage('Build'){
			steps{
				sh 'docker image build -t kg0529/flask .'
			}
		}
		stage('Push'){
			steps{
				script{	
					docker.withRegistry( '', REGISTRY_CREDENTIAL ){
						sh 'docker push kg0529/flask'
					}
				}
			}
		}
		stage('Deploy'){
			steps{
				sh 'ansible-playbook flask-playbook.yml'
			}
		}
	}
}
