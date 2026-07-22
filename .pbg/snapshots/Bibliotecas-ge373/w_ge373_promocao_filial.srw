HA$PBExportHeader$w_ge373_promocao_filial.srw
forward
global type w_ge373_promocao_filial from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge373_promocao_filial
end type
type cb_selecao from commandbutton within w_ge373_promocao_filial
end type
type st_confirmar from statictext within w_ge373_promocao_filial
end type
end forward

global type w_ge373_promocao_filial from dc_w_response_ok_cancela
integer width = 1778
integer height = 1736
string title = "GE373 - Sele$$HEX2$$e700e300$$ENDHEX$$o das Filiais da Promo$$HEX2$$e700e300$$ENDHEX$$o"
long backcolor = 80269524
dw_2 dw_2
cb_selecao cb_selecao
st_confirmar st_confirmar
end type
global w_ge373_promocao_filial w_ge373_promocao_filial

type variables
long ivl_promocao

Boolean ivb_Check
end variables

forward prototypes
public subroutine wf_seleciona_filial (long al_filial, string as_selecionada)
public function boolean wf_existe_filial_selecionada ()
end prototypes

public subroutine wf_seleciona_filial (long al_filial, string as_selecionada);Long lvl_Find,&
	 lvl_Insert

lvl_Find = dw_2.Find("cd_filial =" + String(al_Filial), 1, dw_2.RowCount())

If lvl_Find = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial na promo$$HEX2$$e700e300$$ENDHEX$$o.")
End If

If lvl_Find > 0 Then
	If as_Selecionada = "S" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial j$$HEX1$$e100$$ENDHEX$$ foi inclu$$HEX1$$ed00$$ENDHEX$$da na promo$$HEX2$$e700e300$$ENDHEX$$o.") 
	Else
		// Exclui
		dw_2.DeleteRow(lvl_Find)
	End If
Else
	// Inclui
	If as_Selecionada = "S" Then
		lvl_Insert = dw_2.InsertRow(0)
		dw_2.Object.cd_promocao[lvl_Insert] = ivl_Promocao
		dw_2.Object.cd_filial  [lvl_Insert] = al_Filial
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial j$$HEX1$$e100$$ENDHEX$$ foi exclu$$HEX1$$ed00$$ENDHEX$$da da promo$$HEX2$$e700e300$$ENDHEX$$o.")
	End If
End If
end subroutine

public function boolean wf_existe_filial_selecionada ();Long lvl_Find

lvl_Find = dw_1.Find("id_filial = 'S'", 1, dw_1.RowCount())

If lvl_Find = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial selecionda.")
	Return False
End If

If lvl_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos uma filial.")
	Return False
End If

Return True

end function

on w_ge373_promocao_filial.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_selecao=create cb_selecao
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_selecao
this.Control[iCurrent+3]=this.st_confirmar
end on

on w_ge373_promocao_filial.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_selecao)
destroy(this.st_confirmar)
end on

event open;call super::open;ivl_promocao = Message.DoubleParm	
end event

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2}
This.wf_SetUpdate_DW(lvo_Update)

If Not IsNull(ivl_Promocao) and ivl_Promocao > 0 Then
	dw_1.Event ue_Retrieve()
	dw_2.Event ue_Retrieve()
End If
end event

event ue_save;call super::ue_save;If AncestorReturnValue > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Filial(is) atualiza(s) com sucesso.")	
End If

Return AncestorReturnValue
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge373_promocao_filial
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge373_promocao_filial
integer x = 27
integer width = 1710
integer height = 1504
integer weight = 700
string facename = "Verdana"
string text = "Filiais"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge373_promocao_filial
event ue_mousemove pbm_mousemove
integer width = 1659
integer height = 1404
integer taborder = 60
string dataobject = "dw_ge373_lista_filial"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::ue_mousemove;If This.RowCount() > 0 Then
	If xpos >= st_confirmar.X and (xpos <= st_confirmar.x + st_confirmar.Width) and ypos >= 10 and ypos < 100 Then	 
		
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

event dw_1::itemchanged;call super::itemchanged;String lvs_Selecionada

Long lvl_Filial

lvs_Selecionada = Data
lvl_Filial 		= dw_1.Object.cd_filial[Row]

//wf_Seleciona_Filial(lvl_Filial, lvs_Selecionada)

dw_2.Event ue_Seleciona_Filial(lvl_Filial, lvs_Selecionada)



end event

event dw_1::constructor;call super::constructor;//This.of_SetRowSelection()
end event

event dw_1::doubleclicked;call super::doubleclicked;String lvs_Marcacao
String lvs_Texto

Integer lvi_Row

Long lvl_Linha
  
If dwo.Name = "id_imagem" Then
	
	If ivb_Check Then
		lvs_Texto		= "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		ivb_Check 	 	= False
		lvs_Marcacao 	= "N"
	Else
		lvs_Texto		= "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		ivb_Check 	 	= True
		lvs_Marcacao 	= "S"
	End If
	
	For lvl_Linha = 1 To dw_1.RowCount()
		If dw_1.Object.Id_Filial[lvl_Linha] <> lvs_Marcacao Then
			dw_1.Object.Id_Filial[lvl_Linha] = lvs_Marcacao
			dw_2.Event ue_Seleciona_Filial(dw_1.Object.Cd_Filial[lvl_Linha], lvs_Marcacao)
		End If
	Next
	
	st_confirmar.Text = lvs_Texto

