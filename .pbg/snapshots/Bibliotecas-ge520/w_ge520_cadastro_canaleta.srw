HA$PBExportHeader$w_ge520_cadastro_canaleta.srw
forward
global type w_ge520_cadastro_canaleta from dc_w_2tab_cadastro_selecao_lista_det
end type
type cb_adicionar from commandbutton within tabpage_2
end type
type cb_remover from commandbutton within tabpage_2
end type
type p_1 from picture within tabpage_2
end type
type p_2 from picture within tabpage_2
end type
end forward

global type w_ge520_cadastro_canaleta from dc_w_2tab_cadastro_selecao_lista_det
integer width = 2757
string title = "GE520 - Cadastro de Canaletas"
end type
global w_ge520_cadastro_canaleta w_ge520_cadastro_canaleta

type variables
boolean ib_vm_bloqueada=false
end variables

forward prototypes
public function boolean wf_valida_vinculo_promocao (long pl_nr_vm)
end prototypes

public function boolean wf_valida_vinculo_promocao (long pl_nr_vm);long ll_nr_vm
long ll_cd_promocao
datetime ldh_atual

ll_nr_vm = pl_nr_vm

ldh_atual = gf_getserverdate()

Select max(pv.cd_promocao_sos)
into :ll_cd_promocao
from promocao_sos_vm pv
	inner join promocao_sos ps on ps.cd_promocao_sos = pv.cd_promocao_sos
Where pv.nr_vending_machine = :ll_nr_vm
	and ( :ldh_atual between ps.dh_inicio and ps.dh_termino or ps.dh_inicio > :ldh_atual );

if sqlca.sqlcode = -1 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_valida_vinculo_promocao ~nProblemas ao consultar a tabela "promocao_sos_vm": ~n~n' + sqlca.sqlerrtext )
	return false
end if

if ll_cd_promocao > 0 Then
	ib_vm_bloqueada = True
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Esssa Vending Machine est$$HEX1$$e100$$ENDHEX$$ vinculada a promo$$HEX2$$e700e300$$ENDHEX$$o [' + string(ll_cd_promocao) + ']. Portanto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o permitidas altera$$HEX2$$e700f500$$ENDHEX$$es no cadastro.')
else
	ib_vm_bloqueada = false
end if

return true
end function

on w_ge520_cadastro_canaleta.create
int iCurrent
call super::create
end on

on w_ge520_cadastro_canaleta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;long ll_linhas

ll_linhas = tab_1.tabpage_1.dw_2.retrieve()

if ll_linhas > 0 Then
	tab_1.tabpage_1.dw_2.setrow(1)
end if
end event

type dw_visual from dc_w_2tab_cadastro_selecao_lista_det`dw_visual within w_ge520_cadastro_canaleta
end type

type gb_aux_visual from dc_w_2tab_cadastro_selecao_lista_det`gb_aux_visual within w_ge520_cadastro_canaleta
end type

type tab_1 from dc_w_2tab_cadastro_selecao_lista_det`tab_1 within w_ge520_cadastro_canaleta
integer y = 12
integer width = 2683
integer height = 1440
end type

event tab_1::selectionchanged;long ll_linhas
long ll_cd_vm

string ls_de_vm

if newindex = 2 and tabpage_1.dw_2.rowcount() > 0 then
	
	ll_cd_vm = tabpage_1.dw_2.object.nr_vending_machine[ tabpage_1.dw_2.getrow() ]
	ls_de_vm = tabpage_1.dw_2.object.de_local_vmpay[ tabpage_1.dw_2.getrow() ]
	
	ll_linhas = tabpage_2.dw_3.retrieve( ll_cd_vm )
	
	if ll_linhas = 0 Then
		tabpage_2.dw_3.insertrow(1)
	end if
	
	tabpage_2.dw_3.object.st_cod_vm.text = string(ll_cd_vm)
	tabpage_2.dw_3.object.st_desc_vm.text = ls_de_vm
	
	wf_valida_vinculo_promocao(ll_cd_vm)
	
end if
end event

event tab_1::selectionchanging;//
end event

type tabpage_1 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_1 within tab_1
integer width = 2647
integer height = 1324
end type

type gb_2 from dc_w_2tab_cadastro_selecao_lista_det`gb_2 within tabpage_1
integer x = 14
integer y = 20
integer width = 2240
integer height = 1288
end type

