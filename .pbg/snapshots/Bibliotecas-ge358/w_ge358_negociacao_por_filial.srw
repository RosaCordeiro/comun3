HA$PBExportHeader$w_ge358_negociacao_por_filial.srw
forward
global type w_ge358_negociacao_por_filial from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge358_negociacao_por_filial from dc_w_selecao_lista_relatorio
string tag = "w_ge358_negociacao_por_filial"
integer width = 4713
integer height = 2492
string title = "GE358 - Desconto de Negocia$$HEX2$$e700e300$$ENDHEX$$o por Filial"
end type
global w_ge358_negociacao_por_filial w_ge358_negociacao_por_filial

type variables
uo_filial						io_Filial //ge009
uo_ge355_concorrente	io_Concorrente
uo_produto					io_Produto //ge001

STRING ivs_filiais, ivs_nulo
end variables

forward prototypes
public function integer wf_total_utilizado (integer al_filial, date adt_inicio, date adt_fim)
end prototypes

public function integer wf_total_utilizado (integer al_filial, date adt_inicio, date adt_fim);/*Date ldt_Inicio
Date ldt_Termino
ldt_Inicio 	= gf_primeiro_dia_mes ( adt_periodo )
ldt_Termino	= gf_retorna_ultimo_dia_mes ( adt_periodo )
*/
Decimal idc_Total_Utilizado_Mes, idc_Total_Utilizado_Dia
SELECT IsNull(Round(Sum( n.qt_negociada * (	n.vl_preco_unitario * (((Case when n.pc_desconto_negociado > n.pc_desconto_unitario then n.pc_desconto_negociado else n.pc_desconto_unitario end) - n.pc_desconto_unitario) / 100))) ,	2), 0)
	INTO :idc_Total_Utilizado_Mes
FROM cliente_caixa c
	INNER JOIN negociacao_cliente n
	ON n.nr_sequencial_cliente_caixa = c.nr_sequencial
WHERE c.dh_movimentacao >= :adt_inicio AND c.dh_movimentacao <= :adt_fim
	AND n.cd_filial	 	= :al_filial
	AND n.id_situacao 	= 'A'
	AND c.id_situacao in ( 'A', 'C' )
	AND  NOT EXISTS ( select x.nr_nf FROM nf_venda x 
								  WHERE x.cd_filial  		= c.cd_filial
									 AND x.nr_nf      		= c.nr_nf
									 AND x.de_especie 	= c.de_especie
									 AND x.de_serie   		= c.de_serie
									 AND x.dh_cancelamento IS NOT NULL )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o m$$HEX1$$ea00$$ENDHEX$$s no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_Filial ))
	Return -1
End If

SELECT IsNull(Round(Sum( n.qt_negociada * (	n.vl_preco_unitario * (((Case when n.pc_desconto_negociado > n.pc_desconto_unitario then n.pc_desconto_negociado else n.pc_desconto_unitario end) - n.pc_desconto_unitario) / 100))) ,	2), 0)
	INTO :idc_Total_Utilizado_Dia
FROM cliente_caixa c
	INNER JOIN negociacao_cliente n
	ON n.nr_sequencial_cliente_caixa = c.nr_sequencial
WHERE c.dh_movimentacao = :adt_inicio
	AND n.cd_filial	 	= :al_filial
	AND n.id_situacao 	= 'A'
	AND c.id_situacao in ( 'A', 'C' )
	AND   NOT EXISTS ( select x.nr_nf FROM nf_venda x 
								  WHERE x.cd_filial  		= c.cd_filial
									 AND x.nr_nf      		= c.nr_nf
									 AND x.de_especie 	= c.de_especie
									 AND x.de_serie   		= c.de_serie
									 AND x.dh_cancelamento IS NOT NULL )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o dia no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_Filial ))
	Return -1
End If


If idc_Total_Utilizado_Mes < 0 	or IsNull( idc_Total_Utilizado_Mes ) 	Then idc_Total_Utilizado_Mes = 0
If idc_Total_Utilizado_Dia < 0 	or IsNull( idc_Total_Utilizado_Dia ) 	Then idc_Total_Utilizado_Dia = 0

Return 1
end function

on w_ge358_negociacao_por_filial.create
call super::create
end on

on w_ge358_negociacao_por_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DateTime ldh_Atual

io_Filial			= Create uo_filial
io_Concorrente	= Create uo_ge355_concorrente
io_Produto		= Create uo_produto

If Not gf_Data_Parametro(Ref ldh_Atual) Then Return

dw_1.Object.Dh_Inicio		[1] = ldh_Atual
dw_1.Object.Dh_Termino	[1] = ldh_Atual
end event

