HA$PBExportHeader$w_ge364_libera_transferencia_perini.srw
forward
global type w_ge364_libera_transferencia_perini from dc_w_cadastro_selecao_lista
end type
type cb_2 from commandbutton within w_ge364_libera_transferencia_perini
end type
end forward

global type w_ge364_libera_transferencia_perini from dc_w_cadastro_selecao_lista
string tag = "GE364 - Libera Transfer$$HEX1$$ea00$$ENDHEX$$ncia de Produtos para o Estoque Central"
integer width = 2720
integer height = 1676
string title = "GE364 - Libera Transfer$$HEX1$$ea00$$ENDHEX$$ncia de Produtos para o Estoque Central"
cb_2 cb_2
end type
global w_ge364_libera_transferencia_perini w_ge364_libera_transferencia_perini

type variables
uo_produto ivo_produto
end variables

forward prototypes
public function boolean wf_localiza_liberacao_perini (long pl_produto, long pl_linha)
end prototypes

public function boolean wf_localiza_liberacao_perini (long pl_produto, long pl_linha);DateTime ldh_Inicio, &
			ldh_Termino

Select dh_inicio_vigencia,
		dh_termino_vigencia
Into :ldh_Inicio,
	  :ldh_Termino
From produto_liberado_transf_perini
Where cd_produto = :pl_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
		
	Case 0
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto '" + String( pl_Produto ) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ na lista de produtos liberados para transfer$$HEX1$$ea00$$ENDHEX$$ncia." + &
							"~rPer$$HEX1$$ed00$$ENDHEX$$odo de vig$$HEX1$$ea00$$ENDHEX$$ncia: " + String(Date(ldh_Inicio)) + " at$$HEX1$$e900$$ENDHEX$$ " + String(Date(ldh_Termino)) + " ." + &
							"~rDeseja alterar este per$$HEX1$$ed00$$ENDHEX$$odo?", Question!, YesNo!, 2) = 1 Then
				
			ldh_Inicio 		= gvo_Parametro.of_Dh_Movimentacao()
			ldh_Termino 	= DateTime(RelativeDate(Date(ldh_Inicio), 30))
			
		End If	
		
		dw_2.Object.dh_inicio_vigencia 	[pl_Linha] = ldh_Inicio
		dw_2.Object.dh_termino_vigencia [pl_Linha] = ldh_Termino
		
		Return True
		
	Case 100
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto '" + String(pl_Produto) + "'")
		Return False
End Choose

Return True
end function

on w_ge364_libera_transferencia_perini.create
int iCurrent
call super::create
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
end on

on w_ge364_libera_transferencia_perini.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
end on

event ue_postopen;call super::ue_postopen;ivo_produto = Create uo_Produto

ivm_Menu.mf_Incluir(False)
end event

event close;call super::close;Destroy ivo_produto
end event

event ue_preopen;call super::ue_preopen;ivb_Grava_Log = True
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge364_libera_transferencia_perini
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge364_libera_transferencia_perini
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge364_libera_transferencia_perini
integer x = 69
integer y = 72
integer width = 1819
integer height = 240
string dataobject = "dw_ge364_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.de_produto[1] = ivo_Produto.de_produto + " : " + ivo_Produto.de_apresentacao_venda
				This.Object.cd_produto[1] = ivo_Produto.cd_produto			
			End If
			
	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.de_produto + " : " + ivo_Produto.de_apresentacao_venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto	[1] = ivo_Produto.cd_produto
			This.Object.de_produto	[1] = ivo_Produto.de_produto
		End If
		
End Choose

dw_2.Reset()
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

event dw_1::getfocus;call super::getfocus;ivm_Menu.mf_Excluir(False)
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge364_libera_transferencia_perini
integer y = 352
integer width = 2615
integer height = 1124
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge364_libera_transferencia_perini
integer width = 1874
integer height = 336
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge364_libera_transferencia_perini
integer x = 78
integer y = 412
integer width = 2551
integer height = 1048
string dataobject = "dw_ge364_lista"
end type

event dw_2::ue_recuperar;Date ldh_Inicio,&
		ldh_Termino

Date ldh_Movimento

Long ll_Produto

String ls_Tipo
String ls_Erro

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.dh_inicio		[1]
ldh_Termino 	= dw_1.Object.dh_termino	[1]
ll_Produto		= dw_1.Object.cd_produto	[1]
ls_Tipo			= dw_1.Object.id_tipo		[1]

If ldh_Inicio > ldh_termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor que a data de t$$HEX1$$e900$$ENDHEX$$mino.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If
 
If Not IsNull ( ll_Produto ) Then
	This.of_AppendWhere( "tp.cd_produto = " + String( ll_Produto ))
End If

If Not IsNull(ldh_Inicio) And Not IsNull(ldh_Termino) Then
	This.of_AppendWhere("tp.dh_inicio_vigencia >= '" + String( ldh_Inicio, "yyyy/mm/dd" ) + "'" + " and tp.dh_termino_vigencia <= '" + String( ldh_Termino,  "yyyy/mm/dd"  ) + "'") 
End If

If Not IsNull(ldh_Inicio) And IsNull(ldh_Termino) Then
	This.of_AppendWhere("tp.dh_inicio_vigencia >= '" + String( ldh_Inicio,  "yyyy/mm/dd"  ) + "'")
End If

Choose Case ls_Tipo
	Case "V" // VIGENTE
		This.of_AppendWhere("tp.dh_inicio_vigencia <= r.dh_movimentacao and (tp.dh_termino_vigencia >= r.dh_movimentacao or tp.dh_termino_vigencia is null)")
	Case "E" // ENCERRADO
		This.of_AppendWhere("tp.dh_termino_vigencia < r.dh_movimentacao")
	Case "N" // N$$HEX1$$c300$$ENDHEX$$O VIGENTE
		This.of_AppendWhere("tp.dh_inicio_vigencia > r.dh_movimentacao and (tp.dh_termino_vigencia > r.dh_movimentacao or tp.dh_termino_vigencia is null)")
End Choose
	
Return Retrieve()
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If currentrow > 0 Then
	ivm_Menu.mf_Excluir(True)
End If
end event

event dw_2::getfocus;call super::getfocus;If dw_2.RowCount() > 0 Then ivm_Menu.mf_Excluir(True)
end event

type cb_2 from commandbutton within w_ge364_libera_transferencia_perini
integer x = 2149
integer y = 248
integer width = 503
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir Produtos"
end type

event clicked;SetPointer(HourGlass!)

Open(w_ge364_inclusao_produto)

dw_2.Event ue_Retrieve()

SetPointer(Arrow!)
end event

