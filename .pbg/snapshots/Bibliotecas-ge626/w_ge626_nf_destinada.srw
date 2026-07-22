HA$PBExportHeader$w_ge626_nf_destinada.srw
forward
global type w_ge626_nf_destinada from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge626_nf_destinada from dc_w_selecao_lista_relatorio
integer width = 6002
integer height = 2396
string title = "GE626 - NF-e Destinadas - Malha Fiscal"
end type
global w_ge626_nf_destinada w_ge626_nf_destinada

type variables
uo_fornecedor		ivo_fornecedor
uo_filial				ivo_filial

end variables

on w_ge626_nf_destinada.create
call super::create
end on

on w_ge626_nf_destinada.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_fornecedor 	= Create uo_fornecedor		
ivo_filial			= Create uo_filial	
end event

event ue_postopen;call super::ue_postopen;datetime ldh_atual

DataWindowChild	ldwc_Child

ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			
ldwc_Child.SetItem(1, "cd_unidade_federacao", ""	)
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODOS")

dw_1.setitem(1,'cd_uf','')

ldh_atual = gf_getserverdate()

dw_1.setitem(1,'dh_emissao_inicio', date(ldh_atual))
dw_1.setitem(1,'dh_emissao_fim', date(ldh_atual))
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge626_nf_destinada
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge626_nf_destinada
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge626_nf_destinada
integer y = 500
integer width = 5906
integer height = 1688
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge626_nf_destinada
integer width = 5454
integer height = 456
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge626_nf_destinada
integer width = 5390
integer height = 360
string dataobject = "dw_ge626_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.de_fornecedor	[1] = ivo_Fornecedor.Nm_Razao_Social
				This.Object.cd_fornecedor	[1] = ivo_Fornecedor.Cd_Fornecedor	
				This.Object.nr_cgc_fornecedor[1] = ivo_Fornecedor.nr_cgc
			End If
			
		Case "de_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.de_filial			[1] = ivo_Filial.Nm_Fantasia
				This.Object.cd_filial			[1] = ivo_Filial.Cd_Filial
			End If	
	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;string ls_nulo

setnull(ls_nulo)

