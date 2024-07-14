docker run --rm \
            -v $(pwd):/workspace \
            -v ~/.docker/config.json:/kaniko/.docker/config.json \
            -v $(pwd)/cache:/cache \
            gcr.io/kaniko-project/executor:latest \
            --context /workspace \
            --dockerfile /workspace/Dockerfile \
            --cache=true \
            --cache-dir=/cache \
            --destination scofe/test:tag
