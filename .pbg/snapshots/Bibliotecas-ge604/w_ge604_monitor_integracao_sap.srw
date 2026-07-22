HA$PBExportHeader$w_ge604_monitor_integracao_sap.srw
forward
global type w_ge604_monitor_integracao_sap from dc_w_sheet
end type
type tab_1 from tab within w_ge604_monitor_integracao_sap
end type
type tabpage_1 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_1
end type
type p_3 from picture within tabpage_1
end type
type gb_co_erro_remessa from groupbox within tabpage_1
end type
type gb_co_detalhe_agendamento from groupbox within tabpage_1
end type
type dw_co_detalhe_produto from dc_uo_dw_base within tabpage_1
end type
type p_2 from picture within tabpage_1
end type
type p_1 from picture within tabpage_1
end type
type gb_co_detalhe_pedido from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type gb_co_situacao_pedido from groupbox within tabpage_1
end type
type dw_co_situacao_pedido from dc_uo_dw_base within tabpage_1
end type
type gb_co_situacao_remessa from groupbox within tabpage_1
end type
type dw_co_situacao_remessa from dc_uo_dw_base within tabpage_1
end type
type gb_co_situacao_agendamento from groupbox within tabpage_1
end type
type dw_co_situacao_agendamento from dc_uo_dw_base within tabpage_1
end type
type gb_co_detalhe_remessa from groupbox within tabpage_1
end type
type gb_co_detalhe_produto_por_situacao from groupbox within tabpage_1
end type
type dw_co_detalhe_agendamento from dc_uo_dw_base within tabpage_1
end type
type dw_co_detalhe_remessa from dc_uo_dw_base within tabpage_1
end type
type dw_co_detalhe_pedido from dc_uo_dw_base within tabpage_1
end type
type dw_co_erro_remessa from dc_uo_dw_base within tabpage_1
end type
type dw_co_situacao_produto from dc_uo_dw_base within tabpage_1
end type
type gb_co_situacao_produto from groupbox within tabpage_1
end type
type gb_co_detalhe_produto from groupbox within tabpage_1
end type
type dw_co_detalhe_produto_por_situacao from dc_uo_dw_base within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_4 gb_4
p_3 p_3
gb_co_erro_remessa gb_co_erro_remessa
gb_co_detalhe_agendamento gb_co_detalhe_agendamento
dw_co_detalhe_produto dw_co_detalhe_produto
p_2 p_2
p_1 p_1
gb_co_detalhe_pedido gb_co_detalhe_pedido
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
gb_co_situacao_pedido gb_co_situacao_pedido
dw_co_situacao_pedido dw_co_situacao_pedido
gb_co_situacao_remessa gb_co_situacao_remessa
dw_co_situacao_remessa dw_co_situacao_remessa
gb_co_situacao_agendamento gb_co_situacao_agendamento
dw_co_situacao_agendamento dw_co_situacao_agendamento
gb_co_detalhe_remessa gb_co_detalhe_remessa
gb_co_detalhe_produto_por_situacao gb_co_detalhe_produto_por_situacao
dw_co_detalhe_agendamento dw_co_detalhe_agendamento
dw_co_detalhe_remessa dw_co_detalhe_remessa
dw_co_detalhe_pedido dw_co_detalhe_pedido
dw_co_erro_remessa dw_co_erro_remessa
dw_co_situacao_produto dw_co_situacao_produto
gb_co_situacao_produto gb_co_situacao_produto
gb_co_detalhe_produto gb_co_detalhe_produto
dw_co_detalhe_produto_por_situacao dw_co_detalhe_produto_por_situacao
dw_4 dw_4
end type
type tabpage_2 from userobject within tab_1
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_3 gb_3
dw_3 dw_3
end type
type tab_1 from tab within w_ge604_monitor_integracao_sap
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_ge604_monitor_integracao_sap from dc_w_sheet
integer width = 7296
integer height = 2356
string title = "GE604 - Monitor de Integra$$HEX2$$e700e300$$ENDHEX$$o com o SAP"
event ue_retrieve ( )
tab_1 tab_1
end type
global w_ge604_monitor_integracao_sap w_ge604_monitor_integracao_sap

type variables
long ivl_altura_1, &
        ivl_altura_2, &
        ivl_largura_1, &
        ivl_largura_2
		  
Long		il_nr_pedido, &
			il_tipo_filtro = 0

String	is_de_chave_acesso, &
			is_nr_pedido_sap, &
			is_where, &
			is_pesquisa, &
			is_cd_fornecedor

Date idt_pedido

Constant String	is_titulo_erro_remessa = 'Erros no recebimento '

uo_fornecedor ivo_fornecedor
end variables

forward prototypes
public subroutine wf_co_esconde_agendamento ()
public subroutine wf_co_esconde_cabecalho ()
public subroutine wf_co_esconde_pedido ()
public subroutine wf_co_esconde_produto ()
public subroutine wf_co_esconde_remessa ()
public subroutine wf_co_esconde_tudo ()
public subroutine wf_co_exibe_agendamento ()
public subroutine wf_co_exibe_pedido ()
public subroutine wf_co_exibe_produto ()
public subroutine wf_co_exibe_remessa ()
public subroutine wf_co_exibe_situacao ()
public subroutine wf_co_exibe_situacao_pedido ()
public subroutine wf_co_exibe_situacao_remessa ()
public subroutine wf_co_exibe_situacao_agendamento ()
public subroutine wf_co_exibe_erro_remessa ()
public subroutine wf_co_esconde_erro_remessa ()
public subroutine wf_co_exibe_situacao_produto ()
public subroutine _documentacao ()
public subroutine wf_bloqueia_desbloqueia_filtros (long al_tipo)
public subroutine wf_exibir_esconder_dw_fornecedor (string as_tipo)
end prototypes

event ue_retrieve();If Tab_1.TabPage_1.gb_co_situacao_pedido.Visible = True then
	wf_co_esconde_tudo ()
End if

SetNull (il_nr_pedido)
SetNull (is_nr_pedido_sap)
SetNull (is_de_chave_acesso)

tab_1.tabpage_1.dw_1.AcceptText ()

//tipo 1 - bloqueia os tipo 2
il_nr_pedido       		= tab_1.tabpage_1.dw_1.Object.nr_pedido       	[1]
is_nr_pedido_sap   	= tab_1.tabpage_1.dw_1.Object.nr_pedido_sap	[1]
is_de_chave_acesso 	= tab_1.tabpage_1.dw_1.Object.de_chave_acesso[1]

//tipo 2 - bloqueia o tipo 1
is_cd_fornecedor 	= tab_1.tabpage_1.dw_1.Object.cd_fornecedor[1]
idt_pedido 			= tab_1.tabpage_1.dw_1.Object.dt_pedido 		[1]

