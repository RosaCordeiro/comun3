HA$PBExportHeader$w_ge467_monitor_integracao_sap_old.srw
forward
global type w_ge467_monitor_integracao_sap_old from dc_w_2tab_consulta_selecao_lista_det
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
type cbx_1 from checkbox within tabpage_2
end type
type st_confirmar from statictext within w_ge467_monitor_integracao_sap_old
end type
end forward

global type w_ge467_monitor_integracao_sap_old from dc_w_2tab_consulta_selecao_lista_det
integer width = 4457
integer height = 2572
string title = "GE467 - Monitor Intergra$$HEX2$$e700e300$$ENDHEX$$o SAP"
st_confirmar st_confirmar
end type
global w_ge467_monitor_integracao_sap_old w_ge467_monitor_integracao_sap_old

type variables
uo_filial io_filial

Boolean ivb_Check
end variables

forward prototypes
public subroutine wf_deleta_registro_sybase (long al_nr_atualizacao)
public subroutine wf_deleta_registro_oracle (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao)
public subroutine wf_estorno_sybase (long al_nr_atualizacao)
public subroutine wf_estorno_oracle (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao)
end prototypes

public subroutine wf_deleta_registro_sybase (long al_nr_atualizacao);String	ls_Status,&
		ls_Erro
		
Long	ll_Qt_Erros_Itens		

Select	id_status_integracao 
Into	:ls_Status
From log_exportacao_sap
Where nr_atualizacao = :al_Nr_Atualizacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Status <> "E" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"' n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ reenviado porque o status est$$HEX1$$e100$$ENDHEX$$ diferente de ERRO.")
		Else
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

Select	id_status_integracao 
Into	:ls_Status
From log_exportacao_sap
Where nr_atualizacao = :al_Nr_Atualizacao
Using ao_Trans_Mult;

Choose Case ao_Trans_Mult.SqlCode
	Case 0
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

on w_ge467_monitor_integracao_sap_old.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
end on

on w_ge467_monitor_integracao_sap_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_confirmar)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.dt_inicio_exportacao			[1] = RelativeDate(Date(gf_GetServerDate()),  -30)
Tab_1.TabPage_1.dw_1.Object.dt_termino_exportacao		[1] = Date(gf_GetServerDate())


Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)


end event

event open;call super::open;io_Filial = Create uo_Filial

ivb_Check = False
end event

event close;call super::close;Destroy(io_Filial)
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge467_monitor_integracao_sap_old
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge467_monitor_integracao_sap_old
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge467_monitor_integracao_sap_old
integer width = 4384
integer height = 2364
end type

event tab_1::selectionchanged;//OverRide

Tab_1.TabPage_2.cbx_1.Checked = False
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4347
integer height = 2248
gb_4 gb_4
dw_4 dw_4
cb_1 cb_1
cb_2 cb_2
pb_1 pb_1
pb_2 pb_2
end type

on tabpage_1.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.pb_1=create pb_1
this.pb_2=create pb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.pb_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.pb_1)
destroy(this.pb_2)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 27
integer y = 460
integer width = 4288
integer height = 1600
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3685
integer height = 428
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 46
integer width = 3621
integer height = 340
string dataobject = "dw_ge467_selecao"
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
integer x = 64
integer y = 532
integer width = 4224
integer height = 1512
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
		ll_Doc_Externo

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
		ls_NR_Doc
		
Tab_1.TabPage_1.dw_1.AcceptText()		

