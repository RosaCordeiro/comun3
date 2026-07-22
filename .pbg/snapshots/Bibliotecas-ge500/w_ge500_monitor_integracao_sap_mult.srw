HA$PBExportHeader$w_ge500_monitor_integracao_sap_mult.srw
forward
global type w_ge500_monitor_integracao_sap_mult from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_1
end type
type cb_reenviar from commandbutton within tabpage_1
end type
type cb_marcar_integrado from commandbutton within tabpage_1
end type
type pb_3 from picturebutton within tabpage_1
end type
type pb_2 from picturebutton within tabpage_1
end type
type cbx_1 from checkbox within tabpage_2
end type
type st_confirmar from statictext within w_ge500_monitor_integracao_sap_mult
end type
end forward

global type w_ge500_monitor_integracao_sap_mult from dc_w_2tab_consulta_selecao_lista_det
string accessiblename = "GE500 Monitor Notas Servico SAP"
integer width = 5088
integer height = 2448
string title = "GE500 - Monitor Notas Fiscais - Integra$$HEX2$$e700e300$$ENDHEX$$o SAP/Mult"
st_confirmar st_confirmar
end type
global w_ge500_monitor_integracao_sap_mult w_ge500_monitor_integracao_sap_mult

type variables
uo_filial io_filial

Boolean ivb_Check
end variables

forward prototypes
public subroutine wf_deleta_registro_sybase (long al_nr_atualizacao)
public subroutine wf_estorno_sybase (long al_nr_atualizacao)
public subroutine wf_estorno_oracle (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao)
public subroutine wf_insere_padrao ()
public function boolean wf_grava_log (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao, ref string as_log)
public function long wf_retorna_filial (long pl_filial)
end prototypes

public subroutine wf_deleta_registro_sybase (long al_nr_atualizacao);String	ls_Status,&
		ls_Erro
		
Date ldh_Exportacao
Date ldh_Parametro
		
Long	ll_Qt_Erros_Itens		

ldh_Parametro = Date(gf_GetSerVerDate())

Select	 dh_exportacao
Into	 :ldh_Exportacao
From log_exportacao_mult
Where nr_atualizacao = :al_Nr_Atualizacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		// Permitir o reenvio
//		If (ls_Status = 'I' or ls_Status = 'C') Then
//			ls_Status = "E"
//		End If
//				
//		If ls_Status <> "E" Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"' n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ reenviado porque o status est$$HEX1$$e100$$ENDHEX$$ diferente de ERRO.")
//		Else
//			Delete From log_exportacao_mult
//			Where nr_atualizacao	= :al_Nr_Atualizacao
//			Using SqlCa;
			
			Update log_exportacao_mult
			Set id_situacao_log = 'X', dh_exclusao = GetDate(), de_log = ''
			Where nr_atualizacao	= :al_Nr_Atualizacao
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

///* Ambiente SAP */
//ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_ambiente_sap" )			
//
//ldwc_Child.SetItem(1, "cd_ambiente_sap", ""	)
//ldwc_Child.SetItem(1, "de_ambiente_sap", "TODOS")
//ldwc_Child.SetItem(1, "ordem", -1)
//
//ldwc_Child.SetFilter("cd_ambiente_sap <> 'XXX'")
//ldwc_Child.Filter()

//Tab_1.Tabpage_1.dw_1.Object.cd_ambiente_sap[1] = "PRD"

Tab_1.Tabpage_1.dw_1.Object.id_tipo_log[1] = 1
Tab_1.Tabpage_1.dw_1.Object.id_tipo_doc[1] = 'T'   // 'SR'
Tab_1.TabPage_1.dw_1.Object.id_status	[1] = 'P'

/* Tipo Doc */
//ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("id_tipo_doc" )			

//ldwc_Child.SetItem(1, "id_tipo_nf", ""	)
//ldwc_Child.SetItem(1, "de_tipo_nf", "TODOS")
//Tab_1.Tabpage_1.dw_1.Object.id_tipo_doc[1] = ""
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

