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
$d = get-ADuser -Filter *
$g = get-ADgroupmember Administrators
$input5 = ConvertTo-SecureString "Cyberpatri0t" -AsPlainText -Force
foreach($i in $d){
	set-ADuser $i -passwordneverexpires $false
	$input = Read-Host -prompt "Should '$i' be Admin(a), User(u), Disabled(d), or Eradicated(e)?"
	if($input -eq "a"){
		set-ADAccountPassword -Identity $i -NewPassword $input5
		enable-ADaccount $i
		add-ADgroupmember -identity Administrators -members $i
	}
	if($input -eq "u"){
		set-ADAccountPassword -Identity $i -NewPassword $input5
		enable-ADaccount $i		
		remove-ADgroupmember -identity Admins -members $i
		remove-ADgroupmember -identity "Enterprise Admins" -members $i	
		remove-ADgroupmember -identity "Domain Admins" -members $i
		remove-ADgroupmember -identity "Schema Admins" -members $i
	}
	if($input -eq "d"){
		set-ADAccountPassword -Identity $i -NewPassword $input5
		disable-ADaccount $i
		remove-ADgroupmember -identity Administrators -members $i 
		remove-ADgroupmember -identity "Enterprise Admins" -members $i 
		remove-ADgroupmember -identity "Domain Admins" -members $i
		remove-ADgroupmember -identity "Schema Admins" -members $i
	}
	if($input -eq "e"){
		remove-ADuser $i
	}
}
$whatnow = Read-Host -prompt "Add a new Active Directory Group? Yes(y) or No(n)"
if($whatnow -eq "y"){
	$nameit = Read-Host -prompt "What is the name of the group?"
	new-ADGroup -Name $nameit
	$checksum = 'y'
	while($checksum -eq 'y'){
		$checksum = Read-Host -prompt "Do you want to add a user to this group?"
		if ($checksum -eq 'y'){
			$groupmems = Read-Host -prompt "Name of user to be added:"
			add-ADgroupmember -identity $nameit -members $groupmems
		}
	}
}
$input9 = 'y'
while($input9 -eq 'y'){
	$input9 = Read-Host -prompt "Add a new Active Directory User? Yes(y) or No(n)"
	if($input9 -eq "y"){
		$name = Read-Host -prompt "What is the name of the user?"
		new-ADuser -Name $name
		set-ADAccountPassword -Identity $name -NewPassword $input5
		enable-ADaccount $name
		$checks = Read-Host -prompt "Should password be changed at next logon? Yes(y) or No(n)"
		if($checks -eq "y"){
			set-ADuser $name -changepasswordatlogon $true
		}
		$checks2 = Read-Host -prompt "Add new user to a group? Yes(y) or No(n)"
		if($checks2 -eq "y"){
			$after = Read-Host -prompt "Name of group"
			add-ADgroupmember -identity $after -members $name
		}
	}
}
$input11= 'y'
while($input11 -eq 'y'){
	$input11 = Read-Host -prompt "Add a new Active Directory Administrator? Yes(y) or No(n)"
	if($input11 -eq "y"){
		$name = Read-Host -prompt "What is the name of the administrator?"
		new-ADuser -Name $name
		set-ADAccountPassword -Identity $name -NewPassword $input5
		enable-ADaccount $name
		add-ADgroupmember -identity Administrators -members $name
		$checks = Read-Host -prompt "Should password be changed at next logon? Yes(y) or No(n)"
		if($checks -eq "y"){
			set-ADuser $name -changepasswordatlogon $true
		}
		$checks2 = Read-Host -prompt "Add new user to a group? Yes(y) or No(n)"
		if($checks2 -eq "y"){
			$after = Read-Host -prompt "Name of group"
			add-ADgroupmember -identity $after -members $name
		}
	}
}
Read-Host -prompt "Look at groups b/c we don't want to do that here"	



