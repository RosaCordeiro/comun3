HA$PBExportHeader$w_ge520_cadastro_vending_machine.srw
forward
global type w_ge520_cadastro_vending_machine from dc_w_cadastro_freeform
end type
end forward

global type w_ge520_cadastro_vending_machine from dc_w_cadastro_freeform
integer width = 1966
integer height = 1992
string title = "GE520 - Cadastro de Vending Machine"
end type
global w_ge520_cadastro_vending_machine w_ge520_cadastro_vending_machine

type variables
uo_ge515_vending_machine iuo_vm
uo_filial iuo_filial
uo_cidade iuo_cidade

boolean ib_vm_bloqueada = false
end variables

forward prototypes
public function boolean wf_proximo_codigo ()
public function boolean wf_valida_vinculo_promocao ()
end prototypes

public function boolean wf_proximo_codigo ();long ll_codigo


Select Max(nr_vending_machine)
into :ll_codigo
from vending_machine;

if sqlca.sqlcode = -1 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela "vending_machine": ~n~n' + sqlca.sqlerrtext )
	return false
end if

if isnull(ll_codigo) Then
	ll_codigo = 1
else
	ll_codigo++
end if

dw_1.object.nr_vending_machine[dw_1.getrow()] = ll_codigo


Return True
end function

public function boolean wf_valida_vinculo_promocao ();long ll_nr_vm
long ll_cd_promocao
datetime ldh_atual

ll_nr_vm = dw_1.object.nr_vending_machine[1]

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

on w_ge520_cadastro_vending_machine.create
call super::create
end on

on w_ge520_cadastro_vending_machine.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;iuo_vm = create uo_ge515_vending_machine
iuo_filial = create uo_filial
iuo_cidade = create uo_cidade
end event

event close;call super::close;destroy(iuo_vm)
destroy(iuo_filial)
destroy(iuo_cidade)
end event

event ue_preupdate;call super::ue_preupdate;Long ll_codigo

dw_1.AcceptText()

if dw_1.getrow() = 0 Then return true

ll_codigo = dw_1.Object.nr_vending_machine[1]

If IsNull(ll_codigo) Then
	If Not wf_Proximo_Codigo() Then Return False
End If

Return True
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge520_cadastro_vending_machine
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge520_cadastro_vending_machine
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge520_cadastro_vending_machine
integer width = 1755
integer height = 1656
string dataobject = "dw_ge520_cadastro_vending_machine"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
			
		Case 'de_localizacao' 
		
			iuo_vm.of_localiza_vending_machine(This.GetText())
			
			If iuo_vm.Localizado Then
				This.Event ue_Reset()
				This.Event ue_Retrieve()
			End If
	
	
		Case 'nm_filial'
			
			iuo_filial.of_Localiza_Filial(This.GetText())
	
			If iuo_filial.Localizada Then
				This.Object.Cd_Filial	[1] = iuo_filial.Cd_Filial 
				This.Object.Nm_Filial[1] = iuo_filial.Nm_Fantasia
			End If	
			
		Case 'nm_cidade'
			
			iuo_cidade.of_localiza_cidade(This.GetText())
	
			If iuo_cidade.Localizada Then
				This.Object.cd_cidade	[1] = iuo_cidade.cd_cidade 
				This.Object.nm_cidade[1] = iuo_cidade.nm_cidade
			End If	
	
	End Choose
	
End If
end event

event dw_1::ue_recuperar;// Override

Return This.Retrieve(iuo_vm.nr_vending_machine)
end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	iuo_vm.of_Inicializa()

End If

Return AncestorReturnValue
end event

event dw_1::constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao"}

This.of_SetColSelection(True)

end event

event dw_1::itemchanged;call super::itemchanged;long ll_nulo

Choose Case dwo.name
		
	Case 'nm_filial'
		
		if data = '' or isnull(data) Then
			setnull(ll_nulo)
			object.cd_filial[row] = ll_nulo
		end if
		
	Case 'cd_cidade'
		
		if data = '' or isnull(data) Then
			setnull(ll_nulo)
			object.cd_cidade[row] = ll_nulo
		end if
		
