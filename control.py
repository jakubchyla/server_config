#! /usr/bin/python3

import argparse
import pathlib
import subprocess
import sys
from time import process_time_ns
from typing import Dict, List


def get_services(args: Dict[str,str]) -> List[pathlib.PosixPath]:
    if args["service"] == "all":
        service = "*"
    else:
        service = args["service"]
    services=list(pathlib.Path(f"{sys.argv[0]}").absolute().parent.glob(f"services/{service}/_control.sh"))
    return services

def exec_command(services: List[pathlib.PosixPath], args: Dict[str,str]):
    for service in services:
        subprocess.run([str(service.absolute()), args["command"]])

def parse_args() -> Dict[str,str]:
    parser = argparse.ArgumentParser(
    description="manage container services"
    )
    parser.add_argument("command", metavar="CMD", type=str,
            choices=["start", "stop", "restart", "update"],
            help="command to run, possible commands: (start|stop|restart|update)")
    parser.add_argument("service", metavar="SERVICE", type=str,
            help="target service, accepts glob patterns, all is an alias for *")
    args = parser.parse_args()
    

    parsed_args = dict()
    parsed_args["command"] = args.command
    parsed_args["service"] = args.service

    return parsed_args

def main():
    args = parse_args()
    services = get_services(args)
    if services == []:
        print(f"service: {services} does not exist, exiting...", file=sys.stderr)
    exec_command(services, args)


if __name__ == "__main__":
    main()
