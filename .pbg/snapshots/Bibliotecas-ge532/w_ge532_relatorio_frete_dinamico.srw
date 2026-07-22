HA$PBExportHeader$w_ge532_relatorio_frete_dinamico.srw
forward
global type w_ge532_relatorio_frete_dinamico from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge532_relatorio_frete_dinamico from dc_w_selecao_lista_dinamica_relatorio
integer width = 4087
integer height = 1964
string title = "GE532 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico Frete Disque Entrega"
end type
global w_ge532_relatorio_frete_dinamico w_ge532_relatorio_frete_dinamico

type variables
uo_filial 	io_filial

end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*UF Filial*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			
ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")
dw_1.Object.cd_uf[1] = "TD"

/*Cidade*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_cidade" )			
ldwc_Child.SetItem(1, "cd_cidade", 0)
ldwc_Child.SetItem(1, "nm_cidade", "TODAS")
dw_1.Object.cd_cidade[1] = 0

/*Rede*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_rede" )			
ldwc_Child.SetItem(1, "vl_parametro", "TD")
ldwc_Child.SetItem(1, "rede", "TODAS")
dw_1.Object.id_rede[1] = "TD"

/*Regiao*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_regiao" )			
ldwc_Child.SetItem(1, "cd_regiao", 0)
ldwc_Child.SetItem(1, "de_regiao", "TODAS")
dw_1.Object.cd_regiao[1] = 0



end subroutine

on w_ge532_relatorio_frete_dinamico.create
call super::create
end on

on w_ge532_relatorio_frete_dinamico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;io_filial = Create uo_filial

//Dimensionamento de tela
MaxWidth = 4050
MaxHeight = 9999

//SQL Base para formar o grid
ivs_SQLBase = 	' from filial f ' 																	+&
					' inner join regiao r ' 															+&	
					'   on r.cd_regiao = f.cd_regiao ' 											+&
					' inner join ect_localidade el ' 												+& 
					'   on el.nr_localidade > 0 ' 													+&
					' inner join ect_bairro eb (index idx_localidade) ' 						+&
					'   on eb.nr_localidade = el.nr_localidade ' 								+&
					' inner join ect_bairro_filial ebf (index pk_ect_bairro_filial) ' 		+&
					'   on ebf.cd_filial = f.cd_filial '	 											+&											
					'   and ebf.nr_bairro = eb.nr_bairro ' 										+&
					' inner join  cidade cid ' 														+&
					'   on cid.nr_localidade_ect = eb.nr_localidade ' 						+&
					' inner join parametro_loja p '												+&
					'   on p.cd_filial 			= f.cd_filial '										+&
					"  and p.cd_parametro 	= UPPER('ID_DISQUE_ENTREGA') "		+&
					"  and p.vl_parametro 	= UPPER('S') "									+&
					' left outer join ect_logradouro elg (index idx_localidade_bairro) '	+&
					'   on elg.cd_uf 	= eb.cd_uf ' 											+&
					'   and elg.nr_localidade = eb.nr_localidade ' 						+&
					'   and elg.nr_bairro = eb.nr_bairro '

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 29
end event

event close;call super::close;If IsValid(io_filial) Then Destroy io_filial
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge532_relatorio_frete_dinamico
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge532_relatorio_frete_dinamico
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge532_relatorio_frete_dinamico
integer width = 3995
integer height = 1380
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge532_relatorio_frete_dinamico
integer width = 2761
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge532_relatorio_frete_dinamico
integer width = 2693
string dataobject = "dw_ge532_selecao_filial"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
		
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.nm_fantasia Then
				Return 1
			End If	
		Else			
			io_Filial.Of_Inicializa()
			
			This.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
			This.Object.cd_filial		[1] = io_Filial.cd_filial
			
		End If	
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	This.AcceptText( )
	
	Choose Case This.GetColumnName() 
			
		Case "nm_fantasia"
			io_filial.Of_Localiza_Filial(This.GetText()) 
			
			If io_filial.Localizada Then
				  
				This.Object.cd_filial		[1] = io_filial.cd_filial
				This.Object.nm_fantasia	[1] = io_filial.nm_fantasia
				
			End If
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(io_Filial) Then 
	This.Object.Nm_fantasia[1] = io_Filial.Nm_Fantasia
End If

end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge532_relatorio_frete_dinamico
integer width = 3927
integer height = 1272
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Filial
Long ll_Regiao
Long ll_Cidade

String ls_Rede
String ls_UF

dw_1.Accepttext( )

ll_Filial 		= dw_1.Object.cd_filial					[1]
ls_Rede		= dw_1.Object.id_rede					[1]
ll_Regiao	 	= dw_1.Object.cd_regiao				[1]
ls_UF			= dw_1.Object.cd_uf						[1]
ll_Cidade		= dw_1.Object.cd_cidade				[1]

If Not IsNull(ll_Filial) and (ll_Filial > 0) Then
	This.Of_AppendWhere("f.cd_filial="+String(ll_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+io_filial.nm_fantasia+' ('+String(ll_Filial)+')'
Else
	This.Of_AppendWhere("f.cd_filial > 0")
End If

If ls_UF<>'TD' Then
	This.Of_AppendWhere("cid.cd_unidade_federacao='"+ls_UF+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF : '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+ls_UF+')'
End If

If ls_Rede<>'TD' Then
	This.Of_AppendWhere("f.id_rede_filial='"+ls_Rede+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Rede: '+dw_1.Describe("Evaluate('LookUpDisplay(id_rede)',1)")
End If

If Not IsNull(ll_Cidade) and (ll_Cidade > 0) Then
	This.Of_AppendWhere("cid.cd_cidade="+String(ll_Cidade))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Cidade: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_cidade)',1)")
End If

If Not IsNull(ll_Regiao) and (ll_Regiao > 0) Then
	This.Of_AppendWhere("f.cd_regiao="+String(ll_Regiao))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Regi$$HEX1$$e300$$ENDHEX$$o: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_regiao)',1)")
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge532_relatorio_frete_dinamico
integer x = 1856
integer y = 448
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge532_relatorio_frete_dinamico
integer y = 752
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge532_relatorio_frete_dinamico
integer x = 64
integer y = 568
end type

