HA$PBExportHeader$w_ge510_monitor_ecommerce.srw
forward
global type w_ge510_monitor_ecommerce from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type uo_detalhe from uo_ge510_detalhes within tabpage_2
end type
end forward

global type w_ge510_monitor_ecommerce from dc_w_2tab_consulta_selecao_lista_det
integer width = 3927
integer height = 2416
string title = "GE510 - Monitor Ecommerce"
end type
global w_ge510_monitor_ecommerce w_ge510_monitor_ecommerce

type variables
Integer ii_Empresa = 1000

boolean ivb_check

uo_produto io_produto
uo_filial io_filial
//uo_ge228_marca_produto io_marca

Long il_cd_filial
Long il_cd_produto
Long il_cd_marca
Long il_cd_categoria

String is_nr_pedido
end variables

forward prototypes
public function boolean wf_verifica_obrigatoriedade_campo (long al_controle, string as_campo, string as_obrigatoriedade, string as_valor, ref string as_log)
public subroutine wf_limpa_variaveis ()
end prototypes

public function boolean wf_verifica_obrigatoriedade_campo (long al_controle, string as_campo, string as_obrigatoriedade, string as_valor, ref string as_log);If as_obrigatoriedade = 'S' Then
	If IsNull(as_valor) or Trim(as_valor) = "" Then
		as_log = "Preechimento do campo '"+as_campo+"' $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio"
		Return False
	End If
End If

Return True


end function

public subroutine wf_limpa_variaveis ();setnull( il_cd_filial)
setnull(il_cd_produto)
setnull(il_cd_marca)
setnull(il_cd_categoria)

setnull(is_nr_pedido)
end subroutine

on w_ge510_monitor_ecommerce.create
int iCurrent
call super::create
end on

on w_ge510_monitor_ecommerce.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DataWindowChild lvdwc_tipo, ldwc_rede

Tab_1.TabPage_1.dw_1.AcceptText()

//Tab_1.TabPage_1.dw_1.Object.dh_inicio[1] = relativedate(date(gf_GetServerDate()),- 5)
Tab_1.TabPage_1.dw_1.Object.dh_inicio[1] = date(gf_GetServerDate())
Tab_1.TabPage_1.dw_1.Object.dh_fim[1] = date(gf_GetServerDate())
		
If Tab_1.TabPage_1.dw_1.GetChild("cd_tipo", lvdwc_tipo) = 1 Then
	
	lvdwc_tipo.SetTransObject(SQLCA)

	lvdwc_tipo.Retrieve('S')
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do tipo.")
End If

If Tab_1.TabPage_1.dw_1.GetChild("id_rede", ldwc_rede) = 1 Then
	
	ldwc_rede.SetTransObject(SQLCA)
				 
		
	ldwc_rede.Retrieve('2','S')
	

Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da rede.")
End If

io_produto = create uo_produto
io_filial = create uo_filial

end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge510_monitor_ecommerce
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge510_monitor_ecommerce
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge510_monitor_ecommerce
integer width = 3835
integer height = 2196
end type

event tab_1::selectionchanged;long ll_cd_tipo
long ll_linha
long ll_cd_filial
long ll_linhas
long ll_nr_controle
string ls_dataobject

if newindex <> 2 then return 0

ll_linha = tabpage_1.dw_2.getrow()

