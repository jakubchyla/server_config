#! /bin/sh

get_project_dir()
{
    printf "%s\n" "$(dirname "$0")"
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

restart()
{
    stop
    start
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
            printf "usage: $0 (start|stop|update)"
            exit 1
        ;;
    esac
}

main $@