End Choose
end event

event dw_1::ue_preupdate;long ll_nr_vending_machine
long ll_cd_filial
long ll_cd_cidade
long ll_nr_endereco

string ls_cd_maquina
string ls_cd_local
string ls_de_local
string ls_nr_patrimonio
string ls_nr_serie
string ls_de_endereco
string ls_de_bairro
string ls_nr_cep

dw_1.accepttext( )

if dw_1.getrow() = 0 then return 1

if ib_vm_bloqueada = true then return -1

ll_nr_vending_machine = dw_1.object.nr_vending_machine[1]
ls_cd_maquina 			= dw_1.object.cd_maquina_vmpay[1]
ls_cd_local 					= dw_1.object.cd_local_vmpay[1]
ls_de_local 					= dw_1.object.de_local_vmpay[1]
ls_nr_patrimonio 		= dw_1.object.nr_patrimonio[1]
ls_nr_serie 					= dw_1.object.nr_serie[1]
ll_cd_filial 					= dw_1.object.cd_filial[1]
ll_cd_cidade 				= dw_1.object.cd_cidade[1]
ls_de_endereco 			= dw_1.object.de_endereco[1]
ll_nr_endereco 			= dw_1.object.nr_endereco[1]
ls_de_bairro 				= dw_1.object.de_bairro[1]
ls_nr_cep 					= dw_1.object.nr_cep[1]

if isnull(ll_nr_vending_machine) or ll_nr_vending_machine = 0 Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o c$$HEX1$$f300$$ENDHEX$$digo da Vending Machine.')
	return -1
end if

if isnull(ls_cd_local) or trim(ls_cd_local) = '' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o seguinte campo: C$$HEX1$$f300$$ENDHEX$$digo Local.')
	this.setcolumn('cd_local_vmpay')
	this.setfocus()
	return -1
end if

if isnull(ls_de_local) or trim(ls_de_local) = '' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o seguinte campo: Descri$$HEX2$$e700e300$$ENDHEX$$o Local.')
	this.setcolumn('de_local_vmpay')
	this.setfocus()
	return -1
end if

if isnull(ls_nr_patrimonio) or trim(ls_nr_patrimonio) = '' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o seguinte campo: Patrim$$HEX1$$f400$$ENDHEX$$nio.')
	this.setcolumn('nr_patrimonio')
	this.setfocus()
	return -1
end if

if isnull(ls_nr_serie) or trim(ls_nr_serie) = '' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o seguinte campo: S$$HEX1$$e900$$ENDHEX$$rie.')
	this.setcolumn('nr_serie')
	this.setfocus()
	return -1
end if

if isnull(ll_cd_filial) or ll_cd_filial = 0 Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o seguinte campo: Filial.')
	this.setcolumn('nm_filial')
	this.setfocus()
	return -1
end if

if isnull(ll_cd_cidade) or ll_cd_cidade = 0 Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o seguinte campo: Cidade.')
	this.setcolumn('nm_cidade')
	this.setfocus()
	return -1
end if

if isnull(ls_de_endereco) or trim(ls_de_endereco) = '' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o seguinte campo: Endere$$HEX1$$e700$$ENDHEX$$o.')
	this.setcolumn('de_endereco')
	this.setfocus()
	return -1
end if

if isnull(ll_nr_endereco) or ll_nr_endereco = 0 Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o seguinte campo: Endere$$HEX1$$e700$$ENDHEX$$o Nr$$HEX1$$ba00$$ENDHEX$$.')
	this.setcolumn('nr_endereco')
	this.setfocus()
	return -1
end if

if isnull(ls_de_bairro) or trim(ls_de_bairro) = '' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o seguinte campo: Bairro.')
	this.setcolumn('de_bairro')
	this.setfocus()
	return -1
end if

if isnull(ls_nr_cep) or trim(ls_nr_cep) = '' Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o seguinte campo: CEP.')
	this.setcolumn('nr_cep')
	this.setfocus()
	return -1
end if

return 1
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;wf_valida_vinculo_promocao()


return 1
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge520_cadastro_vending_machine
integer width = 1833
integer height = 1752
end type

