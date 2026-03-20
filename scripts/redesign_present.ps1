param(
    [string]$RootPath = "C:\Users\Nano\Desktop\Study",
    [string]$FileName = "Present.pptx"
)

$ErrorActionPreference = "Stop"

function Find-TargetPresentation {
    param(
        [string]$Root,
        [string]$Name
    )

    $matches = @(Get-ChildItem -Path $Root -Recurse -Filter $Name -File -ErrorAction SilentlyContinue)
    if ($matches.Count -gt 0) {
        return $matches | Select-Object -First 1
    }

    $fallback = Get-ChildItem -Path $Root -Recurse -Filter *.pptx -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -like "*$Name*" } |
        Sort-Object FullName |
        Select-Object -First 1

    return $fallback
}

function Set-SlideBackground {
    param(
        [object]$Slide,
        [int]$RgbLong
    )

    $Slide.FollowMasterBackground = $false
    $Slide.Background.Fill.Solid()
    $Slide.Background.Fill.ForeColor.RGB = $RgbLong
}

function RGB-Long {
    param(
        [int]$R,
        [int]$G,
        [int]$B
    )
    # Office RGB value is stored as 0x00BBGGRR
    return ($R + ($G * 256) + ($B * 65536))
}

function Add-Textbox {
    param(
        [object]$Slide,
        [double]$X,
        [double]$Y,
        [double]$W,
        [double]$H,
        [string]$Text,
        [float]$FontSize,
        [bool]$Bold,
        [int]$FontRgb,
        [int]$Alignment
    )

    # 1 = msoTextOrientationHorizontal
    $shape = $Slide.Shapes.AddTextbox(1, $X, $Y, $W, $H)
    $shape.TextFrame.WordWrap = $true

    $range = $shape.TextFrame.TextRange
    $range.Text = $Text

    $range.Font.Size = $FontSize
    $range.Font.Bold = $Bold
    $range.Font.Name = "Calibri"
    $range.Font.Color.RGB = $FontRgb

    $range.ParagraphFormat.Alignment = $Alignment
    return $shape
}

function Clear-SlideShapes {
    param([object]$Slide)
    for ($i = $Slide.Shapes.Count; $i -ge 1; $i--) {
        $Slide.Shapes.Item($i).Delete()
    }
}

$lf = [char]10

$target = Find-TargetPresentation -Root $RootPath -Name $FileName
if (-not $target) {
    throw "Не нашел презентацию '$FileName' в '$RootPath'. Проверьте имя файла."
}
$pptPath = $target.FullName

$app = New-Object -ComObject PowerPoint.Application
$app.Visible = [Microsoft.Office.Core.MsoTriState]::msoTrue

$pres = $app.Presentations.Open(
    $pptPath,
    [Microsoft.Office.Core.MsoTriState]::msoFalse,
    [Microsoft.Office.Core.MsoTriState]::msoFalse,
    [Microsoft.Office.Core.MsoTriState]::msoFalse
)

$sw = [double]$pres.PageSetup.SlideWidth
$sh = [double]$pres.PageSetup.SlideHeight

$bgRgb = RGB-Long -R 245 -G 247 -B 250
$headerRgb = RGB-Long -R 11 -G 45 -B 77
$titleRgb = $bgRgb # not used
$bodyRgb = RGB-Long -R 26 -G 26 -B 26
$whiteRgb = RGB-Long -R 255 -G 255 -B 255
$accentRgb = RGB-Long -R 31 -G 111 -B 235

$left = $sw * 0.07
$right = $sw * 0.07
$contentW = $sw - $left - $right

$headerY = $sh * 0.03
$headerH = $sh * 0.14
$bodyY = $headerY + $headerH + $sh * 0.03
$bodyH = $sh - $bodyY - $sh * 0.06

function Add-HeaderBar {
    param(
        [object]$Slide,
        [double]$X,
        [double]$Y,
        [double]$W,
        [double]$H,
        [int]$RgbLong
    )
    # 1 = rectangle
    $bar = $Slide.Shapes.AddShape(1, $X, $Y, $W, $H)
    $bar.Fill.ForeColor.RGB = $RgbLong
    $bar.Line.Visible = $false
}