If il_tipo_filtro = 0 Then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe um dos par$$HEX1$$e200$$ENDHEX$$metros para pesquisa!', Information!)
	Return
	
ElseIf il_tipo_filtro = 1 Then
	If not IsNull (il_nr_pedido) or not IsNull (is_nr_pedido_sap) then
		is_pesquisa = 'PEDIDO'
	else
		If not IsNull (is_de_chave_acesso) then
			is_pesquisa = 'CHAVE'
		End if
	End if
	
	If is_pesquisa = 'PEDIDO' then
		If tab_1.tabpage_1.dw_co_situacao_pedido.Event ue_retrieve () > 0 then
			tab_1.tabpage_1.dw_co_situacao_remessa.Event ue_retrieve ()
			tab_1.tabpage_1.dw_co_situacao_produto.Event ue_retrieve ()
			tab_1.tabpage_1.dw_co_situacao_agendamento.Event ue_retrieve ()
		End if
	else
		If tab_1.tabpage_1.dw_co_situacao_remessa.Event ue_retrieve () > 0 then
			tab_1.tabpage_1.dw_co_situacao_pedido.Event ue_retrieve ()
			tab_1.tabpage_1.dw_co_situacao_produto.Event ue_retrieve ()
			tab_1.tabpage_1.dw_co_situacao_agendamento.Event ue_retrieve ()
		End if
	End if
	
ElseIf il_tipo_filtro = 2 Then
	If not isnull(is_cd_fornecedor) and trim(is_cd_fornecedor) <> "" Then
		If isnull(idt_pedido) Then 
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Data Pedido $$HEX1$$e900$$ENDHEX$$ Obrigat$$HEX1$$f300$$ENDHEX$$ria!', Information!)
			tab_1.tabpage_1.dw_1.Event ue_Pos(1,"dt_pedido")
			Return 
		End If
	Else
		If not isnull(idt_pedido) and (isnull(is_cd_fornecedor) OR trim(is_cd_fornecedor) = "" ) Then 
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Favor informar um Fornecedor!', Information!)
			tab_1.tabpage_1.dw_1.Event ue_Pos(1,"nm_fornecedor")
			Return 
		End If
	End If
	
	wf_exibir_esconder_dw_fornecedor('exibir')
	tab_1.tabpage_1.dw_4.Event ue_retrieve()
	
End If

Return
end event

public subroutine wf_co_esconde_agendamento ();Tab_1.TabPage_1.gb_co_detalhe_agendamento.Visible = False
Tab_1.TabPage_1.dw_co_detalhe_agendamento.Visible = False

Return
end subroutine

public subroutine wf_co_esconde_cabecalho ();Tab_1.TabPage_1.gb_co_situacao_pedido.Visible = False
Tab_1.TabPage_1.dw_co_situacao_pedido.Visible = False

Tab_1.TabPage_1.gb_co_situacao_remessa.Visible = False
Tab_1.TabPage_1.dw_co_situacao_remessa.Visible = False

Tab_1.TabPage_1.gb_co_situacao_produto.Visible = False
Tab_1.TabPage_1.dw_co_situacao_produto.Visible = False

Tab_1.TabPage_1.gb_co_situacao_agendamento.Visible = False
Tab_1.TabPage_1.dw_co_situacao_agendamento.Visible = False

Tab_1.TabPage_1.p_1.Visible = False
Tab_1.TabPage_1.p_2.Visible = False
Tab_1.TabPage_1.p_3.Visible = False

Return
end subroutine

public subroutine wf_co_esconde_pedido ();Tab_1.TabPage_1.gb_co_detalhe_pedido.Visible = False
Tab_1.TabPage_1.dw_co_detalhe_pedido.Visible = False

Return
end subroutine

public subroutine wf_co_esconde_produto ();Tab_1.TabPage_1.gb_co_detalhe_produto.Visible = False
Tab_1.TabPage_1.dw_co_detalhe_produto.Visible = False
Tab_1.TabPage_1.gb_co_detalhe_produto_por_situacao.Visible = False
Tab_1.TabPage_1.dw_co_detalhe_produto_por_situacao.Visible = False

Return
end subroutine

public subroutine wf_co_esconde_remessa ();Tab_1.TabPage_1.gb_co_detalhe_remessa.Visible = False
Tab_1.TabPage_1.dw_co_detalhe_remessa.Visible = False
Tab_1.TabPage_1.gb_co_erro_remessa.Visible    = False

wf_co_esconde_erro_remessa ()

Return
end subroutine

public subroutine wf_co_esconde_tudo ();wf_co_esconde_cabecalho ()
wf_co_esconde_pedido ()
wf_co_esconde_remessa ()
wf_co_esconde_agendamento ()
wf_co_esconde_produto ()

tab_1.tabpage_1.dw_co_situacao_pedido.Event ue_Reset()
tab_1.tabpage_1.dw_co_situacao_remessa.Event ue_Reset()
tab_1.tabpage_1.dw_co_situacao_produto.Event ue_Reset()
tab_1.tabpage_1.dw_co_situacao_agendamento.Event ue_Reset()

tab_1.tabpage_1.dw_co_detalhe_pedido.Event ue_Reset()
tab_1.tabpage_1.dw_co_detalhe_remessa.Event ue_Reset()
Tab_1.Tabpage_1.dw_co_erro_remessa.Event ue_Reset()
tab_1.tabpage_1.dw_co_detalhe_produto.Event ue_Reset()
tab_1.tabpage_1.dw_co_detalhe_produto_por_situacao.Event ue_Reset()
tab_1.tabpage_1.dw_co_detalhe_agendamento.Event ue_Reset()

Return
end subroutine

public subroutine wf_co_exibe_agendamento ();Tab_1.TabPage_1.gb_co_detalhe_agendamento.Visible = True
Tab_1.TabPage_1.dw_co_detalhe_agendamento.Visible = True

wf_co_esconde_pedido ()
wf_co_esconde_remessa ()
wf_co_esconde_produto ()

Return
end subroutine

public subroutine wf_co_exibe_pedido ();Tab_1.TabPage_1.gb_co_detalhe_pedido.Visible = True
Tab_1.TabPage_1.dw_co_detalhe_pedido.Visible = True

wf_co_esconde_remessa ()
wf_co_esconde_agendamento ()
wf_co_esconde_produto ()

Return
end subroutine

public subroutine wf_co_exibe_produto ();Tab_1.TabPage_1.gb_co_detalhe_produto.Visible = True
Tab_1.TabPage_1.dw_co_detalhe_produto.Visible = True
Tab_1.TabPage_1.gb_co_detalhe_produto_por_situacao.Visible = True
Tab_1.TabPage_1.dw_co_detalhe_produto_por_situacao.Visible = True

