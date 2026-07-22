HA$PBExportHeader$uo_ge622_wms_romaneio_novo.sru
forward
global type uo_ge622_wms_romaneio_novo from nonvisualobject
end type
end forward

global type uo_ge622_wms_romaneio_novo from nonvisualobject
end type
global uo_ge622_wms_romaneio_novo uo_ge622_wms_romaneio_novo

forward prototypes
public function boolean of_inclui_romaneio_filial (date adt_pedido)
public function boolean of_processa_cria_romaneio ()
public function boolean wf_verifica_dias_romaneio (date adt_pedido, long as_filial, long as_esteira, long al_rota_entrega, ref date adt_romaneio, ref string as_erro)
end prototypes

public function boolean of_inclui_romaneio_filial (date adt_pedido);Boolean lb_Bloqueio, lb_Sucesso = False
Date ldt_Movimento, ldt_Romaneio_Pedido
Long ll_Linhas, ll_Linha, ll_Filial, ll_Proximo_Romaneio, ll_Achou, ll_Esteira, ll_Dias, ll_Pedido_Distribuidora, ll_Romaneio, ll_Rota_Entrega, ll_Filial_Entrega, ll_Filial_Romaneio
Integer li_Dia
String ls_MSG, ls_Sistema

ls_Sistema = gvo_Aplicacao.ivo_Seguranca.Cd_Sistema

