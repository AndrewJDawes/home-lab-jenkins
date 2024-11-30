freeStyleJob("seed-job") {
    description("Seed Job")
    displayName("Seed Job")
    scm {
        git {
            remote {
                // credentials("{{ jenkins_seed_job.github_credentials }}")
                url("${JENKINS_SEED_JOB_REPO_URL}")
            }
            branch("*/main")
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