public function long wf_retorna_filial (long pl_filial);Long ll_Filial

Choose Case pl_filial
	Case 1, 534 // ESTOQUE CENTRAL
		ll_Filial = 100
	Case 2, 688	// MATRIZ E MANIP. JOINVILLE
		ll_Filial = 534
	Case 809		// FARMAGORA
		ll_Filial = 790
	Case 695 	//JOINVILLE_DE
		ll_Filial = 149
	Case 696		//JARAGUA_DE
		ll_Filial = 84
	Case 699		//DE_FLORIPA
		ll_Filial = 301
	Case 700		//BLUMENAU_DE
		ll_Filial = 136
	Case 701		//CRICIUMA_DE
		ll_Filial = 107
	Case 704		//ITAJAI_DE
		ll_Filial = 71
	Case 705 	//LAGES_DE
		ll_Filial = 42
	Case 708 	//TUBAR$$HEX1$$c300$$ENDHEX$$O_DE
		ll_Filial = 550
	Case	709	//BALNEARIO CAMBORIU_DE					
		ll_Filial = 592
	Case 712	  	//CHAPECO_DE
		ll_Filial = 39
	Case 733	 	//GASPAR_DE
		ll_Filial = 330
	Case Else		
		ll_Filial = pl_filial
End Choose

Return ll_Filial
end function

on w_ge500_monitor_integracao_sap_mult.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
end on

on w_ge500_monitor_integracao_sap_mult.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_confirmar)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.dt_inicio_exportacao	[1] = RelativeDate(Date(gf_GetServerDate()),  -6)
Tab_1.TabPage_1.dw_1.Object.dt_termino_exportacao	[1] = Date(gf_GetServerDate())

wf_insere_padrao()

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)

Tab_1.TabPage_1.cb_reenviar.Event Post ue_atualiza_status()
Tab_1.TabPage_1.cb_marcar_integrado.Event Post ue_atualiza_status()
end event

event open;call super::open;io_Filial = Create uo_Filial

ivb_Check = False
end event

event close;call super::close;Destroy(io_Filial)
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge500_monitor_integracao_sap_mult
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge500_monitor_integracao_sap_mult
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge500_monitor_integracao_sap_mult
integer x = 23
integer y = 16
integer width = 5006
integer height = 2228
end type

event tab_1::selectionchanged;//OverRide

Tab_1.TabPage_2.cbx_1.Checked = False
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4969
integer height = 2112
gb_4 gb_4
cb_reenviar cb_reenviar
cb_marcar_integrado cb_marcar_integrado
pb_3 pb_3
pb_2 pb_2
end type

on tabpage_1.create
this.gb_4=create gb_4
this.cb_reenviar=create cb_reenviar
this.cb_marcar_integrado=create cb_marcar_integrado
this.pb_3=create pb_3
this.pb_2=create pb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.cb_reenviar
this.Control[iCurrent+3]=this.cb_marcar_integrado
this.Control[iCurrent+4]=this.pb_3
this.Control[iCurrent+5]=this.pb_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.cb_reenviar)
destroy(this.cb_marcar_integrado)
destroy(this.pb_3)
destroy(this.pb_2)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 41
integer y = 344
integer width = 4896
integer height = 1756
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 37
integer width = 4050
integer height = 324
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 59
integer y = 72
integer width = 4014
integer height = 260
string dataobject = "dw_ge500_selecao"
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
integer x = 69
integer y = 400
integer width = 4837
integer height = 1684
string dataobject = "dw_ge500_detalhes"
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
		ll_Tipo_Log,&
		ll_Nr_NF
		
String ls_sql	

dc_uo_transacao	lo_transacao_SYB
dc_uo_ds_base		lds_SYB

Date	ldt_Inicio_Movimento,&
		ldt_Termino_Movimento,&
		ldt_Inicio_Exportacao,&
		ldt_Termino_Exportacao, &
		ldt_inicio_lancto, &
		ldt_termino_lancto
		
