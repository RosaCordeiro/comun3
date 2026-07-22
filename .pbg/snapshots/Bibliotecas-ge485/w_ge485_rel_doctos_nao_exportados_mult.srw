HA$PBExportHeader$w_ge485_rel_doctos_nao_exportados_mult.srw
$PBExportComments$Relat$$HEX1$$f300$$ENDHEX$$rio de Documentos n$$HEX1$$e300$$ENDHEX$$o Exportados Mul
forward
global type w_ge485_rel_doctos_nao_exportados_mult from dc_w_selecao_lista_relatorio
end type
type uo_1 from uo_data_atual within w_ge485_rel_doctos_nao_exportados_mult
end type
end forward

global type w_ge485_rel_doctos_nao_exportados_mult from dc_w_selecao_lista_relatorio
string accessiblename = "GE485 Pendencias Exportacao TDF"
integer x = 215
integer y = 220
integer width = 5536
integer height = 2364
string title = "GE485 - Relat$$HEX1$$f300$$ENDHEX$$rio Pend$$HEX1$$ea00$$ENDHEX$$ncias Exporta$$HEX2$$e700e300$$ENDHEX$$o TDF"
uo_1 uo_1
end type
global w_ge485_rel_doctos_nao_exportados_mult w_ge485_rel_doctos_nao_exportados_mult

type variables
String ivs_Ambiente
String ivs_Parametros[]

long ivl_altura_1, &
        ivl_altura_2, &
        ivl_largura_1, &
        ivl_largura_2

//Cria$$HEX2$$e700e300$$ENDHEX$$o classes para filtros
uo_mult_tipo_docto 			ivo_tipo_docto
uo_mult_padrao_docto 		ivo_padrao_docto
uo_Filial							ivo_filial   // uo_mult_filial 

dc_uo_transacao uoi_transacao_multi, &
					   uoi_transacao_SYB
end variables

forward prototypes
public function boolean wf_altera_bd (long pl_empresa)
public subroutine wf_settrans (dc_uo_transacao ptr_trans)
public function boolean wf_valida_datas_parametro (ref long pl_cd_filial, ref string ps_vl_parametro)
public function boolean wf_valida_cfop_tipodoc (ref string as_log)
end prototypes

public function boolean wf_altera_bd (long pl_empresa);string lvs_Datasource

Choose Case pl_empresa
	Case 24,61
		lvs_Datasource = IIF(lower(gvo_aplicacao.ivs_datasource)="central", "QUIMIDROL", "QUIMIDROLTESTE")
		If Not gf_conecta_banco_mult( uoi_transacao_multi, 'quimidrol' ) Then
			Return False
		Else
			wf_setTrans(uoi_transacao_multi)
		End If
	Case Else
		lvs_Datasource = IIF(lower(gvo_aplicacao.ivs_datasource)="central", "CLAMPROD", "CLAMTESTE")
		If Not gf_conecta_banco_mult( uoi_transacao_multi, lvs_Datasource ) Then
			Return False
		Else
			wf_setTrans(uoi_transacao_multi)
		End If
End Choose

dw_1.Reset()
dw_1.Event ue_AddRow()
dw_1.Object.cd_empresa [1] = pl_empresa

ivo_tipo_docto.of_SetTrans(uoi_transacao_multi)
ivo_padrao_docto.of_SetTrans(uoi_transacao_multi)
dw_2.SetTransObject(uoi_transacao_multi)

ivo_tipo_docto.of_Inicializa()
ivo_padrao_docto.of_Inicializa()
ivo_filial.of_Inicializa()

Return True
end function

public subroutine wf_settrans (dc_uo_transacao ptr_trans);dw_2.SetTransObject(ptr_trans)
dw_2.SetTrans(ptr_trans)
dw_2.itr_transacao = ptr_trans
end subroutine

public function boolean wf_valida_datas_parametro (ref long pl_cd_filial, ref string ps_vl_parametro);SELECT cd_filial, vl_parametro 
INTO	 :pl_cd_filial, :ps_vl_parametro
FROM	 parametro_loja
WHERE	 cd_parametro = 'DH_INICIO_OPERACAO_SAP' 
	AND LENGTH(vl_parametro) > 10
