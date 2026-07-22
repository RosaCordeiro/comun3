HA$PBExportHeader$w_consulta_posicao_titulo_cv.srw
forward
global type w_consulta_posicao_titulo_cv from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_consulta_posicao_titulo_cv
end type
end forward

global type w_consulta_posicao_titulo_cv from dc_w_selecao_lista_relatorio
integer width = 4023
integer height = 1904
string title = "GE052 - Consulta Posi$$HEX2$$e700e300$$ENDHEX$$o de T$$HEX1$$ed00$$ENDHEX$$tulos de Conv$$HEX1$$ea00$$ENDHEX$$nios"
dw_4 dw_4
end type
global w_consulta_posicao_titulo_cv w_consulta_posicao_titulo_cv

type variables
uo_convenio ivo_convenio
uo_filial          ivo_filial
end variables

forward prototypes
public subroutine wf_insere_portador_default ()
public subroutine wf_localiza_convenio ()
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_insere_portador_default ();DataWindowChild lvdwc_Portador

lvdwc_Portador = dw_1.of_InsertRow_DDDW("cd_portador")			

lvdwc_Portador.SetItem(1, "cd_portador", 0)
lvdwc_Portador.SetItem(1, "de_portador", "TODOS")

dw_1.Object.Cd_Portador[1] = 0
end subroutine

public subroutine wf_localiza_convenio ();String lvs_Convenio

lvs_Convenio = dw_1.GetText()

ivo_Convenio.of_Localiza_Convenio(lvs_Convenio)

If ivo_Convenio.Localizado Then
	dw_1.Object.Cd_Convenio[1] = ivo_Convenio.Cd_Convenio
	dw_1.Object.Nm_Fantasia[1] = ivo_Convenio.Nm_Fantasia
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

on w_consulta_posicao_titulo_cv.create
int iCurrent
call super::create
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
end on

on w_consulta_posicao_titulo_cv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
end on

event close;call super::close;Destroy(ivo_Convenio)
Destroy(ivo_Filial)
end event

event open;call super::open;ivo_Convenio = Create uo_Convenio
ivo_Filial   = Create uo_Filial
ivo_Filial.ivs_Centralizadora = 'S'
end event

event ue_postopen;call super::ue_postopen;wf_Insere_Portador_Default()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_preopen;call super::ue_preopen;dw_4.Visible = False
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_consulta_posicao_titulo_cv
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_consulta_posicao_titulo_cv
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_consulta_posicao_titulo_cv
integer x = 14
integer y = 416
integer width = 3950
integer height = 1292
integer weight = 700
long backcolor = 79741120
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_consulta_posicao_titulo_cv
integer x = 14
integer y = 0
integer width = 3575
integer height = 416
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_consulta_posicao_titulo_cv
integer x = 27
integer y = 52
integer width = 3538
integer height = 352
integer taborder = 40
string dataobject = "dw_selecao_posicao_titulo_cv"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo
Date lvdt_Nulo

SetNull(lvl_Nulo)
SetNull(lvdt_Nulo)

Choose Case dwo.Name
	Case "nm_fantasia"
		If Trim(Data) <> "" Then
			If Data <> ivo_Convenio.Nm_Fantasia Then
				Return 1
			End If
		Else
			This.Object.Cd_Convenio[1] = lvl_Nulo
			ivo_Convenio.Nm_Fantasia   = ""
		End If
	
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			This.Object.Cd_filial[1] = lvl_Nulo
			ivo_filial.Nm_Fantasia   = ""
		End If
	
	Case "id_situacao"
		If Data = "A" Then
			This.Object.Dt_Baixa_Inicio[1]  = lvdt_Nulo // "00/00/0000"
			This.Object.Dt_Baixa_Termino[1] = lvdt_Nulo // "00/00/0000"
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Convenio) Then
	This.Object.Nm_Fantasia[1] = ivo_Convenio.Nm_Fantasia
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1]   = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "nm_fantasia"
			wf_Localiza_Convenio()
		Case "nm_filial"
			wf_localiza_Filial()
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_consulta_posicao_titulo_cv
integer x = 46
integer width = 3899
integer height = 1232
integer taborder = 50
string dataobject = "dw_consulta_titulo_cv_pago"
end type

