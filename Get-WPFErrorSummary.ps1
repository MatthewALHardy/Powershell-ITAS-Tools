$errorsummary = $(get-content C:\Users\MattHardy\Downloads\WPF.log.20251118.log | %{$_ -split '\[Session Start\]\s*' -split '\[Session End\]\s*'} | ?{$_ -match "^2025"}
get-content C:\Users\MattHardy\Downloads\WPF.log.20251119.log | %{$_ -split '\[Session Start\]' -split '\[Session End\]'} | ?{$_ -match "^2025"})

Foreach ($row in $errorsummary) {
    $split = $row -split "\s+"
    $date = $split[0]
    $time = $Split[1]
    $user = $Split[2]
    $ErrorLevel = $Split[4]
    $Source = $Split[5]
    $Message = ($row -replace '^(?:\S+\s+){6}', '')
    $Properties = [ordered]@{
        'date' = $date
        'time' = $time
        'user' = $user
        'ErrorLevel' = $ErrorLevel
        'Source' = $Source
        'Message' = $Message
    }
    New-Object -TypeName PSObject -Property $Properties
}
