HA$PBExportHeader$w_ge241_cadastro_campanha.srw
forward
global type w_ge241_cadastro_campanha from dc_w_sheet
end type
type cb_1 from commandbutton within w_ge241_cadastro_campanha
end type
type dw_5 from dc_uo_dw_base within w_ge241_cadastro_campanha
end type
type dw_3 from dc_uo_dw_base within w_ge241_cadastro_campanha
end type
type dw_2 from dc_uo_dw_base within w_ge241_cadastro_campanha
end type
type dw_1 from dc_uo_dw_base within w_ge241_cadastro_campanha
end type
type gb_1 from groupbox within w_ge241_cadastro_campanha
end type
type gb_2 from groupbox within w_ge241_cadastro_campanha
end type
type gb_3 from groupbox within w_ge241_cadastro_campanha
end type
type gb_4 from groupbox within w_ge241_cadastro_campanha
end type
end forward

global type w_ge241_cadastro_campanha from dc_w_sheet
integer width = 3776
integer height = 2196
string title = "GE241 - Cadastro de Campanhas"
boolean resizable = false
cb_1 cb_1
dw_5 dw_5
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_ge241_cadastro_campanha w_ge241_cadastro_campanha

type variables
uo_Campanha ivo_Campanha

uo_Produto ivo_Produto

uo_Cliente ivo_Cliente

uo_ge229_selecao_prd_personalizado ivo_Selecao_Produtos

uo_ge216_filiais ivo_Selecao_Filiais

Boolean ivb_Campanha_Finalizada = False

Date idh_Data_Atual
end variables

forward prototypes
public subroutine wf_localiza_produto ()
public function Long wf_proxima_campanha ()
public subroutine wf_localiza_cliente ()
public function boolean wf_adiciona_produtos ()
public subroutine wf_localiza_filial ()
public function boolean wf_verifica_datas (date al_inicio, date al_termino, date al_inicio_estoque, date al_termino_estoque, date pdh_insere_cliente)
end prototypes

public subroutine wf_localiza_produto ();Long lvl_Linha
Integer lvi_Tamanho

lvi_Tamanho = LenA(dw_2.GetText())

