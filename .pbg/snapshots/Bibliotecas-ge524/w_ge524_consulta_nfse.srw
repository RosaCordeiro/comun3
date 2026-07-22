HA$PBExportHeader$w_ge524_consulta_nfse.srw
forward
global type w_ge524_consulta_nfse from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_gerar from commandbutton within tabpage_1
end type
type cb_consultar from commandbutton within tabpage_1
end type
type cb_cancelar from commandbutton within tabpage_1
end type
type gb_4 from groupbox within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
end forward

global type w_ge524_consulta_nfse from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge524_consulta_nfse"
integer width = 3826
integer height = 2312
string title = "GE524 - Consulta NFS-e"
end type
global w_ge524_consulta_nfse w_ge524_consulta_nfse

on w_ge524_consulta_nfse.create
int iCurrent
call super::create
end on

on w_ge524_consulta_nfse.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;datetime ldt_atual

ldt_atual = gf_getserverdate()

Tab_1.TabPage_1.dw_1.Object.dh_inicio_pedido[1] = Datetime( relativedate(date(ldt_atual) ,- 5), time('00:00') )
Tab_1.TabPage_1.dw_1.Object.dh_fim_pedido[1] = ldt_atual
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge524_consulta_nfse
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge524_consulta_nfse
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge524_consulta_nfse
integer width = 3739
integer height = 2096
end type

event tab_1::selectionchanged;//
end event

event tab_1::selectionchanging;long ll_linha
long ll_cd_filial, ll_nr_nf
string ls_especie, ls_serie, ls_nr_pedido, ls_situacao

if newindex = 2 then
	
	ll_linha = tabpage_1.dw_2.getrow()
	
	if ll_linha > 0 Then
		
		ls_nr_pedido = tabpage_1.dw_2.object.nr_pedido_drogaexpress[ll_linha]
		ll_cd_filial = tabpage_1.dw_2.object.cd_filial[ll_linha]
		ll_nr_nf = tabpage_1.dw_2.object.nr_nf[ll_linha]
		ls_especie = tabpage_1.dw_2.object.de_especie[ll_linha]
		ls_serie = tabpage_1.dw_2.object.de_serie[ll_linha]
		ls_situacao = tabpage_1.dw_2.object.id_situacao[ll_linha]
		
		if tabpage_2.dw_3.retrieve(ll_cd_filial, ll_nr_nf, ls_especie, ls_serie) = 0 then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ detalhes a serem exibidos.')
			return 1
		end if
		
		tabpage_2.dw_4.retrieve(ls_nr_pedido)
		
	else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1	
	end if
	
end if

end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3703
integer height = 1980
cb_gerar cb_gerar
cb_consultar cb_consultar
cb_cancelar cb_cancelar
end type

on tabpage_1.create
this.cb_gerar=create cb_gerar
this.cb_consultar=create cb_consultar
this.cb_cancelar=create cb_cancelar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar
this.Control[iCurrent+2]=this.cb_consultar
this.Control[iCurrent+3]=this.cb_cancelar
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_gerar)
destroy(this.cb_consultar)
destroy(this.cb_cancelar)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 424
integer width = 3643
integer height = 1420
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3008
integer height = 372
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer y = 96
integer width = 2949
integer height = 268
string dataobject = "dw_ge524_consulta_nfse_selecao"
boolean ivb_selecao_colunas = true
end type

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 512
integer width = 3579
integer height = 1296
string dataobject = "dw_ge524_consulta_nfse_lista"
boolean ivb_selecao_linhas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;datetime ldh_inicio_pedido
datetime ldh_fim_pedido
datetime ldh_inicio_nfse
datetime ldh_fim_nfse

string ls_nr_pedido_ecommerce
string ls_nr_nfse
string ls_id_situacao

long ll_nr_cupom

dw_1.accepttext()

ldh_inicio_pedido = dw_1.object.dh_inicio_pedido[1]
ldh_fim_pedido = dw_1.object.dh_fim_pedido[1]
ldh_inicio_nfse = dw_1.object.dh_inicio_nfse[1]
ldh_fim_nfse = dw_1.object.dh_fim_nfse[1]
ls_id_situacao = dw_1.object.id_situacao[1]
ls_nr_pedido_ecommerce = dw_1.object.nr_pedido_ecommerce[1]
ll_nr_cupom = dw_1.object.nr_cupom[1]
ls_nr_nfse = dw_1.object.nr_nfse[1]

