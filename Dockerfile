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
COPY ./ /

# Exponer puertos
EXPOSE 80 
EXPOSE 443

# Determinar volumen de nuestros archivos publicos
VOLUME [ "/var/www/files", "/var/www/html/public" ]

RUN chmod +x /usr/local/bin/ojs-start
CMD ["ojs-start"]
