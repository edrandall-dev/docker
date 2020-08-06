# Section A - Create docker images for webapps versions v1 and v2

**Build the v1 Image:**
```
make build
```
OR
```
/usr/local/bin/docker build -t gcr.io/coen-ed-randall/edr-website-nginx:v1 .
```
&nbsp;

**Change the src symlink (referenced in Dockerfile) to point to the v2 content before building that image**
```
unlink src
ln -s src-v2 src
```
&nbsp;

**Build the v1 Image:**
```
make build (need to edit scripts/build.sh first to change the version number on the tag)
```
OR
```
/usr/local/bin/docker build -t gcr.io/coen-ed-randall/edr-website-nginx:v2 .
```
&nbsp;

**Push the new images to the Google Container Registry:**
```
docker push gcr.io/coen-ed-randall/edr-website-nginx:v1
docker push gcr.io/coen-ed-randall/edr-website-nginx:v2
```
&nbsp;

**Check the images got uploaded to the GCR:**
```
gcloud container images list
gcloud container images describe gcr.io/coen-ed-randall/edr-website-nginx:v1
gcloud container images describe gcr.io/coen-ed-randall/edr-website-nginx:v2
```
&nbsp;
&nbsp;
&nbsp;
&nbsp;
# Section B - Upload v1 of the docker image webapp

**Set the project:**
```
gcloud config set project coen-ed-randall
```
&nbsp;

**Set the zone:**
```
gcloud config set compute/zone europe-west2
```
&nbsp;

**Create a VPC for the cluster:**
```
gcloud compute networks create edr-gke-vpc --subnet-mode=custom
```
&nbsp;

**Create a Subnet:**
```
gcloud compute networks subnets create edr-gke-vpc-subnet-london \
--network edr-gke-vpc \
--range=10.10.0.0/16 \
--region=europe-west2
```  
&nbsp;

**Double check VPC details:**
```
gcloud compute networks list
```
&nbsp;

**Double check subnet details:**
```
gcloud compute networks subnets list
```
&nbsp;

**Option 1: Create a 1 node cluster in europe-west2-a:**
```
gcloud container clusters create edr-test-cluster \
   --network edr-gke-vpc \
   --subnetwork edr-gke-vpc-subnet-london \
   --num-nodes=1 \
   --zone europe-west2-a
```
&nbsp;

**Option 2: Create 2 node cluster, with nodes in europe-west2-a and europe-west2-b:**
```
gcloud container clusters create edr-test-cluster \
    --network edr-gke-vpc \
    --subnetwork edr-gke-vpc-subnet-london \
    --num-nodes=1 \
    --node-locations europe-west2-a,europe-west2-b
```
&nbsp;

**Option 3: Create a 3 node cluster, with 1 node in each zone of the europe-west2 region:**
```
gcloud container clusters create edr-test-cluster \
    --network edr-gke-vpc \
        --subnetwork edr-gke-vpc-subnet-london \
        --num-nodes=1
```
&nbsp;

**Once created, list the cluster(s):**
```
gcloud container clusters list
```
&nbsp;

**Double check that images have been uploaded sucessfully to the GCR:**
```
gcloud container images list
```
&nbsp;

**Get credentials into kubectl config:**
```
gcloud container clusters get-credentials edr-test-cluster
```
&nbsp;

**Create a Kubernetes deployment for the docker image:**
```
kubectl create deployment edr-test-website --image=gcr.io/coen-ed-randall/edr-website-nginx:v1
```
&nbsp;

**Show Kubernetes pods:**
```
kubectl get pods
```
&nbsp;

**Expose the app to the internet:**
```
kubectl expose deployment edr-test-website \
    --name=edr-test-website-service \
    --type=LoadBalancer \
    --port 80 \
    --target-port 80
```
&nbsp;

**Set the baseline number of deployment replicas to 3:**
```
kubectl scale deployment edr-test-website --replicas=3
```
&nbsp;

**Show pods again to view the increase:**
```
kubectl get pods
```
&nbsp;

**Show details of the new service and the external IP (takes a minute or two for the external IP to show):**
```
kubectl get service
```
&nbsp;
_Browse to the EXTERNAL-IP of the service to see v1 of the application (blue)_
&nbsp;
&nbsp;
&nbsp;
&nbsp;
# Section C - Upgrade the webapp to a newer version

**Show the current kubernetes deployment:**
```
kubectl get deployments
```
&nbsp;

**Check what docker images have been uploaded to the GCR:**
```
gcloud container images list
```
&nbsp;

**Check what versions of that image are in the GCR:**
```
gcloud container images list-tags gcr.io/coen-ed-randall/edr-website-nginx
```
&nbsp;

**Apply a rolling update to the existing deployment with an image update:**
```
kubectl set image deployment/edr-test-website edr-website-nginx=gcr.io/coen-ed-randall/edr-website-nginx:v2
```
&nbsp;
_Finally, navigate to the external LB IP (find it with kubectl get service)_


