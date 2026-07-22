HA$PBExportHeader$w_ge367_atualizacao_preco_abcfarma.srw
forward
global type w_ge367_atualizacao_preco_abcfarma from dc_w_selecao_lista_relatorio
end type
type cb_atualizar from commandbutton within w_ge367_atualizacao_preco_abcfarma
end type
type cb_inconsistencias from commandbutton within w_ge367_atualizacao_preco_abcfarma
end type
end forward

global type w_ge367_atualizacao_preco_abcfarma from dc_w_selecao_lista_relatorio
integer width = 3429
integer height = 1900
string title = "GE367 - Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$os do Caderno ABC Farma"
long backcolor = 80269524
cb_atualizar cb_atualizar
cb_inconsistencias cb_inconsistencias
end type
global w_ge367_atualizacao_preco_abcfarma w_ge367_atualizacao_preco_abcfarma

type variables
string ivs_coluna[], ivs_nome[]

string is_preco_venda_fabrica

end variables

forward prototypes
public function boolean wf_altera_preco_fabrica ()
public function boolean wf_altera_preco_venda ()
public function boolean wf_atualiza_data_vigencia ()
public function boolean wf_atualiza_promocao ()
end prototypes

public function boolean wf_altera_preco_fabrica ();Boolean lvb_Sucesso = True

Long lvl_Linha, &
     lvl_Total, &
	  lvl_Produto,&
	  ll_Contador

Decimal lvdc_Preco

String lvs_UF, &
       lvs_Matricula
						
Open(w_Aguarde)
w_Aguarde.Title = "Atualizando Pre$$HEX1$$e700$$ENDHEX$$os de F$$HEX1$$e100$$ENDHEX$$brica..."

lvs_Matricula = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

lvl_Total = dw_2.RowCount()

w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Linha = 1 To lvl_Total
	lvl_Produto = dw_2.Object.Cd_Produto          [lvl_Linha]		
	lvs_UF      = dw_2.Object.Cd_Unidade_Federacao[lvl_Linha]		
	lvdc_Preco  = dw_2.Object.Vl_Preco_Novo       [lvl_Linha]
	
	If dw_2.Object.id_preco_fabrica_venda[lvl_Linha] <> 'PF' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de atualiza$$HEX2$$e700e300$$ENDHEX$$o diferente da esperada 'Pre$$HEX1$$e700$$ENDHEX$$o de Venda - PV' / Pre$$HEX1$$e700$$ENDHEX$$o de F$$HEX1$$e100$$ENDHEX$$brica - PF.", StopSign!)
		lvb_Sucesso = False		
		Exit
	End If	
	
	Update produto_uf
	Set vl_preco_reposicao           = :lvdc_Preco,
		 nr_matricula_preco_reposicao = :lvs_Matricula,
		 dh_preco_reposicao           = getdate()
 	Where cd_unidade_federacao = :lvs_UF
	  and cd_produto           = :lvl_Produto
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then 
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Reposi$$HEX2$$e700e300$$ENDHEX$$o do Produto '" + String(lvl_Produto) + "'")
		lvb_Sucesso = False		
		Exit
	End If

	Update produto_central
	Set dh_atualizacao_abcfarma = getdate()
	Where cd_produto = :lvl_Produto
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then 
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Data de Atualiza$$HEX2$$e700e300$$ENDHEX$$o ABC Farma do Produto '" + String(lvl_Produto) + "'")
		lvb_Sucesso = False		
		Exit
	End If
	
	ll_Contador ++ 
	
	If ll_Contador >= 100 Then
		ll_Contador = 0
		SqlCa.of_Commit();
	End If

	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

Close(w_Aguarde)

Return lvb_Sucesso
end function

public function boolean wf_altera_preco_venda ();Boolean lvb_Sucesso = True

Long lvl_Linha, &
     lvl_Total, &
	  lvl_Produto,&
	  ll_Contador

Decimal lvdc_Preco

