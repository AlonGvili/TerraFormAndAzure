## Module to create linux virtual machine in azure


> **```This module is part of a larger terraform module to create full Infrastructure as code ( Iac ) in microsoft azure```**

#### What it will create ?

- 2 linux vm's base on ubuntu server 18.04 edition
- 1 availability set

#### Extra
this module will download and install ***`apache2`*** on each vm using ***`azurerm_virtual_machine_extension`*** of type ***`CustomScript`*** 

#### Dependencies
**Network**
This module depends on the [network module](../network/ReadMe.md) for associate the vm's with the correct ***```virtual_network_interface```*** 

#### Inputs
|Parameter|Default|Description|Type|validation|
|-|-|-|-|-|
virtual_machine_count|2|How mutch virtual machine do you want to create|number||
admin_username|vmadmin|The local virtual machine admin user name, you cn find more info in [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/faq#what-are-the-username-requirements-when-creating-a-vm-)|string||
admin_password|P@ssword1|The local virtual machine admin password, you can find more info in [here](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/faq#what-are-the-password-requirements-when-creating-a-vm-)|string|**yes**|
prefix| |The prefix which should be used for all the load balancer resources|string||
location| |Specifies the supported Azure Region where the Load Balancer should be created|string||
resource_group_name| |The resource group name when all the resources for this load balancer will be created|string||

#### Outputs

name|resource|
|-|-|
availability_set_id|azurerm_availability_set.avset.id
network_interface_ids|azurerm_linux_virtual_machine.linux_vm.network_interface_ids
private_ip_address|azurerm_linux_virtual_machine.linux_vm.private_ip_address
public_ip_address|azurerm_linux_virtual_machine.linux_vm.public_ip_address


