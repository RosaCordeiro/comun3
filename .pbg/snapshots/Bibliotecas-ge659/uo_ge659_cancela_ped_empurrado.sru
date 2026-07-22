HA$PBExportHeader$uo_ge659_cancela_ped_empurrado.sru
forward
global type uo_ge659_cancela_ped_empurrado from nonvisualobject
end type
end forward

global type uo_ge659_cancela_ped_empurrado from nonvisualobject
end type
global uo_ge659_cancela_ped_empurrado uo_ge659_cancela_ped_empurrado

forward prototypes
public function boolean of_consulta_dias_cancelamento_pedido (ref integer as_dias_empurados, ref string as_erro)
public function boolean of_processar_cancelamento_ped_empurrado ()
end prototypes

public function boolean of_consulta_dias_cancelamento_pedido (ref integer as_dias_empurados, ref string as_erro);select vl_parametro
	Into :as_dias_empurados
from parametro_geral 
where cd_parametro = 'NR_DIAS_CONSIDERA_EMPU_PROD'
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro dias para considera os produtos do pedido empurrado"
		Return False	
	Case -1
		as_erro = "Erro Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro para cancela o produto do pedido empurrado" + SqlCa.SqlErrText
		Return False
	Case 0 
		Return True
End Choose
end function

public function boolean of_processar_cancelamento_ped_empurrado ();Integer	ll_Dias_empurados

datetime ldh_hoje,&
			ldt_Data

Long	ll_Linha,&
		ll_Linhas,&
		ll_Cd_filial,&
		ll_Nr_pedido_empurrado,&
		ll_produto,&
		ll_qt_empurrada,&
		ll_qt_faturada

String	ls_Situacao,&
			ls_Erro,&
			ls_matricula

Try
	If Not of_consulta_dias_cancelamento_pedido(ref ll_dias_empurados, ref ls_erro) Then
		Return False
	End if
	
	ldt_data = DateTime(RelativeDate(Date(gf_GetServerDate()), ll_dias_empurados * -1),Time("23:59:59"))
	
	dc_uo_ds_base lds_pedidos_empurrados
	lds_pedidos_empurrados = Create dc_uo_ds_base
	
	If Not lds_pedidos_empurrados.Of_ChangeDataObject('ds_ge659_pedido_empurrado_cancelamento') then
		ls_Erro = "Erro no ChageDataObject da ds_ge659_pedido_empurrado_cancelamento." 
		Return False
	End if
	
	lds_pedidos_empurrados.Retrieve(ldt_data)
	ll_Linhas = lds_pedidos_empurrados.RowCount()
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = "Cancelamento Pedidos Empurrados: Processando Cancelamento de Pedidos N$$HEX1$$e300$$ENDHEX$$o Atendidos em "+string(ll_dias_empurados)+" Dias...."
	w_Aguarde.uo_Progress.of_setmax(ll_Linhas)
	
	For ll_Linha = 1 To ll_Linhas
		
		w_Aguarde.Title = "Cancelando os Pedidos Empurrados: " + String(ll_Linha) + " de " + String(ll_Linhas)
		w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
		
		SetNull(ls_Situacao)
		
		ll_Cd_filial				=	lds_pedidos_empurrados.Object.cd_filial				[ll_Linha]
		ll_Nr_pedido_empurrado	=	lds_pedidos_empurrados.Object.nr_pedido_empurrado	[ll_Linha]
		ll_produto					=	lds_pedidos_empurrados.Object.cd_produto				[ll_Linha]
		ll_qt_empurrada			=	lds_pedidos_empurrados.Object.qt_empurrada			[ll_Linha]	
		ll_qt_faturada				=	lds_pedidos_empurrados.Object.qt_faturada				[ll_Linha]
		
		If ll_qt_faturada > 0 Then
			ls_Situacao = 'A'
			Setnull(ldh_hoje)
			Setnull(ls_matricula)
		Else 
			ls_Situacao		= 'X'
			ldh_hoje 		= gf_GetServerDate()
			ls_matricula	= '14330'
		End If
		
		Update pedido_empurrado_produto
			Set id_situacao 					= :ls_Situacao,
				dh_cancelamento 				= :ldh_hoje,
				nr_matricula_cancelamento	= :ls_matricula
		Where cd_filial 			= :ll_Cd_filial
		And nr_pedido_empurrado = :ll_Nr_pedido_empurrado
		And cd_produto 			= :ll_produto
		Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			ls_Erro = "Erro em atualizar o pedido empurrado para cancelado/atendido. ~nProduto:"+string(ll_produto)+" Nr_Pedido:"+string(ll_Nr_pedido_empurrado)+" Cd_filial:"+string(ll_Cd_filial)+" ~n" + sqlca.sqlerrtext
			Return False
		Else
			SqlCa.of_Commit()
		End If
	Next

Finally		
	Destroy(lds_pedidos_empurrados)
	Close(w_Aguarde)
End Try

Return True

end function

on uo_ge659_cancela_ped_empurrado.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge659_cancela_ped_empurrado.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

