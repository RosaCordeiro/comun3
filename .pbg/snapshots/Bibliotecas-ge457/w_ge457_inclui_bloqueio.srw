HA$PBExportHeader$w_ge457_inclui_bloqueio.srw
forward
global type w_ge457_inclui_bloqueio from dc_w_response
end type
type tab_1 from tab within w_ge457_inclui_bloqueio
end type
type tabpage_1 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
gb_1 gb_1
dw_2 dw_2
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type st_confirmar from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_3 gb_3
dw_3 dw_3
st_confirmar st_confirmar
end type
type tab_1 from tab within w_ge457_inclui_bloqueio
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_confirma from commandbutton within w_ge457_inclui_bloqueio
end type
type cb_cancela from commandbutton within w_ge457_inclui_bloqueio
end type
type st_1 from statictext within w_ge457_inclui_bloqueio
end type
end forward

global type w_ge457_inclui_bloqueio from dc_w_response
integer width = 1810
integer height = 2100
string title = "GE457 - Inclui Bloqueio"
boolean controlmenu = false
long backcolor = 80269524
tab_1 tab_1
cb_confirma cb_confirma
cb_cancela cb_cancela
st_1 st_1
end type
global w_ge457_inclui_bloqueio w_ge457_inclui_bloqueio

type variables
dc_uo_ds_base ivds_filial
dc_uo_ds_base ivds_filial_distribuidora

uo_ge216_filiais io_Filiais  

Boolean ivb_alteracao
Boolean ivb_Check

Date ivdt_movimentacao

String ivs_filiais
String ivs_nulo
String is_Motivo_Bloq

s_ge457_lista_filial st_filial
s_ge457_lista_filial st_inicializa
end variables

forward prototypes
public function boolean wf_inclui_bloqueio (long al_filial, string as_distribuidora, date adh_pedido)
public function boolean wf_inclui_bloqueio_filial_distribuidora (string as_distribuidora, long al_filial, string as_incluir_excluir)
public function integer wf_existe_bloqueio (string as_distribuidora, long al_filial, date adh_pedido)
public function boolean wf_inclui_bloqueio_filial (long al_filial, date adt_pedido, string as_incluir_excluir)
public function boolean wf_exclui_distribuidoras_selecionadas (long al_filial)
public function boolean wf_grava_bloqueio_filial ()
public function boolean wf_grava_bloqueio_distribuidora (date adt_pedido)
public subroutine wf_inicializa ()
public function boolean wf_bloqueia_todas_filiais (long al_filial, string as_inclui_exclui)
public function boolean wf_valida_bloqueios (date adh_pedido, string as_id_bloqueio_filial)
public function boolean wf_verifica_bloqueio_ja_incluido (long al_filial, string as_distribuidora, date adh_pedido, ref boolean ab_incluido)
public function boolean wf_nome_fantasia (long al_filial)
public subroutine wf_envia_email (date adt_pedido)
public subroutine wf_retorna_dia_semana (long al_dia, ref string as_dia_semana)
end prototypes

public function boolean wf_inclui_bloqueio (long al_filial, string as_distribuidora, date adh_pedido);Long ll_Achou

String ls_Erro
String ls_Chave
String ls_Nulo
String ls_Para

INSERT INTO pedido_filial_bloqueio
				( id_tipo_bloqueio,
				cd_filial,
				cd_distribuidora,
				dh_pedido,
				nr_dia_semana,
				de_motivo_bloqueio,
				dh_inclusao,
				nr_matricula_inclusao,
				dh_envio_email)
	VALUES ( "D",
			:al_Filial,
			:as_Distribuidora,
			:adh_pedido,
			null,
			:is_Motivo_Bloq,
			getdate(),
			:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
			null)
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o bloqueio na filial '" + String(al_Filial) + "'. " + ls_Erro, StopSign!)
	Return False
End If

//Grava hist$$HEX1$$f300$$ENDHEX$$rico somente do bloqueio das filiais
If Not IsNull(al_Filial) And al_Filial > 0 Then
	ls_Chave = 'CD_FILIAL@#!CD_DISTRIBUIDORA@#!DH_PEDIDO'
	ls_Para = MidA(String(al_Filial) + Space(4), 1, 4) + "@#!" + as_Distribuidora + "@#!" + String(adh_Pedido)
	
	SetNull(ls_Nulo)
	
	If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_FILIAL_BLOQUEIO', ls_Chave, 'NR_BLOQUEIO', ls_Nulo, ls_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'I', Ref ls_Erro, True) Then Return False
End If
	
Return True
end function

public function boolean wf_inclui_bloqueio_filial_distribuidora (string as_distribuidora, long al_filial, string as_incluir_excluir);Integer lvi_Insert,&
	    lvi_Find
		
Date lvdt_Nulo

SetNull(lvdt_Nulo)
		
lvi_Find = wf_Existe_Bloqueio(as_Distribuidora, al_Filial, lvdt_Nulo)

If lvi_Find = -1 Then Return False

// Incluir
If as_Incluir_Excluir = "I" Then
	
	If lvi_Find = 0 Then
	
		lvi_Insert = ivds_Filial_Distribuidora.InsertRow(0)
		
		ivds_Filial_Distribuidora.Object.cd_distribuidora[lvi_Insert] = as_Distribuidora
		ivds_Filial_Distribuidora.Object.cd_filial		 [lvi_Insert] = al_Filial
	End If
Else
	//Excluir
	If lvi_Find > 0 Then
		If ivds_Filial_Distribuidora.DeleteRow (lvi_Find) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o bloqueio.")
			Return False
		End If
	End If
End If

Return True
end function

public function integer wf_existe_bloqueio (string as_distribuidora, long al_filial, date adh_pedido);Integer lvi_Find

If IsNull(as_Distribuidora) Then
	lvi_Find = ivds_Filial.Find("cd_filial = " + String(al_Filial) + " and dh_pedido = date('" + String(adh_Pedido, "yyyy/mm/dd") + "')", 1, ivds_Filial.RowCount())
