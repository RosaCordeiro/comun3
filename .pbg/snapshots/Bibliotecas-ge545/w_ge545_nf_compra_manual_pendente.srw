HA$PBExportHeader$w_ge545_nf_compra_manual_pendente.srw
forward
global type w_ge545_nf_compra_manual_pendente from dc_w_selecao_lista_relatorio
end type
type dw_5 from dc_uo_dw_base within w_ge545_nf_compra_manual_pendente
end type
type dw_4 from dc_uo_dw_base within w_ge545_nf_compra_manual_pendente
end type
type cb_altera_notifica from commandbutton within w_ge545_nf_compra_manual_pendente
end type
type gb_3 from groupbox within w_ge545_nf_compra_manual_pendente
end type
end forward

global type w_ge545_nf_compra_manual_pendente from dc_w_selecao_lista_relatorio
string tag = "w_ge545_nf_compra_manual_pendente"
integer width = 5193
integer height = 2036
string title = "GE545 - Rel$$HEX1$$e100$$ENDHEX$$torio NF Entrada Manual Pendente"
dw_5 dw_5
dw_4 dw_4
cb_altera_notifica cb_altera_notifica
gb_3 gb_3
end type
global w_ge545_nf_compra_manual_pendente w_ge545_nf_compra_manual_pendente

type variables
uo_filial ivo_filial

String is_Fornecedores 
String  is_procedimento
Long   il_Registro



end variables

forward prototypes
public function boolean wf_carrega_fornecedores ()
public function string wf_atualiza_notifica (string as_chave)
public function string wf_atualiza_natureza_operacao (long al_natureza_operacao)
public subroutine _documentacao ()
end prototypes

public function boolean wf_carrega_fornecedores ();Long ll_Linha

If not isNull(is_Fornecedores) And is_Fornecedores <> '' Then Return True

If dw_5.Retrieve() < 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve da dw_5 na fun$$HEX2$$e700e300$$ENDHEX$$o wf_carrega_fornecedores.", Exclamation!)
	Return False
End If

For ll_Linha = 1 to dw_5.rowcount()
	is_Fornecedores +="'"+ dw_5.object.nr_cgc [ll_Linha] +"',"
Next

is_Fornecedores = midA(is_fornecedores,1, (lenA(is_fornecedores ) - 1))

Return True
end function

public function string wf_atualiza_notifica (string as_chave);String lvs_notifica 

Select case id_notifica_loja 
			when 'N' Then 'N$$HEX1$$c300$$ENDHEX$$O' 
			when 'S' Then 'SIM' 
		else 'SIM' End as id_notifica
Into :lvs_notifica
From  nfe_destinadas
Where de_chave_acesso  =:as_chave
Using SqlCA;


Return lvs_notifica
end function

public function string wf_atualiza_natureza_operacao (long al_natureza_operacao);String lvs_natureza

Setnull(lvs_natureza)

Select de_natureza_operacao
Into :lvs_natureza
From natureza_operacao 
Where cd_natureza_operacao = :al_natureza_operacao
Using SqlCA;
	 
If SqlCa.SqlCode = -1 Then
		Sqlca.Of_MsgDbError("Erro ao definir a natureza da opera$$HEX2$$e700e300$$ENDHEX$$o.")
End if
	 
Return lvs_natureza
end function

public subroutine _documentacao ();
/*      

OBJETIVO: Tela para consulta de notas fiscais de compra pendentes de entrada.

Tabelas: 
			- nfe_destinadas 
			- nfe_indexacao_item 
			- nf_compra 
			- nfe_indexacao
			- filial
			- parametro_odbc
			- fornecedor
			- condicao_pagamento_parcela
*/
end subroutine

on w_ge545_nf_compra_manual_pendente.create
int iCurrent
call super::create
this.dw_5=create dw_5
this.dw_4=create dw_4
this.cb_altera_notifica=create cb_altera_notifica
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.cb_altera_notifica
this.Control[iCurrent+4]=this.gb_3
end on

on w_ge545_nf_compra_manual_pendente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.cb_altera_notifica)
destroy(this.gb_3)
end on

event open;call super::open;ivo_Filial		= Create uo_Filial

end event

event close;call super::close;If isValid(ivo_Filial) Then Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;DateTime ldh_GetDate

Integer li_Linha

ldh_GetDate = gf_GetServerDate()

