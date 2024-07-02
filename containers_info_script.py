#!bin/bash/python3

import subprocess
import json

from datetime import timedelta, date


# user input data

num = input(
    "Enter logs rows amount (default = 10): "
)
day = input(
    "Enter logs day duration (default = from container create): "
)


#declare variables

logs_amount = ["-n", "10"] if num == '' else ["-n", str(num)]

if day:
    start_date = (date.today() + timedelta(-int(day)))
    logs_duration = ["--since", str(start_date)]
else:
    logs_duration = []


#get containers id

id_list = subprocess.check_output(
    ["docker", "ps", "-a", "--format", "{{.ID}}"], 
    universal_newlines=True
).split()


# write file with information about containers

with open("containers_info.json", "w", encoding="utf-8") as file:
    for id in id_list: 
        json.dump(
            {
                id: 
                    {
                        "status":
                            subprocess.check_output(
                                ["docker", "inspect", "--format", "'{{json .State.Status}}'", id],
                                universal_newlines=True
                            ).lstrip("'\"").rstrip("'\n\""),
                        "logs":
                            [i.rstrip('\"') for i in subprocess.check_output(
                                ["docker", "logs", id]
                                + logs_amount
                                + logs_duration,
                                universal_newlines=True
                            ).split("\n")]
                    }
            },
            file,
            indent=4
        )
        file.write("," + "\n")