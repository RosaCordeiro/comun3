HA$PBExportHeader$w_ge570_dados_prescritor.srw
forward
global type w_ge570_dados_prescritor from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge570_dados_prescritor
end type
end forward

global type w_ge570_dados_prescritor from dc_w_response_ok_cancela
integer width = 2011
integer height = 708
string title = "GE570 - Informa$$HEX2$$e700f500$$ENDHEX$$es adicionais"
cb_1 cb_1
end type
global w_ge570_dados_prescritor w_ge570_dados_prescritor

type variables
uo_ge570_dados_obrigatorios io_Dados

uo_prescritor_receita io_prescritor


end variables

on w_ge570_dados_prescritor.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge570_dados_prescritor.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;io_prescritor 	= Create uo_prescritor_receita
io_Dados 		= Create uo_ge570_dados_obrigatorios 

end event

event close;call super::close;If IsValid(io_prescritor) Then Destroy io_prescritor
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge570_dados_prescritor
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge570_dados_prescritor
integer x = 27
integer width = 1943
integer height = 472
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge570_dados_prescritor
integer x = 64
integer y = 72
integer width = 1870
integer height = 364
string dataobject = "dw_ge570_dados_prescritor"
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna,&
  	   lvs_prescritor

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	
	Choose Case lvs_Coluna
			
		Case "de_localizacao_prescritor"
			
			lvs_prescritor = This.GetText()
			
			io_Prescritor.of_Localiza_generica(lvs_Prescritor)
			
			If io_Prescritor.Localizado Then
				dw_1.Object.nm_prescritor				[1] = io_Prescritor.nm_prescritor	
				dw_1.Object.cd_uf_prescritor			[1] = io_Prescritor.cd_unidade_federacao	
				dw_1.Object.de_registro_prescritor	[1] = io_Prescritor.nr_registro	
				dw_1.Object.cd_tipo_prescritor			[1] = io_Prescritor.id_registro	
			End If
									
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = 'de_localizacao_prescritor' Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Prescritor.nm_Prescritor Then
			Return 1
		End If
	Else
		io_Prescritor.of_inicializa( )
		
		dw_1.Object.nm_prescritor				[1] = io_Prescritor.nm_prescritor	
		dw_1.Object.cd_uf_prescritor			[1] = io_Prescritor.cd_unidade_federacao	
		dw_1.Object.de_registro_prescritor	[1] = String(Long(io_Prescritor.nr_registro))
		dw_1.Object.cd_tipo_prescritor			[1] = io_Prescritor.id_registro	
	End If
End If


			
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge570_dados_prescritor
integer x = 1312
integer y = 496
integer weight = 700
boolean default = false
end type

event cb_ok::clicked;call super::clicked;String ls_Nome, ls_Uf, ls_Tipo, ls_Registro
String ls_Cartao_Industria, ls_Cupom_Desconto

dw_1.AcceptText()

ls_Nome			= dw_1.Object.nm_prescritor				[1]
ls_Uf				= dw_1.Object.cd_uf_prescritor			[1]
ls_Tipo			= dw_1.Describe ( "Evaluate('LookupDisplay(cd_tipo_prescritor)', " + String(1) + ")" )
ls_Registro		= dw_1.Object.de_registro_prescritor	[1]

If IsNull( ls_Nome ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o prescritor da receita.", Exclamation! )
	dw_1.Event ue_Pos(1, "de_localizacao_prescritor")
	Return -1
End If

io_Dados.nm_Pescritor		= ls_Nome
io_Dados.uf_Prescritor		= ls_Uf
io_Dados.id_Tipo_Registro	= ls_Tipo
io_Dados.nr_Registro			= ls_Registro

CloseWithReturn(Parent, io_Dados)


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge570_dados_prescritor
integer x = 1659
integer y = 496
end type

event cb_cancelar::clicked;//OverRide
SetNull(io_Dados)

CloseWithReturn(Parent, io_Dados)

end event

type cb_1 from commandbutton within w_ge570_dados_prescritor
boolean visible = false
integer x = 32
integer y = 496
integer width = 539
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Inserir Prescritor"
end type

event clicked;Open(w_ge085_cadastro_prescritor_receita)
end event