FETCH FIRST 1 ROW ONLY
USING uoi_transacao_multi;

If pl_cd_filial > 0 Then
	Return False
End If

Return True
end function

public function boolean wf_valida_cfop_tipodoc (ref string as_log);Long	lvl_Ret,&
		lvl_ID,&
		lvl_For,&
		lvl_Tot

Try	
	lvl_Tot = dw_2.RowCount()	
	dw_2.SetRedraw(False)
	
	If Not IsValid(w_aguarde) Then Open(w_aguarde)
	w_aguarde.uo_Progress.of_SetMax(lvl_Tot)
	w_aguarde.Title = "Verificando notas de baixa de estoque enviadas para o TDF direto do Sybase..."
	
	For lvl_For = lvl_Tot To 1 Step -1
		
		//Atualiza progresso
		w_aguarde.uo_Progress.of_SetProgress(lvl_Tot - lvl_For+1)
		
		lvl_Ret = 0
		lvl_ID = dw_2.GetItemNumber(lvl_For,"id_docto")
			
		SELECT 1
		INTO:lvl_Ret
		FROM m3_doctoitem A1
		INNER JOIN m3_tribitem B1 ON B1.idf_doctoitem = A1.ID /*Tributacao do item*/
		INNER JOIN m3_codfisope C1 ON C1.ID = B1.idf_codoperfiscal /*CFOP dp item*/
		INNER JOIN m3_partedocto D1 ON D1.ID = A1.ida /*Parte do documento*/
		INNER JOIN m3_docto E1 ON E1.ID = D1.idf_docto /*Documento*/
		INNER JOIN m3_tipdoc F1 ON F1.ID = E1.idf_tpdocto
		WHERE C1.codigo in ('5.927','6.927') /* CFOPs de Baixa est$$HEX1$$e300$$ENDHEX$$o em interface pelo Sybase */
		AND F1.idf_padraodocto IN(66,70) /* Tipo DOC de Baixa est$$HEX1$$e300$$ENDHEX$$o em interface pelo Sybase */
		AND E1.ID = :lvl_ID
		AND ROWNUM = 1
		USING uoi_transacao_multi;
		
		If uoi_transacao_multi.SQLCode = -1 Then
			as_log = "Erro na Fun$$HEX2$$e700e300$$ENDHEX$$o wf_valida_cfop_tipodoc: "+uoi_transacao_multi.SqlErrText
			Return False
		End If
		
		If lvl_Ret > 0 Then
			dw_2.deleterow( lvl_For)
		End If
		
	Next
	
	//Atualiza progresso
	w_aguarde.uo_Progress.of_SetProgress(lvl_Tot)
	
Finally	
	dw_2.SetRedraw(True)
	If IsValid(w_aguarde) Then Close(w_aguarde)
End Try

Return True
end function

on w_ge485_rel_doctos_nao_exportados_mult.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_ge485_rel_doctos_nao_exportados_mult.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
end on

event ue_preopen;call super::ue_preopen;//Cria$$HEX2$$e700e300$$ENDHEX$$o classes para filtros
ivo_tipo_docto 			= Create uo_mult_tipo_docto
ivo_padrao_docto 		= Create uo_mult_padrao_docto
ivo_filial 					= Create uo_filial 		//uo_mult_filial

//Dimensionamento de tela
Maxheight = 9999

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event close;call super::close;If IsValid(ivo_tipo_docto) 		then Destroy ivo_tipo_docto
If IsValid(ivo_padrao_docto) 	then Destroy ivo_padrao_docto
If IsValid(ivo_filial) 				then Destroy ivo_filial
If IsValid(dw_3) 	  				then Destroy dw_3
end event

event ue_postopen;call super::ue_postopen;String lvs_Datasource

dw_1.Reset()
dw_1.Event ue_AddRow()

