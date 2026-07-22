HA$PBExportHeader$w_ge358_desempenho_cobre_preco.srw
forward
global type w_ge358_desempenho_cobre_preco from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge358_desempenho_cobre_preco from dc_w_selecao_lista_relatorio
string tag = "w_ge358_desempenho_cobre_preco"
integer width = 4745
integer height = 2492
string title = "GE358 - Desempenho Cobre Pre$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge358_desempenho_cobre_preco w_ge358_desempenho_cobre_preco

type variables
uo_filial io_Filial //ge009

STRING ivs_filiais, ivs_nulo
end variables

forward prototypes
public function integer wf_uso_cobre_preco (integer al_filial, date adt_periodo, integer al_linha, integer al_coluna)
public subroutine wf_fat_cobre_preco (integer al_cd_filial, date adt_dt_periodo, integer al_linha, integer al_coluna)
public subroutine wf_fat_meta_cobre_preco (integer al_cd_filial, date adt_periodo, integer al_linha, integer al_coluna)
public subroutine wf_num_clientes_cobre_preco (integer al_cd_filial, date adt_periodo, integer al_linha, integer al_coluna)
end prototypes

public function integer wf_uso_cobre_preco (integer al_filial, date adt_periodo, integer al_linha, integer al_coluna);Decimal ldc_Total_Utilizado_Mes
Date ldt_Inicio, ldt_Termino

ldt_Inicio 	= gf_primeiro_dia_mes ( adt_periodo )
ldt_Termino	= gf_retorna_ultimo_dia_mes ( adt_periodo )

SELECT IsNull(Round( Sum( n.qt_negociada * ( n.vl_preco_unitario * (((Case when n.pc_desconto_negociado > n.pc_desconto_unitario then n.pc_desconto_negociado else n.pc_desconto_unitario end	) - n.pc_desconto_unitario) / 100))) ,	2), 0)
	INTO :ldc_Total_Utilizado_Mes
FROM cliente_caixa c
INNER JOIN negociacao_cliente n
	ON n.nr_sequencial_cliente_caixa = c.nr_sequencial
	and n.cd_filial = c.cd_filial
WHERE (c.dh_movimentacao between :ldt_Inicio and :ldt_Termino)
	AND n.cd_filial	 	= :al_filial
	AND n.id_situacao 	= 'A'
	AND c.id_situacao in ( 'A', 'C' )
	AND  NOT EXISTS ( select x.nr_nf FROM nf_venda x 
								  WHERE x.cd_filial  		= c.cd_filial
									 AND x.nr_nf      		= c.nr_nf_venda
									 AND x.de_especie 	= c.de_especie_venda
									 AND x.de_serie   		= c.de_serie_venda
									 AND x.dh_cancelamento IS NOT NULL )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o m$$HEX1$$ea00$$ENDHEX$$s no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_Filial ))
	Return -1
End If

Choose case al_coluna 
	case 1
		dw_2.Object.periodo01 [al_linha] = ldc_Total_Utilizado_Mes
	case 2
		dw_2.Object.periodo02 [al_linha] = ldc_Total_Utilizado_Mes
	case 3
		dw_2.Object.periodo03 [al_linha] = ldc_Total_Utilizado_Mes		
	case 4
		dw_2.Object.periodo04 [al_linha] = ldc_Total_Utilizado_Mes
	case 5
		dw_2.Object.periodo05 [al_linha] = ldc_Total_Utilizado_Mes
	case 6
		dw_2.Object.periodo06 [al_linha] = ldc_Total_Utilizado_Mes
End choose

Return 1
end function

public subroutine wf_fat_cobre_preco (integer al_cd_filial, date adt_dt_periodo, integer al_linha, integer al_coluna);long ll_tot_fat
Date ldt_Inicio, ldt_Termino

ldt_Inicio 	= gf_primeiro_dia_mes ( adt_dt_periodo )
ldt_Termino	= gf_retorna_ultimo_dia_mes ( adt_dt_periodo)

select sum (vl_total_nf) 
into :ll_tot_fat
from nf_venda 
where dh_movimentacao_caixa between :ldt_Inicio and :ldt_Termino
	and cd_filial = :al_cd_filial
using SQLCA;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o m$$HEX1$$ea00$$ENDHEX$$s no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_cd_Filial ))

End If

