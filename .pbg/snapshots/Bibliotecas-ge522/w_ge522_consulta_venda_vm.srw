HA$PBExportHeader$w_ge522_consulta_venda_vm.srw
forward
global type w_ge522_consulta_venda_vm from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge522_consulta_venda_vm from dc_w_selecao_lista_relatorio
integer width = 2455
integer height = 1576
string title = "GE522 - Vendas VM"
boolean center = true
end type
global w_ge522_consulta_venda_vm w_ge522_consulta_venda_vm

type variables
uo_filial iuo_filial
uo_produto iuo_produto
end variables

on w_ge522_consulta_venda_vm.create
call super::create
end on

on w_ge522_consulta_venda_vm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;long ll_cd_produto
date ldt_atual

iuo_filial = create uo_filial
iuo_produto = create uo_produto

dw_2.ivo_Controle_Menu.of_SalvarComo(True)

ll_cd_produto = message.doubleparm

if ll_cd_produto > 0 then
	iuo_produto.of_localiza_produto( string(ll_cd_produto))
	
	if iuo_produto.localizado Then
		dw_1.object.cd_produto[1] = iuo_produto.cd_produto
		dw_1.object.de_produto[1] = iuo_produto.de_produto + ': ' + iuo_produto.de_apresentacao_venda
	end if
	
	dw_2.post Event Ue_recuperar()
	
end if

ldt_atual = date(gf_getserverdate())

dw_1.object.dh_inicio[1] = relativedate( ldt_atual, -7 )
dw_1.object.dh_fim[1] = ldt_atual
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge522_consulta_venda_vm
integer x = 210
integer y = 1632
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge522_consulta_venda_vm
integer x = 174
integer y = 1560
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge522_consulta_venda_vm
integer width = 2345
integer height = 960
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge522_consulta_venda_vm
integer width = 2345
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge522_consulta_venda_vm
integer x = 59
integer width = 2281
integer height = 272
string dataobject = "dw_ge522_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> iuo_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			iuo_Filial.Of_Inicializa()
			
			This.Object.cd_filial		 	[1] = iuo_Filial.cd_Filial
			This.Object.nm_filial		[1] = iuo_Filial.Nm_Fantasia
		End If
		
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "nm_filial"
			iuo_Filial.of_Localiza_Filial(This.GetText())
			
			If iuo_Filial.Localizada Then
				This.Object.nm_filial		[1] = iuo_Filial.Nm_Fantasia
				This.Object.cd_Filial			[1] = iuo_Filial.Cd_Filial
				
			End If
				
	End Choose
	
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge522_consulta_venda_vm
integer width = 2240
integer height = 856
string dataobject = "dw_ge522_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;long ll_cd_filial
long ll_cd_produto
string ls_id_ecommerce
DateTime ldh_inicio, ldh_fim

ll_cd_filial = dw_1.object.cd_filial[1]
ll_cd_produto = dw_1.object.cd_produto[1]
ldh_inicio = Datetime( dw_1.object.dh_inicio[1], time('00:00') )
ldh_fim = Datetime( dw_1.object.dh_fim[1], time('23:59:59') )

ls_id_ecommerce = '4' //DC-BOX [VMPAY]

if ll_cd_filial > 0 Then
	this.of_appendwhere( 'pe.cd_filial = ' + string(ll_cd_filial) )
end if

return this.retrieve(ls_id_ecommerce, ll_cd_produto, ldh_inicio, ldh_fim)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date ldh_inicio, ldh_fim

ldh_inicio = dw_1.object.dh_inicio[1]
ldh_fim = dw_1.object.dh_fim[1]

if isnull(ldh_inicio) or ldh_inicio = Date('01/01/1900') Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O seguinte campo deve ser informado: Per$$HEX1$$ed00$$ENDHEX$$odo inicial')
	dw_1.setcolumn('dh_inicio')
	dw_1.setfocus()
	return -1
end if

if isnull(ldh_fim) or ldh_fim = Date('01/01/1900') Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O seguinte campo deve ser informado: Per$$HEX1$$ed00$$ENDHEX$$odo final')
	dw_1.setcolumn('dh_fim')
	dw_1.setfocus()
	return -1
end if

return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;//Habilitar a op$$HEX2$$e700e300$$ENDHEX$$o de salvar em planilha
if pl_linhas > 0 then
	this.ivo_Controle_Menu.of_SalvarComo(True)
else
	this.ivo_Controle_Menu.of_SalvarComo(False)
end if

return pl_linhas

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge522_consulta_venda_vm
integer x = 3205
integer y = 60
end type

