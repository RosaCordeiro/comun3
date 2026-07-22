HA$PBExportHeader$w_ge534_relatorio_ruptura.srw
forward
global type w_ge534_relatorio_ruptura from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge534_relatorio_ruptura from dc_w_selecao_lista_relatorio
integer width = 3232
integer height = 2132
string title = "GE534 - Relat$$HEX1$$f300$$ENDHEX$$rio de Rupturas"
end type
global w_ge534_relatorio_ruptura w_ge534_relatorio_ruptura

type variables
uo_produto io_Produto

dc_uo_ds_base ids_4


end variables

forward prototypes
public subroutine wf_insere_uf_default ()
public subroutine wf_insere_distribuidora_default ()
public function long wf_carrega_dados_ruptura ()
end prototypes

public subroutine wf_insere_uf_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "XX")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_UF[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

public function long wf_carrega_dados_ruptura ();// funcao para setar qt_estoque, qt_venda e pc_ruptura para os produtos para cada data dentro do range de datas definido no filtro
// foi necessario implementar o relatorio desta forma pois a tabela distribuidora_produto_saldo traz somente produtos com saldo maior que zero,
// mas aqui precisamos tambem dos casos com estoque zerado pois esta situacao gera ruptura se houve venda no dia em questao.
string 	lvs_cd_distribuidora, &
			lvs_sql_qt_venda, &
			lvs_sql_qt_estoque, &
			lvs_uf, &
			lvs_de_produto
			
long 		lvl_Cd_produto, &
			lvl_qt_estoque_disponivel, &
			i, &
			lvl_qt_venda, &
			lvl_qt_estoque
			
date		lvdt_pedido, &
			lvdt_final

if ids_4.RowCount() > 0 then
	Open(w_Aguarde)

	lvs_UF = dw_1.object.cd_uf[1]
	lvs_cd_distribuidora = dw_1.object.cd_distribuidora[1]
	lvdt_final = dw_1.object.dh_termino[1]
	
	w_aguarde.uo_progress.of_setmax(ids_4.RowCount())
	w_Aguarde.Title = "Verificando rupturas. Aguarde..."
	
	for i = 1 to ids_4.rowcount()
		lvl_cd_produto = ids_4.object.cd_produto[i]
		lvdt_pedido    = dw_1.object.dh_inicio[1]
		
		do while lvdt_pedido <= lvdt_final
			lvs_sql_qt_estoque = " select sum(d.qt_estoque_disponivel_bkp) " + &
			  " from distribuidora_produto_saldo d " + &
			 " inner join fornecedor f on f.cd_fornecedor = d.cd_distribuidora " + &
			 " inner join cidade c on c.cd_cidade = f.cd_cidade " + &
			 " where d.cd_produto = "+string(lvl_cd_produto) + &
			 "   and d.dh_pedido = '"+string(lvdt_pedido,'yyyy-mm-dd') + "'"
		
			if lvs_cd_distribuidora <> '000000000' then
				lvs_sql_qt_estoque += " and d.cd_distribuidora = '" + lvs_cd_distribuidora + "'"
			end if
		
			//if lvs_uf <> 'XX' then
			//	lvs_sql_qt_estoque += " and c.cd_unidade_federacao = '" + lvs_UF + '"'
			//end if
			
			DECLARE cr_estoque DYNAMIC CURSOR FOR SQLSA ;
			PREPARE SQLSA FROM :lvs_sql_qt_estoque;
			OPEN DYNAMIC cr_estoque;
			fetch cr_estoque into :lvl_qt_estoque;
			close cr_estoque;
			
			if isnull(lvl_qt_estoque) then lvl_qt_estoque = 0
		
			lvs_sql_qt_venda = "select coalesce(sum(x.qt_venda - x.qt_devolucao_venda), 0) " + &
			  " from resumo_movto_estq_prd x (index idx_data_produto) " + &
			 " inner join filial fi on fi.cd_filial = x.cd_filial " + &
			 " inner join cidade ci on ci.cd_cidade  = fi.cd_cidade " + &
			 " where x.dh_resumo = '"+string(lvdt_pedido, 'yyyy-mm-dd')+"'" +  &
			 "	and x.cd_produto = "+ string(lvl_cd_produto)
			
			if lvs_uf <> 'XX' then
				lvs_sql_qt_venda += "and ci.cd_unidade_federacao = '" + lvs_UF + "'"
			//else
			//	if lvs_cd_Distribuidora <> '000000000' then
			//		lvs_sql_qt_venda += "and ci.cd_unidade_federacao in (select duf.cd_unidade_federacao from distribuidora_uf duf where duf.cd_distribuidora = '" + lvs_cd_Distribuidora + "' )"
			//	end if
			end if
		
			DECLARE cr_venda DYNAMIC CURSOR FOR SQLSA ;
			PREPARE SQLSA FROM :lvs_sql_qt_venda;
			OPEN DYNAMIC cr_venda;
			fetch cr_venda into :lvl_qt_venda;
			close cr_venda;
			
			if isnull(lvl_qt_venda) then lvl_qt_venda = 0
			
			// se vendas na data for maior que o estoque disponivel...
			if lvl_qt_venda > lvl_qt_estoque then
				
				// se linha do produto atual est$$HEX1$$e100$$ENDHEX$$ com dh_pedido diferente de 2099-01-01, $$HEX1$$e900$$ENDHEX$$ porque o registro j$$HEX1$$e100$$ENDHEX$$ foi utilzado para exibir ruptura para a alguma data
				// dentro do range selecionado no filtro. Neste caso, insere nova linha para o produto/data atual
				if ids_4.object.dh_pedido[i] <> datetime('2099-01-01') then
					lvl_cd_produto = ids_4.object.cd_produto[i]
					lvs_de_produto = ids_4.object.de_produto[i]
					
					if i = ids_4.rowcount() then
						// se $$HEX1$$e900$$ENDHEX$$ ultima linha, insere a nova linha por ultimo, passando 0 como parametro
						i = ids_4.insertrow(0)
					else
						// se n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ ultima linha, insere linha logo depois da linha atual
						i = ids_4.insertrow(i+1)
					end if
					ids_4.object.cd_produto[i] = lvl_cd_produto
					ids_4.object.de_produto[i] = lvs_de_produto
					
					w_aguarde.uo_progress.of_setmax(ids_4.RowCount())
					w_aguarde.uo_progress.of_setprogress(i)
				end if
				
				ids_4.object.dh_pedido[i] = datetime(lvdt_pedido)
				ids_4.object.qt_venda[i] = lvl_qt_venda
				ids_4.object.qt_saldo_distrib[i] = lvl_qt_estoque
				ids_4.object.pc_ruptura[i] = 100 - (lvl_qt_estoque / lvl_qt_venda * 100)
			end if
					
			lvdt_pedido = relativedate(lvdt_pedido, 1)
		loop	 
	
		w_aguarde.uo_progress.of_setprogress(i)
	next
	
	ids_4.RowsCopy(ids_4.GetRow(), ids_4.RowCount(), Primary!, dw_2, 1, Primary!)
	
	// exibe registros de produtos que possuem venda no periodo e onde h$$HEX1$$e100$$ENDHEX$$ ruptura
	dw_2.setfilter("string(dh_pedido, 'yyyy-mm-dd') <> '2099-01-01' and qt_venda > qt_saldo_distrib ")
	dw_2.filter()

	dw_2.setsort('dh_pedido ASC, de_produto ASC')
	dw_2.sort()
	
	Close(w_Aguarde)
end if

return dw_2.rowcount()

end function

on w_ge534_relatorio_ruptura.create
call super::create
end on

on w_ge534_relatorio_ruptura.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;wf_Insere_Distribuidora_Default()
wf_Insere_UF_Default()

dw_1.Object.Dh_Inicio	[1] = RelativeDate(Today(), -1)
dw_1.Object.Dh_Termino	[1] = Today()

if not ids_4.of_changedataobject(dw_2.dataobject) then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao setar dataobject do objeto idw_4')
	return
end if
end event

event close;call super::close;If IsValid(io_Produto) Then Destroy(io_Produto)
if isvalid(ids_4) then destroy ids_4
end event

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto
if not isvalid(ids_4) then ids_4 = create dc_uo_ds_base


end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge534_relatorio_ruptura
integer x = 37
integer y = 904
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge534_relatorio_ruptura
integer x = 0
integer y = 832
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge534_relatorio_ruptura
integer y = 448
integer width = 3118
integer height = 1472
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge534_relatorio_ruptura
integer width = 3118
integer height = 428
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge534_relatorio_ruptura
integer width = 3049
integer height = 312
string dataobject = "dw_ge534_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose

dw_2.Event ue_Reset()
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda				
			End If
			
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge534_relatorio_ruptura
integer y = 524
integer width = 3049
integer height = 1356
string dataobject = "dw_ge534_lista"
end type

event dw_2::ue_postretrieve;pl_Linhas = parent.wf_carrega_dados_ruptura()

If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

SUPER::EVENT ue_postretrieve( pl_linhas )

Return pl_Linhas
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

Return ids_4.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date ldt_Inicio
Date ldt_Termino

Long ll_Produto

String ls_Distribuidora
String ls_UF

dw_1.AcceptText()

ldt_Inicio 		= dw_1.Object.Dh_Inicio				[1]
ldt_Termino 	= dw_1.Object.Dh_Termino			[1]
ll_Produto		= dw_1.Object.Cd_Produto			[1]
ls_Distribuidora	= dw_1.Object.Cd_Distribuidora	[1]
ls_UF				= dw_1.Object.Cd_UF				[1]

//ivs_sql_original_datastore = ids_4.getsqlselect()

if not ids_4.of_changedataobject(dw_2.dataobject) then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao setar dataobject do objeto idw_4')
	return -1
end if

this.reset()

If IsNull(ldt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldt_Inicio > ldt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ls_Distribuidora = "000000000" and ls_UF = 'XX' and (IsNull(ll_Produto) Or ll_Produto = 0) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ao menos uma op$$HEX2$$e700e300$$ENDHEX$$o de filtro para continuar.")
	dw_1.Event ue_Pos(1, "cd_distribuidora")
	Return -1
End If

If ls_UF <> "XX" Then
	ids_4.of_AppendWhere_SubQuery("ci.cd_unidade_federacao = '" + ls_UF + "'", 2)
	//ids_4.of_AppendWhere_SubQuery("c.cd_unidade_federacao = '" + ls_UF + "'", 1)
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	ids_4.of_AppendWhere_SubQuery("d.cd_produto = " + String(ll_Produto), 1)
End If

If ls_Distribuidora <> "000000000" Then
	ids_4.of_AppendWhere_SubQuery("d.cd_distribuidora = '" + ls_Distribuidora + "'", 1)

//	If ls_UF = "XX" Then
//		ids_4.of_AppendWhere_SubQuery("ci.cd_unidade_federacao in (select duf.cd_unidade_federacao from distribuidora_uf duf where duf.cd_distribuidora = '" + ls_Distribuidora + "' )", 2)
//	end if
End If

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge534_relatorio_ruptura
integer x = 2295
integer y = 80
end type

