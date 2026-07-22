HA$PBExportHeader$w_ge612_bloqueio_estorno.srw
forward
global type w_ge612_bloqueio_estorno from dc_w_response
end type
type cb_fechar from commandbutton within w_ge612_bloqueio_estorno
end type
type cb_salva from commandbutton within w_ge612_bloqueio_estorno
end type
type dw_1 from dc_uo_dw_base within w_ge612_bloqueio_estorno
end type
type gb_1 from groupbox within w_ge612_bloqueio_estorno
end type
end forward

global type w_ge612_bloqueio_estorno from dc_w_response
string tag = "w_ge612_bloqueio_estorno"
integer width = 1943
integer height = 520
string title = "GE612 - Permite Estorno Gif Card ( PDV Novo )"
cb_fechar cb_fechar
cb_salva cb_salva
dw_1 dw_1
gb_1 gb_1
end type
global w_ge612_bloqueio_estorno w_ge612_bloqueio_estorno

type variables
uo_Filial io_Filial


String is_Estorno

String is_Situacao_Filial
String is_Estorno_Filial
String is_Filial_Pdv_Novo


end variables

forward prototypes
public function boolean wf_altera_situacao ()
public function boolean wf_localiza_parametro (long al_filial, ref string as_parametro)
end prototypes

public function boolean wf_altera_situacao ();Try
	Update 	parametro_loja
	Set		vl_parametro	=:is_Estorno
	Where 	cd_parametro  ='ID_PERMITE_ESTORNO_GIFT_CARD'
	And     	cd_filial=:io_Filial.Cd_Filial
	Using 		SqlCa;
				
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao parametro para a filial:" + SqlCa.SqlErrText, StopSign!)
		Return False
	Else
		SqlCa.of_Commit()				
	End If 	
		
	Catch( RuntimeError ex )
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ex.getMessage( ) + '~Atualizacao do Parametro' )
	Finally	
End Try

Return True 


end function

public function boolean wf_localiza_parametro (long al_filial, ref string as_parametro);



Select vl_parametro
Into :as_parametro
From parametro_loja
where cd_parametro  =  'ID_PERMITE_ESTORNO_GIFT_CARD'
and     cd_filial =:al_filial
Using SqlCA;

If IsNull(as_parametro) Then as_parametro = 'N'

Return True 



end function

on w_ge612_bloqueio_estorno.create
int iCurrent
call super::create
this.cb_fechar=create cb_fechar
this.cb_salva=create cb_salva
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_fechar
this.Control[iCurrent+2]=this.cb_salva
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge612_bloqueio_estorno.destroy
call super::destroy
destroy(this.cb_fechar)
destroy(this.cb_salva)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event close;call super::close;If IsValid( io_Filial ) Then Destroy io_Filial


end event

event closequery;call super::closequery;If This.il_Retorno <> -1 Then // Se passou pela libera$$HEX2$$e700e300$$ENDHEX$$o de procedimento
	
	
	This.wf_Altera_Situacao( )
End If
end event

event ue_preopen;call super::ue_preopen;If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "W_GE612_BLOQUEIO_ESTORNO", Ref This.is_Matricula_Abertura_Tela ) Then 
	This.il_Retorno = -1
	Return
End If

ivb_permite_fechar = False
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Addrow()
io_Filial	= Create uo_Filial




end event

type pb_help from dc_w_response`pb_help within w_ge612_bloqueio_estorno
integer x = 1728
integer y = 52
end type

type cb_fechar from commandbutton within w_ge612_bloqueio_estorno
integer x = 1609
integer y = 316
integer width = 297
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Fechar"
end type

event clicked;Close(Parent)
end event

type cb_salva from commandbutton within w_ge612_bloqueio_estorno
integer x = 1294
integer y = 316
integer width = 297
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar"
end type

event clicked;String ls_Filial

dw_1.AcceptText()

is_Estorno	= dw_1.Object.estorno		[1]


If IsNull( io_Filial.Cd_Filial ) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar a filial.", Exclamation!)
	dw_1.Event ue_Pos(1, "nm_fantasia")
	Return -1
End If


If (IsNull(is_Estorno) or is_Estorno =  '') Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza selecione se $$HEX1$$e900$$ENDHEX$$ permitido Estorno(Sim/N$$HEX1$$e300$$ENDHEX$$o).", Exclamation!)
	Return -1
End If

wf_Altera_Situacao()

Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Altera$$HEX2$$e700e300$$ENDHEX$$o registrada com sucesso.", Information!)

Return 1
end event

type dw_1 from dc_uo_dw_base within w_ge612_bloqueio_estorno
integer x = 55
integer y = 64
integer width = 1856
integer height = 244
string dataobject = "dw_ge612_selecao"
borderstyle borderstyle = stylelowered!
end type

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			If Not IsNull( This.Object.Cd_Filial[1]) Then				
				wf_Altera_Situacao( )
			End If
			
			io_Filial.of_Inicializa( )

			This.Object.cd_filial		[1] = io_Filial.Cd_Filial
			This.Object.nm_fantasia[1] = io_Filial.Nm_Fantasia			
			is_Filial_Pdv_Novo = io_Filial.id_sistema_novo
		End If
		
	Case "estorno"
		If Data = 'S' Then
			This.Object.estorno[ 1 ] = 'S'
		Else
			This.Object.estorno[ 1 ] = 'N'
		End If 	
End Choose
end event

event losefocus;call super::losefocus;If IsValid(io_Filial) Then
	This.Object.Nm_Fantasia[1] = io_Filial.Nm_Fantasia
	This.Object.cd_filial[1] = io_Filial.cd_filial
End If
end event

event ue_key;call super::ue_key;Long ll_Filial_Temp, ll_nulo 
String lvs_Estorno
String lvs_Null 
SetNull(lvs_Null) 
SetNull(ll_nulo)


If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		io_Filial.of_Localiza_Filial( This.GetText() )

		If io_Filial.Localizada Then
			is_Filial_Pdv_Novo = io_Filial.id_sistema_novo
			
			If is_Filial_Pdv_Novo = 'N' Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial N$$HEX1$$e300$$ENDHEX$$o esta no Novo PDV. Opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o Permitida!", StopSign!)
				This.Object.cd_filial[1] = ll_nulo
				This.Object.nm_fantasia[1] = lvs_Null
				This.Object.estorno		[1] = lvs_Null 
				dw_1.Event ue_Pos(1, "nm_fantasia") 
				Return -1				
			End If 
						
			If Not wf_localiza_parametro(io_Filial.Cd_Filial, Ref lvs_Estorno) Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Parametro da Filial n$$HEX1$$e300$$ENDHEX$$o Localizado!", StopSign!)
				This.Object.cd_filial[1] = ll_nulo
				This.Object.nm_fantasia[1] = lvs_Null	
				This.Object.estorno		[1] = lvs_Null 
				dw_1.Event ue_Pos(1, "nm_fantasia") 
				Return -1			
			End If 	
		
			This.Object.estorno		[1] 	= lvs_Estorno
			This.Object.cd_filial		[1] 	= io_Filial.Cd_Filial
			This.Object.nm_fantasia	[1] 	= io_Filial.Nm_Fantasia
			
		End If
	End If
End If
end event

event ue_postretrieve;call super::ue_postretrieve;

Return AncestorReturnValue
end event

type gb_1 from groupbox within w_ge612_bloqueio_estorno
integer x = 32
integer y = 16
integer width = 1883
integer height = 408
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