ldt_Inicio_Exportacao		= Tab_1.TabPage_1.dw_1.Object.dt_inicio_exportacao			[1]
ldt_Termino_Exportacao	= Tab_1.TabPage_1.dw_1.Object.dt_termino_exportacao		[1]
ldt_Inicio_Movimento		= Tab_1.TabPage_1.dw_1.Object.dt_inicio_movimentacao		[1]
ldt_Termino_Movimento	= Tab_1.TabPage_1.dw_1.Object.dt_termino_movimentacao	[1]
ll_Filial						= Tab_1.TabPage_1.dw_1.Object.cd_filial							[1]
ls_Tipo_Doc					= Tab_1.TabPage_1.dw_1.Object.id_tipo_doc						[1]
ls_Documento_Sap		= Tab_1.TabPage_1.dw_1.Object.nr_documento_sap			[1]
ls_Ambiente_Sap			= Tab_1.TabPage_1.dw_1.Object.cd_ambiente_sap				[1]
ls_Status						= Tab_1.TabPage_1.dw_1.Object.id_status							[1]
ls_Caixa						= Tab_1.TabPage_1.dw_1.Object.id_caixa							[1]
ls_Contabil					= Tab_1.TabPage_1.dw_1.Object.	id_contabilizacao				[1]
ls_NR_Doc					= Tab_1.TabPage_1.dw_1.Object.	nr_documento					[1]
ll_Doc_Externo				= Tab_1.TabPage_1.dw_1.Object.	nr_documento_externo		[1]

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

dw_2.SetRedraw(False)

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

If Not IsNUll(ls_Tipo_Doc) and (ls_Tipo_Doc <> "" )	Then
	This.of_AppendWhere_SubQuery("a.id_tipo_nf = '"+ls_Tipo_Doc+"'", 2)
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
	
//ElseIf ls_Status = "S"	Then	//Sucesso
//	This.of_AppendWhere_SubQuery("a.id_status_integracao = 'S'", 2)
	
ElseIf ls_Status = "A"	Then	//Pedido de Estorno
	This.of_AppendWhere_SubQuery("coalesce(a.id_estornar, 'N') = 'S' and a.dh_estornado_sap is null", 2)
	
ElseIf ls_Status = "B"	Then	//Estornado
	This.of_AppendWhere_SubQuery("coalesce(a.id_estornar, 'N') = 'S' and a.dh_estornado_sap is not null", 2)
	
End If

If Not IsNull(ls_NR_Doc) and Trim(ls_NR_Doc) <> '' Then
	This.of_AppendWhere_SubQuery("a.cd_chave like '%"  + ls_NR_Doc + "%'", 2)
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

	If Not gf_conecta_banco_mult(lo_Trans_Mult,'CLAMPROD') Then
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
	
	If Not IsNUll(ll_Filial) Then
		lds_Mult.of_AppendWhere_SubQuery("a.cd_filial = "+String(ll_Filial), 3)
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
		
//	ElseIf ls_Status = "S"	Then	//Sucesso
//		lds_Mult.of_AppendWhere_SubQuery("a.id_status_integracao = 'S'", 3)
		
	ElseIf ls_Status = "A"	Then	//Pedido de Estorno
		lds_Mult.of_AppendWhere_SubQuery("coalesce(a.id_estornar, 'N') = 'S' and a.dh_estornado_sap is null", 3)
	
	ElseIf ls_Status = "B"	Then	//Estornado
		lds_Mult.of_AppendWhere_SubQuery("coalesce(a.id_estornar, 'N') = 'S' and a.dh_estornado_sap is not null", 3)	
		
	End If
	
	If Not IsNull(ls_NR_Doc) and Trim(ls_NR_Doc) <> '' Then
		lds_Mult.of_AppendWhere_SubQuery("a.nr_documento_ref like '%"  + ls_NR_Doc + "%'", 3)
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
integer height = 2248
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
integer height = 2012
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
integer y = 2076
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
string text = "Erro de Integra$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_1
integer x = 46
integer y = 2128
integer width = 4224
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge467_erro"
end type

type cb_1 from commandbutton within tabpage_1
integer x = 3904
integer y = 52
integer width = 402
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
integer y = 216
integer width = 402
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
integer x = 3790
integer y = 52
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
integer x = 3790
integer y = 216
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
								"Apenas documentos com a situa$$HEX2$$e700e300$$ENDHEX$$o ERRO DE INTEGRA$$HEX2$$c700c300$$ENDHEX$$O poder$$HEX1$$e300$$ENDHEX$$o ser reenviados.")
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

type st_confirmar from statictext within w_ge467_monitor_integracao_sap_old
boolean visible = false
integer x = 3168
integer y = 664
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

