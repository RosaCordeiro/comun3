HA$PBExportHeader$w_ge044_selecao_filiais.srw
forward
global type w_ge044_selecao_filiais from dc_w_response_ok_cancela
end type
type st_confirmar from statictext within w_ge044_selecao_filiais
end type
type gb_2 from groupbox within w_ge044_selecao_filiais
end type
type dw_2 from dc_uo_dw_base within w_ge044_selecao_filiais
end type
end forward

global type w_ge044_selecao_filiais from dc_w_response_ok_cancela
integer x = 987
integer y = 288
integer width = 1701
integer height = 1908
string title = "GE044 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Filiais"
long backcolor = 80269524
st_confirmar st_confirmar
gb_2 gb_2
dw_2 dw_2
end type
global w_ge044_selecao_filiais w_ge044_selecao_filiais

type variables
uo_selecao_filiais ivo_Filial 

boolean ivb_check
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child

If dw_2.GetChild("id_tipo", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"vl_parametro","TD")
	ldw_Child.SetItem(1,"rede","TODOS")
	
	dw_2.Object.id_tipo[1] = "TD"
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' no filtro 'Rede Filial'.", StopSign!)
End If

end subroutine

on w_ge044_selecao_filiais.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
this.gb_2=create gb_2
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.dw_2
end on

on w_ge044_selecao_filiais.destroy
call super::destroy
destroy(this.st_confirmar)
destroy(this.gb_2)
destroy(this.dw_2)
end on

event open;call super::open;ivo_Filial = Create uo_Selecao_Filiais

ivo_Filial = Message.PowerObjectParm

end event

event ue_postopen;call super::ue_postopen;//OverRide

dw_2.Event ue_AddRow()

dw_1.Event ue_Retrieve()
dw_1.SetFocus()

wf_insere_padrao()
end event

event mousemove;If xpos > 0 and ypos > 0 Then
	st_confirmar.Visible = False
End If
end event

event ue_preopen;st_confirmar.Visible = False
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge044_selecao_filiais
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge044_selecao_filiais
integer x = 27
integer y = 200
integer width = 1623
integer height = 1480
long backcolor = 80269524
string text = "Lista"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge044_selecao_filiais
event ue_mousemove pbm_mousemove
integer x = 59
integer y = 280
integer width = 1568
integer height = 1376
integer taborder = 50
string dataobject = "dw_ge044_lista_filiais_regiao"
boolean vscrollbar = true
end type

event dw_1::ue_mousemove;If This.RowCount() > 0 Then
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

event dw_1::ue_postretrieve;If pl_Linhas > 0 Then
	
	Integer lvi_Row, &
	        lvi_Linhas, &
			  lvi_Filial, &
			  lvi_Find
	
	If Not IsNull(ivo_Filial) Then
		lvi_Linhas = UpperBound(ivo_Filial.Cd_Filial)
	End If
	
	If lvi_Linhas = 0 Then
	
		For lvi_Row = 1 To pl_Linhas
			
			This.Object.Id_Imprimir[lvi_Row] = "S"
			ivb_Check = True
			
		Next
	Else
		For lvi_Row = 1 To lvi_Linhas
	
			lvi_Filial = ivo_Filial.Cd_Filial[lvi_Row]
			
			lvi_Find = This.Find("cd_filial = " + String(lvi_Filial), 1, This.RowCount())
			
			If lvi_Find > 0 Then
				This.Object.Id_Imprimir[lvi_Find] = "S"
			End If
			
		Next
	End If
	This.Event ue_Pos(1, "id_imprimir")
End If

Return pl_Linhas
end event

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_1::doubleclicked;Integer lvi_Row, &
		lvi_Regiao
		  
String lvs_Marcacao,&
	   lvs_Nulo 

SetNull(lvs_Nulo)
	
Choose Case dwo.Name 
	Case "regiao"
		
		dw_2.Object.id_tipo[1] = lvs_Nulo
	
		For lvi_Row = 1 To This.RowCount()
			This.Object.Id_Imprimir[lvi_Row] = 'N'
		Next
			
		lvi_Regiao = This.Object.Cd_Regiao[This.GetRow()]
		
		For lvi_Row = 1 To This.RowCount()		
			If This.Object.Cd_Regiao[lvi_Row]   = lvi_Regiao Then
				This.Object.Id_Imprimir[lvi_Row] = 'S'
			End If		
		Next
		
	Case 'id_selecionar'
	
		If ivb_Check Then
			lvs_Marcacao = 'N'
			ivb_Check = False
			dw_2.Object.id_tipo[1] = 'NH'
		Else
			lvs_Marcacao = 'S'
			ivb_Check = True
			dw_2.Object.id_tipo[1] = 'TD'
		End If
		
		For lvi_Row = 1 To This.RowCount()
					
			This.Object.Id_Imprimir[lvi_Row] = lvs_Marcacao
			
		Next
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;String lvs_Nulo

SetNull(lvs_Nulo)

If dwo.Name = 'id_imprimir' Then
	dw_2.Object.id_tipo[1] = lvs_Nulo
End If
end event

event dw_1::ue_preretrieve;call super::ue_preretrieve;// Lista sem ser agrupada por regi$$HEX1$$e300$$ENDHEX$$o
If Not ivo_Filial.ivb_Lista_Regiao  Then
	If Not dw_2.of_ChangeDataobject("dw_ge044_lista_filiais") Then
		Return -1
	End If
End If

Return 1

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge044_selecao_filiais
integer x = 997
integer y = 1696
integer taborder = 30
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Integer lvi_Row, &
        lvi_Cont = 1

Destroy(ivo_Filial)
ivo_Filial = Create uo_Selecao_Filiais

For lvi_Row = 1 To dw_1.RowCount()
	
	If dw_1.Object.Id_Imprimir[lvi_Row] = "S" Then
		
		ivo_Filial.Cd_Filial[lvi_Cont]   = dw_1.Object.Cd_Filial[lvi_Row]
		ivo_Filial.Nm_Fantasia[lvi_Cont] = dw_1.Object.Nm_Fantasia[lvi_Row]
		
		lvi_Cont ++
	End If	
Next

CloseWithReturn(Parent, ivo_Filial)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge044_selecao_filiais
integer x = 1339
integer y = 1696
integer taborder = 40
end type

event cb_cancelar::clicked;CloseWithReturn(Parent, ivo_Filial)
end event

type st_confirmar from statictext within w_ge044_selecao_filiais
integer x = 672
integer y = 240
integer width = 933
integer height = 48
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
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_ge044_selecao_filiais
integer x = 27
integer width = 1362
integer height = 184
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within w_ge044_selecao_filiais
integer x = 50
integer y = 60
integer width = 1317
integer height = 92
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge044_lista_tipo"
end type

event itemchanged;call super::itemchanged;Integer lvi_Linhas,&
		lvi_Linha
		
String lvs_Tipo,&
	   lvs_Imprimir
	   
lvi_Linhas = dw_1.RowCount()

For lvi_Linha = 1 To lvi_Linhas
	
	lvs_Tipo = dw_1.Object.vl_parametro[lvi_Linha]
	
	If Data <> 'TD' Then
		If Data = lvs_Tipo Then
			lvs_Imprimir = 'S'
		Else
			lvs_Imprimir = 'N'
		End If
	Else
		lvs_Imprimir = 'S'
	End If
	
	dw_1.Object.id_imprimir[lvi_Linha] = lvs_Imprimir
Next


		

end event

