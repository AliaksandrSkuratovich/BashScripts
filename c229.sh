#! /bin/bash


# 2) довавить возможность рекомпилировать последний скомпилированный файл +
# 3) добавить возможность запускать редакцию файла +
# 3.1 разбросать по функциям +
# свитч между маком и линухом
# 4) добавить возможность автозаполнения строки при вводе названия файла, который хотим скомпилировать
#

e_normal() {
  NC='\033[0m'
  printf "${NC}$1"
}
e_white() {
white='\033[1;37m'
printf "${white}$1\n"
e_normal
}
e_error() {
red='\033[0;31m'
printf "${red}$1\n"
e_normal
}
e_green() {
  green='\033[0;32m'
  printf "${green}$1"
  e_normal
}

function terminal_mac_linux() {
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


function compile_mv_rmOld_run() {
    gcc -Wall -o $nameOfCompiledFile $cfileName
    rm CompiledC/$nameOfCompiledFile
    mv ~/Desktop/CLang/$nameOfCompiledFile ~/Desktop/CLang/CompiledC/$nameOfCompiledFile
    terminal_mac_linux compile
}
# asks user after run_file if user wants to recompile or change the files in vim and recomplile



function ask_user() {
    switcher=0
    while [[ $switcher < 1 ]]; do
        echo ""
        e_normal "What do you want to do next? "
        echo ""
        e_white "1 Recompile and open file "
        e_white "2 Change file and recompile "
        e_white "3 Go to the main menu "
        read input


        if [[ $input -eq 1 ]]; then # Recompile file
            compile_mv_rmOld_run

        else if [[ $input -eq 2 ]]; then #Edit file and recompile
            terminal_mac_linux edit
            e_green "Compiling starts after you enter anything... "
            read anything

            compile_mv_rmOld_run compile

        else if [[ $input -eq 3 ]]; then
            switcher=1

            mainmenu
        fi
        fi
        fi
    done
}

function run_file() {
    gcc -Wall -o $nameOfCompiledFile $cfileName

    if [[ -e $nameOfCompiledFile ]]; then
        rm CompiledC/$nameOfCompiledFile
        mv ~/Desktop/CLang/$nameOfCompiledFile ~/Desktop/CLang/CompiledC/$nameOfCompiledFile
        e_white "Do you want to open the file?"
        e_white "[y/n]"

        switcher1=0
        while [[ $switcher1 < 1 ]]; do
            read input
            if [ $input = 'y' ]; then
                OS="`uname`"
                case $OS in
                  'Linux')
                    xterm -hold -e ~/Desktop/CLang/CompiledC/$nameOfCompiledFile
                    ;;
                  'Darwin')
                    open -a Terminal ~/Desktop/CLang/CompiledC/$nameOfCompiledFile
                    ;;
                  *) ;;
                esac
                switcher1=1
            else if [ $input = 'n' ]; then
                switcher1=1
            else switcher1=0
            fi
            fi
        done

    fi

}

function mainmenu {
    e_white "------------------------"
    i=0
    while [[ $i < 1 ]]; do
        ls | grep .c
        e_white "------------------------"
        e_white "Enter the name of c file you want to compile:"

        read cfileName
        if [[ -e $cfileName ]]; then

            e_white "Еnter name of compiled file:"
            read nameOfCompiledFile
            run_file
            ask_user

        else
            echo -e "\n"
            e_error "Error "
            e_white "This file doesnt exist. Enter another namе of c file."
        fi
    done

}

main() {
    cd ~/Desktop/
    e_white "------------------------"
    e_white "| *Compile master 229* |"

    if [ ! -d "CLang/" ]; then
        mkdir CLang
        cd CLang/
        mkdir CompiledC
    else
        cd CLang/
        if [ ! -d "CompiledC/" ]; then
            mkdir CompiledC
        fi
    fi


    mainmenu
}

main
