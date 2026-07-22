HA$PBExportHeader$w_ge539_altera_pmpf.srw
forward
global type w_ge539_altera_pmpf from dc_w_cadastro_selecao_lista
end type
type cb_importar from commandbutton within w_ge539_altera_pmpf
end type
type cb_gravar_pedido from commandbutton within w_ge539_altera_pmpf
end type
type dw_3 from dc_uo_dw_base within w_ge539_altera_pmpf
end type
type st_confirmar from statictext within w_ge539_altera_pmpf
end type
end forward

global type w_ge539_altera_pmpf from dc_w_cadastro_selecao_lista
string tag = "w_ge539_altera_pmpf"
string accessiblename = "Gera Pedido Almoxarifado (CO017)"
integer width = 3269
integer height = 1868
string title = "GE539 - Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dio Ponderado"
cb_importar cb_importar
cb_gravar_pedido cb_gravar_pedido
dw_3 dw_3
st_confirmar st_confirmar
end type
global w_ge539_altera_pmpf w_ge539_altera_pmpf

type variables
Boolean ivb_Check = True
Boolean ib_Alteracao = False






end variables

forward prototypes
public function boolean wf_le_dados_planilha ()
public function boolean wf_insere_log_alteracao (string ps_tabela, string ps_chave, string ps_coluna, string ps_matricula, string ps_tipo_alteracao, string ps_de, string ps_para)
public function boolean wf_exibe_formato_arquivo ()
end prototypes

public function boolean wf_le_dados_planilha ();Any la_Dado
Any la_Nulo

Decimal ldc_Preco_Medio
Decimal ldc_Fat_Conv

Long ll_Linha
Long ll_Linhas
Long ll_FatorConversao
Long ll_Achou
Long ll_Find
Long ll_Linha_Dw = 0
String ls_Arquivo
String ls_codigo_barras 
String ls_Cd_UF
Date ldt_inicio
String ls_Produto
String ls_Valor_PMPF
String ls_Fat_Conv

Try

dw_1.AcceptText()

dc_uo_excel lo_Excel
lo_Excel = Create dc_uo_excel

ls_Arquivo  = dw_1.Object.De_Arquivo	[1]
ls_Cd_UF   = dw_1.Object.cd_uf			[1] 
ldt_inicio    = dw_1.Object.dt_inicio		[1]

Open(w_Aguarde)
w_Aguarde.Title = "Importando o Arquivo: " + ls_Arquivo + "..."

