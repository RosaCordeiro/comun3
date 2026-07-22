HA$PBExportHeader$w_ge467_monitor_integracao_sap.srw
forward
global type w_ge467_monitor_integracao_sap from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type pb_1 from picturebutton within tabpage_1
end type
type pb_2 from picturebutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type pb_4 from picturebutton within tabpage_1
end type
type cb_processar from commandbutton within tabpage_1
end type
type cbx_1 from checkbox within tabpage_2
end type
type st_confirmar from statictext within w_ge467_monitor_integracao_sap
end type
end forward

global type w_ge467_monitor_integracao_sap from dc_w_2tab_consulta_selecao_lista_det
integer width = 4475
integer height = 2488
string title = "GE467 - Monitor Integra$$HEX2$$e700e300$$ENDHEX$$o SAP"
st_confirmar st_confirmar
end type
global w_ge467_monitor_integracao_sap w_ge467_monitor_integracao_sap

type variables
uo_filial io_filial

Boolean ivb_Check

Private: 
String is_Tipo_NF_CR = "'TCR','TCC','TCV','VPT','CPT','VSU','CSU','TCE','POD','POC','CDI'"
	
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
		ls_Erro
		
Date ldh_Exportacao
Date ldh_Parametro
		
Long	ll_Qt_Erros_Itens		

ldh_Parametro = Date(gf_GetSerVerDate())

Select	id_status_integracao, dh_exportacao
Into	:ls_Status, :ldh_Exportacao
From log_exportacao_sap
Where nr_atualizacao = :al_Nr_Atualizacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		// Permitir o reenvio
		If (ls_Status = 'I' or ls_Status = 'C') Then
			ls_Status = "E"
		End If
				
		If ls_Status <> "E" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"' n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ reenviado porque o status est$$HEX1$$e100$$ENDHEX$$ diferente de ERRO.")
		Else
			
			Delete From log_exportacao_sap_aux
			Where nr_atualizacao	= :al_Nr_Atualizacao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro	= "Erro no DELETE da 'log_exportacao_sap_aux' com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"': "+ SqlCa.SqlErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", ls_Erro)
				Return
			End If
			
			Delete From log_exportacao_sap_historico
			Where nr_atualizacao	= :al_Nr_Atualizacao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro	= "Erro no DELETE da 'log_exportacao_sap_historico' com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"': "+ SqlCa.SqlErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", ls_Erro)
				Return
			End If
			
			Delete From log_exportacao_sap
			Where nr_atualizacao	= :al_Nr_Atualizacao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro	= "Erro no DELETE da 'log_exportacao_sap' com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"': "+ SqlCa.SqlErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", ls_Erro)
				Return
			End If
			
			SqlCa.of_Commit()
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"'.")
	Case -1
		MessageBox("Erro", "Erro no select da 'log_exportacao_sap', banco SYBASE: "+SqlCa.SqlErrText)
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
	If MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "Documento de estorno com mensagem de erro [cont$$HEX1$$e900$$ENDHEX$$m partidas compesadas].~r"+&
						"Dever$$HEX1$$e100$$ENDHEX$$ ser retirado do log atrav$$HEX1$$e900$$ENDHEX$$ do bot$$HEX1$$e300$$ENDHEX$$o [Retira Doc] ou reenviado caso tenha sido descompensado no SAP.~r~rDeseja reenviar ?", Question!, YesNo!, 2) = 2 Then
		Return
	End If
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

Tab_1.Tabpage_1.dw_1.Object.cd_ambiente_sap[1] = IIF(SQLCa.database='central',"PRD","S8Q")

/* Tipo Log */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("id_tipo_log" )			

ldwc_Child.SetItem(1, "id_tipo_log", 0	)
ldwc_Child.SetItem(1, "de_tipo_log", "TODOS")
ldwc_Child.SetItem(1, "tipo_log", "00 - TODOS")


ll_Row = ldwc_Child.InsertRow(0)
ldwc_Child.SetItem(ll_Row, "id_tipo_log", 99	)
ldwc_Child.SetItem(ll_Row, "de_tipo_log", "MULT")
ldwc_Child.SetItem(ll_Row, "tipo_log", "99 - MULT")

Tab_1.Tabpage_1.dw_1.Object.id_tipo_log[1] = 0

/* Tipo Doc */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("id_tipo_doc" )			

ldwc_Child.SetItem(1, "id_tipo_nf", ""	)
ldwc_Child.SetItem(1, "de_tipo_nf", "TODOS")
Tab_1.Tabpage_1.dw_1.Object.id_tipo_doc[1] = ""


/* Tipo Contabiliza$$HEX2$$e700e300$$ENDHEX$$o */
Choose Case gvo_Aplicacao.ivo_Seguranca.cd_sistema
	Case 'CR'
		Tab_1.Tabpage_1.dw_1.Object.id_contabilizacao [1] = 'S'		
	Case 'CT'
		Tab_1.Tabpage_1.dw_1.Object.id_contabilizacao [1] = 'M'
	Case Else
		Tab_1.Tabpage_1.dw_1.Object.id_contabilizacao [1] = 'T'
End Choose

Tab_1.Tabpage_1.dw_1.Post Event itemChanged(1, Tab_1.Tabpage_1.dw_1.Object.id_contabilizacao, Tab_1.Tabpage_1.dw_1.Object.id_contabilizacao [1])
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

on w_ge467_monitor_integracao_sap.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
end on

on w_ge467_monitor_integracao_sap.destroy
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

#if defined DEBUG then
   tab_1.tabpage_1.cb_processar.visible = True
#end if


end event

event open;call super::open;io_Filial = Create uo_Filial

ivb_Check = False
end event

event close;call super::close;Destroy(io_Filial)
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge467_monitor_integracao_sap
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge467_monitor_integracao_sap
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge467_monitor_integracao_sap
integer width = 4384
integer height = 2280
end type

event tab_1::selectionchanged;//OverRide

Tab_1.TabPage_2.cbx_1.Checked = False
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4347
integer height = 2164
gb_4 gb_4
dw_4 dw_4
cb_1 cb_1
cb_2 cb_2
pb_1 pb_1
pb_2 pb_2
cb_3 cb_3
pb_4 pb_4
cb_processar cb_processar
end type

on tabpage_1.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_3=create cb_3
this.pb_4=create pb_4
this.cb_processar=create cb_processar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.pb_2
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.pb_4
this.Control[iCurrent+9]=this.cb_processar
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_3)
destroy(this.pb_4)
destroy(this.cb_processar)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 27
integer y = 544
integer width = 4288
integer height = 1432
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3730
integer height = 520
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 46
integer width = 3666
integer height = 432
string dataobject = "dw_ge467_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long	ll_Nulo
DatawindowChild ldwc_Child

