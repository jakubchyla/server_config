#! /usr/bin/python3

# TODO add validation for smarthost and relay domains

import argparse
from typing import Dict
import os
import subprocess
import sys

def parse_args() -> Dict[str,str]:
    parser = argparse.ArgumentParser(
        description="creates exim4 config and "
    )
    parser.add_argument("--smarthost", metavar="SMARTHOST", type=str, default="gmail",
                        help="address of smtp exim4 will use, default is gmail's smtp")
    parser.add_argument("--relay-domains", dest="relay_domains", metavar="RELAY_DOMAINS", type=str, default="*",
                        help="list of addresse relay will accept mails from, default is all")
    args = parser.parse_args()

    options = dict()
    options["smarthost"] = parse_smarthost(args.smarthost)
    options["relay_domains"] = parse_relay_domains(args.relay_domains)

    return options

def parse_smarthost(smarthost: str):
    if smarthost == "GMAIL" or smarthost == "gmail":
        return "smtp.gmail.com::587"
    else:
        return smarthost

def parse_relay_domains(relay_domains: str):
    return relay_domains

def create_config(options: Dict[str,str]):
    config = f"""
        dc_eximconfig_configtype='smarthost'
        dc_other_hostnames=''
        dc_local_interfaces='0.0.0.0 ; ::0'
        dc_relay_nets='0.0.0.0/0'
        dc_smarthost='{options["smarthost"]}'
        dc_hide_mailname='true'
        dc_relay_domains='{options["relay_domains"]}'
    """
    print(config)

def main():
    options = parse_args()
    create_config(options)


if __name__ == "__main__":
    main()