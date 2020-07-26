#! /bin/bash

#* Bash script
#*
#* Authors: Andrej Shchapaniak(), Miroslav Javorin()
#*

# bug: line 450 in main_menu  or something when type cd ~Desktop/C229/Clang sh ignores /C229/Clang and make Desktop cd

#region colors
# Set colors for for print messages
e_normal()
{
  NC='\033[0m'
  printf "${NC}$1"
}

e_white()
{
white='\033[1;37m'
printf "${white}$1"
e_normal
}

e_error()
{
red='\033[0;31m'
printf "${red}$1"
e_normal
}

e_green()
{
  green='\033[0;32m'
  printf "${green}$1"
  e_normal
}

e_orange()
{
    orange='\033[0;33m'
    printf "${orange}$1"
    e_normal
}

e_yellow()
{
    yellow='\033[0;93m'
    printf "${yellow}$1"
    e_normal
}

e_purple()
{
    purple='\033[0;35m'
    printf "${purple}$1"
    e_normal
}

e_cyan()
{
    cyan='\033[0;36m'
    printf "${cyan}$1"
    e_normal
}

e_blue()
{
    blue='\033[0;34m'
    printf "${blue}$1"
    e_normal
}
#endregion colors


#region run_in_new_terminal_window
# here are the functions for opening a terminal window with compiled program. It runs only if program has been succesfully compiled
function terminal_mac_linux_cpp() {
    OS="`uname`"
    case $OS in
      'Linux')
        case $1 in
            "compile" )
                xterm -hold -e CompiledCPP/$nameOfCompiledFile
            ;;
            "edit" )
                xterm -hold -e vim $filename
            ;;
            * )
                e_error "БЛЯ ПИЗДЕЦ АНДРЮХА НЕ РАБОТАЕТ"
        esac

        ;;
      'Darwin')
        case $1 in
            "compile" )
                open -a Terminal CompiledCPP/$nameOfCompiledFile
            ;;
            "edit" )
                vim $filename
            ;;
            * )
                e_error "БЛЯ ПИЗДЕЦ АНДРЮХА НЕ РАБОТАЕТ"
        esac
        ;;
      *) ;;
    esac
}

function terminal_mac_linux_c() {
    OS="`uname`"
    case $OS in
      'Linux')
        case $1 in
            "compile" )
                xterm -hold -e CompiledC/$nameOfCompiledFile
            ;;
            "edit" )
                xterm -hold -e vim $filename
            ;;
            * )
                e_error "БЛЯ ПИЗДЕЦ АНДРЮХА НЕ РАБОТАЕТ"
        esac

        ;;
      'Darwin')
        case $1 in
            "compile" )
                open -a Terminal CompiledC/$nameOfCompiledFile
            ;;
            "edit" )
                vim $filename
            ;;
            * )
                e_error "БЛЯ ПИЗДЕЦ АНДРЮХА НЕ РАБОТАЕТ"
        esac
        ;;
      *) ;;
    esac
}
#endregion run_in_new_terminal_window

#region  compile_mv_rmOld
function compile_mv_rmOld_run_cpp(){
    #compiles file and moves it to directory with compiled files
    clang++ -o $nameOfCompiledFile $filename # cd is the directory you etered above in terminal
    rm CompiledCPP/$nameOfCompiledFile
    mv $nameOfCompiledFile CompiledCPP/$nameOfCompiledFile
    terminal_mac_linux_cpp compile
}

function compile_mv_rmOld_run_c() {
    clang -Wall -o  $nameOfCompiledFile $filename
    rm CompiledC/$nameOfCompiledFile
    mv $nameOfCompiledFile CompiledC/$nameOfCompiledFile
    terminal_mac_linux_c compile
}
#endregion compile_mv_rmOld

#region run_file
function run_file_c() {
    clang -Wall -o  $nameOfCompiledFile $filename

    if [[ -e $nameOfCompiledFile ]]; then
        rm CompiledC/$nameOfCompiledFile
        mv $nameOfCompiledFile CompiledC/$nameOfCompiledFile
        e_cyan "Do you want to open the file?"
        echo
        e_white "[y/n]"
        echo

        switcher=0
        while [[ $switcher < 1 ]]; do
            read input
            if [ $input = 'y' ]; then
                OS="`uname`"
                case $OS in
                  'Linux')
                    xterm -hold -e CompiledC/$nameOfCompiledFile
                    ;;
                  'Darwin')
                    open -a Terminal CompiledC/$nameOfCompiledFile
                    ;;
                  *) ;;
                esac
                switcher=1
            else if [ $input = 'n' ]; then
                switcher=1
            else switcher=0
            fi
            fi
        done
    fi
}

function run_file_cpp() {
    clang++ -Wall -o  $nameOfCompiledFile $filename

    if [[ -e $nameOfCompiledFile ]]; then
        rm CompiledCPP/$nameOfCompiledFile
        #  FIXME the line above. Enter the full path instead
        mv $nameOfCompiledFile CompiledCPP/$nameOfCompiledFile
        e_cyan "Do you want to open the file?"
        echo
        e_white "[y/n]"
        echo

        switcher=0
        while [[ $switcher < 1 ]]; do
            read input
            if [ $input = 'y' ]; then
                OS="`uname`"
                # FIXME here. Also write the full path($path_to_directory) below if something doest work
                case $OS in
                  'Linux')
                    xterm -hold -e CompiledCPP/$nameOfCompiledFile
                    ;;
                  'Darwin')
                    open -a Terminal CompiledCPP/$nameOfCompiledFile
                    ;;
                  *) ;;
                esac
                switcher=1
            else if [ $input = 'n' ]; then
                switcher=1
            else switcher=0
            fi
            fi
        done

    fi

}
# endregion run_file


#region ask_user
# asks user after run_file if user wants to recompile or the files in vim and recomplile
function ask_user_c() {
    switcher=0
    while [[ $switcher < 1 ]]; do
        echo
        e_cyan "What do you want to do next? "
        echo
        e_white "1 Recompile and open file "
        echo
        e_white "2 Edit file and recompile "
        echo
        e_white "3 Change name"
        echo
        e_white "0 exit "
        echo
        read input


        if [[ $input -eq 1 ]]; then
            compile_mv_rmOld_run_c

        else if [[ $input -eq 2 ]]; then
            terminal_mac_linux_c edit
            # FIXME uncomment if something doesn work properly

            # e_cyan "Compiling starts after you enter anything... "
            # read anything

            compile_mv_rmOld_run_c compile

        else if [[ $input -eq 3 ]]; then
            change_name_c

        else if [[ $input -eq 0 ]]; then
            switcher=1
            back
        fi
        fi
        fi
        fi
    done
}

function ask_user_cpp() {
    switcher=0
    while [[ $switcher < 1 ]]; do
        echo
        e_cyan "What do you want to do next? "
        echo
        e_white "1 Recompile and open file "
        echo
        e_white "2 Change file and recompile "
        echo
        e_white "3 Change name"
        echo
        e_white "0 exit "
        echo
        read input


        if [[ $input -eq 1 ]]; then # Recompile file
            compile_mv_rmOld_run

        else if [[ $input -eq 2 ]]; then #Edit file and recompile
            terminal_mac_linux edit
            e_cyan "Compiling starts after you enter anything... "
            read anything

            compile_mv_rmOld_run_cpp compile

        else if [[ $input -eq 3 ]]; then
            change_name_cpp


        else if [[ $input -eq 0 ]]; then
            switcher=1

            back
        fi
        fi
        fi
        fi
    done
}
#endregion ask_user


#region change_name
function change_name_c()
{
    switcher=0
    while [[ $switcher < 1 ]]; do
        echo
        e_white "1 Change name of C file"
        echo
        e_white "2 Change name of compiled C file"
        echo
        e_white "3 Change both"
        echo
        e_white "0 exit"
        echo
        read input

        if [[ $input -eq 1 ]]; then
            e_cyan "Enter the new name of file:"
            echo
            read new_file_name
            mv $filename $new_file_name

            filename=$new_file_name # FIXME here is a bug

        else if [[ $input -eq 2 ]]; then
            e_cyan "Enter the new name of file:"
            echo
            read new_name_of_compiled_file
            mv CompiledC/$nameOfCompiledFile CompiledC/$new_name_of_compiled_file
            echo
            e_green "Name has been changed"
            echo

            nameOfCompiledFile=$new_name_of_compiled_file

        else if [[ $input -eq 3 ]]; then
            e_cyan "Enter the new filename with .c postfix:"
            echo
            read new_file_name
            mv $filename $new_file_name
            filename=$new_file_name


            e_cyan "Enter the new filename of compiled CPP file:"
            echo
            read new_name_of_compiled_file
            mv CompiledC/$nameOfCompiledFile CompiledC/$new_name_of_compiled_file
            nameOfCompiledFile=$new_name_of_compiled_file

            echo
            e_green "Names have been changed"
            echo

        else if [[ $input -eq 0 ]]; then
            switcher=1
            ask_user_c
        fi
        fi
        fi
        fi
    done

}

