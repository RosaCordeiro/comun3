HA$PBExportHeader$w_ge497_monitor_integra_sap_mult.srw
$PBExportComments$Monitor Integra$$HEX2$$e700e300$$ENDHEX$$o Lote Cont$$HEX1$$e100$$ENDHEX$$bil Sap para Mult
forward
global type w_ge497_monitor_integra_sap_mult from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type pb_2 from picturebutton within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type pb_4 from picturebutton within tabpage_1
end type
type cb_processar from commandbutton within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type cbx_1 from checkbox within tabpage_2
end type
type st_confirmar from statictext within w_ge497_monitor_integra_sap_mult
end type
end forward

global type w_ge497_monitor_integra_sap_mult from dc_w_2tab_consulta_selecao_lista_det
integer width = 5166
integer height = 2488
string title = "GE497 - Monitor Integra$$HEX2$$e700e300$$ENDHEX$$o Lote Cont$$HEX1$$e100$$ENDHEX$$bil  SAP - Mult"
st_confirmar st_confirmar
end type
global w_ge497_monitor_integra_sap_mult w_ge497_monitor_integra_sap_mult

type variables
uo_filial io_filial

Boolean ivb_Check


end variables

forward prototypes
public subroutine wf_deleta_registro_sybase (long al_nr_atualizacao)
public subroutine wf_deleta_registro_oracle (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao)
public subroutine wf_estorno_sybase (long al_nr_atualizacao)
public subroutine wf_estorno_oracle (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao)
public subroutine wf_insere_padrao ()
public function boolean wf_grava_log (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao, ref string as_log)
end prototypes

public subroutine wf_deleta_registro_sybase (long al_nr_atualizacao);String	ls_Status,&
		ls_Erro, &
		ls_dt_param
		
Date ldh_Exportacao
Date ldh_Parametro
		
Long	ll_Qt_Erros_Itens		

ldh_Parametro  = Date(gf_GetSerVerDate())
ls_dt_param     = String(ldh_Parametro, 'dd/mm/yyyy')

Select	 dh_exportacao
Into	 :ldh_Exportacao
From  lote_exporta_sap_mult
Where nr_exportacao = :al_Nr_Atualizacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		// Permitir o reenvio
			Update lote_exporta_sap_mult
			Set id_status = 'X', de_observacao = "Item marcado para exclus$$HEX1$$e300$$ENDHEX$$o em " + :ls_dt_param
			Where nr_exportacao	= :al_Nr_Atualizacao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro	= "Erro ao atualizar a exclus$$HEX1$$e300$$ENDHEX$$o no 'log_exportacao_mult' com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"': "+ SqlCa.SqlErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", ls_Erro)
				Return
			End If			
			
			SqlCa.of_Commit()
			
//		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"'.")
	Case -1
		MessageBox("Erro", "Erro no select da 'log_exportacao_mult', banco SYBASE: "+SqlCa.SqlErrText)
End Choose
end subroutine

public subroutine wf_deleta_registro_oracle (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao);String	ls_Status,&
		ls_Erro
		
Long	ll_Qt_Erros_Itens
Long ll_Achou

LongLong lll_Doc_sap

Date ldh_Parametro
Datetime ldh_Exportacao
datetime ldh_atual

ldh_atual = gf_GetSerVerDate()
ldh_Parametro = Date(ldh_atual)

Select	 count(nr_atualizacao)
Into	:ll_Achou
From log_exportacao_sap
Where nr_atualizacao = :al_Nr_Atualizacao
	and de_erro like '%Estorno n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel, documento cont$$HEX1$$e900$$ENDHEX$$m partidas compens%'
Using ao_Trans_Mult;

If ao_Trans_Mult.SqlCode = -1 Then
	MessageBox("Erro", "Erro no select da 'log_exportacao_sap', banco ORACLE: "+ao_Trans_Mult.SqlErrText)
	Return
End If

If ll_Achou > 0 Then
	MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "Documento de estorno com mensagem de erro [cont$$HEX1$$e900$$ENDHEX$$m partidas compesadas] n$$HEX1$$e300$$ENDHEX$$o pode ser reenviado.~r~r"+&
						"Dever$$HEX1$$e100$$ENDHEX$$ ser retirado do log atrav$$HEX1$$e900$$ENDHEX$$ do bot$$HEX1$$e300$$ENDHEX$$o [Retira Doc].")
	Return
End If

Select	id_status_integracao, dh_exportacao, nr_documento_sap
Into	:ls_Status, :ldh_Exportacao, :lll_Doc_sap
From log_exportacao_sap
Where nr_atualizacao = :al_Nr_Atualizacao
Using ao_Trans_Mult;

Choose Case ao_Trans_Mult.SqlCode
	Case 0
		
