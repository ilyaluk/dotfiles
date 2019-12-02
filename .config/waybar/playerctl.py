#!/usr/bin/env python3
import threading
import signal
import subprocess
import sys
import os
import time

is_playing = True
song = ""

def print_update():
    sys.stdout.write("{}{}\n".format(
        "" if is_playing else " ",
        song,
    ))
    sys.stdout.flush()

def watch_status():
    global is_playing
    proc = subprocess.Popen(["playerctl", "-F", "status"], stdout=subprocess.PIPE)
    while True:
        l = proc.stdout.readline().strip().decode("utf8")
        is_playing = l == "Playing"
        print_update()

def watch_song():
    global song
    proc = subprocess.Popen(
        ["playerctl", "-F", "-f", "{{artist}} - {{title}}", "metadata"],
        stdout=subprocess.PIPE,
    )
    while True:
        song = proc.stdout.readline().strip().decode("utf8")
        print_update()

def signal_handler(sig, frame):
    try:
        sys.stdout.write('\n')
        sys.stdout.flush()
    finally:
        # ensure death of all subprocesses
        os.killpg(0, signal.SIGKILL)

def main():
    os.setpgrp()
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGCHLD, signal_handler)

    t = threading.Thread(target=watch_status)
    t.start()
    t2 = threading.Thread(target=watch_song)
    t2.start()

    while 1:
        if os.getppid() == 1:
            signal_handler(None, None)
        time.sleep(1)

if __name__ == '__main__':
    main()
