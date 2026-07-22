HA$PBExportHeader$w_ge350_aprovar_retirada_estoque.srw
forward
global type w_ge350_aprovar_retirada_estoque from dc_w_cadastro_selecao_lista
end type
type dw_3 from dc_uo_dw_base within w_ge350_aprovar_retirada_estoque
end type
type st_confirmar from statictext within w_ge350_aprovar_retirada_estoque
end type
type cb_cancelar from commandbutton within w_ge350_aprovar_retirada_estoque
end type
type cb_inclui from commandbutton within w_ge350_aprovar_retirada_estoque
end type
type cb_aprov from commandbutton within w_ge350_aprovar_retirada_estoque
end type
type cb_reabastecimento from commandbutton within w_ge350_aprovar_retirada_estoque
end type
type dw_4 from dc_uo_dw_base within w_ge350_aprovar_retirada_estoque
end type
type cb_msg_logistica from commandbutton within w_ge350_aprovar_retirada_estoque
end type
type dw_5 from dc_uo_dw_base within w_ge350_aprovar_retirada_estoque
end type
type cb_aprov_venc from commandbutton within w_ge350_aprovar_retirada_estoque
end type
type cb_notas_transf from commandbutton within w_ge350_aprovar_retirada_estoque
end type
type cb_gerar_excel from commandbutton within w_ge350_aprovar_retirada_estoque
end type
type cb_1 from commandbutton within w_ge350_aprovar_retirada_estoque
end type
type gb_3 from groupbox within w_ge350_aprovar_retirada_estoque
end type
type str_tipos_avaria from structure within w_ge350_aprovar_retirada_estoque
end type
end forward

type str_tipos_avaria from structure
	string		id_tipo
	long		cd_msg
	string		de_orientacao
end type

global type w_ge350_aprovar_retirada_estoque from dc_w_cadastro_selecao_lista
integer width = 5339
integer height = 2588
string title = "GE350 - Aprovar Retirada de Estoque"
dw_3 dw_3
st_confirmar st_confirmar
cb_cancelar cb_cancelar
cb_inclui cb_inclui
cb_aprov cb_aprov
cb_reabastecimento cb_reabastecimento
dw_4 dw_4
cb_msg_logistica cb_msg_logistica
dw_5 dw_5
cb_aprov_venc cb_aprov_venc
cb_notas_transf cb_notas_transf
cb_gerar_excel cb_gerar_excel
cb_1 cb_1
gb_3 gb_3
end type
global w_ge350_aprovar_retirada_estoque w_ge350_aprovar_retirada_estoque

type variables
uo_filial io_Filial
dc_uo_ds_base ids_excel

uo_produto 	io_Produto

Boolean ivb_Check
DateTime idh_solicitacao
String ils_dw_avaria  = 'dw_ge350_lista_produtos_avaria'

Long il_selecionados

end variables

forward prototypes
public function boolean wf_usuario_possui_permissao (string as_tipo_retirada)
public subroutine wf_prepara_email ()
public function boolean wf_valida_qtde_vencimento (boolean ab_mostra_mensagem, long al_linha)
public subroutine wf_insere_retirada_default ()
public subroutine wf_gera_arquivo_excel ()
public function boolean wf_carrega_dados_nf (long al_filial_destino, long al_retirada, long al_produto, ref long al_nr_nf, ref date adt_emissao, ref double adb_valor_nf, ref string as_erro)
public subroutine wf_envia_email_avaria ()
public subroutine wf_monta_email_avaria (ref string as_texto_produtos)
public subroutine wf_configura_avaria (long al_linha_corrente, string as_tipo_avaria)
public function boolean wf_grava_registros_aprovados (long al_filial, long al_retirada, datetime adt_inicio, datetime adt_termino)
end prototypes

public function boolean wf_usuario_possui_permissao (string as_tipo_retirada);String	ls_Sistema,&
		ls_Matricula,&
		ls_Procedimento,&
		ls_Erro
		
Long	ll_Qtde		

ls_Sistema	=	gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
ls_Matricula	=	gvo_aplicacao.ivo_seguranca.nr_matricula

//No Homologa n$$HEX1$$e300$$ENDHEX$$o valida permiss$$HEX1$$e300$$ENDHEX$$o
If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

Choose Case as_Tipo_Retirada
	Case "E" //Excesso
		ls_Procedimento = "W_GE350_APROVA_RETIRADA_EXCESSO"
	Case "R" //Recolhimento
		ls_Procedimento = "W_GE350_APROVA_RETIRADA_RECOLHIMENTO"
	Case "V" //Vencido
		ls_Procedimento = "W_GE350_APROVA_RETIRADA_VENCIDO"
	Case "P" //Produtos Especiais
		ls_Procedimento = "W_GE350_APROVA_RETIRADA_PRD_ESPECIAIS"
	Case "A" //Avaria
		ls_Procedimento = "W_GE350_APROVA_RETIRADA_AVARIA"
	Case "D" //Defeito de Fabrica$$HEX2$$e700e300$$ENDHEX$$o
		ls_Procedimento = "W_GE350_APROVA_RETIRADA_DEFEITO_FABRI"
	Case "F" //Transfer$$HEX1$$ea00$$ENDHEX$$ncia SAF
		ls_Procedimento = "W_GE350_APROVA_TRANSFERENCIA_SAF"
	Case "S" //Autorizado SAF
		ls_Procedimento = "W_GE350_APROVA_AUTORIZADO_SAF"
End Choose

Select count(*)
Into	:ll_Qtde
From procedimento_sistema_usuario
Where	cd_sistema			= :ls_Sistema
	And	cd_procedimento	= :ls_Procedimento
	And	nr_matricula		= :ls_Matricula
Using SqlCA;	

Choose Case SqlCa.SqlCode
	Case 0	
		If ll_Qtde < 1 Then
			SqlCa.of_RollBack()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ liberado para manipular esse tipo de retirada.")		
			Return False
		End If
		
	Case 100
		
	Case -1
		ls_Erro = SqlCa.SQLErrText
		SqlCa.of_RollBack()
		MessageBox("Erro", "Erro ao verificar se o procedimento est$$HEX1$$e100$$ENDHEX$$ liberado para o usu$$HEX1$$e100$$ENDHEX$$rio: "+ ls_Erro)		
		Return False
End Choose

Return True
end function

public subroutine wf_prepara_email ();DateTime ldh_Inicio
DateTime ldh_Termino
DateTime ldh_Vencimento

Long ll_Filial
Long ll_Retirada

String ls_Tipo

dw_1.AcceptText()
dw_2.AcceptText()

ldh_Vencimento	= dw_1.Object.Dh_Vencimento_Minimo	[dw_1.GetRow()]
ldh_Inicio			= dw_2.Object.Dh_Inicio						[dw_2.GetRow()]
ldh_Termino		= dw_2.Object.Dh_Termino					[dw_2.GetRow()]
ls_Tipo				= dw_2.Object.Id_Tipo_Retirada			[dw_2.GetRow()]
ll_Retirada			= dw_2.Object.Nr_Retirada_Estoque		[dw_2.GetRow()]
ll_Filial				= dw_2.Object.Cd_Filial						[dw_2.GetRow()]


str_ge350_lista_email str
gf_ge350_Dados_Email(Ref str, ll_Filial, ll_Retirada, ldh_Inicio, ldh_Termino, ls_Tipo, ldh_Vencimento)
gf_ge350_Envia_Email(str, ls_Tipo, True)
end subroutine

public function boolean wf_valida_qtde_vencimento (boolean ab_mostra_mensagem, long al_linha);Long ll_Qt_Saldo_Filial
Long ll_Qt_Aprovada
Long ll_Qt_estoque_Base
Long ll_Qt_Promocao
Long ll_Qt_Planograma

dw_1.AcceptText()
dw_3.AcceptText()

ll_Qt_Saldo_Filial		= dw_3.Object.Saldo_Filial								[al_Linha]
ll_Qt_Aprovada			= dw_3.Object.Qt_Aprovada							[al_Linha]
ll_Qt_estoque_Base	= dw_3.Object.Qt_Estoque_Base						[al_Linha]
ll_Qt_Promocao		= dw_3.Object.qt_saldo_promocao					[al_Linha]
ll_Qt_Planograma		= dw_3.Object.qt_saldo_promocao_planograma	[al_Linha]

If ll_Qt_Promocao > ll_Qt_estoque_Base Then
	ll_Qt_estoque_Base = ll_Qt_Promocao
End If

If ll_Qt_Planograma > ll_Qt_estoque_Base Then
	ll_Qt_estoque_Base = ll_Qt_Planograma
End If

If (ll_Qt_Saldo_Filial - ll_Qt_Aprovada) < ll_Qt_estoque_Base Then
	If ab_Mostra_Mensagem Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto ser$$HEX1$$e100$$ENDHEX$$ reabastecido. ~rDeseja aprovar a retirada mesmo assim?", Question!, YesNo!, 2) = 2 Then
			Return False
		End If
		
		Return True
	Else
		Return False			
	End If
End If
end function

public subroutine wf_insere_retirada_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("id_tipo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "id_tipo", "T")
	lvdwc.SetItem(1, "de_tipo", "TODAS")
	
	dw_1.Object.Id_Tipo[1] = "T"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do tipo de retirada.")
End If
end subroutine

public subroutine wf_gera_arquivo_excel ();//Gera a planilha da DataStore selionada
//String lvs_Path,&
//		lvs_Arquivo
//
//Integer lvi_Retorno
//
//lvi_retorno = GetFileSaveName('Arquivo', lvs_Path, lvs_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')
//
//If lvi_retorno = 1 Then
//	 Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
//	If FileExists(lvs_Path) Then
//		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Path + "' existente ?", Question!, YesNo!, 1) =  1 Then 
//			If Not FileDelete(lvs_Path) Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Path + "'.", StopSign!)
//				Return
//			End If
//		Else
//			Return 
//		End If   
//	End If
//	Salva o  no formato Excel
//	If ids_Excel.SaveAs(lvs_Path, Excel!, True) = 1 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
//	Else
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
//	End If
//End If

//

String	lvs_Arquivo, &
		lvs_Diretorio, &
		lvs_Extensao

Integer lvi_Retorno


lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
										lvs_Diretorio, 	&
										lvs_Arquivo, 	&
										"XLS", 			&
										"Arquivos Excel (*.XLS),*.XLS,Arquivos Excel Formatado (*.XLS),*.XLSF" 	+ &
										",Arquivos Excel (*.XLSX),*.XLSX,Arquivos CSV (*.CSV),*.CSV"	+ &
										",Arquivos HTML (*.HTML),*.HTML" 		+ &
										",Arquivos Texto (*.TXT),*.TXT")
										
//																				",Arquivos PDF (*.PDF),*.PDF,Arquivos HTML (*.HTML),*.HTML" 		+ &

If lvi_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
	Return 
Else
	If lvi_Retorno = 0 Then Return
End If


lvs_Diretorio = Upper(lvs_Diretorio)
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

If (lvs_Extensao = 'XLS') or (lvs_Extensao = 'XLSF') then
	If ids_Excel.RowCount() > 65000 Then
		If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',	'Este relat$$HEX1$$f300$$ENDHEX$$rio excede o limite de 65.000 linhas do formato Excel (XLS).~r~n'+ &
											'O arquivo n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salvo neste formato.~r~n~r~n'+ &
											'Deseja selecionar outro formato?',Question!, YesNo!,1)=1 Then 
			wf_gera_arquivo_excel()
			Return
		Else
			Return
		End If
	End If
End If

Choose Case lvs_Extensao
	Case 'XLS'
		lvi_Retorno = ids_Excel.SaveAs(lvs_Diretorio, Excel8!, True)
	Case 'XLSX'
		lvi_Retorno = ids_Excel.SaveAs(lvs_Diretorio, XLSX!, True)
	Case 'CSV'
		//lvi_Retorno = This.SaveAs(lvs_Diretorio, CSV!, True,EncodingUTF8!)
		lvi_Retorno = ids_Excel.SaveAsFormattedText(lvs_Diretorio, EncodingANSI!, ";")
	Case 'PDF'
		//lvi_Retorno = This.SaveAs(lvs_Diretorio, PDF!, True)
//		lvi_Retorno = ids_Excel.of_Exporta_PDF(lvs_Diretorio)
	Case 'HTML'
		lvi_Retorno = ids_Excel.SaveAs(lvs_Diretorio, HTMLTable!, True)
	Case 'TXT'
		lvi_Retorno = ids_Excel.SaveAs(lvs_Diretorio, Text!, True,EncodingUTF8!)
	Case 'XLSF'
		Open(w_aguarde_1)
		w_aguarde_1.Title = 'Aguarde... Salvando...'
		w_aguarde_1.uo_progress.Of_SetMax(2)
		If ids_Excel.SaveAs( lvs_Diretorio, HTMLTable!, True ) = 1 Then
			w_aguarde_1.uo_progress.Of_SetProgress(1)
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
			w_aguarde_1.uo_progress.Of_SetProgress(2)
		Else
			lvi_Retorno = -1
		End If
		Close(w_aguarde_1)
End Choose

If lvi_Retorno <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + lvs_Diretorio + "'.", StopSign!)	
	Return 
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
End If
end subroutine

public function boolean wf_carrega_dados_nf (long al_filial_destino, long al_retirada, long al_produto, ref long al_nr_nf, ref date adt_emissao, ref double adb_valor_nf, ref string as_erro);String ls_Nr_Nf