//		// Permitir o reenvio
//		If (ls_Status = 'I' or ls_Status = 'C') Then
//			If Not IsNull(lll_Doc_sap) Then
//				MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "O documento n$$HEX1$$e300$$ENDHEX$$o pode ser reenviado porque j$$HEX1$$e100$$ENDHEX$$ possui DOC gerado no SAP.")
//			Else
//				ls_Status = "E"
//			End If
//		End If
		
		// Permitir o reenvio
		If ls_Status = 'C' Then
			If Not IsNull(lll_Doc_sap) Then
				MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "O documento n$$HEX1$$e300$$ENDHEX$$o pode ser reenviado porque j$$HEX1$$e100$$ENDHEX$$ possui DOC gerado no SAP.")
			Else
				
				If ldh_atual < ldh_exportacao Then
					Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O Documento n$$HEX1$$e300$$ENDHEX$$o pode ser reenviado antes de duas horas do primeiro envio.')
					return
				end if
				
				ls_Status = "E"
			End If
		End If
		
		If ls_Status <> "E" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"' n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ reenviado porque o status est$$HEX1$$e100$$ENDHEX$$ diferente de ERRO.")
		Else
			Delete From log_exportacao_sap_item
			Where nr_atualizacao	= :al_Nr_Atualizacao
			Using ao_Trans_Mult;
			
			If ao_Trans_Mult.SqlCode = -1 Then
				ls_Erro	= "Erro no DELETE da 'log_exportacao_sap_item' com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"': "+ ao_Trans_Mult.SqlErrText
				ao_Trans_Mult.of_RollBack()
				MessageBox("Erro", ls_Erro)
				Return
			End If
			
			Delete From log_exportacao_sap
			Where nr_atualizacao	= :al_Nr_Atualizacao
			Using ao_Trans_Mult;
			
			If ao_Trans_Mult.SqlCode = -1 Then
				ls_Erro	= "Erro no DELETE da 'log_exportacao_sap' com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"': "+ ao_Trans_Mult.SqlErrText
				ao_Trans_Mult.of_RollBack()
				MessageBox("Erro", ls_Erro)
				Return
			End If
			
			if wf_grava_log(ao_Trans_Mult, al_Nr_Atualizacao, ref ls_erro) Then
				MessageBox("Erro", ls_Erro)
				Return
			end if
			
			ao_Trans_Mult.of_Commit()
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"'.")
	Case -1
		MessageBox("Erro", "Erro no select da 'log_exportacao_sap', banco ORACLE: "+ao_Trans_Mult.SqlErrText)
End Choose
end subroutine

public subroutine wf_estorno_sybase (long al_nr_atualizacao);Datetime ldh_Estornado

String	ls_Status,&
		ls_Erro,&
		ls_DocEstornado,&
		ls_Doc_SAP
		
Select		coalesce(id_status_integracao, ''), nr_documento_sap_estornado, dh_estornado_sap, nr_documento_sap
Into	:ls_Status, :ls_DocEstornado, :ldh_Estornado, :ls_Doc_SAP
From log_exportacao_sap
Where nr_atualizacao = :al_Nr_Atualizacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
				
		If Not IsNull(ls_DocEstornado) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
							"Motivo: Documento de estorno.", Exclamation!)
			Return 
		End If
		
		If Not IsNull(ldh_Estornado) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
							"Motivo: J$$HEX1$$e100$$ENDHEX$$ foi enviado o estorno para o SAP.", Exclamation!)
			Return 
		End If
		
		If ls_Status <> "P" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
							"Motivo: Apenas documentos com o status PROCESSADO poder$$HEX1$$e300$$ENDHEX$$o ser estornados..", Exclamation!)
			Return 
		Else
			
			If IsNull(ls_Doc_SAP) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
								"Motivo: Documento ainda n$$HEX1$$e300$$ENDHEX$$o foi processado no SAP.", Exclamation!)
				Return 
			End If
						
			Update log_exportacao_sap
			Set id_estornar = 'S'
			Where nr_atualizacao	= :al_Nr_Atualizacao
			Using SqlCa;
			
			If SqlCa.SqlNRows <> 1 Then
				SqlCa.of_RollBack()
				MessageBox("Erro", "No UPDATE da 'log_exportacao_sap' deveria ter atualizado 1 registro, atualizou "+String(SqlCa.SqlNRows)+" registros. N$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"'. ")
				Return
			End If
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro	= "Erro no UPDATE da 'log_exportacao_sap' com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"': "+ SqlCa.SqlErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", ls_Erro)
				Return
			End If
			
			SqlCa.of_Commit()
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"'.")
	Case -1
		MessageBox("Erro", "Erro no select da 'log_exportacao_sap', banco ORACLE: "+SqlCa.SqlErrText)
End Choose
end subroutine

public subroutine wf_estorno_oracle (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao);LongLong ll_DocEstornado, ll_Doc_SAP

DateTime ldh_Estornado

String	ls_Status,&
		ls_Erro
		
Select		coalesce(id_status_integracao, ''), nr_documento_sap_estornado, dh_estornado_sap, nr_documento_sap
Into	:ls_Status, :ll_DocEstornado, :ldh_Estornado, :ll_Doc_SAP
From log_exportacao_sap
Where nr_atualizacao = :al_Nr_Atualizacao
Using ao_Trans_Mult;

