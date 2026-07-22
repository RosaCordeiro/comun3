HA$PBExportHeader$uo_ge589_tarefas.sru
forward
global type uo_ge589_tarefas from userobject
end type
type st_observacao from statictext within uo_ge589_tarefas
end type
type em_proximo from editmask within uo_ge589_tarefas
end type
type st_proximo from statictext within uo_ge589_tarefas
end type
type em_ultimo from editmask within uo_ge589_tarefas
end type
type st_ultimo from statictext within uo_ge589_tarefas
end type
type st_tarefa from statictext within uo_ge589_tarefas
end type
end forward

global type uo_ge589_tarefas from userobject
integer width = 5275
integer height = 96
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_observacao st_observacao
em_proximo em_proximo
st_proximo st_proximo
em_ultimo em_ultimo
st_ultimo st_ultimo
st_tarefa st_tarefa
end type
global uo_ge589_tarefas uo_ge589_tarefas

type variables
String ivs_Erro

Long	 ivl_cd_tarefa
end variables

forward prototypes
public subroutine of_inicializa (string ps_tarefa)
public subroutine of_atualiza ()
end prototypes

public subroutine of_inicializa (string ps_tarefa);Choose Case ps_Tarefa
	Case "SUBIDA"
		ivl_cd_tarefa	 = 221
		st_ultimo.Text  = "$$HEX1$$da00$$ENDHEX$$ltimo envio em:"
		st_proximo.Text = "Pr$$HEX1$$f300$$ENDHEX$$ximo envio em:"
		
	Case "DESCIDA"
		ivl_cd_tarefa	 = 218
		st_ultimo.Text  = "$$HEX1$$da00$$ENDHEX$$ltimo retorno em:"
		st_proximo.Text = "Pr$$HEX1$$f300$$ENDHEX$$ximo retorno em:"
		
End Choose
end subroutine

public subroutine of_atualiza ();// 221 - EX - EXPORTA$$HEX2$$c700c300$$ENDHEX$$O BTAX
// 218 - EX - IMPORTA$$HEX2$$c700c300$$ENDHEX$$O BTAX

DateTime lvdh_Ultimo, lvdh_Proximo
String 	lvs_de_tarefa, lvs_de_observacao

SELECT dh_ultima_exec, dh_prox_exec, de_tarefa, de_observacao
Into	:lvdh_Ultimo, :lvdh_Proximo, :lvs_de_tarefa, :lvs_de_observacao
FROM	tarefa
WHERE	cd_tarefa = :ivl_cd_tarefa
USING SQLCA;

If SQLCA.SQLcode = -1 Then
	ivs_Erro = "Erro ao buscar dh_ultima_exec e dh_prox_exec da tarefa "+String(ivl_cd_tarefa)+".~r"+SQLCA.SqlErrText
	Return
End If

st_Tarefa.Text 	 = "Tarefa " + String(ivl_cd_tarefa) + " - " + lvs_de_tarefa
st_Observacao.Text = "Obs: " + lvs_de_observacao

em_Ultimo.Text  = String(lvdh_Ultimo,  "dd/mm/yyyy hh:mm:ss")
em_Proximo.Text = String(lvdh_Proximo, "dd/mm/yyyy hh:mm:ss")
end subroutine

on uo_ge589_tarefas.create
this.st_observacao=create st_observacao
this.em_proximo=create em_proximo
this.st_proximo=create st_proximo
this.em_ultimo=create em_ultimo
this.st_ultimo=create st_ultimo
this.st_tarefa=create st_tarefa
this.Control[]={this.st_observacao,&
this.em_proximo,&
this.st_proximo,&
this.em_ultimo,&
this.st_ultimo,&
this.st_tarefa}
end on

on uo_ge589_tarefas.destroy
destroy(this.st_observacao)
destroy(this.em_proximo)
destroy(this.st_proximo)
destroy(this.em_ultimo)
destroy(this.st_ultimo)
destroy(this.st_tarefa)
end on

event constructor;Choose Case ivl_cd_tarefa
	Case 221
		st_ultimo.Text  = "$$HEX1$$da00$$ENDHEX$$ltimo envio em:"
		st_proximo.Text = "Pr$$HEX1$$f300$$ENDHEX$$ximo envio em:"
		
	Case 218
		st_ultimo.Text  = "$$HEX1$$da00$$ENDHEX$$ltimo retorno em:"
		st_proximo.Text = "Pr$$HEX1$$f300$$ENDHEX$$ximo retorno em:"
		
End Choose
end event

type st_observacao from statictext within uo_ge589_tarefas
integer x = 4133
integer y = 16
integer width = 1093
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Obs: XXXXXXXXXXXXXXXXXXXXXXXX"
boolean focusrectangle = false
end type

type em_proximo from editmask within uo_ge589_tarefas
integer x = 3081
integer y = 4
integer width = 626
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "DD/MM/YYYY HH:MM:SS"
end type

type st_proximo from statictext within uo_ge589_tarefas
integer x = 2491
integer y = 16
integer width = 562
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Pr$$HEX1$$f300$$ENDHEX$$ximo xxxxx em:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_ultimo from editmask within uo_ge589_tarefas
integer x = 1719
integer y = 4
integer width = 626
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "DD/MM/YYYY HH:MM:SS"
end type

type st_ultimo from statictext within uo_ge589_tarefas
integer x = 1170
integer y = 20
integer width = 517
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "$$HEX1$$da00$$ENDHEX$$ltimo xxxxx em:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_tarefa from statictext within uo_ge589_tarefas
integer x = 9
integer y = 20
integer width = 1143
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Tarefa ### - XXXXXXXXXXXXXXXXXXX"
boolean focusrectangle = false
end type

