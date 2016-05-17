# PondCam

Live stream from the garden pond.

Mirror the rtsp stream from the pond camera onto a websocket to protect the camera server from the internet.

## Future work

* Time / user control the light on the camera.
* User control camera direction.
* Capture the camera as images to share.
* Capture clips to share in a greatest hits reel.
* Replay motion events in quite times.

## Server Notess

After all this it probably doesn't need to bother with nginx as node is passed through hosting websockets anyway.

[Good Guid](https://rocketeer.be/articles/deploying-node-js-with-systemd/) should probably be followed. Have a job cache an image from the camera to serve immediately while ffmpeg is loading on the websocket.

### Rough instructions

Starting with a fedora base image;

1. Install MITM-ca.pem to /etc/pki/ca-trust/source/anchors
  1. map the smb share: `mount -t cifs "<\\bhs-...sharepath>" /mnt/admin -o username=<user>`
  1. cp /mnt/admin /etc/...
  1. import that with `update-ca-trust`
  1. This only applies to programs that don't listen to openssl's trust api (npm -_-)
  1. either use `npm install --strict-ssl=false` all the time or copy/add MITM-ca.crt path for .npmrc `ca=`
1. add free/nonfreee rpsfusion repos (ffmpeg)
1. add nodesource rpm node version
1. useradd -mrU src-node-pondcam
1. install ffmpeg nodejs git nginx policycoreutils-python-utils
1. iptables insert webserver and sockets before "all deny"
  1. iptables -L INPUT
  1. iptables -I INPUT <Last -1> -p tcp --dport 80   -j ACCEPT
  1. iptables -I INPUT <Last -1> -p tcp --dport 9999 -j ACCEPT
1. selinux enable proxypass with nginx.
  1. cat /var/log/audit/audit.log | grep nginx | grep denied | audit2allow -M moduleName
  1. semodule -i moduleName.pp
1. copy systemd unit files to /etc/systemd/system
1. systemctl enable nginx node-pondcam
1. systemctl start nginx node-pondcam


