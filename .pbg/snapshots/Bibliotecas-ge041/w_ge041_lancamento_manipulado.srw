HA$PBExportHeader$w_ge041_lancamento_manipulado.srw
forward
global type w_ge041_lancamento_manipulado from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge041_lancamento_manipulado
end type
end forward

global type w_ge041_lancamento_manipulado from dc_w_response_ok_cancela
integer width = 2560
integer height = 1688
string title = "GE041 - Lan$$HEX1$$e700$$ENDHEX$$amento de Produto Manipulado"
cb_1 cb_1
end type
global w_ge041_lancamento_manipulado w_ge041_lancamento_manipulado

type variables
uo_ge041_nf_manip io_nf

Boolean ib_Segundo_Retrieve = False
end variables

forward prototypes
public function boolean wf_contem_caracter_especial (string as_registro, ref string as_modificado)
public subroutine wf_envio_email_log (long pl_linhas)
end prototypes

public function boolean wf_contem_caracter_especial (string as_registro, ref string as_modificado);String ls_Caracteres, ls_x
Integer li_Row, ll_Total
Boolean lb_Retorno = False

If as_registro = "" Then Return False
as_modificado = ""

ls_Caracteres = "$$HEX1$$1420$$ENDHEX$$'$$HEX2$$e700c700$$ENDHEX$$~^$$HEX1$$b400$$ENDHEX$$`$$HEX56$$a800e200c200e000c000e300c300e900c900ea00ca00e800c800ed00cd00ee00ce00ec00cc00e600c600f400f200fb00f900f800a300d8009201e100c100f300fa00f100d100aa00ba00bf00ae00bd00a700bc00d300df00d400d200f500d500b500fe00da00db00d900fd00dd00a800$$ENDHEX$$&*_={}[]><"

ll_Total = LenA( as_registro )

For li_Row = 1 To ll_Total
	
	ls_x = mid(as_registro, li_row, 1)
	
	If Pos( ls_Caracteres, ls_x ) > 0 Then
		as_modificado = gf_Replace( as_registro, ls_x, "", 1 )
		lb_Retorno = True
		Exit
	End If		   
Next

Return lb_Retorno

end function

public subroutine wf_envio_email_log (long pl_linhas);
end subroutine

on w_ge041_lancamento_manipulado.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge041_lancamento_manipulado.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_preopen;call super::ue_preopen;io_nf = Create uo_ge041_nf_manip

io_nf = Message.PowerObjectParm	

end event

event close;call super::close;If IsValid( io_nf ) Then Destroy io_nf
end event

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

pb_Help.Visible = True

dw_1.Event ue_Retrieve()

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge041_lancamento_manipulado
integer x = 32
integer y = 1480
end type

event pb_help::clicked;call super::clicked;wf_Help( "Consulta de Notas Fiscais de Venda (GE041)" )
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge041_lancamento_manipulado
integer width = 2505
integer height = 1464
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge041_lancamento_manipulado
integer x = 50
integer y = 60
integer width = 2459
integer height = 1392
string dataobject = "dw_ge041_lista_manipulado"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;//OverRide

Return This.Retrieve( io_nf.filial, io_nf.nf, io_nf.especie, io_nf.Serie )
end event

event dw_1::constructor;call super::constructor;This.of_Setcolselection( True )
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Integer ll_Linhas, ll_Row
String ls_Texto

Boolean lb_Texto_Alterado = False

ll_Linhas = This.RowCount() 

dw_1.AcceptText()

For ll_Row = 1 To ll_Linhas
	ls_Texto = Trim( This.Object.de_dados_adicionais[ ll_Row ]  )
	
	ls_Texto = gf_Replace(ls_Texto, "~r~n", "|" , 0)
	ls_Texto = gf_Replace(ls_Texto, "~n", "|" , 0)
	ls_Texto = gf_Replace(ls_Texto, "~r", "|" , 0)
	
	gf_remove_enter_tab(ls_Texto)
	
	This.Object.de_dados_adicionais[ ll_Row ] = ls_Texto
	
	If Not IsNull(ls_Texto) And ls_Texto <> "" Then
		lb_Texto_Alterado = True
	End If
