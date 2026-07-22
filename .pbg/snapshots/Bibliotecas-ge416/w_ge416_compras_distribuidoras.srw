HA$PBExportHeader$w_ge416_compras_distribuidoras.srw
forward
global type w_ge416_compras_distribuidoras from dc_w_selecao_lista_relatorio
end type
type cb_detalhes from commandbutton within w_ge416_compras_distribuidoras
end type
end forward

global type w_ge416_compras_distribuidoras from dc_w_selecao_lista_relatorio
integer width = 3630
integer height = 1980
string title = "GE416 - Compras de Distribuidoras por Filial"
cb_detalhes cb_detalhes
end type
global w_ge416_compras_distribuidoras w_ge416_compras_distribuidoras

type variables
String ivs_filiais, ivs_nulo
Long lvl_lojas

uo_filial             ivo_filial
uo_fornecedor ivo_fornecedor
boolean ivb_lista_distribuidora_ec






end variables

forward prototypes
public function string wf_nome_distribuidora ()
public subroutine wf_insere_distribuidora_todas ()
public subroutine wf_ajusta_janela (string ps_tipo_relatorio)
public subroutine wf_atualiza_item_nf_compra_grupo (date adt_inicio, date adt_termino, string as_fornecedor)
public subroutine wf_atualiza_item_nf_compra_distr (date adt_inicio, date adt_termino, long al_filial, string as_fornecedor, string al_filiais)
public subroutine wf_atualiza_item_nf_compra (date adt_inicio, date adt_termino, long al_filial, string as_fornecedor, string al_filiais)
end prototypes

public function string wf_nome_distribuidora ();String lvs_Codigo, &
		 lvs_Nome

DataWindowChild lvdwc
	  
If dw_1.GetChild("cd_distribuidora", lvdwc) <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do nome da distribuidora.", Information!)
Else
	lvs_Codigo = lvdwc.GetItemString(lvdwc.GetRow(), "cd_fornecedor")			
	lvs_Nome   = lvdwc.GetItemString(lvdwc.GetRow(), "nm_fantasia")			
	
	If lvs_Codigo <> "000000000" Then
		lvs_Nome += " (" + lvs_Codigo + ")"
	End If
End If

Return lvs_Nome
end function

public subroutine wf_insere_distribuidora_todas ();Integer lvi_Retorno, &
        lvi_Linha

DataWindowChild lvdwc

