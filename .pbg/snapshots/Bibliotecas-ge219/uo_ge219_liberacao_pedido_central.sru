HA$PBExportHeader$uo_ge219_liberacao_pedido_central.sru
forward
global type uo_ge219_liberacao_pedido_central from nonvisualobject
end type
end forward

global type uo_ge219_liberacao_pedido_central from nonvisualobject
end type
global uo_ge219_liberacao_pedido_central uo_ge219_liberacao_pedido_central

type variables
string nr_matricula_responsavel, nm_responsavel, de_endereco_email_responsavel

decimal vl_pedido

long nr_nivel_autorizado, nr_nivel_responsavel, nr_pedido_central

boolean ivb_Rascunho
end variables

forward prototypes
public function boolean of_verifica_valor_maximo_liberacao (string as_responsavel, ref decimal adc_maximo_liberacao)
public function boolean of_localiza_nivel_autorizado_liberacao (decimal adc_valor_pedido)
public subroutine of_envia_email (string as_remetente, string as_assunto, string as_mensagem, string as_email_origem, string as_email_destino[])
public function boolean of_processa_liberacao_pedido (string as_responsavel, string as_nome_responsavel, string as_email_responsavel, decimal adc_valor_pedido, long al_pedido)
public function boolean of_verifica_valor_maximo_liberacao (string as_responsavel, ref decimal adc_maximo_liberacao, ref string as_mensagem_erro)
public function boolean of_localiza_email_usuario (string as_matricula, ref string as_email, ref string as_mensagem_log)
end prototypes

public function boolean of_verifica_valor_maximo_liberacao (string as_responsavel, ref decimal adc_maximo_liberacao);Decimal ldc_Limite_Nivel, ldc_Limite_Usuario

Long ll_Nivel_Responsavel

Select n.vl_maximo_liberado, u.vl_maximo_liberado, u.nr_nivel
Into :ldc_Limite_Nivel, :ldc_Limite_Usuario,  :ll_Nivel_Responsavel
From nivel_liberacao_pedido n, nivel_liberacao_pedido_usuario u
Where u.nr_nivel			= n.nr_nivel
  	and u.nr_matricula 	= :as_Responsavel
Using SqlCa;

Choose Case SqlCa.Sqlcode 
	Case 0
		
		If IsNull(ldc_Limite_Usuario) or ldc_Limite_Usuario = 0.00 Then
			adc_maximo_liberacao = ldc_Limite_Nivel
		Else
			adc_maximo_liberacao = ldc_Limite_Usuario
		End If
		
		This.nr_nivel_responsavel = ll_Nivel_REsponsavel
		
	Case 100
		// Para for$$HEX1$$e700$$ENDHEX$$ar a abertura da tela com os usu$$HEX1$$e100$$ENDHEX$$rios liberados para aprovar o pedido
		adc_Maximo_Liberacao = 0.01
							
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$ed00$$ENDHEX$$vel de libera$$HEX2$$e700e300$$ENDHEX$$o de pedido para o usu$$HEX1$$e100$$ENDHEX$$rio '"  + as_Responsavel + "'.")
		Return False
End Choose

Return True
end function

public function boolean of_localiza_nivel_autorizado_liberacao (decimal adc_valor_pedido);Long ll_Nivel

If Not IsNull(This.nr_nivel_responsavel) and This.nr_nivel_responsavel > 0 Then

	Select top 1 nr_nivel 
	Into :ll_Nivel
	From nivel_liberacao_pedido
	Where vl_maximo_liberado 	> 		:adc_Valor_Pedido
		and nr_nivel 				<> 	:this.nr_nivel_responsavel
	order by nr_nivel asc
	Using SqlCa;

Else
	
	Select top 1 nr_nivel 
	Into :ll_Nivel
	From nivel_liberacao_pedido
	Where vl_maximo_liberado > :adc_Valor_Pedido
	order by nr_nivel asc
	Using SqlCa;
	
End If

Choose Case SqlCa.SqlCode
	Case 0
		nr_nivel_autorizado = ll_Nivel
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem pessoas a efetuar a libera$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$ed00$$ENDHEX$$vel autorizado a efetuar a libera$$HEX2$$e700e300$$ENDHEX$$o do pedido")
		Return False
End Choose


end function

