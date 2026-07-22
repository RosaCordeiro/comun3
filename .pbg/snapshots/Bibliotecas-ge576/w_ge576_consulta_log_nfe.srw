HA$PBExportHeader$w_ge576_consulta_log_nfe.srw
forward
global type w_ge576_consulta_log_nfe from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge576_consulta_log_nfe
end type
type cb_1 from commandbutton within w_ge576_consulta_log_nfe
end type
type cb_resolvido from commandbutton within w_ge576_consulta_log_nfe
end type
type cb_importar from commandbutton within w_ge576_consulta_log_nfe
end type
type cb_libera from commandbutton within w_ge576_consulta_log_nfe
end type
type gb_3 from groupbox within w_ge576_consulta_log_nfe
end type
type cb_desresolvido from commandbutton within w_ge576_consulta_log_nfe
end type
end forward

global type w_ge576_consulta_log_nfe from dc_w_selecao_lista_relatorio
integer width = 6103
integer height = 2452
string title = "GE576 - Consulta Log NFE"
boolean ivb_valida_salva = true
dw_4 dw_4
cb_1 cb_1
cb_resolvido cb_resolvido
cb_importar cb_importar
cb_libera cb_libera
gb_3 gb_3
cb_desresolvido cb_desresolvido
end type
global w_ge576_consulta_log_nfe w_ge576_consulta_log_nfe

type variables
uo_Filial io_Filial

Boolean ivb_Processando

Boolean ivb_Check

String is_relatorio_resumido
end variables

on w_ge576_consulta_log_nfe.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_resolvido=create cb_resolvido
this.cb_importar=create cb_importar
this.cb_libera=create cb_libera
this.gb_3=create gb_3
this.cb_desresolvido=create cb_desresolvido
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_resolvido
this.Control[iCurrent+4]=this.cb_importar
this.Control[iCurrent+5]=this.cb_libera
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.cb_desresolvido
end on

on w_ge576_consulta_log_nfe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_resolvido)
destroy(this.cb_importar)
destroy(this.cb_libera)
destroy(this.gb_3)
destroy(this.cb_desresolvido)
end on

event ue_postopen;call super::ue_postopen;DateTime ldh_GetDate

Integer li_Linha

ldh_GetDate = gf_GetServerDate()

dw_1.Object.Dt_Inicio		[1] = RelativeDate(Date(ldh_GetDate), -15)
dw_1.Object.Dt_Termino		[1] = Date(ldh_GetDate)
//dw_1.Object.Dh_Emissao	[1] = RelativeDate(Date(ldh_GetDate), -1)

DataWindowChild lvdwc

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	li_Linha = lvdwc.InsertRow(1)
	
	lvdwc.SetItem(li_Linha, "cd_fornecedor", "000000000")
	lvdwc.SetItem(li_Linha, "nm_fantasia"  , "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild.", StopSign!)
End If

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema	= "RO" Then
	cb_desresolvido.visible	= True	
	cb_resolvido.visible 	= True
	cb_importar.visible 		= True
	cb_libera.visible 		= True
End If

This.ivm_Menu.mf_SalvarComo(True)
This.ivm_Menu.mf_Recuperar(True)
dw_4.Event ue_AddRow()
dw_1.SetFocus()
end event

event open;call super::open;io_Filial = Create uo_Filial

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2}
This.wf_SetUpdate_DW(lvo_Update)
end event

event close;call super::close;Destroy(io_Filial)

//integer i
//If IsValid(lvo_Update) then
//	For i = 1 to UpperBound(lvo_Update)
//		If IsValid(lvo_Update[i]) then
//			 Destroy lvo_Update[i]
//		End if
//	Next
//End if

end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	dw_2.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge576_consulta_log_nfe
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge576_consulta_log_nfe
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge576_consulta_log_nfe
integer y = 380
integer width = 6016
integer height = 1644
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge576_consulta_log_nfe
integer width = 4882
integer height = 348
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge576_consulta_log_nfe
integer width = 4818
integer height = 232
string dataobject = "dw_ge576_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		io_Filial.of_Localiza_Filial(GetText())
		
		If io_Filial.Localizada Then
			This.Object.Nm_Filial	[1] = io_Filial.Nm_Fantasia
			This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial
		Else
			io_Filial.of_Inicializa()
	
			This.Object.Nm_Filial	[1] = io_Filial.Nm_Fantasia
			This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial
			This.Object.Nm_Filial	[1] = io_Filial.Nm_Fantasia
		End If
		