Else
	lvi_Find = ivds_Filial_Distribuidora.Find("cd_filial = " + String(al_Filial) + " and cd_distribuidora = '" + as_Distribuidora + "'", 1, ivds_Filial_Distribuidora.RowCount())
End If

Return lvi_Find
end function

public function boolean wf_inclui_bloqueio_filial (long al_filial, date adt_pedido, string as_incluir_excluir);Integer lvi_Insert,&
	    lvi_Find
		
String lvs_Distribuidora

SetNull(lvs_Distribuidora)
		
lvi_Find = wf_Existe_Bloqueio(lvs_Distribuidora, al_Filial, adt_Pedido)

If lvi_Find = -1 Then Return False

// Incluir
If as_Incluir_Excluir = "I" Then
	
	If lvi_Find = 0 Then
		
		lvi_Insert = ivds_Filial.InsertRow(0)
			
		ivds_Filial.Object.cd_filial[lvi_Insert] = al_Filial
		ivds_Filial.Object.dh_pedido[lvi_Insert] = adt_Pedido
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este bloqueio j$$HEX1$$e100$$ENDHEX$$ foi cadastrado.")
		Return False
	End If
Else
	// Excluir
	If lvi_Find > 0 Then
		
		// Verifica se existe alguma distribuidora e exclui
		If wf_Exclui_Distribuidoras_Selecionadas(al_Filial) Then
			If ivds_Filial.DeleteRow (lvi_Find) = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o bloqueio.")
				Return False
			End If
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O bloqueio n$$HEX1$$e300$$ENDHEX$$o foi localizado para a exclus$$HEX1$$e300$$ENDHEX$$o.")
		Return False
	End If
End If

Return True
end function

public function boolean wf_exclui_distribuidoras_selecionadas (long al_filial);Boolean lvb_Sucesso = True

Long lvl_Linhas,&
	 lvl_Linha,&
	 lvl_Filial

lvl_Linhas = ivds_Filial_Distribuidora.RowCount()

If lvl_Linhas = 0 Then Return True

For lvl_Linha = 1 to lvl_Linhas
	
	lvl_Filial = ivds_Filial_Distribuidora.Object.cd_filial[lvl_Linha]
	
	If lvl_Filial = al_Filial Then
		
		If ivds_Filial_Distribuidora.DeleteRow(lvl_Linha)  = -1 Then
			lvb_Sucesso = False
			Exit
		Else
			lvl_Linhas = ivds_Filial_Distribuidora.RowCount()
			lvl_Linha --
		End If
	End If
Next

Return lvb_Sucesso
end function

public function boolean wf_grava_bloqueio_filial ();Boolean lvb_Sucesso = True
Boolean lb_Incluido

Date lvdt_Pedido

Long lvl_Linhas,&
	 lvl_Linha,&
	 lvl_Filial, &
	 ll_Filial_Ant = 0
	 
String lvs_Distribuidora
String ls_Bloq_Fil
String ls_Filial

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Pedido = Tab_1.TabPage_1.dw_1.Object.dh_pedido[1]
ls_Bloq_Fil = Tab_1.TabPage_1.dw_1.Object.id_bloqueio_filial[1]

lvl_Linhas = ivds_Filial_Distribuidora.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Filial	      		= ivds_Filial_Distribuidora.Object.cd_filial		 	[lvl_Linha]
	lvs_Distribuidora	= ivds_Filial_Distribuidora.Object.cd_distribuidora	[lvl_Linha]
	
	If ls_Bloq_Fil = "D" Then
		If ll_Filial_Ant <> lvl_Filial Then		
			If Not wf_Verifica_Bloqueio_Ja_Incluido(lvl_Filial, lvs_Distribuidora, lvdt_Pedido, Ref lb_Incluido) Then
				lvb_Sucesso = False
				Exit
			End If
		End If
		
	ll_Filial_Ant = lvl_Filial

	If lb_Incluido Then Continue	//Bloqueio para as Distribuidoras j$$HEX1$$e100$$ENDHEX$$ foi realizado

	Else
		If Not wf_Verifica_Bloqueio_Ja_Incluido(lvl_Filial, lvs_Distribuidora, lvdt_Pedido, Ref lb_Incluido) Then
			lvb_Sucesso = False
			Exit
		End If

		If lb_Incluido Then Continue //Bloqueio para o Estoque Central j$$HEX1$$e100$$ENDHEX$$ foi realizado
	End If

	If Not wf_Inclui_Bloqueio(lvl_Filial, lvs_Distribuidora, lvdt_Pedido) Then
		lvb_Sucesso = False
		Exit
	End If

	//Prepara o e-mail somente quando o bloqueio for do CD
	If Tab_1.TabPage_1.dw_1.Object.Id_Tipo_Bloqueio[1] = "F" Then
		If ls_Bloq_Fil = "E" Then
			If Not wf_Nome_Fantasia(lvl_Filial) Then
				lvb_Sucesso = False
				Exit
			End If
		End If
	End If
Next

//Envia e-mail somente quando o bloqueio for do CD
If Tab_1.TabPage_1.dw_1.Object.Id_Tipo_Bloqueio[1] = "F" Then
	If ls_Bloq_Fil = "E" Then
		wf_Envia_Email(lvdt_Pedido)
	End If
End If

Return lvb_Sucesso
end function

public function boolean wf_grava_bloqueio_distribuidora (date adt_pedido);Boolean lvb_Sucesso = True

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Nulo
	 
String lvs_Distribuidora,&
	   lvs_Selecionar
	 
lvl_Linhas = Tab_1.TabPage_1.dw_2.RowCount()

SetNull(lvl_Nulo)

For lvl_Linha = 1 To lvl_Linhas
	
	lvs_Distribuidora = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[lvl_Linha]
	lvs_Selecionar    = Tab_1.TabPage_1.dw_2.Object.id_selecionar[lvl_Linha]
		
	If lvs_Selecionar = 'S' Then
		If Not wf_Inclui_Bloqueio(lvl_Nulo, lvs_Distribuidora, adt_Pedido) Then
			lvb_Sucesso = False
			Exit
		End If
	End If
Next

Return lvb_Sucesso
end function

