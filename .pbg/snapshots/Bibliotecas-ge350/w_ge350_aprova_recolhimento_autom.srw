HA$PBExportHeader$w_ge350_aprova_recolhimento_autom.srw
forward
global type w_ge350_aprova_recolhimento_autom from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge350_aprova_recolhimento_autom
end type
type dw_3 from dc_uo_dw_base within w_ge350_aprova_recolhimento_autom
end type
type gb_2 from groupbox within w_ge350_aprova_recolhimento_autom
end type
type gb_3 from groupbox within w_ge350_aprova_recolhimento_autom
end type
end forward

global type w_ge350_aprova_recolhimento_autom from dc_w_response_ok_cancela
integer width = 4357
integer height = 1652
string title = "GE350 - Aprova$$HEX2$$e700e300$$ENDHEX$$o Autom$$HEX1$$e100$$ENDHEX$$tica"
dw_2 dw_2
dw_3 dw_3
gb_2 gb_2
gb_3 gb_3
end type
global w_ge350_aprova_recolhimento_autom w_ge350_aprova_recolhimento_autom

type variables
dc_uo_dw_base idw_Filiais
dc_uo_ds_base ids_Lotes


Boolean ivb_Check
end variables

forward prototypes
public subroutine wf_set_somente_consulta ()
public function boolean wf_prepara_retirada_automatica (datetime adh_inicio, datetime adh_termino)
public function long wf_verifica_lote_cadastrado (long al_aprovacao)
end prototypes

public subroutine wf_set_somente_consulta ();dw_3.of_Set_Somente_Leitura(False)
end subroutine

public function boolean wf_prepara_retirada_automatica (datetime adh_inicio, datetime adh_termino);Boolean lb_Sucesso = True

Date ldt_Atual

DateTime ldh_Inicio_Aprov
DateTime ldh_Termino_Aprov

Long ll_Linha
Long ll_Linha_Filiais
Long ll_Linha_Lotes
Long ll_Produto
Long ll_Filial
Long ll_Retirada
Long ll_Find
Long ll_Qtd_Atua = 0
Long ll_Find_2
Long ll_Linha_PRD
Long ll_Ret_Ant = 0
Long ll_Fil_Ant = 0
Long ll_aux = 0
String ls_Selecionado
String ls_Lote_Ret

Try

	dw_2.AcceptText()
	ids_Lotes.AcceptText()
	
	str_ge350_lista_email st_email_nulo
	str_ge350_lista_email st_email
	
	dc_uo_ds_base lds_Produto
	lds_Produto = Create dc_uo_ds_base
	
	If Not lds_Produto.of_ChangeDataObject("dw_ge350_lista_produtos_venc_recolhim") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_prepara_retirada_automatica.", StopSign!)
		Return False
	End If
	
	ldt_Atual	= Date(String(gf_GetServerDate(), "01/mm/yyyy"))
	
	For ll_Linha = 1 To dw_2.RowCount() //Produtos do cadastro da aprova$$HEX2$$e700e300$$ENDHEX$$o
		ls_Selecionado = dw_2.Object.Id_Selecionado[ll_Linha]
		
		If ls_Selecionado = "S" Then
			If wf_Verifica_Lote_Cadastrado(dw_2.Object.Nr_Aprovacao[ll_Linha]) <= 0 Then
				lb_Sucesso = False
				Return False
			End If
			
			ldh_Inicio_Aprov		= dw_2.Object.Dh_Inicio		[ll_Linha]
			ldh_Termino_Aprov	= dw_2.Object.Dh_Termino	[ll_Linha]
			
			If adh_Inicio < ldh_Inicio_Aprov Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da RETIRADA '" + String(Date(adh_Inicio)) + "' n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data de in$$HEX1$$ed00$$ENDHEX$$cio da APROVA$$HEX2$$c700c300$$ENDHEX$$O '" + String(Date(ldh_Inicio_Aprov)) + "'.", Exclamation!)
				lb_Sucesso = False
				Return False
			End If
			
			If adh_Termino > ldh_Termino_Aprov Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino da RETIRADA '" + String(Date(adh_Termino)) + "' n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino da APROVA$$HEX2$$c700c300$$ENDHEX$$O '" + String(Date(ldh_Termino_Aprov)) + "'.", Exclamation!)
				lb_Sucesso = False
				Return False
			End If
			
			ll_Produto = dw_2.Object.Cd_Produto[ll_Linha]
			
			ll_Linha_Filiais = 0
			
			For ll_Linha_Filiais = 1 To idw_Filiais.RowCount() //Filiais da retirada
				ll_Filial		= idw_Filiais.Object.Cd_Filial					[ll_Linha_Filiais]
				ll_Retirada	= idw_Filiais.Object.Nr_Retirada_Estoque	[ll_Linha_Filiais]
				
				lds_Produto.Reset()
				
				If lds_Produto.Retrieve(ll_Filial, ll_Retirada, ldt_Atual) < 0 Then //Produtos da retirada
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar os dados da retirada.", StopSign!)
					lb_Sucesso = False
					Return False
				End If
				
				If lds_Produto.RowCount() = 0 Then Continue
						
				ll_Find = 0
				ll_Find_2 = 0
				
				For ll_Linha_PRD = 1 To lds_Produto.RowCount()
				
					//Procura o produto da lista no cadastro da aprova$$HEX2$$e700e300$$ENDHEX$$o