Choose Case dwo.Name
	Case "nm_fantasia"
		SetNull(ll_Nulo)
		
		If data = "" or IsNull(data) Then
			This.Object.cd_filial[1] = ll_Nulo
		Else
			If Data <> io_filial.nm_fantasia Then Return 1
		End If	
	

	Case "id_caixa"
		If Data = 'S' Then
			This.Object.id_contabilizacao[1] = 'S'
		End If

	Case "id_contabilizacao"
		If Tab_1.Tabpage_1.dw_1.GetChild("id_tipo_doc", ldwc_Child) > -1 Then
			If Data='M' Then				
				ldwc_Child.SetFilter("cd_tipo_doc_mult<>'' or id_tipo_nf=''")
				ldwc_Child.Filter()
			ElseIf Data='S' Then		
				If gvo_Aplicacao.ivo_Seguranca.cd_sistema='CR' Then
					ldwc_Child.SetFilter("id_tipo_nf in ('',"+is_Tipo_NF_CR+")")
					ldwc_Child.Filter()
				Else
					ldwc_Child.SetFilter("IsNull(cd_tipo_doc_mult) or cd_tipo_doc_mult='' or id_tipo_nf=''")
					ldwc_Child.Filter()
				End IF
			Else		
				ldwc_Child.SetFilter("")
				ldwc_Child.Filter()
			End if
		End If
End Choose
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
integer x = 64
integer y = 612
integer width = 4224
integer height = 1336
string dataobject = "dw_ge467_detalhes"
boolean hscrollbar = true
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

dc_uo_transacao lo_Trans_Mult

dc_uo_ds_base lds_Mult

Date	ldt_Inicio_Movimento,&
		ldt_Termino_Movimento,&
		ldt_Inicio_Exportacao,&
		ldt_Termino_Exportacao
		
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
		ls_Chave, ls_valor_exato, &
		lvs_Parametro
		
Tab_1.TabPage_1.dw_1.AcceptText()		

ldt_Inicio_Exportacao	= Tab_1.TabPage_1.dw_1.Object.dt_inicio_exportacao			[1]
ldt_Termino_Exportacao	= Tab_1.TabPage_1.dw_1.Object.dt_termino_exportacao		[1]
ldt_Inicio_Movimento		= Tab_1.TabPage_1.dw_1.Object.dt_inicio_movimentacao		[1]
ldt_Termino_Movimento	= Tab_1.TabPage_1.dw_1.Object.dt_termino_movimentacao		[1]
ll_Filial					= Tab_1.TabPage_1.dw_1.Object.cd_filial						[1]
ls_Tipo_Doc					= Tab_1.TabPage_1.dw_1.Object.id_tipo_doc						[1]
ls_Documento_Sap			= Tab_1.TabPage_1.dw_1.Object.nr_documento_sap				[1]
ls_Ambiente_Sap			= Tab_1.TabPage_1.dw_1.Object.cd_ambiente_sap				[1]
ls_Status					= Tab_1.TabPage_1.dw_1.Object.id_status						[1]
ls_Caixa						= Tab_1.TabPage_1.dw_1.Object.id_caixa							[1]
ls_Contabil					= Tab_1.TabPage_1.dw_1.Object.id_contabilizacao				[1]
ls_NR_Doc					= Tab_1.TabPage_1.dw_1.Object.nr_documento					[1]
ll_Doc_Externo				= Tab_1.TabPage_1.dw_1.Object.nr_documento_externo			[1]
ls_Chave						= Tab_1.TabPage_1.dw_1.Object.cd_chave							[1]
ll_Tipo_Log					= Tab_1.TabPage_1.dw_1.Object.id_tipo_log						[1]
ls_Divisao					= String(Tab_1.TabPage_1.dw_1.Object.	nr_divisao_sap[1])
ls_valor_exato 			= Tab_1.TabPage_1.dw_1.Object.id_valor_exato[1]

If IsNumber(ls_Tipo_Doc) Then
	select  cd_tipo_doc_mult 
	Into :ls_Tipo_Doc
	from tipo_log_exportacao_sap_nf
	where id_tipo_nf = :ls_Tipo_Doc
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao localizar o tipo de documento na Mult.")
		Return -1
	End If
End If

