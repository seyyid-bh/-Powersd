function getarg($myargs) {
    $url=$myargs[1]
    $inputfile=$myargs[3]
    $outputfile=$myargs[5]
    Write-Host "*************************************"
    Write-Host "your URL is: $url"
    Write-Host "your input file is: $inputfile"
    Write-Host "your output file is: $outputfile"
    Write-Host "*************************************"
    Write-Host "Attacking..."

    #getinputfile $inputfile $url $outputfile
}


function getinputfile($myurl,$myfile,$myoutfile){
    $i=1
    foreach($line in Get-Content $myfile) {
        $mylink="$myurl/$line"
        $mystatus=checkurl($mylink)
        $result="$i : $mylink ===>($mystatus)"
        Write-Host $result 
        $total="$total </br> <a href=""http://$mylink"" target=""_blank""> $mylink</a> ===>($mystatus)"
        $i++
    }
    outputfile $myoutfile $total
}

function checkurl($mylink){
    try
    {
        $Response = Invoke-WebRequest -Uri $mylink -ErrorAction Stop
        $StatusCode = $Response.StatusCode
    }
    catch
    {
        $StatusCode = $_.Exception.Response.StatusCode.value__
    }
    $StatusCode   
}

function outputfile($myoutputfile,$mydata){
    
    $mydata | out-file -FilePath $myoutputfile
}

if ($args.Count -eq 6){
    getarg $args
    getinputfile $args[1] $args[3] $args[5]
}else{
    Write-Host "
        your arguments is not valid.please use this statement:
            powersd -u yoururl -i inputfile -o outputfile
        "
}
