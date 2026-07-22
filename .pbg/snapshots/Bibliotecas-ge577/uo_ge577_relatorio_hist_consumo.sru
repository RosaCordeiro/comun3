HA$PBExportHeader$uo_ge577_relatorio_hist_consumo.sru
forward
global type uo_ge577_relatorio_hist_consumo from nonvisualobject
end type
end forward

global type uo_ge577_relatorio_hist_consumo from nonvisualobject
end type
global uo_ge577_relatorio_hist_consumo uo_ge577_relatorio_hist_consumo

type variables
Private:
Date 		id_dh_limite	= Date("2021-05-01")
String	is_tipo_relatorio = "AGR" //AGR - Agrupado | SEP - Separado por filial
end variables

forward prototypes
public function boolean of_setar_is_tipo_relatorio (string as_tipo_relatorio)
public function boolean of_buscar_dados_agr (dc_uo_ds_base ads, long al_for, ref uo_ge040_args auo_ge040_args)
public function boolean of_buscar_dados (ref dc_uo_ds_base ads, long al_for, ref uo_ge040_args auo_ge040_args)
public function boolean of_gravar_dados_agr (ref integer ai_arquivo, uo_ge040_args luo_ge040_args)
public function boolean of_gravar_cabecalho_agr (ref integer ai_arquivo)
public function boolean of_gravar_cabecalho (ref integer ai_arquivo)
public function boolean of_gravar_dados (ref integer ai_arquivo, uo_ge040_args luo_ge040_args)
public function boolean of_buscar_dados_sep (dc_uo_ds_base ads, long al_for, ref uo_ge040_args auo_ge040_args)
public function boolean of_gravar_cabecalho_sep (ref integer ai_arquivo)
public function boolean of_gravar_dados_sep (ref integer ai_arquivo, uo_ge040_args luo_ge040_args)
public function boolean of_criar_arquivo (string as_nome_arquivo, ref integer li_arquivo, ref string as_arquivo)
public function boolean of_buscar_arquivo (ref string as_cd_produtos_sap[], ref string as_cd_filial_sap[], ref date ad_dh_limite)
public function boolean of_controle_ds (ref dc_uo_ds_base ads, string as_cd_produtos_sap[], string as_cd_filiais_sap[], date ad_dh_limite)
end prototypes

public function boolean of_setar_is_tipo_relatorio (string as_tipo_relatorio);if as_tipo_relatorio <> "AGR" and as_tipo_relatorio <> "SEP" then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de relat$$HEX1$$f300$$ENDHEX$$rio de hist$$HEX1$$f300$$ENDHEX$$rico de consumo errado.", StopSign!)
	Return False
end if

is_tipo_relatorio	= as_tipo_relatorio

Return True
end function

public function boolean of_buscar_dados_agr (dc_uo_ds_base ads, long al_for, ref uo_ge040_args auo_ge040_args);DateTime	ldt_dh_resumo
Long		ll_qt_vendida
String	ls_cd_produto_sap


ls_cd_produto_sap	= ads.Object.cd_produto_sap[al_for]
ldt_dh_resumo		= ads.Object.dh_resumo[al_for]
ll_qt_vendida		= ads.Object.qt_vendida[al_for]

//N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ registrado dados com quantidade vendida zerada
if ll_qt_vendida <= 0 Then
	Return False
End if

auo_ge040_args.of_add_arg("cd_produto_sap", ls_cd_produto_sap)
auo_ge040_args.of_add_arg("dt_dh_resumo", ldt_dh_resumo)
auo_ge040_args.of_add_arg("qt_vendida", ll_qt_vendida)

Return True
end function

public function boolean of_buscar_dados (ref dc_uo_ds_base ads, long al_for, ref uo_ge040_args auo_ge040_args);Choose Case is_tipo_relatorio
	Case "AGR"
		Return this.of_buscar_dados_agr(ads, al_for, auo_ge040_args)
	Case "SEP"
		Return this.of_buscar_dados_sep(ads, al_for, auo_ge040_args)
End Choose

Return False
end function

public function boolean of_gravar_dados_agr (ref integer ai_arquivo, uo_ge040_args luo_ge040_args);String	ls_texto, ls_cd_produto_sap, ls_dh_resumo, ls_qt_vendida
DateTime	ldt_dh_resumo
Long		ll_qt_vendida


ls_cd_produto_sap	= luo_ge040_args.of_get_arg("cd_produto_sap")
ldt_dh_resumo		= luo_ge040_args.of_get_arg("dt_dh_resumo")
ll_qt_vendida		= luo_ge040_args.of_get_arg("qt_vendida")