wf_co_esconde_pedido ()
wf_co_esconde_remessa ()
wf_co_esconde_agendamento ()

Return
end subroutine

public subroutine wf_co_exibe_remessa ();Tab_1.TabPage_1.gb_co_detalhe_remessa.Visible = True
Tab_1.TabPage_1.dw_co_detalhe_remessa.Visible = True

Tab_1.TabPage_1.gb_co_erro_remessa.Visible = True

wf_co_esconde_pedido ()
wf_co_esconde_agendamento ()
wf_co_esconde_produto ()

Return
end subroutine

public subroutine wf_co_exibe_situacao ();Tab_1.TabPage_1.gb_co_situacao_pedido.Visible      = True
Tab_1.TabPage_1.gb_co_situacao_remessa.Visible     = True
Tab_1.TabPage_1.gb_co_situacao_produto.Visible     = True
Tab_1.TabPage_1.gb_co_situacao_agendamento.Visible = True
Tab_1.TabPage_1.dw_co_situacao_pedido.Visible      = True
Tab_1.TabPage_1.dw_co_situacao_remessa.Visible     = True
Tab_1.TabPage_1.dw_co_situacao_produto.Visible     = True
Tab_1.TabPage_1.dw_co_situacao_agendamento.Visible = True
Tab_1.TabPage_1.p_1.Visible                        = True
Tab_1.TabPage_1.p_2.Visible                        = True
Tab_1.TabPage_1.p_3.Visible                        = True
end subroutine

public subroutine wf_co_exibe_situacao_pedido ();Tab_1.TabPage_1.gb_co_situacao_pedido.Visible = True
Tab_1.TabPage_1.dw_co_situacao_pedido.Visible = True
Tab_1.TabPage_1.p_1.Visible                   = True
end subroutine

public subroutine wf_co_exibe_situacao_remessa ();Tab_1.TabPage_1.gb_co_situacao_remessa.Visible = True
Tab_1.TabPage_1.dw_co_situacao_remessa.Visible = True
Tab_1.TabPage_1.p_2.Visible                    = True
end subroutine

public subroutine wf_co_exibe_situacao_agendamento ();Tab_1.TabPage_1.gb_co_situacao_agendamento.Visible = True
Tab_1.TabPage_1.dw_co_situacao_agendamento.Visible = True
end subroutine

public subroutine wf_co_exibe_erro_remessa ();Tab_1.TabPage_1.gb_co_erro_remessa.Visible = True
Tab_1.TabPage_1.dw_co_erro_remessa.Visible = True

Return
end subroutine

public subroutine wf_co_esconde_erro_remessa ();Tab_1.Tabpage_1.dw_co_erro_remessa.Visible = False

Return
end subroutine

public subroutine wf_co_exibe_situacao_produto ();Tab_1.TabPage_1.gb_co_situacao_produto.Visible = True
Tab_1.TabPage_1.dw_co_situacao_produto.Visible = True
Tab_1.TabPage_1.p_3.Visible                    = True
end subroutine

public subroutine _documentacao ();//	DW_2:
//		Este controle est$$HEX1$$e100$$ENDHEX$$ associado $$HEX1$$e000$$ENDHEX$$ mesma DW do DW_1 apenas para evitar que ocorra erro nas valida$$HEX2$$e700f500$$ENDHEX$$es da ancestral. Poderia ser qq DW.
//
// CORRESPOND$$HEX1$$ca00$$ENDHEX$$NCIA DE STATUS x CORES:
//
//		1. Pedido
//				PEDIDO CRIADO NO SAP			-	verde
//				PEDIDO N$$HEX1$$c300$$ENDHEX$$O CRIADO NO SAP	-	amarelo
//
//			1.1. Interface do pedido
//
//				P - IMPORTADO					-	verde
//				C - AGUARDANDO IMPORTACAO	-	amarelo
//				E - ERRO AO IMPORTAR			-	vermelho
//				D - CANCELADA IMPORTA$$HEX2$$c700c300$$ENDHEX$$O	-	vermelho
//				X - CANCELADA IMPORTA$$HEX2$$c700c300$$ENDHEX$$O	-	vermelho
//				  - INV$$HEX1$$c100$$ENDHEX$$LIDO					-	vermelho
//
//		2. NFs/Remessas
//				P - IMPORTADO					-	1	-	verde
//				C - AGUARDANDO IMPORTA$$HEX2$$c700c300$$ENDHEX$$O	-	2	-	amarelo
//				  - INV$$HEX1$$c100$$ENDHEX$$LIDO					-	3	-	vermelho
//				D - CANCELADA IMPORTA$$HEX2$$c700c300$$ENDHEX$$O	-	4	-	vermelho
//				X - CANCELADA IMPORTA$$HEX2$$c700c300$$ENDHEX$$O	-	4	-	vermelho
//				E - ERRO AO IMPORTAR			-	5	-	vermelho
//				  - SEM NOTAS FISCAIS		-	6	-	preto
//
//		3. Produtos
//				0 - PRODUTOS SEM DIVERG$$HEX1$$ca00$$ENDHEX$$NCIA	-	verde
//				1 - RECEBIDOS MAS N$$HEX1$$c300$$ENDHEX$$O PEDIDOS	-	amarelo
//				2 - QUANTIDADE DIVERGENTE		-	amarelo
//				3 - PEDIDOS MAS N$$HEX1$$c300$$ENDHEX$$O RECEBIDOS	-	vermelho
//
//		4. Agendamentos
//				0 - ENVIADO P/ SITE				-	verde
//				1 - LIBERADOS P/ AGENDAMENTO	-	azul escuro
//				2 - AGENDAMENTO CANCELADO		-	cinza
//				3 - ERRO AO ENVIAR NF P/ SITE	-	amarelo
//				4 - NOTAS NAO ENTREGUES NO CD	-	laranja
//				5 - RECUSADA						-	marrom
//				6 - DIVERGENTES					-	violeta
//				7 - CANCELADO SEFAZ				-	vermelho
//

end subroutine

public subroutine wf_bloqueia_desbloqueia_filtros (long al_tipo);String ls_Nulo