SetNull(al_nr_nf)
SetNull(adt_emissao)
SetNull(adb_valor_nf)
SetNull(as_erro)

SELECT Distinct nr_nf
INTO :ls_Nr_Nf
FROM retirada_estoque_produto_lote
WHERE nr_retirada_estoque = :al_retirada
    AND cd_filial = :al_filial_destino
	AND cd_produto = :al_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_erro = "Erro ao localizar o numero da NF. " + SqlCa.SqlErrText
	Return False
End If

al_nr_nf = long(ls_Nr_Nf)

//N$$HEX1$$e300$$ENDHEX$$o encontrou informa$$HEX2$$e700e300$$ENDHEX$$o da nf, n$$HEX1$$e300$$ENDHEX$$o constar$$HEX1$$e100$$ENDHEX$$ no email
If IsNull(al_nr_nf) Then
	Return True
End If

SELECT
    a.dh_emissao, 
    a.vl_total_nf 
INTO
	:adt_emissao,
	:adb_valor_nf
FROM
    nf_transferencia a
    INNER JOIN item_nf_transferencia b ON a.cd_filial_origem = b.cd_filial_origem
                                          AND a.cd_filial_destino = b.cd_filial_destino
                                          AND a.nr_nf = b.nr_nf
                                          AND a.de_especie = b.de_especie
                                          AND a.de_serie = b.de_serie
WHERE
    a.cd_filial_destino = :al_filial_destino
    AND a.nr_nf = :al_nr_nf
    AND a.cd_filial_origem = 534
    AND b.cd_produto = :al_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_erro = "Erro ao obter data de emiss$$HEX1$$e300$$ENDHEX$$o e valor total da NF. " + SqlCa.SqlErrText
	Return False
End If

Return True
end function

public subroutine wf_envia_email_avaria ();//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

DateTime				ldh_solicitacao, &
						ldh_Envio

Long					ll_Filial,       &
						ll_Nro_Retirada, &
						ll_Linhas,       &
						ll_Linha,        &
						ll_Cod_Msg

String				ls_Texto_Email,       &
						ls_texto_produtos,    &
						ls_Texto_Email_Comum, &
						ls_Tipo_Retirada,     &
						ls_NmFantasia,        &
						ls_Situacao,          &
						ls_Situacao_Old,      &
						ls_EmailLoja

s_email				lstr_email	//ge202

str_tipos_avaria	lstr_avarias []

//PROCEDIMENTOS

lstr_avarias [1].id_tipo       = 'AE'
lstr_avarias [1].cd_msg        = 322
lstr_avarias [1].de_orientacao = '<BR>Favor realizar o procedimento a seguir:'                                     + &
											'<BR></BR>'                                                                       + &
											'<BR>Fazer a emiss$$HEX1$$e300$$ENDHEX$$o de nota de diversos contra a pr$$HEX1$$f300$$ENDHEX$$pria filial'                        + &
											'<BR><B>Tipo de perfil:</B> AVARIAS DIVERSAS E AVARIAS CONTROLADOS'                         + &
											'<BR><B>Natureza da Opera$$HEX2$$e700e300$$ENDHEX$$o:</B> REEMBOLSO - AVARIA DE PRODUTO'                         + &
											'<BR><B>Motivo:</B> PEQUENAS AVARIAS REC. EC'                             + &
											'<BR></BR>'                                                                       + &
											'<BR>Obs: Ap$$HEX1$$f300$$ENDHEX$$s fazer emiss$$HEX1$$e300$$ENDHEX$$o da nota de diversos, $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio deixar os '        + &
											'produtos separados juntamente com a nota e aguardar confer$$HEX1$$ea00$$ENDHEX$$ncia do Supervisor '  + &
											'regional ou Gerente regional.'                                                   + &
											'<BR></BR>'                                                                       + &
											'<BR>Ap$$HEX1$$f300$$ENDHEX$$s valida$$HEX2$$e700e300$$ENDHEX$$o e libera$$HEX2$$e700e300$$ENDHEX$$o pelo regional, OS PRODUTOS DEVER$$HEX1$$c300$$ENDHEX$$O SER '          + &
											'DESCARTADOS NA FILIAL e as notas fiscais dever$$HEX1$$e300$$ENDHEX$$o ficar arquivadas por um '       + &
											'PER$$HEX1$$cd00$$ENDHEX$$ODO DE 2 ANOS.'
lstr_avarias [2].id_tipo       = 'AT'
lstr_avarias [2].cd_msg        = 136
lstr_avarias [2].de_orientacao = '<BR>Favor realizar o procedimento a seguir:'                                     + &
											'<BR></BR>'                                                                       + &
											'<UL>'                                                                            + &
											'<LI>Fazer a emiss$$HEX1$$e300$$ENDHEX$$o de nota de diversos contra a pr$$HEX1$$f300$$ENDHEX$$pria filial.'                + &
											'<LI><B>Tipo de perfil:</B> AVARIAS TRANSPORTADORAS E AVARIAS CONTROLADOS'                  + &
											'<LI><B>Natureza da Opera$$HEX2$$e700e300$$ENDHEX$$o:</B> REEMBOLSO - AVARIA DE PRODUTO'                  + &
											'<LI><B>Motivo:</B> GRANDES AVARIAS REC. EC'                              + &
											'</UL>'                                                                           + &
											'<BR></BR>'                                                                       + &
											'Obs: Ap$$HEX1$$f300$$ENDHEX$$s fazer emiss$$HEX1$$e300$$ENDHEX$$o da nota de diversos, $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio deixar os produtos '   + &
											'separados juntamente com a nota e aguardar confer$$HEX1$$ea00$$ENDHEX$$ncia do Supervisor regional '  + &
											'ou Gerente regional.'                                                            + &
											'<BR></BR>'                                                                       + &
											'Ap$$HEX1$$f300$$ENDHEX$$s valida$$HEX2$$e700e300$$ENDHEX$$o e libera$$HEX2$$e700e300$$ENDHEX$$o pelo regional, seguir as orienta$$HEX2$$e700f500$$ENDHEX$$es abaixo:'         + &
											'<BR></BR>'                                                                       + &
											'Registrar o envio da mercadoria como volume na Intranet, anexar a etiqueta que ' + &
											'ser$$HEX1$$e100$$ENDHEX$$ gerada na parte externa da caixa, utilizar caixa de papel$$HEX1$$e300$$ENDHEX$$o e apenas um '   + &
											'volume e enviar a mercadoria danificada para o CD $$HEX1$$1320$$ENDHEX$$ Log$$HEX1$$ed00$$ENDHEX$$stica - GRANDE AVARIA '  + &
											'- A/C SEGREGADOS.'                                                               + &
											'<BR></BR>'                                                                       + &
											'Enviar juntamente com a mercadoria uma c$$HEX1$$f300$$ENDHEX$$pia da NF de origem (emitida do CD '    + &
											'para sua filial), c$$HEX1$$f300$$ENDHEX$$pia da NF diversas emitida e e-mail de autoriza$$HEX2$$e700e300$$ENDHEX$$o.'
lstr_avarias [3].id_tipo       = 'AL'
lstr_avarias [3].cd_msg        = 333
lstr_avarias [3].de_orientacao = '<BR>Favor realizar o procedimento a seguir:'                                     + &
											'<BR></BR>'                                                                       + &
											'<UL>'                                                                            + &
											'<LI>Fazer a emiss$$HEX1$$e300$$ENDHEX$$o de nota de diversos contra a pr$$HEX1$$f300$$ENDHEX$$pria filial.'                + &
											'<LI><B>Tipo de perfil:</B> AVARIAS LEITES $$HEX1$$1320$$ENDHEX$$ TRANSPORTE CLAMED'                  + &
											'<LI><B>Natureza da Opera$$HEX2$$e700e300$$ENDHEX$$o:</B> BAIXA ESTOQUE - AVARIADO'                  + &
											'<LI><B>Motivo:</B> AVARIAS LEITES'                              + &
											'</UL>'                                                                           + &
											'<BR></BR>'                                                                       + &											
											'Obs: Ap$$HEX1$$f300$$ENDHEX$$s fazer emiss$$HEX1$$e300$$ENDHEX$$o da nota de diversos, $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio deixar os produtos '   + &
											'separados juntamente com a nota e aguardar confer$$HEX1$$ea00$$ENDHEX$$ncia do Supervisor regional '  + &
											'ou Gerente regional.'                                                            + &
											'<BR></BR>'                                                                       + &
											'<BR>Ap$$HEX1$$f300$$ENDHEX$$s valida$$HEX2$$e700e300$$ENDHEX$$o e libera$$HEX2$$e700e300$$ENDHEX$$o pelo regional, OS PRODUTOS DEVER$$HEX1$$c300$$ENDHEX$$O SER '          + &
											'DESCARTADOS NA FILIAL e as notas fiscais dever$$HEX1$$e300$$ENDHEX$$o ficar arquivadas por um '       + &
											'PER$$HEX1$$cd00$$ENDHEX$$ODO DE 2 ANOS.'




If gvo_Aplicacao.ivs_DataSource <> 'central' then Return

dw_2.AcceptText ()
dw_3.AcceptText ()

ll_Linha         = dw_2.GetRow()
ll_Linhas        = dw_3.RowCount ()

ll_Filial        = dw_2.Object.Cd_Filial           [ll_Linha]
ls_NmFantasia    = dw_2.Object.Nm_Fantasia         [ll_Linha]
ll_Nro_Retirada  = dw_2.Object.Nr_Retirada_Estoque [ll_Linha]
ls_Tipo_Retirada = dw_2.Object.Id_Tipo_Retirada    [ll_Linha]
ls_Situacao      = dw_2.Object.id_situacao         [ll_Linha]
ls_Situacao_Old  = dw_2.Object.id_situacao_old     [ll_Linha]
ldh_solicitacao  = dw_2.Object.dh_inclusao         [ll_Linha]
ldh_Envio        = Datetime (String (Today (), 'dd/mm/yyyy hh:mm'))

ls_Texto_Email_Comum = '<HTML>'                                                                         + &
							  '<BODY>'                                                                         + &
							  '<BR>'                                                                           + &
							  '<TABLE border=0>'                                                               + &
							  '<TR>'                                                                           + &
							  '<TD><B>Tipo : AVARIA</B></TD>'                                                  + &
							  '</TR>'                                                                          + &
							  '<TR>'                                                                           + &
							  '<TD>Filial : ' + String (ll_Filial) + '-' + String (ls_NmFantasia) + '~n</TD> ' + &
							  '</TR>'                                                                          + &
							  '<TR>'                                                                           + &
							  '<TD>N$$HEX1$$fa00$$ENDHEX$$mero da retirada : '+ String (ll_Nro_Retirada) + '~n</TD> '               + &
							  '</TR>'                                                                          + &
							  '<TR>'                                                                           + &
							  '<TD>Data Solicita$$HEX2$$e700e300$$ENDHEX$$o Loja : ' + String (ldh_solicitacao) + '~n</TD> '           + &
							  '</TR>'                                                                          + &
							  '<TR>'                                                                           + &
							  '<TD>Data Envio Email : ' + String (ldh_Envio) + '~n</TD> '                      + &
							  '</TR>'                                                                          + &
							  '</TABLE><BR></BR>'                                                              + &
							  '<TABLE border = 1> '                                                            + &
							  "<TR bgcolor='#ffff66'> "                                                        + &
							  '<TD>C$$HEX1$$f300$$ENDHEX$$d.Produto</TD> '                                                          + &
							  '<TD>Descri$$HEX2$$e700e300$$ENDHEX$$o</TD> '                                                            + &
							  '<TD>Custo M.</TD> '                                                             + &
							  '<TD>Lote</TD> '                                                                 + &
							  '<TD>Controlado</TD> '                                                           + &
							  '<TD>Qt.Aprovada</TD> '                                                          + &
							  '<TD>Observa$$HEX2$$e700e300$$ENDHEX$$o</TD> '                                                           + &
							  '<TD>Tipo Avaria</TD> '                                                          + &
							  '<TD>NF Transf.Loja</TD> '                                                       + &
							  '<TD>Emiss$$HEX1$$e300$$ENDHEX$$o</TD> '                                                              + &
							  '<TD>Total NF</TD> '                                                             + &
							  '</TR>'

If ls_Tipo_Retirada = 'A' and ls_Situacao_Old = 'S' and ls_Situacao = 'A' then
   If ll_Linhas > 0 then
		dw_3.SetRedraw (False)
		
		For ll_Linha = 1 to UpperBound (lstr_avarias [])
			dw_3.SetFilter ("id_tipo_avaria = '" + lstr_avarias [ll_linha].id_tipo + "'")
			dw_3.Filter ()
			
			If dw_3.RowCount () > 0 then
				ll_Cod_Msg = lstr_avarias [ll_Linha].cd_msg
				
				wf_monta_email_avaria (Ref ls_texto_produtos)
				
				ls_Texto_Email = ls_Texto_Email_Comum                                                + &
									  ls_texto_produtos                                                   + &
									  '</TABLE>'                                                          + &
									  '<BR></BR>'                                                         + &
									  '<DIV>' + lstr_avarias [ll_Linha].de_orientacao + '~n</DIV>' + &
									  '</BODY>'                                                           + &
									  '</HTML>'
				
				lstr_email.ps_Mensagem = ls_Texto_Email
				
				//chamado 1542927 Verifica se ll_Cod_Msg $$HEX1$$e900$$ENDHEX$$ diferente de 135 antes de preencher ls_EmailLoja ( 135 o e-mail para o transportador que n$$HEX1$$e300$$ENDHEX$$o dever$$HEX1$$e100$$ENDHEX$$ ir para a filial)
				If ll_Cod_Msg <> 135 then
					If gvo_Aplicacao.ivs_DataSource = 'central' then
						ls_EmailLoja = String (ll_Filial, '0000') + '@clamedlocal.com.br'
						
						lstr_email.ps_to [1] = ls_EmailLoja
					End if
				End if
				
				lstr_email.pb_Assinatura = True
				gf_ge202_envia_email_padrao(ll_Cod_Msg, lstr_email)
				
				dw_3.SetFilter ('')
				dw_3.Filter ()
			End if
		Next
		
		dw_3.SetRedraw (True)
		
	End if
