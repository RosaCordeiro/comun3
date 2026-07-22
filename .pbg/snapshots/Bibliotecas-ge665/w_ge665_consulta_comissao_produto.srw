HA$PBExportHeader$w_ge665_consulta_comissao_produto.srw
forward
global type w_ge665_consulta_comissao_produto from dc_w_selecao_lista_relatorio
end type
type cb_1 from commandbutton within w_ge665_consulta_comissao_produto
end type
end forward

global type w_ge665_consulta_comissao_produto from dc_w_selecao_lista_relatorio
string tag = "w_ge665_consulta_comissao_produto"
integer width = 6327
integer height = 2512
string title = "GE665 - Consulta Comiss$$HEX1$$e300$$ENDHEX$$o Produto"
cb_1 cb_1
end type
global w_ge665_consulta_comissao_produto w_ge665_consulta_comissao_produto

type variables
uo_ge149_comprador 	io_comprador
uo_fornecedor 			ivo_fornecedor
uo_produto 				iuo_produto
end variables
forward prototypes
public function boolean wf_le_dados_planilha (string as_arquivo)
end prototypes

public function boolean wf_le_dados_planilha (string as_arquivo);Any la_Dado
Long ll_Linha, ll_Linhas, ll_Index, ll_produto_sybase[], ll_for
String ls_produto, ls_produto_sap[], ls_where

dw_1.AcceptText()

Try
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Verificando a quantidade de registros da planilha..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			ll_Index = 0
					
			For ll_Linha = 1 To ll_Linhas
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				
				ls_produto = gf_Tira_Zero_Esquerda(String(la_Dado))
				
				if Len(ls_produto) <= 6 then
					ll_produto_sybase[UpperBound(ll_produto_sybase) + 1] = Long(ls_produto)
				else
					ls_produto_sap[UpperBound(ls_produto_sap) + 1] = ls_produto
				end if
				
				w_Aguarde.Title = "Linha: " + String(ll_Linha) + " at$$HEX1$$e900$$ENDHEX$$ " + String(ll_Linhas)
				w_aguarde.uo_progress.of_setprogress(ll_Linha)
			Next
			
			if UpperBound(ll_produto_sybase) > 0 then
				ls_where = '( pg.cd_produto in ('
				
				for ll_for = 1 to UpperBound(ll_produto_sybase)
					if ll_for = 1 then
						ls_where += String(ll_produto_sybase[ll_for])
					else
						ls_where += ' ,' + String(ll_produto_sybase[ll_for])
					end if
				next
				
				ls_where += '))'
			end if
			
			if UpperBound(ls_produto_sap) > 0 then
				if not isnull(ls_where) and trim(ls_where) <> '' then
					ls_where += ' or (pg.cd_produto_sap in ('
				else
					ls_where = '(pg.cd_produto_sap in ('
				end if
				
				for ll_for = 1 to UpperBound(ls_produto_sap)
					if ll_for = 1 then
						ls_where += " '" + ls_produto_sap[ll_for] + "'"
					else
						ls_where += " ,'" + ls_produto_sap[ll_for] + "'"
					end if
				next
				
				ls_where += '))'
			end if
			
			dw_2.of_AppendWhere (ls_where)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha est$$HEX1$$e100$$ENDHEX$$ em branco.")
			Return False
		End If
	End If
Finally
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
End Try
end function

on w_ge665_consulta_comissao_produto.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge665_consulta_comissao_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;io_Comprador			= Create uo_ge149_comprador
ivo_fornecedor 		= Create uo_Fornecedor
iuo_produto    		= Create uo_produto
end event

event close;call super::close;Destroy(ivo_fornecedor)
Destroy(io_Comprador)
Destroy(iuo_produto)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge665_consulta_comissao_produto
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge665_consulta_comissao_produto
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge665_consulta_comissao_produto
integer x = 14
integer y = 336
integer width = 6254
integer height = 1980
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge665_consulta_comissao_produto
integer x = 14
integer y = 0
integer width = 6254
integer height = 332
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge665_consulta_comissao_produto
integer x = 55
integer y = 68
integer width = 6194
string dataobject = "dw_ge665_consulta_comissao_produto_param"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case 'nm_fantasia'
		If Not IsNull(data) and Trim(data) <> "" Then
			If data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
		
			This.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
			This.Object.nm_fantasia  [1] = ivo_Fornecedor.nm_razao_social
		End If
	Case 'nm_comprador'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
			This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
		End If
	Case 'de_produto'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> iuo_produto.de_produto Then
				Return 1
			End If
		Else
			iuo_produto.of_inicializa()
				
			This.Object.cd_produto[1] = iuo_produto.cd_produto
			This.Object.de_produto[1] = iuo_produto.de_produto + " : " + iuo_produto.de_apresentacao_venda
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;String lvs_Nulo


