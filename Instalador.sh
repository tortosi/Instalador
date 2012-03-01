#!/bin/bash
if [ ! -x /usr/bin/dialog  ];then
 echo "Parece que no tienes DIALOG instalado.
 Vamos a instalarlo para poder continuar"
sudo apt-get install dialog
fi
printf "\e[8;70;180;t"
clear
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
rep_arkcore=git://github.com/Arkania/ArkCORE.git
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
"9 - PRÓXIMAMENTE - Crea tu web de registro de cuentas" "" \
"0 - Salir de la aplicación" "" 2> ~/var0
	  
opcion0=$(cat ~/var0)
	
if [ "$opcion0" = "0 - Salir de la aplicación" ]; then
	rm ~/var*
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
	"0 - Volver" "" 2> ~/var2
	  
	opcion2=$(cat ~/var2)
	rm ~/var*

	while [ "$opcion2" != "0 - Volver" ]; do


####################################################################
# Leer en pantalla
####################################################################
	if [ "$opcion2" = "1 - Leer en pantalla" ]; then
		clear
		cd ~/ && wget https://github.com/downloads/tortosi/Instalador/manual.txt
		dialog --textbox manual.txt 40 120
		rm ~/manual*.txt


####################################################################
# Guardar como archivo
####################################################################
	elif [ "$opcion2" = "2 - Guardar como archivo" ]; then
		clear
		cd ~/Documentos && wget https://github.com/downloads/tortosi/Instalador/manual.txt
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
	"0 - Volver" "" 2> ~/var2
	  
	opcion2=$(cat ~/var2)
	rm ~/var*
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
	"0 - Salir de la aplicación" "" 2> ~/var1
	  
	opcion1=$(cat ~/var1)
	
	if [ "$opcion1" = "0 - Salir de la aplicación" ]; then
		rm ~/var*
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
		"0 - Volver" "" 2> ~/var3
			  
		opcion3=$(cat ~/var3)
		rm ~/var*
	
		while [ "$opcion3" != "0 - Volver" ]; do


####################################################################
# Descargar repositorios
####################################################################
		if [ "$opcion3" = "1 - Descargar repositorios" ]; then
			clear
			if [ ! -x /home/`echo $USER`/Repos  ];then
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
		"0 - Volver" "" 2> ~/var3
		
		opcion3=$(cat ~/var3)
		rm ~/var*
		done


####################################################################
# Compilar el emulador
####################################################################
	elif [ "$opcion1" = "2 - Compilar el emulador" ]; then
		if [ ! -x $core_sky/build  ];then
			cd $core_sky && mkdir build
		fi
		if [ ! -x $server_sky  ];then
			cd /home/`echo $USER`/ && mkdir Server_sky
		fi
		if [ ! -x $server_sky/Backups  ];then
			cd $server_sky && mkdir Backups
		fi
		if [ ! -x $server_sky/logs  ];then
			cd $server_sky && mkdir logs
		fi
		cd $core_sky/build  && clear
		cmake ../ -DPREFIX=/home/`echo $USER`/Server_sky
		make -j$cores && sudo make install
		sudo chown -R `echo $USER` $server_sky
		if [ ! -x $server_sky/bin/world.pid  ];then
			echo "123456" >> $server_sky/bin/world.pid
		fi
		
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nHas terminado de compilar tu emulador. Si todo ha salido correctamete lo encontrarás en tu home, dentro de la carpeta Server_sky" 8 50
		clear


####################################################################
# DBC's, maps y vmaps - Descarga y colocación en directorio
####################################################################
	elif [ "$opcion1" = "3 - DBC's, maps y vmaps - Descarga y colocación en directorio" ]; then
		if [ ! -x $server_sky/data  ];then
			clear && cd $server_sky
			wget http://dl.dropbox.com/u/62758511/data.tar.gz
			tar xvzf data.tar.gz && rm data.tar.gz
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nSe ha creado una carpeta llamada data con las dbc, maps y vmaps en su interior" 8 50
			clear
		else
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nYa está la carpeta data creada y no se han descargado los archivos.\n\nSi deseas reinstalarlos de nuevo, borra la carpeta data de tu directorio del servidor y ejecuta de nuevo este mismo paso" 12 50
		fi


####################################################################
# Instalar las Bases de Datos
####################################################################
	elif [ "$opcion1" = "4 - Instalar las Bases de Datos" ]; then
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nInstalar las Bases de Datos" 20 80 8 \
		"1 - Instalar base de datos world  - SkyFireDB, CCDB o ArkDB" "" \
		"2 - Instalar base de datos auth" "" \
		"3 - Instalar base de datos characters" "" \
		"0 - Volver" "" 2> ~/var4
		  
		opcion4=$(cat ~/var4)
		rm ~/var4
	
		while [ "$opcion4" != "0 - Volver" ]; do


####################################################################
# Instalar base de datos world  - CCDB o ArkDB
####################################################################
		if [ "$opcion4" = "1 - Instalar base de datos world  - SkyFireDB, CCDB o ArkDB" ]; then
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nInstalar base de datos world" 20 80 8 \
			"1 - Instalar base de datos SkyFireDB" "" \
			"2 - Instalar base de datos CCDB" "" \
			"3 - Instalar base de datos ArkDB" "" \
			"0 - Volver" "" 2> ~/var5
		  
			opcion5=$(cat ~/var5)
			rm ~/var5
	
			while [ "$opcion5" != "0 - Volver" ]; do


####################################################################
# Instalar base de datos SkyFireDB
####################################################################

			if [ "$opcion5" = "1 - Instalar base de datos SkyFireDB" ]; then
				dialog --title "ATENCIÓN!" \
				--backtitle "http://linux.msgsistemes.es" \
				--defaultno \
				--yesno "\nEstás a punto de instalar una base de datos vacía. Esto eliminará cualquier base datos que tubieras llamada ${world} ¿Estás seguro?" 8 50 
				if [ $? = 0 ]; then
					mysql $conecta -e "DROP DATABASE IF EXISTS ${world};"
					mysql $conecta -e "create database ${world} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
					clear && echo "IMPORTANDO PREVIOS..." && sleep 5s
					max=`ls -1 "${db1_sky}"/*.sql | wc -l`
					i=0
					for archivo in "${db1_sky}"/*.sql; do
					i=$((${i}+1))
					echo " [${i}/${max}] importando: ${archivo##*/}"
					mysql $conecta ${world} < "${archivo}"
					done
					clear && echo "IMPORTANDO ARCHIVOS..."
					max=`ls -1 "${db_sky}"/*.sql | wc -l`
					i=0
					for archivo in "${db_sky}"/*.sql; do
					i=$((${i}+1))
					echo " [${i}/${max}] importando: ${archivo##*/}"
					mysql $conecta ${world} < "${archivo}"
					done	
					clear && echo "IMPORTANDO ACTUALIZACIONES..." && sleep 5s
					max=`ls -1 "${db_act_sky}"/*.sql | wc -l`
					i=0
					for archivo in "${db_act_sky}"/*.sql; do
					i=$((${i}+1))
					echo " [${i}/${max}] importando: ${archivo##*/}"
					mysql $conecta ${world} < "${archivo}"
					done
					dialog --title "INFORMACIÓN" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nFinalizada la instalación de la base de datos SkyFirDB en ${world}." 10 50
					clear
				fi


####################################################################
# Instalar base de datos CCDB
####################################################################
			elif [ "$opcion5" = "2 - Instalar base de datos CCDB" ]; then
				dialog --title "ATENCIÓN!" \
				--backtitle "http://linux.msgsistemes.es" \
				--defaultno \
				--yesno "\nEstás a punto de instalar una base de datos vacía. Esto eliminará cualquier base datos que tubieras llamada ${world} ¿Estás seguro?" 8 50 
				if [ $? = 0 ]; then
					mysql $conecta -e "DROP DATABASE IF EXISTS ${world};"
					mysql $conecta -e "create database ${world} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
					clear && echo "IMPORTANDO ARCHIVOS..."
					max=`ls -1 "${db_ccdb}"/*.sql | wc -l`
					i=0
					for archivo in "${db_ccdb}"/*.sql; do
					i=$((${i}+1))
					echo " [${i}/${max}] importando: ${archivo##*/}"
					mysql $conecta ${world} < "${archivo}"
					done
					clear && echo "IMPORTANDO ARCHIVOS DE ACTUALIZACIONES DEL CORE..." && sleep 5s
					max=`ls -1 "${db_act_sky}"/*.sql | wc -l`
					i=0
					for archivo in "${db_act_sky}"/*.sql; do
					i=$((${i}+1))
					echo " [${i}/${max}] importando: ${archivo##*/}"
					mysql $conecta ${world} < "${archivo}"
					done	
					dialog --title "INFORMACIÓN" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nFinalizada la instalación de la base de datos CCDB en ${world}." 10 50
					clear
				fi


####################################################################
# Instalar base de datos ArkDB
####################################################################
			elif [ "$opcion5" = "3 - Instalar base de datos ArkDB" ]; then
				dialog --title "ATENCIÓN!" \
				--backtitle "http://linux.msgsistemes.es" \
				--defaultno \
				--yesno "\nEstás a punto de instalar una base de datos vacía. Esto eliminará cualquier base datos que tubieras llamada ${world} ¿Estás seguro?" 8 50
				if [ $? = 0 ]; then
					mysql $conecta -e "DROP DATABASE IF EXISTS ${world};"
					mysql $conecta -e "create database ${world} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
					clear && echo "IMPORTANDO ARCHIVO PRINCIPAL..."
					mysql $conecta ${world} < $db_ark/arkdb.sql
					clear && echo "IMPORTANDO ARCHIVOS SECUNDARIOS..." && sleep 5s
					max=`ls -1 "${db1_ark_sky}"/*.sql | wc -l`
					i=0
					for archivo in "${db1_ark_sky}"/*.sql; do
					i=$((${i}+1))
					echo " [${i}/${max}] importando: ${archivo##*/}"
					mysql $conecta ${world} < "${archivo}"
					done
					clear && echo "IMPORTANDO ARCHIVOS DE ACTUALIZACIONES DEL CORE..." && sleep 5s
					max=`ls -1 "${db_act_sky}"/*.sql | wc -l`
					i=0
					for archivo in "${db_act_sky}"/*.sql; do
					i=$((${i}+1))
					echo " [${i}/${max}] importando: ${archivo##*/}"
					mysql $conecta ${world} < "${archivo}"
					done
					dialog --title "INFORMACIÓN" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nFinalizada la instalación de la base de datos ArkDB en ${world}." 10 50
					clear
				fi
			fi


########  CONCLUSIÓN MENÚ Instalar base de datos world  ######## 
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nInstalar base de datos world" 20 80 8 \
			"1 - Instalar base de datos SkyFireDB" "" \
			"2 - Instalar base de datos CCDB" "" \
			"3 - Instalar base de datos ArkDB" "" \
			"0 - Volver" "" 2> ~/var5
		  
			opcion5=$(cat ~/var5)
			rm ~/var5
			done


####################################################################
# Instalar base de datos auth
####################################################################
		elif [ "$opcion4" = "2 - Instalar base de datos auth" ]; then
			dialog --title "ATENCIÓN!" \
			--backtitle "http://linux.msgsistemes.es" \
			--defaultno \
			--yesno "\nEstás a punto de instalar una base de datos vacía. Esto eliminará cualquier base datos que tubieras llamada ${auth} ¿Estás seguro?" 8 50
			if [ $? = 0 ]; then
				mysql $conecta -e "DROP DATABASE IF EXISTS ${auth};"
				mysql $conecta -e "create database ${auth} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
				clear && echo "IMPORTANDO ..." && sleep 5s
				mysql $conecta ${auth} < $sqlauth_sky/auth_database.sql
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nFinalizada la instalación de la base de datos Auth en ${auth}." 10 50
				clear
			fi


####################################################################
# Instalar base de datos characters
####################################################################
		elif [ "$opcion4" = "3 - Instalar base de datos characters" ]; then
			dialog --title "ATENCIÓN!" \
			--backtitle "http://linux.msgsistemes.es" \
			--defaultno \
			--yesno "\nEstás a punto de instalar una base de datos vacía. Esto eliminará cualquier base datos que tubieras llamada ${char} ¿Estás seguro?" 8 50
			if [ $? = 0 ]; then
				mysql $conecta -e "DROP DATABASE IF EXISTS ${char};"
				mysql $conecta -e "create database ${char} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
				clear && echo "IMPORTANDO ..." && sleep 5s
				mysql $conecta ${char} < $sqlchar_sky/character_database.sql
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nFinalizada la instalación de la base de datos Characters en ${char}." 10 50
				clear
			fi
		fi


########  CONCLUSIÓN MENÚ Instalar las Bases de Datos  ######## 
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nInstalar las Bases de Datos" 20 80 8 \
		"1 - Instalar base de datos world  - SkyFireDB, CCDB o ArkDB" "" \
		"2 - Instalar base de datos auth" "" \
		"3 - Instalar base de datos characters" "" \
		"0 - Volver" "" 2> ~/var4
		  
		opcion4=$(cat ~/var4)
		rm ~/var4
		done


####################################################################
# Instalar traducciones al español de eswow2
####################################################################
	elif [ "$opcion1" = "5 - Instalar traducciones al español de eswow2" ]; then
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nInstalar traducciones al español de eswow2" 20 80 8 \
		"1 - Traducción de Cataclysm a Español de España" "" \
		"2 - Traducción de Cataclysm a Español de Latino-América" "" \
		"0 - Volver" "" 2> ~/var6
	  
		opcion6=$(cat ~/var6)
		rm ~/var6

		while [ "$opcion6" != "0 - Volver" ]; do



