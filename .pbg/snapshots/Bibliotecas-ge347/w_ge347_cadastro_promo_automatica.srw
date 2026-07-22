HA$PBExportHeader$w_ge347_cadastro_promo_automatica.srw
forward
global type w_ge347_cadastro_promo_automatica from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge347_cadastro_promo_automatica
end type
type dw_2 from dc_uo_dw_base within w_ge347_cadastro_promo_automatica
end type
end forward

global type w_ge347_cadastro_promo_automatica from dc_w_response_ok_cancela
integer width = 2158
integer height = 592
string title = "GE347 - Cadastrar Promo$$HEX2$$e700f500$$ENDHEX$$es Vinculadas"
cb_1 cb_1
dw_2 dw_2
end type
global w_ge347_cadastro_promo_automatica w_ge347_cadastro_promo_automatica

type variables
uo_ge216_filiais	io_Selecao_filiais
uo_filial				io_filial
dc_uo_ds_base		ids_Rede

Long il_Lojas

String is_filiais
end variables

forward prototypes
public function boolean wf_le_dados_planilha ()
public function boolean wf_localiza_produto (long al_produto, long al_linha)
end prototypes

public function boolean wf_le_dados_planilha ();Any la_Dado

DateTime ldh_Inicio
DateTime ldh_Termino
DateTime ldh_Inicio_Min
DateTime ldh_Termino_Min

Decimal ldc_Pc_Desc
Decimal ldc_Pc_Desc_Clube

Long ll_Linha_Dw
Long ll_Linha
Long ll_Linhas
Long ll_Produto
Long ll_Qt_Min
Long ll_Sequ

String ls_Desc_Grupo
String ls_Arquivo
String ls_Nome_Promocao
String ls_Bloq_Pre
String ls_Fil_Alter_Min
String ls_Tipo_Repl
String ls_Descricao_Promo

