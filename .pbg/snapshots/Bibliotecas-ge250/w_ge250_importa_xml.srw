HA$PBExportHeader$w_ge250_importa_xml.srw
forward
global type w_ge250_importa_xml from dc_w_response_ok_cancela
end type
type dw_2 from datawindow within w_ge250_importa_xml
end type
end forward

global type w_ge250_importa_xml from dc_w_response_ok_cancela
integer width = 1819
integer height = 816
string title = "GE250 - Importa$$HEX2$$e700e300$$ENDHEX$$o Manual de XML "
dw_2 dw_2
end type
global w_ge250_importa_xml w_ge250_importa_xml

type variables
Boolean ivb_Processando

string is_chave_acesso

string is_Arquivo_Excel
end variables

forward prototypes
public function boolean wf_carrega_dados_excel_ole (string as_arquivo, ref long al_qt_linhas)
end prototypes

public function boolean wf_carrega_dados_excel_ole (string as_arquivo, ref long al_qt_linhas);OLEObject excel

Integer li_RetValue, li_rtn
Boolean lb_sheet_rtn
Long ll_cnt, ll_xls_rows

dw_2.reset()
dw_2.AcceptText()

SetPointer(HourGlass!)

If as_arquivo = '' Then Return False

excel = create OLEObject

li_rtn = excel.ConnectToNewObject("excel.application")
If li_rtn <> 0 Then
	MessageBox('Excel error','Erro ao iniciar aplica$$HEX2$$e700e300$$ENDHEX$$o excel.')
	Destroy excel
	Return False
End If

excel.WorkBooks.Open(as_arquivo)
excel.Application.Visible = false

lb_sheet_rtn = excel.worksheets(1).Activate

ll_xls_rows = excel.worksheets(1).Usedrange.rows.count

excel.Worksheets(1).Range("A1:A"+string(ll_xls_rows)).Copy

al_qt_linhas = dw_2.importclipboard()

excel.Application.Quit
excel.DisConnectObject()
DESTROY excel

If al_qt_linhas > 0 Then
	Return True
Else 
	Return False
End If
end function

on w_ge250_importa_xml.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_ge250_importa_xml.destroy
call super::destroy
destroy(this.dw_2)
end on

event open;call super::open;is_chave_acesso = Message.StringParm	
end event

event ue_postopen;call super::ue_postopen;If Not IsNull(is_chave_acesso) and Len(is_chave_acesso) = 44 Then
	dw_1.Object.de_chave_acesso[1] = is_chave_acesso
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge250_importa_xml
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge250_importa_xml
integer width = 1769
integer height = 616
string text = "Informe a Chave de Acesso"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge250_importa_xml
integer x = 59
integer y = 92
integer width = 1705
integer height = 488
string dataobject = "dw_ge250_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_1.AcceptText()

Choose Case dwo.Name
	Case "id_marreta_reposicao_sta"
		If Data = "S" Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O sistema ir$$HEX1$$e100$$ENDHEX$$ entender que $$HEX1$$e900$$ENDHEX$$ uma reposi$$HEX2$$e700e300$$ENDHEX$$o de PBM e ir$$HEX1$$e100$$ENDHEX$$ incluir um pedido central *** Somente ESTOQUE CENTRAL ****.~r~rConfirma ?", Question!, YesNoCancel!, 2) <> 1 Then
				Return 1
			End If
		End If	
		
	Case "id_sem_tag_xvan"
		If Data = "S" Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O sistema ir$$HEX1$$e100$$ENDHEX$$ localizar um pedido de conex$$HEX1$$e300$$ENDHEX$$o em aberto.~r~rConfirma ?", Question!, YesNoCancel!, 2) <> 1 Then
				Return 1
			End If
		End If		
		
	Case "id_carga"
		If Data = "S" Then
			SetNull(is_Arquivo_Excel)
//			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Importa$$HEX2$$e700e300$$ENDHEX$$o de Chaves NFe em massa.~r~rConfirma ?", Question!, YesNoCancel!, 2) <> 1 Then
//				Return 1
//			End If
			//Abre sele$$HEX2$$e700e300$$ENDHEX$$o de arquivo e retorna o caminho
			Open(w_ge250_importacao_chaves)
			is_Arquivo_Excel = Message.StringParm
		End If	