public subroutine wf_inicializa ();Long ll_Linha
Long ll_Find

Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_3.AcceptText()

ll_Find = Tab_1.TabPage_1.dw_2.Find("id_selecionar = 'S'", 1, Tab_1.TabPage_1.dw_2.RowCount())

If ll_Find > 0 Then
	For ll_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
		Tab_1.TabPage_1.dw_2.Object.Id_Selecionar[ll_Linha] = "N"
	Next
End If

ll_Linha = 0
ll_Find = 0

ll_Find = Tab_1.TabPage_2.dw_3.Find("id_selecionar = 'S'", 1, Tab_1.TabPage_2.dw_3.RowCount())

If ll_Find > 0 Then
	For ll_Linha = 1 To Tab_1.TabPage_2.dw_3.RowCount()
		Tab_1.TabPage_2.dw_3.Object.Id_Selecionar[ll_Linha] = "N"
	Next
End If

ivds_Filial.Reset()
ivds_Filial_Distribuidora.Reset()
end subroutine

public function boolean wf_bloqueia_todas_filiais (long al_filial, string as_inclui_exclui);Long ll_Linha
Long ll_Linhas

String lvs_Distribuidora
String ls_Bloqueio_Filial

//Tab_1.TabPage_2.dw_3.Event ue_Retrieve()

ll_Linhas = Tab_1.TabPage_2.dw_3.Retrieve(al_Filial)

Choose Case ll_Linhas
	//N$$HEX1$$e300$$ENDHEX$$o tem distribuidora relacionada para a filial
	Case 0
		Return True
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw_3. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_bloqueia_todas_filiais.", StopSign!)
		Return False		
End Choose
  
ls_Bloqueio_Filial = Tab_1.TabPage_1.dw_1.Object.Id_Bloqueio_Filial[1] 
 
For ll_Linha = 1 To Tab_1.TabPage_2.dw_3.RowCount()
	lvs_Distribuidora = Tab_1.TabPage_2.dw_3.Object.cd_fornecedor	[ll_Linha]
	
	//Se o bloqueio for para distribuidora desconsidera o Estoque Central
	If ls_Bloqueio_Filial = "D" Then
		If lvs_Distribuidora = "053404705" Then
			Continue
		End If
	Else
		//Sen$$HEX1$$e300$$ENDHEX$$o, significa que o bloqueio $$HEX1$$e900$$ENDHEX$$ para o Estoque Central, ent$$HEX1$$e300$$ENDHEX$$o desconsidera as distribuidoras
		If lvs_Distribuidora <> "053404705" Then
			Continue
		End If
	End If

	wf_Inclui_Bloqueio_Filial_Distribuidora(lvs_Distribuidora, al_Filial, as_inclui_exclui )
Next

Return True
end function

public function boolean wf_valida_bloqueios (date adh_pedido, string as_id_bloqueio_filial);Boolean lvb_Sucesso = True

Long lvl_Linha,&
	 lvl_Find,&
	 lvl_Filial, &
	 ll_Achou
	 
String lvs_Distribuidora,&
	   lvs_Selecionar, &
		ls_Erro, &
		ls_Anexo[]

SetNull(lvs_Distribuidora)

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

If ivdt_movimentacao = adh_Pedido Then
	If as_Id_Bloqueio_Filial = "D" Then
		
		Select Count(*)
			Into :ll_Achou
		From pedido_filial
		Where dh_emissao >= :adh_Pedido
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar se o pedido j$$HEX1$$e100$$ENDHEX$$ foi gerado no dia atual. " + ls_Erro, StopSign!)
			Return False
		End If
		
		If ll_Achou > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A gera$$HEX2$$e700e300$$ENDHEX$$o do pedido j$$HEX1$$e100$$ENDHEX$$ foi iniciada. O sistema continuar$$HEX1$$e100$$ENDHEX$$ com o bloqueio das filiais.~r~r" + &
							"Avise o setor de T.I.")
		
			If gvo_Aplicacao.ivs_DataSource = 'central' Then
				gf_ge202_Envia_Email_Automatico(156, "", "", ls_Anexo[], True)
			End If
		End If
	End If
End If

For lvl_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount() 
	
	lvl_Filial			= Tab_1.TabPage_1.dw_2.Object.cd_filial			[lvl_Linha]
	lvs_Selecionar	= Tab_1.TabPage_1.dw_2.Object.id_selecionar	[lvl_Linha]
	
	If lvs_Selecionar = "S" Then
		lvl_Find = ivds_Filial_Distribuidora.Find("cd_filial = " + String(lvl_Filial), 1, ivds_Filial_Distribuidora.RowCount())
		
		If lvl_Find = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma distribuidora foi selecionada para a filial '" + String(lvl_Filial) + "'.")
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se existe distribuidora selecionada para a filial '" + String(lvl_Find) + "'.")
			lvb_Sucesso = False
			Exit
		End If
	End If
Next

Return lvb_Sucesso
end function

public function boolean wf_verifica_bloqueio_ja_incluido (long al_filial, string as_distribuidora, date adh_pedido, ref boolean ab_incluido);Long ll_Achou

String ls_Erro

If as_Distribuidora = "053404705" Then
	//Verifica se j$$HEX1$$e100$$ENDHEX$$ foi colocado bloqueio para a filial no pedido do Estoque Central
	Select Count(*)
		Into :ll_Achou
	From pedido_filial_bloqueio
	Where id_tipo_bloqueio = 'D'
		And cd_filial = :al_Filial
		And cd_distribuidora = '053404705'
		And dh_pedido =: adh_Pedido
		And nr_dia_semana Is Null
	Using SqlCa;
	
Else
	//Verifica se j$$HEX1$$e100$$ENDHEX$$ foi colocado bloqueio para a filial no pedido das Distribuidoras
	Select Count(*)
		Into :ll_Achou
	From pedido_filial_bloqueio
	Where id_tipo_bloqueio = 'D'
		And cd_filial = :al_Filial
		And cd_distribuidora <> '053404705'
		And dh_pedido =: adh_Pedido
		And nr_dia_semana Is Null
	Using SqlCa;
