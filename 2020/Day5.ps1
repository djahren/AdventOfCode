$TextInput = gc "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day5_input.txt"
#FBFBBFFRLR: row 44,  column 5, seat ID 357. # 44 * 8 + 5 = 357
#BFFFBBFRRR: row 70,  column 7, seat ID 567.
#FFFBBBFRRR: row 14,  column 7, seat ID 119.
#BBFFBBFRLL: row 102, column 4, seat ID 820.

function Get-BoardingPass{
    [cmdletbinding()]
    param($BinaryInput)
    $RowStart = 0; $RowEnd = 127;
    $ColStart = 0; $ColEnd = 7;
    for($I = 0; $I -lt $BinaryInput.length; $I += 1){
        $Action = $BinaryInput[$I]
        switch($Action){
            "F"{$RowEnd   = $RowEnd   - ($RowEnd - $RowStart + 1)/2; break;}
            "B"{$RowStart = $RowStart + ($RowEnd - $RowStart + 1)/2; break;}
            "L"{$ColEnd   = $ColEnd   - ($ColEnd - $ColStart + 1)/2; break;}
            "R"{$ColStart = $ColStart + ($ColEnd - $ColStart + 1)/2; break;}
        }
        if($Action -in "F","B"){
            Write-Verbose "$Action Row: $RowStart : $RowEnd"
        }
        else{
            Write-Verbose "$Action Col: $ColStart : $ColEnd"
        }
    }
    
    $SeatID = $RowStart * 8 + $ColStart
    
    Write-Verbose "Seat ID: $SeatID"
    return [PSCustomObject]@{Pass = $BinaryInput; Row = $RowStart; Col = $ColStart; SeatID = $SeatID}
}

$Passes = @()
foreach($Pass in $TextInput){
    $Passes += Get-BoardingPass $Pass 
}
$Passes = $Passes | Sort SeatID
for($I = 0; $I -lt $Passes.Length - 1; $I += 1){
    if($Passes[$I+1].SeatID -ne $Passes[$I].SeatID + 1){
        Write-Host "My seat is: $($Passes[$I].SeatID + 1)" -ForegroundColor Red
    }
}