If al_tipo = 0 Then
	tab_1.tabpage_1.dw_1.Object.nm_fornecedor	[1] = ls_Nulo
	tab_1.tabpage_1.dw_1.Object.cd_fornecedor   [1] = ls_Nulo
	
	tab_1.tabpage_1.dw_1.object.nr_pedido.Protect = 0
	tab_1.tabpage_1.dw_1.object.nr_pedido.Background.Color = "16777215"
	tab_1.tabpage_1.dw_1.object.nr_pedido.Color = "0"
	
	tab_1.tabpage_1.dw_1.object.nr_pedido_sap.Protect = 0
	tab_1.tabpage_1.dw_1.object.nr_pedido_sap.Background.Color = "16777215"
	tab_1.tabpage_1.dw_1.object.nr_pedido_sap.Color = "0"
	
	tab_1.tabpage_1.dw_1.object.de_chave_acesso.Protect = 0
	tab_1.tabpage_1.dw_1.object.de_chave_acesso.Background.Color = "16777215"
	tab_1.tabpage_1.dw_1.object.de_chave_acesso.Color = "0"
	
	tab_1.tabpage_1.dw_1.object.cd_fornecedor.Protect = 0
	tab_1.tabpage_1.dw_1.object.cd_fornecedor.Background.Color = "16777215"
	tab_1.tabpage_1.dw_1.object.cd_fornecedor.Color = "0"
	
	tab_1.tabpage_1.dw_1.object.nm_fornecedor.Protect = 0
	tab_1.tabpage_1.dw_1.object.nm_fornecedor.Background.Color = "16777215"
	tab_1.tabpage_1.dw_1.object.nm_fornecedor.Color = "0"
	
	tab_1.tabpage_1.dw_1.object.dt_pedido.Protect = 0
	tab_1.tabpage_1.dw_1.object.dt_pedido.Background.Color = "16777215"
	tab_1.tabpage_1.dw_1.object.dt_pedido.Color = "0"
	
ElseIf al_tipo = 1 Then
	tab_1.tabpage_1.dw_1.object.cd_fornecedor.Protect = 1
	tab_1.tabpage_1.dw_1.object.cd_fornecedor.Background.Color = "134217750"
	tab_1.tabpage_1.dw_1.object.cd_fornecedor.Color = "134217750"
	
	tab_1.tabpage_1.dw_1.object.nm_fornecedor.Protect = 1
	tab_1.tabpage_1.dw_1.object.nm_fornecedor.Background.Color = "134217750"
	tab_1.tabpage_1.dw_1.object.nm_fornecedor.Color = "134217750"
	
	tab_1.tabpage_1.dw_1.object.dt_pedido.Protect = 1
	tab_1.tabpage_1.dw_1.object.dt_pedido.Background.Color = "134217750"
	tab_1.tabpage_1.dw_1.object.dt_pedido.Color = "134217750"

ElseIf al_tipo = 2 Then
	tab_1.tabpage_1.dw_1.object.nr_pedido.Protect = 1
	tab_1.tabpage_1.dw_1.object.nr_pedido.Background.Color = "134217750"
	tab_1.tabpage_1.dw_1.object.nr_pedido.Color = "134217750"
	
	tab_1.tabpage_1.dw_1.object.nr_pedido_sap.Protect = 1
	tab_1.tabpage_1.dw_1.object.nr_pedido_sap.Background.Color = "134217750"
	tab_1.tabpage_1.dw_1.object.nr_pedido_sap.Color = "134217750"
	
	tab_1.tabpage_1.dw_1.object.de_chave_acesso.Protect = 1
	tab_1.tabpage_1.dw_1.object.de_chave_acesso.Background.Color = "134217750"
	tab_1.tabpage_1.dw_1.object.de_chave_acesso.Color = "134217750"
End If

il_tipo_filtro = al_tipo

Return
end subroutine

public subroutine wf_exibir_esconder_dw_fornecedor (string as_tipo);If as_tipo = 'exibir' Then
	Tab_1.TabPage_1.gb_4.Visible = True
	Tab_1.TabPage_1.dw_4.Visible = True
Else
	Tab_1.TabPage_1.gb_4.Visible = False
	Tab_1.TabPage_1.dw_4.Visible = False
	ivm_Menu.mf_salvarcomo(False)
End If

Return
end subroutine

on w_ge604_monitor_integracao_sap.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge604_monitor_integracao_sap.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Event ue_AddRow ()
Tab_1.TabPage_1.dw_1.SetFocus ()

ivo_Fornecedor 	= Create uo_Fornecedor

wf_co_esconde_tudo ()

end event

event ue_preopen;call super::ue_preopen;This.ivl_Altura_1  = This.Height
This.ivl_Largura_1 = This.Width
end event

event open;call super::open;If IsValid( This ) Then
	Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
	Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
	Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)
	
	Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
	Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)
	Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(False)
End If
end event

event close;call super::close;Destroy(ivo_Fornecedor)
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge604_monitor_integracao_sap
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge604_monitor_integracao_sap
end type

type tab_1 from tab within w_ge604_monitor_integracao_sap
integer x = 14
integer y = 8
integer width = 7227
integer height = 2152
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		Tab_1.TabPage_1.dw_1.SetFocus()
	Case 2
		Tab_1.TabPage_2.dw_3.SetFocus()
End Choose
	
SetPointer(Arrow!)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 7191
integer height = 2036
long backcolor = 79741120
string text = "Compras"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_4 gb_4
p_3 p_3
gb_co_erro_remessa gb_co_erro_remessa
gb_co_detalhe_agendamento gb_co_detalhe_agendamento
dw_co_detalhe_produto dw_co_detalhe_produto
p_2 p_2
p_1 p_1
gb_co_detalhe_pedido gb_co_detalhe_pedido
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
gb_co_situacao_pedido gb_co_situacao_pedido
dw_co_situacao_pedido dw_co_situacao_pedido
gb_co_situacao_remessa gb_co_situacao_remessa
dw_co_situacao_remessa dw_co_situacao_remessa
gb_co_situacao_agendamento gb_co_situacao_agendamento
dw_co_situacao_agendamento dw_co_situacao_agendamento
gb_co_detalhe_remessa gb_co_detalhe_remessa
gb_co_detalhe_produto_por_situacao gb_co_detalhe_produto_por_situacao
dw_co_detalhe_agendamento dw_co_detalhe_agendamento
dw_co_detalhe_remessa dw_co_detalhe_remessa
dw_co_detalhe_pedido dw_co_detalhe_pedido
dw_co_erro_remessa dw_co_erro_remessa
dw_co_situacao_produto dw_co_situacao_produto
gb_co_situacao_produto gb_co_situacao_produto
gb_co_detalhe_produto gb_co_detalhe_produto
dw_co_detalhe_produto_por_situacao dw_co_detalhe_produto_por_situacao
dw_4 dw_4
end type

