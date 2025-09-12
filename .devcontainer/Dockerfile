FROM mcr.microsoft.com/devcontainers/java:17
# 필요한 CLI(gnu make 등) 추가
RUN apt-get update && apt-get install -y make && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace