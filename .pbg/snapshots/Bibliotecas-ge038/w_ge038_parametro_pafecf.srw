HA$PBExportHeader$w_ge038_parametro_pafecf.srw
forward
global type w_ge038_parametro_pafecf from window
end type
type st_7 from statictext within w_ge038_parametro_pafecf
end type
type em_cpf_cnpj from editmask within w_ge038_parametro_pafecf
end type
type em_ano_ini from editmask within w_ge038_parametro_pafecf
end type
type st_5 from statictext within w_ge038_parametro_pafecf
end type
type em_mes_ini from editmask within w_ge038_parametro_pafecf
end type
type st_2 from statictext within w_ge038_parametro_pafecf
end type
type rb_completa from radiobutton within w_ge038_parametro_pafecf
end type
type rb_normal from radiobutton within w_ge038_parametro_pafecf
end type
type rb_cv5795 from radiobutton within w_ge038_parametro_pafecf
end type
type rb_ac0908 from radiobutton within w_ge038_parametro_pafecf
end type
type rb_ac1704 from radiobutton within w_ge038_parametro_pafecf
end type
type cb_confirma from commandbutton within w_ge038_parametro_pafecf
end type
type cb_cancela from commandbutton within w_ge038_parametro_pafecf
end type
type st_1 from statictext within w_ge038_parametro_pafecf
end type
type st_22 from statictext within w_ge038_parametro_pafecf
end type
type st_23 from statictext within w_ge038_parametro_pafecf
end type
type em_ecf_final from editmask within w_ge038_parametro_pafecf
end type
type em_ecf_inicial from editmask within w_ge038_parametro_pafecf
end type
type st_ecf from statictext within w_ge038_parametro_pafecf
end type
type em_coo_final from editmask within w_ge038_parametro_pafecf
end type
type em_coo_inicial from editmask within w_ge038_parametro_pafecf
end type
type st_coo from statictext within w_ge038_parametro_pafecf
end type
type dw_1 from dc_uo_dw_base within w_ge038_parametro_pafecf
end type
type st_21 from statictext within w_ge038_parametro_pafecf
end type
type em_reducao_inicial from editmask within w_ge038_parametro_pafecf
end type
type st_reducao_final from statictext within w_ge038_parametro_pafecf
end type
type em_reducao_final from editmask within w_ge038_parametro_pafecf
end type
type rb_arquivo from radiobutton within w_ge038_parametro_pafecf
end type
type rb_ecf from radiobutton within w_ge038_parametro_pafecf
end type
type em_data_final from editmask within w_ge038_parametro_pafecf
end type
type st_3 from statictext within w_ge038_parametro_pafecf
end type
type em_data_inicial from editmask within w_ge038_parametro_pafecf
end type
type gb_1 from groupbox within w_ge038_parametro_pafecf
end type
type gb_2 from groupbox within w_ge038_parametro_pafecf
end type
end forward

global type w_ge038_parametro_pafecf from window
integer x = 1010
integer y = 640
integer width = 2295
integer height = 932
boolean titlebar = true
string title = "GE038 - Par$$HEX1$$e200$$ENDHEX$$metros Fun$$HEX2$$e700e300$$ENDHEX$$o PAF-ECF"
windowtype windowtype = response!
long backcolor = 80269524
st_7 st_7
em_cpf_cnpj em_cpf_cnpj
em_ano_ini em_ano_ini
st_5 st_5
em_mes_ini em_mes_ini
st_2 st_2
rb_completa rb_completa
rb_normal rb_normal
rb_cv5795 rb_cv5795
rb_ac0908 rb_ac0908
rb_ac1704 rb_ac1704
cb_confirma cb_confirma
cb_cancela cb_cancela
st_1 st_1
st_22 st_22
st_23 st_23
em_ecf_final em_ecf_final
em_ecf_inicial em_ecf_inicial
st_ecf st_ecf
em_coo_final em_coo_final
em_coo_inicial em_coo_inicial
st_coo st_coo
dw_1 dw_1
st_21 st_21
em_reducao_inicial em_reducao_inicial
st_reducao_final st_reducao_final
em_reducao_final em_reducao_final
rb_arquivo rb_arquivo
rb_ecf rb_ecf
em_data_final em_data_final
st_3 st_3
em_data_inicial em_data_inicial
gb_1 gb_1
gb_2 gb_2
end type
global w_ge038_parametro_pafecf w_ge038_parametro_pafecf

type variables
s_ge038_parametro_pafecf ivs_Parametro
end variables

on w_ge038_parametro_pafecf.create
this.st_7=create st_7
this.em_cpf_cnpj=create em_cpf_cnpj
this.em_ano_ini=create em_ano_ini
this.st_5=create st_5
this.em_mes_ini=create em_mes_ini
this.st_2=create st_2
this.rb_completa=create rb_completa
this.rb_normal=create rb_normal
this.rb_cv5795=create rb_cv5795
this.rb_ac0908=create rb_ac0908
this.rb_ac1704=create rb_ac1704
this.cb_confirma=create cb_confirma
this.cb_cancela=create cb_cancela
this.st_1=create st_1
this.st_22=create st_22
this.st_23=create st_23
this.em_ecf_final=create em_ecf_final
this.em_ecf_inicial=create em_ecf_inicial
this.st_ecf=create st_ecf
this.em_coo_final=create em_coo_final
this.em_coo_inicial=create em_coo_inicial
this.st_coo=create st_coo
this.dw_1=create dw_1
this.st_21=create st_21
this.em_reducao_inicial=create em_reducao_inicial
this.st_reducao_final=create st_reducao_final
this.em_reducao_final=create em_reducao_final
this.rb_arquivo=create rb_arquivo
this.rb_ecf=create rb_ecf
this.em_data_final=create em_data_final
this.st_3=create st_3
this.em_data_inicial=create em_data_inicial
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_7,&
this.em_cpf_cnpj,&
this.em_ano_ini,&
this.st_5,&
this.em_mes_ini,&
this.st_2,&
this.rb_completa,&
this.rb_normal,&
this.rb_cv5795,&
this.rb_ac0908,&
this.rb_ac1704,&
this.cb_confirma,&
this.cb_cancela,&
this.st_1,&
this.st_22,&
this.st_23,&
this.em_ecf_final,&
this.em_ecf_inicial,&
this.st_ecf,&
this.em_coo_final,&
this.em_coo_inicial,&
this.st_coo,&
this.dw_1,&
this.st_21,&
this.em_reducao_inicial,&
this.st_reducao_final,&
this.em_reducao_final,&
this.rb_arquivo,&
this.rb_ecf,&
this.em_data_final,&
this.st_3,&
this.em_data_inicial,&
this.gb_1,&
this.gb_2}
end on

on w_ge038_parametro_pafecf.destroy
destroy(this.st_7)
destroy(this.em_cpf_cnpj)
destroy(this.em_ano_ini)
destroy(this.st_5)
destroy(this.em_mes_ini)
destroy(this.st_2)
destroy(this.rb_completa)
destroy(this.rb_normal)
destroy(this.rb_cv5795)
destroy(this.rb_ac0908)
destroy(this.rb_ac1704)
destroy(this.cb_confirma)
destroy(this.cb_cancela)
destroy(this.st_1)
destroy(this.st_22)
destroy(this.st_23)
destroy(this.em_ecf_final)
destroy(this.em_ecf_inicial)
destroy(this.st_ecf)
destroy(this.em_coo_final)
destroy(this.em_coo_inicial)
destroy(this.st_coo)
destroy(this.dw_1)
destroy(this.st_21)
destroy(this.em_reducao_inicial)
destroy(this.st_reducao_final)
destroy(this.em_reducao_final)
destroy(this.rb_arquivo)
destroy(this.rb_ecf)
destroy(this.em_data_final)
destroy(this.st_3)
destroy(this.em_data_inicial)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;
//em_data_inicial.text = String(Today(),'dd/mm/yyyy')
//em_data_final.text   = String(Today(),'dd/mm/yyyy')

ivs_Parametro = Message.PowerObjectParm

If ivs_parametro.id_cpf <> 'S' Then
	em_data_inicial.text = String(Today(),'dd/mm/yyyy')
	em_data_final.text   = String(Today(),'dd/mm/yyyy')
Else
	em_mes_ini.text  = String(Month(Today()))
	em_ano_ini.text   = String(Year(Today()))
	em_mes_ini.enabled = True
	em_ano_ini.enabled = True
	em_cpf_cnpj.enabled = True
	em_mes_ini.SetFocus()
End If

Choose Case MidA(ivs_Parametro.id_Destino,1,1)
	Case 'S'
		rb_ecf.Enabled 			= True
		rb_arquivo.Enabled 	= True

	Case 'N'		
		If MidA(ivs_Parametro.id_Destino,2,1) = 'A' Then //Tipo Arquivo
			rb_ecf.Checked 		= False
			rb_arquivo.Checked 	= True
		Else
			rb_ecf.Checked			= True
			rb_arquivo.Checked 	= False
		End If
		rb_ecf.Enabled 			= False
		rb_arquivo.Enabled 	= False
			
	Case 'M'
		rb_ecf.Enabled 			= False
		rb_arquivo.Enabled 	= False
		rb_ac0908.Visible 		= True	
		rb_ac0908.Enabled 	= True
		rb_cv5795.Visible 		= True	
		rb_cv5795.Enabled 	= True
		rb_ac1704.Visible 		= True	
		rb_ac1704.Enabled 	= True		
		rb_Normal.Checked 	= False
		rb_cv5795.Checked 	= True	
		
End Choose

If ivs_Parametro.id_Leitura = 'S' Then
	rb_normal.Enabled = True
	rb_completa.Enabled = True
Else
	rb_normal.Enabled = False
	rb_completa.Enabled = False	
End If

If ivs_Parametro.id_periodo = 'S' Then
	em_data_inicial.Enabled = True
	em_data_final.Enabled = True
End If	

If ivs_Parametro.id_coo = 'S' Then
	em_coo_inicial.Enabled = True
	em_coo_final.Enabled = True
End If	

If ivs_Parametro.id_ecf = 'S' Then
	em_ecf_inicial.Enabled = True
	em_ecf_final.Enabled = True
End If	

If ivs_Parametro.id_reducao = 'S' Then
	em_reducao_inicial.Enabled = True
	em_reducao_final.Enabled = True
End If	

If em_data_inicial.Enabled Then 
	em_data_inicial.SetFocus()
Else
	If em_coo_inicial.Enabled Then
		em_coo_inicial.SetFocus()
	Else
		If em_ecf_inicial.Enabled Then
			em_ecf_inicial.SetFocus()
		Else
			If em_reducao_inicial.Enabled Then
				em_reducao_inicial.SetFocus()
			Else	
				rb_ecf.SetFocus()				
			End If	
		End If
	End If
End If	

end event

type st_7 from statictext within w_ge038_parametro_pafecf
integer x = 37
integer y = 604
integer width = 334
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "CPF/CNPJ:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_cpf_cnpj from editmask within w_ge038_parametro_pafecf
integer x = 375
integer y = 592
integer width = 937
integer height = 84
integer taborder = 130
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type em_ano_ini from editmask within w_ge038_parametro_pafecf
integer x = 571
integer y = 480
integer width = 192
integer height = 84
integer taborder = 100
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_5 from statictext within w_ge038_parametro_pafecf
integer x = 485
integer y = 488
integer width = 87
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_mes_ini from editmask within w_ge038_parametro_pafecf
integer x = 375
integer y = 480
integer width = 105
integer height = 84
integer taborder = 90
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_2 from statictext within w_ge038_parametro_pafecf
integer x = 37
integer y = 488
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "M$$HEX1$$ea00$$ENDHEX$$s / Ano:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_completa from radiobutton within w_ge038_parametro_pafecf
integer x = 1472
integer y = 376
integer width = 594
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Completa"
end type

type rb_normal from radiobutton within w_ge038_parametro_pafecf
integer x = 1472
integer y = 300
integer width = 594
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Simplificada"
boolean checked = true
end type

type rb_cv5795 from radiobutton within w_ge038_parametro_pafecf
boolean visible = false
integer x = 1472
integer y = 460
integer width = 594
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Conv$$HEX1$$ea00$$ENDHEX$$nio 57/95"
end type

type rb_ac0908 from radiobutton within w_ge038_parametro_pafecf
boolean visible = false
integer x = 1472
integer y = 636
integer width = 594
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Ato Cotepe 09/08"
end type

type rb_ac1704 from radiobutton within w_ge038_parametro_pafecf
boolean visible = false
integer x = 1472
integer y = 544
integer width = 594
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Ato Cotepe 17/04"
end type

type cb_confirma from commandbutton within w_ge038_parametro_pafecf
integer x = 498
integer y = 696
integer width = 389
integer height = 108
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Con&firmar"
end type

event clicked;If ivs_Parametro.id_periodo = 'S' Then
	ivs_Parametro.dh_inicial = Date(em_data_inicial.text)
	ivs_Parametro.dh_final   = Date(em_data_final.text)
Else
	SetNull(ivs_Parametro.dh_inicial)
	SetNull(ivs_Parametro.dh_final)
End If	

If ivs_Parametro.id_coo = 'S' Then
	ivs_Parametro.nr_coo_inicial = Long(em_coo_inicial.text)
	ivs_Parametro.nr_coo_final   = Long(em_coo_final.text)
Else
	SetNull(ivs_Parametro.nr_coo_inicial)
	SetNull(ivs_Parametro.nr_coo_final)
End If

If ivs_Parametro.id_ecf = 'S' Then
	ivs_Parametro.nr_ecf_inicial = Long(em_ecf_inicial.text)
	ivs_Parametro.nr_ecf_final   = Long(em_ecf_final.text)
Else
	SetNull(ivs_Parametro.nr_ecf_inicial)
	SetNull(ivs_Parametro.nr_ecf_final)
End If	

If ivs_Parametro.id_reducao = 'S' Then
	ivs_Parametro.nr_reducao_inicial = Long(em_reducao_inicial.text)
	ivs_Parametro.nr_reducao_final   = Long(em_reducao_final.text)
Else
	SetNull(em_reducao_inicial)
	SetNull(em_reducao_final)
End If

If ivs_Parametro.id_cpf = 'S' Then
	ivs_Parametro.nr_mes_ini 	= Long(em_mes_ini.text)
	ivs_Parametro.nr_ano_ini 	= Long(em_ano_ini.text)	
	ivs_Parametro.nr_cpf_cnpj  = Trim(em_cpf_cnpj.text)
Else
	SetNull(em_mes_ini.text)
	SetNull(em_ano_ini.text)	
	SetNull(em_cpf_cnpj.text)
End If

ivs_Parametro.id_Arquivo = rb_arquivo.Checked

If rb_normal.Checked Then
	ivs_Parametro.id_Modelo_Arquivo = ''
ElseIf rb_Completa.Checked Then
	ivs_Parametro.id_Modelo_Arquivo = 'C'	
ElseIf rb_ac1704.Checked Then	
	ivs_Parametro.id_Modelo_Arquivo = 'ac1704'
ElseIf rb_ac0908.Checked Then
	ivs_Parametro.id_Modelo_Arquivo = 'ac0908'
ElseIf rb_cv5795.Checked Then
	ivs_Parametro.id_Modelo_Arquivo = 'cv5795'
End If

ivs_Parametro.id_Retorno = "OK"

CloseWithReturn(Parent,ivs_Parametro)
end event

type cb_cancela from commandbutton within w_ge038_parametro_pafecf
integer x = 933
integer y = 696
integer width = 389
integer height = 108
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;
ivs_Parametro.id_Retorno = 'CANCELAR'

