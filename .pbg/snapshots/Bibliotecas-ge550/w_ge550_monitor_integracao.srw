HA$PBExportHeader$w_ge550_monitor_integracao.srw
forward
global type w_ge550_monitor_integracao from dc_w_2tab_cadastro_selecao_lista_det
end type
type cb_reprocessar from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_2
end type
end forward

global type w_ge550_monitor_integracao from dc_w_2tab_cadastro_selecao_lista_det
string tag = "w_ge550_monitor_integracao"
integer width = 4832
integer height = 1776
string title = "GE550 - Monitor de Integra$$HEX2$$e700e300$$ENDHEX$$o Esteira"
end type
global w_ge550_monitor_integracao w_ge550_monitor_integracao

type variables
uo_filial ivo_filial
uo_ge550_esteira_automatica iuo_esteira

Long ivl_Linha_Selecionada

Boolean ib_Desenvolvimento = False

//Boolean ivb_check
//Boolean ivb_botao
//
//
////uo_pedido_filial ivo_pedido
//
//
//String ivs_nulo, ivs_pedidos, ivs_filiais
//String is_Url_Status_Servico
//String is_Status_Servico
//String is_Url_Envio
//String is_Url_Retorno
//String is_Key
//String is_Json_Envio
//String is_Json_Retorno
//
//dc_uo_ds_base lds_logs
//
//
//
//// Esteira configurada n$$HEX1$$e300$$ENDHEX$$o aparecer mais os bot$$HEX1$$f500$$ENDHEX$$es de etiquetas e imprimir
//
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();STRING lvs_Filial

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Filial = Tab_1.TabPage_1.dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Filial)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Filial.Localizada  Then
	Tab_1.TabPage_1.dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
	Tab_1.TabPage_1.dw_1.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
Else

	SetNull(ivo_Filial.Cd_Filial)
	ivo_Filial.Nm_Fantasia = ""
	
	Tab_1.TabPage_1.dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	Tab_1.TabPage_1.dw_1.Object.nm_fantasia[1] = ivo_filial.nm_fantasia
	
End If

end subroutine

on w_ge550_monitor_integracao.create
int iCurrent
call super::create
end on

on w_ge550_monitor_integracao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Base, lvdt_Base_ate

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

ivo_Filial = Create uo_Filial

lvdt_Base = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -1)
lvdt_Base_ate = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), 0)

Tab_1.TabPage_1.dw_1.Object.Dt_emissao_de 	[1] = lvdt_Base
Tab_1.TabPage_1.dw_1.Object.Dt_emissao_ate	[1] = lvdt_Base_ate

Tab_1.TabPage_1.dw_1.SetFocus()

end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(iuo_esteira)
end event

event open;call super::open;iuo_esteira = Create uo_ge550_esteira_automatica
end event

type dw_visual from dc_w_2tab_cadastro_selecao_lista_det`dw_visual within w_ge550_monitor_integracao
end type

type gb_aux_visual from dc_w_2tab_cadastro_selecao_lista_det`gb_aux_visual within w_ge550_monitor_integracao
end type

type tab_1 from dc_w_2tab_cadastro_selecao_lista_det`tab_1 within w_ge550_monitor_integracao
integer y = 0
integer width = 4773
integer height = 1576
alignment alignment = center!
end type

event tab_1::selectionchanged;//Override
SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()

		ivm_Menu.mf_Incluir(False)
		ivm_Menu.mf_Excluir(False)

		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		

SetPointer(Arrow!)
end event

event tab_1::selectionchanging;call super::selectionchanging;SetPointer(HourGlass!)

LONG lvl_Linha

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If OldIndex = 1 Then
	ivl_Linha_Selecionada = Tab_1.TabPage_1.dw_2.GetRow()
End If

If NewIndex = 1 and OldIndex = 2 Then
	If ivl_Linha_Selecionada > 0 Then
		Tab_1.TabPage_1.dw_2.SetRow(ivl_Linha_Selecionada)
	End If
End If

SetPointer(Arrow!)

end event

type tabpage_1 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_1 within tab_1
integer width = 4736
integer height = 1460
cb_reprocessar cb_reprocessar
end type

on tabpage_1.create
this.cb_reprocessar=create cb_reprocessar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reprocessar
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_reprocessar)
end on

type gb_2 from dc_w_2tab_cadastro_selecao_lista_det`gb_2 within tabpage_1
integer y = 416
integer width = 4690
integer height = 1036
string text = "Lista Esteira"
end type