SetRedraw(False)
dw_2.SetRedraw(False)

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
	
	ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		SetNull(la_Nulo)
		
		For ll_Linha = 1 To ll_Linhas
			
			If Mod(ll_Linha, 15)=0 Then
				w_aguarde.Title =  "Importando o Arquivo - Linha: " + String(ll_Linha)+" / "+String(ll_Linhas)	
			End If
			
			Choose Case ls_Cd_UF
				Case 'RS'
					// A - C$$HEX1$$f300$$ENDHEX$$digo EAN do Produto
					la_Dado				= lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
					ls_codigo_barras	= String (la_Dado)
					// B - Descricao 
					la_Dado		= lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
					ls_Produto	= String(la_Dado)
					// C - Valor Preco Medio						
					la_Dado			= lo_Excel.uo_Lendo_Dados(ll_Linha, "C")
					ls_Valor_PMPF	= String(la_Dado)		
					// D - Fator Conversao 
					la_Dado		= lo_Excel.uo_Lendo_Dados(ll_Linha, "D")
					ls_Fat_Conv	= String(la_Dado)
					
				Case 'SP'
					// A - N$$HEX1$$ba00$$ENDHEX$$ Item
					// B - C$$HEX1$$f300$$ENDHEX$$digo EAN do Produto
					la_Dado				= lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
					ls_codigo_barras	= String (la_Dado)
					// C - Produto		
					la_Dado		= lo_Excel.uo_Lendo_Dados(ll_Linha, "C")
					ls_Produto	= String(la_Dado)
					// D - Apresenta$$HEX2$$e700e300$$ENDHEX$$o
					la_Dado			= lo_Excel.uo_Lendo_Dados(ll_Linha, "D")
					ls_Produto		+= IIF(IsNull(la_Dado), "", " "+String(la_Dado))
					// E - Valor Preco Medio						
					la_Dado			= lo_Excel.uo_Lendo_Dados(ll_Linha, "E")
					ls_Valor_PMPF	= String(la_Dado)		
					// F - Fator Conversao 
					la_Dado		= lo_Excel.uo_Lendo_Dados(ll_Linha, "F")
					ls_Fat_Conv	= String(la_Dado)
					
				Case 'PR'
					// A - GTIN / EAN
					la_Dado				= lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
					ls_codigo_barras	= String (la_Dado)
					// B - Desc. Produto		
					la_Dado		= lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
					ls_Produto	= String(la_Dado)
					// C - Apresenta$$HEX2$$e700e300$$ENDHEX$$o
					la_Dado			= lo_Excel.uo_Lendo_Dados(ll_Linha, "C")
					ls_Produto		+= IIF(IsNull(la_Dado), "", " "+String(la_Dado))
					// D - Fator Conversao 
					la_Dado		= lo_Excel.uo_Lendo_Dados(ll_Linha, "D")
					ls_Fat_Conv	= String(la_Dado)
					// E - PMPF					
					la_Dado			= lo_Excel.uo_Lendo_Dados(ll_Linha, "E")
					ls_Valor_PMPF	= String(la_Dado)		
					
				Case Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "UF n$$HEX1$$e300$$ENDHEX$$o prevista para importa$$HEX2$$e700e300$$ENDHEX$$o PMPF.", Exclamation!)
					Return False
			End Choose
			
			//Normaliza$$HEX2$$e700e300$$ENDHEX$$o String
			ls_Valor_PMPF = gf_replace(ls_Valor_PMPF, " ", "", 0)
			
			//Valida$$HEX2$$e700e300$$ENDHEX$$o EAN
			If Not IsNumber(ls_codigo_barras) Or IsNull(ls_codigo_barras) Then
				If ll_Linha = 1 Then 
					Continue
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo EAN do produto "+ls_Produto+" inv$$HEX1$$e100$$ENDHEX$$lido na linha '" + String(ll_Linha) + "'. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista.", Exclamation!)
					Continue
				End If
			End If
			
			//Valida$$HEX2$$e700e300$$ENDHEX$$o PMPF
			If Not IsNumber(ls_Valor_PMPF) Or IsNull(ls_Valor_PMPF) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor M$$HEX1$$e900$$ENDHEX$$dio do produto "+ls_Produto+" deve ser informado na linha '" + String(ll_Linha) + "'. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista.", Exclamation!)
				Continue
			End If
			ldc_Preco_Medio = Dec(ls_Valor_PMPF)
			
			//Valida$$HEX2$$e700e300$$ENDHEX$$o Fator Convers$$HEX1$$e300$$ENDHEX$$o
			If Not IsNull(ls_Fat_Conv) Then
				If Not IsNumber(ls_Fat_Conv) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fator de Conversao do produto "+ls_Produto+" $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido na linha '" + String(ll_Linha) + "'. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ incluido na Lista.",  Exclamation!) 
					Continue
				End If
				ll_FatorConversao = Long(ls_Fat_Conv)
			Else
				SetNull(ll_FatorConversao)
			End If
			
			ll_Linha_Dw++
			
			dw_2.Object.de_codigo_barras		[ll_Linha_Dw] = ls_codigo_barras
			dw_2.Object.Vl_Fator_Conversao	[ll_Linha_Dw] = ll_FatorConversao			
			dw_2.Object.vl_preco_medio_ponderado_cf	[ll_Linha_Dw]  = ldc_Preco_Medio
			dw_2.Object.cd_uf						[ll_Linha_Dw] = ls_Cd_UF
			dw_2.Object.dt_inicio				[ll_Linha_Dw] = Date(ldt_inicio)
			dw_2.Object.id							[ll_Linha_Dw] = ll_Linha_Dw
			dw_2.Object.ds_produto				[ll_Linha_Dw] = ls_Produto

			dw_2.Object.Id_Selecionado[ll_Linha_Dw] = "S"		
			If Mod(ll_Linha, 15)=0 Then
				w_aguarde.uo_progress.Of_SetProgress(ll_Linha)		
			End If
		Next
	End If
