HA$PBExportHeader$w_ge562_conta_fluxo_caixa_manual.srw
forward
global type w_ge562_conta_fluxo_caixa_manual from dc_w_response
end type
type cb_fechar from commandbutton within w_ge562_conta_fluxo_caixa_manual
end type
type cb_salva from commandbutton within w_ge562_conta_fluxo_caixa_manual
end type
type dw_1 from dc_uo_dw_base within w_ge562_conta_fluxo_caixa_manual
end type
type gb_1 from groupbox within w_ge562_conta_fluxo_caixa_manual
end type
end forward

global type w_ge562_conta_fluxo_caixa_manual from dc_w_response
integer width = 2021
integer height = 552
string title = "GE562 - Lan$$HEX1$$e700$$ENDHEX$$amento Conta Fluxo Caixa Manual"
cb_fechar cb_fechar
cb_salva cb_salva
dw_1 dw_1
gb_1 gb_1
end type
global w_ge562_conta_fluxo_caixa_manual w_ge562_conta_fluxo_caixa_manual

type variables
uo_Filial io_Filial

uo_ge136_transacao_remota	itr_Filial

dc_uo_odbc io_Odbc

uo_parametro_geral io_parametro

String is_Liberar
String is_Bloquear
String is_Parametro
String is_Parametro_Estorno
String is_Estorno
String is_Devolver
String is_Conta

String is_Situacao_Filial
String is_Estorno_Filial

String is_Situacao_Filial_Ori
String is_Estorno_Filial_Ori
end variables

forward prototypes
public function boolean wf_conecta_filial ()
public function boolean wf_altera_situacao ()
public function boolean wf_desconecta_filial ()
public function boolean wf_verifica_contas ()
public function boolean wf_recupera_parametro_filial ()
public function boolean wf_busca_descricao_conta (readonly long ai_cd_conta, ref string as_dsc_conta)
end prototypes

public function boolean wf_conecta_filial ();Boolean lb_Sucesso = True

Try
	dw_1.AcceptText( )
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = "Conectando no banco de dados da filial " + String( io_Filial.Cd_Filial )
	
	If not isNull(io_Filial.Cd_Filial ) Then
		io_Odbc.of_Atualiza_Odbcs( String( io_Filial.Cd_Filial ) )
		
		Return gf_GE136_Conecta_Banco_Filial( io_Filial.Cd_Filial, Ref itr_Filial )
	Else 
		Return lb_Sucesso = False
	End If
	

Catch( Exception ex )
	MessageBox( "Exeption", ex.getMessage( ), StopSign! )
	
Finally
	If IsValid( w_Aguarde ) Then Close( w_Aguarde )
End Try
end function

public function boolean wf_altera_situacao ();dw_1.AcceptText( )

Int li_Conta

li_Conta = Long(is_Conta)

Try
	If Not This.wf_Conecta_Filial( ) Then Return False
		
	UPDATE conta_fluxo_caixa
		 SET	id_situacao				= :This.is_Parametro,
		 		id_permite_estorno	= :is_Estorno
	 WHERE cd_conta_fluxo_caixa 	= :li_Conta
	  USING itr_Filial;
		
	If itr_Filial.SqlCode = -1 Then
		itr_Filial.of_RollBack( )
		itr_Filial.Of_MsgdbError("Erro ao atualizar a conta_fluxo_caixa para " + This.is_Parametro )
		Return False
	End If
		
	itr_Filial.of_Commit()
	
	Return True
	
Catch( RuntimeError ex )
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ex.getMessage( ) + '~rwf_altera_situacao( )' )

Finally
	wf_Desconecta_Filial( )
	
End Try



end function

public function boolean wf_desconecta_filial ();Try
	If itr_Filial.of_IsConnected( ) Then
		itr_Filial.of_Disconnect( )
	End If
	
	If not isNull(io_Filial.Cd_Filial) Then
		io_Odbc.of_deleta_regedit_odbc( String( io_Filial.Cd_Filial, "0000" ) )
	End If
	
	Return True	
	
