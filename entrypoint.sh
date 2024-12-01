#!/usr/bin/env bash
# fail if any commands fails
set -e
# pass thru any args
# curl JENKINS_CASC_URL to /var/jenkins_home/casc.yaml
curl -f -L -o /var/jenkins_home/casc.yaml "${JENKINS_CASC_URL}"
# curl the seed-job.groovy
# ENTRYPOINT ["/usr/bin/tini" "--" "/usr/local/bin/jenkins.sh"]
/usr/bin/tini -s -- /usr/local/bin/jenkins.sh "$@"