End Choose

dw_4.Object.De_Chave_Acesso[1] = ""
This.ivm_Menu.mf_Recuperar(True)
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
dw_4.Object.De_Chave_Acesso[1] = ""
This.ivm_Menu.mf_Recuperar(True)
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge576_consulta_log_nfe
integer y = 456
integer width = 5966
integer height = 1540
string dataobject = "dw_ge576_lista_resumo"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_recuperar;//OverRide

DateTime ldh_Inicio
DateTime ldh_Termino
DateTime ldh_Emissao

Long ll_Filial
Long ll_Nr_Nf
Long ll_Pedido

String ls_Distribuidora
String ls_Chave_Acesso
String ls_Tipo
String ls_Estoque_Central
String ls_Resolvido
String ls_DW
String is_Distribuidora
String ls_situacao_nota

dw_1.AcceptText()
dw_2.Reset()

ldh_Inicio				= dw_1.Object.Dt_Inicio					[1]
ldh_Termino				= dw_1.Object.Dt_Termino				[1]
ll_Filial					= dw_1.Object.Cd_Filial					[1]
ls_Distribuidora			= dw_1.Object.Cd_Distribuidora		[1]
ll_Nr_Nf					= dw_1.Object.Nr_Nf					[1]
ll_Pedido					= dw_1.Object.Nr_Pedido				[1]
ls_Chave_Acesso		= dw_1.Object.De_Chave_Acesso	[1]
ls_Tipo					= dw_1.Object.Id_Tipo					[1]
ldh_Emissao				= dw_1.Object.Dh_Emissao				[1]
ls_Estoque_Central	= dw_1.Object.Id_Estoque_Central	[1]
ls_Resolvido				= dw_1.Object.Id_Resolvido			[1]
is_relatorio_resumido	= dw_1.Object.id_relatorio_resumido[1]
ls_situacao_nota		= dw_1.Object.id_situacao_nota		[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Ate$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Ate$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Ate$$HEX2$$e700e300$$ENDHEX$$o","A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If is_relatorio_resumido = 'S' Then
	ls_DW  = 'dw_ge576_lista_resumo'
	cb_desresolvido.Enabled	= False
	cb_resolvido.Enabled 		= False
	cb_importar.Enabled 		= False
	cb_libera.Enabled 			= False
Else
	cb_desresolvido.Enabled	= True	
	cb_resolvido.Enabled		= True
	cb_importar.Enabled 		= True
	cb_libera.Enabled 			= True
	ls_DW  = 'dw_ge576_lista'
End If

If This.DataObject <> ls_DW Then
	If Not This.of_ChangeDataObject(ls_DW) Then	Return -1
End If

This.of_SetRowSelection()

If Not IsNull(ll_Filial) Then
	This.of_appendwhere_subquery("ndnh.cd_filial = " + String(ll_Filial), 2)
	This.of_appendwhere_subquery("linpe.cd_filial = " + String(ll_Filial), 3)
End If

If ls_distribuidora <> '000000000' Then
	This.of_appendwhere_subquery("linpe.cd_distribuidora = '" + ls_distribuidora + "'", 3)
End If

If Not IsNull(ldh_Emissao) Then
	This.of_appendwhere_subquery("linpe.dh_emissao = '" + String(ldh_Emissao, "yyyymmdd") + "'", 3)
End If

If (Not IsNull(ll_Nr_Nf)) And (ll_Nr_Nf <> 0) Then
	This.of_appendwhere_subquery("linpe.nr_nf = " + String(ll_Nr_Nf), 3)
End If

If (Not IsNull(ll_Pedido)) And (ll_Pedido <> 0) Then
	This.of_appendwhere_subquery("linpe.nr_pedido = " + String(ll_Pedido), 3)
End If

If (Not IsNull(ls_Chave_Acesso)) And (ls_Chave_Acesso <> "") Then
	This.of_appendwhere_subquery("linpe.de_chave_acesso = '" + ls_Chave_Acesso + "'", 3)
End If

If ls_Estoque_Central = 'N' Then
	This.of_appendwhere_subquery("linpe.cd_filial <> 534", 3)
	This.of_appendwhere_subquery("(fo.id_distribuidora = 'S' or coalesce(fo.id_permite_nota_sem_pedido, 'N') = 'S' )", 3)
End If

If ls_situacao_nota <> 'T' Then
	This.of_appendwhere_subquery("linpe.id_situacao = '" + ls_situacao_nota + "'", 3)
End If

If ls_Resolvido = "N" Then
	This.of_appendwhere_subquery("(linpe.id_resolvido IS NULL OR linpe.id_resolvido = 'N')", 3)
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema	= "RO" Then
			cb_desresolvido.Visible	= FALSE
			cb_resolvido.Visible		= TRUE
		End if 
Else
	This.of_appendwhere_subquery("(linpe.id_resolvido = 'S')", 3)
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema	= "RO" Then
			cb_desresolvido.Visible	= TRUE
			cb_resolvido.Visible		= FALSE
		End if
End If

/*	Filtro de tipo log
	T - TODOS
	X - XML N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO
	M - PEDIDO REJEITADO MANUALMENTE
	I - SITUA$$HEX2$$c700c300$$ENDHEX$$O DO PEDIDO INV$$HEX1$$c100$$ENDHEX$$LIDA
	P - PEDIDO N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO
	N - N$$HEX1$$da00$$ENDHEX$$MERO DE PEDIDO N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO
	D - N$$HEX1$$c300$$ENDHEX$$O LOCALIZOU NOTA NA NFE_DESTINADAS
	L - NOTA RECEBIDA NA LOJA
*/
	
Choose Case ls_Tipo
	Case 'T'
		//N$$HEX1$$e300$$ENDHEX$$o filtra e mostra todos os resultados
	Case 'X'
		This.of_appendwhere_subquery("(linpe.de_log = 'O XML N$$HEX1$$c300$$ENDHEX$$O FOI LOCALIZADO NA $$HEX1$$c100$$ENDHEX$$REA FTP.' or linpe.de_log = 'XML N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO NA AREA FTP CLAMED')", 3)
		
	Case 'M'
		This.of_appendwhere_subquery("linpe.de_log like '%REJEITADO MANUALMENTE%'", 3)
		
	Case 'I'
		This.of_appendwhere_subquery("linpe.de_log like '%SITUA$$HEX2$$c700c300$$ENDHEX$$O%DO%PEDIDO%INV$$HEX1$$c100$$ENDHEX$$LIDA%'", 3)
		
	Case 'P'
		This.of_appendwhere_subquery("linpe.de_log like '%N$$HEX1$$c300$$ENDHEX$$O FOI LOCALIZADO%PEDIDO%FILIAL%'", 3)
		
	Case 'N'
		This.of_appendwhere_subquery("(linpe.de_log like '%NO XML N$$HEX1$$c300$$ENDHEX$$O $$HEX1$$c900$$ENDHEX$$ V$$HEX1$$c100$$ENDHEX$$LIDO%' or linpe.de_log like '%N$$HEX1$$c300$$ENDHEX$$O FOI ENCONTRADO NO XML%')", 3)
		
	Case 'R'
		This.of_appendwhere_subquery("linpe.de_log like '%N$$HEX1$$c300$$ENDHEX$$O FOI LOCALIZADO O C$$HEX1$$d300$$ENDHEX$$DIGO DO NOSSO PRODUTO COM O C$$HEX1$$d300$$ENDHEX$$DIGO DE BARRAS%'", 3)

	Case 'D'
		This.of_appendwhere_subquery("linpe.de_log  like '%NFE_DESTINADAS%'  ", 3)

	Case 'L'
		This.of_appendwhere_subquery("linpe.id_loja = 'S'  ", 3)
End Choose

Return This.Retrieve(ldh_Inicio, ldh_Termino)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	If is_relatorio_resumido = 'N' Then
		dw_4.Object.De_Chave_Acesso[1] = dw_2.Object.De_Chave_Acesso[CurrentRow]
		dw_4.Object.dh_atual[1]	= gf_getserverdate()
		dw_4.Object.dh_consumo_indev_dest[1]	= dw_2.Object.dh_consumo_indev_dest[CurrentRow]
		dw_4.Object.dh_ultimo_nsu[1]	= dw_2.Object.dh_ultimo_nsu[CurrentRow]
		dw_4.Object.dh_prox_cons_nsu[1]	= gf_relative_datetime(dw_2.Object.dh_ultimo_nsu[CurrentRow], 60 * 70)
	End If
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_situacao"
		This.ivm_Menu.mf_Confirmar(True)
		This.ivm_Menu.mf_Cancelar(True)
	Case "id_situacao"
		This.ivm_Menu.mf_Confirmar(True)
		This.ivm_Menu.mf_Cancelar(True)
End Choose

end event

event dw_2::doubleclicked;call super::doubleclicked;dw_1.AcceptText()

//If dw_1.Object.Cd_Distribuidora[1] = "000000000" Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione alguma distribuidora.")
//	Return -1
//End If

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
		This.Object.Id_Selecionado[lvl_Row] = lvs_Marcacao		
	Next
End If
end event

event dw_2::constructor;call super::constructor;ivb_ordena_colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge576_consulta_log_nfe
integer x = 667
integer y = 1164
end type

type dw_4 from dc_uo_dw_base within w_ge576_consulta_log_nfe
integer x = 69
integer y = 2064
integer width = 4114
integer height = 184
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge576_detalhe"
end type

type cb_1 from commandbutton within w_ge576_consulta_log_nfe
boolean visible = false
integer x = 4233
integer y = 2120
integer width = 846
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importa Sem Pedido Conexao"
end type

event clicked;String ls_Chave_Acesso

gvs_Dir_AnaliseXML = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'AnaliseXML', "")

