HA$PBExportHeader$w_ge479_nivel_ocupacao_cd.srw
forward
global type w_ge479_nivel_ocupacao_cd from dc_w_consulta_lista
end type
end forward

global type w_ge479_nivel_ocupacao_cd from dc_w_consulta_lista
integer width = 1829
integer height = 856
string title = "GE479 - N$$HEX1$$ed00$$ENDHEX$$vel de Ocupa$$HEX2$$e700e300$$ENDHEX$$o do CD"
end type
global w_ge479_nivel_ocupacao_cd w_ge479_nivel_ocupacao_cd

forward prototypes
public function boolean wf_recupera_valores ()
end prototypes

public function boolean wf_recupera_valores ();Long ll_Qt_Vazio_Cont
Long ll_Qt_Utili_Cont
Long ll_Qt_Vazio_N_Cont
Long ll_Qt_Utili_N_Cont
Long ll_Parametro
 
select count( distinct f.cd_endereco )
	Into :ll_Qt_Vazio_Cont
From wms_endereco f
where f.cd_bairro in ('9')
	and f.id_flow_rack = 'N'
	and f.cd_endereco not in ( select cd_endereco from wms_localizacao )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a quantidade vazia de controlado. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

select count( distinct f.cd_endereco )
	Into :ll_Qt_Utili_Cont
From wms_endereco f 
where f.cd_bairro in ('9')
	and f.id_flow_rack = 'N'
	and f.cd_endereco in ( select cd_endereco from wms_localizacao )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a quantidade utilizada de controlado. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

select count( distinct f.cd_endereco )
	Into :ll_Qt_Vazio_N_Cont
From wms_endereco f
where f.cd_bairro in ('1')
	and f.id_flow_rack = 'N'
	and f.cd_endereco not in ( select cd_endereco from wms_localizacao )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a quantidade vazia de N$$HEX1$$c300$$ENDHEX$$O controlado. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

select count( distinct f.cd_endereco )
	Into :ll_Qt_Utili_N_Cont
From wms_endereco f
where f.cd_bairro in ('1')
	and f.id_flow_rack = 'N'
	and f.cd_endereco in ( select cd_endereco from wms_localizacao )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a quantidade utlizada de N$$HEX1$$c300$$ENDHEX$$O controlado. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

Select cast (vl_parametro as int)
	Into :ll_Parametro
From wms_parametro
Where cd_parametro in ('ID_CUSTO_ARMAZENAGEM_PALLET')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o parametro 'ID_CUSTO_ARMAZENAGEM_PALLET' na wms_parametro. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

dw_1.Object.Qt_Vazio_Controlado				[1] = ll_Qt_Vazio_Cont
dw_1.Object.Qt_Utilizado_Controlado			[1] = ll_Qt_Utili_Cont
dw_1.Object.Qt_Vazio_Nao_Controlado		[1] = ll_Qt_Vazio_N_Cont
dw_1.Object.Qt_Utilizado_Nao_Controlado	[1] = ll_Qt_Utili_N_Cont
dw_1.Object.Parametro							[1] = ll_Parametro

Return True
end function

on w_ge479_nivel_ocupacao_cd.create
call super::create
end on

on w_ge479_nivel_ocupacao_cd.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from dc_w_consulta_lista`dw_visual within w_ge479_nivel_ocupacao_cd
integer x = 37
integer y = 356
end type

type gb_aux_visual from dc_w_consulta_lista`gb_aux_visual within w_ge479_nivel_ocupacao_cd
integer x = 0
integer y = 284
end type

type dw_1 from dc_w_consulta_lista`dw_1 within w_ge479_nivel_ocupacao_cd
integer width = 1609
integer height = 508
string dataobject = "dw_ge479_lista_ocupacao"
boolean vscrollbar = false
end type

event dw_1::ue_recuperar;//OverRide

If wf_Recupera_Valores() Then
	Return 1
Else
	Return -1
End If
end event

event dw_1::constructor;call super::constructor;ivb_Selecao_Linhas = False
end event

type gb_1 from dc_w_consulta_lista`gb_1 within w_ge479_nivel_ocupacao_cd
integer width = 1705
integer height = 628
end type