if isnull(ldh_inicio_pedido) or String(ldh_inicio_pedido,'dd/mm/yyyy') = '01/01/1900' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a data inicial do pedido.' )
	dw_1.SetColumn("dh_inicio_pedido")
	return -1
end if

if isnull(ldh_fim_pedido) or String(ldh_fim_pedido,'dd/mm/yyyy') = '01/01/1900' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a data final do pedido.' )
	dw_1.SetColumn("dh_fim_pedido")
	return -1
end if

if not isnull(ldh_inicio_nfse) and String(ldh_inicio_nfse,'dd/mm/yyyy') <> '01/01/1900' Then
	if isnull(ldh_fim_nfse) or String(ldh_fim_nfse,'dd/mm/yyyy') = '01/01/1900' Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a data final da NFS-e.' )
		dw_1.SetColumn("dh_fim_nfse")
		return -1
	end if
end if

if not isnull(ldh_fim_nfse) and String(ldh_fim_nfse,'dd/mm/yyyy') <> '01/01/1900' Then
	if isnull(ldh_inicio_nfse) or String(ldh_inicio_nfse,'dd/mm/yyyy') = '01/01/1900' Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a data inicial da NFS-e.' )
		dw_1.SetColumn("dh_inicio_nfse")
		return -1
	end if
end if

this.of_appendwhere_subquery( "p.dh_emissao >= '"+String(ldh_Inicio_pedido, "yyyymmdd")+"'", 2)
this.of_appendwhere_subquery( "p.dh_emissao <= '"+String(ldh_fim_pedido, "yyyymmdd 23:59:59")+"'", 2)

this.of_appendwhere_subquery( "p.dh_emissao >= '"+String(ldh_Inicio_pedido, "yyyymmdd")+"'", 4)
this.of_appendwhere_subquery( "p.dh_emissao <= '"+String(ldh_fim_pedido, "yyyymmdd 23:59:59")+"'", 4)

if not isnull(ldh_Inicio_nfse) Then
	this.of_appendwhere_subquery( "ns.dh_emissao >= '"+String(ldh_Inicio_nfse, "yyyymmdd")+"'", 2)
	this.of_appendwhere_subquery( "ns.dh_emissao <= '"+String(ldh_fim_nfse, "yyyymmdd 23:59:59")+"'", 2)
	
	this.of_appendwhere_subquery( "ns.dh_emissao >= '"+String(ldh_Inicio_nfse, "yyyymmdd")+"'", 4)
	this.of_appendwhere_subquery( "ns.dh_emissao <= '"+String(ldh_fim_nfse, "yyyymmdd 23:59:59")+"'", 4)
end if

if ls_id_situacao = 'P' Then
	this.of_appendwhere_subquery( "( ns.id_situacao = '"+ ls_id_situacao + "' or ns.id_situacao is null )", 2)
	this.of_appendwhere_subquery( "( ns.id_situacao = '"+ ls_id_situacao + "' or ns.id_situacao is null )", 4)
elseif ls_id_situacao = 'C' then
	this.of_appendwhere_subquery( "ns.id_situacao = '"+ ls_id_situacao + "'", 2)
	this.of_appendwhere_subquery( "ns.id_situacao <> 'X'", 4)
elseif ls_id_situacao = 'X' then
	this.of_appendwhere_subquery( "ns.id_situacao = '"+ ls_id_situacao + "'", 2)
	this.of_appendwhere_subquery( "ns.id_situacao = 'X'", 4)	
elseif ls_id_situacao <> 'T' Then
	this.of_appendwhere_subquery( "ns.id_situacao = '"+ ls_id_situacao + "'", 2)
	this.of_appendwhere_subquery( "ns.id_situacao = 'Z'", 4) //Para n$$HEX1$$e300$$ENDHEX$$o trazer resultados
end if

if ls_nr_pedido_ecommerce <> '' and not isnull(ls_nr_pedido_ecommerce) Then
	this.of_appendwhere_subquery( "p.nr_pedido_ecommerce_site = '"+ ls_nr_pedido_ecommerce + "'", 2)
	this.of_appendwhere_subquery( "p.nr_pedido_ecommerce_site = '"+ ls_nr_pedido_ecommerce + "'", 4)
