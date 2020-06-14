#! /bin/bash



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
  printf "${green}$1\n"
  e_normal
}


function runFile( ) {
    if [[ -e $nameOfCompiledFile ]]; then
        rm CompiledC/$nameOfCompiledFile
        mv ~/Desktop/CLang/$nameOfCompiledFile ~/Desktop/CLang/CompiledC/$nameOfCompiledFile
        e_white "Do you want to open the file?"
        e_white "[y/n]"
        read input
        case $input in
            "y" | "Y")
            open -a Terminal ~/Desktop/CLang/CompiledC/$nameOfCompiledFile
            ;;
        *)
          ./ch.sh
          ;;
        esac
    echo -e "\n"
    else e_error "File hasnt been compiled "
    fi


}

###########################

echo -e "\n"
e_white "------------------------"
e_white "| *Compile master 228* |"
e_white "------------------------"
cd ~/Desktop/CLang

i=0
while [[ $i < 1 ]]; do
    ls | grep .c
    e_white "------------------------"

    e_white "Enter name of c file you want to compile:"

  read cfileName
  if [[ -e $cfileName ]]; then

    e_white "Еnter name of compiled file:"
    read nameOfCompiledFile
      if [[ -e ~/Desktop/CLang/CompiledC ]]; then
        gcc -Wall -o $nameOfCompiledFile $cfileName
            runFile $nameOfCompiledFile
      else
        mkdir ~/Desktop/CLang/CompiledC
        gcc -Wall -o $nameOfCompiledFile $cfileName
        #rm CompiledC/$nameOfCompiledFile
        #mv ~/Desktop/$nameOfCompiledFile ~/Desktop/CompiledC/$nameOfCompiledFile
        #mkdir ~/Desktop/CLang/CompiledC
        runFile $nameOfCompiledFile
      fi

  else
    echo -e "\n"
    e_white "------------------------"
    ls | grep .c
    e_white "------------------------"
    e_error "Error "
    e_white "This file doesnt exist. Enter another namе of c file."
  fi

done