####################################################################
# Traducción de Cataclysm a Español de España
####################################################################
		if [ "$opcion6" = "1 - Traducción de Cataclysm a Español de España" ]; then
			clear
			max=`ls -1 "${cata_es_sky}"/*.sql | wc -l`
			i=0
			for table in "${cata_es_sky}"/*.sql; do
			i=$((${i}+1))
			echo " [${i}/${max}] Importando: ${table##*/}"
			mysql $conecta ${world} < "${table}"
			done
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nFinalizada la traducción de la base de datos." 10 50
			clear


####################################################################
# Traducción de Cataclysm a Español de Latino-América
####################################################################
		elif [ "$opcion6" = "2 - Traducción de Cataclysm a Español de Latino-América" ]; then
			clear
			max=`ls -1 "${cata_mx_sky}"/*.sql | wc -l`
			i=0
			for table in "${cata_mx_sky}"/*.sql; do
			i=$((${i}+1))
			echo " [${i}/${max}] Importando: ${table##*/}"
			mysql $conecta ${world} < "${table}"
			done
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nFinalizada la traducción de la base de datos." 10 50
			clear
		fi


########  CONCLUSIÓN MENÚ Instalar traducciones al español de eswow2  ######## 
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nInstalar traducciones al español de eswow2" 20 80 8 \
		"1 - Traducción de Cataclysm a Español de España" "" \
		"2 - Traducción de Cataclysm a Español de Latino-América" "" \
		"0 - Volver" "" 2> ~/var6
	  
		opcion6=$(cat ~/var6)
		rm ~/var6
		done


####################################################################
# Configuraciones varias
####################################################################
	elif [ "$opcion1" = "6 - Configuraciones varias" ]; then
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nConfiguraciones varias" 20 80 8 \
		"1 - Configurar tabla realmlist de la base de datos auth" "" \
		"2 - Configurar authserver.conf y worldserver.conf" "" \
		"0 - Volver" "" 2> ~/var7
		  
		opcion7=$(cat ~/var7)
		rm ~/var7
	
		while [ "$opcion7" != "0 - Volver" ]; do


####################################################################
# Configurar tabla realmlist de la base de datos auth
####################################################################
		if [ "$opcion7" = "1 - Configurar tabla realmlist de la base de datos auth" ]; then
			if [ ! -x $server_sky/etc/confrealm.sql  ];then
				rm -f $server_sky/etc/confrealm.sql
			fi
			echo "REPLACE INTO \`realmlist\` (\`id\`,\`name\`,\`address\`,\`port\`,\`icon\`,\`color\`,\`timezone\`,\`allowedSecurityLevel\`,\`population\`,\`gamebuild\`) VALUES
(1,'NombreReino','addressReino',portReino,1,0,1,0,0,13623);" >> $server_sky/etc/confrealm.sql

			conf6=$(dialog --title "CONFIGURACIÓN TABLA realmlist DE LA DB auth" \
			--backtitle "http://linux.msgsistemes.es" \
			--inputbox "\nNombre que le quieres dar a tu reino:" 10 51 SkyFire 2>&1 >/dev/tty)
			sed -e "s/NombreReino/$conf6/g" -i $server_sky/etc/confrealm.sql
	
			conf7=$(dialog --title "CONFIGURACIÓN TABLA realmlist DE LA DB auth" \
			--backtitle "http://linux.msgsistemes.es" \
			--inputbox "\nIp de conexión a tu servidor:" 10 51 127.0.0.1 2>&1 >/dev/tty)
			sed -e "s/addressReino/$conf7/g" -i $server_sky/etc/confrealm.sql

			conf8=$(dialog --title "CONFIGURACIÓN TABLA realmlist DE LA DB auth" \
			--backtitle "http://linux.msgsistemes.es" \
			--inputbox "\nPuerto de conexión:" 10 51 8085 2>&1 >/dev/tty)
			sed -e "s/portReino/$conf8/g" -i $server_sky/etc/confrealm.sql

			mysql $conecta $auth < $server_sky/etc/confrealm.sql
			rm -f $server_sky/etc/confrealm.sql
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nYa tienes la Tabla realmlist configurada" 10 50
			clear



####################################################################
# 7.2 - Configurar authserver.conf y worldserver.conf
####################################################################

		elif [ "$opcion7" = "2 - Configurar authserver.conf y worldserver.conf" ]; then
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nConfigurar authserver.conf y worldserver.conf" 20 80 8 \
			"1 - Configurar archivo authserver.conf" "" \
			"2 - Configurar archivo worldserver.conf" "" \
			"0 - Volver" "" 2> ~/var8
			  
			opcion8=$(cat ~/var8)
			rm ~/var8
	
			while [ "$opcion8" != "0 - Volver" ]; do



####################################################################
# 7.2.1 - Configurar Authserver.conf
####################################################################

			if [ "$opcion8" = "1 - Configurar archivo authserver.conf" ]; then
				if [ ! -x $server_sky/etc/authserver.temp  ];then
					rm -f $server_sky/etc/authserver.temp
				fi
				cp $server_sky/etc/authserver.conf.dist $server_sky/etc/authserver.temp

				sed -e "s/LoginDatabaseInfo = \"127\.0\.0\.1;3306;skyfire;skyfire;auth\"/LoginDatabaseInfo = \"127\.0\.0\.1;3306;sqluser;sqlpass;dbauth\"/g" -i $server_sky/etc/authserver.temp

				conf=$(dialog --title "CONFIGURACIÓN DEL authserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nDirectorio del archivo logs: \nValor por defecto logs" 10 51 logs 2>&1 >/dev/tty)
				sed -e "s/LogsDir = \"\"/LogsDir = \"\.\.\/$conf\"/g" -i $server_sky/etc/authserver.temp

				conf2=$(dialog --title "CONFIGURACIÓN DEL authserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nConfiguración de los colores de salida en terminal: \nValor por defecto 13 11 9 5" 10 51 "13 11 9 5" 2>&1 >/dev/tty)	
				sed -e "s/LogColors = \"\"/LogColors = \"$conf2\"/g" -i $server_sky/etc/authserver.temp

				conf3=$(dialog --title "CONFIGURACIÓN DEL authserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nUsuario de MySQL: \nValor por defecto root" 10 51 root 2>&1 >/dev/tty)
				sed -e "s/sqluser/$conf3/g" -i $server_sky/etc/authserver.temp

				conf4=$(dialog --title "CONFIGURACIÓN DEL authserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--insecure \
				--passwordbox "\nContraseña de MySQL: " 10 51 2>&1 >/dev/tty)
				sed -e "s/sqlpass/$conf4/g" -i $server_sky/etc/authserver.temp

				conf5=$(dialog --title "CONFIGURACIÓN DEL authserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nNombre de la base de datos Autentificación: \nValor por defecto $auth" 10 51 $auth 2>&1 >/dev/tty)
				sed -e "s/dbauth/$conf5/g" -i $server_sky/etc/authserver.temp

				# PidFile = "auth.pid" NO TOCAR!!! IMPRESCINDIBLE.
				sed -e "s/PidFile = \"\"/PidFile = \"auth.pid\"/g" -i $server_sky/etc/authserver.temp

				cp $server_sky/etc/authserver.temp $server_sky/etc/authserver.conf
				cp $server_sky/etc/authserver.temp $server_sky/bin/authserver.conf

				rm -f $server_sky/etc/authserver.temp
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHas configurado el archivo authserver.conf.\n\nSi los valores que has introducido son correctos ya puedes arrancar el servidor de logueo (./authserver)." 10 50
				clear


####################################################################
# 7.2.2 - Configurar Worldserver.conf
####################################################################

			elif [ "$opcion8" = "2 - Configurar archivo worldserver.conf" ]; then
				if [ ! -x $server_sky/etc/world.conf  ];then
					rm -f $server_sky/etc/world.conf
				fi
				cp $server_sky/etc/worldserver.conf.dist $server_sky/etc/world.conf
sed -e "s/LoginDatabaseInfo     = \"127\.0\.0\.1;3306;skyfire;skyfire;auth\"/LoginDatabaseInfo     = \"127\.0\.0\.1;3306;sqluser;sqlpass;dbauth\"/g" -i $server_sky/etc/world.conf
				sed -e "s/WorldDatabaseInfo     = \"127\.0\.0\.1;3306;skyfire;skyfire;world\"/WorldDatabaseInfo     = \"127\.0\.0\.1;3306;sqluser;sqlpass;dbworld\"/g" -i $server_sky/etc/world.conf
				sed -e "s/CharacterDatabaseInfo = \"127\.0\.0\.1;3306;skyfire;skyfire;characters\"/CharacterDatabaseInfo = \"127\.0\.0\.1;3306;sqluser;sqlpass;dbchar\"/g" -i $server_sky/etc/world.conf

				conf6=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 1/42\n\nDirectorio del archivo data: \nValor por defecto data" 12 51 data 2>&1 >/dev/tty)
				sed -e "s/DataDir = \"\.\"/DataDir = \"\.\.\/$conf6\"/g" -i $server_sky/etc/world.conf

				conf7=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 2/42\n\nDirectorio del archivo logs: \nValor por defecto logs" 12 51 logs 2>&1 >/dev/tty)
				sed -e "s/LogsDir = \"\"/LogsDir = \"\.\.\/$conf7\"/g" -i $server_sky/etc/world.conf

				conf8=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 3/42\n\nUsuario de MySQL: \nValor por defecto root" 12 51 root 2>&1 >/dev/tty)
				sed -e "s/sqluser/$conf8/g" -i $server_sky/etc/world.conf

				conf9=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--insecure \
				--passwordbox "\nOpción 4/42\n\nContraseña de MySQL: " 12 51 2>&1 >/dev/tty)
				sed -e "s/sqlpass/$conf9/g" -i $server_sky/etc/world.conf

				conf10=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 5/42\n\nNombre de la base de datos Autentificación: \nValor por defecto $auth" 12 51 $auth 2>&1 >/dev/tty)
				sed -e "s/dbauth/$conf10/g" -i $server_sky/etc/world.conf

				conf11=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 6/42\n\nNombre de la base de datos del World: \nValor por defecto $world" 12 51 $world 2>&1 >/dev/tty)
				sed -e "s/dbworld/$conf11/g" -i $server_sky/etc/world.conf

				conf12=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 7/42\n\nNombre de la base de datos de Characters: \nValor por defecto $characters" 12 51 $characters 2>&1 >/dev/tty)
				sed -e "s/dbchar/$conf12/g" -i $server_sky/etc/world.conf

				conf13=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 8/42\n\nPuerto de conexión al worldserver: \nValor por defecto 8085" 12 51 8085 2>&1 >/dev/tty)
				sed -e "s/WorldServerPort = 8085/WorldServerPort = $conf13/g" -i $server_sky/etc/world.conf

				conf14=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 9/42\n\nLímite de jugadores conectados simultaneamente: \nValor por defecto 100" 12 51 100 2>&1 >/dev/tty)
				sed -e "s/PlayerLimit = 100/PlayerLimit = $conf14/g" -i $server_sky/etc/world.conf

				# RESERVADO

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 11/42\n\n¿Quieres que se cree un archivo log con los comandos o acciones realizadas como GM?\nEs recomendable si tienes nuevos GM y quieres ver como trabajan." 12 51
				if [ $? = 0 ]; then
					sed -e "s/LogDB.GM = 0/LogDB.GM = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 12/42\n\n¿Quieres que se cree un archivo log con las conexiones desde telnet?\nEs útil si tienes una tienda web o gestionas el servidor por telnet." 12 51
				if [ $? = 0 ]; then
					sed -e "s/LogDB.RA = 0/LogDB.RA = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--nocancel \
				--menu "\nOpción 13/42\n\nTipo de Reino - Quieres un reino PVP o Normal?\nEn los reinos normales se puede desconetar que los de la facción contraria te puedan atacer. En los PVP te pueden atacar menos en los santuarios.\n\n\n\n" 20 80 4 \
				"1 - Reino PVP" "" \
				"2 - Reino Normal" "" 2> conf16
				conf16=$(cat conf16)
				if [ "$conf16" = "1 - Reino PVP" ]; then
					sed -e "s/GameType = 0/GameType = 1/g" -i $server_sky/etc/world.conf
				else
					sed -e "s/GameType = 0/GameType = 0/g" -i $server_sky/etc/world.conf
				fi
				rm conf16

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 14/42\n\n¿Quieres activar el avance de nivel de las hermandades?\nTodavía experimental en esta versión de emulador." 12 51
				if [ $? = 0 ]; then
					sed -e "s/GuildAdvancement.Enabled = 0/GuildAdvancement.Enabled = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 15/42\n\n¿Quieres que se anuncien por taberna los eventos automáticos?" 12 51
				if [ $? = 0 ]; then
					sed -e "s/Event.Announce = 0/Event.Announce = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 16/42\n\n¿Quieres activar el buscador de mazmorras?\nTodavía experimental en esta versión de emulador" 12 51
				if [ $? = 0 ]; then
					sed -e "s/DungeonFinder.Enable = 0/DungeonFinder.Enable = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--defaultno \
				--yesno "\nOpción 17/42\n\n¿Quieres que en la misma cuenta se puedan crear alianzas y hordas?" 12 51
				if [ $? = 1 ]; then
					sed -e "s/AllowTwoSide.Accounts = 1/AllowTwoSide.Accounts = 0/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 18/42\n\n¿Quieres que los Alianzas y los Hordas se puedan comunicar por los canales de chat como taberna o \"decir\"?" 12 51
				if [ $? = 0 ]; then
					sed -e "s/AllowTwoSide.Interaction.Chat = 0/AllowTwoSide.Interaction.Chat = 1/g" -i $server_sky/etc/world.conf && sed -e "s/AllowTwoSide.Interaction.Channel = 0/AllowTwoSide.Interaction.Channel = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 19/42\n\n¿Quieres que se puedan crear grupos mixtos entre Hordas y Alianzas?\nEsto es útil para cuando hay poca población en el servidor poder hacer mazmorras o raids conjuntamente." 12 51
				if [ $? = 0 ]; then
					sed -e "s/AllowTwoSide.Interaction.Group = 0/AllowTwoSide.Interaction.Group = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 20/42\n\n¿Quieres que se pueda interactuar en las subastas entre Hordas y Alianzas?\nEsto es útil para cuando hay poca población en el servidor." 12 51
				if [ $? = 0 ]; then
					sed -e "s/AllowTwoSide.Interaction.Auction = 0/AllowTwoSide.Interaction.Auction = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 21/42\n\n¿Quieres que se pueda mandar correos a la facción contraria?." 12 51
				if [ $? = 0 ]; then
					sed -e "s/AllowTwoSide.Interaction.Mail = 0/AllowTwoSide.Interaction.Mail = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 22/42\n\n¿Quieres que se pueda comerciar con la facción contraria?." 12 51
				if [ $? = 0 ]; then
					sed -e "s/AllowTwoSide.Trade = 0/AllowTwoSide.Trade = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nOpción 23/42\n\nRATES DEL SERVIDOR:\n\nLos rates son lo que determinan lo rápido que se avanza en el juego.\nLos servidores de Blizzard tienen un rate de x1 por lo que si nosotros ponemos rates x3 se multiplican los valores al triple.\nEjemplo: Ponemos rates de experiencia al matar bichos x3. Si al nivel 10 para subir al 11 debemos matar 30 zebras en el de Blizzard, al nuestro con 10 ya subiríamos." 22 60
				clear

				conf17=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 24/42\n\nRATES DEL SERVIDOR:\nRates de objetos mediocres(grises)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Poor             = 1/Rate.Drop.Item.Poor             = $conf17/g" -i $server_sky/etc/world.conf

				conf18=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 25/42\n\nRATES DEL SERVIDOR:\nRates de objetos normales(blancos)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Normal           = 1/Rate.Drop.Item.Normal           = $conf18/g" -i $server_sky/etc/world.conf

				conf19=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 26/42\n\nRATES DEL SERVIDOR:\nRates de objetos poco frecuentes(verdes)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Uncommon         = 1/Rate.Drop.Item.Uncommon         = $conf19/g" -i $server_sky/etc/world.conf

				conf20=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 27/42\n\nRATES DEL SERVIDOR:\nRates de objetos raros(azules)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Rare             = 1/Rate.Drop.Item.Rare             = $conf20/g" -i $server_sky/etc/world.conf

				conf21=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 28/42\n\nRATES DEL SERVIDOR:\nRates de objetos épicos(morados)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Epic             = 1/Rate.Drop.Item.Epic             = $conf21/g" -i $server_sky/etc/world.conf

				conf22=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 29/42\n\nRATES DEL SERVIDOR:\nRates de objetos legendarios(anaranjados)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Legendary        = 1/Rate.Drop.Item.Legendary        = $conf22/g" -i $server_sky/etc/world.conf

				conf23=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 30/42\n\nRATES DEL SERVIDOR:\nRates de objetos artefactos" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Artifact         = 1/Rate.Drop.Item.Artifact         = $conf23/g" -i $server_sky/etc/world.conf

				conf24=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 31/42\n\nRATES DEL SERVIDOR:\nRates de objetos de misión" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Referenced       = 1/Rate.Drop.Item.Referenced       = $conf24/g" -i $server_sky/etc/world.conf

				conf25=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 32/42\n\nRATES DEL SERVIDOR:\nRates de dinero" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Money                 = 1/Rate.Drop.Money                 = $conf25/g" -i $server_sky/etc/world.conf

				conf26=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 33/42\n\nRATES DEL SERVIDOR:\nRates experiencia por muertes" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.XP.Kill    = 1/Rate.XP.Kill    = $conf26/g" -i $server_sky/etc/world.conf

				conf27=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 34/42\n\nRATES DEL SERVIDOR:\nRates experiencia en misiones" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.XP.Quest   = 1/Rate.XP.Quest   = $conf27/g" -i $server_sky/etc/world.conf

				conf28=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 35/42\n\nRATES DEL SERVIDOR:\nRates experiencia por exploración" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.XP.Explore = 1/Rate.XP.Explore = $conf28/g" -i $server_sky/etc/world.conf

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 36/42\n\n¿Quieres que se anuncie por canal global cuando se anote alguien a BG?\nEsto es útil para cuando hay poca población en el servidor." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Battleground.QueueAnnouncer.Enable = 0/Battleground.QueueAnnouncer.Enable = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 37/42\n\n¿Quieres que esté funcional Wintergrasp?\nTodavía experimental en esta versión de emulador." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Wintergrasp.Enable = 0/Wintergrasp.Enable = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 38/42\n\n¿Quieres que esté funcional Tol Barad?\nTodavía experimental en esta versión de emulador." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Tol Barad.Enable = 0/Tol Barad.Enable = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 39/42\n\n¿Quieres que se adjudiquen los puntos de arenas automáticamente cada semana? Es recomendable que sí." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Arena.AutoDistributePoints = 0/Arena.AutoDistributePoints = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 40/42\n\n¿Quieres que se anuncie por canal global cuando se anote un grupo a arenas?\nEsto es útil para cuando hay poca población en el servidor." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Arena.QueueAnnouncer.Enable = 0/Arena.QueueAnnouncer.Enable = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 41/42\n\n¿Deseas activar el acceso a la máquina por telnet?\nEsto es necesario si quieres tener una tienda de artículos en la web o gestionar el servidor remotamente." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Ra.Enable = 0/Ra.Enable = 1/g" -i $server_sky/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 42/42\n\n¿Si un jugador es Kickeado por un GM, quieres que se muestre el anuncio del kick por el canal global?" 12 51
				if [ $? = 0 ]; then
					sed -e "s/ShowKickInWorld = 0/ShowKickInWorld = 1/g" -i $server_sky/etc/world.conf
				fi

				### Configuraciones que cambiamos automáticamente:
				#PlayerSaveInterval = 900000
				sed -e "s/PlayerSaveInterval = 900000/PlayerSaveInterval = 300000/g" -i $server_sky/etc/world.conf

				#MaxCoreStuckTime = 0
				sed -e "s/MaxCoreStuckTime = 0/MaxCoreStuckTime = 10/g" -i $server_sky/etc/world.conf

				#GmLogPerAccount = 0
				sed -e "s/GmLogPerAccount = 0/GmLogPerAccount = 1/g" -i $server_sky/etc/world.conf

				#RealmZone = 1
				sed -e "s/RealmZone = 1/RealmZone = 11/g" -i $server_sky/etc/world.conf

				#Motd = "Welcome to a Skyfire....
				sed -e "s/Welcome to a Skyfire Core server.@If your seeing this message@it's because the developer hasnt read configs fully/Bienvenido a nuestro servidor.@Esperamos que sea de tu agrado/g" -i $server_sky/etc/world.conf

				#AllowPlayerCommands = 0
				sed -e "s/AllowPlayerCommands = 0/AllowPlayerCommands = 1/g" -i $server_sky/etc/world.conf

				#Die.Command.Mode = 1
				sed -e "s/Die.Command.Mode = 1/Die.Command.Mode = 0/g" -i $server_sky/etc/world.conf

				#IF YOUR READING THIS YOUR DEVELOPER HAS NOT READ ALL OF THE CONFIGERATION FILE!
				sed -e "s/IF YOUR READING THIS YOUR DEVELOPER HAS NOT READ ALL OF THE CONFIGERATION FILE!/World of Warcraft - Cataclysm/g" -i $server_sky/etc/world.conf

				#PidFile = "world.pid"  IMPRESCINDIBLE!!! NO TOCAR.  
				sed -e "s/PidFile = \"\"/PidFile = \"world.pid\"/g" -i $server_sky/etc/world.conf

				cp $server_sky/etc/world.conf $server_sky/etc/worldserver.conf
				rm -f $server_sky/etc/world.conf
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHas configurado el archivo worldserver.conf.\n\nSi los valores que has introducido son correctos ya puedes arrancar el servidor del juego." 10 50
				clear
			fi


