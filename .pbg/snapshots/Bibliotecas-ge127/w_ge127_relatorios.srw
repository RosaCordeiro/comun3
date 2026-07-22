HA$PBExportHeader$w_ge127_relatorios.srw
forward
global type w_ge127_relatorios from dc_w_selecao_lista_relatorio
end type
type cb_aumentar_zoom from commandbutton within w_ge127_relatorios
end type
type cb_diminuir_zoom from commandbutton within w_ge127_relatorios
end type
end forward

global type w_ge127_relatorios from dc_w_selecao_lista_relatorio
string accessiblename = "Relat$$HEX1$$f300$$ENDHEX$$rios para Autoridade Sanit$$HEX1$$e100$$ENDHEX$$ria Local (GE127)"
integer width = 3630
integer height = 2120
string title = "GE127 - Relat$$HEX1$$f300$$ENDHEX$$rios para Autoridade Sanit$$HEX1$$e100$$ENDHEX$$ria Local"
cb_aumentar_zoom cb_aumentar_zoom
cb_diminuir_zoom cb_diminuir_zoom
end type
global w_ge127_relatorios w_ge127_relatorios

type variables
Date idt_Inicio_Periodo
Date idt_Termino_Periodo
end variables

forward prototypes
public subroutine wf_configura_inicio_termino_periodo ()
public subroutine wf_preview (boolean pb_preview)
public function boolean wf_appendwhere_log ()
public function boolean wf_preenche_cabecalho ()
public function boolean wf_recupera_cadastro_historico (string ps_relatorio)
end prototypes

public subroutine wf_configura_inicio_termino_periodo ();Integer li_Ano_Exercicio
Integer li_Mes
Integer li_Trimestre
Integer li_Mes_Termino

String ls_Tipo_Periodo

dw_1.AcceptText()

ls_Tipo_Periodo = dw_1.Object.Id_Tipo_Periodo[1]

Choose Case ls_Tipo_Periodo
	Case 'M' // Mensal - M$$HEX1$$ea00$$ENDHEX$$s completo, mesmo que selecionado o m$$HEX1$$ea00$$ENDHEX$$s corrente
		li_Mes				= dw_1.Object.Nr_Mes			[1]
		li_Ano_Exercicio	= dw_1.Object.Nr_Ano_Mensal	[1]
		
		idt_Inicio_Periodo		= Date("01/" + String( li_Mes, "00" ) + "/" + String( li_Ano_Exercicio, "0000" ) )
		idt_Termino_Periodo	= gf_Calcula_Ultimo_Dia_Mes( Month( idt_Inicio_Periodo ), li_Ano_Exercicio )
		
	Case 'T' // Trimestral - Sempre Trimestre Completo, mesmo que selecionado trimestre corrente.
		li_Trimestre			= dw_1.Object.Nr_Trimestre		[1]
		li_Ano_Exercicio	= dw_1.Object.Nr_Ano_Trimestre	[1]
		
		// Para o m$$HEX1$$ea00$$ENDHEX$$s de in$$HEX1$$ed00$$ENDHEX$$cio do trimestre $$HEX1$$e900$$ENDHEX$$ calculado o ( trimestre selecionado * 3 - 2 ), como exemplo o trimestre 2
		// Ser$$HEX1$$e100$$ENDHEX$$ ( 2 * 3 - 2 ) = 4
		idt_Inicio_Periodo		= Date("01/" + String( li_Trimestre *3 -2, "00" ) + "/" + String( li_Ano_Exercicio, "0000" ) )

		// Para o m$$HEX1$$ea00$$ENDHEX$$s de t$$HEX1$$e900$$ENDHEX$$rmino do trimestre $$HEX1$$e900$$ENDHEX$$ calculado o ( trimestre selecionado * 3 ), como exemplo o trimestre 2
		// Ser$$HEX1$$e100$$ENDHEX$$ ( 2 * 3 ) = 6
		idt_Termino_Periodo	= gf_Calcula_Ultimo_Dia_Mes( li_Trimestre *3, li_Ano_Exercicio )
		
	Case 'A' // Anual - Ano completo, mesmo que selecionado o ano corrente
		li_Ano_Exercicio = dw_1.Object.Nr_Ano_Exercicio[1]

		idt_Inicio_Periodo		= Date("01/01/" + String( li_Ano_Exercicio, "0000" ) )
		idt_Termino_Periodo	= gf_Calcula_Ultimo_Dia_Mes( 12, li_Ano_Exercicio )

	Case 'E'
		idt_Inicio_Periodo		= Date( dw_1.Object.Dh_Inicio		[1] )
		idt_Termino_Periodo	= Date( dw_1.Object.Dh_Termino	[1] )
		
		If idt_Inicio_Periodo > idt_Termino_Periodo Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data de t$$HEX1$$e900$$ENDHEX$$rmino do per$$HEX1$$ed00$$ENDHEX$$odo." )
			dw_1.Event ue_Pos( 1, 'dh_inicio' )	
		End If