//					ll_Find = lds_Produto.Find("cd_produto = " + String(ll_Produto), 1, lds_Produto.RowCount())
//					
//					If ll_Find < 0 Then
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find do lds_Produto.", StopSign!)
//						lb_Sucesso = False
//						Return False
//					End If
					
					//If ll_Find > 0 Then
					
					//Se encontrou o produto
					If lds_Produto.Object.Cd_Produto[ll_Linha_PRD] = ll_Produto Then
						ls_Lote_Ret = lds_Produto.Object.Nr_Lote[ll_Linha_PRD]
						
						//Se achou o produto da lista no cadastro da aprova$$HEX2$$e700e300$$ENDHEX$$o, procura pelo lote
						ll_Find_2 = ids_Lotes.Find("nr_lote = '" + ls_Lote_Ret + "'", 1, ids_Lotes.RowCount())
						
						If ll_Find_2 < 0 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find do ids_Lotes.", StopSign!)
							lb_Sucesso = False
							Return False
						End If
	
						If ll_Find_2 > 0 Then
							//Controle pra gravar o cabe$$HEX1$$e700$$ENDHEX$$alho somente uma vez
							If (ll_Fil_Ant <> ll_Filial) OR (ll_Ret_Ant <> ll_Retirada) Then
								If Not gf_ge350_Grava_Cabecalho(ll_Filial, ll_Retirada, adh_Inicio, adh_Termino, idw_Filiais.Object.Dh_Vencimento_Minimo[ll_Linha_Filiais], true) Then
									lb_Sucesso = False
									Return False
								End If
							End If
							
							If Not gf_ge350_Grava_Retirada_Produto('R', ll_Filial, ll_Retirada, ll_Produto, ls_Lote_Ret, lds_Produto.Object.Qt_Solicitada[ll_Linha_PRD]) Then
								lb_Sucesso = False
								Return False
							End If
							
							If (ll_Fil_Ant <> ll_Filial) OR (ll_Ret_Ant <> ll_Retirada) Then
								If Not gf_ge350_Grava_Cabecalho_aprovado(ll_Filial, ll_Retirada) Then
									lb_Sucesso = False
									Return False
								End If
							End If
														
							If (ll_Fil_Ant <> ll_Filial) And (ll_Ret_Ant <> ll_Retirada) Then
								gf_ge350_Dados_Email(Ref st_email, ll_Filial, ll_Retirada, adh_Inicio, adh_Termino, 'R', idw_Filiais.Object.Dh_Vencimento_Minimo[ll_Linha_Filiais])
							End If
							
							ll_Fil_Ant		= ll_Filial
							ll_Ret_Ant	= ll_Retirada
							
							ll_Qtd_Atua ++
							lb_Sucesso = True
						End If
					End If
				Next //For ll_Linha_PRD = 1 To ld_Produto.RowCount()
			Next //For ll_Linha_Filiais = 1 To idw_Filiais.RowCount() //Filiais da retirada
		End If
	Next //For ll_Linha = 1 To dw_2.RowCount() //Produtos do cadastro da aprova$$HEX2$$e700e300$$ENDHEX$$o
	
	If ll_Qtd_Atua = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto da lista de recolhimento foi encontrado na aprova$$HEX2$$e700e300$$ENDHEX$$o N$$HEX1$$ba00$$ENDHEX$$ " + String(dw_2.Object.Nr_Aprovacao[dw_2.GetRow()]) + ".")
		lb_Sucesso = False
		Return False
	End If
		
Finally
	
	Destroy(lds_Produto)
	
	If ll_Qtd_Atua > 0 And lb_Sucesso Then
		SqlCa.of_Commit();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Aprova$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica realizada com sucesso.")
		
		gf_ge350_Envia_Email(st_email, 'R', False)
		st_email = st_email_nulo
		
		CloseWithReturn(This, "OK")
	Else
		SqlCa.of_Rollback();
	End If
	
End Try

Return True
end function

public function long wf_verifica_lote_cadastrado (long al_aprovacao);Long ll_Linhas

ids_Lotes.Reset()

ll_Linhas = ids_Lotes.Retrieve(al_Aprovacao)

If ll_Linhas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da data window 'dw_ge392_lote'.", StopSign!)
ElseIf ll_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe lote cadastrado para a aprova$$HEX2$$e700e300$$ENDHEX$$o N$$HEX1$$ba00$$ENDHEX$$ '" + String(al_Aprovacao) + "'.", Exclamation!)
End If

