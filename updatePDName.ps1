Param(
    [Parameter(Mandatory)]
    [string]$userID,

    [Parameter(Mandatory)]
    [string]$userName,

    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)

$apiKey = Get-AutomationVariable -Name 'PAGERDUTY_API_KEY'
$url = "https://api.pagerduty.com/users/$userID"
$headers = @{
    'Authorization' = "Token token=$apiKey"
    'Accept' = 'application/vnd.pagerduty+json;version=2'
    'Content-Type' = 'application/json'
}
$body = @{
    user = @{
        name = $userName
    }
}
$body = $body | ConvertTo-Json

$user = Invoke-RestMethod -Uri $url -Method 'Put' -Headers $headers -Body $body
$user = $user.psobject.properties.value

Write-Output ($user.type, $user.id, $user.name, $user.status)