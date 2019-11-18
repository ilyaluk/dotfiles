#!/usr/bin/env python3
import threading
import signal
import subprocess
import sys

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
    sys.stdout.write('\n')
    sys.stdout.flush()
    sys.exit(0)

def main():
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)

    t = threading.Thread(target=watch_status)
    # to kill thread after SIGINT, we don't care about graceful termination
    t.daemon = True
    t.start()
    watch_song()

if __name__ == '__main__':
    main()
