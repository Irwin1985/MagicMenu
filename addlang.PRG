LPARAMETERS tcCaptionES, tcCaptionEN, tcHintES, tcHintEN


IF EMPTY(tcCaptionES)
	tcCaptionES = ""
ENDIF

IF EMPTY(tcCaptionEN)
	tcCaptionEN = ""
ENDIF

IF EMPTY(tcHintES)
	tcHintES = ""
ENDIF

IF EMPTY(tcHintEN)
	tcHintEN = ""
ENDIF

lcUnique = SYS(2015)

USE f:\desarrollo\magicmenu\lang\languages.dbf AGAIN IN 0 ALIAS Languages
APPEND BLANK
REPLACE control_id 	WITH lcUnique
replace caption_es 	WITH tcCaptionES
replace caption_en 	WITH tcCaptionEN
replace hint_es 	WITH tcHintES
replace hint_en 	WITH tcHintEN

USE IN languages

RETURN '_screen.oHelper.oLanguage.Translate("' + lcUnique + '")'