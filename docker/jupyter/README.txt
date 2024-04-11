# Source of notebook builds: https://hub.docker.com/r/jupyter/scipy-notebook

Building dual-platform jupyter-lab containers for analyzing ELM output

docker buildx build --push -t yuanfornl/elm_simulation_tools:elmlab_3.3.2 --no-cache  \
--platform linux/amd64,linux/arm64 -f ngeeA_elm_simulation_tools/docker/jupyter/Dockerfile_elmlab_3.3.2 .