on tabpage_1.create
this.gb_4=create gb_4
this.p_3=create p_3
this.gb_co_erro_remessa=create gb_co_erro_remessa
this.gb_co_detalhe_agendamento=create gb_co_detalhe_agendamento
this.dw_co_detalhe_produto=create dw_co_detalhe_produto
this.p_2=create p_2
this.p_1=create p_1
this.gb_co_detalhe_pedido=create gb_co_detalhe_pedido
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.gb_co_situacao_pedido=create gb_co_situacao_pedido
this.dw_co_situacao_pedido=create dw_co_situacao_pedido
this.gb_co_situacao_remessa=create gb_co_situacao_remessa
this.dw_co_situacao_remessa=create dw_co_situacao_remessa
this.gb_co_situacao_agendamento=create gb_co_situacao_agendamento
this.dw_co_situacao_agendamento=create dw_co_situacao_agendamento
this.gb_co_detalhe_remessa=create gb_co_detalhe_remessa
this.gb_co_detalhe_produto_por_situacao=create gb_co_detalhe_produto_por_situacao
this.dw_co_detalhe_agendamento=create dw_co_detalhe_agendamento
this.dw_co_detalhe_remessa=create dw_co_detalhe_remessa
this.dw_co_detalhe_pedido=create dw_co_detalhe_pedido
this.dw_co_erro_remessa=create dw_co_erro_remessa
this.dw_co_situacao_produto=create dw_co_situacao_produto
this.gb_co_situacao_produto=create gb_co_situacao_produto
this.gb_co_detalhe_produto=create gb_co_detalhe_produto
this.dw_co_detalhe_produto_por_situacao=create dw_co_detalhe_produto_por_situacao
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.p_3,&
this.gb_co_erro_remessa,&
this.gb_co_detalhe_agendamento,&
this.dw_co_detalhe_produto,&
this.p_2,&
this.p_1,&
this.gb_co_detalhe_pedido,&
this.gb_1,&
this.dw_1,&
this.dw_2,&
this.gb_co_situacao_pedido,&
this.dw_co_situacao_pedido,&
this.gb_co_situacao_remessa,&
this.dw_co_situacao_remessa,&
this.gb_co_situacao_agendamento,&
this.dw_co_situacao_agendamento,&
this.gb_co_detalhe_remessa,&
this.gb_co_detalhe_produto_por_situacao,&
this.dw_co_detalhe_agendamento,&
this.dw_co_detalhe_remessa,&
this.dw_co_detalhe_pedido,&
this.dw_co_erro_remessa,&
this.dw_co_situacao_produto,&
this.gb_co_situacao_produto,&
this.gb_co_detalhe_produto,&
this.dw_co_detalhe_produto_por_situacao,&
this.dw_4}
end on

on tabpage_1.destroy
destroy(this.gb_4)
destroy(this.p_3)
destroy(this.gb_co_erro_remessa)
destroy(this.gb_co_detalhe_agendamento)
destroy(this.dw_co_detalhe_produto)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.gb_co_detalhe_pedido)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.gb_co_situacao_pedido)
destroy(this.dw_co_situacao_pedido)
destroy(this.gb_co_situacao_remessa)
destroy(this.dw_co_situacao_remessa)
destroy(this.gb_co_situacao_agendamento)
destroy(this.dw_co_situacao_agendamento)
destroy(this.gb_co_detalhe_remessa)
destroy(this.gb_co_detalhe_produto_por_situacao)
destroy(this.dw_co_detalhe_agendamento)
destroy(this.dw_co_detalhe_remessa)
destroy(this.dw_co_detalhe_pedido)
destroy(this.dw_co_erro_remessa)
destroy(this.dw_co_situacao_produto)
destroy(this.gb_co_situacao_produto)
destroy(this.gb_co_detalhe_produto)
destroy(this.dw_co_detalhe_produto_por_situacao)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage_1
boolean visible = false
integer x = 23
integer y = 260
integer width = 4411
integer height = 1760
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

type p_3 from picture within tabpage_1
boolean visible = false
integer x = 5312
integer y = 416
integer width = 178
integer height = 160
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\Arrow_Next.png"
boolean focusrectangle = false
end type

type gb_co_erro_remessa from groupbox within tabpage_1
boolean visible = false
integer x = 59
integer y = 1520
integer width = 7077
integer height = 480
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Erros no recebimento"
end type

type gb_co_detalhe_agendamento from groupbox within tabpage_1
boolean visible = false
integer x = 23
integer y = 780
integer width = 7145
integer height = 1248
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Agendamentos de entrega"
borderstyle borderstyle = styleraised!
end type

type dw_co_detalhe_produto from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 59
integer y = 852
integer width = 3351
integer height = 1168
integer taborder = 90
string dataobject = "dw_ge604_compras_produto"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()
end event

type p_2 from picture within tabpage_1
boolean visible = false
integer x = 3547
integer y = 416
integer width = 178
integer height = 160
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\Arrow_Next.png"
boolean focusrectangle = false
end type

type p_1 from picture within tabpage_1
boolean visible = false
integer x = 1829
integer y = 416
integer width = 178
integer height = 160
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\Arrow_Next.png"
boolean focusrectangle = false
end type

type gb_co_detalhe_pedido from groupbox within tabpage_1
boolean visible = false
integer x = 23
integer y = 780
integer width = 2446
integer height = 1248
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Interface com o SAP"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 23
integer y = 4
integer width = 7145
integer height = 244
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Par$$HEX1$$e200$$ENDHEX$$metros de Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 64
integer y = 60
integer width = 7058
integer height = 164
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge604_compras_selecao"
end type

event getfocus;call super::getfocus;dw_2.ivo_Controle_Menu.of_Atualiza()
end event

event ue_clearfilter;//override
dw_2.Event ue_ClearFilter()
end event

event ue_filter;//override
dw_2.Event ue_Filter()
end event

event ue_print;//override
end event

event ue_printimmediate;//override
end event

event ue_sort;//override
dw_2.Event ue_Sort()
end event

event itemchanged;call super::itemchanged;If dwo.name = "nm_fornecedor" Then
	If Trim(Data) <> "" Then
		If Data <> ivo_fornecedor.nm_Fantasia Then
			Return 1
		End If	
	Else			
		
		ivo_fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor		[1] = ivo_fornecedor.Cd_Fornecedor
		This.Object.Nm_Fornecedor		[1] = ivo_fornecedor.Nm_Fantasia			
	End If
End If

If (dwo.name = "nr_pedido" OR dwo.name = "nr_pedido_sap" OR dwo.name = "de_chave_acesso") Then
	If isnull(data) OR data = "" Then
		wf_bloqueia_desbloqueia_filtros(0)
	Else
		wf_bloqueia_desbloqueia_filtros(1)
	End If
End If

If (dwo.name = "nm_fornecedor" OR dwo.name = "cd_fornecedor" OR dwo.name = "dt_pedido") Then
	If isnull(data) OR data = "" Then
		wf_bloqueia_desbloqueia_filtros(0)
	Else
		wf_bloqueia_desbloqueia_filtros(2)
	End If
