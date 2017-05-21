DROP TABLE IF EXISTS modelmenu;
CREATE TABLE IF NOT EXISTS `modelmenu` (
  `identifier` varchar(50) DEFAULT NULL,
  `model` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT 'a_m_m_acult_01',
  `percing` int(11) NOT NULL DEFAULT '1',
  `percing_txt` int(11) NOT NULL DEFAULT '1',
  `glasses` int(11) NOT NULL DEFAULT '1',
  `glasses_txt` int(11) NOT NULL DEFAULT '1',
  `helmet` int(11) NOT NULL DEFAULT '1',
  `helmet_txt` int(11) NOT NULL DEFAULT '1',
  `mask` int(11) NOT NULL DEFAULT '0',
  `mask_txt` int(11) NOT NULL DEFAULT '0'
  `mpmodel` int NOT NULL DEFAULT '0'
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
