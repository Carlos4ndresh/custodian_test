# custodian_test
* The « policies » folder will be where the .yml files are located and could be looked for changes and triggering the validation and deployment/upgrade of new or existent policies. 

* The "terraform" folder contains all the terraform scripts necessary to create the resources that enable cloudcustodian policies to run as Lambda functions; 

* and finally a Dockerfile containing the Python+cloudcustodian installation that take the yaml files and validate and create the policies.

This instead of the official Custodian Docker imagebecause of the big size (500Mb+ vs 200Mb)

* The « entrypoint.sh » script will be the one that will use the container to validate and create the policies:


