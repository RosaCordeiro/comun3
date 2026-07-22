HA$PBExportHeader$w_ge462_mix_produtos.srw
forward
global type w_ge462_mix_produtos from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge462_mix_produtos
end type
type dw_3 from dc_uo_dw_base within w_ge462_mix_produtos
end type
end forward

global type w_ge462_mix_produtos from dc_w_cadastro_selecao_lista
integer width = 3035
integer height = 1496
string title = "GE462 - Lista de Mix dos Produtos"
cb_1 cb_1
dw_3 dw_3
end type
global w_ge462_mix_produtos w_ge462_mix_produtos

type variables
uo_Produto					io_Produto
uo_ge242_mix_produto 	io_Mix

end variables

forward prototypes
public function boolean wf_le_dados_planilha (boolean ab_mostra_mensagem)
public function boolean wf_grava_historico_aba_estoque_mix ()
end prototypes

public function boolean wf_le_dados_planilha (boolean ab_mostra_mensagem);Any la_Dado
Boolean lvb_Localizado_Mix = False

DateTime ldh_Termino_Novo
DateTime ldh_Termino

Long ll_Linha
Long ll_Linhas
Long ll_Mix
Long ll_Find
Long ll_Linha_Dw = 0

String lvs_Arquivo,&
		 lvs_data,&
		 lvs_matricula

lvs_data = String ( gf_GetServerDate(), 'mm/dd/yyyy hh:mm:ss') 
lvs_Matricula = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

dw_2.Accepttext( )
dw_3.AcceptText()

dc_uo_excel lo_Excel
lo_Excel = Create dc_uo_excel

lvs_Arquivo = dw_3.Object.De_Arquivo[1]

Open(w_Aguarde)
w_Aguarde.Title = "Importando o arquivo..."

SetRedraw(False)

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	
	// C$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o
	ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas

			// L$$HEX1$$ea00$$ENDHEX$$ os dados do MIX Informado na Planilha		
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			lvb_Localizado_Mix = io_Mix.of_localiza_codigo(Long(la_Dado))			

			If Not IsNumber(String(la_Dado)) Then
				If ab_Mostra_Mensagem Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do Mix '" + String(la_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido.")
				End If				
				Continue
			End If
			
			If Not lvb_Localizado_Mix Then 
				If ab_Mostra_Mensagem Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do Mix '" + String(la_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido.")
				End If				
				Continue
			End If 

			// L$$HEX1$$ea00$$ENDHEX$$ os dados do Produto Informado na Planilha		
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
			io_Produto.of_Localiza_Produto(String(la_Dado))


			If Not IsNumber(String(la_Dado)) Then
				If ab_Mostra_Mensagem Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do Produto '" + String(la_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido.")
				End If				
				Continue
			End If
			
			If Not io_Produto.Localizado Then
				If ab_Mostra_Mensagem Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do Produto '" + String(la_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido.")
				End If				
				Continue				
			End If 
					
			ll_Linha_Dw++
			dw_2.Object.cd_mix_produto[ll_Linha_Dw] = io_Mix.cd_mix_produto
			dw_2.Object.de_mix_produto[ll_Linha_Dw] = io_Mix.de_mix_produto
			dw_2.Object.cd_produto		  [ll_Linha_Dw] = io_Produto.cd_produto
			dw_2.Object.de_produto       [ll_Linha_Dw] = io_Produto.de_apresentacao_estoque
			dw_2.Object.dh_alteracao     [ll_Linha_Dw] = lvs_data
			dw_2.Object.nr_matricula 	  [ll_Linha_Dw] = lvs_matricula
			
		Next
	End If
End If

SetRedraw(True)

dw_2.SetFocus()
dw_2.Sort()

If IsValid(lo_Excel) Then Destroy(lo_Excel)
ivm_Menu.mf_Excluir(False)
Close(w_Aguarde)

Return True
end function

public function boolean wf_grava_historico_aba_estoque_mix ();Long ll_Linha, ll_Find

String ls_Operador,& 
		ls_Nulo, &
		ls_Find, &
		ls_AlteraPara,&
		ls_Erro, &
		ls_Chave

String ls_Cd_Mix,&
          ls_Cd_Mix_Aux

dw_2.AcceptText()

SetNull(ls_Nulo)

ls_Operador = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

