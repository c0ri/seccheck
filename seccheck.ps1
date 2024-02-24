# -- Seccheck.ps1
# -- Script to help you search for eventIDs in your Windows Event Viewer to help find intrusion attempts.
# --

# -- Specify the target Event IDs
$targetEventIDs = 4624, 4634, 4672, 4719, 4720, 4722, 4724, 4728, 4732, 4738, 4756, 4648, 4688, 4740, 4768, 1102

# -- Retrieve events from the Security log
$events = Get-WinEvent -FilterHashTable @{ LogName = 'Security'; Id = $targetEventIDs } | Select-Object TimeCreated, Id, Message | Sort-Object TimeCreated -Descending

# -- Group events by Event ID and display the top 5 for each
foreach ($eventID in $targetEventIDs) {
    Write-Host "Events for Event ID $($eventID):"
    $eventsForID = $events | Where-Object { $_.Id -eq $eventID } | Select-Object -First 5
    $eventsForID | Format-Table -AutoSize
    Write-Host
}
