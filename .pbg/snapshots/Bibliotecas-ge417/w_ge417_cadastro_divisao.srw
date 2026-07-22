HA$PBExportHeader$w_ge417_cadastro_divisao.srw
forward
global type w_ge417_cadastro_divisao from dc_w_response_ok_cancela
end type
type cb_excluir from commandbutton within w_ge417_cadastro_divisao
end type
end forward

global type w_ge417_cadastro_divisao from dc_w_response_ok_cancela
integer width = 1993
integer height = 768
string title = "GE417 - Divis$$HEX1$$e300$$ENDHEX$$o do Fornecedor"
cb_excluir cb_excluir
end type
global w_ge417_cadastro_divisao w_ge417_cadastro_divisao

type variables
string is_fornecedor

Long il_divisao

uo_Fornecedor				io_Fornecedor
uo_ge149_Comprador	io_Comprador
uo_condicao_pagamento	io_condicao
end variables

on w_ge417_cadastro_divisao.create
int iCurrent
call super::create
this.cb_excluir=create cb_excluir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_excluir
end on

on w_ge417_cadastro_divisao.destroy
call super::destroy
destroy(this.cb_excluir)
end on

event ue_postopen;// OverRide

ivo_dbError = Create dc_uo_dbError

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_AddRow()

io_Fornecedor 	= Create uo_Fornecedor
io_Comprador	= Create uo_ge149_Comprador
io_Condicao		= Create uo_Condicao_Pagamento

If il_divisao > 0 Then
	dw_1.Event ue_Retrieve()
Else 
	io_Fornecedor.of_Localiza_Codigo(is_fornecedor)
		
	If io_Fornecedor.Localizado Then
		dw_1.Object.Cd_Fornecedor		[1] = io_Fornecedor.Cd_Fornecedor
		dw_1.Object.nm_razao_social		[1] = io_Fornecedor.Nm_Razao_Social
	End If
End If
end event

event ue_presave;call super::ue_presave;String ls_Comprador, ls_Divisao

Long ll_Cond_Pagto

dw_1.AcceptText()

ls_Comprador 	= dw_1.Object.nr_matricula_comprador	[1]
ls_Divisao		= dw_1.Object.nm_divisao					[1]
ll_Cond_Pagto 	= dw_1.Object.cd_condicao_pagamento[1]

If IsNull(ls_Divisao) or trim(ls_Divisao) = ''  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a descri$$HEX1$$e700$$ENDHEX$$ao da divis$$HEX1$$e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "nm_divisao")
	Return False
End If

