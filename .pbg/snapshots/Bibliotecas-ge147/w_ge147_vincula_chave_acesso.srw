HA$PBExportHeader$w_ge147_vincula_chave_acesso.srw
forward
global type w_ge147_vincula_chave_acesso from dc_w_response_ok_cancela
end type
type cb_desvincula from commandbutton within w_ge147_vincula_chave_acesso
end type
end forward

global type w_ge147_vincula_chave_acesso from dc_w_response_ok_cancela
string accessiblename = "Vincula Chave de Acesso(GE147)"
integer width = 1783
integer height = 944
string title = "GE147 - Vincula Chave de Acesso"
cb_desvincula cb_desvincula
end type
global w_ge147_vincula_chave_acesso w_ge147_vincula_chave_acesso

type variables
Long il_Pedido
end variables

forward prototypes
public function boolean wf_verifica_nf_cancelada (string as_chave_acesso)
public function boolean wf_valida_fornecedor (string as_chave_acesso, ref string as_situacao_pedido, ref decimal ad_percent_atend)
public function boolean wf_valida_produto_xml (string as_chave_acesso)
end prototypes

public function boolean wf_verifica_nf_cancelada (string as_chave_acesso);Long ll_Achou

Select Count(*)
Into :ll_Achou
From nfe_destinadas
Where de_chave_acesso = :as_chave_acesso
   And id_situacao_nf = '3'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na consulta da tabela NFE_DESTINADAS")
	Return False
End If

//Verifica se a nota n$$HEX1$$e300$$ENDHEX$$o esta cancelada. Se o retorno da consulta acima retornar maior que zero significa que nota foi cancelada.

If ll_Achou > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "NF de chave '" + as_chave_acesso + "' cancelada pelo fornecedor", Exclamation!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_valida_fornecedor (string as_chave_acesso, ref string as_situacao_pedido, ref decimal ad_percent_atend);String ls_CGC_Index
String ls_CGC_Cad

Select cgc_origem
Into :ls_CGC_Index
From nfe_indexacao
Where id_nf =: as_Chave_Acesso
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o CNPJ do fornecedor na tabela NFE_INDEXACAO")
		Return False
		
	Case -1
		SqlCa.of_MsgdbError("Erro na consulta do CNPJ do fornecedor na tabela NFE_INDEXACAO")
		Return False
End Choose

Select		f.nr_cgc,
			p.id_situacao,
			(Select Round((coalesce(sum(qt_recebida), 0) * 100) / coalesce(sum(qt_pedida - coalesce(qt_devolvida, 0)), 0), 2)
         	From pedido_central_produto
          	Where nr_pedido = p.nr_pedido) pc_atendido
Into :ls_CGC_Cad, :as_Situacao_Pedido, :ad_Percent_Atend
From pedido_central p
	Inner Join fornecedor f
		On f.cd_fornecedor = p.cd_fornecedor
Where p.nr_pedido =: il_Pedido
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o CNPJ do fornecedor na tabela FORNECEDOR")
		Return False
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao consultar o CNPJ do fornecedor na tabela FORNECEDOR")
		Return False
End Choose

If ls_CGC_Index <> ls_CGC_Cad Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O CNPJ do XML '" + ls_CGC_Index + "' $$HEX1$$e900$$ENDHEX$$ diferente do CNPJ '" + ls_CGC_Cad + "'do pedido.")
	Return False
End If

Return True
end function

public function boolean wf_valida_produto_xml (string as_chave_acesso);Long ll_Achou
Long ll_Linha
Long ll_Item_Pedido

String ls_Ean
String ls_Ean_Trib

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("ds_ge147_produto_informado_xml") Then
	Destroy(lds)
	Return False
End If

lds.AcceptText()

lds.Retrieve(as_chave_acesso)

