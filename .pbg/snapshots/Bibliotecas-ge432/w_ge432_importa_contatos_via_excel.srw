HA$PBExportHeader$w_ge432_importa_contatos_via_excel.srw
forward
global type w_ge432_importa_contatos_via_excel from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge432_importa_contatos_via_excel
end type
end forward

global type w_ge432_importa_contatos_via_excel from dc_w_response_ok_cancela
string accessiblename = "Importa$$HEX2$$e700e300$$ENDHEX$$o dos contatos (CO197)"
integer width = 2359
integer height = 400
string title = "GE432 - Importa$$HEX2$$e700e300$$ENDHEX$$o dos Contatos"
cb_1 cb_1
end type
global w_ge432_importa_contatos_via_excel w_ge432_importa_contatos_via_excel

forward prototypes
public function boolean wf_atualiza_contato ()
public function boolean wf_localiza_fornecedor (string as_fornecedor)
public function boolean wf_grava_contato (string as_fornecedor, long al_tipo, string as_nome_contato, string as_ddd_fone, string as_fone_contato, string as_email_contato)
public function boolean wf_verifica_nome_contato (string as_nome_contato, string as_cd_fornecedor, long al_cd_tipo)
end prototypes

public function boolean wf_atualiza_contato ();Boolean lvb_Sucesso = True

Any la_Dado

String ls_Fornecedor, ls_Nome_Contato, ls_Arquivo, ls_Fone_Contato,ls_Email_Contato, ls_DDD_Fone
		
Long ll_Tipo,  ll_Linhas, ll_Linha 

dw_1.AcceptText()

ls_Arquivo 	= dw_1.Object.de_arquivo	[1]

dc_uo_excel lvo_Excel

lvo_Excel = Create dc_uo_excel

Open(w_Aguarde)
w_Aguarde.Title = "Importando o Arquivo..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	ll_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
					
			la_Dado    = lvo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			
			ls_Fornecedor = String(la_Dado)
			
			If Len(ls_Fornecedor) = 8 Then
				ls_Fornecedor = '0' + ls_Fornecedor
			End If

			If  Not wf_Localiza_Fornecedor(ls_Fornecedor) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo fornecedor n$$HEX1$$e300$$ENDHEX$$o encontrado: " + String(ll_Linha) + ".~rValor: " + String( ls_Fornecedor ) ) 
				lvb_Sucesso = False
				Exit
			End If
			
			// C$$HEX1$$f300$$ENDHEX$$digo do tipo do contato
			la_Dado    = lvo_Excel.uo_Lendo_Dados(ll_Linha, "B")
			
			If Not IsNumber(String(la_Dado)) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(ll_Linha) + ".~rValor: " + String( la_Dado ) ) 
				lvb_Sucesso = False
				Exit
			End If
			
			ll_Tipo = Long(la_Dado)
			
			// Nome do contato
			la_Dado    = lvo_Excel.uo_Lendo_Dados(ll_Linha, "C")
			ls_Nome_Contato = Upper(Trim(String(la_Dado)))
			
			// DDD do telefone
			la_Dado    		= lvo_Excel.uo_Lendo_Dados(ll_Linha, "D")
						
			ls_DDD_Fone 	= String(la_Dado)
			
			If Not IsNumber(ls_DDD_Fone) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(ll_Linha) + ".~rValor: " + String( la_Dado ) ) 
				lvb_Sucesso = False
				Exit
			End If
						
			//Telefone do contato
			la_Dado= lvo_Excel.uo_Lendo_Dados(ll_Linha, "E")
			ls_Fone_Contato = String(la_Dado)
			
			ls_Fone_Contato = gf_retira_caracteres_especiais(ls_Fone_Contato)
			
			ls_Fone_Contato = gf_replace(ls_Fone_Contato, '-', '', 0)
			
			//Email do contato
			la_Dado= lvo_Excel.uo_Lendo_Dados(ll_Linha, "F")
			ls_Email_Contato = String(la_Dado)
			
			If IsNull(ls_Nome_Contato) or Trim(ls_Nome_Contato) = '' Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O nome do contato deve ser informado.~r" + "Linha: " + String(ll_Linha) +  ".", StopSign! )
				lvb_Sucesso = False
				Exit
			End If
			
			//Verifica o nome do contato
			If Not wf_verifica_nome_contato(ls_Nome_Contato,ls_Fornecedor,ll_Tipo) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nome do contato j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado " + String(ll_Linha) + ".~rValor: " + String( ls_Nome_Contato ) ) 
				w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
				Continue
			End If
			
			If Not wf_grava_contato(ls_Fornecedor,  ll_Tipo, ls_Nome_Contato, ls_DDD_Fone, ls_Fone_Contato, ls_Email_Contato) Then
				lvb_Sucesso = False
				Exit
			End If
			
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
		Next
	  
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		lvb_Sucesso = False
	End If
