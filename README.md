## What is this
This pushes an image to AWS ECR that is used in the ECS cluster service task.
The task definition uses the server-core container and this container (nginx) as a reverse proxy to the server-core.

This also sets up SSL for server-core's domain api.lecca.io

If you ever need to spin up a new ec2 instance, we would need to follow the steps below.
Warning, this is not setup to scale. So if we ever do load balancing stuff, we'll need to make the following
steps dynamic and work with multiple ip addresses.

Installing certs
1. SSH into the ec2 instance
2. run `docker ps` to get a list of the docker images. Grab the docker id for the nginx one (this one).
3. run `docker exec -it NGINX_DOCKER_ID "/bin/sh"` to run commands inside the docker container
4. run `apk add --no-cache certbot-nginx` to install certbot.
5. run `certbot --nginx -d api.lecca.io --agree-tos -m admin@lecca.io` and follow their steps.
6. After you run those commands it will generate Let's Encrypt data at /etc/letsencrypt, this will be saved in the volume defined in the task definition. Don't need to do anything on this step.
7. The certbot command will have updated your /etc/nginx/nginx.conf. Copy that file and replace the nginx.conf file in this repo with the new one that was generated.
8. Push this to main and merge to prod to get the docker image created and pushed to ECR. It will be tagged as latest so when you push the server-core repo to main it will run the ecs task with  