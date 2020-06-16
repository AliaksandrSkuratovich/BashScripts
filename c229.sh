#! /bin/bash


# 4) добавить возможность автозаполнения строки при вводе названия файла, который хотим скомпилировать
#

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




function terminal_mac_linux_c() {
    OS="`uname`"
    case $OS in
      'Linux')
        case $1 in
            "compile" )
                xterm -hold -e CompiledC/$nameOfCompiledFile
            ;;
            "edit" )
                xterm -hold -e vim $cfileName
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
                vi $cfileName
            ;;
            * )
                e_error "БЛЯ ПИЗДЕЦ АНДРЮХА НЕ РАБОТАЕТ"
        esac
        ;;
      *) ;;
    esac
}


function compile_mv_rmOld_run_c() {
    clang -Wall -o $nameOfCompiledFile $cfileName
    rm CompiledC/$nameOfCompiledFile
    mv ~/Desktop/C229/CLang/$nameOfCompiledFile ~/Desktop/C229/CLang/CompiledC/$nameOfCompiledFile
    terminal_mac_linux_c compile
}
# asks user after run_file if user wants to recompile or change the files in vim and recomplile



function ask_user_c() {
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


        if [[ $input -eq 1 ]]; then
            compile_mv_rmOld_run_c

        else if [[ $input -eq 2 ]]; then
            terminal_mac_linux_c edit
            e_cyan "Compiling starts after you enter anything... "
            read anything

            compile_mv_rmOld_run_c compile

        else if [[ $input -eq 3 ]]; then
            change_name_c

        else if [[ $input -eq 0 ]]; then
            switcher=1
            mainmenu_c
        fi
        fi
        fi
        fi
    done
}

function change_name_c()
{

    switcher=0
    while [[ $switcher < 1 ]]; do
        echo
        e_white "1 Change name of C file"
        echo
        e_white "2 Change name of compiled C file"
        echo
        e_white "0 exit"
        echo
        read input

        if [[ $input -eq 1 ]]; then
            e_cyan "Enter the new name of file"
            echo
            read new_cfile_name
            mv $cfileName $new_cfile_name

            $cfileName=new_cfile_name # FIXME here is a bug


        else if [[ $input -eq 2 ]]; then
            e_cyan "Enter the new name of file"
            echo
            read new_name_of_compiled_cfile
            mv CompiledC/$nameOfCompiledFile CompiledC/$new_name_of_compiled_cfile
            echo
            e_green "Name has been changed"
            echo

            nameOfCompiledFile=$new_name_of_compiled_cfile # FIXME here is a bug


        else if [[ $input -eq 0 ]]; then
            switcher=1
            ask_user_c
        fi
        fi
        fi
    done

}

function run_file_c() {
    clang -Wall -o $nameOfCompiledFile $cfileName

    if [[ -e $nameOfCompiledFile ]]; then
        rm CompiledC/$nameOfCompiledFile
        mv ~/Desktop/C229/CLang/$nameOfCompiledFile ~/Desktop/C229/CLang/CompiledC/$nameOfCompiledFile
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
                    xterm -hold -e ~/Desktop/C229/CLang/CompiledC/$nameOfCompiledFile
                    ;;
                  'Darwin')
                    open -a Terminal ~/Desktop/C229/CLang/CompiledC/$nameOfCompiledFile
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

function mainmenu_c() {

    if [ ! -d "~/Desktop/C229/CLang/" ]; then
        mkdir CLang
        cd ~/Desktop/C229/CLang/
        mkdir CompiledC
    else
        cd CLang/
        if [ ! -d "CompiledC/" ]; then
            mkdir CompiledC
        fi
    fi

    i=0
    e_white "------------------------"
    echo
    ls | grep .c
    echo
    e_white "------------------------"
    echo
    e_cyan "Enter the name of c file you want to compile:"
    echo


    while [[ $i < 1 ]]; do

        read cfileName
        if [[ -e $cfileName ]]; then

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


########3333333333333333333333333333333333333333333333333333333333



function terminal_mac_linux_cpp() {
    OS="`uname`"
    case $OS in
      'Linux')
        case $1 in
            "compile" )
                xterm -hold -e CompiledCPP/$nameOfCompiledFile
            ;;
            "edit" )
                xterm -hold -e vim $cfileName
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
                vi $cfileName
            ;;
            * )
                e_error "БЛЯ ПИЗДЕЦ АНДРЮХА НЕ РАБОТАЕТ"
        esac
        ;;
      *) ;;
    esac
}


function compile_mv_rmOld_run_cpp() {
    clang++ -o $nameOfCompiledFile $cfileName
    rm CompiledCPP/$nameOfCompiledFile
    mv ~/Desktop/C229/CPPLang/$nameOfCompiledFile ~/Desktop/C229/CPPLang/CompiledCPP/$nameOfCompiledFile
    terminal_mac_linux_cpp compile
}
# asks user after run_file if user wants to recompile or change the files in vim and recomplile


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

            mainmenu_cpp
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
        e_white "0 exit"
        echo
        read input

        if [[ $input -eq 1 ]]; then
            e_cyan "Enter the new name of file"
            echo
            read new_cppfile_name
            mv $cfileName $new_cppfile_name

            $cfileName=new_cppfile_name # FIXME here is a bug


        else if [[ $input -eq 2 ]]; then
            e_cyan "Enter the new name of file"
            echo
            read new_name_of_compiled_cppfile
            mv CompiledCPP/$nameOfCompiledFile CompiledCPP/$new_name_of_compiled_cppfile
            echo
            e_green "Name has been changed"
            echo
            nameOfCompiledFile=$new_name_of_compiled_cppfile # FIXME here is a bug


        else if [[ $input -eq 0 ]]; then
            switcher=1
            ask_user_cpp
        fi
        fi
        fi
    done

}

function run_file_cpp() {
    clang -Wall -o $nameOfCompiledFile $cfileName

    if [[ -e $nameOfCompiledFile ]]; then
        rm CompiledCPP/$nameOfCompiledFile
        mv ~/Desktop/C229/CPPLang/$nameOfCompiledFile ~/Desktop/C229/CPPLang/CompiledCPP/$nameOfCompiledFile
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
                    xterm -hold -e ~/Desktop/C229/CPPLang/CompiledCPP/$nameOfCompiledFile
                    ;;
                  'Darwin')
                    open -a Terminal ~/Desktop/C229/CPPLang/CompiledCPP/$nameOfCompiledFile
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

function mainmenu_cpp() {

    if [ ! -d "~/Desktop/C229/CPPLang/" ]; then
        mkdir CPPLang
        cd CPPLang/
        mkdir CompiledCPP
    else
        cd ~Desktop/C229/CPPLang/
        if [ ! -d "CompiledCPP/" ]; then
            mkdir CompiledCPP
        fi
    fi
    i=0
    e_white "------------------------"
    echo
    ls | grep .cpp
    echo
    e_white "------------------------"
    echo
    e_cyan "Enter the name of cpp file you want to compile:"
    echo

    while [[ $i < 1 ]]; do
        read cfileName
        if [[ -e $cfileName ]]; then

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
##################################

function main() {
    cd ~/Desktop/

    if [ ! -d "C229/" ]; then
        mkdir C229
    fi

    cd C229/

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

main
