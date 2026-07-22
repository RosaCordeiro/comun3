HA$PBExportHeader$w_ge538_envio_venda_scanntech.srw
forward
global type w_ge538_envio_venda_scanntech from dc_w_selecao_lista_relatorio
end type
type cb_selecao from commandbutton within w_ge538_envio_venda_scanntech
end type
type cb_1 from commandbutton within w_ge538_envio_venda_scanntech
end type
type cb_2 from commandbutton within w_ge538_envio_venda_scanntech
end type
type dw_selecao_filial from dc_uo_dw_base within w_ge538_envio_venda_scanntech
end type
type st_1 from statictext within w_ge538_envio_venda_scanntech
end type
type st_2 from statictext within w_ge538_envio_venda_scanntech
end type
type cb_3 from commandbutton within w_ge538_envio_venda_scanntech
end type
type st_3 from statictext within w_ge538_envio_venda_scanntech
end type
type cb_4 from commandbutton within w_ge538_envio_venda_scanntech
end type
type cb_5 from commandbutton within w_ge538_envio_venda_scanntech
end type
type cb_6 from commandbutton within w_ge538_envio_venda_scanntech
end type
type cb_7 from commandbutton within w_ge538_envio_venda_scanntech
end type
end forward

global type w_ge538_envio_venda_scanntech from dc_w_selecao_lista_relatorio
integer width = 2981
integer height = 2260
string title = "GE538 - Promo$$HEX2$$e700e300$$ENDHEX$$o ScannTech"
event ue_processamento ( )
cb_selecao cb_selecao
cb_1 cb_1
cb_2 cb_2
dw_selecao_filial dw_selecao_filial
st_1 st_1
st_2 st_2
cb_3 cb_3
st_3 st_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
end type
global w_ge538_envio_venda_scanntech w_ge538_envio_venda_scanntech

type variables
CONSTANT STRING DW_VARIAS_FILIAIS	= 'dw_ro017_selecao_varias_filiais'
CONSTANT STRING DW_UNICA_FILIAL		= 'dw_ro017_selecao_unica_filial'

uo_ge216_filiais io_filiais

uo_Filial io_Filial

string ivs_filiais, ivs_nulo




end variables

