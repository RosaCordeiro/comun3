HA$PBExportHeader$w_ge268_consulta_produto.srw
forward
global type w_ge268_consulta_produto from dc_w_sheet
end type
type tab_1 from tab within w_ge268_consulta_produto
end type
type tabpage_1 from userobject within tab_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_1 gb_1
dw_1 dw_1
end type
type tabpage_6 from userobject within tab_1
end type
type gb_12 from groupbox within tabpage_6
end type
type dw_12 from dc_uo_dw_base within tabpage_6
end type
type tabpage_6 from userobject within tab_1
gb_12 gb_12
dw_12 dw_12
end type
type tabpage_5 from userobject within tab_1
end type
type gb_11 from groupbox within tabpage_5
end type
type gb_10 from groupbox within tabpage_5
end type
type dw_10 from dc_uo_dw_base within tabpage_5
end type
type dw_11 from dc_uo_dw_base within tabpage_5
end type
type tabpage_5 from userobject within tab_1
gb_11 gb_11
gb_10 gb_10
dw_10 dw_10
dw_11 dw_11
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type st_1 from statictext within tabpage_3
end type
type gb_7 from groupbox within tabpage_3
end type
type gb_6 from groupbox within tabpage_3
end type
type gb_5 from groupbox within tabpage_3
end type
type dw_3 from dc_uo_dw_base within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type dw_5 from dc_uo_dw_base within tabpage_3
end type
type cbx_mostra_produtos_planograma from checkbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
st_1 st_1
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
cbx_mostra_produtos_planograma cbx_mostra_produtos_planograma
end type
type tabpage_4 from userobject within tab_1
end type
type gb_9 from groupbox within tabpage_4
end type
type gb_8 from groupbox within tabpage_4
end type
type gb_4 from groupbox within tabpage_4
end type
type gb_3 from groupbox within tabpage_4
end type
type dw_6 from dc_uo_dw_base within tabpage_4
end type
type dw_7 from dc_uo_dw_base within tabpage_4
end type
type dw_8 from dc_uo_dw_base within tabpage_4
end type
type dw_9 from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_1
gb_9 gb_9
gb_8 gb_8
gb_4 gb_4
gb_3 gb_3
dw_6 dw_6
dw_7 dw_7
dw_8 dw_8
dw_9 dw_9
end type
type tab_1 from tab within w_ge268_consulta_produto
tabpage_1 tabpage_1
tabpage_6 tabpage_6
tabpage_5 tabpage_5
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type st_8 from statictext within w_ge268_consulta_produto
end type
end forward

global type w_ge268_consulta_produto from dc_w_sheet
string tag = "w_ge268_consulta_produto"
integer width = 3712
integer height = 2320
string title = "GE268 - Consulta de Produtos"
string menuname = ""
long backcolor = 80269524
tab_1 tab_1
st_8 st_8
end type
global w_ge268_consulta_produto w_ge268_consulta_produto

type variables
uo_produto ivo_produto

//uo_fornecedor ivo_fornecedor

//uo_fabricante ivo_fabricante

//uo_produto_abcfarma ivo_produto_abcfarma

//uo_grupo_produto ivo_grupo

//uo_subgrupo_produto ivo_subgrupo

//uo_classificacao_produto ivo_classificacao

//uo_dcb ivo_dcb

//uo_grupo_alteracao_preco ivo_grupo_alteracao_preco

//uo_ge228_marca_produto ivo_marca_produto

//uo_ge220_tributacao_produto ivo_tributacao

Boolean ivb_produto_novo

DateTime ivdh_parametro

Long ivl_produto_busca_facil
Long il_Pbm = 0

String ivs_path_fotos_ecommerce
String ivs_path_fotos_categoria
String is_Mensagem_Motivo_Situacao = "INFORME O MOTIVO PELO QUAL A SITUA$$HEX2$$c700c300$$ENDHEX$$O FOI ALTERADA..."
String is_Nm_Pbm = ""
end variables

forward prototypes
public subroutine wf_imprime_relatorio ()
public subroutine wf_localiza_path_fotos ()
public function boolean wf_localiza_foto (long al_produto, string as_tipo)
public function boolean wf_consulta_produto (long al_produto, ref string as_grupo, ref string as_lei_generico)
public function boolean wf_preco_atual (long al_produto, ref decimal adc_valor, string as_uf)
public subroutine wf_localiza_niveis_categoria (long al_categoria, ref string as_niveis)
public subroutine wf_set_somente_consulta ()
public function boolean wf_verifica_pbm ()
public subroutine wf_lista_divisao_fornecedor ()
public subroutine wf_atualiza_divisao_fornecedor (string as_fornecedor, long al_produto)
end prototypes

public subroutine wf_imprime_relatorio ();Long lvl_Produto

SetPointer(HourGlass!)

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Geral[1]

If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	If Not lvds_1.of_ChangeDataObject("dw_ge268_relatorio") Then Return

	If lvds_1.Retrieve(lvl_Produto) > 0 Then
		lvds_1.Print()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados para impress$$HEX1$$e300$$ENDHEX$$o da ficha do produto '" + String(lvl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizados.", StopSign!)
	End If

	Destroy(lvds_1)
End If

SetPointer(Arrow!)
end subroutine