lvi_Retorno = dw_1.GetChild("cd_distribuidora", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_fornecedor", "000000000")
		lvdwc.SetItem(lvi_Linha, "nm_fantasia"  , "TODAS")
		
		dw_1.Object.Cd_Distribuidora[1] = "000000000"
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da distribuidora 'TODAS'.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.", StopSign!)
End If
end subroutine

public subroutine wf_ajusta_janela (string ps_tipo_relatorio);cb_detalhes.Visible = False

Choose Case ps_tipo_relatorio 
	Case "F"
		gb_1.Height = 484   				//412
		dw_1.Height = 424  				//340
		This.Width  = 3700
					
		gb_2.Width  = 3550   			//3550
		gb_2.Height = 1252				//1282
		gb_2.Y      = 516					//416
		dw_2.Width  =   3510  		//3510
		dw_2.Height =   1172  		//1206
		dw_2.Y      = 572   			/// 472
		
		dw_1.Object.Cd_Filial.Visible = True
		dw_1.Object.Nm_Filial.Visible = True
		dw_1.Object.St_Filial.Visible = True
		
		dw_2.of_ChangeDataObject("dw_ge416_lista")
		dw_3.of_ChangeDataObject("dw_ge416_relatorio")
		
	Case "D"
		gb_1.Height = 484				///412
		dw_1.Height = 424			//340
		This.Width  = 3617
					
		gb_2.Width  = 3502			//3547
		gb_2.Height = 1252			//1284
		gb_2.Y      = 516				//416
		
		dw_2.Width  = 3461			//3497
		dw_2.Height = 1172			//1208
		dw_2.Y      = 572				//468
		
		dw_1.Object.Cd_Filial.Visible = True
		dw_1.Object.Nm_Filial.Visible = True
		dw_1.Object.St_Filial.Visible = True
		
		dw_2.of_ChangeDataObject("dw_ge416_lista_distribuidora")
		dw_3.of_ChangeDataObject("dw_ge416_relatorio_distribuidora")

	Case "G"
		gb_1.Height = 340
		dw_1.Height = 268
		This.Width  = 3318
					
		gb_2.Width  = 3241
		gb_2.Height = 1348
		gb_2.Y      = 344
		dw_2.Width  = 3195
		dw_2.Height = 1272
		dw_2.Y      = 400
		
		dw_1.Object.Cd_Filial.Visible = False
		dw_1.Object.Nm_Filial.Visible = False
		dw_1.Object.St_Filial.Visible = False
		
		dw_2.of_ChangeDataObject("dw_ge416_lista_grupo")
		dw_3.of_ChangeDataObject("dw_ge416_relatorio_grupo")
		dw_2.Object.Cd_Grupo.Visible = False

End Choose
end subroutine

public subroutine wf_atualiza_item_nf_compra_grupo (date adt_inicio, date adt_termino, string as_fornecedor);Long lvl_Total, &
     lvl_Contador, &
     lvl_Linha

Decimal lvdc_Bruto, &
        lvdc_Liquido, &
		  lvdc_Vl_Desconto, &
		  lvdc_Pc_Desconto
		  
String lvs_Grupo

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge416_item_nf_compra_grupo") Then
	Destroy(lvds_1)
	Return
End If

If as_Fornecedor <> "000000000" Then
	lvds_1.of_AppendWhere("n.cd_fornecedor = '" + as_Fornecedor + "'")
End If

Open(w_Aguarde)
w_Aguarde.Title = "Verificando os Valores Brutos..."

lvl_Total = lvds_1.Retrieve(adt_Inicio, adt_Termino)

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvs_Grupo  = lvds_1.Object.Cd_Grupo[lvl_Contador]
		lvdc_Bruto = lvds_1.Object.Vl_Bruto [lvl_Contador]
		
		//If lvdc_Bruto > 0 Then
			lvl_Linha = dw_2.Find("cd_grupo = '" + lvs_Grupo + "'", 1, dw_2.RowCount())
			
			If lvl_Linha < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do grupo para atualiza$$HEX2$$e700e300$$ENDHEX$$o do valor bruto.", StopSign!)
				Exit
			End If
			
			If lvl_Linha > 0 Then
				lvdc_Liquido = dw_2.Object.Vl_Liquido[lvl_Linha]
				lvdc_Vl_Desconto = lvdc_Bruto - lvdc_Liquido
				lvdc_Pc_Desconto = Round(lvdc_Vl_Desconto / lvdc_Bruto * 100, 2)
				
			     // Valida$$HEX2$$e700e300$$ENDHEX$$o para n$$HEX1$$e300$$ENDHEX$$o assumir valores negativos como desconto, devido a casas decimais			
			    If  lvdc_Pc_Desconto<=5  then 		  
				    lvdc_Vl_Desconto = 0
 				    dw_2.Object.Vl_Liquido[lvl_Linha] =lvdc_Bruto
		   	    End If 	
			
			
			
				If IsNull(lvdc_Bruto)  		Then lvdc_Bruto   	  = 0
				If IsNull(lvdc_Pc_Desconto) Then lvdc_Pc_Desconto = 0
				If IsNull(lvdc_Vl_Desconto) Then lvdc_Vl_Desconto = 0
				If IsNull(lvdc_Liquido) 	Then lvdc_Liquido 	  = 0
				
				
				dw_2.Object.Vl_Bruto   [lvl_Linha] = lvdc_Bruto
				dw_2.Object.Vl_Desconto[lvl_Linha] = lvdc_Vl_Desconto
				dw_2.Object.Pc_Desconto[lvl_Linha] = lvdc_Pc_Desconto
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Grupo '" + lvs_Grupo + "' n$$HEX1$$e300$$ENDHEX$$o localizado para atualiza$$HEX2$$e700e300$$ENDHEX$$o do valor bruto.", StopSign!)
				Exit
			End If
		//End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	dw_2.GroupCalc()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valores brutos n$$HEX1$$e300$$ENDHEX$$o localizados.", StopSign!)
End If

Destroy(lvds_1)
Close(w_Aguarde)
end subroutine

public subroutine wf_atualiza_item_nf_compra_distr (date adt_inicio, date adt_termino, long al_filial, string as_fornecedor, string al_filiais);Long lvl_Total, &
     lvl_Contador, &
     lvl_Linha,&
	lvl_cd  
	  
Decimal lvdc_Bruto, &
        lvdc_Liquido, &
		lvdc_Vl_Desconto, &
		lvdc_Pc_Desconto
		
String lvs_Fornecedor
		
dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
// Para ver se tem o Dep$$HEX1$$f300$$ENDHEX$$sito na variavel
lvl_cd = pos("534",al_Filiais)

If Not lvds_1.of_ChangeDataObject("dw_ge416_item_nf_compra_distr") Then
	Destroy(lvds_1)
	Return
End If

If  (Not IsNull(al_Filial) and al_Filial <> 0)  or (Not IsNull(al_Filiais)   and al_Filiais <>'' ) Then 
	// Se a apresenta$$HEX2$$e700e300$$ENDHEX$$o for por distribuidora e a filial n$$HEX1$$e300$$ENDHEX$$o for o estoque central
	// vai considerar as transfer$$HEX1$$ea00$$ENDHEX$$ncias do estoque central como se fosse uma distribuidora
	If (al_Filial <> 534 and IsNull(as_Fornecedor)) or (al_Filial <> 534 and as_Fornecedor = '053404705')   or  (lvl_cd =0 and as_Fornecedor = '053404705')  or (lvl_cd=0 and IsNull(as_Fornecedor))    Then
		If Not lvds_1.of_ChangeDataObject("dw_ge416_item_nf_compra_distr_ec") Then
			Destroy(lvds_1)
			Return
		End If
		
		If Not IsNull(al_Filial) and al_Filial <> 0 Then    
			lvds_1.of_AppendWhere("n.cd_filial = " + String(al_Filial), 1)
			lvds_1.of_AppendWhere("n.cd_filial_destino = " + String(al_Filial), 2)
		End If
		
		If Not IsNull(al_Filiais) and al_Filiais<>'' Then
			lvds_1.of_AppendWhere("n.cd_filial in (" + al_Filiais + ")", 1)
			lvds_1.of_AppendWhere("n.cd_filial_destino in (" + al_Filiais +")", 2)
		End If
				
		
		// Como a DW possui union, sendo o primeiro com nf_compra e o segundo nf_transferencia,
		// nunca vai existir nf_compra do fornecedor 053404705 (isso foi feito para n$$HEX1$$e300$$ENDHEX$$o precisar ter uma DW s$$HEX1$$f300$$ENDHEX$$ de nf_transferncia)
		If  ( al_Filial <> 534 and as_Fornecedor = '053404705') or  (lvl_cd =0 and as_Fornecedor = '053404705')      Then
			lvds_1.of_AppendWhere("n.cd_fornecedor = '053404705'", 1)
		End If
	Else
		lvds_1.of_AppendWhere("n.cd_filial = " + String(al_Filial))
		
		
		
		
		If Not IsNull(as_Fornecedor) Then
			lvds_1.of_AppendWhere("n.cd_fornecedor = '" + as_Fornecedor + "'")
		End If
	End If
Else
	If Not IsNull(as_Fornecedor) Then
		If as_Fornecedor <> '053404705' Then
			lvds_1.of_AppendWhere("n.cd_fornecedor = '" + as_Fornecedor + "'")
		Else
			If Not lvds_1.of_ChangeDataObject("dw_ge416_item_nf_compra_distr_ec") Then
				Destroy(lvds_1)
				Return
			End If
			
			lvds_1.of_AppendWhere("n.cd_fornecedor = '" + as_Fornecedor + "'", 1)
		End If
	End If
End If


Open(w_Aguarde)
w_Aguarde.Title = "Verificando os Valores Brutos..."

lvl_Total = lvds_1.Retrieve(adt_Inicio, adt_Termino)

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvs_Fornecedor = lvds_1.Object.Cd_fornecedor[lvl_Contador]
		lvdc_Bruto 	   = lvds_1.Object.Vl_Bruto 	[lvl_Contador]
		
		lvl_Linha = dw_2.Find("cd_fornecedor = '" + lvs_Fornecedor + "'", 1, dw_2.RowCount())
		
		If lvl_Linha < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial para atualiza$$HEX2$$e700e300$$ENDHEX$$o do valor bruto.", StopSign!)
			Exit
		End If
	
		If lvl_Linha > 0 Then
		   lvdc_Liquido = dw_2.Object.Vl_Liquido[lvl_Linha]
		   lvdc_Vl_Desconto = lvdc_Bruto - lvdc_Liquido			
		   lvdc_Pc_Desconto = Round(lvdc_Vl_Desconto / lvdc_Bruto * 100, 2)
				
	       // Valida$$HEX2$$e700e300$$ENDHEX$$o para n$$HEX1$$e300$$ENDHEX$$o assumir valores negativos como desconto, devido a casas decimais				
 	       If  lvdc_Pc_Desconto<=5  then 
			  lvdc_Vl_Desconto = 0
 			  dw_2.Object.Vl_Liquido[lvl_Linha] =lvdc_Bruto
		   End If 	
			
			
		  If IsNull(lvdc_Bruto)  		Then lvdc_Bruto   	  = 0
		  If IsNull(lvdc_Pc_Desconto) Then lvdc_Pc_Desconto = 0
		  If IsNull(lvdc_Vl_Desconto) Then lvdc_Vl_Desconto = 0
		  If IsNull(lvdc_Liquido) 	Then lvdc_Liquido 	  = 0
			
		  dw_2.Object.Vl_Bruto   [lvl_Linha] = lvdc_Bruto
		  dw_2.Object.Vl_Desconto[lvl_Linha] = lvdc_Vl_Desconto
		  dw_2.Object.Pc_Desconto[lvl_Linha] = lvdc_Pc_Desconto
			
		   If IsNull(dw_2.Object.vl_liquido [lvl_Linha]) Then dw_2.Object.vl_liquido [lvl_Linha] = 0
		   If IsNull(dw_2.Object.vl_icms_st [lvl_Linha]) Then dw_2.Object.vl_icms_st [lvl_Linha] = 0
		   If IsNull(dw_2.Object.vl_total_nf[lvl_Linha]) Then dw_2.Object.vl_total_nf[lvl_Linha] = 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor '" + lvs_Fornecedor + "' n$$HEX1$$e300$$ENDHEX$$o localizada para atualiza$$HEX2$$e700e300$$ENDHEX$$o do valor bruto.", StopSign!)
			Exit
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
		
	dw_2.GroupCalc()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valores brutos n$$HEX1$$e300$$ENDHEX$$o localizados.", StopSign!)
End If

Destroy(lvds_1)
Close(w_Aguarde)
end subroutine

public subroutine wf_atualiza_item_nf_compra (date adt_inicio, date adt_termino, long al_filial, string as_fornecedor, string al_filiais);Long lvl_Total, &
     lvl_Contador, &
     lvl_Linha, &
	  lvl_Filial

Decimal lvdc_Bruto, &
        lvdc_Liquido, &
		  lvdc_Vl_Desconto, &
		  lvdc_Pc_Desconto


dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge416_item_nf_compra") Then
	Destroy(lvds_1)
	Return
End If

If Not IsNull(al_Filial) and al_Filial <> 0 Then
	lvds_1.of_AppendWhere("n.cd_filial = " + String(al_Filial))
End If

If Not IsNull(al_Filiais) and al_Filiais <> ''   Then
	lvds_1.of_AppendWhere("n.cd_filial in (" + al_Filiais + ")")
End If



If as_Fornecedor <> "000000000" Then
	lvds_1.of_AppendWhere("n.cd_fornecedor = '" + as_Fornecedor + "'")
End If

Open(w_Aguarde)
w_Aguarde.Title = "Verificando os Valores Brutos..."

lvl_Total = lvds_1.Retrieve(adt_Inicio, adt_Termino)

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Filial = lvds_1.Object.Cd_Filial[lvl_Contador]
		lvdc_Bruto = lvds_1.Object.Vl_Bruto [lvl_Contador]
		
		//If lvdc_Bruto > 0 Then
			lvl_Linha = dw_2.Find("cd_filial = " + String(lvl_Filial), 1, dw_2.RowCount())
			
			If lvl_Linha < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial para atualiza$$HEX2$$e700e300$$ENDHEX$$o do valor bruto.", StopSign!)
				Exit
			End If
			
			If lvl_Linha > 0 Then		 
				lvdc_Liquido = dw_2.Object.Vl_Liquido[lvl_Linha]
				lvdc_Vl_Desconto = lvdc_Bruto - lvdc_Liquido			
				lvdc_Pc_Desconto = Round(lvdc_Vl_Desconto / lvdc_Bruto * 100, 2)
			 
			     // Valida$$HEX2$$e700e300$$ENDHEX$$o para n$$HEX1$$e300$$ENDHEX$$o assumir valores negativos como desconto, devido a casas decimais
			     If  lvdc_Pc_Desconto<=5  then   
				    lvdc_Vl_Desconto = 0
 				    dw_2.Object.Vl_Liquido[lvl_Linha] =lvdc_Bruto
			    End If 	
			
				
				dw_2.Object.Vl_Bruto   [lvl_Linha] = lvdc_Bruto
				dw_2.Object.Vl_Desconto[lvl_Linha] = lvdc_Vl_Desconto
				dw_2.Object.Pc_Desconto[lvl_Linha] = lvdc_Pc_Desconto
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(lvl_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o localizada para atualiza$$HEX2$$e700e300$$ENDHEX$$o do valor bruto.", StopSign!)
				Exit
			End If
		//End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	dw_2.GroupCalc()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valores brutos n$$HEX1$$e300$$ENDHEX$$o localizados.", StopSign!)
End If

Destroy(lvds_1)
Close(w_Aguarde)
end subroutine

on w_ge416_compras_distribuidoras.create
int iCurrent
call super::create
this.cb_detalhes=create cb_detalhes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_detalhes
end on

on w_ge416_compras_distribuidoras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_detalhes)
end on

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Fornecedor)
end event

