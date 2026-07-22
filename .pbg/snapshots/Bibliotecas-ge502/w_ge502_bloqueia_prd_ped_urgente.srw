HA$PBExportHeader$w_ge502_bloqueia_prd_ped_urgente.srw
forward
global type w_ge502_bloqueia_prd_ped_urgente from dc_w_cadastro_lista
end type
type dw_2 from dc_uo_dw_base within w_ge502_bloqueia_prd_ped_urgente
end type
end forward

global type w_ge502_bloqueia_prd_ped_urgente from dc_w_cadastro_lista
integer width = 3790
string title = "GE502 - Bloqueia Produto para o Pedido Ecommerce"
dw_2 dw_2
end type
global w_ge502_bloqueia_prd_ped_urgente w_ge502_bloqueia_prd_ped_urgente

type variables
uo_produto ivo_Produto
end variables

forward prototypes
public function boolean wf_update (dc_uo_dw_base adw_de, dc_uo_dw_base adw_para, string as_valor)
end prototypes

public function boolean wf_update (dc_uo_dw_base adw_de, dc_uo_dw_base adw_para, string as_valor);Long ll_Linha
Long ll_Produto
Long ll_Find

String ls_Erro

dw_1.AcceptText()

For ll_Linha = 1 To adw_de.RowCount()
	ll_Produto = adw_De.Object.Cd_Produto[ll_Linha]
	
	If IsNull(ll_Produto) Then Continue
	
	ll_Find = adw_Para.Find("cd_produto = " + String(ll_Produto), 1, adw_Para.RowCount())
	
	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find.", StopSign!)
		Return False
	End If

	If ll_Find = 0 Then
		Update produto_central
			Set id_desconsidera_saldo_cd = :as_Valor
		Where cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no update do campo produto_central.id_desconsidera_saldo_cd para o produto " + String(ll_Produto) + ".", StopSign!)
			Return False
		End If
		
		If as_Valor = "N" Then //Se foi removido o bloqueio
			If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(ll_Produto), "ID_DESCONSIDERA_SALDO_CD" , "S", "N", String(gvo_Aplicacao.ivo_Seguranca.Nr_Matricula), "A", Ref ls_Erro, True) Then Return False
		Else
			If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_CENTRAL", String(ll_Produto), "ID_DESCONSIDERA_SALDO_CD" , "N", "S", String(gvo_Aplicacao.ivo_Seguranca.Nr_Matricula), "A", Ref ls_Erro, True) Then Return False
		End If
	End If
Next

Return True
end function

on w_ge502_bloqueia_prd_ped_urgente.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_ge502_bloqueia_prd_ped_urgente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
end on

event close;call super::close;Destroy(ivo_Produto)
end event

event ue_preopen;call super::ue_preopen;ivo_Produto = Create uo_produto
end event

event ue_update;//OverRide

Return True
end event

event ue_save;//OverRide

//dw_1 $$HEX1$$e900$$ENDHEX$$ a dw_lista, dw_2 $$HEX1$$e900$$ENDHEX$$ o valor original
//Na primeira chamada da fun$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ verificado se houve exclus$$HEX1$$e300$$ENDHEX$$o
//Na segunda chamada, $$HEX1$$e900$$ENDHEX$$ verificado se houve inclus$$HEX1$$e300$$ENDHEX$$o
If Not wf_Update(dw_2, dw_1, "N") Then Return -1

If Not wf_Update(dw_1, dw_2, "S") Then Return -1

SqlCa.of_Commit()

This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)

dw_1.Event ue_Retrieve()

Return 1
end event

event ue_cancel;call super::ue_cancel;//OverRide
This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)

dw_1.Event ue_Retrieve()
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge502_bloqueia_prd_ped_urgente
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge502_bloqueia_prd_ped_urgente
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge502_bloqueia_prd_ped_urgente
integer width = 3598
integer height = 1164
string dataobject = "dw_ge502_lista"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque	Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto[This.GetRow()] = ivo_Produto.cd_produto
			This.Object.de_Produto[This.GetRow()] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque		
		End If
			
End Choose
end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	This.ivm_Menu.mf_Cancelar(True)
End If

Return AncestorReturnValue
end event

event dw_1::ue_key;call super::ue_key;Long ll_Find

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			ll_Find = This.Find("cd_produto = " + String(ivo_Produto.cd_produto), 1, This.RowCount())
			
			If ll_Find > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto " + ivo_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(ivo_Produto.cd_produto) + ") j$$HEX1$$e100$$ENDHEX$$ consta na lista.", Exclamation!)
				ivo_Produto.of_Inicializa()
				Return -1
			End If
			
			If ivo_Produto.Localizado Then
				This.Object.cd_produto	[This.GetRow()] = ivo_Produto.cd_produto
				This.Object.de_produto	[This.GetRow()] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
				This.Object.Id_Situacao	[This.GetRow()] = ivo_Produto.Id_Situacao
			End If
	End Choose
End If
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;dw_1.AcceptText()

If This.RowCount() > 0 Then
	If IsNull(This.Object.Cd_Produto[This.RowCount()]) Then
		Return -1
	End If
End If

Return 1
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;dw_2.Event ue_Reset()

If dw_1.RowCount() > 0 Then
	If dw_1.RowsCopy(1, dw_1.RowCount(), Primary!, dw_2, 1, Primary!) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no RowsCopy da dw_2.", StopSign!)
		Return -1
	End If
End If

Return 1
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge502_bloqueia_prd_ped_urgente
integer width = 3675
integer weight = 700
string text = "Bloqueia Produto para Pedido Urgente das Filiais"
end type

type dw_2 from dc_uo_dw_base within w_ge502_bloqueia_prd_ped_urgente
boolean visible = false
integer x = 1723
integer y = 636
integer width = 1179
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge502_lista"
end type

