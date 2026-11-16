# Recebe o log do RetroArch do Wii U pela rede (UDP 4405) e salva em
# wiiu-dev\udp-log.txt, mostrando também na tela. Ctrl+C para parar.
$port = 4405
$out  = Join-Path $PSScriptRoot "udp-log.txt"
"--- inicio $(Get-Date -Format s) ---" | Out-File -Encoding utf8 $out
$udp = New-Object System.Net.Sockets.UdpClient
$udp.Client.SetSocketOption([System.Net.Sockets.SocketOptionLevel]::Socket,
    [System.Net.Sockets.SocketOptionName]::ReuseAddress, $true)
$udp.Client.Bind((New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any, $port)))
$ep = New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any, 0)
Write-Host "Escutando UDP $port... (Ctrl+C para parar)"
try {
    while ($true) {
        $bytes = $udp.Receive([ref]$ep)
        $text  = [System.Text.Encoding]::UTF8.GetString($bytes)
        Write-Host -NoNewline $text
        [System.IO.File]::AppendAllText($out, $text)
    }
} finally {
    $udp.Close()
}
