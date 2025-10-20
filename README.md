# devops-extended-demo

Extended DevOps demo: Node.js app → Docker → Trivy scan → Docker Hub → Deploy on EC2 via Jenkins.

## What is included
- Node.js sample app (app/server.js)
- Dockerfile
- docker-compose.yml (for local testing)
- trivy-scan.sh (vulnerability scanning)
- deploy.sh (EC2 deployment script with placeholder <EC2-IP>)
- Jenkinsfile (pipeline to build, scan, push, deploy)

## Quick start (local)
1. Build image:
   ```bash
   docker build -t devops-extended-demo:latest .
   ```
2. Run container:
   ```bash
   docker run -d -p 8080:8080 devops-extended-demo:latest
   ```
3. Open http://localhost:8080

## Jenkins setup
1. Create credentials in Jenkins:
   - **dockerhub-creds** (Username/Password)
   - **ec2-ssh-key** (SSH private key credential ID)
2. Update the repository URL in the Jenkinsfile to your GitHub repo.
3. Replace `<EC2-IP>` in `Jenkinsfile` and `deploy.sh` with your EC2 public IP.
4. Run the pipeline.

## Notes
- Trivy must be available on the Jenkins agent that runs the pipeline.
- Ensure your EC2 instance has Docker installed and the Jenkins-deployer has SSH access.
