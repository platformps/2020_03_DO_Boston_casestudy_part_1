pipeline{
	agent any
	
	stages{
		stage('check-out'){
			setps{
				sh 'git clone https://github.com/kg0529/2020_03_DO_Boston_casestudy_part_1.git'
			}
		}
		stage('Build'){
			steps{
				sh 'docker image build -t kg0529/flask'
			}
		}
		stage('Push'){
			steps{
				withDockerRegistry([ credientialsID: "dockerhub"]){
				sh 'docker push kg0529/flask'
				}
			}
		}
		stage('Depoly'){
			steps{
				sh 'echo  "Ansible commands"'
			}
		}
	}
}
