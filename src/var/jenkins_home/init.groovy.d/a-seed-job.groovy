// Import the Jenkins class
import jenkins.model.Jenkins

// Define the job name
def jobName = 'seed-job'

// Get the Jenkins instance
def jenkins = Jenkins.instance

// Get the job by its name
def job = jenkins.getItem(jobName)

if (job) {
    // Trigger a build
    job.scheduleBuild(0)
    println "Build for job '${jobName}' has been triggered."
} else {
    println "Job '${jobName}' not found."
}
