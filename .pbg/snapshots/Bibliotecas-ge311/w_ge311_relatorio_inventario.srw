HA$PBExportHeader$w_ge311_relatorio_inventario.srw
forward
global type w_ge311_relatorio_inventario from dc_w_sheet
end type
type cb_excel from commandbutton within w_ge311_relatorio_inventario
end type
type gb_3 from groupbox within w_ge311_relatorio_inventario
end type
type dw_2 from dc_uo_dw_base within w_ge311_relatorio_inventario
end type
type gb_1 from groupbox within w_ge311_relatorio_inventario
end type
type gb_2 from groupbox within w_ge311_relatorio_inventario
end type
type dw_3 from dc_uo_dw_base within w_ge311_relatorio_inventario
end type
type dw_1 from dc_uo_dw_base within w_ge311_relatorio_inventario
end type
type cb_selecao_filial from commandbutton within w_ge311_relatorio_inventario
end type
type cb_selecao_grupo from commandbutton within w_ge311_relatorio_inventario
end type
type dw_4 from dc_uo_dw_base within w_ge311_relatorio_inventario
end type
type dw_5 from dc_uo_dw_base within w_ge311_relatorio_inventario
end type
type dw_6 from dc_uo_dw_base within w_ge311_relatorio_inventario
end type
type cb_1 from commandbutton within w_ge311_relatorio_inventario
end type
type cb_2 from commandbutton within w_ge311_relatorio_inventario
end type
type cb_3 from commandbutton within w_ge311_relatorio_inventario
end type
type dw_7 from dc_uo_dw_base within w_ge311_relatorio_inventario
end type
type st_confirmar_grupo from statictext within w_ge311_relatorio_inventario
end type
type st_confirmar_filial from statictext within w_ge311_relatorio_inventario
end type
end forward

global type w_ge311_relatorio_inventario from dc_w_sheet
string tag = "w_relatorio_inventario"
integer width = 3319
integer height = 1832
string title = "GE311 - Relat$$HEX1$$f300$$ENDHEX$$rio de Invent$$HEX1$$e100$$ENDHEX$$rio (Novo)"
cb_excel cb_excel
gb_3 gb_3
dw_2 dw_2
gb_1 gb_1
gb_2 gb_2
dw_3 dw_3
dw_1 dw_1
cb_selecao_filial cb_selecao_filial
cb_selecao_grupo cb_selecao_grupo
dw_4 dw_4
dw_5 dw_5
dw_6 dw_6
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
dw_7 dw_7
st_confirmar_grupo st_confirmar_grupo
st_confirmar_filial st_confirmar_filial
end type
global w_ge311_relatorio_inventario w_ge311_relatorio_inventario

type variables
LONG lvi_Paginas

DATE ivdt_Parametro

BOOLEAN ivb_Cancelar
Boolean ivb_CheckGrupo = True
Boolean ivb_CheckFilial = True

STRING ivs_SQL_Grupo
end variables

forward prototypes
public function string wf_grupos_selecionados ()
public subroutine wf_preenche_resumo (long cd_filial, string ps_total_grupo[], decimal pdc_total_grupo[])
public subroutine wf_gera_inventario (long cd_filial, date dt_inventario)
public subroutine wf_imprime_inventario ()
public subroutine wf_preenche_termos (long cd_filial)
public function string wf_identifica_rede (integer al_filial)
public function string wf_filiais_selecionadas ()
public subroutine wf_gera_excel (datawindow lvds_excel)
end prototypes

public function string wf_grupos_selecionados ();Long   lvl_Row, lvl_Linhas, lvl_Selecao

String lvs_SQL

lvs_SQL = ''

lvl_Linhas = dw_3.RowCount()

For lvl_Row = 1 To lvl_Linhas
	
	If dw_3.Object.Id_Selecao[lvl_Row] = 'S' Then
		
		lvs_SQL += "'"+String(dw_3.Object.cd_grupo [lvl_Row]) + "',"
			
		lvl_Selecao += 1
		
	End If
	
Next

If lvl_Selecao = lvl_Linhas Then
	lvs_SQL = ''
Else
	lvs_SQL = LeftA(lvs_SQL,LenA(lvs_SQL)-1)
	lvs_SQL = 'g.cd_grupo in ('+lvs_SQL+')'
End If

Return lvs_SQL
end function

public subroutine wf_preenche_resumo (long cd_filial, string ps_total_grupo[], decimal pdc_total_grupo[]);Long   lvl_Row, lvl_Linhas, lvl_Insert, lvl_Linha, lvl_Filial

String lvs_Tipo

Decimal{2} lvdc_Total

Date    lvdt_Inventario

lvdt_Inventario = dw_1.Object.dt_inventario[1]

lvs_Tipo   = ''

lvl_Linhas = dw_5.Retrieve(cd_filial)

lvl_Linha  = 0

FOR lvl_Row = 1 TO lvl_Linhas	
	lvl_Linha ++
	dw_5.Object.linha[lvl_Row] = lvl_Linha
NEXT	

lvl_Linhas = UpperBound(ps_total_grupo)

