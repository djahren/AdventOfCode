$Nums = @()
$InputNums = Import-Csv "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day1_input.txt" | %{$Nums += [int]$_.Num}
$Nums = $Nums | Sort

$2020Found = $false
foreach($Value1 in $Nums){
    foreach($Value2 in $Nums){
    if($Value1 + $Value2 -gt 2020-167){break}
        foreach($Value3 in $Nums){
            if(($Value1 + $Value2 + $Value3) -eq 2020){
                $Value1 
                $Value2
                $Value3
                $Value1 * $Value2 * $Value3
                $2020Found = $true
                break
            }
            if($2020Found){break}
        }
    }
    if($2020Found){break}
}

#$Value1 
#$Value2
#$Value3
#[int]$Value1 * [int]$Value2 * [int]$Value3