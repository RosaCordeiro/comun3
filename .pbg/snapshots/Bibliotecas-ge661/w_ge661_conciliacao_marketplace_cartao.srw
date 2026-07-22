HA$PBExportHeader$w_ge661_conciliacao_marketplace_cartao.srw
forward
global type w_ge661_conciliacao_marketplace_cartao from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge661_conciliacao_marketplace_cartao from dc_w_selecao_lista_dinamica_relatorio
integer width = 3977
integer height = 1892
string title = "GE661 - Concilia$$HEX2$$e700e300$$ENDHEX$$o Marketplace - Cart$$HEX1$$e300$$ENDHEX$$o"
end type
global w_ge661_conciliacao_marketplace_cartao w_ge661_conciliacao_marketplace_cartao

type variables
uo_fornecedor ivo_fornecedor
end variables

forward prototypes
public function string wf_get_sql_consulta (long pl_consulta, string ps_sql)
end prototypes

public function string wf_get_sql_consulta (long pl_consulta, string ps_sql);String lvs_SQL
String lvs_Having

Long lvl_Linha

lvs_SQL = ps_SQL

dw_campos.SetFilter("id_visivel='S'")
dw_campos.Filter()
dw_campos.SetSort("nr_seq D")
dw_campos.Sort()

lvs_SQL = Lower(lvs_SQL+' ')

lvs_SQL = gf_replace(lvs_SQL, lower('VL_ANTIFRAUDE_PAGAMENTO_TUNA'), 'VL_ANTIFRAUDE_PAGAMENTO_TUNA',0)
lvs_SQL = gf_replace(lvs_SQL, lower('VL_SPLIT_PAGAMENTO_TUNA'), 'VL_SPLIT_PAGAMENTO_TUNA',0)

For lvl_Linha = 1 to dw_campos.RowCount()
	lvs_SQL = dw_campos.Object.de_sqlcampo	[lvl_Linha] + IIF(lvl_Linha = 1, ' ', ', ') + '~r~n'+ lvs_SQL
Next

lvs_SQL = 'select '+lvs_SQL

If wf_retorna_pos_fim_campo(Upper(lvs_SQL), "WHERE") = 0 Then lvs_SQL += 'Where 1=2 '

If wf_retorna_pos_fim_campo(lvs_SQL,'group by ') > 0 Then
	lvs_SQL = Mid(lvs_SQL,1,wf_retorna_pos_fim_campo(lvs_SQL,'group by ')-1)
End If

dw_campos.SetFilter("id_agregacao='S' AND id_visivel='S'")
dw_campos.Filter()

lvl_Linha = dw_campos.RowCount()
If lvl_Linha > 0 then
	dw_campos.SetFilter("id_agregacao='N' AND id_visivel='S'")
	dw_campos.Filter()
	dw_campos.SetSort("nr_seq A")
	dw_campos.Sort()
	
	For lvl_Linha = 1 to dw_campos.RowCount()
		If lvl_Linha = 1 then lvs_SQL += 'group by '
		lvs_SQL += Mid(dw_campos.Object.de_sqlcampo	[lvl_Linha],1,wf_last_pos(lower(dw_campos.Object.de_sqlcampo[lvl_Linha]),' as '))
		If lvl_Linha <> dw_campos.RowCount() then lvs_SQL += ', ~r~n'
	Next
Else
	lvs_SQL = Mid(lvs_SQL, 1, 6)+" distinct"+Mid(lvs_SQL, 7)
End If

//lvs_SQL += ' order by 1'

dw_campos.SetSort("nr_seq A")
dw_campos.Sort()
dw_campos.SetFilter("")
dw_campos.Filter()

Return lvs_SQL
end function

on w_ge661_conciliacao_marketplace_cartao.create
call super::create
end on

on w_ge661_conciliacao_marketplace_cartao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_fornecedor = create uo_fornecedor

//Dimensionamento de tela
MaxWidth = 4745
MaxHeight = 1900

//SQL Base para formar o grid
ivs_SQLBase = 	"from pedido_ecommerce pe " + &
					"inner join pedido_ecommerce_auxiliar pa on pa.cd_filial_ecommerce = pe.cd_filial_ecommerce and pa.nr_pedido = pe.nr_pedido " + &
					"inner join fornecedor f on f.cd_fornecedor = pa.cd_fornecedor_entrega " + &
					"inner join tipo_pagamento_ecommerce tp on tp.nm_administradora_cartao = pa.nm_administradora_cartao " + &
					"inner join pedido_ecommerce_produto pp on pp.cd_filial_ecommerce = pe.cd_filial_ecommerce and pp.nr_pedido = pe.nr_pedido " + &
					"inner join dbo.cartao_produto cp on cp.nm_produto = tp.nm_administradora_cartao " + &
					"Left join (select 'o' as id_situacao, 1 as vl_fator Union All select 'o' , -1 Union All select 'x' as id_situacao, 1 as vl_fator Union All select 'x' , -1) dev on lower(pe.id_situacao) = dev.id_situacao " + &
					"Left join pedido_ecommerce_movimentacao pdev on pdev.nr_pedido = pe.nr_pedido and pdev.id_movimentacao = 53"

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 33
end event

