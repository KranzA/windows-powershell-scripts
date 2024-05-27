Get-ChildItem -path C:\ -Name > C:\users\liberty\Desktop\c_competition.txt
$a = get-childitem -path C:\ -Name -Hidden
Add-Content C:\users\liberty\Desktop\c_competition.txt $a

Get-ChildItem -path C:\Windows -Name > C:\users\liberty\Desktop\windows_competition.txt
$b = get-childitem -path C:\Windows -Name -Hidden
Add-Content C:\users\liberty\Desktop\windows_competition.txt $b

Get-ChildItem -path C:\ -Name > C:\users\liberty\Desktop\c_competition.txt
$c = get-childitem -path C:\ -Name -Hidden
Add-Content C:\users\liberty\Desktop\c_competition.txt $c

Get-ChildItem -path C:\Windows\System32 -Name > C:\users\liberty\Desktop\sys32_competition.txt
$d = get-childitem -path C:\Windows\System32 -Name -Hidden
Add-Content C:\users\liberty\Desktop\sys32_competition.txt $d

Get-ChildItem -path "C:\Program Files" -Name > C:\users\liberty\Desktop\progfiles_competition.txt
$e = get-childitem -path "C:\Program Files" -Name -Hidden
Add-Content C:\users\liberty\Desktop\progfiles_competition.txt $e

Get-ChildItem -path "C:\Program Files (x86)" -Name > C:\users\liberty\Desktop\progfilesx86_competition.txt
$f = get-childitem -path "C:\Program Files (x86)" -Name -Hidden
Add-Content C:\users\liberty\Desktop\progfilesx86_competition.txt $f
