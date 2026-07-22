HA$PBExportHeader$w_ge147_mensagem_logistica.srw
forward
global type w_ge147_mensagem_logistica from dc_w_base
end type
type cb_3 from commandbutton within w_ge147_mensagem_logistica
end type
type cb_2 from commandbutton within w_ge147_mensagem_logistica
end type
type cb_1 from commandbutton within w_ge147_mensagem_logistica
end type
type dw_1 from dc_uo_dw_base within w_ge147_mensagem_logistica
end type
type gb_1 from groupbox within w_ge147_mensagem_logistica
end type
end forward

global type w_ge147_mensagem_logistica from dc_w_base
integer width = 2098
integer height = 972
string title = "GE147 - Mensagem Log$$HEX1$$ed00$$ENDHEX$$stica"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge147_mensagem_logistica w_ge147_mensagem_logistica

type variables
Long il_Pedido
end variables

forward prototypes
public function boolean wf_houve_alteracao (dc_uo_dw_base pdw_log, string as_coluna, integer al_linha, ref string as_valorpara)
public function boolean wf_grava_historico_alteracao (string as_tabela, string as_chave, string as_coluna, string as_de, string as_para, string as_operador, string as_tipo_alteracao)
public function boolean wf_verifica_nf_compra_pendente (long al_pedido)
end prototypes

public function boolean wf_houve_alteracao (dc_uo_dw_base pdw_log, string as_coluna, integer al_linha, ref string as_valorpara);String lvs_ColunmType, lvs_ValorDe

lvs_ColunmType = Upper(pdw_log.Describe(as_Coluna + ".ColType"))

//Recupera o tipo de dado da coluna alterada
//Recupera os valores atual e antigo da coluna conforme o tipo de dado e converte para string
Choose Case lvs_ColunmType
	Case 'NUMBER','LONG','INT','ULONG'
		lvs_ValorDe		= String(pdw_log.GetItemNumber(al_linha,as_Coluna,Primary!,True))
		as_ValorPara	= String(pdw_log.GetItemNumber(al_linha,as_Coluna,Primary!,False))
	Case 'DATE'
		lvs_ValorDe		= String(pdw_log.GetItemDate(al_linha,as_Coluna,Primary!,True),'DD/MM/YYYY')
		as_ValorPara	= String(pdw_log.GetItemDate(al_linha,as_Coluna,Primary!,False),'DD/MM/YYYY')
	Case 'DATETIME'
		lvs_ValorDe		= String(pdw_log.GetItemDateTime(al_linha,as_Coluna,Primary!,True),'DD/MM/YYYY HH:MM:SS')
		as_ValorPara	= String(pdw_log.GetItemDateTime(al_linha,as_Coluna,Primary!,False),'DD/MM/YYYY HH:MM:SS')
	Case Else	
		If (Pos(lvs_ColunmType,'DECIMAL')>0)or(lvs_ColunmType='REAL') Then
			lvs_ValorDe		= String(pdw_log.GetItemDecimal(al_linha,as_Coluna,Primary!,True),'#,##0.00##')
			as_ValorPara	= String(pdw_log.GetItemDecimal(al_linha,as_Coluna,Primary!,False),'#,##0.00##')
		Else
			lvs_ValorDe		= pdw_log.GetItemString(al_linha,as_Coluna,Primary!,True)
			as_ValorPara	= pdw_log.GetItemString(al_linha,as_Coluna,Primary!,False)
		End If
End Choose		

If (lvs_ValorDe <> as_ValorPara) or (IsNull(lvs_ValorDe) and Not IsNull(as_ValorPara)) or (Not IsNull(lvs_ValorDe) and IsNull(as_ValorPara))Then Return True

//If IsNull(lvs_ValorDe) and Not IsNull(lvs_ValorDe) Then Return True
//If Not IsNull(lvs_ValorDe) and IsNull(lvs_ValorDe) Then Return True
	
Return False
end function

public function boolean wf_grava_historico_alteracao (string as_tabela, string as_chave, string as_coluna, string as_de, string as_para, string as_operador, string as_tipo_alteracao);Insert Into historico_alteracao_tabela(nm_tabela, de_chave, nm_coluna, de_alteracao_de, de_alteracao_para, nr_matric_alteracao, id_alteracao)
Values (:as_Tabela, :as_chave, :as_Coluna, :as_De, :as_Para, :as_Operador, :as_tipo_alteracao)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es. " + SqlCa.SQLErrText, StopSign!)
	SqlCa.of_RollBack()
	Return False
