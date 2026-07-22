HA$PBExportHeader$w_ge524_consulta_nfse_matriz.srw
forward
global type w_ge524_consulta_nfse_matriz from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_gerar from commandbutton within tabpage_1
end type
type cb_consultar from commandbutton within tabpage_1
end type
type pb_exibe_nfse from picturebutton within tabpage_2
end type
end forward

global type w_ge524_consulta_nfse_matriz from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge524_consulta_nfse"
integer width = 4955
integer height = 2200
string title = "GE524 - Consulta NFS-e"
end type
global w_ge524_consulta_nfse_matriz w_ge524_consulta_nfse_matriz

type variables
uo_filial iuo_filial
end variables

on w_ge524_consulta_nfse_matriz.create
int iCurrent
call super::create
end on

on w_ge524_consulta_nfse_matriz.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;datetime ldt_atual

iuo_filial = create uo_filial

ldt_atual = gf_getserverdate()

Tab_1.TabPage_1.dw_1.Object.dh_inicio_nfse[1] = Datetime( relativedate(date(ldt_atual) ,- 5), time('00:00') )
Tab_1.TabPage_1.dw_1.Object.dh_fim_nfse[1] = ldt_atual

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
end event

event ue_preopen;call super::ue_preopen;MaxHeight = 9999
end event

event resize;call super::resize;Tab_1.Height = NewHeight - 30

Tab_1.Tabpage_1.gb_2.Height = Tab_1.Height - Tab_1.Tabpage_1.gb_2.Y - 135
Tab_1.Tabpage_1.dw_2.Height = Tab_1.Tabpage_1.gb_2.Height - 105
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge524_consulta_nfse_matriz
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge524_consulta_nfse_matriz
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge524_consulta_nfse_matriz
integer width = 4864
integer height = 1984
end type

event tab_1::selectionchanged;//
end event

event tab_1::selectionchanging;long ll_linha
long ll_cd_filial, ll_nr_nf
string ls_especie, ls_serie

if newindex = 2 then
	
	ll_linha = tabpage_1.dw_2.getrow()
	
	if ll_linha > 0 Then
		
		ll_cd_filial = tabpage_1.dw_2.object.cd_filial[ll_linha]
		ll_nr_nf = tabpage_1.dw_2.object.nr_nf[ll_linha]
		ls_especie = tabpage_1.dw_2.object.de_especie[ll_linha]
		ls_serie = tabpage_1.dw_2.object.de_serie[ll_linha]
		
		if tabpage_2.dw_3.retrieve(ll_cd_filial, ll_nr_nf, ls_especie, ls_serie) = 0 then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ detalhes a serem exibidos.')
			return 1
		end if
		
	else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1	
	end if
	
end if

end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4827
integer height = 1868
cb_gerar cb_gerar
cb_consultar cb_consultar
end type

on tabpage_1.create
this.cb_gerar=create cb_gerar
this.cb_consultar=create cb_consultar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar
this.Control[iCurrent+2]=this.cb_consultar
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_gerar)
destroy(this.cb_consultar)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 32
integer y = 424
integer width = 4782
integer height = 1420
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 2793
integer height = 372
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer y = 96
integer width = 2720
integer height = 268
string dataobject = "dw_ge524_consulta_nfse_selecao_matriz"
boolean ivb_selecao_colunas = true
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
			
		Case "nm_filial"
			iuo_filial.of_Localiza_Filial(This.GetText())
	
			If iuo_filial.Localizada Then
				This.Object.Cd_Filial	[1] = iuo_filial.Cd_Filial 
				This.Object.Nm_Filial[1] = iuo_filial.Nm_Fantasia
			End If	

	End Choose
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 50
integer y = 504
integer width = 4745
integer height = 1320
string dataobject = "dw_ge524_consulta_nfse_lista_matriz"
boolean ivb_selecao_linhas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;datetime ldh_inicio_nfse
datetime ldh_fim_nfse

