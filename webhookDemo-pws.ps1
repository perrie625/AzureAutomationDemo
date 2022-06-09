param
(
    [Parameter(Mandatory=$false)]
    [object] $WebhookData
)

write-output "start"
write-output ("object type: {0}" -f $WebhookData.gettype())
write-output $WebhookData
#write-warning (Test-Json -Json $WebhookData)
$Payload = @{}
foreach( $property in $WebhookData.psobject.properties.name )
{
    $Payload[$property] = $WebhookData.$property
}
write-output "`n`n"
write-output $Payload.WebhookName
write-output $Payload.RequestBody
write-output $Payload.RequestHeader
write-output "end"

if ($Payload.RequestBody) { 
    $names = (ConvertFrom-Json -InputObject $Payload.RequestBody)

        foreach ($x in $names)
        {
            $name = $x.Name
            Write-Output "Hello $name"
        }
}
else {
    Write-Output "Hello World!"
}