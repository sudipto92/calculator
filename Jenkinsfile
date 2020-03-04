node{
	def Namespace = "default"
	def ImageName = "sudiptod/image"
	def Creds = "DockerHub_Credentials"
	def GITHUB_URL = "https://github.com/sudipto92/calculator.git"
    def GITHUB_Creds = "GITHUB_CREDENTIALS"
	try{
		stage('Checkout'){
			git credentialsId: "${GITHUB_Creds}", url: "${GITHUB_URL}"
			sh "git rev-parse --short HEAD > .git/commit-id"
			imageTag= readFile('.git/commit-id').trim()
		}
		stage('Compile'){
			sh "./gradlew compileJava"
		}
		stage('Unit Tests'){
			sh "./gradlew test"
		}
		stage('Package'){		
		          sh "./gradlew build"
		}
		stage('Docker Build, Push'){

			withDockerRegistry([credentialsId: "${Creds}", url:'https://index.docker.io/v1/']) {
			sh "ssh -i /var/lib/jenkins/key.pem ec2-user@localhost \"cd /var/lib/jenkins/workspace/sudo_test;docker build -t ${ImageName}:${imageTag} .;docker push ${ImageName}:${imageTag}\""
			}
		}
		/*stage('Deploy on K8s'){
			sh "ansible-playbook /var/lib/jenkins/ansible/sayarappdeploy/deploy.yml --user=jenkins --extra-vars ImageName=${ImageName} --extra-vars imageTag=${imageTag} --extravars Namespace=${Namespace}"
		}*/
	}
	catch (err) {
		currentBuild.result = 'FAILURE'
	}
}