Choose case al_coluna 
	case 1
		dw_2.Object.periodo01_2 [al_linha] = ll_tot_fat
	case 2
		dw_2.Object.periodo02_2 [al_linha] = ll_tot_fat		
	case 3
		dw_2.Object.periodo03_2 [al_linha] = ll_tot_fat		
	case 4
		dw_2.Object.periodo04_2 [al_linha] = ll_tot_fat		
	case 5
		dw_2.Object.periodo05_2 [al_linha] = ll_tot_fat		
	case 6
		dw_2.Object.periodo06_2 [al_linha] = ll_tot_fat		
End Choose		
end subroutine

public subroutine wf_fat_meta_cobre_preco (integer al_cd_filial, date adt_periodo, integer al_linha, integer al_coluna);Decimal ldc_Sum_Cota_Mes_Filial
Date ldt_Inicio, ldt_Termino

ldt_Inicio 	= gf_primeiro_dia_mes ( adt_periodo )
ldt_Termino	= gf_retorna_ultimo_dia_mes ( adt_periodo)

SELECT isnull(sum( vl_cota ),0)
INTO :ldc_Sum_Cota_Mes_Filial
FROM cota_filial 
WHERE cd_filial = :al_cd_filial
	and (dh_cota between :adt_periodo and :ldt_Termino)
 Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o m$$HEX1$$ea00$$ENDHEX$$s no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_cd_Filial ))
End If

Choose  case al_coluna
	Case 1
		dw_2.Object.periodo01_3 [al_linha] = ldc_Sum_Cota_Mes_Filial
	Case 2
		dw_2.Object.periodo02_3 [al_linha] = ldc_Sum_Cota_Mes_Filial
	Case 3
		dw_2.Object.periodo03_3 [al_linha] = ldc_Sum_Cota_Mes_Filial
	Case 4
		dw_2.Object.periodo04_3 [al_linha] = ldc_Sum_Cota_Mes_Filial
	Case 5
		dw_2.Object.periodo05_3 [al_linha] = ldc_Sum_Cota_Mes_Filial
	Case 6
		dw_2.Object.periodo06_3 [al_linha] = ldc_Sum_Cota_Mes_Filial
		
End Choose
end subroutine

public subroutine wf_num_clientes_cobre_preco (integer al_cd_filial, date adt_periodo, integer al_linha, integer al_coluna);decimal ldc_tot_cli
Date ldt_Inicio, ldt_Termino

ldt_Inicio 	= gf_primeiro_dia_mes ( adt_periodo )
ldt_Termino	= gf_retorna_ultimo_dia_mes ( adt_periodo )

SELECT count(distinct(cd_cliente))
into :ldc_tot_cli
FROM nf_venda
WHERE (dh_movimentacao_caixa between :ldt_Inicio AND :ldt_Termino)
	AND cd_filial	 = :al_cd_filial
	using SqlCa;
								 
									 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o m$$HEX1$$ea00$$ENDHEX$$s no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_cd_Filial ))
	Return
End If

Choose case al_coluna 
	case 1
		dw_2.Object.periodo01_4 [al_linha] = ldc_tot_cli
	case 2
		dw_2.Object.periodo02_4 [al_linha] = ldc_tot_cli
	case 3
		dw_2.Object.periodo03_4 [al_linha] = ldc_tot_cli		
	case 4
		dw_2.Object.periodo04_4 [al_linha] = ldc_tot_cli
	case 5
		dw_2.Object.periodo05_4 [al_linha] = ldc_tot_cli
	case 6
		dw_2.Object.periodo06_4 [al_linha] = ldc_tot_cli
End choose									 
end subroutine

on w_ge358_desempenho_cobre_preco.create
call super::create
end on

on w_ge358_desempenho_cobre_preco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;io_Filial			= Create uo_filial

end event

event close;call super::close;Destroy(io_Filial)


end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge358_desempenho_cobre_preco
integer x = 37
integer y = 832
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge358_desempenho_cobre_preco
integer x = 0
integer y = 760
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge358_desempenho_cobre_preco
integer y = 296
integer width = 4603
integer height = 1984
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge358_desempenho_cobre_preco
integer width = 1390
integer height = 256
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge358_desempenho_cobre_preco
integer y = 92
integer width = 1312
integer height = 144
string dataobject = "dw_ge358_selecao_desempenho"
end type

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
		
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge358_desempenho_cobre_preco
integer y = 360
integer width = 4549
integer height = 1892
string dataobject = "dw_ge358_lista_desempenho"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;long ll_coluna, ll_linha_lista, ll_cd_filial
date ldt_periodo[]
This.ivo_Controle_Menu.of_SalvarComo(False)

