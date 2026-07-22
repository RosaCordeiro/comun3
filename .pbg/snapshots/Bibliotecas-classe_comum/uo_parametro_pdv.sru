HA$PBExportHeader$uo_parametro_pdv.sru
forward
global type uo_parametro_pdv from nonvisualobject
end type
end forward

global type uo_parametro_pdv from nonvisualobject
end type
global uo_parametro_pdv uo_parametro_pdv

type variables

end variables

forward prototypes
public function boolean of_atualiza_parametro (string as_parametro, date adt_valor)
public function boolean of_atualiza_parametro (string as_parametro, datetime adh_valor)
public function boolean of_atualiza_parametro (string as_parametro, decimal adc_valor)
public function boolean of_atualiza_parametro (string as_parametro, integer ai_valor)
public function boolean of_atualiza_parametro (string as_parametro, long al_valor)
public function boolean of_localiza_parametro (string as_codigo, ref string as_valor, boolean ab_mostra_mensagem)
public function boolean of_localiza_parametro (string as_codigo, ref string as_valor)
public function boolean of_localiza_parametro (string as_parametro, ref boolean ab_valor)
public function boolean of_localiza_parametro (string as_parametro, ref date adt_data)
public function boolean of_localiza_parametro (string as_parametro, ref datetime adh_data)
public function boolean of_localiza_parametro (string as_parametro, ref decimal adc_valor)
public function boolean of_localiza_parametro (string as_parametro, ref integer ai_valor)
public function boolean of_localiza_parametro (string as_parametro, ref long al_valor)
public function boolean of_grava_uptime ()
public function boolean of_atualiza_parametro (string as_codigo, string as_valor, boolean ab_insere)
public function boolean of_atualiza_parametro (string as_codigo, string as_valor)
public function boolean of_grava_usa_leitor_biometrico (string as_valor)
public function boolean of_pdv_propria_filial ()
public function boolean of_grava_id_obriga_biometria (string as_valor)
public function boolean of_grava_cd_caixa ()
public subroutine of_carrega_parametros ()
public function boolean of_grava_mac_address ()
public function string of_get_mac_address ()
public function boolean of_grava_informacoes_pdv ()
public function boolean of_grava_ip_address ()
public function boolean of_grava_user_name ()
public function boolean of_limpa_informacoes_pdv ()
public function string of_get_cd_caixa ()
public function string of_get_lista_odbc_from ()
public function string of_get_permite_senha_digitada ()
end prototypes

public function boolean of_atualiza_parametro (string as_parametro, date adt_valor);String lvs_Valor

lvs_Valor = String(adt_Valor, "dd/mm/yyyy")

Return This.of_Atualiza_Parametro( as_Parametro, lvs_Valor )
end function

public function boolean of_atualiza_parametro (string as_parametro, datetime adh_valor);String lvs_Valor

lvs_Valor = String(adh_Valor, "dd/mm/yyyy hh:mm:ss:fff")

Return This.of_Atualiza_Parametro( as_Parametro, lvs_Valor )
end function

public function boolean of_atualiza_parametro (string as_parametro, decimal adc_valor);String lvs_Valor

lvs_Valor = String( adc_Valor, "0.00" )

Return This.of_Atualiza_Parametro( as_Parametro, lvs_Valor )
end function

public function boolean of_atualiza_parametro (string as_parametro, integer ai_valor);String lvs_Valor

lvs_Valor = String( ai_Valor )

Return This.of_Atualiza_Parametro( as_Parametro, lvs_Valor )
end function

public function boolean of_atualiza_parametro (string as_parametro, long al_valor);String lvs_Valor

lvs_Valor = String( al_Valor )

Return This.of_Atualiza_Parametro( as_Parametro, lvs_Valor )
end function

public function boolean of_localiza_parametro (string as_codigo, ref string as_valor, boolean ab_mostra_mensagem);Boolean lb_Sucesso = False

