HA$PBExportHeader$w_ge521_consulta_nao_importadas.srw
forward
global type w_ge521_consulta_nao_importadas from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge521_consulta_nao_importadas from dc_w_selecao_lista_relatorio
integer width = 3264
integer height = 1584
string title = "GE521 - Documentos N$$HEX1$$e300$$ENDHEX$$o Importados (Mult)"
string menuname = "m_janelas"
end type
global w_ge521_consulta_nao_importadas w_ge521_consulta_nao_importadas

on w_ge521_consulta_nao_importadas.create
call super::create
if this.MenuName = "m_janelas" then this.MenuID = create m_janelas
end on

on w_ge521_consulta_nao_importadas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio		[1] = RelativeDate(Today(),-5)
dw_1.Object.dt_termino	[1] = RelativeDate(Today(),-1)
end event

event ue_preopen;call super::ue_preopen;MaxHeight = 1600
MaxWidth = 3300
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge521_consulta_nao_importadas
integer x = 73
integer y = 1244
integer width = 1637
integer height = 148
string dataobject = "dw_auxilio_visual"
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge521_consulta_nao_importadas
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

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge521_consulta_nao_importadas
integer y = 216
integer width = 3150
integer height = 1152
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge521_consulta_nao_importadas
integer width = 1842
integer height = 180
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge521_consulta_nao_importadas
integer x = 41
integer y = 80
integer width = 1838
integer height = 104
string dataobject = "dw_ge521_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge521_consulta_nao_importadas
integer y = 292
integer width = 3081
integer height = 1044
string title = "FI052 - Documentos N$$HEX1$$e300$$ENDHEX$$o Importados (Mult)"
string dataobject = "dw_ge521_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//OVERRIDE
DateTime lvdt_Inicio
DateTime lvdt_Termino
String lvs_Sql

dw_1.Accepttext( )
lvdt_Inicio 		= DateTime(dw_1.Object.dt_inicio[1])
lvdt_Termino 	= DateTime(dw_1.Object.dt_termino[1])

Return This.Retrieve(lvdt_Inicio,lvdt_Termino)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Cupom

dw_1.accepttext( )

lvs_Cupom = dw_1.Object.id_cupom [1]

If lvs_Cupom = 'N' Then
	This.Of_AppendWhere_SubQuery("nf.de_especie<>'CF'",12)
End If

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;String lvs_Filtro

If dw_2.rowcount() > 0 then
  	If  gvo_aplicacao.ivo_seguranca.cd_sistema = 'CR'  then
   	 	lvs_Filtro = "COMPRA"
        	dw_2.SetFilter("tipo = '"+ lvs_Filtro +"'")
		dw_2.Filter()
	End If	 
End If 


Return AncestorReturnValue


end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge521_consulta_nao_importadas
integer x = 2030
integer y = 28
integer width = 366
integer height = 176
end type

