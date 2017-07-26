#!/bin/bash

nvidia-docker run -d --rm -p 8022:22 --name deep-learning -v /etc/localtime:/etc/localtime:ro -v /data/workspace:/data/workspace:rw -v /data/workspace/Docker/deep-learning/.pycharm_helpers:/root/.pycharm_helpers:rw decoy/deep-learning
