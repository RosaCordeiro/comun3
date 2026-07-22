HA$PBExportHeader$uo_ge473_pedido_liberacao_loja_ba.sru
forward
global type uo_ge473_pedido_liberacao_loja_ba from nonvisualobject
end type
end forward

global type uo_ge473_pedido_liberacao_loja_ba from nonvisualobject
end type
global uo_ge473_pedido_liberacao_loja_ba uo_ge473_pedido_liberacao_loja_ba

type variables
String is_Dia_Semana
String is_Bloqueio
String is_Dias_Reforco
String is_Filial

Long il_Filial
Long il_Dia_Semana
Long il_Dias_Reforco
		
end variables

forward prototypes
public function boolean of_valida_carrega_variaveis (ref string as_log)
public function boolean of_inclui_liberacao (ref string as_log)
public function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_atualiza_pedido_liberacao_loja_ba (long al_controle, long al_tabela)
end prototypes

public function boolean of_valida_carrega_variaveis (ref string as_log);If IsNull(is_Dia_Semana) Then
	as_log = 'O dia da semanda n$$HEX1$$e300$$ENDHEX$$o foi informado, deve estar entre 1 (segunda) at$$HEX1$$e900$$ENDHEX$$ 7(domingo).'
	Return False
End If

If Not IsNumber(is_Dia_Semana) Then
	as_log = 'O dia da semanda n$$HEX1$$e300$$ENDHEX$$o foi informado esta inv$$HEX1$$e100$$ENDHEX$$lido, deve estar entre 1 (segunda) at$$HEX1$$e900$$ENDHEX$$ 7(domingo).'
	Return False
End If

il_Dia_Semana = Long(is_Dia_Semana)
// O dia da semana deve estar entre o dia 1 at$$HEX1$$e900$$ENDHEX$$ 7
If il_Dia_Semana >= 1 and il_Dia_Semana <= 7 Then
	//	SAP -> Inicia na seguda (1), ter$$HEX1$$e700$$ENDHEX$$a (2) ... domingo (7)
	If il_Dia_Semana >= 1 and il_Dia_Semana <= 6 Then
		//Necess$$HEX1$$e100$$ENDHEX$$rio porque no Sybase a semana inicia no domingo, diferente do SAP que inicia na segunda
		il_Dia_Semana = il_Dia_Semana + 1
	ElseIf il_Dia_Semana = 7 Then
		// domingo no SAP $$HEX1$$e900$$ENDHEX$$ 7 e no SyBase $$HEX1$$e900$$ENDHEX$$ 1		
		il_Dia_Semana = 1
	End If
Else
	as_log = 'O dia da semanda deve estar entre 1 (segunda) at$$HEX1$$e900$$ENDHEX$$ 7(domingo).'
	Return False
End If

If Trim(is_Bloqueio) = '' Then SetNull(is_Bloqueio)

If Not IsNull(is_Bloqueio) and is_Bloqueio <> 'X' Then
	as_log = 'O tipo de bloqueio esta diferente do esperado (vazio ou X).'
	Return False
End If

If IsNull(il_Dias_Reforco) Then il_Dias_Reforco = 0

il_Dias_Reforco = Long(is_Dias_Reforco)

If il_Dias_Reforco > 5 Then
	as_log = 'O n$$HEX1$$fa00$$ENDHEX$$mero de dias de refor$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode superior a 5 dias.'
	Return False
End If	

Return True
end function

public function boolean of_inclui_liberacao (ref string as_log);Long ll_Dias_Reforno

