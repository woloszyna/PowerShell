$Source = 'D:\Source\'
$Dupa = 'D:\Dupa\'
$File = 'TextFile.txt'
$largeFile = 'Largefilex.txt'
$Destination = 'D:\Destination\'
$modifiedDate = '01/11/2005 06:01:36'

Describe 'All operations conducted as part of the User Story xxx' {
    BeforeAll {

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
}
    context 'Source directory exists with all expected files' {
        it  'Check if D:\Source directory is created' {
            $Source | Should Exist
        }

        it 'Check if D:\Dupa does not exist' {
            $Dupa | Should Not Exist
        }
        
        it 'TextFile.txt file is successfully created in source directory' {
            $Source+$File | Should Exist
        }
    }

    context 'Destination directory exists with all expected files' {

        it 'Check if Destination directory is created' {
            $Destination | Should Exist
        }

        it 'Two files are present in D:\Destination' {
            (Get-ChildItem $Destination).Count | Should Be 2
        }

        it 'TextFile.txt was successfuly copied from the Source Destination' {
            $Destination+$File | Should Exist
        }

        it 'Large file was sucessfully created' {
            (Get-Item $Destination$largeFile).length/1KB | Should BeGreaterThan 0
        }

        it 'TextFile.txt was created on 01/11/2005 06:01:36' {
            (Get-Item $Destination$File).LastWriteTime | Should Be $modifiedDate
        }

        AfterAll {
        Remove-Item -Path $Destination -Force
        Remove-Item -Path $Source -Force
        Remove-Item -Path 'D:\log.log' -Force
        }
    }
}
