HA$PBExportHeader$w_ge660_conciliacao_marketplace_seller.srw
forward
global type w_ge660_conciliacao_marketplace_seller from dc_w_2tab_consulta_selecao_lista_det
end type
end forward

global type w_ge660_conciliacao_marketplace_seller from dc_w_2tab_consulta_selecao_lista_det
integer width = 4009
integer height = 2284
string title = "GE660 - Concilia$$HEX2$$e700e300$$ENDHEX$$o Marketplace - Seller"
long ivl_altura_2 = 2144
long ivl_largura_2 = 4978
end type
global w_ge660_conciliacao_marketplace_seller w_ge660_conciliacao_marketplace_seller

type variables
uo_fornecedor ivo_fornecedor
end variables

on w_ge660_conciliacao_marketplace_seller.create
call super::create
end on

on w_ge660_conciliacao_marketplace_seller.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;datetime ldh_atual

ldh_atual = gf_getserverdate()

tab_1.tabpage_1.dw_1.setitem(1,'dh_inicio', date(ldh_atual))
tab_1.tabpage_1.dw_1.setitem(1,'dh_fim', date(ldh_atual))

ivo_fornecedor = create uo_fornecedor 

end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge660_conciliacao_marketplace_seller
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge660_conciliacao_marketplace_seller
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge660_conciliacao_marketplace_seller
integer x = 9
integer width = 3945
integer height = 2064
end type

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3909
integer height = 1948
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 356
integer width = 3881
integer height = 1772
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3877
integer height = 324
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer y = 108
integer width = 3799
integer height = 196
string dataobject = "dw_ge660_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
					
			End If
	End Choose			
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
End Choose
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 428
integer width = 3822
integer height = 1680
string dataobject = "dw_ge660_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;date ldh_ini, ldh_fim
string ls_Cd_fornecedor
string ls_id_situacao
string ls_id_rede_ecommerce
string ls_nr_cpf_cnpj
string ls_nr_pedido

dw_1.accepttext()

ls_Cd_fornecedor = dw_1.getitemstring(1, 'cd_fornecedor')
ls_id_situacao = dw_1.getitemstring(1, 'id_situacao')
ls_id_rede_ecommerce = dw_1.getitemstring(1, 'id_rede_ecommerce')
ls_nr_cpf_cnpj = dw_1.getitemstring(1, 'nr_cpf_cnpj')
ls_nr_pedido = dw_1.getitemstring(1, 'nr_pedido')

ldh_ini = dw_1.getitemdate(1,'dh_inicio')
ldh_fim = dw_1.getitemdate(1,'dh_fim')

if isnull(ldh_ini) or ldh_ini = date('01/01/1900') Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a data inicial.')
	this.setcolumn('dh_inicio')
	this.setfocus()
	return -1
ENd if

if isnull(ldh_fim) or ldh_fim = date('01/01/1900') Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a data final.')
	this.setcolumn('dh_fim')
	this.setfocus()
	return -1
ENd if

if ldh_ini > ldh_fim Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A data final deve ser superior a data inicial.')
	this.setcolumn('dh_fim')
	this.setfocus()
	return -1
ENd if

if ls_cd_fornecedor <> '' and not isnull(ls_cd_fornecedor) Then
	this.of_appendwhere("f.cd_fornecedor = '" + ls_cd_fornecedor + "'")
ENd if

if ls_id_situacao <> 'T' Then
	this.of_appendwhere("pe.id_situacao = '" + ls_id_situacao + "'")
ENd if

if ls_id_rede_ecommerce <> 'TO' Then
	this.of_appendwhere("pa.id_rede_ecommerce = '" + ls_id_rede_ecommerce + "'")
ENd if

if ls_nr_cpf_cnpj <> '' and not isnull(ls_nr_cpf_cnpj) Then
	this.of_appendwhere("pe.nr_cpf_cgc = '" + ls_nr_cpf_cnpj + "'")
ENd if

if ls_nr_pedido <> '' and not isnull(ls_nr_pedido) Then
	if isNumber(ls_nr_pedido) = True Then 
		this.of_appendwhere("pe.nr_pedido = " + ls_nr_pedido )
	Else
		this.of_appendwhere("pe.nr_pedido_ecommerce = '" + ls_nr_pedido + "'")
	ENd if
ENd if
return 1
end event

event dw_2::ue_recuperar;datetime ldh_ini, ldh_fim

ldh_ini = Datetime(dw_1.getitemdate(1,'dh_inicio'), time('00:00'))
ldh_fim = Datetime(dw_1.getitemdate(1,'dh_fim'), time('23:59:59'))

return this.retrieve(ldh_ini, ldh_fim)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_salvarcomo( pl_linhas > 0 )

return pl_linhas
end event

event dw_2::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_salvarcomo( rowcount() > 0)
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3909
integer height = 1948
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer y = 20
integer width = 4873
integer height = 1996
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer y = 100
integer width = 4777
integer height = 1888
string dataobject = "dw_ge660_detalhes"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::ue_preretrieve;call super::ue_preretrieve;string ls_id_situacao
string ls_id_rede_ecommerce
string ls_nr_cpf_cnpj
string ls_nr_pedido

ls_id_situacao = Tab_1.TabPage_1.dw_1.getitemstring(1, 'id_situacao')
ls_id_rede_ecommerce = Tab_1.TabPage_1.dw_1.getitemstring(1, 'id_rede_ecommerce')
ls_nr_cpf_cnpj = Tab_1.TabPage_1.dw_1.getitemstring(1, 'nr_cpf_cnpj')
ls_nr_pedido = Tab_1.TabPage_1.dw_1.getitemstring(1, 'nr_pedido')

if ls_id_situacao <> 'T' Then
	this.of_appendwhere("pe.id_situacao = '" + ls_id_situacao + "'")
ENd if

if ls_id_rede_ecommerce <> 'TO' Then
	this.of_appendwhere("pa.id_rede_ecommerce = '" + ls_id_rede_ecommerce + "'")
ENd if

if ls_nr_cpf_cnpj <> '' and not isnull(ls_nr_cpf_cnpj) Then
	this.of_appendwhere("pe.nr_cpf_cgc = '" + ls_nr_cpf_cnpj + "'")
ENd if

if ls_nr_pedido <> '' and not isnull(ls_nr_pedido) Then
	if isNumber(ls_nr_pedido) = True Then 
		this.of_appendwhere("pe.nr_pedido = " + ls_nr_pedido )
	Else
		this.of_appendwhere("pe.nr_pedido_ecommerce = '" + ls_nr_pedido + "'")
	ENd if
ENd if

Return 1
end event

event dw_3::ue_recuperar;datetime ldh_ini, ldh_fim
string ls_cd_fornecedor
long ll_linha, ll_erro

ll_linha = Tab_1.TabPage_1.dw_2.GetRow()

ldh_ini = Datetime(Tab_1.TabPage_1.dw_1.getitemdate(1,'dh_inicio'), time('00:00'))
ldh_fim = Datetime(Tab_1.TabPage_1.dw_1.getitemdate(1,'dh_fim'), time('23:59:59'))

ls_cd_fornecedor = tab_1.tabpage_1.dw_2.getitemstring(ll_linha, 'cd_fornecedor')

ll_erro = this.retrieve(ldh_ini, ldh_fim, ls_cd_fornecedor)

return ll_erro
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;This.ivo_Controle_Menu.of_salvarcomo( pl_linhas > 0 )

return pl_linhas
end event

