HA$PBExportHeader$w_ge030_consulta_nf_compra.srw
forward
global type w_ge030_consulta_nf_compra from dc_w_sheet
end type
type tab_1 from tab within w_ge030_consulta_nf_compra
end type
type tabpage_1 from userobject within tab_1
end type
type st_5 from statictext within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type cb_destinada from commandbutton within tabpage_2
end type
type cb_est_nfs from commandbutton within tabpage_2
end type
type cb_copiar from commandbutton within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_destinada cb_destinada
cb_est_nfs cb_est_nfs
cb_copiar cb_copiar
dw_3 dw_3
gb_3 gb_3
end type
type tabpage_3 from userobject within tab_1
end type
type gb_5 from groupbox within tabpage_3
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type dw_5 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_5 gb_5
gb_4 gb_4
dw_4 dw_4
dw_5 dw_5
end type
type tabpage_4 from userobject within tab_1
end type
type cb_alterar_lote from commandbutton within tabpage_4
end type
type gb_6 from groupbox within tabpage_4
end type
type dw_6 from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_1
cb_alterar_lote cb_alterar_lote
gb_6 gb_6
dw_6 dw_6
end type
type tabpage_5 from userobject within tab_1
end type
type gb_7 from groupbox within tabpage_5
end type
type dw_7 from dc_uo_dw_base within tabpage_5
end type
type hsb_row from hscrollbar within tabpage_5
end type
type tabpage_5 from userobject within tab_1
gb_7 gb_7
dw_7 dw_7
hsb_row hsb_row
end type
type tab_1 from tab within w_ge030_consulta_nf_compra
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
end forward

global type w_ge030_consulta_nf_compra from dc_w_sheet
string accessiblename = "Consulta de Notas de Fiscais de Compra (GE030)"
integer width = 3648
integer height = 1936
string title = "GE030 - Consulta de Notas Fiscais de Compra"
long backcolor = 80269524
event ue_retrieve ( )
tab_1 tab_1
end type
global w_ge030_consulta_nf_compra w_ge030_consulta_nf_compra

type variables
uo_filial ivo_filial

uo_fornecedor ivo_fornecedor

uo_Usuario ivo_Usuario

long ivl_filial, &
        ivl_nf, &
		  ivl_nf_dev

string ivs_fornecedor, &
         ivs_especie, &
         ivs_serie,   &
			ivs_nm_fantasia, &
			ivs_nm_razao_social, &
			ivs_nf_pendente
			
Date ivdt_Movimento
end variables

forward prototypes
public function boolean wf_verifica_solic_devol_pend (st_ge030_parametros_alt_lote ast_parametro, ref string as_mensagem)
end prototypes

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

public function boolean wf_verifica_solic_devol_pend (st_ge030_parametros_alt_lote ast_parametro, ref string as_mensagem);//Se houver solicita$$HEX2$$e700e300$$ENDHEX$$o de devolu$$HEX2$$e700e300$$ENDHEX$$o e a nota fiscal de devolu$$HEX2$$e700e300$$ENDHEX$$o ainda n$$HEX1$$e300$$ENDHEX$$o tiver sido integrada,
//n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel alterar o lote, pois dar$$HEX1$$e100$$ENDHEX$$ erro na integra$$HEX2$$e700e300$$ENDHEX$$o.
Long	ll_Cont

SELECT
		COUNT (*)
INTO
		:ll_Cont
FROM
		item_nf_compra inc
INNER JOIN
		nf_compra nc
				ON  nc.cd_filial     = inc.cd_filial
				AND nc.cd_fornecedor = inc.cd_fornecedor
				AND nc.nr_nf         = inc.nr_nf
				AND nc.de_especie    = inc.de_especie
				AND nc.de_serie      = inc.de_serie
INNER JOIN
		wms_int_sap_auxiliar wisa
				ON  wisa.de_chave_acesso_origem = nc.de_chave_acesso
INNER JOIN
		wms_int_sap wis
				ON  wis.nr_integracao = wisa.nr_integracao
INNER JOIN
		wms_int_sap_detalhe wisd
				ON  wisd.nr_integracao = wis.nr_integracao
				AND wisd.cd_produto    = inc.cd_produto
WHERE
		inc.cd_filial     = :ast_parametro.cd_filial
AND	inc.cd_fornecedor = :ast_parametro.cd_fornecedor
AND	inc.nr_nf         = :ast_parametro.nr_nf
AND	inc.de_especie    = :ast_parametro.de_especie
AND	inc.de_serie      = :ast_parametro.de_serie
AND	inc.cd_produto    = :ast_parametro.cd_produto
AND	wis.nr_nf         IS NOT NULL
USING SQLCA;

If SQLCA.SQLCode < 0 then
	as_mensagem = 'Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ solicita$$HEX2$$e700e300$$ENDHEX$$o de devolu$$HEX2$$e700e300$$ENDHEX$$o pendente para o produto: ' + SQLCA.SQLErrText
	Return False