event ue_postopen;call super::ue_postopen;datetime ldh_atual

ldh_atual = gf_getserverdate()

dw_1.setitem(1,'dh_inicio', date(ldh_atual))
dw_1.setitem(1,'dh_fim', date(ldh_atual))
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge661_conciliacao_marketplace_cartao
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge661_conciliacao_marketplace_cartao
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge661_conciliacao_marketplace_cartao
integer width = 3872
integer height = 1292
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge661_conciliacao_marketplace_cartao
integer width = 3867
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge661_conciliacao_marketplace_cartao
integer width = 3790
string dataobject = "dw_ge661_selecao"
end type

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

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge661_conciliacao_marketplace_cartao
integer width = 3817
integer height = 1196
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;date ldh_ini, ldh_fim
string ls_Cd_fornecedor
string ls_id_situacao
string ls_id_rede_ecommerce
string ls_nr_pedido
string ls_cd_tipo_pagamento
string ls_nr_nsu
string ls_nr_pedido_plataforma

string ls_sql

dw_1.accepttext()

ls_Cd_fornecedor = dw_1.getitemstring(1, 'cd_fornecedor')
ls_id_situacao = dw_1.getitemstring(1, 'id_situacao')
ls_id_rede_ecommerce = dw_1.getitemstring(1, 'id_rede_ecommerce')
ls_nr_pedido = dw_1.getitemstring(1, 'nr_pedido')
ls_cd_tipo_pagamento = dw_1.getitemstring(1, 'cd_tipo_Pagamento')
ls_nr_nsu = dw_1.getitemstring(1, 'nr_nsu')
ls_nr_pedido_plataforma = dw_1.getitemstring(1, 'nr_pedido_plataforma')

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

this.of_appendwhere("pa.id_tipo_pedido in ('PRP','DRC','FRM')")

This.Of_AppendWhere("pe.dh_compra >='"+String(ldh_ini,'YYYY/MM/DD')+"'")
This.Of_AppendWhere("pe.dh_compra <='"+String(ldh_fim,'YYYY/MM/DD')+" 23:59:59'")

if ls_cd_fornecedor <> '' and not isnull(ls_cd_fornecedor) Then
	this.of_appendwhere("f.cd_fornecedor = '" + ls_cd_fornecedor + "'")
ENd if

if ls_id_situacao <> 'T' Then
	this.of_appendwhere("pe.id_situacao = '" + ls_id_situacao + "'")
ENd if

if ls_id_rede_ecommerce <> 'TO' Then
	this.of_appendwhere("pa.id_rede_ecommerce = '" + ls_id_rede_ecommerce + "'")
ENd if

If ls_cd_tipo_pagamento <> 'TODOS' Then
	this.of_appendwhere("tp.cd_pagamento = '" + ls_cd_tipo_pagamento + "'" )
End if

If ls_nr_nsu <> '' and not isnull(ls_nr_nsu) Then
	this.of_appendwhere("pa.nr_nsu_host = '" + ls_nr_nsu + "'" )
End if

if ls_nr_pedido_plataforma <> '' and not isnull(ls_nr_pedido_plataforma) Then
	this.of_appendwhere("pa.nr_pedido_plataforma = '" + ls_nr_pedido_plataforma + "'" )
ENd if

if ls_nr_pedido <> '' and not isnull(ls_nr_pedido) Then
	if isNumber(ls_nr_pedido) = True Then 
		this.of_appendwhere("pe.nr_pedido = " + ls_nr_pedido )
	Else
		this.of_appendwhere("pe.nr_pedido_ecommerce = '" + ls_nr_pedido + "'")
	ENd if
ENd if

ls_sql = this.getsqlselect( )

return 1
end event

event dw_2::ue_reset;call super::ue_reset;string ls_color, ls_coluna
long ll_for, ll_linhas


//if (id_situacao = 'ESTORNO', rgb(255,0,0), if(getrow()=currentRow(),rgb(255,255,255),rgb(0,0,0)))

ls_color = '0~tif (vl_total < 0, rgb(255,0,0),if(getrow()=currentRow(),rgb(255,255,255),rgb(0,0,0)))'

this.setredraw( false )

ll_linhas = long(this.Object.DataWindow.Column.Count)

for ll_for = 1 to ll_linhas
	
	ls_coluna = this.Describe("#" + string(ll_for) + ".Name")
	this.modify(ls_coluna + ".color= '" + ls_color + "'")
	
Next

this.setredraw( True )
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge661_conciliacao_marketplace_cartao
integer x = 2007
integer y = 572
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge661_conciliacao_marketplace_cartao
integer x = 2158
integer y = 944
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge661_conciliacao_marketplace_cartao
end type

