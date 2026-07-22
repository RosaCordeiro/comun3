HA$PBExportHeader$w_ge563_processa_controlado.srw
forward
global type w_ge563_processa_controlado from dc_w_cadastro_selecao_lista
end type
type cb_gera_picking from commandbutton within w_ge563_processa_controlado
end type
end forward

global type w_ge563_processa_controlado from dc_w_cadastro_selecao_lista
string tag = "w_ge563_processa_controlado"
integer width = 2816
integer height = 1884
string title = "GE563 - Gera$$HEX2$$e700e300$$ENDHEX$$o Picking Controlado"
cb_gera_picking cb_gera_picking
end type
global w_ge563_processa_controlado w_ge563_processa_controlado

type variables
Date idt_data
String ivs_operador
Boolean ib_Controlado_Endereco_Lote
end variables

forward prototypes
public function boolean wf_valida_geracao_pedido ()
public function boolean wf_valida_termino_corte ()
public function boolean wf_verifica_pendente_abastecimento ()
public function boolean wf_valida_abastecimento_controlado ()
public function boolean wf_carrega_saldo_conta_corrente ()
end prototypes

public function boolean wf_valida_geracao_pedido ();DateTime ldh_Termino_Geracao_Pedido

String ls_MSG

Select  dh_termino_geracao
Into  :ldh_Termino_Geracao_Pedido
From  controle_geracao_pedido
Where id_multitask_logistica  = 'S'
And dh_pedido=:idt_data
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case 0
		
		If IsNull(ldh_Termino_Geracao_Pedido) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ainda n$$HEX1$$e300$$ENDHEX$$o terminou de gerar o pedido.", Exclamation!)
			Return False
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe pedido gerado em '" + String(idt_data, 'dd/mm/yyyy') + "'.")
		Return False
	Case -1
		ls_MSG = 	"Erro ao consultar a tabela CONTROLE_GERACAO_PEDIDO '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
End Choose


	




end function

public function boolean wf_valida_termino_corte ();DateTime ldh_Termino_Corte_Pedido

String ls_MSG

Select  dh_termino_corte_pedido
Into  :ldh_Termino_Corte_Pedido
From  controle_geracao_pedido
Where id_multitask_logistica  = 'S'
And dh_pedido=:idt_data
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case 0
		
		If IsNull(ldh_Termino_Corte_Pedido) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Aguarde o t$$HEX1$$e900$$ENDHEX$$rmino do processo de corte do pedido. ~r~r Acesse:Menu->Consulta->Pedido->Status Gera$$HEX2$$e700e300$$ENDHEX$$o", Exclamation!)
			Return False
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe pedido gerado em '" + String(idt_data, 'dd/mm/yyyy') + "'.")
		Return False
	Case -1
		ls_MSG = 	"Erro ao consultar a tabela CONTROLE_GERACAO_PEDIDO [CORTE] '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
End Choose

Return True



end function

public function boolean wf_verifica_pendente_abastecimento ();Long ll_Abast_Pendente
Long ll_Ret_Abast

dc_uo_ds_base lds_1

try
	lds_1 = Create dc_uo_ds_base
	
	If Not lds_1.of_ChangeDataObject("dw_ge563_lista_abast_pend_controlado", False) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao trocar a DW [dw_ge563_lista_abast_pend_controlado].", StopSign!)
		Return False
	End If 

	ll_Abast_Pendente = lds_1.retrieve(idt_data)
	
	Choose Case ll_Abast_Pendente
		Case 0
			Return True 
		Case IS > 0
			Open(w_ge563_abast_pend_controlado)
			ll_Ret_Abast = Message.DoubleParm	
			If ll_Ret_Abast <> 1 Then Return False
		Case Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os produtos pendentes de abastecimento.", StopSign!)
			Return False
	End Choose
	
finally
	Destroy(lds_1)
end try

Return True


end function