Catch ( RuntimeError ex )
	MessageBox( "Exception", ex.GetMessage( ) + "~rwf_Desconecta_Filial( )", StopSign! )
	Return False
End Try



end function

public function boolean wf_verifica_contas ();String ls_Parametro
String ls_Contas[]
String ls_Values
String ls_dsc_conta
String ls_Null

Integer li_Pos, li_Loop, li_Mid

Li_Pos = 1

Try
	dw_1.SetRedraw(False)
	If not io_parametro.of_localiza_parametro( "CD_CONTA_FLUXO_LIBERADA_ALTERACAO", ls_Parametro ) Then Return False
	If Not This.wf_Conecta_Filial( ) Then Return False
	li_Loop = 1
	dw_1.Modify("nr_conta.Values=''")
	SetNull(ls_Null)
	dw_1.SetItem(1,"nr_conta",ls_Null)
	
	Do 
		li_Mid = posA(ls_Parametro,',',li_Pos)
	
		If li_Mid <> 0 Then
			ls_Contas[li_Loop] = midA(ls_Parametro, li_Pos ,li_mid - li_Pos)
		Else
			ls_Contas[li_Loop] = midA(ls_Parametro,li_Pos, lenA(ls_Parametro) - li_Pos + 1)
		End If
		
		This.wf_busca_descricao_conta(Long(ls_Contas[li_Loop]), ref ls_dsc_conta)
		ls_dsc_conta = Trim(gf_replace(ls_dsc_conta,"/","|",1))
		ls_Values += ls_Contas[li_Loop] + ' - ' + ls_dsc_conta + '	' + ls_Contas[li_Loop] + '/'
	
		li_Pos = li_Mid + 1
		li_Loop++
		
	Loop While li_Mid > 0
		
	If UPPERBOUND( ls_Contas[] ) = 0 Then
		MessageBox("","")
		Return False
	End If
	
	dw_1.Modify("nr_conta.Values='" + ls_Values + "'")

	Return True

Finally 
	
	dw_1.SetRedraw(True)

End Try
end function

public function boolean wf_recupera_parametro_filial ();String ls_Odbc

Long li_Conta

dw_1.accepttext()

li_Conta = Long(is_Conta)

//S$$HEX1$$f300$$ENDHEX$$ conecta no banco da filial se o Compras estiver sendo executado no banco Central

itr_Filial.ivs_DataBase = 'ANYWHERE'

Try
	Open(w_Aguarde)
	
	If Not io_Odbc.of_localiza_parametro_odbc(io_filial.cd_filial ) Then Return False
	
//	lo_Odbc.of_grava_regedit_odbc( io_filial.cd_filial  )
	
//	ls_Odbc = lo_Odbc.of_Localiza( io_filial.cd_filial  )	
	
	w_Aguarde.Title = "Conectando no odbc '" + ls_Odbc + "'"
	
	If itr_Filial.of_IsConnected( ) Then
		itr_Filial.of_Disconnect( )
	End If
	
	If wf_conecta_filial() Then
	
			Select id_situacao, id_permite_estorno
			Into :is_Situacao_Filial, :is_Estorno_Filial
			From conta_fluxo_caixa
			WHERE cd_conta_fluxo_caixa 	= :li_Conta
		USING itr_Filial;
		
		If itr_Filial.SqlCode = -1 Then
			itr_Filial.of_MsgDbError( )
			Return False
		Else
			
			is_Situacao_Filial_Ori	= is_Situacao_Filial
			is_Estorno_Filial_Ori 	= is_Estorno_Filial
			
			If is_Situacao_Filial = 'A' Then 
				dw_1.Object.liberar		[1] = 'S'
				dw_1.Object.bloquear	[1] = 'N'
			Else 
				is_Situacao_Filial = 'N'
				dw_1.Object.bloquear	[1] = 'S'
				dw_1.Object.liberar		[1] = 'N'
			End If
			
			If is_Estorno_Filial = 'S' Then
				dw_1.Object.estorno	[1] = 'S'
				dw_1.Object.devolver	[1] = 'N'
			Else 
				dw_1.Object.devolver	[1] = 'S'
				dw_1.Object.estorno	[1] = 'N'
			End  If
			
		End If
	
		Return True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar na filial [" + String(io_filial.cd_filial ) + "] Para recuperar os par$$HEX1$$e200$$ENDHEX$$metros atuais.")
		Return True
	End If
	