event ue_postopen;call super::ue_postopen;ivo_Filial 	   = Create uo_Filial
ivo_Fornecedor = Create uo_Fornecedor


dw_1.Object.Dt_Inicio [1] = Today()
dw_1.Object.Dt_Termino[1] = Today()

//wf_Insere_Distribuidora_Todas()
wf_Ajusta_Janela("F")

This.ivm_Menu.ivb_Permite_Imprimir = True
This.ivm_Menu.mf_SalvarComo(True) 
//dw_3.Visible = True
end event

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino
	    
String lvs_Distribuidora,&
	   lvs_RazaoSocial,&
	   lvs_Grupo
	   
Long lvl_Linha,&
	 lvl_Linhas

dw_1.AcceptText()

lvdt_Inicio  	  = dw_1.Object.Dt_Inicio      [1]
lvdt_Termino 	  = dw_1.Object.Dt_Termino     [1]
lvs_Distribuidora = dw_1.Object.cd_fornecedor  [1]
lvs_RazaoSocial   = dw_1.Object.nm_fornecedor  [1]

dw_3.Object.Cabecalho_Periodo.text = String(lvdt_Inicio, "dd/mm/yyyy") + "  at$$HEX1$$e900$$ENDHEX$$  " + String(lvdt_Termino, "dd/mm/yyyy")