If IsNull(ll_Cond_Pagto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento.")
	dw_1.Event ue_Pos(1, "de_condicao_pagamento")
	Return False
End If
	
If IsNull(ls_Comprador) or trim(ls_Comprador) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o comprador.")
	dw_1.Event ue_Pos(1, "nm_usuario")
	Return False
End If

// Novo
If il_divisao = 0 Then
		
	Select coalesce(max(nr_divisao), 0) + 1 
	Into :il_divisao
	From fornecedor_divisao
	Where cd_fornecedor = :is_fornecedor
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo da divis$$HEX1$$e300$$ENDHEX$$o do fornecedor.")
		Return False
	End If
	
	dw_1.Object.nr_divisao[1] = il_divisao
		
End If

Return True
end event

event ue_save;call super::ue_save;If AncestorReturnValue <> -1 Then
	Close(This)
End If

Return AncestorReturnValue
end event

event open;call super::open;String ls_Parametro

ls_Parametro = Message.StringParm	

is_fornecedor 	= Mid(ls_Parametro, 1, 9)
il_divisao 		= Long(Mid(ls_Parametro, 10, 2))


end event

event close;call super::close;Destroy io_Fornecedor
Destroy io_Comprador
Destroy io_Condicao
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge417_cadastro_divisao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge417_cadastro_divisao
integer width = 1915
integer height = 532
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge417_cadastro_divisao
integer width = 1842
integer height = 444
string dataobject = "dw_ge417_cadastro_divisao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;//OverRide

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
		cb_ok.Enabled = True
	End If
End If
end event

event dw_1::itemchanged;//OverRide

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
		cb_ok.Enabled = True
	End If
End If


If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Comprador.Nm_Usuario Then
			Return 1
		End If
	Else
		io_Comprador.of_Inicializa()
		
		This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
		This.Object.nm_usuario  				[1] = io_Comprador.Nm_Usuario
	End If
End If

If dwo.Name = "de_condicao_pagamento" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If data <> io_Condicao.de_Condicao Then
			Return 1
		End If 
	Else
		io_Condicao.of_Inicializa()
		
		This.Object.Cd_Condicao_Pagamento[1] = io_Condicao.Cd_Condicao
		This.Object.De_Condicao_Pagamento[1] = io_Condicao.De_Condicao
	End If
End If


end event

event dw_1::ue_recuperar;//OverRide
dw_1.AcceptText()

If il_divisao > 0 Then
	This.of_AppendWhere("d.cd_fornecedor = '" + is_fornecedor + "'")
	This.of_AppendWhere("d.nr_divisao = " + string(il_Divisao))
End If

Return This.Retrieve()

end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;This.AcceptText()

If pl_Linhas > 0 Then
	io_Fornecedor.of_Localiza_Codigo(This.Object.cd_fornecedor[1])
		
	If io_Fornecedor.Localizado Then
		dw_1.Object.nm_razao_social		[1] = io_Fornecedor.Nm_Razao_Social
	End If
	
	If Not IsNull(This.Object.nm_usuario[1]) Then
		io_Comprador.of_Localiza_Comprador(This.Object.nr_matricula_comprador[1])
		
		If io_Comprador.Localizado Then
			This.Object.nm_usuario  				[1] = io_Comprador.nm_usuario
		End If
	End If
		
	If Not IsNull(This.Object.cd_condicao_pagamento[1]) Then
		If io_Condicao.of_Localiza_Codigo(This.Object.cd_condicao_pagamento[1]) Then
			dw_1.Object.de_Condicao_Pagamento[1] = io_Condicao.De_Condicao
		End If		
	End If
End If

Return pl_Linhas
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_usuario" Then
		io_Comprador.of_Localiza_Comprador(This.GetText())
		
		If io_Comprador.Localizado Then
			This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
			This.Object.nm_usuario  				[1] = io_Comprador.nm_usuario
		End If
	End If
	
	If This.GetColumnName() = "de_condicao_pagamento" Then
		io_Condicao.ib_Valida_Situacao = True
		If io_Condicao.of_Localiza(This.GetText()) Then
			dw_1.Object.cd_Condicao_Pagamento[1] = io_Condicao.Cd_Condicao
			dw_1.Object.de_Condicao_Pagamento[1] = io_Condicao.De_Condicao
		End If
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(io_Comprador) Then
	This.Object.nr_matricula_comprador	[1] 	= io_Comprador.nr_matricula
	This.Object.nm_usuario  				[1] 	= io_Comprador.nm_usuario
End If

If IsValid(io_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = io_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Razao_Social[1] = io_Fornecedor.Nm_Razao_Social
End If

If IsValid(io_Condicao) Then
	This.Object.De_Condicao_Pagamento[1] = io_Condicao.De_Condicao
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge417_cadastro_divisao
integer x = 1285
integer y = 552
boolean enabled = false
string text = "&Salvar"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Parent.Event ue_Save()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge417_cadastro_divisao
integer x = 1627
integer y = 552
end type

type cb_excluir from commandbutton within w_ge417_cadastro_divisao
integer x = 23
integer y = 552
integer width = 325
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Excluir"
end type

event clicked;Long ll_Produtos
Long ll_Divisao

String ls_Fornecedor
String ls_Erro

dw_1.AcceptText()

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o da divis$$HEX1$$e300$$ENDHEX$$o do fornecedor ?", Question!, YesNo!, 1) = 2 Then
	Return 
End If

ls_Fornecedor	= dw_1.Object.Cd_Fornecedor	[1]
ll_Divisao			= dw_1.Object.Nr_Divisao		[1]

Select count(*) 
Into :ll_Produtos
From fornecedor_divisao_produto
Where cd_fornecedor 	= :is_Fornecedor
	and nr_divisao			= :il_Divisao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar os produtos da divis$$HEX1$$e300$$ENDHEX$$o.")
	Return
End If

If ll_Produtos > 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Exclus$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida porque existem produtos cadastrados para esta divis$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
	Return
End If

Update fornecedor_contato 
	Set nr_divisao_fornecedor = Null
Where cd_fornecedor = :ls_Fornecedor
	And nr_divisao_fornecedor = :ll_Divisao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no update da tabela fornecedor_contato. " + ls_Erro, StopSign!)
	Return -1
End If

Update agrupamento_dev_compra  
	Set nr_divisao_fornecedor = Null,
		 nr_matricula_comprador = Null
Where cd_fornecedor = :ls_Fornecedor
	And nr_divisao_fornecedor = :ll_Divisao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no update da tabela agrupamento_dev_compra. " + ls_Erro, StopSign!)
	Return -1
End If

Delete fornecedor_divisao
Where cd_fornecedor =:is_fornecedor
	and nr_divisao		= :il_divisao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao excluir a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor.")
	Return
Else
	SqlCa.of_Commit()
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A divis$$HEX1$$e300$$ENDHEX$$o foi excluida com sucesso.")
	Close(Parent)
End If
end event

