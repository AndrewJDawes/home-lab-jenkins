freeStyleJob("SeedJob") {
    description("SeedJob")
    displayName("SeedJob")
    scm {
        git {
            remote {
                // credentials("{{ jenkins_seed_job.github_credentials }}")
                url("https://github.com/AndrewJDawes/home-lab-jenkins-jobs")
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
