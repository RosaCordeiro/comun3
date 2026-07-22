HA$PBExportHeader$w_ge033_dados_adicionais_cliente.srw
forward
global type w_ge033_dados_adicionais_cliente from dc_w_response_ok_cancela
end type
end forward

global type w_ge033_dados_adicionais_cliente from dc_w_response_ok_cancela
integer width = 2866
integer height = 656
string title = "GE033 - Informa$$HEX2$$e700f500$$ENDHEX$$es de Clientes"
long backcolor = 80269524
end type
global w_ge033_dados_adicionais_cliente w_ge033_dados_adicionais_cliente

type variables
LONG	il_filial
LONG	il_nr_nf
STRING	is_especie
STRING	is_serie

uo_Cidade io_Cidade

end variables

forward prototypes
public function string wf_retira_caracteres (string as_parametro)
end prototypes

public function string wf_retira_caracteres (string as_parametro);String lvs_Retorno

lvs_Retorno = gf_Replace(as_Parametro, ' ', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, '.', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, '-', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, '(', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, ')', '', 0)

Return lvs_Retorno
end function

on w_ge033_dados_adicionais_cliente.create
call super::create
end on

on w_ge033_dados_adicionais_cliente.destroy
call super::destroy
end on

event open;call super::open;STRING	ls_string, ls_aux

Integer li_cont = 0, li_len, li_Pos

ls_string 	= Trim( Message.StringParm )
li_len	 	= LenA( ls_string )

If li_len = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum parametro informado na abertura desta janela: w_ge033_dados_adicionais_cliente.")
	Return -1
End If

Do While LenA( ls_String ) > 0
	li_cont++
	li_Pos = PosA( ls_string, "|")
	
	If li_Pos = 0 Then 
		ls_aux = ls_string
	Else
		ls_aux 	= MidA( ls_string, 1, li_pos -1 ) //Posicao anterior do |
	End If
	
	Choose Case li_Cont
		Case 1
			il_filial		= LONG(ls_aux)		
		Case 2
			il_nr_nf		= LONG(ls_aux)
		Case 3
			is_especie 	= ls_aux
		Case 4
			is_serie 	  	= ls_aux
			ls_string		= "" //Sair do loop
	End Choose
	
	ls_string = Mid( ls_string, li_Pos + 1) //Atualiza a variavel lvs_String a partir | (proximo parametro)
Loop
end event

event ue_postopen;call super::ue_postopen;io_cidade 	= Create uo_cidade

LONG	ll_max

ll_max = dw_1.Retrieve(	il_filial, &
							  	il_nr_nf, &
							  	is_especie, &
							  	is_serie	)

If ll_max <= 0 Then 	dw_1.Event ue_Addrow()
end event

event close;call super::close;If IsValid( io_Cidade ) Then Destroy io_Cidade
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge033_dados_adicionais_cliente
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge033_dados_adicionais_cliente
integer y = 0
integer width = 2798
integer height = 432
integer taborder = 0
long backcolor = 80269524
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge033_dados_adicionais_cliente
integer x = 37
integer y = 64
integer width = 2761
integer height = 344
integer taborder = 10
string dataobject = "dw_nf_venda_loja"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case Lower(dwo.Name) 
	Case "nr_cgc_cpf"
		If IsNull(data) or Trim(data) = ""   Then
			Return 0
		Else
			If LenA(data) < 14 Then 
				If gf_nr_cpf_valido(data) Then
					This.Object.nr_cgc_cpf.EditMask.mask = '###.###.###-##'
				Else
					This.Object.nr_cgc_cpf.EditMask.mask = '##############'
					Return 1
				End If
			Else
				If gf_cgc_valido(data) Then
					This.Object.nr_cgc_cpf.EditMask.mask = '!!.!!!.!!!/!!!!-!!'
				Else
					This.Object.nr_cgc_cpf.EditMask.mask = '!!!!!!!!!!!!!!'
					Return 1
				End If
			End If
		End If
End Choose

Return 0


