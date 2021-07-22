#!/bin/bash

profile=dev

rootDir='parent/path/to/all/projects/folder'
serverConfigDir='ServerConfig'
registryDir='Registry'
gatewayDir='Gateway'
msRechercheDir='MSRecherche'
msReservationDir='MSReservation'
concentrateurDir='Concentrateur'
gitConfigDir='DistantConfigurations'


if [ "$1" == "start" ]; then
    echo "Start all PatateMaison programs"
    if [ "$2" ]; then
        profile=$2
    fi
    echo "Choosen profile : $profile"
    echo "Start $rootDir/$serverConfigDir" ;
    cd $rootDir/$serverConfigDir ;
    ./mvnw spring-boot:run -Dspring-boot.run.profiles=$profile > $rootDir/log-$serverConfigDir&
    sleep 20
    echo "Start $rootDir/$registryDir" ;
    cd $rootDir/$registryDir ;
    ./mvnw spring-boot:run -Dspring-boot.run.profiles=$profile > $rootDir/log-$registryDir&
    sleep 25
    echo "Start $rootDir/$gatewayDir" ;
    cd $rootDir/$gatewayDir ;
    ./mvnw spring-boot:run -Dspring-boot.run.profiles=$profile > $rootDir/log-$gatewayDir&
    sleep 25
    echo "Start $rootDir/$concentrateurDir" ;
    cd $rootDir/$concentrateurDir ;
    ./mvnw spring-boot:run -Dspring-boot.run.profiles=$profile > $rootDir/log-$concentrateurDir&
    sleep 25
    echo "Start $rootDir/$msRechercheDir" ;
    cd $rootDir/$msRechercheDir ;
    ./mvnw spring-boot:run -Dspring-boot.run.profiles=$profile > $rootDir/log-$msRechercheDir&
    sleep 20
    echo "Start $rootDir/$msReservationDir" ;
    cd $rootDir/$msReservationDir ;
    ./mvnw spring-boot:run -Dspring-boot.run.profiles=$profile > $rootDir/log-$msReservationDir&
    sleep 20
    echo "----------------------------------"
    echo "Script finished"
    echo "----------------------------------"
fi


if [ "$1" == "stop" ]; then
    echo "Stop all PatateMaison programs"
    kill -TERM $(ps | grep "java" | awk '{print $1}')
    rm -f $rootDir/log-*
fi

if [ "$1" == "update" ]; then
    echo "Update all PatateMaison git repositories"
    echo "Update $rootDir/$serverConfigDir" ; cd $rootDir/$serverConfigDir ; git pull --rebase origin master:master
    echo "Update $rootDir/$registryDir" ; cd $rootDir/$registryDir ; git pull --rebase origin master:master
    echo "Update $rootDir/$gatewayDir" ; cd $rootDir/$gatewayDir ; git pull --rebase origin master:master
    echo "Update $rootDir/$msRechercheDir" ; cd $rootDir/$msRechercheDir ; git pull --rebase origin master:master
    echo "Update $rootDir/$msReservationDir" ; cd $rootDir/$msReservationDir ; git pull --rebase origin master:master
    echo "Update $rootDir/$concentrateurDir" ; cd $rootDir/$concentrateurDir ; git pull --rebase origin master:master
    echo "Update $rootDir/$gitConfigDir" ; cd $rootDir/$gitConfigDir ; git pull --rebase origin master:master
fi

