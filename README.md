# appimaged

`appimaged` is an optional daemon that watches locations like `~/bin` and `~/Downloads` for AppImages and if it detects some, registers them with the system, so that they show up in the menu, have their icons show up, MIME types associated, etc. It also unregisters AppImages again from the system if they are deleted. If [firejail](https://github.com/netblue30/firejail) is installed, it runs the AppImages with it.


## Install

A precompiled version can be found in the last successful Travis CI build, you can get it with:

```
wget "https://github.com/AppImage/appimaged/releases/download/continuous/appimaged-x86_64.AppImage"
chmod a+x appimaged-x86_64.AppImage
```

Usage in a nutshell:

```
./appimaged-x86_64.AppImage --install
```

Or, if you are on a deb-based system:

```
wget -c "https://github.com/AppImage/appimaged/releases/download/continuous/appimaged_1.0_amd64.deb"
sudo dpkg -i appimaged_*.deb
systemctl --user add-wants default.target appimaged
systemctl --user start appimaged
```

## Monitored directories

appimaged will register the AppImages in with your system from the following places:

* $HOME/Downloads (or its localized equivalent, as determined by `G_USER_DIRECTORY_DOWNLOAD` in glib)
* $HOME/.local/bin
* $HOME/bin
* $HOME/Applications
* /Applications
* /isodevice/Applications
* /isofrom/Applications
* /run/initramfs/isoscan/Applications
* /run/archiso/img_dev/Applications
* /lib/live/mount/findiso/Applications
* /opt
* /usr/local/bin


## Usage

```
Usage:
  appimaged [OPTION...] 

Help Options:
  -h, --help          Show help options

Application Options:
  -v, --verbose       Be verbose
  -i, --install       Install this appimaged instance to $HOME
  -u, --uninstall     Uninstall an appimaged instance from $HOME
  --version           Show version number
```

Run `appimaged -v` for increased verbosity.

__NOTE:__ It may be necessary to restart (or `xkill`) dash, nautilus, to recognize new directories that didn't exist prior to the first run of `appimaged`. Alternatively, it should be sufficient to log out of the session and log in again after having run appimaged once.


## Use AppImageUpdate with appimaged

If you have `AppImageUpdate` on your `$PATH`, then it can also do this neat trick:

![screenshot from 2016-10-15 16-37-05](https://cloud.githubusercontent.com/assets/2480569/19410850/0390fe9c-92f6-11e6-9882-3ca6d360a190.jpg)

Download AppImageUpdate from https://github.com/AppImage/AppImageUpdate/releases/tag/continuous and put on your `$PATH`:

```
sudo mv "Downloads/AppImageUpdate-*.AppImage" /usr/local/bin/AppImageUpdate
chmod a+x /usr/local/bin/AppImageUpdate
```


## Build

appimaged is built using CMake.

You can build appimaged as follows:

```
git clone --recursive https://github.com/AppImage/appimaged/
cd appimaged/
mkdir build/
cd build/
cmake ..
make
```