end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	Choose Case lvs_Coluna
			Case "nm_cidade"
			io_Cidade.of_Localiza_Cidade(This.GetText())
			
			If io_Cidade.Localizada Then				
				If Not isnull(io_Cidade.cd_cidade_ibge) and io_Cidade.cd_cidade_ibge <> '' Then
					dw_1.Object.nm_cidade	[1] = io_Cidade.nm_cidade
					dw_1.Object.cd_cidade	[1] = io_Cidade.cd_cidade
					dw_1.Object.nm_uf	 	[1] = io_Cidade.cd_unidade_federacao
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A cidade '" + io_Cidade.nm_cidade + "' do estado de '" +&
								io_Cidade.cd_unidade_federacao + "' esta sem o c$$HEX1$$f300$$ENDHEX$$digo do IBGE.~r~r" +& 
								"O c$$HEX1$$f300$$ENDHEX$$digo deve ser cadastrado na cidade antes de continuar a gera$$HEX2$$e700e300$$ENDHEX$$o da NFE.", Exclamation!)
				End If
			End If
	End Choose
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge033_dados_adicionais_cliente
integer x = 2185
integer y = 452
boolean default = false
end type

event cb_ok::clicked;Integer li_Tamanho

String ls_Nulo

SetNull( ls_Nulo )

dw_1.AcceptText()

If Not gf_Valida_Informacoes_cliente(dw_1.Object.nm_cliente[1], 1) Then
	dw_1.SetColumn("nm_cliente")
	dw_1.SetFocus()
	Return -1
End If

If Not gf_Valida_Informacoes_Cliente(dw_1.Object.nr_cgc_cpf[1], 4) Then
	dw_1.SetColumn("nr_cgc_cpf")
	dw_1.SetFocus()
	Return -1
End If

If IsNull(dw_1.Object.cd_cidade[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A cidade deve estar preenchida.", Exclamation!)
	dw_1.SetColumn("nm_cidade")
	dw_1.SetFocus()
	Return -1
End If

If Not gf_Valida_Informacoes_Cliente(dw_1.Object.de_endereco[1], 2) Then
	dw_1.SetColumn("de_endereco")
	dw_1.SetFocus()
	Return -1
End If

If Not gf_Valida_Informacoes_Cliente(dw_1.Object.nr_telefone[1], 5) Then
	dw_1.SetColumn("nr_telefone")
	dw_1.SetFocus()
	Return -1
End If

If Not gf_Valida_Informacoes_Cliente(dw_1.Object.de_bairro[1], 3) Then
	dw_1.SetColumn("de_bairro")
	dw_1.SetFocus()
	Return -1
End If

If Not gf_Valida_Informacoes_Cliente(dw_1.Object.nr_cep[1], 6) Then
	dw_1.SetColumn("nr_cep")
	dw_1.SetFocus()
	Return -1
End If

li_Tamanho = Len(Trim(dw_1.Object.nr_cgc_cpf[1]))

If li_Tamanho = 14 Then
	If IsNull(dw_1.Object.nr_inscricao_estadual[1]) Or Trim(dw_1.Object.nr_inscricao_estadual[1]) = "" Then 
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Verifique se o cliente $$HEX1$$e900$$ENDHEX$$ isento de Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual.~r" + &
										"Deseja criar a nota fiscal sem informar a Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual?", Question!,YesNo!, 1) = 2 Then
			dw_1.SetColumn("nr_inscricao_estadual")
			dw_1.SetFocus()
			Return -1
		End If
	End If
End If

If li_Tamanho = 11 Then dw_1.Object.nr_inscricao_estadual[1] = ls_Nulo

If Not IsNull(dw_1.Object.nr_inscricao_estadual[1]) Or Trim(dw_1.Object.nr_inscricao_estadual[1]) <> "" Then 
	If Long(dw_1.Object.nr_inscricao_estadual[1]) = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual corretamente.")
		dw_1.SetColumn("nr_inscricao_estadual")
		dw_1.SetFocus()
		Return -1
	End If
End If

dw_1.Object.cd_filial 		[1] = il_filial 
dw_1.Object.nr_nf		 	[1] = il_nr_nf 
dw_1.Object.de_especie	[1] = is_especie 
dw_1.Object.de_serie	 	[1] = is_serie

If dw_1.Update() = -1 Then
	Return
End If

dw_1.AcceptText()

CloseWithReturn(Parent, dw_1.Object.nm_uf [1] )

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge033_dados_adicionais_cliente
integer x = 2510
integer y = 452
end type