Try

	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	ls_Arquivo = dw_1.Object.Nm_Arquivo[1]
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Importando o arquivo: " + ls_Arquivo + "..."

	SetRedraw(False)
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
		
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			For ll_Linha = 1 To ll_Linhas
						
				//Cd_Produto
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
					
				If Not IsNumber(String(la_Dado)) Or IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do produto $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido. ~rColuna 'A' na linha '" + String(ll_Linha) + ".", StopSign!)
					Return False
				End If	
								
				If Not wf_Localiza_Produto(Long(la_Dado), ll_Linha) Then Return False
				
				ll_Produto = Long(la_Dado)
								
				//DescPromocao
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
				
				If Not IsNumber(String(la_Dado)) Or IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Percentual de desconto da promo$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido. ~rColuna 'B' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ldc_Pc_Desc = Dec(la_Dado)
				
				If ldc_Pc_Desc > 100.00 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desconto clube n$$HEX1$$e300$$ENDHEX$$o pode ser maior que 100%. ~rColuna 'B' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				//DescClube
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "C")
				
				If Not IsNumber(String(la_Dado)) Or IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Percentual de desconto do clube $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido. ~rColuna 'C' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ldc_Pc_Desc_Clube = Dec(la_Dado)
				
				If ldc_Pc_Desc_Clube > 100.00 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desconto do clube n$$HEX1$$e300$$ENDHEX$$o pode ser maior que 100%. ~rColuna 'C' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If
								
				//NomePromocao
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "D")
				
				If IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nome da promo$$HEX2$$e700e300$$ENDHEX$$o deve ser informada. ~rColuna 'D' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ls_Nome_Promocao = Upper(String(la_Dado))
				
				//Bloq_Alt_Preco
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "E")
				
				If (IsNull(la_Dado)) Or (String(la_Dado) <> "S" And String(la_Dado) <> "N") Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O campo de bloquear altera$$HEX2$$e700e300$$ENDHEX$$o pre$$HEX1$$e700$$ENDHEX$$o deve ser 'S' ou 'N'. ~rColuna 'E' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ls_Bloq_Pre = String(la_Dado)
				
				//Filial_Alte_Est_Min
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "F")
				
				If (IsNull(la_Dado)) Or (String(la_Dado) <> "S" And String(la_Dado) <> "N") Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O campo de altera$$HEX2$$e700e300$$ENDHEX$$o do m$$HEX1$$ed00$$ENDHEX$$nimo na filial deve ser 'S' ou 'N'. ~rColuna 'F' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ls_Fil_Alter_Min = String(la_Dado)
				
				//Tp_Replica
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "G")
				
				If IsNull(la_Dado) Or (String(la_Dado) <> "M" And String(la_Dado) <> "T") Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O campo de tipo replica$$HEX2$$e700e300$$ENDHEX$$o deve ser 'M' ou 'T'. ~rColuna 'G' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ls_Tipo_Repl = String(la_Dado)
								
				//dt_ini_venda
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "H")
				
				If IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o deve ser informada. Coluna 'H' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				If (DateTime(la_Dado) < DateTime(Date(gf_GetServerDate()))) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A de data de in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data atual. ~rColuna 'H' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ldh_Inicio = DateTime(la_Dado)
				
				//dt_term_venda
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "I")
				
				If IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o deve ser informada. ~rColuna 'I' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				If (DateTime(la_Dado)) < ldh_Inicio Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data in$$HEX1$$ed00$$ENDHEX$$cio. ~rColuna 'I' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ldh_Termino = DateTime(la_Dado)
				
				//dt_ini_em
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "J")
				
				If IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio do estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser informada. ~rColuna 'J' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				If (DateTime(la_Dado)) > ldh_Termino Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio do estoque m$$HEX1$$ed00$$ENDHEX$$nimo n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o. ~rColuna 'J' '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ldh_Inicio_Min = DateTime(la_Dado)
				
				//dt_term_em
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "K")
				
				If IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino do estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser informada. ~rColuna 'K' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				If (DateTime(la_Dado)) < ldh_Inicio_Min Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino do estoque m$$HEX1$$ed00$$ENDHEX$$nimo n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data de in$$HEX1$$ed00$$ENDHEX$$cio do estoque m$$HEX1$$ed00$$ENDHEX$$nimo. ~rColuna 'K' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ldh_Termino_Min = DateTime(la_Dado)
				
				//Desc_promocao
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "L")
				
				If IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O campo de descri$$HEX2$$e700e300$$ENDHEX$$o da promo$$HEX2$$e700e300$$ENDHEX$$o deve ser informado. ~rColuna 'L' linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ls_Descricao_Promo = Upper(String(la_Dado))
				
				//Rede_Libera				
				//Desc_grupo
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "M")
				
				If IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O campo de descri$$HEX2$$e700e300$$ENDHEX$$o do grupo deve ser informado. ~rColuna 'M' linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If

				ls_Desc_Grupo = String(la_Dado)
				
				//qt_min
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "N")
					
				If Not IsNumber(String(la_Dado)) Or IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade de estoque m$$HEX1$$ed00$$ENDHEX$$nimo inv$$HEX1$$e100$$ENDHEX$$lido. ~rColuna 'N' na linha '" + String(ll_Linha) + "'.", StopSign!)
					Return False
				End If
			
				ll_Qt_Min = Long(la_Dado)
				
				//cd_prom_sos_aux
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "O")
				
				If dw_1.Object.Id_Tipo_Promocao[1] = "V" Then
					If IsNull(la_Dado) Or Not IsNumber(String(la_Dado)) Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial auxiliar inv$$HEX1$$e100$$ENDHEX$$lido. ~rColuna 'O' na linha '" + String(ll_Linha) + "'.", StopSign!)
						Return False
					End If
				End If
				
				ll_Sequ = Long(la_Dado)
																
				ll_Linha_Dw = dw_2.InsertRow(0)
				dw_2.Object.Cd_Produto				[ll_Linha_Dw] = ll_Produto
				dw_2.Object.DescPromocao			[ll_Linha_Dw] = ldc_Pc_Desc
				dw_2.Object.DescClube				[ll_Linha_Dw] = ldc_Pc_Desc_Clube
				dw_2.Object.Nome_Promocao		[ll_Linha_Dw] = ls_Nome_Promocao
				dw_2.Object.Bloq_Alt_Preco			[ll_Linha_Dw] = ls_Bloq_Pre
				dw_2.Object.Filial_Alte_Est_Min	[ll_Linha_Dw] = ls_Fil_Alter_Min
				dw_2.Object.Tp_Replica				[ll_Linha_Dw] = ls_Tipo_Repl
				dw_2.Object.Dt_Ini_Venda			[ll_Linha_Dw] = ldh_Inicio
				dw_2.Object.Dt_Term_Venda		[ll_Linha_Dw] = ldh_Termino
				dw_2.Object.Dt_Ini_Em				[ll_Linha_Dw] = ldh_Inicio_Min
				dw_2.Object.Dt_Term_Em			[ll_Linha_Dw] = ldh_Termino_Min
				dw_2.Object.Desc_Promocao		[ll_Linha_Dw] = ls_Descricao_Promo
				dw_2.Object.Desc_Grupo			[ll_Linha_Dw] = ls_Desc_Grupo
				dw_2.Object.Qtd_Min					[ll_Linha_Dw] = ll_Qt_Min
				dw_2.Object.Cd_Prom_Sos_Aux	[ll_Linha_Dw] = ll_Sequ

				w_Aguarde.Title = "Importando registro " + String(ll_Linha) + " de " + String(ll_Linhas)
				w_aguarde.uo_progress.of_setprogress(ll_Linha)
			Next
		End If
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de clicar no bot$$HEX1$$e300$$ENDHEX$$o [Cadastrar Promo$$HEX2$$e700f500$$ENDHEX$$es] para gravar as promo$$HEX2$$e700f500$$ENDHEX$$es.")
		dw_2.Sort()
	End If
	
	Return True