End If

Finally
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)	
	ivb_Check = True
	
	dw_2.SetFocus()
	
	If dw_2.RowCount() > 0 Then
		Cb_Gravar_Pedido.Enabled = True
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para gravar os dados, pressione o bot$$HEX1$$e300$$ENDHEX$$o GRAVAR!")
	End If
	
	ivm_Menu.mf_Recuperar(False)
	ivm_Menu.mf_Incluir(False)
	ivm_Menu.mf_Excluir(False)
	dw_2.SetRedraw(True)
	SetRedraw(True)
End Try

Return True
end function

public function boolean wf_insere_log_alteracao (string ps_tabela, string ps_chave, string ps_coluna, string ps_matricula, string ps_tipo_alteracao, string ps_de, string ps_para);//Se for log de altera$$HEX2$$e700e300$$ENDHEX$$o e o campo n$$HEX1$$e300$$ENDHEX$$o tiver sido alterado n$$HEX1$$e300$$ENDHEX$$o grava
If ps_tipo_alteracao="A" and (gf_coalesce(ps_de, '')=gf_coalesce(ps_para, '')) Then Return True


//Insere LOG		
Insert Into historico_alteracao_tabela(nm_tabela, de_chave, nm_coluna, nr_matric_alteracao, id_alteracao, de_alteracao_de, de_alteracao_para)
Values (Upper(:ps_tabela), :ps_chave, :ps_coluna, :ps_matricula, :ps_tipo_alteracao, :ps_de, :ps_para)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es. Tabela "+ps_tabela+".~r~n"+SqlCa.SQLErrText, StopSign!)
	SqlCa.of_RollBack()
	Return False
End If
end function

public function boolean wf_exibe_formato_arquivo ();String lvs_UF

dw_1.AcceptText( )
lvs_UF = dw_1.Object.cd_uf [1]

Choose Case lvs_UF
	Case 'RS'
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r" + &
									"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo EAN do Produto" + &
									"~rColuna B = Descri$$HEX2$$e700e300$$ENDHEX$$o Produto" + &
									"~rColuna C = PMPF - Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dio Ponderado" + &
									"~rColuna D = Fator Convers$$HEX1$$e300$$ENDHEX$$o")
	Case 'SP'
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar conforme layout CAT-73/2021 e  Portaria SRE n$$HEX1$$b000$$ENDHEX$$ 064/2023 - SP:~r" + &
									"~rColuna A = Item" + &
									"~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo EAN do Produto" + &
									"~rColuna C = Descri$$HEX2$$e700e300$$ENDHEX$$o Produto" + &
									"~rColuna D = Apresenta$$HEX2$$e700e300$$ENDHEX$$o Produto" + &
									"~rColuna E = PMPF - Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dio Ponderado" + &
									"~rColuna F = Fator de Convers$$HEX1$$e300$$ENDHEX$$o")
		
	Case 'PR'
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar conforme layout NPF-44/2024:~r" + &
									"~rColuna A = GTIN / EAN" + &
									"~rColuna B = Descri$$HEX2$$e700e300$$ENDHEX$$o Produto" + &
									"~rColuna C = Apresenta$$HEX2$$e700e300$$ENDHEX$$o Produto" + &
									"~rColuna D = Fator de Convers$$HEX1$$e300$$ENDHEX$$o" + &
									"~rColuna E = PMPF - Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dio Ponderado~r~r" + &
									"Link: https://www.fazenda.pr.gov.br/Pagina/Pauta-de-Medicamentos")
									
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estado "+lvs_UF+" n$$HEX1$$e300$$ENDHEX$$o tem layout de importa$$HEX2$$e700e300$$ENDHEX$$o desenvolvido.", Exclamation!)		
		Return False