If IsNull(ls_cd_produto_sap) or Trim(ls_cd_produto_sap) = "" Then Return False
If IsNull(ldt_dh_resumo) or ldt_dh_resumo = DateTime("1900-01-01 00:00:00.0000") Then Return False
if IsNull(ll_qt_vendida) or ll_qt_vendida <= 0 Then Return False

ls_dh_resumo	= String(ldt_dh_resumo, "dd/mm/yyyy hh:mm:ss")
ls_qt_vendida	= String(ll_qt_vendida)

ls_texto	= ls_cd_produto_sap + "," + &
			  ls_dh_resumo + "," + &
			  ls_qt_vendida
			  
If FileWriteEx(ai_arquivo, ls_texto) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar no arquivo." , StopSign!)
	Return False
End If

Return True
end function

public function boolean of_gravar_cabecalho_agr (ref integer ai_arquivo);String	ls_texto


ls_texto = "Material, "  + &
			  "Dt. Resumo, " + &
			  "Qt. Vendida"

If FileWriteEx(ai_arquivo, ls_texto) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar no arquivo." , StopSign!)
	Return False
End If

Return True
end function

public function boolean of_gravar_cabecalho (ref integer ai_arquivo);Choose Case is_tipo_relatorio
	Case "AGR"
		Return this.of_gravar_cabecalho_agr(ai_arquivo)
	Case "SEP"
		Return this.of_gravar_cabecalho_sep(ai_arquivo)
End Choose

Return False
end function

public function boolean of_gravar_dados (ref integer ai_arquivo, uo_ge040_args luo_ge040_args);Choose Case is_tipo_relatorio
	Case "AGR"
		Return this.of_gravar_dados_agr(ai_arquivo, luo_ge040_args)
	Case "SEP"
		Return this.of_gravar_dados_sep(ai_arquivo, luo_ge040_args)
End Choose

Return False
end function

public function boolean of_buscar_dados_sep (dc_uo_ds_base ads, long al_for, ref uo_ge040_args auo_ge040_args);DateTime	ldt_dh_resumo
Long		ll_qt_vendida
String	ls_cd_produto_sap, ls_filial_sap


ls_cd_produto_sap	= ads.Object.cd_produto_sap[al_for]
ls_filial_sap		= ads.Object.filial_sap[al_for]
ldt_dh_resumo		= ads.Object.dh_resumo[al_for]
ll_qt_vendida		= ads.Object.qt_vendida[al_for]

//N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ registrado dados com quantidade vendida zerada
if ll_qt_vendida <= 0 Then
	Return False
End if

auo_ge040_args.of_add_arg("cd_produto_sap", ls_cd_produto_sap)
auo_ge040_args.of_add_arg("filial_sap", ls_filial_sap)
auo_ge040_args.of_add_arg("dh_resumo", ldt_dh_resumo)
auo_ge040_args.of_add_arg("qt_vendida", ll_qt_vendida)

Return True
end function

public function boolean of_gravar_cabecalho_sep (ref integer ai_arquivo);String	ls_texto


ls_texto = "Material, "  + &
			  "Filial SAP, " + &
			  "Dt. Resumo, " + &
			  "Qt. Vendida"

If FileWriteEx(ai_arquivo, ls_texto) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar no arquivo." , StopSign!)
	Return False
End If

Return True
end function

public function boolean of_gravar_dados_sep (ref integer ai_arquivo, uo_ge040_args luo_ge040_args);DateTime	ldt_dh_resumo
Long		ll_qt_vendida
String	ls_texto, ls_cd_produto_sap, ls_dh_resumo, ls_qt_vendida, ls_filial_sap


ls_cd_produto_sap	= luo_ge040_args.of_get_arg("cd_produto_sap")
ls_filial_sap		= luo_ge040_args.of_get_arg("filial_sap")
ldt_dh_resumo		= luo_ge040_args.of_get_arg("dh_resumo")
ll_qt_vendida		= luo_ge040_args.of_get_arg("qt_vendida")

If IsNull(ls_cd_produto_sap) or Trim(ls_cd_produto_sap) = "" Then Return False
If IsNull(ls_filial_sap) or Trim(ls_filial_sap) = "" Then Return False
If IsNull(ldt_dh_resumo) or ldt_dh_resumo = DateTime("1900-01-01 00:00:00.0000") Then Return False
if IsNull(ll_qt_vendida) or ll_qt_vendida <= 0 Then Return False

ls_dh_resumo	= String(ldt_dh_resumo, "dd/mm/yyyy hh:mm:ss")
ls_qt_vendida	= String(ll_qt_vendida)

ls_texto	= ls_cd_produto_sap + "," + &
			  ls_filial_sap + "," + &
			  ls_dh_resumo + "," + &
			  ls_qt_vendida
			  
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

