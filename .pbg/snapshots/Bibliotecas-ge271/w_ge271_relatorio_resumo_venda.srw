HA$PBExportHeader$w_ge271_relatorio_resumo_venda.srw
forward
global type w_ge271_relatorio_resumo_venda from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge271_relatorio_resumo_venda from dc_w_selecao_lista_relatorio
string tag = "w_ge271_relatorio_resumo_venda"
integer width = 3639
integer height = 1908
string title = "GE271 - Relat$$HEX1$$f300$$ENDHEX$$rio de Resumo de Vendas"
boolean maxbox = true
end type
global w_ge271_relatorio_resumo_venda w_ge271_relatorio_resumo_venda

type variables
uo_filial ivo_filial
end variables

forward prototypes
public function decimal wf_cota_filial (long al_filial, date adt_inicio, date adt_termino)
public subroutine wf_atualiza_cotas ()
public subroutine wf_atualiza_cotas (dc_uo_ds_base ads, date adt_inicio, date adt_termino, string as_tipo)
public function date wf_ultimo_dia_mes (date adt_data)
public subroutine wf_insere_regiao_default ()
end prototypes

public function decimal wf_cota_filial (long al_filial, date adt_inicio, date adt_termino);Decimal lvdc_Cota = 0

Select sum(vl_cota) Into :lvdc_Cota
From cota_filial
Where cd_filial = :al_Filial
  and dh_cota between :adt_Inicio and :adt_Termino
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvdc_Cota) Then lvdc_Cota = 0
	Case 100
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das Cotas")	
End Choose

Return lvdc_Cota
end function

public subroutine wf_atualiza_cotas ();Long	lvl_Total, &
		lvl_Contador, &
		lvl_Filial, &
		lvl_Regiao

Date lvdt_Inicio, &
     lvdt_Termino

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge271_cota") Then
	Destroy(lvds_1)
End If

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando os Valores das Cotas..."

// Atualiza as cotas do per$$HEX1$$ed00$$ENDHEX$$odo
lvdt_Inicio  		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]
lvl_Filial			= dw_1.Object.Cd_Filial		[1]
lvl_Regiao 		= dw_1.Object.Cd_Regiao	[1]

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	lvds_1.of_appendwhere_subquery("c.cd_filial = " + String(lvl_Filial),3)
End If

If Not IsNull(lvl_Regiao) and lvl_Regiao <> 0 Then
	lvds_1.of_appendwhere_subquery("f.cd_regiao = " + String(lvl_Regiao),3)
End If	 

wf_Atualiza_Cotas(lvds_1, lvdt_Inicio, lvdt_Termino, "PERIODO")

// Atualiza as cotas do m$$HEX1$$ea00$$ENDHEX$$s
lvdt_Inicio 		= Date("01/" + String(lvdt_Inicio, "mm/yyyy"))
lvdt_Termino	= wf_Ultimo_Dia_Mes(lvdt_Inicio)

wf_Atualiza_Cotas(lvds_1, lvdt_Inicio, lvdt_Termino, "MES")

Close(w_Aguarde)
Destroy(lvds_1)
end subroutine

public subroutine wf_atualiza_cotas (dc_uo_ds_base ads, date adt_inicio, date adt_termino, string as_tipo);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Filial, &
	  lvl_Find

Decimal lvdc_Cota

dw_2.SetReDraw(False)
If ads.Retrieve(adt_Inicio, adt_Termino) > 0 Then
	lvl_Total = ads.RowCount()
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Filial = ads.Object.Cd_Filial[lvl_Contador]
		
		lvl_Find = dw_2.Find("cd_filial = " + String(lvl_Filial), 1, dw_2.RowCount())
		
		If Not(lvl_Find > 0) Then
			lvl_Find = dw_2.InsertRow(0)
			
			dw_2.Object.cd_filial 			[lvl_Find] = lvl_Filial
			dw_2.Object.nm_fantasia	[lvl_Find] = ads.Object.nm_fantasia	[lvl_Contador]
			dw_2.Object.cd_regiao 		[lvl_Find] = ads.Object.cd_regiao		[lvl_Contador]
			dw_2.Object.cd_porte		[lvl_Find] = ads.Object.cd_porte		[lvl_Contador]
			dw_2.Object.id_rede_filial	[lvl_Find] = ads.Object.id_rede			[lvl_Contador]
			dw_2.Object.id_ordem		[lvl_Find] = IIF(lvl_Filial=534,'2','1')
		End If
		
		lvdc_Cota = ads.Object.Vl_Cota[lvl_Contador]
		
		If as_Tipo = "MES" Then
			dw_2.Object.Vl_Cota_Mes		[lvl_Find] = lvdc_Cota
		Else
			dw_2.Object.Vl_Cota_Periodo	[lvl_Find] = lvdc_Cota
		End If
	Next	
End If
dw_2.Sort( )
dw_2.GroupCalc( )
dw_2.SetReDraw(True)
end subroutine

public function date wf_ultimo_dia_mes (date adt_data);Integer lvi_Mes, &
        lvi_Ano

Date lvdt_Ultimo_Dia

lvi_Mes = Month(adt_Data)
lvi_Ano = Year(adt_Data)

lvi_Mes ++

If lvi_Mes = 13 Then
	lvi_Mes = 1
	lvi_Ano ++
End If

lvdt_Ultimo_Dia = Date("01/" + String(lvi_Mes, "00") + "/" + String(lvi_Ano, "0000"))

lvdt_Ultimo_Dia = RelativeDate(lvdt_Ultimo_Dia, -1)

Return lvdt_Ultimo_Dia

end function

public subroutine wf_insere_regiao_default ();Integer 	lvi_Retorno, &
        		lvi_Linha

Long lvl_Regiao

DataWindowChild lvdwc

