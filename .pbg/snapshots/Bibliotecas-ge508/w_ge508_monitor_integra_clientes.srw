HA$PBExportHeader$w_ge508_monitor_integra_clientes.srw
$PBExportComments$Monitor Integra$$HEX2$$e700e300$$ENDHEX$$o Lote Cont$$HEX1$$e100$$ENDHEX$$bil Sap para Mult
forward
global type w_ge508_monitor_integra_clientes from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_1
end type
type cb_reprocessar from commandbutton within tabpage_1
end type
type pb_2 from picturebutton within tabpage_1
end type
type pb_4 from picturebutton within tabpage_1
end type
type cb_revisar from commandbutton within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cbx_1 from checkbox within tabpage_2
end type
type st_confirmar from statictext within w_ge508_monitor_integra_clientes
end type
end forward

global type w_ge508_monitor_integra_clientes from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge508_monitor_integra_clientes"
integer width = 5559
integer height = 2544
boolean enabled = false
string title = "GE508 - Monitor Integra$$HEX2$$e700e300$$ENDHEX$$o Clientes - Sybase/SAP"
st_confirmar st_confirmar
end type
global w_ge508_monitor_integra_clientes w_ge508_monitor_integra_clientes

type variables
//uo_filial io_filial

Boolean ivb_Check

dc_uo_transacao 	ivtr_geral
end variables

forward prototypes
public subroutine wf_estorno_sybase (long al_nr_atualizacao)
public subroutine wf_insere_padrao ()
public subroutine wf_deleta_registro_sybase (long al_nr_atualizacao, string as_ambiente_sap, string as_matricula)
end prototypes

public subroutine wf_estorno_sybase (long al_nr_atualizacao);Datetime ldh_Estornado

String	ls_Status,&
		ls_Erro,&
		ls_DocEstornado,&
		ls_Doc_SAP
		
//Select		coalesce(id_status_integracao, ''), nr_documento_sap_estornado, dh_estornado_sap, nr_documento_sap
//Into	:ls_Status, :ls_DocEstornado, :ldh_Estornado, :ls_Doc_SAP
//From log_exportacao_sap
//Where nr_atualizacao = :al_Nr_Atualizacao
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//	Case 0
//				
//		If Not IsNull(ls_DocEstornado) Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
//							"Motivo: Documento de estorno.", Exclamation!)
//			Return 
//		End If
//		
//		If Not IsNull(ldh_Estornado) Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
//							"Motivo: J$$HEX1$$e100$$ENDHEX$$ foi enviado o estorno para o SAP.", Exclamation!)
//			Return 
//		End If
//		
//		If ls_Status <> "P" Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
//							"Motivo: Apenas documentos com o status PROCESSADO poder$$HEX1$$e300$$ENDHEX$$o ser estornados..", Exclamation!)
//			Return 
//		Else
//			
//			If IsNull(ls_Doc_SAP) Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O doc. externo [" + String(al_Nr_Atualizacao) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser estornado. ~r~r" +&
//								"Motivo: Documento ainda n$$HEX1$$e300$$ENDHEX$$o foi processado no SAP.", Exclamation!)
//				Return 
//			End If
//						
//			Update log_exportacao_sap
//			Set id_estornar = 'S'
//			Where nr_atualizacao	= :al_Nr_Atualizacao
//			Using SqlCa;
//			
//			If SqlCa.SqlNRows <> 1 Then
//				SqlCa.of_RollBack()
//				MessageBox("Erro", "No UPDATE da 'log_exportacao_sap' deveria ter atualizado 1 registro, atualizou "+String(SqlCa.SqlNRows)+" registros. N$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"'. ")
//				Return
//			End If
//			
//			If SqlCa.SqlCode = -1 Then
//				ls_Erro	= "Erro no UPDATE da 'log_exportacao_sap' com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"': "+ SqlCa.SqlErrText
//				SqlCa.of_RollBack()
//				MessageBox("Erro", ls_Erro)
//				Return
//			End If
//			
//			SqlCa.of_Commit()
//		End If
//	Case 100
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"'.")
//	Case -1
//		MessageBox("Erro", "Erro no select da 'log_exportacao_sap', banco ORACLE: "+SqlCa.SqlErrText)
//End Choose
end subroutine

