HA$PBExportHeader$dc_uo_dw_base.sru
forward
global type dc_uo_dw_base from datawindow
end type
end forward

global type dc_uo_dw_base from datawindow
integer width = 494
integer height = 360
integer taborder = 10
boolean border = false
boolean livescroll = true
event ue_populate_dddw ( string ps_coluna,  datawindowchild pdwc_dddw )
event type integer ue_preinsertrow ( )
event type integer ue_addrow ( )
event type long ue_recuperar ( )
event type long ue_retrieve ( )
event type integer ue_preretrieve ( )
event type long ue_postretrieve ( long pl_linhas )
event type integer ue_update ( )
event type integer ue_preupdate ( )
event ue_cancel ( )
event ue_clearfilter ( )
event ue_filter ( )
event type boolean ue_predeleterow ( )
event type boolean ue_deleterow ( )
event ue_print ( )
event ue_printimmediate ( )
event ue_sort ( )
event ue_find ( )
event ue_key pbm_dwnkey
event ue_pos ( long pl_linha,  string ps_coluna )
event ue_reset ( )
event ue_selecttext ( )
event ue_saveas ( )
event type long ue_preprint ( )
event ue_imprimir_relatorio ( string ps_titulo,  string ps_rede_logo,  boolean pb_imediato )
end type
global dc_uo_dw_base dc_uo_dw_base

type variables
dc_uo_sort_dw ivo_sort
dc_uo_filter_dw ivo_filter
dc_uo_find_dw ivo_find
dc_uo_multitable_dw ivo_multitable

dc_uo_transacao itr_transacao

string ivs_coluna_sem_validacao_salva[]
string ivs_colunas[]
String ivs_Campos_Obrigatorios[]

String ivs_Cor_Linha_Padrao = "if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255))"
String ivs_Filtro_Relatorio[] = {""}

Boolean ivb_Selecao_Linhas = False

Boolean ivb_Ordena_Colunas = False

dc_uo_Menu_DW ivo_Controle_Menu

m_janelas ivm_Menu

dc_uo_ds_base ivds_relatorio

Protected:
String ivs_SQL_Original, &
          ivs_Ultima_Coluna_Ativa, &
          ivs_Arquivo_SalvarComo

Boolean ivb_SQL_Alterado, &
              ivb_Selecao_Colunas = False

// Tipo de cancelamento
Integer ivi_tipo_cancelar
Constant Integer RETRIEVE = 0
Constant Integer ADDROW = 1
Constant Integer RESET = 2


Constant String LOGO_DC = 'S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png'
Constant String LOGO_CP = 'S:\Sistemas_PB12\Comuns\Figuras\Logo_dc_plus_rel.png'
Constant String LOGO_PP = 'S:\Sistemas_PB12\Comuns\Figuras\logo_pp_rel.png'
Constant String LOGO_FA = 'S:\Sistemas_PB12\Comuns\Figuras\logo_fa_rel.png'
Constant String LOGO_PF = 'S:\Sistemas_PB12\Comuns\Figuras\logo_proformula_rel.png'
Constant String LOGO_MP = 'S:\Sistemas_PB12\Comuns\Figuras\logo_manipulacao_rel.png'
Constant String LOGO_CL = 'S:\Sistemas_PB12\Comuns\Figuras\logo_clamed_rel.bmp'

dc_w_base ivw_parentwindow

boolean ivb_UpdateAble = False
boolean ivb_grava_log = False

constant string ivs_cor_coluna_ativa = '33548231', &
                        ivs_cor_coluna_normal = '16777215'
end variables

forward prototypes
public subroutine of_populate_dddw (string ps_coluna)
public subroutine of_posiciona_coluna ()
public subroutine of_appendfrom (string ps_from)
public subroutine of_appendwhere (string ps_where)
public subroutine of_restoreoriginalsql ()
public subroutine of_changesql (string ps_sql)
public function datawindowchild of_insertrow_dddw (string ps_coluna)
public subroutine of_setmenu (menu pm_menu)
public subroutine of_getparentwindow ()
public subroutine of_setupdateable ()
public function boolean of_coluna_sem_validacao_salva (string ps_coluna)
public subroutine of_settransobject (transaction ptr_transacao)
public subroutine of_appendwhere (string ps_where, integer pi_union)
public subroutine of_appendfrom (string ps_from, integer pi_union)
public function boolean of_isupdated ()
public function boolean of_isupdateable ()
public function boolean of_changedataobject (string ps_dataobject)
public subroutine of_setfilter (string ps_coluna[], string ps_nome[])
public subroutine of_setmultitable ()
public subroutine of_lista_objetos (ref string as_objeto[])
public subroutine of_setrowselection ()
public subroutine of_setrowselection (string as_backcolor, string as_color)
public subroutine of_setcolselection (boolean ab_selecao)
public subroutine of_setsaveas (string as_arquivo)
public function boolean of_setprint (string as_dataobject)
public function boolean of_insertrow_dddw (integer ai_linha, string as_coluna, ref datawindowchild adwc)
public subroutine of_print (boolean ab_imediato)
public subroutine of_marca_coluna_ativa (string as_coluna)
public subroutine of_desmarca_coluna_ativa ()
public subroutine of_setsort (string as_coluna[], string as_nome[])
public subroutine of_setsort (string as_coluna[], string as_nome[], string as_bloqueio[])
public function boolean of_salva_pendente ()
public subroutine of_marca_coluna_ativa_ordenacao (string as_coluna)
public subroutine of_appendwhere_subquery (string ps_where, integer pi_where)
public subroutine of_setrowselection (string as_backcolor, string as_color, boolean pb_usa_default)
public function string of_getsql ()
public subroutine of_appendselect (string ps_campo)
public function boolean of_exporta_excel (string ps_arquivo)
public subroutine of_set_somente_leitura (boolean pb_permite_alterar)
public subroutine of_destaca_campos_obrigatorios ()
public subroutine of_appendfrom_ansi (string ps_from, integer pi_union)
public subroutine of_setsort ()
public subroutine of_setfilter ()
public subroutine of_grava_log (boolean pb_habilita)
public function string of_titulo_coluna (string ps_coluna)
public subroutine of_habilita_aux_visual ()
public function integer of_exporta_pdf (string ps_arquivo)
end prototypes

event ue_preinsertrow;Return 1
end event

event ue_addrow;Long lvl_Linha

Integer lvi_Retorno

SetPointer(HourGlass!)

If This.Event ue_PreInsertRow() = 1 Then
	lvl_Linha = This.InsertRow(0)
	
	// Posiciona na linha inclu$$HEX1$$ed00$$ENDHEX$$da
	This.ScrollToRow(lvl_Linha)
	This.SetRow(lvl_Linha)

	// Posiciona na primeira coluna com TabOrder < 0
	of_Posiciona_Coluna()

	lvi_Retorno = lvl_Linha
Else
	lvi_Retorno = -1
End If

SetPointer(Arrow!)

Return lvi_Retorno
end event

event ue_recuperar;Return This.Retrieve()
end event

event type long ue_retrieve();Long lvl_Linhas

lvl_Linhas = This.Event ue_PreRetrieve()

If lvl_Linhas = 1 Then 
	//Desabilita o timer de inatividade, para que em querys que excedam o tempo
	// o sistema ap$$HEX1$$f300$$ENDHEX$$s o retorno dos dados n$$HEX1$$e300$$ENDHEX$$o desconecte do banco de dados
	If IsValid(gvo_Aplicacao) Then
		If gvo_Aplicacao.ivb_Usa_Timer_Out Then
			Idle(0)
		End If
	End If
	
	lvl_Linhas = This.Event ue_Recuperar()
	
	//Reinicia o controle de inatividade. 
	If IsValid(gvo_Aplicacao) Then
		If gvo_Aplicacao.ivb_Usa_Timer_Out Then
			Idle(gvo_Aplicacao.ivi_Timer_Idle)
		End If
	End If
End If

If lvl_Linhas >= 0 Then
	lvl_Linhas = This.Event ue_PostRetrieve(lvl_Linhas)
End If

Try
	If gvo_Aplicacao.ivb_Forca_End_Transaction Then
		This.itr_Transacao.of_End_Transaction( )
	End If
Catch( RuntimeError ex )
End Try

Return lvl_Linhas
end event

event ue_preretrieve;If This.ivb_SQL_Alterado Then This.of_RestoreOriginalSQL()
Return 1
end event

event type integer ue_update();Integer li_Retorno

If This.Event ue_PreUpdate() = -1 Then Return -1

If IsValid(ivo_Multitable) Then
	Return ivo_Multitable.of_Update()
Else
	//Grava Log? -- Par$$HEX1$$e200$$ENDHEX$$metro ivb_grava_log deve ser habilitado na tela
	If ivb_grava_log Then
		gf_grava_log_alteracao(This)
	End If
	
	li_Retorno = This.Update()
	
	If li_Retorno < 0 Then
		SqlCa.of_RollBack( )// Gambiarra - 10/02/2014
		SqlCa.of_MsgDbError(ivw_ParentWindow.ivo_dbError.ivs_sqlerrtext)
	End If
	
	Return li_Retorno
End If
end event

event ue_preupdate;Return 1
end event

event ue_cancel;SetPointer(HourGlass!)

// Desabilita os menus de confirma e cancela
If Not IsNull(ivm_Menu) Then
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	ivm_Menu.m_Editar.m_Desfazer.Enabled = False
End If