Choose Case ao_Trans_Mult.SqlCode
	Case 0
		
		If Not IsNull(ll_DocEstornado) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
							"Motivo: Documento de estorno.", Exclamation!)
			Return 
		End If
		
		If Not IsNull(ldh_Estornado) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
							"Motivo: J$$HEX1$$e100$$ENDHEX$$ foi enviado o estorno para o SAP.", Exclamation!)
			Return 
		End If
		
		If  ls_Status <> "P" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
							"Motivo: Apenas documentos com o status PROCESSADO poder$$HEX1$$e300$$ENDHEX$$o ser estornados.", Exclamation!)
		Else
			
			If IsNull(ll_Doc_SAP) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
								"Motivo: Documento ainda n$$HEX1$$e300$$ENDHEX$$o foi processado no SAP.", Exclamation!)
				Return 
			End If
						
			Update log_exportacao_sap
			Set id_estornar = 'S'
			Where nr_atualizacao	= :al_Nr_Atualizacao
			Using ao_Trans_Mult;
			
			If ao_Trans_Mult.SqlNRows <> 1 Then
				ao_Trans_Mult.of_RollBack()
				MessageBox("Erro", "No UPDATE da 'log_exportacao_sap' deveria ter atualizado 1 registro, atualizou "+String(ao_Trans_Mult.SqlNRows)+" registros. N$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"'. ")
				Return
			End If
			
			If ao_Trans_Mult.SqlCode = -1 Then
				ls_Erro	=  "Erro no UPDATE da 'log_exportacao_sap' com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"': "+ ao_Trans_Mult.SqlErrText
				ao_Trans_Mult.of_RollBack()
				MessageBox("Erro", ls_Erro)
				Return
			End If
			
			ao_Trans_Mult.of_Commit()
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"'.")
	Case -1
		MessageBox("Erro", "Erro no select da 'log_exportacao_sap', banco ORACLE: "+ao_Trans_Mult.SqlErrText)
End Choose
end subroutine

public subroutine wf_insere_padrao ();Long ll_Row
DataWindowChild	ldwc_Child

/* Ambiente SAP */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_ambiente_sap" )			

ldwc_Child.SetItem(1, "cd_ambiente_sap", ""	)
ldwc_Child.SetItem(1, "de_ambiente_sap", "TODOS")
ldwc_Child.SetItem(1, "ordem", -1)

ldwc_Child.SetFilter("cd_ambiente_sap <> 'XXX'")
ldwc_Child.Filter()

Tab_1.Tabpage_1.dw_1.Object.cd_ambiente_sap[1] = "PRD"

Tab_1.Tabpage_1.dw_1.Object.id_tipo_log[1] = 1
Tab_1.Tabpage_1.dw_1.Object.id_tipo_doc[1] = 'RE'


end subroutine

public function boolean wf_grava_log (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao, ref string as_log);

Insert into log_exportacao_sap_hist ( NR_ATUALIZACAO,
												CD_EMPRESA,
												DH_DOCUMENTO,
												DH_LANCAMENTO,
												CD_TIPO_DOCUMENTO,
												NR_DOCUMENTO_REF,
												DE_TEXTO,
												CD_MOEDA,
												CD_FILIAL,
												NR_IDF_DOCTO,
												ID_SITUACAO_DOCTO,
												ID_STATUS_INTEGRACAO,
												DH_EXPORTACAO,
												NR_DOCUMENTO_SAP,
												DH_ESTORNADO_SAP,
												DH_EXCLUIDO_SAP,
												CD_TIPO_DOC_MULT,
												DE_TIPO_DOC_MULT,
												ID_ESTORNAR,
												DE_ERRO,
												NR_DOCUMENTO_SAP_ESTORNADO,
												CD_CHAVE_INTERFACE,
												CD_AMBIENTE_SAP,
												QT_LANCAMENTO,
												NR_IDF_PADRAO_DOCTO,
												NR_MATRICULA,
												DT_REGISTRO,
												HOST_NAME)
Select NR_ATUALIZACAO,
			CD_EMPRESA,
			DH_DOCUMENTO,
			DH_LANCAMENTO,
			CD_TIPO_DOCUMENTO,
			NR_DOCUMENTO_REF,
			DE_TEXTO,
			CD_MOEDA,
			CD_FILIAL,
			NR_IDF_DOCTO,
			ID_SITUACAO_DOCTO,
			ID_STATUS_INTEGRACAO,
			DH_EXPORTACAO,
			NR_DOCUMENTO_SAP,
			DH_ESTORNADO_SAP,
			DH_EXCLUIDO_SAP,
			CD_TIPO_DOC_MULT,
			DE_TIPO_DOC_MULT,
			ID_ESTORNAR,
			DE_ERRO,
			NR_DOCUMENTO_SAP_ESTORNADO,
			CD_CHAVE_INTERFACE,
			CD_AMBIENTE_SAP,
			QT_LANCAMENTO,
			NR_IDF_PADRAO_DOCTO,
			:gvo_aplicacao.ivo_seguranca.nr_matricula,
			getdate(),
			host_name()
	from log_exportacao_sap
	where nr_atualizacao = :al_nr_atualizacao
