#! /usr/bin/bash

start_all_services()
{
    for SERVICE in $SERVICES; do
        $SERVICE start
    done
}

stop_all_services()
{
    for SERVICE in $SERVICES; do
        $SERVICE stop
    done
}

update_all_services()
{
    for SERVICE in $SERVICES; do
        $SERVICE update
    done
}

restart_all_services()
{
    for SERVICE in $SERVICES; do
        $SERVICE stop
        $SERVICE start
    done
}

main()
{
    for SERVICE in $(find "$(dirname "$(realpath "$0")")" -maxdepth 2 -name "_control.sh"); do
        SERVICES="$SERVICES $(realpath $SERVICE)"
    done
    export SERVICES

    if [ $# -eq 0 ]; then
        printf "no option specified\n" >&2
        exit 1
    fi
    COMMAND=$1
    shift

    case $COMMAND in
        start-all)
            start_all_services
        ;;
        stop-all)
            stop_all_services
        ;;
        restart-all)
            restart_all_services
        ;;
        update-all)
            update_all_services
        ;;
        *)
            printf "usage: $0 (start-all|stop-all|restart-all|update-all)\n"
            exit 1
        ;;
    esac
}

main $@