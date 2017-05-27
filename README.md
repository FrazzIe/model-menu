# model-menu
https://forum.fivem.net/t/release-model-menu-v1/19999
## Model-Menu V2.5
A Menu that:

* Opens when a player first spawns
* Can be opened and closed using E in a clothing shop
* lets you choose from every working model
* lets you fully customise models
* Loads/Saves models to a database(MySQL)

I only spent roughly 12 hours on this so message me if there are bugs


----------
## Changelog

**Version 1.1**

* Added an Accessories menu
* Every mask is available, each mask is saved/loaded to/from a database.
* As for hats and glasses, and earrings.. still need to work on them.

**Version 2.0**

* Added a few head options (still need to get other skin colours to blend)
* Added all hairstyles with names and hair colours
* Added all shirts with names and textures
* Added all Undershirts
* Added Armour
* Added all types of Hands
* Added all pants with names for each one
* Added all shoes with names
* Added help text for players [link](http://prntscr.com/fb93zy)
* Limited the customisation menu to the freemode models [link](http://prntscr.com/fb94cx)
* You can now only open the menu in clothing shops using E [link](http://prntscr.com/fb95b6)
* All of these new features are also saved to and loaded from a database(MySQL)
* I think thats all i did?

**Version 2.1**

* Optimized SQL calls
* Added the store that someone mentioned in the comments

**Version 2.2**

* Added all helmets/hats with names [picture](https://prnt.sc/fc40qx)
* Added all glasses with names [picture](https://prnt.sc/fc40w1)

**Version 2.3**

* Added female names for hats and glasses
* Added all Earrings with individual names
* Changed menu layouts (Customisation->Gender->then all options)
* Fixed bug where next page didn't work (Undershirts)

**Version 2.4**

* Added all heads (45 in total)
* Which means, different skin colours! [pic1](http://prntscr.com/fckeuj) [pic2](http://prntscr.com/fckfqi) [pic3](http://prntscr.com/fckg1z) [pic4](http://prntscr.com/fckg6b)

**Version 2.5**

* Fixed changing hair colour not working
* Fixed remove Earrings button not actually saving
* Added 63 different hair colours [pic1](https://prnt.sc/fct3j7) [pic2](https://prnt.sc/fct3ny) [pic3](https://prnt.sc/fct3qx) [pic4](https://prnt.sc/fct3zx)

----------

If using Cops FiveM then change line 48 in the Cops FiveM _client.lua_ and line 124 in the _vestpolice.lua_ from
```
	TriggerServerEvent("skin_customization:SpawnPlayer")
```
to
```
    TriggerServerEvent("mm:spawn")
```

----------


If players spawn as mp_m_freemode_01 or mp_f_freemode_01 by default in your server then change line 27 in the sql.sql to
```
  `mpmodel` int(11) NOT NULL DEFAULT '1'
```
----------

[Download](https://github.com/FrazzIe/model-menu/archive/master.zip)

----------
Screentshots
https://image.prntscr.com/image/40adc5f7334644219c42eb6b34ee4b33.png
https://image.prntscr.com/image/25fa485f7ca44a36938f9034e80c7ef9.png
https://image.prntscr.com/image/d3ae53e701e14b75959306a10f8bf4f8.png