End if

If ll_Cod_Msg = 0 then
	wf_Prepara_Email ()
	Return
End if

Return
end subroutine

public subroutine wf_monta_email_avaria (ref string as_texto_produtos);Date		ldt_Emissao

Double	ldb_Vlr_Nota, &
			ldb_Custo

Long		ll_Linhas,     &
			ll_Linha,      &
			ll_QtAprovado, &
			ll_Produto,    &
			ll_NotaTransferencia

String	ls_Produto,     &
			ls_Lote,        &
			ls_Controlado,  &
			ls_Observacao,  &
			ls_Tipo_Avaria, &
			ls_Avaria,      &
			ls_Emissao,     &
			ls_Valor_Nf

as_texto_produtos = ''

ll_Linhas = dw_3.RowCount ()	// dw_3 est$$HEX1$$e100$$ENDHEX$$ filtrada pelo tipo de avaria

For ll_Linha=1 to ll_Linhas
	ll_Produto				= dw_3.Object.cd_produto     [ll_Linha]
	ls_Produto 				= dw_3.Object.de_produto     [ll_Linha]
	ls_Lote					= dw_3.Object.nr_lote        [ll_Linha]
	ls_Controlado			= dw_3.Object.controlado     [ll_Linha]
	ls_Observacao 			= dw_3.Object.de_observacao  [ll_Linha]
	ls_Tipo_Avaria 	   = dw_3.Object.id_tipo_avaria [ll_Linha]
	ls_Avaria            = dw_3.Object.de_tipo_avaria [ll_Linha]
	ll_QtAprovado			= dw_3.Object.qt_aprovada    [ll_Linha]
	ll_NotaTransferencia	= dw_3.Object.nr_nf          [ll_Linha]
	ldb_custo				= dw_3.Object.vl_custo_medio [ll_Linha]
	ldb_Vlr_Nota			= dw_3.Object.vl_total_nf    [ll_Linha]
	ldt_Emissao				= Date (dw_3.Object.dt_emissao_nf [ll_Linha])
	
	If ls_Tipo_Avaria <> '' and ll_QtAprovado > 0 then
		If ldb_Vlr_Nota = 0 or IsNull (ldb_Vlr_Nota) then
			ls_Valor_Nf = ''
		else
			ls_Valor_Nf = String (ldb_Vlr_Nota)
		End If
		
		If ldt_Emissao < Date ('2000-01-01') or IsNull (ldt_Emissao) then
			ls_Emissao = ''
		else
			ls_Emissao = String (ldt_Emissao, 'dd/mm/yyyy')
		End if
		
		as_texto_produtos += '<TR>'                                             + &
									'<TD>' + String (ll_Produto)           + '~n</TD>' + &
									'<TD>' + ls_Produto                    + '~n</TD>' + &
									'<TD>' + String (ldb_Custo)            + '~n</TD>' + &
									'<TD>' + ls_Lote                       + '~n</TD>' + &
									'<TD>' + ls_Controlado                 + '~n</TD>' + &
									'<TD>' + String (ll_QtAprovado)        + '~n</TD>' + &
									'<TD>' + ls_Observacao                 + '~n</TD>' + &
									'<TD>' + ls_Avaria                     + '~n</TD>' + &
									'<TD>' + String (ll_NotaTransferencia) + '~n</TD>' + &
									'<TD>' + ls_Emissao                    + '~n</TD>' + &
									'<TD>' + ls_Valor_Nf                   + '~n</TD>' + &
									'</TR>'
	End if
	
Next

Return
end subroutine

public subroutine wf_configura_avaria (long al_linha_corrente, string as_tipo_avaria);Long	ll_Linha, &
		ll_Linhas

ll_Linhas = dw_3.RowCount ()

For ll_Linha = 1 to ll_Linhas
	If ll_Linha = al_linha_corrente then
		Continue
	else
		If dw_3.Object.id_aprovar [ll_Linha] = 'S' then
			dw_3.Object.id_tipo_avaria [ll_Linha] = as_tipo_avaria
		End if
	End if
Next

Return
end subroutine

public function boolean wf_grava_registros_aprovados (long al_filial, long al_retirada, datetime adt_inicio, datetime adt_termino);Long ll_QtdLote, ll_Produto, ll_Quantidade, ll_Linhas, ll_Linha 
String ls_Lote, ls_Erro 

dc_uo_ds_base lds_registros
lds_registros = Create dc_uo_ds_base
		
If Not lds_registros.of_ChangeDataObject("ds_ge350_prd_retirada", False) Then
		Return False
End If 	
		

ll_Linhas  = lds_registros.retrieve(al_filial, al_retirada) 

If ll_Linhas > 0 Then 
	For ll_Linha  =  1 To ll_Linhas 
		ls_Lote		= lds_registros.object.nr_lote[ll_linha]
		ll_Produto 	= lds_registros.object.cd_produto[ll_Linha]
		ll_QtdLote 	= lds_registros.object.qt_lote[ll_Linha]

		//  Atualiza Produtos Lote 
		Update retirada_estoque_produto_lote  
		Set qt_aprovada  	=  qt_lote 
		Where cd_filial 		=:al_filial
		And nr_retirada_estoque 	=:al_retirada
		And cd_produto 			 	=:ll_Produto 
		and nr_lote						=:ls_Lote 
		Using SqlCA;		
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro na tabela RETIRADA_ESTOQUE_PRODUTO_LOTE. " + ls_Erro, StopSign!)
			Return False
		End If   
	Next  	


	// Atualiza os Produtos 
	Update  retirada_estoque_produto 
	Set     qt_aprovada  = qt_aprovada, 
	       	 de_observacao = 'Aprov.Automatica Tela'
	Where   cd_filial  = :al_filial
	And     nr_retirada_estoque =:al_retirada
	Using SqlCA;

	If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro na tabela RETIRADA_ESTOQUE_PRODUTO_LOTE. " + ls_Erro, StopSign!)
			Return False
	End If	
	
	Update retirada_estoque
		Set id_aprovado = 'S', 
		id_situacao  = 'A', 
		nr_matricula_aprovacao=:gvo_aplicacao.ivo_seguranca.nr_matricula,
		dh_aprovacao  = getdate() ,
		de_observacao  =   'Aprov.Automatica Tela', 
		dh_inicio=:adt_inicio,
		dh_termino=:adt_termino
	 Where cd_filial = :al_Filial
		And nr_retirada_estoque = :al_Retirada
	 Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro aprovado na tabela RETIRADA_ESTOQUE. " + ls_Erro, StopSign!)
		Return False
	End If
End If 	

Destroy (lds_registros) 

Return True 
end function

on w_ge350_aprovar_retirada_estoque.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.st_confirmar=create st_confirmar
this.cb_cancelar=create cb_cancelar
this.cb_inclui=create cb_inclui
this.cb_aprov=create cb_aprov
this.cb_reabastecimento=create cb_reabastecimento
this.dw_4=create dw_4
this.cb_msg_logistica=create cb_msg_logistica
this.dw_5=create dw_5
this.cb_aprov_venc=create cb_aprov_venc
this.cb_notas_transf=create cb_notas_transf
this.cb_gerar_excel=create cb_gerar_excel
this.cb_1=create cb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.st_confirmar
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.cb_inclui
this.Control[iCurrent+5]=this.cb_aprov
this.Control[iCurrent+6]=this.cb_reabastecimento
this.Control[iCurrent+7]=this.dw_4
this.Control[iCurrent+8]=this.cb_msg_logistica
this.Control[iCurrent+9]=this.dw_5
this.Control[iCurrent+10]=this.cb_aprov_venc
this.Control[iCurrent+11]=this.cb_notas_transf
this.Control[iCurrent+12]=this.cb_gerar_excel
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.gb_3
end on

on w_ge350_aprovar_retirada_estoque.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.st_confirmar)
destroy(this.cb_cancelar)
destroy(this.cb_inclui)
destroy(this.cb_aprov)
destroy(this.cb_reabastecimento)
destroy(this.dw_4)
destroy(this.cb_msg_logistica)
destroy(this.dw_5)
destroy(this.cb_aprov_venc)
destroy(this.cb_notas_transf)
destroy(this.cb_gerar_excel)
destroy(this.cb_1)
destroy(this.gb_3)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2, dw_3}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.Object.dh_inicio	[1]	= Date(RelativeDate(Date(gf_getserverdate()), -30))
dw_1.Object.dh_fim		[1]	= Date(gf_getserverdate())

This.ivm_Menu.mf_Incluir(False)

dw_1.Object.Id_Reabas_t.Visible = False
dw_1.Object.Id_Reabastecimento.Visible = False
dw_1.Object.Id_Reabastecimento[1] = "T"

cb_reabastecimento.Enabled = False
cb_aprov.Enabled = False
cb_msg_logistica.Enabled = False

cb_aprov_venc.Enabled = False
dw_2.Object.st_selecionado.Visible = False
dw_2.Object.Id_Selecionado.Visible = False

dw_1.Object.id_tipo_avaria.Visible = False
dw_1.Object.id_tipo_avaria [1] = 'T'

dw_5.Event ue_AddRow()

wf_Insere_Retirada_Default()

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "GF" Then
	dw_1.Object.Id_Situacao[1] = "A"
End If

///  Marca$$HEX2$$e700f500$$ENDHEX$$es da DataWindow Retiradas.
dw_2.Object.St_Selecionado.Visible = False
dw_2.Object.Id_Selecionado.Visible = False
cb_cancelar.Enabled = False
 	


dw_1.SetFocus()
end event

event close;call super::close;Destroy(io_Filial)
Destroy(ids_excel)
Destroy(io_Produto) 
end event

event open;call super::open;io_Filial = Create uo_filial
ids_excel = Create dc_uo_ds_base

io_Produto  =  Create uo_produto 

ivb_Check = False
il_selecionados = 0

end event

event ue_cancel;//OverRide

Long	ll_Linha_Dw2,&
		ll_Linha_Dw3

This.ivb_Valida_Salva = False

If dw_2.RowCount() > 0 Then
	ll_Linha_Dw2 = dw_2.GetRow()
End If

If dw_3.RowCount() > 0 Then
	ll_Linha_Dw3 = dw_3.GetRow()
End If

dw_3.Event ue_Cancel()
dw_2.Event ue_Cancel()

dw_2.SetRow(ll_Linha_Dw2)
dw_2.ScrollToRow(ll_Linha_Dw2)

dw_3.SetRow(ll_Linha_Dw3)
dw_3.ScrollToRow(ll_Linha_Dw3)

dw_2.SetFocus()

This.ivm_Menu.mf_Recuperar(True)

dw_1.Enabled			= True
end event

event ue_presave;//OverRide

DateTime	ldh_Inicio,&
			ldh_Termino	

Long	ll_Find,&
		ll_Find_1,&
		ll_Find_2,&
		ll_Linha,&
		ll_Linhas,&
		ll_Fator_Conversao,&
		ll_Qt_Aprovada,&
		ll_Qt_Saldo_Filial,&
		ll_Qt_Promocao,&
		ll_Qt_estoque_Base,&
		ll_Qt_Planograma,&
		ll_Produto,&
		ll_Filial,&
		ll_Nr_Retirada,&
		ll_Qt_Total_Aprovada, &
		ll_Total_Lotes
String	ls_Tipo_Retirada,&
			ls_Erro, &
			ls_prd_Selecionado, &
			ls_Lote, &
			ls_dw_avaria
Decimal	ldc_Resto_Divisao

Boolean lb_Sucesso  = True 

dw_2.AcceptText()
dw_3.AcceptText()
ls_dw_avaria = dw_3.Dataobject			

ldh_Inicio			= dw_2.Object.dh_inicio[dw_2.GetRow()]
ldh_Termino		= dw_2.Object.dh_termino[dw_2.GetRow()]
ls_Tipo_Retirada	= dw_2.Object.id_tipo_retirada[dw_2.GetRow()]
ll_Nr_Retirada		= dw_2.Object.nr_retirada_estoque[dw_2.GetRow()]

If Not wf_Usuario_Possui_Permissao(ls_Tipo_Retirada) Then
	Return False
End If

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da retirada.")
	dw_2.Event ue_Pos(dw_2.GetRow(), "dh_inicio")	
	Return False
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da retirada.")
	dw_2.Event ue_Pos(dw_2.GetRow(), "dh_termino")	
	Return False
End If

If ls_Tipo_Retirada<>'A' Then 	
	If ldh_Inicio < gvo_Parametro.of_Dh_Movimentacao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data corrente.")
		dw_2.Event ue_Pos(dw_2.GetRow(), "dh_inicio")	
		Return False
	End If
End If 

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da retirada n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da retirada.")
	dw_2.Event ue_Pos(dw_2.GetRow(), "dh_termino")	
	Return False
End If

