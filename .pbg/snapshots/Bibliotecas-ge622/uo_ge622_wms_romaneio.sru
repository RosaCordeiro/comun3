HA$PBExportHeader$uo_ge622_wms_romaneio.sru
forward
global type uo_ge622_wms_romaneio from nonvisualobject
end type
end forward

global type uo_ge622_wms_romaneio from nonvisualobject
end type
global uo_ge622_wms_romaneio uo_ge622_wms_romaneio

forward prototypes
public function boolean of_inclui_romaneio_filial (date adt_fechamento)
public function boolean of_verifica_bloqueio_pedido (long al_filial, date adt_pedido, ref boolean ab_bloqueio)
public function boolean of_processa_cria_romaneio ()
end prototypes

public function boolean of_inclui_romaneio_filial (date adt_fechamento);Boolean lb_Bloqueio
Date ldt_Movimento
Long ll_Linhas, ll_Linha, ll_Filial, ll_Proximo_Romaneio, ll_Achou
Integer li_Dia
String ls_MSG, ls_Anexo[], ls_24horas

Try
	gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio Inclus$$HEX1$$e300$$ENDHEX$$o Romaneio")
	SetPointer(HourGlass!)
	Open(w_Aguarde_1)
	w_Aguarde_1.Title = "WMS - Incluindo Romaneio Filial"
	
	li_Dia = DayNumber(adt_fechamento)
	
	// Domingo ou Sabado
	If li_Dia = 1 or li_Dia = 7 Then Return True
	
	// Segunda olha o bloqueio no s$$HEX1$$e100$$ENDHEX$$bado....
	If li_Dia = 2 Then
		ldt_Movimento = RelativeDate(adt_fechamento,  -2)
	Else
		ldt_Movimento = RelativeDate(adt_fechamento,  -1)
	End If

	dc_uo_ds_base lds 	
	lds = Create dc_uo_ds_base	
	If Not lds.of_ChangeDataObject("ds_ge622_lista_filial") Then Return False
	ll_Linhas = lds.Retrieve()
	
	w_Aguarde_1.uo_progress.of_setmax(ll_Linhas)
	
	If ll_Linhas > 0 Then		
		For ll_Linha = 1 To ll_Linhas
			ll_Filial 		= lds.Object.cd_filial		[ll_Linha]
			ls_24horas	= lds.Object.id_24horas	[ll_Linha]
			
			If ls_24horas = 'N' Then
			 	If Not of_verifica_bloqueio_pedido(ll_Filial, ldt_Movimento, ref lb_Bloqueio) Then 	Return False
			Else
				lb_Bloqueio = False
			End If
			
			If lb_Bloqueio Then				
				Continue
			End If
			
			Select nr_romaneio
			Into :ll_Achou
			From wms_romaneio
			Where cd_filial = :ll_Filial
			And dh_movimentacao = :adt_fechamento
			Using Sqlca;
			
			Choose case SqlCa.SQlcode
				case 0
					Continue
				Case 100
				Case -1 
					ls_MSG = "Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo romaneio para a filial '" + string(ll_Filial) +"' '" + SQLCA.SQLErrText + "'."
					gf_ge202_envia_email_automatico(10, "",ls_MSG , ls_Anexo)
					Return False
			End Choose
			
			Select Coalesce(Max(nr_romaneio), 0) + 1
			Into :ll_Proximo_Romaneio
			From wms_romaneio
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = "Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo romaneio para a filial '" + string(ll_Filial) +"' '" + SQLCA.SQLErrText + "'."
				gf_ge202_envia_email_automatico(10, "",ls_MSG , ls_Anexo)
				Return False
			End If
			
			w_Aguarde_1.Title = "WMS - Incluindo Romaneio Filial: "+String (ll_Filial) 
			
			Insert Into wms_romaneio  ( nr_romaneio, cd_filial, dh_movimentacao, nr_matricula_inclusao, dh_inclusao)
			Values  (  :ll_Proximo_Romaneio, :ll_Filial, :adt_fechamento, '14330', getdate())
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = "Erro ao incluir o romaneio para a filial '" + string(ll_Filial) +"' '" + SQLCA.SQLErrText + "'."
				SqlCa.of_Rollback()
				gf_ge202_envia_email_automatico(10, "",ls_MSG , ls_Anexo)
				Continue
			Else
				SqlCa.of_Commit();
			End If	
			w_Aguarde_1.uo_progress.of_setprogress(ll_Linha)
		Next
		
		//Grava romaneio para a filial 2-Matriz, inclui um romaneio para o patrimonio			
		INSERT INTO wms_romaneio  ( nr_romaneio, cd_filial, dh_movimentacao, nr_matricula_inclusao, dh_inclusao, cd_centro_custo)
		select coalesce(max(nr_romaneio), 0) + 1, 2, :adt_fechamento, '14330',  getdate(), 534895 from wms_romaneio 
		Using SqlCa;
		
		w_Aguarde_1.Title = "WMS - Incluindo Romaneio Filial: "+String (2) 
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = "Erro ao incluir o romaneio para a filial '" + string(ll_Filial) +"', centro de custos 534895: '" + SQLCA.SQLErrText + "'."
			SqlCa.of_Rollback()
			gf_ge202_envia_email_automatico(10, "",ls_MSG , ls_Anexo)
			Return False
		Else
			SqlCa.of_Commit();
		End If
		
	ElseIf ll_Linhas = 0 Then
		ls_MSG = "N$$HEX1$$e300$$ENDHEX$$o foi localizada nenhuma filial para a inclus$$HEX1$$e300$$ENDHEX$$o do romaneio."
		gf_ge202_envia_email_automatico(10, "",ls_MSG , ls_Anexo)
	Else
		ls_MSG = "Houve erros na recupera$$HEX2$$e700e300$$ENDHEX$$o das filiais para a inclus$$HEX1$$e300$$ENDHEX$$o do romaneio."
		gf_ge202_envia_email_automatico(10, "",ls_MSG , ls_Anexo)
	End If