End Choose

Return True
end function

on w_ge539_altera_pmpf.create
int iCurrent
call super::create
this.cb_importar=create cb_importar
this.cb_gravar_pedido=create cb_gravar_pedido
this.dw_3=create dw_3
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importar
this.Control[iCurrent+2]=this.cb_gravar_pedido
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.st_confirmar
end on

on w_ge539_altera_pmpf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_importar)
destroy(this.cb_gravar_pedido)
destroy(this.dw_3)
destroy(this.st_confirmar)
end on

event ue_postopen;call super::ue_postopen;ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Incluir(False)

dw_1.Object.dt_inicio		[1] 	= RelativeDate(gf_retorna_ultimo_dia_mes( Today()), +1 )

end event

event ue_preopen;call super::ue_preopen;Maxheight = 9999

ivb_permite_fechar = False
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge539_altera_pmpf
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge539_altera_pmpf
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge539_altera_pmpf
integer y = 76
integer width = 2217
integer height = 196
string dataobject = "dw_ge539_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Date ldt_data  
ldt_data   =   RelativeDate( Today(), +1 )

If dwo.name = 'dt_inicio' then
	
	If Date(data) <= ldt_data  then
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O Campo DATA deve ser maior ou igual ao dia seguinte!", Exclamation!)
		Return -1
	End if
	
End if

end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge539_altera_pmpf
integer x = 32
integer y = 320
integer width = 3163
integer height = 1348
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge539_altera_pmpf
integer width = 2450
integer height = 280
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge539_altera_pmpf
event ue_mouse_move pbm_mousemove
integer x = 64
integer y = 380
integer width = 3086
integer height = 1260
string dataobject = "dw_ge539_lista"
string ivs_cor_linha_padrao = "if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)))"
end type

event dw_2::ue_mouse_move;If This.RowCount() > 0 Then
	If (xpos >= Long(This.Object.id_selecionado_t.X)  and (xpos <= (Long(This.Object.id_selecionado_t.X)  + 73))) and &
		  (ypos >= Long(This.Object.id_selecionado_t.Y)	and (ypos <= (Long(This.Object.id_selecionado_t.Y) + 64))) Then	 
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
ElseIf st_confirmar.Visible Then
	st_confirmar.Visible = False
End If
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
This.ivb_Ordena_Colunas = True
end event

event dw_2::doubleclicked;call super::doubleclicked;Long lvl_Row
String lvs_Marcacao

If dwo.Name = 'id_selecionado_t' Then	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	This.AcceptText()
	This.SetRedraw(False)
	For lvl_Row = 1 To This.RowCount()
		This.Object.Id_Selecionado[lvl_Row] = lvs_Marcacao
	Next
	This.SetRedraw(True)
End If
end event

event dw_2::editchanged;call super::editchanged;ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

If dwo.Name = "qtd_pedida" Then
	This.Object.Qt_Final[This.GetRow()] = This.Object.Vl_Fator_Conversao[This.GetRow()] * Long(Data)
End If
end event

event dw_2::itemchanged;call super::itemchanged;ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)


end event

type cb_importar from commandbutton within w_ge539_altera_pmpf
integer x = 2514
integer y = 44
integer width = 567
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Planilha"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_1.AcceptText()

If dw_2.RowCount() > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A arquivo j$$HEX1$$e100$$ENDHEX$$ foi importada. Deseja desfazer e import$$HEX1$$e100$$ENDHEX$$-la novamente?", Question!, YesNo!, 2) = 2 Then
		Return -1
	Else
		dw_2.Reset()
	End If
End If

If wf_Exibe_Formato_Arquivo( ) Then				
	li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS, Arquivo CSV (*.CSV),*.CSV")
	
	If li_Retorno = 1 Then 
		dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
		If Not wf_Le_Dados_Planilha() Then
			Return -1
		End If
	Else
		SetNull(ls_Nulo)
		dw_1.Object.De_Arquivo[1] = ls_Nulo
	End If
