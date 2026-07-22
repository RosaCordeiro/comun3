HA$PBExportHeader$w_ge196_selecao_receita_recarga.srw
forward
global type w_ge196_selecao_receita_recarga from dc_w_selecao_generica
end type
end forward

global type w_ge196_selecao_receita_recarga from dc_w_selecao_generica
integer width = 2793
string title = "GE196 - Sele$$HEX2$$e700e300$$ENDHEX$$o Receita Recarga Celular"
end type
global w_ge196_selecao_receita_recarga w_ge196_selecao_receita_recarga

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_operadora" )			

ldwc_Child.SetItem(1, "cd_operadora", 0)
ldwc_Child.SetItem(1, "nm_operadora", "TODAS")
end subroutine

on w_ge196_selecao_receita_recarga.create
call super::create
end on

on w_ge196_selecao_receita_recarga.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;wf_insere_padrao()

dw_1.Object.cd_operadora [1] = Message.DoubleParm		

dw_2.Post Event ue_retrieve()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge196_selecao_receita_recarga
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge196_selecao_receita_recarga
integer y = 216
integer width = 2715
integer height = 1060
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge196_selecao_receita_recarga
integer width = 2290
integer height = 188
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge196_selecao_receita_recarga
integer width = 2235
integer height = 76
string dataobject = "dw_ge196_selecao_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Post Event ue_Retrieve()
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge196_selecao_receita_recarga
integer y = 288
integer width = 2633
integer height = 960
string dataobject = "dw_ge196_lista_selecao"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Operadora

Date lvdt_Vigente

dw_1.AcceptText( )
lvl_Operadora	= dw_1.Object.cd_operadora	[1]
lvdt_Vigente		= dw_1.Object.dt_vigente		[1]

If Not IsNull(lvl_Operadora) and (lvl_Operadora > 0) Then
	This.Of_AppendWhere_Subquery('r.cd_operadora='+String(lvl_Operadora),2)
End If 

If Not IsNull(lvdt_Vigente) and (lvdt_Vigente > Date('2011/01/01')) Then
	This.Of_AppendWhere_Subquery("r.dh_inicio<='"+String(lvdt_Vigente,'YYYY.MM.DD')+"'",2)
	This.Of_AppendWhere_Subquery("not exists (select 1 from recarga_receita r1 where r1.cd_operadora=r.cd_operadora and r1.dh_inicio > r.dh_inicio and r1.dh_inicio<='"+String(lvdt_Vigente,'YYYY.MM.DD')+"')",2)
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge196_selecao_receita_recarga
integer x = 1993
end type

event cb_selecionar::clicked;//override
Long lvl_Linha

Datetime lvdh_Inicio

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then 
	lvdh_Inicio = dw_2.Object.dh_inicio [lvl_Linha]
	
	CloseWithReturn(Parent,String(lvdh_Inicio,'YYYY/MM/DD'))
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um registro para confirmar!')
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge196_selecao_receita_recarga
integer x = 2382
end type

event cb_cancelar::clicked;//override
CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge196_selecao_receita_recarga
integer x = 1550
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge196_selecao_receita_recarga
integer width = 1486
integer height = 80
end type

