timestamps {

    node () {

	stage ('case-study - Checkout') {
 	 checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/JasonAutomation/2020_03_DO_Boston_casestudy_part_1']]]) 
	}
	stage ('case-study - Build') {
 			// build
sh """ 
pip3 install -r requirements.txt; python3 web.py 
 """ 
	    }
    }
}