If lds.RowCount() > 0 Then

	For ll_Linha = 1 To lds.RowCount()
		
		ll_Achou = 0
		
		ls_Ean		= lds.Object.De_Codigo_Barras			[ll_Linha]
		ls_Ean_Trib	= lds.Object.De_Codigo_Barras_Trib	[ll_Linha]
			
		If ls_Ean <> "" Or ls_Ean_Trib <> "" Then
			
			//<cEAN>
			If ls_Ean <> "" Then
				ls_Ean = "%"+gf_Tira_Zero_Esquerda(ls_Ean)
					
				Select Count(*)
				Into :ll_Achou
				From pedido_central_produto as p
					Inner Join codigo_barras_produto as c
						On c.cd_produto = p.cd_produto
				Where p.nr_pedido = :il_Pedido
					 And c.de_codigo_barras Like :ls_Ean
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					Destroy(lds)
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto. EAN '" + ls_Ean + "'." + SqlCa.SqlErrText, StopSign!)
					Return False
				End If
			End If
		
			If ll_Achou <= 0 Then
			
				//<cEANTrib>
				If ls_Ean_Trib <> "" Then
					ls_Ean_Trib = "%"+gf_Tira_Zero_Esquerda(ls_Ean_Trib)
						
					Select Count(*)
					Into :ll_Achou
					From pedido_central_produto as p
						Inner Join codigo_barras_produto as c
							On c.cd_produto = p.cd_produto
					Where p.nr_pedido = :il_Pedido
						 And c.de_codigo_barras Like :ls_Ean_Trib
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						Destroy(lds)
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto. EAN '" + ls_Ean + "'." + SqlCa.SqlErrText, StopSign!)
						Return False
					End If
					
					If ll_Achou <=0 Then
						Destroy(lds)
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto no pedido com EAN (<cEAN>) '" + ls_EAN + "' e com EAN (<cEANTrib>) '" + ls_Ean_Trib + "' .", StopSign!)
						Return False
					End If
				Else
					
					Destroy(lds)
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "EAN (<cEAN>)'" + ls_Ean + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado no pedido e n$$HEX1$$e300$$ENDHEX$$o foi informado o EAN na tag (<cEANTrib>).", StopSign!)
					Return False
				End If
			End If
			
		Else
			
			ll_Item_Pedido = lds.Object.Nr_Item_Pedido[ll_Linha]
			
			Select Count(*)
			Into :ll_Achou
			From pedido_central_produto as p
			Where p.nr_pedido	= :il_Pedido
				 And p.cd_produto	= :ll_Item_Pedido
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				Destroy(lds)
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto '" + String(ll_Item_Pedido) + "' no pedido." + SqlCa.SqlErrText, StopSign!)
				Return False
			End If
				
			If ll_Achou <=0 Then
				Destroy(lds)
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi informado o EAN no XML." + &
								"~rC$$HEX1$$f300$$ENDHEX$$digo do produto '" + String(ll_Item_Pedido) + "' informado no XML n$$HEX1$$e300$$ENDHEX$$o foi localizado no pedido.", StopSign!)
				Return False
			Else
				Return True
			End If
		End If
	Next
End If
	
Destroy(lds)

Return True
end function

on w_ge147_vincula_chave_acesso.create
int iCurrent
call super::create
this.cb_desvincula=create cb_desvincula
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_desvincula
end on

on w_ge147_vincula_chave_acesso.destroy
call super::destroy
destroy(this.cb_desvincula)
end on

event open;call super::open;String ls_Pedido

ls_Pedido = Message.StringParm

il_Pedido = Long(ls_Pedido)

dw_1.Retrieve(il_Pedido)
end event

event ue_postopen;//OverRide

Long ll_Linha

dw_1.AcceptText()

If dw_1.RowCount() = 0 Then
	dw_1.InsertRow(0)
End If

For ll_Linha = 1 To dw_1.RowCount()
	dw_1.Object.Nr_Pedido[ll_Linha] = il_Pedido
Next

dw_1.Event ue_Pos(dw_1.RowCount(), "de_chave_acesso")

pb_Help.Visible = True
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge147_vincula_chave_acesso
integer x = 791
integer y = 732
integer height = 108
end type