FOR lvl_Row = 1 TO lvl_Linhas
	
	lvl_Filial = dw_5.Object.cd_filial[1]
	
	If wf_identifica_rede(lvl_filial) = 'DP' Then
		dw_5.Object.st_rede.text = "DROGARIA PRE$$HEX1$$c700$$ENDHEX$$O POPULAR"
	Else
		dw_5.Object.st_rede.text = "CIA LATINO AMERICANA DE MEDICAMENTOS"
	End If
	
	dw_5.Object.st_mes_ano.text = LeftA(Upper(gf_mes_extenso(Month(lvdt_inventario))),3)+'/'+String(Year(lvdt_inventario),'0000')
	
	lvl_Linha ++
	
	lvl_Insert = dw_5.InsertRow(0)
	
	dw_5.Object.Linha[lvl_Insert] = lvl_Linha
	dw_5.Object.Grupo[lvl_Insert] = LeftA(ps_total_grupo[lvl_Row],1)

	dw_5.Object.Msg  [lvl_Insert] = MidA(ps_total_grupo[lvl_Row],2)
	dw_5.Object.Valor[lvl_Insert] = pdc_total_grupo[lvl_Row]

NEXT

IF dw_1.Object.Id_Tipo[1] = 'A' THEN
	lvi_Paginas ++
	dw_5.Object.nr_pagina_atual.Expression = String(lvi_Paginas,'0000')
ELSE
	dw_5.Object.nr_pagina_atual.Expression = String(1,'0000')
END IF	

dw_5.SetSort('grupo a, linha a')
dw_5.Sort()
dw_5.GroupCalc()
end subroutine

public subroutine wf_gera_inventario (long cd_filial, date dt_inventario);Long	lvl_Linhas
Long	lvl_Contador
Long	lvl_Qt_Linhas
Long	lvl_Posicao
Long	lvl_Copiar
Long	lvl_Row
Long	lvl_Linhas_Pagina
Long	lvl_Aux
Long	lvs_Filial

Decimal{2}	lvdc_Total_Pagina
Decimal{2}	lvdc_Total_Transporte
Decimal{2}	lvdc_Total
Decimal{2}	lvdc_Total_Grupo
Decimal{2}	lvdc_Valor_Grupo[]

Integer	lvl_Ind

String	lvs_Mensagem, lvs_Total_Grupo[]

Boolean	lvb_Quebra

SetPointer(HourGlass!)

w_Aguarde.uo_Progress.Of_SetStart()
w_Aguarde.Title = 'Carregando Dados da Filial (' + String(cd_filial,'0000') + ')'

IF ivs_SQL_Grupo <> '' THEN dw_4.Of_AppendWhere(ivs_SQL_Grupo)

// Se for filial 534, contabiliza os produtos da filial 1 tamb$$HEX1$$e900$$ENDHEX$$m
If cd_filial = 534 Then
	lvl_Linhas = dw_4.Retrieve(cd_filial,1,dt_inventario)
Else
	lvl_Linhas = dw_4.Retrieve(cd_filial,cd_filial,dt_inventario)
End If

lvi_Paginas = 2

