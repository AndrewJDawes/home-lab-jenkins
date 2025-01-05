FROM jenkins/jenkins:latest
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
RUN mkdir -p /var/jenkins_data
RUN chown -R jenkins:jenkins /var/jenkins_data
COPY src/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
USER jenkins
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false -Djenkins.model.Jenkins.workspacesDir='/var/jenkins_data/\${ITEM_FULL_NAME}/workspaces' -Djenkins.model.Jenkins.buildsDir='/var/jenkins_data/\${ITEM_FULL_NAME}/builds'"
ENV JENKINS_AGENTS_SSH_USERNAME=jenkins
# Make a link from /var/jenkins_home/jobs to /var/jenkins_data/jobs
RUN ln -s /var/jenkins_data/jobs /var/jenkins_home/jobs
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc.yaml
COPY src/usr/local/seed-job.groovy /usr/local/seed-job.groovy
COPY src/var/jenkins_home/init.groovy.d/ /var/jenkins_home/init.groovy.d/
COPY src/usr/share/jenkins/ref/plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY src/var/jenkins_home/casc.yaml /var/jenkins_home/casc.yaml
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
ENTRYPOINT ["/entrypoint.sh"]


# jenkins_workspaces_dir: "{{ jenkins_workspaces_base_dir }}/${ITEM_FULL_NAME}/workspace" # default is '${JENKINS_HOME}/workspace/${ITEM_FULL_NAME}'
# jenkins_builds_dir: "{{ jenkins_controller_builds_dir }}/${ITEM_FULL_NAME}" # default is '${ITEM_ROOTDIR}/builds'
# - name: If Jenkins_builds_dir is defined, add -D option to jenkins_java_options
#   set_fact:
#     jenkins_java_options: "{{ jenkins_java_options }} -Djenkins.model.Jenkins.buildsDir='{{ jenkins_builds_dir }}'"
#   when: jenkins_builds_dir is defined

# - name: If Jenkins_workspaces_dir is defined, add -D option to jenkins_java_options
#   set_fact:
#     jenkins_java_options: "{{ jenkins_java_options }} -Djenkins.model.Jenkins.workspacesDir='{{ jenkins_workspaces_dir }}'"
#   when: jenkins_workspaces_dir is defined