########  CONCLUSIÓN MENÚ Configurar authserver.conf y worldserver.conf  ########
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nConfigurar authserver.conf y worldserver.conf" 20 80 8 \
			"1 - Configurar archivo authserver.conf" "" \
			"2 - Configurar archivo worldserver.conf" "" \
			"0 - Volver" "" 2> ~/var8
		  
			opcion8=$(cat ~/var8)
			rm ~/var8
			done
		fi


########  CONCLUSIÓN MENÚ Configuraciones varias  ########
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nConfiguraciones varias" 20 80 8 \
		"1 - Configurar tabla realmlist de la base de datos auth" "" \
		"2 - Configurar authserver.conf y worldserver.conf" "" \
		"0 - Volver" "" 2> ~/var7
		  
		opcion7=$(cat ~/var7)
		rm ~/var7
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
	"0 - Salir de la aplicación" "" 2> ~/var1
	  
	opcion1=$(cat ~/var1)
	if [ "$opcion1" = "0 - Salir de la aplicación" ]; then
		rm ~/var*
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
	--menu "\nOpciones disponibles:" 20 80 11 \
	"1 - Obtención o actualización de todos los archivos necesarios" "" \
	"2 - Compilar el emulador" "" \
	"3 - DBC's, maps y vmaps - Descarga y colocación en directorio" "" \
	"4 - Instalar las Bases de Datos" "" \
	"5 - Instalar traducciones al español de eswow2" "" \
	"6 - Configuraciones varias" "" \
	"0 - Salir de la aplicación" "" 2> ~/var30
	  
	opcion30=$(cat ~/var30)
	
	if [ "$opcion30" = "0 - Salir de la aplicación" ]; then
		rm ~/var*
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--msgbox "\nGracias por usar el script de instalación." 10 50
		clear
		exit
	fi
	while [ "$opcion30" != "0 - Salir de la aplicación" ]; do


####################################################################
# Menú - Obtención o actualización de todos los archivos necesarios
####################################################################
	if [ "$opcion30" = "1 - Obtención o actualización de todos los archivos necesarios" ]; then
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nManejo de Repositorios y archivos" 20 60 8 \
		"1 - Descargar repositorios" "" \
		"2 - Actualizar repositorios" "" \
		"0 - Volver" "" 2> ~/var31
			  
		opcion31=$(cat ~/var31)
		rm ~/var*
	
		while [ "$opcion31" != "0 - Volver" ]; do


####################################################################
# Descargar repositorios
####################################################################
		if [ "$opcion31" = "1 - Descargar repositorios" ]; then
			clear
			if [ ! -x /home/`echo $USER`/Repos  ];then
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--pause "\nSe va a crear la carpeta de repositorios dentro de nuestro home" 10 50 5
				clear
				cd /home/`echo $USER`/ && mkdir Repos
			fi
			if [ ! -x /home/`echo $USER`/Repos/ArkCORE  ];then
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--pause "\nVamos a obtener los repositorios de ArkCORE" 10 50 5
				clear
				cd $repos && git clone $rep_arkcore
			fi
			if [ ! -x /home/`echo $USER`/Repos/ArkDB  ];then
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--pause "\nVamos a descargar los repositorios de ArkDB." 10 50 5
				clear
				cd $repos && git clone $rep_arkdb
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
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nTodos los repositorios están descargados." 8 50
			clear


####################################################################
# Actualizar repositorios 
####################################################################
		elif [ "$opcion31" = "2 - Actualizar repositorios" ]; then
			cd $core_ark && git pull origin master
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--pause "\nRepositorios del core actualizados." 10 50 5
			clear
			cd $repos/ArkDB && git pull origin master
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
		"0 - Volver" "" 2> ~/var31
		
		opcion31=$(cat ~/var31)
		rm ~/var*
		done


####################################################################
# Compilar el emulador
####################################################################
	elif [ "$opcion30" = "2 - Compilar el emulador" ]; then
		if [ ! -x $core_ark/build  ];then
			cd $core_ark && mkdir build
		fi
		if [ ! -x $server_ark  ];then
			cd /home/`echo $USER`/ && mkdir Server_ark
		fi
		if [ ! -x $server_ark/Backups  ];then
			cd $server_ark && mkdir Backups
		fi
		if [ ! -x $server_ark/logs  ];then
			cd $server_ark && mkdir logs
		fi
		cd $core_ark/build  && clear
		cmake ../ -DPREFIX=/home/`echo $USER`/Server_ark
		make -j$cores && sudo make install
		sudo chown -R `echo $USER` $server_ark
		if [ ! -x $server_ark/bin/world.pid  ];then
			echo "123456" >> $server_ark/bin/world.pid
		fi
		
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nHas terminado de compilar tu emulador. Si todo ha salido correctamete lo encontrarás en tu home, dentro de la carpeta Server_ark" 8 50
		clear


