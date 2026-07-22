HA$PBExportHeader$uo_ncm_situacao.sru
forward
global type uo_ncm_situacao from nonvisualobject
end type
end forward

global type uo_ncm_situacao from nonvisualobject
end type
global uo_ncm_situacao uo_ncm_situacao

type variables
Boolean Localizado

String Cd_UF
Long Nr_NCM
Long Nr_Sequencial

String De_Situacao
Long Cd_Tributacao_Produto
Long Cd_Mensagem
Long Cd_Tipo_ICMS
String Cd_Tributacao_ICMS
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (long pl_ncm, string ps_uf, long pl_sequencial)
public function boolean of_localiza (long pl_ncm, string ps_uf, string ps_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_UF)
SetNull(Nr_NCM)
SetNull(De_Situacao)
SetNull(Nr_Sequencial)
SetNull(Cd_Mensagem)
SetNull(Cd_Tipo_ICMS)
SetNull(Cd_Tributacao_ICMS)
SetNull(Cd_Tributacao_Produto)

Localizado = False
end subroutine

public function boolean of_localiza_codigo (long pl_ncm, string ps_uf, long pl_sequencial);This.Of_inicializa( )

Select 	cd_uf,
			nr_ncm,
			nr_sequencial,
			de_situacao_especial,
			cd_tributacao_produto,
			cd_mensagem_fiscal,
			cd_tipo_icms,
			cd_tributacao_icms
Into 		:Cd_UF,
	 		:Nr_NCM,
	 		:Nr_Sequencial,
	 		:De_Situacao,
	 		:Cd_Tributacao_Produto,
	 		:Cd_Mensagem,
	 		:Cd_Tipo_ICMS,
	 		:Cd_Tributacao_ICMS
From ncm_situacao_especial
Where nr_ncm = :pl_ncm
	And cd_uf = :ps_uf
	And nr_sequencial = :pl_sequencial
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.of_msgdberror('Localiza$$HEX2$$e700e300$$ENDHEX$$o informa$$HEX2$$e700f500$$ENDHEX$$es situa$$HEX2$$e700e300$$ENDHEX$$o especial NCM.')
End If

Localizado = (SQLCa.SQLCode = 0)

Return Localizado
end function

public function boolean of_localiza (long pl_ncm, string ps_uf, string ps_parametro);String lvs_Parametro
String lvs_Retorno
String lvs_UF
String lvs_NCM
String lvs_Sequencial

This.Of_Inicializa()

If IsNumber(ps_parametro) Then
	This.Of_localiza_codigo(pl_ncm,ps_uf,Long(ps_parametro))
End If

If Not Localizado Then
	lvs_Parametro = String(pl_ncm)+';'
	lvs_Parametro += ps_uf+';'
	lvs_Parametro += ps_parametro+';'
	
	OpenWithParm(w_ge021_selecao_ncm_situacao,lvs_Parametro)
	
	lvs_Retorno = Message.StringParm
	lvs_NCM		= Mid(lvs_Retorno,1,Pos(lvs_Retorno,";") - 1)
	lvs_Retorno = Mid(lvs_Retorno,Pos(lvs_Retorno,";") + 1)
	lvs_UF		= Mid(lvs_Retorno,1,Pos(lvs_Retorno,";") - 1)
	lvs_Retorno = Mid(lvs_Retorno,Pos(lvs_Retorno,";") + 1)
	lvs_Sequencial	= Mid(lvs_Retorno,1)
	
	This.Of_Localiza_codigo(Long(lvs_NCM), lvs_UF, Long(lvs_Sequencial))
End If


Return Localizado
end function

on uo_ncm_situacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ncm_situacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.Of_inicializa( )
end event

