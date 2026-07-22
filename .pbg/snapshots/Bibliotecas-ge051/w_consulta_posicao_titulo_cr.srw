HA$PBExportHeader$w_consulta_posicao_titulo_cr.srw
forward
global type w_consulta_posicao_titulo_cr from dc_w_selecao_lista_relatorio
end type
type cb_mostra_req from commandbutton within w_consulta_posicao_titulo_cr
end type
end forward

global type w_consulta_posicao_titulo_cr from dc_w_selecao_lista_relatorio
integer width = 4059
integer height = 1860
string title = "GE051 - Consulta Posi$$HEX2$$e700e300$$ENDHEX$$o de Cliente Credi$$HEX1$$e100$$ENDHEX$$rio"
cb_mostra_req cb_mostra_req
end type
global w_consulta_posicao_titulo_cr w_consulta_posicao_titulo_cr

type variables
uo_cliente ivo_cliente
uo_filial      ivo_filial
end variables

forward prototypes
public subroutine wf_insere_portador_default ()
public subroutine wf_localiza_cliente ()
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_insere_portador_default ();DataWindowChild lvdwc_Portador

lvdwc_Portador = dw_1.of_InsertRow_DDDW("cd_portador")			

lvdwc_Portador.SetItem(1, "cd_portador", 0)
lvdwc_Portador.SetItem(1, "de_portador", "TODOS")

dw_1.Object.Cd_Portador[1] = 0
end subroutine

public subroutine wf_localiza_cliente ();String lvs_Cliente

lvs_Cliente = dw_1.GetText()

ivo_Cliente.of_Localiza_Cliente(lvs_Cliente)

If ivo_Cliente.Localizado Then
	dw_1.Object.Cd_Cliente[1] = ivo_Cliente.Cd_Cliente
	dw_1.Object.De_Cliente[1] = ivo_Cliente.Nm_Cliente
End If
end subroutine

public subroutine wf_localiza_filial ();String lvs_Filial
Long lvl_Filial

SetNull(lvl_Filial)
lvs_Filial = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Filial)

If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	dw_1.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
Else
	dw_1.Object.Cd_Filial[1] = lvl_Filial
	dw_1.Object.Nm_Filial[1] = ""
End If
end subroutine

on w_consulta_posicao_titulo_cr.create
int iCurrent
call super::create
this.cb_mostra_req=create cb_mostra_req
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_mostra_req
end on

on w_consulta_posicao_titulo_cr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_mostra_req)
end on

event close;call super::close;Destroy(ivo_Cliente)
Destroy(ivo_Filial)
end event

event open;call super::open;ivo_Cliente = Create uo_Cliente
ivo_Filial  = Create uo_Filial
end event

event ue_postopen;call super::ue_postopen;wf_Insere_Portador_Default()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_consulta_posicao_titulo_cr
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_consulta_posicao_titulo_cr
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_consulta_posicao_titulo_cr
integer x = 27
integer y = 512
integer width = 3968
integer height = 1152
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_consulta_posicao_titulo_cr
integer x = 27
integer y = 0
integer width = 3680
integer height = 496
long backcolor = 79741120
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_consulta_posicao_titulo_cr
integer x = 55
integer y = 56
integer width = 3634
integer height = 424
string dataobject = "dw_selecao_posicao_titulo_cr"
end type

event dw_1::itemchanged;call super::itemchanged;String lvs_Nulo
Date   lvdt_Nulo
Long   lvl_Nulo

SetNull(lvs_Nulo)
SetNull(lvdt_Nulo)
SetNull(lvl_Nulo)

