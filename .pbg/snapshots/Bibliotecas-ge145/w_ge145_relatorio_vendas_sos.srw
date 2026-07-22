HA$PBExportHeader$w_ge145_relatorio_vendas_sos.srw
forward
global type w_ge145_relatorio_vendas_sos from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge145_relatorio_vendas_sos from dc_w_selecao_lista_relatorio
string tag = "w_ge145_relatorio_vendas_sos"
string accessiblename = "Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas com Desconto SOS (CO179)"
integer width = 3511
integer height = 1840
string title = "GE145 - Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas com Desconto SOS"
end type
global w_ge145_relatorio_vendas_sos w_ge145_relatorio_vendas_sos

type variables
uo_Fornecedor ivo_Fornecedor // GE003

uo_promocao ivo_promocao //GE065
end variables

forward prototypes
public function boolean wf_atualiza_valores (long al_produto, ref decimal adc_preco_reposicao, ref decimal adc_desc_fornecedor)
end prototypes

public function boolean wf_atualiza_valores (long al_produto, ref decimal adc_preco_reposicao, ref decimal adc_desc_fornecedor);Select vl_preco_reposicao,
		pc_desconto_fornecedor
Into	:adc_preco_reposicao,
		:adc_desc_fornecedor
From produto_central
Where cd_produto = :al_produto
Using SqlCa;

If SqlCa.SqlCode <> 0 Then
	SqlCa.of_msgDbError("Erro no Select do pre$$HEX1$$e700$$ENDHEX$$o do produto.")
	Return False
End If

Return True
end function

on w_ge145_relatorio_vendas_sos.create
call super::create
end on

on w_ge145_relatorio_vendas_sos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date lvdh_Inicio,&
		lvdh_Termino


ivo_Fornecedor 	= Create uo_Fornecedor
ivo_promocao		= Create uo_Promocao

lvdh_Termino 	= Date(gvo_Parametro.of_dh_Movimentacao())
lvdh_Inicio		= RelativeDate(lvdh_Termino, -7)

dw_1.Object.dh_inicio	[1] = lvdh_Inicio
dw_1.Object.dh_termino	[1] = lvdh_Termino

////
//DataWindowChild lvds_Grupo
//
////cd_grupo
//lvds_Grupo = dw_1.of_InsertRow_DDDW("cd_grupo")
////
//lvds_Grupo.SetItem(1, "cd_grupo", "0")
//lvds_Grupo.SetItem(1, "de_grupo", "TODOS")
////
//dw_1.Object.cd_grupo[1] = 0

ivo_Promocao.ivs_Tipo = "S"

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy(ivo_promocao)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge145_relatorio_vendas_sos
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge145_relatorio_vendas_sos
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge145_relatorio_vendas_sos
integer y = 372
integer width = 3406
integer height = 1256
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge145_relatorio_vendas_sos
integer width = 1938
integer height = 344
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge145_relatorio_vendas_sos
integer x = 69
integer width = 1883
string dataobject = "dw_ge145_selecao"
end type

