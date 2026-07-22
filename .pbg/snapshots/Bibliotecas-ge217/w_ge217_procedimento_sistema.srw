HA$PBExportHeader$w_ge217_procedimento_sistema.srw
forward
global type w_ge217_procedimento_sistema from dc_w_selecao_generica
end type
end forward

global type w_ge217_procedimento_sistema from dc_w_selecao_generica
integer width = 3017
integer height = 1536
string title = "GE217 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Procedimento de Sistema"
end type
global w_ge217_procedimento_sistema w_ge217_procedimento_sistema

type variables
uo_ge217_procedimento_sistema ivo_procedimento_sistema
end variables

forward prototypes
public function string wf_localiza_sistema (string ps_sistema)
end prototypes

public function string wf_localiza_sistema (string ps_sistema);STRING lvs_Sistema

Select nm_sistema Into :lvs_Sistema
From sistema
Where cd_sistema = :ps_sistema
Using SqlCa;

If Sqlca.Sqlcode = -1 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao localizar sistema.',StopSign!,Ok!)	
	SetNull(lvs_Sistema)
End If	

Return lvs_Sistema
end function

on w_ge217_procedimento_sistema.create
call super::create
end on

on w_ge217_procedimento_sistema.destroy
call super::destroy
end on

event open;call super::open;ivo_procedimento_sistema = Create uo_ge217_procedimento_sistema


uo_ge217_Parametro_Proc_Sistema lvo_Parametro
lvo_Parametro = Create uo_ge217_Parametro_Proc_Sistema

lvo_Parametro = Message.PowerObjectParm

dw_1.Object.Cd_Sistema[1] = lvo_Parametro.ivs_Sistema
dw_1.Object.Nm_Sistema[1] = Wf_Localiza_Sistema(lvo_Parametro.ivs_Sistema)

If Trim(lvo_Parametro.ivs_Nome) <> "" Then
	dw_1.Object.De_Procedimento[1] = lvo_Parametro.ivs_Nome
   	ivb_Pesquisa_Direta = True
End If	

Destroy(lvo_Parametro)
end event

event close;call super::close;Destroy(ivo_procedimento_sistema)
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge217_procedimento_sistema
integer x = 37
integer y = 288
integer width = 2944
integer height = 1012
long backcolor = 67108864
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge217_procedimento_sistema
integer width = 1751
integer height = 272
long backcolor = 67108864
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge217_procedimento_sistema
integer width = 1691
integer height = 168
string dataobject = "dw_ge217_selecao_procedimento"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge217_procedimento_sistema
integer x = 73
integer y = 360
integer width = 2880
integer height = 924
string dataobject = "dw_ge217_lista_procedimento"
end type

event dw_2::ue_recuperar;//OverRide

String lvs_Sistema,&
		lvs_Procedimento
		
lvs_Sistema 		= dw_1.Object.cd_sistema			[1]
lvs_Procedimento 	= dw_1.Object.de_procedimento	[1]

If Not IsNull(lvs_Procedimento) Then
	This.of_AppendWhere("de_procedimento like '" + lvs_Procedimento + "%'")
End If

Return Retrieve(lvs_Sistema)
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge217_procedimento_sistema
integer x = 2217
end type

event cb_selecionar::clicked;call super::clicked;Long  lvl_Linha

String lvs_Procedimento

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	
	lvs_Procedimento = dw_2.Object.Cd_Procedimento[lvl_Linha]
	
	CloseWithReturn(Parent, lvs_Procedimento)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um procedimento.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge217_procedimento_sistema
integer x = 2610
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Procedimento

SetNull(lvs_Procedimento)

CloseWithReturn(Parent, lvs_Procedimento)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge217_procedimento_sistema
integer x = 1778
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge217_procedimento_sistema
boolean visible = false
integer x = 37
integer y = 1332
integer width = 1138
long backcolor = 67108864
end type

