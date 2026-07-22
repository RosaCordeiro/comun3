HA$PBExportHeader$w_ge041_consulta_nf_venda.srw
forward
global type w_ge041_consulta_nf_venda from dc_w_sheet
end type
type cb_manip_de_para from commandbutton within w_ge041_consulta_nf_venda
end type
type tab_1 from tab within w_ge041_consulta_nf_venda
end type
type tabpage_1 from userobject within tab_1
end type
type cb_imprimir from commandbutton within tabpage_1
end type
type cb_pedido_cliente from commandbutton within tabpage_1
end type
type dw_conexao from dc_uo_dw_base within tabpage_1
end type
type cb_anexa_licitacao from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type cb_reemitir from commandbutton within tabpage_1
end type
type cb_cancelar from commandbutton within tabpage_1
end type
type dw_5 from datawindow within tabpage_1
end type
type dw_6 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_imprimir cb_imprimir
cb_pedido_cliente cb_pedido_cliente
dw_conexao dw_conexao
cb_anexa_licitacao cb_anexa_licitacao
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
dw_1 dw_1
dw_2 dw_2
cb_reemitir cb_reemitir
cb_cancelar cb_cancelar
dw_5 dw_5
dw_6 dw_6
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
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_4 dw_4
end type
type tab_1 from tab within w_ge041_consulta_nf_venda
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_ge041_consulta_nf_venda from dc_w_sheet
string accessiblename = "Consulta de Notas Fiscais de Venda (GE041)"
integer width = 3543
integer height = 1908
string title = "GE041 - Consulta de Notas Fiscais de Venda"
long backcolor = 80269524
event ue_retrieve ( )
cb_manip_de_para cb_manip_de_para
tab_1 tab_1
end type
global w_ge041_consulta_nf_venda w_ge041_consulta_nf_venda

type variables
uo_filial               	iuo_filial
uo_convenio      	ivo_convenio
uo_conveniado  	ivo_conveniado
uo_cliente          	ivo_cliente
uo_filial               	ivo_filial
dc_uo_transacao 	itr_Filial
dc_uo_odbc			ivo_Odbc
uo_Produto			io_Produto

dc_uo_dw_base dw_2
dc_uo_dw_base dw_4

Date ivdt_parametro

long	ivl_altura_1	, &
		ivl_altura_2	, &
		ivl_altura_3	, &
		ivl_largura_1, &
		ivl_largura_2, &
		ivl_largura_3, &
		ivl_Filial_Odbc
end variables

forward prototypes
public function boolean wf_verifica_dependente (long al_filial, long al_nota, string as_especie, string as_serie, ref integer ai_dependente, ref string as_dependente)
public function boolean wf_verifica_caixa_aberto (string a_caixa, integer a_nr_controle)
public function boolean wf_especie_nf_parametro (ref string as_especie, string as_filial_matriz)
public function boolean wf_emitir_nota_anexa ()
public function boolean wf_vincula_venda_licitacao ()
public subroutine wf_apresentacao_venda_manipulado ()
public function boolean wf_cancelada_sefaz (string as_chave)
public function boolean wf_caixa_conferido (string as_caixa, long al_controle)
public function boolean wf_qtd_volume (long al_nr_nf, string as_de_especie, string as_de_serie, ref long al_qtd_volume)
public subroutine _documentacao ()
end prototypes

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

public function boolean wf_verifica_dependente (long al_filial, long al_nota, string as_especie, string as_serie, ref integer ai_dependente, ref string as_dependente);Boolean lvb_Sucesso = True

Long lvl_Convenio

String lvs_Nulo,      &
		 lvs_Conveniado 

Integer lvi_Nulo

Select cd_dependente_conveniado, cd_convenio, cd_conveniado
Into :ai_dependente, :lvl_Convenio, :lvs_Conveniado
From nf_venda
Where cd_filial  =:al_filial
  and nr_nf      =:al_nota
  and de_especie =:as_especie
  and de_serie   =:as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do dependente do conveniado na nota fiscal")
	Return False
End If

If SqlCa.SqlCode = 0 Then
	
	If Not IsNull(ai_dependente) Then
		
		Select nm_dependente
		Into :as_dependente
		From dependente_conveniado
		Where cd_convenio   =:lvl_Convenio
		  and cd_conveniado =:lvs_Conveniado
		  and cd_dependente =:ai_dependente
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do dependente do conveniado")
			Return False
		End If
	End If
End If
 
Return True
end function

public function boolean wf_verifica_caixa_aberto (string a_caixa, integer a_nr_controle);LONG	ll_aux

SELECT count(*)
INTO	 :ll_aux
FROM 	 controle_caixa  
WHERE  ( controle_caixa.cd_caixa				  = :a_caixa 		 ) AND  
		 ( controle_caixa.nr_controle_caixa   = :a_nr_controle ) AND  
		 ( controle_caixa.dh_fechamento_caixa is null 			 )
USING	 SQLCA;

IF SQLCA.SQLCode = -1 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro : " + SQLCA.SQLErrText)
	RETURN FALSE
END IF

IF ISNULL(ll_aux) THEN ll_aux = 0 

IF ll_aux = 0 THEN RETURN FALSE

RETURN TRUE
end function

public function boolean wf_especie_nf_parametro (ref string as_especie, string as_filial_matriz);If as_filial_matriz = "F" Then
	Select de_especie_nf
	Into :as_especie
	From parametro
	Where id_parametro = '1'
	Using SqlCa;
Else
	Select vl_parametro
	Into :as_especie
	From parametro_geral
	Where cd_parametro = 'DE_ESPECIE_NF'
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', "A esp$$HEX1$$e900$$ENDHEX$$cie da nota fiscal n$$HEX1$$e300$$ENDHEX$$o foi encontrada no par$$HEX1$$e200$$ENDHEX$$metro.", Exclamation!)
		Return False
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da esp$$HEX1$$e900$$ENDHEX$$cie da nota fiscal no par$$HEX1$$e200$$ENDHEX$$metro")
		Return False
End Choose

Return True
		
end function

public function boolean wf_emitir_nota_anexa ();Long ll_Filial
Long ll_Cupom
Long ll_row
Long ll_Produto_Manip

Integer li_manip

String	ls_Especie_CF
String	ls_Serie_CF
String	ls_Especie_NF
String	ls_Serie_NF
String ls_Especie_aux
String ls_Serie_aux
String ls_Retorno_Manip
String ls_Responsavel

If Not gf_NFe_Liberada() Then Return False

Tab_1.TabPage_1.dw_1.AcceptText()
dw_2.AcceptText()

ll_Cupom 	= Tab_1.TabPage_1.dw_1.Object.Nr_Nf		[1]
ll_Filial	 	= Tab_1.TabPage_1.dw_1.Object.Cd_Filial	[1]

If IsNull( ll_Cupom ) Or ll_Cupom = 0 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o n$$HEX1$$fa00$$ENDHEX$$mero do cupom fiscal no filtro de sele$$HEX2$$e700e300$$ENDHEX$$o para poder emitir na Nota Fiscal Anexa.", StopSign! )
	Return False
End If

ll_row = dw_2.GetRow()

If ll_row <> 1 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Recupere as informa$$HEX2$$e700f500$$ENDHEX$$es para poder emitir na Nota Fiscal Anexa.", StopSign! )
	Return False
End If

ls_Especie_aux =  dw_2.Object.de_especie	[ll_row]
ls_Serie_aux	=  dw_2.Object.de_serie		[ll_row]

If ls_Especie_aux = 'NFE' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido a emiss$$HEX1$$e300$$ENDHEX$$o de Nota Fiscal Anexa para a Esp$$HEX1$$e900$$ENDHEX$$cie: " + ls_Especie_aux + ".", StopSign!)
	Return False
End If

If ls_Especie_aux = 'NFC' And gvo_parametro.ivs_uf_filial = 'SC' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido a emiss$$HEX1$$e300$$ENDHEX$$o de Nota Fiscal Anexa para a Esp$$HEX1$$e900$$ENDHEX$$cie: " + ls_Especie_aux + ".", StopSign!)
	Return False
End If

ll_Cupom = dw_2.Object.Nr_Nf [ ll_row ]

If MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma a emiss$$HEX1$$e300$$ENDHEX$$o da Nota Fiscal Anexa para o Cupom Fiscal ' + String( ll_Cupom ) + '?', Question!, YesNo!, 2 ) = 2 Then
	Return False
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "W_GE041_CONSULTA_NF_VENDA_ANEXA", Ref ls_Responsavel ) Then 
	Return False
End If

Select	 de_especie_cf, 
		de_serie_cf,
		de_especie_nf,
		de_serie_nf
   Into	:ls_especie_cf,
		:ls_serie_cf,
		:ls_especie_nf,
		:ls_serie_nf
