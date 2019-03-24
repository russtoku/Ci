# Pharo IoT Continuous Integration

[![Build Status](https://travis-ci.org/pharo-iot/Ci.svg?branch=master)](https://travis-ci.org/pharo-iot/Ci)

Pharo IoT CI is a Continuous Integration process created using [Travis CI](https://travis-ci.org/pharo-iot/Ci). This process generate a Pharo image with [PharoThings](https://github.com/pharo-iot/PharoThings) and [TelePharo](https://github.com/dionisiydk/TelePharo) already installed and ready to run in multiplatform (Raspberry, Linux, Windows, Mac) with 1 click files. You can see the files to download in **[Releases page](https://github.com/pharo-iot/Ci/releases)**. All zip files for download are automatically created and deployed when a new tag is created here.

You can run the scripts by yourself in your local machine (Linux, Mac). Clone this repository, go to scripts folder and run the script `./run-scripts`. If you wanna skip the PharoThings instalation, just run `./run-scripts noInstall`. You can see the results inside the folder results-$DATE. 

We are using Github Pages to run the **get.pharo.org**. You can see the files in [docs/](docs/) folder.

In this way, **you can help us to improve this CI process**: Just clone this repository, do the modifications testing the scripts in your local machine (Linux, Mac) and submit a Pull Request with your modifications.

There are 4 script files (download.sh, create-pharo-start.sh, install-packages.sh and upload.sh). They basically do:

- Download the VM files
- Create a local Pharo7 32-bit environment
- Install PharoThings (server)
- Copy this image to a new folder (client-server) and install the PharoThings client
- Copy this image to a new folder (multi)
- Create a local Pharo7 64-bit environment
- Install PharoThings (client-server) in 64-bit image.
- Copy the VMs (Arm, Linux, Windows, Mac) to the vm folders
- Create 1 click multiplatform files
- Create 3 zip files for download. You can see the description of each file below
- And Travis CI deploy the files in **[Releases page](https://github.com/pharo-iot/Ci/releases)** when is created a new Tag. 

# PharoThings how to use

The desctiption below is a easy way to you start very fast using PharoThings to create your IoT projects. You can see PharoThings project in original repository: [PharoThings GitHub repository](https://github.com/pharo-iot/PharoThings)

## Download the zip file according to your scenario:
There are 3 zip files with the VM and PharoThings already installed. 
- **pharothings-server (Raspberry Pi)**
This file has Pharo7, ARM VM and PharoThings **server** loaded;

    [Zeroconf](http://get.pharoiot.org/server):`wget -O - get.pharoiot.org/server | bash`
    
    **[Download](http://get.pharoiot.org/server.zip)**:`wget get.pharoiot.org/server.zip`

- **pharothings-client (Raspberry Pi)**
This file has Pharo7, ARM VM, PharoThings **server and client** loaded. This way you can to work in the Raspberry Pi directly connected in a screen and keyboard/mouse, using the developer PharoThings tools, like the Board Inspector;

    [Zeroconf](http://get.pharoiot.org/client):`wget -O - get.pharoiot.org/client | bash`
    
    **[Download](http://get.pharoiot.org/client.zip)**:`wget get.pharoiot.org/client.zip`

- **pharothings-multi (Raspberry Pi, Linux, Windows, Mac)**
This file has Pharo7, all VMs 32bit, PharoThings **server and client** loaded.

    [Zeroconf](http://get.pharoiot.org/multi):`wget -O - get.pharoiot.org/multi | bash`

    **[Download](http://get.pharoiot.org/multi.zip)**:`wget get.pharoiot.org/multi.zip`

## Start files
There are 4 files of *1 click start*. All of them start with the Pharo image already selected. You can use them according to your necessities:
- **pharo** (Raspberry, Linux, Mac OSX)
Run Pharo in the command line. You can pass arguments, for example `./pharo --help` or `./pharo --version`
- **pharo-ui** (Raspberry, Linux, Mac OSX)
Open Pharo User Interface. Double click or run in command line `./pharo-ui`. 
- **pharo-server** (Raspberry, Linux, Mac OSX)
Start pharo in headless mode with TelePharo listening on port 40423 TCP, run the command `./pharo-server` or double click in it. You can send the process to the background to release your terminal using &, for example `./pharo-server &`. 
- **pharo.bat** (Windows)
Open Pharo User Interface on Microsoft Windows.

## Connecting
1. Start the **pharo-server** on Raspberry Pi. 
2. Run the PharoThings client: **pharo-ui** (Mac, Linux) or **pharo.bat** (Windows). Open the Playground, type and run this line (cmd + D):
```
remotePharo := TlpRemoteIDE connectTo: (TCPAddress ip: #[192 168 1 200] port: 40423).
``` 
3. If you don't receive any error, this means that you are connected. Now you can inspect the physical board of your Raspberry Pi:
```
remoteBoard := remotePharo evaluate: [ RpiBoard3B current].
remoteBoard inspect.
```
You can also call the *Remote Playground*, *Remote System Browser* and *Remote Process Browser*:
```
remotePharo openPlayground.
remotePharo openBrowser.
remotePharo openProcessBrowser.
``` 

## Playing with PharoThings Booklet
You can start playing with LEDs, sensors and learn how to build your **Mini-Weather Station** to shows the temperature and other parameters in an LCD display, and send the data to a cloud server. 
All this content and lessons are written in the **PharoThings Booklet**, you can access it here: [PharoThings Booklet](https://github.com/SquareBracketAssociates/Booklet-APharoThingsTutorial) 

# Raspberry Pi Headless Instalation
You can install the Operation System (Raspbian) in your Raspberry Pi and do all configuration without keyboard/mouse/screen. With this method you will automaticaly:

- Set the hostname
- Set boot to console
- Enable the I2C and SPI modules
- Connect in your WiFi network
- Download PharoThings
- and start the server every boot

Download the PiBakery: [PiBakery Download](https://www.pibakery.org/download.html)

Download the XML configuration file: [PiBakery PharoThings Configuration](http://get.pharoiot.org/pibakeryPharoIoT.xml)

1. Import this XML file in PiBakery
2. Change your hostname and WiFi configuration
3. Insert the SD card in your machine, click in Write and select the Operation System Raspbian Full
4. After the process, insert the SD card into the Raspberry and wait about 2 minutes to finish the automatic setup
5. Now you can find your Raspberry by hostname that you have set before and connect to it. Telepharo is already running on TCP port 40423.