dw_4.AcceptText()

ls_Chave_Acesso = dw_4.Object.De_Chave_Acesso[1]

SetPointer(HourGlass!)

uo_ge250_xml_pedido_eletronico lo_NFE

lo_NFE = Create uo_ge250_xml_pedido_eletronico

lo_NFE.ib_Importacao_Manual = True
	
lo_NFE.ib_Download_Sefaz = True

lo_NFE.ib_Imp_Manual_Sem_Pedido_Conexao = True

lo_NFE.of_Processa_Atualizacao(ls_Chave_Acesso)

Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Processamento conclu$$HEX1$$ed00$$ENDHEX$$do.")

Destroy(lo_NFE)

SetPointer(Arrow!)
end event

type cb_resolvido from commandbutton within w_ge576_consulta_log_nfe
boolean visible = false
integer x = 4983
integer y = 48
integer width = 507
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Resolvido"
end type

event clicked;Boolean lb_Sucesso = True

DateTime ldh_Resolvido

Long ll_Linha
Long ll_Nr_Log
Long ll_Find

String ls_Distribuidora
String ls_Selecionado

dw_1.AcceptText()
dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	ldh_Resolvido	= gf_GetServerDate()
	ls_Distribuidora	= dw_1.Object.Cd_Distribuidora[1]
	