If lvi_Tamanho > 0 Then
	ivo_Produto.of_Localiza_Produto(dw_2.GetText())
	
	If ivo_Produto.Localizado Then
		lvl_Linha = dw_2.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, dw_2.RowCount())
	
		If lvl_Linha < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto selecionado.", StopSign!)
			Return
		End If		
		
		If lvl_Linha = 0 Then
			lvl_Linha = dw_2.GetRow()
			
			dw_2.Object.Cd_Produto          		[lvl_Linha] = ivo_Produto.Cd_Produto
			dw_2.Object.De_Produto          		[lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			
			//dw_2.Object.De_Produto	[lvl_Linha].Protect = 1
			dw_2.Post Event ue_Pos(lvl_Linha, "pc_desconto")	
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(ivo_Produto.Cd_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionado.", Information!)
			//dw_2.Post Event ue_Pos(lvl_linha, "de_produto")
			dw_2.Object.De_Produto [dw_2.GetRow()] = ""
		End If
	End If
Else

	ivo_Selecao_Produtos		= Create uo_ge229_selecao_prd_personalizado
	
	//Usado para gravar os c$$HEX1$$f300$$ENDHEX$$digo dos produtos selecionados nos ArrayLists do Objeto
	//A janela CO121 utiliza estes c$$HEX1$$f300$$ENDHEX$$digos em dw
	ivo_Selecao_Produtos.ivb_Insere_Array = True
	
	OpenWithParm(w_ge229_sel_produto_personalizado, ivo_Selecao_Produtos)
	ivo_Selecao_Produtos = Message.PowerObjectParm
	wf_adiciona_produtos()
	dw_2.Event ue_Pos(dw_2.GetRow(), "pc_desconto" )
	
	Destroy(ivo_Selecao_Produtos)
	
	
End If

end subroutine

public function Long wf_proxima_campanha ();Long lvl_Campanha

Select max(nr_campanha) Into :lvl_Campanha
From campanha
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvl_Campanha) Then
			Return lvl_Campanha + 1
		Else
			Return 1
		End If
	Case 100
		Return 1
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da pr$$HEX1$$f300$$ENDHEX$$xima campanha.")
End Choose
end function

public subroutine wf_localiza_cliente ();Long lvl_Linha

ivo_Cliente.of_Localiza_Cliente(dw_5.GetText())

If ivo_Cliente.Localizado Then
	
	lvl_Linha = dw_5.Find("cd_cliente = '" + ivo_Cliente.cd_cliente + "'", 1, dw_5.RowCount())

	If lvl_Linha < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cliente n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		Return
	End If
	
	If lvl_Linha = 0 Then
		lvl_Linha = dw_5.GetRow()
		
		dw_5.Object.cd_cliente          		[lvl_Linha] = ivo_Cliente.cd_Cliente
		dw_5.Object.nm_cliente          		[lvl_Linha] = ivo_Cliente.nm_cliente
		
		ivm_Menu.mf_Confirmar(True)
		ivm_Menu.mf_Cancelar(True)
		ivb_Valida_Salva = True
		
		dw_5.Event ue_Pos(lvl_Linha,"cd_cliente")	
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente '" + String(ivo_Cliente.cd_cliente) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionado.", Information!)
		dw_5.Object.nm_cliente [dw_5.GetRow()] = ""
	End If
	
End If
end subroutine

public function boolean wf_adiciona_produtos ();
Long lvl_Cont, & 
	  lvl_SubString, &
	  lvl_Id_Tipo_Selecao, &
	  lvl_Qtd_tabs, &
	  lvl_Linha, &
	  lvl_Linhas, &
	  lvl_Linha_Tela, &
	  lvl_Linha_Produto

Long lvl_Mix, lvl_Cd_Produto
Long ll_Retorno_Array, ll_linha_array

Decimal lvd_Pct_Desconto

String lvs_De_Selecao
String lvs_Aba

dc_uo_ds_base lvds_Produtos

lvl_Qtd_tabs = Len(ivo_Selecao_Produtos.ivs_TabPage_Selecionadas)

lvl_Linha_Tela = dw_2.GetRow()

For lvl_Cont = 1 To lvl_Qtd_tabs
	
	lvds_Produtos = Create dc_uo_ds_base
	If Not lvds_Produtos.of_ChangeDataObject("ds_ge241_selecao_produtos") Then Return False
	
	lvl_Id_Tipo_Selecao = Long(MidA(ivo_Selecao_Produtos.ivs_TabPage_Selecionadas, lvl_Cont,1))
	
	If lvl_Id_Tipo_Selecao = 5 Then //Mix de produtos
		lvs_Aba = 'Mix de produtos.'
		ll_Retorno_Array = UpperBound(ivo_Selecao_Produtos.ivs_Mix[])				
		lvs_De_Selecao = ivo_Selecao_Produtos.ivs_Mix[1] 
		For ll_linha_array = 2 To ll_Retorno_Array
			lvs_De_Selecao+= "," + ivo_Selecao_Produtos.ivs_Mix[ll_linha_array]
		Next

		lvds_Produtos.of_AppendFrom(" produto_central c")
		lvds_Produtos.of_AppendWhere(" c.cd_mix_produto  In ("+ lvs_De_Selecao + ")")
		lvds_Produtos.of_AppendWhere(" c.cd_produto = g.cd_produto ")

	ElseIf lvl_Id_Tipo_Selecao = 6 Then // Produto
		lvs_Aba = 'Produtos.'
		ll_Retorno_Array = UpperBound(ivo_Selecao_Produtos.ivs_Produto[])
		lvs_De_Selecao = ivo_Selecao_Produtos.ivs_Produto[1] 
		For ll_linha_array = 2 To ll_Retorno_Array
			lvl_Cd_Produto= Long(ivo_Selecao_Produtos.ivs_Produto[ll_linha_array])
			lvs_De_Selecao+= "," + ivo_Selecao_Produtos.ivs_Produto[ll_linha_array]
		Next
		
		lvds_Produtos.of_AppendWhere(" g.cd_produto In ("+lvs_De_Selecao+") ")
		
	Else
		Choose Case lvl_Id_Tipo_Selecao
			Case 1; lvl_SubString = 1 //Grupo
				lvs_Aba = 'Grupo de produtos.'
				ll_Retorno_Array = UpperBound(ivo_Selecao_Produtos.ivs_Grupo[])				
				lvs_De_Selecao = "'" + ivo_Selecao_Produtos.ivs_Grupo[1] + "'"
				For ll_linha_array = 2 To ll_Retorno_Array
					lvs_De_Selecao+= ",'" + ivo_Selecao_Produtos.ivs_Grupo[ll_linha_array]+ "'"
				Next
				
			Case 2; lvl_SubString = 3 //Subgrupo
				lvs_Aba = 'Subgrupo de produtos.'
				ll_Retorno_Array = UpperBound(ivo_Selecao_Produtos.ivs_SubGrupo[])
				lvs_De_Selecao = "'" + ivo_Selecao_Produtos.ivs_SubGrupo[1] + "'"
				For ll_linha_array = 2 To ll_Retorno_Array
					lvs_De_Selecao+= ",'" + ivo_Selecao_Produtos.ivs_SubGrupo[ll_linha_array]+ "'"
				Next
				
			Case 3; lvl_SubString = 6 //Categoria.
				lvs_Aba = 'Categoria de produtos.'
				ll_Retorno_Array = UpperBound(ivo_Selecao_Produtos.ivs_Categoria[])				
				lvs_De_Selecao = "'" + ivo_Selecao_Produtos.ivs_Categoria[1] + "'"
				For ll_linha_array = 2 To ll_Retorno_Array
					lvs_De_Selecao+= ",'" + ivo_Selecao_Produtos.ivs_Categoria[ll_linha_array]+ "'"
				Next
				
			Case 4; lvl_SubString = 9 //Subcategoria
				lvs_Aba = 'Subcategoria de produtos.'
				ll_Retorno_Array = UpperBound(ivo_Selecao_Produtos.ivs_SubCategoria[])				
				lvs_De_Selecao = "'" + ivo_Selecao_Produtos.ivs_SubCategoria[1] + "'"
				For ll_linha_array = 2 To ll_Retorno_Array
					lvs_De_Selecao+= ",'" + ivo_Selecao_Produtos.ivs_SubCategoria[ll_linha_array] + "'"
				Next
		End Choose

		lvds_Produtos.of_AppendWhere(" Substring(g.cd_subcategoria, 1, " + String(lvl_SubString) + &
													") IN ("+lvs_De_Selecao+") ")
	End If
	
	lvl_Linhas = lvds_Produtos.Retrieve()
	Open(w_Aguarde)
	w_Aguarde.Title = "Carregando "+lvs_Aba
	w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)	

	For lvl_Linha = 1 To lvl_Linhas	
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		
		lvl_Linha_Produto = dw_2.Find("cd_produto = " + String(lvds_Produtos.Object.cd_produto[lvl_Linha]), 1, dw_2.RowCount())
		If IsNull(lvl_Linha_Produto) or lvl_Linha_Produto = 0 Then 
			dw_2.Object.Cd_Produto[lvl_Linha_Tela] = lvds_Produtos.Object.cd_produto[lvl_Linha]
			dw_2.Object.De_Produto[lvl_Linha_Tela] = lvds_Produtos.Object.de_apresentacao_venda[lvl_Linha]
			lvl_Linha_Tela = lvl_Linha_Tela +1
		End If
	Next
	
	Close(w_Aguarde)
	Destroy(lvds_Produtos)
