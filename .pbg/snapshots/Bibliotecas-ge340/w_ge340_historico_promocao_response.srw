HA$PBExportHeader$w_ge340_historico_promocao_response.srw
forward
global type w_ge340_historico_promocao_response from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge340_historico_promocao_response
end type
type gb_2 from groupbox within w_ge340_historico_promocao_response
end type
end forward

global type w_ge340_historico_promocao_response from dc_w_response_ok_cancela
integer width = 4320
integer height = 1868
string title = "GE340 - Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700f500$$ENDHEX$$es de Produto de Promo$$HEX2$$e700e300$$ENDHEX$$o"
dw_2 dw_2
gb_2 gb_2
end type
global w_ge340_historico_promocao_response w_ge340_historico_promocao_response

type variables
uo_promocao	io_Promocao
uo_produto		io_Produto

Boolean ib_Usuario_Localizado = False

String is_Nome_Promocao
String is_De_Tipo_Promocao
String is_Id_Tipo_Promocao
String is_Nome_Usuario
end variables

forward prototypes
public function boolean wf_preenche_dados ()
public function boolean wf_localiza_promocao (long pl_promocao)
public function boolean wf_localiza_usuario (string ps_matricula)
end prototypes

public function boolean wf_preenche_dados ();Long ll_Linha
Long ll_Promocao
Long ll_Pos

String ls_Matricula
String ls_Chave
String ls_Id_Tipo_Promo
String ls_De_Tipo_Promo
String ls_Filter
String ls_Sort
String ls_Promo_Fron

dw_1.AcceptText()
dw_2.AcceptText()

ls_Id_Tipo_Promo	= dw_1.Object.Id_Tipo_Promocao			[1]
ls_Promo_Fron		= dw_1.Object.Id_Promocao_Fronteira	[1]

For ll_Linha = 1 To dw_2.RowCount()
	ls_Matricula = dw_2.Object.Nr_Matric_Alteracao[ll_Linha]
	
	If Not wf_Localiza_Usuario(ls_Matricula) Then
		Return False
	End If
		
	If ib_Usuario_Localizado Then
		is_Nome_Usuario = is_Nome_Usuario + " (" + ls_Matricula + ")"
	End If
	
	dw_2.Object.Nm_Usuario[ll_Linha] = is_Nome_Usuario
	
	ls_Chave = dw_2.Object.De_Chave[ll_Linha]
	
	ll_Pos = PosA(ls_Chave, "@", 1)
	
	ll_Promocao = Long(MidA(ls_Chave, 1, ll_Pos - 1))
	
	If Not wf_Localiza_Promocao(ll_Promocao) Then
		Continue
	End If
					
	dw_2.Object.Cd_Promocao_Sos	[ll_Linha] = ll_Promocao
	dw_2.Object.Nm_Promocao_Sos	[ll_Linha] = is_Nome_Promocao
	dw_2.Object.De_Tipo_Promocao	[ll_Linha] = is_De_Tipo_Promocao
	dw_2.Object.Id_Tipo_Promocao	[ll_Linha] = is_Id_Tipo_Promocao
Next

If ls_Promo_Fron = "N" Then
	ls_Filter	= "id_tipo_promocao = '" + ls_Id_Tipo_Promo + "' and cd_promocao_sos <> 860 and cd_promocao_sos <> 1415"
Else
	ls_Filter	= "id_tipo_promocao = '" + ls_Id_Tipo_Promo + "'"
End If

dw_2.SetFilter( ls_Filter )
dw_2.Filter( )
dw_2.SetSort( ls_Sort )
dw_2.Sort( )

Return True
end function

public function boolean wf_localiza_promocao (long pl_promocao);Select	p.nm_promocao_sos,
		p.id_tipo_promocao,
		t.de_tipo_promocao
Into	:is_Nome_Promocao,
		:is_Id_Tipo_Promocao,
		:is_De_Tipo_Promocao
From promocao_sos As p
	Inner Join tipo_promocao As t
		On t.id_tipo_promocao = p.id_tipo_promocao
Where p.cd_promocao_sos = :pl_promocao
Using SqlCa;		

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi localizada a promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(pl_Promocao) + "'.", Exclamation!)
		Return False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(pl_Promocao) + "'." + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose
end function

public function boolean wf_localiza_usuario (string ps_matricula);ib_Usuario_Localizado = False

