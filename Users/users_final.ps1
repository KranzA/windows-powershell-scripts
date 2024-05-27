remove-item C:\Users\moana\AppData\Local\Temp -recurse -force
$logs = get-wmiobject Win32_NTEventLogFile
foreach($l in $logs){
	$l.maxfilesize = 204800KB
}
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Remote Assistance' -name "fAllowToGetHelp" -Value 0
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 1
$shares = get-smbshare | select-object -expandproperty Name
remove-smbshare $shares
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
$d = get-localuser
$g = get-localgroupmember Administrators
$input5 = ConvertTo-SecureString "Cyberpatri0t" -AsPlainText -Force
foreach($i in $d){
	$input = Read-Host -prompt "Should '$i' be Admin(a), User(u), Disabled(d), or Eradicated(e)?"
	if($input -eq "a"){
		add-localgroupmember -group Administrators -member $i
`		enable-localuser $i
		set-localuser $i -password $input5
	}
	if($input -eq "u"){
		remove-localgroupmember -group Administrators -member $i
		enable-localuser $i
		set-localuser $i -password $input5
	}
	if($input -eq "d"){
		remove-localgroupmember -group Administrators -member $i
		disable-localuser $i
		set-localuser $i -password $input5
	}
	if($input -eq "e"){
		remove-localuser $i
		Remove-Item –path c:\Users\$i
	}
	set-localuser $i -passwordneverexpires $false
}
$groups = 'Access Control Assistance Operators',"Administrators", "Backup Operators", "Certificate Service DCOM Access", "Cryptographic Operators", "Device Owners", "Distributed COM Users", "Event Log Readers", "Guests", "Hyper-V Administrators", "IIS_IUSRS", "Network Configuration Operators", "Performance Log Users", "Performance Monitor Users", "Power Users", "Print Operators", "RDS Endpoint Servers", "RDS Remote Access Servers","Remote Desktop Users", "Remote Management Users", "Replicator", "Storage Replica Administrators", "System Managed Accounts Group", "Users"
$currGroup = get-localgroup
foreach($s in $currGroup){
	if(-not ($groups -contains $s)){
		$in = Read-Host -prompt "Remove group '$s'?"
		if($in -eq "y"){
			remove-localgroup $s
		}
	}
}
$whatnow = Read-Host -prompt "Add a new Group? Yes(y) or No(n)"
if($whatnow -eq "y"){
	$nameit = Read-Host -prompt "What is the name of the group?"
	new-LocalGroup -Name $nameit
	$checksum = 'y'
	while($checksum -eq 'y'){
		$checksum = Read-Host -prompt "Do you want to add a user to this group?"
		if ($checksum -eq 'y'){
			$groupmems = Read-Host -prompt "Name of user to be added:"
			add-localgroupmember -group $nameit -member $groupmems
		}
	}
}
$input9 = 'y'
while($input9 -eq "y"){
$input9 = Read-Host -prompt "Add a new User? Yes(y) or No(n)"
if($input9 -eq "y"){
	$name = Read-Host -prompt "What is the name of the user?"
	new-localuser -Name $name -password $input5
	enable-localuser $name
	add-localgroupmember -group Users -member $name
	$checks2 = Read-Host -prompt "Add new user to a group? Yes(y) or No(n)"
	if($checks2 -eq "y"){
		$after = Read-Host -prompt "Name of group"
		add-localgroupmember -group $after -member $name
	}
}
}
$inputinfinity = 'y'
while($inputinfinity -eq 'y'){
	$inputinfinity = Read-Host -prompt "Add a new Administrator? Yes(y) or No(n)"
	if($inputinfinity -eq 'y'){
		$nameadmin = Read-Host -prompt "What is the name of the administrator?"
		new-localuser -Name $nameadmin -password $input5
		enable-localuser $nameadmin
		add-localgroupmember -group Administrators -member $nameadmin
		$checks2 = Read-Host -prompt "Add new admin to a group? Yes(y) or No(n)"
		if($checks2 -eq "y"){
			$after = Read-Host -prompt "Name of group"
			add-localgroupmember -group $after -member $nameadmin
		}
	}
}
sfc /scannow
