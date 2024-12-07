FROM jenkins/jenkins:latest
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
COPY src/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
USER jenkins
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc.yaml
COPY src/usr/local/seed-job.groovy /usr/local/seed-job.groovy
COPY src/var/jenkins_home/init.groovy.d/ /var/jenkins_home/init.groovy.d/
COPY src/usr/share/jenkins/ref/plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY src/var/jenkins_home/casc.yaml /var/jenkins_home/casc.yaml
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
ENTRYPOINT ["/entrypoint.sh"]