End if

If ll_Cont > 0 then
	as_mensagem = 'Existe solicita$$HEX2$$e700e300$$ENDHEX$$o de devolu$$HEX2$$e700e300$$ENDHEX$$o pendente para o produto.~n~n~rN$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel alterar o lote!'
	Return False
End if

Return True
end function

on w_ge030_consulta_nf_compra.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge030_consulta_nf_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Parametro

Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_5.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_6.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_3.dw_5.Event ue_AddRow()

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio 	[1] = lvdt_Parametro
Tab_1.TabPage_1.dw_1.Object.Dt_Termino	[1] = lvdt_Parametro

Tab_1.TabPage_1.dw_1.SetFocus()

ivm_Menu.mf_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_3.dw_4.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_4.dw_6.ivo_Controle_Menu.of_SalvarComo(True)

gf_ge003_lista_divisao_fornecedor(Tab_1.TabPage_1.dw_1, "", 1)
end event

event open;call super::open;ivo_Filial		= Create uo_Filial

ivo_Fornecedor = Create uo_Fornecedor

ivo_Usuario    = Create uo_Usuario


end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Fornecedor)
Destroy(ivo_Usuario)
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge030_consulta_nf_compra
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge030_consulta_nf_compra
end type

type tab_1 from tab within w_ge030_consulta_nf_compra
integer x = 5
integer width = 3607
integer height = 1736
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event selectionchanging;Long lvl_Linha

If OldIndex = 1 Then
	lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()
	
	If lvl_Linha > 0 Then
		ivl_Filial          = Tab_1.TabPage_1.dw_2.Object.Cd_Filial    				  [lvl_Linha]
		ivs_nm_fantasia     = Tab_1.TabPage_1.dw_2.Object.nm_fantasia    				  [lvl_Linha]
		ivs_Fornecedor      = Tab_1.TabPage_1.dw_2.Object.Cd_Fornecedor				  [lvl_Linha]
		ivs_nm_razao_social = Tab_1.TabPage_1.dw_2.Object.nm_razao_social            [lvl_Linha]
		ivl_NF              = Tab_1.TabPage_1.dw_2.Object.Nr_NF       				     [lvl_Linha]
		ivs_Especie         = Tab_1.TabPage_1.dw_2.Object.De_Especie   				  [lvl_Linha]
		ivs_Serie           = Tab_1.TabPage_1.dw_2.Object.De_Serie     				  [lvl_Linha]
		ivdt_Movimento      = Date(Tab_1.TabPage_1.dw_2.Object.dh_movimentacao_caixa [lvl_Linha])
		ivl_nf_dev          = Tab_1.TabPage_1.dw_2.Object.nr_nf_dev                  [lvl_Linha]
		ivs_nf_pendente     = Tab_1.TabPage_1.dw_2.Object.id_pendente                [lvl_Linha]
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma nota fiscal da lista.")
		Tab_1.TabPage_1.dw_2.SetFocus()
		Return 1
	End If
End If

Choose Case NewIndex
	Case 2
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		
	Case 3
		Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
		
	Case 4
		//O bot$$HEX1$$e300$$ENDHEX$$o para altera$$HEX2$$e700e300$$ENDHEX$$o de lote s$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ vis$$HEX1$$ed00$$ENDHEX$$vel quando:
		//	- a tela $$HEX1$$e900$$ENDHEX$$ executada no WMS
		// - a nota $$HEX1$$e900$$ENDHEX$$ do CD (filial 534)
		//Este bot$$HEX1$$e300$$ENDHEX$$o, quando vis$$HEX1$$ed00$$ENDHEX$$vel, s$$HEX1$$f300$$ENDHEX$$ fica habilitado se:
		// - n$$HEX1$$e300$$ENDHEX$$o houver NF de devolu$$HEX2$$e700e300$$ENDHEX$$o e
		// - a NF estiver confirmada (n$$HEX1$$e300$$ENDHEX$$o mais pendente)
		
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'WS' and &
			ivl_Filial                             = 534  then
			
			tab_1.tabpage_4.cb_alterar_lote.Visible = True
			
			If ivs_nf_pendente = 'S' then
				tab_1.tabpage_4.cb_alterar_lote.Enabled = False
			else
				tab_1.tabpage_4.cb_alterar_lote.Enabled = True
			End if
		else
			tab_1.tabpage_4.cb_alterar_lote.Visible = False
		End if
		
		Tab_1.TabPage_4.dw_6.Event ue_Retrieve()
		
	Case 5
		Tab_1.TabPage_5.dw_7.Event ue_Retrieve()
End Choose
end event