If IsNull(ps_Matricula) Then
	is_Nome_Usuario = "RESPONS$$HEX1$$c100$$ENDHEX$$VEL N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO"
	Return True
End If

Select	nm_usuario
	Into: is_Nome_Usuario
From usuario
Where nr_matricula = :ps_Matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ib_Usuario_Localizado = True
		
	Case 100
		is_Nome_Usuario = "RESPONS$$HEX1$$c100$$ENDHEX$$VEL N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO"
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a matr$$HEX1$$ed00$$ENDHEX$$cula '" + ps_Matricula + "'.", StopSign!)
		Return False
		
End Choose

Return True
end function

on w_ge340_historico_promocao_response.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge340_historico_promocao_response.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Termino	[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Inicio		[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Termino[1]), -90))

dw_1.SetTabOrder("nm_promocao_sos", 0)
dw_1.SetTabOrder("de_produto", 0)

dw_1.Object.Cd_Produto[1] = io_Produto.Cd_Produto
dw_1.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda

io_Promocao.ivs_Tipo = dw_1.Object.Id_Tipo_Promocao[1]

 dw_1.Object.id_utiliza_ecommerce.visible = False

dw_2.Event ue_Retrieve()
end event

event open;call super::open;io_Promocao = Create uo_promocao

io_Produto =  Message.PowerObjectParm
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge340_historico_promocao_response
boolean visible = false
integer x = 3461
integer y = 328
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge340_historico_promocao_response
integer y = 24
integer width = 3328
integer height = 440
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge340_historico_promocao_response
integer y = 88
integer width = 3269
integer height = 348
string dataobject = "dw_ge340_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge340_historico_promocao_response
integer x = 32
integer y = 1664
integer width = 320
string text = "&Atualizar"
end type

event cb_ok::clicked;call super::clicked;dw_2.Event ue_Retrieve()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge340_historico_promocao_response
integer x = 3950
integer y = 1656
string text = "&OK"
end type

event cb_cancelar::clicked;//OverRide

Destroy(io_Promocao)

CloseWithReturn(Parent, io_Produto)
end event

type dw_2 from dc_uo_dw_base within w_ge340_historico_promocao_response
integer x = 59
integer y = 536
integer width = 4169
integer height = 1072
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge340_lista_promocao"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino
DateTime ldh_Parametro

Long ll_Promocao
Long ll_Produto
Long ll_Total

dw_1.AcceptText()

SetRedraw(False)

ldh_Inicio		= dw_1.Object.Dh_Inicio				[1]
ldh_Termino	= dw_1.Object.Dh_Termino			[1]
ll_Produto		= dw_1.Object.Cd_Produto			[1]
ll_Promocao		= dw_1.Object.Cd_Promocao_Sos	[1]
ldh_Parametro	= gvo_Parametro.of_Dh_Movimentacao()

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

ll_Total = DaysAfter(Date(ldh_Inicio), Date(ldh_Parametro))

If ll_Total > 90 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior que 3 meses.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

This.of_AppendWhere("de_chave like '%@#!" + String(io_Produto.Cd_Produto) + "'")

This.of_SetRowSelection()

Return 1
end event

event ue_recuperar;//OverRide

String ls_Tipo_Alter
String ls_Coluna
String ls_Filter
String ls_Sort

dw_1.AcceptText()

//Limpa o filtro que $$HEX1$$e900$$ENDHEX$$ utilizado no evento ue_postretrieve da dw_2
ls_Filter = ''
ls_Sort = ''
	
dw_2.SetFilter( ls_Filter )
dw_2.Filter( )
dw_2.SetSort( ls_Sort )
dw_2.Sort()
//Fim filtro

ls_Tipo_Alter = dw_1.Object.Id_Tipo_Alteracao[1]

If ls_Tipo_Alter = "N" Then
	ls_Coluna = "PC_DESCONTO"
Else
	ls_Coluna = "PC_DESCONTO_CLUBE"
End If

Return This.Retrieve('PROMOCAO_SOS_PRODUTO', ls_Coluna, dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	If Not wf_Preenche_Dados() Then Return -1
End If

SetRedraw(True)

Return pl_Linhas
end event

type gb_2 from groupbox within w_ge340_historico_promocao_response
integer x = 27
integer y = 480
integer width = 4238
integer height = 1160
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