Next

Return True

end function

public subroutine wf_localiza_filial ();Long lvl_Linha, &
	   ll_Retorno_Array, &
	   ll_linha_array, &
        lvl_Linha_Tela, &
	   lvl_Linha_Filial
	
Long ll_Contador = 0

ll_Retorno_Array = UpperBound(ivo_Selecao_Filiais.cd_filial[])
lvl_Linha_Tela = dw_3.GetRow()

For lvl_Linha = 1 To ll_Retorno_Array
	lvl_Linha_Filial = dw_3.Find("cd_filial = " + String(ivo_Selecao_Filiais.cd_filial[lvl_Linha]), 1, dw_3.RowCount())
	If IsNull(lvl_Linha_Filial) or lvl_Linha_Filial = 0 Then 
		dw_3.Object.Cd_Filial[lvl_Linha_Tela] = ivo_Selecao_Filiais.cd_filial[lvl_Linha]
		dw_3.Object.Nm_Fantasia[lvl_Linha_Tela] = ivo_Selecao_Filiais.Nm_Fantasia[lvl_Linha]
		lvl_Linha_Tela = lvl_Linha_Tela +1
		ll_Contador++
	End If

Next

If ll_Contador > 0 Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
	ivb_Valida_Salva = True
End If

end subroutine

public function boolean wf_verifica_datas (date al_inicio, date al_termino, date al_inicio_estoque, date al_termino_estoque, date pdh_insere_cliente);Date ldh_Atual

ldh_Atual =  Date( gf_getserverdate() ) 

