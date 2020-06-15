# BashScripts


This is a bash script that helps to work with compilation in the C language.
The script creates a folder on the desktop called C229 then CPPFiles and CFiles, in which C and CPP files will be stored
In the folder CFiles there is a folder CompiledC, where the compiled files are stored and the same thing for CPPFiles and CompiledCPP

The script will allow you to compile and change the name of the compiled files, recompile the files and make small changes using the vim code editor
At the beginning, the script will display you C and CPP files in the CLang folder. Next, you will be asked to chose the file name and the name of the compiled file,
which upon successful compilation will be moved to the CompiledC folder. Then you can, following the instructions, open the compiled file or edit it.

The script works with MACOS AND UBUNTU.
IMPORTANT when working with ubuntu you must have xterm installed, otherwise the script will not work

To install and run the script, download the file or repository, then execute the commands in the terminal
    `cd`

    `sudo apt install xterm`

    `sudo apt install vim`

    `vim .bash_profile`

you will open the vim code editor, in which you need to write
    
    `alias "command"="Path/to/./c229.sh"`

then you have write the changes.
    
    `chmod + x "Path / to /./ c229.sh"`

this command enables you to execute the script

Grats. you are able able to execute the script using the command "command"
