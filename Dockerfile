FROM --platform=$BUILDPLATFORM ubuntu:20.04

ARG TARGETPLATFORM
ARG BUILDPLATFORM

LABEL maintainer="fr3akyphantom <rokibhasansagar2014@outlook.com>"

RUN echo "Build Platform is $BUILDPLATFORM" && \
  case $TARGETPLATFORM in \
    linux/amd64) \
      echo "It's linux/amd64" \
      ;; \
    linux/386) \
      echo "It's linux/386" \
      ;; \
    linux/arm64) \
      echo "It's linux/arm64 +/v8" \
      ;; \
    linux/arm/v7) \
      echo "It's linux/arm/7" \
    esac
