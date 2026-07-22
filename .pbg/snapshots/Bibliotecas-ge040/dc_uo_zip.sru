HA$PBExportHeader$dc_uo_zip.sru
forward
global type dc_uo_zip from nonvisualobject
end type
end forward

global type dc_uo_zip from nonvisualobject
end type
global dc_uo_zip dc_uo_zip

type prototypes
FUNCTION long  addZIP_Register(string RegName, long RegNum) LIBRARY "azip32.dll" alias for "addZIP_Register;Ansi"
FUNCTION long  addZIP_Initialise() LIBRARY "azip32.dll"
FUNCTION long  addZIP_SetParentWindowHandle(long HWND) LIBRARY "azip32.dll"
FUNCTION long  addZIP_SetCompressionLevel(integer pi_Nivel) LIBRARY "azip32.dll"
FUNCTION long  addZIP_Include(string ps_Arquivo) LIBRARY "azip32.dll" alias for "addZIP_Include;Ansi"
FUNCTION long  addZIP_ArchiveName(string ps_Arquivo) LIBRARY "azip32.dll" alias for "addZIP_ArchiveName;Ansi"
FUNCTION long  addZIP() LIBRARY "azip32.dll"
FUNCTION long addZIP_GetLastWarning() LIBRARY "azip32.dll"
FUNCTION long addZIP_GetLastError() LIBRARY "azip32.dll"
FUNCTION long addZIP_SaveStructure(integer pi_estrutura) LIBRARY "azip32.dll"

FUNCTION long  addUNZIP_Register(string RegName, long RegNum) LIBRARY "aunzip32.dll" alias for "addUNZIP_Register;Ansi"
FUNCTION long  addUNZIP_Initialise() LIBRARY "aunzip32.dll"
FUNCTION long  addUNZIP() LIBRARY "aunzip32.dll"
FUNCTION long  addUNZIP_ArchiveName(string ps_Arquivo) LIBRARY "aunzip32.dll" alias for "addUNZIP_ArchiveName;Ansi"
FUNCTION long  addUNZIP_ExtractTo(string ps_caminho) LIBRARY "aunzip32.dll" alias for "addUNZIP_ExtractTo;Ansi"
FUNCTION long addUNZIP_GetLastError() LIBRARY "aunzip32.dll"
FUNCTION long addUNZIP_Overwrite(integer pi_sobrepor) LIBRARY "aunzip32.dll"
FUNCTION long addUNZIP_RestoreStructure(long RegNum) LIBRARY "aunzip32.dll" alias for "addUNZIP_RestoreStructure;Ansi"

end prototypes

type variables
dc_uo_api ivo_Api

string lvs_arquivo_destino

Long ivl_Salva_Estrutura = 0
end variables

forward prototypes
public subroutine of_zip_origem (string ps_origem)
public subroutine of_zip_destino (string ps_destino)
public function string of_zip ()
public subroutine of_unzip_origem (string ps_origem)
public subroutine of_unzip_destino (string ps_destino)
public function string of_unzip ()
public function string of_unzip (boolean pb_sobrepor)
public subroutine of_salva_estrutura (boolean pb_salvar)
public function string of_zip (string ps_origem, string ps_destino)
public function string of_unzip (boolean pb_sobrepor, boolean pb_manter_estrutura)
end prototypes

public subroutine of_zip_origem (string ps_origem);addZIP_Include(ps_origem)
end subroutine

public subroutine of_zip_destino (string ps_destino);addZIP_ArchiveName(ps_destino)
end subroutine

public function string of_zip ();Long lvl_Error

String lvs_Error
addZIP_SaveStructure(ivl_Salva_Estrutura) 
addZIP_SetCompressionLevel(3)

addZIP()
lvl_Error = addZIP_GetLastError()


Choose Case lvl_Error
		
	Case 12
		lvs_Error = "Arquivo n$$HEX1$$e300$$ENDHEX$$o encontrado"
		
	Case 0
		lvs_Error = ""		
		
 	Case Else
		lvs_Error = "Erro na compacta$$HEX2$$e700e300$$ENDHEX$$o: " + String(lvl_Error)
		
End Choose

Return lvs_Error
end function

public subroutine of_unzip_origem (string ps_origem);addUNZIP_ArchiveName(ps_origem)
lvs_arquivo_destino = MidA(ps_origem, 1, LenA(ps_Origem) -4) + ".txt"
end subroutine

public subroutine of_unzip_destino (string ps_destino);addUNZIP_ExtractTo(ps_destino)
end subroutine

public function string of_unzip ();Long lvl_Error
String lvs_Error = ""

addUNZIP()

lvl_Error = addUNZIP_GetLastError()

Choose Case lvl_Error
	Case 11
		lvs_Error = "Arquivo de destino j$$HEX1$$e100$$ENDHEX$$ existe"
End Choose

Return lvs_Error
end function

public function string of_unzip (boolean pb_sobrepor);Boolean lvb_Exclude

If pb_sobrepor Then
	lvb_Exclude = ivo_Api.of_Delete_File(lvs_arquivo_destino, FALSE)
	
	If Not lvb_Exclude Then
		Return ""
	End If
	
End If

Return of_UnZip()
end function

public subroutine of_salva_estrutura (boolean pb_salvar);//Salvar  a estrutura de pasta
If pb_Salvar Then
	ivl_Salva_Estrutura = -1
Else
	ivl_Salva_Estrutura = 0
End If

end subroutine

public function string of_zip (string ps_origem, string ps_destino);of_Zip_Destino(ps_Destino)
of_Zip_Origem(ps_Origem)

Return of_Zip()
end function

public function string of_unzip (boolean pb_sobrepor, boolean pb_manter_estrutura);Boolean lvb_Exclude

If pb_sobrepor Then
	lvb_Exclude = ivo_Api.of_Delete_File(lvs_arquivo_destino, FALSE)
	
	If Not lvb_Exclude Then
		Return ""
	End If
	
End If

If pb_manter_estrutura Then
	addUNZIP_RestoreStructure(1)	
Else
	addUNZIP_RestoreStructure(0)		
End If

Return of_UnZip()
end function

on dc_uo_zip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_zip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_api = Create dc_uo_api

addZIP_Initialise()
addZIP_Register("UBS, INC.", 600365060)
addUNZIP_Initialise()
addUNZIP_Register("UBS, INC.", 600365060)
addZIP_SetCompressionLevel(3)
end event

event destructor;Destroy ivo_api
end event

