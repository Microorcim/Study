$ErrorActionPreference = "Stop"

if (-not (Test-Path "images")) {
    New-Item -ItemType Directory -Path "images" | Out-Null
}

# Direct upload.wikimedia.org links (stable, no HTML parsing).
# Используем thumbnails, чтобы не скачивать гигантские файлы и реже ловить лимиты.
$map = @(
    @{ file = "ball_adidas_finale.jpg";    url = "https://upload.wikimedia.org/wikipedia/commons/1/1f/Nike_soccer_ball.jpg" },
    @{ file = "boots_nike_mercurial.jpg";  url = "https://upload.wikimedia.org/wikipedia/commons/9/92/Adidas_Copa_Mundial.jpg" },
    @{ file = "dumbbells_10kg.jpg";        url = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Dumbbell.JPG/1280px-Dumbbell.JPG" },
    @{ file = "treadmill_home.jpg";        url = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Nordic_walking_on_treadmill.jpg/960px-Nordic_walking_on_treadmill.jpg" },
    @{ file = "snowboard_allmountain.jpg"; url = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Gravity_Snowboard.jpg/960px-Gravity_Snowboard.jpg" },
    @{ file = "ski_helmet.jpg";            url = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/POC_Helmet_Green.jpg/960px-POC_Helmet_Green.jpg" },
    @{ file = "resistance_bands_set.jpg";  url = "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Rubber_bands_2016.jpg/960px-Rubber_bands_2016.jpg" },
    @{ file = "speed_rope.jpg";            url = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/SpeedRope.jpg/960px-SpeedRope.jpg" },
    @{ file = "kit_football.jpg";          url = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Puma_Cameroon_national_football_team_home_jersey.JPG/960px-Puma_Cameroon_national_football_team_home_jersey.JPG" },
    @{ file = "bike_trainer.jpg";          url = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Magnetic_resistance_stationary_bicycle_exercise_bike.JPG/960px-Magnetic_resistance_stationary_bicycle_exercise_bike.JPG" },
    @{ file = "alpine_skis.jpg";           url = "https://upload.wikimedia.org/wikipedia/commons/7/77/Skis_carving_race_cross_slalom_03.jpg" },
    @{ file = "ski_goggles.jpg";           url = "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/CanadianSnowGoggles.JPG/960px-CanadianSnowGoggles.JPG" },
    @{ file = "yoga_mat_6mm.jpg";          url = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Ardha_Matsyendrasana_-_Half_Lord_of_the_Fishes_Pose.jpg/960px-Ardha_Matsyendrasana_-_Half_Lord_of_the_Fishes_Pose.jpg" },
    @{ file = "bench_press.jpg";           url = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Inclined_sit-up_and_hyperextension_bench.jpg/960px-Inclined_sit-up_and_hyperextension_bench.jpg" },
    @{ file = "running_belt.jpg";          url = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Red_Fanny_Pack.jpg/960px-Red_Fanny_Pack.jpg" }
)

foreach ($item in $map) {
    $out = Join-Path "images" $item.file
    # Не трогаем выбранные пользователем 5 позиций
    $doNotTouch = @("alpine_skis.jpg","snowboard_allmountain.jpg","ski_helmet.jpg","bench_press.jpg","treadmill_home.jpg")
    if ($doNotTouch -contains $item.file) {
        Write-Host ("SKIP (do not touch): " + $item.file)
        continue
    }

    # Перекачиваем только те, что хотим улучшить
    if (Test-Path $out) { Remove-Item -Force $out }

    Write-Host ("DOWN: " + $item.file)
    $attempt = 0
    $sleepSec = 2
    while ($true) {
        $attempt++
        try {
            Invoke-WebRequest -Uri $item.url -OutFile $out -TimeoutSec 60 -Headers @{ "User-Agent" = "SportStore-StudentProject/1.0 (PowerShell)" }
            break
        } catch {
            $msg = $_.Exception.Message
            Write-Host ("WARN: " + $item.file + " attempt " + $attempt + " :: " + $msg)
            if ($attempt -ge 5) { throw }
            Start-Sleep -Seconds $sleepSec
            $sleepSec = [Math]::Min(30, $sleepSec * 2)
        }
    }
    Start-Sleep -Seconds 2
}

Write-Host ""
Write-Host "Downloaded files:"
Get-ChildItem "images" | Sort-Object Name | Select-Object Name, Length

