HA$PBExportHeader$w_ge586_atualiza_registro_solicitacao.srw
forward
global type w_ge586_atualiza_registro_solicitacao from dc_w_cadastro_selecao_lista
end type
type cb_teste from commandbutton within w_ge586_atualiza_registro_solicitacao
end type
end forward

global type w_ge586_atualiza_registro_solicitacao from dc_w_cadastro_selecao_lista
string tag = "w_ge586_atualiza_registro_solicitacao"
integer width = 8526
integer height = 2108
string title = "GE586 - Verifica Solicita$$HEX2$$e700f500$$ENDHEX$$es Altera$$HEX2$$e700e300$$ENDHEX$$o Estoque Base"
cb_teste cb_teste
end type
global w_ge586_atualiza_registro_solicitacao w_ge586_atualiza_registro_solicitacao

type variables
uo_Filial ivo_Filial
uo_usuario ivo_Usuario
uo_produto ivo_Produto

String is_Operador, is_Nm_Operador, is_Lista_Nr_Solicitacao

Date  idt_Inicio
Date  idt_Fim

Long il_Lista_Nr_Solicitacao[]

Boolean ib_Capturou_Todos = False, &
			ib_Aprovou_Todos = False, &
			ib_Cancelou_Todos = False
end variables

forward prototypes
public subroutine wf_insere_padrao ()
public subroutine _documentacao ()
public function boolean wf_carrega_nome_operador (string as_matricula)
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*UF Filial*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

dw_1.Object.cd_uf[1] = "TD"
end subroutine

public subroutine _documentacao ();/*

Tela para acompanhamento das solicita$$HEX2$$e700f500$$ENDHEX$$es de altera$$HEX2$$e700e300$$ENDHEX$$o de Estoque base.

Tabelas:
resumo_reposicao_estoque_solic  
produto_geral
filial
usuario
resumo_reposicao_estoque
vw_saldo_atual_produto

*/
end subroutine

public function boolean wf_carrega_nome_operador (string as_matricula);SetNull(is_Nm_Operador)

SELECT nm_usuario  
INTO :is_Nm_Operador
FROM usuario 
where nr_matricula = :as_matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case -1
		Return False
End Choose
end function

on w_ge586_atualiza_registro_solicitacao.create
int iCurrent
call super::create
this.cb_teste=create cb_teste
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_teste
end on

on w_ge586_atualiza_registro_solicitacao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_teste)
end on

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Usuario)
Destroy(ivo_Produto)
end event

event ue_postopen;call super::ue_postopen;SetNull(is_Operador)

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE586_ATUALIZA_REGISTRO_SOLICITACAO", ref is_Operador) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o liberado, Solicitar o Acesso!")
	Close(This)
	Return
End If
gvo_Aplicacao.ivo_Seguranca.of_Localiza_Usuario(is_Operador)

If Not wf_carrega_nome_operador(is_Operador) Then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Problema ao carregar nome do operador.')
	Return
End If

Dw_1.Object.dt_inicio	[1] = gf_getserverdate()
Dw_1.Object.dt_fim	[1] = gf_getserverdate()

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_salvarcomo(False)
ivm_Menu.mf_imprimir(False)

//ivm_menu.ivb_permite_imprimir = True

end event

event ue_preopen;call super::ue_preopen;ivo_Filial   		= Create uo_Filial
ivo_Produto		= Create uo_Produto
ivo_Usuario		= Create uo_usuario 
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge586_atualiza_registro_solicitacao
integer y = 1924
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge586_atualiza_registro_solicitacao
integer x = 5
integer y = 1852
boolean enabled = false
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge586_atualiza_registro_solicitacao
integer y = 60
integer width = 1911
integer height = 480
string dataobject = "dw_ge586_selecao"
boolean livescroll = false
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Reset()

ivm_Menu.mf_salvarcomo(False)
ivm_Menu.mf_imprimir(False)
ivm_Menu.mf_incluir(False)

Choose Case dwo.name
	Case "de_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_inicializa( )
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia			
		End If
	Case "nm_produto"
		If Trim(Data) <> "" Then
			If Data <> (ivo_Produto.De_Produto+': '+ivo_Produto.de_apresentacao_venda) Then
				Return 1
			End If	
		Else			
			ivo_Produto.Of_inicializa( )
			
			This.Object.Cd_Produto 	[1] = ivo_Produto.Cd_Produto
			This.Object.Nm_produto	[1] = ''	
		End If		
		
	Case "nm_responsavel" 
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Usuario.nm_usuario Then
				Return 1
			End If
		Else
			ivo_Usuario.of_Inicializa()
			
			This.Object.nr_matricula_responsavel	[1] = ivo_Usuario.nr_matricula
			This.Object.nm_responsavel	  			[1] = ivo_Usuario.nm_usuario
		End If
