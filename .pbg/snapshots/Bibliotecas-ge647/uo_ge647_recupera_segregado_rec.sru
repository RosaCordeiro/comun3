HA$PBExportHeader$uo_ge647_recupera_segregado_rec.sru
forward
global type uo_ge647_recupera_segregado_rec from nonvisualobject
end type
end forward

global type uo_ge647_recupera_segregado_rec from nonvisualobject
end type
global uo_ge647_recupera_segregado_rec uo_ge647_recupera_segregado_rec

forward prototypes
public function boolean of_executa ()
end prototypes

public function boolean of_executa ();Boolean	lb_sucess	= True
DateTime	ldt_dh_validade
Long		ll_linhas, ll_for, ll_nr_controle, ll_qt_saldo_wms, ll_cd_produto, ll_qt_caixa_padrao
String	ls_error_msg, ls_nr_lote, ls_cd_endereco

dc_uo_ds_base	lds_ajustar_saldo_segregados


Try
	lds_ajustar_saldo_segregados	= Create dc_uo_ds_Base
	
	If Not lds_ajustar_saldo_segregados.of_ChangeDataObject("ds_ge647_segregado_com_prob") Then
		ls_error_msg = "Erro no changeDataObject da 'ds_ge647_segregado_com_prob'. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_executa"
		
		lb_sucess	= False
		
		Return lb_sucess
	End If
	
	ll_linhas	= lds_ajustar_saldo_segregados.Retrieve()
	
	if ll_linhas < 0 then
		ls_error_msg = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel carregar dados do objeto ds_el020_ajustar_saldo_segregado. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_ajustar_saldo_segregado"
		
		lb_sucess	= False
		
		Return lb_sucess
	end if
	
	for ll_for = 1 to ll_linhas	
		ll_nr_controle		= lds_ajustar_saldo_segregados.GetItemNumber(ll_for, 'nr_controle')
		ll_qt_saldo_wms	= lds_ajustar_saldo_segregados.GetItemNumber(ll_for, 'qt_saldo_wms')
		
		if not IsNull(ll_nr_controle) then
			if ll_qt_saldo_wms = 0 then
				delete from wms_segregado_recebimento
				 where nr_controle	= :ll_nr_controle;
				 
				Choose Case SQLCA.SQLCode
					Case -1
						ls_error_msg = "Erro ao deletar dados da tabela wms_segregado_recebimento. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_deletar_segregado_recebimento. ~r~r~Erro: " + SQLCA.SQLErrText
				
						lb_sucess	= False
						
						Return lb_sucess
				End Choose
			else
				update wms_segregado_recebimento
					set qt_lote	= :ll_qt_saldo_wms
				 where nr_controle	= :ll_nr_controle;
				 
				Choose Case SQLCA.SQLCode
					Case -1
						ls_error_msg = "Erro ao atualizar dados da tabela wms_segregado_recebimento. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_deletar_segregado_recebimento. ~r~r~Erro: " + SQLCA.SQLErrText
				
						lb_sucess	= False
						
						Return lb_sucess
				End Choose
			end if
		else
			ll_cd_produto			= lds_ajustar_saldo_segregados.GetItemNumber(ll_for, 'cd_produto')
			ldt_dh_validade		= lds_ajustar_saldo_segregados.GetItemDateTime(ll_for, 'dh_validade')
			ll_qt_caixa_padrao	= lds_ajustar_saldo_segregados.GetItemNumber(ll_for, 'qt_caixa_padrao')
			ls_nr_lote				= lds_ajustar_saldo_segregados.GetItemString(ll_for, 'nr_lote')
			ls_cd_endereco			= lds_ajustar_saldo_segregados.GetItemString(ll_for, 'cd_endereco')
			
			insert into wms_segregado_recebimento(
						  cd_endereco,
						  cd_fornecedor,
						  nr_nf,
						  de_especie,
						  de_serie,
						  cd_produto,
						  nr_lote,
						  dh_validade,
						  qt_lote,
						  dh_inclusao)
				values (:ls_cd_endereco,
						  null,
						  null,
						  null,
						  null,
						  :ll_cd_produto,
						  :ls_nr_lote,
						  :ldt_dh_validade,
						  :ll_qt_saldo_wms,
						  GetDate())
				using SqlCa;
					
				If SQLCA.SQLCode = -1 Then
					ls_error_msg	= SQLCA.SQLErrText
					ls_error_msg 	= "Erro no Insert da tabela 'wms_segregado_recebimento'. ~r~rErro: " + ls_error_msg
					
					SqlCa.of_Rollback()
					
					lb_sucess = False
					
					return lb_sucess
				End If
		end if
	next
Catch (RunTimeError rte)
	SQLCA.of_rollback()
	
	lb_sucess	= False
	
	ls_error_msg	= 'RunTimeError~r~rMessage: ' + rte.GetMessage()
	
	Return lb_sucess
Finally
	if not lb_sucess then
		SQLCA.of_rollback()
		
		gvo_aplicacao.of_grava_log (ls_error_msg)
	else
		SQLCA.of_commit()
	end if
	
	Destroy(lds_ajustar_saldo_segregados)
End Try

Return True
end function

on uo_ge647_recupera_segregado_rec.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge647_recupera_segregado_rec.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

