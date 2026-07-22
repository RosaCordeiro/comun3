HA$PBExportHeader$w_ge466_simulacao_preco.srw
forward
global type w_ge466_simulacao_preco from dc_w_response
end type
type cb_2 from commandbutton within w_ge466_simulacao_preco
end type
type st_1 from statictext within w_ge466_simulacao_preco
end type
type cb_1 from commandbutton within w_ge466_simulacao_preco
end type
type gb_2 from groupbox within w_ge466_simulacao_preco
end type
type gb_1 from groupbox within w_ge466_simulacao_preco
end type
type dw_1 from dc_uo_dw_base within w_ge466_simulacao_preco
end type
type dw_2 from dc_uo_dw_base within w_ge466_simulacao_preco
end type
type cb_fechar from commandbutton within w_ge466_simulacao_preco
end type
type cb_confirmar from commandbutton within w_ge466_simulacao_preco
end type
type cb_incluir from commandbutton within w_ge466_simulacao_preco
end type
type dw_3 from dc_uo_dw_base within w_ge466_simulacao_preco
end type
type dw_4 from dc_uo_dw_base within w_ge466_simulacao_preco
end type
type gb_3 from groupbox within w_ge466_simulacao_preco
end type
type gb_4 from groupbox within w_ge466_simulacao_preco
end type
end forward

global type w_ge466_simulacao_preco from dc_w_response
string tag = "w_ge466_simulacao_preco"
integer width = 3986
integer height = 1892
string title = "GE466 - Verifica$$HEX2$$e700e300$$ENDHEX$$o Pre$$HEX1$$e700$$ENDHEX$$o dos Produtos "
boolean controlmenu = false
long backcolor = 80269524
cb_2 cb_2
st_1 st_1
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_fechar cb_fechar
cb_confirmar cb_confirmar
cb_incluir cb_incluir
dw_3 dw_3
dw_4 dw_4
gb_3 gb_3
gb_4 gb_4
end type
global w_ge466_simulacao_preco w_ge466_simulacao_preco

type variables
uo_produto ivo_produto

dc_uo_ds_base ids

Boolean ivb_botao_cancelar = False

Long ivl_promocao_sos
end variables

forward prototypes
public subroutine wf_atualiza_preco_simulado ()
public subroutine wf_localiza_produto ()
public subroutine wf_verifica_maior_desconto ()
end prototypes

public subroutine wf_atualiza_preco_simulado ();Decimal lvdc_Preco_Venda
Decimal lvdc_Desconto
Decimal lvdc_Preco_Simulado
Decimal ldc_Desc_Clube
Decimal ldc_Pre_Simulado_Clube

Long lvl_Linha
		  
dw_2.SetRedraw(False)

Open(w_Aguarde)

w_Aguarde.Title = "Aguarde atualizando o pre$$HEX1$$e700$$ENDHEX$$o simulado..."

For lvl_Linha = 1 To dw_2.RowCount()
	lvdc_Preco_Venda	= dw_2.Object.Vl_Preco_Venda_Atual	[lvl_Linha]
	lvdc_Desconto		= dw_2.Object.Pc_Desconto         			[lvl_Linha]
	ldc_Desc_Clube		= dw_2.Object.Pc_Desconto_Clube		[lvl_Linha]
	
	lvdc_Preco_Simulado		= Round(lvdc_Preco_Venda * ((100 - lvdc_Desconto) / 100), 2)
	ldc_Pre_Simulado_Clube	= Round(lvdc_Preco_Venda * ((100 - ldc_Desc_Clube) / 100), 2)
	
	dw_2.Object.Vl_Preco_Simulado		[lvl_Linha] = lvdc_Preco_Simulado
	dw_2.Object.Vl_Pre_Simulado_Clube	[lvl_Linha] = ldc_Pre_Simulado_Clube
Next

Close(w_Aguarde)

dw_2.SetRedraw(True)
end subroutine

public subroutine wf_localiza_produto ();Long lvl_Linha

ivo_Produto.of_Localiza_Produto(dw_2.GetText())

