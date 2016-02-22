#!/usr/bin/python3
# this scripts rotates the screen of my x201t
# after it is put into tablet mode.
import subprocess
import re
import sys

TABLET_SCREEN = "LVDS1"


def get_wacom_ids():
    out = subprocess.getoutput("xsetwacom list")
    ids = re.findall("id: (\d+)", out)
    return [int(x) for x in ids]


def activate_tablet_mode(activate):
    wacom_ids = get_wacom_ids()
    if activate:
        subprocess.run(["xrandr", "--output",
                        TABLET_SCREEN, "--rotate", "inverted"],
                       check=True)
        for id in wacom_ids:
            subprocess.run(["xsetwacom", "set", str(id), "Rotate", "half"],
                           check=True)
    else:
        subprocess.run(["xrandr", "--output",
                        TABLET_SCREEN, "--rotate", "normal"],
                       check=True)
        for id in wacom_ids:
            subprocess.run(["xsetwacom", "set", str(id), "Rotate", "none"],
                           check=True)

if __name__ == "__main__":
    activate = False

    if sys.argv[1] == "1":
        activate = True

    activate_tablet_mode(activate)