End Choose		
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
End If	

If IsValid(ivo_Produto) Then 
	If ivo_Produto.Localizado Then
		This.Object.Nm_Produto [1] = ivo_Produto.de_produto+': '+ivo_produto.de_apresentacao_venda
	Else
		This.Object.Nm_Produto [1] = ''	
	End If
End If	

If IsValid(ivo_Usuario) Then
	This.Object.nr_matricula_responsavel	[1] = ivo_Usuario.nr_matricula
	This.Object.nm_responsavel 				[1] = ivo_Usuario.nm_usuario
End If

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_1::ue_key;call super::ue_key;String ls_Nulo

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_filial"		
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
			Else
				ivo_Filial.Of_Inicializa( )
				
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
			End If
			
		Case "nm_produto"	
			ivo_Produto.of_Localiza_produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				
				This.Object.Cd_Produto	[1] = ivo_Produto.Cd_Produto
				This.Object.Nm_Produto	[1] = ivo_produto.De_produto+': '+ivo_produto.de_apresentacao_venda
			Else
				ivo_Produto.Of_Inicializa( )
				
				This.Object.Cd_Produto	[1] = ivo_Produto.Cd_Produto
				This.Object.Nm_Produto	[1] = ''
			End If			
			
		Case "nm_responsavel" 
			ivo_Usuario.of_Localiza_Usuario(This.GetText())
			
			If ivo_Usuario.Localizado Then
				If ivo_Usuario.id_situacao <> "A" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O responsavel est$$HEX1$$e100$$ENDHEX$$ com a situa$$HEX2$$e700e300$$ENDHEX$$o '"+ivo_Usuario.id_situacao+"', n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser usado.")
					ivo_Usuario.of_Inicializa()
					This.Object.nr_matricula_responsavel	[1] = ls_Nulo
					This.Object.nm_responsavel  				[1] = ls_Nulo
					Return 1
				End If
				
				This.Object.nr_matricula_responsavel	[1] = ivo_Usuario.nr_matricula
				This.Object.nm_responsavel				[1] = ivo_Usuario.nm_usuario
			End If
	End Choose
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge586_atualiza_registro_solicitacao
integer x = 41
integer y = 572
integer width = 8430
integer height = 1348
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge586_atualiza_registro_solicitacao
integer width = 2030
integer height = 552
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge586_atualiza_registro_solicitacao
integer x = 55
integer y = 620
integer width = 8407
integer height = 1288
string dataobject = "dw_ge586_lista"
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;
This.ivm_menu.mf_Imprimir(pl_linhas > 0)
This.ivm_menu.mf_SalvarComo(pl_linhas > 0)

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_salvarcomo(False)
ivm_Menu.mf_imprimir(False)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	 ls_Situacao, ls_Matricula_Resp
		   
Date  ldt_Inicio
Date  ldt_Fim

Time lt_Inicio = time('00:00')
Time lt_Fim = time('23:59')

Long	ll_Filial		, &
     	ll_Nr_Solicitacao	, &
	  	ll_Produto	

dw_1.AcceptText()

ldt_Inicio		  		= Dw_1.Object.dt_inicio			[1]
ldt_Fim			 	= Dw_1.Object.dt_fim			[1]
ll_Filial       			= Dw_1.Object.Cd_Filial			[1]
ll_Produto			= Dw_1.Object.cd_produto		[1] 
ls_Situacao			= Dw_1.Object.id_situacao		[1] 
ll_Nr_Solicitacao	= Dw_1.Object.Nr_Solicitacao	[1]
ls_Matricula_Resp	= string(Dw_1.Object.nr_matricula_responsavel	[1])

idt_Inicio = ldt_Inicio
idt_Fim = ldt_Fim

If IsNull(ldt_Inicio) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o In$$HEX1$$ed00$$ENDHEX$$cio do Per$$HEX1$$ed00$$ENDHEX$$odo!")	
	dw_1.SetColumn("dt_inicio")
	Return -1
End If

If IsNull(ldt_fim) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o Fim do Per$$HEX1$$ed00$$ENDHEX$$odo!")	
	dw_1.SetColumn("dt_fim")
	Return -1
End If

If ldt_fim < ldt_Inicio Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data Fim do Per$$HEX1$$ed00$$ENDHEX$$odo n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a Data In$$HEX1$$ed00$$ENDHEX$$cio!")	
	dw_1.SetColumn("dt_fim")
	Return -1
End If

If ldt_fim >= ldt_Inicio Then
	This.of_AppendWhere(" rres.dh_solicitacao Between '"+ string(datetime(ldt_Inicio,lt_Inicio),'yyyy-mm-dd hh:mm') +"' and '" + string(datetime(ldt_Fim,lt_Fim),'yyyy-mm-dd hh:mm') + "'" ) 
