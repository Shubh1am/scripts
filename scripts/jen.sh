#####INSTALL JAVA 17 JRE######
set -x
sudo apt install openjdk-17-jre-headless -y # version 17.0.12+7-1ubuntu2~24.04

# Installing Jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "Jenkins is running"
else
  echo "Jenkins is not running"
fi
