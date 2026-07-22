HA$PBExportHeader$w_ge418_gera_vendas_promocao.srw
forward
global type w_ge418_gera_vendas_promocao from dc_w_consulta_lista
end type
type gb_2 from groupbox within w_ge418_gera_vendas_promocao
end type
type sle_1 from singlelineedit within w_ge418_gera_vendas_promocao
end type
type pb_1 from picturebutton within w_ge418_gera_vendas_promocao
end type
type dw_2 from dc_uo_dw_base within w_ge418_gera_vendas_promocao
end type
type cb_1 from commandbutton within w_ge418_gera_vendas_promocao
end type
end forward

global type w_ge418_gera_vendas_promocao from dc_w_consulta_lista
integer width = 2674
integer height = 1684
string title = "GE418 - Gera$$HEX2$$e700e300$$ENDHEX$$o de Vendas por Promo$$HEX2$$e700e300$$ENDHEX$$o"
gb_2 gb_2
sle_1 sle_1
pb_1 pb_1
dw_2 dw_2
cb_1 cb_1
end type
global w_ge418_gera_vendas_promocao w_ge418_gera_vendas_promocao

forward prototypes
public function boolean wf_valida_nome (string ps_nome_arquivo)
end prototypes

public function boolean wf_valida_nome (string ps_nome_arquivo);Integer lvi_retorno

If IsNull(ps_nome_arquivo) or Trim(ps_nome_arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor escolher o arquivo a ser salvo.", Information!, Ok!)
	sle_1.SetFocus()
	Return False
End If

If RightA(ps_nome_arquivo, 4) <> '.xls' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O tipo do arquivo escolhido deve ser planilha Excel (.xls)", Information!, Ok!)
	sle_1.SetFocus()
	Return False
End If

If FileExists(ps_nome_arquivo) Then
	lvi_retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo informado j$$HEX1$$e100$$ENDHEX$$ existe. Deseja continuar?", Question!, YesNo!, 2)
	If lvi_retorno = 2 Then
		sle_1.SetFocus()
		Return False
	End If
End If

Return True
end function

on w_ge418_gera_vendas_promocao.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.sle_1=create sle_1
this.pb_1=create pb_1
this.dw_2=create dw_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_1
end on

on w_ge418_gera_vendas_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.sle_1)
destroy(this.pb_1)
destroy(this.dw_2)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;//sle_1.Text = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "") + &
//             'promocao.xls'
sle_1.Text = 'C:\promocao.xls'

end event

type dw_visual from dc_w_consulta_lista`dw_visual within w_ge418_gera_vendas_promocao
end type

type gb_aux_visual from dc_w_consulta_lista`gb_aux_visual within w_ge418_gera_vendas_promocao
end type

type dw_1 from dc_w_consulta_lista`dw_1 within w_ge418_gera_vendas_promocao
integer x = 27
integer y = 248
integer width = 2565
integer height = 1208
string dataobject = "dw_ge418_selecao_analise"
end type

type gb_1 from dc_w_consulta_lista`gb_1 within w_ge418_gera_vendas_promocao
integer x = 14
integer y = 200
integer width = 2610
integer height = 1288
integer taborder = 60
end type

type gb_2 from groupbox within w_ge418_gera_vendas_promocao
integer x = 14
integer width = 2130
integer height = 204
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Diret$$HEX1$$f300$$ENDHEX$$rio e Arquivo"
borderstyle borderstyle = styleraised!
end type

type sle_1 from singlelineedit within w_ge418_gera_vendas_promocao
integer x = 50
integer y = 72
integer width = 1861
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_ge418_gera_vendas_promocao
integer x = 1957
integer y = 72
integer width = 133
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\localizar_arquivo.bmp"
alignment htextalign = left!
end type

event clicked;SetPointer(HourGlass!)

Integer lvi_retorno
String lvs_default, lvs_escolha

lvs_default = sle_1.text

lvi_retorno = GetFileSaveName('Arquivo', lvs_default, lvs_escolha, 'xls', 'Planilha Excel (*.xls),*.xls')

If lvi_retorno = 0 Then
	Return
End If

If wf_valida_nome(lvs_default) Then
	sle_1.Text = lvs_default
End If
end event

type dw_2 from dc_uo_dw_base within w_ge418_gera_vendas_promocao
integer x = 2702
integer y = 32
integer width = 850
integer height = 1112
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge418_vendas_promocao"
end type

type cb_1 from commandbutton within w_ge418_gera_vendas_promocao
integer x = 2222
integer y = 92
integer width = 398
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salvar em Excel"
end type

event clicked;SetPointer(HourGlass!)

Long lvl_numero_promocao, lvl_linha, lvl_linha_dw1
Integer lvi_retorno
uo_periodo lvo_periodo

If Not wf_valida_nome(sle_1.Text) Then
	Return
End If

dw_1.AcceptText()

lvl_linha_dw1 = dw_1.GetRow()

If lvl_linha_dw1 < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor escolher uma promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!, Ok!)
	Return
End If

lvl_numero_promocao = dw_1.Object.cd_promocao_sos[lvl_linha_dw1]

lvo_periodo = Create uo_periodo

OpenWithParm(w_ge418_selecao_periodo, String(lvl_numero_promocao))

lvo_periodo = Message.PowerObjectParm

If IsNull(lvo_periodo.ivdt_inicio) Then
	Return
End If

lvo_periodo.ivdt_inicio = DateTime(Date(String(lvo_periodo.ivdt_inicio, 'dd/mm/yyyy')))
lvo_periodo.ivdt_fim    = DateTime(Date(String(lvo_periodo.ivdt_fim, 'dd/mm/yyyy')))

lvl_linha = dw_2.Retrieve(lvl_numero_promocao, lvo_periodo.ivdt_inicio, lvo_periodo.ivdt_fim)

If lvl_linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foram encontradas informa$$HEX2$$e700f500$$ENDHEX$$es de venda para os produtos desta promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!, Ok!)
	Return
End If

lvi_retorno = dw_2.SaveAs(sle_1.Text, Excel5!, True)

If lvi_retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao salvar o arquivo. Confira o nome e tente novamente.", StopSign!, Ok!)
	Return
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso.",Information!,Ok!)
End If

lvi_retorno = dw_1.Update()
If lvi_retorno = 1 Then
	Commit;
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de $$HEX1$$fa00$$ENDHEX$$ltima an$$HEX1$$e100$$ENDHEX$$lise.", StopSign!, Ok!)
	Rollback;
End If

Destroy(lvo_Periodo)
end event

