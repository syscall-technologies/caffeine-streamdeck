# Caffeine for Stream Deck

A Stream Deck key that keeps your Mac awake. Press it to start macOS's built-in
`caffeinate -di` (display and system stay awake), press again to stop.

| Off | On |
|-----|----|
| ![off](com.seb.caffeine.sdPlugin/imgs/off@2x.png) | ![on](com.seb.caffeine.sdPlugin/imgs/on@2x.png) |

No dependencies, no permissions, about 35 lines of JavaScript. `caffeinate` is started
with `-w <plugin pid>`, so it stops on its own if Stream Deck quits or the plugin crashes.

## Requirements

- macOS 12+
- Stream Deck app 6.5+

## Install

```sh
git clone https://github.com/0xSeb/caffeine-streamdeck.git
ln -s "$PWD/caffeine-streamdeck/com.seb.caffeine.sdPlugin" \
  ~/Library/Application\ Support/com.elgato.StreamDeck/Plugins/
```

Restart the Stream Deck app, then drag **Caffeine → Toggle** onto a key.

## Check that it works

With the key on:

```sh
pmset -g assertions | grep -A1 caffeinate
```

You should see `PreventUserIdleDisplaySleep` and `PreventUserIdleSystemSleep` held by a
`caffeinate` process "on behalf of" the plugin's PID. They disappear when the key is off.

## Notes

- The key always starts **off** after a restart; it does not remember its last state.
- Deleting the key while it is on leaves `caffeinate` running until the Stream Deck app restarts.
- While on, the display never sleeps from inactivity, so a lock tied to display sleep will not trigger.

## Icons

Rendered from SF Symbols: `swift tools/icons.swift com.seb.caffeine.sdPlugin/imgs`

## License

MIT