Finally
	Destroy(lds)	
	gvo_Aplicacao.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino Inclus$$HEX1$$e300$$ENDHEX$$o Romaneio")
	Close(w_Aguarde_1)
End try

Return False
end function

public function boolean of_verifica_bloqueio_pedido (long al_filial, date adt_pedido, ref boolean ab_bloqueio);Boolean lvb_Sucesso = True
String lvs_Fantasia, ls_MSG, ls_Anexo[]

ab_Bloqueio = True

Select f.nm_fantasia Into :lvs_Fantasia
From filial f
Where f.cd_filial = :al_Filial
  and Not Exists (Select *
					   From pedido_filial_bloqueio b
					   Where b.id_tipo_bloqueio = 'D'
						  and b.cd_distribuidora = '053404705'
						  and b.dh_pedido        = :adt_Pedido
						  and b.cd_filial is null
						  and b.nr_dia_semana is null)
  and Not Exists (Select *
					   From pedido_filial_bloqueio b
					   Where b.id_tipo_bloqueio = 'D'
						  and b.cd_distribuidora = '053404705'
						  and b.nr_dia_semana    = datepart(weekday, :adt_Pedido)
						  and b.cd_filial is null
						  and b.dh_pedido is null)
  and Not Exists (Select *
					   From pedido_filial_bloqueio b
					   Where b.id_tipo_bloqueio = 'D'
						  and b.cd_distribuidora = '053404705'
						  and b.cd_filial        = :al_Filial
						  and b.dh_pedido        = :adt_Pedido
						  and b.nr_dia_semana is null)
  and Not Exists (Select *
					   From pedido_filial_bloqueio b
					   Where b.id_tipo_bloqueio = 'D'
						  and b.cd_distribuidora = '053404705'
						  and b.cd_filial        = :al_Filial
						  and b.nr_dia_semana    = datepart(weekday, :adt_Pedido)
						  and b.dh_pedido is null)
  and not exists (Select *
					   From pedido_filial_bloqueio b
					   Where b.id_tipo_bloqueio = 'D'
					 	 and b.cd_distribuidora = '053404705'
						 and b.cd_filial        is null
						 and b.nr_dia_semana    is null
						 and b.dh_pedido 	    is null)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_Bloqueio = False

	Case 100
		
	Case -1
		ls_MSG = "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do bloqueio do pedido da filial '" + string(al_Filial) +"' '" + SQLCA.SQLErrText + "'."
		SqlCa.of_Rollback()
		gf_ge202_envia_email_automatico(10, "",ls_MSG , ls_Anexo)
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean of_processa_cria_romaneio ();Date lvdt_Hoje 
lvdt_Hoje = Today()

// Sempre executa ap$$HEX1$$f300$$ENDHEX$$s a Meia Noite...
This.of_Inclui_Romaneio_Filial(lvdt_Hoje)

Return True 
end function

on uo_ge622_wms_romaneio.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge622_wms_romaneio.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