public subroutine wf_insere_padrao ();Long ll_Row
DataWindowChild	ldwc_Child

/* Ambiente SAP */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_ambiente_sap" )			

ldwc_Child.SetItem(1, "cd_ambiente_sap", "TODOS"	)

ldwc_Child.SetFilter("cd_ambiente_sap <> 'XXX'")
ldwc_Child.Filter()

Tab_1.Tabpage_1.dw_1.Object.cd_ambiente_sap[1] = "PRD"


end subroutine

public subroutine wf_deleta_registro_sybase (long al_nr_atualizacao, string as_ambiente_sap, string as_matricula);String	ls_Status,&
		ls_Erro, &
		ls_dt_param, &
		ls_CpfCnpj
		
Date 		ldh_Exportacao
Date 		ldh_Parametro
Datetime ldth_Parametro
		
Long	ll_Qt_Erros_Itens		

ldth_Parametro = gf_GetSerVerDate()
ldh_Parametro  = Date(ldth_Parametro)
ls_dt_param     = String(ldh_Parametro, 'dd/mm/yyyy')

Select	 dh_exportacao, nr_cpf_cgc
Into	 :ldh_Exportacao, :ls_CpfCnpj
From  cliente_exportacao_sap
Where nr_sequencial 		= :al_Nr_Atualizacao
   and  cd_ambiente_sap = :as_ambiente_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		// Permitir o reenvio
		   	Update cliente_exportacao_sap
			Set id_status = 'X', de_erro = "Item marcado para exclus$$HEX1$$e300$$ENDHEX$$o em " + :ls_dt_param,  /* dh_exportacao = :ldh_Exportacao */
			       nr_matricula_revisao = :as_matricula ,  dh_revisao = :ldth_Parametro, id_revisado = 'S'
			Where nr_sequencial	 = :al_Nr_Atualizacao
			and  cd_ambiente_sap = :as_ambiente_sap
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro	= "Erro ao atualizar a exclus$$HEX1$$e300$$ENDHEX$$o no 'log_exportacao_mult' com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"': "+ SqlCa.SqlErrText
				SqlCa.of_RollBack()
				MessageBox("Erro", ls_Erro)
				Return
			End If			
		
			/* Atualizar$$HEX1$$e100$$ENDHEX$$ as tabelas origem, para que este cliente seja reenviado pela rotina de Exporta$$HEX2$$e700e300$$ENDHEX$$o de Clientes - ell100.pbl */
			Setnull(ldh_Exportacao)
			// Atualiza Cliente
			Update cliente
				Set dh_exportacao_sap =:ldh_Exportacao
					Where 	nr_cpf_cgc	    =:ls_CpfCnpj
					Using SqlCa;
					
			If SqlCa.SqlCode = -1 Then
					MessageBox("Erro", "Erro ao atualizar o c$$HEX1$$f300$$ENDHEX$$digo do cliente SAP na tabela 'cliente', banco SYBASE: " +" CGC/CPF :"+ls_CpfCnpj+' ErroSQL:'+SqlCa.SqlerrText)
					Return
			End If
					
			// Atualiza Cliente Ecommerce
			Update cliente_ecommerce
				Set dh_exportacao_sap =:ldh_Exportacao
					Where 	nr_cpf_cgc 		=:ls_CpfCnpj
					Using SqlCa;
					
			If SqlCa.SqlCode = -1 Then
					MessageBox("Erro", "Erro ao atualizar o c$$HEX1$$f300$$ENDHEX$$digo do cliente SAP na tabela 'cliente_ecommerce', banco SYBASE: " +" CGC/CPF :"+ls_CpfCnpj+' ErroSQL:'+SqlCa.SqlerrText)
					Return
			End If
					
			// Atualiza Convenio
			Update convenio
				Set dh_exportacao_sap = :ldh_Exportacao
					Where 	nr_cgc=:ls_CpfCnpj
					Using 	SqlCA;
			
				If SqlCa.SqlCode = -1 Then
					MessageBox("Erro", "Erro ao atualizar o c$$HEX1$$f300$$ENDHEX$$digo do cliente SAP na tabela 'convenio', banco SYBASE: " +" CGC/CPF :"+ls_CpfCnpj+' ErroSQL:'+SqlCa.SqlerrText)
					Return
				End If
					
			// Atualiza Cliente Cheque 
			Update cliente_cheque
				Set dh_exportacao_sap	=	:ldh_Exportacao
					Where nr_cpf =:ls_CpfCnpj
					Using SqlCA;
					
				If SqlCa.SqlCode = -1 Then
					MessageBox("Erro", "Erro ao atualizar o c$$HEX1$$f300$$ENDHEX$$digo do cliente SAP na tabela 'cliente_cheque', banco SYBASE: " +" CGC/CPF :"+ls_CpfCnpj+' ErroSQL:'+SqlCa.SqlerrText)
					Return
				End If
							
			Sqlca.of_Commit();
			
