# portfolio-sample
Unfortunately the near entirety of my portfolio of work is owned by the previous companies I've worked for, so to showcase some of my experience I've created this sample repository using some of the skills and ideas from past projects. The main application is just a bare bones Django app, but the focus of this repo is mostly on the infrastructure I've created around it.

## Product Development Lifecycle Architecture
<img width="773" height="746" alt="Image" src="https://github.com/user-attachments/assets/01613ca6-db88-47de-9543-cf4018d6fb0c" />

## CI/CD Pipeline
### build.yml
This file creates a GitHub Action that builds our Docker image and pushes to a repository in Docker Hub from my personal namespace. (Secrets attached to this repository correspond with my personal login.) It checks out the repository, authenticates to the hub, then runs a `docker build` and pushes our image.

Right now, this action is triggered on pushes and pull requests to our main branch and uses a default main tag as well. If we were using this in our team development on the repository, we'd likely want something more sophisticated for our image tags--something like the short commit hash from git. I also find it helpful to be able to manually trigger GitHub Actions when I'm developing them, so I included the `workflow_dispatch` trigger here as well.

### pytest.yml
This is a separate GitHub Action run with the same triggers that runs a dummy test file I created and does linting and formatting with Ruff. I put our pytest run in a separate workflow from the build one to help developers more easily be able to identify issues with failing tests and flakiness they might come across. The `workflow_dispatch` trigger can be especially useful here to sanity-check a flaky test or runner issue without having to filter through a long list of jobs/steps if everything were included in the same workflow file.

This is where we would also implement code coverage, probably using something like pytest-cov. The updated workflow file would include the following snippet. Since there is no coverage on this example repository, I excluded pytest-cov because it just muddied up the GitHub Actions logs.

    - name: Test with pytestAdd commentMore actions
        run: |
          pip install pytest pytest-cov
          pytest tests.py --doctest-modules --cov=com --cov-report=xml --cov-report=html

### deploy.yml
This workflow is an example of a Kubernetes deployment to EKS. The kubernetes manifests in the `/kubernetes` directory are really boiler plate examples, and there is no actual configuration in ECS or EKS for a cluster. With more time and to make the pipeline more robust, I would configure out pipeline to deploy to a development environment on merges into our main branch. I also might create specific testing environments on a developer-by-developer need basis. 

## Developer Experience

### dev.sh
This helper script can be used by developers to interact with their local environment. 
Available commands:

 - up/down - uses our docker-compose to spin the application up or take it down; the application runs at http://localhost:8000 and can be seen from a web browswer
 - bash - access a shell from our container
 - manage - allows us to run django management commands
 - migrate - run database migrations locally
 - logs - access our logs from our application
 - lint - runs Ruff linting
 -  format - runs Ruff formating
 - test - runs Pytest tests


## Kubernetes
In addition to the docker-compose setup, I've created k8s manifests for both the deployment and service as well as a minikube guide for local development. More can be found in the `/kubernetes` directory.

## Software Release Channels
<img width="2150" height="380" alt="Image" src="https://github.com/user-attachments/assets/605c7266-b5d4-4ef9-8219-c2c94fb648ce" />

