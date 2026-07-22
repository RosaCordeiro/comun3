HA$PBExportHeader$w_ge100_autorizacao_funcional_card.srw
forward
global type w_ge100_autorizacao_funcional_card from window
end type
type cb_ok from commandbutton within w_ge100_autorizacao_funcional_card
end type
type cb_cancela from commandbutton within w_ge100_autorizacao_funcional_card
end type
type dw_1 from dc_uo_dw_base within w_ge100_autorizacao_funcional_card
end type
type gb_1 from groupbox within w_ge100_autorizacao_funcional_card
end type
end forward

global type w_ge100_autorizacao_funcional_card from window
integer x = 997
integer y = 876
integer width = 1705
integer height = 676
boolean titlebar = true
string title = "Sele$$HEX2$$e700e300$$ENDHEX$$o da Autoriza$$HEX2$$e700e300$$ENDHEX$$o Funcional Card"
windowtype windowtype = response!
long backcolor = 79741120
cb_ok cb_ok
cb_cancela cb_cancela
dw_1 dw_1
gb_1 gb_1
end type
global w_ge100_autorizacao_funcional_card w_ge100_autorizacao_funcional_card

type variables
uo_conveniado ivo_conveniado
end variables

forward prototypes
public subroutine wf_reimpressao_recibo ()
public function boolean wf_selecao_vendedor (string ps_vendedor)
public subroutine wf_localiza_conveniado ()
public subroutine wf_consulta_produto ()
end prototypes

public subroutine wf_reimpressao_recibo ();This.Enabled = False

//w_venda.wf_Reimpressao_Recibo()

This.Enabled = True
This.Show()

dw_1.SetFocus()
end subroutine

public function boolean wf_selecao_vendedor (string ps_vendedor);String  ls_vendedor

Long    lvi_tipo_comissao

ls_vendedor = ps_vendedor

Select u.nm_usuario,
		 v.cd_tipo_comissao
  Into :ls_vendedor,
		 :lvi_Tipo_Comissao
  From vendedor v,
		 usuario u
 Where u.nr_matricula           = v.nr_matricula_vendedor
	and v.nr_matricula_vendedor = :ls_Vendedor;

Choose Case Sqlca.Sqlcode
		
	Case -1 	
		dw_1.object.nr_autorizacao.protect = 1
		dw_1.object.cd_conveniado.protect  = 1			
		Sqlca.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o Vendedor")
		Return False
	
	Case 100 	
		dw_1.object.nr_autorizacao.protect = 1
		dw_1.SetFocus()			
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Vendedor n$$HEX1$$e300$$ENDHEX$$o localizado.",Exclamation!)
		Return False
	
	Case 0
//		gvo_Funcional_Card.cd_tipo_comissao = lvi_Tipo_Comissao
		
		dw_1.object.nm_vendedor[1]         = ls_vendedor
		dw_1.object.nr_autorizacao.protect = 0
				
		dw_1.SetFocus()
		dw_1.Setcolumn("nr_autorizacao")
		Return True
End Choose

end function

public subroutine wf_localiza_conveniado ();String lvs_conveniado

lvs_conveniado = dw_1.GetText()

ivo_conveniado.of_localiza_conveniado(Sitef.Funcional.cd_convenio,lvs_Conveniado)

lvs_conveniado = Message.StringParm

If Not IsNull(lvs_conveniado) Then
	dw_1.object.nm_conveniado[1] = ivo_conveniado.nm_conveniado
	dw_1.object.cd_conveniado[1] = ivo_conveniado.cd_conveniado
End If	




end subroutine

public subroutine wf_consulta_produto ();//
//Open(w_consulta_produto_caixa)
//
end subroutine

on w_ge100_autorizacao_funcional_card.create
this.cb_ok=create cb_ok
this.cb_cancela=create cb_cancela
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_ok,&
this.cb_cancela,&
this.dw_1,&
this.gb_1}
end on

on w_ge100_autorizacao_funcional_card.destroy
destroy(this.cb_ok)
destroy(this.cb_cancela)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;ivo_conveniado = Create uo_conveniado 

This.dw_1.InsertRow(0)
This.dw_1.SetFocus()

