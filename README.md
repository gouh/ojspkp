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

## Definimos una configuracion para apache en "root/etc/php7/conf.d"
```text
post_max_size = 30M
file_uploads = On
upload_max_filesize = 50M
opcache_memory_consumption = 512
opcache_interned_strings_buffer = 8
opcache_max_accelerated_files = 4000
opcache_revalidate_freq = 60
opcache_fast_shutdown = 1
opcache_max_file_size = 0
opcache_enable_cli = 1
```

## Definimos una configuracion para apache en "root/etc/apache2/conf.d"
```apache
LoadModule slotmem_shm_module modules/mod_slotmem_shm.so
LoadModule rewrite_module modules/mod_rewrite.so
LoadModule expires_module modules/mod_expires.so

<VirtualHost *:80>
	ServerName www.example.com
	DocumentRoot /var/www/html
	
	RewriteEngine on
	AcceptPathInfo On
	<Directory /var/www/html>
		Options FollowSymLinks
		AllowOverride all
		Allow from all
	        
		# This removes index.php from the url
		RewriteCond %{REQUEST_FILENAME} !-d 
		RewriteCond %{REQUEST_FILENAME} !-f 
		RewriteRule ^(.*)$ index.php/$1 [QSA,L]
	</Directory>

    ErrorLog  /var/log/apache2/error.log  
    CustomLog  /var/log/apache2/access.log combined
</VirtualHost>
<VirtualHost *:443>
	ServerName www.example.com
	DocumentRoot /var/www/html
	
	SSLEngine on
    SSLCertificateFile /etc/ssl/apache2/server.pem
    SSLCertificateKeyFile /etc/ssl/apache2/server.key
	
	PassEnv HTTPS
	RewriteEngine on
	AcceptPathInfo On
	<Directory /var/www/html>
		Options FollowSymLinks
		AllowOverride all
		Allow from all
	        
		# This removes index.php from the url
		RewriteCond %{REQUEST_FILENAME} !-d 
		RewriteCond %{REQUEST_FILENAME} !-f 
		RewriteRule ^(.*)$ index.php/$1 [QSA,L]
	</Directory>

    ErrorLog  /var/log/apache2/error.log  
    CustomLog  /var/log/apache2/access.log combined
</VirtualHost>
```

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

