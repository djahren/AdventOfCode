$TextInput = Get-Content "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day7_input_test.txt"
$TextInput = Get-Content "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day7_input.txt"

#$BagDB = @{}
$BagDB = @()
foreach($Line in $TextInput){
    $BagInfo = $Line.Split(" ")
    $BagName = $BagInfo[0] + "_" + $BagInfo[1]
    if($BagInfo[4] -eq "no"){
        $Contents = -1}
    else{
        $Contents = @()
        $Index = 4
        while($BagInfo[$Index] -ne $null){
            $Contents += [PSCustomObject]@{Name=$BagInfo[$Index+1] + "_" + $BagInfo[$Index+2];Quantity=$BagInfo[$Index]}
            $Index += 4
        }
    }
    
    #$BagDB[$BagName] = $Contents
    $BagDB += [PSCustomObject]@{Name=$BagName;Contents=$Contents}
}

function Get-BagsThatICanGoIn{
    param($BagName)
    $Results = @()
    
    $Results += $BagDB | Where {$_.Contents.Name -eq $BagName}
    foreach($Result in $Results){
        $Results += Get-BagsThatICanGoIn $Result.Name
    }

    return $Results
}

#$BagsThatFitShinyGold = Get-BagsThatICanGoIn "shiny_gold" | select -Unique Name
#$BagsThatFitShinyGold
#$BagsThatFitShinyGold.Count

function Get-TotalBagsContained{
    param($BagName, [Switch]$CalledRecursively)
    $TotalBags = 0
    $Bag = $BagDB | Where {$_.Name -eq $BagName}
    if($CalledRecursively){
        $TotalBags += 1
    }
    if($Bag.Contents -ne -1){
        foreach($InsideBag in $Bag.Contents){
            $TotalBags += (Get-TotalBagsContained $InsideBag.Name -CalledRecursively) * $InsideBag.Quantity
        }
    }

    return $TotalBags
}

$TotalBagsContained = (Get-TotalBagsContained "shiny_gold")
$TotalBagsContained