IF lvl_Linhas > 0 THEN
	
	w_Aguarde.Title = 'Gerando Invent$$HEX1$$e100$$ENDHEX$$rio da Filial (' + String(cd_filial,'0000') + ')'
	
	lvdc_Total 				 	= 000.00
	lvdc_Total_Pagina 	 		= 000.00
	lvdc_Total_Grupo      		= 000.00
	lvdc_Total_Transporte 	= 000.00
	
	dw_4.Object.st_mes_ano.text = LeftA(Upper(gf_mes_extenso(Month(dt_inventario))),3)+'/'+String(Year(dt_inventario),'0000')
	
	lvl_Posicao = 0
	lvl_Row     = 0
	
	lvb_Quebra = FALSE
	
	lvl_Linhas_Pagina = 43
	
	lvl_Aux = 0
	
	w_Aguarde.uo_Progress.Of_SetMax(dw_4.RowCount())
	
	FOR lvl_Contador = 1 TO lvl_Linhas
				
		IF KeyDown(KeyEscape!) THEN
			IF MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja cancelar gera$$HEX2$$e700e300$$ENDHEX$$o dos invent$$HEX1$$e100$$ENDHEX$$rios ?",Question!,YesNo!,2) = 1 THEN
				ivb_Cancelar = TRUE
				EXIT				
			END IF	
		END IF
		
		lvs_Filial	= dw_4.Object.cd_filial[1]
		
		If wf_identifica_rede(lvs_Filial) = 'DP' Then
			dw_4.Object.st_rede.text = "DROGARIA PRE$$HEX1$$c700$$ENDHEX$$O POPULAR"
		Else
			dw_4.Object.st_rede.text = "CIA. LATINO AMERICANA DE MEDICAMENTOS"
		End If
		
		lvdc_Total = dw_4.GetItemDecimal(lvl_Contador,"vl_total_produto")
		
		lvdc_Total_Grupo			+= lvdc_Total
		lvdc_Total_Pagina			+= lvdc_Total
 		lvdc_Total_Transporte	+= lvdc_Total
		
		w_Aguarde.uo_Progress.Of_SetProgress(lvl_Contador)				
		
		lvl_Posicao = lvl_Contador + 1
		
		IF lvl_Contador > 1 and lvl_Posicao <= lvl_Linhas THEN
		   IF dw_4.Object.Id_proprio_consignado[lvl_Contador] <> dw_4.Object.Id_proprio_consignado[lvl_Posicao] or &
				dw_4.Object.cd_grupo	[lvl_Contador] <> dw_4.Object.cd_grupo [lvl_Posicao] THEN
				
				lvb_Quebra = TRUE			
				
				lvl_Ind ++			
				lvs_Total_Grupo	[lvl_Ind] = dw_4.Object.Id_proprio_consignado[lvl_Contador] + dw_4.Object.de_grupo	 [lvl_Contador] + ' (000' + dw_4.Object.cd_grupo[lvl_Contador] + ')'
				lvdc_Valor_Grupo	[lvl_Ind] = lvdc_Total_Grupo
				lvdc_Total_Grupo  = 000.00
				
			END IF			
		END IF
		
		IF dw_1.Object.id_Tipo[1] = 'A' THEN
		
			IF lvl_Contador <= 43 THEN
				lvl_Qt_Linhas = 43
			ELSE
				IF lvl_Aux = 0 THEN
					lvl_Qt_Linhas = 42
				ELSE
					lvl_Qt_Linhas = 43
				END IF
			END IF
			
			lvl_Row += 1
															
			dw_4.Object.linha[lvl_Contador] = lvl_Contador
			
			IF lvl_Row = lvl_Qt_Linhas and lvl_Aux = 1 THEN lvl_Aux = 0
			
			IF ( lvl_Row = lvl_Qt_Linhas and lvl_Contador <> lvl_Linhas ) or lvb_Quebra THEN
				
				lvl_Copiar   = lvl_Contador
					
				dw_4.RowsCopy(lvl_Copiar,lvl_Copiar,Primary!,dw_4,lvl_Copiar,Primary!)
				
				lvl_Contador += 1
				
				lvs_mensagem = "A TRANSPORTAR : " + String(lvdc_Total_Transporte,"###,###,##0.00") + SPACE(30) + " TOTAL P$$HEX1$$c100$$ENDHEX$$GINA : " + String(lvdc_Total_Pagina,"###,###,##0.00")
				
				dw_4.Object.msg_transporte	[lvl_Contador] = lvs_mensagem
				dw_4.Object.linha					[lvl_Contador] = lvl_Contador
				dw_4.Object.qt_saldo_final		[lvl_Contador] = 000.00

				lvdc_Total_Pagina = 000.00
				lvi_paginas = lvi_paginas + 1
				
				lvl_Linhas += 1
									
				IF NOT lvb_Quebra THEN
						
					lvl_Contador += 1
							
					dw_4.RowsCopy(lvl_Copiar,lvl_Copiar,Primary!,dw_4,lvl_Contador,Primary!)
				
					lvs_mensagem = "DE TRANSPORTE  : " + String(lvdc_Total_Transporte,"###,###,##0.00")
				
					dw_4.Object.msg_transporte	[lvl_Contador] = lvs_mensagem
					dw_4.Object.linha					[lvl_Contador] = lvl_Contador
					dw_4.Object.qt_saldo_final		[lvl_Contador] = 000.00
			
					lvl_Linhas += 1
					
				ELSE
					
					lvl_Aux = 1
					
				END IF
				
				lvl_Row = 0
				
				lvb_Quebra = FALSE
						
			END IF
			
		END IF	
		
		w_Aguarde.uo_Progress.Of_SetMax(dw_4.RowCount())
						
	NEXT	
	
	lvl_Ind ++			
	lvs_Total_Grupo	[lvl_Ind] = dw_4.Object.Id_proprio_consignado[lvl_Linhas] + dw_4.Object.de_grupo [lvl_Linhas] + ' (000' + dw_4.Object.cd_grupo[lvl_Linhas] + ')'
	lvdc_Valor_Grupo	[lvl_Ind] = lvdc_Total_Grupo
		
	dw_4.SetSort("id_proprio_consignado a, cd_grupo a, linha a, de_descricao_produto a")
	dw_4.Sort()
	dw_4.GroupCalc()
	
//	lvi_Paginas = dw_4.GetItemNumber(dw_4.RowCount(),"nr_pagina_atual")
	
	//Preenche dw de resumo do invent$$HEX1$$e100$$ENDHEX$$rio
   Wf_Preenche_Resumo(cd_filial,lvs_Total_Grupo[],lvdc_Valor_Grupo[])

	//Preenche Termos de Abertura e Encerramento
	Wf_Preenche_Termos(cd_filial)
	
	Wf_Imprime_Inventario()
	
ELSE
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem dados para gerar o invent$$HEX1$$e100$$ENDHEX$$rio da filial : " + String(cd_filial),Exclamation!)
END IF	

RETURN

end subroutine

public subroutine wf_imprime_inventario ();STRING lvs_Tipo

lvs_Tipo = dw_1.Object.id_tipo[1]

IF lvs_Tipo = 'A' THEN dw_4.Print() // Relat$$HEX1$$f300$$ENDHEX$$rio de Invent$$HEX1$$e100$$ENDHEX$$rio

dw_5.Print() // Resumo de Invent$$HEX1$$e100$$ENDHEX$$rio

IF lvs_Tipo = 'A' THEN dw_6.Print() // Termos de Encerramentos



end subroutine

public subroutine wf_preenche_termos (long cd_filial);STRING	lvs_Dia_Mes_Ano, &
			lvs_Cidade

INTEGER lvi_Mes, lvi_Ano

DATE    lvdt_Data

Long lvl_Ordem

dw_1.AcceptText()

IF dw_1.Object.Id_Tipo[1] = 'S' THEN RETURN

//lvi_Mes = Month(dw_1.Object.dt_inventario[1])
//lvi_Ano = Year(dw_1.Object.dt_inventario[1])

