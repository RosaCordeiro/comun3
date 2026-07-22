HA$PBExportHeader$w_ge351_consulta_atualizacao_preco_pend.srw
forward
global type w_ge351_consulta_atualizacao_preco_pend from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge351_consulta_atualizacao_preco_pend
end type
end forward

global type w_ge351_consulta_atualizacao_preco_pend from dc_w_cadastro_selecao_lista
integer width = 5243
integer height = 2260
string title = "GE351 - Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o de Distribuidoras"
cb_1 cb_1
end type
global w_ge351_consulta_atualizacao_preco_pend w_ge351_consulta_atualizacao_preco_pend

type variables
Long ivl_timer = 180
end variables

forward prototypes
public subroutine wf_atualiza ()
public subroutine wf_atualiza_contato (string as_distribuidora, ref string as_contato, ref string as_telefone, ref string as_email)
public subroutine wf_set_timer ()
end prototypes

public subroutine wf_atualiza ();Long ll_Linha, ll_Linhas_UF, ll_Linha_UF

String ls_Distribuidora, ls_Contato, ls_Fone, ls_Email

Date ldt_Movimento

dw_1.AcceptText()
dw_2.AcceptText()

try
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
		
	If Not lds.of_ChangeDataObject("ds_ge351_lista_uf") Then Return
	
	ldt_Movimento = dw_1.Object.dh_pedido[1]
	
	For ll_Linha = 1 To dw_2.RowCount()
		
		ls_Distribuidora = dw_2.Object.cd_fornecedor[ll_Linha]
		
		If ls_Distribuidora = '053405197' Then
			ls_Distribuidora = '053405197'
		End If
		
		ll_Linhas_UF = lds.Retrieve(ls_Distribuidora, ldt_Movimento)
		
		If ll_Linhas_UF > 0 Then
			
			ls_Contato 	= ''
			ls_Fone		= ''
			ls_Email		= ''
			
			wf_atualiza_contato(ls_Distribuidora, ref ls_Contato, ref ls_Fone, ref ls_Email)
			
			dw_2.Object.id_mostra	[ll_Linha] = "S"
			dw_2.Object.de_contato	[ll_Linha] =	ls_Contato
			dw_2.Object.de_telefone	[ll_Linha] = 	ls_Fone
			dw_2.Object.de_email	[ll_Linha] =	ls_Email
			
			For ll_Linha_UF = 1 To ll_Linhas_UF
				
				If ll_Linha_UF = 1 Then
					dw_2.Object.de_uf_faltante[ll_Linha] = lds.Object.cd_unidade_federacao[ll_Linha_UF]
				Else
					dw_2.Object.de_uf_faltante[ll_Linha] = dw_2.Object.de_uf_faltante[ll_Linha] + "/" + lds.Object.cd_unidade_federacao[ll_Linha_UF]
				End If
			Next
			
		ElseIf ll_Linhas_UF < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao montar a lista de distribuidoras com o arquivo de pre$$HEX1$$e700$$ENDHEX$$o pendente.")
			Return
		End If
		
	Next
	
	dw_2.SetFilter("id_mostra = 'S'")
	dw_2.Filter( )

finally
	Destroy lds
end try



end subroutine

public subroutine wf_atualiza_contato (string as_distribuidora, ref string as_contato, ref string as_telefone, ref string as_email);Long ll_Linhas_Contato, ll_Linha_Contato

String ls_Nome, ls_Fone

