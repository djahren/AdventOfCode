cd "C:\Users\Ahren\Dropbox\Documents\WindowsPowershell\AdventOfCode2020"
$TextInput = Get-Content "day11_input_test.txt"
#$TextInput = Get-Content "day11_input_test2txt.txt"
#$TextInput = Get-Content "day11_input.txt"
$StartTime = Get-Date
function New-Highlight{
    param($Col, $Row, $Color = "Red")
    return [PSCustomObject]@{
        Col = $Col;
        Row = $Row;
        Color = $Color
    }
}

function Write-Cells{
    param($array, $highlights = @())
    #Write-Host $highlights
    for($R_Index = 0; $R_Index -lt $array.Count; $R_Index += 1){
        for($C_Index = 0; $C_Index -lt $array[0].Count; $C_Index += 1){
            $highlightcell = $highlights | Where-Object {$_.Row -eq $R_Index -and $_.Col -eq $C_Index}
            #Write-Host $highlightcell
            if($highlightcell){
                $highlightcell = $highlightcell[0]
                Write-Host $array[$R_Index][$C_Index] -ForegroundColor $highlightcell.Color -NoNewline
            }
            else{
                Write-Host $array[$R_Index][$C_Index] -NoNewline
            }
        }
        Write-Host ""
    }
}

function Get-OccupiedNeighborSeats{
    param($array, $seatRow, $seatCol, [Switch]$Debug)
    $NeighborCount = 0
    function xy{param($x, $y); return [PSCustomObject]@{X=$x; Y=$y; Found=$false}}
    $Cardinals = [Ordered]@{NW=(xy -1 -1);N=(xy 0 -1);NE=(xy 1 -1);E=(xy 1 0);SE=(xy 1 1);S=(xy 0 1);SW=(xy -1 1);W=(xy -1 0)}
    $Multiple = 1; $UnfoundDirections = $Cardinals.Keys;

    while(($Multiple -le $array.Count -or $Multiple -le $array[0].Count) -and $UnfoundDirections.Count -gt 0){
        foreach($Key in $UnfoundDirections){
            #Get each key that hasn't been found yet
            $Check_Row = $seatRow + [Int]$Cardinals[$Key].Y * $Multiple
            $Check_Col = $seatCol + [Int]$Cardinals[$Key].X * $Multiple
            if($Check_Row -ge 0 -and $Check_Col -ge 0 -and $Check_Row -lt $array.Count -and $Check_Col -lt $array[0].Count){
                #if the current position is in the array...
                if($Debug){
                    Write-Host "`n$Multiple $Key Col: $Check_Col Row: $Check_Row"
                    Write-Cells $array @((New-Highlight -Row $seatRow -Col $seatCol -Color "Red"),(New-Highlight -Row $Check_Row -Col $Check_Col -Color "Blue"))
                }
                if($array[$Check_Row][$Check_Col] -eq "#"){                    
                    if($Debug){Write-Host "Occupied"}
                    $Cardinals[$Key].Found = $true
                    $NeighborCount += 1
                }
                elseif ($array[$Check_Row][$Check_Col] -eq "L") {
                    if($Debug){Write-Host "Not Occupied"}
                    $Cardinals[$Key].Found = $true #seat in direction not occupied, stop checking
                }
            }
            else{
                $Cardinals[$Key].Found = $true #direction out of bounds, don't check
                if($Debug){
                    Write-Host "`n$Multiple $Key Col: $Check_Col Row: $Check_Row`n$Key is out of bounds" -ForegroundColor "Red"
                }
            }
        }
        $UnfoundDirections = ($Cardinals.GetEnumerator() | Where-Object {$_.Value.Found -eq $false}).Key
        $Multiple += 1
    }
    return $NeighborCount 
}

#Convert input to hashtable
$CurrentSeats = @{}
for($R_Index = 0; $R_Index -lt $TextInput.Count; $R_Index += 1){
    $CurrentSeats[$R_Index] = @{}
    for($C_Index = 0; $C_Index -lt $TextInput[0].Length; $C_Index += 1){
        $CurrentSeats[$R_Index][$C_Index] = $TextInput[$R_Index][$C_Index]
    }
}

Function Copy-HashTable{
    param($Table)
    $NewTable = @{}
    foreach($Row in $Table.Keys){
        $NewTable[$Row] = $Table[$Row].Clone()
        #foreach($Column in $Table[$Row].Keys){
        #    $NewTable[$Row][$Column] = $Table[$Row][$Column]
        #}
    }
    return $NewTable
}

$LoopCounter = 0;
while($true){# -and $LoopCounter -lt 2){
    Write-Host $LoopCounter
    $NextSeats = Copy-Hashtable $CurrentSeats

    #loop through seats to update them based on the formula
    for($R_Index = 0; $R_Index -lt $CurrentSeats.Count; $R_Index += 1){
        for($C_Index = 0; $C_Index -lt $CurrentSeats[0].Count; $C_Index += 1){
            $CurrentSeat = $CurrentSeats[$R_Index][$C_Index]
        
            #If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
            if($CurrentSeat -eq "L" -and (Get-OccupiedNeighborSeats $CurrentSeats -seatRow $R_Index -seatCol $C_Index) -eq 0){
                #Write-Cells $CurrentSeats
                #Write-Host ""
                $NextSeats[$R_Index][$C_Index] = "#"
            }
            #If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
            if($CurrentSeat -eq "#" -and (Get-OccupiedNeighborSeats $CurrentSeats -seatRow $R_Index -seatCol $C_Index) -ge 5){
                $NextSeats[$R_Index][$C_Index] = "L"; 
            }
        }
    }

    #Count the number of occupied seats and check if seats match the last round
    $MatchLast = $true; $SeatCount = 0
    for($R_Index = 0; $R_Index -lt $CurrentSeats.Count -and $MatchLast; $R_Index += 1){
        for($C_Index = 0; $C_Index -lt $CurrentSeats[0].Count; $C_Index += 1){
            if($CurrentSeats[$R_Index][$C_Index] -eq "#"){
                #if the seat is occupied, count it
                $SeatCount += 1
            }
            if($CurrentSeats[$R_Index][$C_Index] -ne $NextSeats[$R_Index][$C_Index]){
                #if any seat does not equal the last round, then they do not match
                $MatchLast = $false
                break
            }
        }
    }
    
    Write-Cells $CurrentSeats #display current 
    Write-Host ""
    
    $TestSeats = $CurrentSeats.Clone() #| Select-Object -First 3
    if($MatchLast){
        $SeatCount
        #$TestSeats
        break
    }
    $CurrentSeats = $NextSeats.Clone()
    $LoopCounter += 1
}

"`nRuntime: $((New-TimeSpan -Start $StartTime -End (Get-Date)).TotalMilliseconds)ms"

<# for get occupied seats v1
   for($R_Index = -1; $R_Index -le 1; $R_Index += 1){
        for($C_Index = -1; $C_Index -le 1; $C_Index += 1){
            
            if($R_Index -eq 0 -and $C_Index -eq 0){
                continue
            }
            $Check_Row = $seatRow + $R_Index
            $Check_Col = $seatCol + $C_Index
            #"Row: $Check_Row Col: $Check_Col"
            #if spot in bounds
            if($Check_Row -ge 0 -and $Check_Col -ge 0 -and $Check_Row -lt $array.Count -and $Check_Col -lt $array[0].Length){
                
                if($array[$Check_Row][$Check_Col] -eq "#"){
                    #"Occupied"
                    $NeighborCount += 1
                }
            }
        }
    }#>