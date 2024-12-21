freeStyleJob("seed-job") {
    description("Seed Job")
    displayName("Seed Job")
    scm {
        git {
            remote {
                url("${JENKINS_SEED_JOB_REPO_URL}")
            }
            branch("*/main")
            extensions {
                disableRemotePoll()
            }
        }
    }
    steps {
        jobDsl {
            removedJobAction("DELETE")
            removedViewAction("DELETE")
            targets("**/folder.groovy\n**/job.groovy")
        }
    }
    triggers {
        gitHubPushTrigger()
    }
}
