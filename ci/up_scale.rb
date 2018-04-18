#!/usr/bin/env ruby
#
# Parse current diego cell count from config file
# and increase the number by UP_SCALE_STEP_SIZE.
#
system("git clone cf-deployment-config config-output")

config = YAML.load_file(cf-deployment-config/cf-deployment/config.yml)
cell_count = config["diego"]["cells"]
cell_count =+ ENV["UP_SCALE_STEP_SIZE"]
config["diego"]["cells"] = cell_count

File.open('config-output/cf-deployment/config.yml', 'w') {|f| f.write config.to_yaml }

Dir.chdir("config-output") do
  system("git config --global user.name #{ENV["CONCOURSE_USERNAME"]}")
  system("git config --global user.email #{ENV["CONCOURSE_EMAIL"]}")
  system("git add cf-deployment/config.yml")
  system("git commit -m 'Upscale diego cells by #{ENV["UP_SCALE_STEP_SIZE"]}'")
end
