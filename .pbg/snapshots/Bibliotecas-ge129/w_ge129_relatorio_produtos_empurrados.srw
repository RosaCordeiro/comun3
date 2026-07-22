HA$PBExportHeader$w_ge129_relatorio_produtos_empurrados.srw
forward
global type w_ge129_relatorio_produtos_empurrados from dc_w_selecao_lista_relatorio
end type
type cb_cancelar from commandbutton within w_ge129_relatorio_produtos_empurrados
end type
type cb_check from commandbutton within w_ge129_relatorio_produtos_empurrados
end type
type cb_salvar from commandbutton within w_ge129_relatorio_produtos_empurrados
end type
type dw_4 from dc_uo_dw_base within w_ge129_relatorio_produtos_empurrados
end type
type gb_3 from groupbox within w_ge129_relatorio_produtos_empurrados
end type
end forward

global type w_ge129_relatorio_produtos_empurrados from dc_w_selecao_lista_relatorio
string tag = "w_ge129_relatorio_produtos_empurrados"
integer width = 5746
integer height = 2512
string title = "GE129 - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos Empurrados"
long backcolor = 80269524
cb_cancelar cb_cancelar
cb_check cb_check
cb_salvar cb_salvar
dw_4 dw_4
gb_3 gb_3
end type
global w_ge129_relatorio_produtos_empurrados w_ge129_relatorio_produtos_empurrados

type variables
uo_filial						ivo_filial		//GE009
uo_produto					ivo_produto	//GE001
uo_pedido_empurrado	io_Pedido	//CO055

String ivs_Sistema 

end variables

forward prototypes
public function boolean wf_linhas_selecionadas ()
end prototypes

public function boolean wf_linhas_selecionadas ();Integer lvi_Find

lvi_Find = dw_2.Find("id_cancelar ='" + "S" + "'", 1, dw_2.RowCount())

If lvi_Find = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o de linhas selecionadas.", Information!)
	Return False
Else 
	If lvi_Find < 1 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pelo menos um produto dever$$HEX1$$e100$$ENDHEX$$ ser selecionado.", Information!)
		Return False
	Else
		Return True
	End If
End If
end function

on w_ge129_relatorio_produtos_empurrados.create
int iCurrent
call super::create
this.cb_cancelar=create cb_cancelar
this.cb_check=create cb_check
this.cb_salvar=create cb_salvar
this.dw_4=create dw_4
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelar
this.Control[iCurrent+2]=this.cb_check
this.Control[iCurrent+3]=this.cb_salvar
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.gb_3
end on

on w_ge129_relatorio_produtos_empurrados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_cancelar)
destroy(this.cb_check)
destroy(this.cb_salvar)
destroy(this.dw_4)
destroy(this.gb_3)
end on

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Produto)
Destroy(io_Pedido)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dt_Inicio [1] = Today()
dw_1.Object.Dt_Termino[1] = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True

dw_2.ivo_Controle_Menu.of_SalvarComo(True)

If (ivs_Sistema <> 'CO' And ivs_Sistema <>  'GC' )  Then 
	cb_check.visible 		= False
	cb_cancelar.visible 	= False	
End If 
end event

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino

If AncestorReturnValue > 0 Then
	lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
	lvdt_Termino = dw_1.Object.Dt_Termino[1]

	dw_3.Object.Periodo_Cabecalho.Text = "Per$$HEX1$$ed00$$ENDHEX$$odo de : " + &
	                                     String(lvdt_Inicio,  "dd/mm/yyyy") + "  at$$HEX1$$e900$$ENDHEX$$ :  " + &
   	                                  String(lvdt_Termino, "dd/mm/yyyy")
End If									

Return AncestorReturnValue
									
end event

event open;call super::open;ivo_Filial		= Create uo_Filial
ivo_Produto	= Create uo_Produto
io_Pedido	= Create uo_Pedido_Empurrado


ivs_Sistema  = gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge129_relatorio_produtos_empurrados
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge129_relatorio_produtos_empurrados
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge129_relatorio_produtos_empurrados
integer x = 14
integer y = 416
integer width = 5659
integer height = 1352
long backcolor = 80269524
string text = "Lista de Produtos"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge129_relatorio_produtos_empurrados
integer x = 14
integer y = 0
integer width = 2011
integer height = 412
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge129_relatorio_produtos_empurrados
integer x = 46
integer y = 56
integer width = 1970
integer height = 336
string dataobject = "dw_ge129_selecao"
end type