Try
	dc_uo_transacao lvtr_Trans
	
	//Cria uma nova conex$$HEX1$$e300$$ENDHEX$$o/transa$$HEX2$$e700e300$$ENDHEX$$o para os ajustes no banco
	If SQLCa.Of_Connect_New_Trans_INI( ref lvtr_Trans) Then
		If Not IsValid( gvo_Aplicacao ) Then
			If ab_Mostra_Mensagem Then
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "gvo_Aplicacao n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ uma vari$$HEX1$$e100$$ENDHEX$$vel v$$HEX1$$e100$$ENDHEX$$lida.", StopSign! )
			End If
			
			Return lb_Sucesso
		End If
		
		If gvo_Aplicacao.is_ComputerName = "" Then
			If ab_Mostra_Mensagem Then
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "gvo_Aplicacao.is_ComputerName n$$HEX1$$e300$$ENDHEX$$o possui valor atribuido.", StopSign! )
			End If
			
			Return lb_Sucesso
		End If
		
		  SELECT vl_parametro
			INTO :as_Valor
			FROM parametro_pdv
		 WHERE cd_filial			= dbo.uf_filial_parametro( )
			 AND nm_pdv			= :gvo_Aplicacao.is_ComputerName
			 AND cd_parametro	= :as_Codigo
		  USING lvtr_Trans;
		
		Choose Case lvtr_Trans.SqlCode
			Case 0
				lb_Sucesso = True
				
			Case 100
				If ab_Mostra_Mensagem Then
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign! )
				End If
				
			Case -1
				
				If ab_Mostra_Mensagem Then
					lvtr_Trans.of_MsgdbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Codigo + "'" )
				End If
				
		End Choose
	Else
		If ab_Mostra_Mensagem Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", This.ClassName()+".of_localiza_parametro(): N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar ao banco de dados para captura dos parametro_pdv.", Exclamation!)
		lb_Sucesso = False
	End If
	
Catch (RuntimeError lvo_Erro)
	If ab_Mostra_Mensagem Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvo_Erro.GetMessage(), StopSign!)
	lb_Sucesso = False
	
Finally
	If IsValid(lvtr_Trans) Then 
		lvtr_Trans.Of_End_Transaction( )
		lvtr_Trans.Of_Disconnect( )
		Destroy(lvtr_Trans)
	End If
End Try

Return lb_Sucesso
end function

public function boolean of_localiza_parametro (string as_codigo, ref string as_valor);Return This.of_Localiza_Parametro( as_Codigo, ref as_Valor, True )
end function

public function boolean of_localiza_parametro (string as_parametro, ref boolean ab_valor);Boolean lvb_Sucesso = False

String lvs_Valor

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	lvb_Sucesso = True
	
	If lvs_Valor = "S" Then
		ab_Valor = True
	Else
		ab_Valor = False
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro (string as_parametro, ref date adt_data);Boolean lvb_Sucesso = False

String lvs_Valor

// Formato do par$$HEX1$$e200$$ENDHEX$$metro: dd/mm/yyyy

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 	
	If IsDate(lvs_Valor) Then
		adt_Data = Date(lvs_Valor)
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro (string as_parametro, ref datetime adh_data);Boolean lvb_Sucesso = False

String lvs_Valor, &
       lvs_Data, &
		 lvs_Hora

// Formato do par$$HEX1$$e200$$ENDHEX$$metro: dd/mm/yyyy hh:mm:ss:fff
	
If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	lvs_Data = LeftA(lvs_Valor, 10)
	lvs_Hora = MidA(lvs_Valor, 12)
	
	If IsDate(lvs_Data) and IsTime(lvs_Hora) Then
		adh_Data = DateTime(Date(lvs_Data), Time(lvs_Hora))
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro (string as_parametro, ref decimal adc_valor);Boolean lvb_Sucesso = False

String lvs_Valor

Integer lvi_Pos

// Formato do Par$$HEX1$$e200$$ENDHEX$$metro: 0.00

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	lvi_Pos = PosA(lvs_Valor, ".")
	
	If lvi_Pos > 0 Then
		lvs_Valor = LeftA(lvs_Valor, lvi_Pos - 1) + "," + MidA(lvs_Valor, lvi_Pos + 1)
	End If
	
	If IsNumber(lvs_Valor) Then
		adc_Valor = Dec(lvs_Valor)	
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro (string as_parametro, ref integer ai_valor);Boolean lvb_Sucesso = False

String lvs_Valor

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	If IsNumber(lvs_Valor) Then
		ai_Valor = Integer(lvs_Valor)	
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro (string as_parametro, ref long al_valor);Boolean lvb_Sucesso = False

String lvs_Valor

If This.of_Localiza_Parametro(as_Parametro, lvs_Valor) Then 
	If IsNumber(lvs_Valor) Then
		al_Valor = Long(lvs_Valor)	
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_grava_uptime ();Try
	dc_uo_api lo_api
	lo_api = Create dc_uo_api
	
	Return This.of_Atualiza_Parametro( "UPTIME", lo_Api.of_UpTime( ), True )
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_grava_uptime( )", StopSign! )
	Return False
	