String	ls_Tipo_Doc,&
		ls_Documento_Sap,&
		ls_Ambiente_Sap,&
		ls_Status,&
		ls_Tipo_Doc_Mult,&
		ls_Tipo_Documento,&
		ls_NR_Doc,&
		ls_Chave_Legado,&
		ls_Divisao,&
		ls_Chave
		
Tab_1.TabPage_1.dw_1.AcceptText()		

ldt_Inicio_Exportacao	= Tab_1.TabPage_1.dw_1.Object.dt_inicio_exportacao			[1]
ldt_Termino_Exportacao	= Tab_1.TabPage_1.dw_1.Object.dt_termino_exportacao		[1]
ldt_Inicio_Movimento		= Tab_1.TabPage_1.dw_1.Object.dt_inicio_movimentacao		[1]
ldt_Termino_Movimento	= Tab_1.TabPage_1.dw_1.Object.dt_termino_movimentacao		[1]
ldt_inicio_lancto			= Tab_1.TabPage_1.dw_1.Object.dt_inicio_lancto				[1]
ldt_termino_lancto		= Tab_1.TabPage_1.dw_1.Object.dt_termino_lancto				[1]
ll_Filial					= Tab_1.TabPage_1.dw_1.Object.cd_filial						[1]
ls_Tipo_Doc 				= Tab_1.TabPage_1.dw_1.Object.id_tipo_doc						[1]
ls_Documento_Sap			= Tab_1.TabPage_1.dw_1.Object.nr_documento_sap				[1]
ls_Status					= Tab_1.TabPage_1.dw_1.Object.id_status						[1]
ls_NR_Doc					= Tab_1.TabPage_1.dw_1.Object.nr_documento_sap				[1]
ll_Doc_Externo				= Tab_1.TabPage_1.dw_1.Object.nr_documento_externo			[1]
ls_Chave						= Tab_1.TabPage_1.dw_1.Object.cd_chave							[1]
ll_Tipo_Log					= Tab_1.TabPage_1.dw_1.Object.id_tipo_log						[1]
ls_Divisao					= String(Tab_1.TabPage_1.dw_1.Object.nr_divisao_sap		[1])
ll_Nr_NF						= Parent.dw_1.Object.nr_nf [1]

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

If ldt_inicio_lancto > ldt_termino_lancto Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio de lan$$HEX1$$e700$$ENDHEX$$amento n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino de lan$$HEX1$$e700$$ENDHEX$$amento.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_lancto")
	Return -1
End If

//If ls_Ambiente_Sap = "T" Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o ambiente SAP.", Information!)
//	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "cd_ambiente_sap")
//	Return -1
//End If

// Processado
If ls_Status = 'I'  or  ls_Status = 'T' Then
	If DaysAfter ( ldt_Inicio_Exportacao, ldt_Termino_Exportacao ) > 31 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Devido ao grande volume de informa$$HEX2$$e700f500$$ENDHEX$$es, o per$$HEX1$$ed00$$ENDHEX$$odo entre as datas de exporta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser superior a 31 dias.")
		Return -1
	End If
	
	If IsNull(ll_Filial) and IsNull(ls_Documento_Sap) and IsNull(ls_NR_Doc) and IsNull(ls_Tipo_Doc) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos um par$$HEX1$$e200$$ENDHEX$$metro [FILIAL, DOC. SAP, NR DOC ou TIPO DE DOC].")
		Return -1
	End If
End If

dw_2.SetRedraw(False)

If Not IsNUll(ldt_Inicio_Movimento) and Not IsNull(ldt_Termino_Movimento) Then
	This.of_AppendWhere_SubQuery(" cast(jdoc.docdat as date)  between '"+String(ldt_Inicio_Movimento, "YYYY-MM-DD")+"' and '"+String(ldt_Termino_Movimento, "YYYY-MM-DD")+"'", 1)