event dw_1::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If
			
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
		
	Case "nm_filial"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose

dw_4.Event ue_Reset()
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia	
End If

If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If
end event

event dw_1::editchanged;call super::editchanged;Long lvl_Null

Choose Case dwo.Name
	Case "nm_filial"
		SetNull(lvl_Null)
		dw_1.Object.cd_Filial[1] = lvl_Null
	Case "de_produto"
		SetNull(lvl_Null)
		dw_1.Object.cd_Produto[1] = lvl_Null
End Choose

		



end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge129_relatorio_produtos_empurrados
integer x = 18
integer y = 460
integer width = 5637
integer height = 1296
string dataobject = "dw_ge129_lista"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial, &
     lvl_Produto

String lvs_Situacao, &
		ls_Tipo_Pedido

dw_1.AcceptText()

lvl_Filial   		= dw_1.Object.Cd_Filial  		[1]
lvl_Produto 	 	= dw_1.Object.Cd_Produto 		[1]
lvs_Situacao		= dw_1.Object.Id_Situacao		[1]
ls_Tipo_Pedido		= dw_1.Object.Id_Tipo_Pedido	[1]

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	This.of_AppendWhere("a.cd_filial = " + String(lvl_Filial))
End If

If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
	This.of_AppendWhere("b.cd_produto = " + String(lvl_Produto))
End If

If lvs_Situacao <> "T" Then
	This.of_AppendWhere("b.id_situacao = '" + lvs_Situacao + "'")
End If

If ls_Tipo_Pedido <> "T" Then
	If ls_Tipo_Pedido = "E" Then
		This.of_AppendWhere("(a.id_tipo_pedido = 'E')")	
	ElseIf ls_Tipo_Pedido = "U" Then
		This.of_AppendWhere("(a.id_tipo_pedido = 'U')")
	Else
		This.of_AppendWhere("a.id_tipo_pedido = 'F'")
	End If
End If

Return 1
end event

event dw_2::ue_recuperar;// Override

Date lvdt_Inicio, &
     lvdt_Termino
	  
lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Contador

If pl_Linhas > 0 Then 
	cb_cancelar.Enabled = True
	cb_check.Enabled    = True
	cb_salvar.Enabled    = True
Else
	cb_cancelar.Enabled = False
	cb_check.Enabled    = False
	cb_salvar.Enabled    = False
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[], &
		 lvs_Bloqueio[]

lvs_Coluna = {"cd_filial", &
              "de_produto", &
              "de_apresentacao_venda", &
				  "dh_emissao", &
				  "id_situacao"}

lvs_Nome = {"Filial", &
            "Descri$$HEX2$$e700e300$$ENDHEX$$o", &
            "Apresenta$$HEX2$$e700e300$$ENDHEX$$o de Venda", &
				"Data", &
				"Situa$$HEX2$$e700e300$$ENDHEX$$o"}

lvs_Bloqueio = {"N", "N", "N", "N", "N"}

This.of_SetSort(lvs_Coluna, lvs_Nome, lvs_Bloqueio)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;Long ll_filial, ll_nr_pedido_empurado, ll_cd_produto
Datetime dhl_dh_emissao


If currentrow > 0 Then 
	ll_filial = this.object.cd_filial[currentrow]
	ll_nr_pedido_empurado = this.object.nr_pedido_empurrado[currentrow]
	dhl_dh_emissao = this.object.dh_emissao[currentrow]
	ll_cd_produto = this.object.cd_produto[currentrow]

	dw_4.retrieve(ll_filial, ll_nr_pedido_empurado, dhl_dh_emissao, ll_cd_produto)
End If

end event

event dw_2::itemchanged;call super::itemchanged;String	ls_id_situacao

choose case dwo.name 
	case 'id_cancelar'
		ls_id_situacao = this.object.id_situacao[row]
		
		if ls_id_situacao = 'X' then
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Pedido j$$HEX1$$e100$$ENDHEX$$ esta cancelado.',Exclamation!)
			return 1
		end if
		
		if ls_id_situacao = 'A' then
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Pedido j$$HEX1$$e100$$ENDHEX$$ foi atendido.',Exclamation!)
			return 1
		end if
		
end choose
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge129_relatorio_produtos_empurrados
integer x = 2167
integer y = 32
integer height = 184
integer taborder = 70
string dataobject = "dw_ge129_relatorio"
boolean vscrollbar = false
end type

