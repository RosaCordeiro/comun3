HA$PBExportHeader$uo_ge614_importacoes.sru
forward
global type uo_ge614_importacoes from nonvisualobject
end type
end forward

global type uo_ge614_importacoes from nonvisualobject
end type
global uo_ge614_importacoes uo_ge614_importacoes

forward prototypes
public subroutine of_move_xmls ()
public function boolean of_importacao_nf_quimidrol ()
public function boolean of_importacao_xml ()
public function boolean of_importacao_nf_filiais ()
public function boolean of_importacao_nf_cd ()
public function boolean of_verifica_notas_canceladas ()
end prototypes

public subroutine of_move_xmls ();String ls_mover_xml, ls_Log

//As funcionalidades de mover o xml devem acontecer a todo momento, mesmo durante a parada programada
//$$HEX1$$c900$$ENDHEX$$ um processo curto e r$$HEX1$$e100$$ENDHEX$$pido que n$$HEX1$$e300$$ENDHEX$$o deve atrapalhar o fechamento da multtask
ls_mover_xml			= gvo_Aplicacao.of_GetFromINI("Diretorio", "XMLLeitura") 

gf_mover_arquivo_xml(ls_mover_xml, ref ls_log)
end subroutine

public function boolean of_importacao_nf_quimidrol ();Boolean lb_retorno = False	  
DateTime ldt_Parametro
Long ll_Filial, ll_linha
String ls_Title
Time lt_Agora


of_move_xmls()

ldt_Parametro = gf_getServerDate()

lt_Agora = Now()

Try
	ls_Title = "Importando XML do pedido - FILIAIS" 
	
	If Not gvo_Aplicacao.of_Appisrunning(ls_Title ) Then
		uo_ge250_xml_pedido_eletronico lo_NFE
		lo_NFE = Create uo_ge250_xml_pedido_eletronico
		lo_NFE.il_filial_auxiliar = 9998
		lb_retorno = lo_NFE.of_Processa_Atualizacao('')
	End If
	
	return lb_retorno
Finally
	Destroy(lo_NFE)
End Try
end function

public function boolean of_importacao_xml ();Boolean	lb_retorno

Try
	of_move_xmls()

	uo_ge238_importa_xml  lo
	lo = Create uo_ge238_importa_xml
	lb_retorno = lo.of_processa_leitura()
	
	Return lb_retorno
Finally
	destroy lo
End Try
end function

public function boolean of_importacao_nf_filiais ();Boolean lb_retorno = False
DateTime ldt_Parametro
Time lt_Agora
String ls_Title
Long ll_Filial

of_move_xmls()

ldt_Parametro = gf_getServerDate()

lt_Agora = Now()

Long ll_Linha

Try
	ls_Title = "Importando XML do pedido - FILIAIS" 
	
	If Not gvo_Aplicacao.of_Appisrunning(ls_Title ) Then
		uo_ge250_xml_pedido_eletronico lo_NFE
		lo_NFE = Create uo_ge250_xml_pedido_eletronico
		lo_NFE.il_filial_auxiliar = 9999
		lb_retorno = lo_NFE.of_Processa_Atualizacao('')
	End If
	
	Return lb_retorno
Finally
	Destroy(lo_NFE)
End Try
end function

public function boolean of_importacao_nf_cd ();Boolean lb_retorno = False
DateTime ldt_Parametro
Time lt_Agora	  
String ls_Title
Long ll_Filial


of_move_xmls()

ldt_Parametro = gf_getServerDate()

lt_Agora = Now()

Long ll_Linha

Try
	ls_Title = "Importando XML do pedido - EST. CENTRAL" 
	
	If Not gvo_Aplicacao.of_Appisrunning(ls_Title ) Then
		uo_ge250_xml_pedido_eletronico lo_NFE
		lo_NFE = Create uo_ge250_xml_pedido_eletronico
		lo_NFE.il_filial_auxiliar = 534
		lb_retorno = lo_NFE.of_Processa_Atualizacao('')
	End If
	
	Return lb_retorno
Finally
	Destroy(lo_NFE)
End Try
end function

public function boolean of_verifica_notas_canceladas ();String ls_Controle_Mysql = ''
Date ldt_Parametro

If String(Now(), 'hh:mm:ss') > "13:00:00" And String(Now(), 'hh:mm:ss') < "15:00:00" Then
	
	Boolean lb_Retorno
	String ls_Msg
	
	Try
		ldt_Parametro = date(today())
	
		dc_uo_transacao lo_Intranet
		lo_Intranet = create dc_uo_transacao
		
		lo_Intranet.ivs_DataBase = "MYSQL"
		lo_Intranet.ivs_Usuario = 'gambiarra'
		
		lb_Retorno = lo_Intranet.of_Connect("Intranet", "GN")
		
		If Not lb_Retorno Then
			gvo_Aplicacao.of_Grava_Log( "Erro conectar no banco Intranet.")
			lb_Retorno = False
		End If
	
		If lb_Retorno Then
		
			ls_Controle_Mysql = 'nf_compra_cancelada_gn'
			
			 Select dh_envio
				 Into :ldt_Parametro
			  From controle_envio_email
			Where dh_envio = :ldt_Parametro
				 And de_email = :ls_Controle_Mysql
			  Using lo_Intranet;
			 
			 Choose Case lo_Intranet.SqlCode
				Case -1
					lo_Intranet.of_LogDbError(gvo_Aplicacao.ivi_Log, "Localiza$$HEX2$$e700e300$$ENDHEX$$o da data de envio dos emails." + ls_Controle_Mysql)
					Return False
				Case 0
					//Email enviado
					Return True
				Case 100
					uo_ge614_notas_canceladas lo
					lo = Create uo_ge614_notas_canceladas
					lo.of_Verifica_Nf(Ref ls_Msg)
					Destroy lo
					
					Insert
						into controle_envio_email (dh_envio, de_email)
					 values (:ldt_Parametro, :ls_Controle_Mysql)
					Using lo_Intranet;
					
					If lo_Intranet.SqlCode = -1 Then
						lo_Intranet.of_LogDbError(gvo_Aplicacao.ivi_Log, "Erro ao gravar data de envio no banco Intranet." + ls_Controle_Mysql)
						lo_Intranet.of_RollBack()
						Return False
					Else
						lo_Intranet.of_Commit()
						lb_retorno = True
					End If
			End Choose
		End If
		
		Return lb_retorno
	Finally
		lo_Intranet.of_Disconnect()
		Destroy lo_Intranet
	End Try
End If
end function

on uo_ge614_importacoes.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge614_importacoes.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