End If

Return True
end function

public function boolean wf_verifica_nf_compra_pendente (long al_pedido);Long ll_Achou

select count(*)
Into :ll_Achou
from(
    Select cd_filial
    From nf_compra_pendente
    Where cd_filial = 534
    And nr_pedido_central = 112471
    
    union
    
    Select cd_filial
    From nf_compra
    Where cd_filial = 534
    And nr_pedido_central = :al_Pedido
) as tudo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError('Erro ao consultar a nf_compra_pendente. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_nf_pendente')
	Return False
End If

If ll_Achou > 0  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O XML da nota fiscal eletr$$HEX1$$f400$$ENDHEX$$nica deste pedido j$$HEX1$$e100$$ENDHEX$$ foi importado, portanto n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel gravar uma mensagem.", Exclamation!)
	Return False
Else
	Return True
End If
end function

on w_ge147_mensagem_logistica.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_ge147_mensagem_logistica.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;il_Pedido = Message.DoubleParm	
end event

event ue_postopen;call super::ue_postopen;dw_1.Retrieve(il_Pedido)
end event

type cb_3 from commandbutton within w_ge147_mensagem_logistica
integer x = 27
integer y = 772
integer width = 283
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir"
end type

event clicked;String 	ls_Nulo,&
			ls_Erro

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja realmente excluir a mensagem?", Question!, YesNo!, 2) = 2 Then
	Return 1
End If

SetNull(ls_Nulo)

Update pedido_central
Set de_mensagem_logistica = :ls_Nulo
Where nr_pedido = :il_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir a mensagem: "+ls_Erro)
	Return 1
End If

SqlCa.of_Commit()

Close(Parent)
end event

type cb_2 from commandbutton within w_ge147_mensagem_logistica
integer x = 1362
integer y = 772
integer width = 334
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar"
end type

event clicked;String 	ls_Mensagem, &
			ls_Mensagem_De, &
			ls_AlteraPara, &
			ls_Erro		

dw_1.AcceptText()

If Not wf_verifica_nf_compra_pendente(il_Pedido) Then
	Return 1
End If

ls_Mensagem = dw_1.object.de_mensagem_logistica[1]

If (Trim(ls_Mensagem) = "") or IsNull(ls_Mensagem) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a mensagem.")
	dw_1.SetFocus()
	Return 1
End If

If Len(ls_Mensagem) > 2000 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A mensagem poder$$HEX1$$e100$$ENDHEX$$ ter no m$$HEX1$$e100$$ENDHEX$$ximo 2000 caracteres.")
	dw_1.SetFocus()
	Return 1
End If

Select de_mensagem_logistica
	Into :ls_Mensagem_De
From pedido_central
Where nr_pedido = :il_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError('Erro ao localizar a mensagem do pedido.')
	Return -1
End If

If wf_Houve_Alteracao(dw_1, 'DE_MENSAGEM_LOGISTICA', 1, Ref ls_AlteraPara) Then
	If Not wf_Grava_Historico_Alteracao('PEDIDO_CENTRAL', String(il_Pedido), 'DE_MENSAGEM_LOGISTICA', ls_Mensagem_De, ls_AlteraPara, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A') Then
		Return -1
	End If
End If

Update pedido_central
Set de_mensagem_logistica_text = :ls_Mensagem
Where nr_pedido = :il_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar a mensagem: "+ls_Erro)
	Return 1
End If

SqlCa.of_Commit()

Close(Parent)
end event

type cb_1 from commandbutton within w_ge147_mensagem_logistica
integer x = 1742
integer y = 772
integer width = 315
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;Close(Parent)
end event

type dw_1 from dc_uo_dw_base within w_ge147_mensagem_logistica
integer x = 37
integer y = 76
integer width = 2002
integer height = 652
integer taborder = 20
string dataobject = "dw_ge147_mensagem_logistica"
end type

type gb_1 from groupbox within w_ge147_mensagem_logistica
integer x = 27
integer y = 20
integer width = 2030
integer height = 728
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