Finally
	Destroy lo_api
End Try
end function

public function boolean of_atualiza_parametro (string as_codigo, string as_valor, boolean ab_insere);dc_uo_transacao lvtr_Trans
Boolean lvb_Sucesso = True

Try
	If Not IsValid( gvo_Aplicacao ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "gvo_Aplicacao n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ uma vari$$HEX1$$e100$$ENDHEX$$vel v$$HEX1$$e100$$ENDHEX$$lida.", StopSign! )
		lvb_Sucesso = False
		Return lvb_Sucesso
	End If
	
	If gvo_Aplicacao.is_ComputerName = "" Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "gvo_Aplicacao.is_ComputerName n$$HEX1$$e300$$ENDHEX$$o possui valor atribuido.", StopSign! )
		lvb_Sucesso = False
		Return lvb_Sucesso
	End If
	
	//Cria uma nova conex$$HEX1$$e300$$ENDHEX$$o/transa$$HEX2$$e700e300$$ENDHEX$$o para os ajustes no banco
	If SQLCa.Of_Connect_New_Trans_INI( ref lvtr_Trans) Then
		UPDATE parametro_pdv
			 SET vl_parametro		= :as_Valor,
					dh_atualizacao = getdate( )
		WHERE cd_filial				= dbo.uf_filial_parametro( )
			AND nm_pdv			= :gvo_Aplicacao.is_ComputerName
			AND cd_parametro	= :as_Codigo
		  USING lvtr_Trans;
		
		If lvtr_Trans.SqlCode = -1 Then
			lvtr_Trans.of_RollBack( )
			lvtr_Trans.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do parametro_pdv '" + as_Codigo + "'")
			lvb_Sucesso = False
			Return lvb_Sucesso
		End If
		
		If lvtr_Trans.SqlnRows <> 1 Then
			If lvtr_Trans.SqlnRows = 0 And ab_Insere Then
				 INSERT
					INTO parametro_pdv ( cd_filial, nm_pdv, cd_parametro, vl_parametro, dh_atualizacao )
				VALUES ( dbo.uf_filial_parametro( ), :gvo_Aplicacao.is_ComputerName, :as_Codigo, :as_Valor, getdate( ) )
				USING lvtr_Trans;
				
				If lvtr_Trans.SqlCode = -1 Then
					lvtr_Trans.of_RollBack( )
					lvtr_Trans.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do parametro_pdv '" + as_Codigo + "'")
					lvb_Sucesso = False
					Return lvb_Sucesso
				End If
			Else	//io_Tran.SqlnRows = 0 And ab_Insere
				lvtr_Trans.of_RollBack( )
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do parametro_pdv '" + as_Codigo + "'.~r" + &
												"N$$HEX1$$fa00$$ENDHEX$$mero de linhas atualizadas '" + String( lvtr_Trans.SqlnRows ) + "'.", StopSign! )
				lvb_Sucesso = False
				Return lvb_Sucesso
			End If //io_Tran.SqlnRows = 0
		End If // io_Tran.SqlnRows <> 1
		
	Else
		lvtr_Trans.of_RollBack( )
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", This.ClassName()+".of_atualiza_parametro(): N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar no banco de dados configurado no INI.", StopSign!)
		lvb_Sucesso = False
		Return lvb_Sucesso
	End If
	
Catch (RuntimeError lvo_Erro)
	If IsValid(lvtr_Trans) Then lvtr_Trans.of_RollBack( )
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvo_Erro.GetMessage(), StopSign!)
	lvb_Sucesso = False
	Return lvb_Sucesso
	
Finally
	//Se objeto est$$HEX1$$e100$$ENDHEX$$ instanciado
	If IsValid(lvtr_Trans) Then
		//Se tiver conectado ao banco
		If lvtr_Trans.Of_IsConnected( ) Then
			//Se sucesso
			If lvb_Sucesso Then
				//Efetiva altera$$HEX2$$e700f500$$ENDHEX$$es
				lvtr_Trans.Of_Commit()
			Else
				//Desfaz altera$$HEX2$$e700f500$$ENDHEX$$es
				lvtr_Trans.Of_Rollback()
			End If
		End If
		//For$$HEX1$$e700$$ENDHEX$$a o encerramento da transa$$HEX2$$e700e300$$ENDHEX$$o
		lvtr_Trans.Of_End_Transaction( )
		//Disconecta
		lvtr_Trans.Of_Disconnect( )
		//Destroy o objeto
		Destroy(lvtr_Trans)
	End If