// De acordo com o tipo da DW faz o retrieve ou limpa a DW e insere nova linha
CHOOSE CASE ivi_Tipo_Cancelar
	CASE RETRIEVE
		This.Event ue_Retrieve()
	CASE ADDROW
		This.Reset()
		This.Event ue_AddRow()
	CASE RESET
		This.Reset()
END CHOOSE

SetPointer(Arrow!)
end event

event ue_clearfilter;SetPointer(HourGlass!)

If IsValid(This.ivo_Filter) Then
	This.ivo_Filter.of_ClearFilter()

	ivm_Menu.m_Editar.m_LimparFiltro.Enabled = False
End If

SetPointer(Arrow!)
end event

event ue_filter;SetPointer(HourGlass!)

If IsValid(ivo_Filter) Then ivo_Filter.of_Filter()

If Not IsNull(ivm_Menu) Then
	If This.FilteredCount() > 0 Then
		ivm_Menu.m_Editar.m_LimparFiltro.Enabled = True
	Else
		ivm_Menu.m_Editar.m_LimparFiltro.Enabled = False
	End If
End If

SetPointer(HourGlass!)
end event

event ue_predeleterow;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma exclus$$HEX1$$e300$$ENDHEX$$o do registro ?", Question!, YesNo!, 2) = 2 Then
	Return False
Else
	Return True
End If
end event

event ue_deleterow;Boolean lvb_Retorno = False

SetPointer(HourGlass!)

If This.Event ue_PreDeleteRow() Then
	If This.DeleteRow(0) = 1 Then
		If Not IsNull(ivm_Menu) Then			
			ivm_Menu.mf_Confirmar(True)
			ivm_Menu.mf_Cancelar(True)
			
			If This.RowCount() = 0 Then	
				ivm_Menu.mf_Imprimir(False)
				ivm_Menu.mf_Excluir(False)
			ElseIf This.RowCount() = 1 Then
				ivm_Menu.mf_Classificar(False)
				ivm_Menu.mf_Filtrar(False)
				ivm_Menu.mf_Localizar(False)
			End If	
		End If
		
		// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
		If ivb_UpdateAble Then
			ivw_ParentWindow.ivb_Valida_Salva = True
		End If

		lvb_Retorno = True
	End If
End If

SetPointer(Arrow!)
Return lvb_Retorno
end event

event ue_print;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		This.of_Print(False)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

event ue_printimmediate;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		This.of_Print(True)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

event ue_sort;If IsValid(ivo_Sort) Then 
	ivo_Sort.of_Sort()
	
	If ivo_Sort.ivs_Retorno = 'OK' Then
		This.of_Marca_Coluna_Ativa_Ordenacao('')
	End If	
	
End If	


end event

event ue_pos;This.SetRedraw(False)

This.ScrollToRow(pl_Linha)
This.SetRow(pl_Linha)
This.SetColumn(ps_Coluna)

This.SetRedraw(True)

This.SetFocus()

This.Post Event ue_SelectText()
end event

event ue_reset;This.Reset()
end event

event ue_selecttext;This.SelectText(1, LenA(This.GetText()) + 20)
end event

event ue_saveas();String	lvs_Arquivo, &
		lvs_Diretorio, &
		lvs_Extensao

Integer lvi_Retorno

// Verifica o nome do arquivo
If Trim(This.ivs_Arquivo_SalvarComo) = "" or IsNull(This.ivs_Arquivo_SalvarComo) Then
	lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
											lvs_Diretorio, 	&
											lvs_Arquivo, 	&
											"XLS", 			&
											"Arquivos Excel (*.XLS),*.XLS,Arquivos Excel Formatado (*.XLS),*.XLSF" 	+ &
											",Arquivos Excel (*.XLSX),*.XLSX,Arquivos CSV (*.CSV),*.CSV"	+ &
											",Arquivos PDF (*.PDF),*.PDF,Arquivos HTML (*.HTML),*.HTML" 		+ &
											",Arquivos Texto (*.TXT),*.TXT")
	
	If lvi_Retorno = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
		Return 
	Else
		If lvi_Retorno = 0 Then Return
	End If
Else
	lvs_Diretorio	= This.ivs_Arquivo_SalvarComo
	lvs_Arquivo 	= This.ivs_Arquivo_SalvarComo
End If

lvs_Diretorio = Upper( lvs_Diretorio )
lvs_Diretorio = gf_replace(lvs_Diretorio,'.XLSF','.XLS',0)

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_Diretorio) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
		If Not FileDelete(lvs_Diretorio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
			Return
		End If
	Else
		Return 
   End If   
End If

// Salva o arquivo
lvs_Extensao = gf_replace(Mid(lvs_Arquivo,Len(lvs_Arquivo)-3,4),'.','',0)

lvs_Extensao = Upper( lvs_Extensao )

If (lvs_Extensao = 'XLS') or (lvs_Extensao = 'XLSF') then
	If This.RowCount() > 65000 Then
		If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',	'Este relat$$HEX1$$f300$$ENDHEX$$rio excede o limite de 65.000 linhas do formato Excel (XLS).~r~n'+ &
											'O arquivo n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salvo neste formato.~r~n~r~n'+ &
											'Deseja selecionar outro formato?',Question!, YesNo!,1)=1 Then 
			This.Event ue_SaveAs()
			Return
		Else
			Return
		End If
	End If
End If

Open(w_aguarde_1)
If IsValid(w_aguarde_1) Then w_aguarde_1.Title = 'Aguarde... Salvando...'
Choose Case lvs_Extensao
	Case 'XLS'
		lvi_Retorno = This.SaveAs(lvs_Diretorio, Excel8!, True)
	Case 'XLSX'
		lvi_Retorno = This.SaveAs(lvs_Diretorio, XLSX!, True)
	Case 'CSV'
		//lvi_Retorno = This.SaveAs(lvs_Diretorio, CSV!, True,EncodingUTF8!)
		lvi_Retorno = This.SaveAsFormattedText(lvs_Diretorio, EncodingANSI!, ";")
	Case 'PDF'
		//lvi_Retorno = This.SaveAs(lvs_Diretorio, PDF!, True)
		lvi_Retorno = This.of_Exporta_PDF(lvs_Diretorio)
	Case 'HTML'
		lvi_Retorno = This.SaveAs(lvs_Diretorio, HTMLTable!, True)
	Case 'TXT'
		lvi_Retorno = This.SaveAs(lvs_Diretorio, Text!, True,EncodingUTF8!)
	Case 'XLSF'
		If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetMax(2)
		If This.SaveAs( lvs_Diretorio, HTMLTable!, True ) = 1 Then
			If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetProgress(1)
			// Converte arquivo HTML para Excel
			OLEObject Excel 
			Excel = Create OLEObject 
			
			If Excel.ConnectToNewObject('Excel.Application') = 0 Then
				Excel.Application.DisplayAlerts = False
				Excel.Application.Workbooks.Open(lvs_Diretorio)
				Excel.Application.Workbooks( 1 ).Parent.Windows( Excel.Application.Workbooks( 1 ).Name ).Visible = True
				Excel.Application.Workbooks( 1 ).SaveAs(lvs_Diretorio, 56 ) 
				Excel.Application.Workbooks( 1 ).Close()
				Excel.DisconnectObject()
			
				Destroy(Excel)
				lvi_Retorno = 1
			Else
				Destroy(Excel)
				lvi_Retorno = -1
			End If
			If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetProgress(2)
		Else
			lvi_Retorno = -1
		End If
End Choose
If IsValid(w_aguarde_1) Then Close(w_aguarde_1)

If lvi_Retorno <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + lvs_Diretorio + "'.", StopSign!)	
	Return 
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
End If
end event

event ue_preprint;Long lvl_Linhas

If IsValid(ivds_Relatorio) Then
	lvl_Linhas = ivds_Relatorio.RowCount()
Else
	lvl_Linhas = This.RowCount()
End If

Return lvl_Linhas
end event

event ue_imprimir_relatorio(string ps_titulo, string ps_rede_logo, boolean pb_imediato);/**********************************************************************************************************************
Nome		: ue_imprimir_relatorio
Objetivo	: Imprimir uma DW configurada como lista em forma de relat$$HEX1$$f300$$ENDHEX$$rio, inserindo logo e demais padr$$HEX1$$f500$$ENDHEX$$es visuais.
Descri$$HEX2$$e700e300$$ENDHEX$$o: Na fun$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ criada um dc_uo_ds_base baseado na Syntax da datawindow atual, s$$HEX1$$e300$$ENDHEX$$o compartilhados os dados
				atrav$$HEX1$$e900$$ENDHEX$$s do ShareData e efetuados os ajustes visuais necess$$HEX1$$e100$$ENDHEX$$rios para que a impress$$HEX1$$e300$$ENDHEX$$o esteja de acordo com
				o padr$$HEX1$$e300$$ENDHEX$$o visual dos relat$$HEX1$$f300$$ENDHEX$$rios da Clamed.
			
ATEN$$HEX2$$c700c300$$ENDHEX$$O: Para exibir filtros no relat$$HEX1$$f300$$ENDHEX$$rio impresso, $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio inser$$HEX1$$ed00$$ENDHEX$$-los no string array ivs_Filtro_Relatorio.
			   Habitualmente essa atribui$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ feita no ue_PreRetrieve() da DW, a cada filtro inserido na query
				inserir tamb$$HEX1$$e900$$ENDHEX$$m um texto para exibi$$HEX2$$e700e300$$ENDHEX$$o dele no relat$$HEX1$$f300$$ENDHEX$$rio.
-----------------------------------------------------------------------------------------------------------------------
Param.	: ps_titulo (string) - T$$HEX1$$ed00$$ENDHEX$$tulo do relat$$HEX1$$f300$$ENDHEX$$rio a ser impresso
			  ps_rede_logo (string) - Rede da filial, conforme o par$$HEX1$$e200$$ENDHEX$$metro ID_REDE_FILIAL, para matriz utilizar CL.
			  pb_imediato (boolean) - Imprimir imediatamente? 
-----------------------------------------------------------------------------------------------------------------------
Retorno	: Nenhum
-----------------------------------------------------------------------------------------------------------------------
Log		: 18.Ago.2016 Marlon Kniss - Cria$$HEX2$$e700e300$$ENDHEX$$o
**********************************************************************************************************************/