End If

If Not IsNUll(ldt_inicio_lancto) and Not IsNull(ldt_termino_lancto) Then
	This.of_AppendWhere_SubQuery(" cast(jdoc2.pstdat as date)  between '"+String(ldt_inicio_lancto, "YYYY-MM-DD")+"' and '"+String(ldt_termino_lancto, "YYYY-MM-DD")+"'", 1)
End If

If Not IsNUll(ldt_Inicio_Exportacao) and Not IsNull(ldt_Termino_Exportacao) Then
	This.of_AppendWhere_SubQuery("lem.dh_exportacao between '"+String(ldt_Inicio_Exportacao, "YYYY-MM-DD 00:00:00")+"' and '"+String(ldt_Termino_Exportacao, "YYYY-MM-DD 23:59:59")+"'", 1)
End If

// N$$HEX1$$e300$$ENDHEX$$o tem ambiente sap na tabela de log(log_exportacao_mult)
//If Not IsNUll(ls_Ambiente_Sap) and (ls_Ambiente_Sap <> "" )	Then
//	This.of_AppendWhere_SubQuery("lem.cd_ambiente_sap  = '"+ls_Ambiente_Sap+"'", 1)
//End If

ls_sql = this.Object.DataWindow.Table.Select

If Not IsNUll(ll_Filial) Then
	This.of_AppendWhere_SubQuery("f.cd_filial = "+String(ll_Filial), 1)
End If

If ll_Nr_NF > 0 Then
	This.of_AppendWhere_SubQuery("jdoc2.nfnum = "+String(ll_Nr_NF), 1)
End If

If Not IsNull(ls_Divisao) and ls_Divisao <> "" Then
	This.of_AppendWhere_SubQuery("jdoc.branch = "+ls_Divisao, 1)
End If

If Not IsNUll(ls_Tipo_Doc) and (ls_Tipo_Doc <> "" )	Then
	If ls_Tipo_Doc = 'T' then 
		This.of_AppendWhere_SubQuery("upper(jdoc2.nftype) IN ('SR','S1','T1','U1','SY','SE') ", 1) /* A1 $$HEX1$$e900$$ENDHEX$$ estorno, n$$HEX1$$e300$$ENDHEX$$o deve exibir e os tipos ZK e Cx s$$HEX1$$e300$$ENDHEX$$o fretes e n$$HEX1$$e300$$ENDHEX$$o devem exibir, por enqto*/
	 else
		This.of_AppendWhere_SubQuery("upper(jdoc2.nftype) = '"+upper(ls_Tipo_Doc)+"'", 1)
	End If
End If 

If Not IsNull(ls_NR_Doc) and Trim(ls_NR_Doc) <> '' Then  /* Belnr- SAP */
		This.of_AppendWhere_SubQuery("jdoc.belnr = '"  + ls_NR_Doc + "'" , 1)
End If

If Not IsNull(ll_Doc_Externo) and ll_Doc_Externo > 0 Then
	This.of_AppendWhere_SubQuery("lem.nr_atualizacao = " + String(ll_Doc_Externo),1)
End If

If ls_Status = "T" Then
	This.of_AppendWhere_SubQuery("coalesce(lem.id_situacao_log,'C') <> 'X'",1)
ElseIf ls_Status = "P" Then
	This.of_AppendWhere_SubQuery("coalesce(lem.id_situacao_log,'C') IN ('E','R','C')", 1)
Else
	This.of_AppendWhere_SubQuery("coalesce(lem.id_situacao_log,'C') = '"+ls_Status+"'", 1)
End If

ls_sql = this.Object.DataWindow.Table.Select

If This.Retrieve(1000) < 0 Then
	This.Reset()
	Return -1
End If

ll_Linhas = This.RowCount()

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

event dw_2::rowfocuschanged;call super::rowfocuschanged;String	ls_Erro
String ls_lf = char(13)
String ls_cr = char(10)