//lvi_Mes ++

//IF lvi_Mes = 13 THEN
//	lvi_Mes = 1
//	lvi_Ano += 1
//END IF	

//lvdt_Data = Date("01/"+String(lvi_Mes,'00')+'/'+String(lvi_Ano,'0000'))
//lvdt_Data = RelativeDate(lvdt_Data,-1)
//lvdt_data = today()

lvdt_Data = dw_1.Object.dt_inventario[1]

dw_6.Retrieve(cd_filial)
dw_6.Object.termo	[1] = 'A'
dw_6.Object.paginas	[1] = lvi_Paginas

lvs_Cidade = dw_6.Object.nm_cidade[1]
//lvs_Dia_Mes_Ano = lvs_Cidade + " " + String(Day(lvdt_Data),'00') + ' DE ' + UPPER(gf_mes_extenso(Month(lvdt_Data))) + ' DE ' + String(Year(lvdt_Data))
lvs_Dia_Mes_Ano = lvs_Cidade + " 01 DE " + UPPER(gf_mes_extenso(1)) + " DE " + String(Year(lvdt_Data))
dw_6.Object.dia_mes_ano[1] = lvs_Dia_Mes_Ano

dw_6.InsertRow(0)

lvs_Dia_Mes_Ano = lvs_Cidade + " 31 DE " + UPPER(gf_mes_extenso(12)) + " DE " + String(Year(lvdt_Data))
dw_6.Object.dia_mes_ano						[2] = lvs_Dia_Mes_Ano
dw_6.Object.cd_filial								[2] = dw_6.Object.cd_filial								[1]
dw_6.Object.nm_razao_social					[2] = dw_6.Object.nm_razao_social					[1]
dw_6.Object.nr_cgc								[2] = dw_6.Object.nr_cgc								[1]
dw_6.Object.nr_inscricao_estadual			[2] = dw_6.Object.nr_inscricao_estadual			[1]
dw_6.Object.nm_cidade							[2] = dw_6.Object.nm_cidade							[1]
dw_6.Object.de_endereco						[2] = dw_6.Object.de_endereco						[1]
dw_6.Object.de_bairro							[2] = dw_6.Object.de_bairro							[1]
dw_6.Object.cd_unidade_federacao			[2] = dw_6.Object.cd_unidade_federacao			[1]
dw_6.Object.nr_inscricao_junta_comercial	[2] = dw_6.Object.nr_inscricao_junta_comercial	[1]
dw_6.Object.dh_inscricao_junta_comercial	[2] = dw_6.Object.dh_inscricao_junta_comercial	[1]

lvl_Ordem = dw_1.Object.nr_ordem[1]

dw_6.Object.nr_ordem	[1] = lvl_Ordem
dw_6.Object.nr_ordem	[2] = lvl_Ordem

dw_6.Object.termo	[2] = 'E'
dw_6.Object.paginas	[2] = lvi_Paginas+1
//dw_6.Object.dia_mes_ano[2] = lvs_Dia_Mes_Ano

If wf_identifica_rede(cd_Filial) = 'DP' Then
	dw_6.Object.de_rede	[1] = "DROGARIA PRE$$HEX1$$c700$$ENDHEX$$O POPULAR"
	dw_6.Object.de_rede	[2] = "DROGARIA PRE$$HEX1$$c700$$ENDHEX$$O POPULAR"
	dw_6.Object.st_ass1.Text = "ANDREY BORNSCHEIN~r~nCPF: 048.189.789-57"
	dw_6.Object.st_ass2.Text = "MARIA ANGELA FRACARO~r~nCPF: 591.354.099-91~r~nCRC: 02538607"
Else
	dw_6.Object.de_rede	[1] = "CIA LATINO AMERICANA DE MEDICAMENTOS"
	dw_6.Object.de_rede	[2] = "CIA LATINO AMERICANA DE MEDICAMENTOS"
	dw_6.Object.st_ass1.Text = "ARTHUR KIEFER ~r~nCPF: 102.029.869-34"
	dw_6.Object.st_ass2.Text = "SONIA BRESCIANI MARIANO~r~nCPF: 486.247.999-53~r~nCRC:1SC025337O4"
End If

dw_6.SetSort('termo a')
dw_6.Sort()
dw_6.GroupCalc()

end subroutine

public function string wf_identifica_rede (integer al_filial);String lvs_Rede

Select vl_parametro
  into :lvs_Rede
  from parametro_loja
 where cd_filial = :al_filial
   and cd_parametro = 'ID_REDE_FILIAL'
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Rede da filial '" + String(al_filial) + "'")
	SetNull(lvs_Rede)
End If

Return lvs_Rede
end function

public function string wf_filiais_selecionadas ();Long lvl_Row
Long lvl_Linhas
Long lvl_Selecao

String lvs_Filiais

lvs_Filiais = ''

dw_1.AcceptText()

lvl_Linhas = dw_2.RowCount()

For lvl_Row = 1 To lvl_Linhas
	
	If dw_2.Object.Id_Selecao[lvl_Row] = 'S' Then
		
		lvs_Filiais += String(dw_2.Object.cd_filial[lvl_Row]) + ','
					
	End If
	
Next

If lvs_Filiais <> '' Then
	lvs_Filiais = LeftA(lvs_Filiais,LenA(lvs_Filiais)-1)
End If

Return lvs_Filiais
end function