If IsNull(lvs_Distribuidora) Then 
	dw_3.Object.Cabecalho_Distribuidora.text = 'TODAS'
Else
	dw_3.Object.Cabecalho_Distribuidora.text = lvs_RazaoSocial + " (" + lvs_Distribuidora + ")"
End If

If ivb_Lista_Distribuidora_EC Then
	
	lvl_Linhas = dw_2.RowCount()
	
	For lvl_Linha = 1 To lvl_Linhas 
		
		lvs_Grupo = dw_2.Object.grupo[lvl_Linha]
		
		If lvs_Grupo = "1" Then
			dw_3.Object.Vl_Total_Bruto_1.Text    = String(dw_2.Object.Vl_Total_Bruto   [lvl_Linha], "0,000.00")
			dw_3.Object.Vl_Total_Desconto_1.Text = String(dw_2.Object.Vl_Total_Desconto[lvl_Linha], "0,000.00")
			dw_3.Object.Pc_Total_Desconto_1.Text = String(dw_2.Object.Pc_Total_Desconto[lvl_Linha], "0.00")
		ElseIf lvs_Grupo = "2" Then
			dw_3.Object.Vl_Total_Bruto_2.Text 	 = String(dw_2.Object.Vl_Total_Bruto   [lvl_Linha], "0,000.00")
			dw_3.Object.Vl_Total_Desconto_2.Text = String(dw_2.Object.Vl_Total_Desconto[lvl_Linha], "0,000.00")
			dw_3.Object.Pc_Total_Desconto_2.Text = String(dw_2.Object.Pc_Total_Desconto[lvl_Linha], "0.00")
		End If
	Next

	dw_3.Object.Vl_Total_Bruto_Total.Text    = String(dw_2.Object.Vl_Total_Bruto_Total   [1], "0,000.00")
	dw_3.Object.Vl_Total_Desconto_Total.Text = String(dw_2.Object.Vl_Total_Desconto_Total[1], "0,000.00")
	dw_3.Object.Pc_Total_Desconto_Total.Text = String(dw_2.Object.Pc_Total_Desconto_Total[1], "0.00")
