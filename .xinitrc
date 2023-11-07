/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/pipewire-media-session &

systemctl enable bluetooth.service &
systemctl start bluetooth.service
