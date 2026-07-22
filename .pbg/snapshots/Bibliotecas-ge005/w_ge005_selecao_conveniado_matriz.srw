HA$PBExportHeader$w_ge005_selecao_conveniado_matriz.srw
forward
global type w_ge005_selecao_conveniado_matriz from dc_w_selecao_generica
end type
end forward

global type w_ge005_selecao_conveniado_matriz from dc_w_selecao_generica
integer x = 727
integer y = 376
integer width = 2720
integer height = 1656
string title = "GE005 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Conveniados"
end type
global w_ge005_selecao_conveniado_matriz w_ge005_selecao_conveniado_matriz

type variables
uo_conveniado ivo_conveniado
end variables

on w_ge005_selecao_conveniado_matriz.create
call super::create
end on

on w_ge005_selecao_conveniado_matriz.destroy
call super::destroy
end on

event open;call super::open;SetPointer(HourGlass!)

uo_Convenio lvo_Convenio

lvo_Convenio   = Create uo_Convenio
ivo_Conveniado = Create uo_Conveniado

ivo_Conveniado = Message.PowerObjectParm

dw_1.Object.Cd_Convenio[1] = ivo_Conveniado.ivl_Convenio

lvo_Convenio.of_Localiza_Convenio(String(ivo_Conveniado.ivl_Convenio))

If lvo_Convenio.Localizado Then dw_1.Object.Nm_Convenio[1] = lvo_Convenio.Nm_Fantasia
	
If Trim(ivo_Conveniado.ivs_Matricula) <> "" Then
	dw_1.Object.Cd_Conveniado[1] = ivo_Conveniado.ivs_Matricula
	ivb_Pesquisa_Direta = True
ElseIf Trim(ivo_Conveniado.ivs_Nome) <> "" Then
	dw_1.Object.Nm_Conveniado[1] = ivo_Conveniado.ivs_Nome     
	ivb_Pesquisa_Direta = True
ElseIf Trim(ivo_Conveniado.ivs_CPF) <> "" Then
	dw_1.Object.Nr_CPF[1] = ivo_Conveniado.ivs_CPF
	ivb_Pesquisa_Direta = True	
End If

Destroy(lvo_Convenio)

SetPointer(Arrow!)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge005_selecao_conveniado_matriz
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge005_selecao_conveniado_matriz
integer x = 23
integer y = 360
integer width = 2656
integer height = 1048
long backcolor = 80269524
string text = "Lista de Conveniados"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge005_selecao_conveniado_matriz
integer x = 23
integer y = 4
integer width = 1819
integer height = 344
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge005_selecao_conveniado_matriz
integer x = 41
integer y = 72
integer width = 1792
integer height = 260
string dataobject = "dw_ge005_selecao_matriz"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge005_selecao_conveniado_matriz
integer x = 50
integer y = 408
integer width = 2606
integer height = 980
string dataobject = "dw_ge005_lista_matriz"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String 	lvs_Sql, &
       		lvs_Matricula, &
		 	lvs_Nome, &
			lvs_CPF
		 
Long lvl_Convenio

dw_1.AcceptText()

lvl_Convenio  	= dw_1.Object.Cd_Convenio[1]
lvs_Matricula 	= dw_1.Object.Cd_Conveniado[1]
lvs_Nome      	= dw_1.Object.Nm_Conveniado[1] 
lvs_CPF 			= dw_1.Object.Nr_CPF[1]

This.of_AppendWhere("c.cd_convenio = " + String(lvl_Convenio))

If Trim(lvs_Matricula) <> "" Then
	lvs_Sql = "c.cd_conveniado like '" + lvs_Matricula + "%'"
	This.of_AppendWhere(lvs_SQL)
End If

If Trim(lvs_Nome) <> "" Then
	lvs_Sql = "c.nm_conveniado like '" + lvs_Nome + "%'"
	This.of_AppendWhere(lvs_SQL)	
End If

If Trim(lvs_CPF) <> "" Then
	lvs_Sql = "c.nr_cpf like '" + lvs_CPF + "%'"
	This.of_AppendWhere(lvs_SQL)	
End If

If Trim(lvs_SQL) <> "" Then
	If ivo_Conveniado.ivl_Filial_Parametro <> ivo_Conveniado.ivl_Filial_Matriz Then
		lvs_SQL = "not exists (select *" + &
					 "            from bloqueio b," + &
					 "                 motivo_bloqueio m" + &
					 "            where b.cd_convenio        = c.cd_convenio" + &
					 "              and b.cd_conveniado      = c.cd_conveniado" + &
					 "              and b.id_tipo_bloqueio   <> 'DCO'" + &
					 "              and b.cd_motivo_bloqueio = m.cd_motivo_bloqueio" + &
					 "              and b.dh_liberacao is null" + &
					 "              and m.id_permite_visualizacao = 'N')"
		This.of_AppendWhere(lvs_SQL)					 
	End If	
	Return 1
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a matr$$HEX1$$ed00$$ENDHEX$$cula ou o nome do conveniado ou o CPF para consulta.",StopSign!)
	dw_1.SetColumn("cd_conveniado")	
	dw_1.SetFocus()
	Return -1
End If
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge005_selecao_conveniado_matriz
integer x = 1920
integer y = 1436
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Conveniado

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Conveniado							= dw_2.Object.Cd_Conveniado[lvl_Linha]
	ivo_conveniado.cd_Conveniado		= lvs_Conveniado
	ivo_conveniado.nm_Conveniado	= dw_2.Object.Nm_Conveniado[lvl_Linha]
	ivo_conveniado.cd_Convenio		= dw_1.Object.Cd_Convenio[ 1 ]
	CloseWithReturn(Parent, ivo_conveniado)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um conveniado na lista.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge005_selecao_conveniado_matriz
integer x = 2309
integer y = 1436
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Conveniado

SetNull(lvs_Conveniado)

CloseWithReturn(Parent, lvs_Conveniado)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge005_selecao_conveniado_matriz
integer x = 1513
integer y = 1436
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge005_selecao_conveniado_matriz
integer x = 27
integer y = 1448
integer width = 1449
long backcolor = 80269524
end type

