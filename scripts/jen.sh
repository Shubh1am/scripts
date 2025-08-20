#####INSTALL JAVA 17 JRE######
set -x
#sudo apt install openjdk-17-jre-headless -y # version 17.0.12+7-1 17/08/2025
#
#sudo apt-get install openjdk-17-jre -y
sudo apt-get update
sudo apt-get install fontconfig openjdk-21-jre
java -version

# Installing Jenkins
#sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
#  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
#echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
#  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
#  /etc/apt/sources.list.d/jenkins.list > /dev/null
#sudo apt-get update
#sudo apt-get install jenkins -y

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

sudo chown -R jenkins:jenkins /var/lib/jenkins

sleep 5
sudo systemctl enable jenkins
sleep 5
sudo systemctl start jenkins
sleep 5
sudo systemctl status jenkins > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "Jenkins is running"
else
  echo "Jenkins is not running"
  echo "reinstalling..."
  sudo lsof -i :8080
  sudo apt-get install --reinstall jenkins
  sudo systemctl restart jenkins
  sudo journalctl -xeu jenkins.service -n 50 --no-pager
fi

