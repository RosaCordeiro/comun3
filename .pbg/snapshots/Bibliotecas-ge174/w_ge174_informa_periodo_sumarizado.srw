HA$PBExportHeader$w_ge174_informa_periodo_sumarizado.srw
forward
global type w_ge174_informa_periodo_sumarizado from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge174_informa_periodo_sumarizado
end type
end forward

global type w_ge174_informa_periodo_sumarizado from dc_w_response_ok_cancela
integer width = 1239
integer height = 416
string title = "GE174 - Gera Relat$$HEX1$$f300$$ENDHEX$$rio Sumarizado"
dw_2 dw_2
end type
global w_ge174_informa_periodo_sumarizado w_ge174_informa_periodo_sumarizado

type variables
st_parametros_sumarizado str
end variables

forward prototypes
public function boolean wf_gera_relatorio ()
end prototypes

public function boolean wf_gera_relatorio ();Boolean lvb_Sucesso = True

Date	lvdt_Inicio, &
     	lvdt_Termino, &
		 ldt_Inicio_Sum, &
		 ldt_Fim_Sum, &
		 ldt_Periodo
		 	  
Decimal{2} lvdc_Custo, lvdc_Custo_Fil, lvdc_Custo_EC

Integer lvi_Retorno

Long lvl_Linha_DS, lvl_Find, lvl_Insert, lvl_Linha, ll_Mes, ll_Ano

String	lvs_Path,&
	   	lvs_Arquivo,&
		lvs_Lei_Generico,&
		lvs_Fornecedor_DS,&
		lvs_Razao_Social_DS,&
		lvs_Fornecedor_Usual_DS,&
		lvs_Razao_Social_Usual_DS,&
		lvs_Fornecedor_Usual,&
		lvs_Razao_Social_Usual, &
		ls_Cgc, &
		lvs_Diretorio, &
		ls_Nome_Pla
	
dw_1.AcceptText()
	  
lvdt_Inicio		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

lvs_Diretorio = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

SetPointer(HourGlass!)

dc_uo_ds_base ds
ds = Create dc_uo_ds_base

If Not ds.of_ChangeDataObject("dw_ge174_detalhe_excel_sumarizado") Then
	Destroy(ds)
	Return False
End If

Open(w_Aguarde)