Next

If Not lb_Texto_Alterado Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma descri$$HEX2$$e700e300$$ENDHEX$$o foi informada.~r~rDeseja emitir a nota fiscal mesmo assim?", Question!, yesNo!, 2) = 2 Then
		Return -1
	End If
End If

Return AncestorReturnValue
end event

event dw_1::editchanged;call super::editchanged;String ls_Alterado

Choose Case dwo.name 		
	Case "de_dados_adicionais"
		If wf_contem_caracter_especial( Data, Ref ls_Alterado ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o utilize caract$$HEX1$$e900$$ENDHEX$$res especiais.")
			If Data <> ls_Alterado Then This.Object.de_dados_adicionais[row] = ls_Alterado
			Return -1
		End If
			
End Choose
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;String ls_Chave, ls_Preco_Unitario, ls_Texto, ls_Registro, ls_Preco_UN, ls_PC_Desc, ls_MSG, ls_Dados

Long ll_Registro

Integer i

If pl_Linhas > 0 Then
	ls_MSG = "Valores apos o retrieve SEM alteracao nos dados adicionais dos registros."
	
	If ib_Segundo_Retrieve Then ls_MSG = "Valores apos o clique no CONFIRMAR da janela de dados adicionais dos registros."
	
	For i = 1 To pl_Linhas
		If i = 1 Then	
			ls_Chave   = String(This.Object.cd_filial		[ i ]) + "|"
			ls_Chave += String(This.Object.nr_nf			[ i ]) + "|"
			ls_Chave += This.Object.de_especie			[ i ] + "|"
			ls_Chave += This.Object.de_serie				[ i ] 
		End If
		
		ls_Registro			= String(This.Object.nr_registro 			[ i ] )
		ls_Preco_UN 		= String(This.Object.vl_preco_unitario 	[ i ], "#,##0.00" )
		ls_Pc_Desc 			= String(This.Object.pc_desconto			[ i ], "#,##0.00" )
		ls_Dados				= This.Object.de_dados_adicionais		[ i ]
		
		If IsNull(ls_Registro) 		Then ls_Registro 	= "NULL"
		If IsNull(ls_Preco_UN)	 	Then ls_Preco_UN = "NULL"
		If IsNull(ls_Pc_Desc) 		Then ls_Pc_Desc 	= "NULL"
		If IsNull(ls_Dados) Or Trim(ls_Dados) = '' Then ls_Dados 		= "NULL"
		
		ls_Texto += "Nr Registro: " + ls_Registro + " | Preco UN: " + ls_Preco_UN + " | Desconto: " + ls_Pc_Desc + " | Dados Adicionais: " + ls_Dados + "<br />"
	Next
	
	ls_Texto = ls_MSG + "<br />Chave NF: " + ls_Chave + "<br />" + ls_Texto
		
	//gf_ge202_envia_email_log(63, "Registro Venda Manip GE041", ls_Texto)	

End If

Return pl_Linhas

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge041_lancamento_manipulado
boolean visible = false
integer x = 37
integer y = 1628
integer width = 357
boolean enabled = false
string text = "&Confirmar"
boolean default = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge041_lancamento_manipulado
integer x = 2222
integer y = 1488
end type

type cb_1 from commandbutton within w_ge041_lancamento_manipulado
integer x = 1842
integer y = 1488
integer width = 357
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;Integer li_retorno

If dw_1.Event ue_Update() > 0 Then
	SqlCa.Of_Commit();
	
	ib_Segundo_Retrieve = True
	
	dw_1.Reset()
	dw_1.Event ue_Retrieve()	
		
	CloseWithReturn(Parent, 'S')
Else
	SqlCa.Of_Rollback();
	Return -1
End If

end event