Using ao_trans_mult;

if ao_trans_mult.sqlcode = -1 then
	as_log = 'objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_grava_log ~nErro ao inserir registro na tabela "log_exportacao_sap_hist": ' + sqlca.sqlerrtext
	return false
end if

return true
end function

on w_ge497_monitor_integra_sap_mult.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
end on

on w_ge497_monitor_integra_sap_mult.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_confirmar)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.dt_inicio_exportacao			[1] = RelativeDate(Date(gf_GetServerDate()),  -6)
Tab_1.TabPage_1.dw_1.Object.dt_termino_exportacao		[1] = Date(gf_GetServerDate())


wf_insere_padrao()

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)

//#if defined DEBUG then
//   tab_1.tabpage_1.cb_processar.visible = True
//#end if


end event

event open;call super::open;io_Filial = Create uo_Filial

ivb_Check = False
end event

event close;call super::close;Destroy(io_Filial)
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge497_monitor_integra_sap_mult
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge497_monitor_integra_sap_mult
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge497_monitor_integra_sap_mult
integer width = 5083
integer height = 2280
end type

event tab_1::selectionchanged;//OverRide

Tab_1.TabPage_2.cbx_1.Checked = False
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 5047
integer height = 2164
gb_4 gb_4
cb_2 cb_2
pb_2 pb_2
dw_4 dw_4
pb_4 pb_4
cb_processar cb_processar
dw_5 dw_5
end type

on tabpage_1.create
this.gb_4=create gb_4
this.cb_2=create cb_2
this.pb_2=create pb_2
this.dw_4=create dw_4
this.pb_4=create pb_4
this.cb_processar=create cb_processar
this.dw_5=create dw_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.pb_4
this.Control[iCurrent+6]=this.cb_processar
this.Control[iCurrent+7]=this.dw_5
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.cb_2)
destroy(this.pb_2)
destroy(this.dw_4)
destroy(this.pb_4)
destroy(this.cb_processar)
destroy(this.dw_5)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 0
integer y = 380
integer width = 5001
integer height = 1768
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 0
integer y = 20
integer width = 4453
integer height = 340
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 46
integer y = 88
integer width = 4366
integer height = 260
string dataobject = "dw_ge497_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long	ll_Nulo

If dwo.Name = "nm_fantasia" Then
	
	SetNull(ll_Nulo)
	
	If data = "" or IsNull(data) Then
		This.Object.cd_filial[1] = ll_Nulo
	Else
		If Data <> io_filial.nm_fantasia Then Return 1
	End If	
	
End If

//If dwo.Name = 'id_caixa' and Data = 'S' Then
//	This.Object.id_contabilizacao[1] = 'S'
//End If
end event

event dw_1::ue_key;call super::ue_key;String	ls_Coluna,&
		ls_Filial

If Key = KeyEnter! Then

	ls_Coluna = This.GetColumnName()

	If ls_Coluna = "nm_fantasia" Then

		ls_Filial = Tab_1.TabPage_1.dw_1.GetText()

		io_Filial.of_Localiza_Filial(ls_Filial)
		
		// Verifica se a Filial foi localizada e atualiza a DW
		If io_Filial.Localizada  Then
			Tab_1.TabPage_1.dw_1.Object.cd_filial			[1] = io_Filial.cd_filial
			Tab_1.TabPage_1.dw_1.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
		Else
		
			SetNull(io_Filial.Cd_Filial)
			io_Filial.Nm_Fantasia = ""
			
			Tab_1.TabPage_1.dw_1.Object.cd_filial			[1] = io_filial.cd_filial
			Tab_1.TabPage_1.dw_1.Object.nm_fantasia	[1] = io_filial.nm_fantasia
			
		End If
		
	End If
End If
end event

event dw_1::constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
event ue_mousemove pbm_mousemove
integer x = 41
integer y = 432
integer width = 4933
integer height = 1540
string dataobject = "dw_ge497_detalhes"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_mousemove;If This.RowCount() > 0 Then
	If (xpos >= Long(This.Object.id_imagem.X)  and (xpos <= (Long(This.Object.id_imagem.X)  + 73))) and &
		  (ypos >= Long(This.Object.id_imagem.Y)	and (ypos <= (Long(This.Object.id_imagem.Y) + 64))) Then	 
		
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

event dw_2::ue_recuperar;//OverRide

Long	ll_Linhas,&
		ll_Filial,&
		ll_Linha,&
		ll_New_Row,&
		ll_Doc_Externo,&
		ll_Tipo_Log
		
String ls_sql		

//dc_uo_transacao lo_Trans_Mult
dc_uo_transacao    lo_transacao_SYB
//dc_uo_ds_base lds_Mult
dc_uo_ds_base 	 lds_SYB