public function boolean wf_valida_abastecimento_controlado ();Long	ll_Qtd
String	ls_MSG

select count(*) 
Into :ll_Qtd  
from wms_abastecimento_flow_rack a
inner join produto_geral b 
		on a.cd_produto  = b.cd_produto 
where b.cd_grupo_psico  is not null 
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	ls_MSG = 	"Erro ao consultar a tabela WMS_ABASTECIMENTO_FLOW_RACK '" + SQLCA.SQLErrText + "'."
	SqlCa.of_RollBack()
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
	Return False
Else
	If ll_Qtd>0 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A esteira de CONTROLADO est$$HEX1$$e100$$ENDHEX$$ sendo abastecida. ~r~rFinalize antes de continuar.", Exclamation!)
		Return False
	End If 
End If 

Return True

end function

public function boolean wf_carrega_saldo_conta_corrente ();Long ll_Qtd, ll_Linha, ll_Linhas, ll_Produto, ll_Saldo_Utilizado
String ls_MSG, lvs_Endereco

Select Coalesce(count(*),0) 
Into 	:ll_Qtd
From    wms_localizacao_pedido_cc
Where dh_pedido =:idt_data
Using SqlCA;

If SqlCa.SqlCode = -1  Then 
	ls_MSG = 	"Erro ao Consultar os dados na WMS_LOCALIZACAO_PEDIDO_CC '" + SQLCA.SQLErrText + "'."
	SqlCa.of_RollBack()
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
	Return False
Else
	If ll_Qtd = 0 Then 
		Insert Into wms_localizacao_pedido_cc (dh_pedido,  cd_endereco, cd_produto, nr_lote, qt_saldo, qt_saldo_utilizado ) 
		Select :idt_data , w.cd_endereco, w.cd_produto, w.nr_lote, sum(w.qt_saldo * w.qt_caixa_padrao) , 0
		From wms_localizacao w
		Inner join wms_endereco e on e.cd_endereco = w.cd_endereco
		Inner join wms_bairro b on b.cd_bairro = e.cd_bairro
		Inner 	join produto_geral g on g.cd_produto = w.cd_produto
		Where b.id_flow_rack = 'S'
		And g.cd_grupo_psico is not null
		Group by w.cd_endereco, w.cd_produto, w.nr_lote
		Using SqlCA;

		If Sqlca.SqlCode = -1 Then
			ls_MSG = 	"Erro ao Inserir na WMS_LOCALIZACAO_PEDIDO_CC '" + SQLCA.SQLErrText + "'."
			SqlCa.of_RollBack()
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
			Return False
		End If
	Else
		Delete From wms_localizacao_pedido_cc
		Where dh_pedido=:idt_data
		Using SqlCA;
		
		If Sqlca.SqlCode = -1 Then
			ls_MSG = 	"Erro ao Apagar os dados da WMS_LOCALIZACAO_PEDIDO_CC '" + SQLCA.SQLErrText + "'."
			SqlCa.of_RollBack()
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
			Return False
		End If
		
		Insert Into wms_localizacao_pedido_cc (dh_pedido,  cd_endereco, cd_produto, nr_lote, qt_saldo, qt_saldo_utilizado ) 
		Select :idt_data , w.cd_endereco, w.cd_produto, w.nr_lote, sum(w.qt_saldo * w.qt_caixa_padrao) , 0
		From wms_localizacao w
		Inner join wms_endereco e on e.cd_endereco = w.cd_endereco
		Inner join wms_bairro b on b.cd_bairro = e.cd_bairro
		Inner 	join produto_geral g on g.cd_produto = w.cd_produto
		Where b.id_flow_rack = 'S'
		And g.cd_grupo_psico is not null
		Group by w.cd_endereco, w.cd_produto, w.nr_lote
		Using SqlCA;

		If Sqlca.SqlCode = -1 Then
			ls_MSG = 	"Erro ao Inserir na WMS_LOCALIZACAO_PEDIDO_CC '" + SQLCA.SQLErrText + "'."
			SqlCa.of_RollBack()
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
			Return False
		End If 

	End If 
	