event dw_2::constructor;call super::constructor;This.ivb_Selecao_Linhas = False

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial_centralizadora","filial.nm_fantasia","nr_titulo","nr_titulo_banco",&
              "cd_convenio","convenio.nm_fantasia","dh_emissao","vl_nominal","dh_vencimento",&
				  "vl_aberto","nr_dias_atraso","vl_juros_calculado","saldo"}

lvs_Nome = {"c$$HEX1$$f300$$ENDHEX$$digo centralizadora","filial centralizadora","nr titulo","nr titulo banco",&
            "c$$HEX1$$f300$$ENDHEX$$digo conv$$HEX1$$ea00$$ENDHEX$$nio","conv$$HEX1$$ea00$$ENDHEX$$nio","data de emiss$$HEX1$$e300$$ENDHEX$$o","vlr nominal","data de vencimento",&
				"vlr aberto","dias atraso","vlr juros calculado","saldo"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial, &
     lvl_Convenio, &
	  lvl_Portador
	  
String lvs_SQL, &
       lvs_Situacao, &
		 lvs_DW_Consulta, &
		 lvs_DW_Relatorio
		 
Date lvdt_Emissao_Inicio, &
	  lvdt_Emissao_Termino, &
	  lvdt_Vencimento_Inicio, &
	  lvdt_Vencimento_Termino, &
     lvdt_Fechamento_Inicio, &
	  lvdt_Fechamento_Termino, &
	  lvdt_Baixa_Inicio, &
     lvdt_Baixa_Termino
	  		 
dw_1.AcceptText()		 
		 
// Verifica qual a DW para a consulta
lvs_Situacao = dw_1.Object.Id_Situacao[1]

If lvs_Situacao = "A" Then
	lvs_DW_Consulta  = "dw_consulta_titulo_cv_aberto"
	lvs_DW_Relatorio = "dw_relatorio_titulo_cv_aberto"
ElseIf lvs_Situacao = "P" Then
	lvs_DW_Consulta  = "dw_consulta_titulo_cv_pago"
	lvs_DW_Relatorio = "dw_relatorio_titulo_cv_pago"
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

lvl_Filial   = dw_1.Object.Cd_Filial[1]
lvl_Portador = dw_1.Object.Cd_Portador[1]
lvl_Convenio = dw_1.Object.Cd_Convenio[1]

lvdt_Emissao_Inicio			= dw_1.Object.Dt_Emissao_Inicio			[1]
lvdt_Emissao_Termino		= dw_1.Object.Dt_Emissao_Termino		[1]
lvdt_Vencimento_Inicio		= dw_1.Object.Dt_Vencimento_Inicio		[1]
lvdt_Vencimento_Termino	= dw_1.Object.Dt_Vencimento_Termino	[1]
lvdt_Fechamento_Inicio		= dw_1.Object.Dt_Fechamento_Inicio		[1]
lvdt_Fechamento_Termino	= dw_1.Object.Dt_Fechamento_Termino	[1]
lvdt_Baixa_Inicio				= dw_1.Object.Dt_Baixa_Inicio				[1]
lvdt_Baixa_Termino			= dw_1.Object.Dt_Baixa_Termino			[1]
 
If Not IsNull(lvl_Convenio) Then
	This.of_AppendWhere("t.cd_convenio = " + String(lvl_Convenio) )
End If	

If lvl_Portador > 0 Then
	This.of_AppendWhere("t.cd_portador = " + String(lvl_Portador) )
End If	 

If lvl_Filial > 0 Then	
	This.of_AppendWhere("t.cd_filial_centralizadora = " + String(lvl_Filial) )
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
	
//	If dw_1.Object.Id_Situacao[1] = 'A' Then
//		
//		dw_4.Event ue_Retrieve()
//		
//		lvl_Linha = dw_4.RowCount()
//		
//		If lvl_Linha > 0 Then
			ivm_Menu.mf_SalvarComo(True)
//		End If	
		
//	End If

	This.of_SetRowSelection()

Else
	ivm_Menu.mf_SalvarComo(False)
End If

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.Mf_SalvarComo(False)
end event

event dw_2::ue_saveas;call super::ue_saveas;////OverRide
//dw_2.Event ue_SaveAs()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_consulta_posicao_titulo_cv
integer x = 1879
integer y = 0
integer height = 344
integer taborder = 60
string dataobject = "dw_relatorio_titulo_cv_aberto"
end type

type dw_4 from dc_uo_dw_base within w_consulta_posicao_titulo_cv
integer x = 1495
integer y = 412
integer height = 164
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_ge052_titulos_aberto_excel"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial, &
     lvl_Convenio, &
	  lvl_Portador
	  
String lvs_SQL, &
       lvs_Situacao, &
		 lvs_DW_Consulta, &
		 lvs_DW_Relatorio
		 
Date lvdt_Emissao_Inicio, &
	  lvdt_Emissao_Termino, &
	  lvdt_Vencimento_Inicio, &
	  lvdt_Vencimento_Termino, &
     lvdt_Fechamento_Inicio, &
	  lvdt_Fechamento_Termino, &
	  lvdt_Baixa_Inicio, &
     lvdt_Baixa_Termino
	  		 
dw_1.AcceptText()		 
		 
lvl_Filial   = dw_1.Object.Cd_Filial[1]
lvl_Portador = dw_1.Object.Cd_Portador[1]
lvl_Convenio = dw_1.Object.Cd_Convenio[1]

lvdt_Emissao_Inicio     = dw_1.Object.Dt_Emissao_Inicio[1]
lvdt_Emissao_Termino    = dw_1.Object.Dt_Emissao_Termino[1]
lvdt_Vencimento_Inicio  = dw_1.Object.Dt_Vencimento_Inicio[1]
lvdt_Vencimento_Termino = dw_1.Object.Dt_Vencimento_Termino[1]
lvdt_Fechamento_Inicio  = dw_1.Object.Dt_Fechamento_Inicio[1]
lvdt_Fechamento_Termino = dw_1.Object.Dt_Fechamento_Termino[1]
lvdt_Baixa_Inicio       = dw_1.Object.Dt_Baixa_Inicio[1]
lvdt_Baixa_Termino      = dw_1.Object.Dt_Baixa_Termino[1]
 
If Not IsNull(lvl_Convenio) Then
	This.of_AppendWhere("titulo_receber.cd_convenio = " + String(lvl_Convenio) )
End If	

If lvl_Portador > 0 Then
	This.of_AppendWhere("titulo_receber.cd_portador = " + String(lvl_Portador) )
End If	 

If lvl_Filial > 0 Then	
	This.of_AppendWhere("convenio.cd_filial_centralizadora = " + String(lvl_Filial) )
End If	
		 
If Not IsNull(lvdt_Emissao_Inicio) Then 
	This.of_AppendWhere(gf_Compara_Data("titulo_receber.dh_emissao", ">=", lvdt_Emissao_Inicio) )
End If	

If Not IsNull(lvdt_Emissao_Termino) Then 
	This.of_AppendWhere(gf_Compara_Data("titulo_receber.dh_emissao", "<=", lvdt_Emissao_Termino) )
End If	
		 
If Not IsNull(lvdt_Baixa_Inicio) Then 
	This.of_AppendWhere(gf_Compara_Data("titulo_receber.dh_baixa", ">=", lvdt_Baixa_Inicio) )
End If	

If Not IsNull(lvdt_Baixa_Termino) Then 
	This.of_AppendWhere(gf_Compara_Data("titulo_receber.dh_baixa", "<=", lvdt_Baixa_Termino) )
End If	
		 
If Not IsNull(lvdt_Vencimento_Inicio) Then 
	This.of_AppendWhere(gf_Compara_Data("titulo_receber.dh_vencimento", ">=", lvdt_Vencimento_Inicio) )
End If	

If Not IsNull(lvdt_Vencimento_Termino) Then 
	This.of_AppendWhere(gf_Compara_Data("titulo_receber.dh_vencimento", "<=", lvdt_Vencimento_Termino) )
End If

If Not IsNull(lvdt_Fechamento_Inicio) Then 
	This.of_AppendWhere(gf_Compara_Data("titulo_receber.dh_venda_final", ">=", lvdt_Fechamento_Inicio) )
End If	

If Not IsNull(lvdt_Fechamento_Termino) Then 
	This.of_AppendWhere(gf_Compara_Data("titulo_receber.dh_venda_final", "<=", lvdt_Fechamento_Termino) )
End If

Return 1
end event