event close;call super::close;Destroy(io_Filial)
Destroy(io_Concorrente)
Destroy(io_Produto) 
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge358_negociacao_por_filial
integer x = 37
integer y = 832
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge358_negociacao_por_filial
integer x = 0
integer y = 760
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge358_negociacao_por_filial
integer y = 432
integer width = 4585
integer height = 1844
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge358_negociacao_por_filial
integer width = 3191
integer height = 416
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge358_negociacao_por_filial
integer width = 3104
integer height = 324
string dataobject = "dw_ge358_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	If This.GetColumnName() = "nm_concorrente" Then
		
		io_Concorrente.of_Localiza_Concorrente(This.GetText())
		
		If io_Concorrente.Localizado Then
			dw_1.Object.Cd_Concorrente	[1] = io_Concorrente.Cd_Concorrente
			dw_1.Object.Nm_Concorrente	[1] = io_Concorrente.Nm_Concorrente
		Else
			io_Concorrente.of_Inicializa()
		End If
	End If
	
	If This.GetColumnName() = "de_produto" Then
		
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If io_Produto.Localizado Then
			dw_1.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			dw_1.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		Else
			io_Produto.of_Inicializa()
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;long lvl_lojas

dw_2.Event ue_Reset()

Choose Case dwo.Name

	Case "id_filiais"
		
		If Data = 'C' Then
		
			ivs_filiais = ivs_nulo 
			
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
			
		End If

		
	Case "nm_concorrente"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Concorrente.Nm_Concorrente Then
				Return 1
			End If
		Else
			io_Concorrente.of_Inicializa()
			
			This.Object.Cd_Concorrente		[1] = io_Concorrente.Cd_Concorrente
			This.Object.Nm_Concorrente	[1] = io_Concorrente.Nm_Concorrente
		End If
		
	Case "de_produto"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Produto.De_Produto Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge358_negociacao_por_filial
integer y = 512
integer width = 4517
integer height = 1740
string dataobject = "dw_ge358_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;long ll_row
long ll_cd_filial
decimal ldc_preco_venda, ldc_desc, ldc_preco_atual, ldc_desc_concedido

If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

For ll_row = 1 to dw_2.rowcount()
	
	w_Aguarde.uo_Progress.of_SetMax(dw_2.rowcount())
	
	ldc_preco_venda = 0
	ldc_desc = 0
	ldc_preco_atual = 0
	ldc_desc_concedido = 0
	
	ll_cd_filial = this.Object.cd_filial [ll_row] 
	
	io_Produto.of_Localiza_Produto(string(dw_2.Object.Cd_Produto[ll_row]))	

	ldc_preco_venda = io_Produto.of_Preco_Venda_Filial_Matriz( ll_cd_filial )
	dw_2.Object.vl_preco_unitario	[ll_row] 	= ldc_preco_venda
	
	ldc_desc = io_Produto.Of_Desconto_Filial(ll_cd_filial)
	dw_2.Object.pc_desconto_atual [ll_row]	= ldc_desc
	
	ldc_preco_atual = ldc_preco_venda - (  ldc_preco_venda *( ldc_desc  /100) )
	dw_2.Object.preco_atual_unit [ll_row] = ldc_preco_atual 
	
	ldc_desc_concedido = ldc_preco_atual - dw_2.Object.vl_preco_negociado [ll_row]
	dw_2.Object.desc_concedido [ll_row] = ldc_desc_concedido

	w_Aguarde.uo_Progress.of_SetProgress(ll_row)
Next

dw_2.GroupCalc()

Close(w_Aguarde)

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Concorrente
Long ll_Produto

String ls_Efetivado
String lvs_filial

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.Dh_Inicio				[1]
ldh_Termino	= dw_1.Object.Dh_Termino			[1]
lvs_Filial 			= dw_1.Object.id_filiais 				[1]
ll_Concorrente	= dw_1.Object.Cd_Concorrente	[1]
ll_Produto		= dw_1.Object.Cd_Produto			[1]
ls_Efetivado		= dw_1.Object.Id_Efetivado			[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If lvs_Filial = 'C' Then
	If Not IsNull(ivs_Filiais) Then
		This.of_appendwhere( "n.cd_filial in (" + ivs_Filiais + ")")
	End If
Else
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esta consulta poder$$HEX1$$e100$$ENDHEX$$ demorar, para otimiz$$HEX1$$e100$$ENDHEX$$-la voc$$HEX1$$ea00$$ENDHEX$$ pode especificar uma filial.~rDeseja informar a filial?", Question!,YesNo!,1)=1 Then
		dw_1.Event ue_Pos(1, "id_filiais")
		dw_1.SetFocus()
		Return -1
	End If
End If

If Not IsNull(ll_Concorrente) And ll_Concorrente > 0 Then
	This.of_appendwhere("n.cd_concorrente = " + String(ll_Concorrente))
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_appendwhere("n.cd_produto = " + String(ll_Produto))
End If

If ls_Efetivado = 'S' Then
	This.of_appendwhere("c.nr_nf_venda is not null")
Elseif ls_efetivado = 'N' then
	This.of_appendwhere("c.nr_nf_venda is null")
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

Open(w_aguarde)
w_aguarde.Title = 'Carregando informa$$HEX2$$e700f500$$ENDHEX$$es....'

Return This.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge358_negociacao_por_filial
integer x = 3168
integer y = 1308
end type