From	parametro
Where id_parametro = '1';

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError( "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o dos param$$HEX1$$ea00$$ENDHEX$$tros ( de_especie_cf, de_serie_cf, de_especie_nf, de_serie_nf ) na tabela par$$HEX1$$e200$$ENDHEX$$metro." )
		Return False
		
	Case 100
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Param$$HEX1$$ea00$$ENDHEX$$tros ( de_especie_cf, de_serie_cf, de_especie_nf, de_serie_nf) n$$HEX1$$e300$$ENDHEX$$o localizado na tabela par$$HEX1$$e200$$ENDHEX$$metro.", StopSign! )
		Return False
End Choose

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'RL' Then
	
	ll_Produto_Manip = io_Produto.cd_produto_manipulado
	
	If Not IsNull( ivo_Filial.cd_filial_fcerta ) Then
		select count(*) into :li_manip 
		from item_nf_venda i
		where i.cd_filial 			= :ll_Filial
				and i.nr_nf 			= :ll_Cupom
				and i.de_especie	= :ls_Especie_aux
				and i.de_serie		= :ls_Serie_aux
				and i.cd_produto	= :ll_Produto_Manip
				and not exists(   select * from nf_venda n 
									 where n.cd_filial 	  			= i.cd_filial
										and n.nr_nf_anexa	  		= i.nr_nf
										and n.de_especie_anexa = i.de_especie
										and n.de_serie_anexa	= i.de_serie )
		Using SqlCa;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError( "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o produto manipulado." )
			Return False
		End If
		
		//Insere a descricao das formulas dos produtos manipulados.
		If li_manip > 0 Then
			Try
				uo_ge041_nf_manip lo
				lo = Create uo_ge041_nf_manip
				
				lo.Filial	 	= ll_Filial
				lo.NF			= ll_Cupom
				lo.Especie 	= ls_Especie_aux
				lo.Serie		= ls_Serie_aux
				
				OpenWithParm( w_ge041_lancamento_manipulado,  lo)
				
				ls_Retorno_Manip = Message.StringParm
				
				If IsNull( ls_Retorno_Manip ) Then
					Return False
				End If
				
			Finally
				If IsValid(lo) Then Destroy lo
			End Try
		End If	
	End If
End If

uo_Nota_Fiscal lo_Nota_Fiscal
lo_Nota_Fiscal = Create uo_Nota_Fiscal

lo_Nota_Fiscal.of_Emitir_Nf_Anexa( ll_Filial, ll_Cupom, ls_Especie_Aux, ls_Serie_Aux, ls_Especie_Nf, ls_Serie_Nf, ls_Responsavel )

If IsValid( lo_Nota_Fiscal ) Then Destroy lo_Nota_Fiscal

Return True
end function

public function boolean wf_vincula_venda_licitacao ();Boolean lb_Sucesso = True 

Long ll_Row

Long ll_Nota
Long ll_Filial

String ls_Especie
String ls_Serie
String ls_Matricula_Licitacao

DateTime ldh_Cancelamento

Decimal ldc_Valor

ll_Row = dw_2.GetRow()

If ll_Row = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma nota fiscal.")
	Return False
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE041_LIBERAR_VENDA_LICITACAO", ref ls_Matricula_Licitacao) Then 
	Return False
End If

ll_Filial 					= dw_2.Object.cd_filial				[ll_Row]
ll_Nota 					= dw_2.Object.nr_nf					[ll_Row]
ls_Especie 				= dw_2.Object.de_especie			[ll_Row]
ls_Serie 					= dw_2.Object.de_serie				[ll_Row]
ldh_Cancelamento 	= dw_2.Object.dh_cancelamento	[ll_Row]
ldc_Valor					= dw_2.Object.vl_total_nf			[ll_Row]

If ls_Especie <> "CF" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Notas fiscais ANEXAS n$$HEX1$$e300$$ENDHEX$$o podem ser selecionadas.")
	Return False
End If

If Not IsNull( ldh_Cancelamento ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A nota "+ String( ll_Nota ) + " est$$HEX1$$e100$$ENDHEX$$ cancelada e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterada.")
	Return False
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja relacionar a nota fiscal " +  String( ll_Nota ) + " no valor " + String(ldc_Valor) + &
								 "~rcomo sendo uma nota de licita$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 2 Then
	Return False				
End If

Update nf_venda
	Set id_licitacao 	= 'S',
		 nr_matricula_licitacao = :ls_Matricula_Licitacao,
		 dh_licitacao		= getdate()
Where nr_nf 			= :ll_Nota
	and cd_filial 		= :ll_Filial
	and de_especie	 	= :ls_Especie
	and de_serie		= :ls_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	SqlCa.of_MsgDbError("Erro no update do parametro 'id_licitacao' na tabela nf_venda.")
	lb_Sucesso = False
End If

If lb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nota fiscal " + String( ll_Nota ) + " foi atualizada com sucesso.")
End If
end function

public subroutine wf_apresentacao_venda_manipulado ();/* Autor: Fernando Lu$$HEX1$$ed00$$ENDHEX$$s Cambiaghi
 * Data: 24/09/2015
 * Fun$$HEX2$$e700e300$$ENDHEX$$o para preencher na apresenta$$HEX2$$e700e300$$ENDHEX$$o de venda, quando for produto Manipulado,
 * o c$$HEX1$$f300$$ENDHEX$$digo da filial produtora do FormulaCerta e o n$$HEX1$$fa00$$ENDHEX$$mero da requisi$$HEX2$$e700e300$$ENDHEX$$o */

Long ll_Linha
Long ll_Linhas
Long ll_Produto
Long ll_Filial_FCerta
Long ll_Requisicao
Long ll_Filial

String ls_Apresentacao_Venda
String ls_integraFC
String ls_Modo_Venda_Manip

uo_Parametro_Filial lo_Parametro
lo_Parametro = Create uo_Parametro_Filial
lo_Parametro.of_Localiza_Parametro("ID_PERMITE_INTEGRACAO_FCERTA", ref ls_integraFC, False)
Destroy(lo_parametro)

ll_Linhas = dw_4.RowCount( )

For ll_Linha = 1 To ll_Linhas
	ll_Produto = dw_4.Object.Cd_Produto[ ll_Linha ]
	
	If ll_Produto = io_Produto.Cd_Produto_Manipulado Then
		ls_Apresentacao_Venda	=	""
		
		ll_Filial_FCerta				= dw_4.Object.Cd_Filial_FCerta			[ ll_Linha ]
		ll_Requisicao				= dw_4.Object.Nr_Registro					[ ll_Linha ]
		ls_Modo_Venda_Manip	= dw_4.Object.Id_Modo_Venda_Manip	[ ll_Linha ]
		
		/* O texto est$$HEX1$$e100$$ENDHEX$$ sendo composto nesta ordem devido ao cd_filial_fcerta ter sido criado em 09/2015
		 * com isso, pode haver somente o n$$HEX1$$fa00$$ENDHEX$$mero da requisi$$HEX2$$e700e300$$ENDHEX$$o, e o campo cd_filial_fcerta estar nulo */
		If Not IsNull( ll_Requisicao ) Then
			If ls_Modo_Venda_Manip = 'R' Then
				ls_Apresentacao_Venda = "REQUISI$$HEX2$$c700c300$$ENDHEX$$O: " + String( ll_Requisicao )
			Else
				ls_Apresentacao_Venda = "OR$$HEX1$$c700$$ENDHEX$$AMENTO: " + String( ll_Requisicao )
			End If
		End If
		
		If Not IsNull( ll_Filial_FCerta ) Then
			ls_Apresentacao_Venda = "FILIAL FCERTA: " + String( ll_Filial_FCerta ) + " - " + ls_Apresentacao_Venda
			ll_Filial = gvo_Parametro.Of_Filial()
			If ll_Filial <> gvo_parametro.of_filial_matriz() Then			
				
				If Trim(ls_integraFC) <> 'N' Then					
					If ls_Modo_Venda_Manip = 'R' Then
						cb_manip_de_para.Text = "&Requisi$$HEX2$$e700e300$$ENDHEX$$o De - Para"
					Else
						cb_manip_de_para.Text = "De Or$$HEX1$$e700$$ENDHEX$$amento - Para Requisi$$HEX2$$e700e300$$ENDHEX$$o"
					End If
					
					cb_manip_de_para.visible = True
				End If
			End If
		End If
		
		dw_4.Object.De_Apresentacao_Venda[ ll_Linha ] = ls_Apresentacao_Venda			
	End If
Next
end subroutine

public function boolean wf_cancelada_sefaz (string as_chave);DateTime ldh_cancelamento

select dh_cancelamento
into :ldh_cancelamento
from nf_venda_nfe
where de_chave_acesso = :as_chave
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar a nota fiscal com a chave de acesso: " + as_chave)
		Return False
	Case 100
		//SetNull(ldh_cancelamento)
		Return False
	Case 0
		If IsNull( ldh_cancelamento ) Then
			Return False
		Else
			Return True
		End If
End Choose


end function

public function boolean wf_caixa_conferido (string as_caixa, long al_controle);DateTime lvdh_Conferencia

Select dh_conferencia Into :lvdh_Conferencia
From controle_caixa
Where cd_caixa          = :as_Caixa
  and nr_controle_caixa = :al_Controle
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvdh_Conferencia) Then
			Return True
		Else
			Return False
		End If
	Case 100
		MessageBox("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Confer$$HEX1$$ea00$$ENDHEX$$ncia do Caixa", "Controle '" + String(al_Controle) + "' do caixa '" + as_Caixa + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		Return True
	Case -1
		SqlCa.of_MsgdbError("Verica$$HEX2$$e700e300$$ENDHEX$$o da Confer$$HEX1$$ea00$$ENDHEX$$ncia do Caixa")
		Return True
End Choose
end function

public function boolean wf_qtd_volume (long al_nr_nf, string as_de_especie, string as_de_serie, ref long al_qtd_volume);Long ll_qtd_volume

SELECT coalesce(lp.qt_volume , 0 )
Into :ll_qtd_volume
FROM licitacao_pedido lp
inner join nf_venda nv 
			on nv.nr_pedido_licitacao = lp.nr_pedido 
where nv.cd_filial = 534 
		and nv.nr_nf = :al_nr_nf 
		and nv.de_especie = :as_de_especie	
		and nv.de_serie = :as_de_serie
Using Sqlca;	

If Sqlca.Sqlcode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao acessa a tabela de NF_VENDA_NFE.",STOPSIGN!)
	Return False
End If	

al_qtd_volume = ll_qtd_volume	

Return True
end function

public subroutine _documentacao ();
/*      

OBJETIVO: Tela para consulta de notas fiscais de venda.

Tabelas: 
			- nf_venda
            	- filial
			- nf_venda_nfe 
			- cliente
			- cliente_caixa

*/
end subroutine

on w_ge041_consulta_nf_venda.create
int iCurrent
call super::create
this.cb_manip_de_para=create cb_manip_de_para
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_manip_de_para
this.Control[iCurrent+2]=this.tab_1
end on

on w_ge041_consulta_nf_venda.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_manip_de_para)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;Long lvl_Filial

