HA$PBExportHeader$w_ge417_importa_produtos_via_excel.srw
forward
global type w_ge417_importa_produtos_via_excel from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge417_importa_produtos_via_excel
end type
end forward

global type w_ge417_importa_produtos_via_excel from dc_w_response_ok_cancela
integer width = 2254
integer height = 404
string title = "GE407 - Importa Produtos via Excel"
cb_1 cb_1
end type
global w_ge417_importa_produtos_via_excel w_ge417_importa_produtos_via_excel

type variables
st_produto ist_produtos
end variables

forward prototypes
public function boolean wf_verifica_cd_produto (long al_cd_produto)
public function boolean wf_atualiza_produto ()
end prototypes

public function boolean wf_verifica_cd_produto (long al_cd_produto);Long ll_cd_produto
			
select count(*) 
Into :ll_cd_produto
from produto_geral
where cd_produto = :al_cd_produto
Using SqlCa;			

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo do produto.")
	Return False
End If

If ll_cd_produto > 0 Then
	Return False
Else
	Return True
End If

end function

public function boolean wf_atualiza_produto ();Boolean lvb_Sucesso = True
Any la_Dado
String ls_Arquivo, ls_De_Produto, ls_Sit
		
Long ll_produto, ll_Linhas, ll_Linha, ll_Find, ll_Contador

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
			ll_produto = Long(la_Dado)
			
			Select  g.de_produto  + ' : ' + g.de_apresentacao_estoque de_produto, g.id_situacao
			Into :ls_De_Produto, :ls_Sit
			From produto_geral g
			Where g.cd_produto = :ll_produto
			Using SqlCa	;
			
			ist_produtos.cd_produto[ll_Linha] = ll_produto
			ist_produtos.de_produto[ll_Linha] = ls_De_Produto
			ist_produtos.id_situacao[ll_Linha] = ls_Sit
			
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
		Next
	  
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		lvb_Sucesso = False
	End If
End If

Close(w_Aguarde)

Destroy(lvo_Excel)

Return lvb_Sucesso

end function

on w_ge417_importa_produtos_via_excel.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge417_importa_produtos_via_excel.destroy
call super::destroy
destroy(this.cb_1)
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge417_importa_produtos_via_excel
integer x = 37
integer y = 196
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge417_importa_produtos_via_excel
integer width = 2199
integer height = 188
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge417_importa_produtos_via_excel
integer width = 2139
integer height = 100
string dataobject = "dw_ge417_selecao_arquivo"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge417_importa_produtos_via_excel
integer x = 1573
integer y = 204
boolean default = false
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

lvl_Confirma = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a importa$$HEX2$$e700e300$$ENDHEX$$o dos produtos ?", Question! , YesNo!, 2)

If lvl_Confirma = 1 Then	
	If wf_Atualiza_Produto() Then
		CloseWithReturn(Parent, ist_produtos)
	Else
		Return -1
	End If
End If

Return 1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge417_importa_produtos_via_excel
integer x = 1906
integer y = 204
end type

type cb_1 from commandbutton within w_ge417_importa_produtos_via_excel
integer x = 1010
integer y = 204
integer width = 544
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Selecionar Arquivo"
boolean default = true
end type

event clicked;String lvs_Arquivo,&
	   lvs_Nome,&
	   lvs_Nulo, &
		lvs_Mensagem

Integer lvi_Retorno 

dw_1.AcceptText()

lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
						"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r"
												
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