Do While lvdt_Inicio <= lvdt_Termino
	
	//Limpa o data store para n$$HEX1$$e300$$ENDHEX$$o acumular os valores
	dw_2.Reset()
	
	ldt_Inicio_Sum	= lvdt_Inicio
	ldt_Fim_Sum	= gf_Retorna_Ultimo_Dia_Mes(ldt_Inicio_Sum)
	
	w_Aguarde.Title = "Gerando per$$HEX1$$ed00$$ENDHEX$$odo '" + String(ldt_Inicio_Sum, "mm/yyyy") + "'. Aguarde..."
	
	If Not IsNull(str.Cd_Fornecedor) and Trim(str.Cd_Fornecedor) <> "" Then
		ds.of_appendwhere_subquery("n.cd_fornecedor = '" + str.Cd_Fornecedor + "'", 1)
		ds.of_appendwhere_subquery("n.cd_fornecedor = '" + str.Cd_Fornecedor + "'", 2)
		ds.of_appendwhere_subquery("n.cd_fornecedor = '" + str.Cd_Fornecedor + "'", 3)
	End If
	
	//Limpa o data store para n$$HEX1$$e300$$ENDHEX$$o acumular os valores
	ds.Reset()
	
	If ds.Retrieve(ldt_Inicio_Sum, ldt_Fim_Sum) = -1 Then
		Close(w_Aguarde)
		Destroy(ds)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es.")
		Return False
	End If
	
	For lvl_Linha_DS	= 1 To ds.RowCount() 
		
		ldt_Periodo						=  ds.Object.Dh_Movimentacao_Caixa[lvl_Linha_DS]
		lvs_Fornecedor_DS 			= 	ds.Object.cd_fornecedor				[lvl_Linha_DS]
		lvs_Razao_Social_DS			= 	ds.Object.nm_razao_social			[lvl_Linha_DS]
		
		lvs_Fornecedor_Usual_DS	= 	ds.Object.cd_fornecedor_usual		[lvl_Linha_DS]
		lvs_Razao_Social_Usual_DS	= 	ds.Object.nm_razao_social_usual	[lvl_Linha_DS]
		ls_Cgc							=  ds.Object.Nr_Cgc						[lvl_Linha_DS]
		
		lvs_Lei_Generico				= 	ds.Object.id_lei_generico			[lvl_Linha_DS]
		
		lvdc_Custo			 			=	ds.Object.vl_valor						[lvl_Linha_DS]
		lvdc_Custo_FIL					=	ds.Object.vl_valor_fil					[lvl_Linha_DS]
		lvdc_Custo_EC					=	ds.Object.vl_valor_ec					[lvl_Linha_DS]
		
		lvl_Find = dw_2.Find("cd_fornecedor = '" + lvs_Fornecedor_DS + "' and cd_fornecedor_usual = '" + lvs_Fornecedor_Usual_DS + "' and id_lei_generico = '" + lvs_Lei_Generico + "'", 1, dw_2.RowCount())
		
		If lvl_Find < 0 Then
			Close(w_Aguarde)
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no FIND ao localizar o fornecedor.")
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Find = 0 Then
			lvl_Insert = dw_2.InsertRow(0)
			
			dw_2.Object.Dh_Movimentacao_Caixa[lvl_Insert] 	= 	ldt_Periodo
			dw_2.Object.cd_fornecedor				[lvl_Insert] 	= 	lvs_Fornecedor_DS
			dw_2.Object.nm_razao_social			[lvl_Insert]	=	lvs_Razao_Social_DS	
			dw_2.Object.cd_fornecedor_usual		[lvl_Insert] 	= 	lvs_Fornecedor_Usual_DS
			dw_2.Object.nm_razao_social_usual	[lvl_Insert] 	= 	lvs_Razao_Social_Usual_DS
			dw_2.Object.Nr_Cgc						[lvl_Insert]	= 	ls_Cgc
			dw_2.Object.id_lei_generico			[lvl_Insert] 	= 	lvs_Lei_Generico
			dw_2.Object.vl_valor						[lvl_Insert]	= 	lvdc_Custo_Fil + lvdc_Custo_EC
			dw_2.Object.vl_valor_fil					[lvl_Insert]	= 	lvdc_Custo_Fil
			dw_2.Object.vl_valor_ec					[lvl_Insert]	= 	lvdc_Custo_ec
		Else		
			dw_2.Object.vl_valor			[lvl_Find]	= dw_2.Object.vl_valor[lvl_Find] + lvdc_Custo_Fil + lvdc_Custo_ec
			dw_2.Object.vl_valor_fil		[lvl_Find]	= dw_2.Object.vl_valor_fil[lvl_Find] + lvdc_Custo_Fil
			dw_2.Object.vl_valor_ec		[lvl_Find]	= dw_2.Object.vl_valor_ec[lvl_Find] + lvdc_Custo_EC
		End If
		
	Next	 
	
	If Not lvb_Sucesso Then
		Return False 
	End If 
	
	dw_2.Sort()
	dw_2.GroupCalc()
		 
	If str.Id_Estoque_Central = 'S' Then	 
			 
		dc_uo_ds_base lvds 
		lvds = Create dc_uo_ds_base
		
		If Not lvds.of_ChangeDataObject("dw_ge174_detalhe_excel_central_sumarizado") Then
			Close(w_Aguarde)
			Destroy(lvds)
			Return False
		End If
		
		//Limpa o data store para n$$HEX1$$e300$$ENDHEX$$o acumular os valores
		lvds.Reset()
		
		lvds.Retrieve(ldt_Inicio_Sum, ldt_Fim_Sum)
				
		For lvl_Linha = 1 To lvds.RowCount()
			
			ldt_Periodo					= lvds.Object.Dh_Movimentacao_Caixa[lvl_Linha]
			lvs_Fornecedor_Usual		= lvds.Object.cd_fornecedor_usual	[lvl_Linha]
			lvs_Razao_Social_Usual 	= lvds.Object.nm_razao_social	  		[lvl_Linha]
			ls_Cgc						= lvds.Object.Nr_Cgc						[lvl_Linha]
			lvdc_Custo 					= lvds.Object.vl_custo		  	  		[lvl_Linha]
			lvs_Lei_Generico			= lvds.Object.id_lei_generico 			[lvl_Linha]
			
			lvl_Insert = dw_2.InsertRow(0)	
					
			dw_2.Object.Dh_Movimentacao_Caixa[lvl_Insert] = ldt_Periodo		
			dw_2.Object.cd_fornecedor    			[lvl_Insert] = '53404705'
			dw_2.Object.nm_razao_social         	[lvl_Insert] = 'ESTOQUE CENTRAL'
			dw_2.Object.cd_fornecedor_usual     	[lvl_Insert] = lvs_Fornecedor_usual
			dw_2.Object.nm_razao_social_usual	[lvl_Insert] = lvs_Razao_Social_Usual
			dw_2.Object.Nr_Cgc						[lvl_Insert] = ls_Cgc
			dw_2.Object.id_lei_generico            	[lvl_Insert] = lvs_Lei_Generico
			dw_2.Object.vl_valor	   	              	[lvl_Insert] = lvdc_Custo
			dw_2.Object.vl_valor_fil 	              	[lvl_Insert] = lvdc_Custo
			dw_2.Object.vl_valor_ec 	             	[lvl_Insert] = 0.00
			
		Next
			
		Destroy(lvds)
		
	End If
	
	ls_Nome_Pla = gf_Replace(String(ldt_Inicio_Sum), "/", "_", 2)
	ls_Nome_Pla += " a " + gf_Replace(String(ldt_Fim_Sum), "/", "_", 2)
	
	If dw_2.RowCount() > 0 Then
		lvs_Arquivo = lvs_Diretorio + "Compras Sumarizadas por Fornecedor por Mes de " + ls_Nome_Pla + ".xls"
		
		If dw_2.SaveAs(lvs_Arquivo, Excel!, True) <> 1 Then
			Close(w_Aguarde)
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no saveas da planilha '" + lvs_Arquivo + "'.", StopSign!)
			Return False
		End If
	End If
	
	ll_Mes = Month(lvdt_Inicio)
	ll_Ano = Year(lvdt_Inicio)
	
	If ll_Mes >= 12 Then
		ll_Ano++
		ll_Mes = 1
	Else
		ll_Mes++
	End If
	
	lvdt_Inicio = Date("01/" + String(ll_Mes) + "/" + String(ll_Ano))
