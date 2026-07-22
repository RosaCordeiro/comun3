HA$PBExportHeader$w_lista_distribuidora.srw
forward
global type w_lista_distribuidora from dc_w_response_ok_cancela
end type
type st_confirmar from statictext within w_lista_distribuidora
end type
end forward

global type w_lista_distribuidora from dc_w_response_ok_cancela
integer width = 1787
integer height = 1508
string title = "GE244 - Distribuidoras"
st_confirmar st_confirmar
end type
global w_lista_distribuidora w_lista_distribuidora

type variables
String ivs_Distribuidoras

boolean ivb_Check
end variables

on w_lista_distribuidora.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
end on

on w_lista_distribuidora.destroy
call super::destroy
destroy(this.st_confirmar)
end on

event open;call super::open;ivs_Distribuidoras = ""

dw_1.Event ue_Recuperar()
end event

event ue_postopen;//OverRide

ivo_dbError = Create dc_uo_dbError
dw_1.SetFocus()
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_lista_distribuidora
integer width = 1728
integer height = 1288
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_lista_distribuidora
event ue_mousemove pbm_mousemove
integer width = 1678
integer height = 1212
string dataobject = "dw_ge244_lista_distribuidoras"
boolean vscrollbar = true
end type

event dw_1::ue_mousemove;
If This.RowCount() > 0 Then
	
	If (((xpos >= Long(dw_1.Object.id_imagem.X)) and (xpos < Long(dw_1.Object.id_imagem.x) + Long(dw_1.Object.id_imagem.Width))) and &
		  ((ypos >= Long(dw_1.Object.id_imagem.Y)) and (ypos <= Long(dw_1.Object.id_imagem.Y) + Long(dw_1.Object.id_imagem.Height)))) Then	 
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
	
End If
end event

event dw_1::clicked;call super::clicked;// OverRide
If dwo.name = 'id_imagem' Then Return

If Row > 0 Then This.SetRow(Row)

String lvs_titulo
String lvs_coluna
String lvs_sort_atual
String lvs_Cabecalho

Integer lvi_tamanho

If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then

	lvs_titulo 		= This.GetObjectAtPointer()
	lvs_Cabecalho  = This.GetBandAtPointer()
		
	If LeftA(lvs_Cabecalho, 6) = "header" Then
		
		lvi_tamanho = PosA(lvs_titulo,CharA(9))-1
		
		If lvi_tamanho > 0 Then
			
			lvs_titulo = LeftA(lvs_titulo, lvi_tamanho)
			
			This.of_Marca_Coluna_Ativa_Ordenacao(lvs_titulo)
			
			lvs_Coluna = LeftA(lvs_Titulo,lvi_Tamanho -2 )
					
			lvs_sort_atual = This.Object.DataWindow.Table.Sort
			
			lvi_tamanho 	= LenA(lvs_sort_atual) - 2
			lvs_titulo  	= LeftA(lvs_sort_atual, lvi_tamanho)
			
			If lvs_coluna = lvs_titulo Then
				
				lvs_sort_atual = RightA(lvs_sort_atual, 1)
				
				If lvs_sort_atual = "A" Then
					lvs_sort_atual = " D"
				Else
					lvs_sort_atual = " A"
				End If
				
				lvs_coluna = lvs_coluna + lvs_sort_atual
			Else
				lvs_coluna += " A"				
			End If
			
			This.SetSort(lvs_coluna)
			This.Sort()
			This.GroupCalc()
		End If	
		
	End If
	
End If	
end event

event dw_1::doubleclicked;call super::doubleclicked;String  lvs_Marcacao

Integer lvi_Row
		  
If dwo.Name = "id_imagem" Then
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check 	 = False
		st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
	Else
		lvs_Marcacao = 'S'
		ivb_Check 	 = True
		st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
	End If
	
	For lvi_Row = 1 To dw_1.RowCount()
		dw_1.Object.id_selecionar [lvi_Row] = lvs_Marcacao
	Next
	
End If


end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_lista_distribuidora
integer x = 1097
integer y = 1312
end type

event cb_ok::clicked;call super::clicked;Long lvl_Linha
String lvs_Distribuidoras = ""

For lvl_Linha = 1 To dw_1.RowCount()
			
	If dw_1.Object.id_selecionar[lvl_Linha] = 'S' Then
		
		If lvs_Distribuidoras = "" Then
			lvs_Distribuidoras = "'"+dw_1.Object.cd_fornecedor	[lvl_Linha]+"'"
		Else
			lvs_Distribuidoras += ", '"+dw_1.Object.cd_fornecedor	[lvl_Linha]+"'"
		End If
		
	End If
	
Next

If lvs_Distribuidoras = "" Then 
	Messagebox("Aviso", "Selecione pelo menos uma distribuidora.")
	Return
End If

CloseWithReturn(Parent, lvs_Distribuidoras)

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_lista_distribuidora
integer x = 1431
integer y = 1312
end type

event cb_cancelar::clicked;
SetNull(ivs_Distribuidoras)
CloseWithReturn(Parent, ivs_Distribuidoras)

end event

type st_confirmar from statictext within w_lista_distribuidora
integer x = 654
integer y = 16
integer width = 992
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
boolean focusrectangle = false
end type

