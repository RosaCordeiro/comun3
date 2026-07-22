HA$PBExportHeader$w_ge623_parametro_fornecedor_distrib.srw
forward
global type w_ge623_parametro_fornecedor_distrib from dc_w_cadastro_freeform
end type
type cb_1 from commandbutton within w_ge623_parametro_fornecedor_distrib
end type
end forward

global type w_ge623_parametro_fornecedor_distrib from dc_w_cadastro_freeform
integer width = 2245
integer height = 1344
string title = "GE623-Parametro Fornecedor e Distribuidora ( Atualiza$$HEX2$$e700e300$$ENDHEX$$o no SAP)"
event type boolean wf_proximo_codigo ( )
cb_1 cb_1
end type
global w_ge623_parametro_fornecedor_distrib w_ge623_parametro_fornecedor_distrib

type variables
uo_Fornecedor ivo_Fornecedor
end variables

on w_ge623_parametro_fornecedor_distrib.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge623_parametro_fornecedor_distrib.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event open;call super::open;ivo_Fornecedor = Create uo_Fornecedor
end event

event close;call super::close;Destroy(ivo_Fornecedor)
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Fornecedor

//dw_1.AcceptText()

//If Not gf_Verifica_Cutover("DH_CUTOVER_MATCH_CODE") Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais permitida atualiza$$HEX2$$e700e300$$ENDHEX$$o por esta tela. Utilizar o SAP.", Exclamation!)
//	Return False
//End If

//lvl_Fornecedor = dw_1.Object.cd_fornecedor[1]

//If IsNull(lvl_fornecedor) Then
//	If Not wf_Proximo_Codigo() Then Return False
//End If

Return True
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge623_parametro_fornecedor_distrib
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge623_parametro_fornecedor_distrib
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge623_parametro_fornecedor_distrib
integer x = 46
integer y = 56
integer width = 2103
integer height = 1016
string dataobject = "dw_ge623_parametro_fornecedor_distribuidora"
boolean vscrollbar = false
end type

event dw_1::constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"nm_localiza"}

This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
    Case "nr_cgc"   
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido alterar o campo CNPJ.")
         RETURN 1        
				
    Case "cd_fornecedor"
        	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido alterar o campo Fornecedor.")
        RETURN 1

    Case "nm_razao_social"
        //MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido alterar o campo Raz$$HEX1$$e300$$ENDHEX$$o Social.")
        RETURN 1
		  
    Case "nm_fantasia"
        //MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido alterar o campo Nome Fantasia.")
        RETURN 1
End Choose


end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivo_Fornecedor.of_Inicializa()

End If

Return AncestorReturnValue
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_localiza" Then
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			If ivo_Fornecedor.Localizado Then
				This.Event ue_Reset()
				This.Event ue_Recuperar()
			End If
	End If
End If
end event

event dw_1::ue_recuperar;// Override

Return This.Retrieve(ivo_Fornecedor.Cd_Fornecedor)
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_excluir( False)
This.ivm_Menu.mf_incluir( False)

Return pl_linhas
end event

event dw_1::ue_preupdate;call super::ue_preupdate;String ls_Fornecedor
String ls_Fantasia
String ls_Razao
String ls_CGC
String ls_IdDistribuidora
String ls_Sempedido
String ls_Layout
String ls_De
String ls_Para
String ls_Nulo
String ls_conexao


dw_1.AcceptText()

	ls_Fornecedor			= This.Object.cd_fornecedor							[1]
	ls_Fantasia 				= This.Object.nm_fantasia							[1]
	ls_Razao 				= This.Object.nm_razao_social						[1]
	ls_CGC 					= This.Object.nr_cgc									[1]
	ls_IdDistribuidora	= This.Object.id_distribuidora						[1]
	ls_Sempedido			= This.Object.id_permite_nota_sem_pedido	[1]
	ls_Layout				= This.Object.nr_layout_ped_eletronico_sap	[1]
	ls_conexao				= This.Object.id_projeto_conexao					[1] 
	
If	ls_Layout = '0' Then
    MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o Layout vazio ou no padr$$HEX1$$e300$$ENDHEX$$o 0.00")
    This.Event ue_Pos(1, "nr_layout_ped_eletronico_sap")
    Return -1
End If

				

end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge623_parametro_fornecedor_distrib
integer width = 2139
integer height = 1088
end type

type cb_1 from commandbutton within w_ge623_parametro_fornecedor_distrib
boolean visible = false
integer x = 1641
integer y = 748
integer width = 517
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "XXXXXXXXXX"
end type

event clicked;uo_ge644_empurrados_realocacao = CREATE uo_ge644_empurrados_realocacao

uo_ge644_empurrados_realocacao.of_principal()
end event

