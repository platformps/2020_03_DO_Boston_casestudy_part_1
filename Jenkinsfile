pipeline{
	agent any
        
	stages{
                //Jenkins will do a git polling every 15mins, start a new deployment if any changes are found
		//remove previous existing repository then clone down the repository

		stage('check-out'){
			steps{
				sh 'rm -rf 2020_03_DO_Boston_casestudy_part_1'
				sh 'git clone https://github.com/kg0529/2020_03_DO_Boston_casestudy_part_1.git'
			}
		}
		stage('Deploy'){
			steps{
                                //Jenkins tells ansible to start the deployment
                                //ansible will build the image, push it to dockerhub (done on host machine)
                                //ansible then will deploy the application on target machine using kubernetes

				script {
					sh 'ansible-playbook flask-playbook.yml'
				}
			}
		}
	}
}
