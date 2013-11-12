
Pasos seguidos para la creación de esta gema:

1.- Generamos el esqueleto básico de la gema con la herramienta bundle y el comando "bundle gem -b matriz". La opción -b genera la carpeta bin/ destinada a ejecutables.

2.- Añadimos al fichero .gitignore la linea " *~" para ignorar los archivos temporales generados por los editores de texto. 

3.- Modificamo el fichero matriz.spect anadiendo las gemas necesarias para el funcionamiento de nuestra librería, el enlace donde descargar la libreria y corregimos la informacion que pudiese ser incorrecta.

3.1.- Añadimos la dependencias a pruebas RSpec.

3.2.-
