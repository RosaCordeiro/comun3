HA$PBExportHeader$uo_ge510_detalhes.sru
forward
global type uo_ge510_detalhes from userobject
end type
type cb_1 from commandbutton within uo_ge510_detalhes
end type
type cbx_filtro from checkbox within uo_ge510_detalhes
end type
type cbx_erro from checkbox within uo_ge510_detalhes
end type
type dw_1 from dc_uo_dw_base within uo_ge510_detalhes
end type
end forward

global type uo_ge510_detalhes from userobject
integer width = 3749
integer height = 2036
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_1 cb_1
cbx_filtro cbx_filtro
cbx_erro cbx_erro
dw_1 dw_1
end type
global uo_ge510_detalhes uo_ge510_detalhes

type variables
long il_cd_marca
long il_cd_produto
long il_cd_categoria
long il_cd_filial_pedido

string is_nr_pedido
boolean ib_exibe_erros = true
boolean ib_exibe_filtros = true
boolean ib_marca_erros = false
end variables

forward prototypes
public function boolean of_carrega_detalhes (long pl_cd_filial, long pl_nr_atualizacao, long pl_cd_tipo)
public subroutine of_limpa_variaveis ()
end prototypes

public function boolean of_carrega_detalhes (long pl_cd_filial, long pl_nr_atualizacao, long pl_cd_tipo);
string ls_dataobject
string ls_mensagem

	//wf_limpa_variaveis()	
	
Choose Case pl_cd_tipo
	Case 1
		ls_dataobject = 'dw_ge510_ecommerce_log_item_1'
		
	Case 2
		ls_dataobject = 'dw_ge510_ecommerce_log_item_2'
		
	Case 3
		ls_dataobject = 'dw_ge510_ecommerce_log_item_3'
		
	Case 4
		ls_dataobject = 'dw_ge510_ecommerce_log_item_4'
		
	Case 5
		ls_dataobject = 'dw_ge510_ecommerce_log_item_5'
		
	Case 6
		ls_dataobject = 'dw_ge510_ecommerce_log_item_6'
	
	Case 7, 12
		ls_dataobject = 'dw_ge510_ecommerce_log_item_7'
	
	Case 8,26
		ls_dataobject = 'dw_ge510_ecommerce_log_item_8'
		
	Case 9, 19, 20
		ls_dataobject = 'dw_ge510_ecommerce_log_item_9'
	
	Case 10, 11, 17
		ls_dataobject = 'dw_ge510_ecommerce_log_item_10'
		
	Case 14, 23
		ls_dataobject = 'dw_ge510_ecommerce_log_item_11'
		
	Case 13, 15, 16, 24, 25
		ls_dataobject = 'dw_ge510_ecommerce_log_item_12'
	
	Case 21
		ls_dataobject = 'dw_ge510_ecommerce_log_item_13'
	
	Case else
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Tipo de interface n$$HEX1$$e300$$ENDHEX$$o mapeada.')
		
End Choose

if dw_1.dataobject <> ls_dataobject then
	dw_1.of_changedataobject( ls_dataobject )
end if
	
dw_1.setfilter('')
dw_1.filter()

// Habilitar a linha de sele$$HEX2$$e700e300$$ENDHEX$$o (list)
dw_1.of_SetRowSelection()

dw_1.retrieve(pl_cd_filial, pl_nr_atualizacao)

if ib_marca_erros Then
	dw_1.setfilter("id_situacao = 'E'")
	dw_1.filter()
	cbx_erro.checked = True
	ib_exibe_erros = True

	if dw_1.rowcount() = 0 then
		
		select de_mensagem
		into :ls_mensagem
		from ecommerce_log
		where cd_filial = :pl_cd_filial
		and nr_atualizacao = :pl_nr_atualizacao;
		
		if ls_mensagem <> '' and not isnull(ls_mensagem) then
			
			dw_1.insertrow(1)
			dw_1.object.de_retorno_usuario[1] = ls_mensagem
			
		ENd if
		
	End if
	
end if

cbx_erro.visible = ib_exibe_erros

cbx_filtro.visible = ib_exibe_filtros

return true


end function

public subroutine of_limpa_variaveis ();setnull(il_cd_marca)
setnull(il_cd_produto)
setnull(il_cd_categoria)
setnull(il_cd_filial_pedido)
setnull(is_nr_pedido)
end subroutine

on uo_ge510_detalhes.create
this.cb_1=create cb_1
this.cbx_filtro=create cbx_filtro
this.cbx_erro=create cbx_erro
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cbx_filtro,&
this.cbx_erro,&
this.dw_1}
end on

on uo_ge510_detalhes.destroy
destroy(this.cb_1)
destroy(this.cbx_filtro)
destroy(this.cbx_erro)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within uo_ge510_detalhes
integer x = 73
integer y = 1920
integer width = 448
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exportar"
end type

event clicked;dw_1.saveas()
end event

type cbx_filtro from checkbox within uo_ge510_detalhes
integer x = 1207
integer y = 52
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aplicar filtros:"
boolean lefttext = true
end type

event clicked;string ls_filtro

if checked Then
	
	ls_filtro = ''
	
	if il_cd_filial_pedido > 0 Then
		ls_filtro = 'cd_filial = ' + string(il_cd_filial_pedido)
	end if
	
	if il_cd_produto > 0 Then
		
		if ls_filtro <> '' Then ls_filtro += ' and '
		
		ls_filtro = 'cd_produto = ' + string(il_cd_produto)
	end if
	
	if il_cd_marca > 0 Then
		
		if ls_filtro <> '' Then ls_filtro += ' and '
		
		ls_filtro = 'cd_marca = ' + string(il_cd_marca)
	end if
	
	if il_cd_categoria > 0 Then
		
		if ls_filtro <> '' Then ls_filtro += ' and '
		
		ls_filtro = 'cd_categoria = ' + string(il_cd_categoria)
	end if
	
	if is_nr_pedido <> '' and not isnull(is_nr_pedido) Then
		
		if ls_filtro <> '' Then ls_filtro += ' and '
		
		ls_filtro = 'nr_pedido_ecommerce = "' + is_nr_pedido + '"'
	end if
	
	if ls_filtro <> '' Then
		dw_1.setfilter(ls_filtro)
	end if
Else
	dw_1.setfilter('')
end if

dw_1.filter()
end event

type cbx_erro from checkbox within uo_ge510_detalhes
integer x = 32
integer y = 52
integer width = 960
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Exibir apenas registros com erro:"
boolean lefttext = true
end type

event clicked;if checked Then
	dw_1.setfilter("id_situacao = 'E'")
Else
	dw_1.setfilter('')
end if

dw_1.filter()
end event

type dw_1 from dc_uo_dw_base within uo_ge510_detalhes
integer x = 32
integer y = 180
integer width = 3671
integer height = 1724
string dataobject = "dw_ge510_ecommerce_log_item_1"
boolean vscrollbar = true
end type

event buttonclicked;call super::buttonclicked;string ls_json

if dwo.name = 'b_1' Then
	
	ls_json = dw_1.object.de_json[dw_1.getrow()]
	
	OpenWithparm( w_ge510_json , ls_json)
end if
end event