ivs_Ambiente							 = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"TDF", "Ambiente", "PRD")
dw_1.Object.dt_inicio				[1] = RelativeDate( Today(), -1)
dw_1.Object.dt_fim				[1] = Today()
dw_1.Object.id_movimento		[1] = 'T' 
dw_1.Object.id_situacao			[1] = 'T'
dw_1.Object.id_exporta			[1] = 1    /* Integrado no SAP / 1 = N$$HEX1$$e300$$ENDHEX$$o Integrado SAP  / 2 = Todos */
dw_1.Object.cd_ambiente_sap	[1] = ivs_Ambiente
dw_1.Object.cd_empresa		[1] = 2 // Clamed

wf_altera_bd(dw_1.Object.cd_empresa [1])

//Conex$$HEX1$$e300$$ENDHEX$$o com BD Sybase em producao.
uoi_transacao_SYB = Create dc_uo_transacao
//Se ja estiver em producao utiliza o SQLCA
if lower(gvo_aplicacao.ivs_database) = "central" then
	uoi_transacao_SYB = SQLCA
else
	lvs_Datasource = gvo_aplicacao.ivo_Seguranca.Cd_Sistema + "_" + gvo_aplicacao.of_UserId()
	uoi_transacao_SYB.of_SetDataBase('SYBASE')
	uoi_transacao_SYB.Database = 'SYBASE'
	If Not uoi_transacao_SYB.of_Connect( 'central', lvs_Datasource) Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar ao banco Sybase de produ$$HEX2$$e700e300$$ENDHEX$$o (CENTRAL) com o usu$$HEX1$$e100$$ENDHEX$$rio: " + lvs_Datasource, Exclamation!)
		Post Close( This )
	end if
end if

dw_2.InsertRow(0)
dw_1.SetFocus()
end event

event ue_print;SetPointer(HourGlass!)

dw_3.Event ue_Print()

SetPointer(Arrow!)
end event

event ue_printimmediate;SetPointer(HourGlass!)

dw_3.Event ue_PrintImmediate()
		
SetPointer(Arrow!)


end event

event ue_saveas;call super::ue_saveas;SetPointer(HourGlass!)

dw_2.Event ue_SaveAs()
		
SetPointer(Arrow!)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge485_rel_doctos_nao_exportados_mult
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge485_rel_doctos_nao_exportados_mult
integer x = 78
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge485_rel_doctos_nao_exportados_mult
integer x = 23
integer y = 452
integer width = 5445
integer height = 1712
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge485_rel_doctos_nao_exportados_mult
integer width = 5445
integer height = 436
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge485_rel_doctos_nao_exportados_mult
integer y = 88
integer width = 5362
integer height = 344
string dataobject = "dw_ge485_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_cd_filial
Choose Case dwo.name 
	Case "nm_padraodocto" 
		If Trim(Data) <> "" Then
			If Data <> ivo_padrao_docto.Descricao Then
				Return 1
			End If	
		Else	
			ivo_padrao_docto.of_inicializa()
			
			This.Object.id_padraodocto		[1] = ivo_padrao_docto.ID
			This.Object.nm_padraodocto	[1] = ivo_padrao_docto.Descricao
		
		End If
	Case "de_tipodocto" 
		If Trim(Data) <> "" Then
			If Data <> ivo_tipo_docto.Descricao Then
				Return 1
			End If	
		Else	
			ivo_tipo_docto.of_inicializa()
			
			This.Object.id_tipodocto	[1] = ivo_tipo_docto.ID
			This.Object.cd_tipodocto	[1] = ivo_tipo_docto.Codigo
			This.Object.de_tipodocto	[1] = ivo_tipo_docto.Descricao
		End If
	Case "nm_filial" 
		If Trim(Data) <> "" Then
			If Data <> ivo_filial.Nm_Fantasia Then
				Return 1
			End If	
		Else	
			ivo_filial.of_inicializa()
		
			This.Object.Cd_Filial[Row] 	= ivo_Filial.Cd_Filial
			This.Object.nm_filial[Row] 	= ivo_Filial.Nm_Fantasia
		End If		
			
	Case "cd_empresa"
		If not wf_altera_bd(Long(Data)) Then
			MessageBox('Falha!','N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar o banco de dados da empresa selecionada. ~r~nA tela "'+Parent.Title+'" ser$$HEX1$$e100$$ENDHEX$$ encerrrada.',StopSign!)
			Close(Parent)
			Return
		End if
	
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_padrao_docto) Then
	This.Object.nm_padraodocto[1] 	= ivo_padrao_docto.Descricao