event selectionchanged;Choose Case NewIndex
	Case 1 
		Tab_1.TabPage_1.dw_2.SetFocus()
		
	Case 2
		Tab_1.TabPage_2.dw_3.SetFocus()
		
	Case 3
		Tab_1.TabPage_3.dw_4.SetFocus()
		
	Case 4
		Tab_1.TabPage_4.dw_6.SetFocus()
		
	Case 5
		Tab_1.TabPage_5.dw_7.SetFocus()
End Choose
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3570
integer height = 1620
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type

on tabpage_1.create
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on tabpage_1.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

type st_5 from statictext within tabpage_1
integer x = 2583
integer y = 1556
integer width = 750
integer height = 56
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "** A filial registrou recebimento"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_1
integer x = 1627
integer y = 1560
integer width = 576
integer height = 60
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Nota possui devolu$$HEX2$$e700e300$$ENDHEX$$o"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_1
integer x = 1440
integer y = 1560
integer width = 174
integer height = 60
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 65535
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_1
integer x = 59
integer y = 1556
integer width = 992
integer height = 56
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "A filial ainda n$$HEX1$$e300$$ENDHEX$$o atualizou o saldo da nota"
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_1
integer x = 9
integer y = 1564
integer width = 82
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "*"
boolean focusrectangle = false
end type

type gb_2 from groupbox within tabpage_1
integer x = 5
integer y = 492
integer width = 3547
integer height = 1056
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "Lista de Notas Fiscais"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 9
integer y = 4
integer width = 3543
integer height = 476
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 37
integer y = 60
integer width = 3493
integer height = 404
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge030_selecao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_Fornecedor) Then
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If
end event

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
		gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
		
	Case "nm_conferente"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Usuario.nm_usuario Then
				Return 1
			End If
		Else
			ivo_Usuario.of_Inicializa()
			
			This.Object.nr_matricula	[1] = ivo_Usuario.nr_matricula
			This.Object.nm_conferente	[1] = ivo_Usuario.nm_usuario
		End If
	
End Choose

dw_2.Event ue_Reset()
end event

event ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
				
				If Not gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1) Then
					Return
				End If	
			End If

		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
	
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial 
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If	
			
		Case "nm_conferente"
			ivo_Usuario.of_Localiza_Usuario(This.GetText())
			
			If ivo_Usuario.Localizado Then
				This.Object.nr_matricula	[1] = ivo_Usuario.nr_matricula
				This.Object.nm_conferente	[1] = ivo_Usuario.nm_usuario
			End If
	
	End Choose
End If




	
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()

end event

event getfocus;call super::getfocus;dw_2.ivo_Controle_Menu.of_Atualiza()
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 27
integer y = 548
integer width = 3506
integer height = 988
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge030_lista_nf"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

String	lvs_Fornecedor, &
		lvs_Tipo, &
		lvs_Conferente

String ls_Chave
String ls_Tipo_NF
String ls_ID_Perini
String ls_Devolucao

Long lvl_NF, &
	  lvl_Filial, &
	  lvl_Pedido,&
	  lvl_Divisao_Fornecedor

Date lvdt_Inicio, &
     lvdt_Termino
		
dw_1.AcceptText()

lvdt_Inicio    				= dw_1.Object.Dt_Inicio     					[1]
lvdt_Termino   				= dw_1.Object.Dt_Termino    				[1]
lvl_Filial     					= dw_1.Object.Cd_Filial     					[1]
lvs_Fornecedor 			= dw_1.Object.Cd_Fornecedor				[1]
lvl_NF         					= dw_1.Object.Nr_NF         					[1]
lvl_Pedido     				= dw_1.Object.Nr_Pedido     				[1]
lvs_Tipo       				= dw_1.Object.Id_Tipo_Pedido				[1]
lvs_Conferente 				= dw_1.Object.Nr_Matricula					[1]
ls_Tipo_NF					= dw_1.Object.id_tipo_nf					[1]
ls_Chave						= dw_1.Object.de_chave						[1]
ls_ID_Perini					= dw_1.Object.id_perini_pendente		[1]
lvl_Divisao_Fornecedor	= dw_1.Object.nr_divisao_fornecedor	[1]
ls_Devolucao				= dw_1.Object.Id_Devolucao				[1]

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1	
End If

If Not IsNull(ls_Chave) And Trim(ls_Chave) <> "" Then
	If Not gf_valida_chave_nfe( ls_Chave ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Chave de acesso inv$$HEX1$$e100$$ENDHEX$$lida.")
		dw_1.Event ue_Pos(1, "de_chave")
		Return -1	
	End If
End If

If Not IsNull(lvs_Fornecedor) and lvs_Fornecedor <> "" Then
	This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 1)
	This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'" , 2)
End If

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial), 1)
	This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial), 2)
End If

If Not IsNull(lvl_NF) and lvl_NF > 0 Then
	This.of_AppendWhere("n.nr_nf = " + String(lvl_NF), 1)
	This.of_AppendWhere("n.nr_nf = " + String(lvl_NF), 2)