public subroutine wf_localiza_path_fotos ();Select vl_parametro
Into :ivs_Path_Fotos_Ecommerce
From parametro_geral
Where cd_parametro = 'DE_PATH_FOTOS_ECOMMERCE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O caminho para a localiza$$HEX2$$e700e300$$ENDHEX$$o das fotos do Ecommerce n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela PARAMETRO_GERAL.")
		Return
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do caminho para as fotos do eCommerce")
		Return 
End Choose

Select vl_parametro
Into :ivs_Path_Fotos_Categoria
From parametro_geral
Where cd_parametro = 'DE_PATH_FOTOS_CATEGORIA'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O caminho para a localiza$$HEX2$$e700e300$$ENDHEX$$o das fotos das categorias n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela PARAMETRO_GERAL.")
		Return
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do caminho para as fotos das categorias")
		Return 
End Choose

end subroutine

public function boolean wf_localiza_foto (long al_produto, string as_tipo);String lvs_Arquivo,&
	   lvs_EAN

// eCommerce
If as_Tipo = 'E' Then
	lvs_Arquivo = ivs_path_fotos_ecommerce + "\" + String(al_Produto) + ".jpg"
Else
	
	// Categoria
	
	Select de_codigo_barras
	Into :lvs_EAN
	From codigo_barras_produto
	Where cd_produto 	= :al_Produto
	  and id_principal 	= 'S'
	Using SqlCa;
	
	If SqlCA.SqlCode = -1 Then
		SqlCa.of_MsgDBError('Localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo de barras')
		Return False
	End IF
	
	lvs_Arquivo = ivs_path_fotos_categoria + "\" + lvs_EAN + ".1"	
End If

If FileExists(lvs_Arquivo) Then
	Return True
Else
	Return False
End If
end function

public function boolean wf_consulta_produto (long al_produto, ref string as_grupo, ref string as_lei_generico);Select substring(cd_subcategoria, 1, 1), id_lei_generico
Into :as_Grupo, :as_Lei_Generico
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar os dados do produto '" + String(al_Produto) + "'.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do produto '" + String(al_Produto) + "'")
		Return False
End Choose

Return True


end function

public function boolean wf_preco_atual (long al_produto, ref decimal adc_valor, string as_uf);Select vl_preco_venda_atual
Into :adc_Valor
From produto_uf
Where cd_unidade_federacao = :as_UF
  and cd_produto		   = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de venda atual do produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foi localidado.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de venda atual do produto '" + String(al_Produto) + "'")
		Return False
End Choose

Return True
end function

public subroutine wf_localiza_niveis_categoria (long al_categoria, ref string as_niveis);String lvs_Nivel,&
	   lvs_Nivel_Array[]

Long lvl_Pai,&
	 lvl_Categoria
	 
Integer lvi_Array = 1,&
	    lvi_Niveis

Select de_categoria, cd_categoria_pai
Into :lvs_Nivel, :lvl_Pai
From categoria_ecommerce
Where cd_categoria = :al_Categoria
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
End Choose

as_Niveis = lvs_Nivel

lvs_Nivel_Array[lvi_Array] = lvs_Nivel

Do While lvl_Pai <> 0
	
	al_Categoria = lvl_Pai
	
	lvi_Array ++
	
	Select de_categoria, cd_categoria_pai
	Into :lvs_Nivel, :lvl_Pai
	From categoria_ecommerce
	Where cd_categoria = :al_Categoria
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
		Case -1
	End Choose
	
	lvs_Nivel_Array[lvi_Array] = lvs_Nivel

LOOP

lvi_Niveis = UpperBound(lvs_Nivel_Array)

// Se tiver mais de um n$$HEX1$$ed00$$ENDHEX$$vel monta os niveis
If lvi_Niveis > 1 Then
	
	as_Niveis = ""
	
	Do While lvi_Niveis <> 0
		
		as_Niveis = as_Niveis + lvs_Nivel_Array[lvi_Niveis] 
		
		If lvi_Niveis <> 1 Then
			as_Niveis = as_Niveis + " / "
		End If
				
		lvi_Niveis --
	Loop
		
End If






end subroutine

public subroutine wf_set_somente_consulta ();Tab_1.TabPage_1.dw_1.of_Set_Somente_Leitura(False)
Tab_1.TabPage_2.dw_2.of_Set_Somente_Leitura(False)
Tab_1.TabPage_3.dw_3.of_Set_Somente_Leitura(False)
Tab_1.TabPage_3.dw_4.of_Set_Somente_Leitura(False)
Tab_1.TabPage_3.dw_5.of_Set_Somente_Leitura(False)
Tab_1.TabPage_4.dw_6.of_Set_Somente_Leitura(False)
Tab_1.TabPage_4.dw_7.of_Set_Somente_Leitura(False)
Tab_1.TabPage_4.dw_8.of_Set_Somente_Leitura(False)
Tab_1.TabPage_4.dw_9.of_Set_Somente_Leitura(False)
Tab_1.TabPage_5.dw_10.of_Set_Somente_Leitura(False)
Tab_1.TabPage_5.dw_11.of_Set_Somente_Leitura(False)
Tab_1.TabPage_6.dw_12.of_Set_Somente_Leitura(False)
end subroutine

public function boolean wf_verifica_pbm ();il_Pbm = 0
is_Nm_Pbm = ""

