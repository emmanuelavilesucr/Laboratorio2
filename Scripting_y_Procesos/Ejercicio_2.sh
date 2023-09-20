#!/bin/bash

# En esta primera parte del script se establecen una pautas para ejecutar el codigo. Si el usuario ingresa mal los argumentos, el script le muestra un mensaje sobre como usar correctamente el script y posteormente el script se procede a cerrar. 

if [ $# -ne 2 ]; then                                     # Si la cantidad de argumentos introducidos por el usuario no es igual a 2
  echo "Error: Introduzca el nombre de un proceso y un comando."   # Muestre un mensaje del uso correcto del script al usuario 
  sleep 2                                                          # Espere 2 segundos
  echo "Vuelva a intentarlo...."                                   # Muestre un mensaje al usuario 
  sleep 2                                                          # Espere 2 segundos
  exit 1                                                           # Cierre el script
fi

# En esta parte se declaran las variables del script.

nombre_proceso="$1"               # Se declara una variable que recibe el nombre del proceso
comando="$2"                      # Se declara una variable que recibe un comando

# Se declaran variables para cambiar de color el texto.

color_verde="\033[32m"                           # Se establece la varible del color verde 
reset="\033[0m"                                  # Se establece una variable que le devuelve el color al texto 


# En esta parte del codigo se establece un bucle en el que dependiendo del estado del proceso indique al usuario si el proceso se esta llevando a cabo o no en el sistema. 
 
while true; do                                # Iniciar el bucle al darse la condicion true 
  if pgrep -x "$nombre_proceso" > /dev/null; then                                     # Si el proceso se encuentra en ejecucion 
    echo -e "El proceso ${color_verde}${nombre_proceso}${reset} está en ejecución."   # Muestre un mensaje al usuario de ejecucion 

  else                                                                                  # Sino
    echo -e "El proceso ${color_verde}${nombre_proceso}${reset} no está en ejecución."  # Muestre un mensaje de no ejecucion
    eval "$comando"                                                                     # Ejecute el comando como cadena de texto
  fi

  sleep 5                    # Espere 5 segundos antes de reiniciar el ciclo while
done