public subroutine wf_gera_excel (datawindow lvds_excel);String lvs_Path,&
		lvs_Arquivo

Integer lvi_Retorno

If lvds_excel.RowCount() < 65000 Then
	lvi_retorno = GetFileSaveName('Arquivo', lvs_Path, lvs_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')
Else
	lvi_retorno = GetFileSaveName('Arquivo', lvs_Path, lvs_Arquivo, 'csv', 'Planilha Excel (*.csv),*.csv')
End If

If lvi_retorno = 1 Then
	
	// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
	If FileExists(lvs_Path) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Path + "' existente ?", Question!, YesNo!, 1) =  1 Then 
			If Not FileDelete(lvs_Path) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Path + "'.", StopSign!)
				Return
			End If
		Else
			Return 
		End If   
	End If
	
	If lvds_excel.RowCount() < 65000 Then
		lvi_retorno = lvds_Excel.SaveAs(lvs_Path, Excel!, True)
	Else
		lvi_Retorno = lvds_Excel.SaveAsFormattedText(lvs_Path, EncodingANSI!, ";")
	End If
		
	If  lvi_retorno = 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
	End If
End If

end subroutine

on w_ge311_relatorio_inventario.create
int iCurrent
call super::create
this.cb_excel=create cb_excel
this.gb_3=create gb_3
this.dw_2=create dw_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_3=create dw_3
this.dw_1=create dw_1
this.cb_selecao_filial=create cb_selecao_filial
this.cb_selecao_grupo=create cb_selecao_grupo
this.dw_4=create dw_4
this.dw_5=create dw_5
this.dw_6=create dw_6
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_7=create dw_7
this.st_confirmar_grupo=create st_confirmar_grupo
this.st_confirmar_filial=create st_confirmar_filial
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_excel
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_selecao_filial
this.Control[iCurrent+9]=this.cb_selecao_grupo
this.Control[iCurrent+10]=this.dw_4
this.Control[iCurrent+11]=this.dw_5
this.Control[iCurrent+12]=this.dw_6
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.cb_3
this.Control[iCurrent+16]=this.dw_7
this.Control[iCurrent+17]=this.st_confirmar_grupo
this.Control[iCurrent+18]=this.st_confirmar_filial
end on

on w_ge311_relatorio_inventario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_excel)
destroy(this.gb_3)
destroy(this.dw_2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.cb_selecao_filial)
destroy(this.cb_selecao_grupo)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_7)
destroy(this.st_confirmar_grupo)
destroy(this.st_confirmar_filial)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Parametro

dw_1.Event ue_AddRow()
dw_2.Event ue_Retrieve()
dw_3.Event ue_Retrieve()

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

lvdt_Parametro = RelativeDate(lvdt_Parametro,-(Day(lvdt_Parametro)+1))
ivdt_Parametro = RelativeDate(lvdt_Parametro,-(Day(lvdt_Parametro)-1))

dw_1.Object.Dt_Inventario[1] = ivdt_Parametro
dw_1.SetFocus()

This.ivm_Menu.mf_Imprimir	(True)
//ivm_Menu.mf_SalvarComo	(True)
end event

event open;call super::open; This.ivm_Menu.ivb_Permite_Imprimir = True

 
 //
 dw_4.Visible = FALSE
 dw_5.Visible = FALSE
 dw_6.Visible = FALSE
 //
end event

event ue_printimmediate;call super::ue_printimmediate;LONG 	 lvl_Find, lvl_Row, lvl_Filial, lvl_Contador

DATE   lvdt_Inventario

dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()

lvdt_Inventario = dw_1.Object.dt_inventario[1]

lvl_Find = dw_2.Find("id_selecao = 'S'",1,dw_2.RowCount())

IF lvl_Find = 0 THEN
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma filial foi selecionada.",Information!)
	Return
END IF	

lvl_Find = dw_3.Find("id_selecao = 'S'",1,dw_2.RowCount())

IF lvl_Find = 0 THEN
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum grupo foi selecionado.",Information!)
	Return
END IF

IF MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma gera$$HEX2$$e700e300$$ENDHEX$$o dos relat$$HEX1$$f300$$ENDHEX$$rios de invent$$HEX1$$e100$$ENDHEX$$rio ?",Question!,YesNo!,1) = 2 THEN RETURN

lvl_Contador = dw_2.RowCount()

Open(w_Aguarde)

ivs_SQL_Grupo = Wf_Grupos_Selecionados()

FOR lvl_Row = 1 TO lvl_Contador
	
	IF dw_2.Object.id_selecao[lvl_Row] = 'S' THEN
		
		lvl_Filial = dw_2.Object.cd_filial[lvl_Row]
		
		Wf_Gera_Inventario(lvl_Filial,lvdt_Inventario)				
		
	END IF	
	
	IF ivb_Cancelar THEN
		IF MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A gera$$HEX2$$e700e300$$ENDHEX$$o do invent$$HEX1$$e100$$ENDHEX$$rio da filial : (" + String(lvl_Filial,'0000') + ") foi cancelada. Deseja cancelar os invent$$HEX1$$e100$$ENDHEX$$rios seguintes ?",Question!,YesNo!,2) = 2 THEN
			ivb_Cancelar = FALSE
		ELSE
			EXIT
		END IF	
	END IF	
	
NEXT

dw_4.Reset()
dw_5.Reset()
dw_6.Reset()