# Slide content (11 slides)
$slides = @(
    @{ Title = "Правовая защита ИС"; Body = ("35. Формула изобретения" + $lf + "36. Служебное изобретение") },
    @{ Title = "35. Формула изобретения"; Body = ("1) Определяет объем правовой охраны" + $lf + "по патенту." + $lf + $lf + "2) Охрана предоставляется" + $lf + "в пределах признаков формулы." ) },
    @{ Title = "Структура формулы"; Body = ("Обычно включает:" + $lf +
        "- независимые пункты (ключевые признаки)" + $lf +
        "- зависимые пункты (уточняют варианты)" + $lf + $lf +
        "Логика формулирования: ограничительная" + $lf +
        "и отличительная части.") },
    @{ Title = "Ограничительная и отличительная части"; Body = ("Ограничительная часть:" + $lf +
        "- признаки, общие с ближайшим аналогом (прототипом)" + $lf + $lf +
        "Отличительная часть:" + $lf +
        "- признаки, которые создают новизну" + $lf +
        "и/или изобретательский уровень." ) },
    @{ Title = "Пример (упрощенно)"; Body = ("Способ ...," + $lf +
        "включающий ... (ограничительные признаки)." + $lf + $lf +
        "Отличающийся тем, что ... (отличительные признаки)." + $lf + $lf +
        "Зависимый пункт: способ по п. 1," + $lf +
        "где ... (частный вариант)." ) },
    @{ Title = "Влияние точности формулы"; Body = ("Если признак не включен в формулу," + $lf +
        "как правило, он не защищается патентом." + $lf + $lf +
        "Слишком широкая формула:" + $lf +
        "- риск оспаривания/недействительности." + $lf +
        "Слишком узкая формула:" + $lf +
        "- слабая защита при обходе решения.") },
    @{ Title = "Типичные ошибки"; Body = ("1) Размытые формулировки" + $lf +
        "(без измеримых признаков)." + $lf + $lf +
        "2) Несогласованность" + $lf +
        "с описанием и чертежами." + $lf + $lf +
        "3) Подмена признаков целью." + $lf +
        "4) Смешение разных вариантов" + $lf +
        "в одном пункте без логики.") },
    @{ Title = "36. Служебное изобретение"; Body = ("Служебным изобретением признают результат," + $lf +
        "созданный работником:" + $lf +
        "- в связи с выполнением трудовых обязанностей" + $lf +
        "или" + $lf +
        "- по конкретному заданию работодателя." + $lf + $lf +
        "Авторство у работника, исключительное право" + $lf +
        "и право на патент - у работодателя (если договором не установлено иное).") },
    @{ Title = "Порядок и последствия"; Body = ("Работник уведомляет работодателя" + $lf +
        "о создании результата." + $lf + $lf +
        "Работодатель в установленный срок" + $lf +
        "решает вопрос о патентовании/тайне." + $lf + $lf +
        "Если работодатель не предпринимает действий," + $lf +
        "право на получение патента может перейти работнику." ) },
    @{ Title = "Служебное изобретение по договору"; Body = ("Если результат создан при выполнении" + $lf +
        "работ по договору подряда или НИОКР," + $lf +
        "право на патент обычно принадлежит подрядчику (исполнителю)." + $lf + $lf +
        "Заказчик получает право использовать результат" + $lf +
        "для целей договора на условиях простой лицензии.") },
    @{ Title = "Выводы"; Body = ("Формула изобретения - это границы охраны" + $lf +
        "по ст. 1354 ГК РФ." + $lf + $lf +
        "Служебное изобретение - распределение прав" + $lf +
        "между работником и работодателем" + $lf +
        "(ст. 1370-1371 ГК РФ)." ) }
)

$targetSlideCount = $slides.Count

# Ensure slide count is correct
while ($pres.Slides.Count -lt $targetSlideCount) {
    [void]$pres.Slides.Add($pres.Slides.Count + 1, 12) # blank
}
while ($pres.Slides.Count -gt $targetSlideCount) {
    [void]$pres.Slides.Item($pres.Slides.Count).Delete()
}

for ($idx = 0; $idx -lt $targetSlideCount; $idx++) {
    $slideNumber = $idx + 1
    $slide = $pres.Slides.Item($slideNumber)

    Clear-SlideShapes -Slide $slide
    Set-SlideBackground -Slide $slide -RgbLong $bgRgb

    Add-HeaderBar -Slide $slide -X $left -Y $headerY -W $contentW -H $headerH -RgbLong $headerRgb

    $titleText = $slides[$idx].Title
    $bodyText = $slides[$idx].Body

    $titleFontSize = if ($idx -eq 0) { 34 } else { 30 }
    $bodyFontSize = 19

    # Title
    Add-Textbox -Slide $slide -X ($left + ($contentW * 0.02)) -Y ($headerY + $headerH * 0.18) -W ($contentW * 0.96) -H ($headerH * 0.62) -Text $titleText -FontSize $titleFontSize -Bold $true -FontRgb $whiteRgb -Alignment 2 | Out-Null

    # Body
    Add-Textbox -Slide $slide -X $left -Y $bodyY -W $contentW -H $bodyH -Text $bodyText -FontSize $bodyFontSize -Bold $false -FontRgb $bodyRgb -Alignment 1 | Out-Null

    # Footer accent line
    $lineY = $sh - $sh * 0.045
    $lineH = $sh * 0.003
    $accent = $slide.Shapes.AddShape(1, $left, $lineY, $contentW, $lineH)
    $accent.Fill.ForeColor.RGB = $accentRgb
    $accent.Line.Visible = $false

    $page = "Слайд " + $slideNumber
    Add-Textbox -Slide $slide -X ($left + $contentW - ($contentW * 0.25)) -Y ($sh - $sh * 0.065) -W ($contentW * 0.25) -H ($sh * 0.04) -Text $page -FontSize 12 -Bold $false -FontRgb $bodyRgb -Alignment 3 | Out-Null
}

$pres.Save()
$pres.Close()
$app.Quit()

[System.Runtime.InteropServices.Marshal]::ReleaseComObject($pres) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($app) | Out-Null

Write-Output ("Готово. Улучшенный дизайн: {0}" -f $pptPath)

