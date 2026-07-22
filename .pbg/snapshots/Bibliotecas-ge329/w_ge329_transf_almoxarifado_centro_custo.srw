HA$PBExportHeader$w_ge329_transf_almoxarifado_centro_custo.srw
forward
global type w_ge329_transf_almoxarifado_centro_custo from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge329_transf_almoxarifado_centro_custo from dc_w_selecao_lista_relatorio
integer width = 3168
integer height = 2044
string title = "GE329 - Transfer$$HEX1$$ea00$$ENDHEX$$ncia do Almoxarifado por Departamento"
long backcolor = 80269524
end type
global w_ge329_transf_almoxarifado_centro_custo w_ge329_transf_almoxarifado_centro_custo

type variables
uo_filial ivo_filial

uo_centro_custo ivo_centro_custo

uo_usuario ivo_usuario

uo_produto ivo_produto


end variables

on w_ge329_transf_almoxarifado_centro_custo.create
call super::create
end on

on w_ge329_transf_almoxarifado_centro_custo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio		[1] = gvo_Parametro.of_DH_Movimentacao()
dw_1.Object.dt_termino	[1] = gvo_Parametro.of_DH_Movimentacao()

dw_1.Object.dt_inicio_emi		[1] = dw_1.Object.dt_inicio		[1]
dw_1.Object.dt_termino_emi	[1] = dw_1.Object.dt_termino	[1]

ivo_centro_custo = create uo_centro_custo
ivo_produto = create uo_produto
ivo_usuario = create uo_usuario

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event close;call super::close;Destroy(ivo_Centro_Custo)

Destroy(ivo_Produto)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge329_transf_almoxarifado_centro_custo
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge329_transf_almoxarifado_centro_custo
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge329_transf_almoxarifado_centro_custo
integer x = 18
integer y = 608
integer width = 3099
integer height = 1248
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge329_transf_almoxarifado_centro_custo
integer x = 18
integer y = 12
integer width = 2240
integer height = 588
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge329_transf_almoxarifado_centro_custo
integer x = 55
integer y = 80
integer width = 2176
integer height = 456
string dataobject = "dw_ge329_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna 

dw_1.AcceptText()

lvs_Coluna = dw_1.GetColumnName()

If Key = KeyEnter! Then
	
	If lvs_Coluna = "de_produto" Then
		
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			This.Object.cd_produto[1] = ivo_Produto.cd_produto
			This.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If

	End If 
    	
	If lvs_Coluna = "de_centro_custo" Then
		
		ivo_Centro_Custo.ivb_Centro_Custo = True
		
		ivo_Centro_Custo.of_Localiza_Centro_Custo(This.GetText())
		
		If ivo_Centro_Custo.Localizada Then
			This.Object.cd_centro_custo[1] = ivo_Centro_Custo.cd_centro_custo
			This.Object.de_centro_custo[1] = ivo_Centro_Custo.de_centro_custo
		End If
		
	End If
	If lvs_Coluna = "nm_requisitante" Then
		
		ivo_Usuario.of_Localiza_Usuario(This.GetText())
		
		If ivo_Usuario.Localizado Then
			This.Object.nr_matricula_requisitante	[1] = ivo_Usuario.nr_matricula
			This.Object.nm_requisitante  			[1] = ivo_Usuario.nm_usuario
		End If
		
	End If
	
	
End If

end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Reset()

If dwo.Name = 'de_centro_custo' Then
	If Not IsNull(Data) and Trim(Data) <> '' Then
		If Data <> ivo_Centro_Custo.de_centro_custo Then
			Return 1
		End If
	Else
		ivo_Centro_Custo.of_Inicializa()
		
		This.Object.cd_centro_custo	[1] = ivo_Centro_Custo.cd_centro_custo
		This.Object.de_centro_custo	[1] = ivo_Centro_Custo.de_centro_custo
	End If
End If

If dwo.Name = 'de_produto' Then
	If Not IsNull(Data) and Trim(Data) <> '' Then
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
	Else
		ivo_Produto.of_Inicializa()
		
		This.Object.cd_produto[1] = ivo_Produto.cd_produto
		This.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If