type gb_1 from dc_w_2tab_cadastro_selecao_lista_det`gb_1 within tabpage_1
boolean visible = false
integer x = 169
integer width = 1897
integer height = 220
end type

type dw_1 from dc_w_2tab_cadastro_selecao_lista_det`dw_1 within tabpage_1
boolean visible = false
integer x = 219
integer y = 104
integer width = 1723
integer height = 116
end type

type dw_2 from dc_w_2tab_cadastro_selecao_lista_det`dw_2 within tabpage_1
integer x = 55
integer y = 100
integer width = 2162
integer height = 1176
string dataobject = "dw_ge520_lista"
end type

event dw_2::constructor;call super::constructor;this.of_setrowselection( )
end event

type tabpage_2 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_2 within tab_1
integer width = 2647
integer height = 1324
cb_adicionar cb_adicionar
cb_remover cb_remover
p_1 p_1
p_2 p_2
end type

on tabpage_2.create
this.cb_adicionar=create cb_adicionar
this.cb_remover=create cb_remover
this.p_1=create p_1
this.p_2=create p_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_adicionar
this.Control[iCurrent+2]=this.cb_remover
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.p_2
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_adicionar)
destroy(this.cb_remover)
destroy(this.p_1)
destroy(this.p_2)
end on

type gb_3 from dc_w_2tab_cadastro_selecao_lista_det`gb_3 within tabpage_2
integer width = 2601
end type