End If
	
If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o bloqueio j$$HEX1$$e100$$ENDHEX$$ foi inclu$$HEX1$$ed00$$ENDHEX$$do na filial '" + String(al_Filial) + "'. " + ls_Erro, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	ab_Incluido = True
Else
	ab_Incluido = False
End If
end function

public function boolean wf_nome_fantasia (long al_filial);Long ll_Find

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Find = Tab_1.TabPage_1.dw_2.Find("cd_filial = " + String(al_Filial) + " and id_selecionar = 'S'", 1, Tab_1.TabPage_1.dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da fun$$HEX2$$e700e300$$ENDHEX$$o wf_nome_fantasia.", StopSign!)
	Return False
End If

If ll_Find > 0 Then
	st_Filial.Cd_Filial		[ UpperBound(st_Filial.Cd_Filial			[]) + 1 ] = al_Filial
	st_Filial.Nm_Fantasia	[ UpperBound(st_Filial.Nm_Fantasia	[]) + 1 ] = Tab_1.TabPage_1.dw_2.Object.Nm_Fantasia					[ll_Find]
	st_Filial.Cd_UF			[ UpperBound(st_Filial.Cd_UF			[]) + 1 ] = Tab_1.TabPage_1.dw_2.Object.Cd_Unidade_Federacao	[ll_Find]
End If

Return True
end function

public subroutine wf_envia_email (date adt_pedido);Date ldt_Malote

Long ll_Linha

String ls_Tabela
String ls_Cabecalho
String ls_Mensagem
String ls_Dia_Semana
String ls_Dia_Sema_Malote

If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return

If UpperBound(st_filial.Cd_Filial[]) = 0 Then Return

//DayNumber(adt_Pedido) = 1 - Quando o bloqueio cai no final de semana, $$HEX1$$e900$$ENDHEX$$ bloqueado o s$$HEX1$$e100$$ENDHEX$$bado e o domingo, e pra n$$HEX1$$e300$$ENDHEX$$o enviar dois e-mails, envia s$$HEX1$$f300$$ENDHEX$$ pelo s$$HEX1$$e100$$ENDHEX$$bado
//DayNumber(adt_Pedido) = 6 - Bloqueio na sexta, feriado seria domingo, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio, mas o sistema permite bloquear, por$$HEX1$$e900$$ENDHEX$$m n$$HEX1$$e300$$ENDHEX$$o envia e-mail
If DayNumber(adt_Pedido) = 1 Or DayNumber(adt_Pedido) = 6 Then Return

s_email str

ls_Mensagem = "Segue abaixo a(s) filial(is) que estar$$HEX1$$e100$$ENDHEX$$($$HEX1$$e300$$ENDHEX$$o) bloqueada(s) por motivo de feriado municipal, banc$$HEX1$$e100$$ENDHEX$$rio e/ou outros.<p/><br>"

ldt_Malote = adt_Pedido

//Se for s$$HEX1$$e100$$ENDHEX$$bado
If DayNumber(adt_Pedido) = 7 Then
	ls_Dia_Semana = "FINAL DE SEMANA"
	ls_Mensagem += "<b>Inform$$HEX1$$e100$$ENDHEX$$tica: N$$HEX1$$c300$$ENDHEX$$O GERAR pedido no '" + Upper(ls_Dia_Semana) + "'.</b><br><br>"
	
	//Quando $$HEX1$$e900$$ENDHEX$$ malote, se o bloqueio foi feito no s$$HEX1$$e100$$ENDHEX$$bado, a mensagem diz pra n$$HEX1$$e300$$ENDHEX$$o enviar malote na sexta
	ldt_Malote = RelativeDate(ldt_Malote, -1)
	wf_Retorna_Dia_Semana(DayNumber(ldt_Malote), Ref ls_Dia_Sema_Malote)
Else
	wf_Retorna_Dia_Semana(DayNumber(adt_Pedido), Ref ls_Dia_Semana)
	ls_Mensagem += "<b>Inform$$HEX1$$e100$$ENDHEX$$tica: N$$HEX1$$c300$$ENDHEX$$O GERAR pedido no dia '" + String(adt_Pedido) + "' (" + Upper(ls_Dia_Semana) + ").</b><br><br>"
	
	wf_Retorna_Dia_Semana(DayNumber(ldt_Malote), Ref ls_Dia_Sema_Malote)
End If

//Monta a parte do malote
ls_Mensagem += "<b>Comunica$$HEX2$$e700e300$$ENDHEX$$o: N$$HEX1$$c300$$ENDHEX$$O ENVIAR malote no dia '" + String(ldt_Malote) + "' (" + Upper(ls_Dia_Sema_Malote) + ").</b><p/>"

ls_Cabecalho = "<table border='1'>" + &
					"<tr>" + &
					"<th>FILIAL</th>" + &
					"<th>NOME FANTASIA</th>" + &
					"<th>U.F.</th>" + &
					"</tr>"

For ll_Linha = 1 To UpperBound(st_Filial.Cd_Filial[])
	ls_Tabela += "<tr><td align=right>" + String(st_Filial.Cd_Filial[ll_Linha]) + "</td><td>" + st_Filial.Nm_Fantasia[ll_Linha] + "</td><td>" + st_Filial.Cd_UF[ll_Linha] + "</td></tr>"
Next

ls_Tabela = ls_Cabecalho + ls_Tabela + "</table>"
str.ps_Mensagem = ls_Mensagem + ls_Tabela + "<p/><br>" + "</b><br>"
str.ps_Assunto = "- Pedido do Estoque Central"
str.pb_Assinatura = True

gf_ge202_envia_email_padrao(152, str)

Return
end subroutine

public subroutine wf_retorna_dia_semana (long al_dia, ref string as_dia_semana);Choose Case al_Dia
	Case 1
		as_Dia_Semana = 'Domingo'
	Case 2
		as_Dia_Semana = 'Segunda-feira'
	Case 3
		as_Dia_Semana = 'Ter$$HEX1$$e700$$ENDHEX$$a-feira'
	Case 4
		as_Dia_Semana = 'Quarta-feira'
	Case 5
		as_Dia_Semana = 'Quinta-feira'
	Case 6
		as_Dia_Semana = 'Sexta-feira'
	Case 7
		as_Dia_Semana = 'S$$HEX1$$e100$$ENDHEX$$bado'
End Choose
end subroutine

on w_ge457_inclui_bloqueio.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_confirma=create cb_confirma
this.cb_cancela=create cb_cancela
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_confirma
this.Control[iCurrent+3]=this.cb_cancela
this.Control[iCurrent+4]=this.st_1
end on

on w_ge457_inclui_bloqueio.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_confirma)
destroy(this.cb_cancela)
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;String lvs_Dia_Semana