//Verifica se tem algum produto com a quantidade aprovada menor do que zero
ll_Find = dw_3.Find("qt_aprovada < 0", 1, dw_3.RowCount())

If ll_Find < 0 Then
	MessageBox("Erro", "Erro ao verificar se tem algum produto com a quantidade aprovada menor do que zero.")
	dw_2.SetFocus()
	Return False
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe produto com a quantidade aprovada menor do que zero.")
	dw_3.Event ue_Pos(ll_Find, "qt_aprovada")	
	Return False
End If

//Verifica se tem algum produto com a quantidade aprovada maior do que a quantidade solicitada
ll_Find_1 = dw_3.Find("qt_aprovada > qt_solicitada", 1, dw_3.RowCount())

If ll_Find_1 < 0 Then
	MessageBox("Erro", "Erro ao verificar se tem algum produto com a quantidade aprovada maior do que a quantidade solicitada.")
	dw_2.SetFocus()
	Return False
End If

If ll_Find_1 > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe produto com a quantidade aprovada maior do que a quantidade solicitada.")
	dw_3.Event ue_Pos(ll_Find, "qt_aprovada")	
	Return False
End If


If il_selecionados = 0  Then 
	//Verifica se tem algum produto que n$$HEX1$$e300$$ENDHEX$$o foi informado a quantidade aprovada
	ll_Find_2 = dw_3.Find("(qt_aprovada <= 0)  or isnull(qt_aprovada)", 1,dw_3.RowCount() )

	If ll_Find_2 < 0 Then
		MessageBox("Erro", "Erro ao verificar se tem algum produto que n$$HEX1$$e300$$ENDHEX$$o foi informado a quantidade aprovada.")
		dw_2.SetFocus()
		Return False
	End If

	If ll_Find_2 > 0 Then	
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe produto que n$$HEX1$$e300$$ENDHEX$$o teve a quantidade aprovada informada.~rDeseja continuar?", Question!, yesNo!, 2) = 2 Then
			dw_3.Event ue_Pos(ll_Find_2, "qt_aprovada")	
			Return False
		End If	
	
		ll_Qt_Total_Aprovada = dw_3.Object.qt_total_aprovada		[dw_3.GetRow()]
	
		If ll_Qt_Total_Aprovada = 0 Then //Valida$$HEX2$$e700e300$$ENDHEX$$o criada pois estavam aprovando retiradas sem aprovar nenhum produto. Chamado	953238
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum lote teve quantidade aprovada maior que zero.", Exclamation!)
			dw_3.Event ue_Pos(ll_Find_2, "qt_aprovada")	
			Return False
		End If
	End If
	

	If ls_dw_avaria = ils_dw_avaria then
		//Verifica se tem algum produto aprovado sem indica$$HEX2$$e700e300$$ENDHEX$$o do tipo de avaria
		ll_Find_2 = dw_3.Find ("id_aprovar = 'S' AND (IsNull (id_tipo_avaria) OR Trim (id_tipo_avaria) = '')", 1, dw_3.RowCount())
	
		If ll_Find_2 > 0 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Tem produto aprovado sem informa$$HEX2$$e700e300$$ENDHEX$$o do tipo de avaria!')
			dw_3.Event ue_Pos (ll_Find_2, 'id_tipo_avaria')
			Return False
		End if
	End if
	

	dw_2.object.nr_matricula_aprovacao	[dw_2.getrow()] = gvo_aplicacao.ivo_seguranca.nr_matricula
	dw_2.object.dh_aprovacao				[dw_2.getrow()] = gf_GetServerDate()
	dw_2.object.id_situacao					[dw_2.getrow()] = "A"

	ll_Linhas = dw_3.RowCount()

	ll_Qt_Total_Aprovada	= 0

	For ll_Linha = 1 To ll_Linhas
		ls_prd_Selecionado   = dw_3.Object.id_aprovar						[ll_Linha]
			
		If ls_Prd_Selecionado = 'S' Then			
			ll_Fator_Conversao	= dw_3.Object.vl_fator_conversao				[ll_Linha]
			ll_Qt_Aprovada			= dw_3.Object.qt_aprovada						[ll_Linha]
			ll_Qt_Saldo_Filial	= dw_3.Object.saldo_filial						[ll_Linha]
			ll_Qt_Promocao			= dw_3.Object.qt_saldo_promocao				[ll_Linha]
			ll_Qt_estoque_Base	= dw_3.Object.qt_estoque_base					[ll_Linha]
			ll_Qt_Planograma		= dw_3.Object.qt_saldo_promocao_planograma[ll_Linha]
			ll_Produto				= dw_3.Object.cd_produto						[ll_Linha]
			ll_Filial				= dw_3.Object.cd_filial							[ll_Linha]		

			if IsNull(ll_Qt_Aprovada) then ll_Qt_Aprovada = 0
		
			If ll_Qt_Aprovada > 0 Then			
				ldc_Resto_Divisao = Mod(ll_Qt_Aprovada, ll_Fator_Conversao)
			
				If ldc_Resto_Divisao <> 0.00 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade aprovada do produto "+String(dw_3.Object.cd_produto[ll_Linha])+" - "+String(dw_3.Object.de_produto[ll_Linha])+" n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ divis$$HEX1$$ed00$$ENDHEX$$vel pelo fator de convers$$HEX1$$e300$$ENDHEX$$o.")
					dw_3.Event ue_Pos(ll_Linha, "qt_aprovada")	
					Return False
				End If
			
				If ls_Tipo_Retirada = "E" Then //Se for igual a Excesso
					If ll_Qt_Promocao > ll_Qt_estoque_Base Then
						ll_Qt_estoque_Base = ll_Qt_Promocao
					End If
				
					If ll_Qt_Planograma > ll_Qt_estoque_Base Then
						ll_Qt_estoque_Base = ll_Qt_Planograma
					End If
				
					If (ll_Qt_Saldo_Filial - ll_Qt_Aprovada) < ll_Qt_estoque_Base Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O saldo da filial menos a quantidade aprovada do produto "+String(dw_3.Object.cd_produto[ll_Linha])+" n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que o Estoque Base, Promo$$HEX2$$e700e300$$ENDHEX$$o ou Planograma.")
						dw_3.Event ue_Pos(ll_Linha, "qt_aprovada")
						Return False
					End If
				End If			
		Else
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade aprovada do produto [" + String(ll_Produto) + "] e lote [" + ls_Lote + "] est$$HEX1$$e100$$ENDHEX$$ zerada.~r~rInforme ao T.I.", Exclamation!)
				Return False
		End If
		
		//Atualiza produto_lote
		If ( ls_Tipo_Retirada = "R" Or ls_Tipo_Retirada = "A" Or ls_Tipo_Retirada = "D" Or ls_Tipo_Retirada = "V" ) Then //Recolhimento (agora chamado Recall) ou Avaria ou Defeito de Fabrica$$HEX2$$e700e300$$ENDHEX$$o / Vencido
			ls_Lote = dw_3.Object.nr_lote [ll_Linha]
			
			Update retirada_estoque_produto_lote
			Set qt_aprovada					= :ll_Qt_Aprovada				 
			Where	cd_filial					= :ll_Filial
				And	nr_retirada_estoque	= :ll_Nr_Retirada
				And	cd_produto				= :ll_Produto
				And 	nr_lote					= :ls_Lote
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SQLErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", "Erro ao atualizar a coluna 'qt_aprovada' da tabela 'retirada_estoque_produto_lote': "+ ls_Erro)		
				Return False
			End If
		End If
		
		if ll_Qt_Aprovada > 0 then
			ll_Qt_Total_Aprovada	= ll_Qt_Total_Aprovada + ll_Qt_Aprovada
		end if
		
		if ll_Qt_Total_Aprovada > 0 then
			if ll_linha < ll_Linhas then
				ll_find = dw_3.Find('cd_produto = ' + String(ll_Produto) + ' and id_aprovar = "S"', ll_linha + 1, ll_Linhas)
			end if
			
			if ll_find = 0 or ll_linha = ll_Linhas then
				Update retirada_estoque_produto
				Set qt_aprovada					= :ll_Qt_Total_Aprovada		 
				Where	cd_filial					= :ll_Filial
					And	nr_retirada_estoque	= :ll_Nr_Retirada
					And	cd_produto				= :ll_Produto
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = SqlCa.SQLErrText
					SqlCa.of_RollBack()
					MessageBox("Erro", "Erro ao atualizar a coluna 'qt_aprovada' da tabela 'retirada_estoque_produto': "+ ls_Erro)		
					Return False
				End If
				
				ll_Qt_Total_Aprovada	= 0
			end if
		end if
	End If
Next
	If Not gf_ge350_grava_cabecalho_aprovado(ll_Filial, ll_Nr_Retirada) then
		ls_Erro = SqlCa.SQLErrText
		SqlCa.of_RollBack()
		MessageBox("Erro", "Erro ao atualizar a retirada como aprovado: "+ ls_Erro)		
		Return False
	End if

	//Valida$$HEX2$$e700e300$$ENDHEX$$o para identificar as retiradas que ocasionalmente gravam sem quntidade aprovada no lote
	If ( ls_Tipo_Retirada = "R" Or ls_Tipo_Retirada = "A" Or ls_Tipo_Retirada = "D" Or ls_Tipo_Retirada = "V" ) Then
		Select Sum(Coalesce(qt_aprovada, 0))
		Into :ll_Total_Lotes
		From retirada_estoque_produto_lote
		Where cd_filial					= :ll_Filial
		And nr_retirada_estoque	= :ll_Nr_Retirada
		Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SQLErrText
			SqlCa.of_RollBack()
			MessageBox("Erro", "Erro ao consultar a coluna 'qt_aprovada' da tabela 'retirada_estoque_produto_lote': "+ ls_Erro)		
			Return False
		End If
	
		If ll_Total_Lotes = 0 Then
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade aprovada do lote est$$HEX1$$e100$$ENDHEX$$ zerada. Informe ao T.I.", Exclamation!)
			Return False
		End If
	End If
Else
	Try 
		If il_selecionados > 0 Then 	
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Voc$$HEX1$$ea00$$ENDHEX$$ esta Salvando a Todas as Retirada/Produtos/Lotes Respectivos..~rDeseja continuar?", Question!, yesNo!, 2) = 2 Then
				dw_2.Event ue_Pos(dw_2.GetRow(), "dh_termino")	
				Return False
			End If	
			
			For ll_Linha  = 1 To il_selecionados
				ll_Nr_Retirada											 = dw_2.Object.nr_retirada_estoque[ll_Linha]
				ll_Filial													=	dw_2.Object.cd_filial [ll_Linha]
				ldh_Inicio												= dw_2.Object.dh_inicio[ll_Linha]
				ldh_Termino											= dw_2.Object.dh_termino[ll_Linha]

				If IsNull(ldh_Inicio) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da retirada.")
					dw_2.Event ue_Pos(ll_Linha  , "dh_inicio")	
					Return False
				End If

				If IsNull(ldh_Termino) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da retirada.")
					dw_2.Event ue_Pos(ll_Linha, "dh_termino")	
					Return False
				End If

				If ls_Tipo_Retirada<>'A' Then 	
					If ldh_Inicio < gvo_Parametro.of_Dh_Movimentacao() Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data corrente.")
						dw_2.Event ue_Pos(ll_Linha , "dh_inicio")	
						Return False
					End If
				End If 

				If ldh_Inicio > ldh_Termino Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da retirada n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da retirada.")
					dw_2.Event ue_Pos(ll_Linha, "dh_termino")	
					Return False
				End If
		
				If Not wf_grava_registros_aprovados (ll_Filial, ll_Nr_Retirada, ldh_Inicio, ldh_Termino   ) Then 
					 ls_Erro = "Erro ao Atualizar Produtos e Lotes!"
					 lb_sucesso  = False
				 	 SQLCA.of_rollback()
				Else
					lb_sucesso  = True 
					SqlCa.of_Commit()
				End If 	
			   				  
			Next
			
		End If 	
	Catch (RunTimeError rte)
		 lb_sucesso  = False	
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', rte.GetMEssage(), StopSign!)	
	Finally
		If not lb_Sucesso then
			SqlCa.of_Rollback()
			If Trim (ls_Erro) <> '' then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro)
			End if
		Else
			dw_2.Event ue_Reset()
			dw_3.Event ue_Reset()
			dw_2.Event ue_Recuperar()
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Aprova$$HEX2$$e700e300$$ENDHEX$$o Registrada com Sucesso!")
			Return True 
		End If 		
	End Try
End If 	

Return True
end event

event ue_save;call super::ue_save;Long	ll_Retorno
String	ls_dw_avaria

Try

	This.ivm_Menu.mf_Recuperar(True)
	
	dw_1.Enabled			= True
	cb_cancelar.Enabled	= True
	ll_Retorno = AncestorReturnValue
	
	ls_dw_avaria			= dw_3.Dataobject			
	
	//ils_dw_avaria
	
	If ll_Retorno <> -1 Then
		
	If ls_dw_avaria<>ils_dw_avaria Then 
			wf_Prepara_Email()
		Else
			wf_envia_email_avaria()
	End If
	
		dw_2.Event ue_Reset()
		dw_3.Event ue_Reset()
	
		dw_2.Event ue_Recuperar()
	End If
	
	Return ll_Retorno
	
Catch (RunTimeError lo_error)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lo_error.GetMessage( ), StopSign!)
	Return -1
Finally
	