Date	ldt_Inicio_Movimento,&
		ldt_Termino_Movimento,&
		ldt_Inicio_Exportacao,&
		ldt_Termino_Exportacao, &
		ldt_inicio_docto, &
		ldt_termino_docto
		
String	ls_Tipo_Doc,&
		ls_Documento_Sap,&
		ls_Ambiente_Sap,&
		ls_Status,&
		ls_Tipo_Doc_Mult,&
		ls_Tipo_Documento,&
		ls_Caixa,&
		ls_Contabil,&
		ls_NR_Doc,&
		ls_Chave_Legado,&
		ls_Divisao,&
		ls_Chave, ls_valor_exato

ivb_Check = False
Tab_1.TabPage_1.dw_5.Event ue_Cancel()
Tab_1.TabPage_1.dw_1.AcceptText()		

ldt_Inicio_Exportacao		= Tab_1.TabPage_1.dw_1.Object.dt_inicio_exportacao			[1]
ldt_Termino_Exportacao	= Tab_1.TabPage_1.dw_1.Object.dt_termino_exportacao		[1]
ldt_Inicio_Movimento		= Tab_1.TabPage_1.dw_1.Object.dt_inicio_movimentacao		[1]
ldt_Termino_Movimento	= Tab_1.TabPage_1.dw_1.Object.dt_termino_movimentacao	[1]
ldt_inicio_docto				= Tab_1.TabPage_1.dw_1.Object.dt_inicio_docto 					[1]
ldt_termino_docto			= Tab_1.TabPage_1.dw_1.Object.dt_termino_docto 				[1]
ll_Filial						= Tab_1.TabPage_1.dw_1.Object.cd_filial							[1]
ls_Tipo_Doc					= Tab_1.TabPage_1.dw_1.Object.id_tipo_doc						[1]
//ls_Tipo_Doc 				= Tab_1.TabPage_1.dw_1.Describe ("Evaluate('LookupDisplay(id_tipo_doc)', " + String(1) + ")")
ls_Documento_Sap		= Tab_1.TabPage_1.dw_1.Object.nr_documento_sap			[1]
ls_Ambiente_Sap			= Tab_1.TabPage_1.dw_1.Object.cd_ambiente_sap				[1]
ls_Status						= Tab_1.TabPage_1.dw_1.Object.id_status							[1]
ls_Caixa						= Tab_1.TabPage_1.dw_1.Object.id_caixa							[1]
ls_Contabil					= Tab_1.TabPage_1.dw_1.Object.	id_contabilizacao				[1]
ls_NR_Doc					= Tab_1.TabPage_1.dw_1.Object.	nr_documento					[1]
ll_Doc_Externo				= Tab_1.TabPage_1.dw_1.Object.	nr_documento_externo		[1]
ls_Chave						= Tab_1.TabPage_1.dw_1.Object.	cd_chave							[1]
ll_Tipo_Log					= Tab_1.TabPage_1.dw_1.Object.	id_tipo_log						[1]
ls_Divisao					= String(Tab_1.TabPage_1.dw_1.Object.	nr_divisao_sap		[1])
ls_valor_exato 				= Tab_1.TabPage_1.dw_1.Object.id_valor_exato					[1]

If ldt_Inicio_Exportacao > ldt_Termino_Exportacao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da Exporta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da Exporta$$HEX2$$e700e300$$ENDHEX$$o", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_movimentacao")
	Return -1
End If

If ldt_Inicio_Movimento > ldt_Termino_Movimento Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio do Lan$$HEX1$$e700$$ENDHEX$$amento n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino do Lan$$HEX1$$e700$$ENDHEX$$amento.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_movimentacao")
	Return -1
End If

If ldt_inicio_docto > ldt_termino_docto Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio do Documento SAP n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino do Documento SAP.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_movimentacao")
	Return -1
End If

If ls_Ambiente_Sap = "T" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o ambiente SAP.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "cd_ambiente_sap")
	Return -1
End If

// Processado
If ls_Status = 'P'  Then
	If DaysAfter ( ldt_Inicio_Exportacao, ldt_Termino_Exportacao ) > 7 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo entre as datas de exporta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser superior a 7 dias.")
		Return -1
	End If
	
	If IsNull(ll_Filial) and IsNull(ls_Documento_Sap) and IsNull(ls_Caixa) and IsNull(ls_NR_Doc) and IsNull(ls_Tipo_Doc) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos um par$$HEX1$$e200$$ENDHEX$$metro [FILIAL, DOC. SAP, SOMENTE CX, NR DOC ou TIPO DE DOC].")
		Return -1
	End If
End If

