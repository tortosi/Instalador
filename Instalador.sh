#!/bin/bash
if [ ! -x /usr/bin/dialog  ];then
 echo "Parece que no tienes DIALOG instalado.
 Vamos a instalarlo para poder continuar"
sudo apt-get install dialog
fi

printf "\e[8;70;180;t"
clear
dialogo=("## INSTALADOR Y GESTOR DE SERVIDORES BASADOS EN LINUX DEBIAN Y DERIVADOS ##

A QUIEN ESTÁ DIRIGIDO EL SCRIPT
En un primer momento, el script se hizo para facilitar un poco el trabajo de creación de los servidores
a los recién llegados al mundo de Linux.
Se automatiza la instalación de todos los programas necesarios para la creación de servidores. Se crean 
las opciones para la descarga o actualización de todos los repositorios, consiguiéndolos y teniéndolos 
actualizados con un par de clics.
También se automatiza la compilación y todas las configuraciones necesarias.

Al ver las posibilidades que tenemos con el shell bash, me animé a crear nuevas opciones, consiguiendo 
una aplicación bastante completa para la gestión y administración de nuestro servidor.

De todos modos se están incorporando mejoras y nuevas funciones regularmente.

El Script está en fase Alpha todavía, por lo que puede haber fallos, de todos modos es funcional.


CONTENIDOS DEL SCRIPT:
- Instalar programas previos - esenciales.
- Obtención de todos los archivos necesarios mediante repositorios.
- Actualización de repositorios.
- Compilación del emulador sin tener que escribir ningún comando manualmente.
- DBC's, maps y vmaps - Obtención de los archivos sin necesidad de tener el juego para la extracción.
- Instalación de las bases de datos world, auth y characters.
- Disponibilidad de instalación de 3 bases de datos diferentes del world.
- Instalación de traducciones al español de eswow2.
- Copias de seguridad de las Bases de Datos.
- Configuración guiada de la tabla realmlist de la DB auth.
- Configuración guiada y automatizada de los archivos authserver.conf y worldserver.conf
- Conexión por Telnet a nuestro servidor.
- Ejecución de comandos desde los menús, de forma guiada y visual.


INSTRUCCIONES DE USO

Es necesario tener un sistema Linux Debian o basado en el. Está comprobado y funciona en Debian, 
Ubuntu, LinuxMint y LMDE.

El script está preparado para funcionar en un sistema recién instalado y limpio. También lo puedes usar
en sistemas que ya tengan software previo instalado. Funciona correctamente en ambos casos.
Partimos de la base que no sabes crear un servidor y tienes conocimientos limitados para utilizar un 
sistema Linux, de esta forma explicaré paso a paso lo que se debe hacer desde que prendes el servidor por
primera vez asta el punto final que está corriendo el emulador.

Este script está preparado para funcionar sin entorno gráfico, con Gnome y con KDE sin problemas.

1- Lo primero que debes hacer es asegurarte que tu sistema tiene por defecto el sudo activado para tus 
usuarios. Para averiguar si lo tienes activado, ve a la consola y con el usuario común escribes:
\"sudo apt-get update\" sin las comillas .Si te pide la contraseña y actualiza tus repositorios es que lo 
tienes correcto y puedes salarte el paso 2 e ir directamente al 3. Si en cambio te da un error, debes pasar 
al punto 2.


2- Abres una consola y te logueas como root escribiendo \"su\" (sin las comillas), te pedirá la contraseña.
El siguiente paso es teclear la palabra \"visudo\" (sin comillas) para poder añadir tu usuario. Se abrirá 
un editor de texto. Bajamos al final del archivo con las flechas y añadimos 
\"Tu_usuario ALL=(ALL) ALL\" (otra vez sin comillas) Donde dice Tu_usuario se supone que pones tu nombre de 
usuario en tu sistema Linux. Una vez añadida la línea guardamos el documento con la combinación de teclas
\"Ctrl\" + \"o\" y cerramos con \"Ctrl\" + \"x\". Ya hemos añadido tu usuario en los sudoers y ya nos va a
funcionar el comando sudo. De este modo ya no debemos logearnos más como root y evitamos poner en peligro
la integridad de nuestro sistema.


3- El siguiente paso es dar permisos de ejecución al archivo del script. El archivo podemos colocarlo donde
queramos, ya que está escrito con las rutas enteras de los archivos y su ubicación es indiferente. 
Supongamos que lo tenemos en el escritorio, pues abrimos la consola y vamos al escritorio escribiendo:
\"cd ~/Escritorio\" (el símbolo ~ se hace con AltGr y el nº4).
Una vez en el escritorio desde la consola tecleamos \"chmod +x Instalador.sh\"


4- Ahora ya podemos arrancar el script. Para ello escribimos \"./Instalador.sh\"


5- Al arrancar el script, lo primero que hace es preguntarnos los datos de nuestro servidor. Es necesario
contestar correctamente, ya que sirve para recabar información que necesitará para procesos posteriores y
la guarda en unas variables para cuando la necesita tirar de ella y no pedirla repetidamente. 
Algunas preguntas son:
- Nº de núcleos de procesador que tienes.
- Nombre de la base de datos de Login para el servidor.
- Nombre de la base de datos de characters para el servidor.
- Nombre de la base de datos del mundo para el servidor.
- Dirección ip de la máquina (Si ejecutan el script en el mismo servidor deben dejar localhost).
- Puerto que utiliza MySQL.
- Nombre de usuario de MySQL.
- Contraseña de MySQL.

La mayoría de las respuestas tal como están por defecto son correctas. Lo más recomendable es poner el número
correcto de cores y muy importante la contraseña de MySQL, o de lo contrario no se instalarán las bases de
datos ni se podrá realizar ninguna función sobre ellas.


6- INSTALAR PROGRAMAS PREPARACIÓIN - ESENCIALES

Este paso es el primero que debemos realizar. Lo que hace es instalar todos los programas necesarios para
descargar repositorios, actualizarlos, prepararlos para su compilación, compilarlos, librerías como ACE y
openssl, MySQL, etc... A parte también incluyo lo necesario para instalar una página web y otras cosas que 
podemos necesitar en nuestro servidor.

Al escoger la opción nos dice lo que se va a instalar. Esto consiste en dos pasos. El primero se instalan
los programas con sus dependencias necesarias, y en el segundo se instala ACE y openssl.
después de decirnos lo que va a instalar, nos pide la contraseña de root, necesaria para instalar cualquier
cosa en nuestro equipo. Toma paciencia, pués todo esto puede demorar entre 15 minutos los ordenadores más
potentes y hasta 1 hora los más modestos.


7- OBTENCIÓN O ACTUALIZACIÓN DE TODOS LOS ARCHIVOS NECESARIOS

Dentro de este apartado encontramos dos apartados, la obtención y la actualización. 
- El apartado 1 solo es para utilizar por primera vez o si se añade un nuevo repositorio, como traducciones 
a otros idiomas, nuevas bases de datos o algo parecido. Si teniendo ya descargados estos archivos se le da
por error a este apartado no ocurre nada. Simplemente no sobrescribe.

- El apartado 2 es para actualizar todos los repositorios. Una vez ya tenemos todo funcionando, si queremos
actualizar traducciones, bases de datos o el mismo core(siempre y cuando los desarrolladores hagan añadido
esas actualizaciones), escogeremos este apartado.


8- COMPILAR EL EMULADOR

Este paso es muy sencillo. Sin el script es el que trae más de cabeza a los nuevos en la emulación, pero 
con el solo es escoger la opción del menú y lo hace todo automáticamente. Cuando termina de compilar,
nos pide de nuevo la contraseña de root para escribir los archivos resultantes en su ubicación.

Si todo sale como es debido, aparecerá en nuestro directorio home la carpeta con nuestros archivos.
De todos modos todavía nos faltan algunos pasos para poder arrancar el servidor. Necesitamos las bases de 
datos, los archivos dbc, maps y vmaps, y por último los archivos de configuración.


9- DBC'S, MAPS Y VMAPS - DESCARGA Y COLOCACIÓN EN DIRECTORIO.

Un quebradero de cabeza son las DBC's, ya que para obtenerlas debemos tener el cliente de juego a la 
versión 4.0.6a y sin ninguna actualización más. Para evitar el problema que representa, he decidido 
incluir los archivos necesarios en un fichero disponible en descarga.

Simplemente debemos escoger la opción en el menú y el script se encarga de descargarlo y situar los archivos
en sus correctas ubicaciones.


10- INSTALAR LAS BASES DE DATOS

Al entrar en este apartado encontramos para instalar las 3 bases de datos necesarias para nuestro servidor.
Ellas son con sus nombres por defecto: auth, characters y world. Deben instalarse las 3 para que funcione
nuestro servidor.

Las de las cuentas de usuarios y los Pj (auth y characters), no tienen mas secreto que instalarlas y nada más,
pero con la del mundo (world) tenemos varias opciones a instalar. Ninguna es la idónea o mejor que las otras 
ya que cada una de ellas tiene alguna ventaja sobre las otras. Mi consejo es que pruebes las 3 y te quedes 
con la que más te convenza. De todos modos, puedes cambiar de una base de datos a otra sin perjudicar las
cuentas y pj creados.

Al instalar las bases de datos ya no pide ni usuario o contraseña de MySQL ya que nos lo pidió al entrar 
al programa. 
Las bases de datos se instalan con todas las actualizaciones, por lo que quedan listas para funcionar sin 
tener que realizarles ninguna más acción sobre ellas.


11- INSTALAR TRADUCCIONES AL ESPAÑOL DE ESWOW2

Aquí tenemos 2 opciones, español de España o de México. Tan solo debes escoger la traducción que necesites.


12- CONFIGURACIONES VARIAS

En este apartado tenemos varias cosas a realizar, primero encontramos el configurador de la tabla realmlist
que está en nuestra base de datos de login(auth). Los campos a configurar son:
- Nombre del reino. Es el nombre que aparecerá al momento de conectarnos
- Ip de conexión. En este paso, si quieres solo el servidor para pruebas debes dejarlo con la ip que aparece.
En caso de querer usarlo en Lan pondrás la Ip que tenga el servidor dentro de la lan y en caso de querer 
hacerlo público, pondrás tu ip pública o el nombre que tengas de dominio.
-Puerto de conexión. Este no se suele cambiar.

Ahora pasamos a configurar los archivos authserver.conf y worldserver.conf
En estos apartados lo más importante es poner correctamente los nombres que tienen las bases de datos, el
nombre de usuario y contraseña de MySQL. Estos campos son imprescindibles para que funcione. Para el resto
de opciones, id leyendo los enunciados y poniendo los valores que encontréis más oportunos para vuestro servidor.



Si realizáis estos pasos correctamente ya podréis arrancar vuestro servidor correctamente. 
Espero que os haya sido de ayuda.")


dialog --title "INFORMACIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--msgbox "\nEstos datos son necesarios para la conexión a la base de datos o para poder compilar sin problemas. \nPon valores que sean reales o de lo contrario no funcionará correctamente el script." 10 70 && clear


####################################################################
# Opciones de configuración
####################################################################

cores=$(dialog --title "DATOS DE CONEXIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--nocancel \
--inputbox "\nNº de cores que tienes en tu PC: \nValor por defecto 1" 10 51 1 2>&1 >/dev/tty)

auth=$(dialog --title "DATOS DE CONEXIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--nocancel \
--inputbox "\nBase de datos auth: \nValor por defecto auth" 10 51 auth 2>&1 >/dev/tty)

char=$(dialog --title "DATOS DE CONEXIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--nocancel \
--inputbox "\nBase de datos characters: \nValor por defecto characters" 10 51 characters 2>&1 >/dev/tty)

world=$(dialog --title "DATOS DE CONEXIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--nocancel \
--inputbox "\nBase de datos world: \nValor por defecto world" 10 51 world 2>&1 >/dev/tty)

host=$(dialog --title "DATOS DE CONEXIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--nocancel \
--inputbox "\nDirección IP del host: \nValor por defecto localhost" 10 51 localhost 2>&1 >/dev/tty)

port=$(dialog --title "DATOS DE CONEXIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--nocancel \
--inputbox "\nPuerto de MySQL: \nValor por defecto 3306" 10 51 3306 2>&1 >/dev/tty)

user=$(dialog --title "DATOS DE CONEXIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--nocancel \
--inputbox "\nUsuario de MySQL: \nValor por defecto root" 10 51 root 2>&1 >/dev/tty)

pass=$(dialog --title "DATOS DE CONEXIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--nocancel \
--insecure \
--passwordbox "\nContraseña de MySQL: " 10 51 2>&1 >/dev/tty)

dialog --title "INFORMACIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--msgbox "\nGracias por tus respuestas. Ahora ya podemos continuar con la instalación." 8 50 && clear
clear



####################################################################
# VARIABLES DE RUTAS
####################################################################

cata_es_ark=/home/`echo $USER`/Repos/esWoW2-Cata-es/Arkania
cata_mx_ark=/home/`echo $USER`/Repos/esWoW2-Cata-mx/Arkania
cata_es_sky=/home/`echo $USER`/Repos/esWoW2-Cata-es/SkyFire
cata_mx_sky=/home/`echo $USER`/Repos/esWoW2-Cata-mx/SkyFire
wotlk_es=/home/`echo $USER`/Repos/esWoW2-WoTLK-es
wotlk_mx=/home/`echo $USER`/Repos/esWoW2-WoTLK-mx
db_ark=/home/`echo $USER`/Repos/ArkDB/Databases
db_ccdb=/home/`echo $USER`/Repos/CCDB/CCDB/database/main_db/world_rebase
db_sky=/home/`echo $USER`/Repos/SkyFireDB/main_db/world
db_tdb=/home/`echo $USER`/Repos/TDB-335
db1_sky=/home/`echo $USER`/Repos/SkyFireDB/main_db/procs
db1_ark=/home/`echo $USER`/Repos/ArkDB/Databases/arkcore
db1_ark_sky=/home/`echo $USER`/Repos/ArkDB/Databases/skyfire/rebase
db_act_ark=/home/`echo $USER`/Repos/ArkCORE/sql/updates/world
db_act_sky=/home/`echo $USER`/Repos/SkyFireEMU/sql/updates/world
db_act_tri=
sqlchar_ark=/home/`echo $USER`/Repos/ArkCORE/sql/base
sqlchar_sky=/home/`echo $USER`/Repos/SkyFireEMU/sql/base
sqlchar_tri=
sqlauth_ark=/home/`echo $USER`/Repos/ArkCORE/sql/base
sqlauth_sky=/home/`echo $USER`/Repos/SkyFireEMU/sql/base
sqlauth_tri=
core_ark=/home/`echo $USER`/Repos/ArkCORE
core_sky=/home/`echo $USER`/Repos/SkyFireEMU
core_tri=
server_ark=/home/`echo $USER`/Server_ark
server_sky=/home/`echo $USER`/Server_sky
server_tri=/home/`echo $USER`/Server_tri
repos=/home/`echo $USER`/Repos
back_ark=/home/`echo $USER`/Server_ark/Backups
back_sky=/home/`echo $USER`/Server_sky/Backups
back_tri=/home/`echo $USER`/Server_tri/Backups
rep_arkcore=git clone git://github.com/Arkania/ArkCORE.git
rep_skycore=git://github.com/ProjectSkyfire/SkyFireEMU.git
rep_tricore=git://github.com/TrinityCore/TrinityCore.git
rep_arkdb=git://github.com/tortosi/ArkDB.git
rep_ccdb=git://github.com/tortosi/CCDB.git
rep_skydb=git://github.com/ProjectSkyfire/SkyFireDB.git
rep_tdb=git://github.com/tortosi/TDB-335.git
rep_cata_es=git://github.com/tortosi/esWoW2-Cata-es.git
rep_cata_mx=git://github.com/tortosi/esWoW2-Cata-mx.git
rep_wotlk_es=git://github.com/tortosi/esWoW2-WoTLK-es.git
rep_wotlk_mx=git://github.com/tortosi/esWoW2-WoTLK-mx.git
user=/home/`echo $USER`
conecta="--host=${host} --user=${user} --port=${port} --password=${pass}"
soft="php5-mysql mysql-admin mysql-client mysql-client-5.1 mysql-gui-tools-common mysql-query-browser mysql-server mysql-server-5.1 phpmyadmin apache2 apache2-doc apache2-suexec php5 libapache2-mod-php5 php-pear php5-dev php5-curl g++ gcc make cmake automake openssl mercurial zlib1g-dev libssl-dev libmysqlclient15-dev patch autoconf git git-core php5-gd libapache2-mod-auth-pam libapache2-mod-auth-mysql libbz2-dev libace-dev libmysqlclient-dev p7zip zlib1g-dev libbz2-dev gdb autoconf2.13 autoconf-archive gnu-standards autoconf-doc gettext binutils-doc g++-multilib g++-4.4-multilib gcc-4.4-doc libstdc++6-4.4-dbg gcc-multilib automake1.9 flex bison gcc-doc gcc-4.4-multilib libmudflap0-4.4-dev gcc-4.4-locales libgcc1-dbg libgomp1-dbg libmudflap0-dbg libcloog-ppl0 libppl-c2 libppl7 gdb-doc libace-doc libtao-dev glibc-doc libgd-tools libipc-sharedcache-perl libtool-doc libmcrypt-dev mcrypt libstdc++6-4.4-doc automaken gfortran fortran95-compiler gcj make-doc qct wish vim emacs kdiff3 tkdiff meld xxdiff python-mysqldb python-pygments libterm-readkey-perl tinyca postgresql-client apache apache-ssl libreadline5-dev"


#####################################################################################################
# Menú de emuladores disponibles
#####################################################################################################
dialog --title "Menú de opciones --- Creado por MSANCHO" \
--backtitle "http://linux.msgsistemes.es" \
--nocancel \
--menu "\nEmulador que deseas compilar:" 20 80 11 \
"i - Información - Guía de uso" "" \
"1 - Instalar programas preparación - esenciales" "" \
"2 - SkyFire versión 4.0.6a (13623)" "" \
"3 - ArkCORE versión 4.0.6a (13623)" "" \
"4 - Trinitycore versión 3.3.5a (12340)" "" \
"5 - Conexión por Telnet a nuestro servidor" "" \
"6 - Copias de seguridad de las Bases de Datos" "" \
"0 - Salir de la aplicación" "" 2> $user/var0
	  
opcion0=$(cat $user/var0)
	
if [ "$opcion0" = "0 - Salir de la aplicación" ]; then
	cd $user rm var*
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--msgbox "\nGracias por usar el script de instalación." 10 50
	clear
fi
	
while [ "$opcion0" != "0 - Salir de la aplicación" ]; do


####################################################################
# i - Guía de uso
####################################################################
if [ "$opcion0" = "i - Información - Guía de uso" ]; then
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "\nGuía de uso" 20 60 8 \
	"1 - Leer en pantalla" "" \
	"2 - Guardar como archivo" "" \
	"0 - Volver" "" 2> $user/var2
	  
	opcion2=$(cat $user/var2)
	

	while [ "$opcion2" != "0 - Volver" ]; do


####################################################################
# Leer en pantalla
####################################################################
	if [ "$opcion2" = "1 - Leer en pantalla" ]; then
		dialog --msgbox $dialogo 40 120


####################################################################
# Guardar como archivo
####################################################################
	elif [ "$opcion2" = "2 - Guardar como archivo" ]; then
		cp dialogo ~/Documentos
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nSe ha guardado una copia del manual en:\n/home/`echo $USER`/Documentos." 10 45 && clear
	fi


########  CONCLUSIÓN MENÚ Guía de uso  ######## 
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "\nGuía de uso" 20 60 8 \
	"1 - Leer en pantalla" "" \
	"2 - Guardar como archivo" "" \
	"0 - Volver" "" 2> $user/var2
	  
	opcion2=$(cat $user/var2)
	cd $user rm var* && rm dialogo
	done


####################################################################
# 1 - Instalar programas preparación - esenciales
####################################################################
elif [ "$opcion0" = "1 - Instalar programas preparación - esenciales" ]; then
	dialog --title "INFORMACIÓN" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--msgbox "\nProcedemos a instalar los programas necesarios para recibir los repositorios, bases de datos, MySQL, apache2, php5, compilar, librerías necesarias, etc...\n\nEste proceso puede demorar unos 5 minutos o más, dependiendo de tu equipo.\n\nProbablemete te pida algún dato para las configuraciones de MySQL." 14 70
	clear && sudo apt-get install $soft
	dialog --title "INFORMACIÓN" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--pause "\nSe han instalado los programas imprescindibles para la compilación.\n" 10 70 5
	dialog --title "INFORMACIÓN" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--msgbox "\nProcedemos a las librerias ACE y openssl. Este proceso puede demorarse más de 20 minutos en equipos rápidos y bastante más en equipos antiguos.\n\nNo desesperes! Toma paciencia" 12 70
	clear && cd /home/`echo $USER`/ && wget http://download.dre.vanderbilt.edu/previous_versions/ACE-6.0.1.tar.gz
	tar xvzf ACE-6.0.1.tar.gz && cd ACE_wrappers && mkdir build && cd build
	../configure --disable-ssl --prefix=/home/`echo $USER`/.sys/ && clear
	make -j$cores && sudo make install && cd /home/`echo $USER`/ && rm ACE-6.0.1.tar.gz && rm -R -f ACE_wrappers
	wget http://openssl.org/source/openssl-0.9.8n.tar.gz
	tar xvzf openssl-0.9.8n.tar.gz && cd openssl-0.9.8n
	./config --prefix=/home/`echo $USER`/.sys shared clear
	make -j$cores && sudo make install
	cd /home/`echo $USER`/ && rm openssl-0.9.8n.tar.gz && rm -R openssl-0.9.8n
	dialog --title "INFORMACIÓN" \
	--backtitle "http://linux.msgsistemes.es" \
	--msgbox "\nYa tenemos todo el software necesario instalado. Ya puedes seguir con los otros pasos." 8 50 && clear


#####################################################################################################
# Menú - SkyFire versión 4.0.6a (13623)
#####################################################################################################
elif [ "$opcion0" = "2 - SkyFire versión 4.0.6a (13623)" ]; then
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "\nOpciones disponibles:" 20 80 11 \
	"1 - Obtención o actualización de todos los archivos necesarios" "" \
	"2 - Compilar el emulador" "" \
	"3 - DBC's, maps y vmaps - Descarga y colocación en directorio" "" \
	"4 - Instalar las Bases de Datos" "" \
	"5 - Instalar traducciones al español de eswow2" "" \
	"6 - Configuraciones varias" "" \
	"0 - Salir de la aplicación" "" 2> $user/var1
	  
	opcion1=$(cat $user/var1)
	
	if [ "$opcion1" = "0 - Salir de la aplicación" ]; then
		cd $user rm var*
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--msgbox "\nGracias por usar el script de instalación." 10 50
		clear
		exit
	fi
	while [ "$opcion1" != "0 - Salir de la aplicación" ]; do


####################################################################
# Menú - Obtención o actualización de todos los archivos necesarios
####################################################################
	if [ "$opcion1" = "1 - Obtención o actualización de todos los archivos necesarios" ]; then
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nManejo de Repositorios y archivos" 20 60 8 \
		"1 - Descargar repositorios" "" \
		"2 - Actualizar repositorios" "" \
		"0 - Volver" "" 2> $user/var3
			  
		opcion3=$(cat $user/var3)
		cd $user rm var*
	
		while [ "$opcion3" != "0 - Volver" ]; do


####################################################################
# Descargar repositorios
####################################################################
		if [ "$opcion3" = "1 - Descargar repositorios" ]; then
			clear
			if [ ! -x /home/`echo $USER`/  ];then
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--pause "\nSe va a crear la carpeta de repositorios dentro de nuestro home" 10 50 5
				clear
				cd /home/`echo $USER`/ && mkdir Repos
			fi
			if [ ! -x /home/`echo $USER`/Repos/SkyFireEMU  ];then
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--pause "\nVamos a obtener los repositorios de SkyFireEMU" 10 50 5
				clear
				cd $repos && git clone $rep_skycore
			fi
			if [ ! -x /home/`echo $USER`/Repos/ArkDB  ];then
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--pause "\nVamos a descargar los repositorios de ArkDB." 10 50 5
				clear
				cd $repos && git clone $rep_arkdb
			fi
			if [ ! -x /home/`echo $USER`/Repos/CCDB  ];then
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--nocancel \
				--pause "\nAhora descargamos los repositorios de CCDB" 10 50 5
				clear
				cd $repos && git clone $rep_ccdb
			fi
			if [ ! -x /home/`echo $USER`/Repos/SkyFireDB  ];then
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--pause "\nAhora descargamos los repositorios de SkyFireDB" 10 50 5
				clear
				cd $repos && git clone $rep_skydb
			fi
			if [ ! -x /home/`echo $USER`/Repos/esWoW2-Cata-es  ];then
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--pause "\nLas traducciones en español para España" 10 50 5
				clear
				cd $repos && git clone $rep_cata_es
			fi
			if [ ! -x /home/`echo $USER`/Repos/esWoW2-Cata-mx  ];then
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--pause "\ny finalmente las traducciones en español para Latino-América." 10 50 5
				clear
				cd $repos && git clone $rep_cata_mx
			fi
			if [ ! -x $core_sky/build  ];then
				cd $core_sky && mkdir build
			fi
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nTodos los repositorios están descargados." 8 50
			clear


####################################################################
# Actualizar repositorios 
####################################################################
		elif [ "$opcion3" = "2 - Actualizar repositorios" ]; then
			cd $core_sky && git pull origin master
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--pause "\nRepositorios del core actualizados." 10 50 5
			clear
			cd $repos/CCDB && git pull origin master
			cd $repos/ArkDB && git pull origin master
			cd $repos/SkyFireDB && git pull origin master
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--pause "\nRepositorios de las bases de datos actualizados." 10 50 5
			clear
			cd $repos/esWoW2-Cata-es && git pull origin master
			cd $repos/esWoW2-Cata-mx && git pull origin master
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--pause "\nRepositorios de las traducciones actualizados." 10 50 5
			clear
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nTodos los repositorios han sido actualizados." 8 50
			clear
		fi


########  CONCLUSIÓN MENÚ Obtención o actualización de todos los archivos necesarios  ########  
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nManejo de Repositorios y archivos" 20 60 8 \
		"1 - Descargar repositorios" "" \
		"2 - Actualizar repositorios" "" \
		"0 - Volver" "" 2> $user/var3
		
		opcion3=$(cat $user/var3)
		cd $user rm var*
		done
	fi


########  CONCLUSIÓN MENÚ SkyFire versión 4.0.6a (13623)  ######## 
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "\nOpciones disponibles:" 20 80 11 \
	"1 - Obtención o actualización de todos los archivos necesarios" "" \
	"2 - Compilar el emulador" "" \
	"3 - DBC's, maps y vmaps - Descarga y colocación en directorio" "" \
	"4 - Instalar las Bases de Datos" "" \
	"5 - Instalar traducciones al español de eswow2" "" \
	"6 - Configuraciones varias" "" \
	"0 - Salir de la aplicación" "" 2> $user/var1
	  
	opcion1=$(cat $user/var1)
	if [ "$opcion1" = "0 - Salir de la aplicación" ]; then
		cd $user rm var*
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nGracias por usar el script de instalación." 10 50
		exit
	fi
	done

#####################################################################################################
# Menú - ArkCORE versión 4.0.6a (13623)
#####################################################################################################

elif [ "$opcion0" = "3 - ArkCORE versión 4.0.6a (13623)" ]; then
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "\nMenú de ArkCORE - Opciones disponibles:" 20 80 11 \
	"1 - Obtención o actualización de todos los archivos necesarios" "" \
	"2 - Compilar el emulador" "" \
	"3 - DBC's, maps y vmaps - Descarga y colocación en directorio" "" \
	"4 - Instalar las Bases de Datos" "" \
	"5 - Instalar traducciones al español de eswow2" "" \
	"6 - Configuraciones varias" "" \
	"0 - Salir de la aplicación" "" 2> $user/var30
	  
	opcion30=$(cat $user/var30)
	
	if [ "$opcion30" = "0 - Salir de la aplicación" ]; then
		cd $user rm var*
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--msgbox "\nGracias por usar el script de instalación." 10 50
		clear
		exit
	fi
	while [ "$opcion30" != "0 - Salir de la aplicación" ]; do



	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "\nOpciones disponibles:" 20 80 11 \
	"1 - Obtención o actualización de todos los archivos necesarios" "" \
	"2 - Compilar el emulador" "" \
	"3 - DBC's, maps y vmaps - Descarga y colocación en directorio" "" \
	"4 - Instalar las Bases de Datos" "" \
	"5 - Instalar traducciones al español de eswow2" "" \
	"6 - Configuraciones varias" "" \
	"0 - Salir de la aplicación" "" 2> $user/var30
		  
	opcion30=$(cat $user/var30)
	cd $user rm var*
	if [ "$opcion30" = "0 - Salir de la aplicación" ]; then
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nGracias por usar el script de instalación." 10 50
		clear
		exit
	fi
	done


#####################################################################################################
# Menú - Trinitycore versión 3.3.5a (12340)
#####################################################################################################

elif [ "$opcion0" = "4 - Trinitycore versión 3.3.5a (12340)" ]; then
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--msgbox "\nTodavía no tenemos preparado el script para Trinitycore, pero en breve lo tendrás a tu disposición" 10 50
	clear
fi


#####################################################################################################
# FINAL Menú de emuladores disponibles
#####################################################################################################

dialog --title "Menú de opciones --- Creado por MSANCHO" \
--backtitle "http://linux.msgsistemes.es" \
--nocancel \
--menu "\nEmulador que deseas compilar:" 20 80 11 \
"i - Información - Guía de uso" "" \
"1 - Instalar programas preparación - esenciales" "" \
"2 - SkyFire versión 4.0.6a (13623)" "" \
"3 - ArkCORE versión 4.0.6a (13623)" "" \
"4 - Trinitycore versión 3.3.5a (12340)" "" \
"5 - Conexión por Telnet a nuestro servidor" "" \
"6 - Copias de seguridad de las Bases de Datos" "" \
"0 - Salir de la aplicación" "" 2> $user/var0
	  
opcion0=$(cat $user/var0)
cd $user rm var*
if [ "$opcion0" = "0 - Salir de la aplicación" ]; then
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--msgbox "\nGracias por usar el script de instalación." 10 50
	clear
fi
done