lvi_Retorno = dw_1.GetChild("cd_regiao", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_regiao", 0)
		lvdwc.SetItem(lvi_Linha, "de_regiao", "TODAS")
		
		select cd_regiao
		Into :lvl_Regiao
		From regiao
		Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
		Using SQLCa;
		
		If SQLCa.SQLCode = 0 Then
			dw_1.Object.cd_regiao[1] = lvl_Regiao
		Else
			dw_1.Object.cd_regiao[1] = 0	
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da regi$$HEX1$$e300$$ENDHEX$$o default.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If
end subroutine

on w_ge271_relatorio_resumo_venda.create
call super::create
end on

on w_ge271_relatorio_resumo_venda.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Filial = Create uo_Filial

dw_1.Object.Dt_Inicio 	[1] 	= RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -1)
dw_1.Object.Dt_Termino[1] 	= RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -1)

This.ivm_Menu.ivb_Permite_Imprimir = True

wf_Insere_Regiao_Default()

dw_2.Event ue_Retrieve()
end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_preopen;call super::ue_preopen;//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
MaxWidth	= 4960

//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
//Neste caso como s$$HEX1$$e300$$ENDHEX$$o muitos registros o sistema ajusta ao m$$HEX1$$e100$$ENDHEX$$ximo poss$$HEX1$$ed00$$ENDHEX$$vel da tela
MaxHeight	= 9999
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge271_relatorio_resumo_venda
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge271_relatorio_resumo_venda
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge271_relatorio_resumo_venda
integer x = 9
integer y = 192
integer width = 3584
integer height = 1520
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge271_relatorio_resumo_venda
integer x = 9
integer y = 20
integer width = 3584
integer height = 168
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge271_relatorio_resumo_venda
integer x = 32
integer y = 76
integer width = 3543
integer height = 104
string dataobject = "dw_ge271_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.name = "nm_filial" Then
	If Trim(Data) <> "" Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If	
	Else	
		SetNull(ivo_Filial.Cd_Filial)
		ivo_Filial.Nm_Fantasia = ""
		
		This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
		This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge271_relatorio_resumo_venda
integer x = 27
integer y = 244
integer width = 3538
integer height = 1444
string dataobject = "dw_ge271_lista"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long 	lvl_Filial, &
		lvl_Regiao

dw_1.AcceptText()

lvl_Filial		= dw_1.Object.Cd_Filial		[1]
lvl_Regiao 	= dw_1.Object.Cd_Regiao	[1]

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	This.of_appendwhere_Subquery("r.cd_filial = " + String(lvl_Filial),3)
End If

If Not IsNull(lvl_Regiao) and lvl_Regiao <> 0 Then
	This.of_appendwhere_Subquery("f.cd_regiao = " + String(lvl_Regiao),3)
End If	 

Return 1
end event

event dw_2::ue_recuperar;// Override

Date lvdt_Inicio, &
     lvdt_Termino
	  
lvdt_Inicio		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	wf_Atualiza_Cotas()
End If
This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)
This.ivm_Menu.mf_Imprimir(pl_Linhas > 0)

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
This.ivm_Menu.mf_Imprimir(False)
end event

event dw_2::constructor;call super::constructor;String	lvs_Coluna[], &
		lvs_Nome[]
		 
Integer  lvi_ColX

lvs_Coluna = {	"id_ordem",&
					"cd_filial", &
					"nm_fantasia", &
					"cd_porte", &
					"cd_regiao", &
					"avista", &
					"aprazo", &
					"devolucao", &
					"venda_bruta", &
					"venda_liquida", &
					"clientes", &
					"vl_cota_mes", &
					"vl_cota_periodo", &
					"pc_cota_atingida"}

lvs_Nome = {	"Ordem",&
					"C$$HEX1$$f300$$ENDHEX$$digo da Filial", &
					"Nome de Fantasia", &
					"Porte Filial", &
					"Regi$$HEX1$$e300$$ENDHEX$$o", &
					"Vendas $$HEX1$$e000$$ENDHEX$$ Vista", &
					"Vendas $$HEX1$$e000$$ENDHEX$$ Prazo", &
					"Devolu$$HEX2$$e700e300$$ENDHEX$$o", &
					"Total Vendas", &
					"Total L$$HEX1$$ed00$$ENDHEX$$quido", &
					"Clientes", &
					"Cota do M$$HEX1$$ea00$$ENDHEX$$s", &
					"Cota do Per$$HEX1$$ed00$$ENDHEX$$odo", &
					"% Atingido"}

dw_2.of_SetSort(lvs_Coluna, lvs_Nome)
dw_2.of_SetFilter(lvs_Coluna, lvs_Nome)

dw_2.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge271_relatorio_resumo_venda
integer x = 2853
integer y = 212
integer width = 649
integer height = 328
integer taborder = 50
string dataobject = "dw_ge271_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;String 	lvs_Periodo, &
			lvs_Regiao

Date 	lvdt_Inicio, &
     	lvdt_Termino
	  
DataWindowChild lvdwc_Tipo
  
lvdt_Inicio  		= dw_1.Object.Dt_Inicio 		[1]
lvdt_Termino 	= dw_1.Object.Dt_Termino	[1]

lvs_Periodo = String(lvdt_Inicio, "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + String(lvdt_Termino, "dd/mm/yyyy")

dw_1.GetChild("cd_regiao", lvdwc_Tipo)	
lvs_Regiao = lvdwc_Tipo.GetItemString(lvdwc_Tipo.GetRow(), "de_regiao") 	

dw_3.Object.Periodo_Cabecalho.Text 	= lvs_Periodo
dw_3.Object.Regiao_t.Text 					= lvs_Regiao
dw_3.Sort()

Return AncestorReturnValue
end event