Select Count(pp.cd_pbm), p.nm_pbm
  Into :il_Pbm, :is_Nm_Pbm
From pbm p
	Inner Join pbm_produto pp
		On pp.cd_pbm = p.cd_pbm
Where pp.cd_produto = :ivo_Produto.Cd_Produto
Group By p.nm_pbm
Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs do produto '" + String(ivo_Produto.Cd_Produto) + "'.")
	Return False
End If

Return True
end function

public subroutine wf_lista_divisao_fornecedor ();DataWindowChild lvdwc

String ls_SQL, ls_Fornecedor

Tab_1.TabPage_1.dw_1.AcceptText()

ls_Fornecedor = Tab_1.TabPage_1.dw_1.Object.cd_fornecedor_usual[1]
	
If Tab_1.TabPage_1.dw_1.GetChild("nr_divisao_fornecedor", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
	
	//cast(f.nr_divisao as char(2)) + ' - ' + f.nm_divisao + ' | ' +  u.nm_usuario de_divisao,
		
	ls_SQL = " SELECT 	cast(f.nr_divisao as char(5)) + ' - ' + f.nm_divisao + ' | ' +  u.nm_usuario de_divisao, f.nr_divisao FROM fornecedor_divisao f   " +&
				 " inner join usuario u on u.nr_matricula = f.nr_matricula_comprador " +&
				 " where f.cd_fornecedor = '" + string(ls_Fornecedor) + "'" +&
				 " union " +&
				 " select 'NENHUMA', null"				 
	
	lvdwc.SetSQLSelect(ls_SQL)
		
	If lvdwc.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor.")
		Return 
	End If		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild divis$$HEX1$$e300$$ENDHEX$$o fornecedor.")
End If
end subroutine

public subroutine wf_atualiza_divisao_fornecedor (string as_fornecedor, long al_produto);Long ll_Divisao

Select nr_divisao 
Into :ll_Divisao
From fornecedor_divisao_produto
Where cd_fornecedor = :as_fornecedor
  and cd_produto = :al_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor.")
	Return
Else
	If SqlCa.Sqlcode = 100 Then
		SetNull(ll_Divisao)
		Tab_1.TabPage_1.dw_1.Object.nr_divisao_fornecedor[1] = ll_Divisao
	Else
		Tab_1.TabPage_1.dw_1.Object.nr_divisao_fornecedor[1] = ll_Divisao
	End If
End If

end subroutine

on w_ge268_consulta_produto.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_8=create st_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_8
end on

on w_ge268_consulta_produto.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_8)
end on

event ue_postopen;call super::ue_postopen;ivdh_Parametro = gvo_Parametro.of_Dh_Movimentacao()

This.ivm_menu.ivb_permite_alterar = False
Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_5.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_6.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_7.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_8.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_9.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_5.dw_10.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_5.dw_11.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_6.dw_12.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_4.dw_6.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_4.dw_9.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_5.dw_11.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_6.dw_12.ivo_Controle_Menu.of_Incluir(False)

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_produto_localizacao")

// Localiza o caminho das fotos para o eCommerce e para as Categorias
wf_Localiza_Path_Fotos()
end event

event open;call super::open;ivo_Produto = Create uo_Produto
end event

event close;call super::close;Destroy(ivo_Produto)
end event

event ue_cancel;call super::ue_cancel;Tab_1.TabPage_1.dw_1.Event ue_Cancel()
end event

event ue_print;wf_Imprime_Relatorio()
end event

event ue_printimmediate;wf_Imprime_Relatorio()
end event

event ue_preopen;//override
This.ChangeMenu(m_janelas)

//Executa evento da tela pai
SUPER::EVENT ue_preopen()
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge268_consulta_produto
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge268_consulta_produto
end type

type tab_1 from tab within w_ge268_consulta_produto
integer x = 5
integer y = 8
integer width = 3639
integer height = 2064
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 80269524
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_6 tabpage_6
tabpage_5 tabpage_5
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_6=create tabpage_6
this.tabpage_5=create tabpage_5
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_6,&
this.tabpage_5,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_6)
destroy(this.tabpage_5)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event clicked;Choose Case Index
	Case 1
		If Tab_1.TabPage_1.dw_1.GetColumnName() = "" Then
			Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_produto")
		End If
		
	Case 3
		If Tab_1.TabPage_2.dw_2.GetColumnName() = "" Then
			Tab_1.TabPage_2.dw_2.Event ue_Pos(1, "id_situacao_pis_cofins")
		End If
End Choose
end event

event selectionchanged;Choose Case NewIndex
	Case 2
		Tab_1.tabpage_6.dw_12.Event ue_Retrieve()
	Case 3
		Tab_1.tabpage_5.dw_11.Event ue_Retrieve()
	Case 5
		Tab_1.tabpage_3.dw_3.Event ue_Retrieve()
		Tab_1.tabpage_3.dw_4.Event ue_Retrieve()
		Tab_1.tabpage_3.dw_5.Event ue_Retrieve()
	Case 6
		Tab_1.tabpage_4.dw_6.Event ue_Retrieve()		
		Tab_1.tabpage_4.dw_7.Event ue_Retrieve()		
		Tab_1.tabpage_4.dw_9.Event ue_Retrieve()			
End Choose

