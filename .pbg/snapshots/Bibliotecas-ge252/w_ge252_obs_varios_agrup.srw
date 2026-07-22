HA$PBExportHeader$w_ge252_obs_varios_agrup.srw
forward
global type w_ge252_obs_varios_agrup from w_ge252_observacao
end type
type st_alerta from statictext within w_ge252_obs_varios_agrup
end type
end forward

global type w_ge252_obs_varios_agrup from w_ge252_observacao
st_alerta st_alerta
end type
global w_ge252_obs_varios_agrup w_ge252_obs_varios_agrup

on w_ge252_obs_varios_agrup.create
int iCurrent
call super::create
this.st_alerta=create st_alerta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_alerta
end on

on w_ge252_obs_varios_agrup.destroy
call super::destroy
destroy(this.st_alerta)
end on

event open;call super::open;//Integer	li_pos_ini, li_pos_fim
//Long		ll_qtd_agrup
//
//li_pos_fim = Pos (is_obs, '>>', 1)
//
//If li_pos_fim = 0 then Return
//
//li_pos_ini = Pos (Left (is_obs, li_pos_fim), '<<', 1)
//
//If li_pos_ini = 0 then Return
//
//ll_qtd_agrup = Long (Mid (is_obs, li_pos_ini + 2, li_pos_fim - (li_pos_ini + 2)))
//
//is_obs = Mid (is_obs, li_pos_fim + 2)
//
//If ll_qtd_agrup > 1 then
//	st_alerta.Visible = True
//else
//	st_alerta.Visible = False
//End if
end event

type pb_help from w_ge252_observacao`pb_help within w_ge252_obs_varios_agrup
end type

type gb_1 from w_ge252_observacao`gb_1 within w_ge252_obs_varios_agrup
integer height = 340
end type

type dw_1 from w_ge252_observacao`dw_1 within w_ge252_obs_varios_agrup
integer y = 56
integer height = 264
end type

type cb_ok from w_ge252_observacao`cb_ok within w_ge252_obs_varios_agrup
end type

type cb_cancelar from w_ge252_observacao`cb_cancelar within w_ge252_obs_varios_agrup
end type

type st_alerta from statictext within w_ge252_obs_varios_agrup
integer x = 27
integer y = 356
integer width = 1408
integer height = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "ATEN$$HEX2$$c700c300$$ENDHEX$$O: Esta mensagem ser$$HEX1$$e100$$ENDHEX$$ registrada para todos os agrupamentos marcados para serem resolvidos!"
boolean focusrectangle = false
end type

