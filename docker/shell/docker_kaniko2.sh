docker run -e DOCKER_CONFIG=/.docker \
           -v /root/.docker:/.docker \
           -v ./:/workspace \
           gcr.io/kaniko-project/executor:v1.21.0-debug \
           --context dir:///workspace/ \
           --dockerfile "./Dockerfile" \
           --destination "harbor.dev.tps.com/tps/${MOD_NAME}:${COMMIT_ID}" \
           --insecure --skip-tls-verify