End If

If Not IsNull(ll_Filial) and ll_Filial <> 0 Then
	This.of_AppendWhere(" rres.cd_filial = " + String(ll_Filial))
End If	

If Not IsNull(ll_Nr_Solicitacao) Then
	This.of_AppendWhere(" rres.nr_solicitacao = " + String(ll_Nr_Solicitacao))
End If	

If Not IsNull(ll_Produto) Then
	This.of_AppendWhere(" rres.cd_produto = " + String(ll_Produto))
End If

If Trim(ls_Matricula_Resp) <> '' Then
	This.of_AppendWhere(" rres.nr_matricula_responsavel = '" + ls_Matricula_Resp +"'")
End If

If ls_Situacao <> 'TD' Then
	Choose Case ls_Situacao
		Case 'SL' //Solicitado Loja
			This.Of_AppendWhere(" rres.id_situacao = '" + ls_Situacao +"'" )

		Case 'AT' //Aprovado Quantidade Total Solicitada
			This.Of_AppendWhere(" rres.id_situacao = '" + ls_Situacao +"'" )

		Case 'RS' //Rejeitada a solicitacao
			This.Of_AppendWhere(" rres.id_situacao = '" + ls_Situacao +"'" )

		Case 'AP' //Aprovado Quantidade Parcial
			This.Of_AppendWhere(" rres.id_situacao = '" + ls_Situacao +"'" )

		Case 'CP' //Solicita$$HEX2$$e700f500$$ENDHEX$$es Capturadas
			This.Of_AppendWhere(" rres.id_situacao = '" + ls_Situacao +"'" )
			
	End Choose
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]

