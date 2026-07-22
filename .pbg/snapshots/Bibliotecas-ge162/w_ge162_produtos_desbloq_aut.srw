HA$PBExportHeader$w_ge162_produtos_desbloq_aut.srw
forward
global type w_ge162_produtos_desbloq_aut from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge162_produtos_desbloq_aut from dc_w_selecao_lista_relatorio
integer width = 4544
integer height = 2268
string title = "GE162 - Produtos Desbloqueados Automaticamente"
boolean resizable = false
end type
global w_ge162_produtos_desbloq_aut w_ge162_produtos_desbloq_aut

type variables
uo_produto ivo_Produto
end variables

forward prototypes
public function boolean wf_insere_distribuidora_default ()
public function boolean wf_insere_uf_default ()
end prototypes

public function boolean wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
	return false
End If

return true
end function

public function boolean wf_insere_uf_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "XX")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_UF[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
	return false
End If

return true
end function

on w_ge162_produtos_desbloq_aut.create
call super::create
end on

on w_ge162_produtos_desbloq_aut.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.SetItem(1, "dt_inicial", Date("01/"+String(Today(), "mm/yyyy")))
dw_1.SetItem(1, "dt_final", Today())

wf_Insere_Distribuidora_Default()
wf_Insere_UF_Default()
end event

event open;call super::open;ivo_Produto = create uo_produto
end event

event close;call super::close;destroy ivo_Produto
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge162_produtos_desbloq_aut
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge162_produtos_desbloq_aut
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge162_produtos_desbloq_aut
integer y = 480
integer width = 4466
integer height = 1604
string text = "Lista de Produtos Desbloqueados"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge162_produtos_desbloq_aut
integer width = 1906
integer height = 436
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge162_produtos_desbloq_aut
integer y = 72
integer width = 1838
integer height = 368
string dataobject = "dw_ge162_prod_desbloq_aut_sel"
end type

event dw_1::editchanged;call super::editchanged;dw_2.reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
end choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque			
			End If
	end choose
end if

end event

event dw_1::itemchanged;call super::itemchanged;dw_2.reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
end choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge162_produtos_desbloq_aut
integer y = 556
integer width = 4411
integer height = 1496
string dataobject = "dw_ge162_produtos_desbloq_aut"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;date		lvdt_inicial, &
			lvdt_final
			
String 	lvs_cd_Distribuidora, &
			lvs_UF
			
Long 		lvl_cd_Produto

dw_1.AcceptText()

lvdt_inicial			= dw_1.Object.dt_inicial[1]
lvdt_final				= dw_1.Object.dt_final[1]
lvs_cd_Distribuidora = dw_1.Object.Cd_Distribuidora[1]
lvs_UF               = dw_1.Object.Cd_UF[1]
lvl_cd_Produto       = dw_1.Object.Cd_Produto[1]

if isnull(lvdt_inicial) or isnull(lvdt_final) then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o per$$HEX1$$ed00$$ENDHEX$$odo para continuar.', Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicial")
	Return -1
end if

if string(lvdt_inicial, 'yyyymmdd') > string(lvdt_final, 'yyyymmdd') then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data final.', Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicial")
	Return -1
end if

if string(lvdt_final, 'yyyymmdd') > string(today(), 'yyyymmdd') then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data final n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data de hoje.', Exclamation!)
	dw_1.Event ue_Pos(1, "dt_final")
	Return -1
end if

This.of_appendwhere("dp.dh_alteracao_situacao between '" + string(lvdt_inicial, 'yyyy-mm-dd') + " 00:00:00' and '" + string(lvdt_final, 'yyyy-mm-dd') + " 23:59:59'")

if not isnull(lvs_cd_Distribuidora) and lvs_cd_Distribuidora <> '000000000' then
	This.of_appendwhere("dp.cd_distribuidora = '" + lvs_cd_Distribuidora + "'")
end if

if not isnull(lvs_UF) and lvs_UF <> 'XX' then
	This.of_appendwhere("dp.cd_unidade_federacao = '" + lvs_UF + "'")
end if

if lvl_cd_Produto > 0 then
	This.of_appendwhere("dp.cd_produto = " + string(lvl_cd_produto) + " ")
End If

return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_SalvarComo(pl_linhas > 0)

return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge162_produtos_desbloq_aut
boolean visible = false
end type

