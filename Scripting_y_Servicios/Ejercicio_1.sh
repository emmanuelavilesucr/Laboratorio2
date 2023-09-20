#!/bin/bash

# En esta primera parte se declaran las variables relacionadas al directorio.

directorio="/Escritorio/Lab2/Scripting_y_Servicios/Directorio_de_Prueba" # Se declara una variable que aberga la ruta del directorio a monitorear 
archivo="/Escritorio/Lab2/Scripting_y_Servicios/Directorio_de_Prueba/Prueba.txt" # Se declara una variable que aberga la ruta del archivo a monitorear

# Esta parte del codigo se encarga de monitorear el directorio seleccionado.

inotifywait -m -r -e create,modify,delete "$directorio" |   # Se encarga de monitorear el directorio especificado y detectar cambios
while read -r directory event file; do        # Se establece un bucle de lectura del directorio
    tiempo=$(date "+%Y-%m-%d %H:%M:%S")       # Se declara una variable encargada de almacenar la fecha y hora
    echo "[$tiempo] Evento: $event - Archivo: $file" >> "$archivo"   # Muestra los cambios en el archivo .log
done
  