End Choose
	
end subroutine

public subroutine wf_preview (boolean pb_preview);Integer ll_PageCount

String ls_Tipo_Relatorio
String ls_Grupo_Psico

dw_1.AcceptText()

dw_2.Modify("datawindow.print.preview=yes")
dw_2.Object.Datawindow.Print.Preview.Zoom=100

If pb_Preview Then
	ls_Tipo_Relatorio	= dw_1.Object.Id_Tipo_Relatorio	[1]
	ls_Grupo_Psico		= dw_1.Object.Cd_Grupo_Psico	[1]
	
	// Captura o n$$HEX1$$fa00$$ENDHEX$$mero de p$$HEX1$$e100$$ENDHEX$$ginas do relat$$HEX1$$f300$$ENDHEX$$rio
	ll_PageCount = Long( dw_2.Describe( "evaluate( 'pagecount() '," + String( dw_2.RowCount() ) + ")" ) )
	
	Choose Case dw_2.DataObject
		Case 'dw_ge127_balancos_comp'
			dw_2.Object.dw_Header.Object.st_Total_Paginas.Text = "TOTAL DE P$$HEX1$$c100$$ENDHEX$$GINAS: " + String( ll_PageCount - 1 )
					
			If ls_Tipo_Relatorio = 'C' Then
				dw_2.Object.dw_Header.Object.st_tipo_relatorio.Text = "BALAN$$HEX1$$c700$$ENDHEX$$O COMPLETO DE MEDICAMENTOS"
			End If
			
		Case 'dw_ge127_relatorio_rm_comp'
			If ls_Tipo_Relatorio = 'M' Then
				
				If ls_Grupo_Psico = 'RMNRB2' Then
					dw_2.Object.dw_Header.Object.st_tipo_relatorio.Text = "RELA$$HEX2$$c700c300$$ENDHEX$$O MENSAL DE NOTIFICA$$HEX2$$c700d500$$ENDHEX$$ES DE RECEITA 'B2' (RMNRB2)"
				End If
			End If
			
	End Choose
	
	cb_Diminuir_Zoom.Visible	= True
	cb_Aumentar_Zoom.Visible	= True
	dw_2.Visible					= True

	This.Width	= 3663
	This.Height	= 2080
Else
	cb_Diminuir_Zoom.Visible	= False
	cb_Aumentar_Zoom.Visible	= False
	dw_2.Visible					= False	

	This.Width	= 3050
	This.Height	= 630
End If
end subroutine

public function boolean wf_appendwhere_log ();String ls_Alteracao
String ls_Insercao
String ls_Login
String ls_Remocao
String ls_Opcao
String ls_Classe_Terapeutica
String ls_Like
String ls_Appendwhere

dw_1.AcceptText()

ls_Alteracao					= dw_1.Object.Alteracao						[1]
ls_Insercao					= dw_1.Object.Insercao						[1]
ls_Login						= dw_1.Object.Login							[1]
ls_Remocao					= dw_1.Object.Remocao						[1]
ls_Classe_Terapeutica	= dw_1.Object.Id_Classe_Terapeutica	[1]

Choose Case ls_Classe_Terapeutica
	Case 'P' 
		ls_Like = "psico"
	
	Case 'W'
		ls_Like = "antimicrobiano"
End Choose

If ls_Alteracao = 'S' Then
	ls_Opcao += ",'U'"
End If

If ls_Insercao = 'S' Then
	ls_Opcao += ",'I'"
End If

If ls_Remocao = 'S' Then
	ls_Opcao += ",'D'"
End If

ls_Opcao = MidA(ls_Opcao, 2)

If ls_Login = 'S' Then
	If ls_Alteracao = 'S' Or ls_Insercao = 'S' Or ls_Remocao = 'S' Then
		ls_Appendwhere = "(u.id_acao = 'L' or u.id_acao in (" + ls_Opcao + "))"
		
		If ls_Classe_Terapeutica <> 'T' Then
			ls_Appendwhere = "(u.id_acao = 'L' or (u.id_acao in (" + ls_Opcao + ") and (lower(u.valor_anterior) like '%" + ls_Like + "%' or lower(u.valor_novo) like '%" + ls_Like + "%')))"
		End If
		
		dw_2.of_AppendWhere( ls_Appendwhere )
	Else
		dw_2.of_AppendWhere("u.id_acao = 'L'")
	End If		
