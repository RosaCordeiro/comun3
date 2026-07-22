HA$PBExportHeader$uo_conta_fluxo_caixa.sru
forward
global type uo_conta_fluxo_caixa from nonvisualobject
end type
end forward

global type uo_conta_fluxo_caixa from nonvisualobject
end type
global uo_conta_fluxo_caixa uo_conta_fluxo_caixa

type variables
Boolean Localizado

String de_conta_fluxo_caixa, &
           id_credito_debito, &
           id_situacao,&
		  cd_centro_custo_m3,&
		  cd_conta_contabil,&
		  id_necessita_anexo,&
		  id_permite_modificar_destino

Long cd_conta_fluxo_caixa

end variables

forward prototypes
public subroutine of_localiza_codigo (long pl_conta)
public subroutine of_localiza_conta (string ps_parametro)
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_codigo (long pl_conta);Select		cd_conta_fluxo_caixa,
          	de_conta_fluxo_caixa,
			id_credito_debito,
		 id_situacao, 
		 cd_centro_custo_m3, 
		 cd_conta_contabil, 
		 id_necessita_anexo, 
		 id_permite_modificar_destino
Into :cd_conta_fluxo_caixa,
     :de_conta_fluxo_caixa,
	  :id_credito_debito,
	  :id_situacao,
	  :cd_centro_custo_m3,
	  :cd_conta_contabil,
	  :id_necessita_anexo,
	  :id_permite_modificar_destino
From conta_fluxo_caixa
Where cd_conta_fluxo_caixa = :pl_conta
Using SqlCa;
						 
Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True
	Case 100
		Localizado = False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Conta de Fluxo de Caixa")
		Localizado = False
End Choose
end subroutine

public subroutine of_localiza_conta (string ps_parametro);//
Integer lvi_Tamanho
//
lvi_Tamanho = LenA(ps_Parametro)
//
If lvi_Tamanho > 0 Then
		If IsNumber(ps_Parametro) Then
			of_Localiza_Codigo(LONG(ps_Parametro))
			If Not Localizado Then	
				of_Localiza_Generica("")		
			End If
	Else	
		of_Localiza_Generica(ps_Parametro)
	End If	
Else	
	of_Localiza_Generica("")
End If
//
end subroutine

public subroutine of_localiza_generica (string ps_parametro);String lvs_conta

OpenWithParm(w_ge187_Selecao_Conta_Fluxo_Caixa, ps_Parametro)

lvs_conta = Message.StringParm

If Not IsNull(lvs_conta) Then
	of_Localiza_Codigo(LONG(lvs_conta))
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();SetNull(Cd_Conta_Fluxo_Caixa)
De_Conta_Fluxo_Caixa = ""
end subroutine

on uo_conta_fluxo_caixa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_conta_fluxo_caixa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