End Try
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge350_aprovar_retirada_estoque
integer x = 37
integer y = 668
integer height = 304
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge350_aprovar_retirada_estoque
integer y = 596
integer height = 392
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge350_aprovar_retirada_estoque
integer x = 46
integer y = 76
integer width = 5051
integer height = 248
string dataobject = "dw_ge350_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()
dw_5.Event ue_Reset()

dw_1.AcceptText()

dw_2.Object.St_Selecionado.Visible = False
dw_2.Object.Id_Selecionado.Visible = False
cb_cancelar.Enabled = False	

If dwo.Name = 'nm_fantasia' Then
	If Not IsNull(Data) and Trim(Data) <> '' Then
		If Data <> io_Filial.nm_fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.cd_filial	[1] = io_Filial.cd_filial
		This.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
	End If
End If


If dwo.Name = 'de_produto' Then
	If Not IsNull(Data) and Trim(Data)=  '' Then
		If Data=  io_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.cd_produto	[1] = io_Produto.cd_produto
		This.Object.de_produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If


//Bot$$HEX1$$e300$$ENDHEX$$o Gera Reabastecimento (.XLS)
If (dw_1.Object.Id_Tipo[1] = "V") And (dw_1.Object.Id_Situacao[1] = "S") Then
	dw_1.Object.Id_Reabas_t.Visible = True
	This.Object.Id_Reabastecimento.Visible = True
	cb_reabastecimento.Enabled = True
	
	cb_aprov_venc.Enabled = True
	dw_2.Object.St_Selecionado.Visible = True
	dw_2.Object.Id_Selecionado.Visible = True
Else
	dw_1.Object.Id_Reabas_t.Visible = False
	This.Object.Id_Reabastecimento.Visible = False
	This.Object.Id_Reabastecimento[1] = "T"
	cb_reabastecimento.Enabled = False
	
	cb_aprov_venc.Enabled = False
	dw_2.Object.St_Selecionado.Visible = False
	dw_2.Object.Id_Selecionado.Visible = False
	
	// Para Filtros : Avaria Aprovada
	If (dw_1.Object.Id_Tipo[1] = "A")   And  (dw_1.Object.Id_Situacao[1] = "A")   Then 
		dw_1.Object.id_tipo_avaria.Visible = True
	Else
		dw_1.Object.id_tipo_avaria.Visible = False
	End If 	
	
End If

//Bot$$HEX1$$e300$$ENDHEX$$o Aprov. Autom$$HEX1$$e100$$ENDHEX$$tica
If (dw_1.Object.Id_Tipo[1] = "R") And (dw_1.Object.Id_Situacao[1] = "S" Or dw_1.Object.Id_Situacao[1] = "A") Then
	cb_aprov.Enabled = True
Else
	cb_aprov.Enabled = False
End If

//Bot$$HEX1$$e300$$ENDHEX$$o Mensagem Log$$HEX1$$ed00$$ENDHEX$$stica
If dw_1.Object.Id_Tipo[1] = "P" Then
	If dw_1.Object.Id_Situacao[1] = "A" Then
		cb_msg_logistica.Enabled = True
	Else
		cb_msg_logistica.Enabled = False
	End If
Else
	cb_msg_logistica.Enabled = False
End If


/// Bot$$HEX1$$e300$$ENDHEX$$o de Marcar todos na Retirada:  Recall /Vencidos e Solicitado ou Aprovado 
If (dw_1.Object.Id_Tipo[1]= 'R' or dw_1.Object.Id_Tipo[1]= 'V')   Then 
	If (dw_1.Object.Id_Situacao[1] ="S"  or dw_1.Object.Id_Situacao[1]  = "A" )  Then 
		dw_2.Object.St_Selecionado.Visible = True
		dw_2.Object.Id_Selecionado.Visible = True
		cb_cancelar.Enabled = True	
	End If 
End If   

If (dw_1.Object.Id_Tipo[1]= 'A' or dw_1.Object.Id_Tipo[1]= 'D')   Then 
	If (dw_1.Object.Id_Situacao[1] ="S")  Then 		
		dw_2.Object.Id_Selecionado.Visible = True
		cb_cancelar.Enabled = True	
	End If 
End If   

If dw_1.Object.Id_Tipo [1]= 'S' or dw_1.Object.Id_Tipo [1] = 'F' then
	If dw_1.Object.Id_Situacao [1] = 'A' or dw_1.Object.Id_Situacao [1] = 'S' then
		dw_2.Object.St_Selecionado.Visible = True
		dw_2.Object.Id_Selecionado.Visible = True
		cb_cancelar.Enabled = True
	End if
End if

end event

event dw_1::losefocus;call super::losefocus;If IsValid(io_Filial) Then
	This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
	This.Object.Nm_Fantasia	[1] = io_Filial.nm_fantasia
End If




If IsValid(io_Produto) Then
	This.Object.cd_produto		[1] = io_produto.cd_produto 
	This.Object.de_produto		[1] = io_produto.ivs_Descricao_Apresentacao_Estoque
End If