Else
	If ls_Alteracao = 'S' Or ls_Insercao = 'S' Or ls_Remocao = 'S' Then
		ls_Appendwhere = "u.id_acao in (" + ls_Opcao + ")"
		
		If ls_Classe_Terapeutica <> 'T' Then
			ls_Appendwhere = "(u.id_acao in (" + ls_Opcao + ") and (lower(u.valor_anterior) like '%" + ls_Like + "%' or lower(u.valor_novo) like '%" + ls_Like + "%'))"
		End If
		
		dw_2.of_AppendWhere( ls_Appendwhere )
	End If
End If

Return True
end function

public function boolean wf_preenche_cabecalho ();String ls_Nr_Licenca
String ls_Tipo_Relatorio

dw_1.AcceptText()

ls_Tipo_Relatorio = dw_1.Object.Id_Tipo_Relatorio[1]

SELECT nr_licenca_vig_sanitaria
INTO :ls_Nr_Licenca
FROM filial
WHERE cd_filial = :gvo_Parametro.Cd_Filial
USING SqlCa;

Choose Case SqlCa.SqlCode
		
	Case 0
		
		If ls_Tipo_Relatorio = 'L' Then	
			dw_2.Object.Nr_Licenca_Vig_Sanitaria	[1] = ls_Nr_Licenca
			dw_2.Object.Nr_Cgc							[1] = String(gvo_Parametro.Nr_Cgc, "@@.@@@.@@@/@@@@-@@")
			dw_2.Object.Cd_Uf							[1] = gvo_Parametro.ivs_Uf_Filial
			dw_2.Object.Cd_Filial							[1] = gvo_Parametro.Cd_Filial
			dw_2.Object.Nm_Fantasia					[1] = gvo_Parametro.Nm_Fantasia_Filial
			dw_2.Object.Nm_Razao_Social				[1] = gvo_Parametro.Nm_Razao_Social
		Else
		
			dw_2.Object.dw_Detalhe.Object.Nr_Licenca_Vig_Sanitaria	[1] = ls_Nr_Licenca
			dw_2.Object.dw_Detalhe.Object.Nr_Cgc							[1] = gvo_Parametro.Nr_Cgc
			dw_2.Object.dw_Detalhe.Object.Cd_Uf							[1] = gvo_Parametro.ivs_Uf_Filial
			dw_2.Object.dw_Detalhe.Object.Nm_Fantasia					[1] = gvo_Parametro.Nm_Fantasia_Filial
			
			If ls_Tipo_Relatorio = 'C' Then
				dw_2.Object.dw_Detalhe.Object.Cd_Filial[1] = String(gvo_Parametro.Cd_Filial)
			End If
			
			If ls_Tipo_Relatorio = 'A' Then
				dw_2.Object.dw_Detalhe.Object.Cd_Filial[1] = gvo_Parametro.Cd_Filial
			End If
		End If
					
		Return True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi localizado o n$$HEX1$$fa00$$ENDHEX$$mero da licen$$HEX1$$e700$$ENDHEX$$a da vigil$$HEX1$$e200$$ENDHEX$$ncia.", StopSign!)
		
	Case - 1
		SqlCa.of_MsgdbError()
		
End Choose

Return False
end function

public function boolean wf_recupera_cadastro_historico (string ps_relatorio);Date ldt_Movimento
DateTime ldh_Movimento_Aquisicao

Long ll_Produto
Long ll_Linha
Long ll_Linhas

String ls_De_Produto
String ls_Apresentacao
String ls_Grupo_Psico
String ls_Registro_Ms
String ls_Fabricante
String ls_DCB

dw_2.AcceptText()

DataWindowChild ldwc_Child

If dw_2.GetChild('dw_detalhe', ldwc_Child) = 1 Then
	ll_Linhas = ldwc_Child.RowCount()
End If

ldt_Movimento = idt_Termino_Periodo

