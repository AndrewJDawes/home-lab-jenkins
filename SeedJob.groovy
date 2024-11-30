freeStyleJob("SeedJob") {
    description("SeedJob")
    displayName("SeedJob")
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
            targets("**/*.groovy")
        }
    }
    triggers {
        gitHubPushTrigger()
    }
}
