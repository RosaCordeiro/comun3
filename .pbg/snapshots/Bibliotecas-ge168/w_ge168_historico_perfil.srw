HA$PBExportHeader$w_ge168_historico_perfil.srw
forward
global type w_ge168_historico_perfil from dc_w_response_ok_cancela
end type
end forward

global type w_ge168_historico_perfil from dc_w_response_ok_cancela
string tag = "w_ge168_historico_perfil"
integer width = 2766
integer height = 1276
string title = "GE168 - Historico Perfil de Estoque"
long backcolor = 134217750
end type
global w_ge168_historico_perfil w_ge168_historico_perfil

type variables
str_ge168_parametros st_ge168_parametros
end variables

on w_ge168_historico_perfil.create
call super::create
end on

on w_ge168_historico_perfil.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;/*
Helpdesk: 1101188
Tipo: Melhoria
Autor: Jo$$HEX1$$e300$$ENDHEX$$o Lopes
Motivo: Cria$$HEX2$$e700e300$$ENDHEX$$o de relat$$HEX1$$f300$$ENDHEX$$rio com hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o de perfil de estoque
Adicionado no UE_POSTOPEN para desfazer a inser$$HEX2$$e700e300$$ENDHEX$$o de uma nova linha em branco
que o evento OPEN executa como padr$$HEX1$$e300$$ENDHEX$$o
*/

string ls_text

/* Recebe a Structure enviada pela tela anterior */
st_ge168_parametros = message.powerobjectparm

/* 
Converte o parametro LONG para STRING, pois a coluna envolvida no WHERE da
DW refer$$HEX1$$ea00$$ENDHEX$$ncia uma tabela cujo o valor da coluna $$HEX1$$e900$$ENDHEX$$ STRING
Consulta os dados TOP 10 da tabela dbo.historico_alteracao_tabela 
*/
dw_1.retrieve(string(st_ge168_parametros.cd_filial))

/* 
Mota dinamicamente a propriedade Text do objeto GB_1 
C$$HEX1$$f300$$ENDHEX$$digo da Filial + Nome Fantasia da Filial
*/
ls_text = string(st_ge168_parametros.cd_filial) + ' - ' + st_ge168_parametros.nm_fantasia
gb_1.text = 'Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o Perfil de Estoque [' + ls_text + ']'
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge168_historico_perfil
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge168_historico_perfil
string tag = "Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o Perfil de Estoque"
integer width = 2702
integer height = 1040
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge168_historico_perfil
integer width = 2647
integer height = 948
string dataobject = "dw_ge168_lista_hist_alt_pe"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge168_historico_perfil
integer x = 2414
integer y = 1068
end type

event cb_ok::clicked;call super::clicked;CloseWithReturn(Parent, st_ge168_parametros)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge168_historico_perfil
boolean visible = false
integer x = 1975
integer y = 1068
boolean enabled = false
end type

