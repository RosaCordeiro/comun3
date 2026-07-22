HA$PBExportHeader$w_ge629_bloqueio_compras_prod_cd.srw
forward
global type w_ge629_bloqueio_compras_prod_cd from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge629_bloqueio_compras_prod_cd from dc_w_cadastro_selecao_lista
integer width = 6213
integer height = 2452
string title = "GE629 - Bloqueio de compras de produtos via pescador"
boolean ivb_grava_log = true
end type
global w_ge629_bloqueio_compras_prod_cd w_ge629_bloqueio_compras_prod_cd

type variables
uo_produto ivo_produto

uo_fornecedor ivo_fornecedor

uo_ge149_comprador io_comprador

Date		ivd_saldo_produto

Boolean	ivb_Check

String	is_Produto

Long		ivl_produto

Long		ivl_dias_produto_colocado

Long		ivl_dias_estoque

String	is_Produto_1

String	is_planilha
end variables

forward prototypes
public function boolean wf_calcula_margem_lucro ()
public subroutine wf_saldo_em_transito ()
public function boolean wf_saldo_transito ()
public function boolean wf_venda_diaria (long al_produto, ref decimal adc_venda)
end prototypes

public function boolean wf_calcula_margem_lucro ();Decimal ldc_Preco_Utili
Decimal ldc_Desc_Utili
Decimal ldc_Repasse_Icms
Decimal ldc_Icms_St
Decimal ldc_Vl_Compra
Decimal ldc_Preco_Liqui
Decimal ldc_Repasse
Decimal ldc_Venda
Decimal ldc_Desc_Finan
Decimal lvdc_pc_Icms
Decimal lvdc_pc_Icms_venda
Decimal lvdc_pc_reducao_base_icms
Decimal lvdc_vl_icms_venda
Decimal lvdc_pc_promocao_desconto_finan
Decimal lvdc_pc_desconto_acordo_sellin

Long ll_Linha
Long ll_Qt_Emb_Padrao

String lvs_cd_tributacao_icms
String lvs_id_icms_normal

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
    ldc_Preco_Utili						= dw_2.Object.Vl_Preco_Utilizado				[ll_Linha]
    ldc_Desc_Utili						= dw_2.Object.Pc_Desconto_Utilizado			[ll_Linha]
    ldc_Repasse_Icms						= dw_2.Object.Pc_Repasse_Icms					[ll_Linha]
    ldc_Icms_St							= dw_2.Object.Vl_Icms_St						[ll_Linha]
    ll_Qt_Emb_Padrao						= dw_2.Object.Qt_Embalagem_Padrao_Distrib	[ll_Linha]
    ldc_Venda								= dw_2.Object.Vl_Preco_Venda					[ll_Linha]
    ldc_Desc_Finan						= dw_2.Object.pc_desconto_financeiro		[ll_Linha]
    lvdc_pc_Icms							= dw_2.Object.pc_icms							[ll_Linha]
    lvdc_pc_reducao_base_icms			= dw_2.Object.pc_reducao_base_icms			[ll_Linha]
    lvdc_pc_Icms_venda					= dw_2.Object.pc_Icms_venda					[ll_Linha]
    lvs_cd_tributacao_icms				= dw_2.Object.cd_tributacao_icms				[ll_Linha]
    lvs_id_icms_normal					= dw_2.Object.id_icms_normal					[ll_Linha]
    lvdc_pc_promocao_desconto_finan = dw_2.Object.pc_promocao_desconto_finan	[ll_Linha]
    lvdc_pc_desconto_acordo_sellin	= dw_2.Object.pc_desconto_acordo_sellin	[ll_Linha]

    lvdc_vl_icms_venda = 0

    ldc_Preco_Liqui		= Round(ldc_Preco_Utili * ((100 - ldc_Desc_Utili) / 100), 2)
    ldc_Repasse			= Round(ldc_Preco_Liqui * (ldc_Repasse_Icms / 100), 2)
    ldc_Vl_Compra			= ldc_Preco_Liqui - ldc_Repasse

    if lvs_cd_tributacao_icms <> '1' And lvs_id_icms_normal = 'S' then
        ldc_Vl_Compra		= Round(ldc_Vl_Compra	* ((100 - (lvdc_pc_icms * (100 - lvdc_pc_reducao_base_icms) / 100)) / 100), 2)
        lvdc_vl_icms_venda = Round(ldc_Venda 		* lvdc_pc_Icms_venda / 100, 2)
    end if

    ldc_Vl_Compra = Round(ldc_Vl_Compra * ((100 - lvdc_pc_promocao_desconto_finan) / 100), 2)
    ldc_Vl_Compra = Round(ldc_Vl_Compra * ((100 - ldc_Desc_Finan) / 100), 2)
    ldc_Vl_Compra = Round(ldc_Vl_Compra * ((100 - lvdc_pc_desconto_acordo_sellin) / 100), 2)

    If lvs_cd_tributacao_icms = '1' Then
        ldc_Vl_Compra = ldc_Vl_Compra + ldc_Icms_St
    End If

    ldc_Vl_Compra = Round((ldc_Vl_Compra) / ll_Qt_Emb_Padrao, 2)

    dw_2.object.vl_preco_venda_calculo_bloq	[ll_Linha]		= ldc_Venda
    dw_2.object.vl_icms_venda_calculo_bloq	[ll_Linha]		= lvdc_vl_icms_venda