String lvs_UF, &
       lvs_Matricula

Date lvdh_Vigencia, lvdh_Amanha
						
Open(w_Aguarde)
w_Aguarde.Title = "Atualizando Pre$$HEX1$$e700$$ENDHEX$$os de Venda..."

lvs_Matricula = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

lvdh_Amanha = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), 1)

lvl_Total = dw_2.RowCount()

w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Linha = 1 To lvl_Total
	lvl_Produto   	= dw_2.Object.Cd_Produto          			[lvl_Linha]		
	lvs_UF        		= dw_2.Object.Cd_Unidade_Federacao	[lvl_Linha]		
	lvdc_Preco    	= dw_2.Object.Vl_Preco_Novo       		[lvl_Linha]		
	lvdh_Vigencia 	= Date(dw_2.Object.Dh_Vigencia[lvl_Linha])
	
	If dw_2.Object.id_preco_fabrica_venda[lvl_Linha] <> 'PV' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de atualiza$$HEX2$$e700e300$$ENDHEX$$o diferente da esperada 'Pre$$HEX1$$e700$$ENDHEX$$o de Venda - PV' / Pre$$HEX1$$e700$$ENDHEX$$o de F$$HEX1$$e100$$ENDHEX$$brica - PF.", StopSign!)
		lvb_Sucesso = False		
		Exit
	End If	
	
	If lvdh_Vigencia < lvdh_Amanha Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data da vig$$HEX1$$ea00$$ENDHEX$$ncia dever$$HEX1$$e100$$ENDHEX$$ ser maior ou igual a '" + String(lvdh_Vigencia, 'dd/mm/yyyy') + "'.", StopSign!)
		lvb_Sucesso = False		
		Exit
	End If
	
	//If IsNull(lvdh_Vigencia) Then lvdh_Vigencia = lvdh_Amanha
	
	//If lvdh_Vigencia < lvdh_Amanha Then lvdh_Vigencia = lvdh_Amanha
				
	Update produto_uf
	Set vl_preco_venda_futuro        = :lvdc_Preco,
		 dh_preco_venda_futuro        = :lvdh_Vigencia,
		 nr_matric_preco_venda_futuro = :lvs_Matricula
	Where cd_unidade_federacao = :lvs_UF
	  and cd_produto           = :lvl_Produto
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then 
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda do Produto '" + String(lvl_Produto) + "'")
		lvb_Sucesso = False		
		Exit
	End If

	Update produto_central
	Set dh_atualizacao_abcfarma = getdate()
	Where cd_produto = :lvl_Produto
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then 
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Data de Atualiza$$HEX2$$e700e300$$ENDHEX$$o ABC Farma do Produto '" + String(lvl_Produto) + "'")
		lvb_Sucesso = False		
		Exit
	End If
	
	ll_Contador ++ 
	
	If ll_Contador >= 100 Then
		ll_Contador = 0
		SqlCa.of_Commit();
	End If

	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

Close(w_Aguarde)

Return lvb_Sucesso
end function

public function boolean wf_atualiza_data_vigencia ();Long ll_Linha, ll_Linhas, ll_Produto

String ls_UF

Date ldh_Termino, ldh_Vigencia_Parm, ldh_Vig_ABCFARMA, ldh_Nova_Vigencia

dw_2.AcceptText()
dw_1.AcceptText()

ldh_Vigencia_Parm = dw_1.Object.dt_inicio_vigencia[1]

If ldh_Vigencia_Parm < Date(gvo_Parametro.of_Dh_Movimentacao()) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data da vig$$HEX1$$ea00$$ENDHEX$$ncia dever$$HEX1$$e100$$ENDHEX$$ ser maior que a data atual.", StopSign!)
	dw_1.Event ue_Pos(1, 'dt_inicio_vigencia')
	Return False
End If

Open(w_Aguarde)

ll_Linhas = dw_2.RowCount()

w_aguarde.uo_progress.of_setmax(ll_Linhas)