//		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro com o n$$HEX1$$fa00$$ENDHEX$$mero de atualiza$$HEX2$$e700e300$$ENDHEX$$o '"+String(al_Nr_Atualizacao)+"'.")
	Case -1
		MessageBox("Erro", "Erro no select da 'cliente_exportacao_sap', banco SYBASE: "+SqlCa.SqlErrText)
End Choose
end subroutine

on w_ge508_monitor_integra_clientes.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
end on

on w_ge508_monitor_integra_clientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_confirmar)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.dt_inicio_exportacao			[1] = RelativeDate(Date(gf_GetServerDate()),  -6)
Tab_1.TabPage_1.dw_1.Object.dt_termino_exportacao		[1] = Date(gf_GetServerDate())
Tab_1.TabPage_1.dw_1.Object.id_status						[1] = 'Y'  /* ERRO_TODOS */
Tab_1.TabPage_1.dw_1.Object.id_revisado				    		[1] = '' 

wf_insere_padrao()

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)




end event

event open;call super::open;ivb_Check = False
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge508_monitor_integra_clientes
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge508_monitor_integra_clientes
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge508_monitor_integra_clientes
integer y = 12
integer width = 5499
integer height = 2280
end type

event tab_1::selectionchanged;//OverRide

Tab_1.TabPage_2.cbx_1.Checked = False
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 5463
integer height = 2164
gb_4 gb_4
cb_reprocessar cb_reprocessar
pb_2 pb_2
pb_4 pb_4
cb_revisar cb_revisar
dw_4 dw_4
cb_1 cb_1
end type

on tabpage_1.create
this.gb_4=create gb_4
this.cb_reprocessar=create cb_reprocessar
this.pb_2=create pb_2
this.pb_4=create pb_4
this.cb_revisar=create cb_revisar
this.dw_4=create dw_4
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.cb_reprocessar
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.pb_4
this.Control[iCurrent+5]=this.cb_revisar
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.cb_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.cb_reprocessar)
destroy(this.pb_2)
destroy(this.pb_4)
destroy(this.cb_revisar)
destroy(this.dw_4)
destroy(this.cb_1)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 0
integer y = 464
integer width = 5445
integer height = 1672
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 0
integer y = 28
integer width = 3081
integer height = 412
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 27
integer y = 92
integer width = 3035
integer height = 340
string dataobject = "dw_ge508_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long	ll_Nulo

