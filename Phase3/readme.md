# Taskflow API — CI/CD DevOps Project

This project is a containerized FastAPI application built as part of my DevOps learning journey.

Over the course of this phase, I moved from manually deploying Docker containers on a VM to building a fully automated CI/CD pipeline using GitHub Actions, Docker Hub, and Google Cloud Run.

## Tech Stack

- FastAPI
- Docker
- GitHub Actions
- Docker Hub
- Google Cloud Run
- Pytest
- Flake8

---

## Features

- Automated testing with GitHub Actions
- Docker image build and push automation
- Docker image tagging with commit SHA and `latest`
- Automated deployment to Google Cloud Run
- Health checks after deployment
- Automatic rollback on failed deployments

---

## CI/CD Workflow

```text
Push code
↓
Run lint checks and tests
↓
Build Docker image
↓
Push image to Docker Hub
↓
Deploy to Cloud Run
↓
Run health checks
↓
Rollback automatically if deployment fails
```

---

## Run Locally

### Install dependencies

```bash
pip install -r requirements.txt
```

### Start the app

```bash
uvicorn app.main:app --reload
```

---

## Run with Docker

### Build image

```bash
docker build -t taskflow-api .
```

### Run container

```bash
docker run -p 8000:8000 taskflow-api
```

---

## Blog Post

I documented the full process, deployment issues, debugging steps, and lessons learned during this phase here:

[From Manual Docker Deployments to an Automated CI/CD Pipeline](https://medium.com/@oyawoledamilola01/118c28edc8e5)

---

## Author

Oluwadamilola Oyawole