String lvs_Erro
Long lvl_Param
Long lvl_Y
Long lvl_Width = 0
Long lvl_WLogo = 0
Long lvl_Aux

String lvs_Band
String lvs_Type
String lvs_Objeto
String lvs_Logo
String lvs_BackColor
String lvs_Objetos[]

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dc_uo_ds_base lvds_relatorio
		lvds_relatorio = Create dc_uo_ds_base
		
		//Cria datawindow de relat$$HEX1$$f300$$ENDHEX$$rio baseado na datawindow de lista
		lvds_relatorio.Create(This.Describe("DataWindow.Syntax"), lvs_Erro)
		lvds_relatorio.SetTransObject(This.itr_Transacao)
		//Compartilha os dados conforme a DW
		This.ShareData(lvds_relatorio)
		//Adiciona Logo
		Choose Case ps_rede_logo
			Case 'CL'
				lvs_Logo = LOGO_CL
				lvl_WLogo = 676
			Case 'CP'
				lvs_Logo = LOGO_CP
				lvl_WLogo = 826
			Case 'DC'
				lvs_Logo = LOGO_DC
				lvl_WLogo = 826
			Case 'FA'
				lvs_Logo = LOGO_FA
				lvl_WLogo = 776
			Case 'MP'
				lvs_Logo = LOGO_MP
				lvl_WLogo = 826
			Case 'PF'
				lvs_Logo = LOGO_PF
				lvl_WLogo = 626
			Case 'PP'
				lvs_Logo = LOGO_PP
				lvl_WLogo = 826
			Case Else
				lvs_Logo = ''
		End Choose
		
		If trim(lvs_Logo)<>'' Then
			lvds_relatorio.Modify('CREATE bitmap(band=foreground filename="'+lvs_Logo+'" x="0" y="12" height="188" OriginalSize=Yes width="'+String(lvl_WLogo)+'" border="0" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0"  name=logotipo_relatorio visible="1" transparency="0"')
			//lvds_relatorio.Modify('logotipo_relatorio.OriginalSize=Yes')
		End If
		//Seta cor de fundo da DW
		lvds_relatorio.Modify('DataWindow.Color="33554431"')
		//Insere par$$HEX1$$e200$$ENDHEX$$metros preenchidos
		For lvl_Param = 1 To UpperBound(ivs_Filtro_Relatorio)
			If Trim(ivs_Filtro_Relatorio[lvl_Param]) <> '' Then
				lvds_relatorio.Modify('create text(band=header alignment="0" text="'+ivs_Filtro_Relatorio[lvl_Param]+'" border="0" color="0" x="10" y="'+String(90+(lvl_Param*64))+'" height="72" width="1000" html.valueishtml="0"  name=titulo_dw visible="1"  font.face="Verdana" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )')
			End if
		Next
		//Altera parametros de campos/objetos para padronizar relat$$HEX1$$f300$$ENDHEX$$rio
		This.Of_Lista_Objetos(lvs_Objetos)
		For lvl_Aux = 1 to UpperBound(lvs_Objetos)
			lvs_Objeto	= lvs_Objetos[lvl_Aux]
			lvs_Type 	= lvds_relatorio.Describe(lvs_Objetos[lvl_Aux]+".Type")
			lvs_Band		= lvds_relatorio.Describe(lvs_Objetos[lvl_Aux]+".Band")
			
			Choose Case lvs_Type
				Case 'text'
					If (lvs_Band = 'header') Then
						lvds_relatorio.Modify(lvs_Objeto+".Y='"+String(Long(lvds_relatorio.Describe(lvs_Objeto+'.Y'))+110+(lvl_Param*64))+"'")
					End If
					
					lvds_relatorio.Modify(lvs_Objeto+".Color=0")
					
				Case 'line'
					If (lvs_Band = 'header') Then
						lvds_relatorio.Modify(lvs_Objeto+".Y1='"+String(Long(lvds_relatorio.Describe(lvs_Objeto+'.Y1'))+110+(lvl_Param*64))+"'")
						lvds_relatorio.Modify(lvs_Objeto+".Y2='"+String(Long(lvds_relatorio.Describe(lvs_Objeto+'.Y2'))+110+(lvl_Param*64))+"'")
					End If
					lvds_relatorio.Modify(lvs_Objeto+".Pen.Color='0'")
					
				Case 'column'
					//Diminui linha
					lvds_relatorio.Modify(lvs_Objeto+".Height='64'")	
					//Diminui a fonte
					lvds_relatorio.Modify(lvs_Objeto+".Font.Height='-7'")	
					//Remove a borda
					lvds_relatorio.Modify(lvs_Objeto+".Border='0'")
					//Altera a cor
					lvds_relatorio.Modify(lvs_Objeto+".Color='0'")
					//Acumula largura total das colunas
					If  lvds_relatorio.Describe(lvs_Objeto+".Visible")='1' then
						lvl_Width += Long(lvds_relatorio.Describe(lvs_Objeto+".Width")) + 18
					End if
					//Remove cor de fundo da linha
					lvds_relatorio.Modify(lvs_Objeto+".Background.Color='0~trgb(255,255,255)'")
					
				Case 'compute'
					//Diminui a fonte
					lvds_relatorio.Modify(lvs_Objeto+".Font.Height='-7'")	
					//Remove a borda
					lvds_relatorio.Modify(lvs_Objeto+".Border='0'")
					//Altera a cor
					lvds_relatorio.Modify(lvs_Objeto+".Color='0'")
					//Remove cor de fundo da linha
					lvds_relatorio.Modify(lvs_Objeto+".Background.Color='0~trgb(255,255,255)'")

					//Acumula largura total das colunas
					If  (lvds_relatorio.Describe(lvs_Objeto+".Visible")='1') and (lvs_Band = 'detail') then
						lvl_Width += Long(lvds_relatorio.Describe(lvs_Objeto+".Width")) + 18
					End if
			End choose
		Next
		
		//Seta Tamanho Detail
		lvds_relatorio.Modify("DataWindow.Detail.Height='64'")
		//Seta Tamanho Cabe$$HEX1$$e700$$ENDHEX$$alho
		lvds_relatorio.Modify("DataWindow.Header.Height.AutoSize='Yes'")
		//Ajusta magens e cofigura$$HEX2$$e700e300$$ENDHEX$$o pra impress$$HEX1$$e300$$ENDHEX$$o
		If lvl_Width > 3500 then
			lvds_relatorio.Modify("DataWindow.Print.Orientation= '1'")
		End If
		lvds_relatorio.Modify("DataWindow.Print.Margin.Left = 110")
		lvds_relatorio.Modify("DataWindow.Print.Margin.Right = 110")
		lvds_relatorio.Modify("DataWindow.Print.Margin.Top = 96")
		lvds_relatorio.Modify("DataWindow.Print.Margin.Bottom = 96")
		lvds_relatorio.Modify("DataWindow.Print.Paper.Source = 0")
		lvds_relatorio.Modify("DataWindow.Print.Paper.Size = 0")
		lvds_relatorio.Modify("DataWindow.Print.Canusedefaultprinter=yes")
		
		//Insere T$$HEX1$$ed00$$ENDHEX$$tulo
		If Trim(ps_titulo)='' Then ps_titulo = This.Title
		lvds_relatorio.Modify('create text(band=header alignment="2" text="'+ps_titulo+'" border="0" color="0" x="650" y="96" height="72" width="'+String(2200+(1300*Long(lvds_relatorio.Describe("DataWindow.Print.Orientation"))))+'" html.valueishtml="0"  name=titulo_dw visible="1"  font.face="Verdana" font.height="-11" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )')
		//Insere N$$HEX1$$ba00$$ENDHEX$$ Pagina
		lvds_relatorio.Modify('create compute(band=header alignment="1" expression="'+"'P$$HEX1$$e100$$ENDHEX$$g. '"+" + page() + ' de ' + pageCount()"+'" border="0" color="0" x="'+String(2750+(1300*Long(lvds_relatorio.Describe("DataWindow.Print.Orientation"))))+'" y="114" height="64" width="526" format="[general]" html.valueishtml="0" name=pagina_dw visible="1" font.face="Verdana" font.height="-8" font.weight="400" font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )')
		//Insere data impress$$HEX1$$e300$$ENDHEX$$o
		lvds_relatorio.Modify('create compute(band=header alignment="1" expression="today()" border="0" color="0" x="'+String(2750+(1300*Long(lvds_relatorio.Describe("DataWindow.Print.Orientation"))))+'" y="60" height="64" width="526" format="dd/mm/yyyy hh:mm" html.valueishtml="0" name=data_dw visible="1" font.face="Verdana" font.height="-8" font.weight="400" font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )')
		//Ajusta tamanho cabe$$HEX1$$e700$$ENDHEX$$alho
		lvds_relatorio.Modify("DataWindow.Header.Height="+String(160+( lvl_Param * 64)))
		
		lvds_relatorio.Of_Print(pb_imediato)
		
		Destroy(lvds_relatorio)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

