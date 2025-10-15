## Parallax OS ISO
This builds the .iso and .img installers for Parallax OS. <br>
This takes two files as input:
* `install.img`, the built installer image (from [parallax-os](https://www.github.com/graysus/parallax-os), such as `plasma-installer`)
* `installed.img` (optionally) the image to install. If not specified, it will be an online installer ISO.<br>
To run, just type `sudo ./pxos-build.sh`<br>
It will produce two output files: `pxos.img`, the USB image, and `pxos.iso`, the DVD image