End If

If lvb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Contatos atualizados com sucesso.")
Else
	SqlCa.of_RollBack();
End If

Close(w_Aguarde)

Destroy(lvo_Excel)

Return lvb_Sucesso

end function

public function boolean wf_localiza_fornecedor (string as_fornecedor);Long ll_Fornecedor
			
select count(*) 
Into :ll_Fornecedor
from fornecedor
where cd_fornecedor = :as_fornecedor
Using SqlCa;			

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo do fornecedor.")
	Return False
End If

If ll_Fornecedor > 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean wf_grava_contato (string as_fornecedor, long al_tipo, string as_nome_contato, string as_ddd_fone, string as_fone_contato, string as_email_contato);Long ll_Proximo_Contato

select coalesce(max(nr_contato) , 0) + 1
Into :ll_Proximo_Contato
From fornecedor_contato
Where cd_fornecedor = :as_Fornecedor
Using Sqlca;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo contato.")
	Return False
End If

Insert Into fornecedor_contato(cd_fornecedor,nr_contato,cd_contato,nm_contato,nr_ddd_telefone,nr_telefone, de_email)
Values (:as_Fornecedor,:ll_Proximo_Contato , :al_Tipo,:as_Nome_Contato, :as_DDD_Fone, :as_Fone_Contato, :as_Email_Contato)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do contato.")
	Return False
End If

Return True

end function

public function boolean wf_verifica_nome_contato (string as_nome_contato, string as_cd_fornecedor, long al_cd_tipo);Long ll_nm_contato
			
select count(*) 
Into :ll_nm_contato
from fornecedor_contato
where nm_contato = :as_nome_contato and cd_fornecedor= :as_cd_fornecedor and cd_contato= :al_cd_tipo
Using SqlCa;			

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o nome do contato.")
	Return False
End If

If ll_nm_contato > 0 Then
	Return False
Else
	Return True
End If
end function

on w_ge432_importa_contatos_via_excel.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge432_importa_contatos_via_excel.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;call super::open;pb_help.Visible = True
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge432_importa_contatos_via_excel
integer x = 23
integer y = 192
end type

event pb_help::clicked;call super::clicked;wf_Help("Importa$$HEX2$$e700e300$$ENDHEX$$o dos Contatos (CO197)")
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge432_importa_contatos_via_excel
integer width = 2281
integer height = 172
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge432_importa_contatos_via_excel
integer x = 37
integer y = 64
integer width = 2254
integer height = 92
string dataobject = "dw_ge432_selecao_arquivo"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge432_importa_contatos_via_excel
integer x = 1669
integer y = 192
string text = "&Alterar"
end type

event cb_ok::clicked;call super::clicked;Long lvl_Confirma
String	lvs_Arquivo

dw_1.AcceptText()

lvs_Arquivo 	= dw_1.Object.de_arquivo	[1]


If IsNull(lvs_Arquivo) or Trim(lvs_Arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o arquivo a ser importado.")
	dw_1.SetFocus()
	Return -1
End If

lvl_Confirma = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a importa$$HEX2$$e700e300$$ENDHEX$$o dos contatos ?", Question! , YesNo!, 2)

If lvl_Confirma = 1 Then	
	If Not wf_Atualiza_Contato() Then
		Return -1
	End If
End If
	
Return 1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge432_importa_contatos_via_excel
integer x = 2002
integer y = 192
end type

type cb_1 from commandbutton within w_ge432_importa_contatos_via_excel
integer x = 1061
integer y = 192
integer width = 585
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Selecionar Arquivo"
end type

event clicked;String lvs_Arquivo,&
	   lvs_Nome,&
	   lvs_Nulo, &
		lvs_Mensagem

Integer lvi_Retorno 

dw_1.AcceptText()

lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
						"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Fornecedor~r" + &
						"Coluna B = C$$HEX1$$f300$$ENDHEX$$digo do Contato(1-Comercial | 2-Financeiro | 3-Log$$HEX1$$ed00$$ENDHEX$$stica | 4-Fiscal | 5- XML)...~r"+&
						"Coluna C = Nome do Contato~r" +&
						"Coluna D = DDD do Contato~r"	+&
						"Coluna E = Telefone do Contato~r"	+&
						"Coluna F = Email do Contato~r"

Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem)

lvi_Retorno = GetFileOpenName("Seleciona o arquivo", + lvs_Arquivo, lvs_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Retorno = 1 Then 
	dw_1.Object.de_arquivo[1] = Upper(lvs_Arquivo)
	cb_ok.Enabled = True
Else
	SetNull(lvs_Nulo)
	dw_1.Object.de_arquivo[1] = lvs_Nulo
	cb_ok.Enabled = False
End If
end event

