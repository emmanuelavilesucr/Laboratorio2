#!/bin/bash

# En esta primera parte del script se establecen una pautas para ejecutar el codigo. Si el usuario ingresa mal los argumentos, el script le muestra un mensaje de error al ejecutar el script y posteriormente el script se procede a cerrar. 

if [ $# -ne 1 ]; then                             # Si el numero de argumentos introducidos no es igual a 1
    echo "Error: Utilice un solo argumento."      # Muestre un mensaje de error al usuario
    sleep 2                                       # Espere 2 segundos
    echo "Vuelva a intentarlo ...."               # Muestre un mensaje 
    exit 1                                        # Cierre el script
fi

# En esta parte del codigo se declaran las variables del script.

ejecutable="$1"            # Se declara una variable que en la toma como el primer argumento introducido como el archivo ejecuatable
log_file="registro_consumo.log"   # Se declara una varible que almacena en un archivo .log el consumo del CPU 
pid_file="pid.txt"                 # Se declara una varible que almacena ID del proceso en un archivo de texto

# Esta parte del codigo se encarga de iniciar el proceso en un segundo plano y registrar su PID.

$ejecutable &
echo $! > "$pid_file"       

# En esta parte del script se declara una función cuya fin es obtener el uso de CPU en el proceso.

obtener_uso() {                                     # Se declara la funcion obtener_uso()
    tiempo_actual=$(date "+%Y-%m-%d %H:%M:%S")      # Se declara una variable que almacena el tiempo de uso del script
    proceso_id=$(cat "$pid_file")                   # Se declara una variable encargada de leer el contenido de pid_file

    if [ -n "$proceso_id" ]; then                                                                                                           uso_cpu=$(ps -p $proceso_id -o %cpu | tail -n 1)             # Se declara la variable que almacena el consumo del CPU               uso_memoria=$(ps -p $proceso_id -o %mem | tail -n 1)         # Se declara la variable que almacena el consumo de la memoria
       echo "$tiempo_actual $uso_cpu $uso_memoria" >> "$log_file"    # Muestre un mensaje en archivo 
    fi
}

# Esta parte del codigo se encarga de monitorear y registrar el uso de CPU periodicamente mediante el uso de un ciclo while.

while true; do                 # Se declara un bucle en dado caso que la condicion sea True
    obtener_uso                # Llame a la funcion obtener_uso()
    echo "Generando recopilacion de datos del consumo del CPU..."  # Muestre un mensaje sobre la recopilacion del consumo del CPU
    echo "Guardando consumo en archivo .log"                       # Muestre un mensaje
    sleep 2                                                        # Espere 2 segundos para realizar muestreo
done


