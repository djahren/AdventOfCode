cd C:\Users\Ahren\Documents\WindowsPowerShell\AdventOfCode2020\
$TextInput = Get-Content .\day16_input_test.txt
$TextInput = Get-Content .\day16_input.txt

function New-Range{
    param($TextRange)   
    return [PSCustomObject]@{Low=[int]($TextRange -split "-")[0];High=[int]($TextRange -split "-")[1]}
}

function New-FieldDefinition{
    param($TextDefinition)
    $Input = $TextDefinition -split ": "
    return [PSCustomObject]@{Name=$Input[0] -replace " ", "_";Ranges=@($Input[1] -split " or " | %{New-Range $_});ValidPositions=@()}
}

function Get-Ticket{
    param($Text)
    return $Text -split "," | %{[int]$_}
}

$Definitions = $TextInput | Select-String ":" | Select-String "or" | %{New-FieldDefinition $_}
$MyTicket = ""
$NearbyTickets = @()
$InvalidValues = @()
$FieldNames = @()

$index = 0; $NearbyTicketsSection = $false
while($index -lt $TextInput.Count){
    if($NearbyTicketsSection){
        $NearbyTickets += $TextInput[$index]
    }
    elseif($TextInput[$index] -like "your ticket*"){
        $MyTicket = $TextInput[$index + 1]
    }
    elseif($TextInput[$index] -like "nearby tickets*"){
        $NearbyTicketsSection = $true
    }
    $index += 1
}

#$NearbyTickets = $NearbyTickets | Select -First 1

#$Definitions
#$MyTicket
#$NearbyTickets

#remove bad tickets
foreach($Ticket in $NearbyTickets){
    #loop through tickets
    $ValidTicket = $true
    $TicketValues = Get-Ticket $Ticket

    foreach($Value in $TicketValues){
        #$Value
        #loop through fields in the ticket
        $ValidValue = $false

        foreach($Definition in $Definitions){
            #check each field against definitions

            $ValueInDefinitionRanges = ($Value -ge $Definition.Ranges[0].Low -and $Value -le $Definition.Ranges[0].High) -or `
                ($Value -ge $Definition.Ranges[1].Low -and $Value -le $Definition.Ranges[1].High)
                
            if($ValueInDefinitionRanges){
                    #in phase 0 mark if value is valid
                    $ValidValue = $true
            }
        }
        if(-not $ValidValue){
            #if no valid value after checking all definitions, the ticket is invalid
            $InvalidValues += $Value
            $NearbyTickets = $NearbyTickets | Where {$_ -ne $Ticket} #Remove Bad Ticket
            break
        }
    }
}

$TicketScanningErrorRate = ($InvalidValues | measure -Sum).Sum; 
"Ticket error scannng rate: $TicketScanningErrorRate"

#loop through each field
foreach($Definition in $Definitions){
    $MaxFields = (Get-Ticket ($NearbyTickets | Select -First 1)).Count
    $PositionsValidForDefinition = @()
    
    for($PositionID = 0; $PositionID -lt $MaxFields; $PositionID += 1){
        #"field: $($Definition.Name) checking position: $PositionID"
        $PositionValid = $true

        foreach($Ticket in $NearbyTickets){
            $TicketValues = Get-Ticket $Ticket
            $Value = $TicketValues[$PositionID]

            $ValueInDefinitionRanges = ($Value -ge $Definition.Ranges[0].Low -and $Value -le $Definition.Ranges[0].High) -or `
                ($Value -ge $Definition.Ranges[1].Low -and $Value -le $Definition.Ranges[1].High)

            if(-not $ValueInDefinitionRanges){
                $PositionValid = $false
                break
            }

        }

        if($PositionValid){
            $PositionsValidForDefinition += $PositionID
        }
    }

    $Definition.ValidPositions = $PositionsValidForDefinition
}

#$Definitions | ConvertTo-Json -Depth 3 | Out-File .\Definitions.json

#Process of elimiation
$PositionsDone = @()
while($Definitions.ValidPositions.Count -ne $Definitions.Count){
    $SingleValidPos = $Definitions | Where {$_.ValidPositions.Count -eq 1}
    foreach($Single in $SingleValidPos | Where {$_.ValidPositions[0] -notin $PositionsDone}){
        $CurrentPosition = $Single.ValidPositions[0]
        foreach($Definition in $Definitions | Where {$_.ValidPositions -contains $CurrentPosition -and $_.Name -ne $Single.Name}){
            $Definition.ValidPositions = $Definition.ValidPositions | Where {$_ -ne $CurrentPosition}
        }
        $PositionsDone += $CurrentPosition
    }
    $Definitions; ""
}

#get required fields from my ticket
$MyTicket = Get-Ticket $MyTicket
$MultiplyTotal = 1
foreach($Position in $Definitions | Where {$_.Name -like "departure*"} | Select -ExpandProperty ValidPositions){
    $MultiplyTotal *= $MyTicket[$Position]

}
$MultiplyTotal