If ls_Status = 'N' then //Ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio mudar a datastore - Itens n$$HEX1$$e300$$ENDHEX$$o integrados (n$$HEX1$$e300$$ENDHEX$$o possuem linhas na tabela lote_exporta_sap_mult */
   	If Not This.of_ChangeDataObject("dw_ge497_detalhes_nao_integrado") Then Return 1
		
	/* Data Exporta$$HEX2$$e700e300$$ENDHEX$$o */ 
	If Not IsNUll(ldt_Inicio_Exportacao) and Not IsNull(ldt_Termino_Exportacao) Then
		This.of_AppendWhere_SubQuery("a.dh_inclusao between '"+String(ldt_Inicio_Exportacao, "YYYYMMDD 00:00:00")+"' and '"+String(ldt_Termino_Exportacao, "YYYYMMDD 23:59:59")+"'", 1)
	End If
	
	/* CX = Frete CTEos- model = 67 e ZK = Frete CTE- modelo 57 */
	This.of_AppendWhere_SubQuery("  not exists (Select distinct jdoc.belnr  FROM j_1bnfdoc_1 jdoc INNER JOIN j_1bnfdoc_2  jdoc2 	ON jdoc2.mandt  = jdoc.mandt and jdoc2.docnum = jdoc.docnum  and jdoc2.nr_sequencial = jdoc.nr_sequencial where  jdoc.id_status = 'C'  and  jdoc.belnr =  substring(a.awkey,1,len(a.awkey)-4)  and  jdoc2.model in (57,67))",1)
	This.of_AppendWhere_SubQuery("  not exists ( Select 1 from lote_exporta_sap_mult les where les.mandt = a.mandt and les.bukrs = a.bukrs  and les.belnr = a.belnr and les.budat = a.budat and les.bldat = a.bldat) ",1)
	This.of_AppendWhere_SubQuery("a.blart = '" +upper(ls_Tipo_Doc)+"'", 1)	
	//Expurgar lancamentos de ativo, energia eletrica, etc
	//This.of_AppendWhere_SubQuery(" 1 = (select count(*) from bkpf a2 where a2.awkey = a.awkey)", 1)	
else
	If Not This.of_ChangeDataObject("dw_ge497_detalhes") Then Return 1
	//Expurgar lancamentos de ativo, energia eletrica, etc
	//This.of_AppendWhere_SubQuery(" 1 = (select count(*) from bkpf dc2 where dc2.awkey = dc.awkey)", 1)	

End If

This.of_AppendWhere_SubQuery("not exists ( select 1 " + &
														" from j_1bnflin it1 " + & 
														" Where it1.mandt = n.mandt " + &
														"	and it1.docnum = n.docnum " + &
														"	and it1.nr_sequencial = n.nr_sequencial " + &
														"	and it1.cod_cta = '0012399991')", 1)

This.Of_SetRowSelection()
This.Of_SetSort()
This.Of_SetFilter()
This.SetRedraw(False)

/* Data Lan$$HEX1$$e700$$ENDHEX$$amento SAP */
If Not IsNUll(ldt_Inicio_Movimento) and Not IsNull(ldt_Termino_Movimento) Then
	This.of_AppendWhere_SubQuery("cast(a.budat as date)  between '"+String(ldt_Inicio_Movimento,"YYYYMMDD 00:00:00")+"' and '"+String(ldt_Termino_Movimento, "YYYYMMDD 23:59:59")+"'", 1)
End If

/* Data Documento SAP */
If Not IsNUll(ldt_inicio_docto) and Not IsNull(ldt_termino_docto) Then
	This.of_AppendWhere_SubQuery("a.bldat  between '"+String(ldt_inicio_docto, "YYYYMMDD 00:00:00")+"' and '"+String(ldt_termino_docto, "YYYYMMDD 23:59:59")+"'", 1)
End If


If Not Isnull(ls_Documento_Sap) and (ls_Documento_Sap <> '') then
	This.of_AppendWhere_SubQuery("a.belnr = '"+ls_Documento_Sap+"'",1)
End If	

 If ls_Status <> 'N' Then /* Itens que est$$HEX1$$e300$$ENDHEX$$o na tabela lote_exporta_sap_mult */
        If ls_Status <> 'T' then
	    		This.of_AppendWhere_SubQuery("a.id_status = '" + ls_Status +"'", 1)
	    End If 	 
		/* Data Exporta$$HEX2$$e700e300$$ENDHEX$$o */ 
		If Not IsNUll(ldt_Inicio_Exportacao) and Not IsNull(ldt_Termino_Exportacao) Then
			This.of_AppendWhere_SubQuery("a.dh_exportacao between '"+String(ldt_Inicio_Exportacao, "YYYYMMDD 00:00:00")+"' and '"+String(ldt_Termino_Exportacao, "YYYYMMDD 23:59:59")+"'", 1)
		End If
		
		If Not IsNUll(ls_Tipo_Doc) and (ls_Tipo_Doc <> "" )	Then
			This.of_AppendWhere_SubQuery("upper(a.de_tipo_docto) = '"+upper(ls_Tipo_Doc)+"'", 1)
		End If 
		
		If Not Isnull(ll_Doc_Externo)  then
			This.of_AppendWhere_SubQuery("a.nr_exportacao = "+String(ll_Doc_Externo),1)
		End If	
				
		If Not IsNUll(ls_Ambiente_Sap) and (ls_Ambiente_Sap <> "" )	Then
			This.of_AppendWhere_SubQuery("a.cd_ambiente_sap = '"+ls_Ambiente_Sap+"'", 1)
		End If	
