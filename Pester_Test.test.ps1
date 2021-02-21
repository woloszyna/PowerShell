$Source = 'D:\Source\'
$Dupa = 'D:\Dupa\'
$File = 'TextFile.txt'
$largeFile = 'Largefilex.txt'
$Destination = 'D:\Destination\'
$fileSize = 200000000 #200MB
$logLoc = 'D:\log.log'
$modifiedDate = '01/11/2005 06:01:36'

Describe 'All operations conducted as part of the User Story xxx' {
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
    }
}