Catch( Exception ex )
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ex.GetMessage( ) )
Finally
	wf_desconecta_filial()
	Close( w_Aguarde )
End Try

Return True
end function

public function boolean wf_busca_descricao_conta (readonly long ai_cd_conta, ref string as_dsc_conta);as_dsc_conta = ""

If IsValid(itr_Filial) Then

	Select de_conta_fluxo_caixa
	Into :as_dsc_conta
	From conta_fluxo_caixa
	WHERE cd_conta_fluxo_caixa 	= :ai_cd_conta
	USING itr_Filial;
	
	Choose Case itr_Filial.SqlCode
		Case -1
			itr_Filial.of_MsgDbError( )
			Return False
		Case 100
			as_dsc_conta = "Conta n$$HEX1$$e300$$ENDHEX$$o cadastrada {conta_fluxo_caixa}"		
		Case Else
			//
	End Choose
End If

Return True
end function

on w_ge562_conta_fluxo_caixa_manual.create
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

on w_ge562_conta_fluxo_caixa_manual.destroy
call super::destroy
destroy(this.cb_fechar)
destroy(this.cb_salva)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event close;call super::close;If IsValid( io_Filial ) Then Destroy io_Filial
If IsValid( itr_Filial ) Then Destroy itr_Filial
If IsValid( io_Odbc ) Then Destroy io_Odbc
If IsValid( io_Parametro ) Then Destroy io_Odbc
end event

event closequery;call super::closequery;If This.il_Retorno <> -1 Then // Se passou pela libera$$HEX2$$e700e300$$ENDHEX$$o de procedimento
	is_Estorno 			= is_Estorno_Filial_Ori
	This.is_Parametro = is_Situacao_Filial_Ori
	
	This.wf_Altera_Situacao( )
End If
end event

event ue_preopen;call super::ue_preopen;//If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "W_CR222_CONTA_FLUXO_CAIXA_MANUAL", Ref This.is_Matricula_Abertura_Tela ) Then 
//	This.il_Retorno = -1
//	Return
//End If
//
ivb_permite_fechar = False
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Addrow()

io_Filial	= Create uo_Filial
io_Odbc	= Create dc_uo_odbc
io_Parametro = Create uo_parametro_geral

itr_Filial	= Create uo_ge136_transacao_remota
itr_Filial.of_Set_DataSource( 'POSTGRESQL', '' )
end event

