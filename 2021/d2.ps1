$PuzzleInput = Get-Content .\d2_input.txt | ForEach-Object{$Command = $_.Split(" "); [PSCustomObject]@{
        Action = $Command[0];
        Value = [Int]$Command[1]
    }
}

$Depth = 0; $Position = 0; 
#part1
# foreach($Command in $PuzzleInput){
#     switch ($Command.Action) {
#         "forward" {$Position += $Command.Value}
#         "down" {$Depth += $Command.Value}
#         "up" {$Depth -= $Command.Value}
#     }
# }
# "Depth: $Depth Position: $Position"
# "Multiplied: $($Depth * $Position)"

#part2
$Aim = 0;
foreach($Command in $PuzzleInput){
    switch ($Command.Action) {
        "forward" {
            $Position += $Command.Value
            $Depth += $Aim * $Command.Value
        }
        "down" {$Aim += $Command.Value}
        "up" {$Aim -= $Command.Value}
    }
}
"Depth: $Depth Position: $Position"
"Multiplied: $($Depth * $Position)"