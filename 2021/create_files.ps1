1..25 | %{
    $Files = @{"Input" = "d$($_)_input.txt"; "TestInput" = "d$($_)_testinput.txt"; "PSScript" = "d$($_).ps1"; "PYScript" = "d$($_).py";}
    foreach($File in $Files.GetEnumerator()){
        if($File.Key -eq "PSScript"){
            if(-not (Test-Path $File.Value)){
                $Contents = '$PuzzleInput = Get-Content .\'
                $Contents += $Files.TestInput     
                $Contents += "`n`n#part1`n`n`n#part2"
                $Contents | Out-File $File.Value -Encoding unicode
            }
        } elseif($File.Key -eq "PYScript"){
            if(-not (Test-Path $File.Value)){
                $Contents = "with open('$($Files.TestInput)', 'r', encoding='utf-16') as f:`n"
                $Contents += "`tlines = [j for j in f.readlines() if j != '\n']"   
                $Contents += "`n`n#part1`n`n`n#part2"
                $Contents | Out-File $File.Value -Encoding unicode
            }
        } else { 
            if(-not (Test-Path $File.Value)){
                "" | Out-File $File.Value -Encoding unicode
            }
        }
    }
}