If ivo_Produto.Localizado Then
	lvl_Linha = dw_2.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, dw_2.RowCount())

	If lvl_Linha < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto selecionado.", StopSign!)
		Return
	End If
	
	If lvl_Linha = 0 Then
		lvl_Linha = dw_2.GetRow()
		
		dw_2.Object.Cd_Produto          [lvl_Linha] = ivo_Produto.Cd_Produto
		dw_2.Object.De_Produto          [lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		dw_2.Object.Vl_Preco_Venda_Atual[lvl_Linha] = ivo_Produto.Vl_Preco_Venda_Atual
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(ivo_Produto.Cd_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionado.", Information!)
		lvl_Linha = dw_2.GetRow()
	End If
	
	dw_2.Event ue_Pos(lvl_Linha, "pc_desconto")	
End If
end subroutine

public subroutine wf_verifica_maior_desconto ();Long	lvl_Linhas,&
		lvl_Linha,&
		lvl_Produto,&
		lvl_Promocao_SOS,&
		lvl_Filial
		
Decimal 	lvdc_Desconto_Maior,&
			lvdc_Desconto

lvl_Linhas = dw_2.RowCount()

dw_2.SetRedraw (False)

Open(w_Aguarde)

w_Aguarde.Title = "Aguarde verificando o desconto em outras promo$$HEX2$$e700f500$$ENDHEX$$es ..."

Select min(cd_filial) 
Into :lvl_Filial
From promocao_sos_filial
Where cd_promocao_sos = :ivl_Promocao_SOS
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial da PROMOCAO_SOS")
	Return
End If

If IsNull(lvl_Filial) Then Return

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Produto 		= dw_2.Object.cd_produto	[lvl_Linha]
	lvdc_Desconto	= dw_2.Object.pc_desconto	[lvl_Linha]
	
	ivo_Produto.of_Localiza_Produto(String(lvl_Produto))
	
	If ivo_Produto.Localizado Then
	
		lvdc_Desconto_Maior = ivo_Produto.Of_Desconto_Filial(lvl_Filial)
		
		If lvdc_Desconto_Maior > lvdc_Desconto Then
			dw_2.Object.cd_promocao_sos_maior	[lvl_Linha] = ivo_Produto.cd_promocao_sos			
			dw_2.Object.pc_desconto_maior			[lvl_Linha] = lvdc_Desconto_Maior
		End If		

	End If
	
Next

Close(w_Aguarde)

dw_2.SetRedraw (True)



end subroutine

on w_ge466_simulacao_preco.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_fechar=create cb_fechar
this.cb_confirmar=create cb_confirmar
this.cb_incluir=create cb_incluir
this.dw_3=create dw_3
this.dw_4=create dw_4
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.cb_fechar
this.Control[iCurrent+9]=this.cb_confirmar
this.Control[iCurrent+10]=this.cb_incluir
this.Control[iCurrent+11]=this.dw_3
this.Control[iCurrent+12]=this.dw_4
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.gb_4
end on

on w_ge466_simulacao_preco.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_fechar)
destroy(this.cb_confirmar)
destroy(this.cb_incluir)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;ivl_Promocao_SOS = Message.DoubleParm

ivo_Produto = Create uo_Produto

ids = Create dc_uo_ds_base

If Not ids.of_ChangeDataObject("ds_ge466_produto_simulacao") Then
	Destroy(ids)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge466_produto_simulacao'.", StopSign!)
	Return -1
End If
end event

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]

lvo_Update = {dw_2}

This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_AddRow()

dw_2.Event ue_Retrieve()
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ids)
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	// Se o salvamento foi acionado pelo bot$$HEX1$$e300$$ENDHEX$$o cancelar
	If Not ivb_Botao_Cancelar Then
		CloseWithReturn(This, "S")
	End If
End If

Return AncestorReturnValue
end event

event ue_presave;call super::ue_presave;dw_2.AcceptText()

If Not gf_ge380_Alerta_Desconto(dw_2, dw_2.Object.Id_Tipo_Promocao[1]) Then Return False

If Not gf_ge065_Historico_Exclusao_Produto(ids, dw_2, "S") Then
	Return False
