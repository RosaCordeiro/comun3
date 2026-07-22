HA$PBExportHeader$w_ge526_cadastro_frete_bairro.srw
forward
global type w_ge526_cadastro_frete_bairro from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge526_cadastro_frete_bairro
end type
end forward

global type w_ge526_cadastro_frete_bairro from dc_w_cadastro_selecao_lista
string accessiblename = "Cadastro de Frete por Bairro (GE526)"
integer width = 3131
integer height = 1908
string title = "GE526 - Cadastro de Frete por Bairro"
cb_1 cb_1
end type
global w_ge526_cadastro_frete_bairro w_ge526_cadastro_frete_bairro

type variables
uo_cidade ivo_Cidade // GE008
end variables

on w_ge526_cadastro_frete_bairro.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge526_cadastro_frete_bairro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event close;call super::close;If IsValid(ivo_Cidade) Then Destroy(ivo_Cidade)
end event

event ue_postopen;call super::ue_postopen;ivo_Cidade = Create uo_Cidade
This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Excluir(False)


ivo_Cidade.of_Localiza_Codigo(gvo_Parametro.Cd_Cidade)
			
If ivo_Cidade.Localizada Then				
	dw_1.Object.Cd_Cidade[1] 	= ivo_Cidade.Cd_Cidade
	dw_1.Object.Nm_Cidade[1] 	= ivo_Cidade.Nm_Cidade
End If
end event

event ue_preopen;call super::ue_preopen;String ls_Vl_Parametro

Try
	
	uo_parametro_filial lo_Parametro
	lo_Parametro = Create uo_parametro_filial
	
	If Not lo_Parametro.of_Localiza_Parametro("ID_USA_POO_SITEF", Ref ls_Vl_Parametro, True) Then Return
	
	If ls_Vl_Parametro = "N" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta tela $$HEX1$$e900$$ENDHEX$$ habilitada somente para filiais que operam o Disque Entrega.~r~r" + &
										"Se sua filial ir$$HEX1$$e100$$ENDHEX$$ iniciar a opera$$HEX2$$e700e300$$ENDHEX$$o do Disque Entrega, entre em contato com o setor de Opera$$HEX2$$e700f500$$ENDHEX$$es Comerciais para solicitar a libera$$HEX2$$e700e300$$ENDHEX$$o.")
		This.il_Retorno = -1
		Return
	End If

	If Not This.ib_Solicitou_Liberacao_Procedimento_Base  Then
		If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "w_ge526_cadastro_frete_bairro", ref This.is_Matricula_Abertura_Tela ) Then 
			This.il_Retorno = -1
		End If
	End If
	
Catch (RunTimeError lo_error)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lo_error.GetMessage(), StopSign!)
	Return
Finally
	If IsValid(lo_Parametro) Then Destroy(lo_Parametro)
End Try
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	dw_1.Object.Vl_Novo_Frete[1] = 0.00
End If

Return AncestorReturnValue
end event

event ue_presave;call super::ue_presave;Boolean lb_Permite = False

Decimal ldc_Frete

Long ll_Linha

String ls_Para

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	If gf_Houve_Alteracao_Dw(dw_2, 'VL_FRETE', ll_Linha, Ref ls_Para) Then
		
		dw_2.Object.nr_matricula_alteracao_frete [ll_Linha] = This.is_matricula_abertura_tela
		
		ldc_Frete = dw_2.Object.Vl_Frete[ll_Linha]
		
		If ldc_Frete > 50.00 And Not lb_Permite Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe um ou mais fretes cadastrados com valor maior que R$ 50,00.~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
				Return False
			End If
			
			lb_Permite = True
		End If
	End If
Next

Return True
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge526_cadastro_frete_bairro
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge526_cadastro_frete_bairro
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge526_cadastro_frete_bairro
integer x = 46
integer y = 60
integer width = 2213
integer height = 92
string dataobject = "dw_ge526_selecao"
end type