//	If ls_Distribuidora = "000000000" Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora.", Exclamation!)
//		dw_1.Event ue_Pos(1, "cd_distribuidora")
//		Return -1
//	End If
	
	ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())
	
	If ll_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da dw_2.", StopSign!)
		Return -1
	End If
	
	If ll_Find = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum log foi selecionado.", Exclamation!)
		Return -1
	End If
	
	For ll_Linha = 1 To dw_2.RowCount()
	
		ls_Selecionado = dw_2.Object.Id_Selecionado[ll_Linha]
		
		If ls_Selecionado = "S" Then
			
			ll_Nr_Log = dw_2.Object.Nr_Log[ll_Linha]
					
			Update log_importacao_nf_ped_elet
				Set 	id_resolvido		= 'S',
						dh_resolvido	= :ldh_Resolvido
			Where nr_log = :ll_Nr_Log
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError("Erro ao atualizar o id_resolvido da tabela log_importacao_nf_ped_elet")
				lb_Sucesso = False
				Exit
			End If
		End If
	Next
	
	If lb_Sucesso Then 
		SqlCa.of_Commit();
		dw_2.Event ue_Retrieve()
	Else
		SqlCa.of_RollBack();
		Return -1
	End If
End If
end event

type cb_importar from commandbutton within w_ge576_consulta_log_nfe
boolean visible = false
integer x = 4983
integer y = 156
integer width = 507
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importa NFe"
end type

event clicked;String ls_Chave

dw_2.AcceptText()

If dw_2.RowCount() = 0 Then  Return

//If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja importar a nota selecionada ?", Question!, YesNo!, 2) = 2 Then Return

ls_Chave = dw_2.Object.de_chave_acesso[dw_2.GetRow()]

OpenWithParm(w_ge250_importa_xml, ls_Chave)