This.Event Clicked(NewIndex)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3602
integer height = 1948
long backcolor = 79741120
string text = "Principal"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_1 gb_1
dw_1 dw_1
end type

on tabpage_1.create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.gb_1,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.gb_1)
destroy(this.dw_1)
end on

type gb_1 from groupbox within tabpage_1
integer x = 14
integer width = 3561
integer height = 1940
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 27
integer y = 60
integer width = 3534
integer height = 1868
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_principal"
end type

event constructor;call super::constructor;String lvs_Chave_Geral[], &
       lvs_Coluna_Geral[], &
		 lvs_Chave_Central[], &
		 lvs_Coluna_Central[]
		 
This.of_SetMultitable()

lvs_Chave_Geral   = {"cd_produto_geral"}
lvs_Chave_Central = {"cd_produto_central"}

lvs_Coluna_Geral = {		"cd_produto_geral",               &
						  	"de_produto",                     &   
						  	"de_apresentacao_estoque",        &
						  	"de_apresentacao_venda",          &
						  	"nr_embalagem_padrao",            &
						  	"nr_classificacao_fiscal",        &
						  	"cd_unidade_medida_compra",       &
						  	"cd_unidade_medida_venda",        &
						  	"cd_grupo_produto",               &
						  	"cd_subgrupo_produto",            &
						  	"cd_linha_produto",               &
						  	"cd_fornecedor_usual",            &
						  	"id_situacao",                    &
						  	"id_liberado_filial",             &   
						  	"dh_alteracao_codigo_barras",     &
						  	"vl_fator_conversao",             &
						  	"pc_desconto_atual",              &
						  	"pc_desconto_futuro",             &
						  	"id_preco_bloqueado",             &
						  	"pc_ipi",                         &
						  	"cd_grupo_psico",                 &
						  	"cd_dcb",                         &
						  	"cd_origem_produto",              &
						  	"id_caderno_abcfarma",            &
						  	"pc_reducao_base_icms",           &
						  	"nr_matricula_desconto_futuro",   &
						  	"nr_matricula_desconto_atual",    &
						  	"dh_desconto_atual",              &
						  	"dh_desconto_futuro",             &
						  	"dh_inclusao_produto",            &
						  	"dh_termino_avaliacao",           &
						  	"id_tipo_desconto_atual",         &
						  	"id_proprio_consignado",          &
						  	"id_situacao_pis_cofins",         &
						  	"cd_subcategoria",                &
       				  		"vl_ponto_clube",                 		&
       				  		"qt_pontos_resgate",					&
						  	"pc_desconto_clube_atual",				&
						  	"dh_desconto_clube_atual",				&
						  	"nr_matric_desc_clube_atual",     		&
						  	"pc_desconto_clube_futuro",				&
						  	"dh_desconto_clube_futuro",				&
						  	"nr_matric_desc_clube_futuro",    		&
						  	"id_utiliza_vale_resgate", 				&
						  	"qt_unidades_embalagem", 				&         
						  	"qt_concentracao", 						&
						  	"id_apresentacao", 						&
						  	"qt_dias_maximo_tratamento", 			&
						  	"vl_volume", 							&
						  	"cd_fabricante", 						&
						  	"de_registro_ms",						&
						  	"id_lei_generico",						&
						  	"id_recuperacao_vencido",				&
						  	"de_descricao_internet",				&
						  	"qt_altura_cm",							&
						  	"qt_largura_cm",						&
						  	"qt_profundidade_cm",					&
						  	"qt_peso_grama",						&
							"id_liberado_ecommerce",				&
							"de_principal_internet", &
							"id_farmacia_popular",&
							"id_gratis_farm_popular", &
							"cd_planograma",&
							"cd_marca",&
							"cd_st_origem",&
							"id_geladeira",&
							"qt_comprimento"} 

lvs_Coluna_Central = {"cd_produto_central",            &
                      "cd_mix_produto",                &
                      "id_tipo_reposicao_estoque",     &
					  "cd_produto_fornecedor",         &
					  "pc_desconto_fornecedor",        &
					  "vl_peso_liquido",               &
					  "dh_situacao",                   &
					  "cd_local_estocagem",            &
					  "id_origem_produto_fornecedor",  &
					  "cd_produto_abcfarma",           &
					  "vl_fator_conversao_abcfarma",   &
					  "cd_divisao_estocagem",          &
					  "id_preco_informado",            &
					  "id_contrato_fornecedor",        &
					  "id_pagamento_apos_venda",       & 
					  "id_sugere_pedido_filial",       &
					  "id_lei_generico",			   &
					  "id_projeto_conexao",&
					  "cd_grupo_alteracao_preco",&
					  "id_revisao_fiscal", &
					  "qt_largura_cm_caixa_forn", & 
					  "qt_altura_cm_caixa_forn", &
					  "qt_profundidade_cm_caixa_forn", &   
				   	   "qt_largura_cm_caixa_estoque", &  
					   "qt_altura_cm_caixa_estoque", &   
					   "qt_profund_cm_caixa_estoque",&
						"nr_matric_alteracao_situacao", &
						"de_alteracao_situacao", &
						"cd_bairro_wms"}

This.ivo_Multitable.of_SetUpdateTable("produto_geral"  , lvs_Chave_Geral  , lvs_Coluna_Geral)
This.ivo_Multitable.of_SetUpdateTable("produto_central", lvs_Chave_Central, lvs_Coluna_Central)