dw_1.Object.Dt_Inicio			[1] = RelativeDate(Date(ldh_GetDate), -30)
dw_1.Object.Dt_Termino		[1] = Date(ldh_GetDate)
//dw_1.Object.Dh_Emissao	[1] = RelativeDate(Date(ldh_GetDate), -1)

DataWindowChild lvdwc

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	li_Linha = lvdwc.InsertRow(1)
	
	lvdwc.SetItem(li_Linha, "nr_cgc", "00000000000000")
	lvdwc.SetItem(li_Linha, "nm_razao_social"  , "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "00000000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild.", StopSign!)
End If

This.ivm_Menu.mf_SalvarComo(True)
This.ivm_Menu.mf_Recuperar(True)
dw_4.Event ue_AddRow()
dw_1.SetFocus()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge545_nf_compra_manual_pendente
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge545_nf_compra_manual_pendente
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge545_nf_compra_manual_pendente
integer width = 5106
integer height = 1280
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge545_nf_compra_manual_pendente
integer width = 5106
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge545_nf_compra_manual_pendente
integer width = 3803
string dataobject = "dw_ge545_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
dw_4.Object.De_Chave_Acesso[1] = ""
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
		
End Choose

dw_4.Object.De_Chave_Acesso[1] = ""
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
	
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial 
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If		
	End Choose
End If




end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge545_nf_compra_manual_pendente
string tag = "w_ge545_nf_compra_manual_pendente"
integer width = 5056
integer height = 1184
string title = "GE545 - Rel$$HEX1$$e100$$ENDHEX$$torio NF Entrada Manual Pendente"
string dataobject = "dw_ge545_lista_nf"
borderstyle borderstyle = styleraised!
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long ll_Linha 
String ls_Notifica, ls_natureza_operacao

If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)

	For ll_linha  = 1 To pl_Linhas
		ls_Notifica = wf_atualiza_notifica(dw_2.Object.de_chave_acesso[ll_linha])
		dw_2.Object.id_notifica_loja[ll_linha] =ls_Notifica
		
		ls_natureza_operacao = wf_atualiza_natureza_operacao(dw_2.Object.cd_natureza_operacao[ll_linha])
		dw_2.Object.de_natureza_operacao[ll_linha] = ls_natureza_operacao
	Next 
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_recuperar;DateTime ldh_Inicio ,&
	 		 ldh_Termino

String ls_Cgc_Fornecedor

Long ll_Filial

dw_1.AcceptText()

ldh_Inicio 				= Datetime(dw_1.Object.dt_inicio 				[1], Time('00:00:00'))
ldh_Termino 			= Datetime(dw_1.Object.dt_termino 			[1],Time('23:59:59'))
ls_Cgc_Fornecedor	= dw_1.Object.cd_distribuidora 				[1]
ll_Filial     				= dw_1.Object.Cd_Filial     						[1]