if ll_linha > 0 Then
	
	ll_cd_filial = tabpage_1.dw_2.object.cd_filial[ll_linha]
	ll_nr_controle = tabpage_1.dw_2.object.nr_atualizacao[ll_linha]
	
	ll_cd_tipo = tabpage_1.dw_2.object.cd_tipo[ll_linha]
	
	Choose Case ll_cd_tipo
		Case 1
			
			il_cd_marca = tabpage_1.dw_1.object.cd_marca[1]
			
		Case 2
			
			il_cd_marca = tabpage_1.dw_1.object.cd_marca[1]
			il_cd_produto = tabpage_1.dw_1.object.cd_produto[1]
			il_cd_categoria = tabpage_1.dw_1.object.cd_categoria[1]
			
		Case 3
			
			il_cd_produto = tabpage_1.dw_1.object.cd_produto[1]
			
		Case 4
			
			il_cd_produto = tabpage_1.dw_1.object.cd_produto[1]
			
		Case 5
			
			il_cd_produto = tabpage_1.dw_1.object.cd_produto[1]
			
		Case 6
		
			il_cd_produto = tabpage_1.dw_1.object.cd_produto[1]
		
		Case 7, 12
		
			is_nr_pedido = tabpage_1.dw_1.object.nr_pedido[1]
		
		Case 8,26
		
			is_nr_pedido = tabpage_1.dw_1.object.nr_pedido[1]
			il_cd_filial = tabpage_1.dw_1.object.cd_filial[1]
			
		Case 9, 19, 20
		
			is_nr_pedido = tabpage_1.dw_1.object.nr_pedido[1]
			il_cd_filial = tabpage_1.dw_1.object.cd_filial[1]
		
		Case 10, 11, 17
			
			il_cd_produto = tabpage_1.dw_1.object.cd_produto[1]
			il_cd_filial = tabpage_1.dw_1.object.cd_filial[1]
			
		Case 14, 21, 23
			
			il_cd_filial = tabpage_1.dw_1.object.cd_filial[1]
			
		Case 13, 15, 16, 24, 25
			
			is_nr_pedido = tabpage_1.dw_1.object.nr_pedido[1]
			il_cd_filial = tabpage_1.dw_1.object.cd_filial[1]
		
		
		Case else
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Tipo de interface n$$HEX1$$e300$$ENDHEX$$o mapeada.')
			
	End Choose
	
	tabpage_2.uo_detalhe.il_cd_categoria = il_cd_categoria
	tabpage_2.uo_detalhe.il_cd_filial_pedido = il_cd_filial
	tabpage_2.uo_detalhe.il_cd_marca = il_cd_marca
	tabpage_2.uo_detalhe.il_cd_produto = il_cd_produto
	
	tabpage_2.uo_detalhe.of_carrega_detalhes( ll_cd_filial, ll_nr_controle, ll_cd_tipo )
	
end if

return 0


end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3799
integer height = 2080
gb_4 gb_4
dw_4 dw_4
st_1 st_1
end type

on tabpage_1.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.st_1=create st_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.st_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.st_1)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 596
integer width = 3758
integer height = 1212
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3753
integer height = 576
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 59
integer width = 3643
integer height = 500
string dataobject = "dw_ge510_monitor_ecommerce_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then
				This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
				This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
			End If
			
		Case "nm_filial"
			io_Filial.of_Localiza_Filial(This.GetText())
	
			If io_Filial.Localizada Then
				This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial 
				This.Object.Nm_Filial[1] = io_Filial.Nm_Fantasia
			End If	

	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;long ll_nulo
string ls_nulo

setnull(ll_nulo)
setnull(ls_nulo)

Choose Case dwo.name 
		
	Case 'de_produto'
	
	if data = '' or isnull(data) Then
		object.cd_produto[row] = ll_nulo
	end if
	

Case  'de_marca'
	
	if data = '' or isnull(data) Then
		setnull(ll_nulo)
		object.cd_marca[row] = ll_nulo
	end if


Case 'nm_filial'
	
	if data = '' or isnull(data) Then
		setnull(ll_nulo)
		object.cd_filial[row] = ll_nulo
	end if
	
Case 'cd_tipo'
	
	object.cd_produto[row] = ll_nulo
	object.de_produto[row] = ls_nulo
	
	object.cd_marca[row] = ll_nulo
	
	object.cd_filial[row] = ll_nulo
	object.nm_filial[row] = ls_nulo
	
	object.cd_categoria[row] = ll_nulo
	
	object.nr_pedido[row] = ls_nulo
	
	object.id_somente_pedido[row] = 'N'
	
Case 'id_somente_pedido'
	
	object.cd_tipo[row] = 0
	
End Choose
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 50
integer y = 644
integer width = 3717
integer height = 1140
string dataobject = "dw_ge510_monitor_ecommerce_lista"
end type

event dw_2::ue_recuperar;//OverRide
Long ll_Controle		

Long ll_cd_tipo, ll_cd_produto, ll_cd_marca, ll_cd_categoria, ll_cd_filial
String ls_Situacao, ls_rede, ls_nr_pedido, ls_Somente_Pedido, ls_id_ecommerce

DateTime ldh_Inicio,&
			  ldh_Fim

This.of_RestoreOriginalSQL()

dw_1.AcceptText()