Finally
	SetRedraw(True)
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
End Try
end function

public function boolean wf_localiza_produto (long al_produto, long al_linha);Long ll_Achou

Select Count(*)
	Into: ll_Achou
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto '" + String(al_Produto) + "'. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Achou = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto. ~rColuna 'A' na linha '" + String(al_Linha) + "'. " + SqlCa.SqlErrText, Exclamation!)
	Return False
End If

Return True
end function

on w_ge347_cadastro_promo_automatica.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_ge347_cadastro_promo_automatica.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_2)
end on

event close;call super::close;Destroy(io_Selecao_filiais)
Destroy(io_filial)
Destroy(ids_Rede)
end event

event ue_preopen;call super::ue_preopen;io_Selecao_filiais	= Create uo_ge216_filiais
io_filial				= Create uo_filial
ids_Rede				= Create dc_uo_ds_base
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge347_cadastro_promo_automatica
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge347_cadastro_promo_automatica
integer width = 2080
integer height = 344
integer weight = 700
string facename = "Verdana"
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge347_cadastro_promo_automatica
integer width = 2021
integer height = 248
string dataobject = "dw_ge347_selecao_promo_auto"
end type

event dw_1::itemchanged;call super::itemchanged;String ls_Nulo

Choose Case This.GetColumnName()
	Case "id_conjunto_filial"
		
			SetNull(ls_Nulo)
			
			is_filiais = ls_Nulo
			
			If Data = 'C' Then
								
				OpenWithParm(w_ge216_selecao_filiais, io_Selecao_filiais)
				
				il_Lojas = Message.DoubleParm
				
				If il_Lojas > 0 Then

					io_Filial.of_Inicializa()

//					dw_1.Object.cd_filial  		[1] = io_Filial.cd_filial
//					dw_1.Object.nm_fantasia	[1] = io_Filial.nm_fantasia

					is_filiais = io_Selecao_filiais.ivs_filiais

				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")					
				End If	
			End If
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge347_cadastro_promo_automatica
integer x = 1083
integer y = 376
integer width = 677
string text = "&Cadastrar Promo$$HEX2$$e700f500$$ENDHEX$$es"
end type

event cb_ok::clicked;call super::clicked;DateTime	ldh_dt_ini_venda, &
				ldh_dt_term_venda, &
		    		ldh_dt_ini_em, &
		    		ldh_dt_term_em, &
				ldh_data

Decimal	ldc_DescClube, &
			ldc_DescPromocao

Long ll_MaxPromo, &
	   ll_Linhas, &
	   ll_Linha, &
	   ll_LinhasFilial, &
	   ll_LinhaFilial, &
	   ll_qtd_min, &
	   ll_Filial, &
	   ll_Produto, &
	   ll_Linha_Rede, &
	   ll_Sequ, &
	   ll_Sequ_Ant
		
String	lvs_NomePromocao, &
	   	lvs_Bloq_Alt_Preco, &
	   	lvs_Filial_Alte_Est_Min, &
		lvs_Tp_Replica, &
		lvs_status, &
	 	lvs_Rede_Libera, &
		lvs_Desc_Promocao, &
		lvs_Tipo_Promocao, &
		lvs_Desc_grupo, &
		ls_Erro, &
		ls_Descricao

dw_1.AcceptText()
dw_2.AcceptText()

If il_Lojas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
	Return -1
End If

lvs_Tipo_Promocao = dw_1.Object.Id_Tipo_Promocao[1]

