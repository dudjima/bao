;�----------------------------------------------------
;�--------------------�D�claration�-------------------
;�----------------------------------------------------
;�Version�AutoIt�:����3.7.3
;�Langue�����:��������Francais
;�Plateforme�:		XP/SEVEN/10
;�Auteur����:��������Benjamin DURIEZ
;
;�Fonction�du�script:�Boite � outil pour les manips de fichiers

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
#include "..\constantes.au3"

$chemin_fse		= ""
$chemin_logs 	= $dossier_logs & "\bao_logs.log"
$dossier_existe = FileExists($dossier_logs)
if $dossier_existe = 0 Then
	DirCreate($dossier_logs)
	_FileWriteLog($chemin_logs, "Cr�ation du dossier de logs")
EndIf
_FileWriteLog($chemin_logs, "Lancement du programme")
$val= GUICtrlRead($lst_praticien) ; on r�cup�re la valeur du num user � traiter

; on essai de r�cup�rer le chemin dans c:\pyxvital\pyxvital.ini
$ini_pyxvital = IniRead($chemin_pyxvital_ini, "R�pertoires", "Fse", "0")
if $ini_pyxvital == 0 Then
	_FileWriteLog($chemin_logs, "pyxvital.ini non trouve /:  "& $chemin_pyxvital_ini)
	MsgBox(0, "Erreur = 0", "Le programme ne trouve pas de pyxvital install� sur le poste")
Else
	$chemin_pyx =  StringTrimRight($ini_pyxvital,6)
	$chemin_fse =	StringTrimRight($ini_pyxvital,2)
	_FileWriteLog($chemin_logs, "Chemin FSE dans pyxvital.ini = " & $chemin_pyx)
EndIf

GUICtrlSetData($txt_chemin, $chemin_fse)
$liste_praticiciens = _FileListToArrayRec($chemin_fse, "*|*bak;*old", 2, 0, 1)

For $i = 1 To $liste_praticiciens[0]
	GUICtrlSetData($lst_praticien,$liste_praticiciens[$i])
Next

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btn_parourir
			$chemin_fse = FileSelectFolder("choisir le chemin du dossier FSE", $dossier_pyxvital)
			GUICtrlSetData($txt_chemin, $chemin_fse)
			GUICtrlSetData($lst_praticien, "")
			$liste_praticiciens = _FileListToArrayRec($chemin_fse, "*|*bak;*old", 2, 0, 1)
			For $i = 1 To $liste_praticiciens[0]
				GUICtrlSetData($lst_praticien, $liste_praticiciens[$i])
			Next

		Case $btn_epuration_lot
			Run($dossier_softs & "\epuration.exe")

		Case $btn_lot_rouge
			TrayTip("Epuration lot rouge", "D�but du traitement du fichier",5000)
			$chemin_fichiers = $chemin_fse & "\" & GUICtrlRead($lst_praticien)
			$liste_fichiers = _FileListToArray($chemin_fichiers, "*.hif")
			_FileWriteLog($chemin_logs, "dossier parcouru : " & $chemin_fichiers)
			$compteur = 0
			for $i = 1 to $liste_fichiers[0]
				$pourcentage = $i*100 / $liste_fichiers[0]
				_FileWriteLog($chemin_logs, "pourcentage : " & $pourcentage)
				GUICtrlSetData($Progress1,$pourcentage)
				$pId = _ReplaceStringInFile($chemin_fichiers& "\" & $liste_fichiers[$i], "Erreur FSE = sans ARL", "")
				if $pId = 1 Then
					$compteur += 1
					GUICtrlSetData($lst_tache, "Fichier trait� : " & $liste_fichiers[$i])
					GUICtrlSetData($lst_tache, "Nombre trait� : " & $compteur & "\" & $liste_fichiers[0])
				EndIf
			Next
			if $compteur = 0 then GUICtrlSetData($lst_tache, "Aucun fichier trait�")
			TrayTip("Epuration lot rouge", "fin du traitement du fichier", 5000)

	EndSwitch
WEnd