End If
end event

type cb_gravar_pedido from commandbutton within w_ge539_altera_pmpf
integer x = 2514
integer y = 164
integer width = 567
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Gravar"
end type

event clicked;Boolean lb_Sucesso = True
Long ll_Find
Long ll_Linha
Long ll_Fator
Long ll_Produto
Long ll_Nulo
Long ll_Contador

Decimal ldc_valor 
String ls_Erro
String ls_Selecionado
String ls_Ean
String ls_cd_uf

String lvs_Chave
String lvs_Tabela = "PMPF_VIGENCIA"
Decimal{2} lvdc_VL_PMPF_Ant
Decimal{3} lvdc_VL_Fat_Conv_Ant
String lvs_VL_PMPF_Ant
String lvs_VL_Fat_Conv_Ant
String lvs_VL_PMPF_Novo
String lvs_VL_Fat_Conv_Novo
String lvs_Nulo

Date ldt_inicio

Try
	SetNull(lvs_VL_Fat_Conv_Ant)
	SetNull(lvs_VL_PMPF_Ant)
	SetNull(lvs_VL_Fat_Conv_Novo)
	SetNull(lvs_VL_PMPF_Novo)
	SetNull(lvs_Nulo)
	SetNull(ll_Nulo)
	ib_Alteracao = False
	
	dw_2.AcceptText()
	dw_1.Accepttext( )
	ldt_inicio	= dw_1.Object.dt_inicio	[1]
	ls_cd_uf	= dw_1.Object.cd_uf		[1]   
	
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	ivm_Menu.mf_Excluir(False)
	
	dw_2.SetRedraw(False)
	dw_2.SetFilter("id_selecionado = 'S'")
	dw_2.Filter()
	
	If dw_2.RowCount() = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.", Exclamation!)
		dw_2.SetFocus()
		lb_Sucesso = False
		Return -1
	End If
	
	If ldt_inicio < Today() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "A data n$$HEX1$$e300$$ENDHEX$$o pode ser anterior a data atual, a data m$$HEX1$$ed00$$ENDHEX$$nima $$HEX1$$e900$$ENDHEX$$ amanh$$HEX1$$e300$$ENDHEX$$.", Exclamation!)
		lb_Sucesso = False
		Return -1
	End If
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja realmente importar a listagem de pre$$HEX1$$e700$$ENDHEX$$os ponderados para "+ls_cd_uf+" com in$$HEX1$$ed00$$ENDHEX$$cio em "+String(ldt_inicio, "DD/MM/YYYY")+" ?", Question!, YesNo!, 2) = 2 Then
		lb_Sucesso = False
		Return -1
	End If
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gravando os Dados..."
	w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())
	
	For ll_Linha = 1 To dw_2.RowCount()
	
		w_aguarde.Title =  "Gravando os Dados - Linha: " + String(ll_Linha)+" / "+String(dw_2.RowCount())						
			
		ll_Contador ++
		ll_Fator			= dw_2.Object.Vl_Fator_Conversao	[ll_Linha]
		ls_Ean			= dw_2.Object.de_codigo_barras		[ll_Linha]
		ldc_valor   		= dw_2.Object.vl_preco_medio_ponderado_cf[ll_Linha]      
		ls_Selecionado	= dw_2.Object.Id_Selecionado			[ll_Linha]
		lvs_Chave		= ls_cd_uf+'@#!'+String(ldt_inicio, 'DD/MM/YYYY')+'@#!'+ls_Ean
		
		Select 	count(1), 
					cast(max(vl_preco_medio_ponderado_cf) as varchar) as vl_preco_medio_ponderado_cf,
					cast(max(vl_fator_conversao) as varchar) as vl_fator_conversao
		Into :ll_Find, :lvdc_VL_PMPF_Ant, :lvdc_VL_Fat_Conv_Ant
		From  pmpf_vigencia      
		Where cd_uf   				=:ls_cd_uf 
		And 	 de_codigo_barras	=:ls_Ean
		And 	dh_inicio				=:ldt_inicio
		Using SqlCA;

		If ll_Find =1  Then 
			Update  pmpf_vigencia
			Set  vl_preco_medio_ponderado_cf	= :ldc_valor ,
				 vl_fator_conversao					= :ll_Fator
			Where  cd_uf   				=:ls_cd_uf 
			And 	 de_codigo_barras	=:ls_Ean
			And 	dh_inicio				=:ldt_inicio
			Using SqlCa;	
			
			If SqlCA.SqlCode = -1 then
				MessageBox("Erro na Altera$$HEX2$$e700e300$$ENDHEX$$o dos Dados: Tabela: "+lvs_Tabela, SQLCA.SQLErrText)
				lb_Sucesso = False
				Return -1
			End If 
			
			//Armazena valores novos para grava$$HEX2$$e700e300$$ENDHEX$$o de log
			lvs_VL_Fat_Conv_Ant		= String(lvdc_VL_Fat_Conv_Ant, "###0.000")
			lvs_VL_PMPF_Ant			= String(lvdc_VL_PMPF_Ant, "#####0.00")
			lvs_VL_Fat_Conv_Novo	= String(ll_Fator, "###0.000")
			lvs_VL_PMPF_Novo		= String(ldc_valor, "#####0.00")
			
			If Not wf_Insere_Log_Alteracao(lvs_Tabela, lvs_Chave, 'VL_FATOR_CONVERSAO', gvo_aplicacao.ivo_seguranca.nr_matricula, "A", lvs_VL_Fat_Conv_Ant, lvs_VL_Fat_Conv_Novo) Then Return -1
			If Not wf_Insere_Log_Alteracao(lvs_Tabela, lvs_Chave, 'VL_PRECO_MEDIO_PONDERADO_CF', gvo_aplicacao.ivo_seguranca.nr_matricula, "A", lvs_VL_PMPF_Ant, lvs_VL_PMPF_Novo) Then Return -1									
		Else			
			Insert Into pmpf_vigencia(cd_uf, de_codigo_barras, dh_inicio, vl_preco_medio_ponderado_cf , vl_fator_conversao )
											 Values(:ls_cd_uf, :ls_Ean , :ldt_inicio, :ldc_valor, :ll_Fator)
			Using SqlCa;	
			
			If SqlCA.SqlCode = -1 then
				MessageBox("Erro na Inclus$$HEX1$$e300$$ENDHEX$$o dos Dados: Tabela: pmpf_vigencia", SQLCA.SQLErrText)
				lb_Sucesso = False
				Return -1
			End If 
			
			If Not wf_Insere_Log_Alteracao(lvs_Tabela, lvs_Chave, '', gvo_aplicacao.ivo_seguranca.nr_matricula, "I", lvs_Nulo, lvs_Nulo) Then Return -1
		End If 
					
		SQLCa.Of_Commit()
		w_aguarde.uo_progress.Of_SetProgress(ll_Linha)			
	Next

Catch (RuntimeError lvo_Erro)
	lb_Sucesso = False
	MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	Return -1
	
Finally
	If IsValid(w_Aguarde) Then Close(w_Aguarde)	
	If lb_Sucesso Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dado (s) gravado(s) com sucesso.")
	dw_2.Event ue_Reset()
	ivm_Menu.mf_Excluir(False)
	cb_gravar_pedido.Enabled = False
	
	dw_2.SetFilter("")
	dw_2.Filter()
	dw_2.SetRedraw(True)
	ivb_Check = False
End Try
end event

type dw_3 from dc_uo_dw_base within w_ge539_altera_pmpf
boolean visible = false
integer x = 2185
integer y = 1168
integer taborder = 20
boolean bringtotop = true
end type

type st_confirmar from statictext within w_ge539_altera_pmpf
boolean visible = false
integer x = 1975
integer y = 396
integer width = 1001
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
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
alignment alignment = right!
boolean focusrectangle = false
end type

