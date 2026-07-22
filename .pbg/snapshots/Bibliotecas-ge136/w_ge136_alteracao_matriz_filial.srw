HA$PBExportHeader$w_ge136_alteracao_matriz_filial.srw
forward
global type w_ge136_alteracao_matriz_filial from dc_w_response_ok_cancela
end type
end forward

global type w_ge136_alteracao_matriz_filial from dc_w_response_ok_cancela
integer width = 1490
integer height = 440
string title = "GE136 - Altera$$HEX2$$e700e300$$ENDHEX$$o Matriz -> Filial"
end type
global w_ge136_alteracao_matriz_filial w_ge136_alteracao_matriz_filial

type variables
uo_filial								ivo_filial
uo_ge136_transacao_remota	ivtr_Filial
dc_uo_odbc 						ivo_Odbc

Private:
Long ivl_Tipo

String ivs_Chave
end variables

forward prototypes
public function boolean wf_conecta_filial (long pl_filial)
public function boolean wf_desconecta_filial ()
public function boolean wf_altera_cliente_cheque ()
public function boolean wf_executa_filial ()
public function boolean wf_altera_bloqueio ()
end prototypes

public function boolean wf_conecta_filial (long pl_filial);Boolean lvb_Sucesso = False
String lvs_Odbc

If IsNull(pl_filial) Then Return False

Try
	dw_1.AcceptText( )
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Conectando no banco de dados da filial " + String( pl_filial )
	
	ivo_Odbc.of_Atualiza_Odbcs( String( pl_filial ) )
	
	If Not IsValid( ivtr_Filial ) Then ivtr_Filial = Create uo_ge136_Transacao_Remota
	
	lvs_Odbc = ivtr_Filial.of_Localiza_DataSource_Filial( pl_Filial )
	
	#IF DEFINED DEBUG THEN
		If SQLCa.Database = "homologa" then
			lvs_Odbc = "0000_Loja"
		else
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Voc$$HEX1$$ea00$$ENDHEX$$ deseja conectar no banco loja?", Question!, YesNo!,1) = 1 Then
				lvs_Odbc = "0000_Loja"
			End If
		end If
	#END IF
	
	If IsNull( lvs_Odbc ) Or Trim( lvs_Odbc ) = "" Then Return False
	
	If ivtr_Filial.of_IsConnected( ) Then	ivtr_Filial.of_Disconnect( )
	
	ivtr_Filial.of_Set_Username( "teste_conexao" )
	
	ivtr_Filial.of_Set_DataSource( 'POSTGRESQL', lvs_Odbc )
	
	//Nome da aplica$$HEX2$$e700e300$$ENDHEX$$o tl_importacao para n$$HEX1$$e300$$ENDHEX$$o gerar log de exporta$$HEX2$$e700e300$$ENDHEX$$o para matriz
	lvb_Sucesso = ivtr_Filial.of_Connect( lvs_Odbc, "tl_importacao" )
	
	If lvb_Sucesso Then ivtr_Filial.of_End_Transaction( )

Catch( Exception ex )
	MessageBox( "Exception", ex.getMessage( ), StopSign! )
	lvb_Sucesso = False
	
Finally
	If IsValid( w_Aguarde ) Then Close( w_Aguarde )
End Try

Return lvb_Sucesso
end function

public function boolean wf_desconecta_filial ();Try
	If ivtr_Filial.of_IsConnected( ) Then ivtr_Filial.of_Disconnect( )
	
	ivo_Odbc.of_deleta_regedit_odbc( String( ivo_Filial.Cd_Filial, "0000" ) )
	
	Return True	
	
Catch ( RuntimeError ex )
	MessageBox( "Exception", ex.GetMessage( ) + "~rwf_Desconecta_Filial( )", StopSign! )
	Return False
End Try

end function

public function boolean wf_altera_cliente_cheque ();String lvs_DE_Bloqueio
String lvs_ID_Bloqueado
String lvs_CPF

Long lvl_Filial_Alteracao

lvs_CPF = ivs_Chave

dw_1.AcceptText( )

Try
	If Not This.wf_Conecta_Filial( ivo_Filial.Cd_Filial ) Then Return False
	
	select id_bloqueado, de_bloqueio
	Into :lvs_ID_Bloqueado, :lvs_DE_Bloqueio
	From cliente_cheque
	Where nr_cpf = :lvs_CPF
	Using SQLCa;
	
	Choose Case SQLCa.SQLCode
		Case -1 
			SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o do bloqueio." )
			Return False
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o cliente cheque CPF "+lvs_CPF+".",Exclamation!)
			Return False
		Case 0
			//
	End Choose

	UPDATE cliente_cheque
		 SET 	id_bloqueado = :lvs_ID_Bloqueado,
		 		de_bloqueio = :lvs_DE_Bloqueio,
		 		cd_filial_atualizacao = :gvo_parametro.cd_filial_matriz,
		 		dh_atualizacao = getdate()
	Where nr_cpf = :lvs_CPF
	  USING ivtr_Filial;
		
	If ivtr_Filial.SqlCode = -1 Then
		ivtr_Filial.of_RollBack( )
		ivtr_Filial.Of_MsgdbError("Erro ao liberar o cliente_cheque CPF "+lvs_CPF)
		Return False
	End If
		
	ivtr_Filial.of_Commit()
	
	Return True
	
Catch( RuntimeError ex )
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ex.getMessage( ) + '~rwf_altera_cliente_cheque( )' )