End If

If  tab_1.tabpage_1.dw_4.rowcount() > 0 Then tab_1.tabpage_1.dw_4.reset()
wf_co_esconde_tudo ()
wf_exibir_esconder_dw_fornecedor('esconder')

Return 0
end event

event editchanged;call super::editchanged;Long		ll_nulo
String	ls_nulo

SetNull (ll_nulo)
SetNull (ls_nulo)

If (dwo.name = "nr_pedido" OR dwo.name = "nr_pedido_sap" OR dwo.name = "de_chave_acesso") Then
	If isnull(data) OR data = "" Then
		wf_bloqueia_desbloqueia_filtros(0)
	Else
		wf_bloqueia_desbloqueia_filtros(1)
	End If
End If

If (dwo.name = "nm_fornecedor" OR dwo.name = "cd_fornecedor" OR dwo.name = "dt_pedido") Then
	If isnull(data) OR data = "" Then
		wf_bloqueia_desbloqueia_filtros(0)
	Else
		wf_bloqueia_desbloqueia_filtros(2)
	End If
End If

wf_co_esconde_tudo ()
wf_exibir_esconder_dw_fornecedor('esconder')

If  tab_1.tabpage_1.dw_4.rowcount() > 0 Then tab_1.tabpage_1.dw_4.reset()

Choose case dwo.Name
	case 'nr_pedido'
		If isnull(data) OR data = "" Then this.Object.nr_pedido       [1] = ll_nulo
		this.Object.nr_pedido_sap   [1] = ls_nulo
		this.Object.de_chave_acesso [1] = ls_nulo
	case 'nr_pedido_sap'
		If isnull(data) OR data = "" Then this.Object.nr_pedido_sap   [1] = ls_nulo
		this.Object.nr_pedido       [1] = ll_nulo
		this.Object.de_chave_acesso [1] = ls_nulo
	case 'de_chave_acesso'
		If isnull(data) OR data = "" Then this.Object.de_chave_acesso [1] = ls_nulo
		this.Object.nr_pedido       [1] = ll_nulo
		this.Object.nr_pedido_sap   [1] = ls_nulo
End choose

Return 0
end event

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fornecedor" Then
		
		ivo_fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_fornecedor.Localizado Then
			This.Object.Cd_fornecedor	[1] = ivo_fornecedor.Cd_Fornecedor
			This.Object.Nm_fornecedor	[1] = ivo_fornecedor.Nm_Fantasia
			wf_bloqueia_desbloqueia_filtros(2)
		End If
	End If
End If

end event

type dw_2 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 5669
integer y = 36
integer width = 123
integer height = 148
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_ge604_compras_selecao"
end type

event constructor;call super::constructor;
This.of_SetRowSelection()
This.of_SetSort()
This.of_SetFilter()
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True

	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Classificar)
This.ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)
This.ivo_Controle_Menu.of_Localizar(lvb_Localizar)
This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type gb_co_situacao_pedido from groupbox within tabpage_1
boolean visible = false
integer x = 23
integer y = 252
integer width = 1774
integer height = 492
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_co_situacao_pedido from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 32
integer y = 284
integer width = 1737
integer height = 452
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge604_compras_situacao_pedido"
end type

event buttonclicked;call super::buttonclicked;If dwo.name = 'b_co_detalhe_pedido' then
	wf_co_exibe_pedido ()
End if
end event

event ue_preretrieve;call super::ue_preretrieve;If not IsNull (il_nr_pedido) then
	is_where = 'pc.nr_pedido = ' + String (il_nr_pedido)
else
	If not IsNull (is_nr_pedido_sap) then
		is_where = "isap.de_chave_sap = '" + is_nr_pedido_sap + "'"
	End if
End if

This.of_appendwhere (is_where, 1)
This.ShareData (Parent.dw_co_detalhe_pedido)

Return 1
end event

event ue_recuperar;call super::ue_recuperar;Long	ll_linhas

ll_linhas = AncestorReturnValue

Choose case ll_linhas
	case is < 0
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'Erro na obten$$HEX2$$e700e300$$ENDHEX$$o dos dados!', Exclamation!)
	case 0
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada!', Exclamation!)
	case is > 0
		wf_co_exibe_situacao_pedido ()
End choose

Return ll_linhas
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 then
	If IsNull (il_nr_pedido) then
		il_nr_pedido = this.Object.nr_pedido [1]
	End if
	
	If IsNull (is_nr_pedido_sap) then
		is_nr_pedido_sap = this.Object.de_chave_sap [1]
	End if
End if

Return pl_linhas
end event

type gb_co_situacao_remessa from groupbox within tabpage_1
boolean visible = false
integer x = 2039
integer y = 252
integer width = 1477
integer height = 492
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_co_situacao_remessa from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 2048
integer y = 284
integer width = 1458
integer height = 452
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge604_compras_situacao_remessa"
boolean maxbox = true
end type

event ue_recuperar;call super::ue_recuperar;If AncestorReturnValue > 0 then
	If This.RowsCopy (1, AncestorReturnValue, Primary!, Parent.dw_co_detalhe_remessa, 1, Primary!) < 1 then
		Return -1
	End if
End if

Return AncestorReturnValue
end event

event buttonclicked;call super::buttonclicked;String	ls_situacao, &
			ls_filtro

Parent.dw_co_detalhe_remessa.SetFilter ('')
Parent.dw_co_detalhe_remessa.Filter ()

ls_situacao = String (this.object.de_situacao[row])
ls_filtro = "de_situacao = '" + ls_situacao + "'"

Parent.dw_co_detalhe_remessa.SetFilter (ls_filtro)
Parent.dw_co_detalhe_remessa.Filter ()
Parent.dw_co_detalhe_remessa.Sort ()

Parent.gb_co_detalhe_remessa.Text = 'Detalhes das remessas com status "' + ls_situacao + '"'

wf_co_exibe_remessa ()

Parent.dw_co_detalhe_remessa.Event RowFocuschanged (1)
end event

event ue_preretrieve;call super::ue_preretrieve;If is_pesquisa = 'CHAVE' then
	is_where = "isap.de_chave_sap = '" + is_de_chave_acesso + "'"
else
	is_where = 'rs.nr_pedido = ' + String (il_nr_pedido)
End if

This.of_appendwhere (is_where, 1)

Return 1
end event

