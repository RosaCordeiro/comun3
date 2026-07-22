HA$PBExportHeader$w_ge415_importa_produto.srw
forward
global type w_ge415_importa_produto from dc_w_response
end type
type cb_importar from commandbutton within w_ge415_importa_produto
end type
type gb_1 from groupbox within w_ge415_importa_produto
end type
type dw_1 from dc_uo_dw_base within w_ge415_importa_produto
end type
type pb_selecao from picturebutton within w_ge415_importa_produto
end type
type cb_cancelar from commandbutton within w_ge415_importa_produto
end type
type dw_2 from datawindow within w_ge415_importa_produto
end type
end forward

global type w_ge415_importa_produto from dc_w_response
integer width = 2094
integer height = 436
string title = "GE415 - Importa Produtos do Arquivo"
long backcolor = 80269524
cb_importar cb_importar
gb_1 gb_1
dw_1 dw_1
pb_selecao pb_selecao
cb_cancelar cb_cancelar
dw_2 dw_2
end type
global w_ge415_importa_produto w_ge415_importa_produto

type variables
dc_uo_ds_base ivo_produto

integer ivi_Filiais
end variables

forward prototypes
public function boolean wf_importa_arquivo (string as_arquivo)
end prototypes

public function boolean wf_importa_arquivo (string as_arquivo);Integer lvi_Retorno

lvi_Retorno = ivo_Produto.ImportFile(as_Arquivo)

If lvi_Retorno < 1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao importar o arquivo '" + Upper(as_Arquivo) + "'.~r" +&
						  "C$$HEX1$$f300$$ENDHEX$$digo: '" + String(lvi_Retorno) + "'.")
	Return False
End If

Return True
end function

on w_ge415_importa_produto.create
int iCurrent
call super::create
this.cb_importar=create cb_importar
this.gb_1=create gb_1
this.dw_1=create dw_1
this.pb_selecao=create pb_selecao
this.cb_cancelar=create cb_cancelar
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importar
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.pb_selecao
this.Control[iCurrent+5]=this.cb_cancelar
this.Control[iCurrent+6]=this.dw_2
end on

on w_ge415_importa_produto.destroy
call super::destroy
destroy(this.cb_importar)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.pb_selecao)
destroy(this.cb_cancelar)
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

ivo_Produto = Message.PowerObjectParm
end event

type pb_help from dc_w_response`pb_help within w_ge415_importa_produto
end type

type cb_importar from commandbutton within w_ge415_importa_produto
integer x = 1280
integer y = 216
integer width = 361
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Importar"
end type

event clicked;String lvs_Arquivo

dw_1.AcceptText()

lvs_Arquivo = dw_1.Object.nm_arquivo[1]

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a importa$$HEX2$$e700e300$$ENDHEX$$o do arquivo selecionado ?", Question!, YesNo!, 2) = 2 Then Return

If wf_Importa_Arquivo(lvs_Arquivo) Then
	CloseWithReturn(Parent, ivo_Produto)
End If 


end event

type gb_1 from groupbox within w_ge415_importa_produto
integer x = 23
integer y = 8
integer width = 2016
integer height = 184
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge415_importa_produto
integer x = 41
integer y = 68
integer width = 1856
integer height = 92
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge415_selecao_arquivo"
end type

type pb_selecao from picturebutton within w_ge415_importa_produto
integer x = 1893
integer y = 64
integer width = 110
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\localizar_arquivo.bmp"
alignment htextalign = left!
end type

event clicked;String lvs_Arquivo,&
	   lvs_Nome

Integer lvi_Retorno 

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
                     "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r"     + &
					 "Coluna B = Quantidade~r")

lvi_Retorno = GetFileOpenName("Sele$$HEX2$$e700e300$$ENDHEX$$o do Arquivo", lvs_Arquivo, lvs_Nome, "", "Text Files (*.TXT),*.TXT,")

If lvi_Retorno = 1 Then 
	dw_1.Object.nm_arquivo[1] = Upper(lvs_Arquivo)
	cb_importar.Enabled = True
Else
	cb_importar.Enabled = False
End If
	
	


end event

type cb_cancelar from commandbutton within w_ge415_importa_produto
integer x = 1673
integer y = 216
integer width = 366
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;Close(Parent)
end event

type dw_2 from datawindow within w_ge415_importa_produto
boolean visible = false
integer x = 101
integer y = 444
integer width = 1993
integer height = 720
integer taborder = 40
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
end type