try
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
		
	If Not lds.of_ChangeDataObject("ds_ge351_lista_contato") Then Return
	
	ll_Linhas_Contato = lds.Retrieve(as_distribuidora)
	
	If ll_Linhas_Contato > 0 Then
		
		For ll_Linha_Contato = 1 To ll_Linhas_Contato
			
			If ll_Linha_Contato = 1 Then
				
				as_contato 	= lds.Object.nm_contato	[ll_Linha_Contato]	
								
				If Not IsNull(lds.Object.nr_ddd_telefone[ll_Linha_Contato]) and trim(lds.Object.nr_ddd_telefone[ll_Linha_Contato]) <> "" Then
					as_telefone	= "(" + lds.Object.nr_ddd_telefone[ll_Linha_Contato] + ")" +  lds.Object.nr_telefone	[ll_Linha_Contato]
				Else
					as_telefone	= lds.Object.nr_telefone	[ll_Linha_Contato]
				End If
				
				as_email		= lds.Object.de_email	[ll_Linha_Contato]
				
			Else
				If lds.Object.nm_contato[ll_Linha_Contato] <> '' Then
					If Pos(as_contato, lds.Object.nm_contato[ll_Linha_Contato]) = 0 Then
						as_contato 	= as_contato + "/" + lds.Object.nm_contato[ll_Linha_Contato]	
					End If
				End If
												
				If lds.Object.nr_telefone[ll_Linha_Contato] <> '' Then
					If Pos(as_telefone, lds.Object.nr_telefone[ll_Linha_Contato]) = 0 Then
						If not IsNull(lds.Object.nr_ddd_telefone[ll_Linha_Contato]) and trim(lds.Object.nr_ddd_telefone[ll_Linha_Contato]) <> "" Then
							as_telefone 	= as_telefone + "/(" + lds.Object.nr_ddd_telefone[ll_Linha_Contato] + ")" + lds.Object.nr_telefone[ll_Linha_Contato]
						Else
							as_telefone 	= as_telefone + "/" + lds.Object.nr_telefone[ll_Linha_Contato]
						End If
					End If
				End If
				
				If lds.Object.de_email[ll_Linha_Contato] <> '' Then
					If Pos(as_email, lds.Object.de_email[ll_Linha_Contato]) = 0 Then
						as_email 	= as_email + ";" + lds.Object.de_email[ll_Linha_Contato]
					End If
				End If
				
			End If
							
		Next
		
	ElseIf ll_Linhas_Contato < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao montar a lista de distribuidoras com o arquivo de pre$$HEX1$$e700$$ENDHEX$$o pendente.")
		Return
	End If

finally
	Destroy lds
end try



end subroutine

public subroutine wf_set_timer ();Timer(ivl_timer)
end subroutine

on w_ge351_consulta_atualizacao_preco_pend.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge351_consulta_atualizacao_preco_pend.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dh_pedido	[1] = Date(gf_GetServerDate())

This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_excluir(False)

dw_2.Event ue_Retrieve()

If Not gvo_Aplicacao.ivb_Usa_Aux_Visual Then
	dw_2.SetTabOrder( 'de_email', 10 )
End If

end event

event open;call super::open;wf_set_timer()
end event

event timer;call super::timer;dw_2.Event ue_Retrieve()

This.Post Function wf_set_timer()
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge351_consulta_atualizacao_preco_pend
integer y = 1496
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge351_consulta_atualizacao_preco_pend
integer y = 1424
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge351_consulta_atualizacao_preco_pend
integer x = 64
integer y = 76
integer width = 837
integer height = 84
string dataobject = "dw_ge351_selecao_pend"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "id_atualizado"
		If Data = "S" Then
			This.Object.Id_Pendente[1] = "N"
		Else
			This.Object.Id_Pendente[1] = "S"
		End If
		
	Case "id_pendente"
		If Data = "S" Then
			This.Object.Id_Atualizado[1] = "N"
		Else
			This.Object.Id_Atualizado[1] = "S"
		End If
End Choose

dw_2.Event ue_Reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge351_consulta_atualizacao_preco_pend
integer y = 212
integer width = 5134
integer height = 1836
integer weight = 700
fontcharset fontcharset = ansi!
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge351_consulta_atualizacao_preco_pend
integer width = 891
integer height = 176
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge351_consulta_atualizacao_preco_pend
integer x = 73
integer y = 280
integer width = 5070
integer height = 1744
string dataobject = "dw_ge351_preco_pendente"
end type