type gb_1 from dc_w_2tab_cadastro_selecao_lista_det`gb_1 within tabpage_1
integer y = 16
integer width = 2427
integer height = 404
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_cadastro_selecao_lista_det`dw_1 within tabpage_1
integer x = 64
integer y = 76
integer width = 2350
integer height = 328
string dataobject = "dw_ge550_selecao"
boolean livescroll = false
string ivs_cor_linha_padrao = ""
boolean exibemensagem = false
end type

event dw_1::ue_key;call super::ue_key;STRING	lvs_Coluna

If Key = KeyEnter! Then

	lvs_Coluna = This.GetColumnName()

	If lvs_Coluna = "nm_fantasia" Then

		WF_Localiza_Filial()
		
	End If
	
End If

end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_nulo

String ls_Erro

SetNull(lvl_nulo)

dw_2.Reset()

If dwo.Name = "nm_fantasia" Then
	If data = "" or IsNull(data) Then
		This.Object.cd_filial[1] = lvl_nulo
	Else
		If Data <> ivo_filial.nm_fantasia Then Return 1
	End If	
End If

end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

type dw_2 from dc_w_2tab_cadastro_selecao_lista_det`dw_2 within tabpage_1
integer x = 41
integer y = 480
integer width = 4663
integer height = 952
string dataobject = "dw_ge550_lista"
boolean livescroll = false
boolean exibemensagem = false
end type

event dw_2::getfocus;call super::getfocus;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_2::ue_recuperar;		
Long 	ll_Filial, ll_Nr_Volume, ll_Nr_Pedido_Distribuidora, ll_Id_Integracao, ll_Linhas, ll_Picking, ll_Esteira

String ls_Desc_Integracao, ls_Picking

Datetime dth_Inclusao

Date 	lvdt_Emissao_De, lvdt_Emissao_Ate

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_emissao_de	= dw_1.Object.dt_emissao_de		[1]
lvdt_emissao_ate	= dw_1.Object.dt_emissao_ate		[1]
ll_Filial				= dw_1.Object.cd_filial				[1]
ll_Nr_Volume		= dw_1.Object.nr_volume			[1]
ll_Id_Integracao	= dw_1.Object.id_status				[1]
ll_Picking				= dw_1.Object.nr_picking			[1]
ll_Nr_Pedido_Distribuidora = dw_1.Object.nr_pedido	[1]
ll_Esteira				= dw_1.Object.cd_esteira			[1]

If Not IsNull(ll_Filial) Then
	This.of_AppendWhere("f.cd_filial = "+String(ll_Filial), 1)
End If

If Not IsNull(ll_Nr_Volume) Then
	This.of_AppendWhere("wie.nr_volume = "+String(ll_Nr_Volume), 1)
End If

If Not IsNull(ll_Id_Integracao) Then
	If ll_Id_Integracao = 1 Then
		This.of_AppendWhere("wie.id_integracao = "+String(ll_Id_Integracao), 1)
	ElseIf ll_Id_Integracao = 0 Then
		This.of_AppendWhere("wie.id_integracao = "+String(ll_Id_Integracao), 1)
	ElseIf ll_Id_Integracao = 2 Then
		//lista todos
	End If
End If

If Not IsNull(ll_Picking) Then
	This.of_AppendWhere("wie.nr_picking = "+"'"+string(ll_Picking)+"'", 1)
End If

If Not IsNull(ll_Nr_Pedido_Distribuidora) Then
	This.of_AppendWhere("wie.nr_pedido_distribuidora = "+String(ll_Nr_Pedido_Distribuidora), 1)
End If

If ll_Esteira <> 0 Then
	This.of_AppendWhere("wls.cd_esteira = "+String(ll_Esteira), 1)
End If

This.of_SetRowSelection()

ll_Linhas = This.Retrieve(lvdt_emissao_de, lvdt_emissao_ate)

Return ll_Linhas
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

If pl_linhas > 0 Then
	ivm_Menu.mf_salvarcomo( True)
End If

return pl_linhas
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
ivb_ordena_colunas = True   		 
		 
lvs_Coluna = {"cd_filial" , "nm_fantasia", "cd_esteira", "nr_rota_entrega", "nr_pedido_distribuidora", "nr_volume", "dh_inclusao", "dh_geracao", "ds_integracao", "nr_picking"}

lvs_Nome   = {"Filial" , "Fantasia", "Esteira", "Rota", "Pedido", "Vol.", "Envio Est. Autom.", "Data Geracao", "Descricao Mensagem", "Num. Picking"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		

end event

type tabpage_2 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_2 within tab_1
integer width = 4736
integer height = 1460
cb_1 cb_1
end type

on tabpage_2.create
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_1)
end on

type gb_3 from dc_w_2tab_cadastro_selecao_lista_det`gb_3 within tabpage_2
integer x = 5
integer y = 8
integer width = 3552
integer height = 1448
end type

