if [ $1 == "--help" ]; then
    echo "Initializes a horizon app using a docker container."
    echo "Usage:    create-horizon-dev.sh APPNAME [OWNER]"
    echo "--help    show this message"
    echo "APPNAME   this will be used for home directory and RethinkDB"
    echo "OWNER     directory will be chowned to this user. optional defaults to \$USER"
    echo ""
else
    echo "Starting..."
    if [ -z "$2" ]; then
       echo "No OWNER supplied. Using ${USER}"
       OWNER=${USER}
    else
       OWNER=$2
    fi
    docker run --rm -v `pwd`:/tmp/tmp --name myhorizon-hz ctemplin/horizon-cli /bin/bash -c "cd /tmp/tmp && hz init $1 && cd $1 && hz create-cert"
    sudo chown -R $OWNER:$OWNER ./$1
fi