ldh_Inicio = dw_1.Object.dh_inicio[1]
ldh_Fim = dw_1.Object.dh_fim[1]
ll_cd_tipo = dw_1.Object.cd_tipo[1]
ls_Situacao	= dw_1.Object.id_situacao[1]
ll_Controle = dw_1.Object.nr_controle[1]
ls_rede = dw_1.Object.id_rede[1]

ll_cd_produto = dw_1.Object.cd_produto[1]
ll_cd_marca = dw_1.Object.cd_marca[1]
ll_cd_categoria = dw_1.Object.cd_categoria[1]
ll_cd_produto = dw_1.Object.cd_produto[1]
ls_nr_pedido = dw_1.Object.nr_pedido[1]
ll_cd_filial = dw_1.Object.cd_filial[1]
ll_cd_filial = dw_1.Object.cd_filial[1]
ls_Somente_Pedido = dw_1.Object.id_somente_pedido[1]
ls_id_ecommerce = dw_1.Object.id_ecommerce[1]

//Choose case ll_cd_tipo
//	Case 1
//		
//		ll_cd_marca = dw_1.Object.cd_marca[1]
//		
//	Case 2
//		
//		ll_cd_produto = dw_1.Object.cd_produto[1]
//		ll_cd_marca = dw_1.Object.cd_marca[1]
//		ll_cd_categoria = dw_1.Object.cd_categoria[1]
//		
//	Case 3, 4, 5, 6, 11
//		ll_cd_produto = dw_1.Object.cd_produto[1]
//		
//	Case 8, 9, 13, 15
//		
//		ls_nr_pedido = dw_1.Object.nr_pedido[1]
//		
//End Choose

If Not IsNull(ldh_Inicio) and Not IsNull(ldh_Fim) Then
	If ldh_Inicio > ldh_Fim Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data final.")
		dw_1.SetColumn("dh_inicio")
		Return 1
	End If
End If

if isnull(ls_id_ecommerce) or ls_id_ecommerce = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma plataforma.")
	dw_1.SetColumn("id_ecommerce")
	Return 1
End If


If Not IsNull(ldh_Inicio) Then
	This.of_AppendWhere("el.dh_inclusao >= '"+String(ldh_Inicio, "yyyymmdd")+"'")
End If

If Not IsNull(ldh_Fim) Then
	This.of_AppendWhere("el.dh_inclusao <= '"+String(ldh_Fim, "yyyymmdd 23:59:59")+"'")
End If

If ls_Somente_Pedido = 'S' Then
	This.of_AppendWhere("el.cd_tipo in (7,8,9,13,15, 16, 25)")
Else
	If Not Isnull(ll_cd_tipo) and ll_cd_tipo > 0 Then
		This.of_AppendWhere("el.cd_tipo = " + String(ll_cd_tipo) )
	End if
End If

If Not Isnull(ls_id_ecommerce) and ls_id_ecommerce <> '' Then
	This.of_AppendWhere("el.id_ecommerce = '" + ls_id_ecommerce + "'")
End If

If Not Isnull(ll_Controle) and ll_Controle > 0 Then
	This.of_AppendWhere("el.nr_atualizacao = "+String(ll_Controle))
End If

If Not Isnull(ls_rede) and ls_rede <> '' and ls_rede <> 'TODOS' Then
	This.of_AppendWhere("el.id_rede_filial = '"+ ls_rede + "'")
End If

If ls_Situacao <> "T" Then
	If ls_Situacao = 'CE' Then //COLOCADO ou ERRO
		This.of_AppendWhere("el.id_situacao in ('C', 'E')")
	Else
		This.of_AppendWhere("el.id_situacao = '"+ls_Situacao+"'")
	End If
End If

If ll_cd_filial > 0 Then
	This.of_AppendWhere("el.cd_filial = " + string(ll_cd_filial) )
end if

If ll_cd_produto > 0 Then
	This.of_AppendWhere("Exists (Select 1 from ecommerce_log_item eli where eli.cd_filial = el.cd_filial and eli.nr_atualizacao = el.nr_atualizacao and eli.cd_produto = " + String(ll_cd_produto) + " )")
end if

If ll_cd_marca > 0 Then
	This.of_AppendWhere("Exists (Select 1 from ecommerce_log_item eli where eli.cd_filial = el.cd_filial and eli.nr_atualizacao = el.nr_atualizacao and eli.cd_marca = " + String(ll_cd_marca) + " )")
