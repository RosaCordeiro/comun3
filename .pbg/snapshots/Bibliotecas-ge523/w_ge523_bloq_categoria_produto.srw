HA$PBExportHeader$w_ge523_bloq_categoria_produto.srw
forward
global type w_ge523_bloq_categoria_produto from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge523_bloq_categoria_produto from dc_w_cadastro_selecao_lista
integer width = 2839
integer height = 2220
string title = "GE523 - Cadastro de Bloqueio de Categoria Produto"
end type
global w_ge523_bloq_categoria_produto w_ge523_bloq_categoria_produto

type variables
uo_filial io_Filial
uo_ge216_filiais io_Selecao_Filiais

Boolean ib_Alterando = False

Long il_Linha_Atual

String is_Filiais
String is_Nulo
end variables

forward prototypes
public subroutine wf_atualiza_id_bloqueio ()
end prototypes

public subroutine wf_atualiza_id_bloqueio ();Long ll_Linha
Long ll_Linhas

ll_Linhas = dw_2.RowCount()

//Carrega os campos de bloqueio de exame e vacina da dw_2 com a informa$$HEX2$$e700e300$$ENDHEX$$o SIM OU N$$HEX1$$c300$$ENDHEX$$O
For ll_Linha = 1 To ll_Linhas
	dw_2.Object.Id_Bloq_Exame	[ll_Linha] = dw_2.Object.Pos_Exame		[ll_Linha]
	dw_2.Object.Id_Bloq_Vacina	[ll_Linha] = dw_2.Object.Pos_Vacina		[ll_Linha]
	dw_2.Object.Id_Bloq_Clinicarx	[ll_Linha] = dw_2.Object.Pos_Clinicarx	[ll_Linha]
	dw_2.Object.Id_Bloq_Anticorpo	[ll_Linha] = dw_2.Object.Pos_Anticorpo	[ll_Linha]
	
	dw_2.Object.Id_Bloq_Exame_Old	[ll_Linha]		= dw_2.Object.Pos_Exame		[ll_Linha]
	dw_2.Object.Id_Bloq_Vacina_Old	[ll_Linha]		= dw_2.Object.Pos_Vacina		[ll_Linha]
	dw_2.Object.Id_Bloq_Clinicarx_Old[ll_Linha]	= dw_2.Object.Pos_Clinicarx	[ll_Linha]
	dw_2.Object.Id_Bloq_Anticorpo_Old[ll_Linha]	= dw_2.Object.Pos_Anticorpo	[ll_Linha]
Next
end subroutine

on w_ge523_bloq_categoria_produto.create
call super::create
end on

on w_ge523_bloq_categoria_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(io_Filial)
Destroy(io_Selecao_Filiais)
end event

event ue_preopen;call super::ue_preopen;io_Filial = Create uo_filial
io_Selecao_Filiais = Create uo_ge216_filiais
end event

event ue_postopen;//OverRide

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_AddRow()

This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Recuperar(True)

//Est$$HEX1$$e100$$ENDHEX$$ habilitado o Aux$$HEX1$$ed00$$ENDHEX$$lio Visual no INI ?
If gvo_aplicacao.ivb_usa_aux_visual Then 
	//Adiciona Linha DW
	If dw_visual.RowCount() = 0 Then dw_visual.Event ue_AddRow()
	//Seta os valores de redimensionamento da tela para compatibilidade com telas redimensionam
	MaxWidth = This.Width
	MaxHeight = This.Height
	//Chama o redimensionamento da tela, onde est$$HEX1$$e100$$ENDHEX$$ tratado onde deve aparecer a DW
	This.Event Resize(0,MaxWidth - 72, MaxHeight)
	//Seta DW visivel
	gb_aux_visual.Visible = True
	dw_visual.Visible = True
	
	Yield()
End If

dw_1.SetFocus()
end event

event ue_cancel;call super::ue_cancel;dw_1.Enabled = True
ib_Alterando = False
end event

event ue_save;call super::ue_save;Boolean lb_Alteracao = False

Long ll_Linha
Long ll_Filial