//If Not ivb_Processando Then
//	
//	SetPointer(HourGlass!)
//	
//	uo_ge250_xml_pedido_eletronico lo_NFE
//	
//	lo_NFE = Create uo_ge250_xml_pedido_eletronico
//	
//	lo_NFE.ib_Importacao_Manual = True
//		
//	lo_NFE.ib_Download_Sefaz = True
//
////	If dw_1.Object.id_sem_pedido_conexao[1] = 'S' Then
////		lo_NFE.ib_Imp_Manual_Sem_Pedido_Conexao = True
////	Else
////		lo_NFE.ib_Imp_Manual_Sem_Pedido_Conexao = False
////	End If
//	
//	lo_NFE.ib_Imp_Manual_Sem_Pedido_Conexao = False
//	
////	If dw_1.Object.id_marreta_reposicao_sta[1] = 'S' Then
////		lo_NFE.ib_marreta_reposicao_sta = True
////	Else
////		lo_NFE.ib_marreta_reposicao_sta = False
////	End If
//	
//	lo_NFE.ib_marreta_reposicao_sta = False
//	
//	lo_NFE.of_Processa_Atualizacao(ls_Chave)
//	
//	Destroy(lo_NFE)
//	
//	ivb_Processando = False
//	
//	SetPointer(Arrow!)
//	
//	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Processamento conclu$$HEX1$$ed00$$ENDHEX$$do.")
//End If
//		
end event

type cb_libera from commandbutton within w_ge576_consulta_log_nfe
boolean visible = false
integer x = 4983
integer y = 264
integer width = 507
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Libera a Imp. NF"
end type

event clicked;Boolean 	lb_Alteracao = False

Long 		ll_Linha, &
		 	ll_Filial, &
		 	ll_Pedido, &
			ll_Find, &
			ll_Achou
	 
String		ls_Distribuidora, &
			ls_Situacao, &
			ls_Log, &
			ls_Selecionado, &
			ls_Erro
	 
dw_2.AcceptText()

If dw_2.RowCount() = 0 Then Return -1

ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
	Return -1
End If

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma NF foi selecionada.", Exclamation!)
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a libera$$HEX2$$e700e300$$ENDHEX$$o da importa$$HEX2$$e700e300$$ENDHEX$$o das notas selecionadas?", Question!, YesNo!, 2) = 2 Then Return -1

For ll_Linha = 1 To dw_2.RowCount()
	ll_Filial        			= dw_2.Object.cd_filial[ll_Linha]
	ls_Distribuidora 	= dw_2.Object.cd_distribuidora[ll_Linha]
	ll_Pedido 		  	= dw_2.Object.nr_pedido[ll_Linha]
	ls_Situacao			= dw_2.Object.id_situacao[ll_Linha]
	ls_Log				= dw_2.Object.De_Log[ll_Linha]
	ls_Selecionado		= dw_2.Object.Id_Selecionado[ll_Linha]
	
	if (IsNull(ll_Pedido) or ll_Pedido <= 0) and ls_Selecionado = 'S' then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser realizada para notas fiscais que n$$HEX1$$e300$$ENDHEX$$o tem pedidos atrelados.', StopSign!)
		Return -1
	end if
	
	If ls_Selecionado = "S" Then
		If ls_Situacao = "C" Then Continue //J$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ com situa$$HEX2$$e700e300$$ENDHEX$$o 'COLOCADO'
		
		If IsNull(ls_Situacao) or ls_Situacao = 'PT' or ls_Situacao = 'LE' or ls_Situacao = 'PR' Then
			If PosA(ls_Log, 'J') <= 0 And PosA(ls_Log, 'X') <= 0 And PosA(ls_Log, 'N') <= 0 Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido [REJEITADO], [CANCELADO] ou [N$$HEX1$$c300$$ENDHEX$$O ATENDIDO] poder$$HEX1$$e100$$ENDHEX$$ ser liberado para a importa$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
				Return
			End If
		Else
			If ls_Situacao <> 'J' And ls_Situacao <> 'X' And ls_Situacao <> 'N' Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido [REJEITADO], [CANCELADO] ou [N$$HEX1$$c300$$ENDHEX$$O ATENDIDO] poder$$HEX1$$e100$$ENDHEX$$ ser liberado para a importa$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
				Return
			End If
		End If
		
		SELECT
			cd_filial
		INTO	
			:ll_Achou
		FROM	
			pedido_distribuidora
		WHERE 
			cd_filial = :ll_Filial
		AND
			nr_pedido_distribuidora = :ll_Pedido
		USING 
			SQLCA;
		
		Choose Case SQLCA.SqlCode
			Case 0
				UPDATE
					pedido_distribuidora
				SET
					dh_nota_fiscal = null, 
					dh_titulo_pagar = Null, 
					id_situacao = 'C'
				WHERE
					cd_filial = :ll_Filial
				 	AND nr_pedido_distribuidora = :ll_Pedido
				USING 
					SQLCA;
				
				If SQLCA.SqlCode = -1 Then
					ls_Erro = SqlCa.SqlErrText
					SqlCa.of_RollBack();
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + String(ll_Pedido) + "' da filial '" + String(ll_Filial) + "'. " + ls_Erro, StopSign!)
					Return -1
				End If
				
				dw_2.Object.id_situacao [ll_Linha] = 'C'
				lb_Alteracao = True
			Case 100
				//Se n$$HEX1$$e300$$ENDHEX$$o localizou o pedido distribuidora, localizado um pedido conex$$HEX1$$e300$$ENDHEX$$o
				SELECT
					min(nr_pedido_distribuidora)
				INTO
					:ll_Achou
				FROM
					pedido_distribuidora
				WHERE
					cd_filial = :ll_Filial
					AND nr_pedido_conexao = :ll_Pedido
				USING
					SQLCA;
				
				Choose Case SqlCa.SqlCode
					Case 0
						UPDATE
							pedido_distribuidora
						SET
							dh_nota_fiscal = null, dh_titulo_pagar = Null, id_situacao = 'C'
						WHERE
							cd_filial = :ll_Filial
						  	AND nr_pedido_conexao = :ll_Pedido
						USING
							SQLCA;
						
						If SqlCa.SqlCode = -1 Then
							ls_Erro = SqlCa.SqlErrText
							SqlCa.of_RollBack();
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido conex$$HEX1$$e300$$ENDHEX$$o '" + String(ll_Pedido) + "' da filial '" + String(ll_Filial) + "'. " + ls_Erro, StopSign!)
							Return -1
						End If
						
						dw_2.Object.id_situacao [ll_Linha] = 'C'
						lb_Alteracao = True
					Case 100						
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido foi localizado.~r Verifique se $$HEX1$$e900$$ENDHEX$$ um pedido de conex$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
					Case -1						
						ls_Erro = SqlCa.SqlErrText
						SqlCa.of_RollBack();
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o pedido conex$$HEX1$$e300$$ENDHEX$$o '" + String(ll_Pedido) + "' da filial '" + String(ll_Filial) + "'. " + ls_Erro, StopSign!)
						Return -1
				End Choose
			Case -1
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_RollBack();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o pedido '" + String(ll_Pedido) + "' da filial '" + String(ll_Filial) + "'. " + ls_Erro, StopSign!)
				Return -1
		End Choose
	End If
