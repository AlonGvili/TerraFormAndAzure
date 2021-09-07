function New-TerraformModule {
    [CmdletBinding()]
    param (
       # Module Name
       [Parameter(Mandatory)]
       [string]
       $Name,
       # Module Path
       [Parameter(Mandatory)]
       [string]
       $Path 
    )
    begin {
        $Files = "outputs.tf","variables.tf","main.tf", "ReadMe.md"
    }
    process {
        if(Test-Path -Path (Join-Path -Path $Path -ChildPath $Name)){
            Write-Error -Message "Folder already exists"
        }
        else {
            $ModuleFolder = New-Item -Path $Path -Name $Name -ItemType Directory -Force
            $Files | ForEach-Object {  New-Item -Path $ModuleFolder -Name $_ -ItemType File -Force }   
        }
    }
}