HA$PBExportHeader$uo_ge036_ajuda_sistema.sru
forward
global type uo_ge036_ajuda_sistema from nonvisualobject
end type
end forward

global type uo_ge036_ajuda_sistema from nonvisualobject
end type
global uo_ge036_ajuda_sistema uo_ge036_ajuda_sistema

type variables
String is_Servidor
String is_Diretorio	= ''
end variables

forward prototypes
public subroutine of_abre_ajuda (string ps_arquivo)
public subroutine of_abre_ajuda (string ps_arquivo, integer pi_versao)
end prototypes

public subroutine of_abre_ajuda (string ps_arquivo);String ls_Exe

ls_Exe = 'iexplore ' + is_Servidor

If is_Diretorio <> '' Then
	ls_Exe += '/' + is_Diretorio
End If

ls_Exe += '/' + ps_Arquivo

Run( ls_Exe, Maximized! )
end subroutine

public subroutine of_abre_ajuda (string ps_arquivo, integer pi_versao);String ls_Exe, &
	     ls_Path

ls_Path	= is_Servidor
ls_Exe 	= 'c:\arquivos de programas\Internet Explorer\iexplore.exe'

If Not FileExists(ls_Exe) Then
	ls_Exe = 'C:\Program Files (x86)\Internet Explorer\iexplore.exe'
	
	If Not FileExists(ls_Exe) Then
		ls_Exe = 'C:\Program Files\Internet Explorer\iexplore.exe'
		
		If Not FileExists(ls_Exe) Then			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum browser do IE para execu$$HEX2$$e700e300$$ENDHEX$$o do Help.", Exclamation!)
			Return		
		End If
	End If
End If

//"C:\Documents and Settings\douglas\Local Settings\Application Data\Google\Chrome\Application\chrome.exe"

If is_Diretorio <> '' Then
	ls_Exe += ' ' + ls_Path + '/' + is_Diretorio
End If

ls_Exe += '/' + ps_Arquivo

Run( ls_Exe, Maximized! )
end subroutine

on uo_ge036_ajuda_sistema.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge036_ajuda_sistema.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;String ls_Log

gf_servidor_intranet(True,  Ref is_Servidor, Ref ls_Log )


end event

