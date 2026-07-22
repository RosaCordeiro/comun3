HA$PBExportHeader$w_ge340_historico_promocao.srw
forward
global type w_ge340_historico_promocao from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge340_historico_promocao from dc_w_selecao_lista_relatorio
integer width = 4343
integer height = 2072
string title = "GE340 - Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700f500$$ENDHEX$$es de Produto de Promo$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge340_historico_promocao w_ge340_historico_promocao

type variables
uo_produto		io_Produto //ge001
uo_promocao	io_Promocao //ge065

Boolean ib_Usuario_Localizado = False

String is_Nome_Promocao
String is_Id_Tipo_Promocao
String is_De_Tipo_Promocao
String is_Nome_Usuario
end variables

forward prototypes
public function boolean wf_preenche_dados ()
public function boolean wf_localiza_promocao (long pl_promocao)
public function boolean wf_localiza_usuario (string ps_matricula)
end prototypes

public function boolean wf_preenche_dados ();Long ll_Linha
Long ll_Produto_Seleci
Long ll_Promocao_Seleci
Long ll_Produto
Long ll_Promocao
Long ll_Pos

String ls_Matricula
String ls_Chave
String ls_Id_Tipo_Promo
String ls_De_Tipo_Promo
String ls_Filter
String ls_Sort
String ls_Promo_Fron
string ls_Ecommerce

dw_1.AcceptText()
dw_2.AcceptText()

ll_Produto_Seleci		= dw_1.Object.Cd_Produto					[1]
ll_Promocao_Seleci	= dw_1.Object.Cd_Promocao_Sos			[1]
ls_Id_Tipo_Promo		= dw_1.Object.Id_Tipo_Promocao			[1]
ls_Promo_Fron			= dw_1.Object.Id_Promocao_Fronteira	[1]
ls_Ecommerce	= dw_1.Object.id_utiliza_ecommerce	[1]

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

	If ls_Ecommerce = 'S' Then
		ll_Promocao = Long(ls_Chave)
	End If
	
	If Not wf_Localiza_Promocao(ll_Promocao) Then
		Return False
	End If

	//Se estiver preenchida somente a promo$$HEX2$$e700e300$$ENDHEX$$o
	//If Not IsNull(ll_Produto_Seleci) And IsNull(ll_Promocao_Seleci) Then
		If dw_2.DataObject = 'dw_ge340_lista_promocao' Then
			dw_2.Object.Nm_Promocao_Sos	[ll_Linha] = is_Nome_Promocao
			dw_2.Object.De_Tipo_Promocao	[ll_Linha] = is_De_Tipo_Promocao
		End If
	//End If
	
	dw_2.Object.Cd_Promocao_Sos	[ll_Linha] = ll_Promocao
	dw_2.Object.Id_Tipo_Promocao	[ll_Linha] = is_Id_Tipo_Promocao
	
	If ls_Ecommerce = 'N' Then
		//Se estiver preenchido produto e promo$$HEX2$$e700e300$$ENDHEX$$o ou somente a promo$$HEX2$$e700e300$$ENDHEX$$o
		If (IsNull(ll_Produto_Seleci) And Not IsNull(ll_Promocao_Seleci)) Or (Not IsNull(ll_Produto_Seleci) And Not IsNull(ll_Promocao_Seleci)) Then
			ll_Pos = PosA(ls_Chave, "!", 1)
			
			ll_Produto = Long(MidA(ls_Chave, ll_Pos + 1))
				
			io_Produto.of_Localiza_Produto(String(ll_Produto))
			
			If Not io_Produto.Localizado Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto '" + String(ll_Produto) + "'.")
				Continue
			End If
			
			dw_2.Object.Cd_Produto	[ll_Linha] = ll_Produto
			dw_2.Object.De_Produto	[ll_Linha] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
	End If
	
Next

