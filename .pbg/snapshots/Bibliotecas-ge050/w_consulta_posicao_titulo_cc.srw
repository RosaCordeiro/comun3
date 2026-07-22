HA$PBExportHeader$w_consulta_posicao_titulo_cc.srw
forward
global type w_consulta_posicao_titulo_cc from dc_w_selecao_lista_relatorio
end type
end forward

global type w_consulta_posicao_titulo_cc from dc_w_selecao_lista_relatorio
integer width = 4018
integer height = 1864
string title = "GE050 - Consulta Posi$$HEX2$$e700e300$$ENDHEX$$o de Cliente Conta Corrente"
end type
global w_consulta_posicao_titulo_cc w_consulta_posicao_titulo_cc

type variables
uo_cliente ivo_cliente
uo_filial      ivo_filial
end variables

forward prototypes
public subroutine wf_localiza_cliente ()
public subroutine wf_localiza_filial ()
public subroutine wf_insere_portador_default ()
end prototypes

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

public subroutine wf_insere_portador_default ();DataWindowChild lvdwc_Portador

lvdwc_Portador = dw_1.of_InsertRow_DDDW("cd_portador")			

lvdwc_Portador.SetItem(1, "cd_portador", 0)
lvdwc_Portador.SetItem(1, "de_portador", "TODOS")

dw_1.Object.Cd_Portador[1] = 0
end subroutine

on w_consulta_posicao_titulo_cc.create
call super::create
end on

on w_consulta_posicao_titulo_cc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Cliente)
Destroy(ivo_Filial)
end event

event open;call super::open;ivo_Cliente = Create uo_Cliente
ivo_Filial  = Create uo_Filial
ivo_Filial.ivs_Centralizadora = 'S'
end event

event ue_postopen;call super::ue_postopen;wf_Insere_Portador_Default()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_consulta_posicao_titulo_cc
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_consulta_posicao_titulo_cc
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_consulta_posicao_titulo_cc
integer x = 27
integer y = 416
integer width = 3918
integer height = 1248
integer weight = 700
long backcolor = 79741120
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_consulta_posicao_titulo_cc
integer x = 27
integer y = 0
integer width = 3598
integer height = 416
integer weight = 700
long backcolor = 79741120
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_consulta_posicao_titulo_cc
integer x = 46
integer y = 56
integer width = 3557
integer height = 348
string dataobject = "dw_selecao_posicao_titulo_cc"
end type

event dw_1::itemchanged;call super::itemchanged;String lvs_Nulo
Date   lvdt_Nulo
Long  lvl_Nulo

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
			ivo_Filial.Nm_fantasia   = ""
		End If
		
	Case "id_situacao"
		If Data = "A" Then
			This.Object.Dt_Baixa_Inicio[1]  = lvdt_Nulo // "00/00/0000"
			This.Object.Dt_Baixa_Termino[1] = lvdt_Nulo // "00/00/0000"
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Cliente) Then
	This.Object.De_Cliente[1] = ivo_Cliente.Nm_Cliente
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.nm_Fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "de_cliente"
			wf_Localiza_Cliente()
			
		Case "nm_filial"
			wf_Localiza_Filial()
			
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_consulta_posicao_titulo_cc
integer x = 55
integer width = 3849
integer height = 1184
string dataobject = "dw_consulta_titulo_cc_pago"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial, &
	  lvl_Portador
	  
String lvs_SQL, &
       lvs_Situacao, &
		 lvs_DW_Consulta, &
		 lvs_DW_Relatorio, &
       lvs_Cliente
		 
Date lvdt_Emissao_Inicio, &
	  lvdt_Emissao_Termino, &
	  lvdt_Vencimento_Inicio, &
	  lvdt_Vencimento_Termino, &
	  lvdt_Baixa_Inicio, &
     lvdt_Baixa_Termino, &
	  lvdt_Fechamento_Inicio, &
     lvdt_Fechamento_Termino
	  		 
dw_1.AcceptText()		 
		 
// Verifica qual a DW para a consulta
lvs_Situacao = dw_1.Object.Id_Situacao[1]

If lvs_Situacao = "A" Then
	lvs_DW_Consulta  = "dw_consulta_titulo_cc_aberto"
	lvs_DW_Relatorio = "dw_relatorio_titulo_cc_aberto"
ElseIf lvs_Situacao = "P" Then
	lvs_DW_Consulta  = "dw_consulta_titulo_cc_pago"
	lvs_DW_Relatorio = "dw_relatorio_titulo_cc_pago"
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

lvl_Filial   = dw_1.Object.cd_filial[1]
lvl_Portador = dw_1.Object.Cd_Portador[1]
lvs_Cliente  = dw_1.Object.Cd_Cliente[1]

lvdt_Emissao_Inicio     = dw_1.Object.Dt_Emissao_Inicio[1]
lvdt_Emissao_Termino    = dw_1.Object.Dt_Emissao_Termino[1]
lvdt_Vencimento_Inicio  = dw_1.Object.Dt_Vencimento_Inicio[1]
lvdt_Vencimento_Termino = dw_1.Object.Dt_Vencimento_Termino[1]
lvdt_Baixa_Inicio       = dw_1.Object.Dt_Baixa_Inicio[1]
lvdt_Baixa_Termino      = dw_1.Object.Dt_Baixa_Termino[1]
lvdt_Fechamento_Inicio  = dw_1.Object.Dt_Fechamento_Inicio[1]
lvdt_Fechamento_Termino = dw_1.Object.Dt_Fechamento_Termino[1]
  
If Not IsNull(lvs_Cliente) Then
	This.of_AppendWhere("t.cd_cliente = '"+lvs_Cliente+"'" )
End If	

If lvl_Portador > 0 Then
	This.of_AppendWhere("c.cd_portador = "+String(lvl_Portador) )
End If	 

If lvl_Filial > 0 Then	
	This.of_AppendWhere("c.cd_filial_centralizadora = " + String(lvl_Filial) )
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

If Not IsNull(lvdt_Fechamento_Inicio) Then 
	This.of_AppendWhere(gf_Compara_Data("dh_venda_final", ">=", lvdt_Fechamento_Inicio) )
End If	

If Not IsNull(lvdt_Fechamento_Termino) Then 
	This.of_AppendWhere(gf_Compara_Data("dh_venda_final", "<=", lvdt_Fechamento_Termino) )
End If

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;// Habilita o bot$$HEX1$$e300$$ENDHEX$$o imprimir, mesmo sem linha para impress$$HEX1$$e300$$ENDHEX$$o

Parent.ivm_Menu.mf_Imprimir(True)

dw_3.Object.st_filial.Text  = gvo_parametro.of_nome_filial_parametro()

If pl_linhas > 0 Then
	
	dw_1.AcceptText()
	
	Long lvl_Linha
	
	If dw_1.Object.Id_Situacao[1] = 'A' Then
		
		dw_3.Event ue_Retrieve()
		
		lvl_Linha = dw_3.RowCount()
		
		If lvl_Linha > 0 Then
			ivm_Menu.mf_SalvarComo(True)
		End If			
	End If
	
	This.of_SetRowSelection()
Else
	ivm_Menu.mf_SalvarComo(False)
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_consulta_posicao_titulo_cc
integer x = 2002
integer y = 64
integer width = 279
integer height = 264
string dataobject = "dw_relatorio_titulo_cc_pago"
end type