type dw_3 from dc_w_2tab_cadastro_selecao_lista_det`dw_3 within tabpage_2
integer x = 32
integer width = 3511
integer height = 1352
string dataobject = "dw_ge550_lista_produto"
boolean vscrollbar = true
boolean livescroll = false
boolean exibemensagem = false
end type

event dw_3::ue_recuperar;//OveRide
Long 	ll_Filial,&
		ll_Pedido,&
		ll_Volume

Tab_1.TabPage_1.dw_1.AcceptText()

ll_Filial 		= Tab_1.TabPage_1.dw_2.Object.cd_filial						[Tab_1.TabPage_1.dw_2.GetRow()]
ll_Pedido 	= Tab_1.TabPage_1.dw_2.Object.nr_pedido_distribuidora	[Tab_1.TabPage_1.dw_2.GetRow()]
ll_Volume 	= Tab_1.TabPage_1.dw_2.Object.nr_volume					[Tab_1.TabPage_1.dw_2.GetRow()]

This.of_SetRowSelection()

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

Return This.Retrieve(ll_Filial,ll_Pedido,ll_Volume)
end event

event dw_3::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
ivb_ordena_colunas = True   		 
		 
lvs_Coluna = {"cd_produto" , "de_produto", "qt_pedida", "qt_separada", "de_endereco", "i_station"}

lvs_Nome   = {"Produto" , "Decricao : Apresentacao de Estoque", "Qt. Pedida", "Separada", "Endere$$HEX1$$e700$$ENDHEX$$o", "Estacao Esteira"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		 

end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)
Else
	Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(False)
End If

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

Return pl_Linhas
end event

type cb_reprocessar from commandbutton within tabpage_1
integer x = 2496
integer y = 44
integer width = 503
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Re-Enviar"
end type

event clicked;String ls_Operador
String ls_erro
String lvs_Chave_Volume

Long lvl_Esteira, lvl_Linhas, lvl_cont
Long lvl_filial, lvl_pedido, lvl_volume
Long ll_Conta_Erros = 0

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o reprocessamento dos itens com erro?~nO reprocessamento ir$$HEX1$$e100$$ENDHEX$$ ignorar as linhas ja enviadas." , Question!, YesNo!, 2) = 2 Then
	Return -1
End If

Try
	Tab_1.TabPage_1.dw_1.AcceptText()
	Tab_1.TabPage_1.dw_2.AcceptText()
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este processo apenas funciona caso os pedidos sejam eliminados do Sistema da Brint! Necess$$HEX1$$e100$$ENDHEX$$rio fazer esta solicita$$HEX2$$e700e300$$ENDHEX$$o!!!! ")
	
		
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_WS013_ESTEIRA_AUTOMATICA_ENVIO", ref ls_Operador) Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o liberado, Solicitar o Acesso!")
		Return
	End If
	
	lvl_Linhas = Tab_1.TabPage_1.dw_2.RowCount()

	
	Open(w_Aguarde_1)
	SetPointer(HourGlass!)
	
	w_Aguarde_1.Title = 'Re-Enviando para Esteira Autom$$HEX1$$e100$$ENDHEX$$tica...'
	w_Aguarde_1.uo_Progress.of_SetMax(lvl_Linhas)
	
	For lvl_cont = 1 To lvl_linhas		
		
		w_Aguarde_1.uo_Progress.of_SetProgress(lvl_cont)
		
		//Se integra$$HEX2$$e700e300$$ENDHEX$$o esta 0 faz o envio novamente
		If Tab_1.TabPage_1.dw_2.Object.id_integracao[lvl_cont] = 0 Then
			
			lvl_Esteira	 = Tab_1.TabPage_1.dw_2.Object.cd_esteira[Tab_1.TabPage_1.dw_2.getrow()]
	
			//Verifica se a Esteira est$$HEX1$$e100$$ENDHEX$$ configurada para Envio
			If Not iuo_esteira.of_verifica_esteira( lvl_Esteira, Ref ls_Erro ) Then 
				MessageBox("Aviso!", ls_Erro)
				Continue
			End If 
			
			lvl_Filial		= Tab_1.TabPage_1.dw_2.Object.cd_filial						[lvl_cont]
			lvl_Pedido	= Tab_1.TabPage_1.dw_2.Object.nr_pedido_distribuidora	[lvl_cont]
			lvl_Volume	= Tab_1.TabPage_1.dw_2.Object.nr_volume					[lvl_cont]
			lvs_Chave_Volume = string(Tab_1.TabPage_1.dw_2.Object.nr_picking	[lvl_cont])

			// Verificar se loja esta configurada
			If Not iuo_esteira.of_verifica_config_loja_esteira_auto( lvl_Filial, Ref ls_Erro ) Then
				ll_Conta_Erros += 1
				//MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro )
				Continue
			End If 
			
			//Verifica se o pedido ja foi integrado
			If Not iuo_esteira.of_verifica_pedido_enviado(lvl_Filial, lvl_Pedido, lvl_Volume, Ref ls_Erro) Then
				ll_Conta_Erros += 1
				//MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro )
				Continue
			End If	
			
			If Not iuo_esteira.of_libera_pedido_areenviar(lvl_Filial, lvl_Pedido ,lvl_Volume , Ref ls_Erro)  Then 
				ll_Conta_Erros += 1
				//MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Erro )
				Continue	
			End If 	
			
			//Inicia processo de integra$$HEX2$$e700e300$$ENDHEX$$o, 1 $$HEX1$$e900$$ENDHEX$$ o tipo envio (padr$$HEX1$$e300$$ENDHEX$$o)
			If Not iuo_esteira.of_envia_esteira_automatica( lvl_Filial, lvl_pedido, lvl_volume , '1' , Ref ls_erro )   Then
				ll_Conta_Erros += 1
				If Not ib_Desenvolvimento Then
					If Not Match(ls_erro, "Pedido Ja existente na Base") Then
						//Grava na tabela de integra$$HEX2$$e700e300$$ENDHEX$$o
						If Not iuo_esteira.of_incluir_integracao_esteira(	lvl_Filial,	lvl_Pedido,	lvl_Volume,	iuo_esteira.ivl_id_integracao , Left( ls_Erro, 100),	lvs_Chave_Volume, '1', Ref ls_erro )  Then
							iuo_esteira.of_envia_email("Erro ao incluir integracao esteira. " + ls_erro + ". Filial " + String(lvl_Filial) + ", Pedido " + String(lvl_Pedido) + ", Volume " + String(lvl_Volume) + "")
							Return
						End If
					End If

					//Envia email com o erro
					iuo_esteira.of_envia_email( ls_erro )
					Continue
				End If
			End If
 
		End If

	Next
	
Catch (RunTimeError lo_error)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lo_error.GetMessage( ), StopSign!)
	Return -1	
Finally
	If IsValid(w_Aguarde_1) Then  Close(w_Aguarde_1)
	If ll_Conta_Erros > 0 Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Um ou mais itens n$$HEX1$$e300$$ENDHEX$$o foram reprocessados corretamente!~nLista do Monitor de Integra$$HEX2$$e700e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ atualizada com os detalhes. ['+string(ll_Conta_Erros)+']', Exclamation! )
	Else
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Reprocessamento conclu$$HEX1$$ed00$$ENDHEX$$do sem erros!', Information! )
	End If
	dw_2.Event ue_Retrieve()  
End Try	
end event

type cb_1 from commandbutton within tabpage_2
boolean visible = false
integer x = 3589
integer y = 36
integer width = 594
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Lotes Pad Picking"
end type

event clicked;/*Long ll_Filial, ll_Pedido, ll_Volume, ll_Produto
String ls_Parm

Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_3.AcceptText()

If Tab_1.TabPage_2.dw_3.GetRow() > 0 Then
	ll_Filial 		= Tab_1.TabPage_1.dw_2.Object.cd_filial						[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Pedido 	= Tab_1.TabPage_1.dw_2.Object.nr_pedido_distribuidora	[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Volume 	= Tab_1.TabPage_1.dw_2.Object.nr_volume					[Tab_1.TabPage_1.dw_2.GetRow()]
	ll_Produto   =  Tab_1.TabPage_2.dw_3.Object.cd_produto					[Tab_1.TabPage_2.dw_3.GetRow()]
	
	ls_Parm = String(ll_Filial, '0000') + String(ll_Pedido, '0000000000') + String(ll_Volume, '000') + string(ll_Produto)
	
	OpenWithParm(w_ws013_picking_lotes, ls_Parm)
End If*/
end event