End If

If IsValid(ivo_tipo_docto) Then
	This.Object.de_tipodocto [1] 		= ivo_tipo_docto.Descricao
End If

If IsValid(ivo_filial) Then
	This.Object.nm_filial [1]			 	= ivo_filial.Nm_Fantasia
End If


end event

event dw_1::ue_addrow;call super::ue_addrow;This.Object.dt_inicio	[1] = RelativeDate(Today(),-6)
This.Object.dt_fim		[1] = RelativeDate(Today(),-1)

Return AncestorReturnValue
end event

event dw_1::ue_key;call super::ue_key;Long   lvl_Empresa
String lvs_Filial

If Key = KeyEnter! Then
	dw_1.Accepttext( )
	lvl_Empresa = dw_1.Object.cd_empresa [1]
	Choose Case This.GetColumnName()
		Case "nm_padraodocto"
			ivo_padrao_docto.of_Localiza(This.GetText())
			
			If ivo_padrao_docto.Localizado Then
				This.Object.id_padraodocto		[1]	= ivo_padrao_docto.ID
				This.Object.nm_padraodocto	[1]	= ivo_padrao_docto.Descricao
				
				If Not IsNull(ivo_tipo_docto.ID) Then
					If ivo_tipo_docto.IDF_Padrao <> ivo_padrao_docto.ID Then
						ivo_tipo_docto.of_inicializa()
						
						This.Object.id_tipodocto		[1]	= ivo_tipo_docto.ID
						This.Object.cd_tipodocto		[1]	= ivo_tipo_docto.Codigo
						This.Object.de_tipodocto		[1]	= ivo_tipo_docto.Descricao
					End If
				End If
			End If
		Case "de_tipodocto" 
			ivo_tipo_docto.of_Localiza(This.GetText(),lvl_Empresa)
			
			If ivo_tipo_docto.Localizado Then
				This.Object.id_tipodocto		[1]	= ivo_tipo_docto.ID
				This.Object.cd_tipodocto		[1]	= ivo_tipo_docto.Codigo
				This.Object.de_tipodocto		[1]	= ivo_tipo_docto.Descricao
				
				If Not IsNull(ivo_padrao_docto.ID) Then
					If ivo_tipo_docto.IDF_Padrao <> ivo_padrao_docto.ID Then
						ivo_padrao_docto.of_inicializa()
						
						This.Object.id_padraodocto		[1]	= ivo_padrao_docto.ID
						This.Object.nm_padraodocto	[1]	= ivo_padrao_docto.Descricao		
					End If
				End If
			End If
		Case "nm_filial" 
			lvs_filial =dw_1.GetText()
			ivo_filial.of_localiza_filial(lvs_filial)

			If ivo_filial.localizada Then
				
				Choose Case ivo_filial.cd_filial 
					Case 1 	   
						ivo_Filial.Cd_Filial = 100  /* ESTOQUE CENTRAL  */
					Case 534 	
						ivo_Filial.Cd_Filial = 100 /* ESTOQUE CENTRAL  */
					Case 2 		
						ivo_Filial.Cd_Filial = 534 /* MATRIZ E MANIP. JOINVILLE */
					Case 688	
						ivo_Filial.Cd_Filial = 534 // MATRIZ E MANIP. JOINVILLE
					Case 809 	
						ivo_Filial.Cd_Filial = 790 // FARMAGORA
					Case 695 	
						ivo_Filial.Cd_Filial = 149 //JOINVILLE_DE
					Case 696 	
						ivo_Filial.Cd_Filial = 84 //JARAGUA_DE
					Case 699
						ivo_Filial.Cd_Filial = 301 //DE_FLORIPA
					Case 700 	
						ivo_Filial.Cd_Filial = 136 //BLUMENAU_DE
					Case 701 	
						ivo_Filial.Cd_Filial = 107 //CRICIUMA_DE
					Case 704 	
						ivo_Filial.Cd_Filial = 71 //ITAJAI_DE
					Case 705 	
						ivo_Filial.Cd_Filial = 42 //LAGES_DE
					Case 708 	
						ivo_Filial.Cd_Filial = 550 //TUBAR$$HEX1$$c300$$ENDHEX$$O_DE
					Case 709 	
						ivo_Filial.Cd_Filial = 592 //BALNEARIO CAMBORIU_DE     
					Case 712 	
						ivo_Filial.Cd_Filial = 39 //CHAPECO_DE
					Case 733 	
						ivo_Filial.Cd_Filial = 330 //GASPAR_DE					
				End Choose 
						
				dw_1.Object.cd_filial[1]  = ivo_filial.cd_filial 
				dw_1.Object.nm_filial[1] = ivo_filial.nm_fantasia
			End If			
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge485_rel_doctos_nao_exportados_mult
integer y = 512
integer width = 5362
integer height = 1612
string dataobject = "dw_ge485_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial
Long lvl_Padrao
Long lvl_Empresa
Long lvl_Tipodocto
Long lvl_TotReg
Long lvl_Exportacao
Long lvl_filial_param_invalido