If IsNull(al_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da campanha.", Information!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return False
End If

If ivb_Campanha_Finalizada = False Then
	If al_Inicio < ldh_Atual And IsNull(dw_1.Object.nr_campanha[1]) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data de in$$HEX1$$ed00$$ENDHEX$$cio da campanha dever maior ou igual a " + String(Today(), 'dd/mm/yyyy') + " .")
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return False
	End If
End If

If IsNull(al_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da campanha.", Information!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return False
End If

If al_Termino < al_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino da campanha deve ser maior do que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return False
End If

If IsNull(al_Inicio_Estoque) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo.", Information!)
	dw_1.Event ue_Pos(1, "dh_inicio_estq_minimo")
	Return False
End If

If IsNull(al_Termino_Estoque) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo.", Information!)
	dw_1.Event ue_Pos(1, "dh_termino_estq_minimo")
	Return False
End If

If al_Termino_Estoque < al_Inicio_Estoque Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo.", Information!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return False
End If

If al_Termino_Estoque > al_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino da campanha deve ser maior do que a data de reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo.", Information!)
	dw_1.Event ue_Pos(1, "dh_termino_estq_minimo")
	Return False
End If

If al_Termino_Estoque < al_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$mino para a reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser maior do que a data de in$$HEX1$$ed00$$ENDHEX$$cio da campanha.", Information!)
	dw_1.Event ue_Pos(1, "dh_termino_estq_minimo")
	Return False
End If

If dw_1.Object.id_avisa_cliente[1] = "S" Then
	
	If IsNull(pdh_insere_cliente) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data para a sele$$HEX2$$e700e300$$ENDHEX$$o dos clientes.", Information!)
		dw_1.Event ue_Pos(1, "dh_insere_cliente")
		Return False
	End If
	
	If pdh_insere_cliente < ldh_Atual Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data para a sele$$HEX2$$e700e300$$ENDHEX$$o de cliente(s) n$$HEX1$$e300$$ENDHEX$$o deve ser menor que a data atual.", Information!)
		dw_1.Event ue_Pos(1, "dh_insere_cliente")
		Return False
	End If
	
	If al_Inicio < pdh_insere_cliente Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da validade da campanha n$$HEX1$$e300$$ENDHEX$$o deve ser menor que a data de sele$$HEX2$$e700e300$$ENDHEX$$o do(s) cliente(s).", Information!)
		dw_1.Event ue_Pos(1, "dh_insere_cliente")
		Return False
	End If

End If

Return True
end function

on w_ge241_cadastro_campanha.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_5=create dw_5
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_5
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.gb_4
end on

on w_ge241_cadastro_campanha.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_5)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;ivo_Campanha 				= Create uo_Campanha
ivo_Produto					= Create uo_Produto // ge001
ivo_Cliente						= Create uo_Cliente



end event

event close;call super::close;Destroy(ivo_Campanha)
Destroy(ivo_Produto)
Destroy(ivo_Cliente)



end event

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]

lvo_Update = {dw_1, dw_2, dw_5, dw_3}

This.wf_SetUpdate_DW(lvo_Update)

idh_Data_Atual = Date( gf_getserverdate() )

//dw_4.InsertRow(1)
dw_1.Event ue_AddRow()
dw_1.SetFocus()

dw_1.ivo_Controle_Menu.of_Incluir(True)



end event

event ue_cancel;//OverRide
This.ivb_Valida_Salva = False

dw_1.SetFocus()
dw_1.Event ue_AddRow()
end event

event ue_preupdate;call super::ue_preupdate;Long 		lvl_Campanha, &
			lvl_Linha

Date		lvdh_Inicio, &
			lvdh_Termino,&
			lvdh_Inicio_Estoque,&
			lvdh_Termino_Estoque
		
Date		lvdh_Insere_Cliente,&
			ldh_Nulo

String 	ls_Avisa_Cliente

String 	lvs_Nome_Campanha, &
			lvs_Produto, &
			lvs_tipo_acao

Boolean lvb_selec_clientes 	=	true, & 
		    lvb_selec_produtos = 	true, & 
		    lvb_selec_filiais 		= 	true


SetNull( ldh_Nulo )

dw_1.AcceptText()

lvl_Campanha 				= Dw_1.Object.nr_Campanha							[1]
lvs_Nome_Campanha		= dw_1.Object.nm_campanha							[1]
lvdh_Inicio						= Date(Dw_1.Object.dh_inicio							[1])
lvdh_Termino					= Date(Dw_1.Object.dh_termino						[1])
lvdh_Inicio_Estoque 		= Date(Dw_1.Object.dh_inicio_estq_minimo		[1])
lvdh_Termino_Estoque 	= Date(Dw_1.Object.dh_termino_estq_minimo	[1])
lvdh_Insere_Cliente		= Date(dw_1.Object.dh_Insere_cliente				[1])
ls_Avisa_Cliente				= dw_1.Object.id_avisa_cliente						[1]


//Verifica Campanha Finalizada
If ivb_Campanha_Finalizada Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta campanha j$$HEX1$$e100$$ENDHEX$$ terminou. Nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser realizada.", Information!)
	Return False
End If

//Nome da campanha
If IsNull(lvs_Nome_Campanha) Or Trim(lvs_Nome_Campanha) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o nome da campanha.",Information!)
	dw_1.Event ue_Pos(1,"nm_campanha")
	Return False
End If

