# OJS PKP Instalación
Instalación de OJS PKP con docker

## Objetivo OJS [3_3_0-14](https://github.com/pkp/ojs/tree/3_3_0-14)
![imagen](https://github.com/gouh/ojspkp/assets/13145599/df03fdfe-fedb-4d49-902d-e4f636b8477c)

## Requerimientos base
* PHP 7.3.x, 7.4.x, or 8.0.x
* MySQL >= 4.1 or PostgreSQL >= 9.5
* Apache >= 1.3.2x or >= 2.0.4x or Microsoft IIS 6
* Operating system: Any OS that supports the above software, including Linux, BSD, Solaris, Mac OS X, Windows
Puedes verlos [aquí](https://github.com/pkp/ojs/blob/3_3_0-14/docs/README.md#system-requirements)

## Creamos un dockerfile
El dockerfile lo basaremos de alpine:3.11 y utilizaremos el directorio base "/var/www/html"

## Agregamos variables de entorno de la version que requerimos de ojs, archivos de configuracion de apache y php asi como db
![imagen](https://github.com/gouh/ojspkp/assets/13145599/eec819c1-4af7-401d-9c68-404c3daffb5b)

## Agregamos servicios basicos primordialmente apache y php
![imagen](https://github.com/gouh/ojspkp/assets/13145599/c8667f9d-6b2f-4259-8402-a56a23156199)

## Requerimientos para PHP
Algunas recomendaciones para librerias de PHP las encontre en el siguiente sitio escrito por [Muhammad Hendra](https://openjournaltheme.com/docs/documentation/what-is-ojs-server-requirement#h-recommended-server-requirement)
* php-xml
* php-curl
* php-mbstring
* php-JSON
* php-mysql (use mysqli as an ojs database connection)
* php-pgsql (optional for Postgre db)
* php-gettext
* php-intl

Viendo el proyecto y a grandes rasgos pude distinguir que si eran necesarias dichas librerias sin embargo pude darme cuenta que son necesarias algunas otras mas

* php7-bcmath
* php7-bz2
* php7-calendar
* php7-ctype
* php7-curl
* php7-dom
* php7-exif
* php7-fileinfo
* php7-ftp
* php7-gettext
* php7-intl
* php7-iconv
* php7-json
* php7-mbstring
* php7-mysqli
* php7-opcache
* php7-openssl
* php7-pdo_mysql
* php7-phar
* php7-posix
* php7-session
* php7-shmop
* php7-simplexml
* php7-sockets
* php7-sysvmsg
* php7-sysvsem
* php7-sysvshm
* php7-tokenizer
* php7-xml
* php7-xmlreader
* php7-xmlwriter
* php7-zip
* php7-zlib

![imagen](https://github.com/gouh/ojspkp/assets/13145599/132e3a47-c3ca-4b3b-b4d5-85bbad6f1d7f)

## Definimos herramientas extra para construir OJS
Dado que vemos en el repositorio que tienen un package.json

![imagen](https://github.com/gouh/ojspkp/assets/13145599/91eec262-e339-4fe9-ba4d-10023da1c101)

Definimos para instalacion node y npm asi como git

![imagen](https://github.com/gouh/ojspkp/assets/13145599/48de73a6-4818-4288-9191-c86e614f934b)

## Instalamos todos los paquetes antes mencionados
![imagen](https://github.com/gouh/ojspkp/assets/13145599/d9825140-607d-40b8-a0ef-cbc14a21ca9e)

## Descargamos y configuramos con git
![imagen](https://github.com/gouh/ojspkp/assets/13145599/c98524ea-aeb5-4287-8b2d-eacd59396086)

## Instalamos composer y sus dependencias
![imagen](https://github.com/gouh/ojspkp/assets/13145599/fac1ab7f-f883-4a8a-9381-4fdb43ef6983)
![imagen](https://github.com/gouh/ojspkp/assets/13145599/6718f994-49ce-4bbe-b1f3-e3c8172995f7)

## Instalamos dependencias de node
![imagen](https://github.com/gouh/ojspkp/assets/13145599/85559f29-7c21-4088-b0bd-f60e17250e92)

## Creamos directorios base y configuración de apache
![imagen](https://github.com/gouh/ojspkp/assets/13145599/bb5785ea-b6a9-409d-97e3-0b0fe29e1303)

## Preparamos freefont
![imagen](https://github.com/gouh/ojspkp/assets/13145599/e3e548aa-6cae-46e1-adb5-b705283e5d63)

## Preparamos crontabs acorde a la documentación
![imagen](https://github.com/gouh/ojspkp/assets/13145599/9808ce2e-205d-4c77-94b6-7c516fb1330f)
![imagen](https://github.com/gouh/ojspkp/assets/13145599/e273c8ae-8e02-42f7-b3f6-f6d3bbaf5010)

## Eliminamos archivos y dependencias innecesarios
![imagen](https://github.com/gouh/ojspkp/assets/13145599/83d4dd23-93d5-401b-a049-c16e03b54140)

## Eliminamos folders innecesarios
![imagen](https://github.com/gouh/ojspkp/assets/13145599/b11ed6c5-dcfa-493c-8cae-9f628ce4af5c)

## Copiamos el contenido de la carpeta principal para recuperar informacion en caso de que se necesite
![imagen](https://github.com/gouh/ojspkp/assets/13145599/d68f3e5f-0504-4bcf-9839-ca3a52a6b10c)

## Exponemos puertos y definimos volumenes
![imagen](https://github.com/gouh/ojspkp/assets/13145599/06a34c8c-8a1d-41fc-bbc4-1f94fecf3f8a)