If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_comprador"
			io_Comprador.of_Localiza_Comprador(This.GetText())
			
			If io_Comprador.Localizado Then
				This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
				This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
			End If
		Case 'nm_fantasia'
			ivo_Fornecedor.of_Localiza_Fornecedor(dw_1.GetText())
		
			If ivo_Fornecedor.Localizado Then
				dw_1.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
				dw_1.Object.nm_fantasia  [1] = ivo_Fornecedor.Nm_Razao_Social
			Else
				SetNull(lvs_Nulo)
						
				dw_1.Object.cd_fornecedor[1] = lvs_Nulo
				dw_1.Object.nm_fantasia  [1] = lvs_Nulo
			End If
		Case 'de_produto'
			iuo_produto.of_Localiza_produto( This.GetText() )
			
			If Not iuo_produto.Localizado Then Return
				
			This.Object.cd_produto[1] = iuo_produto.cd_produto
			This.Object.de_produto[1] = iuo_produto.de_produto + " : " + iuo_produto.de_apresentacao_venda
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge665_consulta_comissao_produto
integer x = 46
integer y = 412
integer width = 6199
integer height = 1880
string title = "Lista Comiss$$HEX1$$e300$$ENDHEX$$o por Produto"
string dataobject = "dw_ge665_consulta_comissao_produto_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;Date		ld_dt_inicio_vigencia, ld_dt_fim_vigencia
Long		ll_return, ll_row, ll_cd_tipo_comissao, ll_cd_produto
String	ls_id_vigencia, ls_where, ls_nr_matricula_comprador, ls_cd_fornecedor, &
			ls_id_sit_produto