//Validacao das Datas
If wf_verifica_datas(lvdh_Inicio,lvdh_Termino,lvdh_Inicio_Estoque,lvdh_Termino_Estoque, lvdh_Insere_Cliente) = False Then
	Return False
End If

//Verifica Clientes
If ls_Avisa_Cliente = "N" And ( dw_5.RowCount() = 0 Or (dw_5.RowCount() > 0 And IsNull(dw_5.Object.cd_cliente[1]) ) )Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um cliente.", Information!)
	dw_5.Event ue_AddRow()
	dw_5.Event ue_Pos(1, "cd_cliente")
	Return False
End If

//Verifica Produtos Selecionadas
If dw_2.RowCount() = 0 Then
	lvb_selec_produtos = false
End If

//Verifica Filiais Selecionadas
If dw_3.RowCount() <= 0 Then	
	lvb_selec_filiais = false
End If

If dw_3.RowCount() > 0 And dw_5.RowCount() > 0 And dw_2.RowCount() <= 0 Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Campanha n$$HEX1$$e300$$ENDHEX$$o prevista para os par$$HEX1$$e200$$ENDHEX$$metros informados." )
	dw_2.Event ue_Pos(1, "cd_produto")
	Return False
End If


//Valida Campanha com AVISO AO CLIENTE
If ls_Avisa_Cliente = "S" Then
	
	If dw_2.RowCount() <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um produto.", Information!)
		dw_2.Event ue_Pos(1, "cd_produto")
		Return False
	End If
	
	//Apenas um produto por campanha se estiver marcado.
	If dw_2.RowCount() > 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O par$$HEX1$$e200$$ENDHEX$$metro 'Avisa Cliente' permite apenas um produto por campanha.", Information!)
		dw_2.Event ue_Pos(1, "cd_produto")
		Return False
	End If
	
	If dw_3.RowCount() <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma filial.", Information!)
		dw_3.Event ue_Pos(1, "cd_filial")
		Return False
	End If
		
End If



//Verifica desconto em branco
/*For lvl_linha = 1 To dw_2.RowCount()
	
	lvs_Produto = dw_2.Object.de_produto[lvl_Linha] 
	
	If IsNull(dw_2.Object.pc_desconto[lvl_Linha]) Or dw_2.Object.pc_desconto[lvl_Linha] = 0.00 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o desconto do produto: '" + lvs_Produto + "' .",Information!)
		dw_2.Event ue_Pos(lvl_Linha, "pc_desconto")
		Return False
	End If
Next*/

If ls_Avisa_Cliente = "S" Then
	lvs_tipo_acao = 'CM' //Campanha Clientes X Produtos x Filiais
Else
	If lvb_selec_clientes And lvb_selec_produtos and lvb_selec_filiais Then
		lvs_tipo_acao = 'CM' //Campanha Clientes X Produtos x Filiais
	Else
		If lvb_selec_produtos And lvb_selec_clientes Then
			lvs_tipo_acao = 'AP' //A$$HEX2$$e700e300$$ENDHEX$$o Clientes X Produtos		
		Else
			If lvb_selec_clientes Then
				lvs_tipo_acao = 'AC' //A$$HEX2$$e700e300$$ENDHEX$$o Clientes
			End If
		End If
	End If
End If
dw_1.Object.id_tipo_campanha	[1] = lvs_tipo_acao

//Nova Campanha ou Update
If IsNull(lvl_Campanha) Then
	lvl_Campanha = wf_Proxima_Campanha()
	
	Dw_1.Object.nr_Campanha[1] = lvl_Campanha
End If

dw_1.ivo_Controle_Menu.of_Excluir(False)


Return True
end event

type cb_1 from commandbutton within w_ge241_cadastro_campanha
integer x = 3301
integer y = 1904
integer width = 402
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar .xls"
end type

event clicked;String lvs_caminho = "C:\", &
         lvs_Nm_Arquivo, &
		lvs_De_Produto, &
		lvs_De_Apresentacao_Venda, &
		lvs_Cliente, &
		lvs_Nm_Cliente

Integer lvi_arquivo

Long lvl_Row, &
	lvl_Linha_Nova, &
	lvl_Total, &
	lvl_Limite, &
	lvl_Cliente, &
	lvl_Qtd_Clientes

lvi_arquivo = GetFileOpenName("Selecione o arquivo", &
                               + lvs_Caminho     , & 
										   lvs_Nm_Arquivo  , & 
											"XLS"           , &
     	                         + "Arquivo Excel (*.XLS),*.XLS," &
							   + "Arquivo Excel (*.XLSX),*.XLSX")
											
Setpointer(HourGlass!)
											
Choose Case lvi_Arquivo
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao abrir o arquivo '" + lvs_Nm_Arquivo + "'.")
		Return -1
	Case 0
		Return 1