event dw_1::editchanged;call super::editchanged;//ivm_Menu.ivb_Permite_Imprimir = False
ivm_Menu.mf_SalvarComo(False)
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "de_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.de_fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
				This.Object.cd_fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor			
			End If
			
		Case "de_promocao"
			ivo_Promocao.of_Localiza(This.GetText())
			
			If ivo_Promocao.Localizado Then
				This.Object.de_promocao[1] = ivo_Promocao.Nm_Promocao
				This.Object.cd_promocao[1] = ivo_Promocao.Cd_Promocao
				This.Object.dh_inicio		[1] = ivo_Promocao.dh_inicio
				This.Object.dh_termino	[1] = ivo_Promocao.dh_termino
			End If
			
			
	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.cd_fornecedor	[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.de_fornecedor	[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
	Case "de_promocao"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Promocao.Nm_Promocao Then
				Return 1
			End If
		Else
			ivo_Promocao.of_Inicializa()
			
			This.Object.cd_promocao	[1] = ivo_Promocao.Cd_Promocao
			This.Object.de_promocao	[1] = ivo_Promocao.Nm_Promocao
		End If
		
		
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge145_relatorio_vendas_sos
integer y = 432
integer width = 3355
integer height = 1168
string dataobject = "dw_ge145_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide

Date lvdh_Inicio,&
		lvdh_Termino
		
Long lvl_Promocao
	
dw_1.AcceptText()

lvdh_Inicio 		= dw_1.object.dh_inicio				[1]
lvdh_Termino		= dw_1.Object.dh_termino			[1]
lvl_Promocao		= dw_1.Object.cd_promocao		[1]

If IsNull(lvdh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1,"dh_inicio")
	Return -1
End If

If IsNull(lvdh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	dw_1.Event ue_Pos(1,"dh_termino")
	Return -1
End If

If lvdh_Inicio > lvdh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor do que a data de t$$HEX1$$e900$$ENDHEX$$mino.", Information!)
	dw_1.Event ue_Pos(1,"dh_inicio")
	Return -1
End If

If IsNull(lvl_Promocao) or lvl_Promocao <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	dw_1.Event ue_Pos(1,"de_promocao")
	Return -1
End If

//If lvs_Grupo <> "0" Then
//	This.Of_AppendWhere("v.cd_grupo	= '" + lvs_Grupo + "'")
//End If
//
//If lvs_Fornecedor <> "" Then
//	This.Of_AppendWhere("p.cd_fornecedor_usual = '"+  lvs_Fornecedor + "'")
//End If

//If Not IsNull(lvl_Promocao) Then	
//	//This.Of_AppendWhere("i.cd_promocao_sos = "+  string(lvl_Promocao) + "")
//		
//	This.Of_AppendWhere(	"i.cd_produto in (select pp.cd_produto from promocao_sos_produto pp," +&
//									" promocao_sos p where p.cd_promocao_sos		= pp.cd_promocao_sos" + &
//									"  and p.cd_promocao_sos = " + String(lvl_Promocao) + ")")
//End If

Return Retrieve(lvdh_Inicio, lvdh_Termino, lvl_Promocao )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha,&
		lvl_Produto,&
		lvl_Qtde_Vendida

Decimal lvdc_Preco_Reposicao,&
			lvdc_Desconto_Fornecedor,&
			lvdc_Liquido,&
			lvdc_Custo_UN,&
			lvdc_Custo

If pl_Linhas > 0 Then
	
	Open(w_aguarde)
	w_aguarde.title = "Atualizando valores..."
	w_aguarde.uo_progress.Of_SetMax(pl_Linhas)
	
	SetRedRaw(False)
	
	For lvl_Linha = 1 To pl_Linhas
		
		lvdc_Preco_Reposicao 		= 0.00
		lvdc_Desconto_Fornecedor	= 0.00
		lvdc_Liquido						= 0.00
		lvdc_Custo_UN					= 0.00
		lvdc_Custo						= 0.00
	
		w_aguarde.uo_progress.Of_SetProgress(lvl_Linha)
		
		lvl_Produto 			= This.Object.cd_produto	[lvl_Linha]
		lvl_Qtde_Vendida 	= This.Object.qt_vendida	[lvl_Linha]
		lvdc_Custo			= This.Object.custo_geral	[lvl_Linha]
	
		If Not wf_Atualiza_Valores(lvl_Produto, Ref lvdc_Preco_Reposicao, Ref lvdc_Desconto_Fornecedor) Then
			Return -1
		End If
		
		This.Object.vl_preco_reposicao			[lvl_Linha] = lvdc_Preco_Reposicao

		lvdc_Custo_UN = Round( lvdc_Custo / lvl_Qtde_Vendida  , 2 )
		This.Object.vl_custo_unitario			[lvl_Linha] = lvdc_Custo_UN
		
		This.AcceptText()
		
	Next	

	This.of_SetRowSelection()
	
	SetRedRaw(True)
	
	Close(w_aguarde)
	
	ivm_Menu.mf_SalvarComo(True)
Else
	ivm_Menu.mf_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_produto"     , &
				  "de_produto"   , &
				  "nm_razao_social", &
				  "qt_vendida" }
			
lvs_Nome   = {"C$$HEX1$$f300$$ENDHEX$$digo do Produto"		  , &
				  "Descri$$HEX2$$e700e300$$ENDHEX$$o do Produto"		  , &
				  "Fornecedor", &
				  "Qtde. Vendida"}
				 
This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

//This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Sumarizado, ls_dw, ls_rel
	
dw_1.AcceptText()

ls_Sumarizado = dw_1.object.id_sumarizado [1]

If ls_Sumarizado = 'S' Then
	ls_dw = "dw_ge145_lista_sumarizado"
	ls_rel = "dw_ge145_rel_sumarizado"
Else
	ls_dw = "dw_ge145_lista"
	ls_rel = "dw_ge145_relatorio"
End If

If Not 	This.of_ChangeDataObject( ls_dw ) Then
	MessageBOx("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no ChangeDataObject")
	Return -1
End If

If Not 	dw_3.of_ChangeDataObject( ls_rel ) Then
	MessageBOx("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no ChangeDataObject")
	Return -1
End If

dw_2.ShareData( dw_3 )

Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge145_relatorio_vendas_sos
integer x = 2062
integer y = 36
integer width = 370
integer height = 232
string dataobject = "dw_ge145_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;This.Object.st_periodo.Text = String(dw_1.Object.dh_inicio[1],"dd/mm/yyyy") +&
							  ' at$$HEX1$$e900$$ENDHEX$$ ' + String(dw_1.Object.dh_termino[1],"dd/mm/yyyy")
							  
This.GroupCalc()

Return 1
end event