lvs_Coluna = {"cd_filial", "nm_fantasia", "cd_produto", "de_produto", "cd_classe_reposicao",  "id_agrupamento",   "vl_fator_conversao", "qt_saldo_final", "qt_dias_venda", "qt_estoque_base_definido", "qt_estoque_base", "dias", "dh_termino_bloqueio", "dh_solicitacao", "qt_solicitacao", "qt_dias_solicitacao", "id_aprova_todos", "id_aprova_parcial", "qt_aprovado", "id_cancelar", "de_motivo", "nm_usuario_aprovacao", "id_capturar"}
lvs_Nome = {"Filial", "Nome Fantasia", "Produto", "Descricao : Apresentacao", "Classe", "Agrupamento",  "F.C.","Saldo","Venda", "Def.", "Atual","Dias","Ate" ,"Data Solicitacao", "Qt. Solic.", "Dias","Apr. Total", "Apr. Parc.", "Qt. Aprov", "Cancelar", "Motivo", "Colaborador", "Capturar"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		 

This.of_SetRowSelection()

ivb_ordena_colunas = True
end event

event dw_2::ue_cancel;call super::ue_cancel;//Dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
//Dw_1.Object.dt_fim	[1] = RelativeDate(Today(),+6)

Dw_1.Object.dt_inicio	[1] = idt_Inicio
Dw_1.Object.dt_fim	[1] = idt_Fim

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_salvarcomo(False)
ivm_Menu.mf_imprimir(False)
end event

event dw_2::clicked;call super::clicked;String ls_Parametro, &
		ls_Qtd_Solicitacao,  &
		ls_Id_Aprova_Parcial,  &
		ls_Parametro_Array[],  &
		ls_Id_Aprova_Todos,  &
		ls_Id_Capturar,  &
		ls_Id_Cancelar,  &
		ls_Id_Situacao,  &
		ls_Nr_Matricula, &
		ls_Nm_Usuario,  &
		ls_Nulo
		
Datetime ldt_Nulo

Long ll_Nulo

SetNull(ls_Nulo)
SetNull(ldt_Nulo)
SetNull(ll_Nulo)

If row <= 0 Then Return 

If row > 0 Then
	Choose Case dwo.name
		Case 'id_capturar'
			If Dw_2.Object.id_situacao[row] = 'SL' Then
				ls_Id_Capturar 	= Dw_2.Object.id_capturar	[row]
	
				If ls_Id_Capturar = 'N' Then
					Dw_2.Object.id_situacao						[row]	= 'CP'
					dw_2.Object.nr_matricula_responsavel	[row]	= is_Operador
					dw_2.Object.nm_usuario_aprovacao		[row]	= is_Nm_Operador
				End If
			Else
				ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[row]
				ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[row]
				
				If ls_Nr_Matricula = is_Operador Then
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a Descaptura desta solicita$$HEX2$$e700e300$$ENDHEX$$o?~nObs: Este processo limpar$$HEX1$$e100$$ENDHEX$$ os dados que foram preenchidos anteriormente.", Question!, YesNo!, 1) = 2 Then
						Dw_2.Object.id_capturar[row] = 'S'
						Return -1
					End If
					Dw_2.Object.qt_aprovado					[row]	= ll_Nulo
					Dw_2.Object.nr_matricula_responsavel	[row]	= ls_Nulo
					Dw_2.Object.dh_aprovacao					[row] = ldt_Nulo
					Dw_2.Object.id_situacao						[row]	= 'SL'
					Dw_2.Object.de_motivo						[row]	= ls_Nulo
					
					dw_2.Object.nr_matricula_responsavel	[row]	= ls_Nulo
					dw_2.Object.nm_usuario_aprovacao		[row]	= ls_Nulo
					
					Dw_2.Object.id_aprova_todos	[row] = 'N'
					Dw_2.Object.id_aprova_parcial	[row] = 'N'
					Dw_2.Object.id_cancelar			[row] = 'N'
				Else
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Somente o Colaborador '+ ls_Nm_Usuario + ' poder$$HEX1$$e100$$ENDHEX$$ descapturar esta solicita$$HEX2$$e700e300$$ENDHEX$$o.' )
					Dw_2.Object.id_capturar[row] = 'S'
					Return -1
				End If
			End If
			
		Case 'id_cancelar'
			If Dw_2.Object.id_situacao[row] = 'SL' Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Solicita$$HEX2$$e700e300$$ENDHEX$$o deve estar capturada para altera$$HEX2$$e700f500$$ENDHEX$$es!' )
				Return -1
			ElseIf Dw_2.Object.id_situacao[row] = 'CP' Then
				ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[row]
				ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[row]
				ls_Id_Cancelar = Dw_2.Object.id_cancelar						[row]
				
				If ls_Nr_Matricula = is_Operador Then
					If ls_Id_Cancelar = 'N' Then
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o Cancelamento/Rejei$$HEX2$$e700e300$$ENDHEX$$o desta solicita$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 1) = 2 Then
							Dw_2.Object.id_cancelar[row] = 'N'
							Return -1
						End If
						Open(w_ge586_motivo_cancelamento)
						
						ls_Parametro = Message.StringParm 
						
						If Not IsNull(ls_Parametro) Then
							Dw_2.Object.qt_aprovado					[row]	= 0
							Dw_2.Object.nr_matricula_responsavel	[row]	= is_Operador
							Dw_2.Object.dh_aprovacao					[row] = gf_getserverdate()
							Dw_2.Object.id_situacao						[row]	= 'RS'
							Dw_2.Object.de_motivo						[row]	= Message.StringParm
							
							Dw_2.Object.nm_usuario_aprovacao		[row]	= is_Nm_Operador
						Else
							Dw_2.Object.id_cancelar[row] = 'N'
							Return -1
						End If
					End If
				Else
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Somente o Colaborador '+ ls_Nm_Usuario + ' poder$$HEX1$$e100$$ENDHEX$$ alterar esta solicita$$HEX2$$e700e300$$ENDHEX$$o.' )
					Dw_2.Object.id_cancelar[row] = 'N'
					Return -1
				End If
			ElseIf Dw_2.Object.id_situacao[row] = 'AT' Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Solicita$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ Aprovada!' )
				Return -1
			ElseIf Dw_2.Object.id_situacao[row] = 'AP' Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Solicita$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ Aprovada!' )
				Return -1
			ElseIf Dw_2.Object.id_situacao[row] = 'RS' Then
				ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[row]
				ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[row]
				ls_Id_Cancelar = Dw_2.Object.id_cancelar						[row]
				
				If ls_Nr_Matricula = is_Operador Then
					If ls_Id_Cancelar = 'S' Then
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a reabertura desta solicita$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 1) = 2 Then
							Dw_2.Object.id_cancelar[row] = 'S'
							Return -1
						End If
						Dw_2.Object.qt_aprovado				[row]	= ll_Nulo
						//Dw_2.Object.nr_matricula_responsavel[row]	= ls_Nulo
						Dw_2.Object.dh_aprovacao				[row] = ldt_Nulo
						Dw_2.Object.id_situacao					[row]	= 'CP'
						Dw_2.Object.de_motivo					[row]	= ls_Nulo	
						Dw_2.Object.dh_envio_email			[row]	= ldt_Nulo
					End If
				Else
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Somente o Colaborador '+ ls_Nm_Usuario + ' poder$$HEX1$$e100$$ENDHEX$$ alterar esta solicita$$HEX2$$e700e300$$ENDHEX$$o.' )
					Dw_2.Object.id_cancelar[row] = 'N'
					Return -1
				End If
			End If
			
		Case 'id_aprova_todos'
			If Dw_2.Object.id_situacao[row] = 'SL' Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Solicita$$HEX2$$e700e300$$ENDHEX$$o deve estar capturada para altera$$HEX2$$e700f500$$ENDHEX$$es!' )
				Return -1
			ElseIf Dw_2.Object.id_situacao[row] = 'CP' Then
				ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[row]
				ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[row]
				ls_Id_Aprova_Todos = Dw_2.Object.id_aprova_todos			[row]
				
				If ls_Nr_Matricula = is_Operador Then
					If ls_Id_Aprova_Todos = 'N' Then
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a aprova$$HEX2$$e700e300$$ENDHEX$$o Total desta solicita$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 1) = 2 Then
							Dw_2.Object.id_aprova_todos[row] = 'N'
							Return -1
						End If
		
						Dw_2.Object.qt_aprovado					[row]	= Dw_2.Object.qt_solicitacao[row]
						Dw_2.Object.nr_matricula_responsavel	[row]	= is_Operador
						Dw_2.Object.dh_aprovacao					[row] = gf_getserverdate()
						Dw_2.Object.id_situacao						[row]	= 'AT'
						
						Dw_2.Object.nm_usuario_aprovacao		[row]	= is_Nm_Operador
					End If
				Else
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Somente o Colaborador '+ ls_Nm_Usuario + ' poder$$HEX1$$e100$$ENDHEX$$ alterar esta solicita$$HEX2$$e700e300$$ENDHEX$$o.' )
					Dw_2.Object.id_aprova_todos[row] = 'N'
					Return -1
				End If
			ElseIf Dw_2.Object.id_situacao[row] = 'AT' Then
				ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[row]
				ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[row]
				ls_Id_Aprova_Todos = Dw_2.Object.id_aprova_todos			[row]
				
				If ls_Nr_Matricula = is_Operador Then
					If ls_Id_Aprova_Todos = 'S' Then
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a reabertura desta solicita$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 1) = 2 Then
							Dw_2.Object.id_aprova_todos[row] = 'S'
							Return -1
						End If
						Dw_2.Object.qt_aprovado				[row]	= ll_Nulo
						//Dw_2.Object.nr_matricula_responsavel[row]	= ls_Nulo
						Dw_2.Object.dh_aprovacao				[row] = ldt_Nulo
						Dw_2.Object.id_situacao					[row]	= 'CP'
						Dw_2.Object.de_motivo					[row]	= ls_Nulo				
					End If
				Else
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Somente o Colaborador '+ ls_Nm_Usuario + ' poder$$HEX1$$e100$$ENDHEX$$ alterar esta solicita$$HEX2$$e700e300$$ENDHEX$$o.' )
					Dw_2.Object.id_cancelar[row] = 'N'
					Return -1
				End If
			ElseIf Dw_2.Object.id_situacao[row] = 'AP' Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Solicita$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ Aprovada!' )
				Return -1
			ElseIf Dw_2.Object.id_situacao[row] = 'RS' Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Solicita$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ como Rejeitada/Cancelada!' )
				Return -1
			End If
			
		Case 'id_aprova_parcial'
			If Dw_2.Object.id_situacao[row] = 'SL' Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Solicita$$HEX2$$e700e300$$ENDHEX$$o deve estar capturada para altera$$HEX2$$e700f500$$ENDHEX$$es!' )
				Return -1
			ElseIf Dw_2.Object.id_situacao[row] = 'CP' Then
				ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[row]
				ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[row]
				ls_Id_Aprova_Parcial = Dw_2.Object.id_aprova_parcial		[row]
				
				If ls_Nr_Matricula = is_Operador Then
					If ls_Id_Aprova_Parcial = 'N' Then
						ls_Qtd_Solicitacao = string(Dw_2.Object.qt_solicitacao[row])
						OpenWithParm(w_ge586_quantidade_parcial, ls_Qtd_Solicitacao) 
		
						ls_Parametro = Message.StringParm 
						
						If Not IsNull(ls_Parametro) Then
							//1 codigo, 2 texto motivo - separa pela posi$$HEX2$$e700e300$$ENDHEX$$o do ; 
							ls_Parametro_Array[1] = Left(ls_Parametro, ((Pos(ls_Parametro, ';')) - 1))
							ls_Parametro_Array[2] = Mid(ls_Parametro, ((Pos(ls_Parametro, ';')) + 1))
							
							Dw_2.Object.qt_aprovado					[row]	= Long(ls_Parametro_Array[1])
							Dw_2.Object.nr_matricula_responsavel	[row]	= is_Operador
							Dw_2.Object.dh_aprovacao					[row] = gf_getserverdate()
							Dw_2.Object.id_situacao						[row]	= 'AP'
							Dw_2.Object.de_motivo						[row]	= ls_Parametro_Array[2] 
							
							Dw_2.Object.nm_usuario_aprovacao		[row]	= is_Nm_Operador
						Else
							Dw_2.Object.id_aprova_parcial[row] = 'N'
							Return -1
						End If
					End If				
				Else
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Somente o Colaborador '+ ls_Nm_Usuario + ' poder$$HEX1$$e100$$ENDHEX$$ alterar esta solicita$$HEX2$$e700e300$$ENDHEX$$o.' )
					Dw_2.Object.id_aprova_parcial[row] = 'N'
					Return -1
				End If
			ElseIf Dw_2.Object.id_situacao[row] = 'AT' Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Solicita$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ aprovada!' )
				Return -1
			ElseIf Dw_2.Object.id_situacao[row] = 'AP' Then
				ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[row]
				ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[row]
				ls_Id_Aprova_Parcial = Dw_2.Object.id_aprova_parcial		[row]
				
				If ls_Nr_Matricula = is_Operador Then
					If ls_Id_Aprova_Parcial = 'S' Then
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a reabertura desta solicita$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 1) = 2 Then
							Dw_2.Object.id_aprova_parcial[row] = 'S'
							Return -1
						End If
						Dw_2.Object.qt_aprovado				[row]	= ll_Nulo
						//Dw_2.Object.nr_matricula_responsavel[row]	= ls_Nulo
						Dw_2.Object.dh_aprovacao				[row] = ldt_Nulo
						Dw_2.Object.id_situacao					[row]	= 'CP'
						Dw_2.Object.de_motivo					[row]	= ls_Nulo		
					End If
				Else
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Somente o Colaborador '+ ls_Nm_Usuario + ' poder$$HEX1$$e100$$ENDHEX$$ alterar esta solicita$$HEX2$$e700e300$$ENDHEX$$o.' )
					Dw_2.Object.id_cancelar[row] = 'N'
					Return -1
				End If
				
			ElseIf Dw_2.Object.id_situacao[row] = 'RS' Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Solicita$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ como Rejeitada/Cancelada!' )
				Return -1
			End If

	End Choose
