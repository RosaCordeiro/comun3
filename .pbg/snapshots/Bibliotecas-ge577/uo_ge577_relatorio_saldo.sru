HA$PBExportHeader$uo_ge577_relatorio_saldo.sru
forward
global type uo_ge577_relatorio_saldo from nonvisualobject
end type
end forward

global type uo_ge577_relatorio_saldo from nonvisualobject
end type
global uo_ge577_relatorio_saldo uo_ge577_relatorio_saldo

type variables

end variables

forward prototypes
public function boolean of_buscar_dados (ref dc_uo_ds_base ads, long al_for, ref uo_ge040_args auo_ge040_args)
public function boolean of_gravar_cabecalho (ref integer ai_arquivo)
public function boolean of_gravar_dados (ref integer ai_arquivo, uo_ge040_args luo_ge040_args)
public function boolean of_criar_arquivo (string as_nome_arquivo, ref integer li_arquivo, ref string as_arquivo)
public function boolean of_buscar_arquivo (ref string as_cd_filial_sap[])
public function boolean of_controle_ds (ref dc_uo_ds_base ads, string as_cd_filiais_sap[])
end prototypes

public function boolean of_buscar_dados (ref dc_uo_ds_base ads, long al_for, ref uo_ge040_args auo_ge040_args);Dec{2}	ldc_vl_fator_conversao, ldc_vl_custo_medio
Long		ll_cd_produto, ll_cd_filial, ll_ncm, ll_qt_saldo_final
String	ls_base_dados, ls_cd_produto_sap, ls_cd_filial_sap, ls_ambiente_wms, ls_deposito_sap, &
			ls_de_produto, ls_de_apresentacao_estoque, ls_de_apresentacao_venda, ls_cd_grupo_psico, &
			ls_de_grupo, ls_de_subgrupo, ls_de_subcategoria, ls_unidade_medida, ls_de_registro_ms


ls_base_dados					= ads.Object.base_dados[al_for]
ll_cd_produto					= ads.Object.cd_produto[al_for]
ls_cd_produto_sap				= ads.Object.cd_produto_sap[al_for]
ll_cd_filial					= ads.Object.cd_filial[al_for]
ls_cd_filial_sap				= ads.Object.cd_filial_sap[al_for]
ls_ambiente_wms				= ads.Object.ambiente_wms[al_for]
ls_deposito_sap				= ads.Object.deposito_sap[al_for]
ls_de_produto					= ads.Object.de_produto[al_for]
ls_de_apresentacao_estoque	= ads.Object.de_apresentacao_estoque[al_for]
ls_de_apresentacao_venda	= ads.Object.de_apresentacao_venda[al_for]
ls_cd_grupo_psico				= ads.Object.cd_grupo_psico[al_for]
ls_de_grupo						= ads.Object.de_grupo[al_for]
ls_de_subgrupo					= ads.Object.de_subgrupo[al_for]
ls_de_subcategoria			= ads.Object.de_subcategoria[al_for]
ldc_vl_fator_conversao		= ads.Object.vl_fator_conversao[al_for]
ls_unidade_medida				= ads.Object.unidade_medida[al_for]
ll_ncm							= ads.Object.ncm[al_for]
ls_de_registro_ms				= ads.Object.de_registro_ms[al_for]
ll_qt_saldo_final				= ads.Object.qt_saldo_final[al_for]
ldc_vl_custo_medio			= ads.Object.vl_custo_medio[al_for]

auo_ge040_args.of_add_arg("base_dados", ls_base_dados)
auo_ge040_args.of_add_arg("cd_produto", ll_cd_produto)
auo_ge040_args.of_add_arg("cd_produto_sap", ls_cd_produto_sap)
auo_ge040_args.of_add_arg("cd_filial", ll_cd_filial)
auo_ge040_args.of_add_arg("cd_filial_sap", ls_cd_filial_sap)
auo_ge040_args.of_add_arg("ambiente_wms", ls_ambiente_wms)
auo_ge040_args.of_add_arg("deposito_sap", ls_deposito_sap)
auo_ge040_args.of_add_arg("de_produto", ls_de_produto)
auo_ge040_args.of_add_arg("de_apresentacao_estoque", ls_de_apresentacao_estoque)
auo_ge040_args.of_add_arg("de_apresentacao_venda", ls_de_apresentacao_venda)
auo_ge040_args.of_add_arg("cd_grupo_psico", ls_cd_grupo_psico)
auo_ge040_args.of_add_arg("de_grupo", ls_de_grupo)
auo_ge040_args.of_add_arg("de_subgrupo", ls_de_subgrupo)
auo_ge040_args.of_add_arg("de_subcategoria", ls_de_subcategoria)
auo_ge040_args.of_add_arg("vl_fator_conversao", ldc_vl_fator_conversao)
auo_ge040_args.of_add_arg("unidade_medida", ls_unidade_medida)
auo_ge040_args.of_add_arg("ncm", ll_ncm)
auo_ge040_args.of_add_arg("de_registro_ms", ls_de_registro_ms)
auo_ge040_args.of_add_arg("qt_saldo_final", ll_qt_saldo_final)
auo_ge040_args.of_add_arg("vl_custo_medio", ldc_vl_custo_medio)