String lvs_Especie_Parametro

iuo_Filial			= Create uo_Filial
ivo_Cliente		= Create uo_Cliente
ivo_Convenio	= Create uo_Convenio
ivo_Conveniado	= Create uo_Conveniado
ivo_Filial     		= Create uo_Filial
itr_Filial 			= Create dc_uo_transacao
ivo_Odbc			= Create dc_uo_odbc
io_Produto		= Create uo_Produto
itr_Filial.ivs_DataBase = 'POSTGRESQL'

Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Classificar(False)
Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Filtrar(False)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(False)
Tab_1.TabPage_3.dw_4.ivo_Controle_Menu.of_Recuperar(False)

tab_1.tabpage_1.dw_1.Object.Id_Licitacao.Visible = False

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_6.Event ue_AddRow()
Tab_1.TabPage_1.dw_conexao.Event ue_AddRow()

Tab_1.TabPage_1.dw_1.SetFocus()

Tab_1.TabPage_1.dw_1.Object.Nm_Conveniado.Protect = 1

ivm_Menu.ivb_Permite_Imprimir = True

If Not gf_Data_Parametro( ivdt_parametro ) Then
	Close( This )
	Return
End If

Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_De [1] = ivdt_Parametro
Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_Ate[1] = ivdt_Parametro

lvl_Filial = gvo_Parametro.Of_Filial()

If lvl_Filial <> gvo_parametro.of_filial_matriz() Then
	tab_1.tabpage_1.dw_1.Object.cd_filial[1]      	= lvl_Filial
	tab_1.tabpage_1.dw_1.Object.de_filial[1]      	= gvo_parametro.nm_fantasia_filial
	tab_1.tabpage_1.dw_1.Object.de_filial.Protect 	= 1
	
	//ivo_Filial.Nm_Fantasia = gvo_parametro.nm_fantasia_filial
	ivo_Filial.of_Localiza_Codigo( lvl_Filial )
	
	// Aten$$HEX2$$e700e300$$ENDHEX$$o
	If Not wf_Especie_NF_Parametro(Ref lvs_Especie_Parametro, "F") Then
		Close(This)
	End If
	
	tab_1.tabpage_1.cb_anexa_licitacao.Text 	= "Emitir Nota Anexa"
	
	// A partir do in$$HEX1$$ed00$$ENDHEX$$cio da NFE as notas n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e300$$ENDHEX$$o ser mais impressas
	// em formul$$HEX1$$e100$$ENDHEX$$rio s$$HEX1$$e900$$ENDHEX$$rie 3
//	If lvs_Especie_Parametro = 'NFE' Then
//		tab_1.tabpage_1.cb_reemitir.visible = false
//		tab_1.tabpage_1.cb_cancelar.visible = false
//	End If
Else
	// A partir do in$$HEX1$$ed00$$ENDHEX$$cio da NFE as notas n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e300$$ENDHEX$$o ser mais impressas
	// em formul$$HEX1$$e100$$ENDHEX$$rio s$$HEX1$$e900$$ENDHEX$$rie 3
	tab_1.tabpage_1.cb_reemitir.visible 				  	= False
	tab_1.tabpage_1.cb_cancelar.visible 				  	= False
	tab_1.tabpage_1.dw_1.Object.Id_Licitacao.Visible = True
	tab_1.tabpage_1.dw_conexao.Visible 				= True
	tab_1.tabpage_1.cb_anexa_licitacao.Text 		  	= "Vincula NF Licita$$HEX2$$e700e300$$ENDHEX$$o"

End If

dw_2 = Tab_1.TabPage_1.dw_2
dw_4 = Tab_1.TabPage_3.dw_4
end event

event close;call super::close;If IsValid( itr_Filial ) Then 
	If itr_Filial.of_IsConnected( ) Then
		itr_Filial.of_Disconnect( )
	End If
End If

If IsValid( iuo_Filial ) 			Then Destroy	iuo_Filial
If IsValid( ivo_Cliente ) 		Then Destroy	ivo_Cliente
If IsValid( ivo_Convenio ) 	Then Destroy	ivo_Convenio
If IsValid( ivo_Conveniado ) Then Destroy	ivo_Conveniado
If IsValid( ivo_Filial ) 			Then Destroy	ivo_Filial
If IsValid( itr_Filial ) 			Then Destroy	itr_Filial
If IsValid( ivo_Odbc ) 			Then Destroy	ivo_Odbc
If IsValid( io_Produto ) 		Then Destroy	io_Produto

If IsValid( dw_2 ) Then Destroy	dw_2
If IsValid( dw_4 ) Then Destroy	dw_4
end event

event ue_preopen;call super::ue_preopen;If Not This.ib_Solicitou_Liberacao_Procedimento_Base  Then
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE041_CONSULTA_NF_VENDA_CONSULTA", ref is_Matricula_Abertura_Tela) Then 
		This.il_Retorno = -1
		Return
	End If
End If
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge041_consulta_nf_venda
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge041_consulta_nf_venda
end type

type cb_manip_de_para from commandbutton within w_ge041_consulta_nf_venda
boolean visible = false
integer x = 1998
integer y = 4
integer width = 1143
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Requisi$$HEX2$$e700e300$$ENDHEX$$o De - Para"
end type

event clicked;Long ll_linha
Long ll_linha_venda
Long ll_Filial_FCerta
Long ll_Requisicao
Long ll_COO
Long ll_nf
Long ll_Sequencial

String ls_parametro
String ls_retorno
String ls_especie
String ls_serie

Decimal {2} ldc_valor_pago
DateTime ldt_Cancelamento

ll_linha 			= dw_4.GetRow()
ll_Filial_FCerta	= dw_4.Object.Cd_Filial_FCerta	[ ll_Linha ]
ll_Requisicao	= dw_4.Object.Nr_Registro			[ ll_Linha ]
ldc_valor_pago	= dw_4.Object.vl_preco_praticado	[ ll_Linha ]
ll_Sequencial	= dw_4.Object.nr_sequencial		[ ll_Linha ]

If IsNull(ll_Requisicao) or ll_Requisicao <= 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto deve ser Manipulado e possuir Registro FCerta!", Exclamation!)	
	Return 1
End If
If IsNull(ll_Filial_FCerta) or ll_Filial_FCerta = 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto manipulado sem Filial FCerta!", Information!)	
	Return 1
End If

ll_linha_venda 		= dw_2.GetRow()
ll_COO 				= dw_2.Object.nr_operacao_ecf	[ ll_Linha_venda ]
ll_nf					= dw_2.Object.nr_nf					[ ll_Linha_venda ]
ls_especie			= dw_2.Object.de_especie			[ ll_Linha_venda ]
ls_serie				= dw_2.Object.de_serie				[ ll_Linha_venda ]
ldt_Cancelamento	= dw_2.Object.Dh_Cancelamento  [ ll_Linha_venda ]

If Not IsNull(ldt_Cancelamento) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota Cancelada, altera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida!", Exclamation!)
	Return 1
End If

If ls_especie = 'NFE' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Altera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida para esse tipo de Nota!", Exclamation!)
	Return 1
End If

