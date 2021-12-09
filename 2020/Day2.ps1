$Input = gc "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day2_input.txt"
#$Input = @(); $Input += "1-3 a: abcde"; $Input += "1-3 b: cdefg"; $Input += "2-9 c: ccccccccc"

$Count = 0
foreach($PWLine in $Input){
    $PWParams = $PWLine.split(" ")
    $Range = $PWParams[0].Split("-")
    $Char = $PWParams[1].Split(":")[0]
    $Pass = $PWParams[2]
    #$Pattern = '[' + $Char +  ']{' + $Range.Replace("-",",") + '}'
    
    Write-Host "Pass: $Pass" -ForegroundColor Yellow
    Write-Host "Char: $Char, Range: $Range"
    #Write-Host "Pattern: $Pattern"

    <# $CharCount = 0
    for($i = 0; $i -lt $Pass.Length; $i+=1){
        $CurChar = $Pass.Substring($i, 1)
        if($CurChar -eq $Char){$CharCount += 1}
    }
    Write-Host "Count: $CharCount"

    if($CharCount -ge $Range[0] -and $CharCount -le $Range[1]){
        $Count += 1
        Write-Host "Passed" -ForegroundColor Green
    }
    else{
        Write-Host "Failed" -ForegroundColor Red
    } #>

    Write-Host $Pass[$Range[0] - 1] + " " + $Pass[$Range[1] - 1]

    if($Pass[$Range[0] - 1] -eq $Char -xor $Pass[$Range[1] - 1] -eq $Char){
        $Count += 1
        Write-Host "Passed" -ForegroundColor Green
    }
    else{
        Write-Host "Failed" -ForegroundColor Red
    }
    Write-Host ""
}

$Count

#359 is too low