For ll_Linha = 1 To ll_Linhas
	
	ll_Produto = dw_2.Object.dw_Detalhe.Object.Cd_Produto[ll_Linha]
	
	If ps_Relatorio = 'A' Then
		ldh_Movimento_Aquisicao = dw_2.Object.dw_Detalhe.Object.Dh_Aprovacao_Farmaceutico[ll_Linha]
		ldt_Movimento = Date(ldh_Movimento_Aquisicao)
	End If
	
	SELECT	de_produto,
				de_apresentacao_venda,
				cd_grupo_psico,
				uf_Mascara_Campo( 'REGISTRO_MS', de_registro_ms ),
				de_dcb,
				nm_fabricante
		INTO	:ls_De_Produto,
				:ls_Apresentacao,
				:ls_Grupo_Psico,
				:ls_Registro_MS,
				:ls_DCB,
				:ls_Fabricante
		FROM uf_recupera_cadastro_produto_historico( :idt_Inicio_Periodo, :ldt_Movimento, :ll_Produto )
	USING SqlCa;
  
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError( )
			Return False
			
		Case 100
			//Se n$$HEX1$$e300$$ENDHEX$$o encontrar resultados, significa que o produto n$$HEX1$$e300$$ENDHEX$$o teve altera$$HEX2$$e700e300$$ENDHEX$$o no cadastro no per$$HEX1$$ed00$$ENDHEX$$odo informado
			
		Case 0
			If IsNull( ls_Grupo_Psico )	Then ls_Grupo_Psico		= ""
			If IsNull( ls_De_Produto ) 	Then ls_De_Produto		= ""
			If IsNull( ls_Apresentacao )	Then ls_Apresentacao	= ""
			If IsNull( ls_Registro_MS )	Then ls_Registro_MS		= ""
			If IsNull( ls_Fabricante )		Then ls_Fabricante		= ""
			If IsNull( ls_DCB )				Then ls_DCB				= ""		
	
			dw_2.Object.dw_Detalhe.Object.De_Produto					[ll_Linha]	= ls_De_Produto
			dw_2.Object.dw_Detalhe.Object.De_Apresentacao_Venda	[ll_Linha]	= ls_Apresentacao
			dw_2.Object.dw_Detalhe.Object.Cd_Grupo_Psico				[ll_Linha]	= ls_Grupo_Psico
			dw_2.Object.dw_Detalhe.Object.De_Registro_Ms				[ll_Linha]	= ls_Registro_MS
			dw_2.Object.dw_Detalhe.Object.De_Dcb							[ll_Linha]	= ls_DCB
			
			If ps_Relatorio = 'C' Then
				dw_2.Object.dw_Detalhe.Object.De_Fabricante[ll_Linha] = ls_Fabricante
			End If
			
	End Choose
	
Next

Return True
end function

on w_ge127_relatorios.create
int iCurrent
call super::create
this.cb_aumentar_zoom=create cb_aumentar_zoom
this.cb_diminuir_zoom=create cb_diminuir_zoom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aumentar_zoom
this.Control[iCurrent+2]=this.cb_diminuir_zoom
end on

on w_ge127_relatorios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_aumentar_zoom)
destroy(this.cb_diminuir_zoom)
end on

event ue_postopen;call super::ue_postopen;Date ldh_Hoje

ldh_Hoje = Date( Today( ) )

dw_1.Object.Nr_Ano_Exercicio		[1] = Year( ldh_Hoje )
dw_1.Object.Nr_Ano_Trimestre	[1] = Year( ldh_Hoje )
dw_1.Object.Nr_Ano_Mensal		[1] = Year( ldh_Hoje )
dw_1.Object.Dh_Inicio				[1] = DateTime( ldh_Hoje )
dw_1.Object.Dh_Termino			[1] = DateTime( ldh_Hoje )
dw_1.Object.Nr_Mes					[1] = Month( Today( ) )
dw_1.Event ue_Trimestre_Default( )
end event

event open;call super::open;This.ivm_Menu.ivb_Permite_Imprimir = True

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "W_GE127_GERA_RELATORIO", Ref gvs_Matricula_Farmaceutico ) Then
	Close(This)
	Return -1
End If
end event

event ue_preopen;call super::ue_preopen;wf_Preview( False )
end event

event ue_print;// OverRide

dw_2.Event ue_Print( )
end event

event ue_printimmediate;// OverRide
dw_2.Event ue_PrintImmediate( )
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge127_relatorios
boolean visible = false
integer x = 1490
integer y = 1304
integer width = 800
integer height = 528
integer weight = 700
string facename = "Verdana"
string text = "Preview"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge127_relatorios
boolean visible = false
integer y = 72
integer width = 2062
integer height = 336
integer weight = 700
string facename = "Verdana"
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge127_relatorios
event ue_enabled ( string ps_coluna,  integer pi_taborder )
event type boolean ue_valida_selecao ( )
event ue_trimestre_default ( )
integer x = 0
integer y = 8
integer width = 2953
integer height = 472
string dataobject = "dw_ge127_selecao_bmpo"
boolean livescroll = false
end type

event dw_1::ue_enabled(string ps_coluna, integer pi_taborder);String ls_Retorno_Modify

This.SetTabOrder( ps_Coluna,	pi_TabOrder )

If ps_Coluna = 'alteracao' Or ps_Coluna = 'insercao' Or ps_Coluna = 'login' Or ps_Coluna = 'remocao' Then
	Return
End If

ls_Retorno_Modify = This.Describe(ps_Coluna + ".Background.Color")

If pi_TabOrder > 0 Then
	ls_Retorno_Modify = This.Modify( ps_Coluna + ".background.color =16777215~trgb(255.255.255)" )