This.ivs_Coluna_Sem_Validacao_Salva = {"de_produto_localizacao"}

This.ShareData(Tab_1.TabPage_2.dw_2)
This.ShareData(Tab_1.TabPage_5.dw_10)

This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	This.ivm_Menu.mf_Confirmar(True)
	This.ivm_Menu.mf_Cancelar(True)
End If
end event

event ue_key;Choose Case Key
	Case KeyEnter!
		
		If This.GetColumnName() = "de_produto_localizacao" Then
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				Tab_1.TabPage_3.cbx_mostra_produtos_planograma.Checked = False
				This.Event ue_Retrieve()				
			End If
		End If
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If	
		
End Choose
end event

event ue_preinsertrow;call super::ue_preinsertrow;If wf_Valida_Salva() > 0 Then
	This.Reset()
	Return 1
Else
	Return -1
End If
end event

event ue_preretrieve;call super::ue_preretrieve;If wf_Valida_Salva() > 0 Then
	Return 1
Else
	Return -1
End If
end event

event ue_recuperar;// Override

Return This.Retrieve(ivo_Produto.Cd_Produto)
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event ue_cancel;call super::ue_cancel;This.Object.t_motivo.Text = "$$HEX1$$da00$$ENDHEX$$ltimo Motivo Altera$$HEX2$$e700e300$$ENDHEX$$o:"
This.SetTabOrder('de_alteracao_situacao', 0)
end event

event ue_postretrieve;call super::ue_postretrieve;DateTime lvdh_Termino_Avaliacao

If pl_Linhas > 0 Then
	If Not wf_Verifica_Pbm() Then Return -1
	
	If il_Pbm > 0 Then
		This.Object.Nm_Pbm[1] = is_Nm_Pbm
	Else
		This.Object.Nm_Pbm[1] = ""
	End If
	
	wf_Lista_Divisao_Fornecedor()
	
	If Not IsNull(This.Object.cd_fornecedor_usual[1]) and Not IsNull(This.Object.cd_produto_central[1]) Then
		wf_atualiza_divisao_fornecedor(This.Object.cd_fornecedor_usual[1],This.Object.cd_produto_central[1])
	End If
	
	// Verifica a data de t$$HEX1$$e900$$ENDHEX$$rmino da avalia$$HEX2$$e700e300$$ENDHEX$$o do produto
	lvdh_Termino_Avaliacao = This.Object.Dh_Termino_Avaliacao[1]
	
	If lvdh_Termino_Avaliacao < ivdh_Parametro Then
		This.Object.Text_Avaliacao.Text = ""
	Else
		This.Object.Text_Avaliacao.Text = "PRODUTO NOVO EM AVALIA$$HEX2$$c700c300$$ENDHEX$$O"
	End If
End If

Return pl_Linhas
end event

event ue_addrow;call super::ue_addrow;This.Object.Text_Avaliacao.Text = ""

Return AncestorReturnValue
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3602
integer height = 1948
long backcolor = 80269524
string text = "Subst$$HEX1$$e200$$ENDHEX$$ncias"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_12 gb_12
dw_12 dw_12
end type

on tabpage_6.create
this.gb_12=create gb_12
this.dw_12=create dw_12
this.Control[]={this.gb_12,&
this.dw_12}
end on

on tabpage_6.destroy
destroy(this.gb_12)
destroy(this.dw_12)
end on

type gb_12 from groupbox within tabpage_6
integer x = 14
integer width = 3122
integer height = 1760
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_12 from dc_uo_dw_base within tabpage_6
integer x = 50
integer y = 64
integer width = 3049
integer height = 1664
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_substancias"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()

datawindowChild dwc

Tab_1.TabPage_6.Dw_12.GetChild("cd_substancia", dwc)
dwc.setTransObject(SqlCa)
dwc.Retrieve()

end event

event ue_postretrieve;call super::ue_postretrieve;ivo_Controle_Menu.of_Excluir(False)

Return pl_Linhas
end event

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event ue_reset;call super::ue_reset;ivo_Controle_Menu.of_Excluir(False)
end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If
		
End Choose
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3602
integer height = 1948
long backcolor = 80269524
string text = "e-Commerce"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_11 gb_11
gb_10 gb_10
dw_10 dw_10
dw_11 dw_11
end type

on tabpage_5.create
this.gb_11=create gb_11
this.gb_10=create gb_10
this.dw_10=create dw_10
this.dw_11=create dw_11
this.Control[]={this.gb_11,&
this.gb_10,&
this.dw_10,&
this.dw_11}
end on

on tabpage_5.destroy
destroy(this.gb_11)
destroy(this.gb_10)
destroy(this.dw_10)
destroy(this.dw_11)
end on

type gb_11 from groupbox within tabpage_5
integer x = 14
integer y = 1296
integer width = 3506
integer height = 464
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Categorias"
borderstyle borderstyle = styleraised!
end type

type gb_10 from groupbox within tabpage_5
integer x = 14
integer y = 4
integer width = 3506
integer height = 1272
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_10 from dc_uo_dw_base within tabpage_5
integer x = 59
integer y = 96
integer width = 3355
integer height = 1140
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_ecommerce"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)

