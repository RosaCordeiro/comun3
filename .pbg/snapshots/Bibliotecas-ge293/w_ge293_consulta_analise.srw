HA$PBExportHeader$w_ge293_consulta_analise.srw
forward
global type w_ge293_consulta_analise from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge293_consulta_analise from dc_w_selecao_lista_relatorio
string tag = "w_ge293_consulta_analise"
integer width = 3401
integer height = 2128
string title = "GE293 - Evolu$$HEX2$$e700e300$$ENDHEX$$o Ocorr$$HEX1$$ea00$$ENDHEX$$ncias"
boolean resizable = false
end type
global w_ge293_consulta_analise w_ge293_consulta_analise

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child

Long lvl_Regiao

If dw_1.GetChild("cd_regiao", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_regiao",0)
	ldw_Child.SetItem(1,"de_regiao","TODAS")
	
	dw_1.Object.cd_regiao[1] = 0
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

select cd_regiao
Into :lvl_Regiao
From regiao
Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	dw_1.Object.cd_regiao[1] = lvl_Regiao
Else
	dw_1.Object.cd_regiao[1] = 0	
End If

// Coloca o item TODAS
If dw_1.GetChild("cd_metrica", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_metrica",0)
	ldw_Child.SetItem(1,"de_metrica","TODAS")
	ldw_Child.SetItem(1,"cd_setor","GE")
	If gvo_aplicacao.ivo_seguranca.cd_sistema <> 'DI' Then
		ldw_Child.SetFilter("cd_setor=String('GE') or cd_setor=String('"+gvo_aplicacao.ivo_seguranca.cd_sistema+"')")
		ldw_Child.Filter()
	End If
	
	dw_1.Object.cd_metrica[1] = 0
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna an$$HEX1$$e100$$ENDHEX$$lise.", StopSign!)
End If
end subroutine

on w_ge293_consulta_analise.create
call super::create
end on

on w_ge293_consulta_analise.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dh_inicio	[1] = RelativeDate(Today(),-14)
dw_1.Object.dh_fim		[1] = Today()

wf_insere_padrao()
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge293_consulta_analise
integer width = 3305
integer height = 1548
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge293_consulta_analise
integer width = 2130
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge293_consulta_analise
integer width = 2062
string dataobject = "dw_ge293_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge293_consulta_analise
integer width = 3237
integer height = 1440
string dataobject = "dwg_ge293_evolucao_regional"
end type

event dw_2::ue_recuperar;//overrride
Datetime lvdh_Inicio
Datetime lvdh_Fim

dw_1.AcceptText( )
lvdh_Inicio	= dw_1.Object.dh_inicio	[1]
lvdh_Fim		= Datetime(Date(dw_1.Object.dh_fim	[1]), Time('23:59:59'))

Return This.Retrieve(lvdh_Inicio,lvdh_Fim)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Revisao

Long lvl_Regiao
Long lvl_Metrica

dw_1.Accepttext( )
lvs_Revisao	= dw_1.Object.id_revisao	[1]
lvl_Regiao	= dw_1.Object.cd_regiao	[1]
lvl_Metrica	= dw_1.Object.cd_metrica	[1]

If lvs_Revisao <> 'T' Then
	This.of_appendwhere("a.id_revisado = '"+lvs_Revisao+"'")
End If

If lvl_Regiao > 0 Then
	This.of_appendwhere("f.cd_regiao = "+String(lvl_Regiao))
End If

If lvl_Metrica > 0 Then
	This.of_appendwhere("a.cd_metrica = "+String(lvl_Metrica))
End If

If gvo_aplicacao.ivo_seguranca.cd_sistema <> 'DI' Then
	This.of_appendwhere("((m.cd_setor = '"+gvo_aplicacao.ivo_seguranca.cd_sistema+"') or (m.cd_setor = 'GE'))")
End If

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_menu.mf_salvarcomo(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;ivm_menu.mf_salvarcomo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge293_consulta_analise
integer x = 2377
integer height = 284
end type

