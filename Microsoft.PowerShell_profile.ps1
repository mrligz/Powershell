fastfetch
# Shell
# Invoke-Expression (&starship init powershell)
# $ENV:STARSHIP_CONFIG = "$HOME/.config/starship/starship.toml"
 oh-my-posh init pwsh --config ~/.config/oh-my-posh/ligz2.omp.json | Invoke-Expression
# oh-my-posh init pwsh --config C:/Users/Mark/AppData/Local/Programs/oh-my-posh/themes/atomic.omp.json | Invoke-Expression

Import-Module -Name Terminal-Icons

#PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Import-Module syntax-highlighting

# Fzf
Import-Module PSFzf
# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PsFzfOption -TabExpansion
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# Navigation Shortcuts
function home { set-location ~\ }
function dt   { set-location ~\Desktop}
function docs { set-location ~\Documents}
function dl   { set-location ~\Downloads }
function dev { set-location ~\Documents\Dev }

# PoSh won't allow ${function:..} because of an invalid path error, so...
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }

# Files and Folder functions

# create a file
  function touch ($file) 
    { "" | out-file $file }
# create a folder
  function touch-folder ($name) 
    { new-item ($name) -itemtype directory }
# delete a file
  function delete ($file) 
    { remove-itemSafely -force ($file) }
# move a file
  function move ($source, $destination) 
    { move-item -Path $source -Destination $destination }
# copy a file
  function copy ($source, $destination) 
    { copy-item -Path $source -Destination $destination }
# zip a file
  function zip ($source, $destination) 
    { Compress-Archive -Path $source -DestinationPath $destination }
# unzip a file
Set-Alias sz "~\scoop\apps\7zip\current\7z.exe"
# Function: Easy-Extract
  function EasyExtract {
    [CmdletBinding()]
    param (
        [ValidateScript( {Test-Path -Path $_})]
        [string]
        $Path
    )
    
        $Item = Get-Item -Path $Path
        $Extension = $Item.Extension
        switch ($Extension) {
            ".7z"   {sz e $Item -o*}
            ".bz2"  {sz e $Item -o*}
            ".gz"   {sz e $Item -o*}
            ".tar"  {sz e $Item -o*}
            ".tbz2" {sz e $Item -o*}
            ".tgz"  {sz e $Item -o*}
            ".rar"  {ur e $Item}
            ".zip"  {sz e $Item -o*}
            ".Z"    {sz e $Item -o*}
            #{sz x $Item -so | sz x -aoa -si -ttar -o*}
            Default {
                throw "Problems extracting '$Item' with extract()"
            }
        }
}
Set-Alias unzip EasyExtract
# kill process
  function pkill($name)
    { Get-Process $name -ErrorAction SilentlyContinue | Stop-Process }

  function whereis ($command) 
    { Get-Command -Name $command -ErrorAction SilentlyContinue }

  function getIP { invoke-webrequest http://ifconfig.me/ip }

# Empty the Recycle Bin on all drives
  function Empty-Trash { Clear-RecycleBin }