end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	If lvs_Coluna = "nm_fantasia" Then
		
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If io_Filial.Localizada Then
			This.Object.cd_filial			[1] = io_Filial.cd_filial
			This.Object.nm_fantasia		[1] = io_Filial.nm_fantasia							
		End If
	End If
	
	
	If lvs_Coluna = "de_produto" Then
		
		io_Produto.of_Localiza_Produto(This.GetText())

		If io_Produto.Localizado Then
			This.Object.cd_produto			[1] = io_Produto.cd_produto
			This.Object.de_produto 			[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque							
		End If
	End If
	
	
End If



end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()
dw_5.Event ue_Reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge350_aprovar_retirada_estoque
integer y = 452
integer width = 5239
integer height = 696
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge350_aprovar_retirada_estoque
integer width = 5074
integer height = 340
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge350_aprovar_retirada_estoque
integer x = 46
integer y = 496
integer width = 5010
integer height = 644
string dataobject = "dw_ge350_lista"
end type

event dw_2::rowfocuschanged;call super::rowfocuschanged;String	ls_Situacao,&
		ls_Tipo_Retirada,&
		ls_Observacao
Long ll_Linhas
dw_2.AcceptText()

If currentRow > 0 Then
	ls_Situacao			= dw_2.Object.id_situacao		[currentrow]
	ls_Tipo_Retirada	= dw_2.Object.id_tipo_retirada	[currentrow]
	
	// Trecho Novo : Muda DW
	Choose Case ls_Tipo_Retirada
		Case "R","D", "F", "S", "V"
			If Not dw_3.of_ChangeDataObject("dw_ge350_lista_produtos_venc_recolhim") Then
				MessageBox("Erro", "Erro no ChangeDataObject da dw_ge350_lista_produtos_venc_recolhim")
				Return -1	
			End If
		Case "A"	
			If Not dw_3.of_ChangeDataObject("dw_ge350_lista_produtos_avaria") Then
			   MessageBox("Erro", "Erro no ChangeDataObject da dw_ge350_lista_produtos_avaria")
			   Return -1
			End If			
		Case Else
			If Not dw_3.of_ChangeDataObject("dw_ge350_lista_produtos") Then
				MessageBox("Erro", "Erro no ChangeDataObject da dw_ge350_lista_produtos")
				Return -1
			End If
	End Choose
		
	If ls_Situacao <> "S" Then //Solicitadao				
		dw_3.Modify("qt_aprovada.tabsequence=0")
		dw_3.Modify("id_aprovar.tabsequence=0")		
	else		
		dw_3.Modify("qt_aprovada.tabsequence=10")
		dw_3.Modify("id_aprovar.tabsequence=20")	
	End If
	
	// Somente Avaria e Solicitado : Lista Notas Transferencia: 
 	If  ls_Tipo_Retirada = 'A' and ls_Situacao='S'  Then 
		cb_notas_transf.Visible = True
		idh_solicitacao = dw_2.Object.dh_inclusao	[currentrow]      
	else
		cb_notas_transf.Visible = False
		SetNull(idh_solicitacao)
	End If	
	
	ls_Observacao = ''
	
	If Not IsNull(dw_2.Object.de_observacao[currentrow]) and Trim(dw_2.Object.de_observacao[currentrow]) <> '' Then
		ls_Observacao = 'OBS.: ' + dw_2.Object.de_observacao[currentrow]
	End If
	
	//Substitui "" (aspas duplas) por '' (aspas simples)
	ls_Observacao = gf_Replace(ls_Observacao, '"', "'", 0)
	
//	This.Object.t_Observacao.Text = ls_Observacao
//	This.Object.t_Msg_Logistica.Text = dw_2.Object.De_Mensagem_Logistica[dw_2.GetRow()]

	dw_5.Object.De_Mensagem_Logistica[1] = dw_2.Object.De_Mensagem_Logistica	[dw_2.GetRow()]
	dw_5.Object.De_Observacao			[1] = dw_2.Object.De_Observacao			[dw_2.GetRow()]	
	dw_5.Object.De_Mensagem_Logistica[1] = dw_2.Object.De_Mensagem_Logistica[dw_2.GetRow()]
		
	ll_Linhas = dw_3.Event ue_Recuperar()
	
	If ls_Tipo_Retirada = 'A' Then
		dw_3.Event ue_postretrieve(ll_Linhas)
	End If
	
End If

ivb_Check = False

Return 1
end event

event dw_2::ue_recuperar;//OverRide
DateTime	ldt_Inicio,&
				ldt_Fim

Long	ll_Filial, ll_Rota, ll_Produto  

String	ls_Situacao,&
		ls_Tipo, &
		ls_Reabast,&
		ls_Tipo_Avaria, &
		ls_TipoRota
	
dw_1.AcceptText()

ldt_Inicio		=	DateTime(dw_1.Object.dh_inicio	[1])
ldt_Fim		=	DateTime(dw_1.Object.dh_fim		[1])
ll_Filial		=	dw_1.Object.cd_filial					[1]
ls_Situacao	=	dw_1.Object.id_situacao				[1]
ls_Tipo		=	dw_1.Object.id_tipo					[1]
ls_Reabast	=	dw_1.Object.Id_Reabastecimento	[1]
ls_Tipo_Avaria = dw_1.Object.id_tipo_avaria	[1]
ls_TipoRota        = dw_1.Object.id_tipo_rota	[1]
ll_Rota				= dw_1.Object.nr_rota		[1]
ll_Produto 			= dw_1.Object.cd_produto 		[1]

If IsNull(ldt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")	
	Return 1
End If

If IsNull(ldt_Fim) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_fim")	
	Return 1
End If

If ldt_Inicio > ldt_Fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_fim")	
	Return 1
End If

If Not IsNull(ll_Filial) Then
	This.of_AppendWhere("a.cd_filial = "+String(ll_Filial))
End If

If ls_Situacao <> "T" Then
	This.of_AppendWhere("a.id_situacao = '"+ls_Situacao+"'")
End If

If ls_Tipo <> "T" Then
	This.of_AppendWhere("a.id_tipo_retirada= '"+ls_Tipo+"'")
End If

If Not IsNull(ll_Rota) And ll_Rota <> 0 Then
	This.of_AppendWhere("b.nr_rota_entrega = "+ String(ll_Rota))
End If

If ls_Tipo = "V" Then
	If ls_Reabast = "C" Then //Com reabastecimento
		This.of_AppendWhere("exists (select * from retirada_estoque x " +&
										"inner join retirada_estoque_produto y " +&
											"on y.cd_filial = x.cd_filial " +&
											"and y.nr_retirada_estoque = x.nr_retirada_estoque " +&
										"inner join vw_saldo_atual_produto v " +&
											"on v.cd_filial = y.cd_filial " +&
											"and v.cd_produto = y.cd_produto " +&
										"inner join resumo_reposicao_estoque r " +&
											"on r.cd_filial = y.cd_filial " +&
											"and r.cd_produto = y.cd_produto " +&
										"left outer join resumo_estoque_minimo_filial m " +& 	
											"on m.cd_filial = r.cd_filial " +& 	
											"and m.cd_produto = r.cd_produto " +&  
										"where x.cd_filial = a.cd_filial " +&
										  "and x.nr_retirada_estoque = a.nr_retirada_estoque " +&
										  "and (v.qt_saldo_final - y.qt_solicitada) < (CASE WHEN coalesce(m.qt_estoque_minimo, 0) > r.qt_estoque_base THEN m.qt_estoque_minimo ELSE r.qt_estoque_base END)	) ")
	End If
	
	If ls_Reabast = "S" Then //Sem reabastecimento
		This.of_AppendWhere("not exists (select * from retirada_estoque x " +&
										"inner join retirada_estoque_produto y " +&
											"on y.cd_filial = x.cd_filial " +&
											"and y.nr_retirada_estoque = x.nr_retirada_estoque " +&
										"inner join vw_saldo_atual_produto v " +&
											"on v.cd_filial = y.cd_filial " +&
											"and v.cd_produto = y.cd_produto " +&
										"inner join resumo_reposicao_estoque r " +&
											"on r.cd_filial = y.cd_filial " +&
											"and r.cd_produto = y.cd_produto " +&
										"left outer join resumo_estoque_minimo_filial m " +& 	
											"on m.cd_filial = r.cd_filial " +& 	
											"and m.cd_produto = r.cd_produto " +&  
										"where x.cd_filial = a.cd_filial " +&
										  "and x.nr_retirada_estoque = a.nr_retirada_estoque " +&
										  "and (v.qt_saldo_final - y.qt_solicitada) < (CASE WHEN coalesce(m.qt_estoque_minimo, 0) > r.qt_estoque_base THEN m.qt_estoque_minimo ELSE r.qt_estoque_base END)	) ")
	End If
End If



If ls_Tipo = "A"  Then 
	If ls_Tipo_Avaria = "T" Then 
		This.Of_AppendWhere ("  exists (  select *   " +&
									  "    from   retirada_estoque rte  "+&
									  "	 inner  join retirada_estoque_produto_lote rlte "+&
									  "	 on      rte.cd_filial = rlte.cd_filial   " +&
									  "	 and    rte.nr_retirada_estoque = rlte.nr_retirada_estoque " +&
									  "	 where  rte.cd_filial = a.cd_filial   " +&        
									  "	  and    rte.nr_retirada_estoque =  a.nr_retirada_estoque " +&
									  "	  ) " )		
	Else
		
		This.Of_AppendWhere ("  exists (  select *   " +&
											"    from   retirada_estoque rte  "+&
											"	 inner  join retirada_estoque_produto_lote rlte "+&
											"	 on      rte.cd_filial = rlte.cd_filial   " +&
											"	 and    rte.nr_retirada_estoque = rlte.nr_retirada_estoque " +&
											"	 where rte.cd_filial = a.cd_filial   " +&
											"	  and    rte.nr_retirada_estoque =  a.nr_retirada_estoque " +&
											"	  and     rlte.id_tipo_avaria =  '"  + ls_Tipo_Avaria +"')")		
	End If 
End If 

Choose case ls_tipoRota
		
	case 'P'	//Rota PR$$HEX1$$d300$$ENDHEX$$PRIA
		This.Of_AppendWhere ("re.cd_transportadora IS NULL")
		
	case 'T'	//Rota de TRANSPORTADORA
		This.Of_AppendWhere ("re.cd_transportadora IS NOT NULL")
		
	case 'A'	//Ambos os tipos de rota
		//lista todas, sem filtro
		
End choose


//// Filtro por Produto
If ll_Produto > 0   or  Not IsNull(ll_Produto) Then
	This.of_AppendWhere("  p.cd_produto  =  " + String(ll_Produto))  
End If

ldt_Inicio = DateTime(String(ldt_Inicio	, "dd/mm/yyyy 00:00:00"))
ldt_Fim	= DateTime(String(ldt_Fim		, "dd/mm/yyyy 23:59:59"))

Return This.Retrieve(ldt_Inicio, ldt_Fim)
end event

event dw_2::editchanged;call super::editchanged;
String	ls_Situacao

Choose Case This.GetColumnName() 	
	Case "dh_inicio"
		
		ls_Situacao	= dw_2.Object.id_situacao[row]
		
		If ls_Situacao <> "S" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente solicita$$HEX2$$e700e300$$ENDHEX$$oes com a situa$$HEX2$$e700e300$$ENDHEX$$o SOLICITADO podem ser alteradas.")
			dw_2.Object.dh_inicio[row] = dw_2.Object.dh_inicio_old[row]
			parent.event ue_cancel()
			Return 1
		End If
		
	Case "dh_termino"
		
		ls_Situacao	= dw_2.Object.id_situacao[row]
		
		If ls_Situacao <> "S" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente solicita$$HEX2$$e700e300$$ENDHEX$$oes com a situa$$HEX2$$e700e300$$ENDHEX$$o SOLICITADO podem ser alteradas.")
			dw_2.Object.dh_termino[row] = dw_2.Object.dh_termino_old[row]
			parent.event ue_cancel()
			Return 1
		End If	
End Choose

Parent.ivm_Menu.mf_Incluir(False)
Parent.ivm_Menu.mf_Excluir(False)
Parent.ivm_Menu.mf_Recuperar(False)
dw_1.Enabled			= False
end event

event dw_2::itemchanged;call super::itemchanged;String ls_Situacao 

Parent.ivm_Menu.mf_Incluir(False)
Parent.ivm_Menu.mf_Excluir(False)
Parent.ivm_Menu.mf_Recuperar(False)
dw_1.Enabled			= False
cb_cancelar.Enabled	= False


dw_1.AcceptText()
ls_Situacao  	=	dw_1.Object.id_situacao					[1]

If ls_Situacao = "A" or ls_Situacao  ="S"  Then 
	cb_cancelar.Enabled	= True
Else
	cb_cancelar.Enabled	= False
End If 	


end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Parent.ivm_Menu.mf_Excluir(False)

If pl_Linhas > 0 Then
	dw_5.Object.De_Mensagem_Logistica[1] =  dw_2.Object.De_Mensagem_Logistica	[1]
	dw_5.Object.De_Observacao			[1] =  dw_2.Object.De_Observacao				[1]
End If

Return pl_Linhas
end event

event dw_2::rowfocuschanging;call super::rowfocuschanging;If Not ivb_Valida_Salva Then Return 0

If wf_Valida_Salva() > 0 Then
	Return 0
Else
	Return 1
End If
end event

event dw_2::constructor;//OverRide

String lvs_DataObject

This.ivs_Coluna_Sem_Validacao_Salva = {"id_selecionado"}

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



ivi_Tipo_Cancelar = RETRIEVE

//ivb_Selecao_Linhas = True

This.of_SetRowSelection()
end event

event dw_2::getfocus;//OverRide

This.Post Event ue_SelectText()

This.of_Marca_Coluna_Ativa(This.GetColumnName())

Return 0
end event

event dw_2::ue_preupdate;call super::ue_preupdate;DateTime ldh_Vencimento

dw_1.AcceptText()

ldh_Vencimento = dw_1.Object.Dh_Vencimento_Minimo[1]

If Not IsNull(ldh_Vencimento) Then
	If ldh_Vencimento <= gvo_Parametro.of_Dh_Movimentacao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O vencimento m$$HEX1$$ed00$$ENDHEX$$nimo deve ser maior do que a data corrente.")
		Return -1
	End If
	
	dw_2.Object.Dh_Vencimento_Minimo[dw_2.GetRow()] = ldh_Vencimento
End If
end event

event dw_2::doubleclicked;call super::doubleclicked;Long ll_Linha , lvl_Row  
String ls_Retorno, lvs_Marcacao  
il_selecionados = 0 

str_ge350_datas std


If dw_2.RowCount() > 0 Then

	
	If dwo.Name = 'st_selecionado' Then
	
		If ivb_Check Then
			lvs_Marcacao = 'N'			
			ivb_Check = False
		Else
			lvs_Marcacao = 'S'			
			ivb_Check = True			
		End If
		
		If ivb_Check Then 
			OpenWithParm(w_ge350_datas_retiradas, std)
			std = Message.PowerObjectParm
		
			If IsNull(std.dh_inicio_data) Or IsNull(std.dh_fim_data) Then
				Return -1
			End If		
		End If 		
		
		
	

		
		For lvl_Row = 1 To This.RowCount()				
			This.Object.Id_Selecionado[lvl_Row] =  lvs_Marcacao		
			
			If lvs_Marcacao  = "S" Then 
				il_selecionados++	
				This.Object.dh_inicio[lvl_Row] 		    =  std.dh_inicio_data
				This.Object.dh_termino[lvl_Row]       =  std.dh_fim_data	
			Else 
				il_selecionados=0			
				This.Event ue_recuperar() 
			End if 							
		Next		
			
		
		Parent.ivm_Menu.mf_Incluir(False)
		Parent.ivm_Menu.mf_Excluir(False)
		Parent.ivm_Menu.mf_Recuperar(False)
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)
	End If
Else
	If dw_2.RowCount() = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum registro foi selecionado.")
		Return -1
	End If
	
End If 	



end event

event dw_2::buttonclicked;call super::buttonclicked;String lvs_Parametro
String lvs_Filial
String lvs_Nr_Retirada
String lvs_Situacao
String lvs_Tipo_Retirada 

SetPointer(HourGlass!)
lvs_Filial 				= Right("0000"+String(dw_2.Object.cd_filial[row]), 4)
lvs_Nr_Retirada 	= Right("000000"+String(dw_2.Object.nr_retirada_estoque[row]), 6)
lvs_Situacao			= String(dw_2.Object.id_situacao[row])
lvs_Tipo_Retirada  = String(dw_2.Object.id_tipo_retirada[row])
lvs_Parametro 		= lvs_Filial+lvs_Nr_Retirada+lvs_Situacao+lvs_Tipo_Retirada

OpenWithParm(w_ge350_observacao, lvs_Parametro)

end event

type dw_3 from dc_uo_dw_base within w_ge350_aprovar_retirada_estoque
event ue_mousemove pbm_mousemove
integer x = 73
integer y = 1420
integer width = 5198
integer height = 960
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge350_lista_produtos_venc_recolhim"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_mousemove;If This.RowCount() > 0 Then
	If ((xpos >= long(this.object.id_aprovar_t.x)) and (xpos <= (long(this.object.id_aprovar_t.x) + long(this.object.id_aprovar_t.Width)))) and 	((ypos >= long(this.object.id_aprovar_t.y)) and (ypos <= (long(this.object.id_aprovar_t.y) + long(this.object.id_aprovar_t.height)))) then
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
End If
end event

event ue_recuperar;//OverRide

Long	ll_Filial,&
		ll_Retirada,&
		ll_Linha
		
Date	ldt_Atual		
		
ll_Linha	= dw_2.GetRow()		
		
ll_Filial		= dw_2.Object.cd_filial					[ll_Linha]	
ll_Retirada	= dw_2.Object.nr_retirada_estoque	[ll_Linha]	
ldt_Atual		= Date(String(gf_GetServerDate(), "01/mm/yyyy"))

//If dw_2.Object.id_tipo_retirada	[ll_Linha]	 = 'V' and dw_1.Object.Id_Reabastecimento[1] = 'S' Then
//	This.of_appendwhere_subquery("(CASE WHEN coalesce(m.qt_estoque_minimo, 0) > d.qt_estoque_base THEN m.qt_estoque_minimo ELSE d.qt_estoque_base END) > 0 " +&
//								" and (c.qt_saldo_final - a.qt_solicitada) < (CASE WHEN coalesce(m.qt_estoque_minimo, 0) > d.qt_estoque_base THEN m.qt_estoque_minimo ELSE d.qt_estoque_base END) ", 3)
//End If 

Return This.Retrieve(ll_Filial, ll_Retirada, ldt_Atual)
end event

event itemchanged;call super::itemchanged;Long 		ll_Qt_Saldo_Filial
Long 		ll_Qt_Aprovada
Long 		ll_Qt_estoque_Base
Long 		ll_Qt_Planograma
Long 		ll_Qt_Promocao
Long		ll_nova_qt_aprovada
Long		ll_Find
String 	ls_dw_avaria
String	ls_id_aprovado
String 	ls_Tipo_Avaria


ls_dw_avaria = This.Dataobject	

If ls_dw_avaria = ils_dw_avaria Then
	ls_Tipo_Avaria = dw_3.Object.id_tipo_avaria [Row]	
End If 

This.AcceptText()
dw_1.AcceptText()

Parent.ivm_Menu.mf_Incluir(False)
Parent.ivm_Menu.mf_Excluir(False)
Parent.ivm_Menu.mf_Recuperar(False)
Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)

dw_1.Enabled			= False
cb_cancelar.Enabled	= False

Choose Case This.GetColumnName() 
	Case "qt_aprovada"
		ll_nova_qt_aprovada = Long(data)
		
		if ll_nova_qt_aprovada > 0 then
			This.Object.id_aprovar[row] = 'S'
			If ls_dw_avaria = ils_dw_avaria then
				This.Post Event ue_pos (row, 'id_tipo_avaria')
			End if
		else
			This.Object.id_aprovar[row] = 'N'
			If ls_dw_avaria = ils_dw_avaria then
				This.Object.id_tipo_avaria [Row] = ''
			End if
		end if
	Case "id_aprovar"
		If data = "S" Then			
			This.Object.qt_aprovada[Row] = This.Object.qt_solicitada[Row]
			If ls_dw_avaria = ils_dw_avaria then
				ll_Find = This.Find ("id_aprovar = 'S' and GetRow () <> " + String (row), 1, This.RowCount ())
				If ll_Find > 0 then
					This.Object.id_tipo_avaria [Row] = This.Object.id_tipo_avaria [ll_Find]
				else
					This.Post Event ue_pos (row, 'id_tipo_avaria')
				End if
			End if
		Else
			This.Object.qt_aprovada[Row] = 0

			If  ls_dw_avaria=ils_dw_avaria  Then
  		        This.Object.id_tipo_avaria [Row]=''
		    End If 		
		End If  	
		
	Case 'id_tipo_avaria'
		Post wf_configura_avaria (row, data)
		
End Choose
end event

event editchanged;call super::editchanged;Long	ll_Qtde,&
		ll_Qt_Solicitada	

Parent.ivm_Menu.mf_Incluir(False)
Parent.ivm_Menu.mf_Excluir(False)
Parent.ivm_Menu.mf_Recuperar(False)

Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)

dw_1.Enabled			= False
cb_cancelar.Enabled	= False

Choose Case This.GetColumnName() 	
	Case "qt_aprovada"
		ll_Qtde			= Long(data)
		ll_Qt_Solicitada	= This.Object.qt_solicitada[row]
		
		If ll_Qtde > ll_Qt_Solicitada Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A quantidade aprovada n$$HEX1$$e300$$ENDHEX$$o pode ser maior do qua a quantidade solicitada.")
			This.Event ue_Pos(row, "qt_aprovada")
			This.Object.qt_aprovada[ row ] = 0
			Return 1
		End If
		
		If ll_Qtde < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A quantidade aprovada n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que zero.")
			This.Event ue_Pos(row, "qt_aprovada")
			This.Object.qt_aprovada[ row ] = 0
			Return 1
		End If
