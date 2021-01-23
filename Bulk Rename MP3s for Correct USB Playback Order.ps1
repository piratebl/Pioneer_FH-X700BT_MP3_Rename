############################################################
#
# Title/Pupose: Bulk Rename MP3s for Correct USB Playback Order
#
# Author: Stephen K
#
# Date Created: 17 July 2020
#
# This script was written to address the repetitive work
# of renaming .mp3 audiobook tracks to start with a 001,
# 002, 003, etc prefix. Use of a prefix is needed for 
# correct track playback due to internal sorting putting 
# "12 Great Men 10.mp3" before "12 Great Men 1.mp3" due
# to the trailing "0" and ordering 0 after 9, not before 1.
# This issue could not be addressed via a suffix, as most
# mp3 files come with, so this script was created to add
# a three digit prefix for correct order of track playback.
#
#
# Naming Convention Reference:
#
# Bottom center of page 22 of the Pioneer FH-X700BT Manual
# https://www.pioneerelectronics.com/StaticFiles/Manuals/Car/FH-X700BT_OwnersManual112712.pdf
#
#
# Other coding references used:
#
# https://www.howtogeek.com/111859/how-to-batch-rename-files-in-windows-4-ways-to-rename-multiple-files/
#
# https://stackoverflow.com/questions/23697408/powershell-get-number-from-string
#
# https://blog.netwrix.com/2018/05/17/powershell-file-management/
#
# https://jdhitsolutions.com/blog/powershell/1953/format-leading-zeros-in-powershell/
#
# https://stackoverflow.com/questions/13126175/get-full-path-of-the-files-in-powershell
#
############################################################

cls
$path = "E:\Test" #Target path. Change to target other folders. Do not suggest using -Recurse due to not enough error handling logic and bad file naming potential.
$files = Get-ChildItem -Path $path #create list of files in target folder
foreach ($file in $files)
{   
    $newFileName = $file.Name
    $newFileName = $newFileName -replace '.mp3','' 
    $newFileName = $newFileName -replace '\D+(\d+)','$1' #Remove everything except numbers. Note, 12 Great Men 006.mp3 will become 12006. So watch for extra numbers that are not related to the track order.
    $newFileName = [int]$newFileName #Converts the string to an int. Thus 001 becomes 1.
    
    Write-Host '                        ' $newFileName '  <-- File order number'
    #Write-Host $newFileName.GetType().FullName #Get data type for trouble shooting
    $newFileName = "{0:000}" -f $newFileName #Reformat track number as int to have leading zeros. Ie, 1 becomes 001 and 33 becomes 033.
    #Write-Host $newFileName

    $newFileName = $newFileName + ' ' + $file #Parse together new track number as a prefix to old file name.
    Write-Host $newFileName '  <-- Updated file name'
    #Write-Host $newFileName.GetType().FullName #Get data type for trouble shooting

    Write-Host
    #############
    #Rename-Item $file.FullName $newFileName #Uncomment this line after fully testing to actually rename files in targeted folder.
    #############
}