event ue_postretrieve;call super::ue_postretrieve;Choose case This.RowCount ()
	case is > 0
		il_nr_pedido     = This.Object.nr_pedido     [1]
		is_nr_pedido_sap = This.Object.nr_pedido_sap [1]
		This.Object.cf_qtd_por_situacao.Visible = True
		This.Object.b_detalhe_remessa.Visible   = True
		wf_co_exibe_situacao_remessa ()
	case 0
		This.InsertRow (0)
		This.Object.de_situacao [1] = 'SEM NOTAS FISCAIS'
		This.Object.cf_qtd_por_situacao.Visible = False
		This.Object.b_detalhe_remessa.Visible   = False
		This.GroupCalc ()
		wf_co_exibe_situacao_remessa ()
End choose

Return pl_linhas
end event

event ue_retrieve;//evento em override

Long lvl_Linhas

lvl_Linhas = This.Event ue_PreRetrieve()

lvl_Linhas = This.Event ue_Recuperar()
	
lvl_Linhas = This.Event ue_PostRetrieve(lvl_Linhas)

Return lvl_Linhas
end event

type gb_co_situacao_agendamento from groupbox within tabpage_1
boolean visible = false
integer x = 5531
integer y = 252
integer width = 1637
integer height = 492
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_co_situacao_agendamento from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 5541
integer y = 284
integer width = 1618
integer height = 452
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge604_compras_situacao_agendamento"
end type

event buttonclicked;call super::buttonclicked;String	ls_situacao, &
			ls_filtro

Parent.dw_co_detalhe_agendamento.SetFilter ('')
Parent.dw_co_detalhe_agendamento.Filter ()

ls_situacao = this.object.de_situacao[row]
ls_filtro = "de_situacao = '" + ls_situacao + "'"

Parent.dw_co_detalhe_agendamento.SetFilter (ls_filtro)
Parent.dw_co_detalhe_agendamento.Filter ()
Parent.dw_co_detalhe_agendamento.Sort ()

Parent.gb_co_detalhe_agendamento.Text = 'Agendamentos de entrega com status "' + Mid (ls_situacao, 3) + '"'

wf_co_exibe_agendamento ()
end event

event ue_preretrieve;call super::ue_preretrieve;String	ls_SQL

If is_pesquisa = 'CHAVE' then
	is_where = "AG.de_chave_acesso = '" + is_de_chave_acesso + "'"
else
	is_where = 'AG.nr_pedido_central = ' + String (il_nr_pedido)
End if

ls_SQL  = This.Object.DataWindow.Table.Select
ls_SQL += " WHERE " + is_Where
This.of_changesql (ls_SQL)

Return 1
end event

event ue_recuperar;call super::ue_recuperar;If AncestorReturnValue > 0 then
	If This.RowsCopy (1, AncestorReturnValue, Primary!, Parent.dw_co_detalhe_agendamento, 1, Primary!) < 1 then
		Return -1
	End if
End if

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;Integer	li_lin

Choose case This.RowCount ()
	case is > 0
		This.Object.cf_qtd_por_situacao.Visible   = True
		This.Object.b_detalhe_agendamento.Visible = True
		wf_co_exibe_situacao_agendamento ()
	case 0
		This.InsertRow (0)
		This.Object.de_situacao [1] = '8-SEM AGENDAMENTOS'
		This.Object.cf_qtd_por_situacao.Visible   = False
		This.Object.b_detalhe_agendamento.Visible = False
		This.GroupCalc ()
		wf_co_exibe_situacao_agendamento ()
End choose

Return pl_linhas
end event

type gb_co_detalhe_remessa from groupbox within tabpage_1
boolean visible = false
integer x = 23
integer y = 780
integer width = 7145
integer height = 1248
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes das remessas"
borderstyle borderstyle = styleraised!
end type

type gb_co_detalhe_produto_por_situacao from groupbox within tabpage_1
boolean visible = false
integer x = 3511
integer y = 780
integer width = 3657
integer height = 1248
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos com situa$$HEX2$$e700e300$$ENDHEX$$o "
borderstyle borderstyle = styleraised!
end type

type dw_co_detalhe_agendamento from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 59
integer y = 852
integer width = 7067
integer height = 1164
integer taborder = 60
string dataobject = "dw_ge604_compras_detalhes_agendamento"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()
end event

type dw_co_detalhe_remessa from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 59
integer y = 852
integer width = 7067
integer height = 648
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge604_compras_detalhes_remessa"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()
end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_linhas
String	ls_nr_recebimento

If currentrow > 0 then
	wf_co_esconde_erro_remessa ()
	Parent.gb_co_erro_remessa.Text = is_titulo_erro_remessa
	
	ls_nr_recebimento = This.Object.nr_recebimento [currentrow]
	
	ll_linhas = Tab_1.Tabpage_1.dw_co_erro_remessa.Retrieve (ls_nr_recebimento)
	
	Choose case ll_linhas
		case is < 0
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na leitura dos erros de importa$$HEX2$$e700e300$$ENDHEX$$o do recebimento ' + ls_nr_recebimento + '. SQLErrText: ' + SQLCA.SQLErrText, Exclamation!)
		case is > 0
			Parent.gb_co_erro_remessa.Text += ls_nr_recebimento
			wf_co_exibe_erro_remessa ()
	End choose
End if
end event

type dw_co_detalhe_pedido from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 59
integer y = 852
integer width = 2400
integer height = 1168
integer taborder = 80
string dataobject = "dw_ge604_compras_detalhes_pedido"
end type

type dw_co_erro_remessa from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 73
integer y = 1576
integer width = 7013
integer height = 400
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_ge604_compras_erros_remessa"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()
end event

type dw_co_situacao_produto from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 3776
integer y = 284
integer width = 1458
integer height = 452
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge604_compras_situacao_produto"
end type

event buttonclicked;call super::buttonclicked;String	ls_situacao, &
			ls_filtro

Parent.dw_co_detalhe_produto_por_situacao.SetFilter ('')
Parent.dw_co_detalhe_produto_por_situacao.Filter ()

ls_situacao = MId (this.object.de_gravidade[row], 3)
ls_filtro = "situacao = '" + ls_situacao + "'"

Parent.dw_co_detalhe_produto_por_situacao.SetFilter (ls_filtro)
Parent.dw_co_detalhe_produto_por_situacao.Filter ()
Parent.dw_co_detalhe_produto_por_situacao.Sort ()

Parent.gb_co_detalhe_produto_por_situacao.Text = 'Produtos com situa$$HEX2$$e700e300$$ENDHEX$$o "' + ls_situacao + '"'

wf_co_exibe_produto ()
end event

event ue_recuperar;//evento em override

Long	ll_produtos

ll_produtos = This.Retrieve (il_nr_pedido)