For ll_Linha = 1 To dw_2.RowCount()
		
	ls_Cd_Mix_Aux			= String ( dw_2.Object.Cd_Mix_Produto	[ll_Linha] ) 
	ls_Chave = ls_Cd_Mix_Aux
	
	select cast(cd_mix_produto as char)
	Into :ls_Cd_Mix
	from mix_produto_lista
	where cast(cd_mix_produto as char)=:ls_Cd_Mix_Aux 
	and     cd_produto=:io_Produto.Cd_Produto
	Using SqlCA;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If gf_Houve_Alteracao_Dw(dw_2, 'CD_MIX_PRODUTO', ll_Linha, ref ls_AlteraPara ) Then
				If Not gf_Grava_Historico_Alteracao_Tabela('MIX_PRODUTO_LISTA', 	String (io_Produto.Cd_Produto) , 'CD_MIX_PRODUTO', ls_Cd_Mix, ls_AlteraPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
			End If
		
		Case 100
			If Not gf_Grava_Historico_Alteracao_Tabela('MIX_PRODUTO_LISTA', 	String (io_Produto.Cd_Produto) , 'CD_MIX_PRODUTO', ls_Nulo, ls_Cd_Mix_Aux, ls_Operador, 'I', Ref ls_Erro, True) Then Return False			
		Case -1
			SqlCa.of_MsgdbError()
			Return False
	End Choose		
Next

//Verifica exclus$$HEX1$$e300$$ENDHEX$$o
Try
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("dw_ge400_tipo_mix") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'dw_ge400_tipo_mix'.")
		Return False
	End If
	
	lds.Retrieve(io_Produto.Cd_Produto)
	
	If lds.RowCount() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw_ge400_tipo_mix.", StopSign!)
		Return False
	End If
	
	For ll_Linha = 1 To lds.RowCount()
		ls_Find = ("cd_mix_produto = " +String(lds.Object.cd_mix_produto[ll_Linha]) )	
		ll_Find = dw_2.Find(ls_Find, 1, dw_2.RowCount())


		If ll_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_17.", StopSign!)
			Return False
		End If
		
		ls_Chave = String(lds.Object.cd_mix_produto[ll_Linha])
		
		
		If ll_Find = 0 Then
			If Not gf_Grava_Historico_Alteracao_Tabela('MIX_PRODUTO_LISTA', 	String (io_Produto.Cd_Produto), 'CD_MIX_PRODUTO', String(lds.Object.cd_mix_produto[ll_Linha]) , ls_Nulo, ls_Operador, 'E', Ref ls_Erro, True) Then Return False

		End If
	Next
	
	Return True
	
Finally	
	If IsValid(lds) Then Destroy(lds)
End Try


Return True 
end function

on w_ge462_mix_produtos.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_3
end on

on w_ge462_mix_produtos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_3)
end on

event close;call super::close;Destroy(io_Produto)
Destroy(io_Mix)
end event

event open;call super::open;io_Produto	= Create uo_Produto
io_Mix		= Create uo_ge242_mix_produto
end event

event ue_presave;call super::ue_presave;String  	lvs_data
String     lvs_Matricula

lvs_data = String ( gf_GetServerDate(), 'mm/dd/yyyy hh:mm:ss') 
lvs_Matricula = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	
dw_2.AcceptText()		

If dw_2.GetRow() > 0 Then
	dw_2.Object.dh_alteracao 		[dw_2.GetRow()] =  lvs_data 
	dw_2.Object.nr_matricula 	 	[dw_2.GetRow()]  = lvs_Matricula 
End If 

Return True 
end event

event ue_preupdate;call super::ue_preupdate;If Not IsNull(io_Produto.Cd_Produto) Then
	
	If Not wf_Grava_Historico_Aba_Estoque_Mix() Then Return False
	
End If

Return True

end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge462_mix_produtos
integer y = 1636
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge462_mix_produtos
integer y = 1564
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge462_mix_produtos
integer x = 73
integer y = 72
integer width = 1824
integer height = 180
string dataobject = "dw_ge462_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If GetColumnName() = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If io_Produto.Localizado Then
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.De_Produto + " : " + io_Produto.De_Apresentacao_Venda
		Else
			io_Produto.of_Inicializa()
		End If
	End If
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge462_mix_produtos
integer y = 284
integer width = 2930
integer height = 880
integer weight = 700
fontcharset fontcharset = ansi!
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge462_mix_produtos
integer width = 1961
integer height = 264
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge462_mix_produtos
integer x = 78
integer y = 348
integer width = 2880
integer height = 800
string dataobject = "dw_ge462_mix_produtos"
end type

