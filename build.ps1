[CmdletBinding()]
param (
    [string] $ACR
)

$DEPLOYMENT_SOURCE = $PWD.Path
$ID = (New-Guid).ToString('N').Substring(20)

Write-Host "Creating the 'publish' folder tree"
Write-Host "Building project..."
nuget restore "$DEPLOYMENT_SOURCE\PartsUnlimited.sln"
msbuild "$DEPLOYMENT_SOURCE\src\PartsUnlimitedWebsite\PartsUnlimitedWebsite.csproj" /nologo /p:PublishProfile=FolderProfile.pubxml /p:DeployOnBuild=true

Write-Host "Building the Docker Container..."
Set-Location "$DEPLOYMENT_SOURCE\src\PartsUnlimitedWebsite\"
docker build -t $ACR/partsunlimited:$ID .
docker push $ACR/partsunlimited:$ID
Set-Location
