HA$PBExportHeader$w_ge646_cad_perm_endereco.srw
forward
global type w_ge646_cad_perm_endereco from dc_w_cadastro_selecao_lista
end type
type cb_cadastro from commandbutton within w_ge646_cad_perm_endereco
end type
end forward

global type w_ge646_cad_perm_endereco from dc_w_cadastro_selecao_lista
integer width = 3474
integer height = 1588
string title = "GE646 - Cadastro de Restri$$HEX2$$e700e300$$ENDHEX$$o por Endere$$HEX1$$e700$$ENDHEX$$o"
cb_cadastro cb_cadastro
end type
global w_ge646_cad_perm_endereco w_ge646_cad_perm_endereco

type variables
uo_produto ivo_produto
end variables

forward prototypes
public subroutine wf_filtra_bairro ()
end prototypes

public subroutine wf_filtra_bairro ();DataWindowChild	ldwc_bairro

If dw_1.GetChild ('nm_bairro', ldwc_bairro) = 1 then
	ldwc_bairro.SetFilter ("cd_bairro = 'T' OR cd_filial = " + String (gl_cd_filial))
	ldwc_bairro.Filter    ()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da lista de bairros.")
End if

Return
end subroutine

on w_ge646_cad_perm_endereco.create
int iCurrent
call super::create
this.cb_cadastro=create cb_cadastro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cadastro
end on

on w_ge646_cad_perm_endereco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_cadastro)
end on

event open;call super::open;ivo_Produto 		= Create uo_Produto



end event

event close;call super::close;Destroy(ivo_Produto)
end event

event ue_postopen;call super::ue_postopen;wf_filtra_bairro ()
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge646_cad_perm_endereco
integer x = 174
integer y = 1060
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge646_cad_perm_endereco
boolean visible = true
integer x = 137
integer y = 988
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge646_cad_perm_endereco
integer x = 50
integer y = 108
integer width = 2395
integer height = 328
string dataobject = "dw_ge646_selecao_endereco"
boolean maxbox = true
end type

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
	
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
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
	
End Choose
end event

event dw_1::ue_key;call super::ue_key;dw_1.AcceptText()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
			
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If	
			
	End Choose
End If

If Key = KeyEscape! Then
	Close(Parent)
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge646_cad_perm_endereco
integer y = 464
integer width = 3397
integer height = 932
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge646_cad_perm_endereco
integer y = 24
integer width = 3397
integer height = 432
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge646_cad_perm_endereco
integer x = 55
integer y = 524
integer width = 3351
integer height = 828
string dataobject = "dw_ge646_cadastro_endereco"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long		ll_Cd_Produto

String	ls_Id_Apresentacao
String	ls_Bairro
String	ls_Rua
String	ls_Busca_Produto

dw_1.AcceptText()

ll_Cd_Produto				= dw_1.Object.cd_produto			[1]
ls_Id_Apresentacao		= dw_1.Object.de_apresentacao		[1]
ls_Bairro					= dw_1.Object.nm_bairro				[1]
ls_Rua						= dw_1.Object.de_rua					[1]
ls_Busca_Produto			= dw_1.Object.id_busca_produto	[1]

If ls_Busca_Produto = 'S' then
	
	dw_2.DataObject = "dw_ge646_cadastro_end_prod"
	dw_2.SetTransObject(SQLCA)
	
	//Produto
	If Not IsNull(ll_Cd_Produto) Then
		This.of_AppendWhere_SubQuery("pg.cd_produto = " + String(ll_Cd_Produto), 1)
	End if
	
End if	

If ls_Busca_Produto = 'N' then
	dw_2.DataObject = "dw_ge646_cadastro_endereco"
	dw_2.SetTransObject(SQLCA)
End if	
	
//Apresenta$$HEX2$$e700e300$$ENDHEX$$o
If Not ls_Id_Apresentacao = 'T' Then
	This.of_AppendWhere_SubQuery("wl.id_apresentacao = '" + ls_Id_Apresentacao + "'", 1)
End If

//Bairro
If Not ls_Bairro = 'T' Then
	This.of_AppendWhere_SubQuery("wl.cd_bairro = '" + ls_Bairro + "'", 1)
End If

//Rua
If Not ls_Rua = 'T' Then
	This.of_AppendWhere_SubQuery("wl.cd_rua = '" + ls_Rua + "'", 1)
End If	

//CD
This.of_AppendWhere_SubQuery ('wb.cd_filial = ' + String (gl_cd_filial), 1)

Return 1
end event

type cb_cadastro from commandbutton within w_ge646_cad_perm_endereco
integer x = 1723
integer y = 256
integer width = 645
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cadastrar Restri$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;//open data window de cadastro

String ls_Retorno

OpenWithParm(w_ge646_inclui_nova_restricao, "")

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_2.Retrieve()
End If
end event