Else
	dw_3.Object.Vl_Total_Bruto.Text    = String(dw_2.Object.Vl_Total_Bruto   [1], "0,000.00")
	dw_3.Object.Vl_Total_Desconto.Text = String(dw_2.Object.Vl_Total_Desconto[1], "0,000.00")
	dw_3.Object.Pc_Total_Desconto.Text = String(dw_2.Object.Pc_Total_Desconto[1], "0.00")
End If

Return AncestorReturnValue

end event

event ue_saveas;This.ivm_Menu.mf_SalvarComo(True) 
dw_2.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge416_compras_distribuidoras
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge416_compras_distribuidoras
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge416_compras_distribuidoras
integer x = 14
integer y = 516
integer width = 3534
integer height = 1252
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge416_compras_distribuidoras
integer x = 14
integer y = 4
integer width = 2007
integer height = 484
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge416_compras_distribuidoras
integer x = 41
integer y = 60
integer width = 1957
integer height = 424
string dataobject = "dw_ge416_selecao_new"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "id_filial_grupo"
		
		Choose Case Data
			Case "F"
				wf_Ajusta_Janela("F")
			Case "G"
				wf_Ajusta_Janela("G")
			Case "D"
				wf_Ajusta_Janela("D")
		End Choose
End Choose

