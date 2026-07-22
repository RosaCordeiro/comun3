HA$PBExportHeader$w_ge162_grafico_historico_preco.srw
forward
global type w_ge162_grafico_historico_preco from dc_w_selecao_lista_relatorio
end type
type dw_resumo from dc_uo_dw_base within w_ge162_grafico_historico_preco
end type
type gb_3 from groupbox within w_ge162_grafico_historico_preco
end type
end forward

global type w_ge162_grafico_historico_preco from dc_w_selecao_lista_relatorio
integer width = 5358
integer height = 2856
string title = "GE162 - Gr$$HEX1$$e100$$ENDHEX$$fico de Hist$$HEX1$$f300$$ENDHEX$$rico de Pre$$HEX1$$e700$$ENDHEX$$os"
boolean maxbox = true
dw_resumo dw_resumo
gb_3 gb_3
end type
global w_ge162_grafico_historico_preco w_ge162_grafico_historico_preco

type variables
string 	ivs_cd_uf, &
			ivs_cd_distribuidora

long 		ivl_cd_produto
			
date		ivdt_inicial, &
			ivdt_final

uo_produto ivo_Produto
end variables

forward prototypes
public function boolean wf_verifica_preco_atual ()
public function boolean wf_insere_distribuidora_default ()
public function boolean wf_insere_uf_default ()
public function boolean wf_carrega_resumo ()
end prototypes

public function boolean wf_verifica_preco_atual ();date	lvdt_final

long	lvl_row, &
		lvl_find, &
		i

string lvs_exp

if dw_2.rowcount() > 0 then
	lvdt_final = dw_1.object.dt_final[1]
	
	// se a data final do periodo for igual a data de hoje...
	if lvdt_final = today() then
		for i = 1 to dw_resumo.rowcount()
			
			// verifica se a data final do periodo retornado pela dw_resumo para o produto em quest$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ menor que a data final do filtro
			// se for diferente, atualiza a data final da dw_resumo para ser igual a data do filtro, e atualiza tambem o preco final para ser igual ao preco da distribuidora_produto
			//if date(dw_resumo.object.dt_final[i]) < lvdt_final  then
				
				dw_resumo.object.vl_preco_final[i] = dw_resumo.object.vl_preco_distribuidora_produto[i]
				dw_resumo.object.dt_final[i]       = datetime(lvdt_final)
				
				if dw_resumo.object.vl_preco_final[i] > dw_resumo.object.vl_maior_preco[i] then
					dw_resumo.object.vl_maior_preco[i] = dw_resumo.object.vl_preco_final[i]
				end if
				
				if dw_resumo.object.vl_preco_final[i] < dw_resumo.object.vl_menor_preco[i] then
					dw_resumo.object.vl_menor_preco[i] = dw_resumo.object.vl_preco_final[i]
				end if
			//end if
			
			// busca o produto/distrib./uf na dw_2(grafico) onde a data da posicao for igual a data final do filtro
			lvs_exp = 'cd_produto = ' + string(dw_resumo.object.cd_produto[i]) + ' and cd_distribuidora = "' + dw_resumo.object.cd_distribuidora[i] + '" and cd_unidade_federacao = "' + dw_resumo.object.cd_unidade_federacao[i] + '" and string(dh_data_posicao, "yyyymmdd") = "' + string(lvdt_final, 'yyyymmdd') + '"'
			lvl_find = dw_2.find(lvs_exp, 1, dw_2.rowcount())
			
			if lvl_find > 0 then
				// se encontrou registro, verifica se o pre$$HEX1$$e700$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ igual ao pre$$HEX1$$e700$$ENDHEX$$o da distribuidora_produto. se nao for, usa o preco da distribuidora_produto
				if dw_2.object.vl_preco_compra[lvl_find] <> dw_resumo.object.vl_preco_distribuidora_produto[i] then
					dw_2.object.vl_preco_compra[lvl_find] = dw_resumo.object.vl_preco_distribuidora_produto[i]
				end if
			elseif lvl_find = 0 then

				// se nao encontrou o registro, insere na dw_2 com o preco igual ao preco da distribuidora_produto
				lvl_row = dw_2.insertrow(0)
				dw_2.object.cd_distribuidora[lvl_row]      = dw_resumo.object.cd_distribuidora[i]
				dw_2.object.nm_razao_social[lvl_row]       = dw_resumo.object.nm_razao_social[i]
				dw_2.object.cd_produto[lvl_row]            = dw_resumo.object.cd_produto[i]
				dw_2.object.de_produto[lvl_row]            = dw_resumo.object.de_produto[i]
				dw_2.object.cd_unidade_federacao[lvl_row]  = dw_resumo.object.cd_unidade_federacao[i]
				dw_2.object.dh_data_posicao[lvl_row]       = dw_resumo.object.dt_final[i]
				dw_2.object.vl_preco_compra[lvl_row]       = dw_resumo.object.vl_preco_distribuidora_produto[i]
				dw_2.object.de_produto_chave[lvl_row]      = dw_resumo.object.de_produto_chave[i]
				
			else
				Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao buscar registro na dw_2. Contate o suporte.')
				return false
			end if
		next
	end if
