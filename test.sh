docker build -t jenkins:andrew .
docker run --rm --volume /var/jenkins_home -p 8080:8080 --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=admin --env JENKINS_SEED_JOB_REPO_URL=https://github.com/AndrewJDawes/home-lab-jenkins-jobs jenkins:andrew
