HA$PBExportHeader$uo_ge495_email_bloqueio_multitask.sru
forward
global type uo_ge495_email_bloqueio_multitask from nonvisualobject
end type
end forward

global type uo_ge495_email_bloqueio_multitask from nonvisualobject
end type
global uo_ge495_email_bloqueio_multitask uo_ge495_email_bloqueio_multitask

type variables
Date ldt_hoje 
Long ll_Cod_Msg
String is_dia_semana

// Tipo de Envio Email.
//C - Email pelo Sistema CARGA ( automatico )
//B - Email pelo Botao da Tela   ( manual ) 

end variables

forward prototypes
public function boolean of_envia_email (string as_motivo, date adt_pedido, date adt_hoje, ref string as_erro, string as_origem)
public function boolean of_envia_email_automatico ()
end prototypes

public function boolean of_envia_email (string as_motivo, date adt_pedido, date adt_hoje, ref string as_erro, string as_origem);String ls_email,&
		  ls_erro,&
		  ls_dia_semana_pedido,&
		  ls_dia_semana_email
		  
Boolean lb_Envio = False			  

Try
	
	ls_dia_semana_pedido = gf_dia_semana(adt_pedido) 		  
	ls_dia_semana_email = gf_dia_semana(adt_hoje)
	s_email str //ge202
	
	ll_Cod_Msg = 193 		  		  
	ls_email = 		"<html>"+&
						"<body>"+&
						"<table border=0>"+&
						"<tr>"+& 
											"<tr>"+& 
											"<td>$$HEX1$$a000$$ENDHEX$$</td> "+&	
											"</tr>"+&		
											"<td><b>MultiTask</b></td> "+&	
											"</tr>"+&
											"<tr>"+& 
											"<td>$$HEX1$$a000$$ENDHEX$$</td> "+&	
											"</tr>"+&													
											"<tr>"+& 
											"<td><b>Comunicado Importante</b></td> "+&	
											"</tr>"+&			
											"<tr>"+& 
											"<td>$$HEX1$$a000$$ENDHEX$$</td> "+&	
											"</tr>"+&			
											"<tr>"+& 
											"<td>N$$HEX1$$e300$$ENDHEX$$o executar a tarefa de gera$$HEX2$$e700e300$$ENDHEX$$o de pedidos na data: <b>" + String(ls_dia_semana_pedido) +  "</b></td> "+&	
											"</tr>"+&
											"<tr>"+& 
											"<td>$$HEX1$$a000$$ENDHEX$$</td> "+&	
											"</tr>"+&			
											"<tr>"+& 
											"<td><u><b>Motivo :  " + String (as_motivo) +  "~n</b></u></td> "+&	
											"</tr>"+&									
											"<tr>"+& 
											"<td>$$HEX1$$a000$$ENDHEX$$</td> "+&	
											"</tr>"+&			
											"<tr>"+& 
											"<td>Os demais processos permanecem sem altera$$HEX2$$e700e300$$ENDHEX$$o " +  "~n</td> "+&	 
											"</tr>"+&																			
											"<tr>"+& 
											"<td>$$HEX1$$a000$$ENDHEX$$</td> "+&	
											"</tr>"+&			
											"<tr>"+& 
											"<td>Envio do Email : " + string(ls_dia_semana_email)   + "~n</td> "+&	
											"</tr>"+& 										
											"<tr>"+& 
											"<tr>"+& 
											"<td>$$HEX1$$a000$$ENDHEX$$</td> "+&	
											"</tr>"+&			
											"<td>Origem da Mensagem: " + string(as_origem)   + "~n</td> "+&	
											"</tr>"+& 																			
											"</table>"+&
											"</body>"+&	
											"</html>" 	
											
	String ls_Anexo
	If  ll_Cod_Msg>0 Then 
		str.ps_Mensagem	= ls_email 
		str.pb_Assinatura	= True
		If Not gf_ge202_envia_email_padrao(ll_Cod_Msg, str)  Then 
			lb_Envio = False
		Else
			lb_Envio  = True
		End If 
	Else
		Return lb_Envio
	End If 

Finally
	If Not lb_Envio Then 
		gvo_Aplicacao.of_Grava_Log("Fim - N$$HEX1$$e300$$ENDHEX$$o Enviado e-mail de bloqueio multitask.")
	End If 
	Return lb_Envio
End Try
end function

public function boolean of_envia_email_automatico ();Date ldt_data_hoje
Date ldt_data_futura
Date ldt_pedido

String ls_de_motivo
String ls_origem 
String ls_erro

Long ll_Nr_Bloqueio 
Long ll_Linha

Boolean lb_Enviado = False

Try 
	ls_origem = "Autom$$HEX1$$e100$$ENDHEX$$tico: Sistema Carga: 3 Dias Antes"
	ldt_data_hoje  =   Date (gf_GetServerDate()) 
	ldt_data_futura 	=  RelativeDate(ldt_data_hoje,3) 
	
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	
	If Not lvds_1.of_ChangeDataObject("dw_ge495_lista") Then 
		gvo_Aplicacao.of_Grava_Log("Erro ao carregar o data store 'dw_ge495_lista'.")
		Return lb_Enviado
	End If	
	
	lvds_1.of_AppendWhere("	p.dh_envio_email is null and p.dh_pedido = '" + String(ldt_data_futura, 'yyyy/mm/dd') + "'")	
	lvds_1.Retrieve()
	
	If lvds_1.rowcount( )>0  Then
		For ll_Linha = 1 To lvds_1.rowcount( )
			
			ls_de_motivo = lvds_1.object.de_motivo_bloqueio[ll_Linha]
			ldt_pedido 	= Date(lvds_1.object.dh_pedido[ll_Linha])
			ll_Nr_Bloqueio = lvds_1.object.nr_bloqueio[ll_Linha]
		
			If Not This.of_envia_email( ls_de_motivo, ldt_pedido, ldt_data_hoje, ls_erro , ls_origem) Then 
				lb_Enviado = False
				ls_erro	= "Erro ao enviar email Autom$$HEX1$$e100$$ENDHEX$$tico Bloquei: uo_ge495_email_bloqueio_multitask.of_envia_email_automatico"
				gvo_aplicacao.of_grava_log(ls_erro)			
				Return lb_Enviado
			Else
				lb_Enviado = True
				gvo_Aplicacao.of_Grava_Log("Enviado email: Bloqueio Multitask.")
			End If
			
			If lb_Enviado Then 
				Update  pedido_filial_bloqueio
				Set     dh_envio_email  	= :ldt_data_hoje
				Where   nr_bloqueio 		=	:ll_Nr_Bloqueio 
				Using SqlCA;
							
				If SqlCa.SqlCode = -1 Then
					lb_Enviado = False
					gvo_Aplicacao.of_Grava_Log("Erro atualzacao tabela pedido_filial_bloqueio.")
					SqlCa.of_MsgdbError("Erro atualzacao tabela pedido_filial_bloqueio.")
					SqlCa.of_RollBack()
				Else
					SqlCa.of_Commit()								
				End If 				
			End If 
		Next 
	Else
		lb_Enviado = True 
		//gvo_Aplicacao.of_Grava_Log("Sem Informa$$HEX2$$e700e300$$ENDHEX$$o para o Envio E-mail de Bloqueio Multitask.")
	End If 	
Finally
	Destroy(lvds_1)
	Return lb_Enviado 
End Try
end function

on uo_ge495_email_bloqueio_multitask.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge495_email_bloqueio_multitask.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