####################################################################
# DBC's, maps y vmaps - Descarga y colocación en directorio
####################################################################
	elif [ "$opcion30" = "3 - DBC's, maps y vmaps - Descarga y colocación en directorio" ]; then
		if [ ! -x $server_ark/data  ];then
			clear && cd $server_ark
			wget http://dl.dropbox.com/u/62758511/data.tar.gz
			tar xvzf data.tar.gz && rm data.tar.gz
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nSe ha creado una carpeta llamada data con las dbc, maps y vmaps en su interior" 8 50
			clear
		else
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nYa está la carpeta data creada y no se han descargado los archivos.\n\nSi deseas reinstalarlos de nuevo, borra la carpeta data de tu directorio del servidor y ejecuta de nuevo este mismo paso" 12 50
		fi


####################################################################
# Instalar las Bases de Datos
####################################################################
	elif [ "$opcion30" = "4 - Instalar las Bases de Datos" ]; then
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nInstalar las Bases de Datos" 20 80 8 \
		"1 - Instalar base de datos world  - SkyFireDB, CCDB o ArkDB" "" \
		"2 - Instalar base de datos auth" "" \
		"3 - Instalar base de datos characters" "" \
		"0 - Volver" "" 2> ~/var32
		  
		opcion32=$(cat ~/var32)
		rm ~/var32
	
		while [ "$opcion32" != "0 - Volver" ]; do


####################################################################
# Instalar base de datos world
####################################################################
		if [ "$opcion32" = "1 - Instalar base de datos world  - SkyFireDB, CCDB o ArkDB" ]; then
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nInstalar base de datos world" 20 80 8 \
			"1 - Instalar base de datos ArkDB" "" \
			"2 - Reservado" "" \
			"3 - Reservado" "" \
			"0 - Volver" "" 2> ~/var33
		  
			opcion33=$(cat ~/var33)
			rm ~/var33
	
			while [ "$opcion33" != "0 - Volver" ]; do


####################################################################
# Instalar base de datos ArkDB
####################################################################
			if [ "$opcion33" = "1 - Instalar base de datos ArkDB" ]; then
				dialog --title "ATENCIÓN!" \
				--backtitle "http://linux.msgsistemes.es" \
				--defaultno \
				--yesno "\nEstás a punto de instalar una base de datos vacía. Esto eliminará cualquier base datos que tubieras llamada ${world} ¿Estás seguro?" 8 50 
				if [ $? = 0 ]; then
					mysql $conecta -e "DROP DATABASE IF EXISTS ${world};"
					mysql $conecta -e "create database ${world} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
					clear && echo "IMPORTANDO ARCHIVO PRINCIPAL..."
					mysql $conecta ${world} < $db_ark/arkdb.sql
					clear && echo "IMPORTANDO ARCHIVOS SECUNDARIOS..."
					max=`ls -1 "${db1_ark}"/*.sql | wc -l`
					i=0
					for archivo in "${db1_ark}"/*.sql; do
					i=$((${i}+1))
					echo " [${i}/${max}] importando: ${archivo##*/}"
					mysql $conecta ${world} < "${archivo}"
					done
					clear && echo "IMPORTANDO ARCHIVOS DE ACTUALIZACIONES DEL CORE..." && sleep 5s
					max=`ls -1 "${db_act_ark}"/*.sql | wc -l`
					i=0
					for archivo in "${db_act_ark}"/*.sql; do
					i=$((${i}+1))
					echo " [${i}/${max}] importando: ${archivo##*/}"
					mysql $conecta ${world} < "${archivo}"
					done	
					dialog --title "INFORMACIÓN" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nFinalizada la instalación de la base de datos ArkDB en ${world}." 10 50
					clear
				fi
			fi


########  CONCLUSIÓN MENÚ Instalar base de datos world  ######## 
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nInstalar base de datos world" 20 80 8 \
			"1 - Instalar base de datos ArkDB" "" \
			"2 - Reservado" "" \
			"3 - Reservado" "" \
			"0 - Volver" "" 2> ~/var33
		  
			opcion33=$(cat ~/var33)
			rm ~/var33
			done


####################################################################
# Instalar base de datos auth
####################################################################
		elif [ "$opcion32" = "2 - Instalar base de datos auth" ]; then
			dialog --title "ATENCIÓN!" \
			--backtitle "http://linux.msgsistemes.es" \
			--defaultno \
			--yesno "\nEstás a punto de instalar una base de datos vacía. Esto eliminará cualquier base datos que tubieras llamada ${auth} ¿Estás seguro?" 8 50
			if [ $? = 0 ]; then
				mysql $conecta -e "DROP DATABASE IF EXISTS ${auth};"
				mysql $conecta -e "create database ${auth} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
				clear && echo "IMPORTANDO ..." && sleep 5s
				mysql $conecta ${auth} < $sqlauth_ark/auth.sql
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nFinalizada la instalación de la base de datos Auth en ${auth}." 10 50
				clear
			fi


####################################################################
# Instalar base de datos characters
####################################################################
		elif [ "$opcion32" = "3 - Instalar base de datos characters" ]; then
			dialog --title "ATENCIÓN!" \
			--backtitle "http://linux.msgsistemes.es" \
			--defaultno \
			--yesno "\nEstás a punto de instalar una base de datos vacía. Esto eliminará cualquier base datos que tubieras llamada ${char} ¿Estás seguro?" 8 50
			if [ $? = 0 ]; then
				mysql $conecta -e "DROP DATABASE IF EXISTS ${char};"
				mysql $conecta -e "create database ${char} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
				clear && echo "IMPORTANDO ..." && sleep 5s
				mysql $conecta ${char} < $sqlchar_sky/character_database.sql
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nFinalizada la instalación de la base de datos Characters en ${char}." 10 50
				clear
			fi
		fi


########  CONCLUSIÓN MENÚ Instalar las Bases de Datos  ######## 
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nInstalar las Bases de Datos" 20 80 8 \
		"1 - Instalar base de datos world  - SkyFireDB, CCDB o ArkDB" "" \
		"2 - Instalar base de datos auth" "" \
		"3 - Instalar base de datos characters" "" \
		"0 - Volver" "" 2> ~/var32
		  
		opcion32=$(cat ~/var32)
		rm ~/var32
		done


####################################################################
# Instalar traducciones al español de eswow2
####################################################################
	elif [ "$opcion30" = "5 - Instalar traducciones al español de eswow2" ]; then
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nInstalar traducciones al español de eswow2" 20 80 8 \
		"1 - Traducción de Cataclysm a Español de España" "" \
		"2 - Traducción de Cataclysm a Español de Latino-América" "" \
		"0 - Volver" "" 2> ~/var34
	  
		opcion34=$(cat ~/var34)
		rm ~/var34

		while [ "$opcion34" != "0 - Volver" ]; do



####################################################################
# Traducción de Cataclysm a Español de España
####################################################################
		if [ "$opcion34" = "1 - Traducción de Cataclysm a Español de España" ]; then
			clear
			max=`ls -1 "${cata_es_ark}"/*.sql | wc -l`
			i=0
			for table in "${cata_es_ark}"/*.sql; do
			i=$((${i}+1))
			echo " [${i}/${max}] Importando: ${table##*/}"
			mysql $conecta ${world} < "${table}"
			done
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nFinalizada la traducción de la base de datos." 10 50
			clear

####################################################################
# Traducción de Cataclysm a Español de Latino-América
####################################################################
		elif [ "$opcion34" = "2 - Traducción de Cataclysm a Español de Latino-América" ]; then
			clear
			max=`ls -1 "${cata_mx_ark}"/*.sql | wc -l`
			i=0
			for table in "${cata_mx_ark}"/*.sql; do
			i=$((${i}+1))
			echo " [${i}/${max}] Importando: ${table##*/}"
			mysql $conecta ${world} < "${table}"
			done
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nFinalizada la traducción de la base de datos." 10 50
			clear
		fi


########  CONCLUSIÓN MENÚ Instalar traducciones al español de eswow2  ######## 
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nInstalar traducciones al español de eswow2" 20 80 8 \
		"1 - Traducción de Cataclysm a Español de España" "" \
		"2 - Traducción de Cataclysm a Español de Latino-América" "" \
		"0 - Volver" "" 2> ~/var34
	  
		opcion34=$(cat ~/var34)
		rm ~/var34
		done


####################################################################
# Configuraciones varias
####################################################################
	elif [ "$opcion30" = "6 - Configuraciones varias" ]; then
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nConfiguraciones varias" 20 80 8 \
		"1 - Configurar tabla realmlist de la base de datos auth" "" \
		"2 - Configurar authserver.conf y worldserver.conf" "" \
		"0 - Volver" "" 2> ~/var35
		  
		opcion35=$(cat ~/var35)
		rm ~/var35
	
		while [ "$opcion35" != "0 - Volver" ]; do


####################################################################
# Configurar tabla realmlist de la base de datos auth
####################################################################
		if [ "$opcion35" = "1 - Configurar tabla realmlist de la base de datos auth" ]; then
			if [ ! -x $server_ark/etc/confrealm.sql  ];then
				rm -f $server_ark/etc/confrealm.sql
			fi
			echo "REPLACE INTO \`realmlist\` (\`id\`,\`name\`,\`address\`,\`port\`,\`icon\`,\`color\`,\`timezone\`,\`allowedSecurityLevel\`,\`population\`,\`gamebuild\`) VALUES
(1,'NombreReino','addressReino',portReino,1,0,1,0,0,13623);" >> $server_ark/etc/confrealm.sql

			conf6=$(dialog --title "CONFIGURACIÓN TABLA realmlist de la DB auth" \
			--backtitle "http://linux.msgsistemes.es" \
			--inputbox "\nNombre que le quieres dar a tu reino:" 10 51 Arkania 2>&1 >/dev/tty)
			sed -e "s/NombreReino/$conf6/g" -i $server_ark/etc/confrealm.sql

			conf7=$(dialog --title "CONFIGURACIÓN TABLA realmlist de la DB auth" \
			--backtitle "http://linux.msgsistemes.es" \
			--inputbox "\nIp de conexión a tu servidor:" 10 51 127.0.0.1 2>&1 >/dev/tty)
			sed -e "s/addressReino/$conf7/g" -i $server_ark/etc/confrealm.sql

			conf8=$(dialog --title "CONFIGURACIÓN TABLA realmlist de la DB auth" \
			--backtitle "http://linux.msgsistemes.es" \
			--inputbox "\nPuerto de conexión:" 10 51 8085 2>&1 >/dev/tty)
			sed -e "s/portReino/$conf8/g" -i $server_ark/etc/confrealm.sql

			mysql $conecta $auth < $server_ark/etc/confrealm.sql
			rm -f $server_ark/etc/confrealm.sql
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nYa tienes la Tabla realmlist configurada" 10 50
			clear



####################################################################
# Configurar authserver.conf y worldserver.conf
####################################################################

		elif [ "$opcion35" = "2 - Configurar authserver.conf y worldserver.conf" ]; then
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nConfigurar authserver.conf y worldserver.conf" 20 80 8 \
			"1 - Configurar archivo authserver.conf" "" \
			"2 - Configurar archivo worldserver.conf" "" \
			"0 - Volver" "" 2> ~/var36
			  
			opcion36=$(cat ~/var36)
			rm ~/var36
	
			while [ "$opcion36" != "0 - Volver" ]; do



