$ErrorActionPreference = "Stop"

if (-not (Test-Path "images")) {
    New-Item -ItemType Directory -Path "images" | Out-Null
}

$map = @(
    @{ file = "ball_adidas_finale.jpg";        url = "https://source.unsplash.com/1200x900/?soccer,ball" },
    @{ file = "boots_nike_mercurial.jpg";      url = "https://source.unsplash.com/1200x900/?soccer,cleats" },
    @{ file = "shin_pads_puma.jpg";            url = "https://source.unsplash.com/1200x900/?soccer,shin-guards" },
    @{ file = "kit_football.jpg";              url = "https://source.unsplash.com/1200x900/?football,jersey" },
    @{ file = "dumbbells_10kg.jpg";            url = "https://source.unsplash.com/1200x900/?dumbbells,fitness" },
    @{ file = "yoga_mat_6mm.jpg";              url = "https://source.unsplash.com/1200x900/?yoga,mat" },
    @{ file = "resistance_bands_set.jpg";      url = "https://source.unsplash.com/1200x900/?resistance,bands" },
    @{ file = "speed_rope.jpg";                url = "https://source.unsplash.com/1200x900/?jump,rope" },
    @{ file = "asics_gel.jpg";                 url = "https://source.unsplash.com/1200x900/?running,shoes" },
    @{ file = "running_tshirt.jpg";            url = "https://source.unsplash.com/1200x900/?running,shirt" },
    @{ file = "running_shorts.jpg";            url = "https://source.unsplash.com/1200x900/?running,shorts" },
    @{ file = "running_belt.jpg";              url = "https://source.unsplash.com/1200x900/?running,belt" },
    @{ file = "treadmill_home.jpg";            url = "https://source.unsplash.com/1200x900/?treadmill" },
    @{ file = "bike_trainer.jpg";              url = "https://source.unsplash.com/1200x900/?exercise,bike" },
    @{ file = "bench_press.jpg";               url = "https://source.unsplash.com/1200x900/?weight,bench" },
    @{ file = "pullup_bar.jpg";                url = "https://source.unsplash.com/1200x900/?pullup,bar" },
    @{ file = "alpine_skis.jpg";               url = "https://source.unsplash.com/1200x900/?alpine,skis" },
    @{ file = "snowboard_allmountain.jpg";     url = "https://source.unsplash.com/1200x900/?snowboard" },
    @{ file = "ski_helmet.jpg";                url = "https://source.unsplash.com/1200x900/?ski,helmet" },
    @{ file = "ski_goggles.jpg";               url = "https://source.unsplash.com/1200x900/?ski,goggles" }
)

foreach ($item in $map) {
    $out = Join-Path "images" $item.file
    if (Test-Path $out) {
        Write-Host ("OK exists: " + $item.file)
        continue
    }

    Write-Host ("DOWN: " + $item.file)
    try {
        Invoke-WebRequest -Uri $item.url -OutFile $out -MaximumRedirection 5 -TimeoutSec 45
        Start-Sleep -Milliseconds 200
    }
    catch {
        Write-Host ("FAIL: " + $item.file + " :: " + $_.Exception.Message)
    }
}

Write-Host ""
Write-Host "Downloaded files:"
Get-ChildItem "images" | Sort-Object Name | Select-Object Name, Length