Try
	gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio Inclus$$HEX1$$e300$$ENDHEX$$o Romaneio")
	SetPointer(HourGlass!)
	
	Open(w_Aguarde_1)
	w_Aguarde_1.Title = ls_Sistema + " - Incluindo Romaneio Filial"
	
	dc_uo_ds_base lds 	
	lds = Create dc_uo_ds_base	
	If Not lds.of_ChangeDataObject("ds_ge622_lista_filial_pedido_gerado") Then Return False
	
	ll_Linhas = lds.Retrieve(adt_pedido)
	
	w_Aguarde_1.uo_progress.of_setmax(ll_Linhas)
	
	If ll_Linhas > 0 Then		
		For ll_Linha = 1 To ll_Linhas
			ll_Filial 						=	lds.Object.cd_filial		[ll_Linha]
			ll_Esteira						=	lds.Object.cd_esteira	[ll_Linha]
			ll_Pedido_Distribuidora	=	lds.Object.nr_pedido_distribuidora	[ll_Linha]
			ll_Rota_Entrega			=	lds.Object.nr_rota_entrega				[ll_Linha]
			
			If wf_verifica_dias_romaneio(adt_pedido,ll_Filial, ll_Esteira, ll_Rota_Entrega, Ref ldt_romaneio_pedido, Ref ls_MSG) Then
				
				If ll_Esteira = 5 Then
					
					Select  cd_centro_custo_entrega
					Into :ll_Filial_entrega
					From pedido_almoxarifado 
					Where nr_pedido = :ll_Pedido_Distribuidora and cd_filial = :ll_Filial
					Using SqlCa;
					
					Choose case SqlCa.SQlcode
						Case -1
							ls_MSG = "Erro em verificar se o pedido almoxarifado tem filial de entrega. Filial:" + String(ll_Filial) + " N$$HEX1$$ba00$$ENDHEX$$ Pedido:"+String(ll_Pedido_Distribuidora)+"."+ SQLCA.SQLErrText + "'."
							
					End Choose
				End If 			
				
				If Not Isnull(ll_Filial_entrega) And Len(String(ll_Filial_Entrega)) <= 3 and ll_Filial_Entrega >0  Then
					ll_Filial_Romaneio = ll_Filial_Entrega
				Else
					ll_Filial_Romaneio = ll_Filial
				End If 
				
				Select nr_romaneio
				Into :ll_Achou
				From wms_romaneio
				Where cd_filial = :ll_Filial_Romaneio
				And dh_movimentacao = :ldt_Romaneio_Pedido
				And dh_fechamento is null
				Using Sqlca;
				
				Choose case SqlCa.SQlcode
					Case 0
						Update wms_lista_separacao
							Set nr_romaneio = :ll_Achou
						Where cd_filial = :ll_Filial
						And cd_esteira = :ll_esteira
						And nr_pedido_distribuidora = :ll_Pedido_Distribuidora
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							ls_MSG = "Erro em atualizar a lista_separacao para a filial "+ String(ll_Filial) +" e o pedido distribuidora "+ String(ll_pedido_distribuidora) +" o romaneio "+ String(ll_Romaneio)+"'. "+ SQLCA.SQLErrText + "'."
						Else
							lb_Sucesso= True	
						End If
					
					Case 100
						Select Coalesce(Max(nr_romaneio), 0) + 1
						Into :ll_Proximo_Romaneio
						From wms_romaneio
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							ls_MSG = "Erro em consulta o $$HEX1$$fa00$$ENDHEX$$ltimo romaneio para a filial '" + string(ll_Filial) +"' '" + SQLCA.SQLErrText + "'."
						End If
						
						w_Aguarde_1.Title = ls_Sistema + " - Incluindo Romaneio Filial: "+String (ll_Filial) 
						
						Insert Into wms_romaneio  ( nr_romaneio, cd_filial, dh_movimentacao, nr_matricula_inclusao, dh_inclusao)
						Values  (  :ll_Proximo_Romaneio, :ll_Filial_Romaneio, :ldt_romaneio_pedido, '14330', getdate())
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							ls_MSG = "Erro ao incluir o romaneio para a filial '" + string(ll_Filial) +"' '" + SQLCA.SQLErrText + "'."
						Else
							Update wms_lista_separacao
							Set nr_romaneio = :ll_Proximo_Romaneio
							Where cd_filial = :ll_Filial
							And cd_esteira = :ll_Esteira
							And nr_pedido_distribuidora = :ll_Pedido_Distribuidora
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
								ls_MSG = "Erro ao incluir o romaneio na tabela wms_lista_separacao para a filial '" + string(ll_Filial) +". "+ SQLCA.SQLErrText + "'."
							End If 
							
							lb_Sucesso= True
						End If	
						
					Case -1 
						ls_MSG = "Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo romaneio para a filial '" + string(ll_Filial) +"' '" + SQLCA.SQLErrText + "'."
				
				End Choose
			End If
			
			If lb_Sucesso Then
				SqlCa.of_Commit();	
			Else
				SqlCa.of_Rollback()
				gf_ge202_envia_email_automatico(10, "",ls_MSG )
			End If
		
			w_Aguarde_1.uo_progress.of_setprogress(ll_Linha)
			
		Next
		
		Update controle_geracao_pedido
		Set dh_termino_geracao_romaneio = getdate()
		Where id_multitask_logistica = 'S'
		And dh_pedido 	= :adt_pedido
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			ls_MSG = SqlCa.SqlErrText
			SqlCa.of_RollBack()
			MessageBox("Erro","Erro ao atualizar termino da gera$$HEX2$$e700e300$$ENDHEX$$o do romaneio na tabela controle_geracao_pedido'. " + ls_MSG)
			Return False
		End If
		
		SqlCa.of_Commit();
		
	ElseIf ll_Linhas = 0 Then
		ls_MSG = "N$$HEX1$$e300$$ENDHEX$$o foi localizada nenhuma filial na lista de separa$$HEX2$$e700e300$$ENDHEX$$o para a inclus$$HEX1$$e300$$ENDHEX$$o do romaneio." + String(ldt_romaneio_pedido)
		gf_ge202_envia_email_automatico(10, "",ls_MSG )
	Else
		ls_MSG = "Houve erros na recupera$$HEX2$$e700e300$$ENDHEX$$o das filiais para a inclus$$HEX1$$e300$$ENDHEX$$o do romaneio."
		gf_ge202_envia_email_automatico(10, "",ls_MSG )
	End If
