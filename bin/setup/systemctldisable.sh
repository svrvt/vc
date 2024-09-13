#!/bin/sh
systemd-analyze critical-chain
systemd-analyze blame
systemd-analyze
# sudo systemctl disable systemd-networkd-wait-online.service && sudo systemctl mask systemd-networkd-wait-online.service