End Try

Return lvb_Sucesso
end function

public function boolean of_atualiza_parametro (string as_codigo, string as_valor);// Terceiro argumento FALSE far$$HEX1$$e100$$ENDHEX$$ com que o sistema n$$HEX1$$e300$$ENDHEX$$o realize INSERT caso n$$HEX1$$e300$$ENDHEX$$o exista
Return This.of_Atualiza_Parametro( as_Codigo, as_Valor, False )
end function

public function boolean of_grava_usa_leitor_biometrico (string as_valor);Boolean lb_Retorno = False

Try
	lb_Retorno = This.of_Atualiza_Parametro( "USA_LEITOR_BIOMETRICO", as_Valor, True )
	
	If lb_Retorno And as_Valor = 'S' Then // Atualiza para obrigar identificacao por biometria
		lb_Retorno = This.of_Atualiza_Parametro( "ID_PERMITE_LOGIN_SENHA_DIGITADA", "N", True )
	End If
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_grava_usa_leitor_biometrico( )", StopSign! )
	Return False
	
Finally
	
End Try
end function

public function boolean of_pdv_propria_filial ();String ls_Filial

Boolean lb_Retorno = False

Try
	dc_uo_transacao lvtr_Trans
	
	//Abre nova conex$$HEX1$$e300$$ENDHEX$$o com o BD
	If SQLCa.Of_Connect_New_Trans_INI( ref lvtr_Trans) Then
		 SELECT Right( '0000' || cast( cd_filial as varchar ), 4 )
			INTO :ls_Filial
			FROM parametro
		 WHERE id_parametro = '1'
		  USING lvtr_Trans;
		  
		Choose Case lvtr_Trans.SqlCode
			Case -1
				lvtr_Trans.of_MsgDbError( 'uo_parametro_pdv.of_pdv_propria_filial( )' )
				Return False
				
			Case 100
				Return False
				
			Case 0
				If Left( gvo_Aplicacao.is_ComputerName, 4 ) = ls_Filial Then
					lb_Retorno = True
				End If
				
		End Choose
	Else
		lb_Retorno = False
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", This.ClassName()+".of_pdv_propria_filial(): N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar-se ao banco de dados pelos par$$HEX1$$e200$$ENDHEX$$metros do INI.", Exclamation!)
	End If
	
Catch (RuntimeError lvo_Erro)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvo_Erro.GetMessage(), StopSign!)
	lb_Retorno = False
	
Finally
	If IsValid(lvtr_Trans) Then 
		lvtr_Trans.Of_End_Transaction( )
		lvtr_Trans.Of_Disconnect( )
		Destroy(lvtr_Trans)
	End If
End Try

Return lb_Retorno

end function

public function boolean of_grava_id_obriga_biometria (string as_valor);Try
	If This.of_Pdv_Propria_Filial( ) Then
		Return This.of_Atualiza_Parametro( "ID_OBRIGA_BIOMETRIA", as_Valor, True )
	End If
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_grava_id_obriga_biometria( )", StopSign! )
	Return False
	
Finally
	
End Try
end function

public function boolean of_grava_cd_caixa ();Return True

/* Fernando Cambiaghi - 09/09/2016
 * A fun$$HEX2$$e700e300$$ENDHEX$$o deixa de ser utilizada, pois os novos PDV's seguem o padr$$HEX1$$e300$$ENDHEX$$o cd_caixa = nm_pdv
 */

String ls_Valor

Try
	If Not This.of_Pdv_Propria_Filial( ) Then Return True
	
	ls_Valor = ProfileString( "c:\sistemas\cl\exe\caixa.ini", "CAIXA", "Caixa", "" )

	If ls_Valor = "" Then Return True

	Return This.of_Atualiza_Parametro( "CD_CAIXA", ls_Valor, True )
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_grava_cd_caixa( )", StopSign! )
	Return False
	
Finally
	
End Try
end function

public subroutine of_carrega_parametros ();This.of_Grava_Cd_Caixa( )
end subroutine

public function boolean of_grava_mac_address ();Try
	dc_uo_api lo_api
	lo_api = Create dc_uo_api
	
	Return This.of_Atualiza_Parametro( "MAC_ADDRESS", lo_Api.of_GetMac( ), True )
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_mac_address( )", StopSign! )
	Return False
	
Finally
	Destroy lo_api
End Try
end function

public function string of_get_mac_address ();String ls_Parametro = ''