Long	ll_Qt_Erro_Item

If currentRow > 0 Then
	ls_Erro	= This.Object.de_erro_cabecalho[currentRow]
	
	ls_erro = Trim(ls_erro)
	
	ls_erro = gf_replace(ls_erro, '"', '',0)
	
	ls_erro = gf_replace(ls_erro, ls_lf, '',0)
	ls_erro = gf_replace(ls_erro, ls_cr, '',0)
	
	Tab_1.TabPage_1.dw_2.Object.de_erro_f.Text = ls_Erro
Else
	Tab_1.TabPage_1.dw_2.Object.de_erro_f.Text = ''
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

Parent.cb_reenviar.Event Post ue_Atualiza_Status()
Parent.cb_marcar_integrado.Event Post ue_Atualiza_Status()
end event

event dw_2::constructor;call super::constructor;// Habilitar a linha de sele$$HEX2$$e700e300$$ENDHEX$$o (list)
This.of_SetRowSelection()

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;if pl_linhas > 0 Then
	This.Post Event Rowfocuschanged( 1 )
end If

Return AncestorReturnValue
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Tab_1.TabPage_1.dw_2.Object.de_erro_f.Text = ''

Return AncestorReturnValue
end event

event dw_2::itemchanged;call super::itemchanged;Boolean lvb_Habilita

If Dwo.Name = "id_selecionar" Then
	Parent.cb_reenviar.Event Post ue_Atualiza_Status()
	Parent.cb_marcar_integrado.Event Post ue_Atualiza_Status()
End If
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4969
integer height = 2112
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
integer y = 24
integer width = 4521
integer height = 2128
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 32
integer y = 80
integer width = 4480
integer height = 2016
string dataobject = "ds_ge500_item_detalhes"
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;
//OverRide

Long	ll_Linha,&
		ll_Nr_Exportacao,&
		ll_Linhas = 0, &
		ll_Cd_Filial, &
		lvl_docnum, &
		lvl_nr_sequencial
				
String	ls_Banco, &
         lvs_filial_sap, &
		lvs_mandt	

Try
	SetPointer(HourGlass!)
	
ll_Linha	= Tab_1.TabPage_1.dw_2.GetRow()

If ll_Linha > 0 Then
	  
		lvs_filial_sap		= Tab_1.TabPage_1.dw_2.Object.filial_sap			[ll_Linha]
		lvs_mandt			= Tab_1.TabPage_1.dw_2.Object.mandt		 		[ll_Linha]
		lvl_docnum			= Tab_1.TabPage_1.dw_2.Object.docnum			[ll_Linha]
		lvl_nr_sequencial	= Tab_1.TabPage_1.dw_2.Object.nr_sequencial	[ll_Linha]
		
		Tab_1.TabPage_2.dw_3.Retrieve(1000, lvs_filial_sap, lvs_mandt, lvl_docnum,  lvl_nr_sequencial)
		ll_Linhas	= dw_3.rowcount()
		
		If ll_Linhas <=0 then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o encontrou nenhum registro com as informa$$HEX2$$e700f500$$ENDHEX$$es da sele$$HEX2$$e700e300$$ENDHEX$$o.")
		End If	
	
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
integer width = 3721
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
string text = "Erro de Integra$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type cb_reenviar from commandbutton within tabpage_1
event ue_atualiza_status ( )
integer x = 4311
integer y = 80
integer width = 507
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Reenviar"
end type

event ue_atualiza_status();Boolean lvb_Habilita

lvb_Habilita = (Tab_1.TabPage_1.dw_2.Find("id_selecionar='S'", 1,Tab_1.TabPage_1.dw_2.RowCount())>0 and gvo_Aplicacao.ivo_Seguranca.of_acesso_procedimento("GE500_REENVIAR_DOCUMENTO"))
This.Enabled = lvb_Habilita
end event

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

