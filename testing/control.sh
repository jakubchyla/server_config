#! /usr/bin/bash

build_vagrantfiles()
{
    for i in {1..2}; do
        if [ ! -d "vagrant${i}" ]; then
            mkdir "vagrant${i}"
        fi
        cat << EOF > "./vagrant${i}/Vagrantfile"
Vagrant.configure("2") do |config|
config.vm.box = "debian/bookworm64"
config.vm.provider :libvirt do |libvirt|
libvirt.cpus = 4
libvirt.memory = 4096
end
config.vm
config.vm.network "private_network", ip: "192.168.33.1${i}"
config.vm.provision "shell", inline: "apt-get install --yes python-apt-common"
config.vm.provision "file", source: "~/.ssh/vagrant.pub", destination: "/home/vagrant/.ssh/vagrant.pub"
config.vm.provision "shell", inline: "cat /home/vagrant/.ssh/vagrant.pub >> /home/vagrant/.ssh/authorized_keys"
end
EOF
    done
}

run_vms()
{
    PIDS=""
    for file in $(find . -name Vagrantfile); do
        ( \
            CURRENT_DIR="$(pwd)" && \
            cd "$(dirname $file)" && \
            vagrant up && \
            cd "$CURRENT_DIR" \
        ) &
        PIDS="$PIDS $!"
    done

    wait $PIDS
}

stop_vms()
{
    PIDS=""
    for file in $(find . -name Vagrantfile); do
        ( \
            CURRENT_DIR="$(pwd)" && \
            cd "$(dirname $file)" && \
            vagrant halt && \
            cd "$CURRENT_DIR" \
        ) &
        PIDS="$PIDS $!"
    done

    wait $PIDS
}

destroy_vms()
{
    PIDS=""
    for file in $(find . -name Vagrantfile); do
        ( \
            CURRENT_DIR="$(pwd)" && \
            cd "$(dirname $file)" && \
            vagrant destroy --force && \
            cd "$CURRENT_DIR" \
        ) &
        PIDS="$PIDS $!"
    done

    wait $PIDS
}


main()
{
    set -e
    case "$1" in
        build)
            build_vagrantfiles
        ;;
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
            build_vagrantfiles
            run_vms
        ;;
        *)
            printf "%s&& \n" "unknown command, exiting"
            exit 1
        ;;
    esac
    set +e
}

main "$@"
