
# Info
This repo is me learning terraform for a devops position.

## Your local dev environment
- [vscode]()
- [terraform]()
- [azure cli]()

as i understand hashicorp have some best practice to do Iac using terraform  

1. Create separate environments using `terraform workspaces`
2. Using `terraform modules` to write our infrastructure, instead of one big tf file
3. Save `terraform state object` on a `remote location`, like [azure storage]() or [hashicorp consul](), and **NOT** locally on your dev pc.
4. When writing module the recomanded file stracture is
   1. `variables.tf` file for ...
   2. `outputs.tf` file for ...
   3. `main.tf` file for ...
   4. `inputs.tf` file for ...
   5. `examples` folder with a basic example how to use the module
   6. `tests` folder basically the test folder will contain a `main.tf` file that execute the examle you created in the examples folder and do some validation on the results
   7. `ReadMe.md` file for ... 

# Terraform Task

## Prerequest
you need to have those tools installed
- terraform
- azure cli

you will also need to have an active subscription on microsoft azure  
- [Microsoft Azure](https://portal.azure.com/#home)

## Description
we need to create in azure a demo environment, in this environment we are going to have 2 regions and on every region we will have 

- 2 vms ( linux )
- 1 lb ( load balancer )

so in total we will have 
- 2 regions
- 4 vms ( linux )
- 2 lbs ( load balancer )
- 1 traffic manager

## Topology
```rb

  | Traffic Manager 
  |
  |--| Region 1  
  |  |
  |  |-- lb ( load balancer )  
  |      |  
  |      |-- Vm 1  ( linux virtual machine )
  |      |-- Vm 2  ( linux virtual machine )
  |
  |
  |--| Region 2  
     |
     |-- lb ( load balancer )  
         |  
         |-- Vm 1  ( linux virtual machine )
         |-- Vm 2  ( linux virtual machine )

```

## Building Blocks

The azure resources and the hashicorp terraform providers we need to complete this task

### Azure Load Balancer
- [Azure resource]()  
- [Terraform Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb#example-usage)

Configuration Parts
  1. FrontEnd Ip Configuration - private or public
  2. Backend Pools - group of vm ( server or client in out case linux vms )
  3. Health Probes - monitoring of backend pool health
  4. Rules - traffic distribution to backend pool
  5. Inbound NAT Rules - binding of specific IP:PORT to specific instance in the backend pool
  6. Outbound Rules - control outgoing traffic

Required Inputs
  1. name
  2. resource group name
  3. location

### Azure Traffic Manager
- [Azure resource]()  
- [Terraform Provider]()

### Azure VM
- [Azure resource]()  
- [Terraform Provider]()

### Azure Network
- [Azure resource]()  
- [Terraform Module](https://registry.terraform.io/modules/Azure/network/azurerm/latest)

### Azure Storage
- [Azure resource]()  
- [Terraform Provider]()
> We will use this to save our terraform state file remotly.
> It's best practice to save the state file on remote location like azure storage, hashcorp consul etc..., those places support state file locking and terraform workspaces 