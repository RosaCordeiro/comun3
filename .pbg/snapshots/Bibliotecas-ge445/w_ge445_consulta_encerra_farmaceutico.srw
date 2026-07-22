HA$PBExportHeader$w_ge445_consulta_encerra_farmaceutico.srw
forward
global type w_ge445_consulta_encerra_farmaceutico from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge445_consulta_encerra_farmaceutico from dc_w_selecao_lista_relatorio
integer width = 3470
integer height = 1896
string title = "GE445 - Encerramento de Farmac$$HEX1$$ea00$$ENDHEX$$utico"
string menuname = "m_janelas"
long backcolor = 80269524
end type
global w_ge445_consulta_encerra_farmaceutico w_ge445_consulta_encerra_farmaceutico

type variables
uo_Filial ivo_Filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();String lvs_Filial

dw_1.AcceptText()

lvs_Filial = dw_1.GetText()

ivo_Filial.Of_Localiza_Filial(lvs_Filial) 

If ivo_Filial.Localizada Then
	dw_1.Object.nm_filial[1] = ivo_filial.nm_fantasia
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
End If


end subroutine

on w_ge445_consulta_encerra_farmaceutico.create
call super::create
if this.MenuName = "m_janelas" then this.MenuID = create m_janelas
end on

on w_ge445_consulta_encerra_farmaceutico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Filial = Create uo_Filial
end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dh_emissao[1] = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_preprint;call super::ue_preprint;String lvs_Data

DateTime lvdt_Emissao

lvdt_Emissao = dw_1.Object.dh_emissao[1]

lvs_Data = String(lvdt_Emissao, "dd/mm/yyyy")

dw_3.Object.st_emissao.Text = lvs_Data

Return AncestorReturnValue

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge445_consulta_encerra_farmaceutico
integer x = 73
integer y = 1244
integer width = 1637
integer height = 148
string dataobject = "dw_auxilio_visual"
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge445_consulta_encerra_farmaceutico
integer x = 37
integer y = 1172
integer width = 1728
integer height = 236
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aux$$HEX1$$ed00$$ENDHEX$$lio Visual"
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge445_consulta_encerra_farmaceutico
integer x = 27
integer y = 288
integer width = 3374
integer height = 1400
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge445_consulta_encerra_farmaceutico
integer x = 27
integer y = 20
integer width = 1568
integer height = 248
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge445_consulta_encerra_farmaceutico
integer x = 41
integer y = 80
integer width = 1536
integer height = 172
string dataobject = "dw_ge445_selecao"
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna
      
dw_1.AcceptText()
		 
If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "nm_filial" Then
		wf_localiza_filial()
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

SetNull(lvl_Nulo)

If dwo.Name = 'nm_filial' Then
	If IsNull(Data) or Trim(Data) = "" Then
		This.Object.Cd_Filial[1] = lvl_Nulo
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge445_consulta_encerra_farmaceutico
integer x = 55
integer y = 344
integer width = 3323
integer height = 1324
string dataobject = "dw_ge445_lista"
end type

event dw_2::ue_recuperar;//OverRide

Long lvl_Filial

DateTime lvdt_Emissao, &
			lvdt_Saldo

dw_1.AcceptText()

lvl_Filial		= dw_1.Object.cd_filial [1]
lvdt_Emissao	= dw_1.Object.dh_emissao[1]
lvdt_Saldo		= DateTime(gf_Primeiro_Dia_Mes(Date(lvdt_Emissao)))

If IsNull(lvl_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a filial corretamente.")
	dw_1.Event ue_Pos(1,"nm_filial")
	Return -1
End If

Return This.Retrieve(lvl_Filial, lvdt_Saldo, lvdt_Emissao)


end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge445_consulta_encerra_farmaceutico
integer x = 1970
integer y = 28
integer width = 905
integer height = 232
string dataobject = "dw_ge445_relatorio"
end type

