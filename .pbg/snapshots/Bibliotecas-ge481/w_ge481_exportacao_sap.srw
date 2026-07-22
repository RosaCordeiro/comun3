HA$PBExportHeader$w_ge481_exportacao_sap.srw
forward
global type w_ge481_exportacao_sap from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge481_exportacao_sap
end type
end forward

global type w_ge481_exportacao_sap from dc_w_response_ok_cancela
integer width = 2866
integer height = 1528
string title = "GE481 - EXPORTACAO/IMPORTACAO SAP"
dw_2 dw_2
end type
global w_ge481_exportacao_sap w_ge481_exportacao_sap

type variables
Boolean	ib_checked_all = true
String ivs_cd_sistema
String is_exp_auto
end variables

forward prototypes
public function boolean wf_grava_log (string ps_tipo, long pl_cd_tabela, ref long pl_nr_sequencial)
end prototypes

public function boolean wf_grava_log (string ps_tipo, long pl_cd_tabela, ref long pl_nr_sequencial);long ll_nr_sequencial
string ls_erro

If ps_tipo = 'I' Then
	
	Insert into log_execucao_interface(nr_sequencial, cd_tabela, dh_inicio)
	Select coalesce(max(nr_sequencial),1) + 1, :pl_cd_tabela, getdate()
	from log_execucao_interface;

	if sqlca.sqlcode = -1 then 
		ls_erro = sqlca.sqlerrtext
		Rollback;
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao inserir registro na tabela "log_execucao_interface": ' + ls_erro)
		return false
	end if

	Select l1.nr_sequencial
	into :ll_nr_sequencial
	from log_execucao_interface l1
	where l1.cd_tabela = :pl_cd_tabela 
	and l1.dh_termino is null
	and l1.dh_inicio = (Select max(l2.dh_inicio) from log_execucao_interface l2 where l2.cd_tabela = l1.cd_tabela and l2.dh_termino is null); 
	
	if sqlca.sqlcode = -1 then 
		ls_erro = sqlca.sqlerrtext
		Rollback;
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar registro na tabela "log_execucao_interface": ' + ls_erro)
		return false
	end if

	pl_nr_sequencial = ll_nr_sequencial
	
elseif ps_tipo = 'T' Then
	
	Update log_execucao_interface
	set dh_termino = getdate()
	where nr_sequencial = :pl_nr_sequencial;
	
	if sqlca.sqlcode = -1 then 
		ls_erro = sqlca.sqlerrtext
		Rollback;
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao atualizar a tabela "log_execucao_interface": ' + ls_erro)
		return false
	end if
	
end if

Commit;

return true
end function

on w_ge481_exportacao_sap.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_ge481_exportacao_sap.destroy
call super::destroy
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;string ls_Ambiente_SAP, ls_situacao
long ll_for, ll_cd_tabela

ivs_cd_sistema  = gvo_Aplicacao.ivo_seguranca.cd_sistema

If ivs_cd_sistema <> 'EX' and ivs_cd_sistema <> 'WS' and ivs_cd_sistema <> 'ES' Then 
	dw_1.of_appendwhere( "  t.cd_sistema = '" + ivs_cd_sistema + "'" )
	dw_1.of_appendwhere( "  t.id_subida_descida = 'S' " )
End If 

ls_Ambiente_SAP = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Configuracao", "AmbienteSap", "")

dw_2.insertrow( 1 )

if ls_Ambiente_SAP <> '' and not isnull(ls_Ambiente_SAP) Then
	
	Select id_situacao
	into :ls_situacao
	from ambiente_sap
	where cd_ambiente_sap = :ls_Ambiente_SAP;
	
	if sqlca.sqlcode = -1 then 
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela "ambiente_sap": ' + sqlca.sqlerrtext)
		return 
	end if
	
	if ls_situacao = 'A' Then
		dw_2.object.cd_ambiente_sap[1] = ls_ambiente_sap
	end if

end if

