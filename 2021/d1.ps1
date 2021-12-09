$PuzzleInput = Get-Content .\d1_input.txt | ForEach-Object{[Int]$_}
# $Last = -1; $NumIncreases = 0
#part1
# foreach($Depth in $PuzzleInput){
#     $Depth = $Depth
#     if($Last -ne -1 -and $Last -lt $Depth){
#         $NumIncreases++
#     }    
#     $Last = $Depth
# }
# $NumIncreases

$Windows = @(); $NumIncreases = 0
#part2
for($i = 0; $i -lt $PuzzleInput.length; $i++){
    $Current = $PuzzleInput[$i]
    #Add current to new window
    $Windows += $Current

    #Add current to previous (if exists)
    if($i - 1 -ge 0){
        $Windows[$i - 1] += $Current
    }

    #Add current to one before previous (if exists)
    if($i - 2 -ge 0){
        $Windows[$i - 2] += $Current
    }
    
    if($i -gt 2 -and $Windows[$i - 2] -gt $Windows[$i - 3]){
        $NumIncreases++
    }
}
$NumIncreases