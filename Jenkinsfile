pipeline{
	agent any	
	environment {
		REGISTRY_CREDENTIAL = "dockerhub"
	}
	stages{
		stage('check-out'){
			steps{
				sh 'rm -rf 2020_03_DO_Boston_casestudy_part_1'
				sh 'git clone https://github.com/JasonAutomation/2020_03_DO_Boston_casestudy_part_1'
			}
		}
		stage('Build'){
			steps{
				sh 'docker image build -t jasonautomation/case-study-part1 .'
			}
		}
		stage('Push'){
			steps{
				script{	
					docker.withRegistry( '', REGISTRY_CREDENTIAL ){
						sh 'docker push jasonautomation/case-study-part1'
					}
				}
			}
		}
		stage('Deploy'){
			steps{
				script {
					sh 'ansible-playbook case-study-playbook.yml'
				}
			}
		}
	}
}