Choose Case lvs_Tipo_Promocao
	Case "N" //Nenhuma
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o tipo de promo$$HEX2$$e700e300$$ENDHEX$$o.")
		dw_1.Event ue_Pos(1, "id_tipo_promocao")
		Return -1
		
	Case "C" //PBM CLAMED
		ls_Descricao = "PBM CLAMED"
		
	Case "V" //Vinculada
		ls_Descricao = "VINCULADA"
		
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de promo$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o prevista para o cadastro em massa.")
		dw_1.Event ue_Pos(1, "id_tipo_promocao")
		Return -1
End Choose

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum dado foi importado via planilha.")
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a inclus$$HEX1$$e300$$ENDHEX$$o das promo$$HEX2$$e700f500$$ENDHEX$$es do tipo '" + ls_Descricao +"' ?", Question!, YesNo!, 2) = 2 Then Return -1

Try

	Open(w_Aguarde)
	w_aguarde.uo_progress.of_setmax(dw_2.RowCount())
	
	ldh_data = DateTime(gf_GetServerDate())
	
	If Not ids_Rede.of_ChangeDataObject("dw_ge347_rede") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a ds 'dw_ge347_rede'.", StopSign!)
		Return -1
	End If
	
	//Carrega a rede das filiais selecionadas
	ids_Rede.of_AppendWhere("cd_filial in (" + is_Filiais + ")")
	
	If ids_Rede.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'dw_ge347_rede'.", StopSign!)
		Return -1
	End If
	
	//	dc_uo_ds_base lds
	//	lds = Create dc_uo_ds_base
	//	
	//	If Not dw_2.Of_ChangeDataObject('ds_ge347_promocao_sos_vinculo_base') Then
	//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a ds 'ds_ge347_promocao_sos_vinculo_base'..", StopSign!)
	//		Return -1
	//	End If
	
	//	dc_uo_ds_base dw_2_filial
	//	dw_2_filial = Create dc_uo_ds_base
	//		
	//	If Not dw_2_filial.Of_ChangeDataObject('ds_ge347_promocao_sos_vinculo_base_filial') Then
	//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a ds 'ds_ge347_promocao_sos_vinculo_base_filial'.", StopSign!)
	//		Return -1
	//	End If
	
	//	ll_Linhas			= dw_2.Retrieve()
	//	ll_LinhasFilial	= dw_2_filial.Retrieve()
	ll_LinhasFilial	= UpperBound(io_Selecao_filiais.Cd_Filial[])
	
	For ll_Linha = 1 to dw_2.RowCount()
				
		lvs_status 					= dw_2.Object.id_status				[ll_Linha]
		ll_Produto					= dw_2.Object.cd_produto 			[ll_Linha]
		ldc_DescClube 				= dw_2.Object.descclube			[ll_Linha]
		ldc_DescPromocao 		= dw_2.Object.descpromocao		[ll_Linha]
		lvs_NomePromocao 		= dw_2.Object.nome_promocao	[ll_Linha]
	
		lvs_Bloq_Alt_Preco			= dw_2.Object.bloq_alt_preco		[ll_Linha]
		lvs_Filial_Alte_Est_Min	= dw_2.Object.filial_alte_est_min	[ll_Linha]
		lvs_Tp_Replica 				= dw_2.Object.tp_replica			[ll_Linha]
		lvs_Desc_grupo  			= dw_2.Object.desc_grupo			[ll_Linha]
		lvs_Desc_promocao		= dw_2.Object.desc_promocao		[ll_Linha]
		ll_qtd_min					= dw_2.Object.qtd_min				[ll_Linha]
	
		ldh_dt_ini_venda 			= dw_2.Object.dt_ini_venda 		[ll_Linha]
		ldh_dt_term_venda		= dw_2.Object.dt_term_venda		[ll_Linha]
		ldh_dt_ini_em 				= dw_2.Object.dt_ini_em 			[ll_Linha]
		ldh_dt_term_em 			= dw_2.Object.dt_term_em 		[ll_Linha]	
		ll_Sequ						= dw_2.Object.Cd_Prom_Sos_Aux	[ll_Linha]
		
		If ll_Sequ <> ll_Sequ_Ant Then
		
			//Maximo Codigo da Promo$$HEX2$$e700e300$$ENDHEX$$o : Tabela 1
			select max(cd_promocao_sos) +1
				Into :ll_MaxPromo
			From promocao_sos
			Using SqlCa;
		
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao caputar o c$$HEX1$$f300$$ENDHEX$$digo da pr$$HEX1$$f300$$ENDHEX$$xima promocao_sos. " + ls_Erro, StopSign!)
				Return -1
			End If
			
			// Primeiro Passo Grava na   promocao_sos
			Insert into promocao_sos(	  cd_promocao_sos, 
												  nm_promocao_sos, 
												  id_tipo_promocao, 
												  id_situacao, 
												  dh_inicio, 
												  dh_termino, 
												  id_filial_altera_estoque, 
												  dh_inicio_estoque_minimo, 
												  dh_termino_estoque_minimo,
												  id_preco_bloqueado, 
												  id_tipo_replicacao, 
												  nr_matricula_alteracao,
												  de_promocao )
			Values (	:ll_MaxPromo, :lvs_NomePromocao, :lvs_Tipo_Promocao, 'L', :ldh_dt_ini_venda, :ldh_dt_term_venda, :lvs_Filial_Alte_Est_Min,
						:ldh_dt_ini_em, :ldh_dt_term_em, :lvs_Bloq_Alt_Preco, :lvs_Tp_Replica, :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, :lvs_Desc_promocao  )
			Using SqlCa;
									
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback();
				ls_Erro = SqlCa.SqlErrText
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a promocao_sos. " + ls_Erro, StopSign!)
				Return -1
			End If 	
		
			 // Segundo Passo Filial e Vinculos  : Tabela 2		 		 
			 For ll_Linha_Rede = 1 To ids_Rede.RowCount()
				lvs_Rede_Libera = ids_Rede.Object.Id_Rede_Filial[ll_Linha_Rede]
				
				Insert into promocao_sos_rede_filial( cd_promocao_sos, id_rede_filial ) values ( :ll_MaxPromo, :lvs_Rede_Libera)
				Using SqlCa;
			
				If SqlCa.SqlCode = -1 Then
					ls_Erro = SqlCa.SqlErrText
					SqlCa.of_Rollback();
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a promocao_sos_rede_filial. " + ls_Erro, StopSign!)
					Return -1
				End If
			Next
						
			 For ll_LinhaFilial = 1 to ll_LinhasFilial
		//		 ll_Filial = dw_2_filial.Object.cd_filial[ll_LinhaFilial] 
				 ll_Filial = io_Selecao_filiais.Cd_Filial[ll_LinhaFilial]
				  
				  // Tabela 3
				 Insert into promocao_sos_filial( cd_promocao_sos, cd_filial )  values ( :ll_MaxPromo, :ll_Filial )
				 Using SqlCa;
		
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_Rollback();
					ls_Erro = SqlCa.SqlErrText
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a promocao_sos_filial ." + ls_Erro, StopSign!)
					Return - 1
				End If
			 Next
		
			// Terceiro Passo  :  Tabela 4
			insert into promocao_sos_vinculo  ( cd_promocao_sos, nr_vinculo, de_vinculo, qt_vinculo ) 
			values (:ll_MaxPromo, 1, :lvs_Desc_grupo, :ll_qtd_min )
			Using SqlCA;
			  
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback();
				ls_Erro = SqlCa.SqlErrText
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a promocao_sos_vinculo. " + ls_Erro, StopSign!)
				Return -1
			End If
			
			SqlCa.of_commit();
		End If
		
		// Quarto Passo : Tabela 5
		insert into promocao_sos_vinculo_prd  (cd_promocao_sos, nr_vinculo, cd_produto ) 
		values (:ll_MaxPromo , 1, :ll_Produto ) 
		Using SqlCa;
		  
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback();
			ls_Erro = SqlCa.SqlErrText
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a promocao_vinculo_prd. " + ls_Erro, StopSign!)
			Return -1
		End If	
			  
		// Quinto Passo  : Tabela 6
		insert into promocao_sos_produto(cd_promocao_sos, cd_produto, pc_desconto, id_carregado_as400, dh_alteracao, nr_matricula_alteracao, pc_desconto_clube )
		values (:ll_MaxPromo,  :ll_Produto, :ldc_DescPromocao, 'N', :ldh_data, :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, :ldc_DescClube )
		  Using SqlCA;
	
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback();
			ls_Erro = SqlCa.SqlErrText
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a promocao_sos_produto. " + ls_Erro)
			Return -1
		End If	 
		 
	//		// tabela com os dados de origem  : Tabela 7
	//		Update promocao_vinculo_base
	//			set	id_status = 'E' , 
	//				cd_promocao = :ll_MaxPromo
	//		where Cd_Produto = :ll_Produto
	//		and id_status = 'P'
	//		Using SqlCa;
	//		
	//		If SqlCa.SqlCode = -1 Then
	//			SqlCa.of_Rollback();
	//			ls_Erro = SqlCa.SqlErrText
	//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a promocao_vinculo_base ." + ls_Erro, StopSign!)
	//			Return
	//		End If	 	
		
		SqlCa.of_Commit();
		
		ll_Sequ_Ant = ll_Sequ
		
		w_Aguarde.Title = "Gravando registro " + String(ll_Linha) + " de " + String(dw_2.RowCount())
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Promo$$HEX2$$e700f500$$ENDHEX$$es cadastradas.")
	dw_1.Event ue_Reset()
	dw_2.Event ue_Reset()
	dw_1.Event ue_AddRow()
	
