HA$PBExportHeader$w_ge362_cadastro_desc_produtos_novos.srw
forward
global type w_ge362_cadastro_desc_produtos_novos from dc_w_selecao_lista_relatorio
end type
type cb_incluir from picturebutton within w_ge362_cadastro_desc_produtos_novos
end type
type cb_alterar from picturebutton within w_ge362_cadastro_desc_produtos_novos
end type
type cb_excluir from picturebutton within w_ge362_cadastro_desc_produtos_novos
end type
end forward

global type w_ge362_cadastro_desc_produtos_novos from dc_w_selecao_lista_relatorio
integer width = 3168
integer height = 1712
string title = "GE362 - Cadastro de Promo$$HEX2$$e700e300$$ENDHEX$$o com Desconto para Produtos Novos"
cb_incluir cb_incluir
cb_alterar cb_alterar
cb_excluir cb_excluir
end type
global w_ge362_cadastro_desc_produtos_novos w_ge362_cadastro_desc_produtos_novos

type variables
uo_promocao io_Promocao //ge065
String lvs_Cd_promocao_sap 
end variables

forward prototypes
public subroutine wf_insere_lei_generico_padrao ()
end prototypes

public subroutine wf_insere_lei_generico_padrao ();DataWindowChild ldwc_Child

ldwc_Child = dw_1.of_InsertRow_DDDW("id_lei_generico")

ldwc_Child.SetItem(1, "id_lei_generico", "")
ldwc_Child.SetItem(1, "de_lei_generico", "TODOS")

dw_1.Object.Id_Lei_Generico[1] = ""
end subroutine

on w_ge362_cadastro_desc_produtos_novos.create
int iCurrent
call super::create
this.cb_incluir=create cb_incluir
this.cb_alterar=create cb_alterar
this.cb_excluir=create cb_excluir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_incluir
this.Control[iCurrent+2]=this.cb_alterar
this.Control[iCurrent+3]=this.cb_excluir
end on

on w_ge362_cadastro_desc_produtos_novos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_incluir)
destroy(this.cb_alterar)
destroy(this.cb_excluir)
end on

event ue_preopen;call super::ue_preopen;io_Promocao = Create uo_promocao
end event

event close;call super::close;Destroy(io_Promocao)
end event

event ue_postopen;call super::ue_postopen;io_Promocao.ivs_Tipo = "N"

wf_Insere_Lei_Generico_Padrao()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge362_cadastro_desc_produtos_novos
integer x = 37
integer y = 916
integer width = 1179
integer height = 140
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge362_cadastro_desc_produtos_novos
integer x = 0
integer y = 844
integer width = 1234
integer height = 228
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge362_cadastro_desc_produtos_novos
integer y = 312
integer width = 3049
integer height = 1176
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge362_cadastro_desc_produtos_novos
integer width = 1888
integer height = 276
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge362_cadastro_desc_produtos_novos
integer width = 1819
integer height = 160
string dataobject = "dw_ge362_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_promocao_sos" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Promocao.Nm_Promocao Then
			Return 1
		End If
	Else
		io_Promocao.of_Inicializa()
		
		// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
		If gf_promocao_sap ( io_Promocao.Cd_Promocao   ,  lvs_Cd_promocao_sap ) Then 
	 	    If Long(lvs_Cd_promocao_sap) > 0  Then 					
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(io_Promocao.Cd_Promocao) + "' foi cadastrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
				Return
			End If 
		End If 		
		
		This.Object.Cd_Promocao_Sos	[1]	= io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos[1]	= io_Promocao.Nm_Promocao
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_promocao_sos" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Promocao.Nm_Promocao Then
			Return 1
		End If
	Else
		io_Promocao.of_Inicializa()
		
		// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
		If gf_promocao_sap ( io_Promocao.Cd_Promocao   , lvs_Cd_promocao_sap ) Then 
	 	    If Long(lvs_Cd_promocao_sap) > 0  Then 					
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(io_Promocao.Cd_Promocao) + "' foi cadastrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
				Return
			End If 
		End If 
		
		This.Object.Cd_Promocao_Sos	[1]	= io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos[1]	= io_Promocao.Nm_Promocao
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_promocao_sos" Then
		
		io_Promocao.of_Localiza(This.GetText())
			
		If Not io_Promocao.Localizado Then
			io_Promocao.of_Inicializa()
		End If
						
		// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
		If gf_promocao_sap ( io_Promocao.Cd_Promocao   , lvs_Cd_promocao_sap ) Then 
	 	    If 	Long(lvs_Cd_promocao_sap) > 0  Then 					
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(io_Promocao.Cd_Promocao) + "' foi cadastrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
				Return
			End If 
		End If 
		
		This.Object.Cd_Promocao_Sos	[1] = io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos[1] = io_Promocao.Nm_Promocao
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge362_cadastro_desc_produtos_novos
integer y = 388
integer width = 2981
integer height = 1080
string dataobject = "dw_ge362_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Promocao

