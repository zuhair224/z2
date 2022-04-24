

## List of containers used and a brief description thereof.

In this second assignment I used two containers my-python-app container which run my django application and a postgress container as database to persiste the application data

## List of Kubernetes objects and their brief description.

Here is the list of kubernetes object I used :

- Namespace: The namespace is used to organize objects in a Kubernetes cluster. It groups resources together and perform actions on those resources. One of the use cases can be the creation of different environments (staging and development) for the deployed application. For example, I can create a deployment called my-python-app with the staging namespace and deploy the same application in another namespace called production. While both deployments have the same name, there are no conflicts because of the difference in their namespaces

- Deployment: Deployment is used for managing the python application pods. The first thing a Deployment does when it’s created is to create a replicaset. Its can be used to scale the application by increasing the number of running pods, or update the running application.

- Service: Service is used to expose the deployed application using a single endpoint. i.e. It maps a fixed IP address to a logical group of pods.

- StatefulSet: StatefulSet is used to manage stateful applications with persistent storage. Storage stays associated with replacement pods. Volumes persist when pods are deleted. Like a Deployment, a StatefulSet manages Pods that are based on an identical container spec. Unlike a Deployment, a StatefulSet maintains a sticky identity for each of their Pods. Pods have fixed DNS names, unlike deployments. Pods are created from same specification, but not interchangeable.Each Pod has own storage.

- PersistentVolumeClaim: PVC is binding between a Pod and PV. Pod request the Volume through the PVC.PVC is the request to provision persistent storage with a specific type and configuration.PVCs describe the storage capacity and characteristics a pod requires, and the cluster attempts to match the request and provision the desired persistent volume.

- PersistentVolume: PV is a low level representation of a storage volume. It is an abstraction for the physical storage device that attached to the cluster. PV can be mounted into a pod through a PVC. The important thing is that the PV is independent of the lifecycle of the Pods. It means that data represented by a PV continue to exist as the cluster changes and as Pods are deleted and recreated.

i used this link to understand the meaning of them: https://medium.com/devops-mojo/kubernetes-objects-resources-overview-introduction-understanding-kubernetes-objects-24d7b47bb018

## Description of virtual networks and named volumes used by the application.

Network: I used two services to expose the containers outside the pods

- my-service: the application service of type cluster IP so the app can be reachable from the web.
- postgress-service: The database (statefulset) service so it can be reachable to my python application .

Volume: I used a persistent volume using the kubernetes host localfile as we do not have any NFS for this purpose. This persistent volume is mapped to the local `/mnt/pg` folder.

## A description of the container configuration you performed.

The most important part is the connection to database, as we used now an external database in other pod.
So for this we edit the application (settings.py file lines 75-85) to read the database hostname and credentials from the environement variable. These env variable will be injected in the `deployment.yml` file as the container env vars.

```py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get('POSTGRES_NAME'),
        'USER': os.environ.get('POSTGRES_USER'),
        'PASSWORD': os.environ.get('POSTGRES_PASSWORD'),
        'HOST': os.environ.get('POSTGRES_HOST'),
        'PORT': 5432,
    }
}
```

## Instructions on how to prepare, run, pause and delete the application.

### Prepare the app

To prepare the application you have to run the `prepare-app.sh` script. The script will build my python app, an manuel manipulation should be done to match the current infrastructure. As I tried this in my local machine with minikube my docker registey is not accessible from the kubernetes so in this case to share the image with kubernetes I shoud run the following command before running the script

```
eval $(minikube docker-env)
```

Now I can build my image and it will be accessible from my kubernetes instance.

### Run the app

To run the app you only have to run the `start-app.sh` script which will create the namespace and also all the required kubernetes object of the application.

### To stop the app (clean up)

The `stop-app.sh` script will remove the namespace and all the resources related to this namespace and it will remove the persistent volume we created in the run script.

## Instructions on how to view the application on the web.

To expose the application service outside the kubernetes we used the port-forwading to forward the service proxy localy .  
we run the `expose-app.sh` script and use `http://localhost:9000` to access the application from the browser
