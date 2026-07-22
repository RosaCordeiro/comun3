HA$PBExportHeader$w_ge566_consulta_servico.srw
forward
global type w_ge566_consulta_servico from dc_w_selecao_lista_relatorio
end type
type selecionar from commandbutton within w_ge566_consulta_servico
end type
type cancelar from commandbutton within w_ge566_consulta_servico
end type
type cb_1 from commandbutton within w_ge566_consulta_servico
end type
type dw_4 from dc_uo_dw_base within w_ge566_consulta_servico
end type
end forward

global type w_ge566_consulta_servico from dc_w_selecao_lista_relatorio
integer width = 1989
integer height = 1364
string title = "GE566 - Consulta de Servi$$HEX1$$e700$$ENDHEX$$os"
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
selecionar selecionar
cancelar cancelar
cb_1 cb_1
dw_4 dw_4
end type
global w_ge566_consulta_servico w_ge566_consulta_servico

type variables
Boolean ivb_Check

uo_produto ivo_produto

String ivs_Servicos
end variables

on w_ge566_consulta_servico.create
int iCurrent
call super::create
this.selecionar=create selecionar
this.cancelar=create cancelar
this.cb_1=create cb_1
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.selecionar
this.Control[iCurrent+2]=this.cancelar
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_4
end on

on w_ge566_consulta_servico.destroy
call super::destroy
destroy(this.selecionar)
destroy(this.cancelar)
destroy(this.cb_1)
destroy(this.dw_4)
end on

event close;call super::close;Destroy(ivo_Produto)
end event

event open;call super::open;ivo_Produto  = Create uo_Produto

wf_centraliza_janela()
end event

event ue_postopen;//OverRide
If dw_1.RowCount()=0 Then dw_1.Event ue_AddRow()

dw_2.Event ue_Retrieve()
dw_4.Event ue_Retrieve()

end event

event ue_preopen;//OverRide
//N$$HEX1$$e300$$ENDHEX$$o solicitar seguran$$HEX1$$e700$$ENDHEX$$a de acesso.
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge566_consulta_servico
integer x = 155
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge566_consulta_servico
integer x = 27
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge566_consulta_servico
integer y = 256
integer width = 1938
integer height = 900
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge566_consulta_servico
integer width = 1920
integer height = 224
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge566_consulta_servico
integer width = 1851
integer height = 108
string dataobject = "dw_ge566_selecao_servico"
end type

event dw_1::ue_key;call super::ue_key;dw_1.AcceptText()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				
				Long ll_Find

				ll_Find = dw_4.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, dw_4.RowCount())
				

				If ll_Find < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da wf_produto_servico.", StopSign!)
				End If
				
				If ll_Find = 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esse produto n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ considerado um servi$$HEX1$$e700$$ENDHEX$$o.", Exclamation!)
				Else
					This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
					This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
					dw_2.Event ue_Retrieve()
				End If
				
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_1.accepttext()
dw_2.event ue_reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
End Choose

end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge566_consulta_servico
integer x = 73
integer y = 308
integer width = 1861
integer height = 812
string dataobject = "dw_ge566_lista_servico"
end type

event dw_2::doubleclicked;call super::doubleclicked;If dwo.Name = 'st_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For lvl_Row = 1 To This.RowCount()				
		This.Object.Id_Selecionado[lvl_Row] = lvs_Marcacao		
	Next
End If
end event

event dw_2::ue_recuperar;//OVERRIDE

Long ll_Servico

ll_Servico = dw_1.Object.Cd_Produto[1]

If ll_Servico <> 0 Or not isNull(ll_Servico) Then
	dw_2.of_appendwhere("pg.cd_produto = " + String(ll_Servico))
End If

return dw_2.retrieve()
end event

event dw_2::ue_postretrieve;//OverRide

Return pl_Linhas
end event

event dw_2::ue_reset;//OverRide

This.Reset()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge566_consulta_servico
integer x = 2295
integer y = 1184
integer width = 274
integer height = 204
end type

type selecionar from commandbutton within w_ge566_consulta_servico
integer x = 1147
integer y = 1180
integer width = 370
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Selecionar"
end type

event clicked;Long lvl_Servicos, lvl_Linha, lvl_Contador

lvl_Servicos = dw_2.GetItemNumber(dw_2.RowCount(), "servico_total")
	
If lvl_Servicos > 0 Then
		
		For lvl_Linha = 1 To dw_2.RowCount()
			
			If dw_2.Object.id_selecionado[lvl_Linha] = 'S' Then
				
				lvl_Contador ++
	
				If lvl_Contador = 1 Then
					ivs_Servicos =  String(dw_2.Object.cd_produto[lvl_Linha])
				Else
					ivs_Servicos += ", " + String(dw_2.Object.cd_produto[lvl_Linha])
				End If
				
			End If
			
		Next
				
		CloseWithReturn ( Parent,ivs_Servicos)
		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um servi$$HEX1$$e700$$ENDHEX$$o.")
End If
end event

type cancelar from commandbutton within w_ge566_consulta_servico
integer x = 1573
integer y = 1180
integer width = 370
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;CloseWithReturn ( Parent, '')
end event

type cb_1 from commandbutton within w_ge566_consulta_servico
integer x = 722
integer y = 1180
integer width = 370
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Pesquisar"
end type

event clicked;dw_2.Event ue_Retrieve()
dw_3.Event ue_Retrieve()
end event

type dw_4 from dc_uo_dw_base within w_ge566_consulta_servico
boolean visible = false
integer x = 389
integer y = 572
integer width = 1070
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge566_lista_servico"
end type

