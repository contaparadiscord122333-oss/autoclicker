Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase,System.Windows.Forms
Add-Type @"
using System;using System.Runtime.InteropServices;
public class AC{
  [DllImport("user32.dll")]public static extern void mouse_event(uint f,uint x,uint y,uint d,int e);
  public static void Click(){mouse_event(2,0,0,0,0);mouse_event(4,0,0,0,0);}
}
"@

[xml]$xaml=@"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="AutoClicker" Height="420" Width="360"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        Background="#0D0D0F" FontFamily="Segoe UI">
  <Window.Resources>
    <Style TargetType="Button">
      <Setter Property="Cursor" Value="Hand"/>
      <Setter Property="BorderThickness" Value="0"/>
      <Setter Property="FontFamily" Value="Segoe UI Semibold"/>
      <Setter Property="FontSize" Value="13"/>
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="Button">
            <Border Background="{TemplateBinding Background}" CornerRadius="10" Padding="10,0">
              <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
            </Border>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>
    <Style TargetType="ComboBox">
      <Setter Property="Background" Value="#0D0D0F"/>
      <Setter Property="Foreground" Value="White"/>
      <Setter Property="BorderBrush" Value="#333333"/>
      <Setter Property="FontSize" Value="12"/>
    </Style>
  </Window.Resources>
  <Grid Margin="24">
    <Grid.RowDefinitions>
      <RowDefinition Height="Auto"/>
      <RowDefinition Height="20"/>
      <RowDefinition Height="Auto"/>
      <RowDefinition Height="16"/>
      <RowDefinition Height="Auto"/>
      <RowDefinition Height="16"/>
      <RowDefinition Height="Auto"/>
      <RowDefinition Height="16"/>
      <RowDefinition Height="Auto"/>
      <RowDefinition Height="*"/>
      <RowDefinition Height="Auto"/>
    </Grid.RowDefinitions>

    <StackPanel Grid.Row="0" Orientation="Horizontal" VerticalAlignment="Center">
      <TextBlock Text="AUTO" FontSize="22" FontWeight="Black" Foreground="#FFFFFF"/>
      <TextBlock Text="CLICKER" FontSize="22" FontWeight="Black" Foreground="#06D6A0"/>
      <Border Margin="12,4,0,4" CornerRadius="4" Padding="6,2" Background="#1A3D35">
        <TextBlock Text="FILELESS" FontSize="10" Foreground="#06D6A0" FontFamily="Consolas"/>
      </Border>
    </StackPanel>

    <Grid Grid.Row="2">
      <Grid.ColumnDefinitions>
        <ColumnDefinition/><ColumnDefinition/><ColumnDefinition/>
      </Grid.ColumnDefinitions>
      <Border Grid.Column="0" Background="#161618" CornerRadius="10" Margin="0,0,6,0" Padding="12,10">
        <StackPanel>
          <TextBlock x:Name="statClicks" Text="0" FontSize="22" FontWeight="Bold" Foreground="#06D6A0" FontFamily="Consolas" HorizontalAlignment="Center"/>
          <TextBlock Text="CLIQUES" FontSize="9" Foreground="#555555" HorizontalAlignment="Center" Margin="0,2,0,0"/>
        </StackPanel>
      </Border>
      <Border Grid.Column="1" Background="#161618" CornerRadius="10" Margin="3,0,3,0" Padding="12,10">
        <StackPanel>
          <TextBlock x:Name="statCps" Text="0.0" FontSize="22" FontWeight="Bold" Foreground="#A78BFA" FontFamily="Consolas" HorizontalAlignment="Center"/>
          <TextBlock Text="C/SEG" FontSize="9" Foreground="#555555" HorizontalAlignment="Center" Margin="0,2,0,0"/>
        </StackPanel>
      </Border>
      <Border Grid.Column="2" Background="#161618" CornerRadius="10" Margin="6,0,0,0" Padding="12,10">
        <StackPanel>
          <TextBlock x:Name="statTime" Text="0s" FontSize="22" FontWeight="Bold" Foreground="#FFFFFF" FontFamily="Consolas" HorizontalAlignment="Center"/>
          <TextBlock Text="TEMPO" FontSize="9" Foreground="#555555" HorizontalAlignment="Center" Margin="0,2,0,0"/>
        </StackPanel>
      </Border>
    </Grid>

    <Border Grid.Row="4" Background="#161618" CornerRadius="10" Padding="16,12">
      <Grid>
        <Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition Width="Auto"/></Grid.ColumnDefinitions>
        <StackPanel>
          <TextBlock Text="INTERVALO" FontSize="9" Foreground="#555555" FontWeight="Bold" Margin="0,0,0,4"/>
          <Slider x:Name="sliderMs" Minimum="10" Maximum="2000" Value="100" TickFrequency="10" IsSnapToTickEnabled="True" Foreground="#7C3AED"/>
        </StackPanel>
        <Border Grid.Column="1" Background="#0D0D0F" CornerRadius="6" Padding="10,4" Margin="12,0,0,0" VerticalAlignment="Center">
          <TextBlock x:Name="lblMs" Text="100ms" FontFamily="Consolas" FontSize="13" Foreground="#06D6A0"/>
        </Border>
      </Grid>
    </Border>

    <Border Grid.Row="6" Background="#161618" CornerRadius="10" Padding="16,12">
      <Grid>
        <Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition/></Grid.ColumnDefinitions>
        <StackPanel Grid.Column="0" Margin="0,0,6,0">
          <TextBlock Text="BOTAO" FontSize="9" Foreground="#555555" FontWeight="Bold" Margin="0,0,0,6"/>
          <ComboBox x:Name="cmbBtn">
            <ComboBoxItem Content="Esquerdo" IsSelected="True"/>
            <ComboBoxItem Content="Direito"/>
          </ComboBox>
        </StackPanel>
        <StackPanel Grid.Column="1" Margin="6,0,0,0">
          <TextBlock Text="TIPO" FontSize="9" Foreground="#555555" FontWeight="Bold" Margin="0,0,0,6"/>
          <ComboBox x:Name="cmbType">
            <ComboBoxItem Content="Simples" IsSelected="True"/>
            <ComboBoxItem Content="Duplo"/>
          </ComboBox>
        </StackPanel>
      </Grid>
    </Border>

    <StackPanel Grid.Row="8" Orientation="Horizontal" VerticalAlignment="Center">
      <Ellipse Width="8" Height="8" Margin="0,0,8,0">
        <Ellipse.Fill><SolidColorBrush x:Name="dotColor" Color="#EF4444"/></Ellipse.Fill>
      </Ellipse>
      <TextBlock x:Name="lblStatus" Text="PARADO" FontSize="11" Foreground="#555555" FontFamily="Consolas"/>
      <TextBlock Text="   F6 iniciar / F7 parar" FontSize="10" Foreground="#333333" FontFamily="Consolas"/>
    </StackPanel>

    <Grid Grid.Row="10">
      <Grid.ColumnDefinitions><ColumnDefinition/><ColumnDefinition Width="12"/><ColumnDefinition/></Grid.ColumnDefinitions>
      <Button x:Name="btnStart" Grid.Column="0" Height="44" Foreground="White">
        <Button.Background>
          <LinearGradientBrush StartPoint="0,0" EndPoint="1,1">
            <GradientStop Color="#7C3AED" Offset="0"/>
            <GradientStop Color="#9333EA" Offset="1"/>
          </LinearGradientBrush>
        </Button.Background>
        <StackPanel Orientation="Horizontal">
          <TextBlock Text="▶  " FontSize="13" Foreground="White"/>
          <TextBlock Text="INICIAR" FontSize="13" Foreground="White"/>
        </StackPanel>
      </Button>
      <Button x:Name="btnStop" Grid.Column="2" Height="44" Foreground="#EF4444" IsEnabled="False" Background="#3C1414">
        <StackPanel Orientation="Horizontal">
          <TextBlock Text="■  " FontSize="13" Foreground="#EF4444"/>
          <TextBlock Text="PARAR" FontSize="13" Foreground="#EF4444"/>
        </StackPanel>
      </Button>
    </Grid>
  </Grid>