Finally
	wf_Desconecta_Filial( )
End Try

Return True
end function

public function boolean wf_executa_filial ();Boolean lvb_Ok

Choose Case ivl_Tipo
	Case 1  //001 - BLOQUEIO
		lvb_Ok = wf_altera_bloqueio()
	Case 2  //002 - CLIENTE_CHEQUE
		lvb_Ok = wf_altera_cliente_cheque()
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tipo de altera$$HEX2$$e700e300$$ENDHEX$$o na filial n$$HEX1$$e300$$ENDHEX$$o preparado.", Exclamation!)
		lvb_Ok = False
End Choose

Return lvb_Ok
end function

public function boolean wf_altera_bloqueio ();Datetime lvdh_Liberacao

String lvs_Matric_Liberacao

Long lvl_Filial
Long lvl_Bloqueio

Boolean lvb_Ok = False
Boolean lvb_Loja_pdv_novo

String lvs_msg

dw_1.AcceptText( )

Try
	lvl_Filial 		= Long(Mid(ivs_Chave,1,Pos(ivs_Chave,";") - 1))
	lvl_Bloqueio	= Long(Mid(ivs_Chave,Pos(ivs_Chave,";") + 1))
	
	If Not gf_retorna_loja_pdv_novo(lvl_Filial, ref lvb_Loja_pdv_novo, ref lvs_msg) Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel verificar filial no PDV Novo para o bloqueio "+String(lvl_Bloqueio)+".~r~n"+lvs_msg,Exclamation!)
		Return False
	Else
		//Se a filial for PDV JAVA n$$HEX1$$e300$$ENDHEX$$o efetuar a conexao com o banco de dados.
		If lvb_Loja_pdv_novo Then Return True
	End If

	
	If Not This.wf_Conecta_Filial( ivo_Filial.Cd_Filial ) Then Return False
	
	select dh_liberacao, nr_matricula_liberacao
	Into :lvdh_Liberacao, :lvs_Matric_Liberacao
	From bloqueio
	Where nr_bloqueio = :lvl_Bloqueio
		And cd_filial = :lvl_Filial
	Using SQLCa;
	
	Choose Case SQLCa.SQLCode
		Case -1 
			SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o do bloqueio." )
			Return False
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o bloqueio "+String(lvl_Bloqueio)+".",Exclamation!)
			Return False
		Case 0
			//
	End Choose
	
	UPDATE bloqueio
		 SET dh_liberacao = :lvdh_Liberacao,
			nr_matricula_liberacao = :lvs_Matric_Liberacao
	Where nr_bloqueio = :lvl_Bloqueio
		And cd_filial = :lvl_Filial
	  USING ivtr_Filial;
	
	If ivtr_Filial.SqlCode = -1 Then
		ivtr_Filial.of_RollBack( )
		ivtr_Filial.Of_MsgdbError("Erro ao liberar o bloqueio "+String(lvl_Bloqueio))
	Else			
		lvb_Ok = True
		ivtr_Filial.of_Commit()	
	End If
	
Catch( RuntimeError ex )
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ex.getMessage( ) + '~rwf_altera_bloqueio( )' )
	lvb_Ok = False

Finally
	wf_Desconecta_Filial( )
	Return lvb_Ok
End Try
end function

on w_ge136_alteracao_matriz_filial.create
call super::create
end on

on w_ge136_alteracao_matriz_filial.destroy
call super::destroy
end on

event ue_preopen;call super::ue_preopen;ivo_filial = Create uo_filial
ivo_Odbc = Create dc_uo_odbc
ivtr_Filial = Create uo_ge136_transacao_remota
end event

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_Odbc)
Destroy(ivtr_Filial)
end event

event ue_postopen;call super::ue_postopen;String lvs_Parametro

lvs_Parametro	= Message.StringParm
ivl_Tipo			= Long(Mid(lvs_Parametro,1,Pos(lvs_Parametro,';') - 1 ))
lvs_Parametro	= Mid(lvs_Parametro, Pos(lvs_Parametro,';') + 1)
ivs_Chave		= lvs_Parametro
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge136_alteracao_matriz_filial
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge136_alteracao_matriz_filial
integer width = 1417
integer height = 180
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge136_alteracao_matriz_filial
integer width = 1358
integer height = 88
string dataobject = "dw_ge136_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case 'nm_filial'
		If Data <> ivo_filial.nm_fantasia Then
			If Data <> '' Then
				Return 1
			Else
				ivo_filial.of_inicializa( )
				This.Object.cd_filial	[Row] = ivo_filial.cd_filial
				This.Object.nm_filial	[Row] = ivo_filial.nm_fantasia
			End If
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key=KeyEnter! Then
	Choose Case This.GetColumnName()
		Case 'nm_filial'
			ivo_filial.of_inicializa( )
			ivo_filial.of_localiza_filial(This.GetText())
			
			This.Object.cd_filial	[1] = ivo_filial.cd_filial
			This.Object.nm_filial	[1] = ivo_filial.nm_fantasia		
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_filial) Then
	This.Object.nm_filial [1] = ivo_filial.nm_fantasia
End if

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge136_alteracao_matriz_filial
integer x = 795
integer y = 220
boolean default = false
end type

event cb_ok::clicked;call super::clicked;If wf_executa_filial() Then
	CloseWithReturn(Parent,"OK")
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge136_alteracao_matriz_filial
integer x = 1129
integer y = 220
string text = "Cancelar"
end type