public subroutine of_populate_dddw (string ps_coluna);Long lvl_rc

DataWindowChild lvdwc_Obj

lvl_rc = This.GetChild(ps_Coluna, lvdwc_Obj)

If lvl_rc > 0 Then
	This.Event ue_Populate_DDDW(ps_Coluna, lvdwc_Obj)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild.", Information!)	
End If

end subroutine

public subroutine of_posiciona_coluna ();String lvs_retorno_describe, lvs_expressao
Integer lvi_num_colunas, lvi_contador, lvi_ultimo_tab, lvi_coluna_final

// Posiciona na primeira coluna que permite edi$$HEX2$$e700e300$$ENDHEX$$o

lvi_ultimo_tab = 9999
lvi_num_colunas = Integer(This.Describe("DataWindow.Column.Count"))

FOR lvi_contador = 1 TO lvi_num_colunas
	
	lvs_expressao = "#" + String(lvi_contador) + ".Name"
	lvs_retorno_describe = This.Describe(lvs_expressao)
	
	lvs_expressao = lvs_retorno_describe + ".TabSequence"
	lvs_retorno_describe = This.Describe(lvs_expressao)
	
	If IsNumber(lvs_retorno_describe) Then
		If Integer(lvs_retorno_describe) > 0 and &
		   Integer(lvs_retorno_describe) < lvi_ultimo_tab Then
			lvi_ultimo_tab = Integer(lvs_retorno_describe)
			lvi_coluna_final = lvi_contador
		End If
	End If
	
NEXT

This.SetColumn(lvi_coluna_final)

// Coloca o foco na DW

This.SetFocus()
end subroutine

public subroutine of_appendfrom (string ps_from);String lvs_SQL

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "FROM", 1)

lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao + 4) + " " + ps_From + ", " + &
          MidA(lvs_SQL, lvl_Posicao + 4)

This.of_ChangeSQL(lvs_SQL)
end subroutine

public subroutine of_appendwhere (string ps_where);String lvs_SQL
String lvs_Aux

Long lvl_Posicao

If IsNull( ps_Where ) Then
	Return // Gambiarra - 19/12/2014
End If

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE")

If lvl_Posicao = 0 Then
	lvl_Posicao = PosA(Upper(lvs_SQL), "GROUP BY ")
	If lvl_Posicao > 0 Then
		lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao - 1) + " WHERE " + ps_Where +' '+ MidA(lvs_SQL, lvl_Posicao)	
	Else
		lvl_Posicao = PosA(Upper(lvs_SQL), "HAVING ")
		If lvl_Posicao > 0 Then
			lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao - 1) + " WHERE " + ps_Where +' '+ MidA(lvs_SQL, lvl_Posicao)	
		Else
			lvl_Posicao = PosA(Upper(lvs_SQL), "ORDER BY ")
			If lvl_Posicao > 0 Then
				lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao - 1) + " WHERE " + ps_Where +' '+ MidA(lvs_SQL, lvl_Posicao)	
			Else
				lvs_SQL += " WHERE " + ps_Where
			End If
		End If
	End If
Else
	lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao + 5) + " " + ps_Where + " and " + &
	          MidA(lvs_SQL, lvl_Posicao + 6)
End If

This.of_ChangeSQL(lvs_SQL)
end subroutine

public subroutine of_restoreoriginalsql ();ivs_Filtro_Relatorio = {''}
This.Object.DataWindow.Table.Select = ivs_SQL_Original
ivb_SQL_Alterado = False
end subroutine

public subroutine of_changesql (string ps_sql);This.Object.DataWindow.Table.Select = ps_SQL
This.ivb_SQL_Alterado = True
end subroutine

public function datawindowchild of_insertrow_dddw (string ps_coluna);DataWindowChild ldwc_child

Integer lvi_rc

lvi_rc = This.GetChild(ps_Coluna, ldwc_Child)

If lvi_rc <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da datawindow child da coluna " + ps_Coluna + ".", Information!, Ok!)
End If

ldwc_Child.InsertRow(1)

Return ldwc_Child
end function

public subroutine of_setmenu (menu pm_menu);// Estabelece o menu da dw e o menu do objeto de controle (habilita/desabilita)
This.ivo_Controle_Menu.of_SetMenu(pm_Menu)
This.ivm_Menu = pm_Menu
end subroutine

public subroutine of_getparentwindow ();PowerObject	lvpo_Parent

lvpo_Parent = This.GetParent()

Do While IsValid(lvpo_Parent) 
	
	If lvpo_Parent.TypeOf() <> window! Then
		lvpo_Parent = lvpo_Parent.GetParent()
	Else
		Exit
	End If
	
Loop

If IsNull(lvpo_Parent) or Not IsValid(lvpo_Parent) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na determina$$HEX2$$e700e300$$ENDHEX$$o da ParentWindow da datawindow.", StopSign!)
End If

This.ivw_ParentWindow = lvpo_Parent
end subroutine

public subroutine of_setupdateable ();This.ivb_UpdateAble = True
end subroutine

public function boolean of_coluna_sem_validacao_salva (string ps_coluna);Integer lvi_Contador

String lvs_Coluna

For lvi_Contador = 1 To UpperBound(ivs_Coluna_Sem_Validacao_Salva)
	lvs_Coluna = ivs_Coluna_Sem_Validacao_Salva[lvi_Contador]
	
	If Upper(Trim(lvs_Coluna)) = Upper(Trim(ps_Coluna)) Then
		Return True
	End If
Next

Return False
end function

public subroutine of_settransobject (transaction ptr_transacao);This.itr_Transacao = ptr_Transacao
This.SetTransObject(ptr_Transacao)
end subroutine

public subroutine of_appendwhere (string ps_where, integer pi_union);Integer lvi_Contador = 0

String lvs_SQL

Long lvl_Posicao

If IsNull( ps_Where ) Then
	Return // Gambiarra - 19/12/2014
End If

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "SELECT")

Do While lvl_Posicao > 0
	lvi_Contador ++
	If lvi_Contador = pi_Union Then Exit
		
	lvl_Posicao = PosA(Upper(lvs_SQL), "SELECT", lvl_Posicao + 6)
Loop

// Verifica se encontrou o WHERE na posi$$HEX2$$e700e300$$ENDHEX$$o desejada pelo UNION
If lvi_Contador <> pi_Union Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o AppendWhere.", StopSign!)
	Return
End If

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE", lvl_Posicao)

If lvl_Posicao = 0 Then
	lvs_SQL += " WHERE " + ps_Where
Else
	lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao + 5) + " " + ps_Where + " and " + &
	          MidA(lvs_SQL, lvl_Posicao + 6)
End If

This.of_ChangeSQL(lvs_SQL)
end subroutine

public subroutine of_appendfrom (string ps_from, integer pi_union);Integer lvi_Contador = 0

String lvs_SQL

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "SELECT")

Do While lvl_Posicao > 0
	lvi_Contador ++
	If lvi_Contador = pi_Union Then Exit
		
	lvl_Posicao = PosA(Upper(lvs_SQL), "SELECT", lvl_Posicao + 6)
Loop

// Verifica se encontrou o FROM na posi$$HEX2$$e700e300$$ENDHEX$$o desejada pelo UNION
If lvi_Contador <> pi_Union Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o AppendFrom.", StopSign!)
	Return
End If

lvl_Posicao = PosA(Upper(lvs_SQL), "FROM", lvl_Posicao)

lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao + 4) + " " + ps_From + ", " + &
          MidA(lvs_SQL, lvl_Posicao + 4)

This.of_ChangeSQL(lvs_SQL)
end subroutine

public function boolean of_isupdated ();If This.ModifiedCount() + This.DeletedCount() > 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_isupdateable ();Return This.ivb_UpdateAble
end function

public function boolean of_changedataobject (string ps_dataobject);Integer lvi_Retorno

This.DataObject = ps_DataObject

lvi_Retorno = This.SetTransObject(This.itr_Transacao)

If lvi_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na mudan$$HEX1$$e700$$ENDHEX$$a na DW '" + ps_DataObject + "'.", StopSign!)
	Return False
Else
	This.ivs_SQL_Original = This.Object.DataWindow.Table.Select
	This.ivb_SQL_Alterado = False	
	
	//Habilita aux$$HEX1$$ed00$$ENDHEX$$lio visual?
	If gvo_aplicacao.ivb_Usa_Aux_Visual Then This.of_habilita_aux_visual()
	
	Return True
End If
end function

public subroutine of_setfilter (string ps_coluna[], string ps_nome[]);ivo_Filter = Create dc_uo_Filter_DW