End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge373_promocao_filial
integer x = 997
integer y = 1532
integer width = 352
string text = "&Confirmar"
end type

event cb_ok::clicked;call super::clicked;If wf_Existe_Filial_Selecionada() Then
	Parent.Event ue_Save()
End If



end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge373_promocao_filial
integer x = 1385
integer y = 1532
integer width = 352
integer taborder = 50
string text = "&Sair"
end type

event cb_cancelar::clicked;// OverRide

If wf_Existe_Filial_Selecionada() Then
	Close(Parent)
End If
end event

type dw_2 from dc_uo_dw_base within w_ge373_promocao_filial
event ue_seleciona_filial ( long al_filial,  string as_selecionada )
boolean visible = false
integer x = 1806
integer y = 44
integer width = 942
integer height = 1044
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge373_promocao_filial"
end type

event ue_seleciona_filial;Boolean lvb_Alteracao = False

Long lvl_Find,&
	 lvl_Insert

lvl_Find = dw_2.Find("cd_filial =" + String(al_Filial), 1, dw_2.RowCount())

If lvl_Find = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial na promo$$HEX2$$e700e300$$ENDHEX$$o.")
End If

If lvl_Find > 0 Then
	If as_Selecionada = "S" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial j$$HEX1$$e100$$ENDHEX$$ foi inclu$$HEX1$$ed00$$ENDHEX$$da na promo$$HEX2$$e700e300$$ENDHEX$$o.") 
	Else
		// Exclui
		dw_2.DeleteRow(lvl_Find)
		
		lvb_Alteracao = True
	End If
Else
	// Inclui
	If as_Selecionada = "S" Then
		lvl_Insert = dw_2.InsertRow(0)
		dw_2.Object.cd_promocao[lvl_Insert] = ivl_Promocao
		dw_2.Object.cd_filial  [lvl_Insert] = al_Filial
		
		lvb_Alteracao = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial j$$HEX1$$e100$$ENDHEX$$ foi exclu$$HEX1$$ed00$$ENDHEX$$da da promo$$HEX2$$e700e300$$ENDHEX$$o.")
	End If
End If

If lvb_Alteracao Then
	ivw_ParentWindow.ivb_Valida_Salva = True
End If
end event

event ue_recuperar;// OverRide

Return This.Retrieve(ivl_Promocao)

end event

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Filial,&
	 lvl_Find,&
	 lvl_Retorno = 1
	 
This.AcceptText()

lvl_Linhas = This.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	lvl_Filial = This.Object.cd_filial[lvl_Linha]
	
	lvl_Find = dw_1.Find("cd_filial = " + String(lvl_Filial), 1, dw_1.RowCount() )
	
	If lvl_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial.")
		lvl_Retorno = -1
		Exit
	End If
	
	If lvl_Find > 0 Then
		dw_1.Object.id_filial[lvl_Find] = "S"
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial n$$HEX1$$e300$$ENDHEX$$o localizada.")
		lvl_Retorno = -1
		Exit
	End If
Next

Return lvl_Retorno



end event

event ue_preupdate;call super::ue_preupdate;//If This.RowCount() < 1 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos uma filial.")
//	Return -1
//End If

If Not wf_Existe_Filial_Selecionada() Then
	Return -1
End If

Return 1
end event

type cb_selecao from commandbutton within w_ge373_promocao_filial
integer x = 32
integer y = 1532
integer width = 503
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Filiais"
end type

event clicked;Long ll_Lojas
Long ll_Row
Long ll_Linhas
Long ll_Filial
Long ll_Find

uo_ge216_filiais lo_filiais
lo_Filiais = Create uo_ge216_filiais

OpenWithParm(w_ge216_selecao_filiais, lo_Filiais)

ll_Lojas = Message.DoubleParm

//***

If ll_Lojas > 0 Then
	
	ll_Linhas = UpperBound( lo_Filiais.ivl_filial[] )
	
	For ll_Row = 1 To ll_Linhas
		
		ll_Filial = lo_Filiais.ivl_filial[ ll_Row ]
		
		ll_Find = dw_1.Find("cd_filial = " + String(ll_Filial), 1, dw_1.RowCount())
		
		If ll_Find > 0 Then
			// Se a filial n$$HEX1$$e300$$ENDHEX$$o tiver marcada o sistema vai marcar
			If dw_1.Object.Id_Filial[ ll_Find ] = "N"  Then
				dw_2.Event ue_Seleciona_Filial(ll_Filial, "S")
				dw_1.Object.Id_Filial[ ll_Find ] = "S"
			End If
		Else
			If ll_Find = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + String(ll_Filial) + " selecionada n$$HEX1$$e300$$ENDHEX$$o foi localizada na lista de filiais.")
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial '" + String(ll_Filial) + "'")
				Exit
			End If
		End If
		
	Next
		
End If

Destroy lo_Filiais
end event

type st_confirmar from statictext within w_ge373_promocao_filial
boolean visible = false
integer x = 709
integer y = 40
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