String lvs_dt_invalida
String lvs_Movto
String lvs_Ambiente_Sap
String lvs_Situacao
String lvs_tpdocto
String lvs_log
String lvs_log_cte
String lvs_Parametro

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

ivs_Parametros 	= {''}
ivs_filtro_relatorio = {''}

lvl_Filial 				= dw_1.Object.cd_filial						[1]
lvl_Tipodocto 		= dw_1.Object.id_tipodocto					[1]
lvl_Padrao 			= dw_1.Object.id_padraodocto				[1]
lvs_Movto 			= dw_1.Object.id_movimento				[1]  /* Entrada = '1' // Sa$$HEX1$$ed00$$ENDHEX$$da = '2'  */
lvdt_Inicio			= dw_1.Object.dt_inicio						[1]
lvdt_Fim				= dw_1.Object.dt_fim							[1]
lvl_Empresa			= dw_1.Object.cd_empresa					[1]
lvs_Ambiente_Sap = dw_1.Object.cd_ambiente_sap 			[1]
lvs_Situacao			= dw_1.Object.id_situacao 					[1]  /* T = Todas / S = Canceladas / N = N$$HEX1$$e300$$ENDHEX$$o Canceladas  */
lvl_Exportacao		= dw_1.Object.id_exporta 					[1]	  /* 0 = Integrado no SAP / 1 = N$$HEX1$$e300$$ENDHEX$$o Integrado SAP  / 2 = Todos */

lvs_log = " EXISTS (SELECT 1 FROM log_exportacao_docto l1 WHERE l1.id_docto = TO_CHAR(doc.id)  AND l1.cd_integracao = 'PADRAO'  AND l1.id_situacao_log = 'P') " 
lvs_log_cte = " EXISTS (SELECT 1 FROM log_exportacao_docto l1 WHERE l1.cd_filial = RETORNA_FILIAL_SYBASE(fil.codigo)	AND l1.cd_fornecedor = pjp.cnpj  AND l1.nr_nf = doc.nrodocto  AND TRIM(l1.de_especie) = TRIM(mod.codmodelo)  AND l1.de_serie = COALESCE(ser.codigo,'0')   AND l1.cd_integracao = 'CTE'   AND l1.id_situacao_log <> 'X') " 

//Valida par$$HEX1$$e200$$ENDHEX$$metros
If IsNull(lvdt_Inicio) or (lvdt_Inicio <= Date('2000/01/01')) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data de in$$HEX1$$ed00$$ENDHEX$$cio v$$HEX1$$e100$$ENDHEX$$lida", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If
	
If IsNull(lvdt_Fim) or (lvdt_Fim <= Date('2000/01/01')) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data de fim v$$HEX1$$e100$$ENDHEX$$lida", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_fim")
	Return -1
End If

If  lvdt_Fim < lvdt_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data Final deve ser Maior do que Data Inicial", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_fim")
	Return -1