Tab_1.TabPage_1.dw_1.Event ue_AddRow()

ivdt_movimentacao = Date(gvo_Parametro.of_DH_Movimentacao())

Tab_1.TabPage_1.dw_1.Object.Dh_Pedido[1] = ivdt_movimentacao

ivds_filial = Create dc_uo_ds_base

If Not ivds_filial.of_ChangeDataObject("ds_ge457_lista_filial") Then
	Close(This)
End If

ivds_Filial_Distribuidora = Create dc_uo_ds_base

If Not ivds_Filial_Distribuidora.of_ChangeDataObject("ds_ge457_lista_filial_distribuidora") Then
	Close(This)
End If

io_Filiais = Create uo_ge216_filiais 

wf_Retorna_Dia_Semana(DayNumber(Tab_1.TabPage_1.dw_1.Object.Dh_Pedido[1]), Ref lvs_Dia_Semana)
	
Tab_1.TabPage_1.dw_1.Object.st_Dia_Semana.text = Upper(lvs_Dia_Semana)

Tab_1.TabPage_1.gb_2.text = "Lista de Distribuidora"
Tab_1.Tabpage_2.Visible   = False

Tab_1.Tabpage_1.dw_1.Object.De_Bloqueio_Filial_t.Visible = False
Tab_1.Tabpage_1.dw_1.Object.Id_Bloqueio_Filial.Visible = False
Tab_1.Tabpage_1.dw_1.Object.Id_Bloqueio_Prazo_Inde.Visible = True

Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

event close;call super::close;Destroy(ivds_Filial)
Destroy(ivds_filial_distribuidora)
Destroy(io_Filiais)
end event

