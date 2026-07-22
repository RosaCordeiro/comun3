HA$PBExportHeader$w_ge611_motivo_bloqueio_dist.srw
forward
global type w_ge611_motivo_bloqueio_dist from dc_w_cadastro_lista
end type
end forward

global type w_ge611_motivo_bloqueio_dist from dc_w_cadastro_lista
string tag = "w_ge611_motivo_bloqueio_dist"
integer width = 2103
integer height = 2064
string title = "GE611 - Motivos Bloqueio Produtos Distribuidora"
end type
global w_ge611_motivo_bloqueio_dist w_ge611_motivo_bloqueio_dist

type variables
uo_fornecedor ivo_fornecedor

Long il_Codigo_Del[]

String is_Descricao_Del[]
end variables

forward prototypes
public function integer wf_ultimo_codigo ()
end prototypes

public function integer wf_ultimo_codigo ();Integer lvi_Ultimo

Select Max(cd_motivo_bloqueio) 
into :lvi_Ultimo
from motivo_bloqueio_distrib_prd
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("localiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$fa00$$ENDHEX$$ltimo c$$HEX1$$f300$$ENDHEX$$digo do motivo")
		Return -1
	Case 0
	
		If IsNull(lvi_Ultimo) Then
			
			lvi_Ultimo = 0 		
		End If	
End Choose

Return lvi_Ultimo
end function

on w_ge611_motivo_bloqueio_dist.create
call super::create
end on

on w_ge611_motivo_bloqueio_dist.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Retrieve()
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge611_motivo_bloqueio_dist
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge611_motivo_bloqueio_dist
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge611_motivo_bloqueio_dist
integer x = 41
integer y = 52
integer width = 1970
integer height = 1784
string dataobject = "dw_ge611_motivo_bloqueio_dist"
end type

event dw_1::ue_preupdate;call super::ue_preupdate;Integer lvi_Proximo_Codigo

Long  lvl_Linha, &
      lvl_Total, &
		ll_Linha, &
		ll_Controle_upd, &
		ll_Controle_del		,&
		ll_Codigo_Linha

String ls_valor_antigo, &
		ls_valor_atual, &
		ls_log, &
		ls_Nulo

SetNull(ls_Nulo)

// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de linhas da DW
lvl_Total = This.RowCount()

// Localiza a primeira linha sem c$$HEX1$$f300$$ENDHEX$$digo
lvl_Linha = This.Find("isnull(cd_motivo_bloqueio)", 0, lvl_Total)

lvi_Proximo_Codigo = wf_Ultimo_Codigo()

If lvi_Proximo_Codigo = -1 Then Return -1
	
// Executa enquanto existirem linhas sem c$$HEX1$$f300$$ENDHEX$$digo
Do While lvl_Linha > 0
	lvi_Proximo_Codigo ++
	
	If isnull(This.Object.id_situacao[lvl_Linha]) Then 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Situa$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ Obrigat$$HEX1$$f300$$ENDHEX$$ria!')
		Return -1
	End If
	
	// Atualiza a DW com o c$$HEX1$$f300$$ENDHEX$$digo sequencial
	This.Object.cd_motivo_bloqueio[lvl_Linha] = lvi_Proximo_Codigo
	
	lvl_Linha = This.Find("isnull(cd_motivo_bloqueio)", lvl_Linha, lvl_Total)

Loop

ll_Controle_upd = This.ModifiedCount()
ll_Controle_del = This.DeletedCount()

Do While ll_Controle_upd > 0
	For ll_linha = (This.GetNextModified (0, Primary!)) To This.rowcount()
		If This.GetItemStatus (ll_linha, 0, Primary!) = DataModified! Then
			ll_Codigo_Linha = This.object.cd_motivo_bloqueio[ll_linha]
			ls_valor_antigo = This.GetItemString (ll_linha, 'de_motivo_bloqueio', Primary!, True)
			ls_valor_atual = This.GetItemString (ll_linha, 'de_motivo_bloqueio', Primary!, False)
			
			If ls_valor_antigo <> ls_valor_atual Then
				If Not gf_Grava_Historico_Alteracao_Tabela ('MOTIVO_BLOQUEIO_DISTRIB_PRD', 'CD_MOTIVO: '+String (ll_Codigo_Linha), 'DE_MOTIVO_BLOQUEIO', ls_valor_antigo, ls_valor_atual, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'A', Ref ls_log, True) then
					Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o. '+ls_log)
					Return -1
				End if
			End If			
		End If
		
		ll_Controle_upd --
		If ll_Controle_upd = 0 Then Exit
	Next
Loop

Do While ll_Controle_del > 0
	If Not gf_Grava_Historico_Alteracao_Tabela ('MOTIVO_BLOQUEIO_DISTRIB_PRD', 'CD_MOTIVO: '+String (il_Codigo_Del[ll_Controle_del]), 'DE_MOTIVO_BLOQUEIO', is_Descricao_Del[ll_Controle_del], ls_valor_atual, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'E', Ref ls_log, True) then
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o (exclus$$HEX1$$e300$$ENDHEX$$o). '+ls_log)
		Return -1
	End if
	ll_Controle_del --
Loop

Return 1
end event

event dw_1::ue_predeleterow;call super::ue_predeleterow;Long ll_Linha

ll_Linha = this.getrow( )

If UpperBound(il_Codigo_Del[]) = 0 And UpperBound(is_Descricao_Del[]) = 0 Then
	il_Codigo_Del[1] = this.object.cd_motivo_bloqueio[ll_Linha]
	is_Descricao_Del[1] = this.object.de_motivo_bloqueio[ll_Linha]
Else
	il_Codigo_Del[UpperBound(il_Codigo_Del[])+1] = this.object.cd_motivo_bloqueio[ll_Linha]
	is_Descricao_Del[UpperBound(is_Descricao_Del[])+1] = this.object.de_motivo_bloqueio[ll_Linha]
End If

Return true
end event

event dw_1::ue_cancel;call super::ue_cancel;Long ll_null[]
String ls_null[]

il_Codigo_Del = ll_null[]
is_Descricao_Del = ls_null[]
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge611_motivo_bloqueio_dist
integer x = 9
integer y = 0
integer width = 2016
integer height = 1852
end type

