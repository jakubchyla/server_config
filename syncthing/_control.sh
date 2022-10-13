#! /usr/bin/bash

start()
{
    docker compose --project-directory "$PROJECT_DIR" up -d
}

stop()
{
    docker compose --project-directory "$PROJECT_DIR" down
}

update()
{
    docker compose --project-directory "$PROJECT_DIR" pull
}

main()
{
    if [ $# -eq 0 ]; then
        printf "no option specified\n" >&2
        exit 1
    fi
    COMMAND=$1
    shift

    PROJECT_DIR="$(dirname "$0")"
    case $COMMAND in
        start)
            start
        ;;
        stop)
            stop
        ;;
        update)
            update
        ;;
        *)
            printf "usage: $0 (start|stop|update)"
            exit 1
        ;;
    esac
}

main $@