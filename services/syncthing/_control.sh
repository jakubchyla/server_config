#! /bin/sh

start()
{
    docker compose --project-directory "$PROJECT_DIR" up -d
}

stop()
{
    docker compose --project-directory "$PROJECT_DIR" down
}

restart()
{
    stop
    start
}

update()
{
    docker compose --project-directory "$PROJECT_DIR" pull
}

main()
{
    if [ $# -eq 0 ]; then
        printf "%s\n" "no option specified" >&2
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
            printf "%s\n" "usage: $0 (start|stop|update)" >&2
            exit 1
        ;;
    esac
}

main $@