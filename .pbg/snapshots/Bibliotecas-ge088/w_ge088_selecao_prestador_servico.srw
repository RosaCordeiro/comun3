HA$PBExportHeader$w_ge088_selecao_prestador_servico.srw
forward
global type w_ge088_selecao_prestador_servico from dc_w_selecao_generica
end type
end forward

global type w_ge088_selecao_prestador_servico from dc_w_selecao_generica
int X=827
int Width=2839
int Height=1548
boolean TitleBar=true
string Title="GE088 - Sele$$HEX2$$e700e300$$ENDHEX$$o dos Pretadores de Servi$$HEX1$$e700$$ENDHEX$$os do Clube"
long BackColor=80269524
end type
global w_ge088_selecao_prestador_servico w_ge088_selecao_prestador_servico

type variables
uo_prestador_servico ivo_prestador_servico


end variables

on w_ge088_selecao_prestador_servico.create
call super::create
end on

on w_ge088_selecao_prestador_servico.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

lvs_Parametro = Message.StringParm	

If lvs_Parametro <> "" Then
	dw_1.Object.de_localizacao[1] = lvs_Parametro
	ivb_Pesquisa_Direta = True
End If

end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge088_selecao_prestador_servico
int X=23
int Y=188
int Width=2766
int Height=1116
string Text="Lista de Prestadores"
long BackColor=80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge088_selecao_prestador_servico
int X=23
int Y=4
int Width=1477
int Height=168
string Text="Par$$HEX1$$e200$$ENDHEX$$metro de Sele$$HEX2$$e700e300$$ENDHEX$$o"
long BackColor=80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge088_selecao_prestador_servico
int X=50
int Y=60
int Width=1435
int Height=100
boolean BringToTop=true
string DataObject="dw_ge088_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge088_selecao_prestador_servico
int X=46
int Y=236
int Width=2720
int Height=1032
boolean BringToTop=true
string DataObject="dw_ge088_lista_prestador"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Prestador

dw_1.AcceptText()

lvs_Prestador = Trim(dw_1.Object.de_localizacao[1])

If lvs_Prestador <> "" Then
	This.of_AppendWhere("nm_prestador like '" + lvs_Prestador + "%'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge088_selecao_prestador_servico
int X=2025
int Y=1332
boolean BringToTop=true
end type

event cb_selecionar::clicked;Long lvl_Linha, &
     lvl_Prestador

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Prestador = dw_2.Object.cd_prestador[lvl_Linha]
	CloseWithReturn(Parent, lvl_Prestador)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um prestador.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge088_selecao_prestador_servico
int X=2414
int Y=1332
boolean BringToTop=true
end type

event cb_cancelar::clicked;STRING lvs_Centro_Custo

SetNull(lvs_Centro_Custo)

CloseWithReturn(Parent, lvs_Centro_Custo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge088_selecao_prestador_servico
int X=1637
int Y=1332
boolean BringToTop=true
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge088_selecao_prestador_servico
int X=37
int Y=1336
int Width=1426
boolean BringToTop=true
long BackColor=80269524
end type

