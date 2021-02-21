$Source = 'D:\Source\'
$File = 'TextFile.txt'
$Destination = 'D:\Destination\'
$fileSize = 200000000 #200MB
$logLoc = 'D:\log.log'
$modifiedDate = '01/11/2005 06:01:36'

New-Item -Path $Source -ItemType Directory
New-Item -Path $Source$File -ItemType File
New-Item -Path $Destination -ItemType Directory
#Create a file of particulat=r size (bytes). Might take a lot of resources to create`
fsutil file createNew $Destination'Largefilex.txt' $fileSize

#Add content to the file
Set-Content -Path $Destination'Largefilex.txt' -Value 'This file has a size of'

#Set the property of the file - ReadOnly
Set-ItemProperty -Path $Destination'LargeFilex.txt' -Name IsReadOnly -Value $true

#Copy file from source to destination
Copy-Item $Source'TextFile.txt' $Destination
 
#updating file's modified date
$newDate = Get-Item $Destination$File
$newDate.LastWriteTime = $modifiedDate

#Copy-Item $Source$File $Destination

#Create log:
New-Item -Path $logLoc -ItemType File
Set-Content -Path $logLoc -Value 'Blah Blah Blah Blah Blah Blah Blah Blah.'

#1..20 | foreach { new-item -path $Destination$_.txt }