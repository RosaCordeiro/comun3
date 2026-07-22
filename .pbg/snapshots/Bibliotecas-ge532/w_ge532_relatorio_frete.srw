HA$PBExportHeader$w_ge532_relatorio_frete.srw
forward
global type w_ge532_relatorio_frete from dc_w_selecao_lista_relatorio
end type
type cb_1 from commandbutton within w_ge532_relatorio_frete
end type
end forward

global type w_ge532_relatorio_frete from dc_w_selecao_lista_relatorio
integer width = 4841
integer height = 1772
string title = "GE532 - Frete por CEP"
cb_1 cb_1
end type
global w_ge532_relatorio_frete w_ge532_relatorio_frete

type variables
uo_Filial 				  io_Filial
dc_uo_odbc			  ivo_Odbc

String ivs_nr_localidade
end variables

forward prototypes
public function boolean wf_loja_disque_entrega (long al_filial)
end prototypes

public function boolean wf_loja_disque_entrega (long al_filial);String ls_valor

SELECT vl_parametro 
into :ls_valor
FROM parametro_loja 
WHERE cd_parametro = 'ID_DISQUE_ENTREGA'
and cd_filial = :al_filial
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdberror("Erro ao localizar o valor do par$$HEX1$$e200$$ENDHEX$$metro disque entrega") 
	Return False
End If

Return (ls_valor='S')
end function

on w_ge532_relatorio_frete.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge532_relatorio_frete.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event close;call super::close;If IsValid(io_Filial) Then Destroy(io_Filial)
If IsValid(ivo_Odbc) Then Destroy(ivo_Odbc)

end event

event ue_preopen;call super::ue_preopen;io_Filial 					= Create uo_Filial
ivo_Odbc					= Create dc_uo_odbc

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge532_relatorio_frete
integer y = 1660
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge532_relatorio_frete
integer y = 1588
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge532_relatorio_frete
integer y = 260
integer width = 4745
integer height = 1320
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge532_relatorio_frete
integer width = 2395
integer height = 224
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge532_relatorio_frete
integer width = 2327
integer height = 144
string dataobject = "dw_ge532_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_1.AcceptText()

Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial
			This.Object.Nm_Filial	[1] = io_Filial.Nm_Fantasia
			
			SetNull(ivs_nr_localidade)
		End If
End Choose

dw_2.Event ue_Reset()
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_filial"
			io_Filial.of_Localiza_Filial(This.GetText())
		
			If io_Filial.Localizada Then
				
				If not wf_loja_disque_entrega(io_Filial.cd_filial) Then
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A filial "+String(io_Filial.cd_filial) + " n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativa no Disque Entrega.", Exclamation!)
					
					io_Filial.of_Inicializa()
					This.Object.Nm_Filial	[1] = io_Filial.Nm_Fantasia
					This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial
					
					Return -1
				End If
				
				uo_cidade lo_Cidade // GE008
				lo_Cidade = Create uo_Cidade
				lo_Cidade.of_localiza_codigo(io_Filial.cd_cidade)
				
				//Atribui o lo_Cidade.Nr_Localidade_Ect a ivs_nr_localidade para utilizar no retrieve
				If lo_Cidade.Localizada Then 
					ivs_nr_localidade = String(lo_Cidade.Nr_Localidade_Ect)
				End If			
				
				If isValid(lo_Cidade) Then Destroy(lo_Cidade)
				
				This.Object.Nm_Filial	[1] = io_Filial.Nm_Fantasia
				This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial
			Else
				io_Filial.of_Inicializa()
		
				This.Object.Nm_Filial	[1] = io_Filial.Nm_Fantasia
				This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial
			End If
	End Choose
End If
end event

event dw_1::editchanged;call super::editchanged;Long ll_nulo

SetNull(ll_nulo)

dw_2.Event ue_Reset()

Choose Case dwo.Name 
	Case  "nm_filial"
		If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Filial[1] = ll_nulo
			SetNull(ivs_nr_localidade)
			Return 0
		End If	
		
		If Data <> io_filial.nm_fantasia Then Return 1
End Choose


end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge532_relatorio_frete
integer y = 336
integer width = 4690
integer height = 1212
string dataobject = "dw_ge532_lista"
boolean hscrollbar = true
end type

event dw_2::ue_postretrieve;//OVERRIDE
Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
	lvb_Imprimir = True

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.~r~rVerifique se a filial j$$HEX1$$e100$$ENDHEX$$ fez o cadastro dos fretes.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event dw_2::ue_recuperar;//OVERRIDE
String lvs_Odbc	

Long ll_Filial

dw_1.AcceptText()

ll_Filial = dw_1.Object.cd_filial[1]

If IsNull(ll_Filial) Or ll_Filial= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localize a filial para gerar o relat$$HEX1$$f300$$ENDHEX$$rio." )
	Return -1
End If
	
If IsNull(ivs_nr_localidade) Or ivs_nr_localidade = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localize ao menos uma cidade para gerar o relat$$HEX1$$f300$$ENDHEX$$rio." )
	Return -1
End If

Try

	dc_uo_transacao 	ltr_Filial
	
	ltr_Filial 					= Create dc_uo_transacao
	ltr_Filial.ivs_DataBase = 'POSTGRESQL'
	
	If (Not ltr_Filial.of_IsConnected( )) Then
		
		Open(w_Aguarde)
		
		lvs_Odbc = ivo_Odbc.of_Localiza( ll_Filial )
		
		If Trim(lvs_Odbc)<>'' Then
			ivo_Odbc.of_deleta_regedit_odbc( ll_Filial )
		End If
		
		ivo_Odbc.of_localiza_parametro_odbc( ll_Filial )
		ivo_Odbc.of_grava_regedit_odbc( ll_Filial )
		lvs_Odbc = ivo_Odbc.of_Localiza( ll_Filial )
		
		w_Aguarde.Title = "Conectando na Filial '" + lvs_Odbc + "'"
		
		If ltr_Filial.of_IsConnected( ) Then
			ltr_Filial.of_Disconnect( )
		End If
		
		If Not ltr_Filial.of_Connect(lvs_Odbc, 'TRANSF') Then
			Return -1
		End If
	
	End If
	
	This.of_SetTransObject( ltr_Filial )
	This.Of_AppendWhere("b.nr_localidade in (" + ivs_nr_localidade + ")", 1)	
	This.Of_AppendWhere("b.nr_localidade in (" + ivs_nr_localidade + ")", 2)
	
	Return This.Retrieve()
	
Catch( Exception ex )
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ex.GetMessage( ) )
Finally
	If ltr_Filial.of_IsConnected( ) Then ltr_Filial.of_Disconnect( )
	Destroy ltr_Filial
	Close( w_Aguarde )
End Try
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge532_relatorio_frete
boolean visible = false
integer x = 2427
integer y = 1592
end type

type cb_1 from commandbutton within w_ge532_relatorio_frete
integer x = 2464
integer y = 124
integer width = 549
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Seleciona Cidades"
end type

event clicked;dw_1.AcceptText()

If IsNull(io_Filial.cd_filial) Or io_Filial.cd_filial= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localize a filial para selecionar a(s) cidade(s).", Exclamation! )
	dw_1.Event ue_Pos(1, "nm_filial")
	Return -1
End If

dw_2.Event ue_Reset()

OpenWithParm(w_ge532_seleciona_localidade, io_Filial.cd_cidade)

ivs_nr_localidade = Message.StringParm
end event