End If

//Valida datas anteriores a limpeza do log
uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral
lvo_Parametro.of_localiza_parametro("DH_LIMPA_LOG_EXPORTACAO_DOCTO", ref lvs_Parametro)
Destroy(lvo_Parametro)

If lvdt_Inicio < Date(lvs_Parametro) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data do $$HEX1$$fa00$$ENDHEX$$ltimo expurgo do log de exporta$$HEX2$$e700e300$$ENDHEX$$o de documentos.~r~n~r~n$$HEX1$$da00$$ENDHEX$$ltimo expurgo em: '"+ lvs_Parametro +"'",Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If 
	
If DaysAfter(lvdt_Inicio,lvdt_Fim) > 31 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo informado $$HEX1$$e900$$ENDHEX$$ superior a 31 dias.~rEssa opera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ demorar v$$HEX1$$e100$$ENDHEX$$rias horas.~r~rDeseja continuar?", Exclamation!, YesNo!, 2) = 2 Then 
		dw_1.Event ue_Pos(1, "dt_fim")
		Return -1
	End If
End If	

If lvs_Ambiente_Sap = 'XXX' then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informar o Ambiente onde ser$$HEX1$$e300$$ENDHEX$$o verificadas as Exporta$$HEX2$$e700f500$$ENDHEX$$es.", Exclamation!)
	dw_1.Event ue_Pos(1, "cd_ambiente_sap")
	Return -1
End If	

// As datas de in$$HEX1$$ed00$$ENDHEX$$cio da opera$$HEX2$$e700e300$$ENDHEX$$o SAP devem estar no formato "DD/MM/YYYY".
If Not wf_Valida_Datas_Parametro(Ref lvl_filial_param_invalido, Ref lvs_dt_invalida) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe(m) filial(is) com o par$$HEX1$$e200$$ENDHEX$$metro DH_INICIO_OPERACAO_SAP com formato incorreto no banco Oracle.~rIsso pode ocasionar erros na consulta, favor verificar os par$$HEX1$$e200$$ENDHEX$$metros (Filial: "+String(lvl_filial_param_invalido)+", Par$$HEX1$$e200$$ENDHEX$$metro: "+lvs_dt_invalida+").~rFormato correto: 'DD/MM/YYYY'.~r~rSELECT cd_filial, vl_parametro FROM parametro_loja WHERE cd_parametro = 'DH_INICIO_OPERACAO_SAP' and LENGTH(vl_parametro) > 10", Exclamation!)
End If

// 

// Insere Filtro de Data
This.Of_AppendWhere_SubQuery( ("doc.dtentsai between TO_DATE('"+String(lvdt_Inicio,'dd/mm/yyyy')+"','DD/MM/YYYY') and TO_DATE('"+String(lvdt_fim,'dd/mm/yyyy')+"','DD/MM/YYYY')"),1)
ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio,'dd/mm/yyyy')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_fim,'dd/mm/yyyy')

This.Of_AppendWhere_SubQuery( ("fre.dataentrada between TO_DATE('"+String(lvdt_Inicio,'dd/mm/yyyy')+"','DD/MM/YYYY') and TO_DATE('"+String(lvdt_fim,'dd/mm/yyyy')+"','DD/MM/YYYY')"),3)

// Insere Filtro de Empresa
This.Of_AppendWhere_SubQuery( ("fil.idf_empresa = "+String(lvl_Empresa)),3)
This.Of_AppendWhere_SubQuery( ("fil.idf_empresa = "+String(lvl_Empresa)),1)

ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Empresa: '+String(lvl_Empresa)

// Filtro de Filial - 
If lvl_Filial > 0 Then
	This.Of_AppendWhere_SubQuery( ("fil.codigo = "+String(lvl_Filial)),1)
	This.Of_AppendWhere_SubQuery( ("fil.codigo = "+String(lvl_Filial)),3)
	ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Filial: '+dw_1.Object.nm_filial [1]+' ('+String(dw_1.Object.cd_filial [1])+')'
End If