Choose Case dwo.Name
	Case "de_cliente"
		If Trim(Data) <> "" Then
			If Data <> ivo_Cliente.nm_Cliente Then
				Return 1
			End If
		Else
			This.Object.Cd_Cliente[1] = lvs_Nulo
			ivo_Cliente.Nm_Cliente   = ""
		End If
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If
		Else
			This.Object.Cd_Filial[1] = lvl_Nulo
			ivo_Filial.Nm_Fantasia   = ""
		End If
	Case "id_situacao"
		If Data = "A" Then
			This.Object.Dt_Baixa_Inicio[1]  = lvdt_Nulo // "00/00/0000"
			This.Object.Dt_Baixa_Termino[1] = lvdt_Nulo // "00/00/0000"
		End If
	Case "id_considera_manip"
		If Data = "S" Then
			cb_mostra_req.enabled = true
		Else
			cb_mostra_req.enabled = false
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Cliente) Then
	This.Object.De_Cliente[1] = ivo_Cliente.Nm_Cliente
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "de_cliente"
			wf_Localiza_Cliente()
			
		Case "nm_filial"
			wf_localiza_filial()
			
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_consulta_posicao_titulo_cr
integer x = 59
integer y = 576
integer width = 3909
integer height = 1076
string dataobject = "dw_consulta_titulo_cv_pago"
end type

event dw_2::constructor;call super::constructor;This.ivb_Selecao_Linhas = False
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial, &
	  lvl_Portador
	  
String lvs_SQL, &
       lvs_Situacao, &
		 lvs_DW_Consulta, &
		 lvs_DW_Relatorio, &
       lvs_Cliente, &
	    lvs_considera_manip, &
		 ls_id_verbas
		 
Date lvdt_Emissao_Inicio, &
	  lvdt_Emissao_Termino, &
	  lvdt_Vencimento_Inicio, &
	  lvdt_Vencimento_Termino, &
	  lvdt_Baixa_Inicio, &
     lvdt_Baixa_Termino
	  		 
dw_1.AcceptText()		 
		 
// Verifica qual a DW para a consulta
lvs_Situacao = dw_1.Object.Id_Situacao[1]
ls_id_verbas = dw_1.Object.Id_verbas[1]

If lvs_Situacao = "A" Then
	lvs_DW_Consulta  = "dw_consulta_titulo_cr_aberto"
	lvs_DW_Relatorio = "dw_relatorio_titulo_cr_aberto"
ElseIf lvs_Situacao = "P" Then
	lvs_DW_Consulta  = "dw_consulta_titulo_cr_pago"
	lvs_DW_Relatorio = "dw_relatorio_titulo_cr_pago"
End If

If lvs_DW_Consulta <> This.DataObject Then
	This.DataObject = lvs_DW_Consulta
	This.SetTransObject(SqlCa)
	This.ivs_SQL_Original = This.GetSQLSelect()
End If

If lvs_DW_Relatorio <> dw_3.DataObject Then
	dw_3.DataObject = lvs_DW_Relatorio
	dw_3.SetTransObject(SqlCa)
End If	

// Compartilha as informa$$HEX2$$e700f500$$ENDHEX$$es com a dw_3
This.ShareData(dw_3)

lvl_Filial		= dw_1.Object.Cd_Filial		[1]
lvl_Portador	= dw_1.Object.Cd_Portador	[1]
lvs_Cliente	= dw_1.Object.Cd_Cliente	[1]
lvs_considera_manip = dw_1.Object.id_considera_manip	[1]

lvdt_Emissao_Inicio			= dw_1.Object.Dt_Emissao_Inicio			[1]
lvdt_Emissao_Termino		= dw_1.Object.Dt_Emissao_Termino		[1]
lvdt_Vencimento_Inicio		= dw_1.Object.Dt_Vencimento_Inicio		[1]
lvdt_Vencimento_Termino	= dw_1.Object.Dt_Vencimento_Termino	[1]
lvdt_Baixa_Inicio				= dw_1.Object.Dt_Baixa_Inicio				[1]
lvdt_Baixa_Termino			= dw_1.Object.Dt_Baixa_Termino			[1]