Close(w_Aguarde)
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge311_relatorio_inventario
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge311_relatorio_inventario
end type

type cb_excel from commandbutton within w_ge311_relatorio_inventario
event ue_altera_status ( )
integer x = 2674
integer y = 240
integer width = 562
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar &Excel (XLS)"
end type

event ue_altera_status();ivb_CheckFilial		= (dw_2.Find("id_selecao='S'",1,Dw_2.RowCount()) > 0)
ivb_CheckGrupo	= (dw_3.Find("id_selecao='S'",1,Dw_3.RowCount()) > 0)

This.Enabled = (ivb_CheckGrupo and ivb_CheckFilial)
ivm_menu.mf_imprimir(ivb_CheckGrupo and ivb_CheckFilial)

end event

event clicked;String lvs_Fantasia
String lvs_Grupos_Selecao
String lvs_Grupo
String lvs_Tipo
String lvs_DW

Boolean lvb_Sucesso = True

Date lvdh_Inventario

Long lvl_Linhas
Long lvl_Linha
Long lvl_Filial
Long lvl_Linhas_Aux 		= 0
Long lvl_Filial_anterior 	= 10
Long lvl_Linha_dw2

Decimal lvdc_Saldo 					= 0.00
Decimal lvdc_Medicamento			= 0.00	
Decimal lvdc_Populares				= 0.00
Decimal lvdc_Perfumaria				= 0.00
Decimal lvdc_Diversos				= 0.00
Decimal lvdc_Almoxarifado			= 0.00
Decimal lvdc_Manipulacao			= 0.00
Decimal lvdc_Conveniencia			= 0.00
Decimal lvdc_Total						= 0.00


dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()

lvdh_Inventario	= dw_1.Object.dt_inventario	[1]
lvs_Tipo			= dw_1.Object.id_tipo			[1]

If (IsNull(lvdh_Inventario))or(lvdh_Inventario < Date('2001/01/01')) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Per$$HEX1$$ed00$$ENDHEX$$odo M$$HEX1$$ea00$$ENDHEX$$s/Ano informado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
	dw_1.Event ue_pos(1,'dt_inventario')
	Return -1
ElseIf lvdh_Inventario < Date('2015/10/01') Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Este relat$$HEX1$$f300$$ENDHEX$$rio pode ser emitido a partir de 01/10/2015, antes desta data deve ser utilizado o "Invent$$HEX1$$e100$$ENDHEX$$rio (Antigo)."',Exclamation!)
	dw_1.Event ue_pos(1,'dt_inventario')
	Return -1
ElseIf gf_primeiro_dia_mes(lvdh_Inventario) > gf_primeiro_dia_mes(ivdt_Parametro) THEN 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Somente $$HEX1$$e900$$ENDHEX$$ permitido gerar invent$$HEX1$$e100$$ENDHEX$$rios de m$$HEX1$$ea00$$ENDHEX$$s anterior.",Exclamation!)
	dw_1.Event ue_pos(1,'dt_inventario')
	Return -1
End If

If MessageBox("Confirma$$HEX2$$e700e300$$ENDHEX$$o!","Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o da planilha para as filiais selecionadas?",Question!,YesNo!,1) = 2 Then Return -1

SetPointer(HourGlass!)

dw_7.Reset()

dc_uo_ds_base lds_inventario
lds_inventario = Create dc_uo_ds_base

If lvs_Tipo = 'S' Then 
	lvs_DW = 'ds_ge311_grupo_produto_excel'
	dw_7.Of_changedataobject('ds_ge311_excel')
Else
	lvs_DW = 'ds_ge311_produto_excel'
	dw_7.Of_changedataobject('ds_ge311_produto_excel')
End If

If Not lds_inventario.of_ChangeDataObject(lvs_DW) Then
	Destroy lds_inventario
	Return -1
End If

lvs_Grupos_Selecao = wf_Grupos_Selecionados()
	
If lvs_Grupos_Selecao <> "" Then
	lds_inventario.of_AppendWhere(lvs_Grupos_Selecao)
End If

SetPointer(Arrow!)

//
Open(w_Aguarde)
w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es..."
w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())

