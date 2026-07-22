HA$PBExportHeader$uo_ge614_cancela_pedido_urgente.sru
forward
global type uo_ge614_cancela_pedido_urgente from nonvisualobject
end type
end forward

global type uo_ge614_cancela_pedido_urgente from nonvisualobject
end type
global uo_ge614_cancela_pedido_urgente uo_ge614_cancela_pedido_urgente

forward prototypes
public function boolean of_cancela_pedido_urgente_pendente ()
end prototypes

public function boolean of_cancela_pedido_urgente_pendente ();//Cancela os pedidos empurrados pendentes do tipo urgente que foram inclu$$HEX1$$ed00$$ENDHEX$$dos h$$HEX1$$e100$$ENDHEX$$ mais de 5 horas
//S$$HEX1$$e300$$ENDHEX$$o reservas realizadas pela filial onde N$$HEX1$$c300$$ENDHEX$$O foram finalizadas
//O not exists $$HEX1$$e900$$ENDHEX$$ para n$$HEX1$$e300$$ENDHEX$$o realizar o cancelamento do pedido_empurrado quando houver NF venda
//O pedido com situa$$HEX2$$e700e300$$ENDHEX$$o P $$HEX1$$e900$$ENDHEX$$ porque n$$HEX1$$e300$$ENDHEX$$o foi finalizado na loja ou houve algum bug ($$HEX1$$e900$$ENDHEX$$ feito via distribu$$HEX1$$ed00$$ENDHEX$$do) ao gravar no Central

Update pedido_empurrado
	Set	id_situacao = 'X',
			dh_cancelamento = getdate(),
			nr_matricula_cancelamento = '14330',
			de_motivo_cancelamento = 'RESERVA PENDENTE H$$HEX1$$c100$$ENDHEX$$ MAIS DE 5 HORAS CANC PELO GN'
From pedido_empurrado p
Where p.id_tipo_pedido = 'U'
	And p.id_situacao = 'P'
	And DATEDIFF(Mi, p.dh_inclusao, getdate()) > 300
	And Not Exists (Select *
						From cliente_caixa_produto cp
							Inner Join cliente_caixa c
								On c.cd_filial = cp.cd_filial
								And c.nr_sequencial = cp.nr_sequencial_cliente_caixa
						Where cp.cd_filial = p.cd_filial
							And cp.nr_pedido_empurrado = p.nr_pedido_empurrado
							And c.nr_nf_venda Is Not Null
							And cp.id_situacao = 'C')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	gf_ge202_envia_email_automatico(76, '', "Erro ao cancelar os pedidos urgentes. uo_ge614_cancela_pedido_urgente.of_cancela_pedido_urgente_pendente(). " + SqlCa.SqlErrText, {''} )
	SqlCa.of_Rollback();
	Return False
End If

SqlCa.of_Commit();

Return True
end function

on uo_ge614_cancela_pedido_urgente.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge614_cancela_pedido_urgente.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