string ls_id_situacao
string ls_especie
string ls_serie

long ll_nr_cupom
long ll_cd_filial

dw_1.accepttext()

ldh_inicio_nfse = dw_1.object.dh_inicio_nfse[1]
ldh_fim_nfse = dw_1.object.dh_fim_nfse[1]
ls_id_situacao = dw_1.object.id_situacao[1]
ls_especie = dw_1.object.de_especie[1]
ls_serie = dw_1.object.de_serie[1]
ll_nr_cupom = dw_1.object.nr_cupom[1]
ll_cd_filial = dw_1.object.cd_filial[1]

if isnull(ldh_inicio_nfse) or String(ldh_inicio_nfse,'dd/mm/yyyy') = '01/01/1900' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a data inicial da NFS-e.' )
	dw_1.SetColumn("dh_inicio_nfse")
	return -1
end if

if isnull(ldh_fim_nfse) or String(ldh_fim_nfse,'dd/mm/yyyy') = '01/01/1900' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a data final da NFS-e.' )
	dw_1.SetColumn("dh_fim_nfse")
	return -1
end if

this.of_appendwhere_subquery( "ns.dh_emissao >= '"+String(ldh_Inicio_nfse, "yyyymmdd")+"'", 3)
this.of_appendwhere_subquery( "ns.dh_emissao <= '"+String(ldh_fim_nfse, "yyyymmdd 23:59:59")+"'", 3)
this.of_appendwhere_subquery( "ns.dh_emissao >= '"+String(ldh_Inicio_nfse, "yyyymmdd")+"'", 6)
this.of_appendwhere_subquery( "ns.dh_emissao <= '"+String(ldh_fim_nfse, "yyyymmdd 23:59:59")+"'", 6)

if ls_id_situacao = 'P' Then
	this.of_appendwhere_subquery( "( ns.id_situacao = '"+ ls_id_situacao + "' or ns.id_situacao is null )", 3)
	this.of_appendwhere_subquery( "( ns.id_situacao = '"+ ls_id_situacao + "' or ns.id_situacao is null )", 6)
elseif ls_id_situacao <> 'T' Then
	this.of_appendwhere_subquery( "ns.id_situacao = '"+ ls_id_situacao + "'", 3)
	this.of_appendwhere_subquery( "ns.id_situacao = '"+ ls_id_situacao + "'", 6)
end if

if ll_cd_filial > 0 and not isnull(ll_cd_filial) Then
	this.of_appendwhere_subquery( "n.cd_filial = "+ string(ll_cd_filial) , 3)
	this.of_appendwhere_subquery( "n.cd_filial = "+ string(ll_cd_filial) , 6)
end if

if ll_nr_cupom > 0 Then
	this.of_appendwhere_subquery( "n.nr_nf = "+ String(ll_nr_cupom), 3)
	this.of_appendwhere_subquery( "n.nr_nf = "+ String(ll_nr_cupom), 6)
end if

if ls_especie <> '' and not isnull(ls_especie) Then
	this.of_appendwhere_subquery( "n.de_especie = '"+ ls_especie + "'", 3 )
	this.of_appendwhere_subquery( "n.de_especie = '"+ ls_especie + "'", 6 )
end if

if ls_serie <> '' and not isnull(ls_serie) Then
	this.of_appendwhere_subquery( "n.de_serie = '"+ ls_serie + "'", 3 )
	this.of_appendwhere_subquery( "n.de_serie = '"+ ls_serie + "'", 6 )
end if

return 1
end event

event dw_2::doubleclicked;call super::doubleclicked;String	ls_marcar

Long	ll_Row

If dwo.Name = 'p_imagem' Then
	
	if this.find( 'id_selecionar = "N"', 1, rowcount()) > 0 then
		ls_marcar = 'S'
	else
		ls_marcar = 'N'
	end if
	
	For ll_Row = 1 To This.RowCount()
				
		this.object.id_selecionar[ll_row] = ls_marcar
	
	Next
	