ls_sit_log		= Tab_1.TabPage_1.dw_2.Object.id_situacao_log [ll_Find]
If ls_sit_log = 'X' then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Item selecionado j$$HEX1$$e100$$ENDHEX$$ foi exclu$$HEX1$$ed00$$ENDHEX$$do, para Reenviar, favor executar a rotina de Exporta$$HEX2$$e700e300$$ENDHEX$$o deste tipo de NF.")
	Return
End If	

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE500_REENVIAR_DOCUMENTO", ref ls_Matricula) Then 
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
			ll_Nr_Atualizacao	= Tab_1.TabPage_1.dw_2.Object.nr_atualizacao	[ll_Linha]
			ls_Banco				= Tab_1.TabPage_1.dw_2.Object.de_banco			[ll_Linha]
			
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

type cb_marcar_integrado from commandbutton within tabpage_1
event ue_atualiza_status ( )
integer x = 4311
integer y = 200
integer width = 507
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Marcar Integrado"
end type

event ue_atualiza_status();Boolean lvb_Habilita

lvb_Habilita = (Tab_1.TabPage_1.dw_2.Find("id_selecionar='S' and (id_situacao_log='R' or id_situacao_log='E')", 1,Tab_1.TabPage_1.dw_2.RowCount())>0 and gvo_Aplicacao.ivo_Seguranca.of_acesso_procedimento("GE500_IGNORAR_DOCUMENTO"))
This.Enabled = lvb_Habilita
end event

event clicked;Long	ll_Nr_Atualizacao, &
		ll_Find, &
		ll_Reg_Att, &
		ll_Linha

String	ls_Matricula, &
			ls_Sit_log

Try
	Tab_1.TabPage_1.dw_2.SetRedraw(False)
	ll_Reg_Att = 0
	
	/* Verifica se foi marcado algum registro v$$HEX1$$e100$$ENDHEX$$lido para essa opera$$HEX2$$e700e300$$ENDHEX$$o */
	ll_Find	= Tab_1.TabPage_1.dw_2.Find("id_selecionar = 'S' and (id_situacao_log = 'R' or id_situacao_log = 'E')", 1, Tab_1.TabPage_1.dw_2.RowCount())
	
	If ll_Find	= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum registro selecionado para Marcar como Integrado.")
		Return
	End If
	
	/* Verifica se foram marcados registros com erros */
	ll_Find	= Tab_1.TabPage_1.dw_2.Find("id_selecionar = 'S' and id_situacao_log = 'X'", 1, Tab_1.TabPage_1.dw_2.RowCount())

	If ll_Find < 0 Then
		MessageBox("Erro", "Erro no Find de registros exclu$$HEX1$$ed00$$ENDHEX$$dos.")
		Return
	ElseIf ll_Find > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe(m) item(ns) selecionado(s) com status EXCLU$$HEX1$$cd00$$ENDHEX$$DO, eles n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o afetados pela opera$$HEX2$$e700e300$$ENDHEX$$o de ignorar.")
		Return
	End If
	
	/* Verifica se foram marcados registros integrados */
	ll_Find	= Tab_1.TabPage_1.dw_2.Find("id_selecionar = 'S' and id_situacao_log = 'I'", 1, Tab_1.TabPage_1.dw_2.RowCount())

	If ll_Find < 0 Then
		MessageBox("Erro", "Erro no Find de registros integrados.")
		Return
	ElseIf ll_Find > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe(m) item(ns) selecionado(s) com status INTEGRADO, eles n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o afetados pela opera$$HEX2$$e700e300$$ENDHEX$$o de ignorar.")
		Return
	End If
		
	
