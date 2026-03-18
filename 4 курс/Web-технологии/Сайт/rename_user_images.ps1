$ErrorActionPreference = "Stop"

function Rename-FirstMatch([string]$pattern, [string]$targetName) {
    $match = Get-ChildItem "images" | Where-Object { $_.Name -like $pattern } | Select-Object -First 1
    if (-not $match) {
        Write-Host ("NOT FOUND: " + $pattern)
        return $false
    }
    $dest = Join-Path "images" $targetName
    if (Test-Path $dest) {
        Write-Host ("EXISTS, skip rename: " + $targetName)
        return $true
    }
    Rename-Item -Path $match.FullName -NewName $targetName -Force
    Write-Host ("RENAMED: " + $match.Name + " -> " + $targetName)
    return $true
}

# 1) Asics Gel
Rename-FirstMatch "*Asics*" "asics_gel.jpg" | Out-Null

# 2-3) Футболка и шорты: из-за кодировки имён в PowerShell надёжнее
# взять "лишние" .jpg файлы и переименовать их в ожидаемые имена.
$known = @(
    "alpine_skis.jpg","asics_gel.jpg","ball_adidas_finale.jpg","bench_press.jpg","bike_trainer.jpg",
    "boots_nike_mercurial.jpg","dumbbells_10kg.jpg","kit_football.jpg","resistance_bands_set.jpg",
    "running_belt.jpg","running_shorts.jpg","running_tshirt.jpg","ski_goggles.jpg","ski_helmet.jpg",
    "snowboard_allmountain.jpg","speed_rope.jpg","treadmill_home.jpg","yoga_mat_6mm.jpg"
)

$candidates = Get-ChildItem "images" -File |
    Where-Object { $_.Extension -match '\.jpe?g' } |
    Where-Object { $known -notcontains $_.Name } |
    Sort-Object Length -Descending

if (-not (Test-Path (Join-Path "images" "running_tshirt.jpg"))) {
    $tshirt = $candidates | Select-Object -First 1
    if ($tshirt) {
        Rename-Item -Path $tshirt.FullName -NewName "running_tshirt.jpg" -Force
        Write-Host ("RENAMED (auto): " + $tshirt.Name + " -> running_tshirt.jpg")
        $candidates = $candidates | Where-Object { $_.FullName -ne $tshirt.FullName }
    }
}

if (-not (Test-Path (Join-Path "images" "running_shorts.jpg"))) {
    $shorts = $candidates | Select-Object -First 1
    if ($shorts) {
        Rename-Item -Path $shorts.FullName -NewName "running_shorts.jpg" -Force
        Write-Host ("RENAMED (auto): " + $shorts.Name + " -> running_shorts.jpg")
    }
}

Write-Host ""
Write-Host "Current images:"
Get-ChildItem "images" | Sort-Object Name | Select-Object Name, Length