Return ll_Linhas
end function

on w_ge350_aprova_recolhimento_autom.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_3
end on

on w_ge350_aprova_recolhimento_autom.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_postopen;call super::ue_postopen;Long ll_Linha
Long ll_Linhas

Long ll_Filial

ll_Linhas = dw_2.Retrieve()

If ll_Linhas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar os dados.", StopSign!)
	Return
End If

If ll_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem aprova$$HEX2$$e700f500$$ENDHEX$$es vigentes.", Exclamation!)
	Return
End If

If dw_3.Retrieve(dw_2.Object.Nr_Aprovacao[1]) < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw_3.", StopSign!)
	Return
End If

idw_Filiais = Message.PowerObjectParm

If Not ids_Lotes.of_ChangeDataObject("dw_ge392_lote") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a data store 'dw_ge392_lote'.", StopSign!)
	Destroy(ids_Lotes)
	Return
End If

dw_1.Event ue_Pos(1, "dh_inicio")	
end event

event ue_preopen;call super::ue_preopen;idw_Filiais = Create dc_uo_dw_base
ids_Lotes = Create dc_uo_ds_base
end event

event close;call super::close;Destroy(ids_Lotes)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge350_aprova_recolhimento_autom
integer x = 1303
integer y = 56
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge350_aprova_recolhimento_autom
integer x = 18
integer y = 20
integer width = 1234
integer height = 172
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo da Retirada"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge350_aprova_recolhimento_autom
integer x = 50
integer y = 84
integer width = 1184
integer height = 80
string dataobject = "dw_ge350_selecao_aprov_autom"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge350_aprova_recolhimento_autom
integer x = 946
integer y = 1432
end type

event cb_ok::clicked;call super::clicked;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Find

dw_1.AcceptText()
dw_2.AcceptText()

ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da dw_1.", StopSign!)
	Return -1
End If

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ao menos uma aprova$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
	dw_2.SetFocus()
	Return -1
End If

ldh_Inicio	= dw_1.Object.Dh_Inicio		[1]
ldh_Termino= dw_1.Object.Dh_Termino	[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da retirada.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da retirada.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If ldh_Inicio < gvo_Parametro.of_Dh_Movimentacao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data atual.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

/*Verificado que elas selecionavam apenas um produto para aprova$$HEX2$$e700e300$$ENDHEX$$o, e caso a retirada tivesse mais de um, aprovava apenas o selecionado. 
Adicionado mensagem para alertar elas.*/
setNull(ll_Find)

 ll_Find = dw_2.Find("id_selecionado = 'N'", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da dw_1. - Aprova$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o marcada", StopSign!)
	Return -1
End If

If ll_Find > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "SOMENTE ser$$HEX1$$e300$$ENDHEX$$o aprovados os produtos selecionados. ~rCaso a retirada tenha mais produtos, eles n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o aprovados." + &
						"~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return -1
End If
/**/
If Not wf_Prepara_Retirada_Automatica(ldh_Inicio, ldh_Termino) Then Return -1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge350_aprova_recolhimento_autom
integer x = 1280
integer y = 1432
end type

type dw_2 from dc_uo_dw_base within w_ge350_aprova_recolhimento_autom
integer x = 37
integer y = 252
integer width = 4242
integer height = 724
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge350_selecao_vigente"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;dw_3.Event ue_Retrieve()
dw_2.SetFocus()
end event

event constructor;call super::constructor;This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

event itemfocuschanged;call super::itemfocuschanged;dw_3.Event ue_Retrieve()
dw_2.SetFocus()
end event

event doubleclicked;call super::doubleclicked;If dw_2.RowCount() > 0 Then

	If dwo.Name = 'st_selecionado' Then
			
		Long lvl_Row
		
		String lvs_Marcacao
		
		If ivb_Check Then
			lvs_Marcacao = 'N'
			ivb_Check = False
		Else
			lvs_Marcacao = 'S'
			ivb_Check = True
		End If
		
		For lvl_Row = 1 To This.RowCount()				
			This.Object.id_selecionado[lvl_Row] = lvs_Marcacao		
		Next
	End If
End If
end event

type dw_3 from dc_uo_dw_base within w_ge350_aprova_recolhimento_autom
integer x = 46
integer y = 1044
integer width = 773
integer height = 464
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge392_lote"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_recuperar;//OverRide

dw_2.AcceptText()

Return This.Retrieve(dw_2.Object.Nr_Aprovacao[dw_2.GetRow()])
end event

event constructor;call super::constructor;This.of_SetRowSelection()

dw_3.of_Set_Somente_Leitura(False) 
end event

type gb_2 from groupbox within w_ge350_aprova_recolhimento_autom
integer x = 18
integer y = 196
integer width = 4283
integer height = 800
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lote"
end type

type gb_3 from groupbox within w_ge350_aprova_recolhimento_autom
integer x = 18
integer y = 1000
integer width = 841
integer height = 540
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
end type