If IsNull(ldt_Inicio_Exportacao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da exporta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_exportacao")
	Return -1
End If

If IsNull(ldt_Termino_Exportacao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da exporta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino_exportacao")
	Return -1
End If

If IsNull(ldt_Inicio_Movimento) and Not IsNull(ldt_Termino_Movimento) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da movimenta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_movimentacao")
	Return -1
End If

If IsNull(ldt_Termino_Movimento) and Not IsNull(ldt_Inicio_Movimento) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da movimenta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino_movimentacao")
	Return -1
End If

If ldt_Inicio_Movimento > ldt_Termino_Movimento Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da movimenta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_movimentacao")
	Return -1
End If

If IsNull(ldt_Inicio_Exportacao) and Not IsNull(ldt_Termino_Exportacao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da exporta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_exportacao")
	Return -1
End If

If IsNull(ldt_Termino_Exportacao) and Not IsNull(ldt_Inicio_Exportacao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da exporta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino_exportacao")
	Return -1
End If

If ldt_Inicio_Exportacao > ldt_Termino_Exportacao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da exporta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da exporta$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino_exportacao")
	Return -1
End If

//Valida datas anteriores a limpeza do log
uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral
lvo_Parametro.of_localiza_parametro("DH_LIMPA_LOG_EXPORTACAO_SAP", ref lvs_Parametro)
Destroy(lvo_Parametro)

If ldt_Inicio_Exportacao < Date(lvs_Parametro) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data de in$$HEX1$$ed00$$ENDHEX$$cio da exporta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data do $$HEX1$$fa00$$ENDHEX$$ltimo expurgo do log de exporta$$HEX2$$e700e300$$ENDHEX$$o ao SAP.~r~n~r~n$$HEX1$$da00$$ENDHEX$$ltimo expurgo em: '"+ lvs_Parametro +"'",Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_exportacao")
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

dw_2.SetRedraw(False)

If gvo_aplicacao.ivo_seguranca.cd_sistema='CR' Then
	This.of_AppendWhere_SubQuery("a.id_tipo_nf in ("+is_Tipo_NF_CR+")", 2)
End If

// Mult
If ls_Contabil = 'M' Then
	This.of_AppendWhere_SubQuery("a.nr_atualizacao< 0", 2)
End If

If Not IsNUll(ldt_Inicio_Movimento) and Not IsNull(ldt_Termino_Movimento) Then
	This.of_AppendWhere_SubQuery("b.dh_documento between '"+String(ldt_Inicio_Movimento, "YYYYMMDD")+"' and '"+String(ldt_Termino_Movimento, "YYYYMMDD")+"'", 2)
End If

If Not IsNUll(ldt_Inicio_Exportacao) and Not IsNull(ldt_Termino_Exportacao) Then
	This.of_AppendWhere_SubQuery("a.dh_exportacao between '"+String(ldt_Inicio_Exportacao, "YYYYMMDD 00:00:00")+"' and '"+String(ldt_Termino_Exportacao, "YYYYMMDD 23:59:59")+"'", 2)
End If

If Not IsNUll(ll_Filial) Then
	This.of_AppendWhere_SubQuery("a.cd_filial = "+String(ll_Filial), 2)
End If

If Not IsNull(ls_Chave) and (Trim(ls_Chave)<>'') Then
	This.of_AppendWhere_SubQuery("a.cd_chave like '%"+ls_Chave+"%'", 2)
End If

If Not IsNull(ls_Divisao) and ls_Divisao <> "" Then
	
	select cd_chave_legado 
	Into :ls_Chave_Legado
	from integracao_sap
	where cd_empresa = 1000
	  and cd_tabela = 'FILIAL'
	  and cd_chave_sap = :ls_Divisao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao localizar o tipo de documento na Mult.")
		Return -1
	End If
	
	If Not IsNull(ls_Chave_Legado) and Trim(ls_Chave_Legado) <> '' Then
		This.of_AppendWhere_SubQuery("a.cd_filial = "+ ls_Chave_Legado, 2)
	End If	
End If

If Not IsNUll(ls_Tipo_Doc) and (ls_Tipo_Doc <> "" )	Then
	This.of_AppendWhere_SubQuery("a.id_tipo_nf = '"+ls_Tipo_Doc+"'", 2)
End If 

If Not IsNull(ll_Tipo_Log) and (ll_Tipo_Log > 0) Then
	This.of_AppendWhere_SubQuery("a.id_tipo_log = "+String(ll_Tipo_Log), 2)
End If

If ls_Caixa = "S" Then
	This.of_AppendWhere_SubQuery("a.id_tipo_nf in ('LC', 'LD')", 2)
End If

If Not IsNUll(ls_Documento_Sap) and (ls_Documento_Sap <> "" )	Then
	This.of_AppendWhere_SubQuery("a.nr_documento_sap = '"+ls_Documento_Sap+"'", 2)
End If

If Not IsNUll(ls_Ambiente_Sap) and (ls_Ambiente_Sap <> "" )	Then
	This.of_AppendWhere_SubQuery("a.cd_ambiente_sap = '"+ls_Ambiente_Sap+"'", 2)
End If

If ls_Status	= "E" Then	//Com erro
	This.of_AppendWhere_SubQuery(	"a.id_status_integracao = 'E'", 2)
		
ElseIf ls_Status = "I" Then	//Integrado
	This.of_AppendWhere_SubQuery("a.id_status_integracao = 'I'", 2)
	
ElseIf ls_Status = "P"	Then	//Processado
	This.of_AppendWhere_SubQuery("a.id_status_integracao = 'P'", 2)
	
ElseIf ls_Status = "C"	Then	//Pendente
	This.of_AppendWhere_SubQuery("a.id_status_integracao = 'C'", 2)
	
ElseIf ls_Status = "W"	Then	//Alerta
	This.of_AppendWhere_SubQuery("a.id_status_integracao = 'W'", 2)
	
ElseIf ls_Status = "X"	Then	//Substituido
	This.of_AppendWhere_SubQuery("a.id_status_integracao = 'X'", 2)
	
//ElseIf ls_Status = "S"	Then	//Sucesso
//	This.of_AppendWhere_SubQuery("a.id_status_integracao = 'S'", 2)
	
ElseIf ls_Status = "A"	Then	//Pedido de Estorno
	This.of_AppendWhere_SubQuery("coalesce(a.id_estornar, 'N') = 'S' and a.dh_estornado_sap is null", 2)
	
ElseIf ls_Status = "B"	Then	//Estornado
	This.of_AppendWhere_SubQuery("coalesce(a.id_estornar, 'N') = 'S' and a.dh_estornado_sap is not null", 2)
	
End If

If Not IsNull(ls_NR_Doc) and Trim(ls_NR_Doc) <> '' Then
	
	if ls_valor_exato = 'S' Then
		This.of_AppendWhere_SubQuery("a.cd_chave = '"  + ls_NR_Doc + "'" , 2)
	else
		This.of_AppendWhere_SubQuery("a.cd_chave like '%"  + ls_NR_Doc + "%'", 2)
	end if
End If

If Not IsNull(ll_Doc_Externo) and ll_Doc_Externo > 0 Then
	This.of_AppendWhere_SubQuery("a.nr_atualizacao = " + String(ll_Doc_Externo), 2)
End If

//messagebox("", String(This.Object.Datawindow.Table.Select))

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

//Busca informa$$HEX2$$e700f500$$ENDHEX$$es da MULT
Try
	SetPointer(HourGlass!)
			
	Open(w_aguarde)
	
	w_aguarde.Title = "Buscando dados do ORACLE (Mult)..."
			
	lo_Trans_Mult = Create dc_uo_transacao
	
	lds_Mult = Create dc_uo_ds_base
	
	//Conecta DB Mult
	If lo_Trans_Mult.of_isConnected() Then lo_Trans_Mult.of_Disconnect()

	If Not gf_conecta_banco_mult(lo_Trans_Mult,IIF(Lower(gvo_aplicacao.ivs_datasource) = 'central', 'CLAMPROD','CLAMTESTE')) Then
		Return -1
	End If
	
	lds_Mult.Of_SetTransObject(lo_Trans_Mult)
	
	If Not lds_Mult.of_ChangeDataObject("ds_ge467_detalhes_mult", False) Then
		Return -1
	End If
	
	If Not IsNUll(ldt_Inicio_Movimento) and Not IsNull(ldt_Termino_Movimento) Then
		lds_Mult.of_AppendWhere_SubQuery("a.dh_lancamento between '"+String(ldt_Inicio_Movimento, "DD/MM/YYYY")+"' and '"+String(ldt_Termino_Movimento, "DD/MM/YYYY")+"'", 3)
	End If
	
	If Not IsNUll(ldt_Inicio_Exportacao) and Not IsNull(ldt_Termino_Exportacao) Then
		//lds_Mult.of_AppendWhere_SubQuery("a.dh_exportacao between '"+String(ldt_Inicio_Exportacao, "YYYYMMDD 00:00:00")+"' and '"+String(ldt_Termino_Exportacao, "YYYYMMDD 23:59:59")+"'", 3)
		
		//dh_exportacao >= TO_DATE('20/10/2018','DD/MM/YYYY') and																											 a.dh_exportacao <= To_Date ('26/10/2018 23:59:59', 'DD/mm/YYYY hh24:mi:ss')
		lds_Mult.of_AppendWhere_SubQuery("dh_exportacao >= TO_DATE('" + String(ldt_Inicio_Exportacao, 'DD/MM/YYYY') + "','DD/MM/YYYY') and a.dh_exportacao <= To_Date ('" + string(ldt_Termino_Exportacao, 'DD/MM/YYYY') + " 23:59:59', 'DD/mm/YYYY hh24:mi:ss')", 3) 
	End If
	
	If ll_Filial = 534 Then
		ll_Filial = 100
	End If
	
	If (ll_Filial = 688) or (ll_Filial = 2) Then
		ll_Filial = 534
	End If
	
	// Sybase
	If ls_Contabil = 'S' Then
		lds_Mult.of_AppendWhere_SubQuery("a.nr_atualizacao< 0", 3)
	End If
	
	If Not IsNull(ll_Tipo_Log) and (ll_Tipo_Log > 0) and (ll_Tipo_Log <> 99) Then
		lds_Mult.of_AppendWhere_SubQuery("a.nr_atualizacao< 0", 3)
	End If
	
	If Not IsNUll(ll_Filial) Then
		lds_Mult.of_AppendWhere_SubQuery("a.cd_filial = "+String(ll_Filial), 3)
	End If
	
	If Not IsNull(ls_Chave) and (Trim(ls_Chave)<>'') Then
		lds_Mult.of_AppendWhere_SubQuery("a.nr_documento_ref like '%"+ls_Chave+"%'", 3)
	End If
	
	If Not IsNull(ls_Chave_Legado) and Trim(ls_Chave_Legado) <> '' Then
		
		If ls_Chave_Legado = '534' Then
			ls_Chave_Legado = '100'
		End If
	
		If (ls_Chave_Legado = '688') or (ls_Chave_Legado = '2') Then
			ls_Chave_Legado = '534'
		End If
				
		lds_Mult.of_AppendWhere_SubQuery("a.cd_filial = "+ls_Chave_Legado, 3)
	End If	
	
	If Not IsNUll(ls_Tipo_Doc) and (ls_Tipo_Doc <> "" )	Then
		lds_Mult.of_AppendWhere_SubQuery("a.cd_tipo_doc_mult = '"+ls_Tipo_Doc+"'", 3)
	End If 
	
	If Not IsNUll(ls_Documento_Sap) and (ls_Documento_Sap <> "" )	Then
		lds_Mult.of_AppendWhere_SubQuery("a.nr_documento_sap = '"+ls_Documento_Sap+"'", 3)
	End If
	
	If ls_Ambiente_Sap <> "T"	Then
		lds_Mult.of_AppendWhere_SubQuery("a.cd_ambiente_sap = '"+ls_Ambiente_Sap+"'", 3)
	End If
	
	If ls_Status	= "E" Then	//Com erro
		lds_Mult.of_AppendWhere_SubQuery("a.id_status_integracao = 'E'", 3)
		
	ElseIf ls_Status = "I" Then	//Integrado
		lds_Mult.of_AppendWhere_SubQuery("a.id_status_integracao = 'I'", 3)
		
	ElseIf ls_Status = "P"	Then	//Processado
		lds_Mult.of_AppendWhere_SubQuery("a.id_status_integracao = 'P'", 3)
	
	ElseIf ls_Status = "C"	Then	//Pendente
		lds_Mult.of_AppendWhere_SubQuery("a.id_status_integracao = 'C'", 3)
	
	ElseIf ls_Status = "W"	Then	//Alerta
		lds_Mult.of_AppendWhere_SubQuery("a.id_status_integracao = 'W'", 3)
		
	ElseIf ls_Status = "X"	Then	//Substituido
		lds_Mult.of_AppendWhere_SubQuery("a.id_status_integracao = 'X'", 3)
		
//	ElseIf ls_Status = "S"	Then	//Sucesso
//		lds_Mult.of_AppendWhere_SubQuery("a.id_status_integracao = 'S'", 3)
		
	ElseIf ls_Status = "A"	Then	//Pedido de Estorno
		lds_Mult.of_AppendWhere_SubQuery("coalesce(a.id_estornar, 'N') = 'S' and a.dh_estornado_sap is null", 3)
	
	ElseIf ls_Status = "B"	Then	//Estornado
		lds_Mult.of_AppendWhere_SubQuery("coalesce(a.id_estornar, 'N') = 'S' and a.dh_estornado_sap is not null", 3)	
		
	End If
	
	If Not IsNull(ls_NR_Doc) and Trim(ls_NR_Doc) <> '' Then
		//lds_Mult.of_AppendWhere_SubQuery("a.nr_documento_ref like '%"  + ls_NR_Doc + "%'", 3)
		
		If ls_valor_exato = 'S' Then
			lds_Mult.of_AppendWhere_SubQuery("a.nr_documento_ref = '"  + ls_NR_Doc + "'", 3)
		Else
			lds_Mult.of_AppendWhere_SubQuery("a.nr_documento_ref like '%"  + ls_NR_Doc + "%'", 3)
		End If
	End If
	
	If Not IsNull(ll_Doc_Externo) and ll_Doc_Externo > 0 Then
		lds_Mult.of_AppendWhere_SubQuery("a.nr_atualizacao = " + String(ll_Doc_Externo), 3)
	End If
	
	//messagebox("", String(lds_Mult.Object.Datawindow.Table.Select))
	
	ll_Linhas = lds_Mult.Retrieve()
	
	w_aguarde.uo_Progress.of_SetMax(ll_Linhas)
	
	If ll_linhas < 0 Then
		This.Reset()
		MessageBox("Erro", "Erro no retrieve da base Oracle (Mult).~rErro: "+lds_Mult.itr_transacao.is_lasterrortext)
		Return -1
	End If
	
	For ll_Linha = 1 To ll_Linhas
		w_aguarde.uo_Progress.of_SetProgress(ll_Linha)
		
		ll_New_Row =	This.InsertRow(0)
		
		This.Object.de_banco								[ll_New_Row]	= lds_Mult.Object.de_banco					[ll_Linha]
		This.Object.cd_filial								[ll_New_Row]	=	lds_Mult.Object.cd_filial					[ll_Linha]
		This.Object.nm_fantasia							[ll_New_Row]	=	lds_Mult.Object.nm_fantasia			[ll_Linha]
		This.Object.nr_atualizacao						[ll_New_Row]	=	lds_Mult.Object.nr_atualizacao			[ll_Linha]
		This.Object.de_tipo_documento				[ll_New_Row]	=	lds_Mult.Object.de_tipo_documento	[ll_Linha]
		This.Object.de_referencia						[ll_New_Row]	=	lds_Mult.Object.de_referencia			[ll_Linha]
		This.Object.nr_documento_sap					[ll_New_Row]	=	lds_Mult.Object.nr_documento_sap	[ll_Linha]
		This.Object.nr_documento_sap_estornado	[ll_New_Row]	=	lds_Mult.Object.nr_documento_sap_estornado	[ll_Linha]
		This.Object.dh_exportacao						[ll_New_Row]	=	lds_Mult.Object.dh_exportacao			[ll_Linha]
		This.Object.dh_estornado_sap					[ll_New_Row]	=	lds_Mult.Object.dh_estornado_sap		[ll_Linha]
		This.Object.dh_documento						[ll_New_Row]	=	lds_Mult.Object.dh_lancamento			[ll_Linha]
		This.Object.qt_erros_itens						[ll_New_Row]	=	lds_Mult.Object.qt_erros_itens			[ll_Linha]
		This.Object.de_erro_cabecalho					[ll_New_Row]	=	lds_Mult.Object.de_erro_cabecalho	[ll_Linha]
		This.Object.id_status_integracao				[ll_New_Row]	=	lds_Mult.Object.id_status_integracao	[ll_Linha]		
		This.Object.id_selecionar						[ll_New_Row]	=	lds_Mult.Object.id_selecionar			[ll_Linha]
		This.Object.id_estornado_excluido				[ll_New_Row]	=	lds_Mult.Object.id_estornado_excluido			[ll_Linha]
			
	Next
	
	This.Sort()
	This.GroupCalc()
	
Finally
	If IsValid(lo_Trans_Mult) Then
		If lo_Trans_Mult.Of_IsConnected() Then	lo_Trans_Mult.Of_disconnect()
		Destroy(lo_Trans_Mult)
	End If
	
	If IsValid(lds_Mult) Then
		Destroy(lds_Mult)
	End If
	
	If IsValid(w_Aguarde) Then
		Close(w_Aguarde)
	End If
	
	SetPointer(Arrow!)
End Try

dw_2.SetRedraw(True)

Return This.RowCount()
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;String	ls_Erro_Item	= "",&
		ls_Erro_Cabecalho = ""

Long	ll_Qt_Erro_Item

If currentRow > 0 Then
	ll_Qt_Erro_Item	= This.Object.qt_erros_itens[currentRow]
	
	If ll_Qt_Erro_Item > 0 Then
		ls_Erro_Item = "H$$HEX1$$c100$$ENDHEX$$ ERROS NOS ITENS DESSE DOCUMENTO"
	End If
	
	ls_Erro_Cabecalho	= This.Object.de_erro_cabecalho[currentRow]
	
	Tab_1.TabPage_1.dw_4.Object.de_erro[1] = ls_Erro_Cabecalho + "  " + ls_Erro_Item
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
integer width = 4347
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
integer x = 5
integer y = 124
integer width = 4320
integer height = 2108
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 41
integer y = 188
integer width = 4261
integer height = 1960
string dataobject = "dw_ge467_detalhes_item"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;
//OverRide

Long	ll_Linha,&
		ll_Nr_Atualizacao,&
		ll_Linhas = 0
		
String	ls_Banco	

dc_uo_transacao	lo_Trans_Mult



Try
	SetPointer(HourGlass!)
	
	lo_Trans_Mult = Create dc_uo_transacao
	
	ll_Linha	= Tab_1.TabPage_1.dw_2.GetRow()
	
	If ll_Linha > 0 Then
		ls_Banco	= Tab_1.TabPage_1.dw_2.Object.de_banco[ll_Linha]
		
		If ls_Banco = "SYB" Then
			Tab_1.TabPage_2.dw_3.Of_SetTransObject(SqlCa)
			
			If (Tab_1.TabPage_1.dw_2.Object.id_tipo_nf[ll_Linha]  = 'LC' or Tab_1.TabPage_1.dw_2.Object.id_tipo_nf[ll_Linha]  = 'LD') Then
				If Not Tab_1.TabPage_2.dw_3.of_ChangeDataObject("dw_ge467_detalhes_item_cx") Then Return 1
			Else
				If Not Tab_1.TabPage_2.dw_3.of_ChangeDataObject("dw_ge467_detalhes_item") Then Return 1
			End If
		Else
			
			If lo_Trans_Mult.of_isConnected() Then lo_Trans_Mult.of_Disconnect()
			
			If Not gf_conecta_banco_mult(lo_Trans_Mult,'CLAMPROD') Then
				Return -1
			End If

			Tab_1.TabPage_2.dw_3.Of_SetTransObject(lo_Trans_Mult)
			
			If Not Tab_1.TabPage_2.dw_3.of_ChangeDataObject("dw_ge467_detalhes_item_oracle") Then Return 1
		End If
		
		ll_Nr_Atualizacao	= Tab_1.TabPage_1.dw_2.Object.nr_atualizacao[ll_Linha]
	
		ll_Linhas	= Tab_1.TabPage_2.dw_3.Retrieve(ll_Nr_Atualizacao)
	
	End If
	
Finally
	If IsValid(lo_Trans_Mult) Then
		If lo_Trans_Mult.Of_IsConnected() Then	lo_Trans_Mult.Of_disconnect()
		Destroy(lo_Trans_Mult)
	End If
	
	SetPointer(Arrow!)
End Try


This.of_SetRowSelection()

This.Modify("nr_conta_contabil_sap.tabsequence=10")
This.Modify("nr_conta_contabil_sap.edit.displayonly=yes")


Return ll_Linhas




	
	



end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_3::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type gb_4 from groupbox within tabpage_1
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
string text = "Erro/Log de Integra$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_1
integer x = 46
integer y = 2044
integer width = 4224
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge467_erro"
end type

type cb_1 from commandbutton within tabpage_1
integer x = 3904
integer y = 40
integer width = 425
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Estornar"
end type

event clicked;Long	ll_Nr_Atualizacao,&
		ll_Find,&
		ll_Linha

String	ls_Banco,&
		ls_Selecionado,&
		ls_Matricula
		
dc_uo_transacao	lo_Trans_Mult		


ll_Find	= Tab_1.TabPage_1.dw_2.Find("id_selecionar = 'S'", 1, Tab_1.TabPage_1.dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Erro", "Erro no Find.")
	Return
End If

If ll_Find	= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum registro selecionado para Estornar.")
	Return
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE467_ESTORNAR_DOCUMENTO", ref ls_Matricula) Then 
	Return
End If

Try
	SetPointer(HourGlass!)
	
	lo_Trans_Mult = Create dc_uo_transacao
	
	Open(w_aguarde)
	
	w_aguarde.Title = "Estornando..."
	
	If lo_Trans_Mult.of_isConnected() Then lo_Trans_Mult.of_Disconnect()
		
	If Not gf_conecta_banco_mult(lo_Trans_Mult,'CLAMPROD') Then
		Return -1
	End If
	
	w_aguarde.uo_Progress.of_SetMax(Tab_1.TabPage_1.dw_2.RowCount())
	
	For ll_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
		
		w_aguarde.uo_Progress.of_SetProgress(ll_Linha)
		
		ls_Selecionado		= Tab_1.TabPage_1.dw_2.Object.id_selecionar		[ll_Linha]
		
		If ls_Selecionado = "S" Then
			ll_Nr_Atualizacao	= Tab_1.TabPage_1.dw_2.Object.nr_atualizacao	[ll_Linha]
			ls_Banco				= Tab_1.TabPage_1.dw_2.Object.de_banco		[ll_Linha]
			
			If ls_Banco = "SYB" Then
				wf_Estorno_Sybase(ll_Nr_Atualizacao)
			ElseIf ls_Banco = 'MULT' Then
				wf_Estorno_Oracle(lo_Trans_Mult, ll_Nr_Atualizacao)
			Else
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de banco n$$HEX1$$e300$$ENDHEX$$o previsto '" + ls_Banco + "'.", StopSign!)
			End If	
		End If
		
	Next
	
Finally
	If IsValid(lo_Trans_Mult) Then
		If lo_Trans_Mult.Of_IsConnected() Then	lo_Trans_Mult.Of_disconnect()
		Destroy(lo_Trans_Mult)
	End If
	
	If IsValid(w_Aguarde) Then
		Close(w_Aguarde)
	End If
	
	SetPointer(Arrow!)
End Try


dw_2.Event ue_Recuperar()

	
	



end event

type cb_2 from commandbutton within tabpage_1
integer x = 3904
integer y = 348
integer width = 425
integer height = 100
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
		ls_Matricula
		
dc_uo_transacao	lo_Trans_Mult		


ll_Find	= Tab_1.TabPage_1.dw_2.Find("id_selecionar = 'S'", 1, Tab_1.TabPage_1.dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Erro", "Erro no Find.")
	Return
End If

If ll_Find	= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum registro selecionado para Reenviar.")
	Return
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE467_REENVIAR_DOCUMENTO", ref ls_Matricula) Then 
	Return
End If

Try
	SetPointer(HourGlass!)
	
	lo_Trans_Mult = Create dc_uo_transacao
	
	Open(w_aguarde)
	
	w_aguarde.Title = "Reenviando..."
	
	If lo_Trans_Mult.of_isConnected() Then lo_Trans_Mult.of_Disconnect()
		
	If Not gf_conecta_banco_mult(lo_Trans_Mult,'CLAMPROD') Then
		Return -1
	End If
	
	w_aguarde.uo_Progress.of_SetMax(Tab_1.TabPage_1.dw_2.RowCount())
	
	For ll_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
		
		w_aguarde.uo_Progress.of_SetProgress(ll_Linha)
		
		ls_Selecionado		= Tab_1.TabPage_1.dw_2.Object.id_selecionar		[ll_Linha]
		
		If ls_Selecionado = "S" Then
			ll_Nr_Atualizacao	= Tab_1.TabPage_1.dw_2.Object.nr_atualizacao	[ll_Linha]
			ls_Banco				= Tab_1.TabPage_1.dw_2.Object.de_banco		[ll_Linha]
			
			If ls_Banco = "SYB" Then
				wf_Deleta_Registro_Sybase(ll_Nr_Atualizacao)
			ElseIf ls_Banco = "MULT" Then
				wf_Deleta_Registro_Oracle(lo_Trans_Mult, ll_Nr_Atualizacao)
			Else
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de banco n$$HEX1$$e300$$ENDHEX$$o previsto '" + ls_Banco + "'.", StopSign!)
			End If	
		End If
	Next
	
Finally
	If IsValid(lo_Trans_Mult) Then
		If lo_Trans_Mult.Of_IsConnected() Then	lo_Trans_Mult.Of_disconnect()
		Destroy(lo_Trans_Mult)
	End If
	
	If IsValid(w_Aguarde) Then
		Close(w_Aguarde)
	End If
	
	SetPointer(Arrow!)
End Try

dw_2.Event ue_Recuperar()


	
	



end event

type pb_1 from picturebutton within tabpage_1
integer x = 3776
integer y = 40
integer width = 114
integer height = 96
integer taborder = 30
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

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"O documento ser$$HEX1$$e100$$ENDHEX$$ marcado para ser estornado.~r~rO programa de interface dever$$HEX1$$e100$$ENDHEX$$ ser executado para estornar no SAP.~r~r"+&
								"Apenas documentos com a situa$$HEX2$$e700e300$$ENDHEX$$o INTEGRADO poder$$HEX1$$e300$$ENDHEX$$o ser estornados.")
end event

type pb_2 from picturebutton within tabpage_1
integer x = 3776
integer y = 348
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

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"O registro do documento ser$$HEX1$$e100$$ENDHEX$$ exclu$$HEX1$$ed00$$ENDHEX$$do do bando de dados.~r~r"+&
								"Dever$$HEX1$$e100$$ENDHEX$$ ser executado o programa de interface para enviar o documento novamente para o SAP.~r~r"+&
								"Apenas documentos com a situa$$HEX2$$e700e300$$ENDHEX$$o ERRO DE INTEGRA$$HEX2$$c700c300$$ENDHEX$$O poder$$HEX1$$e300$$ENDHEX$$o ser reenviados.~r~r" +&
								"O registro ser$$HEX1$$e100$$ENDHEX$$ apagado das tabelas: log_exportacao_sap_aux, log_exportacao_sap_historico e log_exportacao_sap.")
end event

type cb_3 from commandbutton within tabpage_1
integer x = 3904
integer y = 188
integer width = 425
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Ignorar Docto"
end type

event clicked;Long ll_Pos, ll_Linha, ll_Aut, ll_Nr_Atualizacao

String ls_Erro, ls_Status, ls_Matricula, ls_Banco, lvs_usuario

lvs_usuario = 'Ignorado-'+string(gvo_aplicacao.ivo_seguranca.nr_matricula)

Tab_1.TabPage_1.dw_2.AcceptText()

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione o documento.')
	Return
End If

ll_Linha	= Tab_1.TabPage_1.dw_2.GetRow()

ls_Erro 				= Tab_1.TabPage_1.dw_2.Object.de_erro_cabecalho[ll_Linha]
ll_Nr_Atualizacao	= Tab_1.TabPage_1.dw_2.Object.nr_atualizacao	[ll_Linha]
ls_Banco				= Tab_1.TabPage_1.dw_2.Object.de_banco	[ll_Linha]

//ll_Pos = Pos(ls_Erro, "documento cont$$HEX1$$e900$$ENDHEX$$m partidas compens.")

//If ll_Pos <= 0 Then
//	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Somente documento de estorno que possui partidas compessadas.')
//	Return
//End If

If ls_Banco <> 'MULT' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta funcionalidade $$HEX1$$e900$$ENDHEX$$ somente para a MULT.")
	Return
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE467_RETIRAR_DOCUMENTO", ref ls_Matricula) Then 
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a retirada do documento da lista de logs [O DOC N$$HEX1$$c300$$ENDHEX$$O SER$$HEX1$$c100$$ENDHEX$$ MAIS ENVIADO] ?.",Question!, YesNo!, 2) = 2 Then
	Return
End If

dc_uo_transacao lo_Trans_Mult

Try
	SetPointer(HourGlass!)
	
	lo_Trans_Mult = Create dc_uo_transacao
	
	Open(w_aguarde)
	
	w_aguarde.Title = "Retirando DOC..."
	
	If lo_Trans_Mult.of_isConnected() Then lo_Trans_Mult.of_Disconnect()
		
	If Not gf_conecta_banco_mult(lo_Trans_Mult,'CLAMPROD') Then
		Return -1
	End If
	
	Select	id_status_integracao 
	Into	:ls_Status
	From log_exportacao_sap
	Where nr_atualizacao = :ll_Nr_Atualizacao
	Using lo_Trans_Mult;
	
	Choose Case lo_Trans_Mult.SqlCode
		Case 0
			If ls_Status <> "E" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(ll_Nr_Atualizacao)+"' n$$HEX1$$e300$$ENDHEX$$o pode ser retirado da lista porque o status est$$HEX1$$e100$$ENDHEX$$ diferente de ERRO.")
			End If
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(ll_Nr_Atualizacao)+"'.")
			Return
		Case -1
			MessageBox("Erro", "Erro no select da 'log_exportacao_sap', banco SYBASE: "+lo_Trans_Mult.SqlErrText)
			Return
	End Choose
			
	select coalesce(min(nr_atualizacao), 0) -1 
	Into :ll_Aut
	from log_exportacao_sap
	Using lo_Trans_Mult;
	
	If lo_Trans_Mult.SqlCode = -1 Then
		ls_Erro	= "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial do log_exportacao_sap ': "+ lo_Trans_Mult.SqlErrText
		lo_Trans_Mult.of_RollBack()
		MessageBox("Erro", ls_Erro)
		Return
	End If
	

	
	
	INSERT INTO LOG_EXPORTACAO_SAP ( NR_ATUALIZACAO, CD_EMPRESA,DH_DOCUMENTO, DH_LANCAMENTO,CD_TIPO_DOCUMENTO, NR_DOCUMENTO_REF,DE_TEXTO, CD_MOEDA,   
															  CD_FILIAL, NR_IDF_DOCTO,ID_SITUACAO_DOCTO, ID_STATUS_INTEGRACAO,DH_EXPORTACAO,NR_DOCUMENTO_SAP, DH_ESTORNADO_SAP,   
															  DH_EXCLUIDO_SAP, CD_TIPO_DOC_MULT, DE_TIPO_DOC_MULT, DE_ERRO, CD_AMBIENTE_SAP, ID_ESTORNAR,QT_LANCAMENTO, NR_DOCUMENTO_SAP_ESTORNADO, CD_CHAVE_INTERFACE )  
	 
	select :ll_Aut, CD_EMPRESA,DH_DOCUMENTO,DH_LANCAMENTO, CD_TIPO_DOCUMENTO, NR_DOCUMENTO_REF, DE_TEXTO, CD_MOEDA, CD_FILIAL,NR_IDF_DOCTO * -1, ID_SITUACAO_DOCTO,   
				  'P', DH_EXPORTACAO, :lvs_usuario ,DH_ESTORNADO_SAP, DH_EXCLUIDO_SAP, CD_TIPO_DOC_MULT, DE_TIPO_DOC_MULT,'SOMENTE PARA N$$HEX1$$c300$$ENDHEX$$O ENVIAR NOVAMENTE O DOC',CD_AMBIENTE_SAP, ID_ESTORNAR,   
				  QT_LANCAMENTO, NR_DOCUMENTO_SAP_ESTORNADO, CD_CHAVE_INTERFACE 
	from log_exportacao_sap
	where nr_atualizacao = :ll_Nr_Atualizacao
	Using lo_Trans_Mult;
	
	If lo_Trans_Mult.SqlCode = -1 Then
		ls_Erro	= "Erro ao inserir o registro no log_exportacao_sap '"+String(ll_Aut)+"': "+ lo_Trans_Mult.SqlErrText
		lo_Trans_Mult.of_RollBack()
		MessageBox("Erro", ls_Erro)
		Return
	End If
	
	If lo_Trans_Mult.SqlNRows <> 1 Then
		ls_Erro	= "Foi inclu$$HEX1$$ed00$$ENDHEX$$do mais registros que o esperado na log_exportacao_sap '"+String(ll_Aut)+"': "+ lo_Trans_Mult.SqlErrText
		lo_Trans_Mult.of_RollBack()
		MessageBox("Erro", ls_Erro)
		Return
	End If
	
	Update LOG_EXPORTACAO_SAP
	Set id_status_integracao = 'P', nr_documento_sap = :lvs_usuario
	Where nr_atualizacao = :ll_Nr_Atualizacao
	Using lo_Trans_Mult;
	
	If lo_Trans_Mult.SqlCode = -1 Then
		ls_Erro	= "Erro ao atualizar o status e o n$$HEX1$$fa00$$ENDHEX$$mero do doc sap da atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(ll_Nr_Atualizacao)+"': "+ lo_Trans_Mult.SqlErrText
		lo_Trans_Mult.of_RollBack()
		MessageBox("Erro", ls_Erro)
		Return
	End If
	
	If lo_Trans_Mult.SqlNRows <> 1 Then
		ls_Erro	= "Foi atualizado mais registros que o esperado na log_exportacao_sap '"+String(ll_Aut)+"': "+ lo_Trans_Mult.SqlErrText
		lo_Trans_Mult.of_RollBack()
		MessageBox("Erro", ls_Erro)
		Return
	End If
		
	lo_Trans_Mult.of_commit();		
	
Finally
	If IsValid(lo_Trans_Mult) Then
		If lo_Trans_Mult.Of_IsConnected() Then	lo_Trans_Mult.Of_disconnect()
		Destroy(lo_Trans_Mult)
	End If
	
	If IsValid(w_Aguarde) Then
		Close(w_Aguarde)
	End If
	
	SetPointer(Arrow!)
End Try

dw_2.Event ue_Recuperar()




end event

type pb_4 from picturebutton within tabpage_1
integer x = 3781
integer y = 188
integer width = 114
integer height = 100
integer taborder = 60
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

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Apenas documentos que n$$HEX1$$e300$$ENDHEX$$o puderam ser estornados no SAP e com a situa$$HEX2$$e700e300$$ENDHEX$$o ERRO DE INTEGRA$$HEX2$$c700c300$$ENDHEX$$O.~r~r"+&
							 "Impede novos envios deste documento.")