end event

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	This.ivm_Menu.mf_Confirmar(True)
	This.ivm_Menu.mf_Cancelar(True)
End If
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event itemchanged;call super::itemchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If	
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If
			
End Choose
end event

type dw_11 from dc_uo_dw_base within tabpage_5
integer x = 55
integer y = 1360
integer width = 3401
integer height = 364
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_ecommerce_categoria"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event itemchanged;call super::itemchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then
		ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event ue_addrow;call super::ue_addrow;DateTime lvdh_ServerDate

If AncestorReturnValue > 0 Then
	ivo_Controle_Menu.of_Excluir(True)
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;String lvs_Niveis

Long lvl_Categoria,&
	 lvl_Linha

If pl_Linhas > 0 Then
	ivo_Controle_Menu.of_Excluir(True)
	
	For lvl_Linha = 1 To pl_Linhas
		
		lvl_Categoria = This.Object.cd_categoria[lvl_Linha]
				
		wf_Localiza_Niveis_Categoria(lvl_Categoria, Ref lvs_Niveis)
		
		This.Object.de_detalhe[lvl_Linha] = lvs_Niveis
	Next
Else
	ivo_Controle_Menu.of_Excluir(False)
End If

Return pl_Linhas
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Produto, &
     lvl_Linha

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

// Exclui a $$HEX1$$fa00$$ENDHEX$$ltima linha em branco
If This.RowCount() > 0 Then
	If IsNull(This.Object.cd_categoria[This.RowCount()]) Then
		This.DeleteRow(This.RowCount())
	End If
End If

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Produto[lvl_Linha]) Then
		This.Object.Cd_Produto[lvl_Linha] = lvl_Produto
	End If
Next

Return 1
end event

event ue_recuperar;// Override
Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event ue_reset;call super::ue_reset;ivo_Controle_Menu.of_Excluir(False)
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.RowCount() > 0 Then
	If IsNull(This.Object.cd_categoria[This.RowCount()]) Then
		Return -1
	End If
End If

Return 1

end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If	
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If	
		
End Choose
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3602
integer height = 1948
long backcolor = 80269524
string text = "Fiscal / Estoque / Outros"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from dc_uo_dw_base within tabpage_2
integer x = 73
integer y = 44
integer width = 3401
integer height = 1796
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_fiscal_preco"
end type

event constructor;call super::constructor;This.of_SetUpdateAble()

This.of_SetColSelection(True)



end event

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	This.ivm_Menu.mf_Confirmar(True)
	This.ivm_Menu.mf_Cancelar(True)
End If
end event

event ue_populate_dddw;SetPointer(HourGlass!)

pdwc_dddw.SetTransObject(SqlCa)
pdwc_dddw.Retrieve()

SetPointer(Arrow!)
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()


end event

event ue_addrow;call super::ue_addrow;Messagebox("TESTE","TSTE")

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	//wf_Localiza_Grupo_Alteracao_Preco(This.Object.cd_grupo_alteracao_preco[1])	
End If

Return pl_Linhas
end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If	
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If	
		
End Choose
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3602
integer height = 1948
long backcolor = 80269524
string text = "Outros Pre$$HEX1$$e700$$ENDHEX$$os e Desc."
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
st_1 st_1
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
cbx_mostra_produtos_planograma cbx_mostra_produtos_planograma
end type

on tabpage_3.create
this.st_1=create st_1
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_5=create gb_5
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cbx_mostra_produtos_planograma=create cbx_mostra_produtos_planograma
this.Control[]={this.st_1,&
this.gb_7,&
this.gb_6,&
this.gb_5,&
this.dw_3,&
this.dw_4,&
this.dw_5,&
this.cbx_mostra_produtos_planograma}
end on

on tabpage_3.destroy
destroy(this.st_1)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cbx_mostra_produtos_planograma)
end on

type st_1 from statictext within tabpage_3
integer x = 1943
integer y = 76
integer width = 1211
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Mostrar Promo$$HEX2$$e700e300$$ENDHEX$$o do Tipo PLANOGRAMA"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_7 from groupbox within tabpage_3
integer x = 14
integer y = 1360
integer width = 2848
integer height = 404
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Pre$$HEX1$$e700$$ENDHEX$$os Regionalizados"
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within tabpage_3
integer x = 14
integer y = 804
integer width = 2848
integer height = 536
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Contratos com Conv$$HEX1$$ea00$$ENDHEX$$nios"
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within tabpage_3
integer x = 14
integer y = 12
integer width = 3543
integer height = 764
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Promo$$HEX2$$e700f500$$ENDHEX$$es"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_3
integer x = 37
integer y = 168
integer width = 3502
integer height = 596
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_promocao"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_preretrieve;call super::ue_preretrieve;
If not cbx_mostra_produtos_planograma.Checked Then
	This.of_AppendWhere("a.id_tipo_promocao <> 'P' ")	
End If	

Return 1
end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If	
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If
		
End Choose
end event

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 41
integer y = 848
integer width = 2798
integer height = 480
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_contrato_convenio"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
		
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If	
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If	
		
End Choose
end event

type dw_5 from dc_uo_dw_base within tabpage_3
integer x = 37
integer y = 1412
integer width = 2802
integer height = 340
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_preco_regionalizado"
boolean vscrollbar = true
end type

event ue_recuperar;// Override
Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If	
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If	
		