End Choose
											
Open(w_Aguarde)
w_Aguarde.Title = "Lendo dados do arquivo : '" + Upper(lvs_Nm_Arquivo) + "'."

dc_uo_Excel lvo_Excel
lvo_Excel = Create dc_uo_Excel

lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Caminho)
lvl_Total = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A")

w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

lvl_Qtd_Clientes = 0
For lvl_Row = 1 To lvl_Total
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)
	lvs_Cliente = String(lvo_Excel.uo_Lendo_Dados(lvl_Row, "A"),'00000000000')
	lvl_Linha_Nova = dw_5.Event ue_AddRow()
	
	Select nm_cliente
 	  Into :lvs_Nm_Cliente
	  From cliente
	 Where cd_cliente = :lvs_Cliente
	 Using SqlCa;
	 
	 If SqlCa.SqlCode <> 0 Then
		SqlCa.of_MsgDbError("Cliente: " +lvs_Cliente + " n$$HEX1$$e300$$ENDHEX$$o encontrado.")
		Exit
	 End If
		
	dw_5.Object.Cd_Cliente	[lvl_Linha_Nova] = lvs_Cliente
	dw_5.Object.Nm_Cliente	[lvl_Linha_Nova] = lvs_Nm_Cliente
	
	lvl_Qtd_Clientes++
				
Next

If lvl_Qtd_Clientes > 0 Then
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)
	Parent.ivb_Valida_Salva = True
End If

dw_5.GroupCalc()

Destroy(lvo_Excel)
Close(w_Aguarde)


end event

type dw_5 from dc_uo_dw_base within w_ge241_cadastro_campanha
integer x = 2039
integer y = 500
integer width = 1682
integer height = 1396
integer taborder = 50
string dataobject = "dw_ge241_campanha_cliente"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

Long lvl_Campanha

lvl_Campanha = dw_1.Object.nr_Campanha[1]

Return Retrieve(lvl_Campanha)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha, &
     lvl_Campanha

lvl_Campanha = dw_1.Object.Nr_Campanha[1]

For lvl_Linha = 1 To This.RowCount()
	
	If Not IsNull(This.Object.cd_cliente[lvl_Linha]) Then
		If IsNull(This.Object.Nr_Campanha[lvl_Linha]) Then
			This.Object.Nr_Campanha [lvl_Linha] = lvl_Campanha
		End If
	Else
		This.DeleteRow(lvl_Linha)
		//This.Event ue_Pos(lvl_Linha - 1, "cd_cliente")
	End If
	
Next

Return 1
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then	
	This.ivo_Controle_Menu.of_Excluir(True)	
End If

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()

	Choose Case lvs_Coluna
		Case "nm_cliente"
			wf_localiza_cliente()
				
	End Choose
		
End If

	

end event

event getfocus;call super::getfocus;If This.GetRow() > 0 Then
	This.ivo_Controle_Menu.of_Incluir(True)
	This.ivo_Controle_Menu.of_Excluir(True)	
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.Find("isnull(cd_cliente)", 1, This.RowCount()) > 0 Then
	Return -1
Else
	Return 1	
End If
end event

type dw_3 from dc_uo_dw_base within w_ge241_cadastro_campanha
event ue_seleciona_filial ( long pl_filial,  boolean pb_selecao )
integer x = 41
integer y = 1332
integer width = 1902
integer height = 664
integer taborder = 50
string dataobject = "dw_ge241_filiais"
boolean vscrollbar = true
end type

event ue_seleciona_filial(long pl_filial, boolean pb_selecao);Long lvl_Linha

lvl_Linha = dw_3.Find("cd_filial = " + String(pl_Filial), 1, dw_3.RowCount())

If lvl_Linha > 0 Then
	If pb_Selecao Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(pl_Filial) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	Else
		dw_3.DeleteRow(lvl_Linha)
	End If
Else
	If pb_Selecao Then
		lvl_Linha = dw_3.InsertRow(0)			
		
		dw_3.Object.Cd_Filial[lvl_Linha] = pl_Filial
	End If
End If

end event

event constructor;call super::constructor;This.Of_SetRowSelection()
end event

event itemchanged;call super::itemchanged;Boolean lvb_Selecao

If Data = "S" Then
	lvb_Selecao = True
Else 
	lvb_Selecao = False
End If

//Marca as filiais Com Campanha
This.Event ue_Seleciona_Filial(This.Object.Cd_Filial[Row], lvb_selecao)

Parent.ivb_Valida_Salva = True

Parent.ivm_menu.mf_Confirmar(True)
Parent.ivm_menu.mf_Cancelar(True)
end event

