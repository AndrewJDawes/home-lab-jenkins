# home-lab-jenkins

## Examples

```
docker run --rm --volume /var/jenkins_home -p 8080:8080 ghcr.io/AndrewJDawes/home-lab-jenkins:latest
```

## TODO

-   [ ] Run the SeedJob on init
-   [ ] Possibly, also run the Organization Scans on init
-   [ ] Make sure that build data is separated from config (WebFX has done) and mount in separate volume
-   [ ]