ls_parametro = String(ll_Filial_FCerta) + '|' + String(ll_Requisicao) + '|' + &
					 String(ldc_valor_pago, "####0.00") + '|' + String(ll_COO) + '|' + &
 					 String(ll_nf) + '|' + ls_especie + '|' + ls_serie + '|' + String(ll_Sequencial)

OpenWithParm (w_ge119_requisicao_de_para, ls_parametro)

ls_retorno = Message.StringParm

If ls_retorno = 'OK' Then 
//	Tab_1.SelectTab(1)
	Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
Else
	Return 1
End If




end event

type tab_1 from tab within w_ge041_consulta_nf_venda
integer x = 5
integer y = 8
integer width = 3488
integer height = 1704
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 80269524
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanging;//OVERRIDE

SetPointer(HourGlass!)

LONG lvl_Linha 

String ls_Usuario

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

cb_manip_de_para.visible = False

If NewIndex = 2 Then
	If lvl_Linha > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
	
		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

If NewIndex = 3 Then
	If lvl_Linha > 0 Then
		
//		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'RL' Then
//			If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE041_ACESSO_ABA_ITENS", Ref ls_Usuario) Then 
//				Return 1
//			End If
//		End If	

		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW de detalhes
		Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
	
		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

SetPointer(Arrow!)
end event

event selectionchanged;SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_2.dw_3.SetFocus()
	Case 3
		This.Width  = Parent.ivl_Largura_3
		This.Height = Parent.ivl_Altura_3
		
		Tab_1.TabPage_3.dw_4.SetFocus()
End Choose
	
Parent.Width  = This.Width  + 60
Parent.Height = This.Height + 150			

SetPointer(Arrow!)
end event

event constructor;ivl_Largura_1 = 3488
ivl_Altura_1  = 1704

ivl_Largura_2 = 3488
ivl_Altura_2  = 1556

ivl_Largura_3 = 3338
ivl_Altura_3  = 1556

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3451
integer height = 1588
long backcolor = 80269524
string text = "Sele$$HEX1$$e700$$ENDHEX$$ao"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_imprimir cb_imprimir
cb_pedido_cliente cb_pedido_cliente
dw_conexao dw_conexao
cb_anexa_licitacao cb_anexa_licitacao
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
dw_1 dw_1
dw_2 dw_2
cb_reemitir cb_reemitir
cb_cancelar cb_cancelar
dw_5 dw_5
dw_6 dw_6
end type

on tabpage_1.create
this.cb_imprimir=create cb_imprimir
this.cb_pedido_cliente=create cb_pedido_cliente
this.dw_conexao=create dw_conexao
this.cb_anexa_licitacao=create cb_anexa_licitacao
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_reemitir=create cb_reemitir
this.cb_cancelar=create cb_cancelar
this.dw_5=create dw_5
this.dw_6=create dw_6
this.Control[]={this.cb_imprimir,&
this.cb_pedido_cliente,&
this.dw_conexao,&
this.cb_anexa_licitacao,&
this.cb_1,&
this.gb_1,&
this.gb_2,&
this.dw_1,&
this.dw_2,&
this.cb_reemitir,&
this.cb_cancelar,&
this.dw_5,&
this.dw_6}
end on

on tabpage_1.destroy
destroy(this.cb_imprimir)
destroy(this.cb_pedido_cliente)
destroy(this.dw_conexao)
destroy(this.cb_anexa_licitacao)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_reemitir)
destroy(this.cb_cancelar)
destroy(this.dw_5)
destroy(this.dw_6)
end on

type cb_imprimir from commandbutton within tabpage_1
boolean visible = false
integer x = 59
integer y = 516
integer width = 512
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Imprimir Etiqueta"
end type

event clicked;str_etiqueta1 lstr_parm

Long ll_nr_nf
String ls_de_especie
String ls_de_serie
String ls_nr_cpf_cgc

ll_nr_nf			= dw_2.object.nr_nf[dw_2.getrow()]
ls_de_especie	= dw_2.object.de_especie[dw_2.getrow()]
ls_de_serie		= dw_2.object.de_serie[dw_2.getrow()]
ls_nr_cpf_cgc	= dw_2.object.nr_cpf_cgc[dw_2.getrow()] 

lstr_parm.al_nr_nf 			=	ll_nr_nf
lstr_parm.as_de_especie		=	ls_de_especie
lstr_parm.as_de_serie		=	ls_de_serie
lstr_parm.as_nr_cnpj			= 	ls_nr_cpf_cgc

If Not wf_qtd_volume(ll_nr_nf, ls_de_especie, ls_de_serie, lstr_parm.al_volume ) Then
	Return
End If

OpenWithParm( w_ge041_impressao_etiqueta_licitacao, lstr_parm )

lstr_parm = message.PowerObjectParm

If lstr_parm.as_acao = 'CA' Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Procedimento cancelado.",INFORMATION!)
	Return
End If	
end event

type cb_pedido_cliente from commandbutton within tabpage_1
boolean visible = false
integer x = 622
integer y = 516
integer width = 622
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Inserir Pedido Cliente"
end type

event clicked;String	ls_Parametro,&
		ls_Especie,&
		ls_Serie,&
		ls_Exige_Pedido

Long	ll_Linha,&
		ll_Filial,&
		ll_Nota


ll_Linha	= tab_1.tabpage_1.dw_2.GetRow()

If ll_Linha > 0 Then

	ll_Filial				= tab_1.tabpage_1.dw_2.Object.cd_filial							[ll_Linha]
	ll_Nota				= tab_1.tabpage_1.dw_2.Object.nr_nf							[ll_Linha]
	ls_Especie			= tab_1.tabpage_1.dw_2.Object.de_especie					[ll_Linha]
	ls_Serie				= tab_1.tabpage_1.dw_2.Object.de_serie						[ll_Linha]
	ls_Exige_Pedido	= tab_1.tabpage_1.dw_2.Object.id_exige_pedido_cliente	[ll_Linha]
	
	If ls_Exige_Pedido <> "S" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse cliente n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ marcado para inserir o pedido na nota.")
		Return 1
	End If
	
	ls_Parametro	= Right("0000"+String(ll_Filial), 4) + ls_Especie + Right("000"+String(Long(ls_Serie)), 3) + String(ll_Nota)
	
	OpenWithParm(w_ge041_lancamento_pedido_cliente, ls_Parametro)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma nota.")
End If
end event

type dw_conexao from dc_uo_dw_base within tabpage_1
integer x = 2610
integer y = 536
integer width = 818
integer height = 88
integer taborder = 70
string dataobject = "dw_ge041_conexao"
end type

event constructor;call super::constructor;This.Visible	= False
end event

type cb_anexa_licitacao from commandbutton within tabpage_1
integer x = 1271
integer y = 516
integer width = 571
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Emitir Nota Anexa"
end type

event clicked;//Este Bot$$HEX1$$e300$$ENDHEX$$o possui fun$$HEX2$$e700f500$$ENDHEX$$es especificas para as Lojas e a Matriz
//Nas Filiais $$HEX1$$e900$$ENDHEX$$ usuado para a emiss$$HEX1$$e300$$ENDHEX$$o de Notas Fiscais Anexas
//Na Matriz $$HEX1$$e900$$ENDHEX$$ usado para vincular Notas Fiscais com sendo de Licita$$HEX2$$e700f500$$ENDHEX$$es

If This.Text = "Emitir Nota Anexa" Then
	//Apenas nas filiais
	If Not wf_Emitir_Nota_Anexa() Then Return -1	
Else
	//Apenas na Matriz
	If Not wf_vincula_venda_licitacao() Then Return -1	
End If
end event

type cb_1 from commandbutton within tabpage_1
integer x = 1874
integer y = 516
integer width = 713
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Copia Chave de Acesso"
end type

event clicked;Integer lvi_Retorno

Tab_1.TabPage_1.dw_6.SetFocus()

Tab_1.TabPage_1.dw_6.SelectText(1, 44)

Long lvl_Linha

lvl_Linha = Tab_1.TabPage_1.dw_6.GetRow()

lvi_Retorno = Tab_1.TabPage_1.dw_6.Copy()

Choose Case lvi_Retorno
	Case -1  // Vazio
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o foi selecionada para a c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -2  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -9  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
End Choose

Tab_1.TabPage_1.dw_2.SetFocus()
end event

type gb_1 from groupbox within tabpage_1
integer x = 9
integer y = 8
integer width = 3424
integer height = 504
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within tabpage_1
integer x = 9
integer y = 612
integer width = 3424
integer height = 960
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Listas de Notas Fiscais"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 27
integer y = 72
integer width = 3378
integer height = 412
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_selecao_nf_venda"
end type

event ue_key;String lvs_Parametro

