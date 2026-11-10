# Lan Bridge for Omarchy

A deliberately small Omarchy bar plugin for a two-computer desk.

- Left-click the bar icon to open **Lan Mouse**, where you pair the other
  laptop and place it on the desired screen edge.
- Right-click opens `~/Lan Drop`, the shared folder intended for Syncthing.
- The icon is bright while `lan-mouse` is running and dim while it is stopped.

Lan Mouse 0.11 shares keyboard and pointer on Hyprland, but does not yet ship
clipboard synchronization. After both machines are paired, configure clipboard
sync with a peer hostname or SSH alias; the bridge can use that existing tunnel
instead of exposing a new network service.

## Install on each Omarchy laptop

```bash
omarchy pkg add lan-mouse syncthing
omarchy plugin add https://github.com/GenericCPU/omarchy-lan-bridge.git --enable
systemctl --user enable --now syncthing.service
mkdir -p ~/"Lan Drop"
```

Then open Lan Bridge from the bar on each machine. In Lan Mouse, add the other
machine by its LAN address (or the address at the end of an SSH tunnel) and set
opposite edges — for example, the primary laptop's right edge and the second
laptop's left edge.

To finish shared copy/paste, tell the installer the SSH alias (or LAN hostname)
for each laptop. The pairing should use a dedicated restricted clipboard key,
not an unrestricted SSH command.

For files, open Syncthing on both machines and share `~/Lan Drop` with the
other laptop. This gives you a dependable drop-folder rather than pretending
Wayland supports cross-machine file dragging.

## SSH tunnel note

Prefer the normal LAN address when both laptops can reach each other. If a
tunnel is necessary, create matching forwards for Lan Mouse's configured
listening port on both machines, then enter the loopback/tunnel address in Lan
Mouse. Do not expose the service to the public internet.
