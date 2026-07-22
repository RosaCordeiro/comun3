HA$PBExportHeader$w_ge339_emissao_etiqueta_transferencia.srw
forward
global type w_ge339_emissao_etiqueta_transferencia from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge339_emissao_etiqueta_transferencia
end type
type dw_2 from dc_uo_dw_base within w_ge339_emissao_etiqueta_transferencia
end type
type cb_imprimir from commandbutton within w_ge339_emissao_etiqueta_transferencia
end type
type cb_cancelar from commandbutton within w_ge339_emissao_etiqueta_transferencia
end type
type gb_1 from groupbox within w_ge339_emissao_etiqueta_transferencia
end type
end forward

global type w_ge339_emissao_etiqueta_transferencia from dc_w_response
integer width = 2245
integer height = 980
string title = "RL004 - Emiss$$HEX1$$e300$$ENDHEX$$o de Etiqueta de Transfer$$HEX1$$ea00$$ENDHEX$$ncia"
dw_1 dw_1
dw_2 dw_2
cb_imprimir cb_imprimir
cb_cancelar cb_cancelar
gb_1 gb_1
end type
global w_ge339_emissao_etiqueta_transferencia w_ge339_emissao_etiqueta_transferencia

type variables
Long ivl_nr_nf
Long ivl_cd_filial

String ivs_Especie, ivs_Serie

end variables

forward prototypes
public subroutine wf_verifica_fonte ()
end prototypes

public subroutine wf_verifica_fonte ();String ls_Folder

String ls_Validar[]

ls_Folder	= "c:\windows\fonts"

ls_Validar = {'IDAutomationHC39M.ttf'}

If Not FileExists( ls_Folder + '\' + ls_Validar[1] ) Then				
	If Not gf_download_matriz(ls_Validar, ls_Validar, ls_Folder, 'fonts',  False) Then Return
End If

If RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", "IDAutomationHC39M (TrueType)", RegString!, "IDAutomationHC39M.ttf" ) = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instalar a fonte necess$$HEX1$$e100$$ENDHEX$$ria para impress$$HEX1$$e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo de barras.', Information! )
End If
end subroutine

on w_ge339_emissao_etiqueta_transferencia.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_imprimir=create cb_imprimir
this.cb_cancelar=create cb_cancelar
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_imprimir
this.Control[iCurrent+4]=this.cb_cancelar
this.Control[iCurrent+5]=this.gb_1
end on

on w_ge339_emissao_etiqueta_transferencia.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_imprimir)
destroy(this.cb_cancelar)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;String lvs_parametro

st_dados_nf lst_dados

lst_dados = Message.PowerObjectParm	

ivl_cd_filial	= lst_dados.cd_filial
ivl_nr_nf		= lst_dados.nr_nf
ivs_Especie	= lst_dados.de_especie
ivs_Serie		= lst_dados.de_serie

dw_1.Event ue_Retrieve( )

end event