If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
		This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
	End If	
End If

If dwo.Name = "nm_fornecedor" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
	End If
End If



If dwo.Name = "id_filial" Then		

		If Data = 'C' Then
			
			ivo_Filial.of_Inicializa()
			
			This.Object.cd_Filial[1] = ivo_Filial.cd_filial
			This.Object.nm_Filial[1] = ivo_Filial.nm_fantasia
					
			ivs_filiais = ivs_nulo 
			
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
			
		End If

End If

end event

event dw_1::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
	End If
	
	If This.GetColumnName() = "nm_fornecedor" Then
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge416_compras_distribuidoras
integer x = 32
integer y = 572
integer width = 3479
integer height = 1164
string dataobject = "dw_ge416_lista"
end type

event dw_2::ue_recuperar;// Override

Long lvl_Filial, &
     lvl_Total,&
     lvl_cd

String lvs_Fornecedor,&
	   lvs_Tipo,&
	   lvs_Filial
   	   

Date lvdt_Inicio, &
     lvdt_Termino
	  
dw_1.AcceptText()

lvl_Filial     = dw_1.Object.Cd_Filial      [1]
lvs_Fornecedor = dw_1.Object.Cd_Fornecedor  [1]
lvdt_Inicio    = dw_1.Object.Dt_Inicio      [1]
lvdt_Termino   = dw_1.Object.Dt_Termino     [1]
lvs_Tipo	   = dw_1.Object.Id_Filial_Grupo[1]
lvs_Filial = dw_1.Object.Id_Filial[1]

