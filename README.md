# cloud-init-rpi
Repo containing cloud-init manifest for RPI

## How to run this?

1. Clone the [image-specs](https://salsa.debian.org/raspi-team/image-specs) repo from Debian

2. Copy the file `raspi_4_bullseye.yaml` to the `image-specs` directory. You may want to change the hardcoded IP address on this file.

3. `sudo make raspi_4_bullseye.img`

4. Do your magic to run this image

5. Serve this repo using your favorite http server. I usually use python `python3 -m http.server 8080`

6. Fire that raspberry pi
