################################################################################
# Get Sign-in Logs from Members for a specific Azure AD Group
# 11.01.2023 - Roman Kallen
################################################################################

$grpobjectid = Get-AzureADGroup -Filter "DisplayName eq 'Group Name'" | Select objectid -ExpandProperty ObjectID
$adminUsers = Get-AzureADGroupMember -ObjectId $grpobjectid
    
foreach ($adminUser in $adminUsers) 
    {
    $upn = $adminUser.UserPrincipalName
    write-host "Getting signin info for $upn" -ForegroundColor Blue
    Get-AzureADAuditSignInLogs -Filter "UserPrincipalName eq '$upn'" -Top 1 | select CreatedDateTime, UserPrincipalName, IsInteractive, AppDisplayName, IpAddress, TokenIssuerType
    }