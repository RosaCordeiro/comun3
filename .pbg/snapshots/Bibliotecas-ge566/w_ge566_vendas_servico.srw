HA$PBExportHeader$w_ge566_vendas_servico.srw
forward
global type w_ge566_vendas_servico from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge566_vendas_servico from dc_w_selecao_lista_relatorio
integer width = 3269
integer height = 1808
string title = "GE566 - Consulta Venda de Servi$$HEX1$$e700$$ENDHEX$$os"
end type
global w_ge566_vendas_servico w_ge566_vendas_servico

type variables
Boolean lb_Salvar  = False

String ivs_Servicos

uo_vendedor ivo_vendedor		//GE013


end variables

on w_ge566_vendas_servico.create
call super::create
end on

on w_ge566_vendas_servico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Vendedor 	= Create uo_Vendedor

dw_1.Object.Dt_Inicio [1] = Today()
dw_1.Object.Dt_Termino[1] = Today()

ivm_Menu.mf_Recuperar(True)
This.ivm_Menu.ivb_Permite_Imprimir = True


dw_1.Object.Cd_Filial[1]      	= gvo_Parametro.of_Filial()
dw_1.Object.De_Filial[1]      	= gvo_Parametro.Nm_Fantasia_Filial

end event

event close;call super::close;If IsValid( ivo_Vendedor ) Then Destroy(ivo_Vendedor)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge566_vendas_servico
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge566_vendas_servico
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge566_vendas_servico
integer y = 484
integer width = 3182
integer height = 1132
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge566_vendas_servico
integer width = 2153
integer height = 436
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge566_vendas_servico
integer width = 2085
integer height = 320
string dataobject = "dw_ge566_selecao_venda"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;
Choose Case dwo.Name
		
	Case "nm_usuario" 
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> ivo_Vendedor.Nm_Usuario Then
				Return 1
			End If
		Else
			ivo_Vendedor.of_Inicializa()
			
			dw_1.Object.Nr_Matricula_Vendedor	[1] = ivo_Vendedor.Nr_Matricula_Vendedor
			dw_1.Object.Nm_Usuario				[1] = ivo_Vendedor.Nm_Usuario
		End If

	Case "servicos"
	
		setNull(ivs_Servicos)
		
		If Data = 'C' Then
							
			OpenWithParm(w_ge566_consulta_servico, '')
			
			ivs_Servicos = Message.StringParm
			
			If ivs_Servicos = '' Then
				Data = 'T'
				dw_1.Object.Servicos[1] = 'T'
			End If

		End If
		

End Choose
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

dw_1.AcceptText()

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "nm_usuario"
			
			ivo_vendedor.of_Localiza_Vendedor(This.GetText())
			
			If ivo_Vendedor.Localizado Then
				dw_1.Object.Nr_Matricula_Vendedor	[1] = ivo_Vendedor.Nr_Matricula_Vendedor
				dw_1.Object.Nm_Usuario				[1] = ivo_Vendedor.Nm_Usuario
			End If
					
	End Choose
	
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge566_vendas_servico
integer y = 556
integer width = 3113
integer height = 1020
string title = "Consulta de Vendas por Servi$$HEX1$$e700$$ENDHEX$$o"
string dataobject = "dw_ge566_lista_venda"
boolean hscrollbar = true
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Max

lvl_Max = dw_2.RowCount()

If (lvl_Max >0) Then
	Parent.ivm_Menu.mf_Imprimir(True)
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	Parent.ivm_Menu.mf_Imprimir(False)
	This.ivo_Controle_Menu.of_SalvarComo(False)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma venda localizada neste per$$HEX1$$ed00$$ENDHEX$$odo.", Information!)
End If



Return pl_linhas
end event

event dw_2::ue_recuperar;//OverRide
DateTime	ldh_Inicio,&
				ldh_Fim

Long ll_Linhas

String ls_Estorno,&
		ls_Matric_Vendedor,&
		ls_Servico

dw_1.AcceptText()

ldh_Inicio				= Datetime(dw_1.Object.dt_inicio				[1])
ldh_Fim					= Datetime(dw_1.Object.dt_termino			[1],23:59:00)
ls_Servico				= dw_1.Object.servicos							[1]
ls_Matric_Vendedor	= dw_1.Object.nr_matricula_vendedor		[1]

If Not IsNull(ldh_Inicio) and Not IsNull(ldh_Fim) Then
	If ldh_Inicio > ldh_Fim Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data final.")
		dw_1.SetColumn("dt_inicio")
		Return 1
	End If
End If

If ls_Servico <> 'T'  Then
	This.of_AppendWhere("  inf.cd_produto in ("+String(ivs_servicos ) + ")")
End If

If not isNull(ls_matric_vendedor) or ls_matric_vendedor <> '' Then
	This.of_AppendWhere("  nf.nr_matric_operador =  " + "'" + ls_matric_vendedor + "'")
End If

This.Retrieve(ldh_Inicio,ldh_Fim)

This.of_SetRowSelection( "if( (not isnull( dh_cancelamento )), rgb(255, 0, 0), " + This.ivs_Cor_Linha_Padrao + ")", "", False )

Return 1 
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge566_vendas_servico
integer x = 2400
integer y = 160
string dataobject = "dw_ge566_relatorio_vendas"
end type

event dw_3::ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino

Long lvl_cd_filial
	   

String lvs_de_filial, &
		 lvs_vendedor,&
		 lvs_filial,&
		 lvs_servico
		 
dw_1.accepttext()

lvdt_Inicio   				= dw_1.Object.Dt_Inicio							[1]
lvdt_Termino			= dw_1.Object.Dt_Termino						[1]
lvl_cd_filial				= dw_1.Object.cd_filial 							[1]
lvs_De_Filial 			= dw_1.Object.de_filial							[1]
lvs_vendedor			= dw_1.Object.nm_usuario						[1]
lvs_servico                = dw_1.Describe ("Evaluate('LookupDisplay(servicos)', " + String(1) + ")")


This.Object.t_Periodo.Text = String(lvdt_Inicio,  "dd/mm/yyyy") + " at$$HEX1$$e900$$ENDHEX$$ " + &
                             String(lvdt_Termino, "dd/mm/yyyy")
This.Object.t_Filial.Text = lvs_De_Filial + "(" + String(lvl_cd_filial) + ")"
This.Object.t_Servico.Text = lvs_servico

If isnull(lvs_vendedor) Then
	This.Object.t_Vendedor.Text = "TODOS"
Else
	This.Object.t_Vendedor.Text = lvs_vendedor
End if
									  

This.GroupCalc()
Return AncestorReturnValue
end event