function change_name_cpp()
{
    while [[ $switcher < 1 ]]; do
        echo
        e_white "1 Change name of CPP file"
        echo
        e_white "2 Change name of compiled CPP file"
        echo
        e_white "3 Change both"
        echo
        e_white "0 exit"
        echo
        read input

        if [[ $input -eq 1 ]]; then
            e_cyan "Enter the new name of file:"
            echo
            read new_file_name
            mv $filename $new_file_name

            filename=$new_file_name


        else if [[ $input -eq 2 ]]; then
            e_cyan "Enter the new name of file:"
            echo
            read new_name_of_compiled_file
            mv CompiledCPP/$nameOfCompiledFile CompiledCPP/$new_name_of_compiled_file
            echo
            e_green "Name has been changed:"
            echo
            nameOfCompiledFile=$new_name_of_compiled_file


        else if [[ $input -eq 3 ]]; then
            e_cyan "Enter the new filename with .cpp postfix:"
            echo
            read new_file_name
            mv $filename $new_file_name
            filename=$new_file_name


            e_cyan "Enter the new filename of compiled C file:"
            echo
            read new_name_of_compiled_file
            mv CompiledCPP/$nameOfCompiledFile CompiledCPP/$new_name_of_compiled_file
            nameOfCompiledFile=$new_name_of_compiled_file

            echo
            e_green "Names have been changed"
            echo

        else if [[ $input -eq 0 ]]; then
            switcher=1
            ask_user_cpp
        fi
        fi
        fi
        fi
    done
}
#endregion change_name



#region mainmenu
function mainmenu_c() {

    echo
    e_cyan "Type the path to the directory you will work in"
    echo
    read path_to_directory
    cd

    if [ ! -d  $path_to_directory ]; then
        mkdir $path_to_directory
        cd $path_to_directory
        echo "Debug"
        mkdir CompiledC
    else
        cd $path_to_directory
        if [ ! -d  CompiledC/ ]; then
            mkdir CompiledC/
        fi
    fi

    #cd $path_to_directory


    echo

    i=0
    e_white "------------------------"
    echo
    ls -C -w | grep .c
    e_white "------------------------"
    echo
    e_cyan "Enter the name of c file you want to compile:"
    echo


    while [[ $i < 1 ]]; do
        read filename

        if [[ -e $filename ]]; then
            e_cyan "Еnter name of compiled file:"
            echo
            read nameOfCompiledFile
            run_file_c
            ask_user_c
        else
            echo
            e_error "Error "
            e_white "This file doesnt exist. Enter another namе of c file."
            echo
        fi
    done
}

function mainmenu_cpp() {
    echo
    e_cyan "Type the path to the directory you will work in"
    echo
    read path_to_directory

    if [ ! -d  $path_to_directory ]; then # cd is C229
        mkdir $path_to_directory

        cd $path_to_directory
        mkdir CompiledCPP
    else
        cd $path_to_directory
    fi

    i=0
    e_white "------------------------"
    echo
    cd $path_to_directory

    ls -C -w | grep .cpp
    echo
    e_white "------------------------"
    echo
    e_cyan "Enter the name of cpp file you want to compile:"
    echo

    while [[ $i < 1 ]]; do
        read filename
        if [[ -e $filename ]]; then

            e_cyan "Еnter name of compiled file:"
            read nameOfCompiledFile
            run_file_cpp
            ask_user_cpp

        else
            echo
            e_error "Error "
            e_white "This file doesnt exist. Enter another namе of cpp file."
            echo
        fi
    done

}
#endregion main_menu

#region main
function main() {

    piska=1
    while [[ $piska < 5 ]]; do
        e_error   "="
        e_orange  "="
        e_yellow  "="
        e_green   "="
        e_blue    "="
        e_purple  "="
        piska=$(($piska+1))

    done
    echo
    e_error "|"
    e_white " *Compile master 229* "
    e_error "|"
    echo

    piska=1
    while [[ $piska < 5 ]]; do
        e_error   "="
        e_orange  "="
        e_yellow  "="
        e_green   "="
        e_blue    "="
        e_purple  "="
        piska=$(($piska+1))

    done
    echo
    back
}
#endregion main

#region back
function back()
{
    #cd ~/Desktop/

    echo
    e_cyan "Choose language"
    echo
    e_white "1 C"
    echo
    e_white "2 C++"
    echo

    switcher=0
    while [[ $switcher < 1 ]]; do
        switcher=1
        read input
        if [[ $input -eq 1 ]]; then
            mainmenu_c
        else if [[ $input -eq 2 ]]; then
            mainmenu_cpp
        else
            switcher=0
        fi
        fi
    done
}
#endregion back


main
