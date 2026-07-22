HA$PBExportHeader$w_ge137_planilha_analise_geral.srw
forward
global type w_ge137_planilha_analise_geral from dc_w_response
end type
type cb_gerar from commandbutton within w_ge137_planilha_analise_geral
end type
type cb_sair from commandbutton within w_ge137_planilha_analise_geral
end type
type dw_1 from dc_uo_dw_base within w_ge137_planilha_analise_geral
end type
type cb_1 from commandbutton within w_ge137_planilha_analise_geral
end type
type cb_gerar_automatico from commandbutton within w_ge137_planilha_analise_geral
end type
type gb_1 from groupbox within w_ge137_planilha_analise_geral
end type
end forward

global type w_ge137_planilha_analise_geral from dc_w_response
string tag = "w_ge137_planilha_analise_geral"
integer x = 1312
integer y = 1028
integer width = 2126
integer height = 1292
string title = "GE137 - Gera$$HEX2$$e700e300$$ENDHEX$$o de Planilha para An$$HEX1$$e100$$ENDHEX$$lise Geral"
boolean controlmenu = false
long backcolor = 80269524
cb_gerar cb_gerar
cb_sair cb_sair
dw_1 dw_1
cb_1 cb_1
cb_gerar_automatico cb_gerar_automatico
gb_1 gb_1
end type
global w_ge137_planilha_analise_geral w_ge137_planilha_analise_geral

type variables
uo_filial 								ivo_filial
uo_fornecedor 					ivo_fornecedor
uo_classificacao_produto 	ivo_classificacao
uo_ge216_filiais 					io_filiais
uo_ge137_planogramas 		io_planogramas

dc_uo_ds_base ids_Planograma_Selecionado

uo_ge260_analise_spaceman 	io_analise

String is_geracao_planilha = ''
String is_filiais
String is_nulo
end variables
forward prototypes
public function decimal wf_desconto_sos (long al_produto)
public function date wf_mes_anterior (date adt_mes_base, integer ai_numero)
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_fornecedor ()
public function long wf_saldo_matriz (long al_produto, ref dc_uo_ds_base ads)
public subroutine wf_saldo_filiais (long al_produto, ref dc_uo_ds_base ads, ref long al_saldo)
public function long wf_venda_liquida (long al_produto, ref dc_uo_ds_base ads)
public function long wf_venda_liquida_filial (long al_produto, ref dc_uo_ds_base ads)
public function long wf_saldo_filial (long al_produto, ref dc_uo_ds_base ads)
public subroutine wf_limpa_campos (string ps_campo)
public subroutine wf_atualiza_campos (string ps_campo)
public function decimal wf_consulta_comissao (long al_produto, integer ai_tipo, datastore ads)
public function boolean wf_verifica_resumo_eb_filiais (long al_produto, ref long al_estoque_base)
public function long wf_venda_almoxarifado (long al_produto, ref dc_uo_ds_base ads)
public function long wf_consulta_produto_transito (long al_produto, ref dc_uo_ds_base ads)
public function boolean wf_saldo_em_transito (dc_uo_ds_base ads)
public subroutine wf_insere_padrao ()
public function boolean wf_composicao_produto (long al_produto, datastore ads, ref string as_substancia)
public subroutine wf_envia_email (string as_mensagem)
public subroutine wf_exclui_arquivos_auto (string as_diretorio_padrao)
public function boolean wf_processo_automatico (string as_diretorio_padrao, ref string as_path_automatico)
public function long wf_saldo_wms_segregado (long al_produto, datastore ads_dados, string as_tipo)
end prototypes

public function decimal wf_desconto_sos (long al_produto);Decimal lvdc_Desconto

/*Select max(b.pc_desconto) 		
Into :lvdc_Desconto 
From promocao_sos a, 
	  promocao_sos_produto b,
	  parametro p
Where a.cd_promocao_sos = b.cd_promocao_sos
  and b.cd_produto = :al_Produto
  and a.dh_inicio <= p.dh_movimentacao
  and (a.dh_termino >= p.dh_movimentacao or a.dh_termino Is Null)  
Using SqlCa;*/


Select  case when max (q.pc_desconto)>max (b.pc_desconto) 
				then max (q.pc_desconto)  else max (b.pc_desconto) end 
Into :lvdc_Desconto 
From promocao_sos a, 
	  promocao_sos_produto b,
	  parametro p,
	  desconto_progressivo_qtd q
Where a.cd_promocao_sos = b.cd_promocao_sos
  and b.cd_produto = :al_Produto
  and a.dh_inicio <= p.dh_movimentacao
  and (a.dh_termino >= p.dh_movimentacao or a.dh_termino Is Null)  
  and q.cd_desconto =* b.cd_desc_progressivo
Using SqlCa;

		
Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvdc_Desconto) Then lvdc_Desconto = 0
		
	Case 100
		lvdc_Desconto = 0
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Desconto SOS - Produto '" + String(al_Produto) + "'")
		lvdc_Desconto = 0
End Choose

Return lvdc_Desconto
end function

public function date wf_mes_anterior (date adt_mes_base, integer ai_numero);Date lvdt_Mes_Anterior

Integer lvi_Mes_Atual, &
        lvi_Ano_Atual, &
		  lvi_Mes_Anterior, &
		  lvi_Ano_Anterior
	  
lvi_Mes_Atual = Month(adt_Mes_Base)
lvi_Ano_Atual = Year(adt_Mes_Base)

lvi_Ano_Anterior = lvi_Ano_Atual
lvi_Mes_Anterior = lvi_Mes_Atual - ai_Numero

If lvi_Mes_Anterior <= 0 Then
	lvi_Ano_Anterior = lvi_Ano_Atual - 1
	lvi_Mes_Anterior = lvi_Mes_Anterior + 12
End If

lvdt_Mes_Anterior = Date("01/" + String(lvi_Mes_Anterior, "00") + "/" + &
                                 String(lvi_Ano_Anterior, "0000"))

Return lvdt_Mes_Anterior
end function

public subroutine wf_localiza_filial ();
STRING ls_filial	, &
		 lvs_nulo

Long   lvl_nulo

ls_filial = dw_1.GetText()

ivo_filial.Of_Localiza_Filial(ls_filial)

If ivo_filial.Localizada Then
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia
	
Else
	SetNull(lvl_nulo)
	SetNull(lvs_nulo)
	dw_1.Object.cd_filial[1] = lvl_nulo
	dw_1.Object.de_filial[1] = lvs_nulo
	
	ivo_filial.cd_filial	    = lvl_nulo
	ivo_filial.nm_fantasia   = lvs_nulo	
	