event getfocus;call super::getfocus;If This.GetRow() > 0 Then
	This.ivo_Controle_Menu.of_Incluir(True)
	This.ivo_Controle_Menu.of_Excluir(True)	
End If
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha, &
     lvl_Campanha
	  
lvl_Campanha = dw_1.Object.nr_campanha[1]

For lvl_Linha = 1 To This.RowCount()
	
	If IsNull(This.Object.nr_campanha[lvl_Linha]) Then
		
		This.Object.nr_campanha[lvl_Linha] = lvl_Campanha
	Else	
		This.DeleteRow(lvl_Linha)	
	End If
	
Next

Return 1



end event

event ue_recuperar;//OverRide

Long lvl_Campanha

lvl_Campanha = dw_1.Object.nr_campanha[1]

Return This.Retrieve(lvl_Campanha)
end event

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Contador, &
     	lvl_Find, &
	 	lvl_Filial

If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_Excluir(True)
Else
	This.ivo_Controle_Menu.of_Excluir(False)
End If

For lvl_Contador = 1 To dw_3.RowCount()
	lvl_Filial = dw_3.Object.Cd_Filial[lvl_Contador]
	
	If This.RowCount() > 0 Then
		lvl_Find = This.Find("cd_filial = " + String(lvl_Filial), 1, This.RowCount())
		
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da lista das filiais da campanha.", StopSign!)
			Return pl_Linhas
		End If
	Else
		lvl_Find = 0
	End If	
	
Next

Return pl_Linhas
end event

event editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then	
	This.ivo_Controle_Menu.of_Excluir(True)	
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then 
		This.ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()

	Choose Case lvs_Coluna
		Case "nm_fantasia"	
			ivo_Selecao_Filiais         = Create uo_ge216_filiais
			OpenWithParm(w_ge216_selecao_filiais, ivo_Selecao_Filiais)
			wf_localiza_filial()
			dw_3.GroupCalc()
			This.Event ue_Pos(This.GetRow(), "cd_filial")
			Destroy(ivo_Selecao_Filiais)
	End Choose
	
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.Find("isnull(cd_filial)", 1, This.RowCount()) > 0 Then
	Return -1
Else
	Return 1	
End If
end event

type dw_2 from dc_uo_dw_base within w_ge241_cadastro_campanha
integer x = 41
integer y = 496
integer width = 1902
integer height = 740
integer taborder = 40
string dataobject = "dw_ge241_campanha_produto"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

Long lvl_Campanha

lvl_Campanha = dw_1.Object.nr_campanha[1]

Return Retrieve(lvl_Campanha)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()

	Choose Case lvs_Coluna
		Case "de_produto"		
			wf_Localiza_Produto()
			
			Parent.ivm_Menu.mf_Confirmar(True)
			Parent.ivm_Menu.mf_Cancelar(True)
			ivw_ParentWindow.ivb_Valida_Salva = True
					
		Case "pc_desconto"
			This.Event ue_AddRow()
	End Choose
End If
end event

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	
Case "pc_desconto"
		
		This.ivo_Controle_Menu.of_Excluir(True)	
		
		If Dec(data) <= 0.00 Or Dec(data) > 100.00 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto informado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
			This.Object.pc_desconto[1] = 0.00
			Return 1
		End If
					
End Choose
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then	
	This.ivo_Controle_Menu.of_Excluir(True)	
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then 
		This.ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.Find("isnull(cd_produto)", 1, This.RowCount()) > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o produto juntamente com o percentual de desconto.",Information!)
	Return -1
Else
	Return 1	
End If


end event

event editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)


end event

event getfocus;call super::getfocus;If This.GetRow() > 0 Then
	This.ivo_Controle_Menu.of_Incluir(True)
	This.ivo_Controle_Menu.of_Excluir(True)	
End If
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_Excluir(True)
//	This.ivo_Controle_Menu.of_Filtrar(True)
//	This.ivo_Controle_Menu.of_Classificar(True)
Else
	This.ivo_Controle_Menu.of_Excluir(False)
//	This.ivo_Controle_Menu.of_Filtrar(False)
//	This.ivo_Controle_Menu.of_Classificar(False)
End If

Return pl_Linhas
end event

event ue_preupdate;call super::ue_preupdate;Long  lvl_Linha, &
     	lvl_Campanha
	  
Date lvdt_Alteracao

lvdt_Alteracao = Today()

lvl_Campanha = dw_1.Object.Nr_Campanha[1]