For ll_Linha = 1 To ll_Linhas
	
	ll_Produto 				= dw_2.Object.cd_produto					[ll_Linha]
	ls_UF 						= dw_2.Object.	cd_unidade_federacao	[ll_Linha]
	ldh_Termino 			= Date(dw_2.Object.dh_termino_promocao	[ll_Linha])
	ldh_Vig_ABCFARMA	= Date(dw_2.Object.dh_vigencia[ll_Linha])
	
	// Data atual = 24/05/2016
	// ldh_Vigencia = 25/05/2016
	// ldh_Termino = 31/05/2016
	// ldh_Vig_ABCFARMA = 01/06/2016
	
	If IsNull(ldh_Termino) 			Then ldh_Termino 			= Date('01/01/2000')
	If IsNull(ldh_Vig_ABCFARMA) 	Then ldh_Vig_ABCFARMA 	= Date('01/01/2000')
	
	// Porque a vig$$HEX1$$ea00$$ENDHEX$$ncia deve ser um dia ap$$HEX1$$f300$$ENDHEX$$s o t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o
	ldh_Nova_Vigencia = RelativeDate(ldh_Termino, 1)
	
	If (ldh_Nova_Vigencia > ldh_Vigencia_Parm) and (ldh_Nova_Vigencia > ldh_Vig_ABCFARMA) Then
		dw_2.Object.dh_vigencia	[ll_Linha] = ldh_Nova_Vigencia
	End If
	
	If (ldh_Vig_ABCFARMA > ldh_Nova_Vigencia) and (ldh_Vig_ABCFARMA > ldh_Vigencia_Parm) Then
		dw_2.Object.dh_vigencia	[ll_Linha] = ldh_Vig_ABCFARMA
	End If
	
	If (ldh_Vigencia_Parm > ldh_Vig_ABCFARMA) and (ldh_Vigencia_Parm > ldh_Nova_Vigencia) Then
		dw_2.Object.dh_vigencia	[ll_Linha] = ldh_Vigencia_Parm
	End If
			
	w_aguarde.uo_progress.of_setprogress(ll_Linha)
		
Next

Close(w_Aguarde)

Return True
end function

public function boolean wf_atualiza_promocao ();Long ll_Linha, ll_Linhas, ll_Produto, ll_Promocao

String ls_Nome_Promocao, ls_UF

Date ldh_Termino

dw_2.AcceptText()

Open(w_Aguarde)

ll_Linhas = dw_2.RowCount()

w_aguarde.uo_progress.of_setmax(ll_Linhas)

w_Aguarde.Title = "Verificando as Promo$$HEX2$$e700f500$$ENDHEX$$es Bloqueadas ..."

For ll_Linha = 1 To ll_Linhas
	
	ll_Produto 	= dw_2.Object.cd_produto					[ll_Linha]
	ls_UF 			= dw_2.Object.	cd_unidade_federacao	[ll_Linha]
	
	select top 1 v.cd_promocao_sos, 
			v.nm_promocao_sos, 
			coalesce(v.dh_termino, cast('01/01/2030' as date)) 
	Into :ll_Promocao, :ls_Nome_Promocao, :ldh_Termino
	from vw_promocao_estoque_minimo v
	where v.cd_produto = :ll_Produto
	  and v.cd_uf = :ls_UF
	  and v.id_preco_bloqueado = 'S' 
	  and v.id_situacao = 'L'
	order by coalesce(v.dh_termino, cast('01/01/2030' as date)) desc
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			dw_2.Object.de_promocao				[ll_Linha] = String(ll_Promocao) + " - " + ls_Nome_Promocao
			dw_2.Object.dh_termino_promocao	[ll_Linha] = ldh_Termino
		Case 100
		Case -1
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Close(w_Aguarde)
			Return False
	End Choose	
	
	w_aguarde.uo_progress.of_setprogress(ll_Linha)
		
Next

Close(w_Aguarde)

Return True
end function

