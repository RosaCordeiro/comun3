HA$PBExportHeader$uo_ge640_cancela_ped_sem_picking.sru
forward
global type uo_ge640_cancela_ped_sem_picking from nonvisualobject
end type
end forward

global type uo_ge640_cancela_ped_sem_picking from nonvisualobject
end type
global uo_ge640_cancela_ped_sem_picking uo_ge640_cancela_ped_sem_picking

forward prototypes
public function boolean of_processa_cancelamento ()
end prototypes

public function boolean of_processa_cancelamento ();//  Como Temos o Processo de Picking Alternado : Geladeira
//  Necessario realizar o cancelamento destes pedidos.

Date ldt_Pedido 

ldt_Pedido  = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -1)

Update  pedido_distribuidora
Set cd_motivo_rejeicao  = 19,
    dh_cancelamento = getdate(),
    nr_matricula_cancelamento  = '14330', 
    id_situacao  = 'X'
From  pedido_distribuidora a 
where a.dh_emissao >=:ldt_Pedido  
and  a.id_situacao  in ('T', 'S')
and a.id_tipo_pedido = 'G'
and  not exists  ( select a.cd_filial , a1.nr_pedido_distribuidora   
                   from   dbo.wms_lista_separacao a1
                   where  a1.cd_filial  = a.cd_filial 
                   and    a1.nr_pedido_distribuidora  = a.nr_pedido_distribuidora
                   AND    a1.dh_geracao>=a.dh_emissao) 
Using SqlCA;


If SqlCa.SqlCode = -1 Then
	gf_ge202_envia_email_automatico(334, '', "Erro ao cancelar os pedidos sem lista de separacao. uo_g640_cancela_ped_sem_picking. " + SqlCa.SqlErrText, {''} )
	SqlCa.of_Rollback();
	Return False
End If

SqlCa.of_Commit();

Return True
end function

on uo_ge640_cancela_ped_sem_picking.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge640_cancela_ped_sem_picking.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

