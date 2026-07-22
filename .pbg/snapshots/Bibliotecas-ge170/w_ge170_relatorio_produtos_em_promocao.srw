HA$PBExportHeader$w_ge170_relatorio_produtos_em_promocao.srw
forward
global type w_ge170_relatorio_produtos_em_promocao from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge170_relatorio_produtos_em_promocao from dc_w_selecao_lista_relatorio
string tag = "w_ge170_relatorio_produtos_em_promocao"
integer width = 3401
integer height = 2048
string title = "GE170 - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos em Promo$$HEX2$$e700e300$$ENDHEX$$o"
boolean resizable = false
end type
global w_ge170_relatorio_produtos_em_promocao w_ge170_relatorio_produtos_em_promocao

type variables

end variables

on w_ge170_relatorio_produtos_em_promocao.create
call super::create
end on

on w_ge170_relatorio_produtos_em_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DataWindowChild lvdwc

Integer 	lvi_Retorno,&
        		lvi_Row

If dw_1.GetChild("cd_grupo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_grupo", "0")
	lvdwc.SetItem(1, "de_grupo",   "TODOS")
	
	dw_1.Object.Cd_Grupo[1] = "0"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do grupo.")
End If
end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge170_relatorio_produtos_em_promocao
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge170_relatorio_produtos_em_promocao
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge170_relatorio_produtos_em_promocao
integer y = 272
integer width = 3323
integer height = 1596
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge170_relatorio_produtos_em_promocao
integer width = 2437
integer height = 236
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge170_relatorio_produtos_em_promocao
integer x = 64
integer y = 76
integer width = 2400
integer height = 168
string dataobject = "dw_ge170_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge170_relatorio_produtos_em_promocao
integer y = 316
integer width = 3282
integer height = 1532
string dataobject = "dw_ge170_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Decimal 	lvdc_pc_desconto_inicial 	, &
			lvdc_pc_desconto_final

String lvs_cd_grupo	
String lvs_id_situacao				

dw_1.AcceptText()

lvdc_pc_desconto_inicial = dw_1.Object.pc_desconto_inicial[1]
lvdc_pc_desconto_final   = dw_1.Object.pc_desconto_final  [1]
lvs_cd_grupo      		 	= dw_1.Object.cd_grupo	          	[1]
lvs_id_situacao	  		 	= dw_1.Object.id_situacao        	[1]

If Not IsNull(lvdc_pc_desconto_inicial) Then
	This.of_appendWhere("g.pc_desconto_atual >= " + &
	                    gf_valor_com_ponto(lvdc_pc_desconto_inicial))
End If

If Not IsNull(lvdc_pc_desconto_final) Then
	This.of_appendWhere("g.pc_desconto_atual <= " + &
	                    gf_valor_com_ponto(lvdc_pc_desconto_final))
End If

This.of_appendWhere("g.pc_desconto_atual <> 0 ")
	                    
If (lvs_cd_grupo <> "0") Then
	This.of_appendWhere("cp.cd_grupo = '" + lvs_cd_grupo +"'")
End If

If lvs_id_situacao = "A" Then
	This.of_appendWhere("g.id_situacao = 'A'"	) 
Else
	This.of_appendWhere("g.id_situacao in ('A','P','I')")	
End If

Return 1

end event

event dw_2::ue_recuperar;call super::ue_recuperar;This.ivm_Menu.ivb_Permite_Imprimir = True

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	ivm_Menu.mf_salvarcomo( True )
Else 
	ivm_Menu.mf_salvarcomo( False )
End If
	
Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge170_relatorio_produtos_em_promocao
integer x = 2793
integer y = 932
string dataobject = "dw_ge170_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;dw_1.AcceptText()

String ls_Grupo
String ls_Descricao
String ls_desconto_inicial
String ls_desconto_final
String ls_Situacao

ls_Grupo 		     = String( dw_1.Object.Cd_Grupo[1] )
ls_desconto_inicial = String( dw_1.Object.pc_desconto_inicial[1]) 
ls_desconto_final   = String( dw_1.Object.pc_desconto_final[1]) 
ls_situacao		     = String( dw_1.Object.id_situacao[1])

If IsNull(ls_Desconto_Inicial)	Then	ls_Desconto_Inicial	= "0,00"
If IsNull(ls_Desconto_Final)	Then	ls_Desconto_Final		= "0,00"

If ls_Situacao = "A" Then
	ls_Situacao	= "ATIVO"
Else
	ls_Situacao = "TODOS"
End If

If ls_Grupo = '0' Then
	ls_Descricao = 'TODOS'
Else
	
	Select de_grupo
		Into :ls_Descricao
	 From grupo
	Where cd_grupo = :ls_Grupo
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError()
			Return -1
			
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum grupo de produto encontrado com c$$HEX1$$f300$$ENDHEX$$digo " + ls_Grupo + ".")
			Return -1
			
	End Choose
End If

This.Object.st_Grupo.Text		= ls_Descricao + " (" + ls_Grupo + ")"
This.Object.st_Situacao.Text	= ls_Situacao
This.Object.st_Desconto.Text	= ls_Desconto_Inicial + "% at$$HEX1$$e900$$ENDHEX$$ " + ls_Desconto_Final + "%"

Return AncestorReturnValue
end event

event dw_3::ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