End If		

ls_sql = this.Object.DataWindow.Table.Select

If This.Retrieve() < 0 Then
	This.Reset()
	Return -1
End If

ll_Linhas = This.RowCount()

//S$$HEX1$$f300$$ENDHEX$$ pega os lan$$HEX1$$e700$$ENDHEX$$amentos do Sybase
If ls_Contabil = 'S' or ls_Caixa = "S"Then 
	dw_2.SetRedraw(True)
	Return ll_Linhas
End If

If IsValid(lo_transacao_SYB) Then
	If lo_transacao_SYB.Of_IsConnected() Then	lo_transacao_SYB.Of_disconnect()
	Destroy(lo_transacao_SYB)
End If
	
If IsValid(lds_SYB) Then
	Destroy(lds_SYB)
End If
	
If IsValid(w_Aguarde) Then
	Close(w_Aguarde)
End If
	
SetPointer(Arrow!)
dw_2.SetRedraw(True)

Return This.RowCount()
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;String	ls_Erro_Cabecalho = ""

If CurrentRow > 0 Then	
	ls_Erro_Cabecalho	= This.Object.de_erro_cabecalho[currentRow]
	
	Tab_1.TabPage_1.dw_5.Object.de_log [1] = ls_Erro_Cabecalho
Else
	Tab_1.TabPage_1.dw_5.Object.de_log [1] = ""
End If
end event

event dw_2::doubleclicked;call super::doubleclicked;Long lvl_Row
	  
String lvs_Marcacao,&
	   lvs_Nulo 

SetNull(lvs_Nulo)

Choose Case dwo.Name 
			
	Case 'id_imagem'
			
		If ivb_Check Then
			lvs_Marcacao = 'N'
			ivb_Check = False
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		Else
			lvs_Marcacao = 'S'
			ivb_Check = True
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		End If
		
		For lvl_Row = 1 To This.RowCount()
					
			This.Object.id_selecionar[lvl_Row] = lvs_Marcacao
			
		Next
		
End Choose
end event

event dw_2::constructor;call super::constructor;// Habilitar a linha de sele$$HEX2$$e700e300$$ENDHEX$$o (list)
This.of_SetRowSelection()

end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 5047
integer height = 2164
cbx_1 cbx_1
end type

on tabpage_2.create
this.cbx_1=create cbx_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cbx_1)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 0
integer y = 36
integer width = 4320
integer height = 2124
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 41
integer y = 92
integer width = 4261
integer height = 2056
string dataobject = "dw_ge497_detallhes_contab_item"
boolean vscrollbar = true
boolean livescroll = false
end type

event dw_3::ue_recuperar;
//OverRide

Long	ll_Linha,&
		ll_Nr_Exportacao,&
		ll_Linhas = 0, &
		ll_Cd_Filial
		
String	ls_Banco	

//dc_uo_transacao	lo_Trans_Mult



Try
	SetPointer(HourGlass!)
	
////	lo_Trans_Mult = Create dc_uo_transacao
//	
ll_Linha	= Tab_1.TabPage_1.dw_2.GetRow()

If ll_Linha > 0 Then

		ll_Nr_Exportacao	= Tab_1.TabPage_1.dw_2.Object.nr_exportacao[ll_Linha]
		ll_Linhas	= Tab_1.TabPage_2.dw_3.Retrieve(ll_Nr_Exportacao)
	
	End If
	
Finally
	SetPointer(Arrow!)
End Try

This.of_SetRowSelection()

Return ll_Linhas




	
	



end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_3::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type gb_4 from groupbox within tabpage_1
boolean visible = false
integer x = 27
integer y = 1992
integer width = 4288
integer height = 160
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Erro de Integra$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type cb_2 from commandbutton within tabpage_1
integer x = 4608
integer y = 92
integer width = 402
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Reenviar"
end type

event clicked;Long	ll_Nr_Atualizacao,&
		ll_Find,&
		ll_Linha

String	ls_Banco,&
		ls_Selecionado,&
		ls_Matricula, &
		ls_sit_log

