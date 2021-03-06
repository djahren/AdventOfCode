$PuzzleInput = Get-Content .\d4_testinput.txt

#load data
$CallingNumbers = $PuzzleInput[0].Split(",");
$Boards = @(); $Board = @{}; $BoardRow = 0;
foreach($Line in $PuzzleInput | Select-Object -Skip 2){
    if($Line -eq ""){
        $Boards += $Board
        $Board = @{}; $BoardRow = 0;
    } else {
        $Board[$BoardRow] = $Line.Split(" ") | Where-Object {$_ -ne ""}
        $BoardRow++
    }
}
$Boards += $Board

#part1


#part2