String ls_Lei_Generico

dw_1.AcceptText()

ll_Promocao		= dw_1.Object.Cd_Promocao_Sos	[1]
ls_Lei_Generico	= dw_1.Object.Id_Lei_Generico	[1]

If Not IsNull(ll_Promocao) And ll_Promocao > 0 Then
	This.of_AppendWhere("p.cd_promocao_sos = " + String(ll_Promocao))
End If

If ls_Lei_Generico <> "" Then
	This.of_AppendWhere("p.id_lei_generico = '" + ls_Lei_Generico + "'")
End If

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge362_cadastro_desc_produtos_novos
integer x = 809
integer y = 792
end type

type cb_incluir from picturebutton within w_ge362_cadastro_desc_produtos_novos
integer x = 1938
integer y = 188
integer width = 375
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_incluir.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_Parametro

st_parametros_promocao str

str.Id_Tipo = "I"

OpenWithParm(w_ge362_cadastra_desconto, str)

ls_Parametro = Message.StringParm

If Not IsNull(ls_Parametro) And ls_Parametro = "OK" Then
	dw_2.Event ue_Retrieve()
End If
end event

type cb_alterar from picturebutton within w_ge362_cadastro_desc_produtos_novos
integer x = 2341
integer y = 188
integer width = 347
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_alterar.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_Parametro

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma promo$$HEX2$$e700e300$$ENDHEX$$o foi localizada para ser alterada.")
	Return -1
End If

st_parametros_promocao str

dw_2.AcceptText()

str.Cd_Promocao_Sos	= dw_2.Object.Cd_Promocao_Sos		[dw_2.GetRow()]
str.Nm_Promocao_Sos	= dw_2.Object.Nm_Promocao_Sos	[dw_2.GetRow()]
str.Cd_Grupo				= dw_2.Object.Cd_Grupo				[dw_2.GetRow()]
str.De_Grupo				= dw_2.Object.De_Grupo				[dw_2.GetRow()]
str.Id_Lei_Generico		= dw_2.Object.Id_Lei_Generico		[dw_2.GetRow()]
str.Pc_Desconto			= dw_2.Object.Pc_Desconto				[dw_2.GetRow()]
str.Id_Tipo					= "A"

OpenWithParm(w_ge362_cadastra_desconto, str)

ls_Parametro = Message.StringParm

If Not IsNull(ls_Parametro) And ls_Parametro = "OK" Then
	dw_2.Event ue_Retrieve()
End If
end event

type cb_excluir from picturebutton within w_ge362_cadastro_desc_produtos_novos
integer x = 2711
integer y = 188
integer width = 375
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_excluir.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_Parametro

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma promo$$HEX2$$e700e300$$ENDHEX$$o foi localizada para ser exclu$$HEX1$$ed00$$ENDHEX$$da.")
	Return -1
End If

st_parametros_promocao str

dw_2.AcceptText()

str.Cd_Promocao_Sos	= dw_2.Object.Cd_Promocao_Sos		[dw_2.GetRow()]
str.Nm_Promocao_Sos	= dw_2.Object.Nm_Promocao_Sos	[dw_2.GetRow()]
str.Cd_Grupo				= dw_2.Object.Cd_Grupo				[dw_2.GetRow()]
str.De_Grupo				= dw_2.Object.De_Grupo				[dw_2.GetRow()]
str.Id_Lei_Generico		= dw_2.Object.Id_Lei_Generico		[dw_2.GetRow()]
str.Pc_Desconto			= dw_2.Object.Pc_Desconto				[dw_2.GetRow()]
str.Id_Tipo					= "E"

OpenWithParm(w_ge362_cadastra_desconto, str)

ls_Parametro = Message.StringParm

If Not IsNull(ls_Parametro) And ls_Parametro = "OK" Then
	dw_2.Event ue_Retrieve()
End If
end event

