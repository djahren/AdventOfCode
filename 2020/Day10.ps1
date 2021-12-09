cd "C:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020"
$TextInput = Get-Content "day10_input_test.txt"
#$TextInput = Get-Content "day10_input_test2.txt"
#$TextInput = Get-Content "day10_input.txt"
$ConvertedInput = $TextInput | %{[Int64]$_}
$ConvertedInput += 0
$ConvertedInput = $ConvertedInput | Sort
$ConvertedInput += ($ConvertedInput | Select -Last 1) + 3

<# $DiffCount = @{}
$Index = 0
While($Index -lt $ConvertedInput.Count - 1){
    $Difference = $ConvertedInput[$Index + 1] - $ConvertedInput[$Index]
    if($DiffCount[$Difference]){
        $DiffCount[$Difference] += 1
    }
    else{
        $DiffCount[$Difference] = 1
    }
    $Index += 1
}
$DiffCount #>

#2d array of step history
$Routes = @()
function New-Route{
    [PSCustomObject]@{ID=$Routes.Count;Steps=@($ConvertedInput[0])}
}
$Routes += New-Route

$StepIndex = 0
#while loop to step through steps ... or max steps not reached ... or final step not met on all possible routes
while($StepIndex -lt 3){
    #loop through each route in history array (1st dimension)
    $RouteIndex = 0
    while($RouteIndex -lt $Routes.Count -and $Routes.Count -lt 10){
        #get number of possible steps
        $PossibleNextSteps = $ConvertedInput | Where {$_ -gt $Routes[$RouteIndex].Steps[$StepIndex] -and $_ -le $Routes[$RouteIndex].Steps[$StepIndex] + 3}

        #for each possible next step exists
        $PossibilityIndex = 0
        while($PossibilityIndex -lt $PossibleNextSteps.Count){
            #if more than one possibility exists copy the current route to new route(s)
            $RouteID = $RouteIndex
            if($PossibilityIndex -gt 0){
                $Routes += New-Route
                $RouteID = $Routes.Count - 1
                $Routes[$RouteID].Steps = $Routes[$RouteIndex].Steps
            }

            #add the other possible options to an array of step histories (2nd dimension)
            $Routes[$RouteID].Steps += $PossibleNextSteps[$PossibilityIndex]

            $PossibilityIndex += 1
        }
        $RouteIndex += 1
    }
    $StepIndex += 1
}

$Routes