Else
	//ls_Retorno_Modify = This.Modify( ps_Coluna + ".background.color =134217750~trgb(192,192,192)" )
	ls_Retorno_Modify = This.Modify( ps_Coluna + ".background.color =134217750" )
End If

ls_Retorno_Modify = ls_Retorno_Modify
end event

event type boolean dw_1::ue_valida_selecao();String ls_Tipo_Relatorio
String ls_Grupo_Psico
String ls_Tipo_Periodo
String ls_Alteracao
String ls_Insercao
String ls_Login
String ls_Remocao

This.AcceptText( )

ls_Tipo_Relatorio	= This.Object.Id_Tipo_Relatorio	[1]
ls_Grupo_Psico		= This.Object.Cd_Grupo_Psico		[1]
ls_Tipo_Periodo	= This.Object.Id_Tipo_Periodo		[1]

Choose Case ls_Tipo_Relatorio
	Case 'L'
		If LeftA( ls_Grupo_Psico, 4 ) = 'RMNR' Then
			Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para o relat$$HEX1$$f300$$ENDHEX$$rio Tipo Log, as listas poss$$HEX1$$ed00$$ENDHEX$$veis s$$HEX1$$e300$$ENDHEX$$o somente 'A1 e A2', 'A3, B1 e B2', 'C1, C2, C4 e C5'." )
			This.Event ue_Pos( 1, "cd_grupo_psico" )
			Return False
		End If
		
		ls_Alteracao	= This.Object.Alteracao	[1]
		ls_Insercao	= This.Object.Insercao	[1]
		ls_Login		= This.Object.Login		[1]
		ls_Remocao	= This.Object.Remocao	[1]

		If ls_Alteracao = 'N' And ls_Insercao = 'N' And ls_Login = 'N' And ls_Remocao = 'N' Then
			Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para o relat$$HEX1$$f300$$ENDHEX$$rio Tipo Log, selecione ao menos uma op$$HEX2$$e700e300$$ENDHEX$$o: 'Altera$$HEX2$$e700e300$$ENDHEX$$o', 'Inser$$HEX2$$e700e300$$ENDHEX$$o', 'Login', 'Remo$$HEX2$$e700e300$$ENDHEX$$o'." )
			This.SetFocus()
			Return False
		End If
	
	Case 'M'
		If LeftA( ls_Grupo_Psico, 4 ) <> 'RMNR' Then
			Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para o tipo de relat$$HEX1$$f300$$ENDHEX$$rio RMNR, as listas poss$$HEX1$$ed00$$ENDHEX$$veis s$$HEX1$$e300$$ENDHEX$$o somente Receitas 'A' e Receitas 'B2'." )
			This.Event ue_Pos( 1, "cd_grupo_psico" )
			Return False
		End If
		
		If ls_Tipo_Periodo <> 'M' Then
			Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para o tipo de relat$$HEX1$$f300$$ENDHEX$$rio RMNR, somente o per$$HEX1$$ed00$$ENDHEX$$odo Mensal pode ser selecionado." )
			This.Object.Id_Tipo_Periodo[1] = 'M'
			This.Event ItemChanged( 1, This.Object.Id_Tipo_Periodo, 'M' ) // J$$HEX1$$e100$$ENDHEX$$ executa o evento ue_pos
			Return False
		End If
		
	Case 'P'
		If ls_Tipo_Periodo <> 'M' Then
			Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para o tipo de relat$$HEX1$$f300$$ENDHEX$$rio PERDAS, somente o per$$HEX1$$ed00$$ENDHEX$$odo Mensal pode ser selecionado." )
			This.Object.Id_Tipo_Periodo[1] = 'M'
			This.Event ItemChanged( 1, This.Object.Id_Tipo_Periodo, 'M' ) // J$$HEX1$$e100$$ENDHEX$$ executa o evento ue_pos
			Return False
		End If
		
	Case Else
		If LeftA( ls_Grupo_Psico, 4 ) = 'RMNR' Then
			Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "As listas Receitas 'A' e Receitas 'B2' s$$HEX1$$f300$$ENDHEX$$ podem ser geradas para o tipo de relat$$HEX1$$f300$$ENDHEX$$rio RMNR." )
			This.Event ue_Pos( 1, "id_tipo_relatorio" )
			Return False
		End If
		
		If ls_Tipo_Periodo = 'M' Then
			Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo Mensal somente pode ser selecionado para o tipo de relat$$HEX1$$f300$$ENDHEX$$rio RMNR." )
			This.Object.Id_Tipo_Periodo[1] = 'T'
			This.Event ItemChanged( 1, This.Object.Id_Tipo_Periodo, 'T' ) // J$$HEX1$$e100$$ENDHEX$$ executa o evento ue_pos
			Return False
		End If
End Choose