event dw_1::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName() 
		Case "nm_cidade"
			
			ivo_Cidade.of_Localiza_Cidade(This.GetText())
			
			If ivo_Cidade.Localizada Then				
				This.Object.Cd_Cidade[This.GetRow()] 	= ivo_Cidade.Cd_Cidade
				This.Object.Nm_Cidade[This.GetRow()] 	= ivo_Cidade.Nm_Cidade
				
				dw_1.Object.Vl_Novo_Frete[1] = 0.00 
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name <> "vl_novo_frete" Then
	dw_2.Event ue_Reset()
End If

Choose Case dwo.Name
	Case "nm_cidade"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> ivo_Cidade.Nm_Cidade Then
				Return 1
			End If
		Else
			ivo_Cidade.Of_Inicializa()
			
			This.Object.Cd_Cidade 		[1] = ivo_Cidade.Cd_Cidade
			This.Object.Nm_Cidade		[1] = ivo_Cidade.Nm_Cidade
		End If
End Choose
end event

event dw_1::editchanged;call super::editchanged;If dwo.Name <> "vl_novo_frete" Then
	dw_2.Event ue_Reset()
End If
end event

event dw_1::ue_cancel;//OverRide
end event

event dw_1::getfocus;call super::getfocus;This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Excluir(False)
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge526_cadastro_frete_bairro
integer x = 18
integer y = 168
integer width = 3054
integer height = 1540
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge526_cadastro_frete_bairro
integer x = 18
integer y = 0
integer width = 2249
integer height = 164
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge526_cadastro_frete_bairro
integer x = 50
integer y = 236
integer width = 2999
integer height = 1452
string dataobject = "dw_ge526_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// OverRide

Long lvl_Cd_Cidade

dw_1.AcceptText()

lvl_Cd_Cidade = dw_1.Object.Cd_Cidade[1]

If lvl_Cd_Cidade > 0 Then
	This.Of_AppendWhere("cid.cd_cidade = " + String(lvl_Cd_Cidade))
End If

This.of_AppendWhere("ecl.cd_uf = '" + gvo_Parametro.ivs_UF_Filial + "'")

Return This.Retrieve()
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_uf", "de_localidade", "de_bairro","vl_frete"}

lvs_Nome = {"UF", "Localidade", "Bairro", "Valor Frete"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

ivi_Tipo_Cancelar = RETRIEVE


end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Excluir(False)
Return pl_Linhas

end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText()

If IsNull(dw_1.Object.Cd_Cidade[1]) Or (ivo_Cidade.Cd_Unidade_Federacao <> gvo_Parametro.ivs_UF_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe alguma cidade da UF [" + gvo_Parametro.ivs_UF_Filial + "].", Exclamation!)
	dw_1.Event ue_Pos(1, "nm_cidade")
	Return -1
End If

Return 1
end event

event dw_2::getfocus;call super::getfocus;This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Excluir(False)
end event

type cb_1 from commandbutton within w_ge526_cadastro_frete_bairro
integer x = 2368
integer y = 52
integer width = 695
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Atualizar Valores Abaixo"
end type

event clicked;Decimal ldc_Novo_Frete

Long ll_Linha

dw_1.AcceptText()

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem registros para serem atualizados.")
	Return -1
End If

ldc_Novo_Frete = dw_1.Object.Vl_Novo_Frete[1]

If IsNull(ldc_Novo_Frete) Or ldc_Novo_Frete = 0.00 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor do [Novo Frete] deve ser maior que 0.")
	dw_1.Event ue_Pos(1, "vl_novo_frete")
	Return -1
End If

If ldc_Novo_Frete > 50.00 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel atualizar todos os fretes com valor acima de R$ 50,00.~rSe for necess$$HEX1$$e100$$ENDHEX$$rio, atualize os fretes individualmente.")
	dw_1.Event ue_Pos(1, "vl_novo_frete")
	Return -1
End If

For ll_Linha = 1 To dw_2.RowCount()
	dw_2.Object.Vl_Frete[ll_Linha] = ldc_Novo_Frete
Next

Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)

ivb_Valida_Salva = True
end event