If key = KeyEnter! Then
	
	lvs_Parametro = This.GetText()
	
	Choose Case This.GetColumnName()
		Case "nm_cliente"
			If LenA( Trim( This.GetText() ) ) = 11 And IsNumber( Trim( This.GetText() ) ) Then
				ivo_Cliente.of_Localiza_Cpf( This.GetText() )
			Else		
				ivo_Cliente.of_Localiza_Cliente( This.GetText() )
			End If
			
			If ivo_Cliente.Localizado Then
				Tab_1.TabPage_1.dw_1.Object.cd_cliente[1] = ivo_Cliente.cd_cliente
				Tab_1.TabPage_1.dw_1.Object.nm_Cliente[1] = ivo_Cliente.nm_cliente
				dw_2.Reset()
			End If
		Case "nm_convenio"
			ivo_Convenio.of_Localiza_Convenio(lvs_Parametro)

			If ivo_Convenio.Localizado Then
				Tab_1.TabPage_1.dw_1.Object.Cd_Convenio[1] = ivo_Convenio.Cd_Convenio
				Tab_1.TabPage_1.dw_1.Object.Nm_Convenio[1] = ivo_Convenio.Nm_Fantasia
				Tab_1.TabPage_1.dw_1.Object.Nm_Conveniado.Protect = 0
				dw_2.Reset()
			Else
				Tab_1.TabPage_1.dw_1.Object.Nm_Convenio[1] = ""
				Tab_1.TabPage_1.dw_1.Object.Nm_Conveniado.Protect = 1
			End If
		Case "nm_conveniado"
			
			Long lvl_Cd_Convenio

			lvl_Cd_Convenio = Tab_1.TabPage_1.dw_1.Object.Cd_Convenio[1]
			
			ivo_Conveniado.of_Localiza_Conveniado(lvl_Cd_Convenio,lvs_Parametro)
			
			If ivo_Conveniado.Localizado Then
				Tab_1.TabPage_1.dw_1.Object.Cd_Conveniado[1] = ivo_Conveniado.Cd_Conveniado
				Tab_1.TabPage_1.dw_1.Object.Nm_Conveniado[1] = ivo_Conveniado.Nm_Conveniado
				dw_2.Reset()
			Else
				Tab_1.TabPage_1.dw_1.Object.Cd_Conveniado[1] = ""
				Tab_1.TabPage_1.dw_1.Object.Nm_Conveniado[1] = ""
			End If
				
		Case "de_filial"
			
			iuo_filial.of_Localiza_Filial( This.GetText() )
			
			If iuo_filial.Localizada Then
				Tab_1.TabPage_1.dw_1.Object.Cd_Filial		[1] = iuo_filial.Cd_Filial
				Tab_1.TabPage_1.dw_1.Object.De_Filial		[1] = iuo_filial.Nm_Fantasia
				dw_2.Reset()
			Else
				
				iuo_filial.of_Inicializa()
				
				Tab_1.TabPage_1.dw_1.Object.Cd_Filial[1] = iuo_filial.Cd_Filial
				Tab_1.TabPage_1.dw_1.Object.De_Filial[1] = iuo_filial.Nm_Fantasia
				
			End If	
				
	End Choose
	
	
End If
end event

event editchanged;call super::editchanged;LONG	ll_nulo

SETNULL(ll_nulo)

dw_2.Event ue_Reset()
dw_6.Object.chave_acesso[1] = ""

Choose Case dwo.Name 
	Case  "de_filial"
		If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Filial[1] = ll_nulo
			Return 0
		End If	
		
		If Data <> iuo_filial.nm_fantasia Then Return 1
	Case "nm_cliente"
		If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Cliente[1] = ""
			Return 0
		End If	
		
		If Data <> ivo_Cliente.Nm_Cliente Then Return 1
	Case "nm_convenio"
		If Data = "" Or Isnull(Data) Then
			This.Object.Cd_Convenio[1] = ll_nulo
			This.Object.Cd_Conveniado[1] = ""
			This.Object.Nm_Conveniado[1] = ""
			Tab_1.TabPage_1.dw_1.Object.Nm_Conveniado.Protect = 1
			Return 0
		End If	
						
		If Data <> ivo_Convenio.Nm_Fantasia Then Return 1
			
	Case "nm_conveniado"
		If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Conveniado[1] = ""
			Return 0
		End If	
		
		If Data <> ivo_Conveniado.Nm_Conveniado Then Return 1
End Choose
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
dw_6.Object.chave_acesso[1] = ""

If dwo.Name = "de_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Trim(Data) <> iuo_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		iuo_Filial.Of_Inicializa()
		
		This.Object.Cd_Filial[1] = iuo_Filial.Cd_Filial
		This.Object.De_Filial[1] = iuo_Filial.Nm_Fantasia
	End If
End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 37
integer y = 672
integer width = 3374
integer height = 880
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_lista_nf_venda"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_preretrieve;call super::ue_preretrieve;STRING	lvs_Especie			, &
			lvs_Serie				, &
			lvs_Situacao			, &
			lvs_Tipo_Venda	, &
			lvs_Cd_Conveniado, &
			lvs_Cd_Cliente		, &
			lvs_Pedido_Disque	, &
			lvs_Pedido			, &
			lvs_Licitacao 		, &
			lvs_Odbc				, &
			lvs_Conexao			, &
			lvs_SQL
		 	   
DATE lvdt_Emissao_de, lvdt_Emissao_ate

LONG lvl_Filial
LONG	lvl_Nota_Fiscal
LONG	lvl_Cd_Convenio
LONG	lvl_ECF
LONG lvl_Requisicao
LONG lvl_COO

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Emissao_de   		= Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_de    		[1]
lvdt_Emissao_ate  		= Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_ate   		[1]
lvl_Filial        			= Tab_1.TabPage_1.dw_1.Object.Cd_Filial		  			[1]
lvl_Nota_Fiscal   		= Tab_1.TabPage_1.dw_1.Object.Nr_Nf			    			[1]
lvs_Especie       		= Tab_1.TabPage_1.dw_1.Object.De_Especie	    			[1] 
lvs_Serie         			= Tab_1.TabPage_1.dw_1.Object.De_Serie		    			[1]
lvl_ECF           			= Tab_1.TabPage_1.dw_1.Object.Nr_ECF		    			[1]
lvs_Situacao      		= Tab_1.TabPage_1.dw_1.Object.Id_Cancelada	  		[1]
lvs_Tipo_Venda   		= Tab_1.TabPage_1.dw_1.Object.Id_Tipo_Venda    		[1]
lvs_Cd_Cliente    		= Tab_1.TabPage_1.dw_1.Object.Cd_Cliente       			[1]
lvl_Cd_Convenio   		= Tab_1.TabPage_1.dw_1.Object.Cd_Convenio      		[1]
lvs_Cd_Conveniado 	= Tab_1.TabPage_1.dw_1.Object.Cd_Conveniado    		[1]
lvs_Pedido_Disque 	= Tab_1.TabPage_1.dw_1.Object.id_disque_entrega		[1]
lvs_Pedido				= Tab_1.TabPage_1.dw_1.Object.id_pedido				[1]
lvs_Licitacao				= Tab_1.TabPage_1.dw_1.Object.id_licitacao				[1]
lvl_Requisicao			= Tab_1.TabPage_1.dw_1.object.nr_requisicao			[1]
lvl_COO					= Tab_1.TabPage_1.dw_1.object.nr_coo_ecf				[1] 
lvs_Conexao				= Tab_1.TabPage_1.dw_conexao.object.id_conexao		[1] 
 

//If ISNULL(lvl_filial) Then lvl_filial = gvo_parametro.of_filial()

If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
	This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione uma filial.", Exclamation!)
	dw_1.Event ue_Pos(1, "de_filial")
	Return -1
End If	

If Not IsNull(lvl_Cd_Convenio) and lvl_Cd_Convenio <> 0 Then
	This.of_AppendFrom("convenio")
	This.of_AppendWhere("n.cd_convenio = " + String(lvl_Cd_Convenio))
	This.of_AppendWhere("convenio.cd_convenio = n.cd_convenio")
End If	

If Not IsNull(lvs_Cd_Cliente) and lvs_Cd_Cliente <> "" Then
	This.of_AppendFrom("cliente")
	This.of_AppendWhere("n.cd_cliente = '" + lvs_Cd_Cliente + "'")
	This.of_AppendWhere("cliente.cd_cliente = n.cd_cliente")
End If	

If Not IsNull(lvs_Cd_Conveniado) and lvs_Cd_Conveniado <> "" Then
	This.of_AppendFrom("conveniado")
	This.of_AppendWhere("n.cd_conveniado = '" + lvs_Cd_Conveniado + "'")
	This.of_AppendWhere("conveniado.cd_convenio = convenio.cd_convenio and " +&
	                    "conveniado.cd_conveniado = n.cd_conveniado and " +&
							  "n.cd_convenio = convenio.cd_convenio")
End If	

If Not IsNull(lvdt_Emissao_de) Then 
	This.of_AppendWhere("n.dh_movimentacao_caixa >= '" + String(lvdt_Emissao_de,"YYYYMMDD") + "'")
End If	

If Not IsNull(lvdt_Emissao_ate) Then 
	This.of_AppendWhere("n.dh_movimentacao_caixa <= '" + String(lvdt_Emissao_ate,"YYYYMMDD") + "'")
End If	

If Not IsNull(lvl_Nota_Fiscal) Then
	This.of_AppendWhere("n.nr_nf = " + String(lvl_Nota_Fiscal))