End If

If Not IsNull(lvl_Pedido) Then
	If lvs_Tipo = "C" Then
		This.of_AppendWhere("n.nr_pedido_central = " + String(lvl_Pedido), 1)
		This.of_AppendWhere("n.nr_pedido = " + String(lvl_Pedido), 2)
	Else
		If IsNull(lvl_Filial) or lvl_Filial = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial para consultar as notas de um pedido.")
			dw_1.Event ue_Pos(1, "nm_filial")
			Return -1
		End If
		
		This.of_AppendWhere("n.nr_pedido_distribuidora = " + String(lvl_Pedido), 1)
		This.of_AppendWhere("n.nr_pedido = " + String(lvl_Pedido), 2)
	End If
End If

If Not IsNull(lvs_Conferente) and lvs_Conferente <> "" Then
	This.of_AppendWhere("n.nr_matricula_conferente = '" + lvs_Conferente + "'", 1)
	This.of_AppendWhere("n.nr_matricula_conferente = '" + lvs_Conferente + "'", 2)
End If

If ls_Tipo_NF = "P" Then
	This.of_AppendWhere("n.de_especie = 'XXXX'", 1)
ElseIf ls_Tipo_NF = "C" Then
	This.of_AppendWhere("n.de_especie = 'XXXX'", 2)
End If

If Not IsNull( ls_Chave ) And Trim(ls_Chave) <> "" Then
	This.of_AppendWhere("n.de_chave_acesso = '" + ls_Chave + "'", 1)
	This.of_AppendWhere("n.de_chave_acesso = '" + ls_Chave + "'", 2)
End If

If ls_ID_Perini = 'N' Then
	This.of_AppendWhere("n.cd_filial <> 534 ", 2)
End If

//Divis$$HEX1$$e300$$ENDHEX$$o Fornecedor
If Not IsNull(lvl_Divisao_Fornecedor) And lvl_Divisao_Fornecedor > 0 Then
	This.Of_appendwhere("	exists (select * from nf_compra a1 "+&
								"	inner join item_nf_compra b1 on b1.cd_filial = a1.cd_filial "+&
								"											and b1.cd_fornecedor = a1.cd_fornecedor "+&
								"											and b1.nr_nf  = a1.nr_nf "+&
								"											and b1.de_especie = a1.de_especie "+&
								"											and b1.de_serie = a1.de_serie "+&
								"	inner join fornecedor_divisao_produto c1 on c1.cd_produto = b1.cd_produto "+&
								"															and c1.cd_fornecedor = b1.cd_fornecedor "+&
								"	where a1.cd_filial = n.cd_filial "+&
								"	and a1.cd_fornecedor = n.cd_fornecedor "+&
								"	and a1.nr_nf  = n.nr_nf "+&
								"	and a1.de_especie = n.de_especie "+&
								"	and a1.de_serie = n.de_serie "+&
								"	and c1.cd_fornecedor = n.cd_fornecedor "+&
								"	and c1.nr_divisao = "+String(lvl_Divisao_Fornecedor)+")", 1)
	This.Of_appendwhere("	exists (select * from nf_compra a1 "+&
								"	inner join item_nf_compra b1 on b1.cd_filial = a1.cd_filial "+&
								"											and b1.cd_fornecedor = a1.cd_fornecedor "+&
								"											and b1.nr_nf  = a1.nr_nf "+&
								"											and b1.de_especie = a1.de_especie "+&
								"											and b1.de_serie = a1.de_serie "+&
								"	inner join fornecedor_divisao_produto c1 on c1.cd_produto = b1.cd_produto "+&
								"															and c1.cd_fornecedor = b1.cd_fornecedor "+&
								"	where a1.cd_filial = n.cd_filial "+&
								"	and a1.cd_fornecedor = n.cd_fornecedor "+&
								"	and a1.nr_nf  = n.nr_nf "+&
								"	and a1.de_especie = n.de_especie "+&
								"	and a1.de_serie = n.de_serie "+&
								"	and c1.cd_fornecedor = n.cd_fornecedor "+&
								"	and c1.nr_divisao = "+String(lvl_Divisao_Fornecedor)+")", 3)								
End If

If ls_Devolucao = "S" Then
	This.of_AppendWhere("dc.nr_nf > 0", 1)
	This.of_AppendWhere("dc.nr_nf > 0", 2)
End If

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event constructor;call super::constructor;This.of_SetRowSelection( "if(nr_nf_dev > 0, if(getrow() = currentrow(), rgb(139,129,76), rgb(255,236,139)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)) )", "", False )
end event

event ue_postretrieve;If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma nota fiscal localizada.", Information!)
	End If
End If

