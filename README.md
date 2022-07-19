# set/rm_dynamic_firewall_for_ADO_agent
This project includes two powershell modules that can be used in an Azure devops pipeline to open and close firewall rules for a devops deployment agent. A relevant usecase for this is if you want to do operations on a sql database that is vNet integrated and only privately available.

Accessing such a sql db is not possible out of the box with ADO deployment pipelines since the agent has a public ip.

The "Set-dynamic_firewall.ps1" module gets the ip adress of a agent at runtime via the Invoke-RestMethod http://ipinfo.io/json method, then a ip range is generated with regex based on the output.

This ip range is set as a pipeline env variable which is used to open a temporary firewall rule/entry. This same entry is then removed again once the database deployment is completed.

The intended use of the modules is to have them as a .yml task/stage before and after an intermediate step that e.g. deploys contained db users/roles or even a entire dacpac deployment.
