HA$PBExportHeader$uo_ge547_fatura_automatico.sru
forward
global type uo_ge547_fatura_automatico from nonvisualobject
end type
end forward

global type uo_ge547_fatura_automatico from nonvisualobject
end type
global uo_ge547_fatura_automatico uo_ge547_fatura_automatico

type variables

end variables

forward prototypes
public function boolean of_finaliza_separacao ()
public function boolean of_atualiza_pedido_distribuidora (long al_filial, long al_pedido_distribuidora, string as_erro)
public function boolean of_atualiza_pedido_almoxarifado (long al_filial, long al_pedido, ref string as_erro)
public function boolean of_verifica_prioridade_faturamento (long al_prioridade, date ldt_inicio, date ldt_fim)
public function boolean of_verifica_volume_nao_conferido (long al_filial, long al_pedido)
public function boolean of_envia_email_erro (string as_mensagem)
public function boolean of_verifica_situacao_pedido (long al_filial, long al_pedido_distribuidora, ref string as_log)
public function boolean of_verifica_controlado_em_separacao (long al_filial, long al_pedido, ref string as_msg)
public function boolean of_verifica_geracao_pedido (ref string as_log)
end prototypes

public function boolean of_finaliza_separacao ();Long	ll_Linhas, ll_Linha, ll_Qtd_Situacao
Long  ll_Pedido, ll_Filial, ll_Nr_Prioridade 
String ls_Log, ls_erro, ls_Almoxarifado 
String ls_Anexo[]
Date ldt_inicio , ldt_termino
Boolean ivb_Controlado_Lote  = False
Boolean   lb_Sucesso = True 

ls_erro  =  "Autom$$HEX1$$e100$$ENDHEX$$tico: Finaliza Separa$$HEX2$$e700e300$$ENDHEX$$o CD: "
ldt_termino	= Date (gf_GetServerDate())
ldt_inicio		= Date(RelativeDate( Date(gf_GetServerDate()) , -5))

If of_verifica_geracao_pedido (Ref ls_Log) then
	
	ivb_Controlado_Lote = gf_pad_picking_lote() 
	
	Try 
		
		dc_uo_ds_base			lds_lista_separados
		lds_lista_separados	=	Create dc_uo_ds_base
		If Not lds_lista_separados.of_ChangeDataObject("dw_ge547_lista_manutencao_pedido", False) Then 
			SqlCa.of_Rollback()		
			ls_Log	=	 ls_erro + "Erro na dw_ge547_lista_manutencao_pedido"
			lb_Sucesso = False  
		End If
		
		// Quantidade de Registros		
		ll_Linhas = lds_lista_separados.Retrieve(ldt_inicio ,ldt_termino)
		
		// Qdo Tem Registros
		If ll_Linhas > 0 Then 
	
			// Para Carregando....
			If Not IsValid(w_aguarde) then
				Open(w_aguarde)
			End If	
			w_aguarde.Title = "WMS-Finaliza$$HEX2$$e700e300$$ENDHEX$$o Separa$$HEX2$$e700e300$$ENDHEX$$o Autom$$HEX1$$e100$$ENDHEX$$tico:"
			w_aguarde.uo_progress.of_reset()
			w_aguarde.uo_progress.Of_SetMax(ll_linhas)			
			
			For ll_Linha = 1 To ll_Linhas 
				w_aguarde.Title = "WMS-Finaliza$$HEX2$$e700e300$$ENDHEX$$o Separa$$HEX2$$e700e300$$ENDHEX$$o Autom$$HEX1$$e100$$ENDHEX$$tico:" + String(ll_Linha)+" De :"+String(ll_Linhas)				
				
				ll_Pedido 				= lds_lista_separados.Object.nr_pedido	[ll_Linha]
				ll_Filial 					= lds_lista_separados.Object.cd_filial		[ll_Linha]
				ll_Nr_Prioridade  		= lds_lista_separados.Object.nr_prioridade_faturamento	[ll_Linha] 
				ls_Almoxarifado		= lds_lista_separados.Object.id_pedido_almoxarifado[ll_Linha]
				
				If IsNull(ll_Nr_Prioridade) or ll_Nr_Prioridade<0 Then Continue
				
				// Verifica Se Picking Controlado N$$HEX1$$e300$$ENDHEX$$o Gerado.
				If ivb_Controlado_Lote Then 
					If Not of_verifica_controlado_em_separacao(ll_Filial,ll_Pedido, ref ls_log) Then 
						///gf_ge202_envia_email_automatico(276,"Aten$$HEX2$$e700e300$$ENDHEX$$o.Picking de Controlado N$$HEX1$$e300$$ENDHEX$$o Foi Gerado", ls_Log, ls_Anexo )
						Continue
					End If 
				End If 
				
				// Verifica Situacao Deste Pedido: Tem que estar "Em Separa$$HEX2$$e700e300$$ENDHEX$$o"
				If Not of_verifica_situacao_pedido(ll_Filial,ll_Pedido, ref ls_log) Then 
					Continue
				End If 
							
				// Atualiza Pedido:  Segura o Registro
				If of_atualiza_pedido_distribuidora(ll_Filial,ll_Pedido, Ref ls_Log) Then 
					// Atualiza Almoxarifado
					If of_atualiza_pedido_almoxarifado(ll_Filial,ll_Pedido, Ref ls_Log) Then 
						lb_Sucesso = True 
					End If 				
				Else
					lb_Sucesso = False  
					ls_Log	=	 ls_erro + "Erro Atualizar PedidoDistribuidora ou PedidoAmox"				
					SqlCa.of_Rollback()		
				End If 
				
				// Verifica se este pedido esta conferido da Loja
				If Not of_verifica_volume_nao_conferido (ll_Filial, ll_Pedido) Then 
					Sqlca.Of_RollBack()
					Continue
				End If 
	
				// Finaliza Grava$$HEX2$$e700e300$$ENDHEX$$o se Passou por todas valida$$HEX2$$e700f500$$ENDHEX$$es anteriores.
				If lb_Sucesso Then
					Sqlca.of_Commit()
				Else
					ls_Log	=	 ls_erro + "Erro no processo de grava$$HEX2$$e700e300$$ENDHEX$$o"
					Sqlca.Of_RollBack()
					lb_Sucesso = False
				End If
				
				// Para Carregando
				w_aguarde.uo_progress.Of_SetProgress(ll_Linha)		
			Next
		Else
			lb_Sucesso = True	
		End If 
			
	Finally
		Destroy (lds_lista_separados)	
		If IsValid(w_aguarde) Then Close(w_aguarde)
	End Try
	
