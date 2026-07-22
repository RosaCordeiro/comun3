HA$PBExportHeader$w_ge058_relatorio_movimentacao_estoque.srw
forward
global type w_ge058_relatorio_movimentacao_estoque from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge058_relatorio_movimentacao_estoque
end type
type gb_3 from groupbox within w_ge058_relatorio_movimentacao_estoque
end type
end forward

global type w_ge058_relatorio_movimentacao_estoque from dc_w_selecao_lista_relatorio
integer width = 4082
integer height = 1880
string title = "GE058 - Relat$$HEX1$$f300$$ENDHEX$$rio de Movimenta$$HEX2$$e700e300$$ENDHEX$$o de Estoque"
dw_4 dw_4
gb_3 gb_3
end type
global w_ge058_relatorio_movimentacao_estoque w_ge058_relatorio_movimentacao_estoque

type variables
uo_produto ivo_produto

uo_filial ivo_filial
end variables

forward prototypes
public function boolean wf_primeiro_mes_saldo (long al_filial, long al_produto, ref datetime adh_mes)
public function boolean wf_cliente (string as_codigo, ref string as_nome)
public function boolean wf_fornecedor (string as_codigo, ref string as_nome)
public function boolean wf_filial (long al_codigo, ref string as_nome)
public function boolean wf_convenio (long al_codigo, ref string as_nome)
public function boolean wf_saldo_periodo (long al_filial, long al_produto, date adt_inicio, date adt_fim, ref long al_saldo)
public function boolean wf_saldo_inicial (long al_filial, long al_produto, date adt_inicio, date adt_fim, ref long al_saldo)
public function boolean wf_nota_diversa (long pl_cd_filial, datetime pdh_mov_caixa, long pl_nr_ajuste, long pl_cd_produto, ref long pl_nr_nf, ref string ps_de_especie, ref string ps_de_serie, ref string ps_de_origem)
end prototypes

public function boolean wf_primeiro_mes_saldo (long al_filial, long al_produto, ref datetime adh_mes);Boolean lvb_Sucesso = True

Select min(dh_saldo) Into :adh_Mes
From saldo_produto
Where cd_filial  = :al_Filial
  and cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Primeiro m$$HEX1$$ea00$$ENDHEX$$s de movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		adh_Mes = DateTime("01/01/1990")
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Primeiro M$$HEX1$$ea00$$ENDHEX$$s de Movimenta$$HEX2$$e700e300$$ENDHEX$$o")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean wf_cliente (string as_codigo, ref string as_nome);Boolean lvb_Sucesso = False

Select nm_cliente Into :as_Nome
From cliente
Where cd_cliente = :as_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cliente '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nome do Cliente")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_fornecedor (string as_codigo, ref string as_nome);Boolean lvb_Sucesso = False

Select nm_razao_social Into :as_Nome
From fornecedor
Where cd_fornecedor = :as_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nome do Fornecedor")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_filial (long al_codigo, ref string as_nome);Boolean lvb_Sucesso = False

Select cast(cd_filial as varchar)+' - '+nm_fantasia  Into :as_Nome
From filial
Where cd_filial = :al_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(al_Codigo) + "' n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nome da Filial")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_convenio (long al_codigo, ref string as_nome);Boolean lvb_Sucesso = False

Select nm_fantasia Into :as_Nome
From convenio
Where cd_convenio = :al_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Conv$$HEX1$$ea00$$ENDHEX$$nio '" + String(al_Codigo) + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nome do Conv$$HEX1$$ea00$$ENDHEX$$nio")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_saldo_periodo (long al_filial, long al_produto, date adt_inicio, date adt_fim, ref long al_saldo);DataStore lds

Boolean lvb_Sucesso

Date lvdt_Fim

Long 	lvl_Qt_Movimento

Integer	lvi_Linhas,&
			lvi_Linha

String 	lvs_Id_Entrada_Saida, &
			lvs_Id_Cancelamento	

Try
	lvb_Sucesso = True
	
	lvdt_Fim = RelativeDate(adt_fim, 0)	
	
	lds = Create DataStore
	lds.DataObject = "dw_ge058_lista_saldo_periodo"
	
	lds.SetTransObject(SqlCa)
	
	lvi_Linhas = lds.Retrieve(al_filial, al_produto, adt_inicio, lvdt_Fim)
	
	al_saldo = 0
	For lvi_Linha = 1 To lvi_Linhas
		
		lvs_Id_Entrada_Saida	= lds.Object.id_entrada_saida	[lvi_Linha]
		lvs_Id_Cancelamento	= lds.Object.id_cancelamento	[lvi_Linha]
		lvl_Qt_Movimento		= lds.Object.qt_movimento	[lvi_Linha]
		
		IF lvs_Id_Entrada_Saida = 'E' AND  lvs_Id_Cancelamento = 'N' Then	//Soma
			al_saldo += lvl_Qt_Movimento 
		ElseIF lvs_Id_Entrada_Saida = 'E' AND  lvs_Id_Cancelamento = 'S' Then	 //Diminui
			 al_saldo -= lvl_Qt_Movimento
		ElseIF lvs_Id_Entrada_Saida = 'S' AND  lvs_Id_Cancelamento = 'S' Then	 //Soma
			al_saldo += lvl_Qt_Movimento 
		ElseIF lvs_Id_Entrada_Saida = 'S' AND  lvs_Id_Cancelamento = 'N' Then //Diminui
			al_saldo -= lvl_Qt_Movimento 
		End If
	
	Next