End If 

// Ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio sempre verificar se n$$HEX1$$e300$$ENDHEX$$o existem volumes que ainda n$$HEX1$$e300$$ENDHEX$$o foram conferidos
dc_uo_ds_base lds_NaoConferidos
lds_NaoConferidos = Create dc_uo_ds_base

If Not lds_NaoConferidos.of_ChangeDataObject("dw_ge563_lista_pedidos_nao_conferidos", True) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao trocar a DW [dw_ge563_lista_pedidos_nao_conferidos].", StopSign!)
	SqlCa.of_Rollback()
	Return False
End If

ll_Linhas = lds_NaoConferidos.Retrieve(idt_data)

For ll_Linha =1 To ll_Linhas 

	ll_Produto			= lds_NaoConferidos.Object.cd_produto [ll_Linha]						
	lvs_Endereco 		= lds_NaoConferidos.Object.cd_endereco_localizacao [ll_Linha]
	ll_Saldo_Utilizado 	= lds_NaoConferidos.Object.qt_saldo_utilizado [ll_Linha]						

	Update wms_localizacao_pedido_cc
	Set  qt_saldo_utilizado =:ll_Saldo_Utilizado
	Where cd_produto =:ll_Produto
	And  cd_endereco=:lvs_Endereco
	Using SqlCA;
	
	If Sqlca.SqlCode = -1 Then
		ls_MSG = 	"Erro ao Atualizar o qt_saldo_utilizado da WMS_LOCALIZACAO_PEDIDO_CC '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
	End If 			
Next 
	
// Se chegou at$$HEX1$$e900$$ENDHEX$$ aqui $$HEX1$$e900$$ENDHEX$$ porque deu tudo certo
SqlCa.of_commit( )

Return True
end function

on w_ge563_processa_controlado.create
int iCurrent
call super::create
this.cb_gera_picking=create cb_gera_picking
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gera_picking
end on

on w_ge563_processa_controlado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_gera_picking)
end on

event ue_postopen;//Overide
String ls_Operador
dw_1.Event ue_AddRow()
dw_1.SetFocus()

This.ivm_Menu.mf_Recuperar(True)
dw_1.Object.Dt_Inicio [1] = Date(String(Today(), "dd/mm/yyyy"))

ib_Controlado_Endereco_Lote  = gf_pad_picking_lote()

If Not ib_Controlado_Endereco_Lote  Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Processo de Gera$$HEX2$$e700e300$$ENDHEX$$o de Picking de Controlado n$$HEX1$$e300$$ENDHEX$$o esta liberado!")
	Close(This)
	Return
End If 


If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE563_PROCESSA_PICK_CONTROLADO", ref ls_Operador) Then 
	Close(This)
	Return
End If
gvo_Aplicacao.ivo_Seguranca.of_Localiza_Usuario(ls_Operador)

ivs_operador = ls_Operador








end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge563_processa_controlado
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge563_processa_controlado
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge563_processa_controlado
integer y = 80
integer width = 850
integer height = 100
string dataobject = "dw_ge563_selecao"
end type

event dw_1::constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge563_processa_controlado
integer y = 224
integer width = 2702
integer height = 1448
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge563_processa_controlado
integer width = 914
integer height = 200
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge563_processa_controlado
integer y = 292
integer width = 2606
integer height = 1352
string dataobject = "dw_ge563_selecao_pedido"
end type

event dw_2::ue_recuperar;//OverRide
Date ldt_data
dw_1.accepttext( )
ldt_data = dw_1.Object.Dt_Inicio [1]
Return This.Retrieve(ldt_data)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	cb_gera_picking.Enabled = TRUE 
Else
	cb_gera_picking.Enabled = FALSE
