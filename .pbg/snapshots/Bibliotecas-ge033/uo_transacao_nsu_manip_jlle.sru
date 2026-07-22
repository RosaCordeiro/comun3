HA$PBExportHeader$uo_transacao_nsu_manip_jlle.sru
forward
global type uo_transacao_nsu_manip_jlle from dc_uo_transacao
end type
end forward

global type uo_transacao_nsu_manip_jlle from dc_uo_transacao
end type
global uo_transacao_nsu_manip_jlle uo_transacao_nsu_manip_jlle

forward prototypes
public function boolean of_connect_central (string ps_DataSource)
end prototypes

public function boolean of_connect_central (string ps_DataSource);String lvs_HostName

lvs_HostName = "RL_Manip"

This.DBMS       = "SYC Sybase System 10/11"
This.Database   = ps_DataSource
This.AutoCommit = False
This.dbParm     = "CharSet='roman8', DateTimeAllowed='Yes', Release='11', Host='" + lvs_HostName + &
                   "', AppName='" + lvs_HostName + "', CommitOnDisconnect='No'"		
		
If Upper(ps_DataSource) = "CENTRAL_DES" Then
	This.ServerName = "SybaseCentral"			
	This.LogId      = "Desenvolvimento"
	This.LogPass    = "desenv"
ElseIf Upper(ps_DataSource) = "CENTRAL" Then
	This.ServerName = "SybaseCentral"			
	This.LogId      = "Drogaria"
	This.LogPass    = "CAThpOwner"
End If
		
Connect Using This;

If This.SqlCode = -1 Then
	This.of_MsgdbError("Conex$$HEX1$$e300$$ENDHEX$$o com o Banco de Dados")
	Return False
End If
Return True

end function

on uo_transacao_nsu_manip_jlle.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on uo_transacao_nsu_manip_jlle.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