Finally
	Destroy(lds)	
	gvo_Aplicacao.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino Inclus$$HEX1$$e300$$ENDHEX$$o Romaneio")
	Close(w_Aguarde_1)
End try

Return True
end function

public function boolean of_processa_cria_romaneio ();String ls_MSG, ls_Anexo
Date ldt_Pedido

Select Top 1 dh_pedido
Into :ldt_Pedido
from controle_geracao_pedido 
Order By dh_pedido Desc
Using Sqlca; 

If SqlCa.SqlCode = -1 Then
	ls_MSG = "Erro em consulta a informa$$HEX2$$e700e300$$ENDHEX$$o na tabela controle_geracao_pedido:'" + SQLCA.SQLErrText + "'."
	SqlCa.of_Rollback()
	MessageBox("Erro", ls_MSG, Exclamation!)
	//gf_ge202_envia_email_automatico(10, "",ls_MSG , ls_Anexo)
	Return False
End If

Update controle_geracao_pedido
Set dh_inicio_geracao_romaneio = getdate()
Where id_multitask_logistica = 'S'
And dh_pedido 	= :ldt_Pedido
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_RollBack()
	MessageBox("Erro","Erro ao atualizar controle_geracao_pedido'. " + SqlCa.SqlErrText)
	Return True
End if

This.of_Inclui_Romaneio_Filial(ldt_Pedido)


Return True 
end function

public function boolean wf_verifica_dias_romaneio (date adt_pedido, long as_filial, long as_esteira, long al_rota_entrega, ref date adt_romaneio, ref string as_erro);Long ll_Dias_Esteira, ll_Dias_Semana, ll_Dias_Extra, ll_Day
String ls_Tipo_Conf_Geladeira
Boolean lb_Feriado, lb_Ok
Date ld_Data_Final

Select nr_dias_romaneio_pos_pedido
Into :ll_Dias_Esteira
From wms_esteira
Where cd_esteira = :as_Esteira
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	as_erro = "Erro na consulta dias da esteira para verifica o romaneio. [wms_esteira]. " + Sqlca.SqlErrText
	Return False
End If

ll_day = DayNumber(adt_Pedido)

Select nr_dias_atendimento_romaneio
Into :ll_Dias_Semana
From wms_dias_atendimento_romaneio
Where cd_wms_dias_atend_romaneio = :ll_Day
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	as_erro = "Erro na consulta dias de atendimento [wms_dias_atendimento_romaneio]. " + Sqlca.SqlErrText
	Return False
End If

ld_data_final = RelativeDate(adt_Pedido, ll_Dias_Esteira + ll_Dias_Semana)

lb_Ok = gf_verifica_feriado('M', 1, ld_Data_Final, Ref lb_Feriado)
If Not lb_Ok Then
	as_Erro = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o de verifica$$HEX2$$e700e300$$ENDHEX$$o de feriado."
	Return False
End If

Do While lb_Feriado
	ll_Day = DayNumber(ld_Data_Final)
	
	Select nr_dias_atendimento_romaneio
	Into :ll_Dias_Extra
	From wms_dias_atendimento_romaneio
	Where cd_wms_dias_atend_romaneio = :ll_Day
	Using Sqlca;

	If Sqlca.Sqlcode = -1 Then
		as_erro = "Erro ao consultar dias adicionais para criar o romaneio [wms_dias_atendimento_romaneio]. " + Sqlca.SqlErrText
		Return False
	End If

	ld_Data_Final = RelativeDate(ld_Data_Final, ll_Dias_Extra)

	lb_Ok = gf_verifica_feriado('M', 1, ld_Data_Final, Ref lb_Feriado)

	If Not lb_Ok Then
		as_Erro = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o de verifica$$HEX2$$e700e300$$ENDHEX$$o de feriado."
		Return False
	End If
Loop

adt_Romaneio = ld_Data_Final

Return True

end function

on uo_ge622_wms_romaneio_novo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge622_wms_romaneio_novo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