Return True
end function

public function boolean of_gravar_cabecalho (ref integer ai_arquivo);String	ls_texto


ls_texto = "Banco de Dados, "  + &
			  "C$$HEX1$$f300$$ENDHEX$$digo Produto Legado, " + &
			  "C$$HEX1$$f300$$ENDHEX$$digo Produto SAP, " + &
			  "C$$HEX1$$f300$$ENDHEX$$digo Filial Legado, " + &			  
			  "C$$HEX1$$f300$$ENDHEX$$digo Filial SAP, " + &
			  "Ambiente WMS, " + &
			  "Dep$$HEX1$$f300$$ENDHEX$$sito SAP, " + &
			  "Descri$$HEX2$$e700e300$$ENDHEX$$o Produto, " + &
			  "Apresenta$$HEX2$$e700e300$$ENDHEX$$o Produto Estoque, " + &
			  "Apresenta$$HEX2$$e700e300$$ENDHEX$$o Produto Venda, " + &
			  "C$$HEX1$$f300$$ENDHEX$$digo Grupo Psico, " + &
			  "Descri$$HEX2$$e700e300$$ENDHEX$$o Grupo, " + &
			  "Descri$$HEX2$$e700e300$$ENDHEX$$o SubGrupo, " + &
			  "Descri$$HEX2$$e700e300$$ENDHEX$$o SubCategoria, " + &
			  "Fator de Convers$$HEX1$$e300$$ENDHEX$$o, " + &
			  "Unidade de Medida, " + &
			  "NCM, " + &
			  "Registro MS, " + &
			  "Saldo, " + &
			  "Custo M$$HEX1$$e900$$ENDHEX$$dio"

If FileWriteEx(ai_arquivo, ls_texto) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar no arquivo." , StopSign!)
	Return False
End If

Return True
end function

public function boolean of_gravar_dados (ref integer ai_arquivo, uo_ge040_args luo_ge040_args);Dec{2}	ldc_vl_fator_conversao, ldc_vl_custo_medio
Long		ll_cd_produto, ll_cd_filial, ll_ncm, ll_qt_saldo_final
String	ls_base_dados, ls_cd_produto_sap, ls_cd_filial_sap, ls_ambiente_wms, ls_deposito_sap, &
			ls_de_produto, ls_de_apresentacao_estoque, ls_de_apresentacao_venda, ls_cd_grupo_psico, &
			ls_de_grupo, ls_de_subgrupo, ls_de_subcategoria, ls_unidade_medida, ls_de_registro_ms, &
			ls_texto


ls_base_dados					= luo_ge040_args.of_get_arg("base_dados")
ll_cd_produto					= luo_ge040_args.of_get_arg("cd_produto")
ls_cd_produto_sap				= luo_ge040_args.of_get_arg("cd_produto_sap")
ll_cd_filial					= luo_ge040_args.of_get_arg("cd_filial")
ls_cd_filial_sap				= luo_ge040_args.of_get_arg("cd_filial_sap")
ls_ambiente_wms				= luo_ge040_args.of_get_arg("ambiente_wms")
ls_deposito_sap				= luo_ge040_args.of_get_arg("deposito_sap")
ls_de_produto					= luo_ge040_args.of_get_arg("de_produto")
ls_de_apresentacao_estoque	= luo_ge040_args.of_get_arg("de_apresentacao_estoque")
ls_de_apresentacao_venda	= luo_ge040_args.of_get_arg("de_apresentacao_venda")
ls_cd_grupo_psico				= luo_ge040_args.of_get_arg("cd_grupo_psico")
ls_de_grupo						= luo_ge040_args.of_get_arg("de_grupo")
ls_de_subgrupo					= luo_ge040_args.of_get_arg("de_subgrupo")
ls_de_subcategoria			= luo_ge040_args.of_get_arg("de_subcategoria")
ldc_vl_fator_conversao		= luo_ge040_args.of_get_arg("vl_fator_conversao")
ls_unidade_medida				= luo_ge040_args.of_get_arg("unidade_medida")
ll_ncm							= luo_ge040_args.of_get_arg("ncm")
ls_de_registro_ms				= luo_ge040_args.of_get_arg("de_registro_ms")
ll_qt_saldo_final				= luo_ge040_args.of_get_arg("qt_saldo_final")
ldc_vl_custo_medio			= luo_ge040_args.of_get_arg("vl_custo_medio")

