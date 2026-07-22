HA$PBExportHeader$uo_unidade_federacao.sru
forward
global type uo_unidade_federacao from nonvisualobject
end type
end forward

global type uo_unidade_federacao from nonvisualobject
end type
global uo_unidade_federacao uo_unidade_federacao

type variables
string 	cd_unidade_federacao	, &
			nm_unidade_federacao	, &
			id_utiliza_st					, &
			id_tipo_cc_tributario

decimal	pc_icms_estadual			, &
			pc_icms_interestadual	, &
			pc_red_icms_outros		, &
			vl_fator_st					, &
			vl_fator_st_lista_positiva	, &
			vl_fator_st_lista_negativa, &
			pc_icms_diferido
				 
string		id_transf_soma_fcp
string		id_utiliza_cbenef_st
string		cd_cst_transf_tributada

datetime dh_inicio_envio_cbenef

Boolean Localizado = False
end variables

forward prototypes
public function boolean of_localiza_uf (string ps_uf)
public function boolean of_localiza_codigo (string ps_uf)
public function boolean of_localiza (string ps_parametro)
public subroutine of_inicializa ()
end prototypes

public function boolean of_localiza_uf (string ps_uf);This.Of_localiza_codigo( ps_uf )

Choose Case SqlCa.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Unidade de federa$$HEX2$$e700e300$$ENDHEX$$o '" + ps_UF + "' n$$HEX1$$e300$$ENDHEX$$o localizada.", Exclamation!, Ok!)
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da unidade de federa$$HEX2$$e700e300$$ENDHEX$$o '" + ps_UF + "'." + SqlCa.SqlErrText, StopSign!, Ok!)	
End Choose

Return This.Localizado
end function

public function boolean of_localiza_codigo (string ps_uf);Select		cd_unidade_federacao,
			nm_unidade_federacao,
			pc_icms_estadual,
			pc_icms_interestadual,
			id_utiliza_st,
			vl_fator_st,
			vl_fator_st_lista_positiva,
			vl_fator_st_lista_negativa,
			coalesce(id_transf_soma_fcp, 'N'),
			pc_icms_outros,
			cd_cst_transf_tributada,
			pc_icms_diferido,
			dh_inicio_envio_cbenef,
			coalesce(id_utiliza_cbenef_st,'N') as id_utiliza_cbenef_st,
			coalesce(id_tipo_cc_tributario, '1') as id_tipo_cc_tributario
Into	:cd_unidade_federacao,
		:nm_unidade_federacao,
		:pc_icms_estadual,
		:pc_icms_interestadual,
		:id_utiliza_st,
		:vl_fator_st,
		:vl_fator_st_lista_positiva,
		:vl_fator_st_lista_negativa,
		:id_transf_soma_fcp,
		:pc_red_icms_outros,
		:cd_cst_transf_tributada,
		:pc_icms_diferido,
		:dh_inicio_envio_cbenef,
		:id_utiliza_cbenef_st,
		:id_tipo_cc_tributario
From unidade_federacao
Where cd_unidade_federacao = :ps_UF;

//Sucesso?
Localizado = (SqlCa.SqlCode = 0)
	
If Localizado Then
	If IsNull(vl_fator_st) or vl_fator_st = 0 Then
		vl_fator_st = 1
	End If

	If IsNull(vl_fator_st_lista_positiva) or vl_fator_st_lista_positiva = 0 Then
		vl_fator_st_lista_positiva = 1
	End If

	If IsNull(vl_fator_st_lista_negativa) or vl_fator_st_lista_negativa = 0 Then
		vl_fator_st_lista_negativa = 1
	End If
	
	If IsNull(pc_red_icms_outros) Then pc_red_icms_outros = 10
	
	//CST padr$$HEX1$$e300$$ENDHEX$$o na cria$$HEX2$$e700e300$$ENDHEX$$o dessa possibilidade de varia$$HEX2$$e700e300$$ENDHEX$$o
	If IsNull(cd_cst_transf_tributada) Then cd_cst_transf_tributada = '51'
	
	//Caso n$$HEX1$$e300$$ENDHEX$$o tenha percentual de diferimento informado, mas a CST for diferimento ser$$HEX1$$e100$$ENDHEX$$ diferido 100%
	If IsNull(pc_icms_diferido) and (cd_cst_transf_tributada="51") Then pc_icms_diferido = 100
End If

Return This.Localizado
end function

public function boolean of_localiza (string ps_parametro);This.of_inicializa()

ps_parametro = Trim(ps_parametro)

If Len(ps_parametro) = 2 Then
	This.Of_localiza_codigo( ps_parametro )
End If

If Not This.Localizado Then
	OpenWithParm(w_ge021_selecao_uf, ps_parametro)

	This.Of_localiza_codigo( Message.StringParm )
End If

Return This.Localizado
end function

public subroutine of_inicializa ();SetNull(nm_unidade_federacao)
SetNull(cd_unidade_federacao)
SetNull(id_utiliza_st)
SetNull(cd_cst_transf_tributada)
SetNull(id_utiliza_cbenef_st)
SetNull(dh_inicio_envio_cbenef)
SetNull(pc_icms_diferido)

SetNull(vl_fator_st)
SetNull(pc_icms_estadual)
SetNull(pc_icms_interestadual)
SetNull(vl_fator_st_lista_positiva)
SetNull(vl_fator_st_lista_negativa)
SetNull(pc_red_icms_outros)
				 
SetNull(id_transf_soma_fcp)
SetNull(id_tipo_cc_tributario)

Localizado = False
end subroutine

on uo_unidade_federacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_unidade_federacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

