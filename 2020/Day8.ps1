cd "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020"
$TextInput = Get-Content "day8_input_test.txt"
$TextInput = Get-Content "day8_input.txt"
$tryfixindex = 0
while($tryfixindex -lt $TextInput.Count){
    
    $TextInputFix = $TextInput.Clone()
    $accumulator = 0
    $index = 0
    $hasrun = @{}
    if($TextInputFix[$tryfixindex] -like "jmp*"){
        $TextInputFix[$tryfixindex] = $TextInputFix[$tryfixindex] -replace "jmp","nop"
    }
    elseif($TextInputFix[$tryfixindex] -like "nop*"){
        $TextInputFix[$tryfixindex] = $TextInputFix[$tryfixindex] -replace "nop","jmp"
    }
    
    while(-not $hasrun[$index] -and $index -lt $TextInputFix.Count){
        $instruction_parts = $TextInputFix[$index].Split(" ")
        $instruction = $instruction_parts[0]
        $value = [int]$instruction_parts[1]
        $hasrun[$index] = $true
    
        

        switch($instruction){
            "nop" {$index += 1; break}
            "acc" {$accumulator += $value; $index += 1; break}
            "jmp" {$index += $value; break}
        }
        
    }
    Write-Host $("Index: $Index Instruction: " + $TextInputFix[$index]) -NoNewline
    Write-Host " Accumulator: $accumulator"

    if($hasrun[$index]){
        Write-Host "Quit due to loop"
    }
    if($index -ge $TextInputFix.Count){
        Write-Host "Quit due to end"
        break
    }
    $tryfixindex += 1
}