Return pl_Linhas
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3570
integer height = 1620
long backcolor = 80269524
string text = "Detalhes da Nota Fiscal"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_destinada cb_destinada
cb_est_nfs cb_est_nfs
cb_copiar cb_copiar
dw_3 dw_3
gb_3 gb_3
end type

on tabpage_2.create
this.cb_destinada=create cb_destinada
this.cb_est_nfs=create cb_est_nfs
this.cb_copiar=create cb_copiar
this.dw_3=create dw_3
this.gb_3=create gb_3
this.Control[]={this.cb_destinada,&
this.cb_est_nfs,&
this.cb_copiar,&
this.dw_3,&
this.gb_3}
end on

on tabpage_2.destroy
destroy(this.cb_destinada)
destroy(this.cb_est_nfs)
destroy(this.cb_copiar)
destroy(this.dw_3)
destroy(this.gb_3)
end on

type cb_destinada from commandbutton within tabpage_2
integer x = 2839
integer y = 864
integer width = 549
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Ch. Destinada"
end type

event clicked;long ll_cd_filial
long ll_nr_nota
long ll_linhas

decimal{2} ldc_vl_total

string ls_cd_fornecedor
string ls_nr_nota

datetime ldh_ini, ldh_fim, ldh_emissao

dc_uo_ds_base lds_dados

lds_dados = create dc_uo_ds_base
lds_dados.of_changedataobject('dw_ge030_lista_destinadas')

ll_Cd_filial = tab_1.tabpage_2.dw_3.object.cd_filial[1]
ll_nr_nota = tab_1.tabpage_2.dw_3.object.nr_nf[1]
ldc_vl_total = tab_1.tabpage_2.dw_3.object.vl_total_nf[1]
ls_cd_fornecedor = tab_1.tabpage_2.dw_3.object.cd_fornecedor[1]

ldh_emissao = tab_1.tabpage_2.dw_3.object.dh_emissao[1]

ldh_ini = datetime(date(ldh_emissao),time('00:00:00'))
ldh_fim = datetime(date(ldh_emissao),time('23:59:59'))


ls_nr_nota = '%' + String(ll_nr_nota) + '%'

ll_linhas = lds_dados.retrieve(ll_Cd_filial, ls_cd_fornecedor, ldc_vl_total, ldh_ini, ldh_fim, ls_nr_nota )

if ll_linhas > 0 then

	OpenWithParm(w_ge030_consulta_destinada,lds_dados)
	
Elseif ll_linhas = 0 Then
	
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o foram encontradas informa$$HEX2$$e700f500$$ENDHEX$$es correspondentes na tabela de notas destinadas.')
	
Else
	
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao consultar a tabela nfe_destinadas: ' + sqlca.sqlerrtext)
	
ENd if
end event

type cb_est_nfs from commandbutton within tabpage_2
integer x = 2798
integer y = 260
integer width = 677
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Solicitar Est. NF Servi$$HEX1$$e700$$ENDHEX$$o"
end type

event clicked;Long		ll_nr_nf, ll_row
String	ls_Log, ls_serie, ls_cd_fornecedor, ls_especie, ls_chave

st_log_export_sap st_log


ll_row = Tab_1.TabPage_2.dw_3.GetRow()

if ll_row < 1 then return

ll_nr_nf 			= Tab_1.TabPage_2.dw_3.GetItemNumber(ll_row, 'nr_nf')
ls_serie 			= Tab_1.TabPage_2.dw_3.GetItemString(ll_row, 'de_serie')
ls_cd_fornecedor 	= Tab_1.TabPage_2.dw_3.GetItemString(ll_row, 'cd_fornecedor')
ls_especie			= Tab_1.TabPage_2.dw_3.GetItemString(ll_row, 'de_especie')

ls_chave = String(ll_nr_nf) + '#' + ls_serie + '#' + ls_cd_fornecedor + '#' + ls_especie
	
st_log.cd_chave 				= ls_chave
st_log.id_tipo_nf 			= 'ENS'
st_log.cd_tipo_documento   = 'ENS'
st_log.id_tipo_log 			= 97
st_log.cd_filial  			= 534
st_log.cd_parametro_geral  = 'DH_INICIO_OPERACAO_SAP'
st_log.nr_nf					= ll_nr_nf
st_log.de_serie				= ls_serie
st_log.cd_fornecedor			= ls_cd_fornecedor
st_log.de_especie				= ls_especie

If Not gf_insere_log_exportacao_sap(st_log, ref ls_Log) then
	Sqlca.of_rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Log)
	Return
End If

Sqlca.of_commit();
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Opera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.")
end event

type cb_copiar from commandbutton within tabpage_2
integer x = 1998
integer y = 864
integer width = 763
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Copia a chave de acesso"
end type

event clicked;Integer lvi_Retorno

Tab_1.TabPage_2.dw_3.SelectText(1, 44)

lvi_Retorno = Tab_1.TabPage_2.dw_3.Copy()

