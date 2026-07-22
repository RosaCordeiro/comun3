HA$PBExportHeader$uo_ge624_retirada_estoque.sru
forward
global type uo_ge624_retirada_estoque from nonvisualobject
end type
end forward

global type uo_ge624_retirada_estoque from nonvisualobject
end type
global uo_ge624_retirada_estoque uo_ge624_retirada_estoque

type variables
Date ivdt_Hoje 
Date ivdt_Dias_Termino







end variables

forward prototypes
public function boolean of_processa_aprovacoes ()
public function boolean of_atualiza_retirada_estoque (long al_filial, long al_nr_retirada, ref string as_msg)
public function boolean of_atualiza_retirada_produto (long al_filial, long al_nr_retirada, ref string as_msg)
public function boolean of_prepara_email (long al_filial, long al_nr_retirada, datetime adt_inicio, datetime adt_fim, string as_tipo, datetime adt_vencimento)
end prototypes

public function boolean of_processa_aprovacoes ();Long ll_Linhas, ll_linha
Long ll_Filial, ll_Retirada
String lvs_msg, lvs_Anexo[], lvs_Tipo
Date  ldt_Periodo

Try 

	ivdt_Hoje = Date(gf_GetServerDate())
	ivdt_Dias_Termino = RelativeDate(ivdt_Hoje,+5)
	ldt_Periodo =  RelativeDate(ivdt_Hoje,-60)
	
	dc_uo_ds_base lds 	
	lds = Create dc_uo_ds_base	
	If Not lds.of_ChangeDataObject("ds_ge624_lista_retiradas") Then Return False
		
	SetPointer(HourGlass!)
	Open(w_Aguarde_1)
	w_Aguarde_1.Title = "EX - Aprova$$HEX2$$e700e300$$ENDHEX$$o Autom.Retirada Estoque Filial"
	
	ll_Linhas = lds.Retrieve(ldt_Periodo)
	w_Aguarde_1.uo_progress.of_setmax(ll_Linhas)
	
	If ll_Linhas > 0 Then 	
		
		For ll_Linha  = 1 To ll_Linhas

			// Dados Filial e Retirada para Processar			
			ll_Filial 		= lds.Object.cd_filial		[ll_Linha]
			ll_Retirada	= lds.Object.nr_retirada_estoque	[ll_Linha]			
			lvs_Tipo= lds.Object.id_tipo_retirada	[ll_Linha] 
			
				
			
			w_Aguarde_1.Title = "EX - Aprova$$HEX2$$e700e300$$ENDHEX$$o Autom.Retirada Estoque Filial: "+String(ll_Filial)+" Nro Retirada:"+String(ll_Retirada)
		
			// Processa Tabela Produtos 
			If Not This.of_atualiza_retirada_produto(ll_Filial,ll_Retirada , Ref lvs_msg ) Then  
				SqlCa.of_rollback( )
				gf_ge202_envia_email_automatico(317, "",lvs_msg , lvs_Anexo)
				Return False
			End If 	
			
			// Processa Tabela Principal
			If Not This.of_atualiza_retirada_estoque(ll_Filial,ll_Retirada, Ref lvs_msg ) Then 
				SqlCa.of_rollback( )
				gf_ge202_envia_email_automatico(317, "",lvs_msg , lvs_Anexo)
				Return False
			End If 			
			
			// Envio Email para Loja :  Vencidos.			
			If Not This.of_prepara_email( ll_Filial,ll_Retirada, Datetime(ivdt_Hoje) , Datetime(ivdt_Dias_Termino) , lvs_Tipo, Datetime(ivdt_Dias_Termino) ) Then 				
				SqlCa.of_rollback( )
				lvs_msg = "Erro envio Email: Aprova$$HEX2$$e700e300$$ENDHEX$$o Autom.Retirada Estoque Filial "
				gf_ge202_envia_email_automatico(317, "",lvs_msg , lvs_Anexo)
				Return False
			End If 			
			w_Aguarde_1.Title = "EX - Aprova$$HEX2$$e700e300$$ENDHEX$$o Autom.Retirada Estoque Filial: "+String(ll_Filial)+" Nro Retirada:"+String(ll_Retirada)+" Envio Email" 

			SqlCa.of_Commit()
				
			w_Aguarde_1.uo_progress.of_setprogress(ll_Linha)
		Next  	
	End If 	
Finally
	Destroy (lds)
	Close(w_Aguarde_1)
End try

Return True 
end function

public function boolean of_atualiza_retirada_estoque (long al_filial, long al_nr_retirada, ref string as_msg);Boolean lb_Atualiza = False


Update retirada_estoque
Set      id_situacao = 'A',
           dh_inicio=:ivdt_Hoje,
		  dh_termino=:ivdt_Dias_Termino,
           dh_aprovacao=:ivdt_Hoje,
		  id_aprovado   ='S',        
           nr_matricula_aprovacao='14330',
           de_dados_adicionais = 'APROVADO PROCESSO AUTOMATICO'
Where nr_retirada_estoque  =:al_nr_retirada
And     cd_filial = :al_filial
Using SqlCA;


Choose case SqlCa.SQlcode
	case 0
		Return True   
	Case 100
	Case -1 
		as_msg = "Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo romaneio para a filial '" + string(al_filial) +"' '" + SQLCA.SQLErrText + "'."
		///gf_ge202_envia_email_automatico(10, "",as_msg,ls_Anexo)
		Return False
End Choose


Return True 
end function

public function boolean of_atualiza_retirada_produto (long al_filial, long al_nr_retirada, ref string as_msg);


Update retirada_estoque_produto
Set qt_aprovada = qt_solicitada
Where cd_filial =:al_filial
And nr_retirada_estoque=:al_nr_retirada
Using SqlCA;

Choose case SqlCa.SQlcode	
	Case -1 
		as_msg = "Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo romaneio para a filial '" + string(al_filial) +"' '" + SQLCA.SQLErrText + "'."
		Return False
End Choose




Update retirada_estoque_produto_lote
Set qt_aprovada = qt_lote
Where cd_filial =:al_filial
And nr_retirada_estoque=:al_nr_retirada
Using SqlCA;

Choose case SqlCa.SQlcode	
	Case -1 
		as_msg = "Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo romaneio para a filial '" + string(al_filial) +"' '" + SQLCA.SQLErrText + "'."	
		Return False
End Choose


Return True 



end function

public function boolean of_prepara_email (long al_filial, long al_nr_retirada, datetime adt_inicio, datetime adt_fim, string as_tipo, datetime adt_vencimento);DateTime ldh_Inicio
DateTime ldh_Termino
DateTime ldh_Vencimento

Long ll_Filial
Long ll_Retirada

String ls_Tipo

str_ge624_lista_email str

gf_ge624_dados_email(Ref str, al_filial , al_nr_retirada, adt_inicio, adt_fim, as_tipo, adt_vencimento) 
gf_ge624_Envia_Email(str, as_tipo , True)


Return True 
end function

on uo_ge624_retirada_estoque.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge624_retirada_estoque.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