## El resultado de nuestro dockerfile es el siguiente
```dockerfile
FROM alpine:3.11

WORKDIR /var/www/html

# Configuraciones base de datos y super usuario de composer asi como archivos de configuracion apache y config
ENV COMPOSER_ALLOW_SUPERUSER=1  \
	SERVERNAME="localhost"      \
	HTTPS="on"                  \
	OJS_VERSION=3_3_0-14 \
	OJS_CLI_INSTALL="0"         \
	OJS_DB_HOST="ojs_db_journal"     \
	OJS_DB_USER="ojs"           \
	OJS_DB_PASSWORD="ojs"       \
	OJS_DB_NAME="ojs"           \
	OJS_WEB_CONF="/etc/apache2/conf.d/ojs.conf"	\
	OJS_CONF="/var/www/html/config.inc.php"


# directorio de PHP
ENV PHP_INI_DIR /etc/php/7.3

# Servicios basicos
ENV PACKAGES 		\
	apache2 		\
	apache2-ssl 	\
	apache2-utils 	\
	ca-certificates \
	curl 			\
	ttf-freefont	\
	dcron 			\
	patch			\
	php7			\
	php7-apache2	\
	runit

# Extensiones de php
ENV PHP_EXTENSIONS	\
	php7-bcmath		\
	php7-bz2		\
	php7-calendar	\
	php7-ctype		\
	php7-curl		\
	php7-dom		\
	php7-exif		\
	php7-fileinfo	\
	php7-ftp		\
	php7-gettext	\
	php7-intl		\
	php7-iconv		\
	php7-json		\
	php7-mbstring	\
	php7-mysqli		\
	php7-opcache	\
	php7-openssl	\
	php7-pdo_mysql	\
	php7-phar		\
	php7-posix		\
	php7-session	\
	php7-shmop		\
	php7-simplexml	\
	php7-sockets	\
	php7-sysvmsg	\
	php7-sysvsem	\
	php7-sysvshm	\
	php7-tokenizer	\
	php7-xml		\
	php7-xmlreader	\
	php7-xmlwriter	\
	php7-zip		\
	php7-zlib

# Herramientas para construir ojs
ENV BUILDERS 		\
	git 			\
	nodejs 			\
	npm

# Listado de datos a excluir
COPY exclude.list /tmp/exclude.list

RUN set -xe \
	&& apk add --no-cache --virtual .build-deps $BUILDERS \
	&& apk add --no-cache $PACKAGES \
	&& apk add --no-cache $PHP_EXTENSIONS \
# Construir OJS:
	# descargar y configurar con git
	&& git config --global url.https://.insteadOf git:// \
	&& git config --global advice.detachedHead false \
	&& git clone --depth 1 --single-branch --branch $OJS_VERSION --progress https://github.com/pkp/ojs.git . \
	&& git submodule update --init --recursive >/dev/null \

	# Composer vudu:
 	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer.phar \

	# Instalar dependencias de composer:
 	&& composer.phar --working-dir=lib/pkp install --no-dev \
 	&& composer.phar --working-dir=plugins/paymethod/paypal install --no-dev \
	&& composer.phar --working-dir=plugins/generic/citationStyleLanguage install --no-dev \
	
	# Instalamos dependencias de node
	&& npm install -y && npm run build \


	# Crear directorios
 	&& mkdir -p /var/www/files /run/apache2  \
	&& cp config.TEMPLATE.inc.php config.inc.php \
	&& chown -R apache:apache /var/www/* \

	# Preparar freefont
	&& ln -s /usr/share/fonts/TTF/FreeSerif.ttf /usr/share/fonts/FreeSerif.ttf \
	
	# Preparar crontabs
	&& echo "0 * * * *   ojs-run-scheduled" | crontab - \

	# Preparar configuracion apache httpd.conf
	&& sed -i -e '\#<Directory />#,\#</Directory>#d' /etc/apache2/httpd.conf \
	&& sed -i -e "s/^ServerSignature.*/ServerSignature Off/" /etc/apache2/httpd.conf \

	# Limpiar imagen con exclude.list
	&& cd /var/www/html \
 	&& rm -rf $(cat /tmp/exclude.list) \
	&& apk del --no-cache .build-deps \
	&& rm -rf /tmp/* \
	&& rm -rf /root/.cache/* \

	# Eliminando folders y archivos no requeridos
	&& find . -name ".git" -exec rm -Rf '{}' \; \
	&& find . -name ".travis.yml" -exec rm -Rf '{}' \; \
	&& find . -name "test" -exec rm -Rf '{}' \; \
	&& find . \( -name .gitignore -o -name .gitmodules -o -name .keepme \) -exec rm -Rf '{}' \;

# Copiar el contenido de nuestra carpeta principal
COPY root/ /

# Exponer puertos
EXPOSE 80 
EXPOSE 443

# Determinar volumen de nuestros archivos publicos
VOLUME [ "/var/www/files", "/var/www/html/public" ]

RUN chmod +x /usr/local/bin/ojs-start
CMD ["ojs-start"]

```

## Por ultimo preparamos un docker compose con mariadb y nuestro dockerfile
```yaml
version: "3.6"

networks:
  inside:
    external: false

services:
  db:
    image: mariadb:10.2
    container_name: "ojs_db_${COMPOSE_PROJECT_NAME:-demo}"
    environment:
      MYSQL_ROOT_PASSWORD: "${MYSQL_ROOT_PASSWORD:-ojsPwd}"
      MYSQL_DATABASE: "${MYSQL_DATABASE:-ojs}"
      MYSQL_USER: "${MYSQL_USER:-ojs}"
      MYSQL_PASSWORD: "${MYSQL_PASSWORD:-ojsPwd}"
    networks:
      - inside
    restart: always

  ojs:
    build: .
    container_name: "ojs_app_${COMPOSE_PROJECT_NAME:-demo}"
    hostname: "${COMPOSE_PROJECT_NAME:-demo}"
    ports:
      - "${HTTP_PORT:-8081}:80"
      - "${HTTPS_PORT:-443}:443"
    networks:
      - inside
    depends_on:
      - db
    restart: always

```

## Estas son las variables que utilizaremos con nuesto docker-compose
```env
COMPOSE_PROJECT_NAME=journal
PROJECT_DOMAIN=journal.localhost
SERVERNAME=$PROJECT_DOMAIN

HTTP_PORT=8081
HTTPS_PORT=8481
ADMINER_HTTP=9081

MYSQL_ROOT_PASSWORD=root
MYSQL_USER=ojs
MYSQL_PASSWORD=ojs
MYSQL_DATABASE=ojs

OJS_CLI_INSTALL=0
OJS_DB_HOST=db
OJS_DB_DRIVER=mysqli
OJS_DB_USER=ojs 
OJS_DB_PASSWORD=ojs 
OJS_DB_NAME=ojs 
```