public subroutine of_envia_email (string as_remetente, string as_assunto, string as_mensagem, string as_email_origem, string as_email_destino[]);uo_smtp lo_smtp
lo_smtp = Create uo_smtp

lo_smtp.ib_grava_log_db = False

lo_smtp.of_envia_email(as_Remetente, &
                       			as_Email_Origem, &
                       			as_Assunto, &
                       			"<tag html se precisar>" + as_Mensagem + "</tag html se precisar>", &
                      				as_email_destino)                                                                                       
Destroy lo_smtp
end subroutine

public function boolean of_processa_liberacao_pedido (string as_responsavel, string as_nome_responsavel, string as_email_responsavel, decimal adc_valor_pedido, long al_pedido);Decimal ldc_Maximo_Liberacao

If This.of_Verifica_Valor_Maximo_Liberacao(as_Responsavel, ref ldc_Maximo_Liberacao) Then
	
	If adc_Valor_Pedido > ldc_Maximo_Liberacao Then
		
		If Not This.of_Localiza_Nivel_Autorizado_Liberacao(adc_Valor_Pedido) Then Return False
		
		This.nr_matricula_responsavel 				=	as_Responsavel
		This.nm_responsavel 							=	as_nome_responsavel
		This.de_endereco_email_responsavel		=	as_email_responsavel
		This.vl_pedido									= 	adc_Valor_Pedido
		This.nr_pedido_central						= 	al_pedido	
		
		OpenWithParm(w_GE219_Usuario_Autorizados, This)
		
		Return False
	Else
		
		If Not ivb_Rascunho Then
			
			Update pedido_central
			Set id_situacao = 'C'
			Where nr_pedido =:al_Pedido
			Using SqlCa;
			
			If SqlCa.Sqlcode = -1 Then
				SqlCa.of_MsgDbError("Erro ao atualizar o pedido para colocado.")
				SqlCa.of_RollBack();
				Return False
			Else
				SqlCa.of_Commit();
			End If
			
		End If
		
	End If
	
Else
	Return False
End If

Return True
end function

public function boolean of_verifica_valor_maximo_liberacao (string as_responsavel, ref decimal adc_maximo_liberacao, ref string as_mensagem_erro);Decimal ldc_Limite_Nivel, ldc_Limite_Usuario

Long ll_Nivel_Responsavel

Select n.vl_maximo_liberado, u.vl_maximo_liberado, u.nr_nivel
Into :ldc_Limite_Nivel, :ldc_Limite_Usuario,  :ll_Nivel_Responsavel
From nivel_liberacao_pedido n, nivel_liberacao_pedido_usuario u
Where u.nr_nivel			= n.nr_nivel
  	and u.nr_matricula 		= :as_Responsavel
Using SqlCa;

Choose Case SqlCa.Sqlcode 
	Case 0
		
		If IsNull(ldc_Limite_Usuario) or ldc_Limite_Usuario = 0.00 Then
			adc_maximo_liberacao = ldc_Limite_Nivel
		Else
			adc_maximo_liberacao = ldc_Limite_Usuario
		End If
		
		This.nr_nivel_responsavel = ll_Nivel_REsponsavel
		
	Case 100
		// Para for$$HEX1$$e700$$ENDHEX$$ar a abertura da tela com os usu$$HEX1$$e100$$ENDHEX$$rios liberados para aprovar o pedido
		adc_Maximo_Liberacao = 0.01
							
	Case -1
		as_mensagem_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$ed00$$ENDHEX$$vel de libera$$HEX2$$e700e300$$ENDHEX$$o de pedido para o usu$$HEX1$$e100$$ENDHEX$$rio '"  + as_Responsavel + "'." + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_localiza_email_usuario (string as_matricula, ref string as_email, ref string as_mensagem_log);Select de_endereco_email
Into :as_email
From nivel_liberacao_pedido_usuario
Where nr_matricula = :as_matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		Return False
	Case -1
		as_mensagem_log = "Erro ao localizar o endere$$HEX1$$e700$$ENDHEX$$o email do usu$$HEX1$$e100$$ENDHEX$$rio " + as_matricula + ". " + SqlCa.SqlErrText 
		Return False
End Choose

Return True
end function

on uo_ge219_liberacao_pedido_central.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge219_liberacao_pedido_central.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

