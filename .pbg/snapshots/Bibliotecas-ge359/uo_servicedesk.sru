HA$PBExportHeader$uo_servicedesk.sru
forward
global type uo_servicedesk from nonvisualobject
end type
end forward

global type uo_servicedesk from nonvisualobject
end type
global uo_servicedesk uo_servicedesk

type variables
Long Nr_Chamado
String De_Chamado

String Nm_Usuario

Long Cd_Filial
Long Id_Situacao

Boolean Localizado = False

Private:
uo_ge136_transacao_remota itr_SD
end variables

forward prototypes
public function boolean of_conecta ()
public function boolean of_desconecta ()
public function boolean of_localiza_codigo (long pl_chamado)
public subroutine of_inicializa ()
end prototypes

public function boolean of_conecta ();Return gf_Ge136_Conecta_Banco_ServiceDesk( Ref itr_SD )
end function

public function boolean of_desconecta ();If IsValid( itr_SD ) Then
	itr_SD.of_Deleta_ODBC( "servicedesk" )
	Destroy itr_SD
End If

Return True
end function

public function boolean of_localiza_codigo (long pl_chamado);//Verifica conex$$HEX1$$e300$$ENDHEX$$o
If Not IsValid(itr_SD) Then itr_SD = Create uo_ge136_transacao_remota
If Not itr_SD.of_IsConnected( ) Then 
	If Not This.Of_Conecta() Then
		This.Of_Inicializa( )
		Return Localizado
	End If
End If

//Localiza os valores no banco
SELECT c.cd_chamado, COALESCE(u.nm_usuario, '' ), left(c.ds_chamado, 1500), c.st_chamado
	INTO :Nr_Chamado, :Nm_Usuario, :De_Chamado, :Id_Situacao
  FROM sd_chamado c
INNER JOIN sd_usuario u 
	ON u.cd_usuario = c.cd_usuario
WHERE c.cd_chamado = :pl_chamado
  USING itr_SD;

//Trata retorno
Choose Case itr_SD.SQLCode
	Case -1
		This.of_Inicializa()
	Case 0
		If IsNumber(Mid(Nm_Usuario, 1, 4)) Then
			Cd_Filial = Long(Mid(Nm_Usuario, 1, 4))
		Else
			Cd_Filial = 534
		End If
		
		Localizado = True
	Case 100
		This.of_Inicializa()
End Choose
	  
Return Localizado
end function

public subroutine of_inicializa ();SetNull( Nr_Chamado )
SetNull( De_Chamado )
SetNull( Nm_Usuario )
SetNull( Cd_Filial )

Localizado = False
end subroutine

on uo_servicedesk.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_servicedesk.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;This.Of_Desconecta()
end event