event ue_processamento();////**********************************************************************************************************************************
////    Altera$$HEX2$$e700e300$$ENDHEX$$o: 
////	  
////	              Data                Respons$$HEX1$$e100$$ENDHEX$$vel                                                               Objetivo
////				17/09/2021      Saulo Braga                                                                - Evento principal, que server para todos os processamentos.	  
////					  
////
////**********************************************************************************************************************************/
////String ls_selecao_parametro, ls_mensagem, ls_filtro_filial, ls_clausa_in, ls_erro, ls_nSelecionado
////Boolean lb_retorno
////date ldt_emissao
////Long ll_cont, ll_row, ll_filial[]
////
////st_1.text = String(Now(), "hh:mm")
////
////
////dw_1.AcceptText() 
////ls_selecao_parametro = dw_1.object.selecao_parametro[1]
////ldt_emissao                 = dw_1.object.dt_emissao[1]
////
////if ( ls_selecao_parametro = 'N' ) or IsNull(ls_selecao_parametro)   then
////   Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",' Favor informar o tipo de PROCESSAMENTO!',information!)
////   dw_1.setColumn('dt_emissao')
////   return
////end if
////
//uo_ge538_scann_tech uo_scanntech
//if isValid(uo_scanntech) then
//   Destroy uo_scanntech
//end if
//
//
////// Criando objeto para o envio do JSON
//uo_scanntech = create uo_ge538_scann_tech
//
//
//
//// Habilita esse codigo e desabilita o resto, para testar como se fosse em exporta$$HEX1$$e700$$ENDHEX$$cao
////uo_scanntech.il_filial[] =  {107,149,181,246,313,738,792,797,803,895}
//uo_scanntech.il_filial[] =  { 149 }
//uo_scanntech.idt_dh_movimentacao_caixa = Date('2021/10/16')
//
//uo_scanntech.of_processa()
//
//
//
////if dw_selecao_filial.object.id_filiais[1] = 'T' then
////  ls_filtro_filial = 'T'    // Todas Filiais	
////else
////  dw_2.setFocus()
////end if
////
////ls_filtro_filial = 'A'    // Algumas Filiais	
////		
////ll_row = dw_2.rowcount()
////	
////if ll_row = 0 then
////   Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",' Favor informar a(s) Filial(is)!',information!)
////   dw_1.setColumn('dt_emissao')
////   return 	
////end if
////
////ls_nSelecionado = 'N'		
////		
////for ll_cont = 1 to ll_row
////		
////   if dw_2.object.processa[ll_cont] = 'S'  then
////	 ls_nSelecionado = 'S'	
////     ll_filial[ll_cont] = dw_2.object.cd_filial[ll_cont]
////  end if	
////		
////next
////		
////if ls_nSelecionado = 'N' then
////   Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",' Favor selecionar a(s) Filial(is)!',information!)
////   dw_1.setColumn('dt_emissao')
////   return 	
////end if
////
////if  ls_selecao_parametro = '1'  then
////
////   if ps_tipo = 'P' then	  // Processamento
////	  Enviar as vendas
////	 lb_retorno = uo_scanntech.of_processa_envio_vendas( ldt_emissao,  ll_filial[], ls_erro )
////   else // Reprocessamento
////	 lb_retorno = uo_scanntech.of_reprocessa_envio_vendas( ldt_emissao, ls_filtro_filial , ll_filial[], ls_erro )	
////   end if		
////elseif  ls_selecao_parametro = '2'  then
////
////
////     Buscar as promo$$HEX2$$e700f500$$ENDHEX$$es aceitas
////    lb_retorno = uo_scanntech.of_processa_promocoes( ldt_emissao, ls_filtro_filial , ll_filial[], ls_erro )
////
////else
////
////     Envio Fechamento Di$$HEX1$$e100$$ENDHEX$$rio
////    lb_retorno = uo_scanntech.of_processa_fechamento_diario( ldt_emissao,  ll_filial[], ls_erro)
////
////end if
////	
////	
////if lb_retorno = true then 
////   ls_mensagem = 'Dados processados com SUCESSO!'
////else 
////   ls_mensagem = ls_erro	
////end if	
////
////st_2.text = String(Now(), "hh:mm")
////
////Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_mensagem,information!)
////
////dw_1.setFocus()
////dw_1.setColumn('dt_emissao')
////
end event

on w_ge538_envio_venda_scanntech.create
int iCurrent
call super::create
this.cb_selecao=create cb_selecao
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_selecao_filial=create dw_selecao_filial
this.st_1=create st_1
this.st_2=create st_2
this.cb_3=create cb_3
this.st_3=create st_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecao
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_selecao_filial
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.cb_5
this.Control[iCurrent+11]=this.cb_6
this.Control[iCurrent+12]=this.cb_7
end on

on w_ge538_envio_venda_scanntech.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_selecao)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_selecao_filial)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.st_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
end on

event close;call super::close;Destroy io_Filiais
Destroy io_Filial  
end event

event ue_postopen;call super::ue_postopen;//dw_2.Event ue_AddRow()
//dw_Selecao_Filial.Event ue_AddRow()
//
//io_Filiais	= Create uo_ge216_filiais
//io_Filial	= Create uo_Filial
//
//this.Event ue_retrieve()
//
//
//dw_1.object.dt_emissao[1] = today()
//dw_1.SetFocus()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge538_envio_venda_scanntech
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge538_envio_venda_scanntech
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge538_envio_venda_scanntech
integer y = 520
integer width = 2853
integer height = 1320
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge538_envio_venda_scanntech
integer width = 2853
integer height = 496
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge538_envio_venda_scanntech
integer x = 91
integer width = 1993
integer height = 196
string dataobject = "dw_ge538_sel_log_filial"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge538_envio_venda_scanntech
integer y = 584
integer width = 2770
integer height = 1220
string dataobject = "dw_ge538_sel_log_filial"
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;//If pl_Linhas > 0 Then
//	cb_Selecao.Text = 'Selecionar Todas'
//	cb_Selecao.Enabled = True
//End If
//
Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;//String lvs_Coluna[], &
//       lvs_Nome[]
//
//lvs_Coluna = {"cd_filial", "nm_fantasia", "nm_razao_social"}
//
//lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo da Filial", "Nome Fantasia", "Raz$$HEX1$$e300$$ENDHEX$$o Social"}
//
//This.of_SetSort(lvs_Coluna, lvs_Nome)
//This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge538_envio_venda_scanntech
integer x = 2720
integer y = 68
end type

