$Source = 'D:\Source\'
$File = 'TextFile.txt'
$Destination = 'D:\Destination\'

New-Item -Path $Source -ItemType Directory
New-Item -Path $Source$File -ItemType File
New-Item -Path $Destination -ItemType Directory


#Copy-Item $Source'TextFile.txt' $Destination
Copy-Item $Source$File $Destination

# 1..20 | foreach { new-item -path $Destination$_.txt }

