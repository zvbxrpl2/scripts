# Scripts

A personal collection of bash utilities for media management, system
provisioning, and everyday tasks. Most scripts are intentionally small and
single-purpose, and many are wired together by a shared yt-dlp config.

## Layout

| Directory | Purpose |
|-----------|---------|
| `media/`        | Downloading, converting, and syncing video (YouTube, ffmpeg, SMB). |
| `ubuntu/`       | One-off system provisioning and maintenance for Ubuntu. |
| `miscellaneous/`| Small general-purpose helpers (sync, IP lookup, mirroring, …). |
| `config/`       | Shared config files (e.g. `yt-dlp.conf`) installed by `ubuntu/` scripts. |

### `media/`
- `download_channels.sh` — download whole YouTube channels/playlists into
  per-channel folders, deduplicated across runs via a shared `archive.txt`.
- `yt-dlp-playlist.sh` — one-off playlist/channel download (no archive).
- `convert_mkv_to_mp4.sh` — remux `.mkv` → `.mp4` (stream copy, no re-encode).
- `scale_to_720p.sh` — re-encode `.mp4` files down to 720p (1280×720, aspect
  ratio preserved).
- `list-video-resolutions.sh` — print the resolution of every `.mp4` in the tree.
- `sync_to_shared.sh` — rsync a local folder to an SMB `shared` mount.

### `ubuntu/`
- `ubuntu-basic-setup.sh` — initial machine setup (packages, PPA, pipx tools).
  Requires `sudo`.
- `ubuntu-install-configs.sh` — install shared config files (e.g. `yt-dlp.conf`).
- `ubuntu-setup-git.sh` — set global git user name/email.
- `ubuntu-setup-bashrc.sh` — idempotently append helper lines to `~/.bashrc`.
- `ubuntu-cleanup.sh` — free space (apt cache, old logs, thumbnails, snap revisions).
- `ubuntu-update.sh` — apt + pipx update.
- `install_firefox_apt.sh` — replace snap Firefox with apt Firefox (Mozillateam PPA).

### `miscellaneous/`
- `easy_sync.sh` — generic rsync wrapper (`-a`, `--modify-window=1`, `--no-perms`).
- `get_ip.sh` — print your public IP with geo/ISP info (or `--ip` for IP only).
- `wget_archive.sh` — mirror a website for offline viewing.
- `fix_virtualbox.sh` — reload the `vboxdrv` kernel module (see the linked forum).

### `config/`
- `yt-dlp.conf` — shared yt-dlp settings: 1080p cap, mp4/mp3, metadata
  embedding, `--ignore-errors`, retries, and a browser user-agent. Used by
  `download_channels.sh` and `yt-dlp-playlist.sh` (install with
  `ubuntu-install-configs.sh`).

## Making the scripts available as commands (the linking process)

Every script is a plain file, but most live in subdirectories, so they are not
on your `PATH` by default. `link_all.sh` solves this once and for all:

1. It scans the repo for every `*.sh` file.
2. For each one it creates a **symlink** inside `<repo>/bin/`, named after the
   script with the `.sh` extension removed (e.g. `media/scale_to_720p.sh` →
   `bin/scale_to_720p`).
3. **Collision safety** — if a name would clash with another script or a real
   system binary (e.g. something named `rsync` or `wget`), it is renamed to a
   `<folder>-<name>-N` form so it never shadows a system command. Explicit
   overrides (force a specific name for a given script) are supported via the
   `overrides` table at the top of the script.

Because the links are **symlinks, not copies**, editing a script updates the
command immediately — there is a single source of truth. `link_all.sh` is
**idempotent**: re-run it any time (e.g. after adding a new script) to add new
links and prune stale ones.

### Setup (run once)

```bash
cd ~/Code/scripts
./link_all.sh
```

Then add the `bin/` directory to your `PATH` (once, in `~/.bashrc`):

```bash
grep -qxF 'export PATH="$HOME/Code/scripts/bin:$PATH"' ~/.bashrc \
  || echo 'export PATH="$HOME/Code/scripts/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

After that, every script is available from anywhere, e.g. `easy_sync`,
`scale_to_720p`, `get_ip`, `ubuntu-update`.

## Windows 10 LTSC Activation

See these links:
- https://github.com/massgravel/Microsoft-Activation-Scripts
- https://massgrave.dev/

## How to setup Windows Store on LTSC

1. Open Windows Powershell as an admin
2. Run: `wsreset -i`
3. Wait a few seconds

Command Breakdown:
`wsreset` = Windows Store Reset
`-i flag` = Install

Source: https://old.reddit.com/r/Windows10LTSC/comments/s88jre/guide_activateinstall_windows_store_without_an/