If lvl_Padrao > 0 Then
	//Adiciona filtro no SQL
	This.of_Appendwhere_SubQuery(("tip.idf_padraodocto="+String(lvl_Padrao)),1)
     This.of_Appendwhere_SubQuery(("tip.idf_padraodocto="+String(lvl_Padrao)),3) /* Conhecimento de Frete */
	 ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Padr$$HEX1$$e300$$ENDHEX$$o Docto: '+dw_1.Object.nm_padraodocto [1]
else	
	This.Of_AppendWhere_SubQuery( ("tip.idf_padraodocto IN(61,62, 68,69,71, 66,67,70, 50,51, 52,53)"),1)
	This.Of_AppendWhere_SubQuery("tip.idf_padraodocto IN (40) ",3) /* Conhecimento de Frete */ 
	ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Padr$$HEX1$$e300$$ENDHEX$$o Docto: '+dw_1.Object.nm_padraodocto [1]
End If

// Insere Movimento
//If lvs_Movto <> "T" Then
//	This.of_Appendwhere("J.TIPOMOV="+lvs_Movto)
//	ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Tipo Mov.: '+dw_1.Describe("Evaluate('LookUpDisplay(id_movimento)',1)")
//End If

// Situa$$HEX2$$e700e300$$ENDHEX$$o T= Todas / 'S'= Canceladas // 'N' = N$$HEX1$$e300$$ENDHEX$$o Canceladas
If lvs_Situacao <> "T" Then
	If lvs_Situacao = 'S'  then /* Canceladas */
		This.Of_AppendWhere_SubQuery(("DOC.SITUACAONF = '1'"),1)
		This.Of_AppendWhere_SubQuery(("DOC.SITUACAONF = '1'"),3)
	else
		/* N$$HEX1$$e300$$ENDHEX$$o Canceladas */
		This.Of_AppendWhere_SubQuery(("DOC.SITUACAONF = '0'"),1)
		This.Of_AppendWhere_SubQuery(("DOC.SITUACAONF = '0'"),3)
	End if	 
	ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Situa$$HEX2$$e700e300$$ENDHEX$$o.: '+dw_1.Describe("Evaluate('LookUpDisplay(id_situacao)',1)")
End If


Choose Case lvl_Exportacao
	Case 0 // Documentos Integrados no SAP  
		// Insere query de LOG para  todos os tipos de Notas, exceto Fretes
		This.Of_AppendWhere(lvs_log, 1)
		
		// Insere Filtro de Ambiente
		This.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+lvs_Ambiente_Sap+"'"),2)
				
		// Insere query de LOG para  Conhecimento de Fretes 
		This.Of_AppendWhere(" NOT " + lvs_log_cte, 4)
		
		This.Of_AppendWhere_SubQuery("l1.id_tipo_docto = 'NCF'",5)
		ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Tipo Docto: '+dw_1.Object.de_tipodocto [1]
		
		// Insere Filtro de Ambiente - Query de Conhecimento de Fretes
		This.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+lvs_Ambiente_Sap+"'"),5)
		ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Ambiente: '+lvs_Ambiente_Sap

	Case 1 // Documentos  n$$HEX1$$e300$$ENDHEX$$o Integrados no SAP - Incluir NOT exist antes UNION e no Final
		// Insere query de LOG para  todos os tipos de Notas, exceto Fretes
		  This.Of_AppendWhere(" NOT " +lvs_log, 1)
		
		// Insere Filtro de Ambiente
		This.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+lvs_Ambiente_Sap+"'"),2)
		
		// Insere query de LOG para  Conhecimento de Fretes 
		This.Of_AppendWhere(lvs_log_cte, 4)
		
		This.Of_AppendWhere_SubQuery("l1.id_tipo_docto = 'NCF'",5)
		ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Tipo Docto: '+dw_1.Object.de_tipodocto [1]
		
		This.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+lvs_Ambiente_Sap+"'"),5)
		ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Ambiente: '+lvs_Ambiente_Sap
		
End Choose		

