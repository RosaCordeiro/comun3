HA$PBExportHeader$w_ge639_cadastro_produto_excecao_corte.srw
forward
global type w_ge639_cadastro_produto_excecao_corte from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge639_cadastro_produto_excecao_corte from dc_w_cadastro_selecao_lista
integer width = 4741
integer height = 1728
string title = "GE639 - Cadastro de Produtos Exce$$HEX2$$e700e300$$ENDHEX$$o de corte CD"
end type
global w_ge639_cadastro_produto_excecao_corte w_ge639_cadastro_produto_excecao_corte

type variables
uo_Usuario ivo_Usuario

uo_produto ivo_produto

//String is_nm_usuario_persiste, is_matricula_persiste
end variables

forward prototypes
public function boolean wf_verifica_insert_produto (long al_produto, ref string as_erro)
end prototypes

public function boolean wf_verifica_insert_produto (long al_produto, ref string as_erro);Long		ll_count

SELECT COUNT(*)
INTO :ll_count 
FROM produto_excecao_corte_cd
WHERE cd_produto = :al_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_erro = 'Erro, Erro na consullta do produto na tabela produto_excecao_corte_cd'
	Return False
End If

If ll_count > 0 or isnull(ll_count) Then
	as_erro = 'Erro: Produto: ' + String(al_produto) + ' j$$HEX1$$e100$$ENDHEX$$ existe na tabela e n$$HEX1$$e300$$ENDHEX$$o pode ser duplicado.'
	Return False
End if

Return True
end function

on w_ge639_cadastro_produto_excecao_corte.create
call super::create
end on

on w_ge639_cadastro_produto_excecao_corte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Usuario)
Destroy(ivo_Produto)
end event

event ue_postopen;call super::ue_postopen;Integer				lvi_Retorno, &
        				lvi_Linha

DataWindowChild	ldwc_Child

ivo_Usuario  = Create uo_Usuario
ivo_Produto = Create uo_Produto

ivm_Menu.ivb_Permite_Imprimir = True

dw_1.SetFocus ()
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 then
	dw_1.Retrieve ()
	dw_2.Retrieve ()
End If

Return AncestorReturnValue


end event

event ue_presave;call super::ue_presave;Integer	li_Retorno
Integer	li_Linha

Date	ldh_inicio
Date	ldh_fim

String	ls_Usuario

ls_Usuario = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

dw_2.AcceptText()

// Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700f500$$ENDHEX$$es na DataWindow
If dw_2.ModifiedCount() > 0 Then
	li_Retorno = MessageBox("Confirma$$HEX2$$e700e300$$ENDHEX$$o", "Voc$$HEX1$$ea00$$ENDHEX$$ deseja salvar as altera$$HEX2$$e700f500$$ENDHEX$$es?", Question!, YesNo!, 2)
	 
    If li_Retorno = 1 Then
        // Percorre todas as linhas para atualizar as colunas das linhas modificadas
        For li_Linha = 1 to dw_2.RowCount()
			
				ldh_inicio = date(dw_2.object.dh_inicio[li_linha])
				ldh_fim	= date(dw_2.object.dh_fim[li_linha])
				
				If ldh_fim < ldh_inicio Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de fim est$$HEX1$$e100$$ENDHEX$$ menor que a data de inicio.", Exclamation!)
					dw_2.Event ue_Pos(li_Linha, "dh_fim")
					Return False
				End If
				
				If DaysAfter(ldh_inicio, ldh_fim) > 90 THEN
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O intervalo entre a data de in$$HEX1$$ed00$$ENDHEX$$cio e fim $$HEX1$$e900$$ENDHEX$$ superior a 90 dias.", Exclamation!)
					dw_2.Event ue_Pos(li_Linha, "dh_fim")
					Return False
				End If
				
            // Verifica se a linha foi modificada ou est$$HEX1$$e100$$ENDHEX$$ em modo de nova modifica$$HEX2$$e700e300$$ENDHEX$$o
            If dw_2.GetItemStatus(li_Linha, 0, Primary!) = DataModified! or dw_2.GetItemStatus(li_Linha, 0, Primary!) = NewModified! then
                // Atualiza a data e a matr$$HEX1$$ed00$$ENDHEX$$cula do respons$$HEX1$$e100$$ENDHEX$$vel logado no sistema
                dw_2.SetItem(li_Linha, "dh_atualizacao", Today())
                dw_2.SetItem(li_Linha, "nr_matricula_atualizacao", ls_Usuario)
            End If
        Next

			dw_2.AcceptText()
			MessageBox("Confirmado", "As altera$$HEX2$$e700f500$$ENDHEX$$es foram realizadas com sucesso.")
			Return true
    Else
        MessageBox("Cancelado", "As altera$$HEX2$$e700f500$$ENDHEX$$es n$$HEX1$$e300$$ENDHEX$$o foram salvas.")
        Return false
    End If