event dw_2::ue_key;call super::ue_key;Boolean lvb_Localizado_Mix = False

If Key = KeyEnter! Then
	If GetColumnName() = "cd_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If io_Produto.Localizado Then
			This.Object.Cd_Produto[GetRow()] = io_Produto.Cd_Produto
			This.Object.De_Produto[GetRow()] = io_Produto.De_Produto + " : " + io_Produto.De_Apresentacao_Venda
		Else
			io_Produto.of_Inicializa()
		End If
	End If
	
	If GetColumnName() = "cd_mix_produto" Then
		lvb_Localizado_Mix = io_Mix.of_localiza_codigo(Long(This.GetText()))
		
		If lvb_Localizado_Mix Then
			This.Object.cd_mix_produto[This.GetRow()] = io_Mix.cd_mix_produto
			This.Object.de_mix_produto[This.GetRow()] = io_Mix.de_mix_produto
		Else
			io_Mix.of_localiza( )
			This.Object.cd_mix_produto[This.GetRow()] = io_Mix.cd_mix_produto
			This.Object.de_mix_produto[This.GetRow()] = io_Mix.de_mix_produto

		End If
	End If	
	
End If


end event

event dw_2::itemchanged;call super::itemchanged;Boolean lvb_Localizado_Mix = False

Choose Case dwo.Name
	Case "cd_produto"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque	Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.cd_produto[This.GetRow()] = io_Produto.cd_produto
			This.Object.de_Produto[This.GetRow()] = io_Produto.ivs_Descricao_Apresentacao_Estoque		
		End If
		
		
	Case "cd_mix_produto"		
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> String(io_Mix.cd_mix_produto)	Then
				Return 1
			End If
		Else
			io_Mix.of_Inicializa()
			lvb_Localizado_Mix = io_Mix.of_localiza_codigo(Long(This.GetText()))
			io_Mix.of_localiza( )
			This.Object.cd_mix_produto[This.GetRow()] = io_Mix.cd_mix_produto
			This.Object.de_mix_produto[This.GetRow()] = io_Mix.de_mix_produto		
		End If		
			
End Choose
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long 	ll_Mix,&
		ll_Cd_Produto,&
		ll_Linhas


dw_1.accepttext( )

ll_Mix = dw_1.Object.cd_mix_produto[1]
ll_Cd_Produto = dw_1.Object.cd_produto[1]

If Not IsNull(ll_Mix)  Then
	This.of_AppendWhere("a.cd_mix_produto  = " + String(ll_Mix))
End If

If Not IsNull(ll_Cd_Produto) Then
	This.of_AppendWhere("b.cd_produto =  " + String(ll_Cd_Produto))
End If

ll_Linhas = dw_2.Retrieve()

If ll_Linhas	> 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
End If

Return ll_Linhas
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;String  ls_Situacao

If pl_Linhas > 0 Then
	ivo_Controle_Menu.of_salvarcomo(True)
	ivo_Controle_Menu.of_imprimir(True)	
	ivo_Controle_Menu.of_Excluir(True)
Else
	ivo_Controle_Menu.of_salvarcomo(False)
	ivo_Controle_Menu.of_imprimir(False)
End If

Return pl_Linhas
end event

type cb_1 from commandbutton within w_ge462_mix_produtos
integer x = 2533
integer y = 1176
integer width = 434
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Importar Excel"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_3.AcceptText()

If dw_2.RowCount() > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha j$$HEX1$$e100$$ENDHEX$$ foi importada. Deseja desfazer e import$$HEX1$$e100$$ENDHEX$$-la novamente?", Question!, YesNo!, 2) = 2 Then
		Return -1
	Else
		dw_3.Reset()
	End If
End If
	
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r" + &
				"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo do Mix" + &
				"~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo do Produto"	)
				
li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_3.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	If Not wf_Le_Dados_Planilha(True) Then
		Return -1
	End If
	
	ivb_Valida_Salva = True
	ivm_Menu.mf_Cancelar(True)
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Excluir(False)
Else
	SetNull(ls_Nulo)
	dw_3.Object.De_Arquivo[1] = ls_Nulo
End If
end event

type dw_3 from dc_uo_dw_base within w_ge462_mix_produtos
integer x = 41
integer y = 1180
integer width = 1847
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge462_selecao_arquivo"
end type