else
	If ls_Log = '' then
		//Pedidos ainda est$$HEX1$$e300$$ENDHEX$$o sendo gerados. Sai sem finalizar a separa$$HEX2$$e700e300$$ENDHEX$$o.
		lb_Sucesso = True
	End if
End if

If Not lb_Sucesso Then 
	of_envia_email_erro( ls_Log  ) 
End If 

Return lb_Sucesso
end function

public function boolean of_atualiza_pedido_distribuidora (long al_filial, long al_pedido_distribuidora, string as_erro);Datetime ldh_termino
ldh_termino	= gf_GetServerDate()



Update pedido_distribuidora
Set id_situacao = 'T' , 
			dh_conferencia_finalizada=:ldh_termino
Where cd_filial = :al_filial
and nr_pedido_distribuidora = :al_pedido_distribuidora
and id_situacao = 'S'
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.Of_RollBack()
	as_Erro = "Erro Atualizar PedidoDistribuidora : "+SqlCa.SqlErrText
	Return False
End If

Return True
end function

public function boolean of_atualiza_pedido_almoxarifado (long al_filial, long al_pedido, ref string as_erro);Boolean lb_Pedido_Almoxarifado_Novo
Long ll_Volume
Datetime ldh_termino


ldh_termino	= gf_GetServerDate()


///   VER COM SERGIO.. SOBRE A FUN$$HEX2$$c700c300$$ENDHEX$$O ABAIXO... 
If Not gf_Pedido_Almoxarifado_Novo(al_Filial, Ref lb_Pedido_Almoxarifado_Novo, Ref as_Erro) Then
	Return False
End If

If Not lb_Pedido_Almoxarifado_Novo Then
	Return True
End If

Update pedido_almoxarifado
Set id_situacao 	= 'T'
Where cd_filial 		= :al_Filial
	And nr_pedido 	in (Select nr_pedido_almoxarifado
							From pedido_distribuidora_almox
							Where cd_filial 						= :al_Filial
							And nr_pedido_distribuidora 	= :al_Pedido)
Using SqlCa;	
	
If  SqlCa.SqlCode = -1 Then
	Sqlca.Of_RollBack()
	as_Erro = "Erro ao atualizar Pedido Amoxarifado : "+SqlCa.SqlErrText
	Return False
End If		

Return True
end function

public function boolean of_verifica_prioridade_faturamento (long al_prioridade, date ldt_inicio, date ldt_fim);Long ll_Qtd

SELECT 	count(*) 
Into :ll_Qtd
FROM pedido_distribuidora 					pd
INNER JOIN filial 								f 	on pd.cd_filial = f.cd_filial
INNER JOIN parametro 						p 	on pd.cd_distribuidora = p.cd_distribuidora_estoque
LEFT JOIN pedido_distribuidora_almox 	pa	on pa.cd_filial = pd.cd_filial
														and pa.nr_pedido_distribuidora = pd.nr_pedido_distribuidora
LEFT JOIN pedido_almoxarifado			a 	on a.cd_filial = pa.cd_filial 
														and a.nr_pedido = pa.nr_pedido_almoxarifado
LEFT JOIN rota_entrega 						ro  on ro.nr_rota = f.nr_rota_entrega
Where  pd.id_situacao = 'S'
and pd.dh_emissao >=:ldt_inicio  and  pd.dh_emissao <=:ldt_fim
and f.nr_prioridade_faturamento < :al_prioridade
Using SqlCA;


