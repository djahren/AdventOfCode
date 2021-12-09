$TextInput = gc "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day6_input.txt"
#$TextInput = gc "D:\Users\Ahren\Documents\WindowsPowershell\AdventOfCode2020\day6_input_test.txt"

#Compile answers to single line
$GroupAnswers = @(); $GroupAnswerContents = @(); $GroupID = 0
foreach($Line in $TextInput){
    if($Line -ne ""){
        $GroupAnswerContents += $Line
    }
    else{       
        $GroupAnswers += [PSCustomObject]@{GroupID=$GroupID; Answers=$GroupAnswerContents;}
        $GroupID += 1
        $GroupAnswerContents = @()
    }
}
if($Line -ne ""){
    $GroupAnswers += [PSCustomObject]@{GroupID=$GroupID; Answers=$GroupAnswerContents} #add last
}

#$GroupAnswers | FT
#$GroupAnswers = [PSCustomObject]@{GroupID=$GroupID; Answers=@("ac","ab")};

#Count answers per group
$Total = 0
foreach($Group in $GroupAnswers){
    $AnswerCount = @{}
    $AmountInGroup = $Group.Answers.Count
    $AnswerString = $Group.Answers -join ""
    for($I = 0; $I -lt $AnswerString.Length; $I += 1){
        $Answer = $AnswerString[$I]
        if(-not $AnswerCount[$Answer]){
            $AnswerCount[$Answer] = 1
        }
        else{
            $AnswerCount[$Answer] += 1
        }
    }
    $Group | FT
    $AmountInGroup
    $AnswerCount | FT
    $AnswerCount.Values | %{if($_ -eq $AmountInGroup){$Total += 1}}
}
$Total