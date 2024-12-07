# https://stackoverflow.com/a/75015304/13461208
# Preserve newline characters in multiline environment variables by calling cat on the file and passing the output to the environment variable
# docker run --rm --volume /var/jenkins_home -p 8080:8080 --env-file .env -e JENKINS_CREDENTIAL_JENKINS_GITHUB_ANDREWJDAWES_PRIVATE_KEY="$(cat converted-jenkins-github-andrewjdawes.pem)" -e JENKINS_CREDENTIAL_JENKINS_GITHUB_CODEKAIZEN_PRIVATE_KEY="$(cat converted-jenkins-github-codekaizen.pem)" ghcr.io/andrewjdawes/home-lab-jenkins:latest
docker build -t home-lab-jenkins:test .
docker run --rm --volume /var/jenkins_data -p 8080:8080 --env-file .env -e JENKINS_CREDENTIAL_JENKINS_GITHUB_ANDREWJDAWES_PRIVATE_KEY="$(cat converted-jenkins-github-andrewjdawes.pem)" -e JENKINS_CREDENTIAL_JENKINS_GITHUB_CODEKAIZEN_PRIVATE_KEY="$(cat converted-jenkins-github-codekaizen.pem)" home-lab-jenkins:test