####################################################################
# 7.2.1 - Configurar Authserver.conf
####################################################################

			if [ "$opcion36" = "1 - Configurar archivo authserver.conf" ]; then
				if [ ! -x $server_ark/etc/authserver.temp  ];then
					rm -f $server_ark/etc/authserver.temp
				fi
				cp $server_ark/etc/authserver.conf.dist $server_ark/etc/authserver.temp

				sed -e "s/LoginDatabaseInfo = \"127\.0\.0\.1;3306;arkcore;arkania;auth\"/LoginDatabaseInfo = \"127\.0\.0\.1;3306;sqluser;sqlpass;dbauth\"/g" -i $server_ark/etc/authserver.temp

				conf=$(dialog --title "CONFIGURACIÓN DEL authserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nDirectorio del archivo logs: \nValor por defecto logs" 10 51 logs 2>&1 >/dev/tty)
				sed -e "s/LogsDir = \"\"/LogsDir = \"\.\.\/$conf\"/g" -i $server_ark/etc/authserver.temp

				conf2=$(dialog --title "CONFIGURACIÓN DEL authserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nConfiguración de los colores de salida en terminal: \nValor por defecto 13 11 9 5" 10 51 "13 11 9 5" 2>&1 >/dev/tty)	
				sed -e "s/LogColors = \"\"/LogColors = \"$conf2\"/g" -i $server_ark/etc/authserver.temp

				conf3=$(dialog --title "CONFIGURACIÓN DEL authserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nUsuario de MySQL: \nValor por defecto root" 10 51 root 2>&1 >/dev/tty)
				sed -e "s/sqluser/$conf3/g" -i $server_ark/etc/authserver.temp

				conf4=$(dialog --title "CONFIGURACIÓN DEL authserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--insecure \
				--passwordbox "\nContraseña de MySQL: " 10 51 2>&1 >/dev/tty)
				sed -e "s/sqlpass/$conf4/g" -i $server_ark/etc/authserver.temp

				conf5=$(dialog --title "CONFIGURACIÓN DEL authserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nNombre de la base de datos Autentificación: \nValor por defecto $auth" 10 51 $auth 2>&1 >/dev/tty)
				sed -e "s/dbauth/$conf5/g" -i $server_ark/etc/authserver.temp

				# PidFile = "auth.pid" NO TOCAR!!! IMPRESCINDIBLE.
				sed -e "s/PidFile = \"\"/PidFile = \"auth.pid\"/g" -i $server_ark/etc/authserver.temp

				cp $server_ark/etc/authserver.temp $server_ark/etc/authserver.conf
				rm -f $server_ark/etc/authserver.temp
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHas configurado el archivo authserver.conf.\n\nSi los valores que has introducido son correctos ya puedes arrancar el servidor de logueo (./authserver)." 10 50
				clear


####################################################################
# 7.2.2 - Configurar Worldserver.conf
####################################################################

			elif [ "$opcion36" = "2 - Configurar archivo worldserver.conf" ]; then
				if [ ! -x $server_ark/etc/world.conf  ];then
					rm -f $server_ark/etc/world.conf
				fi
				cp $server_ark/etc/worldserver.conf.dist $server_ark/etc/world.conf
				sed -e "s/LoginDatabaseInfo     = \"127\.0\.0\.1;3306;arkania;arkania;auth\"/LoginDatabaseInfo     = \"127\.0\.0\.1;3306;sqluser;sqlpass;dbauth\"/g" -i $server_ark/etc/world.conf
				sed -e "s/WorldDatabaseInfo     = \"127\.0\.0\.1;3306;arkania;arkania;world\"/WorldDatabaseInfo     = \"127\.0\.0\.1;3306;sqluser;sqlpass;dbworld\"/g" -i $server_ark/etc/world.conf
				sed -e "s/CharacterDatabaseInfo = \"127\.0\.0\.1;3306;arkania;arkania;characters\"/CharacterDatabaseInfo = \"127\.0\.0\.1;3306;sqluser;sqlpass;dbchar\"/g" -i $server_ark/etc/world.conf

				conf6=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 1/42\n\nDirectorio del archivo data: \nValor por defecto data" 12 51 data 2>&1 >/dev/tty)
				sed -e "s/DataDir = \"\.\"/DataDir = \"\.\.\/$conf6\"/g" -i $server_ark/etc/world.conf

				conf7=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 2/42\n\nDirectorio del archivo logs: \nValor por defecto logs" 12 51 logs 2>&1 >/dev/tty)
				sed -e "s/LogsDir = \"logs\"/LogsDir = \"\.\.\/$conf7\"/g" -i $server_ark/etc/world.conf

				conf8=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 3/42\n\nUsuario de MySQL: \nValor por defecto root" 12 51 root 2>&1 >/dev/tty)
				sed -e "s/sqluser/$conf8/g" -i $server_ark/etc/world.conf

				conf9=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--insecure \
				--passwordbox "\nOpción 4/42\n\nContraseña de MySQL: " 12 51 2>&1 >/dev/tty)
				sed -e "s/sqlpass/$conf9/g" -i $server_ark/etc/world.conf

				conf10=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 5/42\n\nNombre de la base de datos Autentificación: \nValor por defecto $auth" 12 51 $auth 2>&1 >/dev/tty)
				sed -e "s/dbauth/$conf10/g" -i $server_ark/etc/world.conf

				conf11=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 6/42\n\nNombre de la base de datos del World: \nValor por defecto $world" 12 51 $world 2>&1 >/dev/tty)
				sed -e "s/dbworld/$conf11/g" -i $server_ark/etc/world.conf

				conf12=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 7/42\n\nNombre de la base de datos de Characters: \nValor por defecto $characters" 12 51 $char 2>&1 >/dev/tty)
				sed -e "s/dbchar/$conf12/g" -i $server_ark/etc/world.conf

				conf13=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 8/42\n\nPuerto de conexión al worldserver: \nValor por defecto 8085" 12 51 8085 2>&1 >/dev/tty)
				sed -e "s/WorldServerPort = 8085/WorldServerPort = $conf13/g" -i $server_ark/etc/world.conf

				conf14=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 9/42\n\nLímite de jugadores conectados simultaneamente: \nValor por defecto 100" 12 51 100 2>&1 >/dev/tty)
				sed -e "s/PlayerLimit = 100/PlayerLimit = $conf14/g" -i $server_ark/etc/world.conf

				# RESERVADO

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 11/42\n\n¿Quieres que se cree un archivo log con los comandos o acciones realizadas como GM?\nEs recomendable si tienes nuevos GM y quieres ver como trabajan." 12 51
				if [ $? = 0 ]; then
					sed -e "s/LogDB.GM = 0/LogDB.GM = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 12/42\n\n¿Quieres que se cree un archivo log con las conexiones desde telnet?\nEs útil si tienes una tienda web o gestionas el servidor por telnet." 12 51
				if [ $? = 0 ]; then
					sed -e "s/LogDB.RA = 0/LogDB.RA = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--nocancel \
				--menu "\nOpción 13/42\n\nTipo de Reino - Quieres un reino PVP o Normal?\nEn los reinos normales se puede desconetar que los de la facción contraria te puedan atacer. En los PVP te pueden atacar menos en los santuarios.\n\n\n\n" 20 80 4 \
				"1 - Reino PVP" "" \
				"2 - Reino Normal" "" 2> conf16
				conf16=$(cat conf16)
				if [ "$conf16" = "1 - Reino PVP" ]; then
				sed -e "s/GameType = 0/GameType = 1/g" -i $server_ark/etc/world.conf
				else
					sed -e "s/GameType = 0/GameType = 0/g" -i $server_ark/etc/world.conf
				fi
				rm conf16

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 14/42\n\n¿Quieres activar el avance de nivel de las hermandades?\nTodavía experimental en esta versión de emulador." 12 51
				if [ $? = 0 ]; then
					sed -e "s/GuildAdvancement.Enabled = 0/GuildAdvancement.Enabled = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 15/42\n\n¿Quieres que se anuncien por taberna los eventos automáticos?" 12 51
				if [ $? = 0 ]; then
					sed -e "s/Event.Announce = 0/Event.Announce = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 16/42\n\n¿Quieres activar el buscador de mazmorras?\nTodavía experimental en esta versión de emulador" 12 51
				if [ $? = 0 ]; then
					sed -e "s/DungeonFinder.Enable = 0/DungeonFinder.Enable = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--defaultno \
				--yesno "\nOpción 17/42\n\n¿Quieres que en la misma cuenta se puedan crear alianzas y hordas?" 12 51
				if [ $? = 1 ]; then
					sed -e "s/AllowTwoSide.Accounts = 1/AllowTwoSide.Accounts = 0/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 18/42\n\n¿Quieres que los Alianzas y los Hordas se puedan comunicar por los canales de chat como taberna o \"decir\"?" 12 51
				if [ $? = 0 ]; then
					sed -e "s/AllowTwoSide.Interaction.Chat = 0/AllowTwoSide.Interaction.Chat = 1/g" -i $server_ark/etc/world.conf && sed -e "s/AllowTwoSide.Interaction.Channel = 0/AllowTwoSide.Interaction.Channel = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 19/42\n\n¿Quieres que se puedan crear grupos mixtos entre Hordas y Alianzas?\nEsto es útil para cuando hay poca población en el servidor poder hacer mazmorras o raids conjuntamente." 12 51
				if [ $? = 0 ]; then
					sed -e "s/AllowTwoSide.Interaction.Group = 0/AllowTwoSide.Interaction.Group = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 20/42\n\n¿Quieres que se pueda interactuar en las subastas entre Hordas y Alianzas?\nEsto es útil para cuando hay poca población en el servidor." 12 51
				if [ $? = 0 ]; then
					sed -e "s/AllowTwoSide.Interaction.Auction = 0/AllowTwoSide.Interaction.Auction = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 21/42\n\n¿Quieres que se pueda mandar correos a la facción contraria?." 12 51
				if [ $? = 0 ]; then
					sed -e "s/AllowTwoSide.Interaction.Mail = 0/AllowTwoSide.Interaction.Mail = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 22/42\n\n¿Quieres que se pueda comerciar con la facción contraria?." 12 51
				if [ $? = 0 ]; then
					sed -e "s/AllowTwoSide.Trade = 0/AllowTwoSide.Trade = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nOpción 23/42\n\nRATES DEL SERVIDOR:\n\nLos rates son lo que determinan lo rápido que se avanza en el juego.\nLos servidores de Blizzard tienen un rate de x1 por lo que si nosotros ponemos rates x3 se multiplican los valores al triple.\nEjemplo: Ponemos rates de experiencia al matar bichos x3. Si al nivel 10 para subir al 11 debemos matar 30 zebras en el de Blizzard, al nuestro con 10 ya subiríamos." 22 60
				clear

				conf17=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 24/42\n\nRATES DEL SERVIDOR:\nRates de objetos mediocres(grises)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Poor             = 1/Rate.Drop.Item.Poor             = $conf17/g" -i $server_ark/etc/world.conf

				conf18=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 25/42\n\nRATES DEL SERVIDOR:\nRates de objetos normales(blancos)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Normal           = 1/Rate.Drop.Item.Normal           = $conf18/g" -i $server_ark/etc/world.conf

				conf19=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 26/42\n\nRATES DEL SERVIDOR:\nRates de objetos poco frecuentes(verdes)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Uncommon         = 1/Rate.Drop.Item.Uncommon         = $conf19/g" -i $server_ark/etc/world.conf

				conf20=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 27/42\n\nRATES DEL SERVIDOR:\nRates de objetos raros(azules)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Rare             = 1/Rate.Drop.Item.Rare             = $conf20/g" -i $server_ark/etc/world.conf

				conf21=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 28/42\n\nRATES DEL SERVIDOR:\nRates de objetos épicos(morados)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Epic             = 1/Rate.Drop.Item.Epic             = $conf21/g" -i $server_ark/etc/world.conf

				conf22=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 29/42\n\nRATES DEL SERVIDOR:\nRates de objetos legendarios(anaranjados)" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Legendary        = 1/Rate.Drop.Item.Legendary        = $conf22/g" -i $server_ark/etc/world.conf

				conf23=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 30/42\n\nRATES DEL SERVIDOR:\nRates de objetos artefactos" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Artifact         = 1/Rate.Drop.Item.Artifact         = $conf23/g" -i $server_ark/etc/world.conf

				conf24=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 31/42\n\nRATES DEL SERVIDOR:\nRates de objetos de misión" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Item.Referenced       = 1/Rate.Drop.Item.Referenced       = $conf24/g" -i $server_ark/etc/world.conf

				conf25=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 32/42\n\nRATES DEL SERVIDOR:\nRates de dinero" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.Drop.Money                 = 1/Rate.Drop.Money                 = $conf25/g" -i $server_ark/etc/world.conf

				conf26=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 33/42\n\nRATES DEL SERVIDOR:\nRates experiencia por muertes" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.XP.Kill    = 1/Rate.XP.Kill    = $conf26/g" -i $server_ark/etc/world.conf

				conf27=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 34/42\n\nRATES DEL SERVIDOR:\nRates experiencia en misiones" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.XP.Quest   = 1/Rate.XP.Quest   = $conf27/g" -i $server_ark/etc/world.conf

				conf28=$(dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--inputbox "\nOpción 35/42\n\nRATES DEL SERVIDOR:\nRates experiencia por exploración" 12 51 1 2>&1 >/dev/tty)
				sed -e "s/Rate.XP.Explore = 1/Rate.XP.Explore = $conf28/g" -i $server_ark/etc/world.conf

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 36/42\n\n¿Quieres que se anuncie por canal global cuando se anote alguien a BG?\nEsto es útil para cuando hay poca población en el servidor." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Battleground.QueueAnnouncer.Enable = 0/Battleground.QueueAnnouncer.Enable = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 37/42\n\n¿Quieres que esté funcional Wintergrasp?\nTodavía experimental en esta versión de emulador." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Wintergrasp.Enable = 0/Wintergrasp.Enable = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 38/42\n\n¿Quieres que esté funcional Tol Barad?\nTodavía experimental en esta versión de emulador." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Tol Barad.Enable = 0/Tol Barad.Enable = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 39/42\n\n¿Quieres que se adjudiquen los puntos de arenas automáticamente cada semana? Es recomendable que sí." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Arena.AutoDistributePoints = 0/Arena.AutoDistributePoints = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 40/42\n\n¿Quieres que se anuncie por canal global cuando se anote un grupo a arenas?\nEsto es útil para cuando hay poca población en el servidor." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Arena.QueueAnnouncer.Enable = 0/Arena.QueueAnnouncer.Enable = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 41/42\n\n¿Deseas activar el acceso a la máquina por telnet?\nEsto es necesario si quieres tener una tienda de artículos en la web o gestionar el servidor remotamente." 12 51
				if [ $? = 0 ]; then
					sed -e "s/Ra.Enable = 0/Ra.Enable = 1/g" -i $server_ark/etc/world.conf
				fi

				dialog --title "CONFIGURACIÓN DEL worldserver.conf" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nOpción 42/42\n\n¿Si un jugador es Kickeado por un GM, quieres que se muestre el anuncio del kick por el canal global?" 12 51
				if [ $? = 0 ]; then
					sed -e "s/ShowKickInWorld = 0/ShowKickInWorld = 1/g" -i $server_ark/etc/world.conf
				fi

				### Configuraciones que cambiamos automáticamente:
				#PlayerSaveInterval = 900000
				sed -e "s/PlayerSaveInterval = 900000/PlayerSaveInterval = 300000/g" -i $server_ark/etc/world.conf

				#MaxCoreStuckTime = 0
				sed -e "s/MaxCoreStuckTime = 0/MaxCoreStuckTime = 10/g" -i $server_ark/etc/world.conf

				#GmLogPerAccount = 0
				sed -e "s/GmLogPerAccount = 0/GmLogPerAccount = 1/g" -i $server_ark/etc/world.conf

				#RealmZone = 1
				sed -e "s/RealmZone = 1/RealmZone = 11/g" -i $server_ark/etc/world.conf

				#Motd = "Welcome to a ArkCORE....
				sed -e "s/Welcome to a ArkCORE server.@If your seeing this message@it's because the developer hasnt read configs fully/Bienvenido a nuestro servidor./g" -i $server_ark/etc/world.conf
				#AllowPlayerCommands = 0
				sed -e "s/AllowPlayerCommands = 0/AllowPlayerCommands = 1/g" -i $server_ark/etc/world.conf

				#Die.Command.Mode = 1
				sed -e "s/Die.Command.Mode = 1/Die.Command.Mode = 0/g" -i $server_ark/etc/world.conf

				#IF YOUR READING THIS YOUR DEVELOPER HAS NOT READ ALL OF THE CONFIGERATION FILE!
				sed -e "s/IF YOUR READING THIS YOUR DEVELOPER HAS NOT READ ALL OF THE CONFIGERATION FILE!/World of Warcraft - Cataclysm/g" -i $server_ark/etc/world.conf

				#PidFile = "world.pid"  IMPRESCINDIBLE!!! NO TOCAR.  
				sed -e "s/PidFile = \"\"/PidFile = \"world.pid\"/g" -i $server_ark/etc/world.conf

				cp $server_ark/etc/world.conf $server_ark/etc/worldserver.conf
				rm -f $server_ark/etc/world.conf
				dialog --title "INFORMACIÓN" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHas configurado el archivo worldserver.conf.\n\nSi los valores que has introducido son correctos ya puedes arrancar el servidor del juego." 10 50
				clear
			fi