End If

end subroutine

public subroutine wf_localiza_fornecedor ();String lvs_fornecedor

lvs_fornecedor = dw_1.GetText()

ivo_fornecedor.Of_Localiza_fornecedor(lvs_fornecedor)

If ivo_fornecedor.Localizado Then	
	dw_1.Object.cd_fornecedor[1] = ivo_fornecedor.cd_fornecedor
	dw_1.Object.nm_fornecedor[1] = ivo_fornecedor.nm_razao_social
	
	If Not gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1) Then
		Return
	End If	
End If

end subroutine

public function long wf_saldo_matriz (long al_produto, ref dc_uo_ds_base ads);Long lvl_Linha, &
     lvl_Saldo
	  
lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	lvl_Saldo = ads.Object.Saldo[lvl_Linha]
ElseIf lvl_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW Saldo Matriz.", StopSign!)
	lvl_Saldo = 0
Else
	lvl_Saldo = 0
End If

Return lvl_Saldo
end function

public subroutine wf_saldo_filiais (long al_produto, ref dc_uo_ds_base ads, ref long al_saldo);Long lvl_Linha, &
     lvl_Venda, &
	  lvl_Devolucao

lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	al_Saldo = ads.Object.Qt_Saldo[lvl_Linha]
ElseIf lvl_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW.", StopSign!)
	al_Saldo = 0
Else
	al_Saldo = 0
End If
end subroutine

public function long wf_venda_liquida (long al_produto, ref dc_uo_ds_base ads);Long lvl_Linha, &
     lvl_Venda, &
	  lvl_Devolucao

lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	lvl_Venda     = ads.Object.Qt_Venda          [lvl_Linha]
	lvl_Devolucao = ads.Object.Qt_Devolucao_Venda[lvl_Linha]
	
	Return lvl_Venda - lvl_Devolucao
ElseIf lvl_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW.", StopSign!)
	Return 0
Else
	Return 0
End If
end function

public function long wf_venda_liquida_filial (long al_produto, ref dc_uo_ds_base ads);Long lvl_Linha, &
     lvl_Venda

lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())


If lvl_Linha > 0 Then
	lvl_Venda = ads.Object.Qt_Venda[lvl_linha] - ads.Object.Qt_Devolucao_Venda[lvl_linha]
	
	Return lvl_Venda
Else
	Return 0
End If
end function

public function long wf_saldo_filial (long al_produto, ref dc_uo_ds_base ads);Long lvl_Linha, &
     lvl_Saldo
	  
lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	lvl_Saldo = ads.Object.Saldo[lvl_Linha]
ElseIf lvl_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW Saldo Filial.", StopSign!)
	lvl_Saldo = 0
Else
	lvl_Saldo = 0
End If

Return lvl_Saldo
end function

public subroutine wf_limpa_campos (string ps_campo);Choose Case ps_Campo 
	Case "de_grupo"
		dw_1.Object.Cd_SubGrupo[1] = ""
		dw_1.Object.De_SubGrupo[1] = ""
		dw_1.Object.Cd_Categoria[1] = ""
		dw_1.Object.De_Categoria[1] = ""
		dw_1.Object.Cd_SubCategoria[1] = ""
		dw_1.Object.De_SubCategoria[1] = ""
		
	Case "de_subgrupo"
		dw_1.Object.Cd_Categoria[1] = ""
		dw_1.Object.De_Categoria[1] = ""
		dw_1.Object.Cd_SubCategoria[1] = ""
		dw_1.Object.De_SubCategoria[1] = ""
		
	Case "de_categoria"
		dw_1.Object.Cd_SubCategoria[1] = ""
		dw_1.Object.De_SubCategoria[1] = ""
End Choose		
		
end subroutine

public subroutine wf_atualiza_campos (string ps_campo);Choose Case ps_Campo
	Case "de_grupo"
		dw_1.Object.Cd_Grupo[1] = ivo_Classificacao.Cd_Grupo
		dw_1.Object.De_Grupo[1] = ivo_Classificacao.De_Grupo
	Case "de_subgrupo"
		dw_1.Object.Cd_Grupo[1] = ivo_Classificacao.Cd_Grupo
		dw_1.Object.De_Grupo[1] = ivo_Classificacao.De_Grupo
		dw_1.Object.Cd_SubGrupo[1] = ivo_Classificacao.Cd_SubGrupo
		dw_1.Object.De_subGrupo[1] = ivo_Classificacao.De_SubGrupo
	Case "de_categoria"
		dw_1.Object.Cd_Grupo[1] = ivo_Classificacao.Cd_Grupo
		dw_1.Object.De_Grupo[1] = ivo_Classificacao.De_Grupo
		dw_1.Object.Cd_SubGrupo[1] = ivo_Classificacao.Cd_SubGrupo
		dw_1.Object.De_subGrupo[1] = ivo_Classificacao.De_SubGrupo
		dw_1.Object.Cd_Categoria[1] = ivo_Classificacao.Cd_Categoria
		dw_1.Object.De_Categoria[1] = ivo_Classificacao.De_Categoria
	Case "de_subcategoria"
		dw_1.Object.Cd_Grupo[1] = ivo_Classificacao.Cd_Grupo
		dw_1.Object.De_Grupo[1] = ivo_Classificacao.De_Grupo
		dw_1.Object.Cd_SubGrupo[1] = ivo_Classificacao.Cd_SubGrupo
		dw_1.Object.De_subGrupo[1] = ivo_Classificacao.De_SubGrupo
		dw_1.Object.Cd_Categoria[1] = ivo_Classificacao.Cd_Categoria
		dw_1.Object.De_Categoria[1] = ivo_Classificacao.De_Categoria
		dw_1.Object.Cd_SubCategoria[1] = ivo_Classificacao.Cd_SubCategoria
		dw_1.Object.De_SubCategoria[1] = ivo_Classificacao.De_SubCategoria
End Choose

end subroutine

public function decimal wf_consulta_comissao (long al_produto, integer ai_tipo, datastore ads);Decimal ldc_Comissao

Long ll_Linha

ll_Linha = ads.Find("cd_produto = " + string(al_produto) + " and cd_tipo_comissao = " + String(ai_tipo), 1, ads.RowCount())

If ll_Linha > 0 Then
	ldc_Comissao = ads.Object.pc_comissao [ ll_Linha ]