type cb_cancelar from commandbutton within w_ge129_relatorio_produtos_empurrados
integer x = 3182
integer y = 312
integer width = 576
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
string text = "&Cancelar Pend$$HEX1$$ea00$$ENDHEX$$ncia"
end type

event clicked;Boolean lvb_Sucesso = True

Long lvl_Linhas, &
	  lvl_Contador,   &
	  lvl_Filial, &
	  lvl_Produto,&
	  lvl_Pedido
	  
String lvs_Situacao, &
       lvs_Cancelar

If Not wf_Linhas_Selecionadas() Then Return

If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o cancelamento dos produtos selecionados?", Question!, YesNo!, 2) = 2 Then
	Return
End If
	
SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Cancelando Pend$$HEX1$$ea00$$ENDHEX$$ncias dos Produtos..."

lvl_Linhas = dw_2.Rowcount()

w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)

For lvl_Contador = 1 To lvl_Linhas
	lvs_Situacao = dw_2.Object.Id_Situacao[lvl_Contador]
	lvs_Cancelar = dw_2.Object.Id_Cancelar[lvl_Contador]
	
	If lvs_Situacao = "C" and lvs_Cancelar = "S" Then
		lvl_Filial		= dw_2.Object.cd_Filial       			[lvl_Contador]
		lvl_Pedido	= dw_2.Object.nr_Pedido_Empurrado[lvl_Contador]
		lvl_Produto	= dw_2.Object.cd_produto         		[lvl_Contador]
		
		If Not io_Pedido.of_Cancela_Produto_Pedido(lvl_Filial, lvl_Pedido, lvl_Produto) Then
			lvb_Sucesso = False
			Exit
		End If
	End If

	w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next

Close(w_Aguarde)

If lvb_Sucesso Then
	SqlCa.of_Commit()
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cancelamento realizado com sucesso.")
	
	dw_2.Event ue_Retrieve()
	
	cb_check.Text       = 'Todos &Produtos'
Else
	SqlCa.of_RollBack()
End If

SetPointer(Arrow!)
end event

type cb_check from commandbutton within w_ge129_relatorio_produtos_empurrados
integer x = 2665
integer y = 312
integer width = 466
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
string text = "Todos &Produtos"
end type

event clicked;Char lvc_Check

Long lvl_Linhas, &
     lvl_Contador

lvl_Linhas = dw_2.RowCount()

If lvl_Linhas > 0 Then
		
	If This.Text = 'Todos &Produtos' Then
		lvc_Check = 'S'
		This.Text = '&Nenhum &Produto'
	Else
		lvc_Check = 'N'
		This.Text = 'Todos &Produtos'
	End If
	
	For lvl_Contador = 1 To lvl_Linhas
		If dw_2.Object.id_situacao[lvl_Contador] = 'C' Then
			dw_2.Object.id_cancelar[lvl_Contador] = lvc_Check
		End If
	Next 
	
End If
end event

type cb_salvar from commandbutton within w_ge129_relatorio_produtos_empurrados
integer x = 2098
integer y = 312
integer width = 521
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Salvar em Excel"
end type

event clicked;//Boolean lvb_Existe
//
//String lvs_Arquivo
//
//Integer lvi_Retorno
//
//lvs_Arquivo = "c:\sistemas\co\arquivos\pedidos_empurrados.xls"
//
//lvb_Existe = FileExists(lvs_Arquivo)
//
//If lvb_Existe Then
//
//	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + lvs_Arquivo + "' j$$HEX1$$e100$$ENDHEX$$ existe. ~r~r" + "Deseja substitu$$HEX1$$ed00$$ENDHEX$$-lo ?", Question!, YesNoCancel!, 1) = 1 Then
//		lvb_Existe = False // Vai substituir
//	End If
//End If
//
//If Not lvb_Existe Then
//
//	lvi_Retorno = dw_2.SaveAs(lvs_Arquivo, Excel!, True)
//	
//	If lvi_Retorno = 1 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + lvs_Arquivo + "' foi gerado com sucesso.")
//	Else
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Arquivo + "'.", StopSign!)
//	End If
//End If

dw_2.Event ue_SaveAs()
end event

type dw_4 from dc_uo_dw_base within w_ge129_relatorio_produtos_empurrados
integer x = 55
integer y = 1832
integer width = 5051
integer height = 472
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge129_lista_dados"
boolean vscrollbar = true
end type

type gb_3 from groupbox within w_ge129_relatorio_produtos_empurrados
integer x = 23
integer y = 1780
integer width = 5659
integer height = 532
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de atendimento"
end type