If IsNull(ls_cd_produto_sap) or Trim(ls_cd_produto_sap) = "" Then Return False
If IsNull(ls_de_apresentacao_estoque) or Trim(ls_de_apresentacao_estoque) = "" Then Return False
If IsNull(ls_de_apresentacao_venda) or Trim(ls_de_apresentacao_venda) = "" Then Return False
If IsNull(ls_cd_grupo_psico) or Trim(ls_cd_grupo_psico) = "" Then Return False

ls_texto	= ls_base_dados + "," + &
			  String(ll_cd_produto) + "," + &
			  ls_cd_produto_sap + "," + &
			  String(ll_cd_filial) + "," + &
			  ls_cd_filial_sap + "," + &
			  ls_ambiente_wms + "," + &
			  ls_deposito_sap + "," + &
			  ls_de_produto + "," + &
			  ls_de_apresentacao_estoque + "," + &
			  ls_de_apresentacao_venda + "," + &
			  ls_cd_grupo_psico + "," + &
			  ls_de_grupo + "," + &
			  ls_de_subgrupo + "," + &
			  ls_de_subcategoria + "," + &
			  gf_valor_com_ponto(ldc_vl_fator_conversao) + "," + &
			  ls_unidade_medida + "," + &
			  String(ll_ncm) + "," + &
			  ls_de_registro_ms + "," + &
			  String(ll_qt_saldo_final, '#####0') + "," + &
			  gf_valor_com_ponto(ldc_vl_custo_medio)
			  
If FileWriteEx(ai_arquivo, ls_texto) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar no arquivo." , StopSign!)
	Return False
End If

Return True
end function

public function boolean of_criar_arquivo (string as_nome_arquivo, ref integer li_arquivo, ref string as_arquivo);String	ls_caminho


ls_caminho = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

as_arquivo = ls_caminho + as_nome_arquivo + '.txt'

if FileExists(as_arquivo) then
	FileDelete(as_arquivo)
end if

li_arquivo = FileOpen(as_arquivo, LineMode!, Write!)
	
If li_arquivo = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo '" + as_arquivo + "'.", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_buscar_arquivo (ref string as_cd_filial_sap[]);Int		li_arquivo
Long		ll_resposta
String	ls_Path, ls_Arquivo, ls_row, ls_cd_produto_sap, ls_dh_limite, ls_cd_filial_sap


ll_resposta = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja importar o arquivo para ter o relat$$HEX1$$f300$$ENDHEX$$rio apenas das filiais desejadas? (RECOMENDADO)", Question!, YesNoCancel!, 1)

if ll_resposta = 1 then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar separados por virgula e da seguinte forma:~r~r" + &
						"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo da Filial SAP")
	
	GetFileOpenName("Selecione o arquivo", &
						ls_Path, &
						ls_Arquivo  , &
						"Text Files (*.txt);*.txt," &
						+ "All Files (*.*); *.*")
	
	li_arquivo = FileOpen(ls_Path, LineMode!)
			  
	do while FileRead(li_arquivo, ls_row) > 0
		ls_cd_filial_sap	= ls_row
		ls_row	= ''
		
		if Not IsNull(ls_cd_filial_sap) and Trim(ls_cd_filial_sap) <> '' then
			as_cd_filial_sap[UpperBound(as_cd_filial_sap) + 1] = ls_cd_filial_sap
			ls_cd_filial_sap	= ''
		end if
	loop
	
	FileClose(li_arquivo)
elseif ll_resposta = 3 then
	return false
end if

return true
end function

public function boolean of_controle_ds (ref dc_uo_ds_base ads, string as_cd_filiais_sap[]);Date		ld_dh_saldo
String	ls_ds_dataobject, ls_todas_filiais 

ads = Create dc_uo_ds_base


ls_ds_dataobject	= "ds_ge577_relatorio_saldo"

If Not ads.of_ChangeDataObject(ls_ds_dataobject, False) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a DW '" + ls_ds_dataobject + "' - " + 'lista_relatorios_arquivos', StopSign!)
	Return False
End If

select max(dh_saldo)
  into :ld_dh_saldo
  from saldo_produto;
  
Choose Case SQLCA.SQLCode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar data do saldo de estoque atual. " + SQLCA.SQLErrText, StopSign!)
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado saldo informado no sistema", StopSign!)
		Return False
End Choose

if UpperBound(as_cd_filiais_sap) = 0 then
	as_cd_filiais_sap[1]	= '0'
	ls_todas_filiais  = 'S'
else
	ls_todas_filiais = 'N'
end if

ads.Retrieve(as_cd_filiais_sap, ld_dh_saldo, ls_todas_filiais)

Return True
end function

on uo_ge577_relatorio_saldo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge577_relatorio_saldo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