End If	

If Not IsNull(lvs_Especie) Then
	This.of_AppendWhere("n.de_especie = '" + lvs_Especie + "'")
End If	

If Not IsNull(lvs_Serie) Then
	This.of_AppendWhere("n.de_serie = '" + lvs_Serie + "'")
End If

If Not IsNull(lvl_Ecf) Then
	This.of_AppendWhere("n.nr_ecf = " + String(lvl_Ecf))
End If

If lvs_Tipo_Venda <> 'TO' Then
	This.of_AppendWhere("n.id_tipo_venda = '" + lvs_tipo_venda + "'")
End If

If lvs_Situacao <> "T" Then
   If lvs_Situacao = 'S' Then
		This.of_AppendWhere("n.dh_cancelamento is Not null")
	Else
		This.of_AppendWhere("n.dh_cancelamento is null")
	End If	
End If	

If lvs_Pedido <> 'N' Then
	If lvs_Pedido = 'D' Then
		//This.of_AppendWhere("nr_pedido_drogaexpress is not null")
		This.of_AppendWhere(" EXISTS ( SELECT * FROM cliente_caixa c " 			+&
															"WHERE c.cd_filial		= n.cd_filial " 		+&
															"AND c.nr_nf_venda				= n.nr_nf " 			+&
															"AND c.de_especie_venda		= n.de_especie "	+&
															"AND c.de_serie_venda			= n.de_serie "		+&
															"AND c.id_situacao		= 'C' " +&
															"AND c.id_tipo = 'D')")
		This.of_AppendWhere("nr_pedido_ecommerce is null")
	Elseif lvs_Pedido = 'M' then
		This.of_AppendWhere(" EXISTS ( SELECT * FROM registro_venda_manip m " 			+&
															"WHERE m.cd_filial		= n.cd_filial " 		+&
															"AND m.nr_nf				= n.nr_nf " 			+&
															"AND m.de_especie		= n.de_especie "	+&
															"AND m.de_serie			= n.de_serie )" )
	Else
		This.of_AppendWhere("nr_pedido_ecommerce is not null")
	End If
End If

If lvs_Licitacao = "S" Then
	This.of_AppendWhere("n.id_licitacao = 'S'")
End If

If Not IsNull(lvl_Requisicao) and lvl_Requisicao > 0 Then
	This.of_AppendWhere(" EXISTS ( SELECT * FROM registro_venda_manip m " 			+&
															"WHERE m.cd_filial		= n.cd_filial " 		+&
															"AND m.nr_nf				= n.nr_nf " 			+&
															"AND m.de_especie		= n.de_especie "	+&
															"AND m.de_serie			= n.de_serie "		+&
															"AND m.nr_registro		= " + String( lvl_Requisicao ) + ")" )
End If

If lvs_Conexao = 'F' Then
	If (not itr_Filial.of_IsConnected( ))or(ivl_Filial_Odbc <> lvl_Filial) Then
		Open(w_Aguarde)
		lvs_Odbc = ivo_Odbc.of_Localiza( lvl_Filial )
		
		If Trim(lvs_Odbc)<>'' Then
			ivo_Odbc.of_deleta_regedit_odbc(lvl_Filial)
		End If
		
		ivo_Odbc.of_localiza_parametro_odbc(lvl_Filial)
		ivo_Odbc.of_grava_regedit_odbc(lvl_Filial)
		lvs_Odbc = ivo_Odbc.of_Localiza( lvl_Filial )
		
		w_Aguarde.Title = "Conectando na Filial '" + lvs_Odbc + "'"
		
		If itr_Filial.of_IsConnected( ) Then
			itr_Filial.of_Disconnect( )
		End If
		
		If Not itr_Filial.of_Connect(lvs_Odbc, 'TRANSF') Then
			Close( w_Aguarde )
			Return -1
		Else
			ivl_Filial_Odbc = lvl_Filial
		End If

		Close(w_Aguarde)

	End If
	This.of_SetTransObject( itr_Filial )
	tab_1.tabpage_2.dw_3.of_SetTransObject( itr_Filial )
	tab_1.tabpage_3.dw_4.of_SetTransObject( itr_Filial )
	
	If Not IsNull(lvl_COO) and lvl_COO > 0 Then
		This.Of_Appendwhere("coalesce(n.nr_operacao_ecf,n.nr_ccf)="+String(lvl_COO))
	End If
	
Else	
	This.of_SetTransObject( SQLCa )
	tab_1.tabpage_2.dw_3.of_SetTransObject( SQLCa )
	tab_1.tabpage_3.dw_4.of_SetTransObject( SQLCa )
	
	If gvo_Parametro.Of_Filial() = gvo_parametro.of_filial_matriz() Then	
		lvs_SQL = This.GetSQLSelect()		
		lvs_SQL = gf_replace(lvs_SQL, "coalesce(n.nr_operacao_ecf,n.nr_ccf) as nr_operacao_ecf", "n.nr_coo_ecf", 0)
		This.SetSQLSelect( lvs_SQL )		
		
		If Not IsNull(lvl_COO) and lvl_COO > 0 Then
			This.Of_Appendwhere("n.nr_coo_ecf="+String(lvl_COO))
		End If		
	Else
		If Not IsNull(lvl_COO) and lvl_COO > 0 Then
			This.Of_Appendwhere("coalesce(n.nr_operacao_ecf,n.nr_ccf)="+String(lvl_COO))
		End If				
	End If	
	

End If

Return AncestorReturnValue
end event

event ue_postretrieve;Boolean lvb_Habilita = False

If pl_Linhas > 0 Then
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	
	lvb_Habilita = True
	
ElseIf pl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

This.ivo_Controle_Menu.of_Imprimir(lvb_Habilita)
This.ivo_Controle_Menu.of_SalvarComo(lvb_Habilita)

Return pl_Linhas
end event

event constructor;call super::constructor;//Compartilha dados com dw de relat$$HEX1$$f300$$ENDHEX$$rio
This.ShareData(dw_5)

//This.of_SetRowSelection("", "if( not isnull( dh_cancelamento ), RGB(255,0, 0), RGB(0,0,0) )")
//This.of_SetRowSelection( 'if( (not isnull( dh_cancelamento )), rgb(255, 0, 0), if((id_situacao = "D"),rgb(255,0,0), ' + This.ivs_Cor_Linha_Padrao + '))', '', False )
This.of_SetRowSelection( "if( (not isnull( dh_cancelamento )), rgb(255, 0, 0), " + This.ivs_Cor_Linha_Padrao + ")", "", False )
end event

event rowfocuschanged;call super::rowfocuschanged;If  tab_1.tabpage_1.dw_2.RowCount() > 0 Then
	
	tab_1.tabpage_1.dw_6.Object.chave_acesso[1] = tab_1.tabpage_1.dw_2.Object.de_chave_acesso[currentrow]
	
	If (tab_1.tabpage_1.dw_2.Object.id_exige_pedido_cliente[currentrow]	= "S")	and	(tab_1.tabpage_1.dw_2.Object.de_especie[currentrow]	= "NFE")	Then
		cb_pedido_cliente.Visible	= True
	Else
		cb_pedido_cliente.Visible	= False		
	End If
	
End If
end event

event ue_retrieve;call super::ue_retrieve;String ls_id_licitacao

IF AncestorReturnValue > 0 THEN
	tab_1.tabpage_1.cb_Cancelar.Enabled = TRUE
	tab_1.tabpage_1.cb_Reemitir.Enabled = TRUE
	THIS.Event RowFocusChanged(1)
ELSE
	tab_1.tabpage_1.cb_cancelar.Enabled = FALSE
	tab_1.tabpage_1.cb_Reemitir.Enabled = FALSE
END IF

If gvo_Aplicacao.ivo_Seguranca.cd_sistema = 'WS' And  AncestorReturnValue > 0 Then
	ls_id_licitacao = dw_1.Object.id_licitacao[1]
	
	If ls_id_licitacao = 'S' Then
		cb_imprimir.Visible = True
	Else
		cb_imprimir.Visible = False
	End If	
End If	


RETURN AncestorReturnValue

end event

event ue_printimmediate;//OVERRIDE

dw_5.Event ue_Print()

end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type cb_reemitir from commandbutton within tabpage_1
integer x = 2624
integer y = 516
integer width = 389
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
string text = "&Reemitir"
end type

event clicked;LONG	ll_row

String ls_Responsavel

ll_row = dw_2.GetRow()

If ll_row <= 0 Then Return 1

If Not gf_nfe_impressao_cancelamento(dw_2.Object.de_especie[ll_row]) Then
	Return
End If