Choose Case lvi_Retorno
	Case -1  // Vazio
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum informa$$HEX2$$e700e300$$ENDHEX$$o foi selecionada para a c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -2  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -9  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
End Choose


end event

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 41
integer y = 60
integer width = 3470
integer height = 1496
integer taborder = 20
string dataobject = "dw_ge030_detalhe_nf"
end type

event ue_recuperar;// Override

Return This.Retrieve(ivl_Filial, ivs_Fornecedor, ivl_NF, ivs_Especie, ivs_Serie)
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_postretrieve;call super::ue_postretrieve;Long		ll_nr_nf
String 	lvs_Chave, ls_de_especie, ls_de_serie, ls_cd_fornecedor

If pl_Linhas > 0 Then
	
	Tab_1.TabPage_2.dw_3.AcceptText()
	
	lvs_Chave = Tab_1.TabPage_2.dw_3.Object.de_chave_acesso[1]
	
	If Not IsNull(lvs_Chave) and Trim(lvs_Chave) <> "" Then
		
		cb_copiar.Enabled = True
		
		Tab_1.TabPage_2.dw_3.Object.de_chave_acesso.Protect = 0		
	Else
		
		cb_copiar.Enabled = False
		
		Tab_1.TabPage_2.dw_3.Object.de_chave_acesso.Protect = 1		
	End If
	
	ls_de_especie = Tab_1.TabPage_2.dw_3.Object.de_especie[1]
	ls_de_serie = Tab_1.TabPage_2.dw_3.Object.de_serie[1]
	ll_nr_nf	= Tab_1.TabPage_2.dw_3.Object.nr_nf[1]
	ls_cd_fornecedor = Tab_1.TabPage_2.dw_3.Object.cd_fornecedor[1]
	
	if ls_de_especie = 'NFS' then
		cb_est_nfs.enabled = true
	else
		cb_est_nfs.enabled = false
	end if
End If

Return pl_Linhas


end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type gb_3 from groupbox within tabpage_2
integer x = 9
integer width = 3525
integer height = 1572
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

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3570
integer height = 1620
long backcolor = 80269524
string text = "Produtos da Nota Fiscal"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_5 gb_5
gb_4 gb_4
dw_4 dw_4
dw_5 dw_5
end type

on tabpage_3.create
this.gb_5=create gb_5
this.gb_4=create gb_4
this.dw_4=create dw_4
this.dw_5=create dw_5
this.Control[]={this.gb_5,&
this.gb_4,&
this.dw_4,&
this.dw_5}
end on

on tabpage_3.destroy
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.dw_5)
end on

type gb_5 from groupbox within tabpage_3
integer x = 9
integer y = 1056
integer width = 3515
integer height = 516
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes do Produto Selecionado"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_3
integer x = 9
integer width = 3515
integer height = 1044
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 37
integer y = 44
integer width = 3470
integer height = 980
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge030_lista_produto"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;// Override

Return This.Retrieve(ivl_Filial, ivs_Fornecedor, ivl_NF, ivs_Especie, ivs_Serie)
end event

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]

lvs_Coluna = {"cd_produto", "de_produto"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "Descri$$HEX2$$e700e300$$ENDHEX$$o"}

This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	dw_5.Object.Cd_Produto            [1] = This.Object.Cd_Produto            [CurrentRow]
	dw_5.Object.De_Produto            [1] = This.Object.De_Produto            [CurrentRow]
	dw_5.Object.Qt_Faturada           [1] = This.Object.Qt_Faturada           [CurrentRow]
	dw_5.Object.Qt_Recebida           [1] = This.Object.Qt_Recebida           [CurrentRow]
	dw_5.Object.Vl_Preco_Unitario     [1] = This.Object.Vl_Preco_Unitario     [CurrentRow]
	dw_5.Object.Pc_Desconto           [1] = This.Object.Pc_Desconto           [CurrentRow]	
	dw_5.Object.Vl_ICMS_Repassado     [1] = This.Object.Vl_ICMS_Repassado     [CurrentRow]
	dw_5.Object.Pc_ICMS               [1] = This.Object.Pc_ICMS               [CurrentRow]
	dw_5.Object.Pc_IPI                [1] = This.Object.Pc_IPI                [CurrentRow]
	dw_5.Object.Pc_Reducao_Base_ICMS  [1] = This.Object.Pc_Reducao_Base_ICMS  [CurrentRow]
	dw_5.Object.Cd_Natureza_Operacao  [1] = This.Object.Cd_Natureza_Operacao  [CurrentRow]
	dw_5.Object.Cd_Situacao_Tributaria[1] = This.Object.Cd_Situacao_Tributaria[CurrentRow]
	dw_5.Object.Id_Lista_PIS_COFINS   [1] = This.Object.Id_Lista_PIS_COFINS   [CurrentRow]
	dw_5.Object.vl_icms_st			  [1] = This.Object.vl_ICMS_St			  [CurrentRow]	
	dw_5.Object.vl_preco_base_icms_st	[1] = This.Object.vl_preco_base_icms_st[CurrentRow]
	dw_5.Object.vl_ipi			  [1] = This.Object.vl_ipi[CurrentRow]
	dw_5.Object.vl_custo_entrada			  [1] = This.Object.vl_custo_entrada[CurrentRow]
	
	if this.DataObject = 'dw_ge030_lista_produto2' then
		dw_5.Object.cd_produto_sap			  [1] = This.Object.cd_produto_sap[CurrentRow]
	end if
	
	If This.Object.vl_outras_despesas[CurrentRow] = 0 Then
		dw_5.Object.vl_outras_despesas		  [1] = 0
	Else
		dw_5.Object.vl_outras_despesas		  [1] = This.Object.vl_outras_despesas[CurrentRow] /  This.Object.Qt_Faturada [CurrentRow]
	End If
	
	dw_5.Object.t_vl_preco_base_icms_st.Visible = (This.Object.id_bc_icms_st_calculado[CurrentRow] = 'S')
	dw_5.Object.t_vl_icms_st.Visible = (This.Object.id_icms_st_calculado[CurrentRow] = 'S')
	dw_5.Object.t_valor_calculado.Visible =  ((This.Object.id_bc_icms_st_calculado[CurrentRow] = 'S') or  (This.Object.id_icms_st_calculado[CurrentRow] = 'S')) 
