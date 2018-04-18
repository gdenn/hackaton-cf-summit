 #!/bin/sh
#
# Called by CI/CD to update the cf deployment
# with the latest cell count configured at cf-deployment-config/cf-deployment/config.yml
#
bosh deploy -d cf cf-deployment/cf-deployment.yml \
  -o ops/scale-to-one-az.yml \
  -o ops/replace_diego_cell_count.yml \
  -o ops/rename-network.yml
  -l cf-deployment-config/cf-deployment/config.yml \
  -v network_name=default