If dw_2.Object.de_especie[ll_row] = "CF" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A reemiss$$HEX1$$e300$$ENDHEX$$o de cupons fiscais deve ser utilizada somente como espelho. ~rCertifique-se de que a impressora est$$HEX1$$e100$$ENDHEX$$ preparada com papel branco.", Information!)
End If
If dw_2.Object.de_especie[ll_row] = "NFC" Or dw_2.Object.de_especie[ll_row] = "SAT" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A reemiss$$HEX1$$e300$$ENDHEX$$o de NFC-e/SAT $$HEX1$$e900$$ENDHEX$$ feita somente no Sistema de Caixa.", Information!)
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja reemitir esta nota fiscal de Venda ?", Question!, YesNo!) = 1 Then
	
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "W_GE041_CONSULTA_NF_VENDA_REEMITIR", Ref ls_Responsavel ) Then 
		Return
	End If

	
	UO_NOTA_FISCAL luo_nf
	
	luo_nf = Create UO_NOTA_FISCAL
	
	luo_nf.Emitir_Nf_Venda(dw_2.Object.cd_filial	[ll_row], &
								  dw_2.Object.nr_nf		[ll_row], &
								  dw_2.Object.de_especie[ll_row], &
								  dw_2.Object.de_serie	[ll_row])
								  
	Try
		uo_usuario lo_usuario // GE010
		lo_usuario = Create uo_usuario
		
		lo_usuario.of_localiza_matricula( ls_Responsavel )
		If lo_usuario.localizado Then
			ls_Responsavel = lo_usuario.nm_usuario + ' ( ' + ls_Responsavel + ' )'
		End If
		
	Catch( RuntimeError ru )
	//
	Finally
		Destroy lo_usuario
	End Try

//	gf_ge202_envia_email_log( 108, &
//									"Reemiss$$HEX1$$e300$$ENDHEX$$o de cupom fiscal de venda :: Filial " + String( dw_2.Object.cd_filial[ll_row] ), &
//									"<br />Filial: "		+ String( dw_2.Object.cd_filial		[ll_row] ) + &
//									"<br />Cupom: "	+ String( dw_2.Object.nr_nf			[ll_row] ) + &
//									"<br />Esp$$HEX1$$e900$$ENDHEX$$cie: "	+ String( dw_2.Object.de_especie	[ll_row] ) + &
//									"<br />S$$HEX1$$e900$$ENDHEX$$rie : "	+ String( dw_2.Object.de_serie	[ll_row] ) + &
//									"<br />Por: " 		+ ls_Responsavel + &
//									"<br />Em: " 		+ String( Today( ), "dd/mm/yyyy hh:mm:ss" ), &
//									True, &
//									False )
	Destroy(luo_nf)
	
End If
end event

type cb_cancelar from commandbutton within tabpage_1
integer x = 3045
integer y = 516
integer width = 389
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Cancelar"
end type

event clicked;Long 	lvl_Linha		, &
		lvl_Filial		, &
		lvl_NF			, &
		lvl_Controle , &
		lvl_pedido_ecommerce
	  
String	lvs_Especie		, &
		lvs_Serie			, &
		lvs_Mensagem	, &
		lvs_Caixa			, &
		lvs_Protocolo_Cancelamento
	
String ls_Chave_Acesso
String ls_Cancela_Sefaz = 'S'
String ls_Motivo
String ls_Proc_Envio
String ls_Log
String lvs_Matric_Cancelamento
	
DateTime lvdh_Cancelamento

Date ldt_Caixa
Date ldt_devolucao

lvl_Linha = Parent.dw_2.GetRow()

If lvl_Linha <= 0 Then Return -1

lvl_Filial								= Parent.dw_2.Object.Cd_Filial								[lvl_Linha]
lvl_NF									= Parent.dw_2.Object.Nr_NF								[lvl_Linha]
lvs_Especie							= Parent.dw_2.Object.De_Especie							[lvl_Linha]
lvs_Serie								= Parent.dw_2.Object.De_Serie							[lvl_Linha]
lvs_Caixa								= Parent.dw_2.Object.Cd_Caixa							[lvl_Linha]
lvl_Controle							= Parent.dw_2.Object.Nr_Controle_Caixa				[lvl_Linha]
ldt_Caixa								= Date(Parent.dw_2.Object.Dh_Movimentacao_Caixa	[lvl_Linha])
lvdh_Cancelamento				= DateTime(Parent.dw_2.Object.Dh_Cancelamento	[lvl_Linha])
lvs_Protocolo_Cancelamento	= Parent.dw_2.Object.nr_protocolo_cancelamento	[lvl_Linha]
ls_Proc_Envio						= Parent.dw_2.Object.nr_protocolo_envio				[lvl_Linha]	
ls_Chave_Acesso					= Parent.dw_2.Object.de_chave_acesso					[lvl_Linha]
lvl_pedido_ecommerce			= Parent.dw_2.Object.nr_pedido_ecommerce			[lvl_Linha]
ldt_devolucao						= Date(Parent.dw_2.Object.dh_devolucao				[lvl_Linha])

If Not gf_Data_Parametro( ivdt_parametro ) Then Return -1

If Not IsNull(lvdh_Cancelamento) Then
	lvs_Mensagem = "A nota fiscal '" + String(lvl_NF) + "', esp$$HEX1$$e900$$ENDHEX$$cie '" + lvs_Especie + "', s$$HEX1$$e900$$ENDHEX$$rie '" + lvs_Serie + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cancelada."
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Exclamation!)
	Return -1
End If

If lvs_Especie <> "NFE" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o cancelamento de cupons fiscais.", StopSign!)
	Return -1
End If

//N$$HEX1$$e300$$ENDHEX$$o Autorizada na SEFAZ
If IsNull( ls_Proc_Envio ) Or Trim( ls_Proc_Envio ) = '' Then
	lvs_Mensagem = "A nota fiscal '" + String(lvl_NF) + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ AUTORIZADA no Sefaz."
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Exclamation!)
	Return -1
End If

/* ********************* Essa parte foi incluida na gf_ge033_cancela_nf_regra_depto_fiscal Chamado: 810565-1 ********************
//Cfme chamado 311616, se o mes da emissao for diferente do atual, e o dia for maior ou igual a 2, nao pode cancelar
If ( Month( ivdt_parametro ) <> Month( ldt_Caixa ) ) And Day( ivdt_parametro ) >= 2 Then
	lvs_Mensagem = "Expirou o prazo para cancelamento desta nota fiscal.~rNota: " + String(lvl_NF) + " ~rEsp$$HEX1$$e900$$ENDHEX$$cie: " + lvs_Especie + "~rS$$HEX1$$e900$$ENDHEX$$rie: " + lvs_Serie
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Exclamation! )
	Return -1
End If
*/

//Se a nf foi cancelada no sefaz pelo sistema NFe com esta janela aberta.
If wf_Cancelada_Sefaz( ls_Chave_Acesso ) Then 
	ls_Cancela_Sefaz = 'N'		
End If

//Venda Ecommerce Loja s$$HEX1$$f300$$ENDHEX$$ permite cancelamento se o caixinha da venda ainda estiver aberto.
If Not IsNull(lvl_pedido_ecommerce) And lvl_pedido_ecommerce > 0 Then 
	If Not IsNull(ldt_devolucao) Then
		lvs_Mensagem = "Nota de venda possui devolu$$HEX2$$e700e300$$ENDHEX$$o, cancelamento n$$HEX1$$e300$$ENDHEX$$o permitido!"
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Exclamation!)
		Return -1				
	End If
	If wf_Caixa_Conferido(lvs_Caixa, lvl_Controle) Then
		lvs_Mensagem = "Controle de Caixa da venda j$$HEX1$$e100$$ENDHEX$$ conferido, cancelamento n$$HEX1$$e300$$ENDHEX$$o permitido!"
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Exclamation!)
		Return -1		
	End If		
End If

//Verifica se pode cancelar no retaguarda de acordo com a regra do depto fiscal
If Not gf_ge033_cancela_nf_regra_depto_fiscal( ldt_Caixa ) Then
	Return -1
End If