end if

return true

end function

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

public function boolean wf_carrega_resumo ();dw_resumo.event ue_retrieve()

return true
end function

on w_ge162_grafico_historico_preco.create
int iCurrent
call super::create
this.dw_resumo=create dw_resumo
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_resumo
this.Control[iCurrent+2]=this.gb_3
end on

on w_ge162_grafico_historico_preco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_resumo)
destroy(this.gb_3)
end on

event open;call super::open;string lvs_parametro

lvs_parametro = message.stringparm

if len(lvs_parametro) > 0 then
	ivdt_inicial			= date(mid(lvs_parametro, 1, 10))
	ivdt_final				= date(mid(lvs_parametro,11, 10))
	ivs_cd_uf 				= mid(lvs_parametro,21, 2)
	ivl_cd_produto 		= long(mid(lvs_parametro,23, 7))
	ivs_cd_distribuidora = mid(lvs_parametro,30)
end if

ivo_Produto = create uo_produto
end event

event ue_postopen;call super::ue_postopen;wf_Insere_Distribuidora_Default()
wf_Insere_UF_Default()

if len(ivs_cd_distribuidora) > 0 then
	dw_1.object.cd_distribuidora[1]  = ivs_cd_distribuidora
	dw_1.object.cd_produto[1] 			= ivl_cd_produto
	dw_1.object.cd_uf[1]					= ivs_cd_uf
	dw_1.object.dt_inicial[1] 			= ivdt_inicial
	dw_1.object.dt_final[1] 			= ivdt_final

	ivo_Produto.of_Localiza_Produto(string(ivl_cd_produto))
	
	If ivo_Produto.Localizado Then
		dw_1.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque			
	End If
	
	dw_2.post event ue_retrieve()
end if
end event

event close;call super::close;destroy ivo_Produto
end event

event key;call super::key;if key = keyescape! then
	close(this)
end if
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge162_grafico_historico_preco
integer y = 1352
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge162_grafico_historico_preco
integer y = 1280
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge162_grafico_historico_preco
integer y = 480
integer width = 5230
integer height = 1612
string text = "Gr$$HEX1$$e100$$ENDHEX$$fico"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge162_grafico_historico_preco
integer width = 5230
integer height = 456
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge162_grafico_historico_preco
integer width = 3214
integer height = 356
string dataobject = "dw_ge162_selecao_historico_preco"
end type

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

event dw_1::editchanged;call super::editchanged;dw_resumo.reset()

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

event dw_1::itemchanged;call super::itemchanged;dw_resumo.reset()

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

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge162_grafico_historico_preco
integer y = 560
integer width = 5157
integer height = 1496
string dataobject = "dw_ge162_grafico_historico_preco"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long 		lvl_cd_Produto

String 	lvs_cd_Distribuidora, &
			lvs_UF, &
			lvs_homologacao

date		lvdt_inicial, &
			lvdt_final

dw_1.AcceptText()

lvs_cd_Distribuidora = dw_1.Object.Cd_Distribuidora[1]
lvl_cd_Produto       = dw_1.Object.Cd_Produto[1]
lvs_UF               = dw_1.Object.Cd_UF[1]
lvdt_inicial			= dw_1.Object.dt_inicial[1]
lvdt_final				= dw_1.Object.dt_final[1]
lvs_Homologacao		= dw_1.Object.Id_Homologacao[1]

if IsNull(lvl_cd_Produto) or lvl_cd_Produto = 0 then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe um produto para continuar.')
	dw_1.Event ue_Pos(1, "cd_produto")
	Return -1
End If

