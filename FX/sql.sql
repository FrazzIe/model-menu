DROP TABLE IF EXISTS modelmenu;
CREATE TABLE IF NOT EXISTS `modelmenu` (
  `identifier` varchar(50) DEFAULT NULL,
  `model` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT 'a_m_m_bevhills_02',
  `percing` int(11) NOT NULL DEFAULT '0',
  `percing_txt` int(11) NOT NULL DEFAULT '240',
  `glasses` int(11) NOT NULL DEFAULT '0',
  `glasses_txt` int(11) NOT NULL DEFAULT '240',
  `helmet` int(11) NOT NULL DEFAULT '0',
  `helmet_txt` int(11) NOT NULL DEFAULT '240',
  `mask` int(11) NOT NULL DEFAULT '0',
  `mask_txt` int(11) NOT NULL DEFAULT '240',
  `head` int(11) NOT NULL DEFAULT '0',
  `hair` int(11) NOT NULL DEFAULT '1',
  `hair_colour` int(11) NOT NULL DEFAULT '1',
  `shirt` int(11) NOT NULL DEFAULT '0',
  `shirt_txt` int(11) NOT NULL DEFAULT '0',
  `hand` int(11) NOT NULL DEFAULT '0',
  `shoe` int(11) NOT NULL DEFAULT '0',
  `shoe_txt` int(11) NOT NULL DEFAULT '0',
  `pants` int(11) NOT NULL DEFAULT '0',
  `pants_txt` int(11) NOT NULL DEFAULT '0',
  `undershirt` int(11) NOT NULL DEFAULT '0',
  `undershirt_txt` int(11) NOT NULL DEFAULT '240',
  `armour` int(11) NOT NULL DEFAULT '0',
  `armour_txt` int(11) NOT NULL DEFAULT '0',
  `mpmodel` int(11) NOT NULL DEFAULT '0'
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

------ mpmodel ---------
--------- If your server spawns mp_m_freemode_01 by default, make it 1
--------- If your server spawns normal ped models make it 0