on w_ge367_atualizacao_preco_abcfarma.create
int iCurrent
call super::create
this.cb_atualizar=create cb_atualizar
this.cb_inconsistencias=create cb_inconsistencias
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_atualizar
this.Control[iCurrent+2]=this.cb_inconsistencias
end on

on w_ge367_atualizacao_preco_abcfarma.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_atualizar)
destroy(this.cb_inconsistencias)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dt_Inicio_Vigencia[1] = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), 1)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge367_atualizacao_preco_abcfarma
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge367_atualizacao_preco_abcfarma
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge367_atualizacao_preco_abcfarma
integer x = 14
integer y = 256
integer width = 3346
integer height = 1440
integer weight = 700
string text = "Lista de Produtos com Altera$$HEX2$$e700e300$$ENDHEX$$o"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge367_atualizacao_preco_abcfarma
integer x = 14
integer y = 0
integer width = 1568
integer height = 240
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge367_atualizacao_preco_abcfarma
integer x = 37
integer y = 52
integer width = 1513
integer height = 172
string dataobject = "dw_ge367_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;String ls_Aliquota_UF, lvs_DW

This.AcceptText()

If dwo.Name = "id_tipo" Then
	ls_Aliquota_UF = Mid(Data, 3)
	
	If Mid(Data, 1, 2) = 'PF' Then
		
		Parent.Width 	= 3450
		dw_2.Width		= 3282
		dw_1.Width		= 1513
		
		gb_2.Width 		= 3346
		gb_1.Width		= 1568
		This.Object.Id_Bloqueado[1] = "N"
		
		This.Object.dt_inicio_vigencia.Visible 		= False
		This.Object.dt_inicio_vigencia_t.Visible 	= False
		This.Object.id_bloqueado.Visible 			= False
		
		is_preco_venda_fabrica = 'PF'
		// PRE$$HEX1$$c700$$ENDHEX$$O DE FABRICA
		If ls_Aliquota_UF = 'SP' Then
			lvs_DW = "dw_ge367_lista_pfsp"
		Else
			lvs_DW = "dw_ge367_lista_pf"
		End If
	Else
		
		Parent.Width	= 4457
		dw_2.Width		= 4297
		dw_1.Width		= 2437
		gb_2.Width 		= 4352
		gb_1.Width		= 2473
		
		This.Object.dt_inicio_vigencia.Visible 		= True
		This.Object.dt_inicio_vigencia_t.Visible 	= True
		This.Object.id_bloqueado.Visible 			= True
		
		is_preco_venda_fabrica = 'PV'
		// PRE$$HEX1$$c700$$ENDHEX$$O DE VENDA
		If ls_Aliquota_UF = 'SP' Then
			lvs_DW = "dw_ge367_lista_pvsp"
		Else
			lvs_DW = "dw_ge367_lista_pv"
		End If
	End If
	
	If dw_2.DataObject <> lvs_DW Then
		If Not dw_2.of_ChangeDataObject(lvs_DW) Then Return 0
		
		dw_2.ShareData(dw_3)
		dw_2.of_SetRowSelection()
		
		dw_2.of_SetSort(ivs_Coluna, ivs_Nome)
	End If
End If

If dwo.Name = "dt_inicio_vigencia" Then
	If Date(data) < Date(gvo_Parametro.of_Dh_Movimentacao()) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data da vig$$HEX1$$ea00$$ENDHEX$$ncia dever$$HEX1$$e100$$ENDHEX$$ ser maior que a data atual.", StopSign!)
		dw_1.Event ue_Pos(1, 'dt_inicio_vigencia')
		Return 0
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge367_atualizacao_preco_abcfarma
integer x = 41
integer y = 308
integer width = 3282
integer height = 1352
string dataobject = "dw_ge367_lista_pf"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Decimal ldc_ICMS

String lvs_Tipo, &
       lvs_Bloqueado, &
       lvs_DW, &
		 lvs_Promocao, &
		 lvs_SQL
		 