Else
	ldc_Comissao = 0.00
End If

Return ldc_Comissao
end function

public function boolean wf_verifica_resumo_eb_filiais (long al_produto, ref long al_estoque_base);Select qt_estoque_base
Into :al_Estoque_Base
From resumo_estoque_base_filiais
Where cd_produto 	= :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If al_Estoque_Base = -1 Then al_Estoque_Base = 0
		
		Return True
	Case 100
		
		al_Estoque_Base = 0
		
		Return True
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base. " + SqlCa.SqlErrText)
		Return False
End Choose
end function

public function long wf_venda_almoxarifado (long al_produto, ref dc_uo_ds_base ads);Long lvl_Linha, &
     lvl_Transferida

lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	lvl_Transferida = ads.Object.Qt_Transferida[lvl_Linha]
	
	Return lvl_Transferida
ElseIf lvl_Linha < 0 Then
	
	If gvb_Auto Then
		wf_Envia_Email("Erro no find da DW. Produto " + String(al_Produto) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o wf_Venda_Almoxarifado")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW. Produto '" + String(al_Produto) + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_Venda_Almoxarifado", StopSign!)
	End If
	
	Return 0
Else
	Return 0
End If
end function

public function long wf_consulta_produto_transito (long al_produto, ref dc_uo_ds_base ads);Long lvl_Linha
     
	  
lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	lvl_Linha = lvl_Linha
Else
	lvl_Linha = 0

End If

Return lvl_Linha





end function

public function boolean wf_saldo_em_transito (dc_uo_ds_base ads);Long ll_Linha
Long ll_Linhas
Long ll_Find

st_saldo_transito str

gf_Saldo_em_Transito(Ref str)

ll_Linhas = UpperBound(str.Cd_Produto[])

For ll_Linha = 1 To ll_Linhas
	
	ll_Find = ads.Find("cd_produto = " + String(str.Cd_Produto[ll_Linha]), 1, ads.RowCount())
	
	If ll_Find > 0 Then
		ads.Object.Qt_Saldo_Transito[ll_Find] = str.Qt_Saldo[ll_Linha]
	End If
Next

Return True
end function

public subroutine wf_insere_padrao ();DataWindowChild ldwc_Child

/* Lei Gen$$HEX1$$e900$$ENDHEX$$rico */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			
ldwc_Child.SetItem(1, "id_lei_generico", "T")
ldwc_Child.SetItem(1, "de_lei_generico", "TODOS")
dw_1.Object.id_lei_generico [1] = "T"
end subroutine

public function boolean wf_composicao_produto (long al_produto, datastore ads, ref string as_substancia);Long ll_Find
Long ll_Len

String ls_Nulo

as_Substancia = ""

ll_Find = ads.Find("cd_produto = " + String(al_produto), 1, ads.RowCount())

If ll_Find < 0 Then
	If gvb_Auto Then
		wf_Envia_Email("Erro no Find do produto '" + String(al_Produto) + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_composicao_produto.")
	Else		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find do produto '" + String(al_Produto) + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_composicao_produto.", StopSign!)
		Return False
	End If
End If

If ll_Find = 0 Then
	SetNull(ls_Nulo)
	as_substancia = ls_Nulo
	Return True
End If

Do While ll_Find > 0
	as_substancia += ads.Object.De_Substancia [ ll_Find ] + " | "
	
	//Se for a $$HEX1$$fa00$$ENDHEX$$ltima linha da ads, da um exit pra n$$HEX1$$e300$$ENDHEX$$o ficar em um loop eterno
	If ll_Find = ads.RowCount() Then
		Exit
	End If
	
	//Pega a pr$$HEX1$$f300$$ENDHEX$$xima subst$$HEX1$$e200$$ENDHEX$$ncia
	ll_Find = ads.Find("cd_produto = " + String(al_produto), ll_Find + 1, ads.RowCount())
Loop

ll_Len = LenA(as_Substancia)

//Remove o "|" do final do argumento as_Substancia
as_Substancia = LeftA(as_Substancia, ll_Len - 3)

Return True
end function

public subroutine wf_envia_email (string as_mensagem);String ls_Anexo[]

gf_ge202_Envia_Email_Automatico(169, "", as_Mensagem, ls_Anexo[], True)
end subroutine

public subroutine wf_exclui_arquivos_auto (string as_diretorio_padrao);Long ll_Linha

String ls_Arquivo
String ls_Anexo[]
String ls_Nome_Arquivo

gf_Dir_List(as_Diretorio_Padrao, "analise_geral_automatica*", 1, Ref ls_Anexo[])

For ll_Linha = 1 To UpperBound(ls_Anexo)
	ls_Arquivo = ls_Anexo[ll_Linha]
	
	ls_Nome_Arquivo = as_Diretorio_Padrao + ls_Arquivo
	
	If Not FileDelete(ls_Nome_Arquivo) Then
		wf_Envia_Email("Erro ao deletar o arquivo " + ls_Arquivo + " da pasta " + as_Diretorio_Padrao + ".")
	End If
Next

Return
end subroutine

public function boolean wf_processo_automatico (string as_diretorio_padrao, ref string as_path_automatico);Date ldt_Atual

If Not gvb_Auto Then Return True

ldt_Atual = Today()

//No processo autom$$HEX1$$e100$$ENDHEX$$tico se for domingo ou s$$HEX1$$e100$$ENDHEX$$bado n$$HEX1$$e300$$ENDHEX$$o gera o arquivo
If DayNumber(ldt_Atual) = 1 Or DayNumber(ldt_Atual) = 7 Then Return False

Select vl_parametro
	Into :as_Path_Automatico
From parametro_geral
Where cd_parametro = 'ANALISE_GERAL_AUTOMATICO'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	wf_Envia_Email("Erro ao consultar o diret$$HEX1$$f300$$ENDHEX$$rio de destino para o arquivo gerado autom$$HEX1$$e100$$ENDHEX$$ticamente.")
	Return False
End If

If Trim(as_Path_Automatico) = "" Or IsNull(as_Path_Automatico) Then
	wf_Envia_Email("A coluna vl_parametro do par$$HEX1$$e200$$ENDHEX$$metro geral 'ANALISE_GERAL_AUTOMATICO' est$$HEX1$$e100$$ENDHEX$$ branca ou nula.")
End If

If Not DirectoryExists(as_Path_Automatico) Then
	If CreateDirectory(as_Path_Automatico) = -1 Then
		wf_Envia_Email("Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '" + as_Path_Automatico + "'.")
		Return False
	End If
End If

wf_Exclui_Arquivos_Auto(as_Diretorio_Padrao)

Return True
end function

public function long wf_saldo_wms_segregado (long al_produto, datastore ads_dados, string as_tipo);Long lvl_Linha, &
     lvl_Saldo
	  
lvl_Linha = ads_dados.Find("cd_bairro = '"+String(as_tipo)+"'"+ " and cd_produto =" + string(al_produto),1, ads_dados.RowCount())

If lvl_Linha > 0 Then
	lvl_Saldo = ads_dados.Object.qt_saldo_final [lvl_Linha]
ElseIf lvl_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW Saldo Matriz.", StopSign!)
	lvl_Saldo = 0
Else
	lvl_Saldo = 0
End If

Return lvl_Saldo
end function

on w_ge137_planilha_analise_geral.create
int iCurrent
call super::create
this.cb_gerar=create cb_gerar
this.cb_sair=create cb_sair
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_gerar_automatico=create cb_gerar_automatico
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar
this.Control[iCurrent+2]=this.cb_sair
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_gerar_automatico
this.Control[iCurrent+6]=this.gb_1
end on

on w_ge137_planilha_analise_geral.destroy
call super::destroy
destroy(this.cb_gerar)
destroy(this.cb_sair)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_gerar_automatico)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;ivo_filial        		= Create uo_filial
ivo_Fornecedor    	= Create uo_fornecedor
ivo_classificacao	= Create uo_classificacao_produto
io_filiais				= Create uo_ge216_filiais

io_planogramas					= Create  uo_ge137_planogramas 		  
ids_Planograma_Selecionado	= Create dc_uo_ds_base
io_analise							= Create  uo_ge260_analise_spaceman

dw_1.Event ue_AddRow()
dw_1.Object.Dt_Inicio [1] = Date("01/" + String(Today(), "mm/yyyy"))
dw_1.SetFocus()

gf_ge003_lista_divisao_fornecedor(dw_1, "", 1)

wf_insere_padrao()

If gvb_Auto Then
	cb_gerar_automatico.Event Clicked()
	cb_Sair.Event Clicked()
End If
end event

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_fornecedor)
Destroy(ivo_classificacao)
Destroy(io_filiais)