ivo_Filter.of_SetDW(This)
ivo_Filter.of_SetFilterColumns(ps_Coluna, ps_Nome)
end subroutine

public subroutine of_setmultitable ();ivo_Multitable = Create dc_uo_Multitable_DW

ivo_Multitable.of_SetDW(This)
end subroutine

public subroutine of_lista_objetos (ref string as_objeto[]);Integer lvi_Pos, &
		  lvi_Inicio, &
        lvi_Contador

String lvs_Objetos, &
       lvs_Objeto

lvs_Objetos = This.Describe("DataWindow.Objects")

If lvs_Objetos <> "" Then
	lvi_Inicio = 1
	
	lvi_Pos = PosA(lvs_Objetos, CharA(9), lvi_Inicio)
	
	Do While lvi_Pos > 0
		lvs_Objeto = MidA(lvs_Objetos, lvi_Inicio, lvi_Pos - lvi_Inicio)
		
		lvi_Inicio = lvi_Pos + 1
		
		lvi_Contador ++

		as_Objeto[lvi_Contador] = lvs_Objeto
		
		lvi_Pos = PosA(lvs_Objetos, CharA(9), lvi_Inicio)
	Loop
	
	lvs_Objeto = MidA(lvs_Objetos, lvi_Inicio)
	
	lvi_Contador ++

	as_Objeto[lvi_Contador] = lvs_Objeto
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos objetos da DW.", StopSign!)
End If
end subroutine

public subroutine of_setrowselection ();This.of_SetRowSelection("", "")
end subroutine

public subroutine of_setrowselection (string as_backcolor, string as_color);Integer	lvi_Total, &
			lvi_Contador
		  
String lvs_Objetos[], &
		 lvs_Objeto, &
       lvs_Describe, &
		 lvs_Modify, &
		 lvs_Band, &
		 lvs_Tipo, &
		 lvs_Color, &
		 lvs_BackColor, &
		 lvs_Edicao

This.of_Lista_Objetos(ref lvs_Objetos[])

lvi_Total = UpperBound(lvs_Objetos)

For lvi_Contador = 1 To lvi_Total
	
	lvs_Objeto = lvs_Objetos[lvi_Contador]
	lvs_Describe = lvs_Objeto + ".Band"
	lvs_Band = This.Describe(lvs_Describe)
	
	If Upper(lvs_Band) = "DETAIL" Then
		lvs_Describe = lvs_Objeto + ".Type"
		lvs_Tipo = This.Describe(lvs_Describe)
		
		Choose Case Upper(lvs_Tipo)
			Case "COLUMN", "COMPUTE"
				lvs_Describe = lvs_Objeto + ".edit.style"
				lvs_Edicao = This.Describe(lvs_Describe)
				
				If lvs_Edicao <> "checkbox" and lvs_Edicao <> "radiobuttons" Then 
					lvs_Describe = lvs_Objeto + ".Background.Color"
					lvs_BackColor = This.Describe(lvs_Describe)
					
					// Se j$$HEX1$$e100$$ENDHEX$$ houver uma f$$HEX1$$f300$$ENDHEX$$rmula estabelecida "Not IsNumber()" 
					// Altera somente se receber outra f$$HEX1$$f300$$ENDHEX$$rmula como par$$HEX1$$e200$$ENDHEX$$metro
					// Sen$$HEX1$$e300$$ENDHEX$$o utiliza a cor definida originalmente
					
					If as_BackColor <> "" or IsNumber(lvs_BackColor) Then
						If as_BackColor <> "" Then lvs_BackColor = as_BackColor
						
						lvs_Modify = lvs_Objeto + ".Background.Color='0~tIf(getrow() = currentrow(), rgb(0,128,128), " + lvs_BackColor + ")'"
	
						If This.Modify(lvs_Modify) <> "" Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na defini$$HEX2$$e700e300$$ENDHEX$$o do modo de sele$$HEX2$$e700e300$$ENDHEX$$o das linhas (backcolor).", Information!)
							Return
						End If
					End If
					
					lvs_Describe = lvs_Objeto + ".Color"
					lvs_Color = This.Describe(lvs_Describe)
					
					If as_Color <> "" or IsNumber(lvs_Color) Then
						If as_Color <> "" Then lvs_Color = as_Color
						
						lvs_Modify = lvs_Objeto + ".Color='0~tIf(getrow() = currentrow(), rgb(255,255,255), " + lvs_Color + ")'"
						
						If This.Modify(lvs_Modify) <> "" Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na defini$$HEX2$$e700e300$$ENDHEX$$o do modo de sele$$HEX2$$e700e300$$ENDHEX$$o das linhas (color).", Information!)
							Return
						End If
					End If
				End If
		End Choose
	End If	
Next

This.ivb_Selecao_Linhas = False
end subroutine

public subroutine of_setcolselection (boolean ab_selecao);This.ivb_Selecao_Colunas = ab_Selecao
end subroutine

public subroutine of_setsaveas (string as_arquivo);This.ivs_Arquivo_SalvarComo = as_Arquivo
end subroutine

public function boolean of_setprint (string as_dataobject);ivds_Relatorio = Create dc_uo_ds_Base

If Not ivds_Relatorio.of_ChangeDataObject(as_DataObject) Then Return False

This.ShareData(ivds_Relatorio)

Return True
end function

public function boolean of_insertrow_dddw (integer ai_linha, string as_coluna, ref datawindowchild adwc);Integer lvi_rc

lvi_rc = This.GetChild(as_Coluna, adwc)

If lvi_rc <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da datawindow child da coluna " + as_Coluna + ".", StopSign!)
	Return False
End If

If adwc.InsertRow(ai_Linha) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da linha na datawindow child da coluna " + as_Coluna + ".", StopSign!)
	Return False
End If

Return True
end function

public subroutine of_print (boolean ab_imediato);String lvs_Intervalo

dc_uo_Parametro_Impressao lvo_Parametro

lvo_Parametro = Create dc_uo_Parametro_Impressao

If Not ab_Imediato Then
	OpenWithParm(dc_w_Configuracao_Impressao, lvo_Parametro)

	If lvo_Parametro.ivb_Cancelar_Impressao Then 
		Destroy(lvo_Parametro)
		Return
	End If
Else
	lvo_Parametro.ivb_Todas_Paginas = True

	lvo_Parametro.ivi_Qtde_Copias = 1
	
	lvo_Parametro.ivb_Agrupar_Copias = False
End If

If lvo_Parametro.ivb_Todas_Paginas Then
	lvs_Intervalo = ""
Else
	lvs_Intervalo = String(lvo_Parametro.ivi_Pagina_Inicial) + "-" + String(lvo_Parametro.ivi_Pagina_Final)
End If

If IsValid(ivds_Relatorio) Then
	ivds_Relatorio.Object.DataWindow.Print.Page.Range = lvs_Intervalo
	
	ivds_Relatorio.Object.DataWindow.Print.Copies = lvo_Parametro.ivi_Qtde_Copias
	
	ivds_Relatorio.Object.DataWindow.Print.Collate = lvo_Parametro.ivb_Agrupar_Copias
	
	ivds_Relatorio.Print(True)
Else
	This.Object.DataWindow.Print.Page.Range = lvs_Intervalo
	
	This.Object.DataWindow.Print.Copies = lvo_Parametro.ivi_Qtde_Copias
	
	This.Object.DataWindow.Print.Collate = lvo_Parametro.ivb_Agrupar_Copias
	
	This.Print(True)	
End If

Destroy(lvo_Parametro)
end subroutine

public subroutine of_marca_coluna_ativa (string as_coluna);String lvs_Describe, &
       lvs_Modify

If Not ivb_Selecao_Colunas Then Return

If as_Coluna = "" Then Return

lvs_Describe = This.Describe(as_Coluna + ".edit.style")

If lvs_Describe = "edit" or lvs_Describe = "editmask" Then 
	If IsNumber(This.Describe(as_Coluna + ".background.color")) Then
		lvs_Modify = as_Coluna + ".background.color = " + ivs_Cor_Coluna_Ativa
		
		If This.Modify(lvs_Modify) = "" Then
			This.ivs_Ultima_Coluna_Ativa = as_Coluna
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na altera$$HEX2$$e700e300$$ENDHEX$$o da cor das coluna ativa.~r~r" + &
			                      "Modify '" + lvs_Modify + "'", Information!)
		End If
	End If
End If
end subroutine

public subroutine of_desmarca_coluna_ativa ();String lvs_Modify

If Not ivb_Selecao_Colunas Then Return

If This.ivs_Ultima_Coluna_Ativa <> "" Then
	lvs_Modify = This.ivs_Ultima_Coluna_Ativa + ".background.color = " + This.ivs_Cor_Coluna_Normal
	
	If This.Modify(lvs_Modify) = "" Then
		This.ivs_Ultima_Coluna_Ativa = ""
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na altera$$HEX2$$e700e300$$ENDHEX$$o da cor da $$HEX1$$fa00$$ENDHEX$$ltima coluna ativa.~r~r" + &
		                      "Modify '" + lvs_Modify + "'", Information!)
	End If
End If
end subroutine

public subroutine of_setsort (string as_coluna[], string as_nome[]);String lvs_Bloqueio[]

Integer lvi_Coluna

// Considera todas as colunas do sort n$$HEX1$$e300$$ENDHEX$$o bloqueadas para altera$$HEX2$$e700e300$$ENDHEX$$o