If lvs_considera_manip = 'S' Then
	This.of_AppendFrom("registro_venda_manip")
	This.of_AppendWhere("registro_venda_manip.cd_filial = t.cd_filial_nf")
	This.of_AppendWhere("registro_venda_manip.nr_nf = t.nr_nf")
	This.of_AppendWhere("registro_venda_manip.de_especie = t.de_especie")
	This.of_AppendWhere("registro_venda_manip.de_serie = t.de_serie")	
End If
 
If Not IsNull(lvs_Cliente) Then
	This.of_AppendWhere("t.cd_cliente = '"+lvs_Cliente+"'" )
End If	

If lvl_Portador > 0 Then
	This.of_AppendWhere("t.cd_portador = "+String(lvl_Portador) )
End If	 

If lvl_Filial > 0 Then	
	This.of_AppendWhere("t.cd_filial = " + String(lvl_Filial) )
End If	
		 
If Not IsNull(lvdt_Emissao_Inicio) Then 
	This.of_AppendWhere(gf_Compara_Data("dh_emissao", ">=", lvdt_Emissao_Inicio) )
End If	

If Not IsNull(lvdt_Emissao_Termino) Then 
	This.of_AppendWhere(gf_Compara_Data("dh_emissao", "<=", lvdt_Emissao_Termino) )
End If	
		 
If Not IsNull(lvdt_Baixa_Inicio) Then 
	This.of_AppendWhere(gf_Compara_Data("dh_baixa", ">=", lvdt_Baixa_Inicio) )
End If	

If Not IsNull(lvdt_Baixa_Termino) Then 
	This.of_AppendWhere(gf_Compara_Data("dh_baixa", "<=", lvdt_Baixa_Termino) )
End If	
		 
If Not IsNull(lvdt_Vencimento_Inicio) Then 
	This.of_AppendWhere(gf_Compara_Data("dh_vencimento", ">=", lvdt_Vencimento_Inicio) )
End If	

If Not IsNull(lvdt_Vencimento_Termino) Then 
	This.of_AppendWhere(gf_Compara_Data("dh_vencimento", "<=", lvdt_Vencimento_Termino) )
End If

if ls_id_verbas = 'S' Then
	//Somente Verbas
	This.of_AppendWhere("coalesce(t.nr_conta_sap,'') = '0011201067'")
Elseif ls_id_verbas = 'D' Then
	//Desconsiderar Verbas
	This.of_AppendWhere("coalesce(t.nr_conta_sap,'') <> '0011201067'")	
End if

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;// Habilita o bot$$HEX1$$e300$$ENDHEX$$o imprimir, mesmo sem linha para impress$$HEX1$$e300$$ENDHEX$$o

Parent.ivm_Menu.mf_Imprimir(True)

If pl_linhas > 0 Then
	ivm_Menu.mf_SalvarComo(True)
	This.of_SetRowSelection()
Else
	ivm_Menu.mf_SalvarComo(False)
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_consulta_posicao_titulo_cr
integer x = 3013
integer y = 56
integer width = 325
integer height = 232
string dataobject = "dw_relatorio_titulo_cr_aberto"
end type

type cb_mostra_req from commandbutton within w_consulta_posicao_titulo_cr
integer x = 1266
integer y = 300
integer width = 919
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Mostra Requisi$$HEX2$$e700e300$$ENDHEX$$o de Manipulado"
end type

event clicked;Long ll_Linha

st_ge051_nota lvst_nota

dw_2.AcceptText()

If dw_2.rowcount( ) > 0 Then
	ll_Linha		= dw_2.GetRow( )
	If ll_linha > 0 Then	
		lvst_nota.cd_filial		= dw_2.Object.cd_filial_nf[ll_Linha]
		lvst_nota.nr_nf			= dw_2.Object.nr_nf[ll_Linha]
		lvst_nota.de_especie	= dw_2.Object.de_especie[ll_Linha]
		lvst_nota.de_serie		= dw_2.Object.de_serie[ll_Linha]
		
		OpenWithParm(w_ge051_consulta_req_titulo,lvst_nota)
	End If
End If
end event