ldt_periodo[1] = gf_primeiro_dia_mes ( date(gf_getserverdate()) )
ldt_periodo[2] = gf_primeiro_dia_mes ( RelativeDate(ldt_periodo[1], - 1) ) //atual -1
ldt_periodo[3] = gf_primeiro_dia_mes ( RelativeDate(ldt_periodo[2], - 1) ) //atual -2
ldt_periodo[4] = gf_primeiro_dia_mes ( RelativeDate(ldt_periodo[3], - 1) ) //atual -3
ldt_periodo[5] = gf_primeiro_dia_mes ( RelativeDate(ldt_periodo[4], - 1) ) //atual -4
ldt_periodo[6] = gf_primeiro_dia_mes ( RelativeDate(ldt_periodo[5], - 1) ) //atual -5

dw_2.Object.periodo01_t.Text = string(ldt_periodo[1])
dw_2.Object.periodo02_t.Text = string(ldt_periodo[2])
dw_2.Object.periodo03_t.Text = string(ldt_periodo[3])
dw_2.Object.periodo04_t.Text = string(ldt_periodo[4])
dw_2.Object.periodo05_t.Text = string(ldt_periodo[5])
dw_2.Object.periodo06_t.Text = string(ldt_periodo[6])

For ll_linha_lista =1 to dw_2.rowcount()
	
	w_Aguarde.uo_Progress.of_SetMax(dw_2.rowcount())
	
	ll_cd_filial = dw_2.Object.cd_filial  [ ll_linha_lista ]

	// Linha Uso Cobre Pre$$HEX1$$e700$$ENDHEX$$o
	For ll_coluna = 1 to 6 // 6 = M$$HEX1$$ea00$$ENDHEX$$s atual + 5 meses anteriores
		wf_uso_cobre_preco( ll_cd_filial, ldt_periodo[ll_coluna], ll_linha_lista, ll_coluna)
	Next
	
	// FAT
	ll_coluna = 0
	For ll_coluna = 1 to 6 
		wf_fat_cobre_preco(ll_cd_filial, ldt_periodo[ll_coluna], ll_linha_lista, ll_coluna)
	Next

	// FAT(Meta)
	ll_coluna = 0	
	For ll_coluna = 1 to 6 
		wf_fat_meta_cobre_preco(ll_cd_filial, ldt_periodo[ll_coluna], ll_linha_lista, ll_coluna)
	Next

	// N$$HEX1$$fa00$$ENDHEX$$m. Clientes
	ll_coluna = 0
	For ll_coluna = 1 to 6 
		wf_num_clientes_cobre_preco(ll_cd_filial, ldt_periodo[ll_coluna], ll_linha_lista, ll_coluna)
	Next

	w_Aguarde.uo_Progress.of_SetProgress(ll_linha_lista)

Next

Close(w_Aguarde)

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
String lvs_filial

dw_1.AcceptText()

lvs_Filial = dw_1.Object.id_filiais [1]

If lvs_Filial = 'C' Then
	If Not IsNull(ivs_Filiais) Then
		This.of_AppendWhere("n.cd_filial in (" + ivs_Filiais + ")")
	End If

else
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esta consulta poder$$HEX1$$e100$$ENDHEX$$ demorar, para otimiz$$HEX1$$e100$$ENDHEX$$-la voc$$HEX1$$ea00$$ENDHEX$$ pode especificar uma filial.~rDeseja informar a filial?", Question!,YesNo!,1)=1 Then
		dw_1.Event ue_Pos(1, "id_filiais")
		dw_1.SetFocus()
		Return -1
	End If
End If

Return 1
end event

event dw_2::ue_recuperar;dw_1.AcceptText()

Open(w_aguarde)
w_aguarde.Title = 'Carregando informa$$HEX2$$e700f500$$ENDHEX$$es....'

Return This.Retrieve()




end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge358_desempenho_cobre_preco
boolean visible = false
integer x = 3168
integer y = 1308
end type

