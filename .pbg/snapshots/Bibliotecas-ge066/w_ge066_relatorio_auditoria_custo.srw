HA$PBExportHeader$w_ge066_relatorio_auditoria_custo.srw
forward
global type w_ge066_relatorio_auditoria_custo from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge066_relatorio_auditoria_custo from dc_w_selecao_lista_relatorio
integer width = 3712
integer height = 1896
string title = "GE066 - Relat$$HEX1$$f300$$ENDHEX$$rio de Auditoria de Custos"
end type
global w_ge066_relatorio_auditoria_custo w_ge066_relatorio_auditoria_custo

type variables
uo_produto ivo_produto
uo_filial ivo_filial
end variables

forward prototypes
public subroutine wf_localiza_produto ()
public subroutine wf_localiza_filial ()
public function date wf_primeiro_mes_saldo (long pl_filial, long pl_produto)
public function long wf_saldo_inicial (long pl_filial, long pl_produto, date pdt_inicio)
end prototypes

public subroutine wf_localiza_produto ();String lvs_Produto

lvs_Produto = dw_1.GetText()

ivo_Produto.of_Localiza_Produto(lvs_Produto)

If ivo_Produto.Localizado Then
	dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If
end subroutine

public subroutine wf_localiza_filial ();String lvs_Filial

lvs_Filial = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Filial)

If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial  [1] = ivo_Filial.Cd_Filial
	dw_1.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
End If
end subroutine

public function date wf_primeiro_mes_saldo (long pl_filial, long pl_produto);DateTime lvdh_Saldo

Date lvdt_Retorno

lvdt_Retorno = Date("01/01/1900")

Select min(dh_saldo) Into :lvdh_Saldo
From saldo_produto
Where cd_filial  = :pl_Filial
  and cd_produto = :pl_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvdh_Saldo) Then
			lvdt_Retorno = Date(lvdh_Saldo)
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Primeiro m$$HEX1$$ea00$$ENDHEX$$s de movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do primeiro m$$HEX1$$ea00$$ENDHEX$$s de movimenta$$HEX2$$e700e300$$ENDHEX$$o.")		
End Choose

Return lvdt_Retorno
end function

public function long wf_saldo_inicial (long pl_filial, long pl_produto, date pdt_inicio);Long lvl_Saldo = -111111

Date lvdt_Anterior, &
     lvdt_Saldo, &
	  lvdt_Primeiro_Saldo

lvdt_Anterior = RelativeDate(pdt_Inicio, -1)

lvdt_Saldo = Date(String(lvdt_Anterior, "01/mm/yyyy"))

Select qt_saldo_final Into :lvl_Saldo
From saldo_produto
Where cd_filial  = :pl_Filial
  and cd_produto = :pl_Produto
  and dh_saldo   = :lvdt_Saldo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		lvdt_Primeiro_Saldo = wf_Primeiro_Mes_Saldo(pl_filial,pl_Produto)
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O saldo inicial do produto n$$HEX1$$e300$$ENDHEX$$o foi localizado.~rO primeiro " + &
		                      "saldo dispon$$HEX1$$ed00$$ENDHEX$$vel $$HEX1$$e900$$ENDHEX$$ do m$$HEX1$$ea00$$ENDHEX$$s '" + String(lvdt_Primeiro_Saldo, "mm/yyyy") + &
									 "'.~r~rSer$$HEX1$$e100$$ENDHEX$$ considerado saldo inicial igual a zero.", Information!)
		
		lvl_Saldo = 0
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo inicial do produto.")
End Choose

Return lvl_Saldo
end function

on w_ge066_relatorio_auditoria_custo.create
call super::create
end on

on w_ge066_relatorio_auditoria_custo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Parametro

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