Else
	Return True
End If
end event

type pb_help from dc_w_response`pb_help within w_ge466_simulacao_preco
end type

type cb_2 from commandbutton within w_ge466_simulacao_preco
integer x = 2935
integer y = 124
integer width = 1006
integer height = 100
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Listar Produtos com Pre$$HEX1$$e700$$ENDHEX$$o Futuro"
end type

event clicked;String	lvs_Texto,&
		lvs_Filtro

lvs_Texto =This.Text

If lvs_Texto = 'Listar Produtos com Pre$$HEX1$$e700$$ENDHEX$$o Futuro' Then
	
	lvs_Filtro =  "vl_preco_venda_futuro > 0.00"
	
	lvs_Texto = 'Todos os Produtos' 
Else
	lvs_Filtro = ""
	
	lvs_Texto = 'Listar Produtos com Pre$$HEX1$$e700$$ENDHEX$$o Futuro'
End If

This.Text = lvs_Texto

dw_2.SetFilter(lvs_Filtro)
dw_2.Filter()
end event

type st_1 from statictext within w_ge466_simulacao_preco
integer x = 32
integer y = 1692
integer width = 1079
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "Produtos com altera$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o futuro"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_ge466_simulacao_preco
integer x = 2939
integer y = 12
integer width = 539
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar em Excel"
end type

event clicked;String lvs_Arquivo

lvs_Arquivo = "c:\sistemas\GP\arquivos\" + "simulacao_promocao_" + string(ivl_promocao_sos) + ".xls"

If dw_2.SaveAs(lvs_Arquivo, Excel8!, TRUE) = 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Arquivo + "'.")
End If
end event

type gb_2 from groupbox within w_ge466_simulacao_preco
integer x = 23
integer y = 224
integer width = 3922
integer height = 860
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge466_simulacao_preco
integer x = 23
integer y = 20
integer width = 1266
integer height = 192
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Unidade de Federa$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge466_simulacao_preco
integer x = 50
integer y = 84
integer width = 1221
integer height = 104
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_ge466_selecao_simulado"
end type

event itemchanged;call super::itemchanged;
dw_1.Object.cd_unidade_federacao[1] = data

dw_2.Event ue_Retrieve()


end event

type dw_2 from dc_uo_dw_base within w_ge466_simulacao_preco
string tag = "Lista de Produtos"
integer x = 64
integer y = 288
integer width = 3342
integer height = 780
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge466_produto_simulacao"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_recuperar;//OverRide

String lvs_Unidade_Federacao

lvs_Unidade_Federacao = dw_1.Object.cd_unidade_federacao[1]

Return dw_2.Retrieve(lvs_Unidade_Federacao, ivl_promocao_sos)
end event

event ue_postretrieve;//wf_Atualiza_Preco_Simulado()

//wf_verifica_maior_desconto()

ids.Reset()

If dw_2.RowsCopy(1, dw_2.RowCount(), Primary!, ids, 1, Primary!) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no RowsCopy.", StopSign!)
	Return -1
End If

Return 1
end event

event ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()

	Choose Case lvs_Coluna
		Case "de_produto"		
			wf_Localiza_Produto()	
	End Choose
	
	
	
End If
end event

event constructor;call super::constructor;//This.of_SetRowSelection()

This.of_SetRowSelection("", "if( not isnull( dh_preco_venda_futuro ), RGB(255,0, 0), RGB(0,0,0) )")
end event

event ue_preupdate;call super::ue_preupdate;/*Long lvl_Linha
	  
DateTime lvdh_Atual

Date lvdt_Alteracao

lvdh_Atual = gvo_Parametro.of_Dh_Movimentacao()

lvdt_Alteracao = RelativeDate(Date(lvdh_Atual), 1)

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Promocao_SOS[lvl_Linha]) Then
		This.Object.Cd_Promocao_SOS		[lvl_Linha] = ivl_Promocao_sos
		This.Object.Dh_Alteracao				[lvl_Linha] = lvdt_Alteracao
		This.Object.Nr_Matricula_Alteracao	[lvl_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	Else
		If (This.Object.Pc_Desconto[lvl_Linha] <> This.Object.Pc_Desconto_Anterior[lvl_Linha]) Or &
		(This.Object.Pc_Desconto_Clube[lvl_Linha] <> This.Object.Pc_Desconto_Clube_Anterior[lvl_Linha]) Then
			This.Object.Dh_Alteracao				[lvl_Linha] = lvdt_Alteracao
			This.Object.Nr_Matricula_Alteracao	[lvl_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		End If
	End If
Next
*/

Return 1
end event

event editchanged;call super::editchanged;Decimal lvdc_Preco_Normal
Decimal lvdc_Desconto
Decimal ldc_Desc_Clube

This.AcceptText()

lvdc_Preco_Normal = This.Object.Vl_Preco_Venda_Atual[Row]

If dwo.Name = "vl_preco_simulado" Then
	If Dec(Data) = 0 Then Return 0

	If Dec(Data) > lvdc_Preco_Normal Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pre$$HEX1$$e700$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o deve ser menor que o pre$$HEX1$$e700$$ENDHEX$$o normal.", StopSign!)
		This.Event ue_Pos(This.GetRow(), "vl_preco_simulado")
		Return 1
	End If		
		
	lvdc_Desconto = lvdc_Preco_Normal - Dec(Data)
	lvdc_Desconto = Round(lvdc_Desconto / lvdc_Preco_Normal * 100, 2)
	
	If lvdc_Desconto <= 0 or lvdc_Desconto >= 100 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o informado gera um desconto inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
		This.Event ue_Pos(This.GetRow(), "vl_preco_simulado")
		Return 1
	End If

	This.Object.Pc_Desconto[Row] = lvdc_Desconto
End If

If dwo.Name = "vl_pre_simulado_clube" Then	
	If Dec(Data) = 0 Then Return 0

	If Dec(Data) > lvdc_Preco_Normal Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pre$$HEX1$$e700$$ENDHEX$$o do clube deve ser menor que o pre$$HEX1$$e700$$ENDHEX$$o normal.", StopSign!)
		This.Event ue_Pos(This.GetRow(), "vl_pre_simulado_clube")
		Return 1
	End If		
		
	ldc_Desc_Clube = lvdc_Preco_Normal - Dec(Data)
	ldc_Desc_Clube = Round(ldc_Desc_Clube / lvdc_Preco_Normal * 100, 2)
	
	If ldc_Desc_Clube <= 0 or ldc_Desc_Clube >= 100 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o do Clube informado gera um desconto inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
		This.Event ue_Pos(This.GetRow(), "vl_pre_simulado_clube")
		Return 1
	End If

	This.Object.Pc_Desconto_Clube[Row] = ldc_Desc_Clube
End If
end event

event rowfocuschanged;call super::rowfocuschanged;Long ll_cd_promocao_sos,&
		ll_cd_produto
String ls_cd_unidade_federacao,&
		ls_id_tipo_promocao
		
		
If currentrow > 0 Then		
	dw_2.AcceptText()

	ll_cd_produto   			=  	dw_2.Object.cd_produto	[currentrow]
	ll_cd_promocao_sos   =  dw_2.Object.cd_promocao_sos	[currentrow]
	ls_cd_unidade_federacao =  dw_2.Object.cd_unidade_federacao	[currentrow]  
	ls_id_tipo_promocao =  dw_2.Object.id_tipo_promocao	[currentrow]  
	
	If ll_cd_produto>0 Then 
		dw_3.Reset()
		dw_3.Retrieve(ls_cd_unidade_federacao , ll_cd_promocao_sos, ll_cd_produto  )
	Else
		dw_3.Reset()
	End If 
	
	If ll_cd_produto>0 Then 
		dw_4.Reset()
			dw_4.Retrieve(ls_cd_unidade_federacao,  ll_cd_promocao_sos, ll_cd_produto   )
	Else 
		dw_4.Reset()
	End If 
	
End If


end event

type cb_fechar from commandbutton within w_ge466_simulacao_preco
integer x = 3570
integer y = 1692
integer width = 389
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean cancel = true
end type

event clicked;ivb_Botao_Cancelar = True

CloseWithReturn(Parent, "N")


end event

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

type cb_confirmar from commandbutton within w_ge466_simulacao_preco
boolean visible = false
integer x = 1989
integer y = 32
integer width = 389
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Con&firmar"
end type

event clicked;Parent.Event ue_Save()
end event

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

type cb_incluir from commandbutton within w_ge466_simulacao_preco
boolean visible = false
integer x = 1513
integer y = 32
integer width = 475
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Incluir Produto"
end type

event clicked;Long lvl_Linha

lvl_Linha = dw_2.Find("isnull(cd_produto)", 1, dw_2.RowCount())

If lvl_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o de linhas em branco.", StopSign!)
	Return
End If

If lvl_Linha = 0 Then
	lvl_Linha = dw_2.InsertRow(0)
End If

dw_2.Event ue_Pos(lvl_Linha, "de_produto")
end event

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

type dw_3 from dc_uo_dw_base within w_ge466_simulacao_preco
integer x = 64
integer y = 1168
integer width = 1888
integer height = 492
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge466_produto_simulacao_desconto"
end type

event editchanged;call super::editchanged;Decimal lvdc_Preco_Normal
Decimal lvdc_Desconto
Decimal ldc_Desc_Clube

This.AcceptText()

lvdc_Preco_Normal = This.Object.Vl_Preco_Venda_Atual[Row]

If dwo.Name = "valor_preco" Then
	If Dec(Data) = 0 Then Return 0

	If Dec(Data) > lvdc_Preco_Normal Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pre$$HEX1$$e700$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o deve ser menor que o pre$$HEX1$$e700$$ENDHEX$$o normal.", StopSign!)
		This.Event ue_Pos(This.GetRow(), "valor_preco")
		Return 1
	End If		
		
	lvdc_Desconto = lvdc_Preco_Normal - Dec(Data)
	lvdc_Desconto = Round(lvdc_Desconto / lvdc_Preco_Normal * 100, 2)

	If lvdc_Desconto <= 0 or lvdc_Desconto >= 100 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o informado gera um desconto inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
		This.Event ue_Pos(This.GetRow(), "valor_preco")
		Return 1
	End If

	This.Object.desconto[Row] = lvdc_Desconto
End If


end event

type dw_4 from dc_uo_dw_base within w_ge466_simulacao_preco
integer x = 2089
integer y = 1168
integer width = 1842
integer height = 492
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge466_produto_simulacao_desc_prog"
end type

event itemchanged;call super::itemchanged;Decimal lvdc_Preco_Normal
Decimal lvdc_Desconto
Decimal ldc_Desc_Clube

This.AcceptText()

lvdc_Preco_Normal = This.Object.Vl_Preco_Venda_Atual[Row]

If dwo.Name = "valor_preco" Then
	If Dec(Data) = 0 Then Return 0

	If Dec(Data) > lvdc_Preco_Normal Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pre$$HEX1$$e700$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o deve ser menor que o pre$$HEX1$$e700$$ENDHEX$$o normal.", StopSign!)
		This.Event ue_Pos(This.GetRow(), "valor_preco")
		Return 1
	End If		
		
	lvdc_Desconto = lvdc_Preco_Normal - Dec(Data)
	lvdc_Desconto = Round(lvdc_Desconto / lvdc_Preco_Normal * 100, 2)

	If lvdc_Desconto <= 0 or lvdc_Desconto >= 100 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o informado gera um desconto inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
		This.Event ue_Pos(This.GetRow(), "valor_preco")
		Return 1
	End If

	This.Object.desconto[Row] = lvdc_Desconto
End If


end event

type gb_3 from groupbox within w_ge466_simulacao_preco
integer x = 27
integer y = 1104
integer width = 2021
integer height = 572
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Desconto Progressivo"
end type

type gb_4 from groupbox within w_ge466_simulacao_preco
integer x = 2057
integer y = 1104
integer width = 1906
integer height = 576
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Desconto Clube Progressivo"
end type