########  CONCLUSIÓN MENÚ Configurar authserver.conf y worldserver.conf  ########
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nConfigurar authserver.conf y worldserver.conf" 20 80 8 \
			"1 - Configurar archivo authserver.conf" "" \
			"2 - Configurar archivo worldserver.conf" "" \
			"0 - Volver" "" 2> ~/var36
		  
			opcion36=$(cat ~/var36)
			rm ~/var36
			done
		fi


########  CONCLUSIÓN MENÚ Configuraciones varias  ########
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nConfiguraciones varias" 20 80 8 \
		"1 - Configurar tabla realmlist de la base de datos auth" "" \
		"2 - Configurar authserver.conf y worldserver.conf" "" \
		"0 - Volver" "" 2> ~/var35
		  
		opcion35=$(cat ~/var35)
		rm ~/var35
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
	"0 - Salir de la aplicación" "" 2> ~/var30
	  
	opcion30=$(cat ~/var30)
	if [ "$opcion30" = "0 - Salir de la aplicación" ]; then
		rm ~/var*
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nGracias por usar el script de instalación." 10 50
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


####################################################################
# TEST TELNET
####################################################################
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "Escoge el nombre de la carpeta del servidor.\nSi no escoges correctamente puede fallar el envio de los comandos por telnet." 15 60 5 \
	"/home/`echo $USER`/Server_sky" "" \
	"/home/`echo $USER`/Server_ark" "" \
	"/home/`echo $USER`/Server_tri" "" \
	"/home/`echo $USER`/Server" "" 2> ~/var16

	opcion16=$(cat ~/var16)

	if [ ! -x $opcion15/Backups  ];then
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nLa ruta ${opcion16} no existe. Asegúrate de escoger la ruta de tu servidor correcta." 10 50
		clear
	fi


GDB_ENABLED=1
PID=$(cat $opcion16/bin/world.pid)
checkStatus $PID
function checkStatus() {
if [ -d "/proc/"$1 ]; then
	eval "TEST=1"
else	
	eval "TEST=0"
fi
}
if [ $TEST -eq 0 ]; then
dialog --title "INFORMACIÓN" \
--backtitle "http://linux.msgsistemes.es" \
--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
fi


####################################################################
# Conexión por Telnet a nuestro servidor
####################################################################
elif [ "$opcion0" = "5 - Conexión por Telnet a nuestro servidor" ]; then
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "\nConexión por Telnet a nuestro servidor" 20 60 8 \
	"1 - Menú de comandos más comunes preestablecidos" "" \
	"2 - Acceder a la consola del servidor" "" \
	"0 - Volver" "" 2> ~/var9
	  
	opcion9=$(cat ~/var9)
	rm ~/var9

	while [ "$opcion9" != "0 - Volver" ]; do