For lvl_Linha_dw2 = 1 To dw_2.RowCount()
	
	w_Aguarde.uo_Progress.Of_SetProgress(lvl_Linha_dw2)		
	
	IF dw_2.Object.id_selecao[lvl_Linha_dw2] = 'S' THEN
		
		lvl_Filial = dw_2.Object.cd_filial[lvl_Linha_dw2]
		
		If lvl_Filial = 534 Then
			lvl_Linhas = lds_inventario.Retrieve(lvdh_Inventario, lvl_Filial, 1)
		Else
			lvl_Linhas = lds_inventario.Retrieve(lvdh_Inventario, lvl_Filial, lvl_Filial)
		End If
						
		If  lvl_Linhas =  -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o invent$$HEX1$$e100$$ENDHEX$$rio da filial '" + String ( lvl_Filial ) + "'. "+ SqlCa.SqlErrText + "", StopSign!, Ok!)
			lvb_Sucesso = False
			Exit
		End If
		
		If lvs_Tipo = 'A' Then 	
			lds_inventario.Rowscopy(1,lds_inventario.RowCount(),Primary!,dw_7, 1, Primary!)
		Else
			If lvl_Filial <> lvl_Filial_Anterior Then
				
				lvdc_Medicamento			= 0.00	
				lvdc_Populares				= 0.00
				lvdc_Perfumaria			= 0.00
				lvdc_Manipulacao			= 0.00
				lvdc_Diversos				= 0.00
				lvdc_Conveniencia			= 0.00
				lvdc_Almoxarifado			= 0.00
				lvdc_Total					= 0.00
				
				lvl_Linhas_Aux++
				
				lvs_Fantasia		= dw_2.Object.nm_fantasia		[lvl_Linha_dw2]
				
				dw_7.Object.cd_filial			[lvl_Linhas_Aux] = lvl_Filial
				dw_7.Object.nm_filial			[lvl_Linhas_Aux] = lvs_Fantasia
				
				lvl_Filial_Anterior = lvl_Filial
				
			End If
			
			w_Aguarde.Title = 'Carregando informa$$HEX2$$e700f500$$ENDHEX$$es da filial (' + String(lvl_Filial,'0000') + ')'
			
			For lvl_Linha = 1 To lvl_Linhas
				
				lvs_Grupo			= lds_inventario.Object.cd_grupo	[lvl_Linha]
				lvdc_Saldo			= lds_inventario.Object.saldo_filial	[lvl_Linha]
				lvdc_Total			+=lvdc_Saldo
					
				Choose Case lvs_Grupo
						
					Case '1' //Medicamento
						lvdc_Medicamento += lvdc_Saldo 
						
					Case '2' //Populares
						lvdc_Populares += lvdc_Saldo 
						
					Case '3' //Perfumaria Geral
						lvdc_Perfumaria += lvdc_Saldo 
						
					Case '4' //Conveni$$HEX1$$ea00$$ENDHEX$$ncia
						lvdc_Conveniencia += lvdc_Saldo 
						
					Case '5' //Almoxarifado
						lvdc_Almoxarifado += lvdc_Saldo 
						
					Case '6' //Manipula$$HEX2$$e700e300$$ENDHEX$$o
						lvdc_Manipulacao += lvdc_Saldo 
						
					Case '7' //Diversos
						lvdc_Diversos += lvdc_Saldo 
						
				End Choose
				
			Next
			
			dw_7.Object.grupo_medicamento					[lvl_Linhas_Aux] = lvdc_Medicamento
			dw_7.Object.grupo_populares						[lvl_Linhas_Aux] = lvdc_Populares
			dw_7.Object.grupo_perfumaria						[lvl_Linhas_Aux] = lvdc_Perfumaria
			dw_7.Object.grupo_conveniencia					[lvl_Linhas_Aux] = lvdc_Conveniencia
			dw_7.Object.grupo_almoxarifado					[lvl_Linhas_Aux] = lvdc_Almoxarifado
			dw_7.Object.grupo_manipulacao					[lvl_Linhas_Aux] = lvdc_Manipulacao
			dw_7.Object.grupo_diversos						[lvl_Linhas_Aux] = lvdc_Diversos
			dw_7.Object.total_filial								[lvl_Linhas_Aux] = lvdc_Total
			
		End If
		
	End If
	
Next

Close(w_Aguarde)

If lvb_Sucesso Then
	wf_Gera_Excel(dw_7)
End If

If IsValid(lds_inventario) Then Destroy(lds_inventario)
end event

type gb_3 from groupbox within w_ge311_relatorio_inventario
integer x = 1646
integer y = 360
integer width = 1591
integer height = 884
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Grupos de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within w_ge311_relatorio_inventario
event ue_mouse_move pbm_mousemove
integer x = 50
integer y = 420
integer width = 1541
integer height = 1168
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge311_sel_lista_filial"
boolean vscrollbar = true
end type

event ue_mouse_move;If This.RowCount() > 0 Then
	If XPos >= (st_confirmar_filial.X + st_confirmar_filial.Width - 75) and (XPos <= st_confirmar_filial.x + st_confirmar_filial.Width + 25) and &
		  ypos >= 2 and ypos < 90 Then	 
		
		st_confirmar_filial.Visible = True
		
		If ivb_CheckFilial Then
			st_confirmar_filial.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar_filial.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar_filial.Visible = False
	End If
End If
end event

event constructor;call super::constructor;This.of_setrowselection( )
end event

event doubleclicked;call super::doubleclicked;If Dwo.Name = 'st_lote_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_CheckFilial Then
		lvs_Marcacao = 'N'
		ivb_CheckFilial = False
	Else
		lvs_Marcacao = 'S'
		ivb_CheckFilial = True
	End If
	
	For lvl_Row = 1 To This.RowCount()
				
		This.Object.id_selecao [lvl_Row] = lvs_Marcacao
		
	Next
	
	cb_excel.Post Event ue_altera_status()
End If

end event

event itemchanged;call super::itemchanged;If Dwo.Name = 'id_selecao' Then
	cb_excel.Post Event ue_altera_status()
End If

Return AncestorReturnValue

end event

type gb_1 from groupbox within w_ge311_relatorio_inventario
integer x = 23
integer y = 8
integer width = 1120
integer height = 336
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Par$$HEX1$$e200$$ENDHEX$$metros Gerais"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge311_relatorio_inventario
integer x = 23
integer y = 360
integer width = 1591
integer height = 1248
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Filiais"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within w_ge311_relatorio_inventario
event ue_mouse_move pbm_mousemove
integer x = 1673
integer y = 420
integer width = 1541
integer height = 812
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_ge311_sel_grupo_produto"
boolean vscrollbar = true
end type