End Choose


end event

event doubleclicked;call super::doubleclicked;Long ll_Row
	  
String	ls_Marcacao,&
		ls_Situacao,&
		ls_SituacaoGA,&
		ls_StatusGA
		
dw_1.AcceptText()
dw_2.AcceptText()
This.AcceptText()

Choose Case dwo.Name
	Case 'id_aprovar_t'
		ls_Situacao	= dw_2.Object.id_situacao[dw_2.getrow()]
		
		If ls_Situacao <> "S" Then //Solicitado
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente solicita$$HEX2$$e700f500$$ENDHEX$$es com a situa$$HEX2$$e700e300$$ENDHEX$$o SOLICITADO poder$$HEX1$$e300$$ENDHEX$$o alteradas.")
			st_confirmar.Visible = False
		Else
		
			If ivb_Check Then
				ls_Marcacao = 'N'
				ivb_Check = False
				st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos AVARIA."
			Else
				ls_Marcacao = 'S'
				ivb_Check = True
				st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos AVARIA."
			End If
			
			If This.RowCount() > 0 Then
				For ll_Row = 1 To This.RowCount()
							
					This.Object.id_aprovar[ll_Row] = ls_Marcacao
					
					If ls_Marcacao = "S" Then						
						This.Object.qt_aprovada[ll_Row] = This.Object.qt_solicitada[ll_Row]
						
//						If dw_1.Object.Id_Tipo[1] = "V" Then
//							If Not wf_Valida_Qtde_Vencimento(False, ll_Row) Then
//								This.Object.qt_aprovada[ll_Row] = 0
//								This.Object.Id_Aprovar[ll_Row] = "N"
//							End If
//						End If
					Else
						This.Object.qt_aprovada[ll_Row] = 0
					End If	
										
					//This.Event itemChanged(ll_Row, This.Object.qt_solicitada, String(This.Object.qt_aprovada[ll_Row]))
				Next
	
				Parent.ivm_Menu.mf_Incluir(False)
				Parent.ivm_Menu.mf_Excluir(False)
				Parent.ivm_Menu.mf_Recuperar(False)
				
				Parent.ivm_Menu.mf_Confirmar(True)
				Parent.ivm_Menu.mf_Cancelar(True)
				
				dw_1.Enabled			= False
				cb_cancelar.Enabled	= False
			End If			
		End If		
		
End Choose
end event

event ue_postretrieve;call super::ue_postretrieve;Long ll_Filial_Destino, ll_Retirada, ll_Produto, ll_Linha, ll_Linhas, ll_Nr_Nf
String ls_Erro, ls_Nr_Nf
Date ldt_Emissao, ldt_Nulo
Double ldb_Vlr_Nf, ldb_Nulo

SetNull(ldt_Nulo)
SetNull(ldb_Nulo)

If dw_2.Object.id_tipo_retirada	[dw_2.getrow()] = 'A' Then
	ll_Retirada 		= dw_2.Object.nr_retirada_estoque	[dw_2.getrow()]
	ll_Filial_Destino	= dw_2.Object.cd_filial					[dw_2.getrow()]

	ll_Linhas = dw_3.rowcount()
	For ll_Linha = 1 to ll_Linhas
		ll_Produto = dw_3.Object.cd_produto[ll_Linha]
		
		If Not wf_Carrega_Dados_Nf(ll_Filial_Destino, ll_Retirada, ll_Produto, Ref ll_Nr_Nf, Ref ldt_Emissao, Ref ldb_Vlr_Nf, Ref ls_Erro) Then
			//Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', ls_Erro)
			Return -1
		End If
		
		If ldb_Vlr_Nf = 0 Then
			ldb_Vlr_Nf = ldb_Nulo
		End If
		dw_3.Object.vl_total_nf[ll_Linha] = ldb_Vlr_Nf
		
		If ldt_Emissao < date('2022-01-01') Then
			ldt_Emissao = ldt_Nulo
		End If
		dw_3.Object.dt_emissao_nf	[ll_Linha] = string(ldt_Emissao, 'dd/mm/yyyy')
		
	Next
	
End If

Return pl_linhas
end event

type st_confirmar from statictext within w_ge350_aprovar_retirada_estoque
boolean visible = false
integer x = 2962
integer y = 1316
integer width = 951
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 134217752
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_ge350_aprovar_retirada_estoque
integer x = 658
integer y = 360
integer width = 562
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;String	ls_Matricula,&
		ls_Situacao,&
		ls_Tipo_Retirada,&
		ls_Erro,&
		ls_Marcado

Long	ll_Filial,&
		ll_Retirada,&
		ll_Linha,&
		ll_Linhas,&
		ll_Find
		
Boolean lb_Sucesso = False		

If dw_2.GetRow() < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhuma registro selecionado.")
	Return 1
End If

ls_Tipo_Retirada	= dw_2.Object.id_tipo_retirada	[dw_2.GetRow()]

If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja cancelar a solicita$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 2 Then
	Return 1
End If

If Not wf_Usuario_Possui_Permissao(ls_Tipo_Retirada) Then
	Return 1
End If

ls_Matricula	= gvo_aplicacao.ivo_seguranca.nr_matricula

ll_Linhas = dw_2.rowCount() 

ll_Find = dw_2.Find(" id_selecionado = 'S' ", 1,ll_Linhas)

Open(w_Aguarde)
w_aguarde.uo_progress.of_setmax(ll_Linhas)


Do Until ll_Find =  0
	
	ls_Marcado  = dw_2.Object.id_selecionado			[ll_Find]
	ls_Tipo_Retirada	= dw_2.Object.id_tipo_retirada	[ll_Find]
	ll_Filial		= dw_2.Object.cd_filial					[ll_Find]
	ll_Retirada	= dw_2.Object.nr_retirada_estoque	[ll_Find]
	ls_Situacao	= dw_2.Object.id_situacao				[ll_Find]		
		
	w_Aguarde.Title = "Cancelando Retirada: '" + String(ll_Retirada) 
		
	Update	retirada_estoque
	Set	id_situacao = 'X',
			nr_matricula_aprovacao =:ls_Matricula,
			de_observacao = 'RETIRADA CANCELADA'
	Where	cd_filial					=: ll_Filial
	and	nr_retirada_estoque	=: ll_Retirada
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SQLErrText
		SqlCa.of_RollBack()
		MessageBox("Erro", "Ocorreu um erro ao cancelar "+ ls_Erro)		
		lb_Sucesso  = False
		Return -1
	Else
		lb_Sucesso  = True 					
	End If 
	
	If ll_Find = ll_linhas Then
		ll_Find = 0 
	Else
		ll_Find = dw_2.Find(" id_selecionado = 'S' ",ll_Find + 1 ,ll_Linhas)
	End If 	

	w_aguarde.uo_progress.of_setprogress(ll_Linha)	
Loop 			

Close(w_Aguarde)

If lb_Sucesso Then
	SqlCa.of_Commit();
	dw_2.Event ue_Retrieve()
	dw_3.Reset()
	dw_3.Event ue_AddRow()
		
	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)
	dw_1.Enabled			= True
	ivm_Menu.mf_Recuperar(True)
	Else
		SqlCa.of_RollBack();
End If


Return 1


end event

type cb_inclui from commandbutton within w_ge350_aprovar_retirada_estoque
integer x = 32
integer y = 360
integer width = 617
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Incluir Ret. de Estoque"
end type

event clicked;OpenWithParm(w_ge350_inclui_retirada_via_planilha, "")
end event

type cb_aprov from commandbutton within w_ge350_aprovar_retirada_estoque
integer x = 2043
integer y = 360
integer width = 681
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Aprov. Autom$$HEX1$$e100$$ENDHEX$$tica Recall"
end type

event clicked;String ls_Retorno

dw_1.AcceptText()
dw_2.AcceptText()

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum registro foi selecionado.")
	Return -1
End If

If Not wf_Usuario_Possui_Permissao(dw_1.Object.Id_Tipo[1]) Then Return -1

OpenWithParm(w_ge350_aprova_recolhimento_autom, dw_2)

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_3.Event ue_Reset()
	dw_2.Event ue_Retrieve()
	dw_2.Event RowFocusChanged(dw_2.GetRow())
End If
end event

type cb_reabastecimento from commandbutton within w_ge350_aprovar_retirada_estoque
integer x = 1230
integer y = 360
integer width = 800
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gera Reabastecimento (.XLS)"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o da planilha com os produtos que v$$HEX1$$e300$$ENDHEX$$o gerar o reabastecimento ?", Question!, YesNo!, 2) = 2 Then Return


Open(w_Aguarde)

w_Aguarde.Title = "Gerando a planilha. Aguarde..."

dw_4.Reset()

dw_4.Event ue_Retrieve()

dw_4.Event ue_SaveAs()

Close(w_Aguarde)
end event

type dw_4 from dc_uo_dw_base within w_ge350_aprovar_retirada_estoque
boolean visible = false
integer x = 215
integer y = 580
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_ge350_produtos_problema"
end type

event ue_recuperar;//OverRide

DateTime ldh_Inicio
DateTime ldh_Termino
Long ll_Filial

dw_1.AcceptText()