String ls_Parametro
String ls_Erro
String ls_Id_Exame
String ls_Id_Exame_Old
String ls_Id_Vacina
String ls_Id_Vacina_Old
String ls_Id_Clinicarx
String ls_Id_Clinicarx_Old
String ls_Id_Anticorpo
String ls_Id_Anticorpo_Old

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	
	ls_Id_Exame 	= dw_2.Object.Id_Bloq_Exame		[ll_Linha]
	ls_Id_Vacina	= dw_2.Object.Id_Bloq_Vacina		[ll_Linha]
	ls_Id_Clinicarx	= dw_2.Object.Id_Bloq_Clinicarx	[ll_Linha]
	ls_Id_Anticorpo	= dw_2.Object.Id_Bloq_Anticorpo	[ll_Linha]
	
	ls_Id_Exame_Old 		= dw_2.Object.Id_Bloq_Exame_Old		[ll_Linha]
	ls_Id_Vacina_Old 		= dw_2.Object.Id_Bloq_Vacina_Old		[ll_Linha]
	ls_Id_Clinicarx_Old	= dw_2.Object.Id_Bloq_Clinicarx_Old		[ll_Linha]	
	ls_Id_Anticorpo_Old	= dw_2.Object.Id_Bloq_Anticorpo_Old	[ll_Linha]
	
	//Se teve altera$$HEX2$$e700e300$$ENDHEX$$o
	If	ls_Id_Exame 		<>	ls_Id_Exame_Old		Or &
	  	ls_Id_Vacina 		<>	ls_Id_Vacina_Old		Or	& 
	  	ls_Id_Clinicarx 		<>	ls_Id_Clinicarx_Old 	Or &
	  	ls_Id_Anticorpo		<>	ls_Id_Anticorpo_Old	Then		   	
		
		ll_Filial = dw_2.Object.Cd_Filial[ll_Linha]
		ls_Parametro = ""
				
		//Categorias bloqueadas atualmente
		//102153,206027,206033,206040
		If ls_Id_Vacina = "S" Then
			ls_Parametro = "102153"
		End If
				
		If ls_Id_Exame = "S" Then
			If ls_Parametro = "" Then
				ls_Parametro = "206027,206033"
			Else
				ls_Parametro += ",206027,206033"
			End If
		End If
		
		If ls_Id_Clinicarx = "S" Then
			If ls_Parametro = "" Then
				ls_Parametro = "206040"
			Else
				ls_Parametro += ",206040"
			End If
		End If
		
		// Exame Anticorpo
		If ls_Id_Anticorpo = "S" Then
			If ls_Parametro = "" Then
				ls_Parametro = "206041"
			Else
				ls_Parametro += ",206041"
			End If
		End If
		
		Update parametro_loja
			Set vl_parametro = :ls_Parametro
		Where cd_parametro = 'CD_CATEGORIA_PRD_MOVIMENTACAO_BLOQUEADA'
			And cd_filial = :ll_Filial
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o valor do parametro loja 'CD_CATEGORIA_PRD_MOVIMENTACAO_BLOQUEADA' da filial [" + String(ll_Filial) + "].~r" + ls_Erro, StopSign!)
			Return -1
		End If
		
		lb_Alteracao = True
		
		il_Linha_Atual = ll_Linha
	End If
Next

If lb_Alteracao Then
	SqlCa.of_Commit();
	
	dw_1.Enabled = True
	ib_Alterando = False
	
	This.ivm_Menu.mf_Confirmar(False)
	This.ivm_Menu.mf_Cancelar(False)
	
	dw_2.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge523_bloq_categoria_produto
integer x = 37
integer y = 1240
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge523_bloq_categoria_produto
integer x = 0
integer y = 1168
integer width = 2135
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge523_bloq_categoria_produto
integer x = 59
integer width = 2597
integer height = 312
string dataobject = "dw_ge523_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

Choose Case This.GetColumnName()
		
	Case "nm_fantasia" 
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			dw_1.Object.cd_filial  		[1] = io_Filial.cd_filial
			dw_1.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
		End If
	
	Case "id_conjunto_filial"
		
		is_filiais = is_nulo
		
		If Data = 'C' Then
							
			OpenWithParm(w_ge216_selecao_filiais, io_Selecao_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				
				io_Filial.of_Inicializa()
			
				dw_1.Object.cd_filial  		[1] = io_Filial.cd_filial
				dw_1.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
					
				is_filiais = io_Selecao_Filiais.ivs_filiais
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")					
			End If

		End If
End Choose

dw_2.Event ue_Reset()
end event

event dw_1::ue_key;call super::ue_key;dw_1.AcceptText()

If dw_1.GetColumnName() = "nm_fantasia" Then
	If Key = KeyEnter! Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If io_Filial.Localizada Then
					
			This.Object.cd_filial  		[1] = io_Filial.cd_filial
			This.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
			
			This.Object.id_conjunto_filial[1] = "T"			
		End If
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge523_bloq_categoria_produto
integer y = 416
integer height = 1600
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge523_bloq_categoria_produto
integer width = 2743
integer height = 404
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge523_bloq_categoria_produto
integer x = 59
integer y = 472
integer width = 2656
integer height = 1504
string dataobject = "dw_ge523_lista"
end type

event dw_2::ue_postretrieve;//OverRide

Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Excluir

If pl_Linhas > 0 Then
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar		= IsValid(This.ivo_Filter)
	lvb_Localizar	= IsValid(This.ivo_Find)
	
	//Tela n$$HEX1$$e300$$ENDHEX$$o permite exclus$$HEX1$$e300$$ENDHEX$$o do parametro_loja
	lvb_Excluir = False

	This.ivo_Controle_Menu.of_SalvarComo(True)		
	wf_Atualiza_Id_Bloqueio()

//	This.SetRow(1)

	This.SetRow(il_Linha_Atual)
	This.ScrollToRow(il_Linha_Atual)
	
	il_Linha_Atual = 1
	
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		This.ivo_Controle_Menu.of_SalvarComo(False)
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Excluir(lvb_Excluir)
Parent.ivm_Menu.mf_Incluir(lvb_Excluir)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText()

If Not IsNull(dw_1.Object.Cd_Filial[1]) And dw_1.Object.Cd_Filial[1] > 0 Then
	This.of_AppendWhere("f.cd_filial = " + String(dw_1.Object.Cd_Filial[1]))
End If

If Not IsNull(is_Filiais) And is_Filiais <> "" Then
	This.of_AppendWhere("f.cd_filial in (" + is_Filiais + ")")
End If

Return 1
end event

event dw_2::getfocus;//OverRide

This.Post Event ue_SelectText()

This.of_Marca_Coluna_Ativa(This.GetColumnName())

Parent.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Incluir(False)

Return 0
end event

event dw_2::itemchanged;call super::itemchanged;If dwo.Name = "id_bloq_exame" Or dwo.Name = "id_bloq_vacina" Or dwo.Name = "id_bloq_clinicarx"  Or dwo.Name = "id_bloq_clinicarx"  Or dwo.Name = "id_bloq_anticorpo" Then
	dw_1.Enabled = False
	ib_Alterando = True
End If
end event

