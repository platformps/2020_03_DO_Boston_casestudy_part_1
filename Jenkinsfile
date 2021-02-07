pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                git url: 'https://github.com/JasonAutomation/2020_03_DO_Boston_casestudy_part_1'
            
            }
        }
        stage('Deploy') {
            steps {
                
                ansiblePlaybook(playbook: 'case-study-playbook.yml')
              
            }
        }
    }
}