end if

if ls_nr_nfse <> '' and not isnull(ls_nr_nfse) Then
	this.of_appendwhere_subquery( "ns.nr_nf_servico = '"+ ls_nr_nfse + "'", 2)
	this.of_appendwhere_subquery( "ns.nr_nf_servico = '"+ ls_nr_nfse + "'", 4)
end if

if ll_nr_cupom > 0 Then
	this.of_appendwhere_subquery( "n.nr_nf = "+ String(ll_nr_cupom), 2 )
	this.of_appendwhere_subquery( "n.nr_nf = "+ String(ll_nr_cupom), 4 )
end if

return 1
end event

event dw_2::doubleclicked;call super::doubleclicked;//String	ls_marcar
//
//Long	ll_Row
//
//If dwo.Name = 'p_imagem' Then
//	
//	if this.find( 'id_selecionar = "N"', 1, rowcount()) > 0 then
//		ls_marcar = 'S'
//	else
//		ls_marcar = 'N'
//	end if
//	
//	For ll_Row = 1 To This.RowCount()
//				
//		this.object.id_selecionar[ll_row] = ls_marcar
//	
//	Next
//	
//End If		
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;string ls_id_situacao 
string ls_protocolo_cancel

if pl_linhas > 0 Then
	
	ls_id_situacao = dw_1.object.id_situacao[1]
	
	Choose Case ls_id_situacao
			
		Case 'R'
			
			cb_gerar.enabled = true
			cb_consultar.enabled = false
			cb_cancelar.enabled = true
			
		case 'P'
			
			cb_gerar.enabled = true
			cb_consultar.enabled = false
			cb_cancelar.enabled = false
			
		case 'N' 
			
			cb_gerar.enabled = false
			cb_consultar.enabled = true
			cb_cancelar.enabled = false
			
		Case 'E'	
			
			cb_gerar.enabled = true
			cb_consultar.enabled = true
			cb_cancelar.enabled = false
			
		Case 'C'	
			cb_cancelar.enabled = True
			cb_gerar.enabled = false
			cb_consultar.enabled = false
			
		Case 'T'
			
			cb_gerar.enabled = false
			cb_consultar.enabled = false
			cb_cancelar.enabled = false
	End Choose
			
else			
			
	cb_gerar.enabled = false
	cb_consultar.enabled = false				
			
end if

return pl_linhas
end event

event dw_2::buttonclicked;call super::buttonclicked;string ls_nr_protocolo, ls_url, ls_log

if dwo.name = 'b_imprimir' Then
	
	uo_ge524_nfse luo_nfse
	
	luo_nfse = create uo_ge524_nfse 
	
	ls_nr_protocolo = this.object.nr_protocolo[row]
	
	if Not luo_nfse.of_imprimir_nfse( ls_nr_protocolo, ref ls_url, ref ls_log ) then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
	end if
	
end if
end event

event dw_2::itemchanged;call super::itemchanged;long ll_find

if dwo.name = 'id_selecionar' then
	
	if data = 'S' then
		ll_find = find('id_selecionar = "S"',1,rowcount() )
		if ll_find > 0 Then
			setitem(ll_find, 'id_selecionar', 'N')
		end if
	end if
	
end if
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3703
integer height = 1980
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_2.create
this.gb_4=create gb_4
this.dw_4=create dw_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_4
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3456
integer height = 772
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3401
integer height = 656
string dataobject = "dw_ge524_consulta_nfse_detalhes"
end type

type cb_gerar from commandbutton within tabpage_1
integer x = 2551
integer y = 1864
integer width = 549
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Gerar NFS-e"
end type

event clicked;long ll_for
long ll_linhas
long ll_cd_filial
long ll_nr_cupom
string ls_especie
string ls_serie
string ls_cd_servico
string ls_de_servico
string ls_id_selecionado
string ls_id_situacao
string ls_log
string ls_nr_protocolo
string ls_nr_protocolo_cancel
string ls_matricula
decimal{2} ldc_base_iss, ldc_aliq_iss

uo_ge524_nfse luo_nfse