end if

If ll_cd_categoria > 0 Then
	This.of_AppendWhere("Exists (Select 1 from ecommerce_log_item eli where eli.cd_filial = el.cd_filial and eli.nr_atualizacao = el.nr_atualizacao and eli.cd_categoria = " + String(ll_cd_categoria) + " )")
end if

If Not Isnull(ls_nr_pedido) and ls_nr_pedido <> '' Then
	This.of_AppendWhere("Exists (Select 1 from ecommerce_log_item eli where eli.cd_filial = el.cd_filial and eli.nr_atualizacao = el.nr_atualizacao and eli.nr_pedido_ecommerce = '" + ls_nr_pedido + "' )")
End If

Return This.Retrieve()
end event

event dw_2::doubleclicked;call super::doubleclicked;String	lvs_Marcacao

Long	ll_Row

If dwo.Name = 'id_imagem' Then
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For ll_Row = 1 To This.RowCount()
				
		If lvs_Marcacao = 'S' Then
			If This.Object.id_situacao[ll_Row] = 'C' or This.Object.id_situacao[ll_Row] = 'E'  Then
				This.Object.id_processa[ll_Row] = lvs_Marcacao
			End If
		Else
			This.Object.id_processa[ll_Row] = lvs_Marcacao
		End If
	
	Next
	
End If		
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If currentRow > 0 and rowcount() > 0 Then
	Tab_1.TabPage_1.dw_4.Object.de_erro[1] = This.Object.de_mensagem[currentRow]
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;//If pl_Linhas > 0 then
//	cb_cancelamento.Enabled = True
//Else
//	cb_cancelamento.Enabled = False
//End If
//
Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

event dw_2::clicked;call super::clicked;If row > 0 Then
	Tab_1.TabPage_1.dw_4.Object.de_erro[1] = This.Object.de_mensagem[Row]
End If
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3799
integer height = 2080
uo_detalhe uo_detalhe
end type

on tabpage_2.create
this.uo_detalhe=create uo_detalhe
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_detalhe
end on

on tabpage_2.destroy
call super::destroy
destroy(this.uo_detalhe)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 0
integer y = 0
integer width = 3790
integer height = 2076
string text = ""
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
boolean visible = false
integer x = 41
integer y = 172
integer width = 3671
integer height = 1724
string dataobject = "dw_ge510_ecommerce_log_item_1"
boolean vscrollbar = true
end type

event dw_3::ue_retrieve;//OverRide

//Long	ll_Controle
//
//ll_Controle	= Tab_1.TabPage_1.dw_2.Object.nr_controle	[Tab_1.TabPage_1.dw_2.GetRow()]
//
//Return This.Retrieve(ll_Controle)

return 0
end event

event dw_3::constructor;call super::constructor;// Habilitar a linha de sele$$HEX2$$e700e300$$ENDHEX$$o (list)
This.of_SetRowSelection()

end event

event dw_3::buttonclicked;call super::buttonclicked;string ls_json

if dwo.name = 'b_1' Then
	
	ls_json = dw_3.object.de_json[dw_3.getrow()]
	
	OpenWithparm( w_ge510_json , ls_json)
end if
end event

type gb_4 from groupbox within tabpage_1
integer x = 23
integer y = 1812
integer width = 3758
integer height = 260
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Erro"
end type

type dw_4 from dc_uo_dw_base within tabpage_1
integer x = 59
integer y = 1880
integer width = 3685
integer height = 156
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge510_monitor_ecommerce_erro"
boolean hscrollbar = true
end type

type st_1 from statictext within tabpage_1
integer x = 2834
integer y = 376
integer width = 859
integer height = 152
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "OBS: S$$HEX1$$e300$$ENDHEX$$o armazenados apenas os registros dos $$HEX1$$fa00$$ENDHEX$$ltimos 30 dias."
boolean focusrectangle = false
end type

type uo_detalhe from uo_ge510_detalhes within tabpage_2
event destroy ( )
integer x = 23
integer y = 40
integer width = 3753
integer height = 2032
integer taborder = 40
boolean bringtotop = true
end type

on uo_detalhe.destroy
call uo_ge510_detalhes::destroy
end on

