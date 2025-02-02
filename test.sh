#!/usr/bin/env bash
# https://stackoverflow.com/a/75015304/13461208
# Preserve newline characters in multiline environment variables by calling cat on the file and passing the output to the environment variable
# docker run --rm --volume /var/jenkins_home -p 8080:8080 --env-file .env -e JENKINS_CREDENTIAL_GITHUB_APP_USER_ANDREWJDAWES_SSH_KEY_PRIVATE="$(cat converted-github-app-user-andrewjdawes.pem)" -e JENKINS_CREDENTIAL_GITHUB_APP_ORGANIZATION_CODEKAIZEN_SSH_KEY_PRIVATE="$(cat converted-github-app-organization-codekaizen.pem)" ghcr.io/andrewjdawes/home-lab-jenkins:latest
docker build -t home-lab-jenkins:test .
# If network minio is not created, create it
docker network create minio_reverse_proxy || true
docker network create conjur_external || true
docker run --name jenkins --rm --volume /var/jenkins_data -p 8073:8080 --env-file .env \
    -e JENKINS_CREDENTIAL_JENKINS_CONTROLLER_TO_AGENTS_PRIVATE_KEY="$(cat jenkins-controller-to-agents-private-key.pem)" \
    -e JENKINS_CREDENTIAL_GITHUB_APP_USER_ANDREWJDAWES_SSH_KEY_PRIVATE="$(cat converted-github-app-user-andrewjdawes.pem)" \
    -e JENKINS_CREDENTIAL_GITHUB_APP_USER_MISSIEDAWES_SSH_KEY_PRIVATE="$(cat converted-github-app-user-missiedawes.pem)" \
    -e JENKINS_CREDENTIAL_GITHUB_APP_ORGANIZATION_CODEKAIZEN_SSH_KEY_PRIVATE="$(cat converted-github-app-organization-codekaizen.pem)" \
    -e JENKINS_CREDENTIAL_APPLICATION_DEPLOYMENT_PREVIOUSLY_AUTHORIZED_SSH_KEY_PRIVATE="$(cat application-deployment-previously-authorized-private-key.pem)" \
    --network minio_reverse_proxy \
    --network conjur_external \
    home-lab-jenkins:test