Loop

Close(w_Aguarde)

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivos gerados com sucesso em '" + lvs_Diretorio + "'.")
	
SetPointer(Arrow!)

Destroy(ds)

Close(This)

Return True
end function

on w_ge174_informa_periodo_sumarizado.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_ge174_informa_periodo_sumarizado.destroy
call super::destroy
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;Date ldt_Periodo

dw_1.AcceptText()

ldt_Periodo = Date(gf_GetServerDate())

dw_1.Object.Dt_Inicio		[1] = Date("01/" + String(ldt_Periodo, "mm/yyyy"))
dw_1.Object.Dt_Termino	[1] = Date("01/" + String(ldt_Periodo, "mm/yyyy"))

str = Message.PowerObjectParm
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge174_informa_periodo_sumarizado
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge174_informa_periodo_sumarizado
integer x = 27
integer width = 1143
integer height = 172
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge174_informa_periodo_sumarizado
integer width = 1097
integer height = 92
string dataobject = "dw_ge174_informa_periodo_sumarizado"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge174_informa_periodo_sumarizado
integer x = 530
integer y = 200
end type

event cb_ok::clicked;call super::clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio?", Question!, YesNo!, 2) = 2 Then
	Return -1
End If

dw_1.AcceptText()

If dw_1.Object.Dt_Inicio[1] > dw_1.Object.Dt_Termino[1] Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(dw_1.Object.Dt_Inicio[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser nula.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(dw_1.Object.Dt_Termino[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino n$$HEX1$$e300$$ENDHEX$$o pode ser nula.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If dw_1.Object.Dt_Termino[1] > Date(gf_GetServerDate()) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino pode ser maior do que a data corrente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1	
End If

If Not wf_Gera_Relatorio() Then
	Return -1
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge174_informa_periodo_sumarizado
integer x = 864
integer y = 200
end type

type dw_2 from dc_uo_dw_base within w_ge174_informa_periodo_sumarizado
boolean visible = false
integer x = 23
integer y = 120
integer width = 210
integer height = 160
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_ge174_detalhe_excel_sumarizado"
end type

