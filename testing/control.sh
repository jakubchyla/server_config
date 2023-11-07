#! /usr/bin/bash

run_vms()
{
    CURRENT_DIR="$(pwd)"
    cd vagrant
    vagrant up
    cd "$CURRENT_DIR"
}

stop_vms()
{
    CURRENT_DIR="$(pwd)"
    cd vagrant
    vagrant halt
    cd "$CURRENT_DIR"
}

destroy_vms()
{
    CURRENT_DIR="$(pwd)"
    cd vagrant
    vagrant destroy --force vagrant1
    vagrant destroy --force vagrant2
    cd "$CURRENT_DIR"
}


main()
{
    set -e
    case "$1" in
        run|start)
            run_vms
        ;;
        destroy)
            destroy_vms
        ;;
        halt|stop)
            stop_vms
        ;;
        reset)
            destroy_vms
            run_vms
        ;;
        *)
            printf "%s\n" "unknown command, exiting"
            exit 1
        ;;
    esac
    set +e
}

main "$@"