event ue_mouse_move;If This.RowCount() > 0 Then
	If XPos >= (st_confirmar_grupo.X + st_confirmar_grupo.Width - This.X) and (XPos <= st_confirmar_grupo.x + st_confirmar_grupo.Width + This.X) and &
		  ypos >= 2 and ypos < 90 Then	 
		
		st_confirmar_grupo.Visible = True
		
		If ivb_CheckGrupo Then
			st_confirmar_grupo.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar_grupo.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar_grupo.Visible = False
	End If
End If
end event

event constructor;call super::constructor;This.of_setrowselection( )
end event

event doubleclicked;call super::doubleclicked;If Dwo.Name = 'st_lote_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_CheckGrupo Then
		lvs_Marcacao = 'N'
		ivb_CheckGrupo = False
	Else
		lvs_Marcacao = 'S'
		ivb_CheckGrupo = True
	End If
	
	For lvl_Row = 1 To This.RowCount()
				
		This.Object.id_selecao [lvl_Row] = lvs_Marcacao
		
	Next
	
	cb_excel.Post Event ue_altera_status()
End If

end event

event itemchanged;call super::itemchanged;If Dwo.Name = 'id_selecao' Then
	cb_excel.Post Event ue_altera_status()
End If

Return AncestorReturnValue
end event

type dw_1 from dc_uo_dw_base within w_ge311_relatorio_inventario
integer x = 50
integer y = 68
integer width = 1070
integer height = 264
boolean bringtotop = true
string dataobject = "dw_ge311_sel_geral"
end type

type cb_selecao_filial from commandbutton within w_ge311_relatorio_inventario
boolean visible = false
integer x = 1166
integer y = 240
integer width = 448
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Nenhuma &Filial"
end type

event clicked;Long lvl_Contador

String lvs_Selecao

If This.Text = "Nenhuma &Filial" Then
	This.Text = "Todas &Filiais"
	lvs_Selecao = "N"	
Else
	This.Text = "Nenhuma &Filial"
	lvs_Selecao = "S"	
End If

For lvl_Contador = 1 To dw_2.RowCount()
	dw_2.Object.Id_Selecao[lvl_Contador] = lvs_Selecao
Next
end event

type cb_selecao_grupo from commandbutton within w_ge311_relatorio_inventario
boolean visible = false
integer x = 2766
integer y = 240
integer width = 471
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Nenhum &Grupo"
end type

event clicked;Long lvl_Contador

String lvs_Selecao

If This.Text = "Nenhum &Grupo" Then
	This.Text = "Todos &Grupos"
	lvs_Selecao = "N"	
Else
	This.Text = "Nenhum &Grupo"
	lvs_Selecao = "S"	
End If

For lvl_Contador = 1 To dw_3.RowCount()
	dw_3.Object.Id_Selecao[lvl_Contador] = lvs_Selecao
Next
end event

type dw_4 from dc_uo_dw_base within w_ge311_relatorio_inventario
integer x = 1650
integer y = 1276
integer width = 334
integer height = 224
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_ge311_relatorio_inventario"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Selecao_Linhas = True
This.Object.DataWindow.Print.PreView = "Yes"

end event

event printend;call super::printend;lvi_Paginas = pagesprinted
end event

type dw_5 from dc_uo_dw_base within w_ge311_relatorio_inventario
integer x = 2016
integer y = 1276
integer width = 334
integer height = 224
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_ge311_resumo_inventario"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Selecao_Linhas = True
This.Object.DataWindow.Print.PreView = "Yes"

end event

type dw_6 from dc_uo_dw_base within w_ge311_relatorio_inventario
integer x = 2391
integer y = 1276
integer width = 283
integer height = 224
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_ge311_termo_abertura_encerramento"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Selecao_Linhas = True
This.Object.DataWindow.Print.PreView = "Yes"

end event

type cb_1 from commandbutton within w_ge311_relatorio_inventario
boolean visible = false
integer x = 1755
integer y = 36
integer width = 247
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "dw_4"
end type

event clicked;dw_4.Visible = TRUE
dw_5.Visible = FALSE
dw_6.Visible = FALSE

	

end event

type cb_2 from commandbutton within w_ge311_relatorio_inventario
boolean visible = false
integer x = 2030
integer y = 36
integer width = 247
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "dw_5"
end type

event clicked;	dw_5.Visible = TRUE
   dw_4.Visible = FALSE
	dw_6.Visible = FALSE

end event

type cb_3 from commandbutton within w_ge311_relatorio_inventario
boolean visible = false
integer x = 2304
integer y = 36
integer width = 247
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "dw_6"
end type

event clicked;   dw_4.Visible = FALSE
	dw_5.Visible = FALSE
	dw_6.Visible = TRUE
	
end event

type dw_7 from dc_uo_dw_base within w_ge311_relatorio_inventario
boolean visible = false
integer x = 2720
integer y = 1276
integer width = 411
integer height = 248
integer taborder = 90
boolean bringtotop = true
string dataobject = "ds_ge311_excel"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_confirmar_grupo from statictext within w_ge311_relatorio_inventario
boolean visible = false
integer x = 2043
integer y = 436
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
boolean focusrectangle = false
end type

type st_confirmar_filial from statictext within w_ge311_relatorio_inventario
boolean visible = false
integer x = 411
integer y = 436
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
boolean focusrectangle = false
end type