dw_1.Object.Dt_Inicio[1]  = Date(String(lvdt_Parametro, "01/mm/yyyy"))
dw_1.Object.Dt_Termino[1] = lvdt_Parametro

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event open;call super::open;ivo_Produto = Create uo_Produto
ivo_Filial  = Create uo_Filial
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge066_relatorio_auditoria_custo
integer x = 23
integer y = 344
integer width = 3625
integer height = 1352
integer taborder = 0
integer weight = 700
string text = "Movimenta$$HEX2$$e700e300$$ENDHEX$$o de Estoque"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge066_relatorio_auditoria_custo
integer x = 23
integer y = 4
integer width = 2277
integer height = 328
integer taborder = 0
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge066_relatorio_auditoria_custo
integer x = 50
integer y = 60
integer width = 2240
integer height = 264
integer taborder = 10
string dataobject = "dw_ge066_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

Choose Case dwo.Name 
	Case "nm_fantasia"
	
		SetNull(lvl_Nulo)
	
		If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Filial[1] = lvl_nulo
			Return 0
		End If	
		
		If Data <> ivo_Filial.Nm_Fantasia Then Return 1

	Case "de_produto"
		SetNull(lvl_Nulo)
	
		If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Produto[1] = lvl_nulo
			Return 0
		End If	
		
		If Data <> ivo_Produto.De_Produto Then Return 1
End Choose
end event

event dw_1::losefocus;If IsValid(ivo_Produto) Then
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Filial) Then
	dw_1.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
End If

end event

event dw_1::ue_key;If Key = KeyEnter! Then
	Choose Case GetColumnName() 
		Case "de_produto" 
			wf_Localiza_Produto()
			
		Case "nm_fantasia"
			wf_Localiza_Filial()
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge066_relatorio_auditoria_custo
integer x = 55
integer y = 400
integer width = 3570
integer height = 1280
integer taborder = 20
string dataobject = "dw_ge066_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// Override

Date lvdt_Inicio, &
     lvdt_Termino
	  
Long lvl_Produto, &
     lvl_Saldo_Inicial, &
	  lvl_Filial

dw_1.AcceptText()	

lvl_Filial   = dw_1.Object.Cd_Filial[1]
lvl_Produto  = dw_1.Object.Cd_Produto[1]
lvdt_Inicio  = dw_1.Object.Dt_Inicio[1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

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

lvl_Saldo_Inicial = wf_Saldo_Inicial(lvl_Filial, lvl_Produto, lvdt_Inicio)

If lvl_Saldo_Inicial = -111111 Then Return -1

dw_3.Object.st_filial.Text = dw_1.Object.Nm_Fantasia[1]

Return This.Retrieve(lvl_Filial,lvl_Produto, lvdt_Inicio, lvdt_Termino, lvl_Saldo_Inicial)
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"dh_movimento", "dh_movimentacao_custo","de_tipo_movimento","qt_movimento","vl_custo_unitario", &
              "total_custo_produto","nr_nf","de_especie","de_serie", &
				  "filial_fornec_cli_conv","nr_movimento_estoque"}

lvs_Nome = {"data movimento","data custo","tipo movimento","qtde movimento","custo unitario","total custo",&
            "nota fiscal","esp$$HEX1$$e900$$ENDHEX$$cie","s$$HEX1$$e900$$ENDHEX$$rie","origem / destino","Nr movimento_estoque"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		 

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge066_relatorio_auditoria_custo
integer x = 2601
integer y = 24
integer width = 681
integer height = 200
integer taborder = 0
string dataobject = "dw_ge066_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino
	  
lvdt_Inicio  = dw_1.Object.Dt_Inicio[1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

dw_3.Object.Periodo_t.Text = String(lvdt_Inicio, "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
                             String(lvdt_Termino, "dd/mm/yyyy")

dw_3.Object.Produto_t.Text = String(ivo_Produto.Cd_Produto) + "  -  " + &
                             ivo_Produto.ivs_Descricao_Apresentacao_Venda

Return AncestorReturnValue
end event

