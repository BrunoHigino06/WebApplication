information :
	@Echo Use make configure to configure the aws environment
	@Echo -------------------------------------------------------------------
	@Echo Use make plan to execute the terrafor plan command
	@Echo -------------------------------------------------------------------
	@Echo Use make apply to execute the terrafor apply command
	@Echo -------------------------------------------------------------------
	@Echo Use make destroy to execute the terrafor destroy command
	@Echo -------------------------------------------------------------------
configure:
	@Echo ---------Configuring AWS environment---------
	aws configure
plan:
	@Echo ---------Starting terraform plan command---------
	terraform init
	terraform plan
apply:
	@Echo ---------Starting terraform apply command---------
	terraform init
	terraform apply -target=module.network -auto-approve
	terraform apply -target=module.Golden_Image -auto-approve
	terraform apply -target=module.instances -auto-approve
	terraform output
destroy:
	@Echo ---------Starting terraform destroy command---------
	terraform init
	terraform destroy -auto-approve
	terraform apply -target=module.destroy_null_resources -compact-warnings -auto-approve