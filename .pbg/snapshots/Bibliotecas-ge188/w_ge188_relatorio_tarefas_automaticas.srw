HA$PBExportHeader$w_ge188_relatorio_tarefas_automaticas.srw
forward
global type w_ge188_relatorio_tarefas_automaticas from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge188_relatorio_tarefas_automaticas from dc_w_selecao_lista_relatorio
integer width = 5381
integer height = 1352
string title = "GE188 - Relat$$HEX1$$f300$$ENDHEX$$rio Status das Tarefas Autom$$HEX1$$e100$$ENDHEX$$ticas"
boolean resizable = false
event ue_timer pbm_timer
end type
global w_ge188_relatorio_tarefas_automaticas w_ge188_relatorio_tarefas_automaticas

type variables
uo_tarefa	ivo_tarefa
uo_sistema	ivo_sistema
end variables

event ue_timer;dw_2.Event ue_Retrieve()
end event

on w_ge188_relatorio_tarefas_automaticas.create
call super::create
end on

on w_ge188_relatorio_tarefas_automaticas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;MaxHeight = 9999
MaxHeight = 5500

ivo_tarefa	= Create uo_tarefa
ivo_sistema	= Create uo_sistema
end event

event close;call super::close;Destroy(ivo_tarefa)
Destroy(ivo_sistema)
end event

event ue_postopen;call super::ue_postopen;ivm_menu.ivb_permite_imprimir = True

If gvo_aplicacao.ivb_usa_aux_visual Then
	dw_1.Object.id_atrasado [1] = 'S'
	
	dw_2.Event ue_Retrieve()
End If
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge188_relatorio_tarefas_automaticas
integer x = 311
integer y = 2400
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge188_relatorio_tarefas_automaticas
integer x = 274
integer y = 2328
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge188_relatorio_tarefas_automaticas
integer width = 5303
integer height = 780
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge188_relatorio_tarefas_automaticas
integer width = 2825
integer height = 348
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge188_relatorio_tarefas_automaticas
integer width = 2761
string dataobject = "dw_ge188_selecao"
end type

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_tarefa) Then
	This.Object.de_tarefa [1] = ivo_tarefa.Descricao
End If

If IsValid(ivo_sistema) Then
	This.Object.nm_sistema [1] = ivo_sistema.Descricao
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	This.AcceptText( )
	Choose Case This.GetColumnName()
		Case 'nm_sistema'
			ivo_sistema.Of_Localiza(This.GetText())
			
			This.Object.cd_sistema	[1] = ivo_sistema.Codigo
			This.Object.nm_sistema	[1] = ivo_sistema.Descricao
		Case 'de_tarefa'
			ivo_tarefa.Of_Localiza(This.GetText())
			
			This.Object.cd_tarefa	[1] = ivo_tarefa.Codigo
			This.Object.de_tarefa	[1] = ivo_tarefa.Descricao
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "nm_sistema"
		If Trim(Data) <> "" Then
			If Data <> ivo_sistema.Descricao Then
				Return 1
			End If	
		Else	
			ivo_sistema.Of_inicializa( )
			
			This.Object.Cd_Sistema	[1] = ivo_sistema.Codigo
			This.Object.Nm_Sistema	[1] = ivo_sistema.Descricao
		End If
	Case "de_tarefa"
		If Trim(Data) <> "" Then
			If Data <> ivo_tarefa.Descricao Then
				Return 1
			End If	
		Else	
			ivo_tarefa.Of_inicializa( )
			
			This.Object.Cd_Tarefa	[1] = ivo_tarefa.Codigo
			This.Object.De_Tarefa	[1] = ivo_tarefa.Descricao
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge188_relatorio_tarefas_automaticas
event ue_timer pbm_timer
integer x = 64
integer y = 460
integer width = 5266
integer height = 688
string dataobject = "dw_ge188_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::constructor;call super::constructor;This.of_setrowselection("~tIf(getrow()= currentRow(),rgb(0,128,128),If(  Today() > dh_limite  , rgb(255,0,0),rgb(255,255,255)))", "~tIf(getrow()= currentRow(),rgb(255,255,255),rgb(0,0,0))")
This.ShareData(dw_3)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Sistema
String lvs_problema
String lvs_SMS
String lvs_Email
String lvs_Situacao
String lvs_Controlada

Long lvl_Tarefa

dw_1.Accepttext( )

lvs_Sistema		= dw_1.Object.cd_sistema		[1]
lvs_problema	= dw_1.Object.id_atrasado		[1]
lvs_SMS 			= dw_1.Object.id_envia_sms	[1]
lvs_Situacao		= dw_1.Object.id_situacao		[1]
lvs_Email			= dw_1.Object.id_envia_email	[1]
lvl_Tarefa		= dw_1.Object.cd_tarefa			[1]
lvs_Controlada	= dw_1.Object.id_controlada	[1]

If (Not IsNull(lvs_Sistema)) and (Trim(lvs_Sistema)<>'') Then
	This.Of_appendwhere("cd_sistema='"+lvs_Sistema+"'")
End If

If (Not IsNull(lvl_Tarefa)) and (lvl_Tarefa>0) Then
	This.Of_appendwhere("cd_tarefa="+String(lvl_Tarefa))
End If

If lvs_Situacao<>'T' Then
	This.Of_appendwhere("id_situacao='"+lvs_Situacao+"'")
End If

If lvs_SMS = 'S' Then
	This.Of_AppendWhere("id_envia_sms='"+lvs_SMS+"'")
End If

If lvs_Email = 'S' Then
	This.Of_AppendWhere("cd_mensagem_email is not null")
End If

If lvs_Controlada = 'S' Then
	This.Of_AppendWhere("coalesce(nr_tolerancia,0)>0")
End If

If lvs_problema = 'S' Then
	This.Of_AppendWhere("coalesce(nr_tolerancia,0) > 0")
	This.Of_AppendWhere("dateadd(ss,nr_tolerancia, case when (dh_ultima_exec is not null) and (dh_ultima_exec >= coalesce(dh_prox_exec,dh_ultima_exec)) then dh_ultima_exec else coalesce(dh_prox_exec,coalesce(dh_ultima_exec,dh_cadastro)) end) < getDate()")
End If

Return AncestorReturnValue

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_SalvarComo(pl_linhas > 0)
This.ivm_menu.mf_Imprimir(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
This.ivm_menu.mf_Imprimir(False)
end event

event dw_2::ue_retrieve;call super::ue_retrieve;Timer(30)
Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge188_relatorio_tarefas_automaticas
integer x = 2853
integer y = 48
integer width = 311
string dataobject = "dw_ge188_relatorio"
string ivs_cor_linha_padrao = "If(mod(getrow(),2)=0,rgb(222,222,222),rgb(255,255,255))"
end type

event dw_3::constructor;call super::constructor;//This.Modify("DataWindow.Detail.Color= '0~tIf(mod(getrow(),2)=0,rgb(222,222,222),rgb(255,255,255))'")
end event