event pb_help::clicked;call super::clicked;wf_Help( "Vincula Chave de Acesso (GE147)" )
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge147_vincula_chave_acesso
integer x = 27
integer width = 1696
integer height = 716
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge147_vincula_chave_acesso
integer x = 59
integer width = 1637
integer height = 616
string dataobject = "dw_ge147_vincula_chave_acesso"
boolean vscrollbar = true
end type

event dw_1::doubleclicked;call super::doubleclicked;Long ll_Linha
Long ll_Linhas

String ls_Marcado

If dwo.Name = 'st_pedido_selecionado' Then

	ls_Marcado = This.Object.Id_Selecionado[1]
	
	ll_Linhas = This.RowCount()
	
	For ll_Linha = 1 To ll_Linhas
		
		If ls_Marcado = 'S' Then
			This.Object.Id_Selecionado[ll_Linha] = 'N'
		Else
			This.Object.Id_Selecionado[ll_Linha] = 'S'
		End If
	Next
	
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then	
	This.Event ue_AddRow()
	dw_1.Object.Nr_Pedido[dw_1.GetRow()] = il_Pedido
End If
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;Long ll_Tamanho

This.AcceptText()

If This.RowCount() > 0 Then
	If IsNull(This.Object.De_Chave_Acesso[This.RowCount()]) Or This.Object.De_Chave_Acesso[This.RowCount()] = ""Then
		Return 0
	End If
	
	ll_Tamanho = LenA(This.Object.De_Chave_Acesso[This.RowCount()])
	
	If ll_Tamanho < 44 Then
		Return 0
	End If
End If

Return AncestorReturnValue
end event

event dw_1::ue_predeleterow;call super::ue_predeleterow;Long ll_Tamanho

This.AcceptText()

If This.RowCount() > 0 Then
	If IsNull(This.Object.De_Chave_Acesso[This.RowCount()]) Or This.Object.De_Chave_Acesso[This.RowCount()] = ""Then
		Return False
	End If
	
	ll_Tamanho = LenA(This.Object.De_Chave_Acesso[This.RowCount()])
	
	If ll_Tamanho < 44 Then
		Return False
	End If
End If

Return AncestorReturnValue
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge147_vincula_chave_acesso
integer x = 1079
integer y = 740
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Decimal ldc_Percent_Atend

Long ll_Linha
Long ll_Linhas
Long ll_Find
Long ll_Tamanho

String ls_Chave_Acesso
String ls_Selecionado
String ls_Situacao_Pedido
String ls_De_Situacao

dw_1.AcceptText()

If dw_1.RowCount() > 1 Then
	If IsNull(dw_1.Object.De_Chave_Acesso[dw_1.RowCount()]) Or dw_1.Object.De_Chave_Acesso[dw_1.RowCount()] = "" Then
		dw_1.DeleteRow(dw_1.RowCount())
	End If
End If

ll_Linhas = dw_1.RowCount()

