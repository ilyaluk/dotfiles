#!/usr/bin/env python3.10
import asyncio
import signal
import iterm2

'''
This is a small script that monitors SIGUSR1 signal and
creates a new iTerm window when it receives the signal.

This is done to speed up spawning new iTerm windows from
AeroSpace, because all other methods add significant delay (AppleScript/Python API/CLI).
'''

async def new_window(connection):
    window = await iterm2.Window.async_create(connection)
    app = await iterm2.async_get_app(connection)
    await app.async_activate()
    await window.async_activate()

async def main(connection):
    loop = asyncio.get_event_loop()
    loop.add_signal_handler(signal.SIGUSR1,
                            lambda: asyncio.create_task(new_window(connection)))
    while True:
        await asyncio.sleep(3600)

iterm2.run_forever(main)
