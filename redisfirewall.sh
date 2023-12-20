rgname=$2
name=$4
echo "Resource group is $rgname"
echo "Resource name is $name"

firewallrulename=$(az redis firewall-rules list --name $name --resource-group $rgname --query "[].name" -o tsv)

if [ -z $firewallrulename ]; then

    az redis update --name $name --resource-group $rgname --set "publicNetworkAccess=Disabled"
  
    echo "Public network access disabled for $name Azure Cache for Redis. because firewall rule having any to any or firewall rule does not exists"

else
   
     echo "Firewall rule already exists for $name which is $firewallrulename No action needed."

fi
