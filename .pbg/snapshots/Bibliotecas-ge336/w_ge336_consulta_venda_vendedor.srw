HA$PBExportHeader$w_ge336_consulta_venda_vendedor.srw
forward
global type w_ge336_consulta_venda_vendedor from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge336_consulta_venda_vendedor from dc_w_selecao_lista_relatorio
integer width = 5184
integer height = 1648
string title = "GE336 - Relat$$HEX1$$f300$$ENDHEX$$rio Detalhado de Vendas por Vendedor"
long backcolor = 80269524
end type
global w_ge336_consulta_venda_vendedor w_ge336_consulta_venda_vendedor

type variables
dc_uo_ds_base ivds_dev

uo_filial ivo_filial					//GE009
uo_vendedor ivo_vendedor		//GE013

Boolean ivb_Matriz		= True
Boolean ivb_Alerta_Data	= True
Boolean ivb_Aceita_Data = True
Boolean ivb_Gerar_Arquivo = False

String ivs_Rede
String is_Usuario



Integer ii_Timer = 20

Date ivdt_Periodo_De
Date ivdt_Periodo_Ate



end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_vendedor ()
public function string wf_retira_strings (string ps_char_delete, string ps_char_nova, string ps_string)
public function string wf_valor (decimal adc_valor)
public subroutine wf_calcula_periodo ()
end prototypes

public subroutine wf_localiza_filial ();String lvs_Texto

lvs_Texto = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Texto)

If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
	dw_1.Object.de_Filial	[1] = ivo_Filial.Nm_Fantasia	
End If
end subroutine

public subroutine wf_localiza_vendedor ();String lvs_Texto

lvs_Texto = dw_1.GetText()

ivo_vendedor.of_Localiza_Vendedor(lvs_Texto)

If ivo_Vendedor.Localizado Then
	dw_1.Object.Nr_Matricula_Vendedor	[1] = ivo_Vendedor.Nr_Matricula_Vendedor
	dw_1.Object.Nm_Usuario				[1] = ivo_Vendedor.Nm_Usuario
End If
end subroutine

public function string wf_retira_strings (string ps_char_delete, string ps_char_nova, string ps_string);String lvs_limpo, &
       lvs_auxlimpo
		 
Integer lvi_posicao, &
        lvi_contador, &
		  lvi_ASC
		  
Boolean lvb_exist

lvi_ASC = AscA(ps_char_delete)

//Procura o caracter enter
lvi_posicao = PosA(ps_string,CharA(lvi_ASC))

//VerIfica se existe o caracter
If lvi_posicao > 0 and not isnull(lvi_posicao) Then
	lvb_exist = True
Else
	lvb_exist = False
	Return(ps_string)
End If

//A primeira vez, vai ser o valor do parametro
lvs_limpo = ps_string

//Rotina para retirar todos os caracteres lvl_ASC da string

DO WHILE lvb_exist = True
  lvs_auxlimpo = lvs_limpo
  lvi_posicao  = PosA(lvs_auxlimpo, CharA(lvi_ASC))
  
  If lvi_posicao > 0 and not isnull(lvi_posicao) Then
    lvs_limpo = ReplaceA (lvs_auxlimpo, lvi_posicao, 1, ps_char_nova)
  Else
    lvb_exist = False
End If

LOOP

//Retorna a string j$$HEX1$$e100$$ENDHEX$$ limpa
Return(lvs_limpo)
end function

public function string wf_valor (decimal adc_valor);String lvs_String,&
	   lvs_Valor

Integer lvi_Pos

lvs_String = String(adc_valor)

lvi_Pos = PosA(lvs_String, ",")

lvs_Valor = MidA(lvs_String, 1, lvi_Pos -1) + MidA(lvs_String, lvi_Pos + 1, LenA(lvs_String))

Return lvs_Valor


end function

public subroutine wf_calcula_periodo ();
If  Integer(String(Today(), "dd") )  < 29 Then
	ivdt_Periodo_De  = Date("26/" + String( RelativeDate(Today(),  - 30), "mm/yyyy"))
Else
	ivdt_Periodo_De  = Date("26/" + String( Today(), "mm/yyyy"))	
End If

ivdt_Periodo_Ate = Today()

dw_1.Object.Dt_Periodo_De		[1] = ivdt_Periodo_De
dw_1.Object.Dt_Periodo_Ate	[1] = ivdt_Periodo_Ate


end subroutine

on w_ge336_consulta_venda_vendedor.create
call super::create
end on