catch ( runtimeerror  lo_rte )
	MessageBox (	"Erro", "Ocorreu erro ao localizar o saldo do per$$HEX1$$ed00$$ENDHEX$$odo de " + &
 						String(adt_inicio, "dd/mm/yyyy")+" a " +String(adt_fim, "dd/mm/yyyy")+"~r~r"+ &
 						"Erro: "+lo_rte.GetMessage( ))
						 
	lvb_Sucesso = False
End Try	

Destroy(lds)
  
Return lvb_Sucesso
end function

public function boolean wf_saldo_inicial (long al_filial, long al_produto, date adt_inicio, date adt_fim, ref long al_saldo);Boolean 	lvb_Sucesso = False
Date 		lvdt_Inicio_Mes, ldt_hoje
DateTime lvdh_Primeiro_Saldo
Long 		lvl_Saldo_periodo_inicio_hoje


ldt_hoje	= Date(gf_GetServerDate())

lvdt_Inicio_Mes = Date(String(ldt_hoje, "01/mm/yyyy"))

If not wf_saldo_periodo(al_filial, al_produto, adt_inicio, ldt_hoje, ref lvl_Saldo_periodo_inicio_hoje) Then
	Return False	
End IF

SELECT qt_saldo_final 
INTO :al_Saldo
FROM saldo_produto
WHERE cd_filial = :al_Filial
AND cd_produto = :al_Produto
AND dh_saldo = :lvdt_Inicio_Mes
USING SQLCA;

Choose Case SqlCa.SqlCode
	Case 0
		if IsNull(lvl_Saldo_periodo_inicio_hoje) then lvl_Saldo_periodo_inicio_hoje = 0
		
		al_Saldo -= lvl_Saldo_periodo_inicio_hoje
		
		lvb_Sucesso = True
		
	Case 100
		If wf_Primeiro_Mes_Saldo(al_Filial, al_Produto, ref lvdh_Primeiro_Saldo) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O saldo inicial do produto n$$HEX1$$e300$$ENDHEX$$o foi localizado.~rO primeiro " + &
										 "saldo dispon$$HEX1$$ed00$$ENDHEX$$vel $$HEX1$$e900$$ENDHEX$$ do m$$HEX1$$ea00$$ENDHEX$$s '" + String(lvdh_Primeiro_Saldo, "mm/yyyy") + &
										 "'.~r~rSer$$HEX1$$e100$$ENDHEX$$ considerado saldo inicial igual a zero.", Information!)
			
			al_Saldo = 0
			lvb_Sucesso = True
		End If
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo Inicial do Produto")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_nota_diversa (long pl_cd_filial, datetime pdh_mov_caixa, long pl_nr_ajuste, long pl_cd_produto, ref long pl_nr_nf, ref string ps_de_especie, ref string ps_de_serie, ref string ps_de_origem);long ll_nr_nf
string ls_de_especie, ls_de_serie, ls_de_origem

select top 1 ws.nr_nf, ws.de_especie, ws.de_serie, fi.nm_fantasia 
into :ll_nr_nf, :ls_de_especie, :ls_de_serie, :ls_de_origem
from ajuste_estoque ae
	inner join wms_ajuste_estoque we on we.nr_ajuste = ae.nr_ajuste_wms 
	inner join wms_int_sap ws on ws.nr_agrupamento_dev_compra = we.nr_agrupamento_dev_compra 
	inner join .wms_int_sap_detalhe wisd
        on wisd.nr_integracao = ws.nr_integracao 
        and wisd.cd_produto = ae.cd_produto 
        and wisd.qt_lote  = we.qt_ajuste  
        and wisd.nr_lote = we.nr_lote 
	inner join filial fi on fi.cd_filial = ae.cd_filial_ajuste
WHERE ae.dh_movimentacao_caixa = :pdh_mov_caixa
and ae.cd_filial_ajuste = :pl_cd_filial
and ae.cd_produto = :pl_cd_produto
and ae.nr_ajuste = :pl_nr_ajuste;