If IsNull(ldh_Inicio) or Not IsDate(String(ldh_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(ldh_Termino) or Not IsDate(String(ldh_Termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1	
End If

If Not IsNull(ll_Filial) and ll_Filial > 0 Then
	This.of_AppendWhere_Subquery("f.cd_filial = " + String(ll_Filial), 3)
	This.of_AppendWhere_Subquery("f.cd_filial = " + String(ll_Filial), 8)
End If

If Not IsNull(ls_Cgc_Fornecedor) and ls_Cgc_Fornecedor <> '00000000000000' Then
	This.of_AppendWhere_Subquery("n.nr_cgc_origem = '" + ls_Cgc_Fornecedor + "'", 3)
	This.of_AppendWhere_Subquery("n.cgc_origem = '" + ls_Cgc_Fornecedor + "'" , 8)
Else
	If not wf_carrega_fornecedores() Then Return -1

	This.of_AppendWhere_Subquery("n.nr_cgc_origem in (" + is_fornecedores + ")",3)
	This.of_AppendWhere_Subquery("n.cgc_origem in (" + is_fornecedores + ")",8) 
	
//	This.of_AppendWhere_Subquery("n.nr_cgc_origem in (select distinct f.nr_cgc "+&
//															"from nf_compra n "+&
//															"inner join fornecedor f  "+&
//																"on f.cd_fornecedor = n.cd_fornecedor " +&
//															"where n.dh_movimentacao_caixa >= (select dateadd(day, -365, dh_movimentacao) from parametro where id_parametro = '1') "+&
//																"and (f.id_distribuidora is null or f.id_distribuidora = 'N') "+&
//																"and n.nr_pedido_distribuidora is null "+&
//																"and n.nr_pedido_central is null)",1  )
//																
//	This.of_AppendWhere_Subquery("n.cgc_origem in (select distinct f.nr_cgc "+&
//															"from nf_compra n "+&
//															"inner join fornecedor f "+&
//																"on f.cd_fornecedor = n.cd_fornecedor "+&
//															"where n.dh_movimentacao_caixa >= (select dateadd(day, -365, dh_movimentacao) from parametro where id_parametro = '1') "+&
//																"and (f.id_distribuidora is null or f.id_distribuidora = 'N') "+&
//																"and n.nr_pedido_distribuidora is null "+&
//																"and n.nr_pedido_central is null)",6 )
End If

Return This.Retrieve(ldh_Inicio, ldh_Termino)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;String ls_Envia_Email

If CurrentRow > 0 Then
		dw_4.Object.De_Chave_Acesso[1] = dw_2.Object.De_Chave_Acesso[CurrentRow]
		ls_Envia_Email 							 = dw_2.Object.id_notifica_loja[CurrentRow]

		If ls_Envia_Email = "SIM" Then 
			cb_altera_notifica.enabled = True
			il_Registro	=	CurrentRow
		Else
			cb_altera_notifica.enabled = False
		End If 

End If



end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge545_nf_compra_manual_pendente
integer x = 137
integer y = 1128
end type

type dw_5 from dc_uo_dw_base within w_ge545_nf_compra_manual_pendente
boolean visible = false
integer x = 2135
integer y = 1096
integer width = 1362
integer height = 252
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "ddw_fornecedor_entrada_manual"
end type

type dw_4 from dc_uo_dw_base within w_ge545_nf_compra_manual_pendente
integer x = 69
integer y = 1744
integer width = 2021
integer height = 92
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge545_detalhe"
end type

type cb_altera_notifica from commandbutton within w_ge545_nf_compra_manual_pendente
integer x = 3241
integer y = 1736
integer width = 686
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Definir N$$HEX1$$e300$$ENDHEX$$o Notifica Loja"
end type

event clicked;String ls_Chave_Acesso , ls_Envia_Email_Atual, ls_Erro, ls_Operador
Long   ll_Registro
DateTime  ldh_Inicio, ldh_Termino 

dw_2.AcceptText()

ls_Envia_Email_Atual 	 		= dw_2.Object.id_notifica_loja[il_Registro]
ls_Chave_Acesso 				= dw_2.Object.de_chave_acesso[il_Registro]

ldh_Inicio 				= Datetime(dw_1.Object.dt_inicio 				[1], Time('00:00:00'))
ldh_Termino 			= Datetime(dw_1.Object.dt_termino 			[1],Time('23:59:59'))




If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE545_ALTERAR_NOTIFICACAO_LOJA", ref ls_Operador) Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o liberado, Solicitar o Acesso!")
		Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o para N$$HEX1$$c300$$ENDHEX$$O Notificar a Loja?", Question!, YesNo!, 2) = 2 Then Return -1


If ls_Envia_Email_Atual = "SIM"  Then
		
	Update  nfe_destinadas
	Set     id_notifica_loja  = 'N'
	Where 	de_chave_acesso  =:ls_Chave_Acesso
	And     (id_notifica_loja is null or id_notifica_loja ='S')
	Using SqlCA;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao Atualizar Notifica$$HEX2$$e700e300$$ENDHEX$$o. Chave de Acesso:" + String(ls_Chave_Acesso) + ". " + ls_Erro, StopSign!)
		Return -1
	Else
		If Not gf_Grava_Historico_Alteracao_Tabela('NFE_DESTINADAS', ls_Chave_Acesso, 'ID_NOTIFICA_LOJA', 'S', 'N', ls_Operador, 'A', Ref ls_Erro, True) Then Return -1		
		SqlCa.of_commit( )
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Opera$$HEX2$$e700e300$$ENDHEX$$o Realizada com Sucesso!")
		dw_2.Retrieve(ldh_Inicio, ldh_Termino)
	End If 
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Opera$$HEX2$$e700e300$$ENDHEX$$o N$$HEX1$$e300$$ENDHEX$$o Permitida!")
	Return -1	
End If 
end event

type gb_3 from groupbox within w_ge545_nf_compra_manual_pendente
integer x = 37
integer y = 1672
integer width = 2071
integer height = 176
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