type dw_3 from dc_w_2tab_cadastro_selecao_lista_det`dw_3 within tabpage_2
integer x = 64
integer width = 2551
integer height = 1064
string dataobject = "dw_ge520_detalhes"
boolean vscrollbar = true
boolean livescroll = false
end type

event dw_3::constructor;call super::constructor;//this.of_setrowselection( )
end event

event dw_3::ue_update;call super::ue_update;//Integer li_Retorno
//long ll_nr_vm
//long ll_nr_canaleta
//
//long ll_linhas
//
//
//If This.Event ue_PreUpdate() = -1 Then Return -1
//
//ll_nr_vm = tab_1.tabpage_1.dw_2.object.nr_vending_machine[ tab_1.tabpage_1.dw_2.getrow() ]
//
//for ll_for = 1 to ll_linhas
//	
//	ll_nr_canaleta = this.object.nr_canaleta[ll_for]
//	
//	
//	
//	
//next
//
//
//If IsValid(ivo_Multitable) Then
//	Return ivo_Multitable.of_Update()
//Else
//	//Grava Log? -- Par$$HEX1$$e200$$ENDHEX$$metro ivb_grava_log deve ser habilitado na tela
//	If ivb_grava_log Then
//		gf_grava_log_alteracao(This)
//	End If
//	
//	li_Retorno = This.Update()
//	
//	If li_Retorno < 0 Then
//		SqlCa.of_RollBack( )// Gambiarra - 10/02/2014
//		SqlCa.of_MsgDbError(ivw_ParentWindow.ivo_dbError.ivs_sqlerrtext)
//	End If
//	
//	Return li_Retorno
//End If

return 1
end event

event dw_3::ue_preupdate;call super::ue_preupdate;long ll_nr_vm
long ll_nr_canaleta
long ll_for
long ll_linhas
long ll_nr_prateleira
long ll_qt_capacidade

String ls_divisor
String ls_campo
string ls_coluna
decimal{2} ldc_altura, ldc_largura, ldc_prof

boolean lb_concluido=false

if ib_vm_bloqueada = true then return -1

Try 

	ll_nr_vm = tab_1.tabpage_1.dw_2.object.nr_vending_machine[ tab_1.tabpage_1.dw_2.getrow() ]
	
	ll_linhas = this.rowcount( )
	
	for ll_for = 1 to ll_linhas
		
		if isnull(this.object.nr_vending_machine[ll_for]) Then
			this.object.nr_vending_machine[ll_for] = ll_nr_vm
		end if
		
		ll_nr_canaleta = this.object.nr_canaleta[ll_for]
		ll_nr_prateleira = this.object.nr_prateleira[ll_for]
		ls_divisor = this.object.id_divisor[ll_for]
		ldc_altura = this.object.qt_altura[ll_for]
		ldc_largura = this.object.qt_largura[ll_for]
		ldc_prof = this.object.qt_profundidade[ll_for]
		ll_qt_capacidade = this.object.qt_capacidade[ll_for]
	
		if ll_nr_canaleta = 0 or isnull(ll_nr_canaleta) Then
			ls_campo = 'Canaleta'
			ls_coluna = 'nr_canaleta'
			return -1
		end if
		
		if ll_nr_prateleira = 0 or isnull(ll_nr_prateleira) Then
			ls_campo = 'Prateleira'
			ls_coluna = 'nr_prateleira'
			return -1
		end if
		
		if ls_divisor = '' or isnull(ls_divisor) Then
			ls_campo = 'Divisor'
			ls_coluna = 'id_divisor'
			return -1
		end if
		
		if ldc_altura = 0 or isnull(ldc_altura) Then
			ls_campo = 'Altura'
			ls_coluna = 'qt_altura'
			return -1
		end if
		
		if ldc_largura = 0 or isnull(ldc_largura) Then
			ls_campo = 'Largura'
			ls_coluna = 'qt_largura'
			return -1
		end if
		
		if ldc_prof = 0 or isnull(ldc_prof) Then
			ls_campo = 'Profundidade'
			ls_coluna = 'qt_profundidade'
			return -1
		end if
		
		if ll_qt_capacidade = 0 or isnull(ll_qt_capacidade) Then
			ls_campo = 'Capacidade'
			ls_coluna = 'qt_capacidade'
			return -1
		end if
		
	next
	
	lb_concluido = true

Finally
	
	if lb_concluido = false then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O seguinte campo deve ser informado: ' + ls_campo )
		this.setrow(ll_for)
		this.setcolumn(ls_coluna)
		this.setfocus()
	end if
		
End Try

return 1
end event

event dw_3::itemchanged;call super::itemchanged;long ll_nr_canaleta

if dwo.name = 'nr_canaleta' Then
	
	ll_nr_canaleta = long(data)
	
	if find('nr_canaleta = ' + string(ll_nr_canaleta), 1, rowcount() ) > 0 Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A canaleta informada [' +string(ll_nr_canaleta) + '] j$$HEX1$$e100$$ENDHEX$$ foi configurada.')
		
		setnull(ll_nr_canaleta)
		post setitem( row, 'nr_canaleta', ll_nr_canaleta )
		return 1
	end if
	
	
end if
end event

type cb_adicionar from commandbutton within tabpage_2
integer x = 78
integer y = 1160
integer width = 466
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Adicionar"
end type

event clicked;
if ib_vm_bloqueada = True then return 1

if dw_3.getitemstatus( dw_3.rowcount() , 0, primary!) = New! Then return 1

dw_3.insertrow( dw_3.rowcount() + 1 )
end event

type cb_remover from commandbutton within tabpage_2
integer x = 571
integer y = 1160
integer width = 466
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Remover"
end type

event clicked;long ll_for
string ls_selecionado

if ib_vm_bloqueada = True then return 1

if dw_3.find('id_selecionado = "S"',1, dw_3.rowcount() ) = 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros selecionados para remover.')
	return -1
end if

If messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Deseja excluir os registros selecionados?',question!,yesno!,2) = 2 then return -1

for ll_for = 1 to dw_3.rowcount()
	
	ls_selecionado = dw_3.object.id_selecionado[ll_for]
	
	if ls_selecionado = 'N' Then continue
	
	dw_3.deleterow(ll_for)
	
next
end event

type p_1 from picture within tabpage_2
integer x = 937
integer y = 1176
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\cancel_peq.png"
boolean focusrectangle = false
end type

event clicked;cb_remover.event clicked()
end event

type p_2 from picture within tabpage_2
integer x = 448
integer y = 1176
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\up.png"
boolean focusrectangle = false
end type

event clicked;cb_adicionar.event clicked()
end event