// Para ver se tem o Dep$$HEX1$$f300$$ENDHEX$$sito na variavel
lvl_cd = pos("534",ivs_filiais)

ivb_Lista_Distribuidora_ec = False

If lvs_Tipo = "D" Then
	
	dw_2.of_ChangeDataObject("dw_ge416_lista_distribuidora")
	dw_3.of_ChangeDataObject("dw_ge416_relatorio_distribuidora")
	
	If Not IsNull(lvl_Filial) and lvl_Filial <> 0 or lvs_Filial='C' Then
		// Se a apresenta$$HEX2$$e700e300$$ENDHEX$$o for por distribuidora e a filial n$$HEX1$$e300$$ENDHEX$$o for o estoque central
		// vai considerar as transfer$$HEX1$$ea00$$ENDHEX$$ncias do estoque central como se fosse uma distribuidora
		If (lvl_Filial <> 534  and IsNull(lvs_Fornecedor)) or (lvl_Filial <> 534  and lvs_Fornecedor = '053404705')   or (lvl_cd=0   and IsNull(lvs_Fornecedor))   or   (lvl_cd=0 and lvs_Fornecedor = '053404705' )      Then
			If Not This.of_ChangeDataObject("dw_ge416_lista_distribuidora_ec") Then
				Return -1
			End If
			
			If Not dw_3.of_ChangeDataObject("dw_ge416_relatorio_distribuidora_ec") Then
				Return -1
			End If
			
			ivb_Lista_Distribuidora_EC = True
			
			//This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial), 1)
			//This.of_AppendWhere("n.cd_filial_destino = " + String(lvl_Filial), 2)
			
			/// Adicionado para Filtro de Grupo de Filiais/Cidade/Estado/Rede
			If lvs_Filial = 'C' Then
				If Not IsNull(ivs_Filiais) and ivs_Filiais <> '' Then
					This.of_AppendWhere("n.cd_filial in (" + ivs_Filiais + ")", 1)
					This.of_AppendWhere("n.cd_filial_destino in (" + ivs_Filiais +")", 2)
				End If
			End If 

			// Filtro apenas de uma Loja
			If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
			    This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial), 1)
				This.of_AppendWhere("n.cd_filial_destino = " + String(lvl_Filial), 2)
			End If
					
			
			
			// Como a DW possui union, sendo o primeiro com nf_compra e o segundo nf_transferencia,
			// nunca vai existir nf_compra do fornecedor 053404705 (isso foi feito para n$$HEX1$$e300$$ENDHEX$$o precisar ter uma DW s$$HEX1$$f300$$ENDHEX$$ de nf_transferncia)
			If lvl_Filial <> 534   and lvs_Fornecedor = '053404705' Then
				This.of_AppendWhere("n.cd_fornecedor = '053404705'", 1)
			End If
		Else
			This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial))
			
			If Not IsNull(lvs_Fornecedor) Then
				This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'")
			End If
		End If
	Else
		If Not IsNull(lvs_Fornecedor) Then
			If lvs_Fornecedor <> '053404705' Then
				This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 1)
			Else
				If Not This.of_ChangeDataObject("dw_ge416_lista_distribuidora_ec") Then
					Return -1
				End If
				
				If Not dw_3.of_ChangeDataObject("dw_ge416_relatorio_distribuidora_ec") Then
					Return -1
				End If
			
				ivb_Lista_Distribuidora_EC = True
				
				This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 1)		
			End If
		End If
	End If