End Choose
end event

type cbx_mostra_produtos_planograma from checkbox within tabpage_3
integer x = 3154
integer y = 72
integer width = 82
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean lefttext = true
end type

event clicked;Tab_1.TabPage_3.dw_3.Reset()
Tab_1.TabPage_3.dw_3.Event ue_Retrieve()
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3602
integer height = 1948
long backcolor = 80269524
string text = "EAN / Comiss$$HEX1$$e300$$ENDHEX$$o / U.F."
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_9 gb_9
gb_8 gb_8
gb_4 gb_4
gb_3 gb_3
dw_6 dw_6
dw_7 dw_7
dw_8 dw_8
dw_9 dw_9
end type

on tabpage_4.create
this.gb_9=create gb_9
this.gb_8=create gb_8
this.gb_4=create gb_4
this.gb_3=create gb_3
this.dw_6=create dw_6
this.dw_7=create dw_7
this.dw_8=create dw_8
this.dw_9=create dw_9
this.Control[]={this.gb_9,&
this.gb_8,&
this.gb_4,&
this.gb_3,&
this.dw_6,&
this.dw_7,&
this.dw_8,&
this.dw_9}
end on

on tabpage_4.destroy
destroy(this.gb_9)
destroy(this.gb_8)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.dw_8)
destroy(this.dw_9)
end on

type gb_9 from groupbox within tabpage_4
integer x = 1454
integer y = 8
integer width = 2098
integer height = 856
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Tipos de Comiss$$HEX1$$e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_8 from groupbox within tabpage_4
integer x = 1454
integer y = 876
integer width = 2098
integer height = 904
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Cadastro para U.F. Selecionada"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_4
integer x = 14
integer y = 876
integer width = 1413
integer height = 904
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "U.F.~'s com Filiais Ativas"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within tabpage_4
integer x = 14
integer y = 8
integer width = 1413
integer height = 856
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de EAN"
borderstyle borderstyle = styleraised!
end type

type dw_6 from dc_uo_dw_base within tabpage_4
integer x = 32
integer y = 60
integer width = 1381
integer height = 780
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_codigo_barras"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_addrow;call super::ue_addrow;DateTime lvdh_ServerDate

If AncestorReturnValue > 0 Then
	lvdh_ServerDate = gf_GetServerDate()
	
	This.Object.Dh_Atualizacao          [AncestorReturnValue] = lvdh_ServerDate
	This.Object.Nr_Matricula_Atualizacao[AncestorReturnValue] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	This.Object.Nm_Usuario              [AncestorReturnValue] = gvo_Aplicacao.ivo_Seguranca.Nm_Usuario
	
	ivo_Controle_Menu.of_Excluir(True)
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then
		ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Produto, &
     lvl_Linha

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Produto[lvl_Linha]) Then
		This.Object.Cd_Produto[lvl_Linha] = lvl_Produto
	End If
Next

Return 1
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event itemchanged;call super::itemchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

This.Object.Nr_Matricula_Atualizacao[Row] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event ue_reset;call super::ue_reset;ivo_Controle_Menu.of_Excluir(False)
end event

event ue_postretrieve;If pl_Linhas > 0 Then
	ivo_Controle_Menu.of_Excluir(True)
Else
	ivo_Controle_Menu.of_Excluir(False)
End If

Return pl_Linhas
end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If	
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If	
		
End Choose
end event

type dw_7 from dc_uo_dw_base within tabpage_4
event ue_atualiza_detalhe ( long al_linha )
integer x = 32
integer y = 944
integer width = 1381
integer height = 808
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_lista_uf_produto"
boolean vscrollbar = true
end type

event ue_atualiza_detalhe;dw_8.of_Populate_DDDW("cd_tributacao_icms")
dw_8.of_Populate_DDDW("cd_tributacao_produto")
dw_8.of_Populate_DDDW("cd_tipo_icms")

dw_8.ScrollToRow(al_Linha)
dw_8.SetRow(al_Linha)
end event

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event ue_postretrieve;Long lvl_Linha

If pl_Linhas > 0 Then
	// Atualiza os indicadores de ICMS e margem espec$$HEX1$$ed00$$ENDHEX$$fica do produto
	For lvl_Linha = 1 To pl_Linhas
		If Not IsNull(This.Object.Pc_ICMS_Compra_Preco[lvl_Linha]) Then
			This.Object.Id_ICMS_Compra[lvl_Linha] = "S"
		End If
		
		If Not IsNull(This.Object.Pc_ICMS_Venda_Preco[lvl_Linha]) Then
			This.Object.Id_ICMS_Venda[lvl_Linha] = "S"
		End If
	
		If Not IsNull(This.Object.Pc_Margem_Resultado_Preco[lvl_Linha]) Then
			This.Object.Id_Margem_Resultado[lvl_Linha] = "S"
		End If
	Next
	
	This.Event RowFocusChanged(1)
End If

Return pl_Linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection()

This.ShareData(dw_8)
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	This.Post Event ue_Atualiza_Detalhe(CurrentRow)
End If
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Produto, &
     lvl_Linha

DateTime lvdh_ServerDate

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