Choose Case dwo.Name
	Case "de_filial"	
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.cd_filial	[1] = ivo_Filial.Cd_Filial
			This.Object.de_filial	[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "de_fornecedor"		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.cd_fornecedor	[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.de_fornecedor	[1] = ivo_Fornecedor.Nm_Razao_Social
			This.Object.nr_cgc_fornecedor[1] = ls_nulo
		End If
			
End Choose

end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge626_nf_destinada
integer y = 584
integer width = 5851
integer height = 1564
string dataobject = "dw_ge626_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;Datetime ldh_emissao_inicio
Datetime ldh_emissao_fim
Datetime ldh_manif_inicio
Datetime ldh_manif_fim

Long ll_Cd_filial

String ls_cgc_fornecedor
String ls_id_situacao
String ls_id_situacao_clamed
String ls_de_chave_acesso
String ls_exibir_erro
String ls_id_considerar_pendente
String ls_cd_uf

dw_1.accepttext( )

ldh_emissao_inicio = Datetime( dw_1.getitemdate(1, 'dh_emissao_inicio'), time('00:00:00') )
ldh_emissao_fim = Datetime( dw_1.getitemdate(1, 'dh_emissao_fim'), time('23:59:59') )

ldh_manif_inicio = Datetime( dw_1.getitemdate(1, 'dh_manif_inicio'), time('00:00:00') )
ldh_manif_fim = Datetime( dw_1.getitemdate(1, 'dh_manif_fim'), time('23:59:59') )

ll_cd_filial = dw_1.getitemnumber( 1, 'cd_filial')
ls_cgc_fornecedor = dw_1.getitemstring( 1, 'nr_cgc_fornecedor')
ls_id_situacao = dw_1.getitemstring( 1, 'id_situacao_nf')
ls_id_situacao_clamed = dw_1.getitemstring( 1, 'id_situacao_clamed')
ls_de_chave_acesso = dw_1.getitemstring( 1, 'de_chave_acesso')
ls_exibir_erro = dw_1.getitemstring( 1, 'id_exibir_erro')
ls_id_considerar_pendente = dw_1.getitemstring( 1, 'id_considerar_pend_atual_estoque')
ls_cd_uf = dw_1.getitemstring( 1, 'cd_uf')

this.setfilter("")

if isnull( ldh_emissao_inicio ) or date( ldh_emissao_inicio ) = date( '01/01/1900' ) Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A data de emiss$$HEX1$$e300$$ENDHEX$$o deve ser preenchida. ')
	return -1 
ENd if

if isnull( ldh_emissao_fim ) or date( ldh_emissao_fim ) = date( '01/01/1900' ) Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A data de emiss$$HEX1$$e300$$ENDHEX$$o deve ser preenchida. ')
	return -1 
ENd if

if ldh_emissao_inicio > ldh_emissao_fim then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A data de emiss$$HEX1$$e300$$ENDHEX$$o informada $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida. ')
	return -1 
ENd if

if not isnull(ldh_manif_inicio) and date(ldh_manif_inicio) <> date('01/01/1900') and ( isnull(ldh_manif_fim) or date(ldh_manif_fim) = date('01/01/1900') )Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A data de manifesta$$HEX2$$e700e300$$ENDHEX$$o deve ser informada.')
	return -1 
ENd if

if not isnull(ldh_manif_fim) and date(ldh_manif_fim) <> date('01/01/1900') and ( isnull(ldh_manif_inicio) or date(ldh_manif_inicio) = date('01/01/1900') )Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A data de manifesta$$HEX2$$e700e300$$ENDHEX$$o deve ser informada.')
	return -1 
ENd if

if ldh_manif_inicio > ldh_manif_fim then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A data de manifesta$$HEX2$$e700e300$$ENDHEX$$o informada $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida. ')
	return -1 
ENd if

if not isnull(ldh_manif_inicio) and date(ldh_manif_inicio) <> date('01/01/1900') Then
	this.of_appendwhere_subquery( "nd.dh_envio_manifestacao BETWEEN convert(datetime, '" + String(ldh_manif_inicio,'yyyymmdd hh:mm') + "') and convert(datetime, '" + string(ldh_manif_fim,'yyyymmdd hh:mm') + "')" , 2)
End if

if ls_de_chave_acesso <> '' and not isnull(ls_de_chave_acesso) Then
	this.of_appendwhere_subquery( "nd.de_chave_acesso = '" + ls_de_chave_acesso + "'", 2)
End if

if ll_cd_filial > 0 then
	this.of_appendwhere_subquery('f.cd_filial = ' + string(ll_cd_filial) , 2)
ENd if

if ls_cd_uf <> '' and not isnull(ls_cd_uf) Then
	this.of_appendwhere_subquery("c.cd_unidade_federacao = '" + ls_cd_uf + "'", 2)
ENd if

if ls_cgc_fornecedor <> '' and not isnull(ls_cgc_fornecedor) then
	this.of_appendwhere_subquery("nd.nr_cgc_origem = '" + ls_cgc_fornecedor + "'", 2)
ENd if

if ls_id_situacao <> 'T' Then
	this.of_appendwhere_subquery( "nd.id_situacao_nf = '" + ls_id_situacao + "'", 2)
End if

if ls_id_situacao_clamed <> 'T' Then
	this.of_appendwhere_subquery( "id_status_clamed = '" + ls_id_situacao_clamed + "'", 5)
End if

if ls_id_considerar_pendente = 'N' Then
	this.of_appendwhere_subquery( "id_status_clamed <> '2'", 5)
End if

if ls_exibir_erro = 'S' Then
	this.setfilter("id_situacao_destinada= '1'")
End if


string ls_sql

ls_sql = this.getsqlselect( )

return this.retrieve( ldh_emissao_inicio, ldh_emissao_fim )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_menu.mf_SalvarComo(pl_linhas > 0)

return pl_linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge626_nf_destinada
integer x = 1998
integer y = 1384
end type