</Window>
"@

$reader = [System.Xml.XmlNodeReader]::new($xaml)
$win = [Windows.Markup.XamlReader]::Load($reader)

$statClicks = $win.FindName("statClicks")
$statCps    = $win.FindName("statCps")
$statTime   = $win.FindName("statTime")
$sliderMs   = $win.FindName("sliderMs")
$lblMs      = $win.FindName("lblMs")
$lblStatus  = $win.FindName("lblStatus")
$dotColor   = $win.FindName("dotColor")
$btnStart   = $win.FindName("btnStart")
$btnStop    = $win.FindName("btnStop")
$cmbBtn     = $win.FindName("cmbBtn")
$cmbType    = $win.FindName("cmbType")

$sliderMs.add_ValueChanged({ $lblMs.Text = "$([int]$sliderMs.Value)ms" })

$n = 0
$startT = $null
$tm = New-Object System.Windows.Forms.Timer

$tm.add_Tick({
    $right  = $cmbBtn.SelectedIndex -eq 1
    $double = $cmbType.SelectedIndex -eq 1
    if ($right) { [AC]::mouse_event(8,0,0,0,0); [AC]::mouse_event(16,0,0,0,0) }
    else        { [AC]::Click() }
    if ($double) {
        if ($right) { [AC]::mouse_event(8,0,0,0,0); [AC]::mouse_event(16,0,0,0,0) }
        else        { [AC]::Click() }
    }
    $script:n++
    $el  = [int](([DateTime]::Now - $script:startT).TotalSeconds)
    $cps = if ($el -gt 0) { [math]::Round($script:n / $el, 1) } else { 0 }
    $win.Dispatcher.Invoke([action]{
        $statClicks.Text = "$script:n"
        $statCps.Text    = "$cps"
        $statTime.Text   = "${el}s"
    })
})

$btnStart.add_Click({
    $script:n = 0
    $script:startT = [DateTime]::Now
    $tm.Interval = [int]$sliderMs.Value
    $tm.Start()
    $btnStart.IsEnabled = $false
    $btnStop.IsEnabled  = $true
    $lblStatus.Text       = "ATIVO"
    $lblStatus.Foreground = [Windows.Media.Brushes]::LightGreen
    $dotColor.Color       = [Windows.Media.Color]::FromRgb(6,214,160)
})

$btnStop.add_Click({
    $tm.Stop()
    $btnStart.IsEnabled   = $true
    $btnStop.IsEnabled    = $false
    $lblStatus.Text       = "PARADO"
    $lblStatus.Foreground = [Windows.Media.Brushes]::Gray
    $dotColor.Color       = [Windows.Media.Color]::FromRgb(239,68,68)
})

$win.add_KeyDown({
    if ($_.Key -eq "F6" -and $btnStart.IsEnabled) {
        $btnStart.RaiseEvent([Windows.RoutedEventArgs]::new([Windows.Controls.Button]::ClickEvent))
    }
    if ($_.Key -eq "F7" -and $btnStop.IsEnabled) {
        $btnStop.RaiseEvent([Windows.RoutedEventArgs]::new([Windows.Controls.Button]::ClickEvent))
    }
})

[void]$win.ShowDialog()