Else
	If dw_2.DeletedCount() > 0 Then
		MessageBox("Sucesso", "As exclus$$HEX1$$f500$$ENDHEX$$es foram realizadas com sucesso.")
		Return true
   Else
		MessageBox("Aviso", "Nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o foi detectada.")
		Return true
	End if
End If
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge639_cadastro_produto_excecao_corte
integer y = 1612
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge639_cadastro_produto_excecao_corte
integer y = 1540
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge639_cadastro_produto_excecao_corte
integer width = 3899
integer height = 200
string dataobject = "dw_ge639_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
		
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then 
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto				[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto				[1] = ivo_Produto.De_Apresentacao_Venda
		End If				
		
	Case "nm_matricula"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Usuario.nm_usuario Then
				Return 1
			End If
		Else
			ivo_Usuario.of_Inicializa()
			
			This.Object.nr_matricula	[1] = ivo_Usuario.nr_matricula
			This.Object.nm_matricula	[1] = ivo_Usuario.nm_usuario
		End If
		
End Choose

dw_2.Event ue_Reset()
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;String	lvs_Coluna

lvs_Coluna = dw_1.GetColumnName ()

If Key = KeyEnter! Then
	Choose Case lvs_Coluna
			
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				dw_1.Object.Cd_Produto				[1] = ivo_Produto.Cd_Produto
				dw_1.Object.De_Produto				[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda	
			End If
		
		Case "nm_matricula"
				ivo_Usuario.of_Localiza_Usuario(This.GetText())
				
				This.Object.nr_matricula	[1] = ivo_Usuario.nr_matricula
				This.Object.nm_matricula	[1] = ivo_Usuario.nm_usuario
	
		End Choose
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge639_cadastro_produto_excecao_corte
integer y = 364
integer width = 4622
integer height = 1160
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge639_cadastro_produto_excecao_corte
integer width = 4078
integer height = 324
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge639_cadastro_produto_excecao_corte
integer x = 78
integer y = 432
integer width = 4549
integer height = 1080
string dataobject = "dw_ge639_lista_produto_excecao_corte_cd"
boolean hscrollbar = true
end type

event dw_2::constructor;call super::constructor;ivb_ordena_colunas = True
This.of_SetRowSelection()
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Id_situacao
String ls_Id_Vigencia
String ls_Nr_matricula

Datetime	ldh_Data_atual

Date	ldh_Atualizacao_inicio
Date	ldh_Atualizacao_fim
Date	ldh_Inicio
Date	ldh_Fim

Long	ll_Cd_Produto
Long	ll_Linhas


dw_1.AcceptText ()

ldh_Data_atual = gf_GetServerDate()


ldh_Inicio					= dw_1.Object.dh_inicio					[1]
ldh_Fim						= dw_1.Object.dh_termino				[1]
ldh_Atualizacao_inicio	= dw_1.Object.dh_atualizacao_inicio	[1]
ldh_Atualizacao_fim		= dw_1.Object.dh_atualizacao_fim		[1]
ls_Id_situacao				= dw_1.Object.id_situacao				[1]   
ls_Nr_matricula			= dw_1.Object.nr_matricula				[1]
ll_Cd_Produto				= dw_1.Object.cd_produto				[1]
ls_Id_Vigencia				= DW_1.Object.id_vigente				[1]

// Valida os filtros	
If ldh_Inicio > ldh_Fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor ou igual a de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If 

If ldh_Atualizacao_inicio > ldh_Atualizacao_fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor ou igual a de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "ldh_Atualizacao_inicio")
	Return -1
End If 
	
/// Adicionar as Condi$$HEX2$$e700f500$$ENDHEX$$es do Filtro
If Not IsNull(ldh_Inicio) Then
	This.of_AppendWhere ("pe.dh_inicio>='"+String(ldh_Inicio,'YYYYMMDD' )+"'")
End If
	
If Not IsNull(ldh_Fim) Then
	This.of_AppendWhere ("pe.dh_fim<='"+String(ldh_Fim,'YYYYMMDD' )+"'")
End If

If Not IsNull(ldh_Atualizacao_inicio) Then
	This.of_AppendWhere ("pe.dh_atualizacao>='"+String(ldh_Inicio,'YYYYMMDD' )+"'")
End If
	
If Not IsNull(ldh_Atualizacao_fim) Then
	This.of_AppendWhere ("pe.dh_atualizacao<='"+String(ldh_Atualizacao_fim,'YYYYMMDD' )+"'")
End If
	
If ls_Id_situacao<>"T"  Then	
	This.of_AppendWhere (" pe.id_situacao = '" + ls_Id_situacao + "'")
End If	

If Not IsNull(ll_Cd_Produto) Then
	This.of_AppendWhere ("pe.cd_produto = " +String(ll_Cd_Produto))
End If

If Not IsNull(ls_Nr_matricula) or Trim(ls_Nr_matricula) <> '' Then
    This.of_AppendWhere("pe.nr_matricula_atualizacao='" + ls_Nr_matricula + "'")
End If

If ls_Id_Vigencia = "A"  Then	
	This.of_AppendWhere("pe.id_situacao = 'A' AND pe.dh_inicio <= '" + String(ldh_Data_atual, 'YYYY-MM-DD') + "' AND pe.dh_fim >= '" + String(ldh_Data_atual, 'YYYY-MM-DD') + "'")
End If

ll_Linhas = dw_2.Retrieve ()

If ll_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo (True)
End If

Return ll_Linhas
end event

event dw_2::ue_addrow;//override

Long lvl_Linha

Integer lvi_Retorno

String ls_usuario
String ls_usuario_visual

ls_usuario_visual = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula + " - " + gvo_Aplicacao.ivo_Seguranca.nm_Usuario
ls_usuario			= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

	Parent.ivm_Menu.mf_Excluir(True)

	SetPointer(HourGlass!)

	If This.Event ue_PreInsertRow() = 1 Then
		lvl_Linha = This.InsertRow(0)
		
		// Preenche as colunas com os valores autom$$HEX1$$e100$$ENDHEX$$ticos
			dw_2.SetItem(lvl_Linha, "dh_inicio", Date(gf_GetServerDate()))
			dw_2.SetItem(lvl_Linha, "dh_fim", RelativeDate(Date(gf_GetServerDate()), 90))
			dw_2.SetItem(lvl_Linha, "dh_atualizacao", Today())
			dw_2.SetItem(lvl_Linha, "id_situacao", "A")
			dw_2.SetItem(lvl_Linha, "usuario_atualizacao", ls_usuario_visual)
			dw_2.SetItem(lvl_Linha, "nr_matricula_atualizacao", ls_usuario)
		
		// Posiciona na linha inclu$$HEX1$$ed00$$ENDHEX$$da
		This.ScrollToRow(lvl_Linha)
		This.SetRow(lvl_Linha)

		// Posiciona na primeira coluna com TabOrder < 0
		of_Posiciona_Coluna()

		lvi_Retorno = lvl_Linha
	Else
		lvi_Retorno = -1
	End If
	SetPointer(Arrow!)	

Return lvi_Retorno

end event

event dw_2::ue_key;call super::ue_key;DwItemStatus   ll_status

String	lvs_Coluna
String	ls_msg

Long		ll_Linha
Long		ll_cd_produto

ll_Linha = This.GetRow()

lvs_Coluna = dw_2.GetColumnName()

ll_status = This.GetItemStatus(ll_Linha, 0, Primary!)

If Key = KeyEnter! Then
	Choose Case lvs_Coluna
			
		Case "de_produto"
			
			If ll_status <> NewModified! AND ll_status <> New! THEN
				Return 1
			End If
			
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				ll_cd_produto = ivo_Produto.Cd_Produto
				
				// Verifica se pode inserir o produto
				If Not wf_verifica_insert_produto(ll_cd_produto, Ref ls_msg) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg)
					Return 0
				End If
				
				// Insere os valores somente ap$$HEX1$$f300$$ENDHEX$$s a valida$$HEX2$$e700e300$$ENDHEX$$o
				dw_2.Object.Cd_Produto				[ll_Linha] = ivo_Produto.Cd_Produto
				dw_2.Object.De_Produto				[ll_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If

		Case "cd_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				ll_cd_produto = ivo_Produto.Cd_Produto
				
				// Verifica se pode inserir o produto
				If Not wf_verifica_insert_produto(ll_cd_produto, Ref ls_msg) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg)
					Return 0
				End If
				
				// Insere os valores somente ap$$HEX1$$f300$$ENDHEX$$s a valida$$HEX2$$e700e300$$ENDHEX$$o
				dw_2.Object.Cd_Produto				[ll_Linha] = ivo_Produto.Cd_Produto
				dw_2.Object.De_Produto				[ll_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
		
	End Choose
End If
end event

event dw_2::itemchanged;call super::itemchanged;Long		ll_Linha
Long		ll_cd_produto

String	ls_msg

ll_Linha = This.GetRow()

Choose Case dwo.Name
		
	Case "de_produto"
	
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then 
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto				[ll_Linha] = ivo_Produto.Cd_Produto
			This.Object.De_Produto				[ll_Linha] = ivo_Produto.De_Apresentacao_Venda
			
			ll_cd_produto = ivo_Produto.Cd_Produto
			
			If Not wf_verifica_insert_produto(ll_cd_produto, Ref ls_msg) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg)
				Return 0
			End If
		
		End If
		
	Case "cd_produto"
		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then 
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto				[ll_Linha] = ivo_Produto.Cd_Produto
			This.Object.De_Produto				[ll_Linha] = ivo_Produto.De_Apresentacao_Venda
			
			If Not wf_verifica_insert_produto(ll_cd_produto, Ref ls_msg) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg)
				Return 0
			End If
			
		End If
End Choose
end event

