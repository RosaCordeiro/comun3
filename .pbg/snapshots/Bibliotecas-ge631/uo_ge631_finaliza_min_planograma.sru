HA$PBExportHeader$uo_ge631_finaliza_min_planograma.sru
forward
global type uo_ge631_finaliza_min_planograma from nonvisualobject
end type
end forward

global type uo_ge631_finaliza_min_planograma from nonvisualobject
end type
global uo_ge631_finaliza_min_planograma uo_ge631_finaliza_min_planograma

type variables
Date ivdt_Hoje 
Date ivdt_Dias_Termino







end variables

forward prototypes
public function boolean of_processa_envio ()
public function boolean of_insere_registro (long al_filial, long al_produto, date adt_data, string as_sequencial, ref string as_msg_erro, long al_qtde, date adt_dia)
end prototypes

public function boolean of_processa_envio ();Long ll_Linhas, ll_linha
Long ll_Filial, ll_Produto, ll_qt_est_minimo  

String lvs_msg, lvs_Anexo[], lvs_Sequencial

Date  ldt_Periodo, ldt_dh_termino_minimo , ldt_Hoje  

ldt_Hoje = Date(gf_GetServerDate())
ldt_Periodo = RelativeDate(ldt_Hoje,-1) 

Try 
	dc_uo_ds_base lds 	
	lds = Create dc_uo_ds_base	
	If Not lds.of_ChangeDataObject("ds_ge631_lista_dados") Then Return False
		
	SetPointer(HourGlass!)
	Open(w_Aguarde_1)
	w_Aguarde_1.Title = "EX - Atualiza$$HEX2$$e700e300$$ENDHEX$$o Envio Log Minimo Planograma"
	
	ll_Linhas = lds.Retrieve()
	w_Aguarde_1.uo_progress.of_setmax(ll_Linhas)
	
	If ll_Linhas > 0 Then 	
		
		For ll_Linha  = 1 To ll_Linhas

			// Dados Filial e Retirada para Processar			
			ll_Filial 						= lds.Object.cd_filial						[ll_Linha]
			ll_Produto    				= lds.Object.cd_produto					[ll_Linha]			
			ll_qt_est_minimo			= lds.Object.qt_estoque_minimo		[ll_Linha] 			
			lvs_Sequencial 				= lds.Object.seq							[ll_Linha]   
	         ldt_dh_termino_minimo  = Date(lds.Object.dh_termino_estoque_minimo	[ll_Linha])  			 

			w_Aguarde_1.Title = "EX - Atualiza$$HEX2$$e700e300$$ENDHEX$$o Envio Log Minimo Planograma. Filial: "+String(ll_Filial)+" Produto:"+String(ll_Produto)
		
			If Not This.of_insere_registro (ll_Filial,ll_Produto,&
													ldt_dh_termino_minimo,lvs_Sequencial,&
													Ref lvs_msg,ll_qt_est_minimo,&
													ldt_Hoje ) Then 
				SqlCa.of_rollback( )
				gf_ge202_envia_email_automatico(324, "",lvs_msg , lvs_Anexo)			
			Else
				SqlCa.of_Commit()	
			End If 
				
			w_Aguarde_1.uo_progress.of_setprogress(ll_Linha)
		Next  	
	End If 	
Finally
	Destroy (lds)
	Close(w_Aguarde_1)
End try

Return True 
end function

public function boolean of_insere_registro (long al_filial, long al_produto, date adt_data, string as_sequencial, ref string as_msg_erro, long al_qtde, date adt_dia);


INSERT INTO log_exportacao  (nr_exportacao,cd_empresa,cd_chave,dh_inclusao,cd_tipo_exportacao,id_situacao_exportacao,cd_integer1,&
            cd_integer2,cd_integer3,cd_varchar1) values (:as_sequencial, 1000, rtrim(convert(char(4),:al_filial)) +'@#!' +rtrim(convert(char(7),:al_produto)),&
            :adt_dia, 5,'C',:al_filial,:al_produto, :al_qtde,  'MP') 
Using SqlCA;	

Choose case SqlCa.SQlcode
	case 0
		Return True   
	Case 100
	Case -1 
		as_msg_erro = "Erro ao inserir registro a filial '" + string(al_filial) +"' '" + SQLCA.SQLErrText + "'."		
		Return False
End Choose

Return True 



end function

on uo_ge631_finaliza_min_planograma.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge631_finaliza_min_planograma.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

