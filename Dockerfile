FROM jenkins/jenkins:latest
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
RUN mkdir -p /var/jenkins_data
RUN mkdir -p /var/jenkins_home/jobs
RUN chown -R jenkins:jenkins /var/jenkins_data
RUN chown -R jenkins:jenkins /var/jenkins_home
COPY src/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
USER jenkins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Djenkins.model.Jenkins.workspacesDir='/var/jenkins_data/\${ITEM_FULL_NAME}/workspaces' -Djenkins.model.Jenkins.buildsDir='/var/jenkins_data/\${ITEM_FULL_NAME}/builds' -Dio.jenkins.plugins.artifact_manager_jclouds.s3.S3BlobStoreConfig.deleteArtifacts=true -Dio.jenkins.plugins.artifact_manager_jclouds.s3.S3BlobStoreConfig.deleteStashes=true"
ENV JENKINS_AGENTS_SSH_USERNAME=jenkins
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc.yaml
COPY src/usr/local/seed-job.groovy /usr/local/seed-job.groovy
COPY src/var/jenkins_home/init.groovy.d/ /var/jenkins_home/init.groovy.d/
COPY src/usr/share/jenkins/ref/plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY src/var/jenkins_home/casc.yaml /var/jenkins_home/casc.yaml
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
ENV JENKINS_LOCATION_URL=http://localhost:8080
ENV JENKINS_AGENT_HOME=/var/lib/jenkins
ENV JENKINS_AWS_S3_CUSTOM_ENDPOINT=minio.codekaizen.net
ENV JENKINS_CONJUR_APPLIANCE_URL=https://conjur.codekaizen.net
ENV JENKINS_CONJUR_ORG_ACCOUNT=myorg
ENV JENKINS_CONJUR_AUTH_WEB_SERVICE_ID=jenkins
ENV JENKINS_CONJUR_JWT_AUDIENCE=cyberark-conjur
ENTRYPOINT ["/entrypoint.sh"]