//If dwo.Name = "nm_fantasia" Then
//	
//	SetNull(ll_Nulo)
//	
//	If data = "" or IsNull(data) Then
//		This.Object.cd_filial[1] = ll_Nulo
//	Else
//		If Data <> io_filial.nm_fantasia Then Return 1
//	End If	
//	
//End If
//
//If dwo.Name = 'id_caixa' and Data = 'S' Then
//	This.Object.id_contabilizacao[1] = 'S'
//End If
end event

event dw_1::ue_key;call super::ue_key;//String	ls_Coluna,&
//		ls_Filial
//
//If Key = KeyEnter! Then
//
//	ls_Coluna = This.GetColumnName()
//
//	If ls_Coluna = "nm_fantasia" Then
//
//		ls_Filial = Tab_1.TabPage_1.dw_1.GetText()
//
//		io_Filial.of_Localiza_Filial(ls_Filial)
//		
//		// Verifica se a Filial foi localizada e atualiza a DW
//		If io_Filial.Localizada  Then
//			Tab_1.TabPage_1.dw_1.Object.cd_filial			[1] = io_Filial.cd_filial
//			Tab_1.TabPage_1.dw_1.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
//		Else
//		
//			SetNull(io_Filial.Cd_Filial)
//			io_Filial.Nm_Fantasia = ""
//			
//			Tab_1.TabPage_1.dw_1.Object.cd_filial			[1] = io_filial.cd_filial
//			Tab_1.TabPage_1.dw_1.Object.nm_fantasia	[1] = io_filial.nm_fantasia
//			
//		End If
//		
//	End If
//End If
end event

event dw_1::constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
event ue_mousemove pbm_mousemove
event ue_atualiza_botoes ( )
integer x = 37
integer y = 512
integer width = 5385
integer height = 1608
string dataobject = "dw_ge508_detalhes"
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

event dw_2::ue_atualiza_botoes();If This.RowCount() > 0 Then
	Parent.cb_reprocessar.Enabled = (This.Find("id_selecionar='S'", 1, This.RowCount()) > 0)
	Parent.cb_revisar.Enabled = Parent.cb_reprocessar.Enabled
Else
	Parent.cb_reprocessar.Enabled = False
	Parent.cb_revisar.Enabled = False
End If
end event

event dw_2::ue_recuperar;//OverRide

Long	ll_Linhas,&
		ll_Linha,&
		ll_New_Row
		
String ls_sql		

dc_uo_transacao    lo_transacao_SYB
dc_uo_ds_base 	 lds_SYB

//If Not This.of_ChangeDataObject("dw_ge508_detalhes") Then Return 1

dw_2.SetRedraw(False)

ls_sql = this.Object.DataWindow.Table.Select

If This.Retrieve() < 0 Then
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
This.of_SetRowSelection( '', 'if( id_status_integracao = "X", rgb(255, 0, 0), if( CurrentRow()=GetRow(), rgb(255,255,255), rgb(0,0,0) ))', False )



end event

event dw_2::ue_reset;call super::ue_reset;Parent.cb_reprocessar.Enabled = False
Parent.cb_revisar.Enabled 		= False


end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Parent.cb_reprocessar.Enabled 	= False
Parent.cb_revisar.Enabled 			= False

ivm_menu.mf_SalvarComo( pl_linhas > 0 )

ivb_Check = False
	
Return AncestorReturnValue
end event

event dw_2::itemchanged;call super::itemchanged;This.Post Event ue_Atualiza_Botoes()
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Status
String lvs_Ambiente
String lvs_Nr_Cpf_Cgc
String lvs_Revisao
String lvs_Excluido
String lvs_Cli_SAP
String lvs_Integracao
String lvs_Sql

Long lvl_Filial
Decimal{0} lvdc_Transacao

Date lvdt_Export_Ini
Date lvdt_Export_Fim

Parent.dw_1.Accepttext( )