Next

Return True

end function

public subroutine wf_saldo_em_transito ();//st_saldo_transito str
//
//Long ll_Find
//Long ll_Linha
//Long ll_Linhas
//
//gf_Saldo_em_transito(Ref str)
//
//dc_uo_ds_base lvds
//lvds = Create dc_uo_ds_base
//lvds.Of_ChangeDataObject('dw_ge629_lista_distribuidora_cd')
//lvds.Retrieve()
//
//ll_Linhas = lvds.RowCount()
//
//ll_Linhas = UpperBound(str.Cd_Produto[])
//
//For ll_Linha = 1 To ll_Linhas
//	
//	ll_Find = dw_2.Find("cd_produto = " + String(str.Cd_Produto[ll_Linha]), 1, dw_2.RowCount())
//	
//	If ll_Find < 0 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw 2.", StopSign!)
//		Return False
//	End If
//	
//	If ll_Find > 0 Then
//		dw_2.Object.Qt_Est_Transito[ll_Find] = str.Qt_Saldo[ll_Linha] 
//	End If
//Next
//
//Return True
end subroutine

public function boolean wf_saldo_transito ();//Date	ldh_saldo_transito
//Long	ll_qt_transito
//Long	ll_Linha
//Long	ll_Linhas
//Long	ll_cd_produto
//Long	ll_Find
//
// string rowcount
//string setitem
//
//ldh_saldo_transito = RelativeDate(Today(), -90)
//
//dc_uo_ds_base lvds
//
//lvds = Create dc_uo_ds_base
//lvds.Of_ChangeDataObject('ds_ge629_saldo_transito')
//lvds.Retrieve(ldh_saldo_transito)
//
//If lvds.ivo_dberror.ivl_sqldbcode <> 0 then
//	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao carregar ds_saldo_transito. ~r~rErro: ' + lvds.ivo_dberror.ivs_mensagem, StopSign!)
//	Return false
//End if
//
//ll_Linhas = lvds.RowCount()
//
//For ll_Linha = 1 To ll_Linhas
//	ll_qt_transito		= lvds.Object.qt_transito		[ll_Linha]
//	ll_cd_produto		= lvds.Object.cd_produto		[ll_Linha]
//		
//	ll_Find = This.Find("cd_produto = " + String(ll_cd_produto), 1, This.RowCount())
//
//	If ll_Find > 0 Then
//		This.SetItem(ll_Find, "qt_est_transito", ll_qt_transito)
//	End If
//Next
//		
Return true
end function

public function boolean wf_venda_diaria (long al_produto, ref decimal adc_venda);Long lvl_Venda

Date	lvdt_Resumo
Date	ldt_Parametro
Integer lvi_Dia

ldt_Parametro = Today()

lvi_Dia = Day(ldt_Parametro)

lvdt_Resumo = Date("01/" + String(ldt_Parametro, "mm/yyyy"))

Select sum(qt_venda - qt_devolucao_venda) Into :lvl_Venda
From resumo_produto
Where cd_produto = :al_Produto
  and dh_resumo >= dateadd(month, -2, :lvdt_Resumo)
  and id_rede    = 'CIA' 
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Venda > 0 Then
			adc_Venda = Round(lvl_Venda / (60 + lvi_Dia - 1), 2)
		Else
			lvl_Venda = 0
		End If
		
	Case 100
		adc_Venda = 0
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas do Produto")
		Return False