type pb_help from dc_w_response`pb_help within w_ge339_emissao_etiqueta_transferencia
end type

type dw_1 from dc_uo_dw_base within w_ge339_emissao_etiqueta_transferencia
integer x = 37
integer y = 72
integer width = 2130
integer height = 656
boolean bringtotop = true
string dataobject = "dw_ge339_selecao_etiqueta_transferencia"
end type

event itemchanged;call super::itemchanged;If dwo.name = 'nr_volume' Then
	If Long(data) <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O volume deve ser maior que zero!",StopSign!,Ok!)
		Return 1
	End If
End If

end event

event itemfocuschanged;call super::itemfocuschanged;If dwo.Name = 'nr_volume' Then
	This.SelectText(1,5)
End If
end event

event ue_postretrieve;call super::ue_postretrieve;If This.Object.cd_Remanejamento[ 1 ] <> 0 Then
	This.Object.nm_Solicitante[ 1 ] = 'RETIRADA DE EXCESSO'	
	This.Object.nm_Solicitante.Protect = True
Else
	This.Object.nm_Solicitante.Protect = False
End If

Return AncestorReturnValue
end event

event ue_recuperar;//OverRide

Return This.Retrieve( ivl_cd_filial, ivl_nr_nf,  ivs_Especie, ivs_Serie)
end event

type dw_2 from dc_uo_dw_base within w_ge339_emissao_etiqueta_transferencia
boolean visible = false
integer x = 1541
integer y = 32
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge339_relatorio_etiqueta_transferencia"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type cb_imprimir from commandbutton within w_ge339_emissao_etiqueta_transferencia
integer x = 1618
integer y = 768
integer width = 279
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Imprimir"
boolean default = true
end type

event clicked;Long lvl_linha
Long lvl_nr_volume

Long 	ll_Origem
Long 	ll_Destino
Long 	ll_Doc

String ls_Especie
String ls_Serie
String ls_Argumentos
String ls_Operador

//If dw_1.AcceptText()	<= 0 Then Return

dw_1.AcceptText()

wf_Verifica_Fonte()

lvl_nr_volume = dw_1.Object.nr_volume[1]
FOR lvl_linha = 1 TO lvl_nr_volume
	
	ll_Origem	= dw_1.Object.cd_filial_origem				[1]
	ll_Doc    		= dw_1.Object.nr_nf							[1]
	ls_Especie	= dw_1.Object.de_especie					[1]
	ls_Serie		= dw_1.Object.de_serie						[1]
	ll_Destino	= dw_1.Object.cd_filial_destino			[1]
	ls_Operador	= dw_1.Object.Nr_Matricula_Operador	[1]	
	
	dw_2.Event ue_AddRow()
	dw_2.Object.nm_filial_origem			[lvl_linha] = dw_1.Object.nm_filial_origem				[1]
	dw_2.Object.de_endereco_origem		[lvl_linha] = dw_1.Object.de_endereco_origem		[1]
	dw_2.Object.dh_movimentacao_caixa[lvl_linha] = dw_1.Object.dh_movimentacao_caixa	[1]
	dw_2.Object.nm_operador				[lvl_linha] = dw_1.Object.nm_operador					[1]
	dw_2.Object.nr_nf							[lvl_linha] = dw_1.Object.nr_nf								[1]
	dw_2.Object.nm_filial_destino			[lvl_linha] = dw_1.Object.nm_filial_destino				[1]
	dw_2.Object.de_endereco_destino	[lvl_linha] = dw_1.Object.de_endereco_destino		[1]
	dw_2.Object.nm_solicitante				[lvl_linha] = dw_1.Object.nm_solicitante					[1]
	dw_2.Object.nr_volume					[lvl_linha] =	String(lvl_linha) + '/' + &
																	String(lvl_nr_volume)	
																 
	dw_2.Object.de_cogigo_barras[lvl_linha] =	"*"+ right("0000" + String(dw_1.Object.cd_filial_origem[1]),4) +&
																	right("000000000"+String(dw_1.Object.nr_nf[1]),9)+&
																	dw_1.Object.de_especie[1] + dw_1.Object.de_serie[1] +String( lvl_linha, "00" ) + "*"
	
NEXT

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "WS"  Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Troque a folha da impressora para formul$$HEX1$$e100$$ENDHEX$$rio branco!")
	
	OPEN(w_ge033_prepara_impressora)
	
	dw_2.Event ue_printimmediate()
	
	ls_argumentos =	"cd_filial_origem="	+ String( ll_Origem )	+ &
							"&cd_filial_destino="	+ String( ll_Destino )	+ &
							"&nr_nf="				+ String( ll_Doc )		+ &
							"&de_serie="			+ ls_Serie 				+ &
							"&de_especie="		+ ls_Especie 			+ &
							"&nr_matricula="		+ ls_Operador			+ &
							"&qt_item="				+ String( lvl_nr_volume )
										
	uo_transacao_remota lo_SD
	lo_SD = Create uo_transacao_remota
	lo_SD.of_Executa_Rotina_Intranet( 'registra_saida_transferencia', ls_argumentos )
	Destroy lo_SD
	
Else
	dw_2.Event ue_printimmediate()
End If

dw_2.Reset()
end event

type cb_cancelar from commandbutton within w_ge339_emissao_etiqueta_transferencia
integer x = 1925
integer y = 768
integer width = 279
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

event clicked;Close(w_ge339_emissao_etiqueta_transferencia)
end event

type gb_1 from groupbox within w_ge339_emissao_etiqueta_transferencia
integer x = 23
integer y = 4
integer width = 2185
integer height = 744
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

