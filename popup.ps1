Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form (GUI window)
$popup = New-Object System.Windows.Forms.Form
$popup.Text = "Choose Mode"
$popup.Size = New-Object System.Drawing.Size(350,180)
$popup.StartPosition = "CenterScreen"
$popup.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)  # Background #282828
$popup.FormBorderStyle = "FixedDialog"

# Load Nunito Bold Font (if installed)
$fontFamily = "Nunito Bold"
try {
    $font = New-Object System.Drawing.Font($fontFamily, 12, [System.Drawing.FontStyle]::Bold)
} catch {
    # Fallback to default font if Nunito Bold is not available
    $font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
}

# Add a label (question text in white)
$label = New-Object System.Windows.Forms.Label
$label.Text = "Select an application mode:"
$label.ForeColor = [System.Drawing.Color]::White  # White color for text
$label.Font = $font
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(50,25)
$popup.Controls.Add($label)

# Create a function to style buttons with rounded corners
function Create-Button($text, $x, $y, $color) {
    $button = New-Object System.Windows.Forms.Button
    $button.Text = $text
    $button.Size = New-Object System.Drawing.Size(120,40)
    $button.Location = New-Object System.Drawing.Point($x, $y)
    $button.BackColor = $color
    $button.ForeColor = [System.Drawing.Color]::White
    $button.FlatStyle = "Flat"
    $button.Font = New-Object System.Drawing.Font($fontFamily, 10, [System.Drawing.FontStyle]::Bold)
    $button.FlatAppearance.BorderSize = 0
    
    # Set rounded corners using the region property
    $radius = 15
    $graphicsPath = New-Object System.Drawing.Drawing2D.GraphicsPath
    $graphicsPath.AddArc(0, 0, $radius, $radius, 180, 90)
    $graphicsPath.AddArc($button.Width - $radius - 1, 0, $radius, $radius, 270, 90)
    $graphicsPath.AddArc($button.Width - $radius - 1, $button.Height - $radius - 1, $radius, $radius, 0, 90)
    $graphicsPath.AddArc(0, $button.Height - $radius - 1, $radius, $radius, 90, 90)
    $graphicsPath.CloseFigure()
    $button.Region = New-Object System.Drawing.Region($graphicsPath)

    return $button
}

# Create the Fullscreen button
$fullscreenButton = Create-Button "Fullscreen" 50 80 ([System.Drawing.Color]::FromArgb(50, 150, 250))  # Blue
$fullscreenButton.Add_Click({
    "1" | Out-File "$env:temp\choice.txt" -Encoding ASCII
    $popup.Close()
})
$popup.Controls.Add($fullscreenButton)

# Create the Desktop button
$desktopButton = Create-Button "Desktop" 180 80 ([System.Drawing.Color]::FromArgb(100, 200, 100))  # Green
$desktopButton.Add_Click({
    "2" | Out-File "$env:temp\choice.txt" -Encoding ASCII
    $popup.Close()
})
$popup.Controls.Add($desktopButton)

$popup.Topmost = $true
$popup.ShowDialog()
