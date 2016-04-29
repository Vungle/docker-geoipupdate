# Maxmind Geo IP update Docker image

The container can be run as a daemon; to run the container as a DaemonSet in
Kubernetes, make sure the required volumes exists on in Kubernetes cluster and
run:

    kubectl create -f daemonset.yaml

You can alternatively update the configuration in the `daemonset.yaml` for your
project and deploy to Kubernetes. Essentially, you just need to make sure that
there is a Maxmind configuration file at `/etc/conf/maxmind.conf` mounted to the
container. The configuration file should have the following format:

    UserId your_id
    LicenseKey your_key
    ProductIds GeoIP2-Country GeoIP2-City 106 132 <other> <other>
