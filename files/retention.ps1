 $res = gci | Where-Object { $_.PSIsContainer} | Sort-Object CreationTime

 $folderlist = New-Object System.Collections.ArrayList(,$res)

Write-Host "folder count is " $folderlist.Count

 while ($folderlist.Count -gt 5) 
 {
     Remove-Item $folderlist[0].FullName
     $folderlist.RemoveAt(0)
 }