//No SAP o usu$$HEX1$$e100$$ENDHEX$$rio deve informar o dia em que o pedido ser$$HEX1$$e100$$ENDHEX$$ bloqueado, sempre for cadastrada uma loja 
//a transa$$HEX2$$e700e300$$ENDHEX$$o ir$$HEX1$$e100$$ENDHEX$$ colocar um X em todos os dias da semana, quando for tirar o bloqueio $$HEX1$$e900$$ENDHEX$$ no ID_BLOQUEIO vazio, 
//isso indica que necess$$HEX1$$e100$$ENDHEX$$rio incluir um registro no Sybase para liberar o pedido no dia.
//No Sybase o usu$$HEX1$$e100$$ENDHEX$$rio informa o dia em que vai liberar o pedido.
If IsNull(is_Bloqueio) Then
		
	SELECT qt_dias_reforco
	Into :ll_Dias_Reforno
     FROM libera_pedido_filial_estoque   
	Where cd_filial 				=:il_Filial
		and nr_dia_semana 	=:il_Dia_Semana
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
			If ll_Dias_Reforno <> il_Dias_Reforco Then
			
				UPDATE libera_pedido_filial_estoque  
				  SET 	qt_dias_reforco = :il_Dias_Reforco 
				Where cd_filial = :il_Filial
					and nr_dia_semana = :il_Dia_Semana
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Log	= "Erro ao atualizar o registro de libera$$HEX2$$e700e300$$ENDHEX$$o do pedido." + " Erro: "+ SqlCa.SqlErrText
					Return False
				End If
				
			End If

			
		Case 100
			
			INSERT INTO libera_pedido_filial_estoque ( cd_filial,
																	nr_dia_semana,
																	qt_dias_reforco, 
																	id_mix_completo, 
																	id_pedido_controlado_exclusivo )  
			VALUES ( :il_Filial, :il_Dia_Semana, :il_Dias_Reforco, 'S', 'N')
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao incluir o registro de libera$$HEX2$$e700e300$$ENDHEX$$o do pedido." + " Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
		Case -1
			as_Log	= "Erro ao localizar o registro de libera$$HEX2$$e700e300$$ENDHEX$$o do pedido." + " Erro: "+ SqlCa.SqlErrText
			Return False
	End Choose	
	
ElseIf is_Bloqueio = 'X' Then
	
	//	Exclui o registro da tabela, para n$$HEX1$$e300$$ENDHEX$$o enviar o pedido
	DELETE FROM libera_pedido_filial_estoque
	Where cd_filial = :il_Filial
		and nr_dia_semana = :il_Dia_Semana
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao localizar o registro de libera$$HEX2$$e700e300$$ENDHEX$$o do pedido." + " Erro: "+ SqlCa.SqlErrText
		Return False
	End If

End If

Return True
end function

public function boolean of_inicializa_variaveis (ref string as_log);Try
		
	SetNull(is_Dia_Semana)
	SetNull(is_Bloqueio)
	SetNull(is_Dias_Reforco)
	SetNull(is_Filial)
	
	SetNull(il_Filial)
	SetNull(il_Dia_Semana)
	SetNull(il_Dias_Reforco)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: " + lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_atualiza_pedido_liberacao_loja_ba (long al_controle, long al_tabela);Boolean lb_Sucesso = False

Long ll_Atualizacao_Pend
Long ll_Linhas

String ls_Log

Try
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False

	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If lo_Comum.of_processa_carrega_dados(al_controle, al_tabela, ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		If ll_Linhas = 1 Then
			
			is_Dia_Semana		= lo_Comum.ids_lista_registros.Object.nr_dia_semana	[1]
			is_Bloqueio 		 	= lo_Comum.ids_lista_registros.Object.id_bloqueio		[1]
			is_Dias_Reforco 	= lo_Comum.ids_lista_registros.Object.nr_dias_reforco	[1]
			is_Filial				= lo_Comum.ids_lista_registros.Object.cd_filial_sap		[1]
			
			If Not lo_Comum.of_Localiza_Codigo_Filial_Legado(is_Filial, Ref  il_Filial, Ref ls_Log) Then Return False
			
			If This.of_valida_carrega_variaveis(Ref ls_Log) Then
				If This.of_inclui_liberacao(Ref ls_Log) Then
					lb_Sucesso = True
				End If
			End If
						
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If
		
	End If
		
Finally
		
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 175, ls_Log)
	End If
	
	Destroy lo_Comum	

End Try

Return True
end function

on uo_ge473_pedido_liberacao_loja_ba.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_pedido_liberacao_loja_ba.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