Try

	ll_linhas = dw_2.rowcount()
	
	if dw_2.find('id_selecionar = "S"', 1, dw_2.rowcount() ) = 0 Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros selecionados.')
		return -1
	end if
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE524_GERA_NFSE", Ref ls_matricula) Then
		Return -1
	End If
	
	if Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma o envio para gerar a nota fiscal de servi$$HEX1$$e700$$ENDHEX$$o?', Question!, YesNo!, 2) = 2 Then return -1
	
	Open(w_Aguarde)
		
	w_Aguarde.Title = "NFS-e - Emiss$$HEX1$$e300$$ENDHEX$$o"
		
	w_Aguarde.uo_progress.of_setmax(ll_linhas)
		
	for ll_for = 1 to ll_linhas
		
		ls_id_selecionado = dw_2.object.id_selecionar[ll_for]
		ls_id_situacao = dw_2.object.id_situacao[ll_for]
		ll_cd_filial = dw_2.object.cd_filial[ll_for]
		ll_nr_cupom = dw_2.object.nr_nf[ll_for]
		ls_especie = dw_2.object.de_especie[ll_for]
		ls_serie = dw_2.object.de_serie[ll_for]
		ls_nr_protocolo = dw_2.object.nr_protocolo[ll_for]
		ls_nr_protocolo_cancel = dw_2.object.nr_protocolo_cancelamento[ll_for]
		//ls_cd_servico = dw_2.object.cd_servico[ll_for]
		//ls_de_servico = dw_2.object.de_servico[ll_for]
		ldc_base_iss = dw_2.object.vl_manipulado[ll_for]
		ldc_aliq_iss = 2 //2%
		
		ls_cd_servico = '4.07'
		ls_de_servico = 'servi$$HEX1$$e700$$ENDHEX$$os farmaceuticos'
		
		if ls_id_selecionado <> 'S' then 
			w_Aguarde.uo_progress.of_setprogress(ll_for)
			continue
		End if
		
		if isnull(ls_nr_protocolo) Then ls_nr_protocolo = ''
		if isnull(ls_nr_protocolo_cancel) Then ls_nr_protocolo_cancel = ''
		
		if ls_id_situacao = 'P' or ( ls_id_situacao = 'E' and ls_nr_protocolo = '' ) or ( ls_id_situacao = 'R' and ls_nr_protocolo_cancel = '' ) Then
			
			luo_nfse = create uo_ge524_nfse
			
			luo_nfse.of_processa_nfse( ll_cd_filial, ll_nr_cupom, ls_especie, ls_serie, ls_cd_servico, ls_de_servico, ldc_base_iss, ldc_aliq_iss, True, ref ls_log) 
			
			if ls_log = '-1' Then return -1
			
			destroy(luo_nfse)
			
		end if
		
		w_Aguarde.uo_progress.of_setprogress(ll_for)
		
	next
	
	dw_2.Event ue_recuperar()
	
Finally 
	
	Close(w_aguarde)
	if isvalid(luo_nfse) then
		destroy(luo_nfse)
	end if
End Try
end event

type cb_consultar from commandbutton within tabpage_1
integer x = 3113
integer y = 1864
integer width = 549
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
string text = "Consultar NFS-e"
end type

event clicked;long ll_for
long ll_linhas
long ll_cd_filial

string ls_nr_protocolo
string ls_id_nfse
string ls_id_selecionado
string ls_id_situacao
string ls_log

uo_ge524_nfse luo_nfse

