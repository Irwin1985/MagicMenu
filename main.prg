LPARAMETERS tcLanguage, tnToolBarSize

IF NOT PEMSTATUS(_screen, 'oLang', 5)
	_screen.AddProperty('oLang', .null.)
ENDIF

IF NOT PEMSTATUS(_screen, 'oHelper', 5)
	_screen.AddProperty('oHelper', .null.)
ENDIF

IF NOT PEMSTATUS(_screen, 'oBridge', 5)
	_screen.AddProperty('oBridge', .null.)
ENDIF

IF NOT PEMSTATUS(_screen, 'oVfpStretch', 5)
	_screen.AddProperty('oVfpStretch', .null.)
ENDIF

IF NOT PEMSTATUS(_screen, 'oProjectManager', 5)
	_screen.AddProperty('oProjectManager', .null.)
ENDIF

IF EMPTY(tcLanguage)
	tcLanguage = "EN"
ENDIF

IF EMPTY(tnToolBarSize)
	tnToolBarSize = 32
ENDIF

IF NOT INLIST(UPPER(tcLanguage), "ES", "EN")
	MESSAGEBOX("Wrong value for parameter: tcLanguage." + CHR(13) + CHR(10) + "Please send 'ES' for Spanish or 'EN' for English.", 16, "Error")
	RETURN
ENDIF
public loBarra, gcMainDir, gcVersion, glDebugMode, lcMenuClass
gcMainDir = ADDBS(SYS(5) + SYS(2003))
gcVersion = "0.0.1"

** DEBUG
glDebugMode = .t.
IF glDebugMode
	CD f:\desarrollo\github\magicmenu\
	SET DEFAULT TO f:\desarrollo\github\magicmenu\
ENDIF
** DEBUG

SET PATH TO "classes;bmps;lang;libs" ADDITIVE
SET PROCEDURE TO "VFPStretch" ADDITIVE
SET CLASSLIB TO "MagicMenu" ADDITIVE

_screen.oHelper = CREATEOBJECT("Helper")
_screen.oLang = _screen.oHelper.oLanguage.loadLanguage(LOWER(tcLanguage))
_screen.oVFPStretch = CREATEOBJECT("vfpStretch")

IF !DIRECTORY(gcMainDir + 'libs\')
	_screen.oHelper.oSystem.ExtractDependencies()
ENDIF

* Load the wwDotNetBridge
DO wwDotNetBridge
InitializeDotnetVersion()
_screen.oBridge = getwwDotNetBridge()
lcMenuClass = "ToolBarMenuX" + ALLTRIM(STR(tnToolBarSize))
loBarra = CREATEOBJECT(lcMenuClass)
loBarra.show()