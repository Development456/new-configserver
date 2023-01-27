pipeline {
	agent any
	tools {
maven "3.6.0" // You need to add a maven with name "3.6.0" in the Global Tools Configuration page
}
stages {
stages("Build") {
	steps{
sh "mvn -version"
sh "mvn clean install"
}
}
 stage("Git Clone"){
	 steps{
   git branch: 'main', url: 'https://github.com/ineeladri/new-configserver.git'
      }
 }
	stage("Docker build"){
		 steps{
        sh 'docker build -t configserver .'
        sh 'docker image ls'
      }
	}
      withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'test', usernameVariable: 'ineeladri', passwordVariable: 'password']]) {
        sh 'docker login -u ineeladri -p $password docker.io'
      }
      stage("Pushing Image to Docker Hub"){
	       steps{
	sh 'docker tag configserver ineeladri/configserver:latest'
	sh 'docker push ineeladri/configserver:latest'
      }
      }
      stage("SSH Into Server") {
	    steps{   
       def remote = [:]
       remote.name = 'VMububtu18.0'
       remote.host = '20.232.127.94'
       remote.user = 'azureuser'
       remote.password = 'Miracle@1234'
       remote.allowAnyHosts = true
     }
      }
     stage("Deploy"){
	      steps{
	     sh 'docker stop configserver|| true && docker rm -f configserver || true'
	     sh 'docker run -d -p 8888:8888 --name configserver configserver:latest'
	      }
     }
    }
}