If IsValid(io_planogramas) 					Then Destroy io_planogramas
If IsValid(ids_Planograma_Selecionado)	Then Destroy ids_Planograma_Selecionado
If IsValid(io_analise) 							Then Destroy io_analise
end event

event open;call super::open;pb_help.Visible = True
end event

type pb_help from dc_w_response`pb_help within w_ge137_planilha_analise_geral
integer x = 23
integer y = 1072
end type

event pb_help::clicked;call super::clicked;wf_Help("Gera$$HEX2$$e700e300$$ENDHEX$$o de Planilhas para An$$HEX1$$e100$$ENDHEX$$lise Geral (GE137)")
end event

type cb_gerar from commandbutton within w_ge137_planilha_analise_geral
integer x = 1207
integer y = 1096
integer width = 466
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Gerar Planilha"
end type

event clicked;Date 	lvdt_Mes_Base	, &
		lvdt_Mes_1		, &
		lvdt_Mes_2		, &
		lvdt_Mes_3		, &
		lvdt_Mes_4		, &
		lvdt_Mes_5		, &
		lvdt_Mes_6		, &
		lvdt_Mes			, &
		ldt_Ultimo_Dia_Mes

Long 	lvl_Contaitem		, &
		lvl_Contames		, &
		lvl_Total				, &
		lvl_Produto			, &
		lvl_Saldo_Matriz	, &
		lvl_Saldo_Filiais	, &
		lvl_Venda_Liquida	, &
		lvl_Mix				, &
		ll_Divisao_Forn		, &
		ll_EB_Filiais			, &
		ll_Saldo_Transito	, &
		ll_Saveas			,&
		ll_SaldoSegreg_Dev		,&
		ll_SaldoSegreg_Receb	,&
		ll_SaldoSegreg_Trans		
		
String	lvs_Diretorio			, &
		lvs_Arquivo  		, &
		lvs_Fornecedor		, &
		lvs_Lei				, &
		lvs_Grupo			, &
		lvs_SubGrupo		, &
		lvs_Categoria		, &
		lvs_SubCategoria	, &
		lvs_Situacao			, &
		ls_Grupo_Prod		, &
		lvs_Filiais			, &
		lvs_Planograma	, &
		ls_Substancia		, &
		ls_Path
		
Time	lvt_Inicio		, &
		lvt_Termino

Try
	
	lvs_Diretorio = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
	
	If Not wf_Processo_Automatico(lvs_Diretorio, Ref ls_Path) Then Return -1
	
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	If Not lvds_1.of_ChangeDataObject("dw_ge137_planilha") Then Return
	
	dc_uo_ds_Base lvds_2
	lvds_2 = Create dc_uo_ds_Base
	If Not lvds_2.of_ChangeDataObject("dw_ge137_resumo_mes") Then Return
	
	dc_uo_ds_Base lvds_3
	lvds_3 = Create dc_uo_ds_Base
	If Not lvds_3.of_ChangeDataObject("dw_ge137_saldo") Then Return
	
	dc_uo_ds_Base lvds_4
	lvds_4 = Create dc_uo_ds_Base
	If Not lvds_4.of_ChangeDataObject("dw_ge137_resumo_mes_filiais") Then Return
	
	dc_uo_ds_Base lvds_5
	lvds_5 = Create dc_uo_ds_Base
	If Not lvds_5.of_ChangeDataObject("dw_ge137_saldo_filiais") Then Return
	
	dc_uo_ds_Base lds_comissao
	lds_comissao = Create dc_uo_ds_Base
	If Not lds_comissao.of_ChangeDataObject("dw_ge137_comissao_produto") Then Return
	
	dc_uo_ds_Base lds_Almoxarifado
	lds_Almoxarifado = Create dc_uo_ds_Base
	If Not lds_Almoxarifado.of_ChangeDataObject("dw_ge137_venda_almoxarifado") Then Return
	
	dc_uo_ds_Base lds_Almoxarifado_Fil
	lds_Almoxarifado_Fil = Create dc_uo_ds_Base
	If Not lds_Almoxarifado_Fil.of_ChangeDataObject("dw_ge137_venda_almoxarifado_filiais") Then Return
	
	dc_uo_ds_Base lds_Composicao
	lds_Composicao = Create dc_uo_ds_Base
	If Not lds_Composicao.of_ChangeDataObject("dw_ge137_composicao_produto") Then Return
	

	dc_uo_ds_Base lvds_Saldo_Segreg
	lvds_Saldo_Segreg = Create dc_uo_ds_Base
	If Not lvds_Saldo_Segreg.of_ChangeDataObject("dw_ge137_saldo_segreg") Then Return
	
	lvt_Inicio = Now()
	
	SetPointer(HourGlass!)
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando as informa$$HEX2$$e700f500$$ENDHEX$$es..."
	
	dw_1.AcceptText()
	
	lvdt_Mes_Base   	= dw_1.Object.dt_inicio      					[1]
	lvs_fornecedor		= dw_1.Object.cd_fornecedor  				[1]	
	lvs_Filiais			= dw_1.Object.de_filial      					[1]
	lvs_Lei				= dw_1.Object.Id_Lei_Generico			[1]
	lvs_Grupo      		= dw_1.Object.Cd_Grupo       				[1]
	lvs_SubGrupo		= dw_1.Object.Cd_SubGrupo    			[1]
	lvs_Categoria		= dw_1.Object.Cd_Categoria   				[1]
	lvs_SubCategoria 	= dw_1.Object.Cd_SubCategoria			[1]
	lvs_Situacao			= dw_1.Object.Id_Situacao    				[1]
	lvl_Mix				= dw_1.Object.cd_mix         				[1]
	ll_Divisao_Forn		= dw_1.Object.Nr_Divisao_Fornecedor	[1]
	lvs_Planograma 	= dw_1.Object.cd_planograma				[1]
	
	If IsNull(lvdt_Mes_Base) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar a data base para gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo.",Information!)
		dw_1.Event ue_Pos(1, "dt_inicio")
		Return
	End If
	
	If Not IsNull(lvs_fornecedor) Then
		lvds_1.Of_appendwhere("pg.cd_fornecedor_usual = '" + lvs_fornecedor + "'")
	End If
	
	
	//Divis$$HEX1$$e300$$ENDHEX$$o Fornecedor
	If Not IsNull(ll_Divisao_Forn) And ll_Divisao_Forn > 0 Then
		lvds_1.Of_appendwhere(" pg.cd_produto in ( select cd_produto" + &
										 " from vw_divisao_fornecedor_produto" + &
										 " where cd_fornecedor = '" + lvs_Fornecedor + "'" + &
										 " and nr_divisao = " + String(ll_Divisao_Forn) + ")")
	End If
	
	If Not IsNull(lvs_Lei) and lvs_Lei <> "T" Then
		lvds_1.Of_appendwhere("pg.id_lei_generico = '" + lvs_Lei + "'")
	End If
	
	// Grupo
	If Not IsNull(lvs_Grupo) and lvs_Grupo <> "" Then
		lvds_1.of_Appendwhere("cp.cd_grupo = '" + lvs_Grupo + "'")
	End If
	
	// SubGrupo
	If Not IsNull(lvs_SubGrupo) and lvs_SubGrupo <> "" Then
		lvds_1.of_Appendwhere("cp.cd_subgrupo = '" + lvs_SubGrupo + "'")
	End If
	
	// Categoria
	If Not IsNull(lvs_Categoria) and lvs_Categoria <> "" Then
		lvds_1.of_Appendwhere("cp.cd_categoria = '" + lvs_Categoria + "'")
	End If
	
	// SubCategoria
	If Not IsNull(lvs_SubCategoria) and lvs_SubCategoria <> "" Then
		lvds_1.of_Appendwhere("cp.cd_subcategoria = '" + lvs_SubCategoria + "'")
	End If
	
	If lvs_Situacao <> "T" Then
		lvds_1.of_AppendWhere("pg.id_situacao = '" + lvs_Situacao + "'")
	End If
	
	// Mix
	If Not IsNull(lvl_Mix) Then
		lvds_1.of_AppendWhere("pc.cd_mix_produto = " + String(lvl_Mix) )
	End If
	
	// Planograma
	If (lvs_Planograma = 'C') Then 
		lvds_1.Of_appendwhere(" pg.cd_planograma in ( " + io_planogramas.is_planogramas + " )" )
	End If
	
	/*
	Testar a gera$$HEX2$$e700e300$$ENDHEX$$o da planilha 
	lvds_1.Of_appendwhere(" pg.cd_produto in ( 181,369,408,424)" )
	lvds_3.Of_appendwhere(" p.cd_produto in ( 181,369,408,424)" )
	*/
		
	lvl_Total = lvds_1.Retrieve()
	
	If lvl_Total > 0 Then
		
		w_Aguarde.Title = "Calculando Saldo Matriz..."
		
		lvds_3.Retrieve(lvdt_Mes_Base)

		// Carrega Saldos Segregados - CD
		lvds_Saldo_Segreg.retrieve( )
		
		If lds_comissao.Retrieve() < 0 Then
			If gvb_Auto Then
				wf_Envia_Email("Erro no retrieve da ds 'dw_ge137_comissao_produto'.")
			Else			
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'dw_ge137_comissao_produto'.", StopSign!)
				Return -1
			End If
		End If
		
		If lds_Composicao.Retrieve() < 0 Then
			If gvb_Auto Then
				wf_Envia_Email("Erro no retrieve da ds 'dw_ge137_composicao_produto'.")
			Else				
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'dw_ge137_composicao_produto'.", StopSign!)
				Return -1
			End If
		End If
		
		If lvs_filiais = 'C' Then
			w_Aguarde.Title = "Calculando Saldo Filial..."
			lvds_5.of_AppendWhere("cd_filial in ( " + is_filiais + " )" )
			lvds_5.Retrieve( lvdt_Mes_Base )
			
			lvds_4.of_AppendWhere("cd_filial in ( " + is_filiais + " )" )
			lds_Almoxarifado_Fil.of_AppendWhere("n.cd_filial_destino in ( " + is_filiais + " )" )
		End If
	
		lvdt_Mes_1 = wf_Mes_Anterior(lvdt_Mes_Base, 6)
		lvdt_Mes_2 = wf_Mes_Anterior(lvdt_Mes_Base, 5)
		lvdt_Mes_3 = wf_Mes_Anterior(lvdt_Mes_Base, 4)
		lvdt_Mes_4 = wf_Mes_Anterior(lvdt_Mes_Base, 3)
		lvdt_Mes_5 = wf_Mes_Anterior(lvdt_Mes_Base, 2)
		lvdt_Mes_6 = wf_Mes_Anterior(lvdt_Mes_Base, 1)
		 
		For lvl_Contames = 1 to 7
			 
			 If lvl_Contames = 1 Then
				 lvdt_mes = lvdt_mes_1
			 ElseIf lvl_Contames = 2 Then
				 lvdt_mes = lvdt_mes_2
			 ElseIf lvl_Contames = 3 Then
				 lvdt_mes = lvdt_mes_3
			 ElseIf lvl_Contames = 4 Then
				 lvdt_mes = lvdt_mes_4
			 ElseIf lvl_Contames = 5 Then
				 lvdt_mes = lvdt_mes_5
			 ElseIf lvl_Contames = 6 Then
				 lvdt_mes = lvdt_mes_6
			 ElseIf lvl_Contames = 7 Then
				 lvdt_mes = lvdt_mes_base
			 End If
		 
				 
			 w_Aguarde.Title = "Calculando Vendas do M$$HEX1$$ea00$$ENDHEX$$s " + string(lvdt_Mes,"mm/yyyy")
			 w_Aguarde.uo_Progress.of_Reset()
			 w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
			If lvs_filiais = 'C' Then
				lvds_4.Retrieve(lvdt_Mes)
				ldt_Ultimo_Dia_Mes = gf_Retorna_Ultimo_Dia_Mes(lvdt_mes)
				lds_Almoxarifado_Fil.Retrieve(lvdt_Mes, ldt_Ultimo_Dia_Mes)
			 Else
				 lvds_2.Retrieve(lvdt_Mes)
				 lds_Almoxarifado.Retrieve(lvdt_Mes)
			 End If
	
			 For lvl_Contaitem = 1 To lvl_Total
				  lvl_Produto = lvds_1.Object.Cd_Produto[lvl_Contaitem]
					
				  If lvl_Contames = 7 Then
					  lvds_1.Object.Pc_Desconto_SOS[lvl_Contaitem] = wf_Desconto_SOS(lvl_Produto)
	
					 lvl_Saldo_Matriz = wf_Saldo_Matriz(lvl_Produto,lvds_3)
					 lvds_1.Object.Qt_Saldo_Matriz[lvl_Contaitem] = lvl_Saldo_Matriz
					 					
					 // F	SEGREG. MERCAD TRANS
					 ll_SaldoSegreg_Trans =  wf_saldo_wms_segregado(lvl_produto, lvds_Saldo_Segreg, 'F')
					 lvds_1.Object.segreg_merc_trans[lvl_Contaitem] = ll_SaldoSegreg_Trans
					
					 /// 	B	SEGREG. DEVOLU$$HEX2$$fa00fb00$$ENDHEX$$O
					 ll_SaldoSegreg_Dev =  wf_saldo_wms_segregado(lvl_produto, lvds_Saldo_Segreg, 'B')
					 lvds_1.Object.segreg_devolucao[lvl_Contaitem] = ll_SaldoSegreg_Dev

					/// 	A	SEGREG. RECEBIMENTO
					ll_SaldoSegreg_Receb =  wf_saldo_wms_segregado(lvl_produto, lvds_Saldo_Segreg, 'A')
					lvds_1.Object.segreg_recebimento[lvl_Contaitem] = ll_SaldoSegreg_Receb
			   					 
					 If lvs_filiais = 'C' Then
						  lvl_Saldo_Filiais = wf_saldo_Filial(lvl_Produto,lvds_5)
						  lvds_1.Object.Qt_Saldo_Filiais[lvl_Contaitem] = lvl_Saldo_Filiais
					  Else
						  wf_Saldo_Filiais(lvl_Produto, lvds_2, lvl_Saldo_Filiais)
						  lvds_1.Object.Qt_Saldo_Filiais[lvl_Contaitem] = lvl_Saldo_Filiais - lvl_Saldo_Matriz
					  End If
					  
					  //Tratamento Tipo Comissao
					  lvds_1.Object.pc_comissao_normal		[lvl_Contaitem] = wf_Consulta_Comissao(lvl_Produto, 1, lds_comissao)
					  lvds_1.Object.pc_comissao_seletiva		[lvl_Contaitem] = wf_Consulta_Comissao(lvl_Produto, 2, lds_comissao)
					  
					  //Informa a composi$$HEX2$$e700e300$$ENDHEX$$o do produto
					  If Not wf_Composicao_Produto(lvl_Produto, lds_Composicao, Ref ls_Substancia) Then Return -1
					  lvds_1.Object.De_Substancia[lvl_Contaitem] = ls_Substancia
					  
	
				End If
				  
				  ls_Grupo_Prod = lvds_1.Object.Cd_Grupo[lvl_Contaitem]
			
				  If lvs_filiais = 'C' Then
					//Se for grupo 5 captura vendas (transfer$$HEX1$$ea00$$ENDHEX$$ncia) do almoxarifado
					If ls_Grupo_Prod = '5' Then					
						If lvl_Contames = 1 Then
						  lvds_1.Object.Qt_Venda_Mes_1[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado_Fil)
						ElseIf lvl_Contames = 2 Then
						  lvds_1.Object.Qt_Venda_Mes_2[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado_Fil)
						ElseIf lvl_Contames = 3 Then
						  lvds_1.Object.Qt_Venda_Mes_3[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado_Fil)
						ElseIf lvl_Contames = 4 Then
						  lvds_1.Object.Qt_Venda_Mes_4[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado_Fil)
						ElseIf lvl_Contames = 5 Then
						  lvds_1.Object.Qt_Venda_Mes_5[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado_Fil)
						ElseIf lvl_Contames = 6 Then
						  lvds_1.Object.Qt_Venda_Mes_6[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado_Fil)
						ElseIf lvl_Contames = 7 Then
						  lvds_1.Object.Qt_Venda_Mes_Base[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado_Fil)
						End If
					Else
						If lvl_Contames = 1 Then
						  lvds_1.Object.Qt_Venda_Mes_1[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4)  					
						ElseIf lvl_Contames = 2 Then
						  lvds_1.Object.Qt_Venda_Mes_2[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4)
						ElseIf lvl_Contames = 3 Then
						  lvds_1.Object.Qt_Venda_Mes_3[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4)
						ElseIf lvl_Contames = 4 Then
						  lvds_1.Object.Qt_Venda_Mes_4[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4)
						ElseIf lvl_Contames = 5 Then
						  lvds_1.Object.Qt_Venda_Mes_5[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4)
						ElseIf lvl_Contames = 6 Then
						  lvds_1.Object.Qt_Venda_Mes_6[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4)
						ElseIf lvl_Contames = 7 Then
						  lvds_1.Object.Qt_Venda_Mes_Base[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4)
						End If
					End If //FIM CONJUNTO FILIAIS
					  
				  Else
					
					//Se for grupo 5 captura vendas (transfer$$HEX1$$ea00$$ENDHEX$$ncia) do almoxarifado
					If ls_Grupo_Prod = '5' Then
						If lvl_Contames = 1 Then
						  lvds_1.Object.Qt_Venda_Mes_1[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado)
						ElseIf lvl_Contames = 2 Then
						  lvds_1.Object.Qt_Venda_Mes_2[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado)
						ElseIf lvl_Contames = 3 Then
						  lvds_1.Object.Qt_Venda_Mes_3[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado)
						ElseIf lvl_Contames = 4 Then
						  lvds_1.Object.Qt_Venda_Mes_4[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado)
						ElseIf lvl_Contames = 5 Then
						  lvds_1.Object.Qt_Venda_Mes_5[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado)
						ElseIf lvl_Contames = 6 Then
						  lvds_1.Object.Qt_Venda_Mes_6[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado)
						ElseIf lvl_Contames = 7 Then
						  lvds_1.Object.Qt_Venda_Mes_Base[lvl_Contaitem] = wf_Venda_Almoxarifado(lvl_Produto, lds_Almoxarifado)
						End If
					Else
						If lvl_Contames = 1 Then
						  lvds_1.Object.Qt_Venda_Mes_1[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2)
						ElseIf lvl_Contames = 2 Then
						  lvds_1.Object.Qt_Venda_Mes_2[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2)
						ElseIf lvl_Contames = 3 Then
						  lvds_1.Object.Qt_Venda_Mes_3[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2)
						ElseIf lvl_Contames = 4 Then
						  lvds_1.Object.Qt_Venda_Mes_4[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2)
						ElseIf lvl_Contames = 5 Then
						  lvds_1.Object.Qt_Venda_Mes_5[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2)
						ElseIf lvl_Contames = 6 Then
						  lvds_1.Object.Qt_Venda_Mes_6[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2)
						ElseIf lvl_Contames = 7 Then
						  lvds_1.Object.Qt_Venda_Mes_Base[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2)
						End If			  
					End If //FIM TODAS FILIAIS
				End If //FIM TODAS FILIAIS / CONJUNTO FILIAIS
	
				w_Aguarde.uo_Progress.of_SetProgress(lvl_Contaitem)
				  
			Next //Total Planilha
		Next
		
		If Not wf_Saldo_Em_Transito(lvds_1) Then Return -1
		
		w_Aguarde.Title = "Salvando Planilha..."
		
		If gvb_Auto Or lvl_Total > 65000 Then
			//Salva em CSV no C quando $$HEX1$$e900$$ENDHEX$$ gerado manual com mais de 65 mil linhas e quando $$HEX1$$e900$$ENDHEX$$ autom$$HEX1$$e100$$ENDHEX$$tico, pra ter um backup
			lvs_Arquivo =  lvs_Diretorio + "analise_geral_automatica_" + String(Today(), "ddmmyy") + "_" + String(Now(), "hhmm") + ".csv"
		
			ll_Saveas = lvds_1.SaveAsFormattedText(lvs_Arquivo, EncodingANSI!, ";")		
			
			//Salva no diret$$HEX1$$f300$$ENDHEX$$rio especificado pelo compras somente quando $$HEX1$$e900$$ENDHEX$$ gerado autom$$HEX1$$e100$$ENDHEX$$tico
			If gvb_Auto Then
				lvs_Arquivo =  ls_Path + "\analise_geral_automatica_" + String(Today(), "ddmmyy") + "_" + String(Now(), "hhmm") + ".csv"
				
				ll_Saveas = lvds_1.SaveAsFormattedText(lvs_Arquivo, EncodingANSI!, ";")
			End If
		Else
			
			lvs_Arquivo = lvs_Diretorio + "analise_geral_" + String(Today(), "ddmmyy") + "_" + String(Now(), "hhmm") + ".xls"
			
			ll_Saveas = lvds_1.SaveAs(lvs_Arquivo, Excel!, True)
		End If
		
		If ll_Saveas = 1 Then
			If Not gvb_Auto Then
				lvt_Termino = Now()
				
				is_geracao_planilha	= 'SUCESSO'
				
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Planilha '" + lvs_Arquivo + "' gerada com sucesso.~r~r" + &
											 "In$$HEX1$$ed00$$ENDHEX$$cio: "  + String(lvt_Inicio , "hh:mm:ss") + "~r" + &
											 "T$$HEX1$$e900$$ENDHEX$$rmino: " + String(lvt_Termino, "hh:mm:ss"), Information!)
			End If
			
			dw_1.Reset()
			dw_1.Event ue_AddRow()
			dw_1.Object.Dt_Inicio [1] = Date("01/" + String(Today(), "mm/yyyy"))
			dw_1.SetFocus()
		Else
			If gvb_Auto Then
				wf_Envia_Email("Erro no saveas da planilha '" + lvs_Arquivo + "'.")
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no saveas da planilha '" + lvs_Arquivo + "'.", StopSign!)
			End If
		End If
	Else
		If gvb_Auto Then
			wf_Envia_Email("Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.",Information!)
		End If
	End If
		
Finally
	Destroy(lvds_1)
	Destroy(lvds_2)
	Destroy(lvds_3)
	Destroy(lvds_4)
	Destroy(lvds_5)
	Destroy(lds_comissao)
	Destroy(lds_Almoxarifado)
	Destroy(lds_Almoxarifado_Fil)
	Destroy(lds_Composicao)
	Destroy(lvds_Saldo_Segreg)
	
	Close(w_Aguarde)
	SetPointer(Arrow!)
	
	If gvb_Auto Then
		cb_Sair.Event Clicked()
	End If
End Try
end event

type cb_sair from commandbutton within w_ge137_planilha_analise_geral
integer x = 1696
integer y = 1096
integer width = 379
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sai&r"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, is_geracao_planilha)
end event

type dw_1 from dc_uo_dw_base within w_ge137_planilha_analise_geral
integer x = 41
integer y = 52
integer width = 2007
integer height = 992
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge137_selecao"
end type

event ue_key;String lvs_Coluna

IF Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
		
	Choose Case lvs_Coluna 
		Case "de_filial" ; WF_Localiza_Filial()
	
		Case "nm_fornecedor"
			wf_Localiza_Fornecedor()
			
		Case "de_grupo"
			
			If ivo_Classificacao.wf_Localiza_Grupo(This.GetText()) Then
				
				wf_Limpa_Campos("de_grupo")
				wf_Atualiza_Campos("de_grupo")
				
			End If
			
		Case "de_subgrupo"
			
			If ivo_Classificacao.wf_Localiza_SubGrupo(This.GetText()) Then
				
				wf_Limpa_Campos("de_subgrupo")
				wf_Atualiza_Campos("de_subgrupo")

			End If
			
		Case "de_categoria"
			
			If ivo_Classificacao.of_Localiza_Categoria(This.GetText()) Then
				
				wf_Limpa_Campos("de_categoria")
				wf_Atualiza_Campos("de_categoria")

			End If
			
		Case "de_subcategoria"
			
			If ivo_Classificacao.of_Localiza_SubCategoria(This.GetText()) Then
				
				wf_Atualiza_Campos("de_subcategoria")
				
			End If

	End Choose
End If
end event

event itemchanged;Long ll_Lojas
Long ll_Null[]




Choose Case dwo.Name
	
	Case "de_filial"
		
		If Data = 'C' Then
		
			is_filiais = is_nulo 
			
			OpenWithParm(w_ge216_selecao_filiais, io_Filiais)
			
			ll_Lojas = Message.DoubleParm
			
			If ll_Lojas > 0 Then 
				is_filiais = io_Filiais.ivs_filiais				
			Else
				This.Object.de_filial[1] = 'T'
				Return 1
			End If
		
		End If
		

	Case "de_grupo"
		If Trim(Data) <> "" Then
			If Data <> ivo_Classificacao.De_Grupo Then
				Return 1
			End If	
		Else			
			wf_Limpa_Campos("de_grupo")
			
			SetNull(ivo_Classificacao.Cd_Grupo)
			ivo_Classificacao.De_Grupo = ""

			This.Object.Cd_Grupo[1] = ivo_Classificacao.Cd_Grupo
			This.Object.De_Grupo[1] = ivo_Classificacao.De_Grupo	
		End If

	Case "de_subgrupo"
		
		If Trim(Data) <> "" Then
			If Data <> ivo_Classificacao.De_SubGrupo Then
				Return 1
			End If	
		Else			
			wf_Limpa_Campos("de_subgrupo")
			
			SetNull(ivo_Classificacao.Cd_SubGrupo)
			ivo_Classificacao.De_SubGrupo = ""

			This.Object.Cd_SubGrupo[1] = ivo_Classificacao.Cd_SubGrupo
			This.Object.De_SubGrupo[1] = ivo_Classificacao.De_SubGrupo
		End If
		
	Case "de_categoria"
		
		If Trim(Data) <> "" Then
			If Data <> ivo_Classificacao.De_Categoria Then
				Return 1
			End If	
		Else			
			wf_Limpa_Campos("de_categoria")
			
			SetNull(ivo_Classificacao.Cd_Categoria)
			ivo_Classificacao.De_Categoria = ""

			This.Object.Cd_Categoria[1] = ivo_Classificacao.Cd_Categoria
			This.Object.De_Categoria[1] = ivo_Classificacao.De_Categoria
		End If
		
	Case "de_subcategoria"
		
		If Trim(Data) <> "" Then
			If Data <> ivo_Classificacao.De_SubCategoria Then
				Return 1
			End If	
		Else			
			
			SetNull(ivo_Classificacao.Cd_SubCategoria)
			ivo_Classificacao.De_SubCategoria = ""

			This.Object.Cd_SubCategoria[1] = ivo_Classificacao.Cd_SubCategoria
			This.Object.De_SubCategoria[1] = ivo_Classificacao.De_SubCategoria
		End If
		
	Case "nm_fornecedor"
		
		If Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_razao_social Then
				Return 1
			End If	
		Else
			
			ivo_fornecedor.of_Inicializa()			
			
			This.Object.cd_fornecedor[1] 	= ivo_fornecedor.cd_fornecedor
			This.Object.nm_fornecedor[1] 	= ivo_fornecedor.nm_razao_social
		End If
		
		gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor,1)
		
	// Para escolha de um ou mais planogramas
	Case "cd_planograma"				
		If Data = 'C' Then
				
				io_planogramas.il_Analise = io_analise.nr_analise
				OpenWithParm( w_ge137_selecao_planograma, io_planogramas )
				io_planogramas = Message.PowerObjectParm			
			
				If IsNull(io_planogramas.is_Planogramas ) Or io_planogramas.is_Planogramas = "" Then 
					This.Object.cd_planograma[ 1 ] = "T"
					Return 1
				End If 								
		End If
			
				
		
End Choose
end event

event constructor;call super::constructor;This.of_SetColSelection(True)

end event

event editchanged;call super::editchanged;Choose Case dwo.Name
	Case "nm_fornecedor"
			
		If Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_razao_social Then
				Return 1
			End If	
		Else
			
			ivo_fornecedor.of_Inicializa()			
			
			This.Object.cd_fornecedor[1] 	= ivo_fornecedor.cd_fornecedor
			This.Object.nm_fornecedor[1] 	= ivo_fornecedor.nm_razao_social
		End If
			
	gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
End Choose
end event

type cb_1 from commandbutton within w_ge137_planilha_analise_geral
boolean visible = false
integer x = 448
integer y = 1076
integer width = 503
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Novo Autom$$HEX1$$e100$$ENDHEX$$tico"
end type

event clicked;uo_ge137_analise_geral_novo lo_Export
			Try
				lo_Export = Create uo_ge137_analise_geral_novo
				lo_Export.of_gera_arquivo ()
			
			Finally
				Destroy(lo_Export)
			End Try		
end event

type cb_gerar_automatico from commandbutton within w_ge137_planilha_analise_geral
integer x = 347
integer y = 1096
integer width = 402
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Automatico"
end type

event clicked;uo_ge137_analise_geral_novo  lo_Exp
Try
	lo_Exp = Create uo_ge137_analise_geral_novo
	lo_Exp.of_gera_arquivo ()
Finally
	Destroy(lo_Exp)
End Try	
end event

type gb_1 from groupbox within w_ge137_planilha_analise_geral
integer x = 18
integer width = 2057
integer height = 1072
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

