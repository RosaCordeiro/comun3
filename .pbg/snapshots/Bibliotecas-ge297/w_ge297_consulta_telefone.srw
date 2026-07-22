HA$PBExportHeader$w_ge297_consulta_telefone.srw
forward
global type w_ge297_consulta_telefone from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge297_consulta_telefone from dc_w_selecao_lista_relatorio
string tag = "w_ge297_consulta_telefone"
integer width = 4338
integer height = 2020
string title = "GE297 - Consulta Telefones Empresa"
end type
global w_ge297_consulta_telefone w_ge297_consulta_telefone

type variables
uo_centro_custo ivo_centro_custo
end variables

forward prototypes
public subroutine wf_localiza_centro_custo ()
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_localiza_centro_custo ();STRING lvs_Centro_Custo

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio
lvs_Centro_Custo = dw_1.GetText()
ivo_Centro_Custo.of_Localiza_Centro_Custo(lvs_Centro_Custo)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Centro_Custo.Localizada Then
	dw_1.Object.Cd_Centro_Custo[1] = ivo_Centro_Custo.Cd_Centro_Custo
  	dw_1.Object.De_Centro_Custo[1] = ivo_Centro_Custo.De_Centro_Custo
	  
Else

	SetNull(ivo_Centro_Custo.Cd_Centro_Custo)
	ivo_Centro_Custo.de_Centro_Custo = ""
	
	dw_1.Object.Cd_Centro_Custo[1] = ivo_Centro_Custo.Cd_Centro_Custo
  	dw_1.Object.De_Centro_Custo[1] = ivo_Centro_Custo.De_Centro_Custo
	  
End If
end subroutine

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

Long lvl_null

/*Grupo*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_operadora" )			

ldwc_Child.SetItem(1, "cd_operadora", lvl_null	)
ldwc_Child.SetItem(1, "nm_operadora", "TODAS")

dw_1.Object.cd_operadora[1] = lvl_null
end subroutine

on w_ge297_consulta_telefone.create
call super::create
end on

on w_ge297_consulta_telefone.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_centro_custo)
end event

event open;call super::open;ivo_centro_custo = Create uo_centro_custo
end event

event ue_preopen;call super::ue_preopen;//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
MaxWidth	= 4935

//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
//Neste caso como s$$HEX1$$e300$$ENDHEX$$o muitos registros o sistema ajusta ao m$$HEX1$$e100$$ENDHEX$$ximo poss$$HEX1$$ed00$$ENDHEX$$vel da tela
MaxHeight	= 9999

ivm_menu.ivb_permite_imprimir = True
end event

event ue_print;//override
dw_2.event ue_imprimir_relatorio("Telefones Empresa", "CL", False)
end event

event ue_printimmediate;call super::ue_printimmediate;//override
dw_2.event ue_imprimir_relatorio("Telefones Empresa", "CL", True)
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge297_consulta_telefone
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge297_consulta_telefone
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge297_consulta_telefone
integer y = 288
integer width = 4238
integer height = 1532
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge297_consulta_telefone
integer width = 3154
integer height = 272
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge297_consulta_telefone
integer y = 88
integer width = 3099
integer height = 156
string dataobject = "dw_ge297_selecao"
end type

event dw_1::editchanged;call super::editchanged;Long lvl_nulo

String lvs_nulo

SetNull(lvs_Nulo)
SetNull(lvl_Nulo)


Choose Case dwo.Name 
	Case "de_centro_custo"
	
		dw_2.Event ue_Reset()
		
		SetNull(lvl_Nulo)
		This.Object.Cd_Centro_Custo[1] = lvl_nulo
		Return 0
		
		If Data <> ivo_Centro_Custo.De_Centro_Custo Then Return 1
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = 'de_centro_custo' Then
		wf_Localiza_Centro_Custo()
	End If
	
End If
end event

event dw_1::getfocus;call super::getfocus;If dw_2.RowCount() > 0 Then
	ivm_Menu.mf_SalvarComo(False)
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge297_consulta_telefone
integer y = 364
integer width = 4169
integer height = 1424
string dataobject = "dw_ge297_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"nr_ddd","nr_telefone","de_telefone","nr_ramal","id_tipo",&
              "id_situacao", "cd_centro_custo","centro_custo", "cd_filial"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo de $$HEX1$$c100$$ENDHEX$$rea","N$$HEX1$$ba00$$ENDHEX$$ do Telefone","Descri$$HEX2$$e700e300$$ENDHEX$$o","Ramal","Tipo",&
            "Situa$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do Centro de Custo","Nome do Centro de Custo", "Filial"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection("", 'if( id_situacao = "3", RGB(255,0, 0), RGB(0,0,0) )')

This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_recuperar;//OverRide
Long lvl_Centro_Custo
Long lvl_Operadora

String lvs_DDD,&
		 lvs_Telefone,&
		 lvs_Situacao
		 

dw_1.AcceptText()

lvl_Centro_Custo	= dw_1.Object.Cd_Centro_Custo	[1]
lvs_DDD				= dw_1.Object.Nr_DDD			 	[1]
lvs_Telefone		= dw_1.Object.Nr_Telefone	 		[1]
lvl_Operadora		= dw_1.Object.cd_operadora	 	[1]
lvs_Situacao			= dw_1.Object.id_situacao		 	[1]

If Not IsNull(lvl_centro_custo) and lvl_centro_custo <> 0 Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio)+ 1] = "Centro Custo: "+ivo_centro_custo.de_centro_custo+' ('+String(ivo_centro_custo.cd_centro_custo)+')'
	This.of_AppendWhere("t.cd_centro_custo = " + String(lvl_centro_custo))
End If

If Not IsNull(lvl_Operadora) and lvl_Operadora <> 0 Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio)+ 1] = "Operadora: "+dw_1.Describe("Evaluate('LookUpDisplay(cd_operadora)',1)")
	This.of_AppendWhere("t.cd_operadora = " + String(lvl_Operadora))
End If

If lvs_Situacao <> "T" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio)+ 1] = "Situa$$HEX2$$e700e300$$ENDHEX$$o: "+dw_1.Describe("Evaluate('LookUpDisplay(id_situacao)',1)")
	If lvs_Situacao = "0" Then	
		This.of_AppendWhere("t.id_situacao <> '3'")
	Else
		This.of_AppendWhere("t.id_situacao = '" + lvs_Situacao + "'")
	End If
End If

If Not IsNull(lvs_DDD) and lvs_DDD <> "" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio)+ 1] = "DDD: "+lvs_DDD
	This.of_AppendWhere("t.nr_ddd = '" + lvs_DDD + "'")
End If

If Not IsNull(lvs_Telefone) and lvs_Telefone <> "" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio)+ 1] = "Telefone Inicia Com: "+Trim(lvs_Telefone)
	This.of_AppendWhere("t.nr_telefone like '" + Trim(lvs_Telefone) + "%'")
End If

Return This.Retrieve()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	
	ivm_Menu.mf_SalvarComo(True)
	
End If

Return pl_Linhas
end event

event dw_2::getfocus;call super::getfocus;If dw_2.RowCount() > 0 Then
	ivm_Menu.mf_SalvarComo(True)
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge297_consulta_telefone
integer x = 3269
integer y = 32
integer height = 188
end type