End If
end event

event ue_postretrieve;Boolean lvb_Habilitar

If pl_Linhas > 0 Then
	lvb_Habilitar = True
	
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	dw_5.Reset()
	dw_5.Event ue_AddRow()
	
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos da nota fiscal n$$HEX1$$e300$$ENDHEX$$o localizados.")
	End If
End If

ivo_Controle_Menu.of_Classificar(lvb_Habilitar)
ivo_Controle_Menu.of_Filtrar(lvb_Habilitar)

Return pl_Linhas
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_preretrieve;call super::ue_preretrieve;String lvs_DW

String 	lvs_Coluna[], &
     		lvs_Nome[]
			  
lvs_Coluna = {"cd_produto", "de_produto"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "Descri$$HEX2$$e700e300$$ENDHEX$$o"}

If ivdt_Movimento >= Date("12/02/2014") Then
	lvs_DW  = "dw_ge030_lista_produto2"
Else
	lvs_DW  = "dw_ge030_lista_produto"
End If

If This.DataObject <> lvs_DW Then
	If Not This.of_ChangeDataObject(lvs_DW) Then	Return -1
	
	This.of_SetSort(lvs_Coluna, lvs_Nome)
	
	This.of_SetFilter(lvs_Coluna, lvs_Nome)
	
	This.of_SetRowSelection()
End If

Return AncestorReturnValue
end event

type dw_5 from dc_uo_dw_base within tabpage_3
integer x = 37
integer y = 1120
integer width = 3470
integer height = 432
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge030_detalhe_produto"
end type

event getfocus;call super::getfocus;dw_4.ivo_Controle_Menu.of_Atualiza()
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3570
integer height = 1620
long backcolor = 67108864
string text = "Lotes"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_alterar_lote cb_alterar_lote
gb_6 gb_6
dw_6 dw_6
end type

on tabpage_4.create
this.cb_alterar_lote=create cb_alterar_lote
this.gb_6=create gb_6
this.dw_6=create dw_6
this.Control[]={this.cb_alterar_lote,&
this.gb_6,&
this.dw_6}
end on

on tabpage_4.destroy
destroy(this.cb_alterar_lote)
destroy(this.gb_6)
destroy(this.dw_6)
end on

type cb_alterar_lote from commandbutton within tabpage_4
integer x = 2816
integer y = 1512
integer width = 411
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Alterar Lote"
end type

event clicked;//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Long									ll_Linha, &
										ll_Find,  &
										ll_Tot_Prod

String								ls_Usuario, &
										ls_Retorno

st_ge030_parametros_alt_lote	lst_Parametro

//PROCEDIMENTOS
ll_Linha = dw_6.GetRow ()

If ll_Linha < 1 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione um produto para altera$$HEX2$$e700e300$$ENDHEX$$o do lote!')
	Return 1
End if

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento ('GE030_ALTERAR_LOTE', ref ls_Usuario) then
	Return 1
End if

dw_6.AcceptText ()
tab_1.tabpage_3.dw_4.AcceptText ()