Next

If lb_Alteracao Then
	SQLCA.of_Commit();
End If
end event

type gb_3 from groupbox within w_ge576_consulta_log_nfe
integer x = 37
integer y = 2016
integer width = 4169
integer height = 244
integer taborder = 50
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

type cb_desresolvido from commandbutton within w_ge576_consulta_log_nfe
boolean visible = false
integer x = 4983
integer y = 48
integer width = 507
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "N$$HEX1$$e300$$ENDHEX$$o Resolvido"
end type

event clicked;Boolean lb_Sucesso = True

DateTime ldh_Resolvido

Long ll_Linha
Long ll_Nr_Log
Long ll_Find

String ls_Distribuidora
String ls_Selecionado

dw_1.AcceptText()
dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	ldh_Resolvido	= gf_GetServerDate()
	ls_Distribuidora	= dw_1.Object.Cd_Distribuidora[1]
	
//	If ls_Distribuidora = "000000000" Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora.", Exclamation!)
//		dw_1.Event ue_Pos(1, "cd_distribuidora")
//		Return -1
//	End If
	
	ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())
	
	If ll_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da dw_2.", StopSign!)
		Return -1
	End If
	
	If ll_Find = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum log foi selecionado.", Exclamation!)
		Return -1
	End If
	
	For ll_Linha = 1 To dw_2.RowCount()
	
		ls_Selecionado = dw_2.Object.Id_Selecionado[ll_Linha]
		
		If ls_Selecionado = "S" Then
			
			ll_Nr_Log = dw_2.Object.Nr_Log[ll_Linha]
					
			Update log_importacao_nf_ped_elet
				Set 	id_resolvido		= 'N',
						dh_resolvido	= :ldh_Resolvido
			Where nr_log = :ll_Nr_Log
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError("Erro ao atualizar o id_resolvido da tabela log_importacao_nf_ped_elet")
				lb_Sucesso = False
				Exit
			End If
		End If
	Next
	
	If lb_Sucesso Then 
		SqlCa.of_Commit();
		dw_2.Event ue_Retrieve()
	Else
		SqlCa.of_RollBack();
		Return -1
	End If
End If
end event