If ls_Promo_Fron = "N" Then
	ls_Filter	= "id_tipo_promocao = '" + ls_Id_Tipo_Promo + "' and cd_promocao_sos <> 860 and cd_promocao_sos <> 1415"
Else
	ls_Filter	= "id_tipo_promocao = '" + ls_Id_Tipo_Promo + "'"
End If

ls_Sort = "dh_alteracao desc"

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

on w_ge340_historico_promocao.create
call super::create
end on

on w_ge340_historico_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;io_Produto		= Create uo_produto
io_Promocao	= Create uo_promocao
end event

event close;call super::close;Destroy(io_Produto)
Destroy(io_Promocao)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Termino	[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Inicio		[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Termino[1]), -7))

dw_2.ivo_Controle_Menu.of_SalvarComo(True)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge340_historico_promocao
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge340_historico_promocao
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge340_historico_promocao
integer y = 472
integer width = 4219
integer height = 1384
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge340_historico_promocao
integer width = 3319
integer height = 436
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge340_historico_promocao
integer width = 3250
integer height = 320
string dataobject = "dw_ge340_selecao"
boolean ivb_updateable = true
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If Not io_Produto.Localizado Then
			io_Produto.of_Inicializa()
		End If
		
		This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
		This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
	
	If This.GetColumnName() = "nm_promocao_sos" Then
		
		io_Promocao.ivs_Tipo = dw_1.Object.Id_Tipo_Promocao[1]
		
		io_Promocao.of_Localiza(This.GetText())
		
		If Not io_Promocao.Localizado Then
			io_Promocao.of_Inicializa()
		End If
			
		This.Object.Cd_Promocao_Sos	[1] = io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos[1] = io_Promocao.Nm_Promocao
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.De_Produto Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
		This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If

If dwo.Name = "nm_promocao_sos" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Promocao.Nm_Promocao Then
			Return 1
		End If
	Else
		io_Promocao.of_Inicializa()
		
		This.Object.Cd_Promocao_Sos	[1]	= io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos[1]	= io_Promocao.Nm_Promocao
	End If
End If

If dwo.Name = "id_utiliza_ecommerce" Then
	io_Produto.of_Inicializa()
		
	This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
	This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
End If

dw_2.Event ue_Reset()
end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.De_Produto Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
		This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If

If dwo.Name = "nm_promocao_sos" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Promocao.Nm_Promocao Then
			Return 1
		End If
	Else
		io_Promocao.of_Inicializa()
		
		This.Object.Cd_Promocao_Sos	[1]	= io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos[1]	= io_Promocao.Nm_Promocao
	End If
End If

If dwo.Name = "id_utiliza_ecommerce" Then
	io_Produto.of_Inicializa()
		
	This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
	This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
End If

dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge340_historico_promocao
integer y = 548
integer width = 4151
integer height = 1280
string dataobject = "dw_ge340_lista_promocao"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino
DateTime ldh_Parametro

Long ll_Promocao
Long ll_Produto
Long ll_Total

String ls_Tipo_Promo
String ls_Dw
String ls_Ecommerce

dw_1.AcceptText()

SetRedraw(False)

ldh_Inicio		= dw_1.Object.Dh_Inicio				[1]
ldh_Termino	= dw_1.Object.Dh_Termino			[1]
ll_Produto		= dw_1.Object.Cd_Produto			[1]
ll_Promocao		= dw_1.Object.Cd_Promocao_Sos	[1]
ls_Tipo_Promo	= dw_1.Object.Id_Tipo_Promocao	[1]
ls_Ecommerce	= dw_1.Object.id_utiliza_ecommerce	[1]

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

If ls_Ecommerce = 'S' Then
	
	ls_Dw = "dw_ge340_lista_promocao"
		
	If This.DataObject <> ls_Dw Then
		If Not This.of_ChangeDataObject(ls_Dw) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store '" + ls_Dw + ".", StopSign!)
			Return -1
		End If
	End If
	
	If IsNull(ll_Promocao) Then
		This.of_AppendWhere("de_chave = '"  + string(ll_Promocao) + "'")
	End If