Choose case ll_produtos
	case is < 0
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na leitura da situa$$HEX2$$e700e300$$ENDHEX$$o dos produtos do pedido: ' + SQLCA.SQLErrText, Exclamation!)
	case 0
		This.InsertRow (0)
		This.Object.de_gravidade [1] = '4-SEM PRODUTOS'
		This.Object.cf_qtd_por_situacao.Visible = False
		This.Object.b_detalhe_produto.Visible   = False
		This.GroupCalc ()
		wf_co_exibe_situacao_produto ()

	case is > 0
		If This.RowsCopy (1, ll_produtos, Primary!, Parent.dw_co_detalhe_produto_por_situacao, 1, Primary!) < 1 then
			Return -1
		End if
		ll_produtos = Tab_1.TabPage_1.dw_co_detalhe_produto.Retrieve (il_nr_pedido)
		Choose case ll_produtos
			case is < 0
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na leitura dos produtos do pedido: ' + SQLCA.SQLErrText, Exclamation!)
			case 0
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foram encontrados produtos para este pedido!', Information!)
			case is > 0
				This.Object.cf_qtd_por_situacao.Visible = True
				This.Object.b_detalhe_produto.Visible   = True
				wf_co_exibe_situacao_produto ()
		End choose
End choose

return ll_produtos
end event

type gb_co_situacao_produto from groupbox within tabpage_1
boolean visible = false
integer x = 3767
integer y = 252
integer width = 1504
integer height = 492
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_co_detalhe_produto from groupbox within tabpage_1
boolean visible = false
integer x = 23
integer y = 780
integer width = 3433
integer height = 1248
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos do pedido"
borderstyle borderstyle = styleraised!
end type

type dw_co_detalhe_produto_por_situacao from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 3547
integer y = 852
integer width = 3593
integer height = 1168
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_ge604_compras_produto_por_situacao"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()
end event

type dw_4 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 55
integer y = 316
integer width = 4375
integer height = 1696
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge604_situacao_pedido_fornecedor"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event buttonclicked;call super::buttonclicked;String ls_Parametro, ls_pedido, ls_pedido_sap //, ls_situacao

ls_pedido = string(tab_1.tabpage_1.dw_4.Object.nr_pedido[row])
ls_pedido_sap = string(tab_1.tabpage_1.dw_4.Object.nr_pedido_sap[row])
//ls_situacao = string(tab_1.tabpage_1.dw_4.Object.nr_pedido_sap[row])

If IsNull(ls_pedido) Then ls_pedido = ''
If IsNull(ls_pedido_sap) Then ls_pedido_sap = ''

ls_parametro = ';' + ls_pedido + ';' + ls_pedido_sap

Choose Case dwo.name
	Case 'b_pedido'
		Openwithparm(w_ge604_response_detalhes_pedido, ls_parametro)
	Case 'b_nf'
		Openwithparm(w_ge604_response_detalhes_remessa, ls_parametro)
	Case 'b_produtos'
		Openwithparm(w_ge604_response_detalhes_produtos, ls_parametro)
	Case 'b_agendamento'
		Openwithparm(w_ge604_response_detalhes_agendamento, ls_parametro)
End Choose

end event

event ue_recuperar;Long ll_linhas 

Open(w_aguarde)

Try
	w_aguarde.Title = 'Recuperando Dados...'
	
	ll_linhas = this.retrieve(is_cd_fornecedor, idt_pedido) 
	
	w_Aguarde.uo_Progress.of_SetMax(ll_linhas)
	
CATCH (runtimeerror er)   
   MessageBox("Runtime Error", er.GetMessage())
End Try

return ll_linhas
end event

event ue_postretrieve;call super::ue_postretrieve;Long ll_Linha, ll_Pedido, ll_Qtde, ll_Row
String ls_situacao_nf, ls_gravidade_agendamento, ls_gravidade_produtos

dc_uo_ds_base lvds
lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge604_situacao_age_nf_prod") Then 
	Destroy(lvds)
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao carregar DS.')
	Return -1
End If

If IsValid(w_aguarde) Then w_aguarde.Title = 'Obtendo Detalhes...'

If pl_linhas > 0 Then
	For ll_linha = 1 To pl_linhas
		w_aguarde.uo_progress.Of_SetProgress(ll_linha)
		
		w_aguarde.Title = 'Obtendo Detalhes... ' + string(ll_linha) + ' de ' + string(pl_linhas)
		
		ll_Pedido = This.Object.nr_pedido[ll_linha]
		
		If lvds.Retrieve(ll_Pedido) = -1 Then
			Destroy(lvds)
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao obter dados da DS.')
			Return -1
		End If
		
		ll_Qtde = lvds.RowCount()
		
		For ll_Row = 1 To ll_Qtde
			ls_situacao_nf					= lvds.object.de_situacao_nf					[ll_Row]
			ls_gravidade_agendamento = lvds.object.de_gravidade_agendamento	[ll_Row]
			ls_gravidade_produtos 		= lvds.object.de_gravidade_produtos			[ll_Row]
			
			If Isnull(ls_situacao_nf) Then ls_situacao_nf 									= 'SEM NOTAS FISCAIS'
			If Isnull(ls_gravidade_agendamento) Then ls_gravidade_agendamento 	= '8-SEM INFORMA$$HEX2$$c700d500$$ENDHEX$$ES'
			If Isnull(ls_gravidade_produtos) Then ls_gravidade_produtos 				= '1-RECEBIDOS MAS N$$HEX1$$c300$$ENDHEX$$O PEDIDOS'
			
			this.object.de_gravidade_produtos			[ll_linha] = ls_gravidade_produtos
			this.object.de_gravidade_agendamento	[ll_linha] = ls_gravidade_agendamento
			this.object.de_situacao_nf					[ll_linha]	= ls_situacao_nf
		Next		
		
	Next
End If

Close(w_aguarde)

If pl_Linhas > 0 Then	
	ivm_Menu.mf_salvarcomo(True)
	This.SetRow(1)
	This.SetFocus()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o encontrada.", Information!)
End If

Return pl_linhas
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 7191
integer height = 2036
boolean enabled = false
long backcolor = 79741120
string text = "Log$$HEX1$$ed00$$ENDHEX$$stica"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_3 gb_3
dw_3 dw_3
end type

on tabpage_2.create
this.gb_3=create gb_3
this.dw_3=create dw_3
this.Control[]={this.gb_3,&
this.dw_3}
end on

on tabpage_2.destroy
destroy(this.gb_3)
destroy(this.dw_3)
end on

type gb_3 from groupbox within tabpage_2
integer x = 23
integer y = 12
integer width = 2446
integer height = 1288
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 59
integer y = 76
integer width = 2363
integer height = 1192
integer taborder = 30
boolean bringtotop = true
end type

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True

	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Classificar)
This.ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)
This.ivo_Controle_Menu.of_Localizar(lvb_Localizar)
This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