if sqlca.sqlcode = -1 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao consultar a tabela wms_ajuste_estoque: ' + sqlca.sqlerrtext)
	return false
ENd if

pl_nr_nf = ll_nr_nf
ps_de_especie = ls_de_especie
ps_de_serie = ls_de_serie 
ps_de_origem = ls_de_origem 

return true
end function

on w_ge058_relatorio_movimentacao_estoque.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.gb_3
end on

on w_ge058_relatorio_movimentacao_estoque.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.gb_3)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto	= Create uo_Produto
ivo_Filial		= Create uo_Filial

ivm_Menu.ivb_Permite_Imprimir = True

dw_1.Object.Dt_Inicio		[1] = Date("01/" + String(Today(), "mm/yyyy"))
dw_1.Object.Dt_Termino[1] = Today()

dw_1.SetFocus()

end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge058_relatorio_movimentacao_estoque
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge058_relatorio_movimentacao_estoque
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge058_relatorio_movimentacao_estoque
integer x = 18
integer y = 408
integer width = 4005
integer height = 1276
string text = "Movimentos de Estoque"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge058_relatorio_movimentacao_estoque
integer x = 18
integer y = 0
integer width = 1797
integer height = 392
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge058_relatorio_movimentacao_estoque
integer x = 41
integer y = 56
integer width = 1746
integer height = 324
string dataobject = "dw_ge058_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_4.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
		
	Case "nm_filial"
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If
End Choose
end event

event dw_1::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
			
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If
			
	End Choose
End If
end event

event dw_1::editchanged;call super::editchanged;dw_4.Event ue_Reset()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge058_relatorio_movimentacao_estoque
integer x = 50
integer y = 468
integer width = 3954
integer height = 1196
string dataobject = "dw_ge058_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// Override
Long	lvl_Filial, &
		lvl_Produto, &
		lvl_Saldo_Inicial,&
		lvl_Tipo_Movimento

Date	lvdt_Inicio, &
		lvdt_Termino
	  
dw_1.AcceptText()

lvl_Filial					= dw_1.Object.Cd_Filial				[1]
lvl_Produto				= dw_1.Object.Cd_Produto			[1]
lvdt_Inicio				= dw_1.Object.Dt_Inicio 				[1]
lvdt_Termino			= dw_1.Object.Dt_Termino			[1]
lvl_Tipo_Movimento	=dw_1.Object.cd_tipo_movimento	[1]

If IsNull(lvl_Filial) or lvl_Filial = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.", Information!)
	dw_1.Event ue_Pos(1, "nm_filial")
	Return -1
End If

If IsNull(lvl_Produto) or lvl_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.", Information!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1
End If

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If Not wf_Saldo_Inicial(lvl_Filial, lvl_Produto, lvdt_Inicio, lvdt_Termino, ref lvl_Saldo_Inicial) Then
	Return -1
End If

If lvl_Tipo_Movimento <> 0 Then
	This.of_AppendWhere(" t.cd_tipo_movimento = "+String(lvl_Tipo_Movimento))
End If

Return This.Retrieve(lvl_Filial, lvl_Produto, lvdt_Inicio, lvdt_Termino, lvl_Saldo_Inicial)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long	lvl_Contador, &
		lvl_Filial, &
		lvl_Convenio, lvl_cd_produto, lvl_nr_nf, lvl_nr_ajuste
	  
String	lvs_Cliente, &
		lvs_Fornecedor, &
		lvs_Origem_Destino, lvs_de_especie, lvs_de_serie

String lvs_id_tipo_mov

Datetime lvdh_movimento