on w_ge336_consulta_venda_vendedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;If IsValid( ivds_Dev ) 			Then Destroy(ivds_Dev)
If IsValid( ivo_Vendedor ) 	Then Destroy(ivo_Vendedor)
If IsValid( ivo_Filial ) 			Then Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;ivds_Dev 	 	= Create dc_uo_ds_base
ivo_Vendedor 	= Create uo_Vendedor
ivo_Filial   		= Create uo_Filial

wf_calcula_periodo()

ivm_Menu.mf_Recuperar(True)
ivm_Menu.ivb_Permite_Imprimir = True

If Not ivb_Matriz Then
	
	ivo_vendedor.of_Localiza_Codigo( is_Usuario )
	
	If Not ivo_vendedor.Localizado Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Vendedor n$$HEX1$$e300$$ENDHEX$$o localizado.")
		Close(This)
		Return
	End If
	
	dw_1.Object.Cd_Filial[1]      	= gvo_Parametro.of_Filial()
	dw_1.Object.De_Filial[1]      	= gvo_Parametro.Nm_Fantasia_Filial
	dw_1.Object.Cd_Filial.Protect 	= 1
	dw_1.Object.De_Filial.Protect 	= 1	
	dw_1.Object.id_beauty.visible 	= 1
	
	//Altera$$HEX2$$e700e300$$ENDHEX$$o Ref. Chamado: 93566
	dw_1.Object.nr_matricula_vendedor	[1]			= ivo_vendedor.nr_matricula_vendedor
	dw_1.Object.nm_usuario					[1]			= ivo_vendedor.nm_usuario
	dw_1.Object.nr_matricula_vendedor.Protect	= 1
	dw_1.Object.nm_usuario.Protect 					= 1
	
	Timer( ii_Timer, This )
		
End If
end event

event ue_preprint;call super::ue_preprint;dw_3.Object.St_Periodo.Text 	= STRING(dw_1.Object.dt_periodo_de [1], "DD/MM/YYYY") + " $$HEX1$$e000$$ENDHEX$$ " + STRING(dw_1.Object.dt_periodo_ate[1], "DD/MM/YYYY")
dw_3.Object.St_Filial.Text  		= dw_1.Object.de_filial[1] + " - (" + STRING(dw_1.Object.cd_filial[1]) + ")"

Return AncestorReturnValue

end event

event timer;call super::timer;Return Close( This )
end event

event ue_preopen;call super::ue_preopen;Maxheight = 9999
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge336_consulta_venda_vendedor
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge336_consulta_venda_vendedor
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge336_consulta_venda_vendedor
integer x = 14
integer y = 344
integer width = 5111
integer height = 1112
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge336_consulta_venda_vendedor
integer x = 14
integer y = 0
integer width = 1911
integer height = 332
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge336_consulta_venda_vendedor
integer x = 27
integer y = 52
integer width = 1874
integer height = 276
string dataobject = "dw_ge336_selecao"
end type

event dw_1::ue_key;String lvs_Coluna

dw_1.AcceptText()

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "de_filial"
			wf_Localiza_Filial()
			
		Case "nm_usuario"
			wf_Localiza_Vendedor()
	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;Integer lvi_Resp

If dwo.Name = "de_filial" Then
	If Data <> ivo_Filial.Nm_Fantasia Then Return 1
End If

If dwo.Name = "nm_usuario" Then
	
	If Data = "" OR IsNull(Data) Then 
		This.Object.Nr_Matricula_Vendedor[1] = ""
		Return 0
	End If
	
	If Data <> ivo_Vendedor.Nm_Usuario Then Return 1
End If



end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge336_consulta_venda_vendedor
integer x = 46
integer y = 388
integer width = 5065
integer height = 1028
string dataobject = "dw_ge336_lista_vendas"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date lvdt_Inicio, &
	  lvdt_Termino, &
	  lvdh_Data_Minima
	  
Long lvl_Filial, &
	  lvl_Intervalo

Integer lvi_Resp

dw_1.AcceptText()

lvdt_Inicio		= dw_1.Object.Dt_Periodo_De	[1]
lvdt_Termino	= dw_1.Object.Dt_Periodo_Ate	[1]
lvl_Filial			= dw_1.Object.Cd_Filial	  		[1]

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event Ue_Pos(1, "dt_periodo_de")
	Return -1
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event Ue_Pos(1, "dt_periodo_ate")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event Ue_Pos(1, "dt_periodo_ate")
	Return -1
End If