Date ldh_Vigencia		 

String ls_Aliquota_UF

dw_1.AcceptText()

lvs_Tipo      		= dw_1.Object.Id_Tipo     			[1]
lvs_Bloqueado 	= dw_1.Object.Id_Bloqueado		[1]
ldh_Vigencia	= dw_1.Object.dt_inicio_vigencia	[1]

If ldh_Vigencia < Date(gvo_Parametro.of_Dh_Movimentacao()) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data da vig$$HEX1$$ea00$$ENDHEX$$ncia dever$$HEX1$$e100$$ENDHEX$$ ser maior que a data atual.", StopSign!)
	dw_1.Event ue_Pos(1, 'dt_inicio_vigencia')
	Return -1
End If

ls_Aliquota_UF = Mid(lvs_Tipo, 3)

If Mid(lvs_Tipo, 1, 2) = 'PF' Then
	is_preco_venda_fabrica = 'PF'
	// PRE$$HEX1$$c700$$ENDHEX$$O DE FABRICA
	If ls_Aliquota_UF = 'SP' Then
		lvs_DW = "dw_ge367_lista_pfsp"
	Else
		lvs_DW = "dw_ge367_lista_pf"
	End If
Else
	is_preco_venda_fabrica = 'PV'
	// PRE$$HEX1$$c700$$ENDHEX$$O DE VENDA
	If ls_Aliquota_UF = 'SP' Then
		lvs_DW = "dw_ge367_lista_pvsp"
	Else
		lvs_DW = "dw_ge367_lista_pv"
	End If
End If

If This.DataObject <> lvs_DW Then
	If Not This.of_ChangeDataObject(lvs_DW) Then Return -1
	
	This.ShareData(dw_3)
	This.of_SetRowSelection()
	
	This.of_SetSort(ivs_Coluna, ivs_Nome)
End If

If IsNumber(ls_Aliquota_UF) Then
	If ls_Aliquota_UF <> '12' and ls_Aliquota_UF <> '17' and ls_Aliquota_UF <> '18' and ls_Aliquota_UF <> '20' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS n$$HEX1$$e300$$ENDHEX$$o localizada '" + ls_Aliquota_UF + "'.", StopSign!)
		Return -1
	Else
		This.of_AppendWhere("uf.pc_icms_pmc = " + ls_Aliquota_UF)
	End If
Else
	If ls_Aliquota_UF <> 'SP' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS inv$$HEX1$$e100$$ENDHEX$$lida '" + ls_Aliquota_UF + "'.", StopSign!)
		Return -1
	End If	
End If

//lvs_Promocao = "(select * from promocao_sos x, promocao_sos_produto y" + &
//					" where x.dh_inicio <= (select dh_movimentacao from parametro where id_parametro = '1') and (x.dh_termino is null or x.dh_termino >= (select dh_movimentacao from parametro where id_parametro = '1'))" + &
//					" and x.id_preco_bloqueado = 'S' and x.id_situacao = 'L'" + &
//					" and y.cd_promocao_sos = x.cd_promocao_sos and y.cd_produto = c.cd_produto)"

//lvs_Promocao = 	" (select * from vw_promocao_estoque_minimo x " +&
//						" where x.id_preco_bloqueado = 'S' " + &
//						" and  x.id_situacao = 'L' " +&
//						" and x.cd_produto = c.cd_produto" +&
//						" and x.cd_uf		= u.cd_unidade_federacao )"

//If lvs_Bloqueado = "S" Then
//	lvs_SQL = "(g.id_preco_bloqueado = 'S' or exists " + lvs_Promocao + ")"
//Else
//	lvs_SQL = "g.id_preco_bloqueado = 'N' and not exists " + lvs_Promocao
//End If

//If lvs_Bloqueado = "S" Then
//	lvs_SQL = "exists " + lvs_Promocao
//Else
//	lvs_SQL = "not exists " + lvs_Promocao
//End If
//
//This.of_AppendWhere(lvs_SQL)