If ll_Linhas > 0 Then
	
	For ll_Linha = 1 To ll_Linhas
			
		ls_Selecionado = dw_1.Object.Id_Selecionado[ll_Linha]
		
		ll_Find = dw_1.Find("id_selecionado = 'S'", 1, dw_1.RowCount())
		
		If ll_Find = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ao menos uma chave de acesso para ser vinculada.")
			Return -1
		End If
		
		If ls_Selecionado = 'S' Then
						
			ls_Chave_Acesso = dw_1.Object.De_Chave_Acesso[ll_Linha]
			
			If IsNull(ls_Chave_Acesso) Or ls_Chave_Acesso = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Chave de acesso n$$HEX1$$e300$$ENDHEX$$o informada.")
				Return -1
			End If
										
			If Not gf_Valida_Chave_Nfe(ls_Chave_Acesso) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Chave de acesso '" + ls_Chave_Acesso + "' inv$$HEX1$$e100$$ENDHEX$$lida.", Exclamation!)
				Return -1
			End If
			
			If Not wf_Verifica_Nf_Cancelada(ls_Chave_Acesso) Then
				Return -1
			End If
			
			If Not wf_Valida_Fornecedor(ls_Chave_Acesso, Ref ls_Situacao_Pedido, Ref ldc_Percent_Atend) Then
				Return -1
			End If
			
			Choose Case ls_Situacao_Pedido
				Case "A"
					ls_De_Situacao = "100% Atendido"
				Case "R"
					ls_De_Situacao = "Rascunho"
				Case "X"
					ls_De_Situacao = "Cancelado"
				Case "P"
					ls_De_Situacao = "Pendente"
			End Choose
			
			If (ls_Situacao_Pedido = "A" And ldc_Percent_Atend = 100) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Situa$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + ls_De_Situacao + "' inv$$HEX1$$e100$$ENDHEX$$lida para vincula$$HEX2$$e700e300$$ENDHEX$$o.")
				Return -1
			ElseIf ls_Situacao_Pedido <> "C" And ls_Situacao_Pedido <> "A" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Situa$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + ls_De_Situacao + "' inv$$HEX1$$e100$$ENDHEX$$lida para vincula$$HEX2$$e700e300$$ENDHEX$$o.")
					Return -1
			End If
			
			If Not wf_Valida_Produto_Xml(ls_Chave_Acesso) Then
				Return -1
			End If
		End If
	Next
	
	If dw_1.Event ue_Update() = -1 Then
		SqlCa.of_RollBack();
		Return -1
	Else
		SqlCa.of_Commit();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Chave de acesso vinculada com sucesso.")
		CloseWithReturn(w_ge147_Vincula_Chave_Acesso, "")
	End If
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge147_vincula_chave_acesso
integer x = 1413
integer y = 740
end type

type cb_desvincula from commandbutton within w_ge147_vincula_chave_acesso
integer x = 27
integer y = 740
integer width = 750
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Desvinc. Chave de Acesso"
end type

event clicked;Long ll_Nr_Nf
Long ll_GetRow
Long ll_Find

String ls_Chave_Acesso
String ls_Erro_Sql
String ls_Selecionado

dw_1.AcceptText()

ll_GetRow = dw_1.GetRow()

If dw_1.RowCount() > 1 Then
	If IsNull(dw_1.Object.De_Chave_Acesso[dw_1.RowCount()]) Or dw_1.Object.De_Chave_Acesso[dw_1.RowCount()] = "" Then
		dw_1.DeleteRow(dw_1.RowCount())
	End If
End If

ls_Selecionado = dw_1.Object.Id_Selecionado[ll_GetRow]

ll_Find = dw_1.Find("id_selecionado = 'S'", 1, dw_1.RowCount())

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ao menos uma chave de acesso para ser desvinculada.")
	Return -1
End If

If ls_Selecionado = "S" Then
	
	ls_Chave_Acesso = dw_1.Object.De_Chave_Acesso[ll_GetRow]
	
	Select nr_nf
	Into :ll_Nr_Nf
	From nf_compra_pendente
	Where de_chave_acesso = :ls_Chave_Acesso
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			//
	
		Case 100
			
			Select nr_nf
			Into :ll_Nr_Nf
			From nf_compra
			Where de_chave_acesso = :ls_Chave_Acesso
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError('Erro ao consultar a tabela NF_COMPRA')
				Return -1
			End If
			
		Case -1
			SqlCa.of_MsgdbError('Erro ao consultar a tabela NF_COMPRA_PENDENTE')
			Return -1
	End Choose
	
	If Not IsNull(ll_Nr_Nf) And ll_Nr_Nf <> 0 Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "NF '" + String(ll_Nr_Nf) + "' j$$HEX1$$e100$$ENDHEX$$ foi importada." + &
										"~rDeseja continuar?", Question!, YesNo!) = 2 Then
			Return -1
		End If
	End If
			
	Delete pedido_central_chave_acesso_nf
	Where nr_pedido = :il_Pedido
		 And de_chave_acesso = :ls_Chave_Acesso
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro_Sql = SqlCa.SqlErrText
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao desvincular a chave de acesso do pedido.")
		Return -1
	Else
		SqlCa.of_Commit();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Chave de acesso desvinculada com sucesso.")
		CloseWithReturn(w_ge147_Vincula_Chave_Acesso, "")
	End If
End If
end event