Try
	
	ll_linhas = dw_2.rowcount()

	if dw_2.find('id_selecionar = "S"', 1, dw_2.rowcount() ) = 0 Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros selecionados.')
		return -1
	end if

	Open(w_Aguarde)
		
	w_Aguarde.Title = "NFS-e - Consulta"
		
	w_Aguarde.uo_progress.of_setmax(ll_linhas)
	
	for ll_for = 1 to ll_linhas
		
		ls_id_selecionado = dw_2.object.id_selecionar[ll_for]
		ls_id_situacao = dw_2.object.id_situacao[ll_for]
		ls_id_nfse = dw_2.object.id_nfse[ll_for]
		ls_nr_protocolo = dw_2.object.nr_protocolo[ll_for]
		ll_cd_filial = dw_2.object.cd_filial[ll_for]
		
		if ls_id_selecionado <> 'S' then 
			w_Aguarde.uo_progress.of_setprogress(ll_for)
			continue
		end if
		
		if isnull(ls_nr_protocolo) then ls_nr_protocolo = ''
		
		//if ls_id_situacao = 'N'  or ( ls_id_situacao = 'E' and ls_nr_protocolo <> '' ) Then //Somente se situa$$HEX2$$e700e300$$ENDHEX$$o for Enviada
			
			luo_nfse = create uo_ge524_nfse
		
			luo_nfse.of_consulta_nfse( ls_nr_protocolo, ls_id_nfse, ll_cd_filial, True, ref ls_log )
			
			Destroy(luo_nfse)
			
		//end if
		
		w_Aguarde.uo_progress.of_setprogress(ll_for)
		
	next
	
	dw_2.Event ue_recuperar()
	
Finally
	
	Close(w_aguarde)
	if isvalid(luo_nfse) then
		Destroy(luo_nfse)
	end if
	
End Try
end event

type cb_cancelar from commandbutton within tabpage_1
integer x = 23
integer y = 1864
integer width = 549
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Cancelar NFS-e"
end type

event clicked;long ll_for
long ll_linhas
long ll_cd_filial

string ls_nr_protocolo
string ls_id_nfse
string ls_id_selecionado
string ls_id_situacao
string ls_nr_protocolo_canc
string ls_log

uo_ge524_nfse luo_nfse

Try
	
	ll_linhas = dw_2.rowcount()

	if dw_2.find('id_selecionar = "S"', 1, dw_2.rowcount() ) = 0 Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros selecionados.')
		return -1
	end if

	Open(w_Aguarde)
		
	w_Aguarde.Title = "NFS-e - Cancelamento"
		
	w_Aguarde.uo_progress.of_setmax(ll_linhas)
	
	for ll_for = 1 to ll_linhas
		
		ls_id_selecionado = dw_2.object.id_selecionar[ll_for]
		ls_id_situacao = dw_2.object.id_situacao[ll_for]
		ls_id_nfse = dw_2.object.id_nfse[ll_for]
		ls_nr_protocolo = dw_2.object.nr_protocolo[ll_for]
		ll_cd_filial = dw_2.object.cd_filial[ll_for]
		ls_nr_protocolo_canc = dw_2.object.nr_protocolo_cancelamento[ll_for]
		
		if ls_id_selecionado <> 'S' then 
			w_Aguarde.uo_progress.of_setprogress(ll_for)
			continue
		end if
		
		if isnull(ls_nr_protocolo) then ls_nr_protocolo = ''
		if isnull(ls_nr_protocolo_canc) then ls_nr_protocolo_canc = ''
		
		if ls_id_situacao = 'C'  or ( ls_id_situacao = 'R' and ls_nr_protocolo_canc <> '' ) Then //Somente se situa$$HEX2$$e700e300$$ENDHEX$$o for Pendente de Cancelamento
			
			luo_nfse = create uo_ge524_nfse
			
			if ls_nr_protocolo_canc = '' Then
				//Faz a solicita$$HEX2$$e700e300$$ENDHEX$$o do cancelamento
				luo_nfse.of_cancelar_nfse( ll_cd_filial, ls_nr_protocolo, ls_id_nfse, true, ref ls_log ) 
			else
				//Consulta a solicita$$HEX2$$e700e300$$ENDHEX$$o do cancelamento
				luo_nfse.of_cancelar_nfse_consulta( ls_nr_protocolo_canc, ls_id_nfse, ll_cd_filial, ref ls_log )
			end if
			
			Destroy(luo_nfse)
			
		end if
		
		w_Aguarde.uo_progress.of_setprogress(ll_for)
		
	next
	
	dw_2.Event ue_recuperar()
	
Finally
	
	Close(w_aguarde)
	if isvalid(luo_nfse) then
		Destroy(luo_nfse)
	end if
	
End Try
end event

type gb_4 from groupbox within tabpage_2
integer x = 23
integer y = 812
integer width = 3456
integer height = 1168
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 41
integer y = 904
integer width = 3406
integer height = 1036
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge524_consulta_nfse_produtos"
boolean vscrollbar = true
end type

