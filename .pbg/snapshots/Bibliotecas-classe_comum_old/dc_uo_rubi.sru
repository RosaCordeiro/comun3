HA$PBExportHeader$dc_uo_rubi.sru
forward
global type dc_uo_rubi from transaction
end type
end forward

global type dc_uo_rubi from transaction
end type
global dc_uo_rubi dc_uo_rubi

forward prototypes
public function boolean of_localiza_dll ()
public function boolean of_connect ()
end prototypes

public function boolean of_localiza_dll ();String lvs_DLL1, &
	    lvs_DLL2, &
	    lvs_Path

Integer lvi_Retorno

// Procedimento para identificar o sistema operacional
Environment lvo_ENV
OsTypes     lvo_OsType

lvi_Retorno = GetEnvironment(lvo_ENV)

If lvi_Retorno <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar ao identiciar o sistema operacional.")
	Return False
End If

lvo_OsType = lvo_ENV.OsType

If lvo_OsType = Windowsnt! Then
	lvs_Path = "C:\WINNT"
Else
	lvs_Path = "C:\WINDOWS"
End If
		
lvs_DLL1 = Upper(lvs_Path + "\system32\ntwdblib.dll")
lvs_DLL2 = Upper(lvs_Path + "\system32\pbmss60.dll")

If Not FileExists(lvs_DLL1) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo DLL '" + lvs_DLL1 + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado'.")
	Return False
End If

If Not FileExists(lvs_DLL2) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo DLL '" + lvs_DLL2 + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado'.")
	Return False
End If

Return True
end function

public function boolean of_connect ();If Not This.of_Localiza_DLL() Then Return False

This.DBMS       = "MSS Microsoft SQL Server 6.5"
This.Database   = "dbsenior"
This.LogPass    = "gambiarra"
This.ServerName = "Drog_Cat2"
This.LogId      = "intranet"
This.AutoCommit = False

Connect Using This;

If This.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados do RH.~r~r" + This.SQLErrText, StopSign!)
	Return False
Else
	If This.SqlCode = 100 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar ao banco de dados do RH.", StopSign!)
		Return False
	End If
End If

Return True
end function

on dc_uo_rubi.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_rubi.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

