#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <Array.au3>
#include <File.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\dev\bao\bao.kxf
$Form1_1 = GUICreate("Form1", 274, 437, 345, 158)
$Label1 = GUICtrlCreateLabel("Boite à Outils", 8, 0, 66, 17)
$btn_epuration_lot = GUICtrlCreateButton("Epuration lots bloquant", 8, 160, 259, 25)
$btn_lot_rouge = GUICtrlCreateButton("correction lot rouge", 8, 128, 259, 25)
$lst_praticien = GUICtrlCreateList("", 8, 64, 257, 58)
$btn_parourir = GUICtrlCreateButton("Parcourir", 8, 24, 49, 25)
$txt_chemin = GUICtrlCreateInput("", 72, 24, 193, 21)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