If SqlCa.SqlCode = -1 Then	
	Sqlca.Of_MsgDbError("Erro ao localizar situacao prioridade de fatuamento")
	Return False
End If 


If ll_Qtd  = 0 Then
	Return True 
Else
	Return False  
End If 
end function

public function boolean of_verifica_volume_nao_conferido (long al_filial, long al_pedido);Long ll_listas

select count(*) 
Into :ll_Listas
From wms_lista_separacao
Where cd_filial 							= :al_filial
	and nr_pedido_distribuidora 	= :al_pedido
	and (dh_termino_conferencia 	is null or (dh_termino_conferencia is not null and id_atualizacao_mov_estoque = 'N'))
	and dh_cancelamento is null
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.Of_MsgDbError("Erro ao localizar se exite lista se separa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o conferida.")
	Return False
End If

// Verifica se o volume que esta passando esta OK.
If ll_Listas > 0 Then
	Return False
Else
	Return True 
End If 
end function

public function boolean of_envia_email_erro (string as_mensagem);String	ls_Msg
s_email lst_Email					

ls_Msg =	"Aten$$HEX2$$e700e300$$ENDHEX$$o,<br><br>" +&
			"Erro na Finaliza$$HEX2$$e700e300$$ENDHEX$$o da Separa$$HEX2$$e700e300$$ENDHEX$$o! Verificar com Urg$$HEX1$$ea00$$ENDHEX$$ncia (GE547)<br>"	

lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

If Not gf_ge202_envia_email_padrao(265, lst_Email)	Then
	Return False
End If
			
Return True
end function

public function boolean of_verifica_situacao_pedido (long al_filial, long al_pedido_distribuidora, ref string as_log);Long ll_Qtd


select  Count(*) 
Into :ll_Qtd
from   pedido_distribuidora
Where cd_filial = :al_filial
and 	nr_pedido_distribuidora = :al_pedido_distribuidora
and   id_situacao = 'S'
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	Sqlca.Of_MsgDbError("Erro ao Localizar situa$$HEX2$$e700e300$$ENDHEX$$o pedido distribuidora")
	Return False
End If

If ll_Qtd > 0 Then
	Return True 
Else
	Return False 
End If 

end function

public function boolean of_verifica_controlado_em_separacao (long al_filial, long al_pedido, ref string as_msg);String ls_MSG

Long ll_Qtde


ll_Qtde	= 0

//O Select abaixo verifica se o produto $$HEX1$$e900$$ENDHEX$$ psico ou somente vigiado
Select count(*) 
Into 	:ll_Qtde
From  pedido_distribuidora a
Inner join pedido_distribuidora_produto b 
		on b.cd_filial  = a.cd_filial 
		and b.nr_pedido_distribuidora  = a.nr_pedido_distribuidora 
Inner join produto_geral c 
		on c.cd_produto  = b.cd_produto 
Where (c.cd_grupo_psico is not null 
or    exists (select * from dbo.wms_endereco_produto w 
					where w.cd_esteira = 3 
					  and w.cd_produto = c.cd_produto))		
And 	a.id_situacao  = 'S'
And   a.dh_picking_controlado is null 
And   coalesce(a.id_tipo_pedido, 'A') <> 'G'
And   a.cd_filial  =:al_Filial
And   a.nr_pedido_distribuidora=:al_pedido
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	ls_MSG = 	"Erro verifica$$HEX2$$e700e300$$ENDHEX$$o da quantidade lista separacao do pedido '" + String(al_Pedido) + "'. '" + SQLCA.SQLErrText + "'."
	SqlCa.of_RollBack()
	Return False
Else
	If ll_Qtde > 0 Then
		ls_MSG = 	"Aten$$HEX2$$e700e300$$ENDHEX$$o! N$$HEX1$$e300$$ENDHEX$$o foi gerado picking Controlado! Filial:'" + String(al_filial) + " para o Pedido: "+String(al_pedido)
		SqlCa.of_RollBack()		
		Return False
	End If
End If

Return true


end function

public function boolean of_verifica_geracao_pedido (ref string as_log);DateTime	ldh_termino

as_log = ''

SELECT
		dh_termino_geracao_flow
  INTO
  		:ldh_termino
  FROM
  		controle_geracao_pedido
 WHERE
 		id_multitask_logistica = 'S'
   AND
		dh_pedido = (SELECT
								MAX (dh_pedido)
							FROM
								controle_geracao_pedido
						  WHERE
						  		id_multitask_logistica = 'S')
 USING SQLCA;

If SQLCA.SQLCode <> 0 then
	as_log = 'Erro ao verificar se os pedidos est$$HEX1$$e300$$ENDHEX$$o sendo gerados: ' + SQLCA.SQLErrText
	Return False
End if

If IsNull (ldh_termino) then
	Return False
End if

Return True
end function

on uo_ge547_fatura_automatico.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge547_fatura_automatico.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

