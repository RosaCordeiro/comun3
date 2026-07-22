HA$PBExportHeader$uo_ge577_relatorio_de_para_un_forn.sru
forward
global type uo_ge577_relatorio_de_para_un_forn from nonvisualobject
end type
end forward

global type uo_ge577_relatorio_de_para_un_forn from nonvisualobject
end type
global uo_ge577_relatorio_de_para_un_forn uo_ge577_relatorio_de_para_un_forn

forward prototypes
public function boolean of_grava_arquivo_cabecalho (ref integer ai_arquivo)
public function boolean of_controle_ds (ref dc_uo_ds_base ads)
public function boolean of_buscar_dados (ref dc_uo_ds_base ads, long al_for, ref string as_cd_produto_sap, ref string as_cd_fornecedor_sap, ref string as_cd_unidade_fornecedor, ref string as_cd_unidade_clamed)
public function boolean of_gravar_dados (ref integer ai_arquivo, string as_cd_produto_sap, string as_cd_fornecedor_sap, string as_cd_unidade_fornecedor, string as_cd_unidade_clamed)
public function boolean of_criar_arquivo (string as_nome_arquivo, ref integer li_arquivo, ref string as_caminho_arquivo)
end prototypes

public function boolean of_grava_arquivo_cabecalho (ref integer ai_arquivo);String	ls_texto


ls_texto = 'FORNECEDOR' + ',' + & 
			  'MATERIAL' + ',' + &
			  'UNIDADE MED FORNECEDOR' + ',' + &
			  'UNIDADE MED CLAMED'
								
If FileWriteEx(ai_arquivo, ls_texto) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar no arquivo", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_controle_ds (ref dc_uo_ds_base ads);ads = Create dc_uo_ds_base

If Not ads.of_ChangeDataObject('ds_ge577_rel_lista_forn_prod_agendados', False) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a DW '" + 'ds_ge577_rel_lista_forn_prod_agendados' + "' - " + 'lista_relatorios_arquivos', StopSign!)
	Return False
End If

ads.Retrieve()

Return True
end function

public function boolean of_buscar_dados (ref dc_uo_ds_base ads, long al_for, ref string as_cd_produto_sap, ref string as_cd_fornecedor_sap, ref string as_cd_unidade_fornecedor, ref string as_cd_unidade_clamed);Long		ll_cd_produto
String	ls_cd_fornecedor


ls_cd_fornecedor	= ads.Object.cd_fornecedor[al_for]
ll_cd_produto		= ads.Object.cd_produto[al_for]

select top 1 pg.cd_produto_sap,
				 f.cd_fornecedor_sap ,
				 i.cd_unidade_comercial, 
				 CASE 
					WHEN pg.vl_fator_conversao > 1 THEN 
						'CXU' 
					ELSE 
						pg.cd_unidade_medida_venda
				 END
  into :as_cd_produto_sap,
		 :as_cd_fornecedor_sap,
		 :as_cd_unidade_fornecedor,
		 :as_cd_unidade_clamed
  from nf_agendamento_ent n inner join fornecedor f on f.nr_cgc = n.nr_cgc_fornecedor 
									 inner join nf_agendamento_ent_item i on i.de_chave_acesso = n.de_chave_acesso 
									 inner join produto_geral pg on pg.cd_produto = i.cd_produto 
 where f.cd_fornecedor 	= :ls_cd_fornecedor
	and pg.cd_produto 	= :ll_cd_produto
 order by n.dh_inclusao desc
using SQLCA;

If SQLCA.SQLCode <> 0 then 
	Return False
End If

Return True
end function

public function boolean of_gravar_dados (ref integer ai_arquivo, string as_cd_produto_sap, string as_cd_fornecedor_sap, string as_cd_unidade_fornecedor, string as_cd_unidade_clamed);String	ls_texto


if IsNull(as_cd_fornecedor_sap) Then as_cd_fornecedor_sap = ""
if IsNull(as_cd_produto_sap) Then as_cd_produto_sap = ""
if IsNull(as_cd_unidade_fornecedor) Then as_cd_unidade_fornecedor = ""
if IsNull(as_cd_unidade_clamed) Then as_cd_unidade_clamed = ""

ls_texto = as_cd_fornecedor_sap + ',' + & 
			  as_cd_produto_sap + ',' + &
			  as_cd_unidade_fornecedor + ',' + &
			  as_cd_unidade_clamed
									
If FileWriteEx(ai_arquivo, ls_texto) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar no arquivo." , StopSign!)
	Return False
End If

Return True
end function

public function boolean of_criar_arquivo (string as_nome_arquivo, ref integer li_arquivo, ref string as_caminho_arquivo);String	ls_caminho


ls_caminho = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

as_caminho_arquivo = ls_caminho + as_nome_arquivo + '.txt'

if FileExists(as_caminho_arquivo) then
	FileDelete(as_caminho_arquivo)
end if

li_arquivo = FileOpen(as_caminho_arquivo, LineMode!, Write!)
	
If li_arquivo = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo '" + as_caminho_arquivo + "'.", StopSign!)
	Return False
End If

Return True
end function

on uo_ge577_relatorio_de_para_un_forn.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge577_relatorio_de_para_un_forn.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