type cb_selecao from commandbutton within w_ge538_envio_venda_scanntech
integer x = 37
integer y = 1868
integer width = 503
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Selecionar Todas"
end type

event clicked;Long lvl_Linha

String lvs_Marcar		= 'S'
String lvs_Definicao	= 'N'

If This.Text = 'Selecionar Todas' Then
	This.Text = 'Desmarcar Todas'
Else
	This.Text = 'Selecionar Todas'
	lvs_Marcar = 'N'
End If

For lvl_Linha = 1 To dw_2.RowCount()
	dw_2.Object.processa[lvl_Linha] = lvs_Marcar
Next

If dw_Selecao_Filial.DataObject = DW_VARIAS_FILIAIS Then
	If dw_Selecao_Filial.Object.id_Filiais[ 1 ] = 'T' Then
		lvs_Definicao = 'S'
	End If
End If

If lvs_Marcar = 'S' And lvs_Definicao = 'S' Then
	dw_2.Object.processa[ 1 ] = 'S'
Else
	dw_2.Object.processa[ 1 ] = 'N'
End If
end event

type cb_1 from commandbutton within w_ge538_envio_venda_scanntech
integer x = 2071
integer y = 1868
integer width = 402
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Processar"
end type

event clicked;/**********************************************************************************************************************************
    Altera$$HEX2$$e700e300$$ENDHEX$$o: 
	  
	              Data                Respons$$HEX1$$e100$$ENDHEX$$vel                                                               Objetivo
				13/08/2021      Saulo Braga                                                                - Processa o envio ou a busca pela promo$$HEX2$$e700e300$$ENDHEX$$o.	  
					  
                  Parametro do Evento: P - Processamento
**********************************************************************************************************************************/
//Parent.Event ue_processamento()

end event

type cb_2 from commandbutton within w_ge538_envio_venda_scanntech
integer x = 2482
integer y = 1872
integer width = 402
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Cancelar"
boolean default = true
end type

event clicked;close(parent)
end event

type dw_selecao_filial from dc_uo_dw_base within w_ge538_envio_venda_scanntech
integer x = 325
integer y = 296
integer width = 1760
integer height = 80
integer taborder = 40
boolean bringtotop = true
end type

event itemchanged;call super::itemchanged;cb_Selecao.Text = 'Selecionar Todas'
cb_Selecao.Enabled	= False
//cb_Copiar.Enabled		= False
//cb_Salvar.Enabled		= False

Long lvl_Lojas

This.AcceptText()

