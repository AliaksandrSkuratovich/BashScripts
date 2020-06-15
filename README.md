# BashScripts
This is a bash script that helps to work with compilation in the C language.
The script creates a folder on the desktop called CFiles, in which C files will be stored
In the folder CFiles there is a folder CompiledC, where the compiled files are stored\n\n

The script will allow you to compile and change the name of the compiled files, recompile the files and make small changes using the vim code editor\n
At the beginning, the script will display you C files in the CLang folder. Next, you will be asked to chose the file name and the name of the compiled file,\n
which upon successful compilation will be moved to the CompiledC folder. Then you can, following the instructions, open the compiled file or edit it.\n\n

The script works with MACOS AND UBUNTU. \n
IMPORTANT when working with ubuntu you must have xterm installed, otherwise the script will not work\n\n

To install and run the script, download the file or repository, then execute the commands in the terminal\n
\t`cd`\n
\t`sudo apt install xterm`\n
\t`sudo apt install vim`\n
\t`vim .bash_profile`\n
you will open the vim code editor, in which you need to write\n
\t`alias "command"="Path/to/./c229.sh"`\n
then you have write the changes.\n 
\t`chmod + x "Path / to /./ c229.sh"`\n
this command enables you to execute the script\n\n

Grats. you are able able to execute the script using the command "command"
