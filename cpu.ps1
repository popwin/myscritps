
#监测cpu使用率，如果超过一定数量，则输出占用高的app
#记录哪个app吃cpu
$CpuCores=(Get-WmiObject -class Win32_processor | Measure-Object -Sum NumberOfLogicalProcessors).Sum
$loop = 0



while($true)  
{  
    #使用率
    $count = 0
    $cpuArray = @()
    [System.Collections.ArrayList]$cpuArrayList = $cpuArray

    $logdate = Get-Date -Format "MM/dd/yyyy HH:mm:ss"

    Get-Counter  -ErrorAction  SilentlyContinue -Counter '\Process(*)\% Processor Time' -SampleInterval 1 -MaxSamples 3 `
    | Select-Object -ExpandProperty CounterSamples `
    | Group-Object -Property InstanceName `
    | ForEach-Object {
            $_ | Select-Object -Property Name, @{n='AverageCV';e={($_.Group.CookedValue | Measure-Object -Average).Average}};
        } `
    | Select-Object -Property Name, @{Name="CPU_p";Expression={[Decimal]::Round(($_.AverageCV / $CpuCores), 2)}} `
    | Sort-Object -Property "CPU_p" -Descending `
    | Select-Object -First 20 `
    | foreach-Object{   
        [void]$cpuArrayList.Add($_)
    }
 
    for($index=0; $index -lt $cpuArrayList.count; $index=$index+1){ 
        #计算非idle部分的占用率      
        if(  ($cpuArrayList[$index].Name -ne '_total') -and ($cpuArrayList[$index].Name -ne 'idle')){
            $count = $count + $cpuArrayList[$index].CPU_p
        }
    }

    write-host "log time is :" $logdate
    write-host "total usage percent is"  $cpuArrayList[0].CPU_p
    write-host "process usage CPU% is " $count
    Write-Host "---------------------" 
 
    #cpu使用率大于70%停止
    if( $count -gt 70){
        write-host "WARN CPU OVERLOAD!"
        write-host "current cpu data :" 
        $cpuArrayList | ForEach-Object{
            Write-Host $_.name  "CPU%" $_.CPU_p

        }  
        break
    }


    $loop +=1   
    #Start-Sleep -Seconds 1
}