//	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE500_IGNORAR_DOCUMENTO", ref ls_Matricula) Then 
//		Return
//	End If
	
	SetPointer(HourGlass!)
	
	Open(w_aguarde)
	
	w_aguarde.Title = "Marcando Registros Selecionados como Integrados..."
	
	/* Filtra registros selecionados */
	Tab_1.TabPage_1.dw_2.SetFilter("id_selecionar = 'S'")
	Tab_1.TabPage_1.dw_2.Filter()
	
	w_aguarde.uo_Progress.of_SetMax(Tab_1.TabPage_1.dw_2.RowCount())
	
	For ll_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
		
		w_aguarde.uo_Progress.of_SetProgress(ll_Linha)
		
		ls_Sit_log		= Tab_1.TabPage_1.dw_2.Object.id_situacao_log		[ll_Linha]
		
		//Situa$$HEX2$$e700f500$$ENDHEX$$es: erro ou revisar
		If ls_Sit_log = 'E' or ls_Sit_log='R' Then
			ll_Reg_Att++
			ll_Nr_Atualizacao	= Tab_1.TabPage_1.dw_2.Object.nr_atualizacao	[ll_Linha]
			
			UPDATE log_exportacao_mult
			SET id_situacao_log = 'I', //Integrado
				 de_log = 'MARCADO COMO INTEGRADO VIA MONITOR POR '||:gvo_aplicacao.ivo_seguranca.nr_matricula,
				 dh_processamento = getdate()
			WHERE nr_atualizacao = :ll_Nr_Atualizacao
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then
				SQLCa.Of_Rollback()
				SQLCa.Of_Msgdberror( "Falha ao atualizar o log.")
			Else
				SQLCa.Of_Commit()
			End If
		End If
	Next
	
Finally
	If IsValid(w_Aguarde) Then	Close(w_Aguarde)
	Tab_1.TabPage_1.dw_2.SetFilter("")
	Tab_1.TabPage_1.dw_2.Filter()
	Tab_1.TabPage_1.dw_2.SetRedraw(True)
	SetPointer(Arrow!)
	
	Choose Case ll_Reg_Att
		Case 0
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum registro atualizado.', Exclamation!)
		Case 1
			Messagebox('Sucesso', 'Foi atualizado '+String(ll_Reg_Att)+' registro.')
		Case Else
			Messagebox('Sucesso', 'Foram atualizados '+String(ll_Reg_Att)+' registros.')
	End Choose
End Try

dw_2.Event ue_Recuperar()
end event

type pb_3 from picturebutton within tabpage_1
integer x = 4174
integer y = 200
integer width = 114
integer height = 100
integer taborder = 80
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

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"O(s) registro(s) selecionado(s) ser$$HEX1$$e100$$ENDHEX$$($$HEX1$$e300$$ENDHEX$$o) marcado(s) como INTEGRADO.~r~r"+&
								"Ou seja, o(s) log(s) selecionado(s) n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$($$HEX1$$e300$$ENDHEX$$o) mais exibido(s) e sua(s) nota(s) ficar$$HEX1$$e100$$ENDHEX$$($$HEX1$$e300$$ENDHEX$$o) marcada(s) como integrada(s) com sucesso. ~r~r"+&
								"Devido a isso execute essa funcionalidade apenas para notas que j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e300$$ENDHEX$$o certas dentro do Mult-M3.")
end event

type pb_2 from picturebutton within tabpage_1
integer x = 4174
integer y = 80
integer width = 114
integer height = 100
integer taborder = 40
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

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"O registro do documento ser$$HEX1$$e100$$ENDHEX$$ marcado para Exclus$$HEX1$$e300$$ENDHEX$$o.~r~r"+&
								"Dever$$HEX1$$e100$$ENDHEX$$ ser executado o programa de interface para enviar o documento novamente do SAP para Mult.~r~r"+&
								"Ser$$HEX1$$e100$$ENDHEX$$ importante excluir o documento na Mult, caso contr$$HEX1$$e100$$ENDHEX$$rio, o reenvio causar$$HEX1$$e100$$ENDHEX$$ duplicidade.")
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

type st_confirmar from statictext within w_ge500_monitor_integracao_sap_mult
boolean visible = false
integer x = 3922
integer y = 524
integer width = 846
integer height = 68
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

