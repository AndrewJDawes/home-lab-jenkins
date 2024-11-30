docker build -t jenkins:andrew .
docker run --rm --volume /var/jenkins_home -p 8080:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=admin jenkins:andrew