Try
	If Not This.of_Localiza_Parametro( 'MAC_ADDRESS', Ref ls_Parametro, False ) Then
		ls_Parametro = '(Cannot Resolved MAC)'
	End If
	
	Return ls_Parametro
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_get_mac_address( )", StopSign! )
	
Finally
	
End Try
end function

public function boolean of_grava_informacoes_pdv ();Try
	If This.of_Grava_UpTime( ) Then
		If This.of_Grava_Mac_Address( ) Then
			If This.of_Grava_IP_Address( ) Then
				If This.of_Grava_User_Name( ) Then
					Return True
				End If
			End If
		End If
	End If
	
	Return False
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_grava_informacoes_pdv( )", StopSign! )
	Return False
	
Finally
	gvo_Aplicacao.of_SetMicrohelp( )
End Try
end function

public function boolean of_grava_ip_address ();String ls_IP

Try
	dc_uo_api lo_api
	lo_api = Create dc_uo_api
	
	ls_IP = lo_Api.of_GetIp_Host( gvo_Aplicacao.is_ComputerName )
	
	This.of_Atualiza_Parametro( "IP_ADDRESS", ls_IP, True )
	
	Return ( ls_IP <> '' )
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_grava_ip_address( )", StopSign! )
	Return False
	
Finally
	Destroy lo_api
End Try
end function

public function boolean of_grava_user_name ();Try
	dc_uo_api lo_api
	lo_api = Create dc_uo_api
	
	Return This.of_Atualiza_Parametro( "USER_NAME", lo_Api.of_Get_User_Name( ), True )
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_grava_user_name( )", StopSign! )
	Return False
	
Finally
	Destroy lo_api
End Try
end function

public function boolean of_limpa_informacoes_pdv ();Boolean lvb_Sucesso = True

Try
	dc_uo_transacao lvtr_Trans
	
	//Abre nova conex$$HEX1$$e300$$ENDHEX$$o com o banco
	If SQLCa.Of_Connect_New_Trans_INI( ref lvtr_Trans) Then
		//Em caso de troca do computador, apaga os dados da tabela
		Delete from parametro_pdv
		 where nm_pdv = :gvo_Aplicacao.is_ComputerName
		Using lvtr_Trans;
		
		If lvtr_Trans.SqlCode = -1 Then
			lvtr_Trans.of_RollBack( )
			lvtr_Trans.of_MsgDbError( 'uo_pdv.of_limpa_informacoes_pdv( )' )
			lvb_Sucesso = False
			Return lvb_Sucesso
		End If		
		
		Delete from sistema_pdv
		 where nm_pdv = :gvo_Aplicacao.is_ComputerName
		Using lvtr_Trans;
				
		If lvtr_Trans.SqlCode = -1 Then
			lvtr_Trans.of_RollBack( )
			lvtr_Trans.of_MsgDbError( 'uo_pdv.of_limpa_informacoes_pdv( )' )
			lvb_Sucesso = False
			Return lvb_Sucesso
		End If
		
		lvtr_Trans.of_commit( )
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", This.ClassName()+".of_limpa_informacoes_pdv(): N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar no banco de dados configurado no INI.", StopSign!)
		lvb_Sucesso = False
		Return lvb_Sucesso
	End If


Catch (RuntimeError lvo_Erro)
	If IsValid(lvtr_Trans) Then lvtr_Trans.Of_Rollback( )
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", lvo_Erro.GetMessage(), StopSign!)
	lvb_Sucesso = False
	Return lvb_Sucesso
	
Finally
	If IsValid(lvtr_Trans) Then
		//Se tiver conectado ao banco
		If lvtr_Trans.Of_IsConnected( ) Then
			//Se sucesso
			If lvb_Sucesso Then
				//Efetiva altera$$HEX2$$e700f500$$ENDHEX$$es
				lvtr_Trans.Of_Commit()
			Else
				//Desfaz altera$$HEX2$$e700f500$$ENDHEX$$es
				lvtr_Trans.Of_Rollback()
			End If
		End If
		//For$$HEX1$$e700$$ENDHEX$$a o encerramento da transa$$HEX2$$e700e300$$ENDHEX$$o
		lvtr_Trans.Of_End_Transaction( )
		//Disconecta
		lvtr_Trans.Of_Disconnect( )
		//Destroy o objeto
		Destroy(lvtr_Trans)
	End If
End Try

Return lvb_Sucesso
end function

