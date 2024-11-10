pipeline {
    agent any

    environment {
        SSH_SCRIPT = 'ansible/ssh.sh' // Path to your SSH script
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', credentialsId: 'your-github-credentials-id', url: 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('SSH and Run Ansible Playbooks') {
            steps {
                script {
//                    def ec2Instances = [
//                        '192.168.1.100',
//                        '192.168.1.101'
//                    ]

                    ec2Instances.each { instanceIp ->
                        // Execute SSH script with instance IP as argument
                        sh "sh ${env.SSH_SCRIPT} ${instanceIp}"

                        // Execute the first playbook (k8s.yml)
                        sh "ansible-playbook -i inventory.ini k8s.yml"

                        // Sleep for a few seconds (adjust as needed)
                        sleep 5

                        // Execute the second playbook (master.yml)
                        sh "ansible-playbook -i inventory.ini master.yml"
                    }
                }
            }
        }
    }
}
