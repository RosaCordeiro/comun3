HA$PBExportHeader$w_ge601_aprovacao_pedido_empurrado_distr.srw
forward
global type w_ge601_aprovacao_pedido_empurrado_distr from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge601_aprovacao_pedido_empurrado_distr from dc_w_cadastro_selecao_lista
string tag = "w_ge601_aprovacao_pedido_empurrado_distr"
integer width = 7767
integer height = 1964
string title = "GE601 - Aprova$$HEX2$$e700e300$$ENDHEX$$o de Pedido Empurrado Distribuidora"
end type
global w_ge601_aprovacao_pedido_empurrado_distr w_ge601_aprovacao_pedido_empurrado_distr

type variables
uo_filial ivo_Filial
uo_Produto 	ivo_Produto

Boolean ivb_Check



		







end variables

forward prototypes
public subroutine _documentacao ()
end prototypes

public subroutine _documentacao ();
				

end subroutine

on w_ge601_aprovacao_pedido_empurrado_distr.create
call super::create
end on

on w_ge601_aprovacao_pedido_empurrado_distr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_Produto)
end event

event ue_postopen;call super::ue_postopen;Integer				lvi_Retorno, &
        				lvi_Linha

DataWindowChild	ldwc_Child

ivo_Filial  = Create uo_Filial
ivo_Produto = Create uo_Produto

ivm_Menu.ivb_Permite_Imprimir = True

dw_1.Object.dh_termino [1] = Date (gf_GetServerDate ())
dw_1.Object.dh_inicio  [1] = RelativeDate (dw_1.Object.dh_termino	[1], -15)

This.ivm_Menu.mf_Incluir (False)
This.ivm_Menu.mf_Excluir (False)

dw_1.SetFocus ()
end event

event ue_presave;call super::ue_presave;String	ls_Status, &
			ls_Selecionado, &
			ls_Cancelar, &
			ls_operacao

Long		ll_Qt_aprovada, &
			ll_Qt_pedida, &
			ll_Filial, &
			ll_NrPedido, &
			ll_Linha, &
			ll_Linhas, &
			ll_cd_produto

dw_2.AcceptText ()

ll_Linhas = dw_2.RowCount ()

For ll_Linha = 1 To ll_Linhas
	
	ll_Qt_aprovada	= dw_2.Object.qt_aprovada			 [ll_Linha]
	ll_Qt_pedida	= dw_2.Object.qtd_pedida		    [ll_Linha]
	ls_Status		= dw_2.Object.id_situacao			 [ll_Linha]
	ll_NrPedido		= dw_2.Object.nr_pedido_empurrado [ll_Linha]
	ll_Filial 		= dw_2.Object.cd_filial				 [ll_Linha]
	ls_Selecionado	= dw_2.Object.id_selecionado		 [ll_Linha]
	ls_Cancelar		= dw_2.Object.id_cancelar			 [ll_Linha]
	ll_cd_produto	= dw_2.Object.cd_produto			 [ll_Linha]
	
	// Controle :  N$$HEX1$$e300$$ENDHEX$$o pode Cancelar e Aprovar
	If ls_Cancelar = 'S' and ls_Selecionado = 'S' Then 
		SqlCa.of_RollBack()
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Aprovar e Cancelar n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido!', Exclamation!)
		dw_2.Object.id_situacao		[ll_Linha] = 'B'
		dw_2.Object.qt_aprovada		[ll_Linha] = 0
		dw_2.Object.id_selecionado [ll_Linha] = 'N'
		dw_2.Object.id_cancelar		[ll_Linha] = 'N'
		dw_2.Event ue_Pos (ll_Linha, 'qt_aprovada')
		Return False
	End If
	
	// Aprova$$HEX2$$e700e300$$ENDHEX$$o
	If ls_Selecionado = "S" Then	
		ls_operacao = "C"
	
		If ll_Qt_aprovada>ll_Qt_pedida Then
			SqlCa.of_RollBack()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quandidade Aprovada maior que a Pedida!", Information!)
			dw_2.Event ue_Pos(ll_Linha,"qt_aprovada")
			Return False
		End If
		
		If (ls_Status = 'C') and (ll_Qt_aprovada < 1) Then
			SqlCa.of_RollBack()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para pedidos com a situa$$HEX2$$e700e300$$ENDHEX$$o 'Colocado' ou 'Requer Aprova$$HEX2$$e700e300$$ENDHEX$$o', a quantidade aprovada deve ser maior do que zero!", Information!)
			dw_2.Event ue_Pos(ll_Linha,"qt_aprovada")
			Return False
		End If
	End If
