HA$PBExportHeader$w_ge532_historico_alteracao_frete.srw
forward
global type w_ge532_historico_alteracao_frete from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge532_historico_alteracao_frete from dc_w_selecao_lista_relatorio
integer width = 4859
integer height = 2516
string title = "GE532 - Hist$$HEX1$$f300$$ENDHEX$$rico Altera$$HEX2$$e700e300$$ENDHEX$$o Frete"
end type
global w_ge532_historico_alteracao_frete w_ge532_historico_alteracao_frete

type variables
uo_Filial io_Filial
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

on w_ge532_historico_alteracao_frete.create
call super::create
end on

on w_ge532_historico_alteracao_frete.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio		[1] = RelativeDate(Today(),-5)
dw_1.Object.dt_termino	[1] = Today()

wf_insere_padrao()
end event

event close;call super::close;If IsValid( io_Filial ) Then Destroy io_Filial
end event

event ue_preopen;call super::ue_preopen;io_Filial = Create uo_Filial
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge532_historico_alteracao_frete
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge532_historico_alteracao_frete
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge532_historico_alteracao_frete
integer width = 4763
integer height = 1924
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge532_historico_alteracao_frete
integer width = 2871
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge532_historico_alteracao_frete
integer width = 2802
string dataobject = "dw_ge532_selecao_historico"
end type

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

event dw_1::losefocus;call super::losefocus;If IsValid(io_Filial) Then 
	This.Object.Nm_fantasia[1] = io_Filial.Nm_Fantasia
End If

end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge532_historico_alteracao_frete
integer width = 4699
integer height = 1828
string dataobject = "dw_ge532_lista_historico"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date ldt_Inicio, ldt_Termino

Long ll_Filial
Long ll_Regiao
Long ll_Cidade

String ls_Rede
String ls_UF

dw_1.Accepttext( )

ldt_Inicio		= Date(dw_1.Object.dt_Inicio			[1])
ldt_Termino	= Date(dw_1.Object.dt_termino		[1])
ll_Filial 		= dw_1.Object.cd_filial					[1]
ls_Rede		= dw_1.Object.id_rede					[1]
ll_Regiao	 	= dw_1.Object.cd_regiao				[1]
ls_UF			= dw_1.Object.cd_uf						[1]
ll_Cidade		= dw_1.Object.cd_cidade				[1]

If IsNull(ldt_Inicio) Or ( ldt_Inicio = Date( '1900/01/01')) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, 'dt_inicio')
	Return -1
End If

If IsNull(ldt_Termino) Or ( ldt_Termino = Date( '1900/01/01')) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, 'dt_termino')
	Return -1
End If

If ldt_Inicio > ldt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio $$HEX1$$e900$$ENDHEX$$ maior que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, 'dt_inicio')
	Return -1
End If

If Not IsNull(ll_Filial) and (ll_Filial > 0) Then
	This.Of_AppendWhere("h.cd_filial="+String(ll_Filial))
End If

If ls_UF<>'TD' Then
	This.Of_AppendWhere("cid.cd_unidade_federacao='"+ls_UF+"'")
End If

If ls_Rede<>'TD' Then
	This.Of_AppendWhere("f.id_rede_filial='"+ls_Rede+"'")
End If

If Not IsNull(ll_Cidade) and (ll_Cidade > 0) Then
	This.Of_AppendWhere("cid.cd_cidade="+String(ll_Cidade))
End If

If Not IsNull(ll_Regiao) and (ll_Regiao > 0) Then
	This.Of_AppendWhere("f.cd_regiao="+String(ll_Regiao))
End If

ldt_Termino = RelativeDate(ldt_Termino, +1) //Corrigir data e hora
This.Of_AppendWhere("h.dh_alteracao>='"+String(ldt_Inicio, 'yyyy/mm/dd') + "' and h.dh_alteracao<'"+String(ldt_Termino, 'yyyy/mm/dd')+"'")	

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge532_historico_alteracao_frete
integer x = 3529
integer y = 88
end type