public function string of_get_cd_caixa ();/* Fernando Cambiaghi - 09/09/2016
 * Retorna o cd_caixa da tabela parametro_pdv ou o nome do pdv caso n$$HEX1$$e300$$ENDHEX$$o exista cadastro
 */
String ls_Parametro

SetNull( ls_Parametro )

Try
	dc_uo_transacao lvtr_Trans
	
	//Localiza par$$HEX1$$e200$$ENDHEX$$metro
	This.of_Localiza_Parametro( 'CD_CAIXA', Ref ls_Parametro, False )
	
	//Encontrou o caixa
	If IsNull( ls_Parametro ) Then
		
		ls_Parametro = gvo_Aplicacao.is_ComputerName
		
		ls_Parametro = LeftA( ls_Parametro, 4 ) + MidA( ls_Parametro, 6, 2 )
		
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CL' Then
				
			//Abre nova conex$$HEX1$$e300$$ENDHEX$$o
			If SQLCa.Of_Connect_New_Trans_INI( ref lvtr_Trans) Then
			
				// Se houver outro PDV com o mesmo CD_CAIXA n$$HEX1$$e300$$ENDHEX$$o permite prosseguir
				Long ll_Achou
				
				SELECT count( 1 )
				INTO :ll_Achou
				FROM parametro_pdv
				WHERE cd_parametro = 'CD_CAIXA'
				AND vl_parametro = :ls_Parametro
				USING lvtr_Trans;
				
				Choose Case lvtr_Trans.SqlCode
					Case -1
						lvtr_Trans.Of_RollBack()
						lvtr_Trans.of_MsgDbError( "uo_parametro_pdv.of_get_cd_caixa( )" )
						
					Case 0
						If ll_Achou > 0 Then
							MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe outro PDV utilizando o caixa " + ls_Parametro + ".~r~rEntre em contato com TI - Desenvolvimento para ativar este PDV.", Exclamation! )
							Return '*' // * faz a fun$$HEX2$$e700e300$$ENDHEX$$o que chamou esta retornar false
						End If
						
				End Choose
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", This.ClassName()+".of_get_cd_caixa(): N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar no banco de dados com os par$$HEX1$$e200$$ENDHEX$$metros do INI.", Exclamation!)
				Return '*'
			End If //Nova conex$$HEX1$$e300$$ENDHEX$$o
			
		End If // gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CL' '
		
	End If	//Encontrou parametro
	
	Return ls_Parametro
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_get_cd_caixa( )", StopSign! )
	Return '*'
	
Finally
	If IsValid(lvtr_Trans) Then
		lvtr_Trans.Of_End_Transaction( )
		lvtr_Trans.Of_Disconnect( )
		Destroy(lvtr_Trans)
	End If
End Try
end function

public function string of_get_lista_odbc_from ();/* Funcao que retorna se deve listar os ODBCs a partir da parametro_odbc ou do Windows 
 * Retorno: PARAMETRO_ODBC = parametro_odbc
 				SO = sistema_operacional (DEFAULT)
*/

String ls_Parametro
String ls_Retorno	= 'SO'

Try
	If This.of_Localiza_Parametro( 'LISTA_ODBC_FROM', Ref ls_Parametro, False ) Then
		If Not IsNull( ls_Parametro ) And Trim( ls_Parametro ) = 'PARAMETRO_ODBC' Then
			ls_Retorno = ls_Parametro
		End If
	End If
	
	Return ls_Retorno
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_get_lista_odbc_from( )", StopSign! )
	Return ls_Retorno	
Finally
	
End Try
end function

public function string of_get_permite_senha_digitada ();String ls_Parametro = 'N'

Try
	If Not This.of_Localiza_Parametro( 'ID_PERMITE_LOGIN_SENHA_DIGITADA', Ref ls_Parametro, False ) Then
		SetNull( ls_Parametro )
		Return ls_Parametro
	End If
	
	If Not IsNull( ls_Parametro ) And ls_Parametro <> 'N' And ls_Parametro <> 'S' Then
		ls_Parametro = 'N'
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Configura$$HEX2$$e700e300$$ENDHEX$$o do parametro ID_PERMITE_LOGIN_SENHA_DIGITADA incorreta na parametro_pdv.~rValores permitidos( S, N )", StopSign! )
	End If
	
	Return ls_Parametro
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + "~r~ruo_parametro_pdv.of_get_permite_login_senha_digitada( )", StopSign! )
	Return 'N'	
Finally
	
End Try
end function

on uo_parametro_pdv.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametro_pdv.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

