HA$PBExportHeader$w_ge295_relatorio_falta_caixas.srw
forward
global type w_ge295_relatorio_falta_caixas from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge295_relatorio_falta_caixas from dc_w_selecao_lista_relatorio
integer width = 3424
integer height = 1852
string title = "GE295 - Relat$$HEX1$$f300$$ENDHEX$$rio de Faltas nos Caixas das Filiais"
long backcolor = 80269524
end type
global w_ge295_relatorio_falta_caixas w_ge295_relatorio_falta_caixas

type variables
uo_filial ivo_filial

string ivs_coluna[], &
         ivs_coluna_sumarizada[], &
         ivs_nome[], &
         ivs_nome_sumarizado[]
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child
Long lvl_Regiao

If dw_1.GetChild("cd_regiao", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_regiao",0)
	ldw_Child.SetItem(1,"de_regiao","TODAS")
	
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

select cd_regiao
Into :lvl_Regiao
From regiao
Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	dw_1.Object.cd_regiao[1] = lvl_Regiao
Else
	dw_1.Object.cd_regiao[1] = 0	
End If
end subroutine

on w_ge295_relatorio_falta_caixas.create
call super::create
end on

on w_ge295_relatorio_falta_caixas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;Date lvdt_Inicio
Date lvdt_Fim

String lvs_Data
String lvs_Param

Long lvl_Tipo
Long lvl_Mostra

lvs_Param = Message.StringParm

//Parametros passados pela GE278
If (Trim(lvs_Param)<>'')and(not(IsNull(lvs_Param))) Then

	lvs_Data = Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	If IsDate(lvs_Data) Then
		lvdt_Inicio = Date(lvs_Data)
	Else
		lvdt_Inicio	= Date(gvo_Parametro.of_DH_Movimentacao()	)		
	End If

	lvs_Param = Mid(lvs_Param,Pos(lvs_Param,';') + 1)
	lvs_Data = Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	If IsDate(lvs_Data) Then
		lvdt_Fim = Date(lvs_Data)
	Else
		lvdt_Fim	= Date(gvo_Parametro.of_DH_Movimentacao()	)
	End If
	
	lvs_Param 	= Mid(lvs_Param,Pos(lvs_Param,';') + 1)
	lvs_Data 		= Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	lvl_Tipo 		=	Long(lvs_Data)
	
	lvs_Param 	= Mid(lvs_Param,Pos(lvs_Param,';') + 1)
	lvs_Data 		= Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	lvl_Mostra 	=	Long(lvs_Data)
	
	//If (lvl_Tipo = 1) Then  //Por Quantidade
	//	dw_2.SetSort('qt_lancamento_perda desc')
	//Else //Por Valor
	//	dw_2.SetSort('vl_diferenca desc')
	//End If
Else
	lvdt_Inicio	= Date(gvo_Parametro.of_DH_Movimentacao())
	lvdt_Fim		= Date(gvo_Parametro.of_DH_Movimentacao())
End If

dw_1.Object.dt_Inicio [1]	= lvdt_Inicio
dw_1.Object.dt_Termino[1]	= lvdt_Fim

This.ivm_Menu.ivb_Permite_Imprimir = True

wf_insere_padrao( )
end event

event ue_print;//override
dw_3.Event ue_Print()
end event

event ue_printimmediate;//override
dw_3.Event ue_PrintImmediate()
end event

event ue_preopen;call super::ue_preopen;ivo_filial = Create uo_filial

MaxHeight = 9999
MaxWidth = 3440
end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge295_relatorio_falta_caixas
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge295_relatorio_falta_caixas
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge295_relatorio_falta_caixas
integer x = 27
integer y = 348
integer width = 3323
integer height = 1300
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge295_relatorio_falta_caixas
integer x = 27
integer y = 8
integer width = 1760
integer height = 324
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge295_relatorio_falta_caixas
integer x = 50
integer y = 68
integer width = 1691
string dataobject = "dw_ge295_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia					
		End If
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;Long lvl_Nulo

If dwo.Name = "nm_filial" Then
	If Data = "" or IsNull(Data) Then
		SetNull(lvl_Nulo)
		dw_1.Object.cd_filial[1] = lvl_Nulo
	End If
End If

Return 1
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_filial" Then
	If data <> "" Then
		If Trim(Data) <> ivo_Filial.nm_fantasia Then
			Return 1 
		End If
	End If
End If

If dwo.Name = "id_sumarizado" Then

	Choose Case Data
		Case "N"
					
			dw_2.of_ChangeDataObject("dw_ge295_lista")
			dw_3.of_ChangeDataObject("dw_ge295_relatorio")
			dw_2.ivb_ordena_colunas = False
		Case "S"
			
			dw_2.of_ChangeDataObject("dw_ge295_lista_sumarizada")
			dw_3.of_ChangeDataObject("dw_ge295_relatorio_sumarizado")
			dw_2.ivb_ordena_colunas = True
	End Choose
	
	dw_2.ShareData( dw_3 )
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge295_relatorio_falta_caixas
integer x = 55
integer y = 404
integer width = 3269
integer height = 1224
string dataobject = "dw_ge295_lista_sumarizada"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//Override
Date lvdt_Inicio, &
	  lvdt_Termino

Long lvl_Filial
Long lvl_Regiao

String lvs_Sumarizado, &
		 lvs_DW, &
		 lvs_DW3, &
		 lvs_Coluna[], &
		 lvs_Nome[]

dw_1.AcceptText()

lvl_Filial			= dw_1.Object.Cd_Filial 			[1]
lvdt_Inicio		= dw_1.Object.Dt_Inicio 			[1]
lvdt_Termino 	= dw_1.Object.Dt_Termino		[1]
lvs_Sumarizado= dw_1.Object.Id_Sumarizado	[1]
lvl_Regiao		= dw_1.Object.cd_regiao		[1]

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data inicial corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvs_Sumarizado = "S" Then
	lvs_Coluna	= ivs_Coluna_Sumarizada
	lvs_Nome	= ivs_Nome_Sumarizado
Else
	lvs_Coluna	= ivs_Coluna
	lvs_Nome	= ivs_Nome
End If

This.of_SetSort	(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.ShareData (dw_3)

If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
	This.of_AppendWhere("cx.cd_filial = " + String(lvl_Filial))
End If

If Not IsNull(lvl_Regiao) and lvl_Regiao <> 0 Then
	This.of_AppendWhere("f.cd_regiao = " + String(lvl_Regiao))
End If

Return Retrieve(lvdt_Inicio,lvdt_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.of_SetRowSelection()
This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)

Return pl_Linhas
	
	
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

event dw_2::constructor;call super::constructor;ivs_Coluna	=	{"dh_movimentacao_caixa", &
					 "cd_filial", &
					 "cd_caixa", &
					 "nr_controle_caixa", &
					 "nr_matricula", &
					 "nm_usuario", &
					 "vl_sobra", &
					 "vl_perda", &
					 "vl_diferenca"}

ivs_Nome 	=	{"Data da Movimenta$$HEX2$$e700e300$$ENDHEX$$o", &
					 "Filial", &
					 "Caixa", &
					 "Controle", &
					 "Matr$$HEX1$$ed00$$ENDHEX$$cula", &
					 "Operador", &
					 "Valor Sobra", &
					 "Valor Perda", &
					 "Valor Diferen$$HEX1$$e700$$ENDHEX$$a"}
					 
ivs_Coluna_Sumarizada	=	{	"cd_filial", &
									  	"nm_fantasia", &	
										"vl_diferenca", &
									  	"qt_lancamento", &
										"vl_perda", &
									  	"qt_lancto_perda", &
										"vl_sobra", &
									  	"qt_lancto_sobra"}
									 
ivs_Nome_Sumarizado		=	{"Filial", &
										 "Nome Filial", &
										 "Valor Diferen$$HEX1$$e700$$ENDHEX$$a", &
										 "Qtde Total", &
										 "Valor Perda", &
										 "Qtde Perda", &
										 "Valor Sobra", &
										 "Qtde Sobra"}
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge295_relatorio_falta_caixas
integer x = 1938
integer y = 4
integer width = 384
integer height = 216
string dataobject = "dw_ge295_relatorio_sumarizado"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date	lvdt_Inicio, &
		lvdt_Termino
		
Long lvl_Linhas
		  
dw_1.AcceptText()

lvl_Linhas = dw_3.RowCount()
lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

If lvl_Linhas > 0 Then	
	dw_3.Object.Periodo.Text = String(lvdt_Inicio, "DD/MM/YYYY") + " $$HEX1$$e000$$ENDHEX$$ " + String(lvdt_Termino, "DD/MM/YYYY")
End If

Return lvl_Linhas
end event

