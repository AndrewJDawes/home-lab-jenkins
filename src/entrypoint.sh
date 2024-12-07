#!/usr/bin/env bash
# fail if any commands fails
set -e
# pass thru any args
# ENTRYPOINT ["/usr/bin/tini" "--" "/usr/local/bin/jenkins.sh"]
/usr/bin/tini -s -- /usr/local/bin/jenkins.sh "$@"
