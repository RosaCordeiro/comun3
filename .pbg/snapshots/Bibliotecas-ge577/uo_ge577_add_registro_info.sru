HA$PBExportHeader$uo_ge577_add_registro_info.sru
forward
global type uo_ge577_add_registro_info from nonvisualobject
end type
end forward

global type uo_ge577_add_registro_info from nonvisualobject
end type
global uo_ge577_add_registro_info uo_ge577_add_registro_info

forward prototypes
public function boolean of_controla_ds (ref dc_uo_ds_base ads)
public function boolean of_insere_registro_info (ref dc_uo_ds_base ads)
end prototypes

public function boolean of_controla_ds (ref dc_uo_ds_base ads);If Not ads.of_ChangeDataObject('ds_ge577_add_registro_info', False) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a DW '" + 'ds_ge577_add_registro_info' + "' - " + 'uo_ge577_add_registro_info', StopSign!)
	Return False
End If

ads.Retrieve()

Return True
end function

public function boolean of_insere_registro_info (ref dc_uo_ds_base ads);Long		ll_for, ll_cd_produto, ll_nr_atualizacao
String	ls_cd_distribuidora, ls_cd_unidade_federacao, ls_chave, ls_erro


for ll_for = 1 to ads.RowCount()
	ls_cd_distribuidora		= ads.Object.cd_distribuidora[ll_for]
	ls_cd_unidade_federacao	= ads.Object.cd_unidade_federacao[ll_for]
	ll_cd_produto				= ads.Object.cd_produto[ll_for]
	
	if not lf_ge470_proximo_sequencial_log(REF ll_nr_atualizacao, REF ls_erro) then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_erro)
		Continue
	end if
	
	ls_chave	= ls_cd_distribuidora + '@#!' + String(ll_cd_produto) + '@#!' + ls_cd_unidade_federacao
	
	insert into log_exportacao_sap(nr_atualizacao,
											 cd_empresa,
											 cd_chave,                                    
											 id_tipo_nf,                                                        
											 id_tipo_log,
											 id_status_integracao,  
											 id_situacao_docto, 
											 cd_ambiente_sap,                                    
											 dh_exportacao,
											 cd_produto)                                  						
									values(:ll_nr_atualizacao, 
                            		 1000,
							  				 :ls_chave,
							  				 'STA',   
							  				 39,
							  				 'C',
							  				 'C', 
							  				 'PRD',                            
							  				 getdate() ,  
							  				 :ll_cd_produto);
												
	If SQLCA.SQLCode = -1 Then
		ls_erro	= SQLCA.SQLErrText
		SQLCA.of_rollback()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_erro, StopSign!)
		return false
	End If
next

SQLCA.of_commit()

return true
end function

on uo_ge577_add_registro_info.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge577_add_registro_info.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