For lvi_Coluna = 1 To UpperBound(as_Coluna)
	lvs_Bloqueio[lvi_Coluna] = "N"
Next

This.of_SetSort(as_Coluna, as_Nome, lvs_Bloqueio)
end subroutine

public subroutine of_setsort (string as_coluna[], string as_nome[], string as_bloqueio[]);If UpperBound(as_Coluna) <> UpperBound(as_Nome) or UpperBound(as_Coluna) <> UpperBound(as_Bloqueio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Defini$$HEX2$$e700e300$$ENDHEX$$o das colunas para classifica$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return
End If

ivo_Sort = Create dc_uo_Sort_DW

ivo_Sort.of_SetDW(This)
ivo_Sort.of_SetSortColumns(as_Coluna, as_Nome, as_Bloqueio)
end subroutine

public function boolean of_salva_pendente ();Long lvl_Linha

Integer lvi_Numero_Colunas, &
        lvi_Coluna
		  
String lvs_Coluna, &
       lvs_UpdateTable

dwItemStatus ldwis_Status

lvs_UpdateTable = This.Describe("DataWindow.Table.UpdateTable")
	
If lvs_UpdateTable = "?" Or lvs_UpdateTable = "" Then
	Return False
End If	
	
If This.DeletedCount() > 0 Then Return True

If This.ModifiedCount() = 0 Then Return False

lvi_Numero_Colunas = Integer(This.Describe("DataWindow.Column.Count")) 

For lvi_Coluna = 1 To lvi_Numero_Colunas	
	lvs_Coluna = This.Describe("#" + String(lvi_Coluna) + ".Name")
	
	If Lower(This.Describe(lvs_Coluna + ".Update")) = "yes" Then
		For lvl_Linha = 1 To This.RowCount()
			ldwis_Status = This.GetItemStatus(lvl_Linha, lvs_Coluna, Primary!)
			
			If ldwis_Status = DataModified! or ldwis_Status = NewModified! Then
				Return True
			End If
		Next
	End If
Next

Return False
end function

public subroutine of_marca_coluna_ativa_ordenacao (string as_coluna);Integer lvi_Total, &
        lvi_Contador
		  
String lvs_Objetos[], &
		 lvs_Objeto, &
       lvs_Describe, &
		 lvs_Modify, &
		 lvs_Band, &
		 lvs_Tipo

This.of_Lista_Objetos(ref lvs_Objetos[])

lvi_Total = UpperBound(lvs_Objetos)

For lvi_Contador = 1 To lvi_Total
	
	lvs_Objeto = lvs_Objetos[lvi_Contador]
	
	lvs_Describe = lvs_Objeto + ".Band"
	lvs_Band = This.Describe(lvs_Describe)
	
	If Upper(lvs_Band) = "HEADER" Then
		
		lvs_Describe = lvs_Objeto + ".Type"
		lvs_Tipo = This.Describe(lvs_Describe)
		
		If Upper(lvs_Tipo) = "TEXT" or Upper(lvs_Tipo) = "COMPUTE" Then
			
			If Upper( RightA( lvs_Objeto, 2 ) ) = '_T' Then
				If lvs_Objeto = as_coluna Then
					lvs_Modify = This.Modify(lvs_Objeto+".Font.Weight = 700")
				Else				
					lvs_Modify = This.Modify(lvs_Objeto+".Font.Weight = 400")
				End If	
			
				If This.Modify(lvs_Modify) <> "" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na identifica$$HEX2$$e700e300$$ENDHEX$$o da Coluna ordenada.", Information!)
					Return
				End If
			End If
		
		End If
		
	End If	
		
Next
end subroutine

public subroutine of_appendwhere_subquery (string ps_where, integer pi_where);Integer lvi_Contador = 0

String lvs_SQL

Long lvl_Posicao

If IsNull( ps_Where ) Then
	Return // Gambiarra - 19/12/2014
End If

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE")

Do While lvl_Posicao > 0
	lvi_Contador ++
	If lvi_Contador = pi_Where Then Exit
		
	lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE", lvl_Posicao + 5)
Loop

// Verifica se encontrou o WHERE na posi$$HEX2$$e700e300$$ENDHEX$$o desejada
If lvi_Contador <> pi_where Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o AppendWhere.", StopSign!)
	Return
End If

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE", lvl_Posicao)

If lvl_Posicao = 0 Then
	lvs_SQL += " WHERE " + ps_Where
Else
	lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao + 5) + " " + ps_Where + " and " + &
	          MidA(lvs_SQL, lvl_Posicao + 6)
End If

This.of_ChangeSQL(lvs_SQL)
end subroutine

public subroutine of_setrowselection (string as_backcolor, string as_color, boolean pb_usa_default);Integer lvi_Total, &
        lvi_Contador
		  
String lvs_Objetos[], &
		 lvs_Objeto, &
       lvs_Describe, &
		 lvs_Modify, &
		 lvs_Band, &
		 lvs_Tipo, &
		 lvs_Color, &
		 lvs_BackColor, &
		 lvs_Edicao

This.of_Lista_Objetos(ref lvs_Objetos[])

lvi_Total = UpperBound(lvs_Objetos)

For lvi_Contador = 1 To lvi_Total
	
	lvs_Objeto = lvs_Objetos[lvi_Contador]
	
	lvs_Describe = lvs_Objeto + ".Band"
	lvs_Band = This.Describe(lvs_Describe)
	
	If Upper(lvs_Band) = "DETAIL" Then
		lvs_Describe = lvs_Objeto + ".Type"
		lvs_Tipo = This.Describe(lvs_Describe)
		
		Choose Case Upper(lvs_Tipo)
			Case "COLUMN", "COMPUTE"
				lvs_Describe = lvs_Objeto + ".edit.style"
				lvs_Edicao = This.Describe(lvs_Describe)
				
				If lvs_Edicao <> "checkbox" and lvs_Edicao <> "radiobuttons" Then 
					lvs_Describe = lvs_Objeto + ".Background.Color"
					lvs_BackColor = This.Describe(lvs_Describe)
					
					// Se j$$HEX1$$e100$$ENDHEX$$ houver uma f$$HEX1$$f300$$ENDHEX$$rmula estabelecida "Not IsNumber()" 
					// Altera somente se receber outra f$$HEX1$$f300$$ENDHEX$$rmula como par$$HEX1$$e200$$ENDHEX$$metro
					// Sen$$HEX1$$e300$$ENDHEX$$o utiliza a cor definida originalmente
					
					If as_BackColor <> "" or IsNumber(lvs_BackColor) Then
						If as_BackColor <> "" Then lvs_BackColor = as_BackColor
						
						lvs_Modify = lvs_Objeto + ".Background.Color='0~t" + lvs_BackColor + "'"
	
						If This.Modify(lvs_Modify) <> "" Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na defini$$HEX2$$e700e300$$ENDHEX$$o do modo de sele$$HEX2$$e700e300$$ENDHEX$$o das linhas (backcolor).", Information!)
							Return
						End If
					End If
					
					lvs_Describe = lvs_Objeto + ".Color"
					lvs_Color = This.Describe(lvs_Describe)
					
					If as_Color <> "" or IsNumber(lvs_Color) Then
						If as_Color <> "" Then lvs_Color = as_Color
						
						lvs_Modify = lvs_Objeto + ".Color='0~tIf(getrow() = currentrow(), rgb(255,255,255), " + lvs_Color + ")'"
						
						If This.Modify(lvs_Modify) <> "" Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na defini$$HEX2$$e700e300$$ENDHEX$$o do modo de sele$$HEX2$$e700e300$$ENDHEX$$o das linhas (color).", Information!)
							Return
						End If
					End If
				End If
		End Choose
	End If	
Next

This.ivb_Selecao_Linhas = False
end subroutine

public function string of_getsql ();Return This.Object.DataWindow.Table.Select
end function

public subroutine of_appendselect (string ps_campo);String lvs_SQL

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "FROM", 1)

lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao -1) + ", " + ps_Campo + " " + &
          MidA(lvs_SQL, lvl_Posicao)

This.of_ChangeSQL(lvs_SQL)
end subroutine

public function boolean of_exporta_excel (string ps_arquivo);String lvs_Arquivo
String lvs_Diretorio

Long lvi_Retorno

lvs_Diretorio = ps_arquivo

lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
										lvs_Diretorio, &
										lvs_Arquivo, &
										"XLS", "Arquivos do Excel (*.XLS)")

If lvi_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
	Return False
Else
	If lvi_Retorno = 0 Then Return False
End If

