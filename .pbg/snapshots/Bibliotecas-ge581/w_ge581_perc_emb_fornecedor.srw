HA$PBExportHeader$w_ge581_perc_emb_fornecedor.srw
$PBExportComments$Percentual Aumento da Quantidade de Embalagem Fornecedor
forward
global type w_ge581_perc_emb_fornecedor from dc_w_sheet
end type
type dw_1 from dc_uo_dw_base within w_ge581_perc_emb_fornecedor
end type
type st_1 from statictext within w_ge581_perc_emb_fornecedor
end type
type gb_1 from groupbox within w_ge581_perc_emb_fornecedor
end type
end forward

global type w_ge581_perc_emb_fornecedor from dc_w_sheet
string tag = "w_ge581_perc_emb_fornecedor"
integer width = 2958
integer height = 816
string title = "GE581 - Percentual Aumento da Qtde de Emb. Fornecedor"
dw_1 dw_1
st_1 st_1
gb_1 gb_1
end type
global w_ge581_perc_emb_fornecedor w_ge581_perc_emb_fornecedor

type variables

String ivs_Mensagem

Boolean ib_Fecha_Tela = False
end variables

forward prototypes
public subroutine _documentacao ()
end prototypes

public subroutine _documentacao ();/*

	Objetivo: Nesta tela $$HEX1$$e900$$ENDHEX$$ definido os parametros de corte de pedidos da Log$$HEX1$$ed00$$ENDHEX$$stica 

	Tabelas: 
				- wms_parametro
				- historico_alteracao_tabela
				
	Consulta a wms_parametro, grava as altera$$HEX2$$e700f500$$ENDHEX$$es na historico_alteracao_tabela									

*/
end subroutine

event ue_postopen;call super::ue_postopen;String lvs_Operador, ls_Mensagem

//Verifica se ja iniciou gera$$HEX2$$e700e300$$ENDHEX$$o de pedido CD
If Not gf_verifica_geracao_logistica( Ref ls_Mensagem ) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, StopSign!)
	Close(This)
	Return 
End If 

dc_uo_dw_Base lvo_Update[]

lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.Retrieve()

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE581_PERC_EMB_FORNECEDOR", ref lvs_Operador) Then 
	Close(This)
	Return
End If
gvo_Aplicacao.ivo_Seguranca.of_Localiza_Usuario(lvs_Operador)


end event

on w_ge581_perc_emb_fornecedor.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_ge581_perc_emb_fornecedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.gb_1)
end on

event ue_preupdate;call super::ue_preupdate;Long  ll_Linha, ll_Total
			
String     lvs_erro,  ls_Valor_Parametro_De, ls_Valor_Parametro_Para, ls_Operador, ls_Codigo_Parametro, ls_Mensagem

//Verifica novamente se ja iniciou gera$$HEX2$$e700e300$$ENDHEX$$o de pedido CD
If Not gf_verifica_geracao_logistica( Ref ls_Mensagem ) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, StopSign!)
	dw_1.Event ue_Cancel()
	ib_Fecha_Tela = True
	Return False
End If 

ll_Total  = dw_1.rowcount( )
ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

SetPointer(HourGlass!)

//Grava Hist$$HEX1$$f300$$ENDHEX$$rico da altera$$HEX2$$e700e300$$ENDHEX$$o
For ll_Linha = 1 To ll_Total 
	ls_Codigo_Parametro = dw_1.Object.cd_parametro[ll_linha]
	
	ls_Valor_Parametro_Para = dw_1.getitemstring(ll_linha, 'vl_parametro')
	
	Select 	vl_parametro
	Into 		:ls_Valor_Parametro_De
	From 		wms_parametro 
	Where 	cd_parametro = :ls_Codigo_Parametro
	Using SqlCa;

	Choose Case SqlCa.SqlCode
	Case 0
		If ls_Valor_Parametro_De <> ls_Valor_Parametro_Para Then
			If Not gf_Grava_Historico_Alteracao_Tabela('WMS_PARAMETRO', ls_Codigo_Parametro+';GC', 'VL_PARAMETRO', ls_Valor_Parametro_De, ls_Valor_Parametro_Para, ls_Operador, 'A', Ref lvs_erro, True) Then Return False
		End If		
		
	Case -1
		lvs_erro = "Erro Ao Localizar os Dados de Parametros para Grava$$HEX2$$e700e300$$ENDHEX$$o de Historico." + SqlCa.SQLErrText
		SqlCa.of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_erro, StopSign!)
		Return False
	End Choose
Next

Return True

end event

event ue_save;call super::ue_save;
If ib_Fecha_Tela Then
	SqlCa.of_RollBack()
	Close(This)
End If

Return 1
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge581_perc_emb_fornecedor
integer x = 87
integer y = 1376
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge581_perc_emb_fornecedor
integer x = 55
integer y = 1292
end type

type dw_1 from dc_uo_dw_base within w_ge581_perc_emb_fornecedor
integer x = 41
integer y = 176
integer width = 2857
integer height = 420
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge581_perc_emb_fornecedor"
end type

event itemchanged;call super::itemchanged;dw_1.ivm_menu.mf_confirmar( True)
dw_1.ivm_menu.mf_cancelar( True)
end event

event editchanged;call super::editchanged;dw_1.ivm_menu.mf_confirmar( True)
dw_1.ivm_menu.mf_cancelar( True)
end event

type st_1 from statictext within w_ge581_perc_emb_fornecedor
integer x = 37
integer y = 56
integer width = 1102
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean underline = true
long textcolor = 8388608
long backcolor = 67108864
string text = "Defini$$HEX2$$e700e300$$ENDHEX$$o Valores de Par$$HEX1$$e200$$ENDHEX$$metros"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ge581_perc_emb_fornecedor
integer x = 18
integer width = 2885
integer height = 616
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

