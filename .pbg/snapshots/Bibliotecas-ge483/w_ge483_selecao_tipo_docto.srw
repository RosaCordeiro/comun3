HA$PBExportHeader$w_ge483_selecao_tipo_docto.srw
forward
global type w_ge483_selecao_tipo_docto from dc_w_selecao_generica
end type
type st_confirmar from statictext within w_ge483_selecao_tipo_docto
end type
end forward

global type w_ge483_selecao_tipo_docto from dc_w_selecao_generica
integer width = 2565
integer height = 1524
string title = "GE483 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tipo Documento"
st_confirmar st_confirmar
end type
global w_ge483_selecao_tipo_docto w_ge483_selecao_tipo_docto

type variables
uo_mult_tipo_docto ivo_tipo_docto
uo_mult_padrao_docto ivo_padrao_docto

Boolean ivb_Check
end variables

on w_ge483_selecao_tipo_docto.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
end on

on w_ge483_selecao_tipo_docto.destroy
call super::destroy
destroy(this.st_confirmar)
end on

event open;call super::open;String lvs_filtro

ivo_tipo_docto = Message.PowerObjectParm

lvs_filtro = Upper(ivo_tipo_docto.ivs_Parametro_Selecao)

If lvs_filtro <> "" Then
	dw_1.Object.de_filtro[1] = lvs_filtro
End If

dw_2.object.id_selecionar.visible = ivo_tipo_docto.ib_mult_selecao
dw_2.object.id_imagem.visible = ivo_tipo_docto.ib_mult_selecao

end event

event ue_preopen;call super::ue_preopen;ivo_padrao_docto = Create uo_mult_padrao_docto

end event

event close;call super::close;Destroy(ivo_padrao_docto)
end event

event ue_postopen;call super::ue_postopen;ivo_padrao_docto.of_SetTrans(ivo_tipo_docto.ivtr_Trans)
dw_2.of_SetTransObject(ivo_tipo_docto.ivtr_Trans)

If (ivo_tipo_docto.ivs_Parametro_Selecao) <> '' Then
 	dw_2.Event ue_Retrieve()
End if
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge483_selecao_tipo_docto
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge483_selecao_tipo_docto
integer y = 292
integer width = 2478
integer height = 1004
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge483_selecao_tipo_docto
integer width = 2478
integer height = 272
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge483_selecao_tipo_docto
integer width = 2395
integer height = 188
string dataobject = "dw_ge483_selecao_tipo_docto"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_padraodocto" Then
		ivo_padrao_docto.of_Localiza(This.GetText())
		
		If ivo_padrao_docto.Localizado Then
			This.Object.id_padraodocto	[1]	= ivo_padrao_docto.ID
			This.Object.de_padraodocto	[1]	= ivo_padrao_docto.Descricao
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.name = "de_padraodocto" Then
	If Trim(Data) <> "" Then
		If Data <> ivo_padrao_docto.Descricao Then
			Return 1
		End If	
	Else	
		ivo_padrao_docto.of_inicializa()
		
		This.Object.id_padraodocto	[1] = ivo_padrao_docto.ID
		This.Object.de_padraodocto	[1] = ivo_padrao_docto.Descricao
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_padrao_docto) Then
	This.Object.de_padraodocto	[1] = ivo_padrao_docto.Descricao
End If
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge483_selecao_tipo_docto
event ue_mousemove pbm_mousemove
integer y = 364
integer width = 2427
integer height = 904
string dataobject = "dw_ge483_lista_tipo_docto"
end type

event dw_2::ue_mousemove;If This.RowCount() > 0 Then
	If xpos >= st_confirmar.X and (xpos <= st_confirmar.x + st_confirmar.Width) and &
		  ypos >= 0 and ypos < 40 Then	 
		
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

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Padrao

String lvs_Filtro
String lvs_Valida

dw_1.Accepttext( )

lvl_Padrao 	= dw_1.Object.id_padraodocto	[1]
lvs_Filtro		= dw_1.Object.de_filtro 			[1]

If lvl_Padrao > 0 Then
	This.of_appendwhere('idf_padraodocto='+String(lvl_Padrao))
End If

This.of_appendwhere('idf_empresa='+String(ivo_tipo_docto.idf_empresa))

If lvs_Valida = 'S' Then
	This.of_appendwhere('datvalfin >= sysdate')
End If

If Trim(lvs_Filtro)<>'' Then
	This.of_appendwhere("((upper(descricao) like '%"+lvs_Filtro+"%')"+ &
						  	  "or (upper(codtpdocto) like '%"+lvs_Filtro+"%'))")
End If

Return AncestorReturnValue
end event

event dw_2::doubleclicked;call super::doubleclicked;String lvs_Incluir_Excluir,&
	   lvs_Marcacao

Integer lvi_Row
		  
If dwo.Name = "id_imagem" Then
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check 	 = False
		// Excluir
		lvs_Incluir_Excluir = "E"
	Else
		lvs_Marcacao = 'S'
		ivb_Check 	 = True
		// Incluir
		lvs_Incluir_Excluir = "I"
	End If
	
	For lvi_Row = 1 To This.RowCount()
		This.Object.Id_selecionar[lvi_Row] = lvs_Marcacao
	Next
	
End If


end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge483_selecao_tipo_docto
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Find, lvl_Linha, lvl_Contador

If ivo_tipo_docto.ib_mult_selecao Then
	
	lvl_Find = dw_2.Find("id_selecionar='S'",1,dw_2.RowCount())
		
	If lvl_Find > 0 Then
			
			For lvl_Linha = 1 To dw_2.RowCount()
				
				If dw_2.Object.id_selecionar[lvl_Linha] = 'S' Then
					
					lvl_Contador ++
					
					ivo_tipo_docto.id = dw_2.Object.id[lvl_Linha]
					ivo_tipo_docto.codigo = dw_2.Object.codtpdocto	[lvl_Linha]
					ivo_tipo_docto.descricao = dw_2.Object.descricao	[lvl_Linha]
					
					If lvl_Contador = 1 Then
						ivo_tipo_docto.ivs_tipo_dctos  =  String(dw_2.Object.id[lvl_Linha])
					Else
						ivo_tipo_docto.ivs_tipo_dctos =  ivo_tipo_docto.ivs_tipo_dctos + ", " + String(dw_2.Object.id[lvl_Linha])
					End If
					
				End If
				
			Next
			
			If lvl_Contador = dw_2.RowCount() Then
				ivo_tipo_docto.ib_todos_tipo_dctos  = True
			Else
				ivo_tipo_docto.ib_todos_tipo_dctos = False
			End If
					
			CloseWithReturn ( Parent, Double(lvl_Contador) )
			
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Tipo de Documento.", Information!)
		dw_2.SetFocus()
	End If
Else
	lvl_Linha = dw_2.GetRow()

	If lvl_Linha > 0 Then
		CloseWithReturn(Parent, String(dw_2.Object.id [lvl_Linha]))
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Tipo de Documento.", Information!)
		dw_2.SetFocus()
	End If
	
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge483_selecao_tipo_docto
integer x = 2126
end type

event cb_cancelar::clicked;call super::clicked;Close(Parent)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge483_selecao_tipo_docto
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge483_selecao_tipo_docto
end type

type st_confirmar from statictext within w_ge483_selecao_tipo_docto
boolean visible = false
integer x = 1618
integer y = 292
integer width = 855
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