/*If gvo_Funcional_Card.id_cliente_caixa	= 'S' Then
	If Not IsNull(gvo_Funcional_Card.nr_matricula_vendedor) Or Trim(gvo_Funcional_Card.nr_matricula_vendedor) <> '' Then
		If wf_selecao_vendedor(gvo_Funcional_Card.nr_matricula_vendedor) Then
			dw_1.object.nr_matricula_vendedor[1] 		= gvo_Funcional_Card.nr_matricula_vendedor
			dw_1.object.nr_matricula_vendedor.protect = 1
			dw_1.object.nm_vendedor.protect 				= 1
		End If		
	End If
End If*/
	
	
	
	
end event

event close;Destroy(ivo_conveniado)
end event

type cb_ok from commandbutton within w_ge100_autorizacao_funcional_card
integer x = 914
integer y = 428
integer width = 361
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Ok"
end type

event clicked;String  lvs_Conveniado,&
		  lvs_Vendedor 

Integer lvi_Retorno

dw_1.AcceptText()

lvs_Vendedor   = dw_1.Object.nr_matricula_vendedor[1]
lvs_Conveniado = dw_1.Object.cd_conveniado        [1]

If Not IsNull(lvs_Conveniado) and Trim(lvs_Conveniado) <> '' Then	
	Sitef.Funcional.nr_doc                = dw_1.Object.nr_autorizacao       [1]
//	Sitef.Funcional.nr_matricula_vendedor = dw_1.Object.nr_matricula_vendedor[1]
	Sitef.Funcional.cd_conveniado         = dw_1.Object.cd_conveniado        [1]
	Sitef.Funcional.nm_conveniado         = dw_1.Object.nm_conveniado        [1]
	
	Close(Parent)	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o conv$$HEX1$$ea00$$ENDHEX$$nio.",Exclamation!)
	dw_1.SetFocus()
	dw_1.SetColumn('nm_conveniado')
End If	


end event

event getfocus;This.Default = True
end event

event losefocus;This.Default = False
end event

type cb_cancela from commandbutton within w_ge100_autorizacao_funcional_card
integer x = 1289
integer y = 428
integer width = 361
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancela"
boolean cancel = true
end type

event clicked;
SetNull(Sitef.Funcional.nr_doc)

Close(Parent)
end event

type dw_1 from dc_uo_dw_base within w_ge100_autorizacao_funcional_card
integer x = 37
integer y = 48
integer width = 1591
integer height = 344
string dataobject = "dw_ge100_autorizacao_funcional"
end type

event itemchanged;call super::itemchanged;Integer lvi_Tipo_Comissao

Long   lvl_Autorizacao

String lvs_Nm_Paciente,&
	   lvs_Nr_Matricula_Vendedor

Choose Case dwo.Name 
	Case "nr_autorizacao"
		//Limpa todas as vari$$HEX1$$e100$$ENDHEX$$veis.
		Sitef.Funcional.of_Inicializa()
		//
		lvl_Autorizacao = Long(Trim(This.GetText()))
		//
		If Sitef.Funcional.of_Autorizacao(lvl_Autorizacao) Then
	
			This.Object.nr_autorizacao[1] = Sitef.Funcional.nr_doc
			This.Object.nr_cartao     [1] = Sitef.Funcional.nr_cartao
			This.Object.de_transacao  [1] = Sitef.Funcional.de_transacao
			This.Object.vl_total      [1] = Sitef.Funcional.vl_total 
			
			This.SetColumn("cd_conveniado")
			This.SetFocus()
		
			cb_Ok.Enabled = True
					
		End If
		//
	Case "nm_conveniado"
		If Not IsNull(data) and Trim(data) <> '' Then
			If Trim(data) <> ivo_conveniado.nm_conveniado Then
				Return 1
			End If
		End If	
End Choose
//


end event

event getfocus;This.SelectText(1,20)
end event

event ue_key;CHOOSE CASE key 
	CASE KeyEnter!
		If This.GetColumnName() = 'nm_conveniado' Then
			Wf_Localiza_Conveniado()
		Else	
			dw_1.AcceptText()
		End If	
	CASE KeyF9!    ; wf_consulta_produto()
	CASE KeyF12!   ; wf_Reimpressao_Recibo()
END CHOOSE
end event

event itemfocuschanged;This.SelectText(1,20)
end event

event losefocus;call super::losefocus;If IsValid(ivo_Conveniado) Then
	This.Object.Nm_conveniado[1] = ivo_conveniado.nm_conveniado
End If
end event

type gb_1 from groupbox within w_ge100_autorizacao_funcional_card
integer x = 23
integer width = 1627
integer height = 408
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