Finally
	Close(w_Aguarde)
End Try
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge347_cadastro_promo_automatica
integer x = 1792
integer y = 376
end type

type cb_1 from commandbutton within w_ge347_cadastro_promo_automatica
integer x = 27
integer y = 376
integer width = 507
integer height = 100
integer taborder = 30
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

Long ll_Filial

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_1.AcceptText()

If dw_2.RowCount() > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha j$$HEX1$$e100$$ENDHEX$$ foi importada uma vez.~rDeseja desfazer e import$$HEX1$$e100$$ENDHEX$$-la novamente?", Question!, YesNo!, 2) = 2 Then Return -1
	dw_2.Event ue_Reset()
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r" + &
								"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto" + &
								"~rColuna B = Desconto da Promo$$HEX2$$e700e300$$ENDHEX$$o" + &
								"~rColuna C = Desconto do Clube" + &
								"~rColuna D = Nome da Promo$$HEX2$$e700e300$$ENDHEX$$o" + &
								"~rColuna E = Bloqueia Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o" + &
								"~rColuna F = Filial Altera o Estoque M$$HEX1$$ed00$$ENDHEX$$nimo" + &
								"~rColuna G = Tipo de Replica$$HEX2$$e700e300$$ENDHEX$$o" + &
								"~rColuna H = Data de In$$HEX1$$ed00$$ENDHEX$$cio da Promo$$HEX2$$e700e300$$ENDHEX$$o" + &
								"~rColuna I = Data de T$$HEX1$$e900$$ENDHEX$$rmino da Promo$$HEX2$$e700e300$$ENDHEX$$o" + &
								"~rColuna J = Data de In$$HEX1$$ed00$$ENDHEX$$cio do Estoque M$$HEX1$$ed00$$ENDHEX$$nimo" + &
								"~rColuna K = Data de T$$HEX1$$e900$$ENDHEX$$rmino do Estoque M$$HEX1$$ed00$$ENDHEX$$nimo" + &
								"~rColuna L = Descri$$HEX2$$e700e300$$ENDHEX$$o da Promo$$HEX2$$e700e300$$ENDHEX$$o" + &
								"~rColuna M = Descri$$HEX2$$e700e300$$ENDHEX$$o do Grupo" + &
								"~rColuna N = Quantidade de Estoque M$$HEX1$$ed00$$ENDHEX$$nimo" + &
								"~rColuna O = Sequencial Auxiliar (controla se haver$$HEX1$$e100$$ENDHEX$$ mais de um produto na promo$$HEX2$$e700e300$$ENDHEX$$o)")								
								//A coluna "O" serve para controlar se haver$$HEX1$$e100$$ENDHEX$$ mais de um produto na promo$$HEX2$$e700e300$$ENDHEX$$o
							  	//Estar$$HEX1$$e300$$ENDHEX$$o na mesma promo$$HEX2$$e700e300$$ENDHEX$$o os produtos que estiverem com o sequencial auxiliar repetido
				
li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.Nm_Arquivo[1] = Upper(ls_Arquivo)
	
	If Not wf_Le_Dados_Planilha() Then Return -1
Else
	SetNull(ls_Nulo)
	dw_1.Object.Nm_Arquivo[1] = ls_Nulo
End If
end event

type dw_2 from dc_uo_dw_base within w_ge347_cadastro_promo_automatica
boolean visible = false
integer x = 608
integer y = 604
integer width = 544
integer height = 212
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_ge347_promocao_sos_vinculo_base"
end type

