# Create the demo org
sfdx shane:org:create -f config/project-scratch-def.json -d 1 -s --wait 60 --userprefix sfi -o hlsinsurance.demo

############################
### Health Cloud Package ###
############################
hcStartTime=$SECONDS

# Install Health Cloud
sfdx force:package:install -w 45 --package "HealthCloud-Latest" 
# sfdx force:package:install -w 30 --package "HealthCloud-UnmanagedExtension"

hcElapsedTime=$(( SECONDS - hcStartTime ))
hcInstallTime=$(date -u -r $hcElapsedTime +'%T')
echo "Health Cloud install time ${hcInstallTime}"
############################
### Health Cloud Package ###
############################

#################################
### Vlocity Insurance Package ###
#################################
viStartTime=$SECONDS

# Install Vlocity Insurance
sfdx force:package:install -w 45 -r --package "VlocityIns-Latest"

viElapsedTime=$(( SECONDS - viStartTime ))
viInstallTime=$(date -u -r $viElapsedTime +'%T')
echo "Vlocity Insurance install time ${viInstallTime}"
#################################
### Vlocity Insurance Package ###
#################################

# Push the metadata into the new scratch org.
sfdx force:source:push

# Set the default password.
sfdx shane:user:password:set -g User -l User -p salesforce1

# Set PermSets

## Health Cloud PermSets
sfdx force:user:permset:assign -n HealthCloudPermissionSetLicense
sfdx force:user:permset:assign -n HealthCloudAdmin
sfdx force:user:permset:assign -n HealthCloudApi
sfdx force:user:permset:assign -n HealthCloudFoundation
sfdx force:user:permset:assign -n HealthCloudLimited
sfdx force:user:permset:assign -n HealthCloudMemberServices
sfdx force:user:permset:assign -n HealthCloudSocialDeterminants
sfdx force:user:permset:assign -n HealthCloudStandard
sfdx force:user:permset:assign -n HealthCloudUtilizationManagement

## ICT Meetings specific
sfdx force:user:permset:assign -n ICT_Meetings

# Prep work
sfdx force:apex:execute -f scripts/apex/enable-person-account-record-type.apex

# Open the org.
sfdx force:org:open

# Import the data required by the demo
# sfdx automig:load --inputdir ./data