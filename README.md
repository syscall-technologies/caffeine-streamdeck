<div align="center">

<img src="com.seb.caffeine.sdPlugin/imgs/on@2x.png" width="96" alt="Caffeine key, on">

# Caffeine for Stream Deck

**One key to keep your Mac awake.**

[![macOS 12+](https://img.shields.io/badge/macOS-12%2B-000000?logo=apple&logoColor=white)](#requirements)
[![Stream Deck 7.1+](https://img.shields.io/badge/Stream%20Deck-7.1%2B-6E44FF)](#requirements)
[![Dependencies: 0](https://img.shields.io/badge/dependencies-0-brightgreen)](com.seb.caffeine.sdPlugin/plugin.js)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE)

</div>

---

<table align="center">
  <tr>
    <td align="center"><img src="com.seb.caffeine.sdPlugin/imgs/off@2x.png" width="96" alt="off"><br><sub><b>Off</b> · Mac sleeps as usual</sub></td>
    <td align="center"><img src="com.seb.caffeine.sdPlugin/imgs/on@2x.png" width="96" alt="on"><br><sub><b>On</b> · display and system stay awake</sub></td>
  </tr>
</table>

Press the key to start macOS's built-in [`caffeinate -di`](https://ss64.com/mac/caffeinate.html). Press it again to stop it. That's all it does.

## Why this one

- ☕ **Built into macOS.** No third-party keep-awake app, just Apple's own `caffeinate`.
- 🪶 **Tiny.** About 35 lines of plain JavaScript. No npm, no build step, nothing to update.
- 🔒 **No permissions.** No Accessibility, Screen Recording or admin access.
- 🧯 **Stops cleanly.** `caffeinate` is tied to the plugin's process, so it stops on its own if Stream Deck quits or crashes.

## Requirements

- macOS 12 or later
- Stream Deck app 7.1 or later, with any Stream Deck that has keys (tested on a Stream Deck + XL)

## Install

**[⬇ Download Caffeine for Stream Deck](https://github.com/syscall-technologies/caffeine-streamdeck/releases/latest/download/com.seb.caffeine.streamDeckPlugin)**, then double-click the file. Stream Deck installs it for you.

Then drag **Caffeine → Toggle** onto a key.

<details>
<summary>Install from source instead</summary>

```sh
git clone https://github.com/syscall-technologies/caffeine-streamdeck.git
ln -s "$PWD/caffeine-streamdeck/com.seb.caffeine.sdPlugin" \
  ~/Library/Application\ Support/com.elgato.StreamDeck/Plugins/
```

Restart the Stream Deck app, then drag **Caffeine → Toggle** onto a key.

</details>

## Is it working?

Turn the key on, then run:

```sh
pmset -g assertions | grep -A1 caffeinate
```

You should see `PreventUserIdleDisplaySleep` and `PreventUserIdleSystemSleep`, held by a `caffeinate` process *on behalf of* the plugin. When you turn the key off, both lines go away.

## Good to know

> [!NOTE]
> The key always starts **off** after a restart. It doesn't remember its last state.

> [!WARNING]
> While the key is on, the display never sleeps from inactivity, so a screen lock tied to display sleep won't trigger. If you delete the key while it's on, `caffeinate` keeps running until the Stream Deck app restarts.

## Hacking

| Path | What |
|------|------|
| [`com.seb.caffeine.sdPlugin/plugin.js`](com.seb.caffeine.sdPlugin/plugin.js) | The whole plugin |
| [`com.seb.caffeine.sdPlugin/manifest.json`](com.seb.caffeine.sdPlugin/manifest.json) | Stream Deck manifest |
| [`tools/icons.swift`](tools/icons.swift) | Draws the key images from SF Symbols: `swift tools/icons.swift com.seb.caffeine.sdPlugin/imgs` |

To build the installer, use the [Stream Deck CLI](https://docs.elgato.com/streamdeck/cli/intro) (`npm install -g @elgato/cli`):

```sh
streamdeck validate com.seb.caffeine.sdPlugin
streamdeck pack com.seb.caffeine.sdPlugin -o dist
```

## License

[MIT](LICENSE) © 0xSeb