if isnull(lvdt_inicial) or isnull(lvdt_final) then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o per$$HEX1$$ed00$$ENDHEX$$odo para continuar.')
	dw_1.Event ue_Pos(1, "dt_inicial")
	Return -1
end if

if string(lvdt_inicial, 'yyyymmdd') > string(lvdt_final, 'yyyymmdd') then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data final.')
	dw_1.Event ue_Pos(1, "dt_inicial")
	Return -1
end if

if string(lvdt_final, 'yyyymmdd') > string(today(), 'yyyymmdd') then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data final n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data de hoje.')
	dw_1.Event ue_Pos(1, "dt_final")
	Return -1
end if

This.of_appendwhere("d.cd_produto = " + string(lvl_cd_produto) + " ")
This.of_appendwhere("d.dh_data_posicao between '" + string(lvdt_inicial, 'yyyy-mm-dd') + "' and '" + string(lvdt_final, 'yyyy-mm-dd') + "'")

if not isnull(lvs_cd_Distribuidora) and lvs_cd_Distribuidora <> '000000000' then
	This.of_appendwhere("d.cd_distribuidora = '" + lvs_cd_Distribuidora + "'")
end if

if not isnull(lvs_UF) and lvs_UF <> 'XX' then
	This.of_appendwhere("d.cd_unidade_federacao = '" + lvs_UF + "'")
end if

return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;long 	lvl_min, &
		lvl_max

// carrega informa$$HEX2$$e700f500$$ENDHEX$$es de resumo apresentadas no rodape da tela
parent.wf_carrega_resumo()

// calcula o percentual de variacao de preco no periodo 
parent.wf_verifica_preco_atual()


if pl_linhas > 0 then
	ivm_Menu.mf_SalvarComo(true)
else
	ivm_Menu.mf_SalvarComo(false)
end if

if dw_2.rowcount() > 0 then
	lvl_min = long(dw_resumo.object.vl_menor_preco[1] - (dw_resumo.object.vl_menor_preco[1] * 0.02))
	lvl_max = long(dw_resumo.object.vl_maior_preco[1] + (dw_resumo.object.vl_maior_preco[1] * 0.02))
	
	if lvl_min = lvl_max then
		lvl_min -= 1
		lvl_max += 1
	end if
	
	dw_2.Object.gr_1.Values.MinimumValue = lvl_min
	dw_2.Object.gr_1.Values.MaximumValue = lvl_max
end if

return pl_linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge162_grafico_historico_preco
boolean visible = false
integer y = 816
end type

type dw_resumo from dc_uo_dw_base within w_ge162_grafico_historico_preco
integer x = 69
integer y = 2192
integer width = 5157
integer height = 384
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge162_resumo_historico_preco"
boolean vscrollbar = true
end type

event ue_preretrieve;call super::ue_preretrieve;Long 		lvl_cd_Produto

String 	lvs_cd_Distribuidora, &
			lvs_UF

date		lvdt_inicial, &
			lvdt_final

dw_1.AcceptText()

lvs_cd_Distribuidora = dw_1.Object.Cd_Distribuidora[1]
lvl_cd_Produto       = dw_1.Object.Cd_Produto[1]
lvs_UF               = dw_1.Object.Cd_UF[1]
lvdt_inicial			= dw_1.Object.dt_inicial[1]
lvdt_final				= dw_1.Object.dt_final[1]

this.of_appendwhere_subquery("d.cd_produto = " + string(lvl_cd_produto) + " ", 5)
//this.of_appendwhere_subquery("d.dh_data_posicao between '" + string(lvdt_inicial, 'yyyy-mm-dd') + "' and '" + string(lvdt_final, 'yyyy-mm-dd') + "'", 5)

if not isnull(lvs_cd_Distribuidora) and lvs_cd_Distribuidora <> '000000000' then
	this.of_appendwhere_subquery("d.cd_distribuidora = '" + lvs_cd_Distribuidora + "'", 5)
end if

if not isnull(lvs_UF) and lvs_UF <> 'XX' then
	this.of_appendwhere_subquery("d.cd_unidade_federacao = '" + lvs_UF + "'", 5)
end if

return 1
end event

event ue_recuperar;//override
Return This.Retrieve(dw_1.object.dt_inicial[1], dw_1.object.dt_final[1])
end event

type gb_3 from groupbox within w_ge162_grafico_historico_preco
integer x = 37
integer y = 2116
integer width = 5230
integer height = 500
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Resumo"
borderstyle borderstyle = styleraised!
end type

