HA$PBExportHeader$uo_prescritor.sru
forward
global type uo_prescritor from nonvisualobject
end type
end forward

global type uo_prescritor from nonvisualobject
end type
global uo_prescritor uo_prescritor

type variables
Boolean Localizado

String nr_registro, &
          nm_prescritor, &
          cd_uf, &
          id_registro

string ivs_Parametro, &
         ivs_Tipo_Prescritor = ""


end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_prescritor (string ps_parametro)
public subroutine of_localiza_codigo (string ps_id_registro, string ps_nr_registro, string ps_uf)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String lvs_Cliente

This.ivs_Parametro = ps_Parametro

OpenWithParm(w_ge056_Selecao_Prescritor, This)

If Not IsNull(lvs_Cliente) Then
	of_Localiza_Codigo(This.id_registro,This.nr_registro,This.cd_uf)
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();
SetNull(nr_registro)
SetNull(id_registro)
SetNull(cd_uf)

Nm_Prescritor = ""
end subroutine

public subroutine of_localiza_prescritor (string ps_parametro);Integer lvi_Tamanho

ps_Parametro = Trim(ps_Parametro)

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then		
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
	of_Localiza_Generica(ps_Parametro)
Else	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_localiza_codigo (string ps_id_registro, string ps_nr_registro, string ps_uf);Select id_registro,
       nr_registro,
		 cd_unidade_federacao,
		 nm_prescritor
  Into :id_registro,
       :nr_registro,
		 :cd_uf,
 		 :nm_prescritor
From prescritor_receita
Where id_registro = :ps_id_registro
  and nr_registro = :ps_nr_registro
  and cd_unidade_federacao = :ps_uf
Using Sqlca;  

Choose Case SqlCa.SqlCode
	Case 100
		Localizado = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do prescritor '" + ps_id_registro + "/" + ps_nr_registro + "/" + ps_uf + "." + SqlCa.SqlErrText, Information!)
		Localizado = False
	Case 0
		Localizado = True
End Choose
end subroutine

on uo_prescritor.create
TriggerEvent( this, "constructor" )
end on

on uo_prescritor.destroy
TriggerEvent( this, "destructor" )
end on