Try
	dw_1.AcceptText()
	
	ll_row	= dw_1.GetRow()
	
	ll_cd_tipo_comissao			= dw_1.GetItemNumber(ll_row, 'cd_tipo_comissao')
	ll_cd_produto					= dw_1.GetItemNumber(ll_row, 'cd_produto')
	ls_id_vigencia					= dw_1.GetItemString(ll_row, 'id_vigencia')
	ls_cd_fornecedor				= dw_1.GetItemString(ll_row, 'cd_fornecedor')
	ls_nr_matricula_comprador	= dw_1.GetItemString(ll_row, 'nr_matricula_comprador')
	ls_id_sit_produto				= dw_1.GetItemString(ll_row, 'id_sit_produto')
	ld_dt_inicio_vigencia		= dw_1.GetItemDate(ll_row, 'dt_inicio_vigencia')
	ld_dt_fim_vigencia			= dw_1.GetItemDate(ll_row, 'dt_fim_vigencia')
	
	if ls_id_sit_produto <> 'T' then
		This.of_AppendWhere ("pg.id_situacao = '" + ls_id_sit_produto + "'")
	end if
	
	if ll_cd_tipo_comissao > 0 then
		This.of_AppendWhere ('tcps.cd_tipo_comissao = ' + String (ll_cd_tipo_comissao))
	end if
	
	if ll_cd_produto > 0 then
		This.of_AppendWhere ('pg.cd_produto = ' + String (ll_cd_produto))
	end if
	
	if not isnull(ls_nr_matricula_comprador) and trim(ls_nr_matricula_comprador) <> '' then
		This.of_AppendWhere ("fd.nr_matricula_comprador = '" + ls_nr_matricula_comprador + "'")
	end if
	
	if not isnull(ls_cd_fornecedor) and trim(ls_cd_fornecedor) <> '' then
		This.of_AppendWhere ("f.cd_fornecedor = '" + ls_cd_fornecedor + "'")
	end if	
	
	choose case ls_id_vigencia
		case 'V'
			if not IsNull(ld_dt_inicio_vigencia) and ld_dt_inicio_vigencia >= Date('1900-01-01') and &
				not IsNull(ld_dt_fim_vigencia) and ld_dt_fim_vigencia >= Date('1900-01-01') then
				ls_where	= "((tcps.dh_inicio between '" + String (ld_dt_inicio_vigencia, 'yyyy-mm-dd') + "' and '" + String (ld_dt_fim_vigencia, 'yyyy-mm-dd') + "') or (" + &
					"tcps.dh_termino between '" + String (ld_dt_inicio_vigencia, 'yyyy-mm-dd') + "' and '" + String (ld_dt_fim_vigencia, 'yyyy-mm-dd') + "') or (" + &
					" '" + String (ld_dt_inicio_vigencia, 'yyyy-mm-dd') + "' between tcps.dh_inicio and tcps.dh_termino) or (" + &
					" '" + String (ld_dt_fim_vigencia, 'yyyy-mm-dd') + "' between tcps.dh_inicio and tcps.dh_termino))"
					
				This.of_AppendWhere (ls_where) 
			end if
		case 'A'
			if not IsNull(ld_dt_inicio_vigencia) and ld_dt_inicio_vigencia >= Date('1900-01-01') and &
				not IsNull(ld_dt_fim_vigencia) and ld_dt_fim_vigencia >= Date('1900-01-01') then
				ls_where	= "(((tcps.dh_inicio between '" + String (ld_dt_inicio_vigencia, 'yyyy-mm-dd') + "' and '" + String (ld_dt_fim_vigencia, 'yyyy-mm-dd') + "') or (" + &
					"tcps.dh_termino between '" + String (ld_dt_inicio_vigencia, 'yyyy-mm-dd') + "' and '" + String (ld_dt_fim_vigencia, 'yyyy-mm-dd') + "') or (" + &
					" '" + String (ld_dt_inicio_vigencia, 'yyyy-mm-dd') + "' between tcps.dh_inicio and tcps.dh_termino) or (" + &
					" '" + String (ld_dt_fim_vigencia, 'yyyy-mm-dd') + "' between tcps.dh_inicio and tcps.dh_termino)) or " + &
					"(tcps.dh_inicio > '" + String (ld_dt_fim_vigencia, 'yyyy-mm-dd') + "'))"
					
				This.of_AppendWhere (ls_where) 
			end if
		case 'X'
			if not IsNull(ld_dt_inicio_vigencia) and ld_dt_inicio_vigencia >= Date('1900-01-01') then
				ls_where	= "(tcps.dh_termino < '" + String (ld_dt_inicio_vigencia, 'yyyy-mm-dd') + "')"
					
				This.of_AppendWhere (ls_where) 
			end if
		case 'F'
			if not IsNull(ld_dt_inicio_vigencia) and ld_dt_inicio_vigencia >= Date('1900-01-01') then
				ls_where	= "(tcps.dh_inicio > '" + String (ld_dt_inicio_vigencia, 'yyyy-mm-dd') + "')"
					
				This.of_AppendWhere (ls_where) 
			end if
	end choose
			
	ll_return = This.Retrieve()
Catch (RunTimeError RTE)
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', RTE.getmessage())
	ll_return = -1
Finally
	Return ll_return
End Try
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;if pl_linhas > 0 then
	ivm_Menu.mf_SalvarComo(true)
else
	ivm_Menu.mf_SalvarComo(false)
end if

return pl_linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge665_consulta_comissao_produto
integer x = 5751
integer y = 2036
string dataobject = "dw_ge665_consulta_comissao_produto_lista"
end type

type cb_1 from commandbutton within w_ge665_consulta_comissao_produto
integer x = 5266
integer y = 48
integer width = 974
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Filtrar Produtos Via Planilha"
end type

event clicked;Int		li_Retorno
Long		ll_linhas
String	ls_Arquivo, ls_Nome


MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r~r" + &
							+ "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo de Produto SAP ou Sybase")

li_Retorno = GetFileOpenName("Seleciona o arquivo", ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then
	dw_2.of_RestoreOriginalSQL()
	wf_le_dados_planilha(ls_Arquivo)
	ll_linhas = dw_2.Retrieve()
	
	if ll_linhas > 0 then
		ivm_Menu.mf_SalvarComo(true)
	else
		ivm_Menu.mf_SalvarComo(false)
	end if
Else
	//SetNull(ls_Nulo)
	//dw_1.Object.De_Arquivo[1] = ls_Nulo
	//cb_Ok.Enabled = False
End If
end event