Return True
end event

event dw_1::ue_trimestre_default();Integer li_Mes_Atual

li_Mes_Atual = Month( Today( ) )

Choose Case li_Mes_Atual
	Case 1, 2, 3
		This.Object.Nr_Trimestre[1] = 4

	Case 4, 5, 6
		This.Object.Nr_Trimestre[1] = 1

	Case 7, 8, 9
		This.Object.Nr_Trimestre[1] = 2

	Case 10, 11, 12
		This.Object.Nr_Trimestre[1] = 3

End Choose
end event

event dw_1::itemchanged;call super::itemchanged;wf_Preview( False )

Choose Case dwo.Name
	Case 'id_tipo_relatorio'
		
		If Data <> 'L' Then
			dw_1.Object.Alteracao	[1] = 'N'
			dw_1.Object.Insercao		[1] = 'N'
			dw_1.Object.Login			[1] = 'N'
			dw_1.Object.Remocao	[1] = 'N'
			
			This.Event ue_Enabled( 'alteracao',0 )
			This.Event ue_Enabled( 'insercao',	0 )
			This.Event ue_Enabled( 'login',		0 )
			This.Event ue_Enabled( 'remocao',0 )
		Else
			This.Event ue_Enabled( 'alteracao',21 )
			This.Event ue_Enabled( 'insercao',	22 )
			This.Event ue_Enabled( 'login',		23 )
			This.Event ue_Enabled( 'remocao',24 )
		End If
		
		Choose Case Data
				
			Case 'P'
				This.Event ue_Enabled( 'id_classe_terapeutica',20 )
				This.Event ue_Enabled( 'cd_grupo_psico',		0 )
				
				This.Object.Cd_Grupo_Psico[1] = 'T'
				
			Case 'L'
				This.Event ue_Enabled( 'id_classe_terapeutica',0 )
				This.Event ue_Enabled( 'cd_grupo_psico',		0 )
				
				This.Object.Cd_Grupo_Psico			[1]	= 'T'
				This.Object.Id_Classe_Terapeutica[1]= 'T'
						
			Case Else
				This.Event ue_Enabled( 'id_classe_terapeutica',0 )
				This.Event ue_Enabled( 'cd_grupo_psico',		20 )
				
			This.Object.Id_Classe_Terapeutica[1]= 'T'
								
		End Choose
		
	Case 'id_tipo_periodo'
		
		Choose Case Data
			Case 'T'
				This.Event ue_Enabled( 'nr_ano_exercicio',			0 )
				This.Event ue_Enabled( 'dh_inicio',					0 )
				This.Event ue_Enabled( 'dh_termino',					0 )
				This.Event ue_Enabled( 'nr_mes',						0 )
				This.Event ue_Enabled( 'nr_ano_mensal',			0 )
				
				This.Event ue_Enabled( 'nr_trimestre',		30 )
				This.Event ue_Enabled( 'nr_ano_trimestre',	40 )
				
				This.Event ue_Trimestre_Default( )
				This.Event ue_Pos( 1, 'nr_trimestre' )
				
			Case 'A'
				This.Event ue_Enabled( 'nr_trimestre',				0 )
				This.Event ue_Enabled( 'nr_ano_trimestre',			0 )
				This.Event ue_Enabled( 'dh_inicio',					0 )
				This.Event ue_Enabled( 'dh_termino',					0 )
				This.Event ue_Enabled( 'nr_mes',						0 )
				This.Event ue_Enabled( 'nr_ano_mensal',			0 )
				
				This.Event ue_Enabled( 'nr_ano_exercicio',	30 )
				
				This.Event ue_Pos( 1, 'nr_ano_exercicio' )

			Case 'M'
				This.Event ue_Enabled( 'nr_mes',				30 )
				This.Event ue_Enabled( 'nr_ano_mensal',	40 )

				This.Event ue_Enabled( 'nr_trimestre',				0 )
				This.Event ue_Enabled( 'nr_ano_trimestre',			0 )
				This.Event ue_Enabled( 'nr_ano_exercicio',			0 )
				This.Event ue_Enabled( 'dh_inicio',					0 )
				This.Event ue_Enabled( 'dh_termino',					0 )
				
				This.Object.Nr_Mes[1] = Month( Today( ) )
				This.Event ue_Pos( 1, 'nr_mes' )

			Case 'E'
				This.Event ue_Enabled( 'nr_trimestre',				0 )
				This.Event ue_Enabled( 'nr_ano_trimestre',			0 )
				This.Event ue_Enabled( 'nr_ano_exercicio',			0 )
				This.Event ue_Enabled( 'nr_mes',						0 )
				This.Event ue_Enabled( 'nr_ano_mensal',			0 )
				
				This.Event ue_Enabled( 'dh_inicio',					30 )
				This.Event ue_Enabled( 'dh_termino',					40 )
				
				This.Event ue_Pos( 1, 'dh_inicio' )
				
			Case 'L'
	End Choose
	
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge127_relatorios
integer x = 23
integer y = 468
integer width = 3543
integer height = 1444
string dataobject = "dw_ge127_balancos_comp"
boolean hscrollbar = true
boolean border = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Grupo
String ls_Tipo_Periodo
String ls_Tipo_Relatorio
String ls_Modify