ll_Find	= Tab_1.TabPage_1.dw_2.Find("id_selecionar = 'S'", 1, Tab_1.TabPage_1.dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Erro", "Erro no Find.")
	Return
End If

If ll_Find	= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum registro selecionado para Reenviar.")
	Return
End If

ls_sit_log		= Tab_1.TabPage_1.dw_2.Object.id_status_integracao [ll_Find]
If ls_sit_log = 'X' then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Item selecionado j$$HEX1$$e100$$ENDHEX$$ foi exclu$$HEX1$$ed00$$ENDHEX$$do, para Reenviar, favor solicitar $$HEX1$$e000$$ENDHEX$$ TI para executar a rotina de Exporta$$HEX2$$e700e300$$ENDHEX$$o de Lote Cont$$HEX1$$e100$$ENDHEX$$bil.")
	Return
End If	

If ls_sit_log = 'N' then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Item n$$HEX1$$e300$$ENDHEX$$o foi processado e enviado para Mult, favor solicitar $$HEX1$$e000$$ENDHEX$$ TI para executar a rotina de Exporta$$HEX2$$e700e300$$ENDHEX$$o de Lote Cont$$HEX1$$e100$$ENDHEX$$bil.")
	Return
End If	


If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE497_REENVIAR_DOCUMENTO", ref ls_Matricula) Then 
	Return
End If

Try
	SetPointer(HourGlass!)
	
	Open(w_aguarde)
	
	w_aguarde.Title = "Reenviando..."
	
	w_aguarde.uo_Progress.of_SetMax(Tab_1.TabPage_1.dw_2.RowCount())
	
	For ll_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
		
		w_aguarde.uo_Progress.of_SetProgress(ll_Linha)
		
		ls_Selecionado		= Tab_1.TabPage_1.dw_2.Object.id_selecionar		[ll_Linha]
		
		If ls_Selecionado = "S" Then
			ll_Nr_Atualizacao	= Tab_1.TabPage_1.dw_2.Object.nr_exportacao	[ll_Linha]
			ls_Banco				= Tab_1.TabPage_1.dw_2.Object.de_banco		[ll_Linha]
			
			If ls_Banco = "SYB" Then
				wf_Deleta_Registro_Sybase(ll_Nr_Atualizacao)
			Else
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de banco n$$HEX1$$e300$$ENDHEX$$o previsto '" + ls_Banco + "'.", StopSign!)
			End If	
		End If
	Next
	
Finally
	
	If IsValid(w_Aguarde) Then
		Close(w_Aguarde)
	End If
	
	SetPointer(Arrow!)
End Try

dw_2.Event ue_Recuperar()


	
	
	



end event

type pb_2 from picturebutton within tabpage_1
integer x = 4480
integer y = 92
integer width = 114
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\question_1.png"
alignment htextalign = left!
end type

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"O registro do documento ser$$HEX1$$e100$$ENDHEX$$ marcado para exclus$$HEX1$$e300$$ENDHEX$$o no banco de dados.~r~r"+&
								"Dever$$HEX1$$e100$$ENDHEX$$ ser executado o programa de interface para enviar o documento novamente para a Mult.~r~r"+&
								"Apenas documentos com a situa$$HEX2$$e700e300$$ENDHEX$$o 'INTEGRADO' poder$$HEX1$$e300$$ENDHEX$$o ser reenviados.")
end event

type dw_4 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 41
integer y = 2036
integer width = 4224
integer height = 100
integer taborder = 20
boolean enabled = false
string dataobject = "dw_ge497_erro"
end type

type pb_4 from picturebutton within tabpage_1
boolean visible = false
integer x = 4480
integer y = 220
integer width = 114
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\question_1.png"
alignment htextalign = left!
end type

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"O registro do documento ser$$HEX1$$e100$$ENDHEX$$ marcado para Reprocesso.~r~r"+&
								"Dever$$HEX1$$e100$$ENDHEX$$ ser executado o programa de interface para enviar o documento novamente do SAP para Mult.~r~r"+&
								"Ser$$HEX1$$e100$$ENDHEX$$ importante certificar como o documento est$$HEX1$$e100$$ENDHEX$$ na Mult, caso contr$$HEX1$$e100$$ENDHEX$$rio, o Reprocesso causar$$HEX1$$e100$$ENDHEX$$ duplicidade.")
end event

type cb_processar from commandbutton within tabpage_1
boolean visible = false
integer x = 4608
integer y = 220
integer width = 402
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Processar"
end type

type dw_5 from dc_uo_dw_base within tabpage_1
integer x = 32
integer y = 1984
integer width = 4919
integer height = 132
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge497_log"
end type

event constructor;call super::constructor;This.ivi_tipo_cancelar = ADDROW
end event

type cbx_1 from checkbox within tabpage_2
boolean visible = false
integer x = 46
integer y = 36
integer width = 1335
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Mostrar apenas os itens com erro de integra$$HEX2$$e700e300$$ENDHEX$$o"
boolean automatic = false
end type

event clicked;Tab_1.TabPage_2.dw_3.SetRedraw(false)

If This.Checked Then
	Tab_1.TabPage_2.dw_3.SetFilter(" not isnull(de_erro_item)")	
	Tab_1.TabPage_2.dw_3.Filter()
Else
	Tab_1.TabPage_2.dw_3.SetFilter("")
	Tab_1.TabPage_2.dw_3.Filter()	
End If

Tab_1.TabPage_2.dw_3.Sort()
Tab_1.TabPage_2.dw_3.SetRedraw(true)
end event

type st_confirmar from statictext within w_ge497_monitor_integra_sap_mult
boolean visible = false
integer x = 3803
integer y = 540
integer width = 951
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
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
boolean focusrectangle = false
end type