lvs_Diretorio = Upper(lvs_Diretorio)

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_Diretorio) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
		If Not FileDelete(lvs_Diretorio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
			Return False
		End If
	Else
		Return False
   End If   
End If

If This.SaveAs( lvs_Diretorio, HTMLTable!, True ) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel exportar os dados.~r~n Erro ao sobreescrever o arquivo: "+lvs_Arquivo+"!",Exclamation!)
	Return False
End If

// Convert HTML file to Excel native format
OLEObject Excel 
Excel = Create OLEObject 

If Excel.ConnectToNewObject('Excel.Application') = 0 Then
	Excel.Application.DisplayAlerts = False
	Excel.Application.Workbooks.Open(lvs_Diretorio)
	Excel.Application.Workbooks( 1 ).Parent.Windows( Excel.Application.Workbooks( 1 ).Name ).Visible = True
	Excel.Application.Workbooks( 1 ).SaveAs(lvs_Diretorio, 56 ) 
	Excel.Application.Workbooks( 1 ).Close()
	Excel.DisconnectObject()
	
	MessageBox('Sucesso!','Arquivo gerado: '+lvs_Diretorio)

	Destroy(Excel)
	Return True
Else
	MessageBox('Erro!','O arquivo n$$HEX1$$e300$$ENDHEX$$o pode ser salvo!',StopSign!)
	Destroy(Excel)
	Return False
End If
end function

public subroutine of_set_somente_leitura (boolean pb_permite_alterar);Long lvl_Count
Long lvl_Campo
Long lvl_Coluna

String lvs_Coluna
String lvs_Tipo

Boolean lvb_Protect

If Not(pb_permite_alterar) Then
	lvl_Count = Long(This.Describe("DataWindow.Column.Count"))
	
	For lvl_Campo = 1 To lvl_Count
		lvs_Coluna = "#"+String(lvl_Campo)+".Name"
		lvs_Coluna = This.Describe(lvs_Coluna) 
		
		lvb_Protect = True
		For lvl_Coluna = 1 To UpperBound(This.ivs_Coluna_Sem_Validacao_Salva) 
			If lvs_Coluna = This.ivs_Coluna_Sem_Validacao_Salva[lvl_Coluna] Then
				lvb_Protect = False
				Exit
			End If
		Next
		If lvb_Protect  Then
			lvs_Tipo = Lower(This.Describe(lvs_Coluna+".Edit.Style"))
			If  (lvs_Tipo = 'editmask') or (lvs_Tipo = 'edit') Then
				This.Modify(lvs_Coluna+".Edit.DisplayOnly=Yes")  
			Else
				This.Modify(lvs_Coluna+".Protect='1~t1'")  
			End If
		End If
	NEXT	
End If
end subroutine

public subroutine of_destaca_campos_obrigatorios ();Long i, ll_x, ll_y, ll_h, ll_w
String ls_name
String ls_Campo
String ls_Erro
String ls_Retangulo

For i = 1 To UpperBound( ivs_Campos_Obrigatorios )
	ls_Campo	=	ivs_Campos_Obrigatorios[i]
	ll_x			= Long( This.Describe(ls_Campo+'.x') )		- 4
	ll_y			= Long( This.Describe(ls_Campo+'.y') )		- 4
	ll_h			= Long( This.Describe(ls_Campo+'.height') )	+ 8
	ll_w			= Long( This.Describe(ls_Campo+'.width') )	+ 10
	ls_name		= 'r_required_' + ls_Campo
	
	This.Modify( 'destroy ' + ls_name )
	
	ls_Retangulo = 'create rectangle(band=detail x="'+String(ll_x)+'" y="'+String(ll_y)	+ &
						'" height="'+String(ll_h)+'" width="'+String(ll_w)+'"name='+ls_name					+ &
						' visible="1" brush.hatch="7" brush.color="1610612736" pen.style="0" '				+ &
						'pen.width="5" pen.color="190"  background.mode="2" background.color="33554432")'
	
	ls_Erro = This.modify( ls_Retangulo )
	
	If ls_Erro = "" Then
		ls_Erro = This.modify(ls_Campo + '.Border = "0"')
	End If
Next
end subroutine

public subroutine of_appendfrom_ansi (string ps_from, integer pi_union);Integer lvi_Contador = 0

String lvs_SQL

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE")

Do While lvl_Posicao > 0
	lvi_Contador ++
	If lvi_Contador = pi_Union Then Exit
		
	lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE", lvl_Posicao + 5)
Loop

// Verifica se encontrou o FROM na posi$$HEX2$$e700e300$$ENDHEX$$o desejada pelo UNION
If lvi_Contador <> pi_Union Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o AppendFrom.", StopSign!)
	Return
End If

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE ", lvl_Posicao - 5 )

lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao - 1) + " " + ps_From + " " + &
          MidA(lvs_SQL, lvl_Posicao)

This.of_ChangeSQL(lvs_SQL)
end subroutine

public subroutine of_setsort ();Long lvl_Colunas
Long lvl_Coluna

String lvs_Coluna
String lvs_DescColuna
String lvs_Bands

String lvs_Campo[]
String lvs_Descricao[]

lvs_Bands = This.Describe("DataWindow.Bands")
//Se tiver agrupamentos n$$HEX1$$e300$$ENDHEX$$o ativa o sort autom$$HEX1$$e100$$ENDHEX$$tico
If Pos(lvs_Bands,'header.1')>0 Then Return 

lvl_Colunas = Long(This.Describe("DataWindow.Column.Count"))

For lvl_Coluna = 1 to lvl_Colunas
	lvs_Coluna = This.Describe("#"+String(lvl_Coluna)+".Name")
	lvs_DescColuna = This.Describe(lvs_Coluna+"_t.Text")
	
	If ((Not IsNull(lvs_DescColuna))and(Trim(lvs_DescColuna)<>'')and(Trim(lvs_DescColuna)<>'!')) and &
		((Not IsNull(lvs_Coluna))and(Trim(lvs_Coluna)<>'')) Then
		lvs_Campo		[UpperBound(lvs_Campo) + 1] 		= lvs_Coluna
		lvs_Descricao	[UpperBound(lvs_Descricao) + 1] 	= lvs_DescColuna
	End If
Next

If UpperBound(lvs_Campo) > 0 Then
	This.of_SetSort(lvs_Campo,lvs_Descricao)
End If
end subroutine

public subroutine of_setfilter ();Long lvl_Colunas
Long lvl_Coluna

String lvs_Coluna
String lvs_DescColuna

String lvs_Campo[]
String lvs_Descricao[]

//Se tiver agrupamentos n$$HEX1$$e300$$ENDHEX$$o ativa o sort autom$$HEX1$$e100$$ENDHEX$$tico
//If Pos(This.Describe("DataWindow.Bands"),'header.1')>0 Then Return 

lvl_Colunas = Long(This.Describe("DataWindow.Column.Count"))

For lvl_Coluna = 1 to lvl_Colunas
	lvs_Coluna = This.Describe("#"+String(lvl_Coluna)+".Name")
	lvs_DescColuna = This.Describe(lvs_Coluna+"_t.Text")
	
	If ((Not IsNull(lvs_DescColuna))and(Trim(lvs_DescColuna)<>'')and(Trim(lvs_DescColuna)<>'!')) and &
		((Not IsNull(lvs_Coluna))and(Trim(lvs_Coluna)<>'')) Then
		lvs_Campo		[UpperBound(lvs_Campo) + 1] 		= lvs_Coluna
		lvs_Descricao	[UpperBound(lvs_Descricao) + 1] 	= lvs_DescColuna
	End If
Next

If UpperBound(lvs_Campo) > 0 Then
	This.of_SetFilter(lvs_Campo,lvs_Descricao)
End If
end subroutine

public subroutine of_grava_log (boolean pb_habilita);ivb_grava_log = pb_habilita
end subroutine

public function string of_titulo_coluna (string ps_coluna);String lvs_Coluna
//Retorna o valor do t$$HEX1$$ed00$$ENDHEX$$tulo da coluna (caso esteja como padr$$HEX1$$e300$$ENDHEX$$o [nome] + _t) 
lvs_Coluna = This.Describe(ps_coluna+'_t.Text')

//Verifica se foi poss$$HEX1$$ed00$$ENDHEX$$vel recuperar o t$$HEX1$$ed00$$ENDHEX$$tulo da coluna
//Caso n$$HEX1$$e300$$ENDHEX$$o atribui o nome do campo
If IsNull(lvs_Coluna) or (Trim(lvs_Coluna)='') Then lvs_Coluna = ps_coluna

Return lvs_Coluna
end function

public subroutine of_habilita_aux_visual ();Long lvl_Count
Long lvl_Campo
Long lvl_Coluna

String lvs_Coluna

Boolean lvb_Protect

lvl_Count = Long(This.Describe("DataWindow.Column.Count"))

For lvl_Campo = 1 To lvl_Count
	lvs_Coluna = "#"+String(lvl_Campo)+".Name"
	lvs_Coluna = This.Describe(lvs_Coluna) 
	
	lvb_Protect = True
	For lvl_Coluna = 1 To UpperBound(This.ivs_Coluna_Sem_Validacao_Salva) 
		If lvs_Coluna = This.ivs_Coluna_Sem_Validacao_Salva[lvl_Coluna] Then
			lvb_Protect = False
			Exit
		End If
	Next
	If lvb_Protect  Then
		If Not (Long(This.Describe(lvs_Coluna+".TabSequence")) > 0) Then	
			If (This.Describe(lvs_Coluna+".Visible")="1") Then	
				This.Modify(lvs_Coluna+".TabSequence="+String(lvl_Campo * 10))  
				//If This.Describe("#"+String(lvl_Campo)+'.Edit.Style')<>'ddlb' Then
					This.Modify(lvs_Coluna+".Edit.DisplayOnly=Yes")  
					This.Modify(lvs_Coluna+".Edit.FocusRectangle=No")  
				//End If
			End if
		End If
	End If
NEXT	
end subroutine

public function integer of_exporta_pdf (string ps_arquivo);String lvs_Dir
String lvs_Exe
String lvs_File

