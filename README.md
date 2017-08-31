# Deployments Demo via GitLab (Matrix Builds)

Project relies on docker and docker-compose installed on your system.

## 3, 2, 1, Go!

Start the environment

`docker-compose up -p matrixtest -d && docker-compose scale integration=2 production=3`

Identify gitlab-ce docker container ip with:

`docker inspect matrixtest_gitlab-ce_1 | grep IPAddress`

Note: If you use docker-machine use the IP of the docker vm.

Add running matrixtest_gitlab-ce_1 container-ip to your machines hosts file. For example:

`echo "172.19.0.2 gitlab-ce" >> /etc/hosts`

Browse to your gitlab-ce installation via [gitlab-ce:17777](http://gitlab-ce:17777/) and:

- change initial password
- create a new project
- Get into Settings - Pipeline and note Runner registration token.

Register runners...

```
REGTOKEN=[ENTER-REG-TOKEN-HERE]

./regrunner.sh $REGTOKEN matrixtest_integration_1 integration1
./regrunner.sh $REGTOKEN matrixtest_integration_1 integration1
./regrunner.sh $REGTOKEN matrixtest_integration_2 integration2
./regrunner.sh $REGTOKEN matrixtest_production_1 production1
./regrunner.sh $REGTOKEN matrixtest_production_2 production2
./regrunner.sh $REGTOKEN matrixtest_production_3 production3
```

Create new File `.gitlab-ci.yml` with the contents of the one from this repo and commit.

Browse your started Pipeline and wait for the magic to happen...

[http://gitlab-ce:17777/root/matrixtest/pipelines/1](http://gitlab-ce:17777/root/matrixtest/pipelines/1)

Also check out Environments Deploy Board:

[http://gitlab-ce:17777/root/matrixtest/environments](http://gitlab-ce:17777/root/matrixtest/environments)
