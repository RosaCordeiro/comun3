HA$PBExportHeader$w_ge042_emissao_nota_fiscal_anexa.srw
forward
global type w_ge042_emissao_nota_fiscal_anexa from dc_w_sheet
end type
type dw_1 from dc_uo_dw_base within w_ge042_emissao_nota_fiscal_anexa
end type
end forward

global type w_ge042_emissao_nota_fiscal_anexa from dc_w_sheet
integer x = 215
integer y = 220
integer width = 2194
integer height = 604
string title = "GE042 - Emiss$$HEX1$$e300$$ENDHEX$$o de Notas Fiscais Anexas"
dw_1 dw_1
end type
global w_ge042_emissao_nota_fiscal_anexa w_ge042_emissao_nota_fiscal_anexa

type variables
uo_nota_fiscal    ivo_nota_fiscal //GE033
end variables

forward prototypes
public function boolean wf_verifica_serie_especie_nf (ref string ps_especie_nf, ref string ps_serie_nf)
public function boolean wf_verifica_serie_especie_cf (ref string ps_especie_cf, ref string ps_serie_cf)
end prototypes

public function boolean wf_verifica_serie_especie_nf (ref string ps_especie_nf, ref string ps_serie_nf);Select de_especie_nf, 
       de_serie_nf
Into :ps_especie_nf,
     :ps_serie_nf
From parametro
Where id_parametro = '1';

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o dos param$$HEX1$$ea00$$ENDHEX$$tros.")
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Param$$HEX1$$ea00$$ENDHEX$$tro n$$HEX1$$e300$$ENDHEX$$o localizado.",StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_verifica_serie_especie_cf (ref string ps_especie_cf, ref string ps_serie_cf);Select de_especie_cf, 
       de_serie_cf
Into :ps_especie_cf,
     :ps_serie_cf
From parametro
Where id_parametro = '1';

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o dos param$$HEX1$$ea00$$ENDHEX$$tros.")
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Param$$HEX1$$ea00$$ENDHEX$$tro n$$HEX1$$e300$$ENDHEX$$o localizado.",StopSign!)
		Return False
End Choose

Return True
end function

event close;call super::close;Destroy(ivo_Nota_Fiscal)
end event

event open;call super::open;dw_1.SetFocus()

ivo_Nota_Fiscal = Create Uo_Nota_Fiscal

ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_print;call super::ue_print;Long lvl_Cupom, &
     lvl_Filial
	  
String lvs_Especie_Cf, &
       lvs_Serie_Cf, &
		 lvs_Especie_Nf, &
		 lvs_Serie_Nf

dw_1.AcceptText()

lvl_Cupom      = dw_1.Object.nr_cf[1]
lvl_Filial     = dw_1.Object.cd_filial[1]
lvs_Especie_Cf = dw_1.Object.de_especie_cf[1]
lvs_Serie_Cf   = dw_1.Object.de_serie_cf[1]

If Not wf_Verifica_Serie_Especie_Nf(ref lvs_Especie_Nf, ref lvs_Serie_Nf) Then Return

If IsNull(lvl_cupom) OR lvl_cupom = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Digite o n$$HEX1$$fa00$$ENDHEX$$mero do cupom fiscal.")
	Return 
End If

ivo_Nota_Fiscal.of_Emitir_Nf_Anexa(lvl_Filial,lvl_Cupom,lvs_Especie_Cf,lvs_Serie_Cf,lvs_Especie_Nf,lvs_Serie_Nf)

dw_1.SetFocus()
dw_1.SelectText(1,10)

end event

event ue_printimmediate;call super::ue_printimmediate;Long lvl_Cupom, &
     lvl_Filial
	  
String lvs_Especie_Cf, &
       lvs_Serie_Cf, &
		 lvs_Especie_Nf, &
		 lvs_Serie_Nf

dw_1.AcceptText()

lvl_Cupom      = dw_1.Object.nr_cf[1]
lvl_Filial     = dw_1.Object.cd_filial[1]
lvs_Especie_Cf = dw_1.Object.de_especie_cf[1]
lvs_Serie_Cf   = dw_1.Object.de_serie_cf[1]

If Not wf_Verifica_Serie_Especie_Nf(lvs_Especie_Nf,lvs_Serie_Nf) Then Return

If IsNull(lvl_cupom) OR lvl_cupom = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Digite o n$$HEX1$$fa00$$ENDHEX$$mero do cupom fiscal a ser copiado.")
	Return 
End If

ivo_Nota_Fiscal.of_Emitir_Nf_Anexa(lvl_Filial,lvl_Cupom,lvs_Especie_Cf,lvs_Serie_Cf,lvs_Especie_Nf,lvs_Serie_Nf)

dw_1.SetFocus()
dw_1.SelectText(1,10)

end event

on w_ge042_emissao_nota_fiscal_anexa.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_ge042_emissao_nota_fiscal_anexa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;ivm_Menu.mf_Imprimir(True)

If Not gf_NFe_Liberada() Then
	Close(This)
	Return
End If
end event

type dw_1 from dc_uo_dw_base within w_ge042_emissao_nota_fiscal_anexa
integer y = 16
integer width = 2085
integer height = 400
boolean bringtotop = true
string dataobject = "dw_selecao_cupom_fiscal"
end type

event constructor;call super::constructor;String lvs_Especie_Cf, &
       lvs_Serie_Cf

Event ue_AddRow()

If Not wf_Verifica_Serie_Especie_Cf(ref lvs_Especie_Cf, ref lvs_Serie_Cf) Then Return
 
This.Object.cd_filial     [1] = gvo_parametro.of_filial()
This.Object.nm_filial     [1] = gvo_parametro.nm_fantasia_filial
This.Object.de_especie_cf [1] = lvs_Especie_Cf
This.Object.de_serie_cf   [1] = lvs_Serie_Cf

end event