ldh_Inicio	= DateTime(dw_1.Object.Dh_Inicio	[1])
ldh_Termino= DateTime(dw_1.Object.Dh_Fim		[1])
ll_Filial		= dw_1.Object.cd_filial[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")	
	Return 1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_fim")	
	Return 1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_fim")	
	Return 1
End If

If Not IsNull(ll_Filial) Then
	This.of_appendwhere_subquery("re.cd_filial = "+String(ll_Filial), 5)
End If

ldh_Inicio 	= DateTime(String(ldh_Inicio		, "dd/mm/yyyy 00:00:00"))
ldh_Termino= DateTime(String(ldh_Termino	, "dd/mm/yyyy 23:59:59"))

Return This.Retrieve(ldh_Inicio, ldh_Termino)
end event

type cb_msg_logistica from commandbutton within w_ge350_aprovar_retirada_estoque
integer x = 3410
integer y = 360
integer width = 544
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Mensagem Log$$HEX1$$ed00$$ENDHEX$$stica"
end type

event clicked;Long ll_Linha_Atual

String ls_Retorno

dw_1.AcceptText()
dw_2.AcceptText()

If dw_2.RowCount() =  0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma retirada foi selecionada.")
	Return -1
End If

If Not wf_Usuario_Possui_Permissao(dw_1.Object.Id_Tipo[1]) Then Return -1

str_ge350_dados_msg_logistica st

st.Cd_Filial						= dw_2.Object.Cd_Filial						[dw_2.GetRow()]
st.Nr_Retirada_Estoque		= dw_2.Object.Nr_Retirada_Estoque		[dw_2.GetRow()]
st.De_Mensagem_Logistica	= dw_2.Object.De_Mensagem_Logistica	[dw_2.GetRow()]

ll_Linha_Atual = dw_2.GetRow()

OpenWithParm(w_ge350_mensagem_logistica, st)

ls_Retorno = Message.StringParm

If IsNull(ls_Retorno) Then Return -1 //Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o avan$$HEX1$$e700$$ENDHEX$$ou para gravar o motivo do cancelamento

dw_2.Event ue_Retrieve()

If dw_2.RowCount() > 0 Then
	dw_2.Event ue_Pos(ll_Linha_Atual, "dh_inicio")
End If
end event

type dw_5 from dc_uo_dw_base within w_ge350_aprovar_retirada_estoque
integer x = 27
integer y = 1168
integer width = 4695
integer height = 180
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge350_dados_adicionais"
end type

type cb_aprov_venc from commandbutton within w_ge350_aprovar_retirada_estoque
integer x = 2734
integer y = 360
integer width = 667
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Aprov. Autom$$HEX1$$e100$$ENDHEX$$tica Venc."
end type

event clicked;Boolean lb_Sucesso = False

Date ldt_Atual

DateTime ldh_Vencimento_Minimo

Decimal ldc_Resto_Divisao

Long ll_Linha
Long ll_Find
Long ll_Filial
Long ll_Produto
Long ll_Retirada
Long ll_Qt_Aprov
Long ll_Linha_Ds
Long ll_Fator_Conversao

String ls_Selecionado
String ls_Nulo
String ls_Lote

dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()

str_ge350_lista_email st_email_nulo
str_ge350_lista_email st_email

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum registro foi selecionado.")
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica do tipo de retirada 'VENCIDO'?", Question!, YesNo!, 2) = 2 Then Return -1

If Not wf_Usuario_Possui_Permissao(dw_1.Object.Id_Tipo[1]) Then Return -1

ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
	Return -1
End If

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum retirada foi selecionada.")
	Return -1
End If

OpenWithParm(w_ge350_periodo_aprovacao_venc, "")

str_ge350_periodo_aprovacao st

st = Message.PowerObjectParm

If IsNull(st.Dh_Inicio) Or IsNull(st.Dh_Termino) Then
	Return -1
End If

ldt_Atual						= Date(String(gf_GetServerDate(), "01/mm/yyyy"))
ldh_Vencimento_Minimo = dw_1.Object.Dh_Vencimento_Minimo[1]

SetNull(ls_Nulo)

Try
		
	For ll_Linha = 1 To dw_2.RowCount()
		ls_Selecionado = dw_2.Object.Id_Selecionado[ll_Linha]
		
		If ls_Selecionado = "S" Then
			
			ll_Filial 		= dw_2.Object.Cd_Filial					[ll_Linha]
			ll_Retirada	= dw_2.Object.Nr_Retirada_Estoque	[ll_Linha]
			
			ll_Linha_Ds = dw_3.Retrieve(ll_Filial, ll_Retirada, ldt_Atual)
			
			If ll_Linha_Ds < 0 Then
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar informa$$HEX2$$e700f500$$ENDHEX$$es da dw_3.", StopSign!)
				lb_Sucesso = False
				Return -1
			End If
			
			If Not gf_ge350_Grava_Cabecalho(ll_Filial, ll_Retirada, st.Dh_Inicio, st.Dh_Termino, ldh_Vencimento_Minimo, false) Then Return -1
			
			For ll_Linha_Ds = 1 To dw_3.RowCount()						
				ll_Produto				= dw_3.Object.Cd_Produto				[ll_Linha_Ds]
				ll_Qt_Aprov				= dw_3.Object.Qt_Solicitada			[ll_Linha_Ds]
				ll_Fator_Conversao	= dw_3.Object.Vl_Fator_Conversao	[ll_Linha_Ds]
				ls_Lote					= dw_3.Object.nr_lote					[ll_Linha_Ds]	
				
				ldc_Resto_Divisao = Mod(ll_Qt_Aprov, ll_Fator_Conversao)
		
				If ldc_Resto_Divisao <> 0.00 Then
					SQLCA.of_rollback()
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade aprovada do produto " + String(dw_3.Object.Cd_Produto[ll_Linha_Ds]) + " - " + String(dw_3.Object.De_Produto[ll_Linha_Ds]) + " n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ divis$$HEX1$$ed00$$ENDHEX$$vel pelo fator de convers$$HEX1$$e300$$ENDHEX$$o.")
					dw_3.Event ue_Pos(ll_Linha_Ds, "qt_aprovada")
					lb_Sucesso = False
					Return -1
				End If
			
				If Not gf_ge350_Grava_Retirada_Produto('V', ll_Filial, ll_Retirada, ll_Produto, ls_Lote, ll_Qt_Aprov) Then
					lb_Sucesso = False
					Return -1
				End If
								
				lb_Sucesso = True
			Next
			
			If Not gf_ge350_Grava_Cabecalho_Aprovado(ll_Filial, ll_Retirada) Then Return -1
			
			gf_ge350_Dados_Email(Ref st_email, ll_Filial, ll_Retirada, st.Dh_Inicio, st.Dh_Termino, 'V', ldh_Vencimento_Minimo)
		End If
	Next
	
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit();
		dw_2.Event ue_Retrieve()
		dw_3.Reset()
		dw_3.Event ue_AddRow()
		
		
		Parent.ivm_Menu.mf_Confirmar(False)
		Parent.ivm_Menu.mf_Cancelar(False)
		
		dw_1.Enabled			= True
		cb_cancelar.Enabled	= True
		ivm_Menu.mf_Recuperar(True)
		
		gf_ge350_Envia_Email(st_email, 'V', False)
		st_email = st_email_nulo
	Else
		SqlCa.of_RollBack();
	End If
End Try
end event

type cb_notas_transf from commandbutton within w_ge350_aprovar_retirada_estoque
boolean visible = false
integer x = 4690
integer y = 1320
integer width = 343
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Listar Notas"
end type

event clicked;Long ll_Linha_Atual,&
	   ll_Nota
String ls_Parametro
Double ldb_Vlr_Nota
Date ldt_Emissao

dw_3.AcceptText()

If dw_3.Getrow( ) = 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma registro foi selecionada.")
	Return -1
End If 	

str_ge350_dados_notas_avaria st
st.cd_filial		= dw_3.Object.Cd_Filial						[dw_3.GetRow()]
st.nr_produto	= dw_3.Object.Cd_Produto					[dw_3.GetRow()]
st.nr_lote		= dw_3.Object.Nr_Lote						[dw_3.GetRow()]
st.dh_solicita	= idh_solicitacao

ll_Linha_Atual = dw_3.GetRow()


OpenWithParm(w_ge350_lista_notas_tranferencia, st)

//ll_Nota = Message.DoubleParm
//If IsNull(ll_Nota) then return 1 
//dw_3.Object.nr_nf			[dw_3.GetRow()]   = ll_Nota  

ls_Parametro = Message.StringParm

ll_Nota = Long(Left(ls_Parametro, (Pos(ls_Parametro, ';')-1) ))
If IsNull(ll_Nota) then return 1 

ldb_Vlr_Nota = Double(Mid(ls_Parametro, (Pos(ls_Parametro, ';')+1), ((LastPos(ls_Parametro, ';')-1) - Pos(ls_Parametro, ';') ) ))
If IsNull(ldb_Vlr_Nota) then return 1 

ldt_Emissao = Date(Mid(ls_Parametro, (LastPos(ls_Parametro, ';')+1)))
If IsNull(ldt_Emissao) then return 1 

dw_3.Object.nr_nf				[dw_3.GetRow()]   = ll_Nota  
dw_3.Object.vl_total_nf		[dw_3.GetRow()]   = ldb_Vlr_Nota  
dw_3.Object.dt_emissao_nf	[dw_3.GetRow()]   = string(ldt_Emissao, 'dd/mm/yyyy')  

end event

type cb_gerar_excel from commandbutton within w_ge350_aprovar_retirada_estoque
integer x = 3963
integer y = 360
integer width = 434
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exportar Excel"
end type

event clicked;Datetime ldh_Inicio,&
			ldh_Termino,&			
			ldh_Vencimento
			
Date ldt_Atual

String ls_Nome_DataStore,&
		ls_Situacao,&
		ls_TipoRetirada,&
		ls_TipoReabastecimento, &
		ls_Tipo_Avaria,&
		ls_TipoRota
	
Long   ll_Filial,&
		 ll_Retorno, ll_Rota, ll_Produto
		 
dw_1.AcceptText()

ldt_Atual		= Date(String(gf_GetServerDate(), "01/mm/yyyy"))
ldh_Inicio	= DateTime(dw_1.Object.dh_inicio	[1])
ldh_Termino= DateTime(dw_1.Object.dh_fim		[1])
ll_Filial						= dw_1.Object.cd_filial 						[1]	
ls_Situacao					= dw_1.Object.id_situacao					[1]
ls_TipoRetirada	 			= dw_1.Object.id_tipo						[1]
ls_TipoReabastecimento = dw_1.Object.id_reabastecimento		[1]
ls_Tipo_Avaria 				= dw_1.Object.id_tipo_avaria				[1]
ls_TipoRota        			= dw_1.Object.id_tipo_rota					[1]
ll_Rota						= dw_1.Object.nr_rota						[1]
ldh_Vencimento 			= dw_1.Object.dh_vencimento_minimo	[1]
ll_Produto 					= dw_1.Object.cd_produto 					[1]

ls_Nome_DataStore = 'dw_ge350_lista_dados_excel'

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")	
	Return 1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_fim")	
	Return 1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_fim")	
	Return 1
End If

If Not ids_Excel.of_ChangeDataObject(ls_Nome_DataStore) Then Return -1

//Colocar appendWhere se necess$$HEX1$$e100$$ENDHEX$$rio
If Not IsNull(ll_Filial) Then
	ids_Excel.of_appendwhere_SubQuery( "a.cd_filial = "+ String(ll_Filial), 2)
End If

If ls_Situacao <> "T" Then
	ids_Excel.of_AppendWhere_SubQuery("f.id_situacao = '"+ls_Situacao+"'", 2)
End If

If ls_TipoRetirada <> "T" Then
	ids_Excel.of_AppendWhere_SubQuery("f.id_tipo_retirada= '"+ls_TipoRetirada+"'", 2)
End If

If Not IsNull(ll_Rota) And ll_Rota <> 0 Then
	ids_Excel.of_AppendWhere_SubQuery("g.nr_rota_entrega = "+ String(ll_Rota), 2)
End If

If ls_TipoRetirada = "V" Then
	If ls_TipoReabastecimento = "C" Then //Com reabastecimento
		ids_Excel.of_AppendWhere_SubQuery("exists (select * from retirada_estoque x " +&
										"inner join retirada_estoque_produto y " +&
											"on y.cd_filial = x.cd_filial " +&
											"and y.nr_retirada_estoque = x.nr_retirada_estoque " +&
										"inner join vw_saldo_atual_produto v " +&
											"on v.cd_filial = y.cd_filial " +&
											"and v.cd_produto = y.cd_produto " +&
										"inner join resumo_reposicao_estoque r " +&
											"on r.cd_filial = y.cd_filial " +&
											"and r.cd_produto = y.cd_produto " +&
										"left outer join resumo_estoque_minimo_filial m " +& 	
											"on m.cd_filial = r.cd_filial " +& 	
											"and m.cd_produto = r.cd_produto " +&  
										"where x.cd_filial = a.cd_filial " +&
										  "and x.nr_retirada_estoque = a.nr_retirada_estoque " +&
										  "and (v.qt_saldo_final - y.qt_solicitada) < (CASE WHEN coalesce(m.qt_estoque_minimo, 0) > r.qt_estoque_base THEN m.qt_estoque_minimo ELSE r.qt_estoque_base END)	) ", 2)
	End If
	
	If ls_TipoReabastecimento = "S" Then //Sem reabastecimento
		ids_Excel.of_AppendWhere_SubQuery("not exists (select * from retirada_estoque x " +&
										"inner join retirada_estoque_produto y " +&
											"on y.cd_filial = x.cd_filial " +&
											"and y.nr_retirada_estoque = x.nr_retirada_estoque " +&
										"inner join vw_saldo_atual_produto v " +&
											"on v.cd_filial = y.cd_filial " +&
											"and v.cd_produto = y.cd_produto " +&
										"inner join resumo_reposicao_estoque r " +&
											"on r.cd_filial = y.cd_filial " +&
											"and r.cd_produto = y.cd_produto " +&
										"left outer join resumo_estoque_minimo_filial m " +& 	
											"on m.cd_filial = r.cd_filial " +& 	
											"and m.cd_produto = r.cd_produto " +&  
										"where x.cd_filial = a.cd_filial " +&
										  "and x.nr_retirada_estoque = a.nr_retirada_estoque " +&
										  "and (v.qt_saldo_final - y.qt_solicitada) < (CASE WHEN coalesce(m.qt_estoque_minimo, 0) > r.qt_estoque_base THEN m.qt_estoque_minimo ELSE r.qt_estoque_base END)	) ", 2)
	End If 
End If

If ls_TipoRetirada = "A"  Then 
	If ls_Tipo_Avaria = "T" Then 
		ids_Excel.Of_AppendWhere_SubQuery ("  exists (  select *   " +&
									  "    from   retirada_estoque rte  "+&
									  "	 inner  join retirada_estoque_produto_lote rlte "+&
									  "	 on      rte.cd_filial = rlte.cd_filial   " +&
									  "	 and    rte.nr_retirada_estoque = rlte.nr_retirada_estoque " +&
									  "	 where  rte.cd_filial = f.cd_filial   " +&        
									  "	  and    rte.nr_retirada_estoque =  f.nr_retirada_estoque " +&
									  "	  ) ", 2)		
	Else
		
		ids_Excel.Of_AppendWhere_SubQuery ("  exists (  select *   " +&
											"    from   retirada_estoque rte  "+&
											"	 inner  join retirada_estoque_produto_lote rlte "+&
											"	 on      rte.cd_filial = rlte.cd_filial   " +&
											"	 and    rte.nr_retirada_estoque = rlte.nr_retirada_estoque " +&
											"	 where rte.cd_filial = f.cd_filial   " +&
											"	  and    rte.nr_retirada_estoque =  f.nr_retirada_estoque " +&
											"	  and     rlte.id_tipo_avaria =  '"  + ls_Tipo_Avaria +"')", 2)
	End If 
End If 


Choose case ls_tipoRota
	case 'P'	//Rota PR$$HEX1$$d300$$ENDHEX$$PRIA
		ids_Excel.of_AppendWhere_SubQuery("re.cd_transportadora IS NULL", 2)
		
	case 'T'	//Rota de TRANSPORTADORA
		ids_Excel.of_AppendWhere_SubQuery("re.cd_transportadora IS NOT NULL", 2)
		
	case 'A'	//Ambos os tipos de rota
		//lista todas, sem filtro
		
End choose

If ll_Produto > 0   or  Not IsNull(ll_Produto) Then
	ids_Excel.of_AppendWhere_SubQuery("  a.cd_produto  =  " + String(ll_Produto), 2) 
End If

ldh_Inicio = DateTime(String(ldh_Inicio	, "dd/mm/yyyy 00:00:00"))
ldh_Termino	= DateTime(String(ldh_Termino, "dd/mm/yyyy 23:59:59"))

ids_Excel.Retrieve(ldh_Inicio, ldh_Termino, ldt_Atual )

//Chama a fun$$HEX2$$e700e300$$ENDHEX$$o para salvar em excel
wf_gera_arquivo_excel()

Return ll_Retorno
end event

type cb_1 from commandbutton within w_ge350_aprovar_retirada_estoque
integer x = 4402
integer y = 360
integer width = 334
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Ret. SAF"
end type

event clicked;String ls_Matricula

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "W_GE350_INCLUI_RETIRADA_SAF", Ref ls_Matricula ) Then 
	Return -1
End If

OpenWithParm(w_ge350_cadastra_retirada_saf, "")
end event

type gb_3 from groupbox within w_ge350_aprovar_retirada_estoque
integer x = 37
integer y = 1352
integer width = 5243
integer height = 1044
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

