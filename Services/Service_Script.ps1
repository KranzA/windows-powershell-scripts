get-service | select-object "StartType","Name" | export-csv -path "C:\Users\moana\Desktop\ServicesLocal.csv"
$file1 = import-csv -path "C:\Users\moana\Desktop\ServicesLocal.csv" | Select-Object "StartType","Name"
$file2 = import-csv -path "C:\Users\moana\Desktop\ServiceImport.csv" | Select-Object "StartType","Name"
$return = Compare-Object $file1 $file2 -property Name,StartType
$array = @()
$ar = @()
[System.Collections.ArrayList]$array1 = $array
[System.Collections.ArrayList]$array2 = $ar
for ($i = 0; $i -lt $return.Length; $i++){
	$check = 0
	$a = $return[$i] | select-object -expandproperty Name
	$b = $return[$i] | select-object -expandproperty StartType;
	if(($return[$i] | select-object -expandproperty SideIndicator) -eq "=>"){
		for ($x = 0; $x -lt $return.Length; $x++){
			if($a -eq ($return[$x] | select-object -expandproperty Name) -and $i -ne $x){
				$check++
			}
		}
		if($check -eq 0){
			$array1.Add($a)
		}
		elseif((get-service $a | select-object -expandproperty StartType) -ne $b){
			$input = Read-Host -Prompt "Do you want to change the StartType of '$a' to '$b'?"
			if($input -eq 'Y'){
				Set-Service -InputObject $a -StartupType $b
				if($b -eq "Stopped"){
					set-service -Name $a -StartupType Disabled
					write-host "Yayitworked"
				}
			}
		}
		else{continue}
	}
	else{
		for ($x = 0; $x -lt $return.Length; $x++){
			if($a -eq ($return[$x] | select-object -expandproperty Name) -and $i -ne $x){
				$check++
			}
		}
		if($check -eq 0){
			$array2.Add($a)
		}
	}
}
write-host " "
write-host "DO YOU WANT TO ADD THESE WONDERFUL THINGS?"
$array1
write-host " "
write-host "DO YOU WANT TO GET RID OF THESE WONDERFUL THINGS?"
$array2
Read-Host -Prompt "Press Enter to exit"