type pb_help from dc_w_response`pb_help within w_ge457_inclui_bloqueio
end type

type tab_1 from tab within w_ge457_inclui_bloqueio
integer x = 9
integer y = 8
integer width = 1751
integer height = 1856
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 80269524
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		Tab_1.TabPage_2.dw_3.SetFocus()
End Choose

SetPointer(Arrow!)
end event

event selectionchanging;SetPointer(HourGlass!)

String lvs_Selecionar

Tab_1.TabPage_1.dw_2.AcceptText()

Choose Case NewIndex
	Case 1
	Case 2
		
		lvs_Selecionar = Tab_1.TabPage_1.dw_2.Object.id_selecionar[Tab_1.TabPage_1.dw_2.GetRow()]
		
		If lvs_Selecionar = "S" Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW's de detalhes
			Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
	
			// Permite a troca do folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma filial para selecionar as distribuidoras.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
		
		If Tab_1.TabPage_1.dw_2.Object.Id_Tipo_Bloqueio[1] = "F" Then
			If IsNull(Tab_1.TabPage_1.dw_2.Object.Id_Bloqueio_Filial[1]) Or Trim(Tab_1.TabPage_1.dw_2.Object.Id_Bloqueio_Filial[1]) = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o bloqueio da filial.", Exclamation!)
				Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "id_bloqueio_filial")
				Return 1
			End If
		End If
End Choose

SetPointer(Arrow!)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1714
integer height = 1740
long backcolor = 80269524
string text = "Bloqueio"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_2 gb_2
gb_1 gb_1
dw_2 dw_2
dw_1 dw_1
end type

on tabpage_1.create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.gb_2,&
this.gb_1,&
this.dw_2,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type gb_2 from groupbox within tabpage_1
integer x = 27
integer y = 376
integer width = 1655
integer height = 1340
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 27
integer y = 24
integer width = 1655
integer height = 344
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Bloqueio"
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 55
integer y = 424
integer width = 1595
integer height = 1256
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge457_lista_filial_inclusao"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;Date lvdt_Pedido

Long lvl_Filial
Long ll_Linha

String lvs_Incluir_Excluir
String lvs_Tipo_Bloqueio
String ls_Bloqueio_Filial
String ls_Abre_Domingo


Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_3.AcceptText()

lvdt_Pedido			= Tab_1.TabPage_1.dw_1.Object.dh_pedido			[1]
lvs_Tipo_Bloqueio	= Tab_1.TabPage_1.dw_1.Object.id_tipo_bloqueio	[1]
ls_Bloqueio_Filial	= Tab_1.TabPage_1.dw_1.Object.Id_Bloqueio_Filial	[1]


If lvs_Tipo_Bloqueio = 'F' Then
	If Trim(ls_Bloqueio_Filial) = "" Or IsNull(ls_Bloqueio_Filial) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o bloqueio da filial.")
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "id_bloqueio_filial")
		Return 1
	End If
	
	lvl_Filial  = Tab_1.TabPage_1.dw_2.Object.cd_filial[Row]
	ls_Abre_Domingo	= This.Object.Id_Abre_Domingo[Row]
	

	If Data = "S" Then
		// Incluir
		lvs_Incluir_Excluir = "I"
		
		If ls_Abre_Domingo = "S" Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(lvl_Filial) + "' abre no domingo. ~rTem certeza que deseja continuar?", Question!, YesNo!, 2) = 2 Then
				Return 1
			End If
		End If
			
	Else
		// Excluir
		lvs_Incluir_Excluir = "E"
	End If
		
	// Inclui o bloqueio da filial (cabe$$HEX1$$e700$$ENDHEX$$alho)
	//If Not wf_Inclui_Bloqueio_Filial(lvl_Filial, lvdt_Pedido, lvs_Incluir_Excluir) Then Return -1
	
	If Not wf_Bloqueia_Todas_Filiais(lvl_Filial, lvs_Incluir_Excluir) Then Return -1

End If
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_preretrieve;call super::ue_preretrieve;String lvs_Tipo,&
	   lvs_DW

dw_1.AcceptText()

lvs_Tipo = dw_1.Object.id_tipo_bloqueio[1]

If lvs_Tipo = "D" Then
	lvs_DW = "dw_ge457_lista_distribuidora_inclusao"
Else
	lvs_DW = "dw_ge457_lista_filial_inclusao"
End If

If This.DataObject <> lvs_DW Then
	If Not This.of_ChangeDataObject(lvs_DW) Then	Return -1
End If

If  lvs_DW = "dw_ge457_lista_filial_inclusao" Then
	
	If ivs_filiais <> "" Then
		This.of_AppendWhere( "f.cd_filial in (" + ivs_Filiais + ")" )
	End If

End If

This.of_SetRowSelection()

Return 1




end event

event doubleclicked;call super::doubleclicked;If dwo.Name = 'p_1' Then
	
	Tab_1.TabPage_1.dw_1.AcceptText()
	
	If Tab_1.TabPage_1.dw_1.Object.Id_Tipo_Bloqueio[1] = "D" Then Return 1
	
	If IsNull(Tab_1.TabPage_1.dw_1.Object.Id_Bloqueio_Filial[1]) Or Trim(Tab_1.TabPage_1.dw_1.Object.Id_Bloqueio_Filial[1]) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o tipo de bloqueio da filial.", Exclamation!)
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "id_bloqueio_filial")
		Return 1
	End If
	
	Long lvl_Row
	Long lvl_Filial
	
	String lvs_Marcacao
	String lvs_Incluir_Excluir
	String ls_Abre_Domingo
	String ls_Adm_Sap
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True		
	End If
	
	For lvl_Row = 1 To This.RowCount()
		
		lvl_Filial				= This.Object.Cd_Filial				[lvl_Row]
		ls_Abre_Domingo	= This.Object.Id_Abre_Domingo	[lvl_Row]
		
		If lvs_Marcacao = "S" Then
			lvs_Incluir_Excluir = 'I'
			If ls_Abre_Domingo = "S" Then
				Continue
			End If
		Else
			lvs_Incluir_Excluir = 'E'
		End If
				
		If Not wf_Bloqueia_Todas_Filiais(lvl_Filial, lvs_Incluir_Excluir) Then Return -1
		
		This.Object.Id_Selecionar[lvl_Row] = lvs_Marcacao			

	Next
End If
end event

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 55
integer y = 88
integer width = 1595
integer height = 268
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge457_parametro_inclusao"
end type

event itemchanged;call super::itemchanged;Date ldt_Nulo

Long lvl_Lojas

String lvs_Tipo
String lvs_DW
String lvs_Dia_Semana

dw_1.AcceptText()

lvs_Tipo = dw_1.Object.id_tipo_bloqueio[1]

SetNull(ldt_Nulo)

If This.GetColumnName() = "id_tipo_bloqueio" Then

	Tab_1.TabPage_1.dw_2.Reset()

	If lvs_Tipo = "D" Then
		Tab_1.TabPage_1.gb_2.text = "Lista de Distribuidora"
		Tab_1.Tabpage_2.Visible   = False
		
		Tab_1.Tabpage_1.dw_1.Object.De_Bloqueio_Filial_t.Visible = False
		Tab_1.Tabpage_1.dw_1.Object.Id_Bloqueio_Filial.Visible = False
		Tab_1.Tabpage_1.dw_1.Object.Id_Bloqueio_Prazo_Inde.Visible = True
		
	Else
						
		If lvs_Tipo = 'F' Then
			
			Tab_1.Tabpage_1.dw_1.Object.De_Bloqueio_Filial_t.Visible = True
			Tab_1.Tabpage_1.dw_1.Object.Id_Bloqueio_Filial.Visible = True
			Tab_1.Tabpage_1.dw_1.Object.Id_Bloqueio_Prazo_Inde.Visible = False
		
			ivs_filiais = ivs_nulo 
			
			SetPointer(HourGlass!)
					
			OpenWithParm(w_ge216_selecao_filiais, io_Filiais)
			
			SetPointer(Arrow!)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = io_Filiais.ivs_filiais
			End If
				
			Tab_1.Tabpage_2.Visible   = True
			Tab_1.TabPage_1.gb_2.text = "Lista de Filiais"
		
		End If
	End If
	
	Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
End If

//If This.GetColumnName() = "dh_pedido" Then
//	
//	wf_Retorna_Dia_Semana(DayNumber(dw_1.Object.Dh_Pedido[1]), Ref lvs_Dia_Semana)
//	
//	dw_1.Object.st_Dia_Semana.text = Upper(lvs_Dia_Semana)
//	
//	This.Object.Id_Bloqueio_Prazo_Inde[1] = "N"
//End If

If This.GetColumnName() = "id_bloqueio_filial" Then
	wf_Inicializa()
End If

If This.GetColumnName() = "id_bloqueio_prazo_inde" Then
	If Data = "S" Then				
		This.Object.Dh_Pedido[1] = ldt_Nulo
		This.Object.st_dia_semana.Text = ""
		
	Else
		
		This.Object.Dh_Pedido[1] = Today()
		wf_Retorna_Dia_Semana(DayNumber(This.Object.Dh_Pedido[1]), Ref lvs_Dia_Semana)	
		dw_1.Object.st_Dia_Semana.text = Upper(lvs_Dia_Semana)
	End If
End If
end event

event losefocus;call super::losefocus;String lvs_Dia_Semana

dw_1.AcceptText()

If This.GetColumnName() = "dh_pedido" Then
	wf_Retorna_Dia_Semana(DayNumber(Tab_1.TabPage_1.dw_1.Object.Dh_Pedido[1]), Ref lvs_Dia_Semana)
		
	Tab_1.TabPage_1.dw_1.Object.st_Dia_Semana.text = Upper(lvs_Dia_Semana)
End If
end event

event itemfocuschanged;call super::itemfocuschanged;String lvs_Dia_Semana

If This.GetColumnName() = "dh_pedido" Then
	
	wf_Retorna_Dia_Semana(DayNumber(dw_1.Object.Dh_Pedido[1]), Ref lvs_Dia_Semana)
	
	dw_1.Object.st_Dia_Semana.text = Upper(lvs_Dia_Semana)	
End If
end event

event editchanged;call super::editchanged;String lvs_Dia_Semana

dw_1.AcceptText()

If This.GetColumnName() = "dh_pedido" Then
	
	wf_Retorna_Dia_Semana(DayNumber(dw_1.Object.Dh_Pedido[1]), Ref lvs_Dia_Semana)
	
	dw_1.Object.st_Dia_Semana.text = Upper(lvs_Dia_Semana)
	
	If Not IsNull(dw_1.Object.Dh_Pedido[1]) Then
		This.Object.Id_Bloqueio_Prazo_Inde[1] = "N"
	End If
End If
end event

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 1714
integer height = 1740
long backcolor = 80269524
string text = "Distribuidoras"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_3 gb_3
dw_3 dw_3
st_confirmar st_confirmar
end type

on tabpage_2.create
this.gb_3=create gb_3
this.dw_3=create dw_3
this.st_confirmar=create st_confirmar
this.Control[]={this.gb_3,&
this.dw_3,&
this.st_confirmar}
end on

on tabpage_2.destroy
destroy(this.gb_3)
destroy(this.dw_3)
destroy(this.st_confirmar)
end on

type gb_3 from groupbox within tabpage_2
integer x = 27
integer y = 16
integer width = 1627
integer height = 1696
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
event ue_mousemove pbm_mousemove
integer x = 64
integer y = 80
integer width = 1568
integer height = 1600
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge457_lista_dist_inclusao_detalhes"
boolean vscrollbar = true
end type

event ue_mousemove;If This.RowCount() > 0 Then
	If xpos >= st_confirmar.X and (xpos <= st_confirmar.x + st_confirmar.Width) and &
		  ypos >= 0 and ypos < 40 Then	 
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
End If
end event

event ue_recuperar;Long lvl_Filial

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Filial = Tab_1.TabPage_1.dw_2.Object.cd_filial[Tab_1.TabPage_1.dw_2.GetRow()]

Return This.Retrieve(lvl_Filial)
end event

event itemchanged;call super::itemchanged;Date lvdt_Pedido

Long lvl_Filial

String	lvs_Distribuidora, &
		lvs_Incluir_Excluir, &
		lvs_Tipo_Bloqueio, &
		ls_Bloqueio_Filial
	   
Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_3.AcceptText()
	   
lvl_Filial				= Tab_1.TabPage_1.dw_2.Object.cd_filial				[Tab_1.TabPage_1.dw_2.GetRow()]
lvdt_Pedido			= Tab_1.TabPage_1.dw_1.Object.dh_pedido	    		[1]
lvs_Tipo_Bloqueio	= Tab_1.TabPage_1.dw_1.Object.id_tipo_bloqueio	[1]

If Data = "S" Then
	// Incluir
	lvs_Incluir_Excluir = "I"
Else
	// Excluir
	lvs_Incluir_Excluir = "E"
End If

ls_Bloqueio_Filial	= Tab_1.TabPage_1.dw_1.Object.Id_Bloqueio_Filial[1]
lvs_Distribuidora	= This.Object.Cd_Fornecedor[This.GetRow()]

If lvs_Tipo_Bloqueio = "F" Then
	If lvs_Incluir_Excluir = "I" Then			
		If ls_Bloqueio_Filial = "D" Then
			If lvs_Distribuidora = "053404705" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O bloqueio selecionado no campo [Bloqueio Filial] $$HEX1$$e900$$ENDHEX$$ DISTRIBUIDORAS.~rN$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser selecionado o Estoque Central.", Exclamation!)
				Return 1
			End If
		Else
			If lvs_Distribuidora <> "053404705" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O bloqueio selecionado no campo [Bloqueio Filial] $$HEX1$$e900$$ENDHEX$$ ESTOQUE CENTRAL.~rN$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser selecionada nenhuma distribuidora.", Exclamation!)
				Return 1
			End If
		End If
	End If
End If

wf_Inclui_Bloqueio_Filial_Distribuidora(lvs_Distribuidora, lvl_Filial, lvs_Incluir_Excluir)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Linhas,&
	 lvl_Linha,&
	 lvl_Filial,&
	 lvl_Find
	 
Date lvdt_Pedido

String lvs_Distribuidora,&
	   lvs_Nome_Fantasia

SetNull(lvdt_Pedido)

lvl_Linhas = This.RowCount()

lvl_Filial 		  = Tab_1.TabPage_1.dw_2.Object.cd_filial  [Tab_1.TabPage_1.dw_2.GetRow()]
lvs_Nome_Fantasia = Tab_1.TabPage_1.dw_2.Object.nm_fantasia[Tab_1.TabPage_1.dw_2.GetRow()]

Tab_1.TabPage_2.gb_3.text = lvs_Nome_Fantasia + " (" + String(lvl_Filial) + ")"

For lvl_Linha = 1 to lvl_Linhas
	
	lvs_Distribuidora = This.Object.cd_fornecedor[lvl_Linha]
	
	lvl_Find = wf_Existe_Bloqueio(lvs_Distribuidora, lvl_Filial, lvdt_Pedido)
	
	If lvl_Find > 0 Then
		This.Object.id_selecionar[lvl_Linha] = "S"	
	End If
	
	If lvl_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial selecionada.")
	End If
Next

Return lvl_Linhas


end event

event doubleclicked;call super::doubleclicked;Long lvl_Filial
Long ll_Linha

Date lvdt_Pedido

String	lvs_Distribuidora, &
		lvs_Incluir_Excluir, &
		lvs_Tipo_Bloqueio, &
		lvs_Marcacao, &
		ls_Bloqueio_Filial

Integer lvi_Regiao
		
Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()		
		  
If dwo.Name = "id_selecionar2" Then
	
	lvl_Filial				= Tab_1.TabPage_1.dw_2.Object.cd_filial				[Tab_1.TabPage_1.dw_2.GetRow()]
	lvdt_Pedido			= Tab_1.TabPage_1.dw_1.Object.dh_pedido			[1]
	lvs_Tipo_Bloqueio	= Tab_1.TabPage_1.dw_1.Object.id_tipo_bloqueio	[1]
	ls_Bloqueio_Filial	= Tab_1.TabPage_1.dw_1.Object.Id_Bloqueio_Filial	[1]
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check 	 = False
		lvs_Incluir_Excluir = "E"
	Else
		lvs_Marcacao = 'S'
		ivb_Check 	 = True
		lvs_Incluir_Excluir = "I"
	End If
	
	For ll_Linha = 1 To This.RowCount()
		lvs_Distribuidora = Tab_1.TabPage_2.dw_3.Object.cd_fornecedor[ll_Linha]
		
		If lvs_Incluir_Excluir = "I" Then			
			If ls_Bloqueio_Filial = "D" Then
				If lvs_Distribuidora = "053404705" Then
					Continue
				End If
			Else
				If lvs_Distribuidora <> "053404705" Then
					Continue
				End If
			End If			
		End If		
				
		If Not wf_Inclui_Bloqueio_Filial_Distribuidora(lvs_Distribuidora, lvl_Filial, lvs_Incluir_Excluir) Then Return -1
		
		This.Object.Id_selecionar[ll_Linha] = lvs_Marcacao
	Next	
End If
end event

type st_confirmar from statictext within tabpage_2
integer x = 686
integer y = 32
integer width = 878
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
boolean focusrectangle = false
end type

type cb_confirma from commandbutton within w_ge457_inclui_bloqueio
integer x = 1051
integer y = 1892
integer width = 357
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a inclus$$HEX1$$e300$$ENDHEX$$o do(s) bloqueio(s) ?", Question!, YesNo!, 2) = 2 Then
	Return
End If

Boolean lvb_Sucesso = False

Date lvdt_Pedido,&
	 lvdt_Nulo
	 
Long lvl_Find

String lvs_Tipo
String ls_Bloqueio_Filial
String ls_Nulo[]
String ls_Bloq_Prazo_Inde

is_Motivo_Bloq = ""

Tab_1.TabPage_1.dw_1.AcceptText()

st_filial = st_inicializa
	   
lvdt_Pedido				= Tab_1.TabPage_1.dw_1.Object.dh_pedido					[1]
lvs_Tipo					= Tab_1.TabPage_1.dw_1.Object.id_tipo_bloqueio			[1]
ls_Bloqueio_Filial		= Tab_1.TabPage_1.dw_1.Object.Id_Bloqueio_Filial			[1]
ls_Bloq_Prazo_Inde 	= Tab_1.TabPage_1.dw_1.Object.Id_Bloqueio_Prazo_Inde	[1]

If lvs_Tipo = "D" Then
	If IsNull(lvdt_Pedido) And ls_Bloq_Prazo_Inde = "N" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do bloqueio.")
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dh_pedido")
		Tab_1.TabPage_1.dw_1.SetFocus()
		Return
	End If
	
	If Not IsNull(lvdt_Pedido) And ls_Bloq_Prazo_Inde = "S" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O campo de prazo indefinido est$$HEX1$$e100$$ENDHEX$$ marcado e a data de bloqueio est$$HEX1$$e100$$ENDHEX$$ preenchida.~r~rDeve ser informada a data de bloqueio OU marcado o prazo indefinido.", Exclamation!)
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dh_pedido")
		Tab_1.TabPage_1.dw_1.SetFocus()
		Return
	End If
End If

If lvdt_Pedido < ivdt_movimentacao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do bloqueio deve ser maior ou igual a '" + String(ivdt_Movimentacao, "dd/mm/yyyy") + "'.")
	Return
End If

lvl_Find = Tab_1.TabPage_1.dw_2.Find("id_selecionar = 'S'", 1, Tab_1.TabPage_1.dw_2.RowCount())

If lvl_Find = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o bloqueio.")
	Return
End If

If lvl_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum bloqueio foi selecionado.")
	Return
End If

If lvs_Tipo = "F" Then
	If Trim(ls_Bloqueio_Filial) = "" Or IsNull(ls_Bloqueio_Filial) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o bloqueio da filial.")
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "id_bloqueio_filial")
		Return -1
	End If
End If

If lvs_Tipo = "D" Then
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "RO" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente a T.I. poder$$HEX1$$e100$$ENDHEX$$ bloquear o pedido da distribuidora.")
		Return -1
	End If
	
	OpenWithParm(w_ge457_motivo_bloqueio, "")
	
	is_Motivo_Bloq = Message.StringParm
	
	If IsNull(is_Motivo_Bloq) Or is_Motivo_Bloq = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o motivo do bloqueio.", Exclamation!)
		Return -1
	End If
	
	If wf_Grava_Bloqueio_Distribuidora(lvdt_Pedido) Then 
		lvb_Sucesso = True
	End If
Else
	If wf_Valida_Bloqueios(lvdt_Pedido, ls_Bloqueio_Filial) Then
		If wf_Grava_Bloqueio_Filial() Then
			lvb_Sucesso = True
		End If
	End If
End If

If lvb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O(s) bloqueio(s) foram inclu$$HEX1$$ed00$$ENDHEX$$dos com sucesso.")
	CloseWithReturn(Parent, "OK")
Else
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o(s) bloqueio(s).")
End If
end event

type cb_cancela from commandbutton within w_ge457_inclui_bloqueio
integer x = 1435
integer y = 1892
integer width = 325
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "C&ancelar"
end type

event clicked;CloseWithReturn(Parent, "")
end event

type st_1 from statictext within w_ge457_inclui_bloqueio
integer x = 9
integer y = 1876
integer width = 654
integer height = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 134217857
long backcolor = 67108864
string text = "Filial Adm.SAP, fazer o bloqueio no SAP!"
boolean focusrectangle = false
end type