Next

Return AncestorReturnValue
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 then
	dw_1.Retrieve ()
	dw_2.Retrieve ()
End If

This.ivm_Menu.mf_Excluir (False)

Return AncestorReturnValue
end event

event open;call super::open;ivb_Check = False

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento ('W_GE601_APROVACAO_PEDIDO_EMPURRADO_DISTR', ref is_Matricula_Abertura_Tela) then
	Return Close (This)
End If
end event

event ue_saveas;call super::ue_saveas;Integer	li_Retorno

String	ls_Path, &
			ls_Arquivo

If dw_2.RowCount () > 0 Then
	li_Retorno = GetFileSaveName ('Arquivo', ls_Path, ls_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')
	
	If li_Retorno = 1 then
		
		If dw_2.SaveAs (ls_Path, Excel!, True) = 1 Then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "O arquivo '" + ls_Path + "' foi salvo com sucesso.", Information!)
		Else
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao gerar o arquivo '" + ls_Path + "'.", StopSign!)
		End If
	End If
else
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ informa$$HEX2$$e700f500$$ENDHEX$$es!', Exclamation!)
End If
end event

event ue_update;call super::ue_update;String	ls_Status, &
			ls_Selecionado, &
			ls_Cancelar, &
			ls_operacao,&
			ls_Erro
			
			
Long		ll_qt_empurrada,&	
			ll_Qt_aprovada, &
			ll_Qt_pedida, &
			ll_cd_filial, &
			ll_nr_pedido_empurrado, &
			ll_Linha, &
			ll_Linhas, &
			ll_cd_produto

dw_2.AcceptText ()

ll_Linhas = dw_2.RowCount ()

For ll_Linha = 1 To ll_Linhas
	
	ll_nr_pedido_empurrado	= dw_2.Object.nr_pedido_empurrado [ll_Linha]
	ll_cd_filial 				= dw_2.Object.cd_filial				 [ll_Linha]

	Select Coalesce(sum(qt_empurrada), 0)
	into :ll_qt_empurrada
	from pedido_empurrado_produto
	where   cd_filial =:ll_cd_filial
	and      nr_pedido_empurrado=:ll_nr_pedido_empurrado
	and		id_situacao <> 'X'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro	= "Erro ao consultar a soma de 'qt_empurrada' na tabela 'pedido_empurrado_produto'. ~r~rErro: "+SqlCa.SqlErrText
		SqlCa.of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro)
		Return False
	End If
	
	If ll_qt_empurrada  =  0 Then
		Update pedido_empurrado
		set	id_situacao = 'X',
				dh_cancelamento = getdate(),
				nr_matricula_cancelamento = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		where cd_filial =:ll_cd_filial
		and   nr_pedido_empurrado = :ll_nr_pedido_empurrado
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro	= "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o pata cancelado do pedido na tabela 'pedido_empurrado'. ~r~rErro: "+SqlCa.SqlErrText
			SqlCa.of_RollBack()
			MessageBox("Erro", ls_Erro)
			Return False
		End If
	End If
Next

Return True
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge601_aprovacao_pedido_empurrado_distr
integer x = 3584
integer y = 200
integer width = 439
string dataobject = ""
end type

event dw_visual::ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino


lvdt_Inicio		= dw_1.Object.Dh_Inicio 	[1]
lvdt_Termino	= dw_1.Object.Dh_Termino	[1]


