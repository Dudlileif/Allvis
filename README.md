# Allvís
## [Latest release](https://github.com/Dudlileif/Allvis/releases)

Allvís is a fun and interesting addition to the Adressa Park just outside Adresseavisen in Trondheim. This repository contains all of the code that went into its realization.

## Getting started
Clone the project to your desired location on your local machine by using the following command

```
git clone https://github.com/Dudlileif/Allvis
```

and fill in your Github credentials if needed. You can also choose to [download the zip](https://github.com/Dudlileif/Allvis/archive/master.zip) if that suits you better. If you want to build the project yourself, follow the next to paragraphs, if not just skip to the [Installing](https://github.com/Dudlileif/Allvis/blob/master/README.md#installing) part.

### Prerequisites
This project is built in the open-source [Qt framework](https://www.qt.io/download) (version 5.10.1). For cross-compiling to the Raspberry Pi that is used in the giraffe [RaspberryPi2EGLFS](https://wiki.qt.io/RaspberryPi2EGLFS) was used. This can be a very cumbersome process and you will probably encouter issues, remember Google is your friend.\
The image for the arrow must be downloaded separately, see the [Resources](https://github.com/Dudlileif/Allvis/blob/master/README.md#resources) at the bottom of this page.\
Note: The application for the Pi can only be built on Linux, and the release was built with Ubuntu 17.10 for the Raspberry Pi 3 Model B. The username of the account on the Pi has to be ```pi``` for the game to work, if not edit the parameters in [```pythongame.cpp```](https://github.com/Dudlileif/Allvis/blob/master/src/Allvis/pythongame.cpp#L7) to suit the username.

## Building
The project should be ready to build once the Qt Creator is set up as in the prerequisistes, with the Pi as a building option device. Once the application is built, it will automatically upload the file to the Pi as long as both the computer and the Pi is connected to the same network. If they are not, the file must be copied manually to the Pi from the build folder.

## Installing
Place the [```Allvis```](https://github.com/Dudlileif/Allvis/releases/download/v1.0/Allvis) executable and the python script [```game.py```](https://github.com/Dudlileif/Allvis/releases/download/v1.0/game.py) from the release in the ```/home/pi``` folder of the Rasperry Pi. Change the [raspi-config](https://www.raspberrypi.org/documentation/linux/usage/rc-local.md) so that the boot behaviour is set to CLI (command line). To run the application on startup, edit the [```rc.local```](https://www.raspberrypi.org/documentation/linux/usage/rc-local.md) found in ```/etc/rc.local``` so that the following line is added before ```exit 0```:
```
./home/pi/Allvis
```
Note: If the files are placed in a different folder, make sure to edit the necessary files [pythongame.cpp](https://github.com/Dudlileif/Allvis/blob/master/src/Allvis/pythongame.cpp#L7) and ```rc.local```. This means that the program has to be rebuilt to be able to find the ```game.py``` file if it's not in ```/home/pi```.

## Licensing
This application as well as the Qt framework is licensed under the [GNU Lesser General Public License](https://www.gnu.org/licenses/lgpl-3.0.en.html).

## Resources
### [```Images```](https://github.com/Dudlileif/Allvis/tree/master/src/Allvis/Images)
Twitter emojis: Twemoji: [http://twitter.github.io/twemoji/](http://twitter.github.io/twemoji/)\
Adressa logo: Cut and recolored from here: [http://logos.wikia.com/wiki/File:Adressa.svg](http://logos.wikia.com/wiki/File:Adressa.svg)\
Arrow: Download the white version from [flaticon.com](https://www.flaticon.com/free-icon/direction-arrow-pointing-right_17944), rename to ```RightPointingArrow.svg``` and place in the [```Allvis/Images```](https://github.com/Dudlileif/Allvis/tree/master/src/Allvis/Images) folder.\
Giraffe: Download the image from [infobilder.com](https://www.infobilder.com/bilde-giraff-i21051.html), rename to ```Giraffe.png``` and place in the [```Allvis/Images```](https://github.com/Dudlileif/Allvis/tree/master/src/Allvis/Images) folder.

## Hardware
In the [```hw```](https://github.com/Dudlileif/Allvis/blob/master/hw) folder there are stl-files that can be printed out to replace buttons as well as pdfs with dimensions for recreating and modification.