Long lvl_Char
Long lvl_Retorno = -1

dc_uo_api ivo_api
ivo_api = Create dc_uo_api

//Localiza diret$$HEX1$$f300$$ENDHEX$$rio GhostScript
lvs_Dir = ivo_api.of_get_diretorio_ghostscript()
lvs_Exe = lvs_Dir+'bin\gswin64c.exe'
If Not FileExists(lvs_Exe) Then
	lvs_Exe = lvs_Dir+'bin\gswin32c.exe'
	If Not FileExists(lvs_Exe) Then
		lvs_Exe = lvs_Dir+'gswin64c.exe'
		If Not FileExists(lvs_Exe) Then
			lvs_Exe = lvs_Dir+'gswin32c.exe'
			If Not FileExists(lvs_Exe) Then lvs_Exe = ''
		End If
	End If
End If

//Executa processos apenas se houver o aplicativo
If (lvs_Exe <> '') Then
	//Verifica se existe a impressora necess$$HEX1$$e100$$ENDHEX$$ria configurada
	If Not ivo_api.of_printer_pdf_installed() Then 
		ivo_api.of_AddPrinter(lvs_Dir+'Lib\ghostpdf.inf', "Ghostscript PDF", "Sybase DataWindow PS")
		If Not ivo_api.of_printer_pdf_installed() Then 
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instalar a impressora PDF (Sybase DataWindow PS)".~r~n'+ &
							'O arquivo n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ salvo!',Exclamation!)
			Destroy(ivo_api)
			Return lvl_Retorno
		End If
	End If
	//Localiza a primeira barra para retornar apenas o diret$$HEX1$$f300$$ENDHEX$$rio
	For lvl_Char = Len(ps_arquivo) To  1 Step -1
		If Mid(ps_arquivo,lvl_Char,1) = '\' Then Exit
	Next 
	//Armazena caminho do arquivo tempor$$HEX1$$e100$$ENDHEX$$rio PostScript
	lvs_File = Mid(ps_arquivo,1,lvl_Char)+'printer_file.ps'
	//Define configura$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o de arquivo PostScript
	This.Object.DataWindow.Print.FileName = lvs_File
	This.Object.DataWindow.Print.PrinterName = 'Sybase DataWindow PS'
	This.Object.DataWindow.Export.PDF.Method = Distill!
	This.Object.DataWindow.Export.PDF.Distill.CustomPostScript= "Yes"
	//Gera arquivo PostScript
	This.Print(False,False)
	//Converte PostScript em PDF
	gf_run('"'+lvs_Exe+'" -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -sOutputFile="'+ps_arquivo+'" -c .setpdfwrite -f "'+lvs_File+'"',0,True)
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','N$$HEX1$$e300$$ENDHEX$$o foi encontrado o programa (GhostScript) necess$$HEX1$$e100$$ENDHEX$$rio para a exporta$$HEX2$$e700e300$$ENDHEX$$o.~r~n'+ &
					'Solicite a infraestrutura de inform$$HEX1$$e100$$ENDHEX$$tica a instala$$HEX2$$e700e300$$ENDHEX$$o do programa.',Exclamation!)
End If

Destroy(ivo_api)

//Volta o valor do filename para n$$HEX1$$e300$$ENDHEX$$o haver problema em impress$$HEX1$$f500$$ENDHEX$$es posteriores
This.Object.DataWindow.Print.FileName 		= '' 
This.Object.DataWindow.Print.PrinterName	= ''
//Exclui arquivo PostScript
If FileExists(lvs_File) Then FileDelete(lvs_File)
//Verifica a gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo
If FileExists(ps_arquivo) Then lvl_Retorno = 1

Return lvl_Retorno
end function

event rowfocuschanged;If ivb_Selecao_Linhas Then
	This.SelectRow(0, False)
	This.SelectRow(CurrentRow, True)
End If
end event

event constructor;String lvs_DataObject

This.of_SetTransObject(SqlCa)

lvs_DataObject = This.DataObject

If Trim(This.DataObject) <> "" Then
	ivs_SQL_Original = This.Object.DataWindow.Table.Select
End If

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()

//Habilita aux$$HEX1$$ed00$$ENDHEX$$lio visual?
If gvo_aplicacao.ivb_Usa_Aux_Visual Then This.of_habilita_aux_visual()


end event

event itemerror;Return 1
end event

event destructor;Destroy(ivo_Controle_Menu)

If IsValid(ivo_Sort)       Then Destroy(ivo_Sort)
If IsValid(ivo_Filter)     Then Destroy(ivo_Filter)
If IsValid(ivo_Find)       Then Destroy(ivo_Find)
If IsValid(ivo_Multitable) Then Destroy(ivo_Multitable)
If IsValid(ivds_Relatorio) Then Destroy(ivds_Relatorio)
end event

event dberror;
String lvs_Mensagem

SetPointer(HourGlass!)

If SqldbCode = -3 Then
	lvs_Mensagem = "Ocorreram altera$$HEX2$$e700f500$$ENDHEX$$es no banco de dados em uma das informa$$HEX2$$e700f500$$ENDHEX$$es modificadas " + &
	               "nesta janela. Por favor, recupere os registros novamente e proceda as modifica$$HEX2$$e700f500$$ENDHEX$$es " + &
					   "efetuadas."
Else
	lvs_Mensagem = "Ocorreu um erro de base de dados.~r~n~r~n~r~n" + &
						"C$$HEX1$$f300$$ENDHEX$$digo:  " + String(SqldbCode) + "~r~n~r~n" + &
						"Descri$$HEX2$$e700e300$$ENDHEX$$o:~r~n" + SqlErrText
End If

// Atualiza as informa$$HEX2$$e700f500$$ENDHEX$$es sobre o erro ocorrido
ivw_ParentWindow.ivo_dbError.ivl_SqldbCode  = SqldbCode
ivw_ParentWindow.ivo_dbError.ivs_SqlErrText = SqlErrText
ivw_ParentWindow.ivo_dbError.ivs_SqlSyntax  = SqlSyntax
ivw_ParentWindow.ivo_dbError.ivs_Mensagem   = lvs_Mensagem
ivw_ParentWindow.ivo_dbError.ivs_DataBase   = This.itr_Transacao.ivs_DataBase

// Altera$$HEX2$$e700e300$$ENDHEX$$o feita por Ademir Buss em 05/11/2001
// N$$HEX1$$e300$$ENDHEX$$o estava apresentando a mensagem de erro das DW$$HEX1$$b400$$ENDHEX$$s
// Foi comentado em 01/08/2002 por Ademir Buss
// ivw_ParentWindow.Event ue_dbError()

// Altera$$HEX2$$e700e300$$ENDHEX$$o feita por Ademir Buss em 11/12/2002
// O evento SAVE da janela j$$HEX1$$e100$$ENDHEX$$ chama o evento para mostrar a mensagem de erro
// Antes n$$HEX1$$e300$$ENDHEX$$o mostrava a mensagem quando o erro era de retrieve
If Not ivw_ParentWindow.ivb_Salvando Then
	ivw_ParentWindow.Event ue_dbError()
End If

SetPointer(Arrow!)
Return 1
end event

event editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
	End If
End If
end event

event itemchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
	End If
End If
end event

event itemfocuschanged;This.Post Event ue_SelectText()

This.of_Desmarca_Coluna_Ativa()

If dwo.Type = "column" Then
	This.of_Marca_Coluna_Ativa(dwo.Name)
End If

Return 0
end event

event losefocus;// This.of_Desmarca_Coluna_Ativa()
end event

event getfocus;This.Post Event ue_SelectText()

This.of_Marca_Coluna_Ativa(This.GetColumnName())

Return 0
end event

event clicked;If Row > 0 Then This.SetRow(Row)

String lvs_titulo
String lvs_coluna
String lvs_sort_atual
String lvs_Cabecalho

Integer lvi_tamanho

If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then

	lvs_titulo 		= This.GetObjectAtPointer()
	lvs_Cabecalho  = This.GetBandAtPointer()
		
	If LeftA(lvs_Cabecalho, 6) = "header" Then
		
		lvi_tamanho = PosA(lvs_titulo,CharA(9))-1
		
		If lvi_tamanho > 0 Then
			
			lvs_titulo = LeftA(lvs_titulo, lvi_tamanho)
			
			This.of_Marca_Coluna_Ativa_Ordenacao(lvs_titulo)
			
			lvs_Coluna = LeftA(lvs_Titulo,lvi_Tamanho -2 )
					
			lvs_sort_atual = This.Object.DataWindow.Table.Sort
			
			lvi_tamanho 	= LenA(lvs_sort_atual) - 2
			lvs_titulo  	= LeftA(lvs_sort_atual, lvi_tamanho)
			
			If lvs_coluna = lvs_titulo Then
				
				lvs_sort_atual = RightA(lvs_sort_atual, 1)
				
				If lvs_sort_atual = "A" Then
					lvs_sort_atual = " D"
				Else
					lvs_sort_atual = " A"
				End If
				
				lvs_coluna = lvs_coluna + lvs_sort_atual
			Else
				lvs_coluna += " A"				
			End If
			
			This.SetSort(lvs_coluna)
			This.Sort()
			
			This.Event RowFocusChanged(1)
		End If	
		
	End If
	
End If	
end event

on dc_uo_dw_base.create
end on

on dc_uo_dw_base.destroy
end on

