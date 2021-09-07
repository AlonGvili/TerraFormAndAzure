function New-TFSAzStorage {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter()]
        [string]
        $Prefix = "dev",
        # Parameter help description
        [Parameter()]
        [string]
        $ResourceGroupName = "$($Prefix)-tfs-rg$(Get-Random -Minimum 12345 -Maximum 54321)",
        # Parameter help description
        [Parameter()]
        [string]
        $StorageAccountName = "$($Prefix)tfs$(Get-Random -Minimum 12345 -Maximum 54321)",
        # Parameter help description
        [Parameter()]
        [string]
        $ContainerName = "$($Prefix)tfs$(Get-Random -Minimum 12345 -Maximum 54321)",
        # Parameter help description
        [Parameter()]
        [ValidateSet("Standard_LRS", "Standard_ZRS", "Standard_GRS", "Standard_RAGRS", "Premium_LRS", "Premium_ZRS", "Standard_GZRS", "Standard_RAGZRS")]
        [string]
        $SkuName = "Standard_LRS",
        # Parameter help description
        [Parameter()]
        [string]
        $Location = "westeurope"
    )
    begin {
        $IsRGExists =Get-AzResourceGroup -ResourceGroupName  $ResourceGroupName -ErrorAction SilentlyContinue
    }
    
    process {
        if ($Null -eq $IsRGExists) {
            # Create resource group
            $ResourceGroup = New-AzResourceGroup -Name $ResourceGroupName -Location $Location
        }

        # Create storage account
        $StorageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -SkuName $SkuName -Location $Location -AllowBlobPublicAccess $true

        # Create blob container
        $StorageContainer = New-AzStorageContainer -Name $ContainerName -Context $StorageAccount.context -Permission blob   
    }
    end {
        $ACCOUNT_KEY = (Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName -Name $StorageAccountName)[0].value
        $env:ARM_ACCESS_KEY = $ACCOUNT_KEY

        $Results = [PSCustomObject][ordered]@{
            StorageAccount = $StorageAccount
            StorageContainer = $StorageContainer
            StorageAccessKey = 'You can get the accesskey using this environment variable $env:ARM_ACCESS_KEY'
        }

        Write-Output $Results
    }
}