End Choose

Return True
end function

on w_ge629_bloqueio_compras_prod_cd.create
call super::create
end on

on w_ge629_bloqueio_compras_prod_cd.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Fornecedor)
Destroy(io_comprador)
end event

event open;call super::open;String lvs_Parametro

ivo_Produto 		= Create uo_Produto
ivo_Fornecedor 	= Create uo_Fornecedor
io_comprador		= Create uo_ge149_comprador
end event

event ue_cancel;If dw_2.RowCount() > 0 Then
	dw_2.Event ue_Retrieve()
Else
	dw_1.Event ue_Reset()
	dw_2.Event ue_Reset()
	
	dw_1.Event ue_AddRow()
End If

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Bloqueio temporario atualizado com sucesso!")
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es ..."
	dw_2.Event ue_Retrieve()
	Close(w_Aguarde)
End If

Return AncestorReturnValue
end event

event ue_postopen;call super::ue_postopen;String ls_matricula
String ls_comprador_aux
string ls_id_tipo_comprador

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

//Processo que validava a matricula do usuario e deixava alterar apenas os seus produtos.

//ls_matricula	= gvo_Aplicacao.ivo_Seguranca.nr_matricula

//DataWindowChild ldwc_nm_usuario

//dw_1.GetChild('nm_usuario_comprador', ldwc_nm_usuario)
//
//ldwc_nm_usuario.SetTransObject(SQLCA)

//Select coalesce (c.id_auxiliar_comprador, 'N') as id_auxiliar_comprador
//Into :ls_comprador_aux
//from usuario u
//Inner Join comprador c On	c.nr_matricula	= u.nr_matricula
//Where	coalesce (c.id_auxiliar_comprador, 'N') in ('S','N')
//and u.id_situacao in ('F','A')
//and c.nr_matricula = :ls_matricula
//Using SQLCa;
//	
//if SqlCa.SqlCode = -1 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a matricula na tabela COMPRADOR " + ls_matricula + ".~r~r" + SqlCa.SqlErrText, StopSign!)
//	Return
//End if
//
//Choose case ls_comprador_aux
//	Case 'N' //	Comprador
//		dw_1.SetFilter("nm_usuario_comprador			='"+ ls_matricula+" '")
//		dw_1.Object.nm_usuario_comprador		[1]	= ls_matricula
//		dw_1.Modify("nm_usuario_comprador.Protect	= 1")			
//   	ls_id_tipo_comprador = 'C'	
//	Case 'S' //Auxiliar
//		ls_id_tipo_comprador = 'A'
//	Case ''	//Todos
//		dw_2.Modify("id_bloqueia_compra_pescador.Protect		= 1")
//		dw_2.Modify("dt_inicio_bloq_compra_pescador.Protect	= 1")
//		dw_2.Modify("dt_fim_bloq_compra_pescador.Protect		= 1")
//   	ls_id_tipo_comprador = 'T'
//End Choose

//ldwc_nm_usuario.Retrieve(ls_id_tipo_comprador,ls_matricula)

end event

event ue_addrow;//dw_2.Event ue_AddRow()
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge629_bloqueio_compras_prod_cd
integer x = 1225
integer y = 3152
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge629_bloqueio_compras_prod_cd
integer x = 1189
integer y = 3080
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge629_bloqueio_compras_prod_cd
integer y = 60
integer width = 6080
integer height = 484
string dataobject = "dw_ge629_selecao"
boolean ivb_updateable = true
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
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
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
	Case "nm_usuario_comprador"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_comprador.of_Inicializa()			
			This.Object.nr_matricula				[1] = io_comprador.nr_matricula
			This.Object.nm_usuario_comprador  	[1] = io_comprador.nm_usuario
		End If
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;Long ll_Nulo

String ls_Nulo

SetNull(ll_Nulo)
SetNull(ls_Nulo)

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
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
	Case "id_planilha"
		If Data = "S" Then
			OpenWithParm(w_ge629_filtro_via_planilha, '')
			
			is_Produto = Message.StringParm
			
			If Trim(is_Produto) = "" Or IsNull(is_Produto) Then
				Return 1
			End If
					
			dw_1.Object.De_Produto[1] = ls_Nulo
			dw_1.Object.Cd_Produto[1] = ll_Nulo
			
		Else
			is_Produto = ""
		End If
		
	Case "nm_usuario_comprador"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_comprador.nm_usuario Then
			Return 1
			End If
		Else
			io_comprador.of_Inicializa()
				
			This.Object.nr_matricula	[1] = io_comprador.nr_matricula
			This.Object.nm_usuario		[1] = io_comprador.nm_usuario
		End If
	End Choose