End Choose

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge250_importa_xml
integer x = 1152
integer y = 624
end type

event cb_ok::clicked;call super::clicked;String 	ls_Log,&
			ls_Fornecedor,&
			ls_Carga
			
Long ll_Row, ll_linhas, ll_Linha, ll_Qt_Linhas = 0

String ls_Chave, ls_Chave_Nf_Excel, ls_Lista_Erros

dw_1.AcceptText()

ls_Chave = dw_1.Object.de_chave_acesso[1]
ls_Carga	= dw_1.Object.id_carga[1]

If  ls_Carga = "S" And Trim(is_Arquivo_Excel) <> ''  And Not Isnull(is_Arquivo_Excel) And Len(is_Arquivo_Excel) > 3 And ls_Chave="" Then 
	If Not wf_carrega_dados_excel_ole(is_Arquivo_Excel, Ref ll_Qt_Linhas) Then
		SqlCa.of_Rollback()
		Return 0
	End If
Else
	If IsNull(ls_Chave) or Len(ls_Chave) <> 44 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A chave deve possuir 44 caracteres.")
		dw_1.Event ue_Pos(1, "de_chave_acesso")
		Return
	End If
End If	

If Not ivb_Processando Then
	
	SetPointer(HourGlass!)
	
	uo_ge250_xml_pedido_eletronico lo_NFE
	
	lo_NFE = Create uo_ge250_xml_pedido_eletronico
	
	// se estiver como TRUE n$$HEX1$$e300$$ENDHEX$$o faz o FTP do distribuidor
	lo_NFE.ib_Importacao_Manual = True
		
	lo_NFE.ib_Download_Sefaz = True

	If dw_1.Object.id_sem_pedido_conexao[1] = 'S' Then
		lo_NFE.ib_Imp_Manual_Sem_Pedido_Conexao = True
	Else
		lo_NFE.ib_Imp_Manual_Sem_Pedido_Conexao = False
	End If
	
	If dw_1.Object.id_marreta_reposicao_sta[1] = 'S' Then
		lo_NFE.ib_marreta_reposicao_sta = True
	Else
		lo_NFE.ib_marreta_reposicao_sta = False
	End If
	
	If dw_1.Object.id_sem_tag_xvan[1] = 'S' Then
		lo_NFE.ib_sem_xvan = True
	Else
		lo_NFE.ib_sem_xvan = False
	End If
	
	If  ls_Carga = "S" And Trim(is_Arquivo_Excel) <> ''  And Not Isnull(is_Arquivo_Excel) And Len(is_Arquivo_Excel) > 3 And ls_Chave=""   Then 
		ls_Lista_Erros = ''
		For ll_Linha = 1 to ll_Qt_Linhas
			ls_Chave_Nf_Excel = string(dw_2.Object.chave_acesso[ll_linha])
			ls_Chave_Nf_Excel = gf_retira_caracteres_especiais(ls_Chave_Nf_Excel)
			If len(ls_Chave_Nf_Excel) <> 44 Then 
				ls_Lista_Erros += ls_Lista_Erros + ls_Chave_Nf_Excel + ','
				Continue
			End If
			lo_NFE.of_Processa_Atualizacao(ls_Chave_Nf_Excel)			
		Next 	
		
		If ls_Lista_Erros = '' Or isNull(ls_Lista_Erros) Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Processamento conclu$$HEX1$$ed00$$ENDHEX$$do.")
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Processamento conclu$$HEX1$$ed00$$ENDHEX$$do parcialmente! Segue lista com chaves invalidas:~r"+ls_Lista_Erros)
		End If
	Else
		lo_NFE.of_Processa_Atualizacao(ls_Chave)
		//lo_NFE.of_Processa_Atualizacao('')
	End If 
	
	Destroy(lo_NFE)
	
	ivb_Processando = False
	
	SetPointer(Arrow!)

End If
		
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge250_importa_xml
integer x = 1486
integer y = 624
end type

type dw_2 from datawindow within w_ge250_importa_xml
integer x = 59
integer y = 496
integer width = 686
integer height = 92
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge250_importa_dados_excel"
boolean border = false
boolean livescroll = true
end type