event dw_2::ue_postretrieve;// OverRide

Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Excluir

If pl_Linhas > 0 Then
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar		= IsValid(This.ivo_Filter)
	lvb_Localizar	= IsValid(This.ivo_Find)
	
	
	
	wf_atualiza()
	
	SetRedraw(True)
	
	If dw_2.RowCount() > 0 Then
		dw_2.ivo_Controle_Menu.of_SalvarComo(True)
		This.SetRow(1)
		This.SetFocus()
	Else
		dw_2.ivo_Controle_Menu.of_SalvarComo(False)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If

Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
	
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

wf_set_timer()

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Excluir(False)

Return pl_Linhas
end event

event dw_2::ue_recuperar;//OverRide
String ls_Fornecedor

dw_1.AcceptText()

This.Reset()
This.SetFilter("")
This.Filter()

If Isnull(dw_1.Object.dh_pedido[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do arquivo cprretamente.")
	dw_1.Event ue_Pos(1, "dh_pedido")
	Return -1
End If

SetRedraw(False)

// Desenvolvimento
//ls_Fornecedor = '053405197'

If Trim(ls_Fornecedor) <> '' Then
	This.of_AppendWhere("f.cd_fornecedor = '" + ls_Fornecedor + "'")
End If

Return This.Retrieve()
end event

event dw_2::itemchanged;// OverRide
end event

event dw_2::editchanged;// OverRide
end event

event dw_2::getfocus;//OverRide

This.Post Event ue_SelectText()

This.of_Marca_Coluna_Ativa(This.GetColumnName())

Return 0
end event

type cb_1 from commandbutton within w_ge351_consulta_atualizacao_preco_pend
string tag = "Cobrar o arquivo de pre$$HEX1$$e700$$ENDHEX$$o via email"
accessiblerole accessiblerole = dialogrole!
integer x = 4110
integer y = 92
integer width = 1042
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cobrar o arquivo de pre$$HEX1$$e700$$ENDHEX$$o via email"
end type

event clicked;String ls_Email, ls_UF,  ls_Fantasia

dw_2.AcceptText()

s_email str

If dw_2.RowCount() > 0 Then 
	
	ls_Email 			= dw_2.Object.de_email		[dw_2.GetRow()]
	ls_Fantasia		= dw_2.Object.nm_fantasia	[dw_2.GetRow()]
		
	If IsNull(ls_Email) or Trim(ls_Email) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe e-mail cadastrado.", Exclamation!)
		Return
	End If
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o envio do e-mail ?", Question!, YesNo!, 2) = 2 Then Return
	
	//Desenvolvimento
	//ls_Email = "sergiogol@gmail.com.br;sergio.gol@clamed.com.br"
	
	ls_UF 	= dw_2.Object.de_uf_faltante[dw_2.GetRow()]
		
	str.ps_to[ UpperBound(str.ps_to[]) + 1 ] = ls_Email
	
	str.ps_Mensagem = "Distribuidora: <b>" + ls_Fantasia + "</b><br /><br />" + "Estamos aguardando a disponibiliza$$HEX2$$e700e300$$ENDHEX$$o do(s) arquivo(s) de pre$$HEX1$$e700$$ENDHEX$$os da(s) seguinte(s) UF('s): [" + ls_UF + "]"
	str.pb_assinatura = True
	
	//Se n$$HEX1$$e300$$ENDHEX$$o conseguir enviar e-mail com c$$HEX1$$f300$$ENDHEX$$pia para os fornecedores, envia e-mail para os compradores com o corpo do e-mail original
	If  gf_ge202_envia_email_padrao(139, str) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O e-mail foi enviado com sucesso.")
	Else 
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao enviar o e-mail.", StopSign!)
		Return
	End If
End If


end event