type pb_help from dc_w_response`pb_help within w_ge562_conta_fluxo_caixa_manual
integer x = 1728
integer y = 52
end type

type cb_fechar from commandbutton within w_ge562_conta_fluxo_caixa_manual
integer x = 1573
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

type cb_salva from commandbutton within w_ge562_conta_fluxo_caixa_manual
integer x = 1257
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

event clicked;String ls_Odbc
String ls_Filial

dw_1.AcceptText()

is_Liberar	= dw_1.Object.Liberar		[1]
is_Bloquear	= dw_1.Object.Bloquear		[1]
is_Estorno	= dw_1.Object.Estorno		[1]
is_Devolver  = dw_1.Object.Devolver		[1]
is_Conta		= dw_1.Object.Nr_conta		[1]

If IsNull( io_Filial.Cd_Filial ) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar a filial.", Exclamation!)
	dw_1.Event ue_Pos(1, "nm_fantasia")
	Return -1
End If

If IsNull( is_conta) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar a conta.", Exclamation!)
	dw_1.Event ue_Pos(1, "nr_conta")
	Return -1
End If

If (IsNull(is_Liberar) or is_Liberar =  'N') and (IsNull(is_Bloquear) or is_Bloquear = 'N') Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza selecione a situa$$HEX2$$e700e300$$ENDHEX$$o da Conta(Ativa/Inativa).", Exclamation!)
	Return -1
End If

If (IsNull(is_Estorno) or is_Estorno =  'N') and (IsNull(is_Devolver) or is_Devolver = 'N') Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza selecione se $$HEX1$$e900$$ENDHEX$$ permitido Estorno(Sim/N$$HEX1$$e300$$ENDHEX$$o).", Exclamation!)
	Return -1
End If

If is_Liberar = 'S' Then
	is_Parametro = 'A'
Else
	is_Parametro = 'I'
End If

wf_Altera_Situacao( )

Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Altera$$HEX2$$e700e300$$ENDHEX$$o registrada com sucesso.", Information!)

Return 1
end event

type dw_1 from dc_uo_dw_base within w_ge562_conta_fluxo_caixa_manual
integer x = 64
integer y = 92
integer width = 1911
integer height = 344
string dataobject = "dw_ge562_selecao"
borderstyle borderstyle = stylelowered!
end type

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			If Not IsNull( This.Object.Cd_Filial[1] ) Then
				Parent.is_Parametro = 'I'
				wf_Altera_Situacao( )
			End If
			
			io_Filial.of_Inicializa( )

			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia[1] = io_Filial.Nm_Fantasia
			If Not wf_verifica_contas() Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao recuperar as contas. Abra um chamado no ServiceDesk.",Exclamation!)
			End If

		End If
		
	Case "liberar"
		If Data = 'S' Then
			This.Object.Bloquear[ 1 ] = 'N'
		End If
		
	Case "bloquear"
		If Data = 'S' Then
			This.Object.Liberar[ 1 ] = 'N'
		End If
		
	Case "estorno"
		If Data = 'S' Then
			This.Object.devolver[ 1 ] = 'N'
		End If
		
	Case "devolver"
		If Data = 'S' Then
			This.Object.estorno[ 1 ] = 'N'
		End If
		
	Case "nr_conta"
		If (Data <> '00' Or Data <> '') And not isNull(io_Filial.Nm_Fantasia) Then
				is_conta = Data 
				wf_recupera_parametro_filial()
				
			If is_conta = '264' Or is_conta = '265' Then
				dw_1.Object.Liberar.Protect	 	= 1
				dw_1.Object.Bloquear.Protect 	= 1
			Else 
				dw_1.Object.Liberar.Protect 	= 0
				dw_1.Object.Bloquear.Protect 	= 0
			End If
		End If
		
	gvo_parametro.of_carrega_parametros( )
	
End Choose
end event

event losefocus;call super::losefocus;If IsValid(io_Filial) Then
	This.Object.Nm_Fantasia[1] = io_Filial.Nm_Fantasia
End If
end event

event ue_key;call super::ue_key;Long ll_Filial_Temp

is_conta = dw_1.Object.nr_conta [1]

If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		io_Filial.of_Localiza_Filial( This.GetText() )
		
		If io_Filial.Localizada Then
			
			If Not IsNull( This.Object.Cd_Filial[1] ) And This.Object.Cd_Filial[1] <> io_Filial.Cd_Filial Then
				ll_Filial_Temp = io_Filial.Cd_Filial
				io_Filial.Cd_Filial =  This.Object.Cd_Filial[1]
				Parent.is_Parametro = 'I'

				io_Filial.Cd_Filial = ll_Filial_Temp
			End If
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia[1] = io_Filial.Nm_Fantasia
			
			If not isNull(is_conta) And is_conta <> ''  And is_conta <> '00' Then
				wf_recupera_parametro_filial()
			End If
			
			If Not wf_verifica_contas() Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao recuperar as contas. Abra um chamado no ServiceDesk.",Exclamation!)
			End If

			
		End If
	End If

End If
end event

event ue_postretrieve;call super::ue_postretrieve;If itr_Filial.of_IsConnected( ) Then itr_Filial.of_Disconnect( )

Return AncestorReturnValue
end event

type gb_1 from groupbox within w_ge562_conta_fluxo_caixa_manual
integer x = 32
integer y = 16
integer width = 1957
integer height = 436
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

