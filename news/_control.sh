#! /usr/bin/bash

get_project_dir()
{
    printf "$(dirname "$0")"
}

start()
{
    docker compose --project-directory "$PROJECT_DIR" up -d
}

stop()
{
    while docker compose --project-directory "$PROJECT_DIR" ps --status running | grep "news-news" >/dev/null; do
        sleep 10
    done
    docker compose --project-directory "$PROJECT_DIR" down 
}

update()
{
    stop
    docker compose --project-directory "$PROJECT_DIR" pull
    start
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