//This.of_Appendwhere("g.cd_produto = 701916")

Return 1
end event

event dw_2::constructor;call super::constructor;ivs_Coluna = {"cd_produto", &
				  "de_produto", &
				  "vl_preco_atual", &
				  "vl_preco_novo", &
				  "pc_variacao"}
				  
ivs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", &
				"Descri$$HEX2$$e700e300$$ENDHEX$$o", &
				"Pre$$HEX1$$e700$$ENDHEX$$o Atual", &
				"Pre$$HEX1$$e700$$ENDHEX$$o Novo", &
				"Varia$$HEX2$$e700e300$$ENDHEX$$o"}
				
This.of_SetSort(ivs_Coluna, ivs_Nome)

// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_reset;call super::ue_reset;cb_Atualizar.Enabled = False
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Boolean lb_Sucesso = False

String lvs_Bloqueado

dw_1.AcceptText()

lvs_Bloqueado = dw_1.Object.Id_Bloqueado[1]

If pl_Linhas > 0 Then
		
	This.SetFilter("")
	This.Filter()
	
	If is_preco_venda_fabrica = 'PV' Then
					
		If wf_Atualiza_Promocao() Then 
			If wf_Atualiza_data_vigencia() Then
				lb_Sucesso = True
			End If
		End If
		
		If lvs_Bloqueado = 'S' Then
			This.SetFilter("de_promocao <> ''")
			This.Filter( )
		Else
			This.SetFilter("de_promocao = ''")
			This.Filter( )
		End If
		
		If Not lb_Sucesso Then
			cb_Atualizar.Enabled = False
			ivm_Menu.mf_SalvarComo(False)
			Return pl_Linhas
		End If
	End If
	
	cb_Atualizar.Enabled = True
		
	ivm_Menu.mf_SalvarComo(True)
Else
	cb_Atualizar.Enabled = False
	
	ivm_Menu.mf_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge367_atualizacao_preco_abcfarma
integer x = 3159
integer y = 32
integer width = 329
integer height = 116
integer taborder = 60
end type

type cb_atualizar from commandbutton within w_ge367_atualizacao_preco_abcfarma
integer x = 2537
integer y = 24
integer width = 576
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Atualizar Pre$$HEX1$$e700$$ENDHEX$$os"
end type

event clicked;Boolean lvb_Sucesso

String lvs_Tipo

SetPointer(HourGlass!)

dw_1.AcceptText()

lvs_Tipo = dw_1.Object.Id_Tipo[1]

//Choose Case lvs_Tipo
//	Case "PF17", "PF18", "PF12", "PF20", "PFSP"
//		lvb_Sucesso = wf_Altera_Preco_Fabrica()
//		
//	Case "PV17", "PV18", "PV12", "PV20", "PVSP"
//		lvb_Sucesso = wf_Altera_Preco_Venda()
//End Choose

If is_preco_venda_fabrica = 'PF' Then
	lvb_Sucesso = wf_Altera_Preco_Fabrica()
Else
	lvb_Sucesso = wf_Altera_Preco_Venda()
End If

If lvb_Sucesso Then 
	Update parametro
	Set dh_atualizacao_abcfarma = getdate()
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro Data de Atualiza$$HEX2$$e700e300$$ENDHEX$$o ABC Farma")
		lvb_Sucesso = False
	End If	
End If

If lvb_Sucesso Then
	SqlCa.of_Commit()	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.")
	
	dw_2.Event ue_Retrieve()
Else
	SqlCa.of_RollBack()
End If

SetPointer(Arrow!)
end event

type cb_inconsistencias from commandbutton within w_ge367_atualizacao_preco_abcfarma
integer x = 2537
integer y = 132
integer width = 576
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Inconsist$$HEX1$$ea00$$ENDHEX$$ncias..."
end type

event clicked;Open(w_ge367_inconsistencia_preco_abcfarma)
end event