lvs_Status			= Parent.dw_1.Object.id_status						[1]
lvs_Ambiente		= Parent.dw_1.Object.cd_ambiente_sap				[1]
lvs_Nr_Cpf_Cgc		= Parent.dw_1.Object.nr_cpf_cgc						[1]
lvdt_Export_Ini		= Parent.dw_1.Object.dt_inicio_exportacao			[1]
lvdt_Export_Fim	= Parent.dw_1.Object.dt_termino_exportacao		[1]
lvs_Revisao			= Parent.dw_1.Object.id_revisado						[1]
lvs_Cli_SAP			= Parent.dw_1.Object.nr_cli_sap						[1]

If lvs_Ambiente <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Ambiente: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_ambiente_sap)',1)")
	This.Of_AppendWhere_Subquery( "a.cd_ambiente_sap = '"+ lvs_Ambiente+"'", 1)
End If

If lvs_Revisao <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Status Revis$$HEX1$$e300$$ENDHEX$$o: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_revisado)',1)")
	This.Of_AppendWhere_Subquery( "coalesce(a.id_revisado,'P') = '"+ lvs_Revisao+"'", 1)	
End If

If lvs_Status <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Status Log: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_status)',1)")
	If lvs_Status = "Y" Then
		This.Of_AppendWhere_Subquery( "a.id_status in ('E', 'F', 'V')", 1)
	Else
		If lvs_Status <> "T" Then 
		   This.Of_AppendWhere_Subquery( "a.id_status = '"+ lvs_Status+"'", 1)
		End If
	End If	
End If

// Processado - Aguardando retorno SAP
If (lvs_Status = 'P' or lvs_Status = 'I')  Then
	If DaysAfter ( lvdt_Export_Ini, lvdt_Export_Fim ) > 7 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Devido ao grande n$$HEX1$$fa00$$ENDHEX$$mero de integra$$HEX2$$e700f500$$ENDHEX$$es, o Per$$HEX1$$ed00$$ENDHEX$$odo entre as datas de exporta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser superior $$HEX1$$e000$$ENDHEX$$ 7 dias.")
		Return -1
	End If
End If

If Not IsNull(lvdt_Export_Ini) and (lvdt_Export_Ini >= Date("2020/09/01")) Then
	If IsNull(lvdt_Export_Fim) or (lvdt_Export_Fim < Date("2020/09/01")) Then lvdt_Export_Fim = lvdt_Export_Ini
	
	If lvdt_Export_Fim < lvdt_Export_Ini Then
		Parent.dw_1.Event ue_Pos(1, "dt_termino_exportacao")
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data final de exporta$$HEX2$$e700e300$$ENDHEX$$o", Exclamation!)
		Return -1
	End If
	
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Data Exporta$$HEX2$$e700e300$$ENDHEX$$o: "+String(lvdt_Export_Ini, "DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(lvdt_Export_Fim, "DD/MM/YYYY")
	This.Of_AppendWhere_Subquery( "a.dh_exportacao >= '"+ String(lvdt_Export_Ini, "YYYY.MM.DD")+"' and a.dh_exportacao < '"+ String(RelativeDate(lvdt_Export_Fim, 1), "YYYY.MM.DD")+"'", 1)
End If

If lvs_Nr_Cpf_Cgc <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Cpf/Cnpj: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(nr_cpf_cgc)',1)")
	This.Of_AppendWhere_Subquery( "a.nr_cpf_cgc = '"+ lvs_Nr_Cpf_Cgc+"'", 1)	
End If

If lvs_Cli_SAP <> "" Then
	This.ivs_Filtro_Relatorio [ UpperBound(This.ivs_Filtro_Relatorio) + 1] = "Cliente SAP: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(nr_cli_sap)',1)")
	This.Of_AppendWhere_Subquery( "a.cd_cliente_sap = '"+ lvs_Cli_SAP+"'", 1)	
End If

lvs_Sql = This.Object.DataWindow.Table.Select

Return AncestorReturnValue
end event

event dw_2::ue_printimmediate;//override
This.Event ue_Imprimir_Relatorio( This.Title, "CL", True)
end event