Else

	/// Adicionado para Filtro de Grupo de Filiais/Cidade/Estado/Rede
	If lvs_Filial = 'C' Then
		If Not IsNull(ivs_Filiais) and ivs_Filiais <> '' Then
			This.of_AppendWhere("n.cd_filial in (" + ivs_Filiais + ")")
		End If
	End If 
	
	If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
			This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial))
	End If
	

	If Not IsNull(lvs_Fornecedor) Then
		This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'")
	End If
End If

lvl_Total = This.Retrieve(lvdt_Inicio, lvdt_Termino)

If lvl_Total > 0 Then
	This.ShareData(dw_3)
	Choose Case lvs_Tipo
		Case "F"
			// Adicionado Grupo de Filiais na fun$$HEX2$$e700e300$$ENDHEX$$o
			wf_Atualiza_Item_NF_Compra(lvdt_Inicio, lvdt_Termino, lvl_Filial, lvs_Fornecedor, ivs_Filiais )
		Case "G"
			wf_Atualiza_Item_NF_Compra_Grupo(lvdt_Inicio, lvdt_Termino, lvs_Fornecedor)
		Case "D"
			cb_detalhes.Visible = True
			// Adicionado Grupo de Filiais na fun$$HEX2$$e700e300$$ENDHEX$$o
			wf_atualiza_item_nf_compra_distr(lvdt_Inicio, lvdt_Termino, lvl_Filial, lvs_Fornecedor, ivs_Filiais)
	End Choose			
End If

Return lvl_Total
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.of_SetRowSelection()
This.ivm_Menu.mf_SalvarComo(True) 
Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge416_compras_distribuidoras
integer x = 2551
integer y = 20
integer width = 923
integer height = 208
integer taborder = 50
string dataobject = "dw_ge416_relatorio"
end type

type cb_detalhes from commandbutton within w_ge416_compras_distribuidoras
boolean visible = false
integer x = 2825
integer y = 308
integer width = 727
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Detalhes Fornecedor"
end type

event clicked;Date lvdt_Inicio,&
	 lvdt_Termino
	 
Long lvl_Linha,&
	 lvl_Filial
	 
String lvs_Fornecedor,&
	   lvs_Parametro
	 
dw_1.AcceptText()
dw_2.AcceptText()

lvl_Linha = dw_2.GetRow()

lvdt_Inicio  = dw_1.Object.dt_inicio [1]
lvdt_Termino = dw_1.Object.dt_termino[1]
lvl_Filial	 = dw_1.Object.cd_filial [1]

If IsNull(lvl_Filial) Then lvl_Filial = 0

If lvl_Linha > 0 Then
	
	lvs_Fornecedor = dw_2.Object.cd_fornecedor[lvl_Linha]
	
	lvs_Parametro = String(lvdt_Inicio, "dd/mm/yyyy") + String(lvdt_Termino, "dd/mm/yyyy") +&
				    String(lvl_Filial, "0000") + lvs_Fornecedor
					
	OpenWithParm(w_ge416_compras_distribuidoras_detalhes, lvs_Parametro)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha para visualizar os detalhes.")
End If


end event