public function boolean of_buscar_arquivo (ref string as_cd_produtos_sap[], ref string as_cd_filial_sap[], ref date ad_dh_limite);Int		li_arquivo
String	ls_Path, ls_Arquivo, ls_row, ls_cd_produto_sap, ls_dh_limite, ls_cd_filial_sap

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar separados por virgula e da seguinte forma:~r~r" + &
				   "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto SAP~r~r" + &
					"Coluna B = C$$HEX1$$f300$$ENDHEX$$digo da Filial SAP (Informar apenas uma vez cada filial, elas se repetir$$HEX1$$e300$$ENDHEX$$o para todos os produtos)~r~r" + & 
					"Coluna C = Data Limite (Informar no formato dd/mm/aaaa e apenas na primeira linha.")

GetFileOpenName("Selecione o arquivo", &
					ls_Path, &
					ls_Arquivo  , &
					"Text Files (*.txt);*.txt," &
					+ "All Files (*.*); *.*")

li_arquivo = FileOpen(ls_Path, LineMode!)
		  
do while FileRead(li_arquivo, ls_row) > 0
	if pos(ls_row, ',') > 0 then
		ls_cd_produto_sap	= mid(ls_row, 1, pos(ls_row, ',') -1)
		ls_row	= mid(ls_row, pos(ls_row, ',') + 1)
	elseif Trim(ls_row) <> '' then
		ls_cd_produto_sap	= ls_row
		ls_row	= ''
	end if
	
	if Not IsNull(ls_cd_produto_sap) and Trim(ls_cd_produto_sap) <> '' then
		as_cd_produtos_sap[UpperBound(as_cd_produtos_sap) + 1] = ls_cd_produto_sap
		ls_cd_produto_sap	= ''
	end if
	
	if pos(ls_row, ',') > 0 then
		ls_cd_filial_sap	= mid(ls_row, 1, pos(ls_row, ',') -1)
		ls_row	= mid(ls_row, pos(ls_row, ',') + 1)
	elseif Trim(ls_row) <> '' then
		ls_cd_filial_sap	= ls_row
		ls_row	= ''
	end if
	
	if Not IsNull(ls_cd_filial_sap) and Trim(ls_cd_filial_sap) <> '' then
		as_cd_filial_sap[UpperBound(as_cd_filial_sap) + 1] = ls_cd_filial_sap
		ls_cd_filial_sap	= ''
	end if

	if IsNull(ls_dh_limite) or Trim(ls_dh_limite) = '' then
		ls_dh_limite = ls_row
		
		ls_dh_limite = gf_replace(ls_dh_limite, ',', '', 1)
		
		ad_dh_limite	= Date(ls_dh_limite)
	end if
loop

FileClose(li_arquivo)

return true
end function

public function boolean of_controle_ds (ref dc_uo_ds_base ads, string as_cd_produtos_sap[], string as_cd_filiais_sap[], date ad_dh_limite);Long		ll_cd_filiais[], ll_for
String	ls_ds_dataobject, ls_todas_filiais, ls_cd_filial_legado

ads = Create dc_uo_ds_base


Choose Case is_tipo_relatorio
	Case "AGR"
		ls_ds_dataobject	= "ds_ge577_relatorio_hist_consumo_agr"
	Case "SEP"
		ls_ds_dataobject	= "ds_ge577_relatorio_hist_consumo_sep"
End Choose

If Not ads.of_ChangeDataObject(ls_ds_dataobject, False) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a DW '" + ls_ds_dataobject + "' - " + 'lista_relatorios_arquivos', StopSign!)
	Return False
End If

if UpperBound(as_cd_filiais_sap) > 0 then
	ls_todas_filiais = 'N'
else
	ls_todas_filiais = 'S'
end if

for ll_for = 1 to UpperBound(as_cd_filiais_sap)
	select cd_chave_legado
	  into :ls_cd_filial_legado
	  from integracao_sap
	 where cd_tabela = 'FILIAL'
	 	and cd_chave_sap	= :as_cd_filiais_sap[ll_for];
		 
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao buscar c$$HEX1$$f300$$ENDHEX$$digo da filial do legado. ' + SQLCA.SQLErrText, StopSign!)
			return false
		Case 100 
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado o c$$HEX1$$f300$$ENDHEX$$digo da filial do legado. ', StopSign!)
			return false
		Case 0
			ll_cd_filiais[UpperBound(ll_cd_filiais) + 1] = Long(ls_cd_filial_legado)
	End Choose
next

ads.Retrieve(ad_dh_limite, as_cd_produtos_sap, ll_cd_filiais, ls_todas_filiais)

Return True
end function

on uo_ge577_relatorio_hist_consumo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge577_relatorio_hist_consumo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