CloseWithReturn(Parent,ivs_Parametro)
end event

type st_1 from statictext within w_ge038_parametro_pafecf
integer x = 37
integer y = 36
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_22 from statictext within w_ge038_parametro_pafecf
integer x = 37
integer y = 152
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "COO:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_23 from statictext within w_ge038_parametro_pafecf
integer x = 37
integer y = 268
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "ECF:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_ecf_final from editmask within w_ge038_parametro_pafecf
integer x = 923
integer y = 260
integer width = 389
integer height = 84
integer taborder = 60
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type em_ecf_inicial from editmask within w_ge038_parametro_pafecf
integer x = 375
integer y = 260
integer width = 389
integer height = 84
integer taborder = 50
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_ecf from statictext within w_ge038_parametro_pafecf
integer x = 786
integer y = 268
integer width = 114
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "at$$HEX1$$e900$$ENDHEX$$"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_coo_final from editmask within w_ge038_parametro_pafecf
integer x = 923
integer y = 144
integer width = 389
integer height = 84
integer taborder = 40
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type em_coo_inicial from editmask within w_ge038_parametro_pafecf
integer x = 375
integer y = 144
integer width = 389
integer height = 84
integer taborder = 30
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type st_coo from statictext within w_ge038_parametro_pafecf
integer x = 786
integer y = 152
integer width = 114
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "at$$HEX1$$e900$$ENDHEX$$"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from dc_uo_dw_base within w_ge038_parametro_pafecf
boolean visible = false
integer x = 1445
integer y = 864
integer width = 1143
integer height = 708
integer taborder = 180
string dataobject = "dw_ge038_pafecf_estoque"
end type

type st_21 from statictext within w_ge038_parametro_pafecf
integer x = 37
integer y = 384
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Redu$$HEX2$$e700e300$$ENDHEX$$o:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_reducao_inicial from editmask within w_ge038_parametro_pafecf
integer x = 375
integer y = 376
integer width = 389
integer height = 84
integer taborder = 70
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type st_reducao_final from statictext within w_ge038_parametro_pafecf
integer x = 786
integer y = 384
integer width = 114
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "at$$HEX1$$e900$$ENDHEX$$"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_reducao_final from editmask within w_ge038_parametro_pafecf
integer x = 923
integer y = 376
integer width = 389
integer height = 84
integer taborder = 80
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type rb_arquivo from radiobutton within w_ge038_parametro_pafecf
integer x = 1833
integer y = 72
integer width = 361
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Arquivo"
end type

event clicked;rb_normal.Enabled = True
rb_completa.Enabled = True
//rb_ac1704.Enabled = True
//rb_ac0908.Enabled = True
//rb_cv5795.Enabled = True

end event

type rb_ecf from radiobutton within w_ge038_parametro_pafecf
integer x = 1472
integer y = 72
integer width = 320
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "ECF"
boolean checked = true
end type

event clicked;//rb_normal.Enabled = False
//rb_ac1704.Enabled = False
//rb_ac0908.Enabled = False
//rb_cv5795.Enabled = False

end event

type em_data_final from editmask within w_ge038_parametro_pafecf
integer x = 923
integer y = 28
integer width = 389
integer height = 84
integer taborder = 20
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 33554431
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_3 from statictext within w_ge038_parametro_pafecf
integer x = 786
integer y = 36
integer width = 114
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "at$$HEX1$$e900$$ENDHEX$$"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_data_inicial from editmask within w_ge038_parametro_pafecf
integer x = 375
integer y = 28
integer width = 389
integer height = 84
integer taborder = 10
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 33554431
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type gb_1 from groupbox within w_ge038_parametro_pafecf
integer x = 1413
integer y = 4
integer width = 823
integer height = 176
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Destino"
end type

type gb_2 from groupbox within w_ge038_parametro_pafecf
integer x = 1413
integer y = 184
integer width = 823
integer height = 580
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Tipo Leitura"
end type

