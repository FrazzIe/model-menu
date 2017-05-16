DROP TABLE IF EXISTS modelmenu;
CREATE TABLE IF NOT EXISTS `modelmenu` (
  `identifier` varchar(50) DEFAULT NULL,
  `model` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT 'a_m_m_acult_01'
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;