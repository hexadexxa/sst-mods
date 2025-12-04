# A collection of my mods for the game Space Simulation Toolkit.
*v0.9.x*

## To install ui-mods:
* Download the mods you want, or download them all by clicking Code then Download ZIP.
* For each mod, drop the **first** folder named "ui", containing a folder named "_", into the games directory, the same one that contains "sst.exe"
* If asked to replace files, accept.
* Slideshow example images have credits in the top left taken from the Steam Workshop

## To customize slideshow
###### Requires Python (or manual editing)
* Install the mod
* Go to the same directory as sst.exe
* Open the folder "ui"
* Open the folder "slideshow"
* Add or remove images here
* When you want to update the list, run generate_list.py with python
* Alternatively, edit "imageFiles" in ui/_/ui/qml/ui.qml

## To-do list
* Make the slideshow shuffle work actually
* Make images persist nicer
* For better-tools, try using an array instead of 32 individual ints