event dw_2::ue_print;//override
This.Event ue_Imprimir_Relatorio( This.Title, "CL", False)
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
boolean visible = false
integer width = 5463
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
string dataobject = "dw_ge508_detalhes_item"
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

type cb_reprocessar from commandbutton within tabpage_1
integer x = 3301
integer y = 60
integer width = 494
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
string text = "Reprocessar"
end type

event clicked;Long	ll_Nr_Atualizacao,&
		ll_Find,&
		ll_Linha

String	ls_Banco,&
		ls_Selecionado,&
		ls_Matricula, &
		ls_sit_log, &
		ls_Ambiente_Sap

ll_Find	= Tab_1.TabPage_1.dw_2.Find("id_selecionar = 'S'", 1, Tab_1.TabPage_1.dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Erro", "Erro no Find.")
	Return
End If

If ll_Find	= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum registro selecionado para Reenviar.")
	Return
End If

ls_sit_log				= Tab_1.TabPage_1.dw_2.Object.id_status_integracao [ll_Find]

If ls_sit_log = 'X' then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Item selecionado j$$HEX1$$e100$$ENDHEX$$ foi exclu$$HEX1$$ed00$$ENDHEX$$do, para Reenviar, favor solicitar $$HEX1$$e000$$ENDHEX$$ TI para executar a rotina de Exporta$$HEX2$$e700e300$$ENDHEX$$o de Clientes.")
	Return
End If	

//If ls_sit_log = 'N' then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Item n$$HEX1$$e300$$ENDHEX$$o foi processado e enviado para SAP, favor solicitar $$HEX1$$e000$$ENDHEX$$ TI para executar a rotina de Exporta$$HEX2$$e700e300$$ENDHEX$$o de Clientes")
//	Return
//End If	

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE508_REENVIAR_CLIENTE", ref ls_Matricula) Then 
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
			ll_Nr_Atualizacao	= Tab_1.TabPage_1.dw_2.Object.nr_exportacao		[ll_Linha]
			ls_Ambiente_Sap 	= Tab_1.TabPage_1.dw_2.Object.cd_ambiente_sap 	[ll_Linha]	
			wf_Deleta_Registro_Sybase(ll_Nr_Atualizacao,ls_Ambiente_Sap, ls_Matricula)			
		End If
	Next
	
Finally
	
	If IsValid(w_Aguarde) Then
		Close(w_Aguarde)
	End If
	
	SetPointer(Arrow!)
End Try


dw_2.Post Event ue_Atualiza_Botoes()
dw_2.Event ue_Recuperar()


	
	
	



end event

type pb_2 from picturebutton within tabpage_1
integer x = 3173
integer y = 60
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

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"O Cliente ser$$HEX1$$e100$$ENDHEX$$ marcado para exclus$$HEX1$$e300$$ENDHEX$$o no banco de dados.~r~r"+&
								"O Cliente ser$$HEX1$$e100$$ENDHEX$$ reenviado pela Interface de Clientes, assim que salvo a situa$$HEX2$$e700e300$$ENDHEX$$o de Reenvio ao SAP.~r~r"+&
								"Apenas documentos com a situa$$HEX2$$e700e300$$ENDHEX$$o 'INTEGRADO' poder$$HEX1$$e300$$ENDHEX$$o ser reenviados.")
end event

type pb_4 from picturebutton within tabpage_1
integer x = 3173
integer y = 188
integer width = 114
integer height = 96
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

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"Esta op$$HEX2$$e700e300$$ENDHEX$$o permitir$$HEX1$$e100$$ENDHEX$$ que mude a Situa$$HEX2$$e700e300$$ENDHEX$$o de envio ao SAP, do Cliente Selecionado.~r~r"+&
								"Apenas Clientes com a situa$$HEX2$$e700e300$$ENDHEX$$o de 'Erro' no envio ao SAP poder$$HEX1$$e300$$ENDHEX$$o ser alterados.")
						
end event