end event

type cb_processar from commandbutton within tabpage_1
boolean visible = false
integer x = 3867
integer y = 2036
integer width = 402
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Processar"
end type

event clicked;long ll_linhas, ll_for, ll_nr_atualizacao, ll_pos, ll_pos_fim, ll_existe, ll_Aut_Localizada
string ls_erro, ls_nr_doc, ls_marcado, ls_Data
dc_uo_transacao lo_Trans_Mult

Open(w_Aguarde)

lo_Trans_Mult = Create dc_uo_transacao
	
//Conecta DB Mult
If lo_Trans_Mult.of_isConnected() Then lo_Trans_Mult.of_Disconnect()

If Not gf_conecta_banco_mult(lo_Trans_Mult,'CLAMPROD') Then
	Return -1
End If

ls_Data = '01-01-' +  string(Year(today())) + ' 00:00'

ll_linhas = tab_1.tabpage_1.dw_2.rowcount()	

Try
	
	for ll_for = 1 to ll_linhas	
		
		ll_nr_atualizacao = tab_1.tabpage_1.dw_2.object.nr_atualizacao[ll_for]
		ls_erro = tab_1.tabpage_1.dw_2.object.de_erro_cabecalho[ll_for]
		ls_marcado = tab_1.tabpage_1.dw_2.object.id_selecionar[ll_for]
		
		if ls_marcado <> 'S' Then Continue
		
		ll_pos = pos(ls_erro, 'Documento j$$HEX1$$e100$$ENDHEX$$ foi processado')
		
		if ll_pos = 0 Then Continue
		
		ll_pos = pos(ls_erro, 'Doc SAP:', ll_pos)
		
		if ll_pos = 0 Then Continue
		
		ll_pos_fim = pos(ls_erro,',',ll_pos)
		
		if ll_pos_fim = 0 then Continue
		
		ll_pos = ll_pos + len('Doc SAP:')
		
		ls_nr_doc = mid(ls_erro, ll_pos, ll_pos_fim - ll_pos)
		
		if ls_nr_doc = '' or isnull(ls_nr_doc) Then Continue
		
		Select count(*)
		into :ll_existe
		from log_exportacao_sap
		where nr_documento_sap = :ls_nr_doc
		   and dh_exportacao > To_Date (:ls_Data, 'DD-mm-YYYY hh24:mi' )
		Using lo_Trans_Mult ;
		
		if lo_Trans_Mult.sqlcode = -1 then
			ls_erro = lo_Trans_Mult.sqlerrtext
			Rollback Using lo_Trans_Mult;
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela "log_exportacao_sap" na base de dados Mult: ' + ls_erro)
			return -1
		end if
		
		if ll_existe= 1 Then
			
			Select nr_atualizacao
			into :ll_Aut_Localizada
			from log_exportacao_sap
			where nr_documento_sap = :ls_nr_doc
				and dh_exportacao > To_Date (:ls_Data, 'DD-mm-YYYY hh24:mi' )
			Using lo_Trans_Mult ;
			
			if lo_Trans_Mult.sqlcode = -1 then
				ls_erro = lo_Trans_Mult.sqlerrtext
				Rollback Using lo_Trans_Mult;
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela "log_exportacao_sap" na base de dados Mult: ' + ls_erro)
				return -1
			end if
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc externo " + String(ll_Aut_Localizada) + " j$$HEX1$$e100$$ENDHEX$$ esta utilizando o doc SAP: " + ls_nr_doc + ".", Exclamation!)
			
			Continue
							
		ElseIf ll_existe > 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foram localizados mais de um registro com o doc SAP: "  + ls_nr_doc + ".", Exclamation!)
			Continue
		end if
				
		Update log_exportacao_sap
		set id_status_integracao = 'P', nr_documento_sap = :ls_nr_doc //, de_erro = de_erro || '(Processado manualmente)'
		where nr_atualizacao = :ll_nr_atualizacao
		Using lo_Trans_Mult ;
		
		if lo_Trans_Mult.sqlcode = -1 then
			ls_erro = lo_Trans_Mult.sqlerrtext
			Rollback Using lo_Trans_Mult;
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao atualizar a tabela "log_exportacao_sap" na base de dados Mult: ' + ls_erro)
			return -1
		else
			
			Commit Using lo_Trans_Mult;
			
		end if
		
		
	next
			
Finally
		
	Disconnect Using lo_Trans_Mult;
	Destroy(lo_Trans_Mult)
	
	If IsValid(w_Aguarde) Then
		Close(w_Aguarde)
	End If

End Try

Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Registros processados com sucesso.')

dw_2.Event ue_Recuperar()
end event

type cbx_1 from checkbox within tabpage_2
integer x = 46
integer y = 36
integer width = 1335
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Mostrar apenas os itens com erro de integra$$HEX2$$e700e300$$ENDHEX$$o"
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

type st_confirmar from statictext within w_ge467_monitor_integracao_sap
boolean visible = false
integer x = 3168
integer y = 724
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
long backcolor = 15793151
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
boolean focusrectangle = false
end type

