# https://stackoverflow.com/a/75015304/13461208
# Preserve newline characters in multiline environment variables by calling cat on the file and passing the output to the environment variable
# docker run --rm --volume /var/jenkins_home -p 8080:8080 --env-file .env -e JENKINS_CREDENTIAL_GITHUB_APP_USER_ANDREWJDAWES_SSH_KEY_PRIVATE="$(cat converted-github-app-user-andrewjdawes.pem)" -e JENKINS_CREDENTIAL_GITHUB_APP_ORGANIZATION_CODEKAIZEN_SSH_KEY_PRIVATE="$(cat converted-github-app-organization-codekaizen.pem)" ghcr.io/andrewjdawes/home-lab-jenkins:latest
docker build -t home-lab-jenkins:test .
docker run --name jenkins --rm --volume /var/jenkins_data -p 8080:8080 --env-file .env \
    -e JENKINS_CREDENTIAL_JENKINS_CONTROLLER_TO_AGENTS_PRIVATE_KEY="$(cat jenkins-controller-to-agents-private-key.pem)" \
    -e JENKINS_CREDENTIAL_GITHUB_APP_USER_ANDREWJDAWES_SSH_KEY_PRIVATE="$(cat converted-github-app-user-andrewjdawes.pem)" \
    -e JENKINS_CREDENTIAL_GITHUB_APP_USER_MISSIEDAWES_SSH_KEY_PRIVATE="$(cat converted-github-app-user-missiedawes.pem)" \
    -e JENKINS_CREDENTIAL_GITHUB_APP_ORGANIZATION_CODEKAIZEN_SSH_KEY_PRIVATE="$(cat converted-github-app-organization-codekaizen.pem)" \
    home-lab-jenkins:test
