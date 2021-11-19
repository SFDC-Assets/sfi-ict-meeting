# Create the demo org
sfdx shane:org:create -f config/project-scratch-def.json -d 1 -s --wait 60 --userprefix sfi -o hlsinsurance.demo

# Install Health Cloud
# sfdx force:package:install -w 30 --package "HealthCloud-Latest" 
# sfdx force:package:install -w 30 --package "HealthCloud-UnmanagedExtension"

# Install Vlocity Insurance
sfdx force:package:install -w 30 -r --package "VlocityIns-Latest"

# Push the metadata into the new scratch org.
sfdx force:source:push

# Set the default password.
sfdx shane:user:password:set -g User -l User -p salesforce1

# Set PermSets
# sfdx force:user:permset:assign -n HealthCloudPermissionSetLicense
# sfdx force:user:permset:assign -n HealthCloudAdmin
# sfdx force:user:permset:assign -n HealthCloudApi
# sfdx force:user:permset:assign -n HealthCloudFoundation
# sfdx force:user:permset:assign -n HealthCloudLimited
# sfdx force:user:permset:assign -n HealthCloudMemberServices
# sfdx force:user:permset:assign -n HealthCloudSocialDeterminants
# sfdx force:user:permset:assign -n HealthCloudStandard
# sfdx force:user:permset:assign -n HealthCloudUtilizationManagement
# sfdx force:apex:execute -f scripts/apex/enable-person-account-record-type.apex

# Open the org.
sfdx force:org:open

# Import the data required by the demo
# sfdx automig:load --inputdir ./data