If dwo.Name = 'nm_requisitante' Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Usuario.nm_usuario Then
			Return 1
		End If
	Else
		ivo_Usuario.of_Inicializa()
		
		This.Object.nr_matricula_requisitante	[1] = ivo_Usuario.nr_matricula
		This.Object.nm_requisitante				[1] = ivo_Usuario.nm_usuario
	End If
End If

end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge329_transf_almoxarifado_centro_custo
integer x = 46
integer y = 676
integer width = 3031
integer height = 1164
string dataobject = "dw_ge329_lista"
end type

event dw_2::ue_recuperar;// OverRide

DateTime lvdt_Inicio  ,&
		   	 lvdt_Termino, &
				 lvdt_Inicio_emi,&
				lvdt_Termino_emi 

Long lvl_Filial    ,&
	 lvl_Centro_Custo ,&
	 lvl_de_produto
	 
String lvs_Requisitante,&
	   lvs_DW, lvs_cd_requisitante, lvs_DW_Relatorio
 
dw_1.AcceptText()

lvdt_Inicio 	  			=  dw_1.Object.dt_inicio		    					[1]
lvdt_Termino 	  		=  dw_1.Object.dt_termino	    					[1]
lvl_de_produto    		=  dw_1.object.cd_produto     					[1]
lvl_Centro_Custo  		=  dw_1.Object.cd_centro_custo				[1]
lvs_Requisitante  		=  dw_1.Object.id_requisitante					[1]
lvs_cd_requisitante 	= 	dw_1.Object.nr_matricula_requisitante	[1]
lvdt_Inicio_emi 	 	  	=  dw_1.Object.dt_inicio_emi	    				[1]
lvdt_Termino_emi 	  	=  dw_1.Object.dt_termino_emi 				[1]


If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or lvdt_Termino<lvdt_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If


If IsNull(lvdt_Inicio_emi) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data emissao de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio_emi")
	Return -1
End If

If IsNull(lvdt_Termino_emi) or lvdt_Termino_emi<lvdt_Inicio_emi Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data emissao de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino_emi")
	Return -1
End If


If lvs_Requisitante = 'S' Then
	lvs_DW 			 = "dw_ge329_lista_resiquitante"
	lvs_DW_Relatorio = "dw_ge329_lista_resiquitante_relatorio"
Else
	lvs_DW 				= "dw_ge329_lista"
	lvs_DW_Relatorio 	= "dw_ge329_lista_relatorio"
End If	

If Not dw_2.Of_ChangeDataObject(lvs_DW) Then
	Return -1
End If

If Not dw_3.Of_ChangeDataObject(lvs_DW_Relatorio) Then
	Return -1
End If

This.ShareData(dw_3)

If Not IsNull(lvs_cd_requisitante) Then
	This.of_appendwhere_subquery("nr_matricula_requisitante ='" + String(lvs_cd_requisitante)+"'", 1)
	This.of_appendwhere_subquery("nr_matricula_cadastramento ='" + String(lvs_cd_requisitante)+"'", 2)
End If

If Not IsNull(lvl_de_produto) Then
	This.of_appendwhere_subquery("i.cd_produto = " + String(lvl_de_produto), 1)
	This.of_appendwhere_subquery("i.cd_produto = " + String(lvl_de_produto), 2)
End If

If Not IsNull(lvl_Centro_Custo) Then
	This.of_appendwhere_subquery("n.cd_centro_custo = " + String(lvl_Centro_Custo), 1)
	This.of_appendwhere_subquery("n.cd_centro_custo = " + String(lvl_Centro_Custo), 2)
End If


Return This.Retrieve(lvdt_Inicio, DateTime(RelativeDate(Date(lvdt_Termino),0)),lvdt_Inicio_emi,   DateTime(RelativeDate(Date(lvdt_Termino_emi),0)))

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
Else
	This.ivm_Menu.mf_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge329_transf_almoxarifado_centro_custo
integer x = 64
integer y = 1144
integer width = 672
integer height = 672
integer taborder = 50
string dataobject = "dw_ge329_lista_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;This.Object.st_periodo.Text = String(dw_1.Object.dt_inicio[1],"dd/mm/yyyy") +&
							  ' at$$HEX1$$e900$$ENDHEX$$ ' + String(dw_1.Object.dt_termino[1],"dd/mm/yyyy")

Return 1
end event

