##Pasos seguidos para la creación de esta gema:

1.- Generamos el esqueleto básico de la gema con la herramienta bundle y el comando "bundle gem -b matriz". La opción -b genera la carpeta bin/ destinada a ejecutables.

2.- Añadimos al fichero .gitignore la linea " *~" para ignorar los archivos temporales generados por los editores de texto. 

3.- Modificamo el fichero matriz.spect anadiendo las gemas necesarias para el funcionamiento de nuestra librería, el enlace donde descargar la libreria y corregimos la informacion que pudiese ser incorrecta.

    3.1.- Añadimos la dependencias a pruebas RSpec.

    3.2.- No es necesario añadir dependencias a los Test pues no se riguen por una gema.

    3.3.- Se añaden las dependencias de guard.

4.- Se añade el desarrollo integrado a través de travis.

##Jerarquía y diseño de clases

###Clases 

    Racional => Clase para trabajar con numeros racionales

    Matriz => Clase de matriz generica

    MatrizEnteros < Matriz => Clase de matriz para enteros
  
    MatrizRacionales < Matriz => Clase de matriz para numeros racionales

    MatrizDispersa => Clase de matriz dispersa generica

    MatrizDispersaEnteros < MatrizDispersa => Clase de matriz dispersa para numeros enteros

    MatrizDispersaRacionales < MatrizDispersa => Clase de matriz dispersa para numeros enteros

####Métodos
![diagrama](https://raw.github.com/alu0100693386/prct09/master/design/design.png "Diagrama matrices")