dw_1.AcceptText( )

ls_Grupo				= dw_1.Object.Cd_Grupo_Psico	[1]
ls_Tipo_Periodo	= dw_1.Object.Id_Tipo_Periodo	[1]
ls_Tipo_Relatorio	= dw_1.Object.Id_Tipo_Relatorio	[1]

If Not dw_1.Event ue_Valida_Selecao( ) Then
	Return -1
End If

wf_Configura_Inicio_Termino_Periodo( )

If ls_Tipo_Relatorio = 'P' Then // Perdas
	This.of_ChangeDataObject( "dw_ge127_relatorio_rmp_comp" )
	ls_Modify = This.Modify("dw_Detalhe.DataObject='dw_ge127_relatorio_rmp'")
	Return AncestorReturnValue
End If

If ls_Tipo_Relatorio = 'L' Then
	This.of_ChangeDataObject( "dw_ge127_relatorio_log" )
End If

Choose Case ls_Grupo
	Case 'RMNRA', 'RMNRB2'
		This.of_ChangeDataObject( "dw_ge127_relatorio_rm_comp" )
		ls_Modify = This.Modify("dw_Detalhe.DataObject=''dw_ge127_relatorio_rmnr")
		Return AncestorReturnValue
End Choose

Choose Case ls_Tipo_Periodo
	Case 'T', 'E', 'A'
		Choose Case ls_Tipo_Relatorio
			Case 'A'
				This.of_ChangeDataObject( "dw_ge127_balancos_comp" )
				ls_Modify = This.Modify("dw_Detalhe.DataObject='dw_ge127_bal_aquisicoes'")				
			Case 'C'
				This.of_ChangeDataObject( "dw_ge127_balancos_comp" )
				ls_Modify = This.Modify("dw_Detalhe.DataObject='dw_ge127_balanco'")
		End Choose
End Choose

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;// OverRide
Integer li_Linhas

Long ll_Pos
Long ll_Idx_Array = 0

String ls_Portaria
String ls_Grupo_Psico[]
String ls_Psico_Todos[]
String ls_Psico_Todos_Rmp[]
String ls_Tipo_Periodo
String ls_Tipo_Relatorio
String ls_Classe_Terapeutica
String ls_Lista

dw_1.AcceptText( )

ls_Portaria					= dw_1.Object.Cd_Grupo_Psico			[1]
ls_Tipo_Periodo			= dw_1.Object.Id_Tipo_Periodo			[1]
ls_Tipo_Relatorio			= dw_1.Object.Id_Tipo_Relatorio			[1]
ls_Classe_Terapeutica	= dw_1.Object.Id_Classe_Terapeutica	[1]
ls_Psico_Todos				= {'A1','A2','A3','B1','B2','C1','C2','C3','C4','C5'}

Choose Case ls_Tipo_Relatorio
	Case 'P'
		ls_Psico_Todos_Rmp = {'A1','A2','A3','B1','B2','C1','C2','C3','C4','C5','W'}
		
		If ls_Classe_Terapeutica = 'W' Then
			ls_Grupo_Psico = {'W'}
		End If
		
		If ls_Classe_Terapeutica = 'T' Then
			ls_Grupo_Psico = ls_Psico_Todos_Rmp
		End If
		
		If ls_Classe_Terapeutica = 'P' Then
			ls_Grupo_Psico = ls_Psico_Todos
		End If
		
	Case 'L'
		If Not wf_Appendwhere_Log() Then
			Return - 1
		End If

	Case Else
		Choose Case ls_Portaria
			Case 'RMNRA'
				ls_Grupo_Psico = {'A1','A2','A3'}
				
			Case 'RMNRB2'
				ls_Grupo_Psico = {'B2'}
				
			Case 'T'
				ls_Grupo_Psico = ls_Psico_Todos
				
			Case Else
				Do
					ll_Idx_Array++
					ll_Pos = PosA( ls_Portaria, ',' )
					ls_Grupo_Psico[ll_Idx_Array] = LeftA( ls_Portaria, ll_Pos -1 )
					ls_Portaria = MidA( ls_Portaria, ll_Pos+1 )
					ls_Lista += ", '" + ls_Portaria + "'"
				Loop While ll_Pos > 0
				
				ls_Grupo_Psico[ll_Idx_Array] = ls_Portaria
				ls_Lista = MidA(ls_Lista, 2)
		End Choose