For lvl_Linha = 1 To This.RowCount()
	
	//If Not IsNull(This.Object.cd_produto[lvl_linha]) And Not IsNull(This.Object.pc_desconto[lvl_linha]) Then
	If Not IsNull(This.Object.cd_produto[lvl_linha]) Then
		If IsNull(This.Object.Nr_Campanha[lvl_Linha]) Then
			This.Object.Nr_Campanha	[lvl_Linha] = lvl_Campanha
			This.Object.Dh_Alteracao	[lvl_Linha] = lvdt_Alteracao
		Else
			If This.Object.Pc_Desconto[lvl_Linha] <> This.Object.Pc_Desconto_Anterior[lvl_Linha] Then
				This.Object.Dh_Alteracao	[lvl_Linha] = lvdt_Alteracao
			End If
		End If
	Else	
		This.DeleteRow(lvl_Linha)		
	End If
	
Next

Return 1
end event

type dw_1 from dc_uo_dw_base within w_ge241_cadastro_campanha
integer x = 32
integer y = 72
integer width = 3246
integer height = 324
integer taborder = 20
string dataobject = "dw_ge241_selecao_campanha"
end type

event ue_key;call super::ue_key;String lvs_Campanha

If Key = KeyEnter! Then
	
	If This.GetColumnName() = "de_localizacao" Then
	
		ivo_Campanha.of_Localiza(This.GetText())

		If ivo_Campanha.Localizado Then
			This.Object.nr_campanha[1] = ivo_Campanha.nr_campanha
			
			This.Event ue_Retrieve()
			
			dw_2.Event ue_Recuperar()
			dw_3.Event ue_Recuperar()
			dw_5.Event ue_Recuperar()
						
		End If
	End If
End If
end event

event ue_recuperar;//OverRide

Long lvl_Campanha

lvl_Campanha = dw_1.Object.nr_campanha[1]

Return Retrieve(lvl_Campanha)
end event

event itemchanged;// Override

Date ldh_Nulo

SetNull( ldh_Nulo )

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	ivw_ParentWindow.ivb_Valida_Salva = True
	
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)		
End If


If dwo.Name = "id_avisa_cliente" Then
	If Data = "S" Then
		This.Object.dh_Insere_cliente[1] = idh_Data_Atual
	Else
		This.Object.dh_Insere_cliente[1] = ldh_Nulo
	End If
	
End If
end event

event constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao"}

This.of_SetColSelection(True)
end event

event editchanged;//OverRide
If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
		
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)		
	End If
End If
end event

event getfocus;call super::getfocus;If ivw_ParentWindow.ivb_Valida_Salva = True Then
	This.Object.de_localizacao.Protect = 1
Else
	This.Object.de_localizacao.Protect = 0
End If

This.ivo_Controle_Menu.of_Atualiza()



end event

event ue_deleterow;// OverRide

dw_2.SetFocus()

dw_2.Event ue_DeleteRow()

Return True
end event

event ue_addrow;call super::ue_addrow;Long lvl_Campanha

If AncestorReturnValue > 0 Then
	Parent.ivb_Valida_Salva = False
	//limpa produtos
	dw_2.Reset()
	//limpa filiais
	dw_3.Reset()
	//limpa clientes
	dw_5.Reset()
			
	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)
	
	//Data Sistema
	dw_1.Object.dh_Inicio						[1]	= idh_Data_Atual
	dw_1.Object.dh_inicio_estq_minimo	[1]	= idh_Data_Atual
	//dw_1.Object.dh_Insere_cliente 		[1]	= idh_Data_Atual
		
End If

Return AncestorReturnValue
end event

event ue_preinsertrow;//OverRide

						
This.Reset()


Return 1

end event

event ue_postretrieve;call super::ue_postretrieve;Date lvdh_Data_Atual, &
		lvdh_Data_Final

If pl_Linhas > 0 Then
	
	This.AcceptText()
	
	lvdh_Data_Atual 	= Today()
	lvdh_Data_Final 	= Date(This.Object.dh_termino[1])

//	If Date(lvdh_Data_Atual) > lvdh_Data_Final Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta campanha j$$HEX1$$e100$$ENDHEX$$ terminou. Nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser realizada.", Information!)
//		ivb_Campanha_Finalizada = True
//	End If
	
End If

Return pl_Linhas
end event

type gb_1 from groupbox within w_ge241_cadastro_campanha
integer x = 9
integer y = 8
integer width = 3291
integer height = 424
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Campanha"
end type

type gb_2 from groupbox within w_ge241_cadastro_campanha
integer x = 9
integer y = 440
integer width = 1961
integer height = 816
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
end type

type gb_3 from groupbox within w_ge241_cadastro_campanha
integer x = 2007
integer y = 440
integer width = 1733
integer height = 1580
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Clientes"
end type

type gb_4 from groupbox within w_ge241_cadastro_campanha
integer x = 9
integer y = 1276
integer width = 1961
integer height = 744
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filiais"
end type

