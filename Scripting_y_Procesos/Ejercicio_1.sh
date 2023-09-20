#!/bin/bash 

# En esta parte el script verifica que el usuario introduzca un argumento correcto. En caso que el usuario no introduzca un argumento correcto, el script mostrara un mensaje del uso correcto del script al usuario y posteriormente se cerrara el script.  


if [ $# -ne 1 ]; then                                                # Si el numero de argumentos introducidos no es igual a uno
  echo "Error: El argumento introduccido no es valido. Este programa solo acepta un argumento." # Muestre un mensaje de error
  sleep 2                                             # Delay de 2 segundos
  echo "Vuelva a intentarlo..."                       # Muestre un mensaje 
  sleep 2                                             # Espere 2 segundos
  exit 1                                              # Cierre el script
fi
 
pid=$1                                           # Declara una variable que dicta que el primer argumento introducido es el id


# En esta parte se establece lo que debe de hacer el script en caso de ingresar el ID de un proceso no existente.


if ! ps -p $pid > /dev/null 2>&1; then           # Si el proceso del Id no se esta ejecutando  
  echo "El proceso con ID $pid no existe."       # Imprima un mensaje expresando que el proceso no existe
  sleep 2                                        # Espere 2 segundos
  exit 1                                         # Cierre el script
fi


# Se declaran variables para cambiar de color el texto.

color_verde="\033[32m"                           # Se establece la varible del color verde 
reset="\033[0m"                                  # Se establece una variable que le devuelve el color al texto 


# Obtén la información del proceso usando comandos ps y readlink  En esta parte del script se establecen una serie de variables

nombre_proceso=$(ps -p $pid -o comm=)       # Se declara una variable encargada de obtener el nombre del proceso del ID
ppid=$(ps -p $pid -o ppid=)                 # Se declara una variable encargada de obtener el parent process ID
nombre_usuario=$(ps -p $pid -o user=)       # Se declara una variable encargada de obtener el nombre del usuario
consumo_cpu=$(ps -p $pid -o %cpu=)          # Se declara una variable encargada de obtener el porcentaje de uso del cpu
consumo_memoria=$(ps -p $pid -o %mem=)      # Se declara una variable encargada de obtener el porcentaje de uso de la memoria ram
estado=$(ps -p $pid -o state=)              # Se declara una variable encargada de obtener el estado del proceso del ID 
path=$(readlink -f /proc/$pid/exe)          # Se declara una variable encargada de obtener los datos del path del ejecutable


# En esta seccion final, el script imprime un texto  con todas las variables del proceso obtenidas anteriormente.

echo -e "${color_verde}Nombre del proceso:${reset} $nombre_proceso"        # Imprima el nombre del proceso
sleep 1                                                                    # Espere 1 segundo
echo -e "${color_verde}ID del proceso:${reset} $pid"                       # Imprima el id del proceso
sleep 1                                                                    # Espere 1 segundo
echo -e "${color_verde}Parent process ID:${reset} $ppid"                   # Imprima el parent process ID
sleep 1                                                                    # Espere 1 segundo
echo -e "${color_verde}Usuario propietario:${reset} $nombre_usuario"       # Imprima el nombre del usuario
sleep 1                                                                    # Espere 1 segundo
echo -e "${color_verde}Porcentaje de uso de CPU:${reset} $consumo_cpu%"    # Imprima el porcentaje de uso del cpu
sleep 1                                                                    # Espere 1 segundo
echo -e "${color_verde}Consumo de memoria:${reset} $consumo_memoria%"      # Imprima el porcentaje e consumo de la memoria ram
sleep 1                                                                    # Espere 1 segundo
echo -e "${color_verde}Estado:${reset} $estado"                            # Imprima el estado del proceso
sleep 1                                                                    # Espere 1 segundo
echo -e "${color_verde}Path del ejecutable:${reset} $path"                 # Imprima el path del ejecutable

sleep 2                # Espere 2 segundos
exit 0                 # Cierre el script al terminar de ejecutarse correctamente 
