HA$PBExportHeader$dc_w_response.srw
forward
global type dc_w_response from dc_w_base
end type
type pb_help from picturebutton within dc_w_response
end type
end forward

global type dc_w_response from dc_w_base
integer width = 2395
integer height = 1344
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
pb_help pb_help
end type
global dc_w_response dc_w_response

type variables

end variables

forward prototypes
public subroutine wf_help (string ps_arquivo)
end prototypes

public subroutine wf_help (string ps_arquivo);ShowHelp( gvo_Aplicacao.ivs_Path_Manual, KeyWord!, ps_Arquivo )
end subroutine

on dc_w_response.create
int iCurrent
call super::create
this.pb_help=create pb_help
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_help
end on

on dc_w_response.destroy
call super::destroy
destroy(this.pb_help)
end on

event ue_preopen;// OverRide
Long lvl_Altura_Total, &
     lvl_Largura_Total, &
	  lvl_Altura_Janela, &
	  lvl_Largura_Janela

Environment lva

If GetEnvironment(lva) <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na identifica$$HEX2$$e700e300$$ENDHEX$$o do ambiente.", Information!)
	Return
End If

lvl_Altura_Total  = lva.ScreenHeight
lvl_Largura_Total = lva.ScreenWidth

lvl_Altura_Total  = PixelsToUnits(lvl_Altura_Total,  YPixelsToUnits!)
lvl_Largura_Total = PixelsToUnits(lvl_Largura_Total, XPixelsToUnits!)

lvl_Altura_Janela  = This.Height
lvl_Largura_Janela = This.Width

This.X = (lvl_Largura_Total - lvl_Largura_Janela) / 2
This.Y = (lvl_Altura_Total  - lvl_Altura_Janela)  / 2
end event

event open;call super::open;If IsValid( This ) Then
	pb_Help.Visible = False
End If
end event

type pb_help from picturebutton within dc_w_response
integer x = 50
integer y = 40
integer width = 142
integer height = 120
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\question_1.png"
alignment htextalign = left!
end type

