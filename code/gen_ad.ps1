param([Parameter(Mandatory=$true)] $JSON_File) 

function CreateADGroup() {
    param([Parameter(Mandatory=$true)] $groupObject)

    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
}

function CreateADUser() {
    param([Parameter(Mandatory=$true)] $userObject)
    
    # pulls out the name from json
    $name = $userObject.name
    $password = $userObject.password

    # creates name based on first initial and last
    $first, $last = name.split(" ")
    $username = ($first[0] + $last).ToLower()
    $samAccountName = $username
    $principalname = $username
    
    # actually creates the ad user
    New-ADUser -Name "$name" -GivenName $first -Surname $last -SamAccountName $samAccountName -UserPrincipalName $principalname@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount

    #adds users to groups
    foreach($group_name in $userObject.groups) {
        try {
            Get-ADGroup -Identity "$group_name"
            Add-ADGroupMember -Identity $group_name -Members $username
        }
        catch [Microsoft.ActiveDirectory.Management.ADidentityNotFoundException]
        {
            Write-Warning "$group_name does not exist"
        }
    }
}

$json = (Get-Content $JSON_File | ConvertFrom-Json)

$Global:Domain = $json.domain

foreach ($group in $json.groups) { 
    CreateADGroup $group
}

foreach ( $user in $json.users ){
    CreateADUser $user
}