If ivb_Alerta_Data = True Then
	If lvdt_Inicio <> ivdt_Periodo_De Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tem certeza que deseja alterar o per$$HEX1$$ed00$$ENDHEX$$odo?", Question!, YesNo!) = 2 Then	
			dw_1.Object.Dt_Periodo_De		[1] = ivdt_Periodo_De
			dw_1.Object.Dt_Periodo_Ate	[1] = ivdt_Periodo_Ate
			dw_1.Event ue_Pos(1, "dt_periodo_de")
			ivb_Aceita_Data = False
			Return -1
		Else
			ivb_Aceita_Data = True
		End If
	Else
		If lvdt_Termino <>  ivdt_Periodo_Ate Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tem certeza que deseja alterar o per$$HEX1$$ed00$$ENDHEX$$odo?", Question!, YesNo!) = 2 Then
				dw_1.Object.Dt_Periodo_De		[1] = ivdt_Periodo_De
				dw_1.Object.Dt_Periodo_Ate	[1] = ivdt_Periodo_Ate
				dw_1.Event ue_Pos(1, "dt_periodo_ate")
				ivb_Aceita_Data = False
				Return -1
			Else
				ivb_Aceita_Data = True
			End If
		Else
			ivb_Aceita_Data = True
		End If
	End If
End If

If IsNull(lvl_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial deve ser informada.")
	dw_1.Event Ue_Pos(1, "de_filial")
	Return -1
End If

If Not ivb_Matriz Then
	lvdh_Data_Minima = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -60)
	
	If lvdh_Data_Minima > lvdt_Inicio Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial deve ser maior ou igual a '" + String(lvdh_Data_Minima) + "'.")
		dw_1.Event ue_Pos(1, "dt_periodo_de")
		Return -1
	End If
	
	This.of_AppendWhere("v.id_mostrar_comissao = 'S'")
	This.of_AppendWhere_Subquery("v.id_mostrar_comissao = 'S'",2)

End If

This.SetRedraw(False)

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

String lvs_Vendedor,&
		lvs_Beauty

Date lvdt_Inicio, &
	  lvdt_Termino
	  
Long lvl_Filial

lvs_Vendedor 	= dw_1.Object.Nr_Matricula_Vendedor	[1]
lvdt_Inicio  		= dw_1.Object.Dt_Periodo_De 		   		[1]
lvdt_Termino 	= dw_1.Object.Dt_Periodo_Ate 			[1]
lvl_Filial	 		= Long(dw_1.Object.Cd_Filial				[1])
lvs_Beauty		= dw_1.Object.id_beauty					[1]

If lvs_Vendedor <> "" And Not IsNull(lvs_Vendedor) Then
	dw_2.of_AppendWhere("n.nr_matricula_vendedor = '" + lvs_Vendedor + "'")
	dw_2.of_AppendWhere_Subquery("nd.nr_matricula_vendedor = '" + lvs_Vendedor + "'",2)
End If

If lvs_Beauty = 'S' Then
	dw_2.of_AppendWhere("i.cd_produto in (select cd_produto from produto_geral where id_beauty = 'S')")
	dw_2.of_AppendWhere_Subquery("id.cd_produto in (select cd_produto from produto_geral where id_beauty = 'S')",3)
End If

Open(w_Aguarde)
w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de vendas, aguarde..."

Return This.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Filial)
end event

event dw_2::ue_postretrieve;// OverRide

Boolean lvb_Classificar, &
            lvb_Filtrar, &
		  lvb_Localizar

If pl_Linhas <= 0 Then
	If ivb_Gerar_Arquivo = False Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
	Close(w_Aguarde)
Else	
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar     	= IsValid(This.ivo_Filter)
	lvb_Localizar	= IsValid(This.ivo_Find)	

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()

	dw_1.AcceptText()
	Close(w_Aguarde)
End If

This.SetRedraw(True)

If ivb_Matriz Then
	This.ivm_Menu.mf_Imprimir(True)
	This.ivm_Menu.mf_SalvarComo(True)
	This.ivm_Menu.mf_Classificar(lvb_Classificar)
	This.ivm_Menu.mf_Filtrar(lvb_Filtrar)
	This.ivm_Menu.mf_Localizar(lvb_Localizar)
Else
	This.ivm_Menu.mf_Imprimir(False)
	This.ivm_Menu.mf_SalvarComo(False)
	This.ivm_Menu.mf_Classificar( False )
	This.ivm_Menu.mf_Filtrar( False )	
	This.ivm_Menu.mf_Localizar(lvb_Localizar)
	Timer( ii_Timer )
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge336_consulta_venda_vendedor
integer x = 1966
integer y = 36
integer width = 434
integer height = 252
integer taborder = 50
string dataobject = "dw_ge336_relatorio"
end type