####################################################################
# Menú de comandos más comunes preestablecidos
####################################################################
	if [ "$opcion9" = "1 - Menú de comandos más comunes preestablecidos" ]; then
			tnetusr=$(dialog --title "DATOS DE CONEXIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--inputbox "\nUsuario de conexión via telnet:" 10 51 2>&1 >/dev/tty)

			tnetpass=$(dialog --title "DATOS DE CONEXIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--insecure \
			--passwordbox "\nContraseña del usuario de telnet:" 10 51 2>&1 >/dev/tty)
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nMenú de comandos más comunes preestablecidos" 20 60 10 \
		"1 - account create" "" \
		"2 - account set password" "" \
		"3 - Reservado" "" \
		"4 - announce" "" \
		"5 - ban - menú opciones" "" \
		"6 - flusharenapoints" "" \
		"7 - kick" "" \
		"8 - nameannounce" "" \
		"9 - notify" "" \
		"10 - reload - menú opciones" "" \
		"11 - saveall" "" \
		"12 - send mail" "" \
		"13 - server restart" "" \
		"14 - unban - menú opciones" "" \
		"0 - Volver" "" 2> ~/var10
	  
		opcion10=$(cat ~/var10)
		rm ~/var10

		while [ "$opcion10" != "0 - Volver" ]; do


####################################################################
# 8.1.1 - account create
####################################################################
		if [ "$opcion10" = "1 - account create" ]; then
			clear
			GDB_ENABLED=1
			PID=$(cat $opcion16/bin/world.pid)
			checkStatus $PID
			function checkStatus() {
			if [ -d "/proc/"$1 ]; then
				eval "TEST=1"
			else	
				eval "TEST=0"
			fi
			}
			if [ $TEST -eq 0 ]; then
			dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
			else
			
			newusr=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--inputbox "\nNombre del nuevo usuario:" 10 51 2>&1 >/dev/tty)

			newupass=$(dialog --title "DATOS DE CONEXIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--insecure \
			--passwordbox "\nContraseña del nuevo usuario:" 10 51 2>&1 >/dev/tty)
			clear

			(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "account create $newusr $newupass"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
			(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "account set addon $newusr 3"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
			fi
			busca=`cat log_conexion | grep "Account created:"`
			if [ -z $busca ];then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHa ocurrido algún error y no se ha creado la cuenta correctamente." 8 50 && clear
				clear
			else
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nSe ha creado la cuenta $newusr." 8 50 && clear
				clear
			fi
			rm log_conexion
			killall telnet


####################################################################
# account set password
####################################################################
		elif [ "$opcion10" = "2 - account set password" ]; then	
			GDB_ENABLED=1
			PID=$(cat $opcion16/bin/world.pid)
			checkStatus $PID
			function checkStatus() {
			if [ -d "/proc/"$1 ]; then
				eval "TEST=1"
			else	
				eval "TEST=0"
			fi
			}
			if [ $TEST -eq 0 ]; then
			dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
			else
			
			accusr=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--inputbox "\nNombre del usuario que quieres cambiar la contraseña:" 10 51 2>&1 >/dev/tty)

			passusr=$(dialog --title "DATOS DE CONEXIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--insecure \
			--passwordbox "\nNueva contraseña:" 10 51 2>&1 >/dev/tty)
			clear

			(sleep 2; echo "$tnetusr"; sleep 2; echo "$tnetpass"; sleep 1; echo "account set password $accusr $passusr $passusr"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
			fi
			busca=`cat log_conexion | grep "The password was changed"`
			if [ -z $busca ];then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHa ocurrido algún error y no se ha podido cambiar la contraseña." 8 50 && clear
				clear
			else
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nSe ha cambiado correctamente la contraseña a la cuenta $accusr." 8 50 && clear
				clear
			fi
			rm log_conexion
			killall telnet



####################################################################
# 8.1.3 - Reservado
####################################################################
		elif [ "$opcion10" = "3 - Reservado" ]; then
			dialog --title "INFORMACIÓN" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nEste apartado no está disponible por el momento." 8 50 && clear
			clear


####################################################################
# 8.1.4 - announce
####################################################################
		elif [ "$opcion10" = "4 - announce" ]; then
			clear
			GDB_ENABLED=1
			PID=$(cat $opcion16/bin/world.pid)
			checkStatus $PID
			function checkStatus() {
			if [ -d "/proc/"$1 ]; then
				eval "TEST=1"
			else	
				eval "TEST=0"
			fi
			}
			if [ $TEST -eq 0 ]; then
			dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
			else
			
			mensaje=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--inputbox "\nEscribe el mensaje que quieres que aparezca en el canal global:" 10 51 2>&1 >/dev/tty)
			clear

			(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "announce $mensaje"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
			fi
			busca=`cat log_conexion | grep "Bye"`
			if [ -z $busca ];then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHa ocurrido algún error y no se ha mandado el mensaje." 8 50 && clear
				clear
			else
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nSe ha enviado el mensaje:\n\n $mensaje." 15 50 && clear
				clear
			fi
			rm log_conexion
			killall telnet


####################################################################
# ban - menú opciones
####################################################################
		elif [ "$opcion10" = "5 - ban - menú opciones" ]; then
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nban - menú opciones" 20 60 8 \
			"1 - ban account" "" \
			"2 - ban character" "" \
			"3 - ban ip" "" \
			"0 - Volver" "" 2> ~/var11
		  
			opcion11=$(cat ~/var11)
			rm ~/var11
	
			while [ "$opcion11" != "0 - Volver" ]; do


####################################################################
# ban account
####################################################################
			if [ "$opcion11" = "1 - ban account" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
				
					cuentaban=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--nocancel \
					--inputbox "\nEscribe el nombre de la cuenta a banear:" 10 51 2>&1 >/dev/tty)
					clear
	
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--defaultno \
					--yesno "\n¿Quieres banear esta cuenta por un tiempo indefinido?\n\nSi contestas no, deberás especificar los días, horas y segundos de la duración del baneo." 12 51
					if [ $? = 0 ]; then
						perm=-1
						banrazon=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el motivo por lo que quieres banear a $cuentaban:" 10 51 2>&1 >/dev/tty)
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "ban account $cuentaban $perm $banrazon"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						busca=`cat log_conexion | grep "banned permanently"`
						if [ -z $busca ];then
							dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nHa ocurrido algún error y no se ha baneado la cuenta." 8 50 && clear
							clear
						else
							dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nSe ha baneado la cuenta $cuentaban por tiempo indefinido.\nMotivo: $banrazon" 10 50 && clear
							clear
						fi
						rm log_conexion
						killall telnet
					else
						bandias=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el número de días por los que quieres banear a $cuentaban:\n\nEscibe entre 0 y 365" 10 51 2>&1 >/dev/tty)
						clear
	
						banhoras=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el número de horas por las que quieres banear a $cuentaban:\n\nEscibe entre 0 y 23" 10 51 2>&1 >/dev/tty)
						clear

						banseg=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el número de segundos por los que quieres banear a $cuentaban:\n\nEscibe entre 0 y 59" 10 51 2>&1 >/dev/tty)
						clear
					
						banrazon=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el motivo por lo que quieres banear a $cuentaban:" 10 51 2>&1 >/dev/tty)
						clear
				
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "ban account $cuentaban ${bandias}d${banhoras}h${banseg}s $banrazon"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						
						busca=`cat log_conexion | grep "is banned for"`
						if [ -z $busca ];then
							dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nHa ocurrido algún error y no se ha baneado la cuenta." 8 50 && clear
							clear
						else
								dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nSe ha baneado la cuenta $cuentaban por:\n$bandias días, $banhoras horas y $banseg segundos.\n\nMotivo: $banrazon" 14 50 && clear
							clear
						fi
						rm log_conexion
						killall telnet
					fi		
				fi


####################################################################
# ban character
####################################################################
			elif [ "$opcion11" = "2 - ban character" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
				
					charban=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--nocancel \
					--inputbox "\nEscribe el nombre del character a banear:" 10 51 2>&1 >/dev/tty)
					clear
	
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--defaultno \
					--yesno "\n¿Quieres banear este character por un tiempo indefinido?\n\nSi contestas no, deberás especificar los días, horas y segundos de la duración del baneo." 12 51
					if [ $? = 0 ]; then
						perm=-1
						banrazon=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el motivo por lo que quieres banear a $charban:" 10 51 2>&1 >/dev/tty)
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "ban character $charban $perm $banrazon"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						busca=`cat log_conexion | grep "banned permanently"`
						if [ -z $busca ];then
							dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nHa ocurrido algún error y no se ha baneado el character." 8 50 && clear
							clear
						else
							dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nSe ha baneado el character $charban por tiempo indefinido.\nMotivo: $banrazon" 10 50 && clear
							clear
						fi
						rm log_conexion
						killall telnet
					else
						bandias=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el número de días por los que quieres banear a $charban:\n\nEscibe entre 0 y 365" 10 51 2>&1 >/dev/tty)
						clear
	
						banhoras=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el número de horas por las que quieres banear a $charban:\n\nEscibe entre 0 y 23" 10 51 2>&1 >/dev/tty)
						clear

						banseg=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el número de segundos por los que quieres banear a $charban:\n\nEscibe entre 0 y 59" 10 51 2>&1 >/dev/tty)
						clear
					
						banrazon=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el motivo por lo que quieres banear a $charban:" 10 51 2>&1 >/dev/tty)
						clear
				
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "ban character $charban ${bandias}d${banhoras}h${banseg}s $banrazon"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						
						busca=`cat log_conexion | grep "is banned for"`
						if [ -z $busca ];then
							dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nHa ocurrido algún error y no se ha baneado el character." 8 50 && clear
							clear
						else
								dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nSe ha baneado el character $charban por:\n$bandias días, $banhoras horas y $banseg segundos.\n\nMotivo: $banrazon" 14 50 && clear
							clear
						fi
						rm log_conexion
						killall telnet
					fi		
				fi


####################################################################
# ban ip
####################################################################
			elif [ "$opcion11" = "3 - ban ip" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
				
					ipban=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--nocancel \
					--inputbox "\nEscribe el número de la ip a banear:" 10 51 2>&1 >/dev/tty)
					clear
	
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--defaultno \
					--yesno "\n¿Quieres banear esta ip por un tiempo indefinido?\n\nSi contestas no, deberás especificar los días, horas y segundos de la duración del baneo." 12 51
					if [ $? = 0 ]; then
						perm=-1
						banrazon=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el motivo por lo que quieres banear a $ipban:" 10 51 2>&1 >/dev/tty)
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "ban ip $ipban $perm $banrazon"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						busca=`cat log_conexion | grep "banned permanently"`
						if [ -z $busca ];then
							dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nHa ocurrido algún error y no se ha baneado la ip." 8 50 && clear
							clear
						else
							dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nSe ha baneado la ip $ipban por tiempo indefinido.\nMotivo: $banrazon" 10 50 && clear
							clear
						fi
						rm log_conexion
						killall telnet
					else
						bandias=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el número de días por los que quieres banear la ip $ipban:\n\nEscibe entre 0 y 365" 10 51 2>&1 >/dev/tty)
						clear
	
						banhoras=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el número de horas por las que quieres banear la ip $ipban:\n\nEscibe entre 0 y 23" 10 51 2>&1 >/dev/tty)
						clear

						banseg=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el número de segundos por los que quieres banear la ip $ipban:\n\nEscibe entre 0 y 59" 10 51 2>&1 >/dev/tty)
						clear
					
						banrazon=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--nocancel \
						--inputbox "\nEscribe el motivo por lo que quieres banear la ip $ipban:" 10 51 2>&1 >/dev/tty)
						clear
				
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "ban ip $ipban ${bandias}d${banhoras}h${banseg}s $banrazon"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						
						busca=`cat log_conexion | grep "is banned for"`
						if [ -z $busca ];then
							dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nHa ocurrido algún error y no se ha baneado la ip." 8 50 && clear
							clear
						else
								dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
							--backtitle "http://linux.msgsistemes.es" \
							--msgbox "\nSe ha baneado la ip $ipban por:\n$bandias días, $banhoras horas y $banseg segundos.\n\nMotivo: $banrazon" 14 50 && clear
							clear
						fi
						rm log_conexion
						killall telnet
					fi		
				fi
			fi


########  CONCLUSIÓN MENÚ 9.1.5  ########
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nban - menú opciones" 20 60 8 \
			"1 - ban account" "" \
			"2 - ban character" "" \
			"3 - ban ip" "" \
			"0 - Volver" "" 2> ~/var11
	  
			opcion11=$(cat ~/var11)
			rm ~/var11
			done


####################################################################
# flusharenapoints
####################################################################
		elif [ "$opcion10" = "6 - flusharenapoints" ]; then
			clear
			GDB_ENABLED=1
			PID=$(cat $opcion16/bin/world.pid)
			checkStatus $PID
			function checkStatus() {
			if [ -d "/proc/"$1 ]; then
				eval "TEST=1"
			else	
				eval "TEST=0"
			fi
			}
			if [ $TEST -eq 0 ]; then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
			else
			
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nSe repartirán los puntos de arenas. ¿Estás de acuerdo?" 10 51
					if [ $? = 0 ]; then
					clear
					(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "flusharenapoints"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
					fi
				busca=`cat log_conexion | grep "Bye"`
				if [ -z $busca ];then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nHa ocurrido algún error y no se han adjudicado los puntos de arenas." 8 50 && clear
					clear
				else
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nSe han adjudicado los puntos de arenas." 8 50 && clear
					clear
				fi
			fi
			rm log_conexion
			killall telnet


####################################################################
# kick
####################################################################
		elif [ "$opcion10" = "7 - kick" ]; then
			clear
			GDB_ENABLED=1
			PID=$(cat $opcion16/bin/world.pid)
			checkStatus $PID
			function checkStatus() {
			if [ -d "/proc/"$1 ]; then
				eval "TEST=1"
			else	
				eval "TEST=0"
			fi
			}
			if [ $TEST -eq 0 ]; then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
			else
				userkick=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--nocancel \
				--inputbox "\nEscribe el nombre de character que quieres kickear:" 10 51 2>&1 >/dev/tty)
				clear
				razonkick=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--nocancel \
				--inputbox "\nEscribe el motivo:" 10 51 2>&1 >/dev/tty)
				clear
				(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "kick $userkick $razonkick"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
			fi
			busca=`cat log_conexion | grep "Bye"`
			if [ -z $busca ];then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHa ocurrido algún error y no se han adjudicado los puntos de arenas." 8 50 && clear
				clear
			else
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nSe ha kickeado al jugador $userkick.\nEl motivo a sido: $razonkick" 8 50 && clear
				clear
			fi
			rm log_conexion
			killall telnet


####################################################################
# nameannounce
####################################################################
		elif [ "$opcion10" = "8 - nameannounce" ]; then
			clear
			GDB_ENABLED=1
			PID=$(cat $opcion16/bin/world.pid)
			checkStatus $PID
			function checkStatus() {
			if [ -d "/proc/"$1 ]; then
				eval "TEST=1"
			else	
				eval "TEST=0"
			fi
			}
			if [ $TEST -eq 0 ]; then
			dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
			else
			
			nameannounce=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--inputbox "\nEscribe el mensaje que quieres que aparezca en el canal global:\nSerá enviado como anunciante el Servidor." 10 51 2>&1 >/dev/tty)
			clear

			(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "nameannounce $nameannounce"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
			fi
			busca=`cat log_conexion | grep "Bye"`
			if [ -z $busca ];then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHa ocurrido algún error y no se ha mandado el mensaje." 8 50 && clear
				clear
			else
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nSe ha enviado el mensaje:\n\n $nameannounce." 15 50 && clear
				clear
			fi
			rm log_conexion
			killall telnet


####################################################################
# notify
####################################################################
		elif [ "$opcion10" = "9 - notify" ]; then
			clear
			GDB_ENABLED=1
			PID=$(cat $opcion16/bin/world.pid)
			checkStatus $PID
			function checkStatus() {
			if [ -d "/proc/"$1 ]; then
				eval "TEST=1"
			else	
				eval "TEST=0"
			fi
			}
			if [ $TEST -eq 0 ]; then
			dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
			else
			
			notify=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--inputbox "\nEscribe el mensaje que quieres que aparezca como notificación al centro de la pantalla de los jugadores:" 10 51 2>&1 >/dev/tty)
			clear

			(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "notify $notify"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
			fi
			busca=`cat log_conexion | grep "Bye"`
			if [ -z $busca ];then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHa ocurrido algún error y no se ha mandado el mensaje." 8 50 && clear
				clear
			else
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nSe ha enviado el mensaje:\n\n $notify." 15 50 && clear
				clear
			fi
			rm log_conexion
			killall telnet


####################################################################
# reload - menú opciones
####################################################################
		elif [ "$opcion10" = "10 - reload - menú opciones" ]; then
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nreload - menú opciones" 20 60 8 \
			"1 - reload autobroadcast" "" \
			"2 - reload creature_template" "" \
			"3 - reload disables" "" \
			"4 - reload gossip_menu" "" \
			"5 - reload quest_template" "" \
			"6 - reload all" "" \
			"0 - Volver" "" 2> ~/var12
		  
			opcion12=$(cat ~/var12)
			rm ~/var12
		
			while [ "$opcion12" != "0 - Volver" ]; do


####################################################################
# reload autobroadcast
####################################################################
			if [ "$opcion12" = "1 - reload autobroadcast" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
			
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--yesno "\nSe recargará la tabla autobroadcast de la base de datos. ¿Estás de acuerdo?" 10 51
						if [ $? = 0 ]; then
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "reload autobroadcast"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						fi
					busca=`cat log_conexion | grep "Bye"`
					if [ -z $busca ];then
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nHa ocurrido algún error y no se han recargado los datos." 8 50 && clear
						clear
					else
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nSe ha recargado la tabla autobroadcast correctamente." 8 50 && clear
						clear
					fi
				fi
				rm log_conexion
				killall telnet


####################################################################
# reload creature_template
####################################################################
			elif [ "$opcion12" = "2 - reload creature_template" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
				
					idcreature=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--nocancel \
					--inputbox "\nEscribe la id del NPC que quieres recargar:" 10 51 2>&1 >/dev/tty)
					clear
					(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "reload creature_template $idcreature"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
					busca=`cat log_conexion | grep "Bye"`
					if [ -z $busca ];then
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nHa ocurrido algún error y no se han recargado los datos." 8 50 && clear
						clear
					else
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nSe ha recargado la id del NPC $idcreature correctamente." 8 50 && clear
						clear
					fi
				fi
				rm log_conexion
				killall telnet


####################################################################
# reload disables
####################################################################
			elif [ "$opcion12" = "3 - reload disables" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
			
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--yesno "\nSe recargará la tabla disables de la base de datos. ¿Estás de acuerdo?" 10 51
						if [ $? = 0 ]; then
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "reload disables"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						fi
					busca=`cat log_conexion | grep "Bye"`
					if [ -z $busca ];then
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nHa ocurrido algún error y no se han recargado los datos." 8 50 && clear
						clear
					else
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nSe ha recargado la tabla disables correctamente." 8 50 && clear
						clear
					fi
				fi
				rm log_conexion
				killall telnet


####################################################################
# reload gossip_menu
####################################################################
			elif [ "$opcion12" = "4 - reload gossip_menu" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
			
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--yesno "\nSe recargará la tabla gossip_menu de la base de datos. ¿Estás de acuerdo?" 10 51
						if [ $? = 0 ]; then
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "reload gossip_menu"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						fi
					busca=`cat log_conexion | grep "Bye"`
					if [ -z $busca ];then
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nHa ocurrido algún error y no se han recargado los datos." 8 50 && clear
						clear
					else
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nSe ha recargado la tabla gossip_menu correctamente." 8 50 && clear
						clear
					fi
				fi
				rm log_conexion
				killall telnet


####################################################################
# reload quest_template
####################################################################
			elif [ "$opcion12" = "5 - reload quest_template" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
			
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--yesno "\nSe recargará la tabla quest_template de la base de datos. ¿Estás de acuerdo?" 10 51
						if [ $? = 0 ]; then
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "reload quest_template"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						fi
					busca=`cat log_conexion | grep "Bye"`
					if [ -z $busca ];then
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nHa ocurrido algún error y no se han recargado los datos." 8 50 && clear
						clear
					else
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nSe ha recargado la tabla quest_template correctamente." 8 50 && clear
						clear
					fi
				fi
				rm log_conexion
				killall telnet


####################################################################
# reload all
####################################################################
			elif [ "$opcion12" = "6 - reload all" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
			
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--yesno "\nSe recargarán todas las tablas de la base de datos que se permitan estando el servidor en marcha. Este proceso puede dar mucho lag al servidor e incluso provocar una caida. ¿Estás de acuerdo?" 13 51
						if [ $? = 0 ]; then
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "reload all"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						fi
					busca=`cat log_conexion | grep "Bye"`
					if [ -z $busca ];then
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nHa ocurrido algún error y no se han recargado los datos." 8 50 && clear
						clear
					else
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nSe han recargado todas las tablas de la base de datos correctamente." 8 50 && clear
						clear
					fi
				fi
				rm log_conexion
				killall telnet
			fi


########  CONCLUSIÓN MENÚ  ########
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nreload - menú opciones" 20 60 8 \
			"1 - reload autobroadcast" "" \
			"2 - reload creature_template" "" \
			"3 - reload disables" "" \
			"4 - reload gossip_menu" "" \
			"5 - reload quest_template" "" \
			"6 - reload all" "" \
			"0 - Volver" "" 2> ~/var12
			  
			opcion12=$(cat ~/var12)
			rm ~/var12
			done


####################################################################
# saveall
####################################################################
		elif [ "$opcion10" = "11 - saveall" ]; then
			clear
			GDB_ENABLED=1
			PID=$(cat $opcion16/bin/world.pid)
			checkStatus $PID
			function checkStatus() {
			if [ -d "/proc/"$1 ]; then
				eval "TEST=1"
			else	
				eval "TEST=0"
			fi
			}
			if [ $TEST -eq 0 ]; then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
			else
			
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--yesno "\nSe va a salvar todos los players. ¿Estás de acuerdo?" 10 51
					if [ $? = 0 ]; then
					clear
					(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "saveall"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
					fi
				busca=`cat log_conexion | grep "players saved"`
				if [ -z $busca ];then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nHa ocurrido algún error y no se han salvado los jugadores." 8 50 && clear
					clear
				else
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nSe han salvado todos los players." 8 50 && clear
					clear
				fi
			fi
			rm log_conexion
			killall telnet


####################################################################
# send mail
####################################################################
		elif [ "$opcion10" = "12 - send mail" ]; then
			clear
			GDB_ENABLED=1
			PID=$(cat $opcion16/bin/world.pid)
			checkStatus $PID
			function checkStatus() {
			if [ -d "/proc/"$1 ]; then
				eval "TEST=1"
			else	
				eval "TEST=0"
			fi
			}
			if [ $TEST -eq 0 ]; then
			dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
			else
			
			pjmail=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--inputbox "\nEscribe el nombre del personaje que debe recibir el correo:" 10 51 2>&1 >/dev/tty)
			clear

			subtxt=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--inputbox "\nEscribe el título del correo:" 10 51 2>&1 >/dev/tty)
			clear

			mailtxt=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--inputbox "\nAquí debes escribir el cuerpo del mensaje:" 10 51 2>&1 >/dev/tty)
			clear

			(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "send mail $pjmail \"$subtxt\" \"$mailtxt\""; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
			fi
			busca=`cat log_conexion | grep "Mail sent to"`
			if [ -z $busca ];then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHa ocurrido algún error y no se ha mandado el mensaje." 8 50 && clear
				clear
			else
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nSe ha enviado el mail:\n$subtxt al jugador $pjmail." 15 50 && clear
				clear
			fi
			rm log_conexion
			killall telnet


####################################################################
# server restart
####################################################################
		elif [ "$opcion10" = "13 - server restart" ]; then
			clear
			GDB_ENABLED=1
			PID=$(cat $opcion16/bin/world.pid)
			checkStatus $PID
			function checkStatus() {
			if [ -d "/proc/"$1 ]; then
				eval "TEST=1"
			else	
				eval "TEST=0"
			fi
			}
			if [ $TEST -eq 0 ]; then
			dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
			else
			
			tiemporestart=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--inputbox "\nEscribe en segundos el tiempo que quieres que tarde en reiniciar el servidor en segundos:\n\nSe manda un mensaje al chat global avisando del reinicio y el tiempo" 12 51 2>&1 >/dev/tty)
			clear

			(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "server restart $tiemporestart"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
			fi
			busca=`cat log_conexion | grep "Bye"`
			if [ -z $busca ];then
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nHa ocurrido algún error y no se ha mandado la orden de reinicio." 8 50 && clear
				clear
			else
				dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
				--backtitle "http://linux.msgsistemes.es" \
				--msgbox "\nSe va a reiniciar el servidor en $tiemporestart segundos." 10 50 && clear
				clear
			fi
			rm log_conexion
			killall telnet


####################################################################
# unban - menú opciones
####################################################################
		elif [ "$opcion10" = "14 - unban - menú opciones" ]; then
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nunban - menú opciones" 20 60 8 \
			"1 - unban account" "" \
			"2 - unban character" "" \
			"3 - unban ip" "" \
			"0 - Volver" "" 2> ~/var13
		  
			opcion13=$(cat ~/var13)
			rm ~/var13
		
			while [ "$opcion13" != "0 - Volver" ]; do


####################################################################
# unban account
####################################################################
			if [ "$opcion13" = "1 - unban account" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
					unbanac=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--nocancel \
					--inputbox "\nEscribe la cuenta que quieres desbanear:" 12 51 2>&1 >/dev/tty)
					clear
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--yesno "\nEsta acción desbaneará a $unbanac. ¿Estás de acuerdo?" 10 51
						if [ $? = 0 ]; then
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "unban account $unbanac"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						fi
					busca=`cat log_conexion | grep "unbanned"`
					if [ -z $busca ];then
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nHa ocurrido algún error y no se ha podido desbanear a $unbanac." 8 50 && clear
						clear
					else
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nSe ha desbaneado correctamente a $unbanac." 8 50 && clear
						clear
					fi
				fi
				rm log_conexion
				killall telnet


####################################################################
# unban character
####################################################################
			elif [ "$opcion13" = "2 - unban character" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
					unbanchar=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--nocancel \
					--inputbox "\nEscribe el character que quieres desbanear:" 12 51 2>&1 >/dev/tty)
					clear
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--yesno "\nEsta acción desbaneará a $unbanchar. ¿Estás de acuerdo?" 10 51
						if [ $? = 0 ]; then
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "unban character $unbanchar"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						fi
					busca=`cat log_conexion | grep "Bye"`
					if [ -z $busca ];then
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nHa ocurrido algún error y no se ha podido desbanear a $unbanchar." 8 50 && clear
						clear
					else
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nSe ha desbaneado correctamente a $unbanchar." 8 50 && clear
						clear
					fi
				fi
				rm log_conexion
				killall telnet


####################################################################
# unban ip
####################################################################
			elif [ "$opcion13" = "3 - unban ip" ]; then
				clear
				GDB_ENABLED=1
				PID=$(cat $opcion16/bin/world.pid)
				checkStatus $PID
				function checkStatus() {
				if [ -d "/proc/"$1 ]; then
					eval "TEST=1"
				else	
					eval "TEST=0"
				fi
				}
				if [ $TEST -eq 0 ]; then
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
				else
					unbanip=$(dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--nocancel \
					--inputbox "\nEscribe la ip que quieres desbanear:" 12 51 2>&1 >/dev/tty)
					clear
					dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
					--backtitle "http://linux.msgsistemes.es" \
					--yesno "\nEsta acción desbaneará la ip $unbanip. ¿Estás de acuerdo?" 10 51
						if [ $? = 0 ]; then
						clear
						(sleep 2; echo "$tnetusr"; sleep 3; echo "$tnetpass"; sleep 1; echo "unban ip $unbanip"; echo "exit"; sleep 1) | telnet 127.0.0.1 3443 >> log_conexion 
						fi
					busca=`cat log_conexion | grep "unbanned"`
					if [ -z $busca ];then
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nHa ocurrido algún error y no se ha podido desbanear a $unbanip." 8 50 && clear
						clear
					else
						dialog --title "CONEXIÓN TELNET AL SERVIDOR" \
						--backtitle "http://linux.msgsistemes.es" \
						--msgbox "\nSe ha desbaneado correctamente a $unbanip." 8 50 && clear
						clear
					fi
				fi
				rm log_conexion
				killall telnet
			fi


########  CONCLUSIÓN MENÚ unban - menú opciones  ########
			dialog --title "Menú de opciones --- Creado por MSANCHO" \
			--backtitle "http://linux.msgsistemes.es" \
			--nocancel \
			--menu "\nunban - menú opciones" 20 60 8 \
			"1 - unban account" "" \
			"2 - unban character" "" \
			"3 - unban ip" "" \
			"0 - Volver" "" 2> ~/var13
			  
			opcion13=$(cat ~/var13)
			rm ~/var13
			done
		fi


########  CONCLUSIÓN MENÚ Menú de comandos más comunes preestablecidos  ########
		dialog --title "Menú de opciones --- Creado por MSANCHO" \
		--backtitle "http://linux.msgsistemes.es" \
		--nocancel \
		--menu "\nMenú de comandos más comunes preestablecidos" 20 60 10 \
		"1 - account create" "" \
		"2 - account set password" "" \
		"3 - Reservado" "" \
		"4 - announce" "" \
		"5 - ban - menú opciones" "" \
		"6 - flusharenapoints" "" \
		"7 - kick" "" \
		"8 - nameannounce" "" \
		"9 - notify" "" \
		"10 - reload - menú opciones" "" \
		"11 - saveall" "" \
		"12 - send mail" "" \
		"13 - server restart" "" \
		"14 - unban - menú opciones" "" \
		"0 - Volver" "" 2> ~/var10
			  
		opcion10=$(cat ~/var10)
		rm ~/var10
		done


####################################################################
# Acceder a la consola del servidor
####################################################################

	elif [ "$opcion9" = "2 - Acceder a la consola del servidor" ]; then
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nPara que la connexión sea correcta necesitas tener instalado el GDM. Si no lo tienes o tienes dudas, ejecuta el comando: 'sudo apt-get install GDM'.\n\nVamos a establecer conexión al servidor mediante consola.\n\nPara salir debes escribir exit o logout pero no cierres la ventana ya que podría quedar la sesión activa." 15 60 && clear
		clear

		GDB_ENABLED=1
		PID=$(cat $opcion16/bin/world.pid)
		checkStatus $PID
		function checkStatus() {
		if [ -d "/proc/"$1 ]; then
			eval "TEST=1"
		else	
			eval "TEST=0"
		fi
		}
			
		if [ $TEST -eq 0 ]; then
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nNo hay respuesta del servidor. Comprueba que esté online y que tengas la conexión remota activada en el archivo worldserver.conf." 8 50 && clear
		else
		telnet 127.0.0.1 3443
		fi
	fi


########  CONCLUSIÓN MENÚ Conexión por Telnet a nuestro servidor  ########
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "\nConexión por Telnet a nuestro servidor" 20 60 8 \
	"1 - Menú de comandos más comunes preestablecidos" "" \
	"2 - Acceder a la consola del servidor" "" \
	"0 - Volver" "" 2> var9
	  
	opcion9=$(cat var9)
	rm var9
	done


####################################################################
# Copias de seguridad de las Bases de Datos
####################################################################
elif [ "$opcion0" = "6 - Copias de seguridad de las Bases de Datos" ]; then

	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "Escoge el nombre de la carpeta del servidor.\nSi no escoges correctamente no se realizarán las copias." 15 60 5 \
	"/home/`echo $USER`/Server_sky" "" \
	"/home/`echo $USER`/Server_ark" "" \
	"/home/`echo $USER`/Server_tri" "" \
	"/home/`echo $USER`/Server" "" 2> ~/var15

	opcion15=$(cat ~/var15)

	if [ ! -x $opcion15/Backups  ];then
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nLa ruta ${opcion15} no existe. Asegúrate de escoger la ruta de tu servidor correcta." 10 50
		clear
	fi

	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "\nAquí se harán las copias de seguridad de las Bases de Datos" 20 80 8 \
	"1 - Backup de la DB World" "" \
	"2 - Backup de la DB Auth" "" \
	"3 - Backup de la DB Characters" "" \
	"4 - Backup de otra Base de Datos" "" \
	"0 - Volver" "" 2> ~/var14
	  
	opcion14=$(cat ~/var14)
	rm ~/var14 && rm ~/var15

	while [ "$opcion14" != "0 - Volver" ]; do


####################################################################
# Backup de la DB World
####################################################################
	if [ "$opcion14" = "1 - Backup de la DB World" ]; then
		clear && echo "Realizando la copia..." && sleep 5s
		mysqldump $conecta ${world} > "$opcion15/Backups/world_backup.sql"
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nFinalizada la copia de seguridad de la Base de Datos ${world}." 10 50
		clear


####################################################################
# Backup de la DB Auth
####################################################################
	elif [ "$opcion14" = "2 - Backup de la DB Auth" ]; then
		clear && echo "Realizando la copia..." && sleep 5s
		mysqldump $conecta ${auth} > "$opcion15/Backups/auth_backup.sql"
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nFinalizada la copia de seguridad de la Base de Datos ${auth}." 10 50
		clear


####################################################################
# Backup de la DB Characters
####################################################################
	elif [ "$opcion14" = "3 - Backup de la DB Characters" ]; then
		clear && echo "Realizando la copia..." && sleep 5s
		mysqldump $conecta ${char} > "$opcion15/Backups/characters_backup.sql"
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nFinalizada la copia de seguridad de la Base de Datos ${char}." 10 50
		clear


####################################################################
# Backup de otra Base de Datos
####################################################################
	elif [ "$opcion14" = "4 - Backup de otra Base de Datos" ]; then
		clear
		otradb=$(dialog --title "BACKUP BASE DE DATOS" \
		--backtitle "http://linux.msgsistemes.es" \
		--inputbox "\nEscribe el nombre de la base de datos que quieres realizar la copia de seguridad" 10 51 2>&1 >/dev/tty)
		mysqldump $conecta ${otradb} > "$opcion15/Backups/${otradb}_backup.sql"
		dialog --title "INFORMACIÓN" \
		--backtitle "http://linux.msgsistemes.es" \
		--msgbox "\nFinalizada la copia de seguridad de la Base de Datos ${otradb}." 10 50
		clear
	fi


########  CONCLUSIÓN MENÚ copias de seguridad de las Bases de Datos  ########
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--nocancel \
	--menu "\nCopias de seguridad de las Bases de Datos" 20 80 8 \
	"1 - Backup de la DB World" "" \
	"2 - Backup de la DB Auth" "" \
	"3 - Backup de la DB Characters" "" \
	"4 - Backup de otra Base de Datos" "" \
	"0 - Volver" "" 2> ~/var14
	  
	opcion14=$(cat ~/var14)
	rm ~/var14 && rm ~/var15
	done
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
"9 - PRÓXIMAMENTE - Crea tu web de registro de cuentas" "" \
"0 - Salir de la aplicación" "" 2> ~/var0
	  
opcion0=$(cat ~/var0)

if [ "$opcion0" = "0 - Salir de la aplicación" ]; then
	rm ~/var*
	dialog --title "Menú de opciones --- Creado por MSANCHO" \
	--backtitle "http://linux.msgsistemes.es" \
	--msgbox "\nGracias por usar el script de instalación." 10 50
	clear
fi
done


