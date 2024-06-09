#!/bin/bash
docker build -t ansible-arch .
docker run -it --rm ansible-arch bash
