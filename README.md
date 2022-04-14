# Create docker with Oracle db 11.2.0.4 on Oracle Linux 7 
# Reference on https://github.com/wscherphof/oracle-12c(wscherphof.tar)

#  In install file, there are 2 versions:
### Version 1: there are 5 steps. 
### Version 2: there are 4 steps. It has no step3

# VERSION 1
# Step1 (step1.sh)
  ### Create image that has:
  ### OS: Oracle Linux 7
  ### pre-install packages,pre-config for Oracle DB

# Step2 (step2.sh)
  ### Create container and install oracle software on container

# Step3 (step3.sh)
  ### Create instance db01

# Step4
  ### Config for connecting to instance db01
  
# Step 5
### create image from container.

# VERSION 2
# Step1 (step1_V2.sh)
  ### Create image that has:
  ### OS: Oracle Linux 7
  ### pre-install packages,pre-config for Oracle DB

# Step2 (step2_V2.sh)
  ### Create container, install oracle software and create instance of db.

# Step4
  ### Config for connecting to instance db01
  
# Step 5
### create image from container.