End If

Return pl_Linhas


end event

type cb_gera_picking from commandbutton within w_ge563_processa_controlado
integer x = 2107
integer y = 108
integer width = 631
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Processar Picking"
end type

event clicked;Long 		ll_Filial, ll_Pedido, ll_Qtd_Abast, ll_Lista_Separacao, ll_Pedido_Nao_Gerado,  ll_Linha, ll_Ret_Abast, ll_Linhas
Date 		ldt_Parametro
String 	ls_MSG, ls_Anexo[]

Boolean lb_Pedido_Almoxarifado = False
Boolean lb_Pedido_Controlado = True
Boolean lb_Sucesso = True

uo_ge622_wms_romaneio_novo lo_roma
lo_roma = Create uo_ge622_wms_romaneio_novo

If Not gf_pad_picking_lote() Then
 	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nova funcionalidade da esteira controlada ainda n$$HEX1$$e300$$ENDHEX$$o foi ativada.", Exclamation!)
	 Return
End If

dw_1.accepttext( )
idt_data   =  dw_1.Object.Dt_Inicio [1]

If IsNull(idt_data) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do pedido.")
	dw_1.Event ue_Pos(1, "Dt_Inicio")
	Return 
End If

If dw_2.RowCount() <= 0 Then Return

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma Gera$$HEX2$$e700e300$$ENDHEX$$o do Picking da Esteira de Controlado?", Question!, YesNo!, 2) = 2 Then Return	

// Valida Se Termino a Gera$$HEX2$$e700e300$$ENDHEX$$o do Pedido: Tabela :  Controle_geracao_pedido
If Not wf_valida_geracao_pedido() Then Return

// Valida Se Termino a Gera$$HEX2$$e700e300$$ENDHEX$$o do Pedido: Tabela :  Controle_geracao_pedido
If Not wf_valida_termino_corte() Then Return

//  Valida$$HEX2$$e700e300$$ENDHEX$$o Abastecmento em Andamento
If Not wf_valida_abastecimento_controlado() Then Return

//  Verifica se todos os produtos da esteira controlado foram abastecido, caso contr$$HEX1$$e100$$ENDHEX$$rio ir$$HEX1$$e100$$ENDHEX$$ gerar corte
If Not wf_verifica_pendente_abastecimento() Then Return

// Carga ou Atualizacao Tabela ContaCorrente:  Tabela :wms_localizacao_pedido_cc
If Not wf_carrega_saldo_conta_corrente() Then Return

try
	uo_ge259_pedido_filial lds
	lds = Create uo_ge259_pedido_filial
	
	ll_Linhas = dw_2.RowCount()

	Open(w_Aguarde)
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	For ll_Linha = 1 To ll_Linhas
		
		If dw_2.Object.id_processar[ll_Linha] = 'S' Then
			
			ll_Filial      =   dw_2.Object.cd_filial[ll_Linha] 
			ll_Pedido   =   dw_2.Object.nr_pedido[ll_Linha] 
			
			If Not lds.of_processa_geracao_picking( ll_Filial, ll_Pedido,lb_Pedido_Almoxarifado, lb_Pedido_Controlado, idt_data  ) Then 
				lb_Sucesso = False
				ls_MSG = "Erro ao gerar picking para Filial:"+String(ll_Filial) + "Pedido:" + String(ll_Pedido) +". Entre em Contato com TI" 
				SqlCa.of_RollBack()
				gf_ge202_envia_email_automatico(276, '',ls_MSG, ls_Anexo)
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG )
				Return 	
			End If 
			
		End If
		
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
	
	lo_roma.of_processa_cria_romaneio( )
	
finally
	Close(w_Aguarde)
	Destroy(lds)
	Destroy (lo_roma)
	
	If lb_Sucesso Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Picking Controlado Gerado com Sucesso!")
		dw_2.Event ue_Recuperar()
	End If
end try

end event

