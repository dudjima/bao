; ----------------------------------------------------
; -------------------- Déclaration -------------------
; ----------------------------------------------------
; Version AutoIt :    3.7.3
; Langue     :        Francais
; Plateforme :		XP/SEVEN/10
; Auteur    :        Benjamin DURIEZ
;
; Fonction du script: Boite à outil pour les manips de fichiers

#RequireAdmin
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <MsgBoxConstants.au3>
#include <ColorConstants.au3>
#include <File.au3>
#include <NetShare.au3>
#include "fenetre_bao.au3"

$chemin_fse =""
While 1
	$nMsg = GUIGetMsg()
	$val= GUICtrlRead($lst_praticien) ; on récupère la valeur du num user à traiter
	$chemin_fichiers = $chemin_fse&"\"&$val

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btn_parourir

			$chemin_fse = FileSelectFolder("choisir le chemin du dossier FSE","C:\pyxvital")
			GUICtrlSetData($txt_chemin,$chemin_fse)
			GUICtrlSetData($lst_praticien,"")
;~ 			$liste_praticiciens = _FileListToArray($chemin_fse&"\","*","2")
			$liste_praticiciens = _FileListToArrayRec($chemin_fse,"*|*bak;*old",2,0,1)
			For $i = 1 To UBound($liste_praticiciens) - 1
				GUICtrlSetData($lst_praticien,$liste_praticiciens[$i])
			Next

		Case $btn_epuration_lot
			Run("c:\trilog\soft\epuration.exe")
		Case $btn_lot_rouge
			$liste_fichiers = _FileListToArray($chemin_fichiers,"*.hif")
			for $i=1 to UBound($liste_fichiers) - 1
				_ReplaceStringInFile($chemin_fichiers&"\"& $liste_fichiers[$i],"Erreur FSE = sans ARL","")
			Next
			MsgBox(1,"","fin moulinettes")
	EndSwitch
WEnd