Else
	
	If IsNull(ll_Produto) And IsNull(ll_Promocao) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto ou a promo$$HEX2$$e700e300$$ENDHEX$$o para prosseguir.")
		dw_1.Event ue_Pos(1, "cd_produto")
		Return -1
	End If
	
	ll_Total = DaysAfter(Date(ldh_Inicio), Date(ldh_Parametro))
	
	If ll_Total > 90 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior que 3 meses.", Exclamation!)
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return -1
	End If
	
	//Se estiver preenchido somente o produto
	If Not IsNull(ll_Produto) And IsNull(ll_Promocao) Then
		ls_Dw = "dw_ge340_lista_promocao"
		
		If This.DataObject <> ls_Dw Then
			If Not This.of_ChangeDataObject(ls_Dw) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store '" + ls_Dw + ".", StopSign!)
				Return -1
			End If
		End If
			
		This.of_AppendWhere("de_chave like '%@#!" + String(ll_Produto) + "'")
	End If
	
	//Se estiver preenchido produto e promo$$HEX2$$e700e300$$ENDHEX$$o ou somente a promo$$HEX2$$e700e300$$ENDHEX$$o
	If (IsNull(ll_Produto) And Not IsNull(ll_Promocao)) Or (Not IsNull(ll_Produto) And Not IsNull(ll_Promocao)) Then
		ls_Dw = "dw_ge340_lista_produto"
		
		If This.DataObject <> ls_Dw Then
			If Not This.of_ChangeDataObject(ls_Dw) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store '" + ls_Dw + "'.", StopSign!)
				Return -1
			End If
		End If
		
		If IsNull(ll_Produto) And Not IsNull(ll_Promocao) Then
			This.of_AppendWhere("de_chave like '" + MidA(String(ll_Promocao) + Space(6), 1, 6) + "@#!%'")
		End If
		
		//de_chave like '%4622@#!714886%'
		If Not IsNull(ll_Produto) And Not IsNull(ll_Promocao) Then
			This.of_AppendWhere("de_chave like '%" + MidA(String(ll_Promocao) + Space(6), 1, 6) + "@#!" + String(ll_Produto) + "'")
		End If
	End If
End If

This.of_SetRowSelection()

Return 1
end event

event dw_2::ue_recuperar;//OverRide

String ls_Tipo_Alter
String ls_Coluna
String ls_Filter
String ls_Sort
String ls_Tipo_Promocao
String ls_Ecommerce
String ls_Tabela

DateTime ldh_Termino

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
ls_Tipo_Promocao  =  dw_1.Object.Id_Tipo_Promocao[1]
ls_Ecommerce	= dw_1.Object.id_utiliza_ecommerce	[1]

If ls_Ecommerce = 'S' Then
	ls_Coluna = "ID_UTILIZA_ECOMMERCE"
	ls_Tabela = 'PROMOCAO_SOS'
Else
	ls_Tabela = 'PROMOCAO_SOS_PRODUTO'
	
	If ls_Tipo_Alter = "N" Then
		ls_Coluna = "PC_DESCONTO"
	Else
		ls_Coluna = "PC_DESCONTO_CLUBE"
	End If
	
	If ls_Tipo_Promocao = 'Q' Then 
		ls_Coluna = "CD_DESCONTO_PROGRESSIVO_CLUBE"		
	End If 
End If

ldh_Termino = dateTime(String(dw_1.Object.Dh_Termino[1], 'dd/mm/yyyy') + ' 23:59:59')

Return This.Retrieve(ls_Tabela, ls_Coluna, dw_1.Object.Dh_Inicio[1], ldh_Termino )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	If Not wf_Preenche_Dados() Then Return -1
End If

parent.ivm_Menu.mf_SalvarComo(True)

SetRedraw(True)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge340_historico_promocao
integer x = 1038
integer y = 968
end type