Return AncestorReturnValue
end event

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge601_aprovacao_pedido_empurrado_distr
integer x = 3557
integer y = 136
integer width = 498
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge601_aprovacao_pedido_empurrado_distr
integer x = 23
integer y = 76
integer width = 2843
integer height = 340
string dataobject = "dw_ge601_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;DataWindowChild	ldw_Child

dw_2.Event ue_Reset ()

Choose Case Dwo.name
	Case 'nm_filial'
		If Not IsNull (Data) and Trim (Data) <> '' then
			If Data <> ivo_Filial.Nm_Fantasia then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa ()
			
			This.Object.Cd_Filial [1] = ivo_Filial.Cd_Filial
			This.Object.nm_Filial [1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case 'de_produto'
		If Not IsNull (Data) and Trim (Data) <> '' then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa ()
			
			This.Object.cd_produto [1] = ivo_Produto.cd_produto
			This.Object.de_Produto [1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
End Choose
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection (True)
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset ()
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If	
end event

event dw_1::ue_key;call super::ue_key;String	lvs_Coluna

lvs_Coluna = dw_1.GetColumnName ()

If key = KeyEnter! Then
	Choose Case lvs_Coluna
		Case 'nm_filial'
			ivo_Filial.of_Localiza_Filial (This.GetText())
			
			// Verifica se a Filial foi localizada e atualiza a DW
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial [1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial [1] = ivo_Filial.Nm_Fantasia
			Else
				ivo_Filial.Of_inicializa ()
				This.Object.Cd_Filial [1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial [1] = ivo_Filial.Nm_Fantasia
			End If
			
		Case 'de_produto'
			ivo_Produto.of_Localiza_Produto (This.GetText ())
			
			If ivo_Produto.Localizado Then
				This.Object.cd_produto [1] = ivo_Produto.cd_produto
				This.Object.de_produto [1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
		
	End Choose
End If
end event

event dw_1::ue_cancel;//OverRide
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge601_aprovacao_pedido_empurrado_distr
integer x = 9
integer y = 440
integer width = 7698
integer height = 1152
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge601_aprovacao_pedido_empurrado_distr
integer x = 9
integer width = 2875
integer height = 420
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge601_aprovacao_pedido_empurrado_distr
integer x = 46
integer y = 496
integer width = 7648
integer height = 1248
string dataobject = "dw_ge601_lista"
boolean hscrollbar = true
end type

event dw_2::ue_postretrieve;//@OverRide

Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Excluir

String  ls_Situacao
		  
If pl_Linhas > 0 Then

	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar		= IsValid(This.ivo_Filter)
	lvb_Localizar	= IsValid(This.ivo_Find)
	
	lvb_Excluir = True

	This.SetRow(1)
	This.SetFocus()
	
	ivo_Controle_Menu.of_salvarcomo(True)
	ivo_Controle_Menu.of_imprimir(True)	
Else
	ivo_Controle_Menu.of_salvarcomo(False)
	ivo_Controle_Menu.of_imprimir(False)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

ivo_Controle_Menu.of_Excluir(False)

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Excluir(lvb_Excluir)

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	ls_StatusPedido

Long		ll_Linhas, &
			ll_Filial, &
			ll_NrPedido, &
			ll_CdProduto

Date		ldh_inicio, &
			ldh_fim			 

dw_1.AcceptText ()

ldh_inicio      = dw_1.Object.dh_inicio  [1]
ldh_fim   		 = dw_1.Object.dh_termino [1]
ll_Filial 		 = dw_1.Object.cd_filial  [1]  
ls_StatusPedido = dw_1.Object.cd_status  [1]   
ll_NrPedido		 = dw_1.Object.nr_pedido  [1]
ll_CdProduto	 = dw_1.Object.cd_produto [1]

// Valida os filtros
If IsNull(ldh_inicio) or Not IsDate(String(ldh_inicio, "dd/mm/yyyy"))Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If 	
	
If IsNull(ldh_fim) or Not IsDate(String(ldh_fim, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If 	
	
If ldh_inicio > ldh_fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor ou igual a de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If 	
	
/// Adicionar as Condi$$HEX2$$e700f500$$ENDHEX$$es do Filtro
If Not IsNull(ldh_inicio) Then
	This.of_AppendWhere ("a.dh_emissao>='"+String(ldh_Inicio,'YYYYMMDD' )+"'")
End If
	
If Not IsNull(ldh_fim) Then
	This.of_AppendWhere ("a.dh_emissao<='"+String(ldh_fim,'YYYYMMDD' )+"'")
End If
	
If ls_StatusPedido<>"T"  Then
	If ls_StatusPedido = "C" Or ls_StatusPedido = "B" Then
		This.of_AppendWhere ("coalesce(b.qt_faturada,0)=0")
	End If
	
	This.of_AppendWhere (" b.id_situacao = '" + ls_StatusPedido + "'")
End If	
	
If Not IsNull(ll_Filial)  Then
	This.of_AppendWhere (" b.cd_filial = " +String(ll_Filial))
End If	

If Not IsNull(ll_NrPedido) And ll_NrPedido > 0 Then
	This.of_AppendWhere ("a.nr_pedido_empurrado="+String(ll_NrPedido))
End If

If Not IsNull(ll_CdProduto) Then
	This.of_AppendWhere ("b.cd_produto = " +String(ll_CdProduto))
End If

ll_Linhas = dw_2.Retrieve ()

If ll_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo (True)
End If

Return ll_Linhas
end event

event dw_2::itemchanged;call super::itemchanged;String ls_idSituacaoAtual,&
		ls_Nulo, &
		ls_Situacao_Ant

Long   ll_Qt_Aprovada,&
		 ll_Qt_Pedida,&
		 ll_Qt_AprovadaData,&
		 ll_Filial,&
		 ll_NrPedido
		 
Date	ldt_Nulo		 

ls_idSituacaoAtual = This.Object.idsituacao          [row]
ll_Qt_Aprovada     = This.Object.qt_aprovada         [row]
ll_Qt_Pedida       = This.Object.qtd_pedida          [row]
ll_Filial          = This.Object.cd_filial           [row]
ll_NrPedido        = This.Object.nr_pedido_empurrado [row]
ls_Situacao_Ant    = This.Object.Id_Situacao_Ant     [row]

SetNull(ldt_Nulo)
SetNull(ls_Nulo)

Choose Case GetColumnName()
	Case "qt_aprovada"
		ll_Qt_Aprovada = Long (data)
		
		If ll_Qt_Aprovada>ll_Qt_Pedida Then 
		   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade aprovada maior que a pedida!")
		   This.Object.qt_aprovada[row] =ll_Qt_Pedida
		   This.Object.id_situacao[row] = 'C'	
		   Return 1 			
		End If
		
		If ll_Qt_aprovada=0 Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quandidade Aprovada deve ser maior que Zero", Information!)
			This.Object.qt_aprovada[row] = ll_Qt_Pedida
			dw_2.Event ue_Pos(dw_2.GetRow(),"qt_aprovada")
			Return 1
		End If
			
		If ll_Qt_aprovada<ll_Qt_pedida Then 
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade Aprovada $$HEX1$$e900$$ENDHEX$$ menor que a Pedida!."+".~rDeseja continuar?", Question!,YesNo!, 2) = 2 Then
				This.Object.qt_aprovada[row] = ll_Qt_Pedida
				dw_2.Event ue_Pos(dw_2.GetRow(),"qt_aprovada")
	 	     	Return 1   
			End If 	   
		End If

	// Campo Aprovado
	Case "id_selecionado"
		
		If data='S' Then 
			If ls_Situacao_Ant <> "B" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido com situa$$HEX2$$e700e300$$ENDHEX$$o REQUER APROVA$$HEX2$$c700c300$$ENDHEX$$O pode ser aprovado.", Exclamation!)
				Return 1
			End If
			
			This.Object.id_situacao						[row] = 'C'
			This.Object.qt_aprovada						[row] = ll_Qt_Pedida
			This.Object.dh_aprovacao					[row] = Datetime (String(Today(), "dd/mm/yyyy hh:mm:ss"))
			This.Object.nr_matricula_aprovacao		[row]	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
			This.Object.nm_usuario				   	[row] = gvo_Aplicacao.ivo_Seguranca.nm_usuario
			This.Object.id_cancelar						[row] = 'N'
			This.Object.dh_cancelamento				[row] = ldt_Nulo
			This.Object.nr_matricula_cancelamento	[row] = ls_NUlo
			This.Object.nm_resp_cancelamento			[row] = ls_NUlo
		else 
			This.Object.id_situacao						[row] = 'B'	
			This.Object.qt_aprovada						[row] = 0
			This.Object.dh_aprovacao					[row] = ldt_Nulo
			This.Object.nr_matricula_aprovacao		[row]	= ls_NUlo				
			This.Object.nm_usuario	   				[row] = ls_NUlo
		End If 	

	// Campo Cancelar
	Case "id_cancelar"		
		
		If data = "S" Then 
			If ls_Situacao_Ant <> "B" And ls_Situacao_Ant <> "C" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido com situa$$HEX2$$e700e300$$ENDHEX$$o REQUER APROVA$$HEX2$$c700c300$$ENDHEX$$O ou COLOCADO pode ser cancelado.", Exclamation!)
				Return 1
			End If
			
			This.Object.id_situacao						[row] = 'X'
			This.Object.qt_aprovada             	[row] = 0
			This.Object.nr_matricula_cancelamento	[row]	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
			This.Object.nm_resp_cancelamento		 	[row] = gvo_Aplicacao.ivo_Seguranca.nm_usuario
			This.Object.dh_cancelamento				[row] = Datetime (String(Today(), "dd/mm/yyyy hh:mm:ss"))
			This.Object.id_selecionado					[row] = 'N'
			This.Object.dh_aprovacao					[row] = ldt_Nulo
			This.Object.nr_matricula_aprovacao		[row]	= ls_NUlo				
			This.Object.nm_usuario				   	[row] = ls_NUlo
		Else
			This.Object.id_situacao						[row] = ls_idSituacaoAtual
			This.Object.qt_aprovada						[row] = 0
			This.Object.dh_cancelamento				[row] = ldt_Nulo
			This.Object.nr_matricula_cancelamento	[row] = ls_NUlo
			This.Object.nm_resp_cancelamento	   	[row] = ls_NUlo
		End If 	
End Choose
end event

event dw_2::ue_printimmediate;//OverRide
end event

event dw_2::ue_print;// OverRide

end event

event dw_2::constructor;call super::constructor;ivb_ordena_colunas = True
This.of_SetRowSelection()
end event

event dw_2::doubleclicked;call super::doubleclicked;String ls_Situacao

dw_1.AcceptText()
ls_Situacao  = dw_1.Object.cd_status[1]

If ls_Situacao<>'B' Then 
	This.Object.qt_aprovada.protect 	 = 1
	This.Object.id_situacao.protect 	 = 1		
	This.Object.id_selecionado.protect = 1
Else 
	If dw_2.RowCount() > 0 Then
			If dwo.Name = 'st_selecionado' Then
				Long lvl_Row		
				String lvs_Marcacao
				
				If ivb_Check Then
					lvs_Marcacao = 'N'
					ivb_Check = False
				Else
					lvs_Marcacao = 'S'
					ivb_Check = True
				End If
				
				For lvl_Row = 1 To This.RowCount()				
					If lvs_Marcacao="S" Then 
						This.Object.Id_Selecionado[lvl_Row] = lvs_Marcacao		
						This.Object.Id_Situacao[lvl_Row] 	= 'C'
						This.Object.qt_aprovada[lvl_Row] = This.Object.qtd_pedida[lvl_Row]
					Else 
						This.Object.Id_Selecionado[lvl_Row] = lvs_Marcacao		
						This.Object.Id_Situacao[lvl_Row] 	= 	'B'
						This.Object.qt_aprovada[lvl_Row] = 0
					End If 				
				Next		
			End If
	End If
End If 
end event