lvs_Mensagem = "Confirma o cancelamento da nota fiscal '" + String(lvl_NF) + "', esp$$HEX1$$e900$$ENDHEX$$cie '" + lvs_Especie + "', s$$HEX1$$e900$$ENDHEX$$rie '" + lvs_Serie + "' ?"

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", lvs_Mensagem, Question!, YesNo!) = 1 Then

	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("CANCELAMENTO_NOTAS_FISCAIS", Ref lvs_Matric_Cancelamento) Then 
		Return
	End If

	Try
		If ls_Cancela_Sefaz = 'S' Then
			//Qtde m$$HEX1$$ed00$$ENDHEX$$nima exigida pela Sefaz --> 15 caracteres
			OpenWithParm( w_justificativa, '15' + 'Informe o motivo do cancelamento:' )
			ls_Motivo = Message.StringParm
			
			If IsNull( ls_Motivo ) Then Return -1
		
			//Cancelamento na SEFAZ
			uo_ge140_cancela_nf_sefaz lo_sefaz
			lo_sefaz = Create uo_ge140_cancela_nf_sefaz
			
			If Not lo_sefaz.of_cancela_nfe( lvl_Filial, ls_Chave_Acesso, ls_Proc_Envio, ls_Motivo, Ref lvs_Protocolo_Cancelamento, Ref ls_Log  ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Log )
				Return -1
			Else
				Update nf_venda_nfe
					Set nr_protocolo_cancelamento 	= :lvs_Protocolo_Cancelamento,
						 dh_cancelamento					= GetDate(),
						 nr_matricula_cancelamento	= :lvs_Matric_Cancelamento,
						 id_situacao							= 'X'
				 Where	cd_filial		= :lvl_Filial
					and 	nr_nf			= :lvl_NF
					and	de_especie	= :lvs_Especie
					and	de_serie		= :lvs_Serie
				Using SqlCa;
			
				If SqlCa.SqlCode = 0 Then
					SqlCa.of_Commit();
				Else
					SqlCa.of_Rollback();
					SqlCa.of_msgDbError( "Erro no cancelamento da nf_venda_nfe." + SqlCa.SqlErrText )
					Return -1
				End If
			End If
		End If	

		Update nf_venda
		Set	dh_cancelamento           	= dbo.uf_dh_parametro(),
				nr_matricula_cancelamento = :lvs_Matric_Cancelamento
		Where cd_filial  	= :lvl_Filial
		  and nr_nf      		= :lvl_NF
		  and de_especie 	= :lvs_Especie
		  and de_serie   	= :lvs_Serie
		Using SqlCa;
		
		If SqlCa.SqlCode = 0 Then
			If IsNull(lvl_pedido_ecommerce) Or lvl_pedido_ecommerce <= 0 Then  //N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ venda do Ecommerce Loja					
				SqlCa.of_Commit();
			Else  //Venda Ecommerce Loja, tem que cancelar as movimenta$$HEX2$$e700f500$$ENDHEX$$es de Caixa.
				uo_ge205_cancelamento lvo_cancelamento				
				lvo_cancelamento = Create uo_ge205_cancelamento
				If Not lvo_cancelamento.of_cancela_lancamentos_caixa(lvl_Filial, lvl_NF, lvs_Especie, lvs_Serie) Then
					SqlCa.of_Rollback();
					Destroy(lvo_cancelamento)					
				Else
					SqlCa.of_Commit();					
					Destroy(lvo_cancelamento)
				End If
			End If
		Else
			SqlCa.of_Rollback();
			SqlCa.of_msgDbError( "Erro no cancelamento da nf_venda." + SqlCa.SqlErrText )
		End If
		
	Finally
		If IsNull( lo_sefaz ) Then Destroy lo_sefaz
	End Try

	Parent.dw_2.Event ue_Retrieve()
End If
end event

type dw_5 from datawindow within tabpage_1
event ue_print ( )
boolean visible = false
integer x = 3054
integer y = 660
integer width = 361
integer height = 276
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_relatorio_nf_venda"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

event ue_print();STRING lvs_Especie, &
		 lvs_Serie, &
		 lvs_Cd_Conveniado, &
		 lvs_Cd_Cliente, &
		 lvs_Filial,&
		 lvs_Nm_Cliente,&
		 lvs_Nm_Conveniado,&
		 lvs_Nm_Convenio, &
		 lvs_Cd_Convenio
		 	   
DATE   lvdt_Emissao_de, lvdt_Emissao_ate

LONG lvl_Filial, &
     lvl_Nota_Fiscal, &
	  lvl_Cd_Convenio

lvdt_Emissao_de   = Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_de   [1]
lvdt_Emissao_ate  = Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_ate  [1]

lvl_Filial        = Tab_1.TabPage_1.dw_1.Object.Cd_Filial		 [1]
lvs_Filial        = Tab_1.TabPage_1.dw_1.Object.De_Filial	 [1]

lvl_Nota_Fiscal   = Tab_1.TabPage_1.dw_1.Object.Nr_Nf		    [1]
lvs_Especie       = Tab_1.TabPage_1.dw_1.Object.De_Especie	    [1] 
lvs_Serie         = Tab_1.TabPage_1.dw_1.Object.De_Serie		    [1]

lvs_Cd_Cliente    = Tab_1.TabPage_1.dw_1.Object.Cd_Cliente      [1]
lvs_Nm_Cliente    = Tab_1.TabPage_1.dw_1.Object.Nm_Cliente    [1]

lvl_Cd_Convenio   = Tab_1.TabPage_1.dw_1.Object.Cd_Convenio		[1]
lvs_Nm_Convenio   = Tab_1.TabPage_1.dw_1.Object.Nm_Convenio	[1]

lvs_Cd_Conveniado = Tab_1.TabPage_1.dw_1.Object.Cd_Conveniado   [1]
lvs_Nm_Conveniado = Tab_1.TabPage_1.dw_1.Object.Nm_Conveniado [1]

This.object.st_Periodo.text = String(lvdt_Emissao_de) + ' at$$HEX1$$e900$$ENDHEX$$ ' + String(lvdt_Emissao_ate)

This.object.st_Filial.text  = lvs_Filial + ' (' + String(lvl_Filial) + ')'

If Not IsNull(lvs_Cd_Cliente) and lvs_Cd_Cliente <> ""  Then 
	This.object.st_Cliente.text    = lvs_Nm_Cliente + ' (' + lvs_Cd_Cliente + ')'
End If

If IsNull(lvs_Nm_Conveniado) Then lvs_Nm_Conveniado = ""
If IsNull(lvs_Nm_Convenio)   Then lvs_Nm_Convenio   = ""

If Not IsNull(lvs_Cd_Conveniado) and lvs_Cd_Conveniado <> "" Then 
	This.object.st_Conveniado.text = lvs_Nm_Conveniado + ' (' + lvs_Cd_Conveniado + ')'
End If

If Not IsNull(lvl_Cd_Convenio)   Then 
	This.object.st_Convenio.text   = lvs_Nm_Convenio   + ' (' + String(lvl_Cd_Convenio) + ')'
End If

This.Print()
end event

type dw_6 from dc_uo_dw_base within tabpage_1
integer x = 626
integer y = 1412
integer width = 1495
integer height = 84
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_chave_acesso"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3451
integer height = 1588
long backcolor = 80269524
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
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
integer x = 9
integer y = 8
integer width = 3424
integer height = 1416
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Detalhes da Nota Fiscal"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 64
integer width = 3342
integer height = 1332
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_detalhe_nota"
end type

event ue_postretrieve;Integer lvi_Dependente

Long lvl_Nota,  &
	  lvl_Filial 

String lvs_Nome_Dep,   &
		 lvs_Especie,    &
		 lvs_Serie

If pl_Linhas > 0 Then
	
	lvl_Filial  = Tab_1.TabPage_2.dw_3.Object.cd_filial [1] 
	lvl_Nota    = Tab_1.TabPage_2.dw_3.Object.nr_nf     [1] 
	lvs_Especie = Tab_1.TabPage_2.dw_3.Object.de_especie[1] 
	lvs_Serie   = Tab_1.TabPage_2.dw_3.Object.de_serie  [1] 
	
	If wf_Verifica_Dependente(lvl_Filial, lvl_Nota, lvs_Especie, lvs_Serie, &
									 Ref lvi_Dependente, Ref lvs_Nome_Dep) Then
		Tab_1.TabPage_2.dw_3.Object.cd_dependente_conveniado[1] = lvi_Dependente
		Tab_1.TabPage_2.dw_3.Object.nm_dependente_conveniado[1] = lvs_Nome_Dep
	End If

End If

Return pl_linhas
end event

event ue_recuperar;//OverRide

Long lvl_Linha,   &
	  lvl_Filial,  &
	  lvl_Nota
	  
String lvs_Especie, &
       lvs_Serie

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If lvl_Linha > 0 Then
	
	lvl_Filial  = Tab_1.TabPage_1.dw_2.Object.cd_filial [lvl_Linha]
	lvl_Nota    = Tab_1.TabPage_1.dw_2.Object.nr_nf     [lvl_Linha]
	lvs_Especie = Tab_1.TabPage_1.dw_2.Object.de_especie[lvl_Linha]
	lvs_Serie   = Tab_1.TabPage_1.dw_2.Object.de_serie  [lvl_Linha]
End If

Return dw_3.Retrieve(lvl_Filial, lvl_Nota, lvs_Especie, lvs_Serie)

end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3451
integer height = 1588
long backcolor = 80269524
string text = "Itens"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage_3
integer x = 9
integer y = 8
integer width = 3246
integer height = 1416
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 41
integer y = 56
integer width = 3186
integer height = 1348
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_detalhe_itens_nf_venda"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

Long lvl_Linha
Long lvl_Filial
Long lvl_Nota
	  
String lvs_Especie
String lvs_Serie

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then	
	lvl_Filial			= dw_2.Object.cd_filial		[lvl_Linha]
	lvl_Nota			= dw_2.Object.nr_nf			[lvl_Linha]
	lvs_Especie		= dw_2.Object.de_especie	[lvl_Linha]
	lvs_Serie			= dw_2.Object.de_serie		[lvl_Linha]
End If

Return dw_4.Retrieve( lvl_Filial, lvl_Nota, lvs_Especie, lvs_Serie )

end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_postretrieve;call super::ue_postretrieve;wf_Apresentacao_Venda_Manipulado( )

Return pl_Linhas
end event