type cb_revisar from commandbutton within tabpage_1
integer x = 3301
integer y = 188
integer width = 494
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
string text = "Revisar Situa$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;Long		 lvl_Linha
Longlong	 lvl_ID_Log

DateTime lvdh_Servidor
Integer 	 lvi_Sit_Item

String 	lvs_Situacao
String 	lvs_Revisao
String 	lvs_Ambiente_sap

Try
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja realmente marcar como Ignorar esses registros?", Question!, YesNo!, 2) = 1 Then
						
		Open(w_ge508_revisao_log)
		
		If Message.StringParm <> '' Then
			lvs_Situacao	= Mid(Message.StringParm, 1, 1)
			lvs_Revisao	= Mid(Message.StringParm, 3)
		
			Parent.dw_2.SetRedraw(False)
			
			Parent.dw_2.SetFilter("id_selecionar='S'")
			Parent.dw_2.Filter()
			
			For lvl_Linha = 1 To Parent.dw_2.RowCount()
				lvl_ID_Log 			= Parent.dw_2.Object.nr_exportacao		[lvl_Linha]
				lvs_Ambiente_sap 	= Parent.dw_2.Object.cd_ambiente_sap	[lvl_Linha]
				lvi_Sit_Item			= Parent.dw_2.Object.status				[lvl_Linha]
				
				If lvi_Sit_Item <> 2 then /* N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ item com Erro, portanto n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ mudar a situa$$HEX2$$e700e300$$ENDHEX$$o */
				    Continue
			    End If
				
				lvdh_Servidor = gf_getserverdate()
		 
		 		ivtr_geral = sqlca
		
 				Update cliente_exportacao_sap
				Set       nr_matricula_revisao = :gvo_aplicacao.ivo_seguranca.nr_matricula ,  dh_revisao = :lvdh_Servidor, id_revisado = :lvs_Situacao
				Where nr_sequencial	 			=:lvl_ID_Log
				   and  cd_ambiente_sap 	    = :lvs_ambiente_sap
			  	 Using ivtr_geral;
				
				If ivtr_geral.SQLCode = -1 Then
					ivtr_geral.Of_RollBack()
					ivtr_geral.Of_Msgdberror( "Falha ao atualizar status do log de exporta$$HEX2$$e700e300$$ENDHEX$$o." )
				Else
					ivtr_geral.Of_Commit()
					Parent.dw_2.Object.id_selecionar		[lvl_Linha] = "N"
					Parent.dw_2.Object.id_revisado		[lvl_Linha] = lvs_Situacao
					Parent.dw_2.Object.status				[lvl_Linha] = IIF(lvs_Situacao='X', 6, 5)
				End If
			Next
			
		End If
		
		Parent.dw_2.Post Event ue_Atualiza_Botoes()
	End If

Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	Return -1
	
Finally
	Parent.dw_2.SetFilter("")
	Parent.dw_2.Filter()
	Parent.dw_2.setsort("dh_exportacao ds, nr_exportacao as")
	Parent.dw_2.sort()
	Parent.dw_2.SetRedraw(True)
End Try
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

type cb_1 from commandbutton within tabpage_1
boolean visible = false
integer x = 3954
integer y = 104
integer width = 402
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "none"
end type

event clicked;//
//uo_el103_dados_helpdesk  lo_teste 
//
//	lo_teste = Create uo_el103_dados_helpdesk
//					lo_teste.of_gera_dados_helpdesk( )
//					Destroy(lo_teste) 				    

//
//uo_el104_lgpd_consentimento    lo_Lgpd
//			    		lo_Lgpd = Create uo_el104_lgpd_consentimento
//					lo_Lgpd.of_processo_clientes( )
//					Destroy(lo_Lgpd) 				    
//
//
/////of_gera_dados_helpdesk
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

type st_confirmar from statictext within w_ge508_monitor_integra_clientes
boolean visible = false
integer x = 4366
integer y = 624
integer width = 901
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

