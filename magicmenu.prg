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

IF NOT PEMSTATUS(_screen, 'oActiveProject', 5)
	_screen.AddProperty('oActiveProject', .null.)
ENDIF

IF NOT PEMSTATUS(_screen, 'oMagicMenu', 5)
	_screen.AddProperty('oMagicMenu', CREATEOBJECT("Empty"))
	ADDPROPERTY(_screen.oMagicMenu, "oBarra", .null.)
	ADDPROPERTY(_screen.oMagicMenu, "cMainDir", ADDBS(JUSTPATH(SYS(16))))
	ADDPROPERTY(_screen.oMagicMenu, "cDirBMP", ADDBS(JUSTPATH(SYS(16))) + 'bmps\')
	ADDPROPERTY(_screen.oMagicMenu, "cVersion", "0.3.2")
	ADDPROPERTY(_screen.oMagicMenu, "bDebugMode", .F.)
	ADDPROPERTY(_screen.oMagicMenu, "cVFPDir", "C:\Program Files (x86)\Microsoft Visual FoxPro 9\vfp9.exe")	
	ADDPROPERTY(_screen.oMagicMenu, "cTempDir", ADDBS(GETENV("USERPROFILE")) + 'MagicMenu\')
	IF NOT DIRECTORY(_screen.oMagicMenu.cTempDir)
		MKDIR (_screen.oMagicMenu.cTempDir)
	ENDIF
ENDIF

IF EMPTY(tcLanguage)
	tcLanguage = "ES"
ENDIF

IF EMPTY(tnToolBarSize)
	tnToolBarSize = 16
ENDIF

IF NOT INLIST(UPPER(tcLanguage), "ES", "EN")
	MESSAGEBOX("Wrong value for parameter: tcLanguage." + CHR(13) + CHR(10) + "Please send 'ES' for Spanish or 'EN' for English.", 16, "Error")
	RETURN
ENDIF

CD (_screen.oMagicMenu.cMainDir)
SET DEFAULT TO (_screen.oMagicMenu.cMainDir)

SET PATH TO "classes;bmps;lang;libs" ADDITIVE
SET PROCEDURE TO "VFPStretch" ADDITIVE
SET CLASSLIB TO "MagicMenu" ADDITIVE

_screen.oHelper 	= CREATEOBJECT("Helper")
_screen.oLang 		= _screen.oHelper.oLanguage.loadLanguage(LOWER(tcLanguage))
_screen.oVFPStretch = CREATEOBJECT("vfpStretch")

IF !DIRECTORY(_screen.oMagicMenu.cMainDir + 'libs\')
	_screen.oHelper.oSystem.ExtractDependencies()
ENDIF

* Load the wwDotNetBridge
DO wwDotNetBridge
InitializeDotnetVersion()
_screen.oBridge = getwwDotNetBridge()
LOCAL lcMenuClass
lcMenuClass = "ToolBarMenuX" + ALLTRIM(STR(tnToolBarSize))
_screen.oMagicMenu.oBarra = CREATEOBJECT(lcMenuClass)
_screen.oMagicMenu.oBarra.show()