If pl_Linhas > 0 Then

	This.SetRedraw(False)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Origem e Destino dos Movimentos..."
	
	w_Aguarde.uo_Progress.of_SetMax(pl_Linhas)
	
	For lvl_Contador = 1 To pl_Linhas
		lvl_Filial			= This.Object.Cd_Filial			[lvl_Contador]
		lvl_Convenio		= This.Object.Cd_Convenio		[lvl_Contador]
		lvs_Fornecedor	= This.Object.Cd_Fornecedor	[lvl_Contador]
		lvs_Cliente		= This.Object.Cd_Cliente			[lvl_Contador]
		lvs_id_tipo_mov = This.Object.id_tipo_movimento	[lvl_Contador]
		lvdh_movimento = this.object.dh_movimento[lvl_Contador]
		lvl_cd_produto = this.object.cd_produto[lvl_Contador]
		lvl_nr_ajuste = this.object.nr_nf[lvl_Contador]
		
		lvs_Origem_Destino = ""
		
		//Busca o numero das notas de Ajuste de estoque da filial 534(Estoque central):
		if lvs_id_tipo_mov = 'A' and ivo_filial.cd_filial = 534 Then
		
			if Not wf_nota_diversa(ivo_filial.cd_filial, lvdh_movimento, lvl_nr_ajuste, lvl_cd_produto, ref lvl_nr_nf, ref lvs_de_especie, ref lvs_de_serie, ref lvs_Origem_Destino) then return -1
			
			if lvl_nr_nf > 0 and not isnull(lvl_nr_nf) then
				this.object.nr_nf[lvl_Contador] = lvl_nr_nf
				this.object.de_especie[lvl_Contador] = lvs_de_especie
				this.object.serie[lvl_Contador] = lvs_de_serie
			ENd if
		
		ELse
			If Not IsNull(lvs_Cliente) Then
				wf_Cliente(lvs_Cliente, ref lvs_Origem_Destino)
			Else
				If Not IsNull(lvs_Fornecedor) Then
					wf_Fornecedor(lvs_Fornecedor, ref lvs_Origem_Destino)
				Else
					If Not IsNull(lvl_Filial) Then
						wf_Filial(lvl_Filial, ref lvs_Origem_Destino)
					Else
						If Not IsNull(lvl_Convenio) Then
							wf_Convenio(lvl_Convenio, ref lvs_Origem_Destino)
						End If
					End If
				End If
			End If
		End if
		
		If Trim(lvs_Origem_Destino) <> "" Then
			This.Object.De_Origem_Destino[lvl_Contador] = lvs_Origem_Destino
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	Close(w_Aguarde)
	This.SetRedraw(True)

End If

This.ivm_menu.mf_SalvarComo(pl_linhas > 0)
This.ivm_menu.mf_Imprimir(pl_linhas > 0)

Return pl_Linhas
end event

event dw_2::ue_saveas;//override
dw_3.Event ue_SaveAs()
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
This.ivm_menu.mf_Imprimir(False)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;Long	ll_Filial_Movimento,&
		ll_Produto,&
		ll_Nota,&
		ll_Tipo_Movimento,&
		ll_Filial
		
String		ls_Especie,&
			ls_Serie,&
			ls_Tipo
			
If currentRow > 0 Then
	dw_2.AcceptText()
	
	ll_Filial_Movimento	=	dw_2.object.cd_filial_movimento	[currentRow]
	ll_Produto				=	dw_2.object.cd_produto				[currentRow]
	ll_Nota					=	dw_2.object.nr_nf						[currentRow]
	ls_Especie				=	dw_2.object.de_especie				[currentRow]
	ls_Serie					=	dw_2.object.serie						[currentRow]
	ll_Tipo_movimento	=	dw_2.object.cd_tipo_movimento	[currentRow]
	ll_Filial					=	dw_2.object.cd_filial					[currentRow]
	
	Choose Case ll_Tipo_movimento
		Case 16
			ls_Tipo = 'CO' //COMPRA BONIFICADA SEM CUSTO
		Case 3	
			ls_Tipo = 'CO' //COMPRA
		Case 14
			ls_Tipo = 'DC' //DEVOLU$$HEX2$$c700c300$$ENDHEX$$O DE COMPRA
		Case 6
			ls_Tipo = 'TR' //TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA DE SA$$HEX1$$cd00$$ENDHEX$$DA
		Case 5
			ls_Tipo = 'TR' //TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA DE ENTRADA
			ll_Filial_Movimento = ll_Filial
		Case 10
			ls_Tipo = 'DV' //DEVOLU$$HEX2$$c700c300$$ENDHEX$$O DE VENDA
	End Choose		

	dw_4.Retrieve(ll_Filial_Movimento, ll_Produto, ll_Nota, ls_Especie, ls_Serie, ls_Tipo)

End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge058_relatorio_movimentacao_estoque
integer x = 1938
integer y = 36
integer height = 256
string dataobject = "dw_ge058_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino


lvdt_Inicio		= dw_1.Object.Dt_Inicio 		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

This.Object.Cabecalho_Periodo.Text = String(lvdt_Inicio, "dd/mm/yyyy") + "  $$HEX1$$e000$$ENDHEX$$ " + String(lvdt_Termino, "dd/mm/yyyy")
This.Object.Cabecalho_Filial.Text  = ivo_Filial.Nm_Fantasia + " (" + String(ivo_Filial.Cd_Filial) + ")"
This.Object.Cabecalho_Produto.Text = ivo_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(ivo_Produto.Cd_Produto) + ")"

Return AncestorReturnValue
end event

type dw_4 from dc_uo_dw_base within w_ge058_relatorio_movimentacao_estoque
integer x = 2473
integer y = 44
integer width = 1522
integer height = 272
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge058_lotes"
boolean vscrollbar = true
end type

type gb_3 from groupbox within w_ge058_relatorio_movimentacao_estoque
integer x = 2446
integer width = 1573
integer height = 324
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lotes"
borderstyle borderstyle = styleraised!
end type