lst_Parametro.cd_produto           = dw_6.Object.cd_produto           [ll_Linha]
lst_Parametro.de_produto           = dw_6.Object.de_produto           [ll_Linha]
lst_Parametro.nr_lote              = dw_6.Object.nr_lote              [ll_Linha]
lst_Parametro.dh_validade          = dw_6.Object.dh_validade          [ll_Linha]
lst_Parametro.cd_natureza_operacao = dw_6.Object.cd_natureza_operacao [ll_Linha]
lst_Parametro.cd_filial            = ivl_filial
lst_Parametro.nm_fantasia          = ivs_nm_fantasia
lst_Parametro.cd_fornecedor        = ivs_fornecedor
lst_Parametro.nm_razao_social      = ivs_nm_razao_social
lst_Parametro.nr_nf                = ivl_nf
lst_Parametro.de_especie           = ivs_especie
lst_Parametro.de_serie             = ivs_serie

If not wf_verifica_solic_devol_pend (lst_Parametro, Ref ls_Retorno) then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Retorno, Exclamation!)
	Return 1
End if

ll_Tot_Prod = tab_1.tabpage_3.dw_4.RowCount ()

If ll_Tot_Prod > 0 then
	ll_Find = tab_1.tabpage_3.dw_4.Find ('cd_produto = ' + String (lst_Parametro.cd_produto), 1, ll_Tot_Prod)
	
	If ll_Find < 1 then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na lista de produtos da nota!')
		Return 1
	End if
	
	lst_Parametro.qt_faturada = tab_1.tabpage_3.dw_4.Object.qt_faturada [ll_Find]
else
	SELECT qt_faturada
	  INTO :lst_Parametro.qt_faturada
	  FROM item_nf_compra
	 WHERE cd_filial            = :lst_Parametro.cd_filial
		AND cd_fornecedor        = :lst_Parametro.cd_fornecedor
		AND nr_nf                = :lst_Parametro.nr_nf
		AND de_especie           = :lst_Parametro.de_especie
		AND de_serie             = :lst_Parametro.de_serie
		AND cd_natureza_operacao = :lst_Parametro.cd_natureza_operacao
		AND cd_produto           = :lst_Parametro.cd_produto
	 USING SQLCA;
	
//	Choose case SQLCA.SQLCode
End if

OpenWithParm (w_ge030_altera_adiciona_lote, lst_Parametro)
ls_Retorno = Message.StringParm

If ls_Retorno = 'S' Then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Lote alterado!')
	dw_6.Event ue_Retrieve ()
	dw_6.SetRow (ll_Linha)
	dw_6.ScrollToRow (ll_Linha)
End If
end event

type gb_6 from groupbox within tabpage_4
integer x = 9
integer width = 3543
integer height = 1500
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type dw_6 from dc_uo_dw_base within tabpage_4
integer x = 37
integer y = 48
integer width = 3474
integer height = 1440
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge030_lotes_controlados"
boolean vscrollbar = true
end type

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]

lvs_Coluna = {"cd_produto", "de_produto"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "Descri$$HEX2$$e700e300$$ENDHEX$$o"}

This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()
end event

event ue_recuperar;// Override

Return This.Retrieve( ivl_Filial, ivs_Fornecedor, ivl_NF, ivs_Especie, ivs_Serie )
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3570
integer height = 1620
long backcolor = 67108864
string text = "Devolu$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_7 gb_7
dw_7 dw_7
hsb_row hsb_row
end type

on tabpage_5.create
this.gb_7=create gb_7
this.dw_7=create dw_7
this.hsb_row=create hsb_row
this.Control[]={this.gb_7,&
this.dw_7,&
this.hsb_row}
end on

on tabpage_5.destroy
destroy(this.gb_7)
destroy(this.dw_7)
destroy(this.hsb_row)
end on

type gb_7 from groupbox within tabpage_5
integer x = 23
integer width = 2354
integer height = 1100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_7 from dc_uo_dw_base within tabpage_5
integer x = 59
integer y = 76
integer width = 2190
integer height = 1004
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge030_lista_devolucao"
end type

event ue_recuperar;//OverRide

Return This.Retrieve(ivl_Filial, ivs_Fornecedor, ivl_NF, ivs_Especie, ivs_Serie)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	hsb_row.Visible = True
Else
	hsb_row.Visible = False
End If

Return pl_Linhas
end event

type hsb_row from hscrollbar within tabpage_5
integer x = 183
integer y = 976
integer width = 151
integer height = 72
boolean bringtotop = true
boolean stdheight = false
end type

event constructor;This.Visible = True

This.tabOrder = 14
end event

event lineleft;Long ll_row

ll_row = Tab_1.tabpage_5.dw_7.GetRow()

ll_row -= 1

If ll_row = 0 Then ll_row = 1

dw_7.ScrollToRow(ll_row)
end event

event lineright;Long ll_row

ll_row = Tab_1.tabpage_5.dw_7.GetRow()

ll_row += 1

If ll_row > Tab_1.tabpage_5.dw_7.RowCount() Then ll_row = Tab_1.tabpage_5.dw_7.RowCount()

dw_7.ScrollToRow(ll_row)
end event

