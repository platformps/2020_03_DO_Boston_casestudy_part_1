pipeline {
    agent any
    triggers(cron('*/5 * * * *'))
    environment {
        DOCKER_HUB_REPO = "kbelle/case_study1"
        CONTAINER_NAME = "kbelle/case_study1"
        STUB_VALUE = "200"
    }
    stages {
        }
        stage('Build') {
            steps {
                // Download an change directory into repo
                sh 'git clone https://github.com/kbelle-max/2020_03_DO_Boston_casestudy_part_1.git'
                sh 'cd 2020_03_DO_Boston_casestudy_part_1'
                //  Building new image from repo
                sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
                sh 'docker image tag $DOCKER_HUB_REPO:latest $DOCKER_HUB_REPO:$BUILD_NUMBER'


            }
        }
        stage('Publish'){
            steps{
                 //  Publishing Image to Repository
                sh 'docker push $DOCKER_HUB_REPO:$BUILD_NUMBER'
                sh 'docker push $DOCKER_HUB_REPO:latest'
                echo "Image built and pushed to repository"
            }
        }
        stage('Deploy') {
            steps {
                script{
                    //sh 'BUILD_NUMBER = ${BUILD_NUMBER}'
                    if (BUILD_NUMBER == "1") {
                        sh 'docker run --name $CONTAINER_NAME -d -p 5000:8080 $DOCKER_HUB_REPO'
                    }
                    else {
                        sh 'docker stop $CONTAINER_NAME'
                        sh 'docker rm $CONTAINER_NAME'
                        sh 'docker run --name $CONTAINER_NAME -d -p 5000:8080 $DOCKER_HUB_REPO'
                         }
                       }
                    }
                         }
}
}