end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1]		= ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If

If IsValid(ivo_Fornecedor) Then
	This.Object.Nm_Fornecedor[1]	= ivo_Fornecedor.Nm_Razao_Social
End If
end event

event dw_1::ue_key;dw_1.AcceptText()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
				
				is_planilha = "N"
				//dw_1.Object.Id_Planilha.Visible = False
				is_Produto = ""
			End If
		
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
			End If
			
		Case "nm_usuario_comprador"
			io_comprador.of_Localiza_comprador( This.GetText() )
			If io_comprador.Localizado Then
				This.Object.nr_matricula				[1] = io_comprador.nr_matricula
				This.Object.nm_usuario_comprador		[1] = io_comprador.nm_usuario
			End If
			
	End Choose
End If

If Key = KeyEscape! Then
	Close(Parent)
End If
end event

event dw_1::clicked;call super::clicked;Boolean	lb_flegada
Integer	li_resultado
Datetime	dt_fim_bloqueio
Date		dh_fim_bloqueio
Date		dh_inicio
Date		dh_fim
Long		ll_linha
Long		ll_Count

Choose Case dwo.name
	 Case 'cb_planilha'

			OpenWithParm(w_ge629_filtro_via_planilha, '')
			
			is_Produto = Message.StringParm
			
			If Trim(is_Produto) = "" Or IsNull(is_Produto) Then
				Return 1
			End If
	 
    Case 'cb_replicar'

        If dw_1.GetRow() > 0 Then
            dh_inicio = dw_1.GetItemDate(dw_1.GetRow(), "dh_inicio")
            dh_fim    = dw_1.GetItemDate(dw_1.GetRow(), "dh_fim")
        Else
            MessageBox("Mensagem", "Linha inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
            Return
        End If
		  
        ll_Count = dw_2.RowCount()

        If ll_Count = 0 Then
            MessageBox("Mensagem", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio carregar os produtos antes de atualizar a data de bloqueio.", StopSign!)
        Else
            If IsNull(dh_fim) Or dh_fim < Today() Then
                MessageBox("Mensagem", "Data inv$$HEX1$$e100$$ENDHEX$$lida ou menor que o dia atual.", StopSign!)
            Else
                // Verifica se existe checkbox flegada
                lb_flegada = False
                For ll_linha = 1 To ll_Count
                    If dw_2.GetItemString(ll_linha, "id_bloqueia_compra_pescador") = 'S' Then
                        lb_flegada = True
                    End If
                Next

                If lb_flegada Then
                    li_resultado = MessageBox("Confirma$$HEX2$$e700e300$$ENDHEX$$o", "Existem registros j$$HEX1$$e100$$ENDHEX$$ bloqueados. Deseja atualizar as informa$$HEX2$$e700f500$$ENDHEX$$es de bloqueio nesses registros?", Question!, YesNo!, 2)
                    
                    // Se escolher SIM atualiza todas as linhas
                    If li_resultado = 1 Then
                        For ll_linha = 1 To ll_Count
                            dw_2.SetItem(ll_linha, "id_bloqueia_compra_pescador", 'S')
                            dw_2.SetItem(ll_linha, "dt_inicio_bloq_compra_pescador", dh_inicio)
                            dw_2.SetItem(ll_linha, "dt_fim_bloq_compra_pescador", dh_fim)
                        Next
                    Else
                        // Se escolher N$$HEX1$$e300$$ENDHEX$$o atualiza apenas as linhas que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o bloqueadas
                        For ll_linha = 1 To ll_Count
                            If dw_2.GetItemString(ll_linha, "id_bloqueia_compra_pescador") <> 'S' Then
                                dw_2.SetItem(ll_linha, "id_bloqueia_compra_pescador", 'S')
                                dw_2.SetItem(ll_linha, "dt_inicio_bloq_compra_pescador", dh_inicio)
                                dw_2.SetItem(ll_linha, "dt_fim_bloq_compra_pescador", dh_fim)
                            Else
                                // Verifica se a data dt_fim_bloq_compra_pescador $$HEX1$$e900$$ENDHEX$$ menor que hoje
                                
                                dt_fim_bloqueio = dw_2.GetItemDateTime(ll_linha, "dt_fim_bloq_compra_pescador")
                                dh_fim_bloqueio = Date(dt_fim_bloqueio)

                                If Not IsNull(dh_fim_bloqueio) And dh_fim_bloqueio < Today() Then
                                    dw_2.SetItem(ll_linha, "id_bloqueia_compra_pescador", 'S')
                                    dw_2.SetItem(ll_linha, "dt_inicio_bloq_compra_pescador", dh_inicio)
                                    dw_2.SetItem(ll_linha, "dt_fim_bloq_compra_pescador", dh_fim)
                                End If
                            End If
                        Next
                    End If
                Else
                    // Realiza a replica$$HEX2$$e700e300$$ENDHEX$$o para todas as linhas se n$$HEX1$$e300$$ENDHEX$$o houver registros bloqueados
                    For ll_linha = 1 To ll_Count
                        dw_2.SetItem(ll_linha, "id_bloqueia_compra_pescador", 'S')
                        dw_2.SetItem(ll_linha, "dt_inicio_bloq_compra_pescador", dh_inicio)
                        dw_2.SetItem(ll_linha, "dt_fim_bloq_compra_pescador", dh_fim)
                    Next
                End If

                ivm_Menu.mf_Confirmar(True)
                ivm_Menu.mf_Cancelar(True)
            End If
        End If

End Choose

end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge629_bloqueio_compras_prod_cd
integer y = 604
integer width = 6130
integer height = 1636
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge629_bloqueio_compras_prod_cd
integer width = 6130
integer height = 568
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge629_bloqueio_compras_prod_cd
integer x = 96
integer y = 648
integer width = 6062
integer height = 1600
string dataobject = "dw_ge629_lista_distribuidora_cd"
boolean hscrollbar = true
string icon = "AppRectangle!"
boolean ivb_updateable = true
end type

event dw_2::doubleclicked;call super::doubleclicked;Integer lvi_Row
		  
String	lvs_Marcacao,&
	   	lvs_Nulo
				
Date dt_atual
Date dt_fixa

dw_2.AcceptText()

dt_atual = Date(Today())
dt_fixa	= Date("2099-12-31")

SetNull(lvs_Nulo)
	
Choose Case dwo.Name 
		
	Case 'st_bloqueio'
	

		If ivb_Check Then
			lvs_Marcacao = 'N'
			ivb_Check = False
		Else
			lvs_Marcacao = 'S'
			ivb_Check = True
		End If
		
		For lvi_Row = 1 To This.RowCount()					
			This.trigger event itemchanged(lvi_row, this.object.id_bloqueia_compra_pescador, 'S')			
			
			This.Object.id_bloqueia_compra_pescador[lvi_Row] = lvs_Marcacao
			If lvs_Marcacao = 'S' Then
				dw_2.SetItem(lvi_Row, "id_bloqueia_compra_pescador", 'S')
				dw_2.SetItem(lvi_Row, "dt_inicio_bloq_compra_pescador", dt_atual)
				dw_2.SetItem(lvi_Row, "dt_fim_bloq_compra_pescador", dt_fixa)
			End if
		Next
		
		ivm_Menu.mf_Confirmar(True)
		ivm_Menu.mf_Cancelar(True)
		
End Choose
end event

event dw_2::editchanged;call super::editchanged;Long ll_Nulo

String ls_Nulo

Date dt_atual
Date dt_fixa

dt_atual = Date(Today())
dt_fixa	= Date("2099-12-31")


SetNull(ll_Nulo)
SetNull(ls_Nulo)

Choose Case dwo.Name
	Case "id_bloqueia_compra_pescador"
		If Not IsNull(Data) and Data <> "" Then
			If Data = 'S' Then
				dw_2.SetItem(row, "dt_inicio_bloq_compra_pescador", dt_atual)
				dw_2.SetItem(row, "dt_fim_bloq_compra_pescador", dt_fixa)
				Return 1
			End if
		End If 
End Choose


end event

event dw_2::itemchanged;call super::itemchanged;Long ll_Nulo

String ls_Nulo

Date dt_atual
Date dt_fixa

dt_atual = Date(Today())
dt_fixa	= Date("2099-12-31")


SetNull(ll_Nulo)
SetNull(ls_Nulo)

Choose Case dwo.Name
	Case "id_bloqueia_compra_pescador"
		If Not IsNull(Data) and Data <> "" Then
			If Data = 'S' Then
				dw_2.SetItem(row, "id_bloqueia_compra_pescador", 'S')
				dw_2.SetItem(row, "dt_inicio_bloq_compra_pescador", dt_atual)
				dw_2.SetItem(row, "dt_fim_bloq_compra_pescador", dt_fixa)
				Return 1
			End if
		End If	
	Case "dt_inicio_bloq_compra_pescador"
		If Not IsNull(Data) and Data <> "" Then
			If dt_atual > date(Data) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Data de bloqueio precisa ser maior que a data atual.', StopSign!)
				Return 1
			End if
		End if
	Case "dt_fim_bloq_compra_pescador"
		If Not IsNull(Data) and Data <> "" Then
			If dt_atual > date(Data) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Data de bloqueio precisa ser maior que a data atual.', StopSign!)
				Return 1
			End if
		End if 
End Choose


end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long		ll_Cd_Produto
Long		ll_Divisao
Long		ll_Dias_Produto_Colocado
Long		ll_Dias_Estoque

String	ls_Cd_Fornecedor
String	ls_cd_grupo
String	ls_Nm_Usuario_Comprador
String	ls_Id_Situacao_Clamed
String	ls_Dh_Saldo_Produto


dw_1.AcceptText()

ls_Dh_Saldo_Produto	= String(Today(), "yyyy/mm/01")

ivd_saldo_produto		= date(ls_Dh_Saldo_Produto)

ll_Cd_Produto					= dw_1.Object.Cd_Produto				[1]
ls_Cd_Fornecedor 				= dw_1.Object.Cd_Fornecedor			[1]
ls_cd_grupo						= dw_1.Object.Cd_grupo					[1]
ls_Id_Situacao_Clamed		= dw_1.Object.Id_Situacao_clamed		[1]
ls_Nm_Usuario_Comprador		= dw_1.Object.nm_usuario_comprador	[1]
ll_Dias_Produto_Colocado	= dw_1.Object.nr_saldo_colocado		[1]
ll_Dias_Estoque				= dw_1.Object.nr_dias_estoque			[1]
ls_Nm_Usuario_Comprador		= dw_1.Object.nr_matricula      		[1]

ivl_dias_produto_colocado	= ll_Dias_Produto_Colocado
ivl_produto						= ll_Cd_Produto
ivl_dias_estoque				= ll_Dias_Estoque

If ls_Nm_Usuario_Comprador = "" then
    SetNull(ls_Nm_Usuario_Comprador)
End If

//Produto
If is_Produto = "" Then
	If Not IsNull(ll_Cd_Produto) Then
		This.of_AppendWhere_SubQuery("pg.cd_produto = " + String(ll_Cd_Produto), 2)
	End if
//Planilha
Else
	This.of_AppendWhere_SubQuery("pg.cd_produto in (" + is_Produto + ")", 2)
End If

//Fornecedor
If Not IsNull(ls_Cd_Fornecedor) and Trim(ls_Cd_Fornecedor) <> "" Then
	This.of_AppendWhere_SubQuery("pg.cd_fornecedor_usual = '" + ls_Cd_Fornecedor + "'", 2)
End If

//Matricula Comprador
If Not IsNull( ls_Nm_Usuario_Comprador ) Then
	This.of_AppendWhere_SubQuery("pc.nr_matricula_comprador = '" + ls_Nm_Usuario_Comprador + "'", 2)
End If

//Situa$$HEX2$$e700e300$$ENDHEX$$o do Produto
If ls_Id_Situacao_Clamed <> "T" Then
	This.of_AppendWhere_SubQuery("pg.id_situacao = '" + ls_Id_Situacao_Clamed + "'", 2)
End If

//Grupo(Medicamentos,Perfumaria etc)
If Not IsNull(ls_cd_grupo) and Trim(ls_cd_grupo) <> "0" Then
	This.of_AppendWhere_SubQuery("substring(pg.cd_subcategoria, 1, 1) = '" + ls_cd_grupo + "'", 2)
End If

//Dias de estoque
//If Not IsNull(ll_Dias_Estoque) and Trim(ll_Dias_Estoque) <> "0" Then
//	This.of_AppendWhere_SubQuery("substring(pg.cd_subcategoria, 1, 1) = '" + ls_cd_grupo + "'", 2)
//End If

// Divisao-  Adicionado por ultimo pois este filtro adiciona um novo where
If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
	This.of_appendwhere_subquery("pg.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + ls_Cd_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 3)
End If

Return 1
end event

event dw_2::ue_reset;call super::ue_reset;ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

ivm_Menu.mf_Classificar(False)
ivm_Menu.mf_Filtrar(False)
ivm_Menu.mf_Localizar(False)
ivm_Menu.mf_Imprimir(False)
ivm_Menu.mf_SalvarComo(False)

dw_1.Enabled = True
end event

event dw_2::constructor;call super::constructor;//This.of_SetRowSelection()


String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_produto", &
					"de_produto", &
					"cd_unidade_medida_compra", &
					"id_lei_generico", &
					"cd_curva_abc_perini", &
					"cd_curva_abc_filiais", &
					"nm_fornecedor", &
					"nr_divisao", &
					"nm_comprador", &
					"qt_est_transito", &
					"qt_saldo_colocado", &
					"qt_saldo_filiais", &
					"qt_dias_estoque", &
					"id_bloqueia_compra_pescador", &
					"dt_inicio_bloq_compra_pescador", &
					"dt_fim_bloq_compra_pescador", &
					"qt_estoque_base", &
					"qt_saldo_final", &
					"vl_custo_gerencial", &
					"qt_media_venda"}
				  
lvs_Nome = {"CdProduto", &
				"DeProduto", &
				"UnidadeMedida", &
				"IDLeiGenerico", &
				"CDCurvaABCperini", &
				"CDCurvaABCfiliais", &
            "Fornecedor", &
				"NRDivisao", &
				"Comprador", &
				"QtEstTransito", &
				"IDBloqueio", &
				"InicioBloqueio", &
				"FimBloqueio", &
				"SaldoColocado", &
				"SaldoFiliais", &
				"DiasEstoque", &
				"EstoqueBase", &
				"SaldoCD", &
				"CustoGerencial", &
				"MediaVenda"}
			
//This.of_SetFilter(lvs_Coluna, lvs_Nome)
This.of_SetSort(lvs_Coluna, lvs_Nome)

This.ivb_Ordena_Colunas = True
end event

event dw_2::buttonclicked;call super::buttonclicked;string	ls_cd_produto

ls_cd_produto = string(dw_2.object.cd_produto[row])

   Choose case dwo.name
		Case 'cb_historico'
			OpenWithParm(w_ge629_historico, ls_cd_produto)
		
End Choose

end event

event dw_2::ue_recuperar;Return This.Retrieve(ivd_saldo_produto)

end event

event dw_2::ue_deleterow;Boolean lvb_Retorno = False

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
Return lvb_Retorno
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_SalvarComo(True)


Boolean lb_retorno	= False

Decimal lvdc_Venda_Diaria

DateTime ldt_saldo_transito
DateTime ldt_saldo_colocado_inicio  

Long ll_qt_transito
Long ll_Linha
Long ll_Linhas
Long ll_cd_produto
Long ll_Find_saldo_transito
Long ll_qt_colocado
Long ll_Find_saldo_colocado

dc_uo_transacao ISQLCA_CONSULTA

ldt_saldo_colocado_inicio	= DateTime(RelativeDate(Today(), -ivl_dias_produto_colocado))
ldt_saldo_transito			= DateTime(RelativeDate(Today(), -90))

// Cria lvds_saldo_transito
dc_uo_ds_base lvds_saldo_transito
lvds_saldo_transito = Create dc_uo_ds_base
lvds_saldo_transito.Of_ChangeDataObject('ds_ge629_saldo_transito')
lvds_saldo_transito.Retrieve(ldt_saldo_transito, ivl_produto)

If lvds_saldo_transito.ivo_dberror.ivl_sqldbcode <> 0 Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao carregar ds_ge629_saldo_transito. ~r~rErro: ' + lvds_saldo_transito.ivo_dberror.ivs_mensagem, StopSign!)
	Return -1
End If

// Cria lvds_saldo_colocado
dc_uo_ds_base lvds_saldo_colocado
lvds_saldo_colocado = Create dc_uo_ds_base
lvds_saldo_colocado.Of_ChangeDataObject('ds_ge629_saldo_colocado')

Try
	ISQLCA_CONSULTA = Create dc_uo_transacao
	ISQLCA_CONSULTA.ivs_database = "SYBASE"
	ISQLCA_CONSULTA.of_Connect(gvo_Aplicacao.ivs_DataSource, 'SQLCA - Consulta (AutoCommit)')
	ISQLCA_CONSULTA.AutoCommit	= true
	lb_retorno	= True
Catch (RunTimeError RTE)
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Problema na fun$$HEX2$$e700e300$$ENDHEX$$o wf_cria_conexao_consulta. ~r~rErro: ")
	lb_retorno	= False
Finally
	
End Try

lvds_saldo_colocado.settransobject(ISQLCA_CONSULTA)

lvds_saldo_colocado.Retrieve(ldt_saldo_colocado_inicio, ivl_produto)

If lvds_saldo_colocado.ivo_dberror.ivl_sqldbcode <> 0 Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao carregar ds_ge629_saldo_colocado. ~r~rErro: ' + lvds_saldo_colocado.ivo_dberror.ivs_mensagem, StopSign!)
	Return -1
End If

ll_Linhas = This.RowCount()

For ll_Linha = 1 To ll_Linhas
	ll_cd_produto = This.Object.cd_produto[ll_Linha]
	
	lvdc_Venda_Diaria = 0.00
	
	ll_Find_saldo_transito = lvds_saldo_transito.Find("cd_produto = " + String(ll_cd_produto), 1, This.RowCount())
	
	If ll_Find_saldo_transito > 0 Then
		ll_qt_transito = lvds_saldo_transito.Object.qt_transito[ll_Find_saldo_transito]
		This.SetItem(ll_Linha, "qt_est_transito", ll_qt_transito)	  	
	End If
	
	If Not wf_Venda_Diaria(ll_cd_produto, Ref lvdc_Venda_Diaria) Then Return -1
	
	This.SetItem(ll_Linha, "qt_media_venda", lvdc_Venda_Diaria)

	ll_Find_saldo_colocado = lvds_saldo_colocado.Find("cd_produto = " + String(ll_cd_produto), 1, lvds_saldo_colocado.RowCount())

	If ll_Find_saldo_colocado > 0 Then
		ll_qt_colocado = lvds_saldo_colocado.Object.qt_saldo_colocado[ll_Find_saldo_colocado]
		This.SetItem(ll_Linha, "qt_saldo_colocado", ll_qt_colocado)
	End If
Next

This.SetFilter('qt_dias_estoque <= ' + string(ivl_dias_estoque))
This.Filter()

Return ll_Linhas

end event

event dw_2::ue_cancel;call super::ue_cancel;SetPointer(HourGlass!)

// Desabilita os menus de confirma e cancela
If Not IsNull(ivm_Menu) Then
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	ivm_Menu.m_Editar.m_Desfazer.Enabled = False
End If

// De acordo com o tipo da DW faz o retrieve ou limpa a DW e insere nova linha
CHOOSE CASE ivi_Tipo_Cancelar
	CASE RETRIEVE
			This.Event ue_Retrieve()
	CASE ADDROW
		This.Reset()
		This.Event ue_AddRow()
	CASE RESET
			This.Event ue_Retrieve()
END CHOOSE

SetPointer(Arrow!)
end event

event dw_2::ue_retrieve;Long lvl_Linhas

This.Post Event ue_habilita_historico()

lvl_Linhas = This.Event ue_PreRetrieve()

If lvl_Linhas = 1 Then 
	//Desabilita o timer de inatividade, para que em querys que excedam o tempo
	// o sistema ap$$HEX1$$f300$$ENDHEX$$s o retorno dos dados n$$HEX1$$e300$$ENDHEX$$o desconecte do banco de dados
	If IsValid(gvo_Aplicacao) Then
		If gvo_Aplicacao.ivb_Usa_Timer_Out Then
			Idle(0)
		End If
	End If
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es ..."
	lvl_Linhas = This.Event ue_Recuperar()
	Close(w_Aguarde)
	
	//Reinicia o controle de inatividade. 
	If IsValid(gvo_Aplicacao) Then
		If gvo_Aplicacao.ivb_Usa_Timer_Out Then
			Idle(gvo_Aplicacao.ivi_Timer_Idle)
		End If
	End If
End If

If lvl_Linhas >= 0 Then
	lvl_Linhas = This.Event ue_PostRetrieve(lvl_Linhas)
End If

Try
	If gvo_Aplicacao.ivb_Forca_End_Transaction Then
		This.itr_Transacao.of_End_Transaction( )
	End If
Catch( RuntimeError ex )
End Try

Return lvl_Linhas
end event