Choose Case dwo.Name
				
	Case "id_filiais"
				
		If Data = 'P' Then
		
			ivs_filiais = ivs_nulo 
					
			OpenWithParm(w_ge216_selecao_filiais, io_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = io_Filiais.ivs_filiais			
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
				This.Object.id_filiais	[1] = "T"
				Return 1
			End If
			
		End If

	Case "nm_fantasia"
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
End Choose
end event

event losefocus;call super::losefocus;If This.DataObject = DW_UNICA_FILIAL Then
	If IsValid( io_Filial ) Then
		This.Object.Nm_Fantasia[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event ue_addrow;call super::ue_addrow;If IsValid( io_Filial ) Then io_Filial.of_Inicializa( )

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fantasia"
			io_Filial.of_Localiza_Filial( This.GetText() )
			
			If io_Filial.Localizada Then
				This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
			End If
			
	End Choose
End If
end event

type st_1 from statictext within w_ge538_envio_venda_scanntech
integer x = 649
integer y = 1868
integer width = 183
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge538_envio_venda_scanntech
integer x = 923
integer y = 1868
integer width = 183
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_ge538_envio_venda_scanntech
integer x = 1641
integer y = 1864
integer width = 416
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Reprocessar"
end type

event clicked;///**********************************************************************************************************************************
//    Altera$$HEX2$$e700e300$$ENDHEX$$o: 
//	  
//	              Data                Respons$$HEX1$$e100$$ENDHEX$$vel                                                               Objetivo
//				13/08/2021      Saulo Braga                                                                - Processa o envio ou a busca pela promo$$HEX2$$e700e300$$ENDHEX$$o.	  
//					  
//                   Parametro do Evento: R - Reprocessamento
//					
//**********************************************************************************************************************************/
////Parent.Event ue_processamento()
//
//
//uo_ge546_distribuidora_historico uo_historico
//
//uo_historico = create  uo_ge546_distribuidora_historico
//
//uo_historico.of_processa_historico( )
//
//
//destroy uo_historico
end event

type st_3 from statictext within w_ge538_envio_venda_scanntech
integer x = 1189
integer y = 1868
integer width = 183
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_ge538_envio_venda_scanntech
integer x = 2066
integer y = 1964
integer width = 421
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "NewProcessar"
end type

event clicked;/////**********************************************************************************************************************************
////    Altera$$HEX2$$e700e300$$ENDHEX$$o: 
////	  
////	              Data                Respons$$HEX1$$e100$$ENDHEX$$vel                                                               Objetivo
////				13/08/2021      Saulo Braga                                                                - Processa o envio ou a busca pela promo$$HEX2$$e700e300$$ENDHEX$$o.	  
////					  
////                  Parametro do Evento: P - Processamento
////**********************************************************************************************************************************/
//long ll_cd_filial[], ll_cont
//
//string ls_erro
//
//uo_ge538_scanntech_new uo_novo
//uo_ge538_scanntech_lote uo_lote
//
//uo_novo = create uo_ge538_scanntech_new
//uo_lote = create uo_ge538_scanntech_lote
//
////uo_novo.il_filial[] = { 149, 563 }
////uo_novo.idt_dh_movimentacao_caixa = Date('2021/06/01')
//
////uo_lote.of_leitura_retorno_json_enviado( '', 'S', ls_erro )
//
//st_1.text = String(Now(), "hh:mm")
//
////for ll_cont = 1 to 100
////	
////uo_novo.of_processar_scanntech()
////
////next
////
//uo_novo.of_processar_scanntech_fechamento()
//st_2.text = String(Now(), "hh:mm")
end event

type cb_5 from commandbutton within w_ge538_envio_venda_scanntech
integer x = 1399
integer y = 1960
integer width = 475
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Processar Lote"
end type

event clicked;//
//
/////////**********************************************************************************************************************************
//////    Altera$$HEX2$$e700e300$$ENDHEX$$o: 
//////	  
//////	              Data                Respons$$HEX1$$e100$$ENDHEX$$vel                                                               Objetivo
//////				13/08/2021      Saulo Braga                                                                - Processa o envio ou a busca pela promo$$HEX2$$e700e300$$ENDHEX$$o.	  
//////					  
//////                  Parametro do Evento: P - Processamento
//////**********************************************************************************************************************************/
long ll_cd_filial[], ll_cont
//
//
////ii_Arq = FileOpen("c:\temp\log_scanntech.txt", LineMode!, Write!, LockReadWrite!, Replace!, EncodingANSI!)
//
//string ls_erro
//
uo_ge538_scanntech_lote uo_lote

uo_lote = create uo_ge538_scanntech_lote

string ls_mes[]

//uo_lote.of_processamento_atrasado(today(),'V',ls_mes)

//for ll_cont = 1 to 100


uo_lote.of_processar_bloco_lote( 1)
//
//
uo_lote.of_processar_bloco_lote( 2)
//
//
//
uo_lote.of_processar_bloco_lote( 3)


//next 

////fileClose(ii_arq)

uo_lote.of_processar_scanntech_fechamento()
//
//st_2.text = String(Now(), "hh:mm")
end event

type cb_6 from commandbutton within w_ge538_envio_venda_scanntech
integer x = 946
integer y = 1980
integer width = 402
integer height = 92
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Separa$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;////
//String ls_erro
//
//uo_ge550_esteira_automatica uo_ge550_esteira
//
//uo_ge550_esteira = create uo_ge550_esteira_automatica
//
//
//uo_ge550_esteira.of_envia_esteira_automatica( 372 , 16373615 , 3 , ls_erro)  //lvl_Filial, lvl_pedido, lvl_volume 
//
//destroy uo_ge550_esteira
end event

type cb_7 from commandbutton within w_ge538_envio_venda_scanntech
integer x = 119
integer y = 1976
integer width = 512
integer height = 92
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Processar Picking"
end type

event clicked;////uo_ge259_pedido_filial_new luo_pedido
//
//luo_pedido  = create uo_ge259_pedido_filial_new
//
//
//luo_pedido.of_processa_geracao_picking( 13 , 20143129  , false) 
//
//
//
//Destroy luo_pedido
end event