// Insere Filtro de Docto
If lvl_Tipodocto > 0 And lvl_Exportacao >= 0 Then
	Choose Case lvl_Tipodocto
		Case 51 // Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compra
			lvs_tpdocto = "NFD"
		Case 52,53 // Nota Fiscal de Compra
			lvs_tpdocto = "NFF"
		Case 66 // Nota Fiscal Remessa (Diversas)  - Saida
			lvs_tpdocto = "NDS"
		Case 68 // Notas Fiscais Remessa ( Diversas) -  Entrada
			lvs_tpdocto = "NDE"
		Case 61 // Nota Fiscal Transferencia  Entrada
			lvs_tpdocto = "NTE"
		Case 62 // Nota Fiscal Transfer$$HEX1$$ea00$$ENDHEX$$ncia Sa$$HEX1$$ed00$$ENDHEX$$da
			lvs_tpdocto = "NTS"
	End Choose
	
	If Trim(lvs_tpdocto) <> "" Then
		This.Of_AppendWhere_SubQuery("l1.id_tipo_docto = '" + lvs_tpdocto+"'",3)  /*Nota Fiscal Transferencia (Entrada)*/
		This.Of_AppendWhere_SubQuery("l1.id_tipo_docto = '" + lvs_tpdocto+"'",5) /* Query Union que trar$$HEX1$$e100$$ENDHEX$$ Frete */
			
		ivs_Parametros[UpperBound(ivs_Parametros) + 1] = 'Tipo Docto: '+dw_1.Object.de_tipodocto [1]
	End If
End If

// Atribuindo o texto do filtro de per$$HEX1$$ed00$$ENDHEX$$odo para exibi$$HEX2$$e700e300$$ENDHEX$$o no relat$$HEX1$$f300$$ENDHEX$$rio
This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo:'+ String(lvdt_Inicio,'DD/MM/YYYY')+ ' $$HEX1$$e000$$ENDHEX$$ ' + String(lvdt_Fim,'DD/MM/YYYY')  

lvs_tpdocto = This.GetSQLSelect()

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection( '', 'if( cancelada = "X", rgb(255, 0, 0), if( CurrentRow()=GetRow(), rgb(255,255,255), rgb(0,0,0) ))', False )

end event

event dw_2::getfocus;call super::getfocus;If This.RowCount() > 0 Then
	ivm_Menu.mf_SalvarComo(True)
Else
	ivm_Menu.mf_SalvarComo(False)
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;String lvs_Erro
ivm_Menu.mf_SalvarComo(pl_Linhas > 0)
ivm_menu.mf_imprimir(pl_Linhas > 0)

If Not wf_valida_cfop_tipodoc(ref lvs_Erro) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Erro, Exclamation!)
End If

This.ShareData(Parent.dw_3)

Return pl_Linhas

end event

event dw_2::ue_printimmediate;//Override
dw_2.Event ue_imprimir_relatorio(dw_2.Title, 'CL', True)

end event

event dw_2::ue_print;// Override
SetPointer(HourGlass!)

dw_2.Event ue_imprimir_relatorio(dw_2.Title, 'CL', False)

SetPointer(Arrow!)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge485_rel_doctos_nao_exportados_mult
integer x = 4224
integer y = 968
string dataobject = "dw_ge485_relatorio"
boolean ivb_ordena_colunas = true
end type

event dw_3::constructor;call super::constructor;This.Visible = False
end event

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Termino
		
// Verifica quais os par$$HEX1$$e200$$ENDHEX$$metros informados
Parent.dw_1.AcceptText()

lvdt_Inicio		= Parent.dw_1.Object.Dt_Inicio	 [1]
lvdt_Termino	= Parent.dw_1.Object.dt_fim	 [1]

This.Object.img_logo.Visible 	= (gvo_parametro.cd_filial = gvo_parametro.cd_filial_matriz)
This.Object.st_periodo.Text 	= "Per$$HEX1$$ed00$$ENDHEX$$odo: "+String(lvdt_Inicio,'dd/mm/yyyy')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Termino,'dd/mm/yyyy')

Return AncestorReturnValue
end event

event dw_3::ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type uo_1 from uo_data_atual within w_ge485_rel_doctos_nao_exportados_mult
integer x = 4992
integer y = 52
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_data_atual::destroy
end on