End If

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_2::itemchanged;call super::itemchanged;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)


end event

event dw_2::editchanged;call super::editchanged;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_2::itemfocuschanged;call super::itemfocuschanged;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_2::losefocus;call super::losefocus;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_2::getfocus;call super::getfocus;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_2::doubleclicked;call super::doubleclicked;Long ll_Linha, ll_Qtd_Solicitacao, ll_Nulo
String ls_Nr_Matricula, ls_Nm_Usuario, ls_Id_Aprova_Todos, ls_Id_Capturar, ls_Mensagem, ls_Mensagem_2, ls_Nulo, ls_Id_Aprova_Parcial, ls_Parametro, ls_Id_Cancelar
Datetime ldt_Nulo

SetNull(ls_Nulo)
SetNull(ldt_Nulo)
SetNull(ll_Nulo)

Choose Case dwo.name
	Case 'id_aprova_todos_t'
		If ib_Aprovou_Todos Then
			ls_Mensagem = "Confirma a reabertura de todas as solicita$$HEX2$$e700f500$$ENDHEX$$es listadas vinculadas a voc$$HEX1$$ea00$$ENDHEX$$?"
		Else
			ls_Mensagem = "Confirma a aprova$$HEX2$$e700e300$$ENDHEX$$o TOTAL de TODAS as solicita$$HEX2$$e700f500$$ENDHEX$$es listadas?~nS$$HEX1$$f300$$ENDHEX$$ ir$$HEX1$$e100$$ENDHEX$$ aprovar as solicita$$HEX2$$e700f500$$ENDHEX$$es que j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e300$$ENDHEX$$o capturadas pelo usu$$HEX1$$e100$$ENDHEX$$rio atual do sistema."
		End If
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Question!, YesNo!, 1) = 2 Then
			Return -1
		End If
		
		ivw_ParentWindow.ivb_Valida_Salva = True
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)
		
		If ib_Aprovou_Todos Then 
			ib_Aprovou_Todos = False
			//Desmarca o aprovar todas de todas as solicita$$HEX2$$e700f500$$ENDHEX$$es vinculadas ao usuario atual
			For ll_Linha = 1 To dw_2.RowCount()
				If Dw_2.Object.id_situacao[ll_Linha] = 'AT' Then
					ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[ll_Linha]
					ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[ll_Linha]
					ls_Id_Aprova_Todos = Dw_2.Object.id_aprova_todos			[ll_Linha]
					
					If ls_Nr_Matricula = is_Operador Then
						If ls_Id_Aprova_Todos = 'S' Then
							Dw_2.Object.qt_aprovado				[ll_Linha]	= ll_Nulo
							Dw_2.Object.dh_aprovacao				[ll_Linha] = ldt_Nulo
							Dw_2.Object.id_situacao					[ll_Linha]	= 'CP'
							Dw_2.Object.de_motivo					[ll_Linha]	= ls_Nulo		
							Dw_2.Object.id_aprova_todos			[ll_Linha] = 'N'
						Else
							Continue
						End If
					Else
						Continue
					End If
				Else
					Continue
				End If
			Next
		Else
			ib_Aprovou_Todos = True
			//Aprova tudo de todas as solicita$$HEX2$$e700f500$$ENDHEX$$es capturadas pelo usuario atual
			For ll_Linha = 1 To dw_2.RowCount()
				If Dw_2.Object.id_situacao[ll_Linha] = 'CP' Then
					ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[ll_Linha]
					ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[ll_Linha]
					ls_Id_Aprova_Todos = Dw_2.Object.id_aprova_todos			[ll_Linha]
					
					If ls_Nr_Matricula = is_Operador Then
						If ls_Id_Aprova_Todos = 'N' Then
							Dw_2.Object.qt_aprovado					[ll_Linha]	= Dw_2.Object.qt_solicitacao[ll_Linha]
							Dw_2.Object.nr_matricula_responsavel	[ll_Linha]	= is_Operador
							Dw_2.Object.dh_aprovacao					[ll_Linha] = gf_getserverdate()
							Dw_2.Object.id_situacao						[ll_Linha]	= 'AT'
							Dw_2.Object.nm_usuario_aprovacao		[ll_Linha]	= is_Nm_Operador
							Dw_2.Object.id_aprova_todos				[ll_Linha] = 'S'
						Else
							Continue
						End If
					Else
						Continue
					End If
				Else
					Continue
				End If
			Next
		End If
	
	Case 'id_capturar_t'
		If ib_Capturou_Todos Then
			ls_Mensagem_2 = "Descapturar todas as solicita$$HEX2$$e700f500$$ENDHEX$$es listadas vinculadas a voc$$HEX1$$ea00$$ENDHEX$$?"
		Else
			ls_Mensagem_2 = "Confirma a Captura de TODAS as solicita$$HEX2$$e700f500$$ENDHEX$$es listadas sem respons$$HEX1$$e100$$ENDHEX$$vel para voc$$HEX1$$ea00$$ENDHEX$$?"
		End If
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem_2, Question!, YesNo!, 1) = 2 Then
			Return -1
		End If
		
		ivw_ParentWindow.ivb_Valida_Salva = True
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)
		
		If ib_Capturou_Todos Then 
			ib_Capturou_Todos = False
			//Descaptura as solicita$$HEX2$$e700f500$$ENDHEX$$es capturadas pelo usuario atual
			For ll_Linha = 1 To dw_2.RowCount()
				ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[ll_Linha]
				ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[ll_Linha]
				
				If ls_Nr_Matricula = is_Operador Then
					Dw_2.Object.qt_aprovado					[ll_Linha]	= ll_Nulo
					Dw_2.Object.nr_matricula_responsavel	[ll_Linha]	= ls_Nulo
					Dw_2.Object.dh_aprovacao					[ll_Linha] = ldt_Nulo
					Dw_2.Object.id_situacao						[ll_Linha]	= 'SL'
					Dw_2.Object.de_motivo						[ll_Linha]	= ls_Nulo
					
					dw_2.Object.nr_matricula_responsavel	[ll_Linha]	= ls_Nulo
					dw_2.Object.nm_usuario_aprovacao		[ll_Linha]	= ls_Nulo
					
					Dw_2.Object.id_aprova_todos	[ll_Linha] = 'N'
					Dw_2.Object.id_aprova_parcial	[ll_Linha] = 'N'
					Dw_2.Object.id_cancelar			[ll_Linha] = 'N'
					Dw_2.Object.id_capturar			[ll_Linha] = 'N'
				Else
					Continue
				End If
			Next
		Else
			ib_Capturou_Todos = True
			//Captura todas as solicita$$HEX2$$e700f500$$ENDHEX$$es sem responsavel
			For ll_Linha = 1 To dw_2.RowCount()
				If Dw_2.Object.id_situacao[ll_Linha] = 'SL' Then
					ls_Id_Capturar 	= Dw_2.Object.id_capturar	[ll_Linha]
			
					If ls_Id_Capturar = 'N' Then
						Dw_2.Object.id_situacao						[ll_Linha]	= 'CP'
						dw_2.Object.nr_matricula_responsavel	[ll_Linha]	= is_Operador
						dw_2.Object.nm_usuario_aprovacao		[ll_Linha]	= is_Nm_Operador
						Dw_2.Object.id_capturar						[ll_Linha]	= 'S'
					End If
				Else
					Continue
				End If
			Next
		End If
		
		Case 'id_cancelar_t'
			If ib_Cancelou_Todos Then
				ls_Mensagem = "Confirma a reabertura de todas as solicita$$HEX2$$e700f500$$ENDHEX$$es listadas vinculadas a voc$$HEX1$$ea00$$ENDHEX$$?"
			Else
				ls_Mensagem = "Confirma a REJEI$$HEX2$$c700c300$$ENDHEX$$O/CANCELAMENTO de todas as solicita$$HEX2$$e700f500$$ENDHEX$$es listadas?~n"+&
									"*S$$HEX1$$f300$$ENDHEX$$ ir$$HEX1$$e100$$ENDHEX$$ Cancelar as solicita$$HEX2$$e700f500$$ENDHEX$$es que est$$HEX1$$e300$$ENDHEX$$o capturadas para voc$$HEX1$$ea00$$ENDHEX$$ que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o aprovadas total ou parcial.~n"+&
									"**A observa$$HEX2$$e700e300$$ENDHEX$$o informada a seguir ser$$HEX1$$e100$$ENDHEX$$ a mesma para todas as solicita$$HEX2$$e700f500$$ENDHEX$$es que ser$$HEX1$$e300$$ENDHEX$$o canceladas."
			End If
			
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Question!, YesNo!, 1) = 2 Then
				Return -1
			End If

			ivw_ParentWindow.ivb_Valida_Salva = True
			Parent.ivm_Menu.mf_Confirmar(True)
			Parent.ivm_Menu.mf_Cancelar(True)
			
			If ib_Cancelou_Todos Then 
				ib_Cancelou_Todos = False
				//Reabre todas as solicita$$HEX2$$e700f500$$ENDHEX$$es vinculadas ao usuario atual
				For ll_Linha = 1 To dw_2.RowCount()
					If Dw_2.Object.id_situacao[ll_Linha] = 'RS' Then
						ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[ll_Linha]
						ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[ll_Linha]
						ls_Id_Cancelar 	= Dw_2.Object.id_cancelar						[ll_Linha]
						
						If ls_Nr_Matricula = is_Operador Then
							If ls_Id_Cancelar = 'S' Then
								Dw_2.Object.qt_aprovado				[ll_Linha]	= ll_Nulo
								Dw_2.Object.dh_aprovacao				[ll_Linha] = ldt_Nulo
								Dw_2.Object.id_situacao					[ll_Linha]	= 'CP'
								Dw_2.Object.de_motivo					[ll_Linha]	= ls_Nulo	
								Dw_2.Object.dh_envio_email			[ll_Linha]	= ldt_Nulo
								Dw_2.Object.id_cancelar					[ll_Linha] = 'N'
							Else
								Continue
							End If
						Else
							Continue
						End If
					Else
						Continue
					End If
				Next
			Else
				ib_Cancelou_Todos = True
				Open(w_ge586_motivo_cancelamento)		
				If Not IsNull(Message.StringParm ) Then
					ls_Parametro = Message.StringParm 
				Else
					ls_Parametro = ''
				End If
				//Rejeita todas as solicita$$HEX2$$e700f500$$ENDHEX$$es capturadas pelo usuario atual
				For ll_Linha = 1 To dw_2.RowCount()
					If Dw_2.Object.id_situacao[ll_Linha] = 'CP' Then
						ls_Nr_Matricula	= Dw_2.Object.nr_matricula_responsavel	[ll_Linha]
						ls_Nm_Usuario	= Dw_2.Object.nm_usuario_aprovacao		[ll_Linha]
						ls_Id_Aprova_Todos = Dw_2.Object.id_aprova_todos			[ll_Linha]
						ls_Id_Aprova_Parcial	= Dw_2.Object.id_aprova_parcial		[ll_Linha]
						
						If ls_Nr_Matricula = is_Operador Then
							If ls_Id_Aprova_Todos = 'N' And ls_Id_Aprova_Parcial = 'N' Then
								Dw_2.Object.qt_aprovado					[ll_Linha]	= 0
								Dw_2.Object.nr_matricula_responsavel	[ll_Linha]	= is_Operador
								Dw_2.Object.dh_aprovacao					[ll_Linha] = gf_getserverdate()
								Dw_2.Object.id_situacao						[ll_Linha]	= 'RS'
								Dw_2.Object.de_motivo						[ll_Linha]	= ls_Parametro
								Dw_2.Object.nm_usuario_aprovacao		[ll_Linha]	= is_Nm_Operador
								Dw_2.Object.id_cancelar						[ll_Linha] = 'S'
							Else
								Continue
							End If
						Else
							Continue
						End If
					Else
						Continue
					End If
				Next
			End If

End Choose

Return 1
end event

type cb_teste from commandbutton within w_ge586_atualiza_registro_solicitacao
boolean visible = false
integer x = 2299
integer y = 216
integer width = 530
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "testar-envio-email"
end type

event clicked;//uo_ge586_envio_email_automatico lo_envio
//Try
//	lo_envio = create uo_ge586_envio_email_automatico
//	lo_envio.of_verifica_processa()
//	// gf_atualiza_data_execucao_tarefa( 199 ,true)
//Finally
//	Destroy (lo_envio)
//End Try		
end event

