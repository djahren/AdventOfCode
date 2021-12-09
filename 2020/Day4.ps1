$TextInput = gc "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day4_input.txt"
#$TextInput = gc "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day4_input_test.txt"
$RequiredFields = "byr","iyr","eyr","hgt","hcl","ecl","pid"
$Passports = @(); $PassportContents = ""
foreach($Line in $TextInput){
    if($Line -ne ""){
        $PassportContents += $Line + " "
    }
    else{
        $Passports += $PassportContents.Trim();
        $PassportContents = ""
    }
}
$Passports += $PassportContents + $Line; #add last

$ValidCount = 0
foreach($Passport in $Passports){
    $PassportValid = $true
    Write-Host $Passport

    #check for required fields
    foreach($Field in $RequiredFields){
        if(-not ($Passport | Select-String $($Field + ":"))){
            Write-Host "Passport invalid. Missing: $Field" -ForegroundColor Red            
            $PassportValid = $false
            break
        }
    }

    $PassportFields = $Passport.Split(" ")
    if($PassportValid){
        foreach($Field in $PassportFields){
            $FieldName  = $Field.Split(":")[0]
            $FieldValue = $Field.Split(":")[1]

            if($FieldName -eq "byr" -and ($FieldValue.Length -ne 4 -or $FieldValue -lt "1920" -or $FieldValue -gt "2002")){
                Write-Host "Passport invalid. byr invalid: $FieldValue" -ForegroundColor Red 
                $PassportValid = $false
                break
            }
            if($FieldName -eq "iyr" -and ($FieldValue.Length -ne 4 -or $FieldValue -lt "2010" -or $FieldValue -gt "2020")){
                Write-Host "Passport invalid. iyr invalid: $FieldValue" -ForegroundColor Red 
                $PassportValid = $false
                break
            }
            if($FieldName -eq "eyr" -and ($FieldValue.Length -ne 4 -or $FieldValue -lt "2020" -or $FieldValue -gt "2030")){
                Write-Host "Passport invalid. eyr invalid: $FieldValue" -ForegroundColor Red 
                $PassportValid = $false
                break
            }
            if($FieldName -eq "hgt"){
                $HeighPass = $true
                if($FieldValue | Select-String "in"){
                    if($FieldValue -lt "59in" -or $FieldValue -gt "76in"){
                        $HeighPass = $false
                    }
                }
                elseif($FieldValue | Select-String "cm"){
                    if($FieldValue -lt "150cm" -or $FieldValue -gt "193cm"){
                        $HeighPass = $false
                    }
                }
                else{
                    $HeighPass = $false
                }
                if(-not $HeighPass){
                    Write-Host "Passport invalid. hgt invalid: $FieldValue" -ForegroundColor Red 
                    $PassportValid = $false
                    break
                }
            }

            if($FieldName -eq "hcl" -and $FieldValue.Length -ne 7 -and -not($FieldValue | Select-String -Pattern '#[0-9a-f]{6}')){
                Write-Host "Passport invalid. hcl invalid: $FieldValue" -ForegroundColor Red 
                $PassportValid = $false
                break
            }

            if($FieldName -eq "ecl" -and $FieldValue -notin "amb","blu","brn","gry","grn","hzl","oth"){
                Write-Host "Passport invalid. ecl invalid: $FieldValue" -ForegroundColor Red 
                $PassportValid = $false
                break
            }

            if($FieldName -eq "pid" -and $FieldValue.Length -ne 9){
                Write-Host "Passport invalid. pid invalid: $FieldValue" -ForegroundColor Red 
                $PassportValid = $false
                break
            }

        }
    }
    
    if($PassportValid){
        Write-Host "Passport valid." -ForegroundColor Green      
        $ValidCount += 1
    }
    ""
}

Write-Host "Valid passports: $ValidCount"