End Choose

Open(w_Aguarde)

w_Aguarde.Title = 'Aguarde... Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es.'

li_Linhas = This.Retrieve( gvo_Parametro.Cd_Filial, idt_Inicio_Periodo, idt_Termino_Periodo, 'FARMACEUTICOS', ls_Grupo_Psico, 'TRIMESTRAL', 'BALAQ' )

If ls_Tipo_Relatorio = 'A' Or ls_Tipo_Relatorio = 'C' Then
	If ls_Grupo_Psico = ls_Psico_Todos Then
		ls_Lista = "'A1','A2','A3','B1','B2','C1','C2','C3','C4','C5'"
	Else
		If Trim(ls_Portaria) = 'A2' Then
			ls_Lista = "'A1, A2'"
		End If
		
		If Trim(ls_Portaria) = 'B2' Then
			ls_Lista = "'A3, B1, B2'"
		End If
		
		If Trim(ls_Portaria) = 'C5' Then
			ls_Lista = "'C1, C2, C4, C5'"
		End If
	End If
	This.Object.dw_Header.Object.Portaria_t.Text = gf_Replace(ls_Lista, "'", "", 0)
	This.Object.dw_Detalhe.Object.Portaria_t.Text = gf_Replace(ls_Lista, "'", "", 0)
End If

Close(w_Aguarde)

Return li_Linhas
end event

event dw_2::ue_postretrieve;//OverRide
Integer ll_PageCount
Integer li_GetChild

String ls_Tipo_Relatorio

If pl_Linhas < 0 Then 
	Return pl_Linhas
End If

dw_1.AcceptText()

ls_Tipo_Relatorio = dw_1.Object.Id_Tipo_Relatorio[1]

If ls_Tipo_Relatorio = 'L' Then
	
	If pl_Linhas = 0 Then
		This.InsertRow(0)
		This.Object.st_nenhuma_movimentacao.Visible = True
		
		If Not wf_Preenche_Cabecalho() Then
			Return -1
		End If
	Else
		This.Object.st_nenhuma_movimentacao.Visible = False
	End If
	
	dw_2.Object.Periodo_t.Text = String(idt_Inicio_Periodo) + " at$$HEX1$$e900$$ENDHEX$$ " + String(idt_Termino_Periodo)
	
Else
	
	DataWindowChild ldwc_Child
	
	If This.GetChild('dw_detalhe', ldwc_Child) = 1 Then
		pl_Linhas = ldwc_Child.RowCount()
	End If
	
	If pl_Linhas > 0 Then
		This.Object.dw_Detalhe.Object.st_nenhuma_movimentacao.Visible = False
		If Not wf_Recupera_Cadastro_Historico(ls_Tipo_Relatorio) Then
			Return -1
		End If
		
		If ls_Tipo_Relatorio = 'C' Then
			If Not wf_Preenche_Cabecalho() Then
				Return -1
			End If
		End If
	Else
		ldwc_Child.InsertRow(0)
		This.Object.dw_Detalhe.Object.st_nenhuma_movimentacao.Visible = True
		
		If ls_Tipo_Relatorio = 'A' Or ls_Tipo_Relatorio = 'C' Then
			If Not wf_Preenche_Cabecalho() Then
				Return -1
			End If
		End If
	End If
	
	This.Object.dw_Detalhe.Object.st_Comentario.Visible = False // Campo de coment$$HEX1$$e100$$ENDHEX$$rio para o desenvolvedor
	
End If

wf_Preview( True )

Parent.ivm_Menu.mf_Imprimir(True)

Return pl_Linhas
end event

event dw_2::ue_preprint;// OverRide
Return This.RowCount()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge127_relatorios
integer x = 2821
integer y = 1108
end type

event dw_3::ue_print;// OverRide
dw_2.Event ue_Print( )
end event

event dw_3::ue_printimmediate;// Override
dw_2.Event ue_PrintImmediate( )
end event

type cb_aumentar_zoom from commandbutton within w_ge127_relatorios
integer x = 3022
integer y = 356
integer width = 480
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Aumentar Zoom"
end type

event clicked;dw_2.Object.Datawindow.Print.Preview.Zoom = Integer( dw_2.Object.Datawindow.Print.Preview.Zoom ) + 10
end event

type cb_diminuir_zoom from commandbutton within w_ge127_relatorios
integer x = 3022
integer y = 224
integer width = 480
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Diminuir Zoom"
end type

event clicked;dw_2.Object.Datawindow.Print.Preview.Zoom = Integer( dw_2.Object.Datawindow.Print.Preview.Zoom ) - 20
end event