lvdh_ServerDate = gf_GetServerDate()

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Produto[lvl_Linha]) Then
		This.Object.Cd_Produto[lvl_Linha] = lvl_Produto
	End If
	
	If This.Object.Vl_Preco_Reposicao[lvl_Linha] <> This.Object.Vl_Preco_Reposicao_Anterior[lvl_Linha] Then
		This.Object.Dh_Preco_Reposicao          [lvl_Linha] = lvdh_ServerDate
		This.Object.Nr_Matricula_Preco_Reposicao[lvl_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	End If
Next

Return 1
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If		
		
End Choose
end event

type dw_8 from dc_uo_dw_base within tabpage_4
integer x = 1477
integer y = 948
integer width = 2066
integer height = 816
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_uf_produto"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event ue_populate_dddw;String lvs_UF

lvs_UF = dw_7.Object.Cd_Unidade_Federacao[dw_7.GetRow()]

SetPointer(HourGlass!)

pdwc_dddw.SetTransObject(SqlCa)

If ps_Coluna = "cd_tipo_icms" Then
	pdwc_dddw.Retrieve(lvs_UF)
Else
	pdwc_dddw.Retrieve()
End If

SetPointer(Arrow!)
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event itemchanged;call super::itemchanged;Decimal lvdc_Nulo

SetNull(lvdc_Nulo)

Choose Case dwo.Name
	Case "id_icms_compra"
		If Data = "N" Then
			This.Object.Pc_ICMS_Compra_Preco[Row] = lvdc_Nulo
		Else
			This.Object.Pc_ICMS_Compra_Preco[Row] = 0
		End If
		
	Case "id_icms_venda"
		If Data = "N" Then
			This.Object.Pc_ICMS_Venda_Preco[Row] = lvdc_Nulo
		Else
			This.Object.Pc_ICMS_Venda_Preco[Row] = 0
		End If
		
	Case "id_margem_resultado"
		If Data = "N" Then
			This.Object.Pc_Margem_Resultado_Preco[Row] = lvdc_Nulo
		Else
			This.Object.Pc_Margem_Resultado_Preco[Row] = 0
		End If		
End Choose

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event rowfocuschanged;call super::rowfocuschanged;dw_7.ScrollToRow(CurrentRow)
dw_7.SetRow(CurrentRow)
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If	
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If	
		
End Choose
end event

type dw_9 from dc_uo_dw_base within tabpage_4
integer x = 1477
integer y = 60
integer width = 2062
integer height = 788
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge268_detalhe_comissao"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event itemchanged;call super::itemchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
end event

event ue_recuperar;// Override

Long lvl_Produto

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Produto, &
     lvl_Linha

lvl_Produto = Tab_1.TabPage_1.dw_1.Object.Cd_Produto_Central[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Produto[lvl_Linha]) Then
		This.Object.Cd_Produto[lvl_Linha] = lvl_Produto
	End If
Next

Return 1
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then
		ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivo_Controle_Menu.of_Excluir(True)
End If

Return AncestorReturnValue
end event

event ue_postretrieve;If pl_Linhas > 0 Then
	ivo_Controle_Menu.of_Excluir(True)
Else
	ivo_Controle_Menu.of_Excluir(False)
End If

Return pl_Linhas
end event

event ue_reset;call super::ue_reset;ivo_Controle_Menu.of_Excluir(False)
end event

event ue_key;call super::ue_key;Choose Case Key
		
	Case KeyF2!
		
		If Not IsNull(ivo_Produto.Cd_Produto) and ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o.")
		End If
		
	Case KeyF3!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Preco_Venda, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de pre$$HEX1$$e700$$ENDHEX$$o de venda.")
		End If
		
	Case KeyF4!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			OpenWithParm(w_ge120_Historico_Desconto, String(ivo_Produto.Cd_Produto))
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de descontos.")
		End If
		
	Case KeyF5!
		
		If Not IsNull(ivo_Produto.Cd_Produto) And ivo_Produto.Cd_Produto > 0 Then
			If wf_Verifica_Pbm() Then
				If il_Pbm > 0 Then
					OpenWithParm(w_ge113_consulta_pbm_produto, ivo_Produto.Cd_Produto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o possui cadastro no PBM.")
				End If
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o PBM.")
		End If
		
	Case KeyF6!
						
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
			Return
		End If
			
		If Not IsNull(ivo_Produto.Cd_Produto) Then
			
			OpenWithParm(w_ge120_busca_facil_lista_tecnica, ivo_Produto.Cd_Produto)
			
		End If	
		
	Case KeyF7!
		If IsNull(ivo_Produto.Cd_Produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para consultar altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o.")
			Return
		End If
			
		If Not IsNull(ivo_Produto) Then
			OpenWithParm(w_ge340_historico_promocao_response, ivo_Produto)
		End If	
		
End Choose
end event

type st_8 from statictext within w_ge268_consulta_produto
integer x = 23
integer y = 2092
integer width = 3602
integer height = 116
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Hist. de Pre$$HEX1$$e700$$ENDHEX$$o de Repos. [F2] | Hist. de Pre$$HEX1$$e700$$ENDHEX$$o de Venda [F3] | Hist. de Desconto [F4] | PBM [F5] | Busca F$$HEX1$$e100$$ENDHEX$$cil [F6] | Hist. Promo$$HEX2$$e700e300$$ENDHEX$$o [F7]"
alignment alignment = center!
boolean focusrectangle = false
end type