If is_exp_auto <> '' and not isnull(is_exp_auto) Then

	Choose Case is_exp_auto 
		Case 'EXPS'
			if gvb_auto Then
				dw_1.of_appendwhere( " t.id_execucao_individual = 'N' " )
			end if
			
			dw_1.Event ue_AddRow()
			dw_1.Event ue_Recuperar()

			dw_1.setfilter('id_subida_descida = "S" ')			
			
		Case 'EXPD'	
			if gvb_auto Then
				dw_1.of_appendwhere( " t.id_execucao_individual = 'N' " )
			end if
			
			dw_1.Event ue_AddRow()
			dw_1.Event ue_Recuperar()
			
			dw_1.setfilter('id_subida_descida = "D" ')
			
		Case 'J1BTAXDESC'
			dw_1.of_appendwhere( " t.cd_tabela in (113,114,115,116,117,118) " )
			
			dw_1.Event ue_AddRow()
			dw_1.Event ue_Recuperar()
			
		Case 'J1BTAXSUBIDA'
			dw_1.of_appendwhere( " t.cd_tabela in (140,141,142,143,144,145) " )
			
			dw_1.Event ue_AddRow()
			dw_1.Event ue_Recuperar()
		
		Case 'DOCNUM'
			dw_1.of_appendwhere( " t.cd_tabela in (73) " )
	
			dw_1.Event ue_AddRow()
			dw_1.Event ue_Recuperar()
			
		Case 'MVTOEST'
			dw_1.of_appendwhere( " t.cd_tabela in (102) " )
	
			dw_1.Event ue_AddRow()
			dw_1.Event ue_Recuperar()
			
		Case 'NFSAP'
			dw_1.of_appendwhere( " t.cd_tabela in (97) " )
	
			dw_1.Event ue_AddRow()
			dw_1.Event ue_Recuperar()
			
		Case 'SLP'
			dw_1.of_appendwhere( " t.cd_tabela in (148) " )
	
			dw_1.Event ue_AddRow()
			dw_1.Event ue_Recuperar()
			
		Case 'RNFL'
			if gvb_auto Then
				dw_1.of_appendwhere( " t.cd_tabela in (125) " )
			end if
			
			dw_1.Event ue_AddRow()
			dw_1.Event ue_Recuperar()

			dw_1.setfilter('id_subida_descida = "S" ')
	End Choose
	
	dw_1.filter()
				
	dw_1.setsort('nr_ordenacao')
	dw_1.sort()
				
	For ll_for = 1 to dw_1.rowcount( )
		
		dw_1.object.id_executa[ll_for] = 'S'
		
	Next
			
	cb_ok.post Event Clicked()
else
	dw_1.Event ue_AddRow()
	dw_1.Event ue_Recuperar()
end if
end event

event ue_preopen;call super::ue_preopen;is_exp_auto = message.stringparm
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge481_exportacao_sap
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge481_exportacao_sap
integer x = 32
integer y = 12
integer width = 2802
integer height = 1272
string text = "Lista de Interfaces"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge481_exportacao_sap
integer y = 76
integer width = 2761
integer height = 1188
string dataobject = "dw_ge481_lista_interface"
boolean vscrollbar = true
boolean livescroll = false
end type

event dw_1::constructor;call super::constructor;// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

event dw_1::clicked;call super::clicked;Long	ll_for


Choose Case dwo.name
	Case 'check_t'
		for ll_for = 1 to dw_1.RowCount()
			if ib_checked_all then
				dw_1.Object.id_executa[ll_for]	= 'N'
			else
				dw_1.Object.id_executa[ll_for]	= 'S'
			end if
		next
		
		ib_checked_all = not ib_checked_all
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge481_exportacao_sap
integer x = 2185
integer y = 1300
end type

event cb_ok::clicked;call super::clicked;Boolean lb_retorno, lb_erro_identificado = False
Long ll_Linha
Long ll_Linhas
Long ll_Tabela, ll_nr_seq_log, ll_nr_rows, ll_qt_selecionados, ll_progresso=0
String ls_Chave, ls_log, ls_nm_tabela, ls_retorno = ''
uo_ge492_exportacao_sap luo_exportacao

ll_Linhas = dw_1.RowCount()

ll_qt_selecionados = dw_1.object.c_total_executa[ll_linhas]

dw_1.AcceptText()
	
Try
	
	If ll_Linhas > 0 Then
		
		luo_exportacao = create uo_ge492_exportacao_sap
		
		if ll_qt_selecionados > 0 Then
			Open(w_aguarde_3)
		end if
		
		For ll_Linha = 1 To ll_Linhas
			
			ll_Tabela = dw_1.Object.cd_tabela[ll_Linha]
			ls_nm_tabela = dw_1.Object.de_tabela[ll_Linha]
			
			If dw_1.Object.id_executa[ll_Linha] = 'S' Then
				ll_progresso++
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress.of_reset()
					w_aguarde_3.uo_progress_2.of_reset()
				
					w_aguarde_3.wf_settext('Interface: ' + ls_nm_tabela + ' (' + string(ll_progresso) + ' de ' + string(ll_qt_selecionados) + ')', 1)
				end if
				
				gvs_Ambiente_SAP = dw_2.object.cd_ambiente_sap[1]
				if gvs_Ambiente_SAP = '' or isnull(gvs_Ambiente_SAP) Then
					messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe o Ambiente SAP.')
					dw_2.setcolumn('cd_ambiente_sap')
					dw_2.setfocus()
					return -1
				end if
				
				lb_retorno = luo_exportacao.uf_executar( ll_tabela, ref ls_log) 
				
				if not lb_retorno then
					lb_erro_identificado = True
				end if
				
				//N$$HEX1$$e300$$ENDHEX$$o retirar o sleep
				sleep(1)
			End If
		Next
	End If
	
	if gvb_Auto = False Then
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Exporta$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.')
	end if
Finally
	destroy(luo_exportacao)
	
	if isvalid(w_aguarde_3) Then Close(w_aguarde_3)
	
	if gvb_Auto Then
		if lb_erro_identificado then ls_retorno = 'ERRO_IDENTIFICADO'
		
		CloseWithReturn(parent, ls_retorno)
	end if
End Try

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge481_exportacao_sap
integer x = 2523
integer y = 1300
end type

type dw_2 from dc_uo_dw_base within w_ge481_exportacao_sap
integer x = 55
integer y = 1312
integer width = 1774
integer height = 92
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge481_lista_ambiente"
end type