End If		
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;string ls_id_situacao 

if pl_linhas > 0 Then
	
	ls_id_situacao = dw_1.object.id_situacao[1]
	
	Choose Case ls_id_situacao
		case 'P'
			
			cb_gerar.enabled = true
			cb_consultar.enabled = false
			
		case 'N' 
			
			cb_gerar.enabled = false
			cb_consultar.enabled = true
			
		Case 'E'	
			
			cb_gerar.enabled = true
			cb_consultar.enabled = true
			
		Case 'T'
			
			cb_gerar.enabled = false
			cb_consultar.enabled = false
			
	End Choose
			
else			
			
	cb_gerar.enabled = false
	cb_consultar.enabled = false				
			
end if

return pl_linhas
end event

event dw_2::constructor;call super::constructor;This.ivo_Controle_Menu.of_Atualiza()
end event

event dw_2::buttonclicked;call super::buttonclicked;string ls_nr_protocolo, ls_url, ls_log

If dwo.name = 'b_imprimir' Then
	Try
		uo_ge524_nfse luo_nfse
		
		luo_nfse = Create uo_ge524_nfse 
		
		ls_nr_protocolo = This.object.nr_protocolo[row]
		
		If Not luo_nfse.of_imprimir_nfse( ls_nr_protocolo, ref ls_url, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
		End If
		
	Catch (RuntimeError lvo_Erro)
		MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
		Return 
	
	Finally
		If IsValid(luo_nfse) Then Destroy(luo_nfse)
	End Try
	
End If
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4827
integer height = 1868
pb_exibe_nfse pb_exibe_nfse
end type

on tabpage_2.create
this.pb_exibe_nfse=create pb_exibe_nfse
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_exibe_nfse
end on

on tabpage_2.destroy
call super::destroy
destroy(this.pb_exibe_nfse)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3410
integer height = 1388
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 50
integer width = 3369
integer height = 1312
string dataobject = "dw_ge524_consulta_nfse_detalhes_matriz"
end type

event dw_3::constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

type cb_gerar from commandbutton within tabpage_1
boolean visible = false
integer x = 2880
integer y = 56
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
string ls_matricula
decimal{2} ldc_base_iss, ldc_aliq_iss

uo_ge524_nfse luo_nfse

Try

	ll_linhas = dw_2.rowcount()
	
	if dw_2.find('id_selecionar = "S"', 1, dw_2.rowcount() ) = 0 Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros selecionados.')
		return -1
	end if
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE524_CONSULTA_NFSE_MATRIZ", Ref ls_matricula) Then
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
		
		if ls_id_situacao = 'P' or ( ls_id_situacao = 'E' and ls_nr_protocolo = '' ) Then
			
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
boolean visible = false
integer x = 2880
integer y = 188
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
		
		if ls_id_situacao = 'N'  or ( ls_id_situacao = 'E' and ls_nr_protocolo <> '' ) Then //Somente se situa$$HEX2$$e700e300$$ENDHEX$$o for Enviada
			
			luo_nfse = create uo_ge524_nfse
		
			luo_nfse.of_consulta_nfse( ls_nr_protocolo, ls_id_nfse, ll_cd_filial, True, ref ls_log )
			
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

type pb_exibe_nfse from picturebutton within tabpage_2
integer x = 3278
integer y = 640
integer width = 105
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\icon_search.PNG"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\icon_search.PNG"
alignment htextalign = left!
end type

event clicked;string ls_url

ls_url = Parent.dw_3.Object.de_link_visualizacao_nfse[1]

If gf_coalesce(ls_url,'')<>'' Then
	Try
		uo_ge524_nfse luo_nfse
		
		luo_nfse = Create uo_ge524_nfse 
		luo_nfse.of_imprimir_nfse( ls_url )
		
	Catch (RuntimeError lvo_Erro)
		MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
		Return 
	
	Finally
		If IsValid(luo_nfse) Then Destroy(luo_nfse)
	End Try
	
End If
end event

