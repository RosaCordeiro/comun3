HA$PBExportHeader$w_ge063_cadastro_filial.srw
forward
global type w_ge063_cadastro_filial from dc_w_cadastro_freeform
end type
end forward

global type w_ge063_cadastro_filial from dc_w_cadastro_freeform
integer x = 1248
integer y = 496
integer width = 2171
integer height = 2264
string title = "GE063 - Cadastro de Filiais"
boolean resizable = false
long backcolor = 80269524
end type
global w_ge063_cadastro_filial w_ge063_cadastro_filial

type variables
uo_filial ivo_filial
uo_filial ivo_filial_centralizadora
uo_filial ivo_filial_sede_drogaexpress
uo_usuario ivo_usuario
uo_cidade ivo_cidade

String is_Cd_UF = ''
end variables

forward prototypes
public subroutine wf_localiza_cidade (string ps_cidade)
public subroutine wf_localiza_filial_centralizadora (string ps_cd_filial)
public subroutine wf_localiza_filial_sede_drogaexpress (string ps_cd_filial)
public subroutine wf_localiza_telefones ()
public function boolean wf_grava_rede_filial (long pl_filial)
public function boolean wf_verifica_altera_rede ()
public function boolean wf_grava_filial_sap ()
public function boolean wf_verifica_movimento_estoque ()
end prototypes

public subroutine wf_localiza_cidade (string ps_cidade);ivo_Cidade.of_Localiza_Cidade(ps_Cidade)

If ivo_Cidade.Localizada Then
	dw_1.Object.Cd_Cidade	[1] = ivo_Cidade.Cd_Cidade
	dw_1.Object.Nm_Cidade	[1] = ivo_Cidade.Nm_Cidade
	dw_1.Object.cd_uf			[1] = ivo_Cidade.cd_unidade_federacao
End If
end subroutine

public subroutine wf_localiza_filial_centralizadora (string ps_cd_filial);STRING lvs_Filial

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_filial = ps_cd_filial
	
ivo_filial_centralizadora.of_Localiza_Filial(lvs_Filial)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_filial_centralizadora.Localizada Then
	
	dw_1.Object.cd_filial_centralizadora[1] = ivo_filial_centralizadora.cd_filial
  	dw_1.Object.de_filial_centralizadora[1] = ivo_filial_centralizadora.nm_fantasia

Else
	
	SetNull(ivo_filial_centralizadora.cd_Filial)
	ivo_filial_centralizadora.nm_fantasia = ""
	dw_1.Object.Cd_filial_centralizadora[1] = ivo_filial_centralizadora.cd_filial
  	dw_1.Object.de_filial_centralizadora[1] = ivo_filial_centralizadora.nm_fantasia
	  
End If
end subroutine

public subroutine wf_localiza_filial_sede_drogaexpress (string ps_cd_filial);STRING lvs_Filial

lvs_filial = ps_cd_filial
	
ivo_filial_sede_drogaexpress.of_Localiza_Filial(lvs_Filial)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_filial_sede_drogaexpress.Localizada Then
	
	dw_1.Object.cd_filial_sede_drogaexpress[1] = ivo_filial_sede_drogaexpress.cd_filial
  	dw_1.Object.de_filial_sede_drogaexpress[1] = ivo_filial_sede_drogaexpress.nm_fantasia

Else
	
	SetNull(ivo_filial_sede_drogaexpress.cd_Filial)
	ivo_filial_sede_drogaexpress.nm_fantasia = ""
	dw_1.Object.Cd_filial_sede_drogaexpress[1] = ivo_filial_sede_drogaexpress.cd_filial
  	dw_1.Object.de_filial_sede_drogaexpress[1] = ivo_filial_sede_drogaexpress.nm_fantasia
	  
End If
end subroutine

public subroutine wf_localiza_telefones ();Long lvl_Rows , &
	  lvl_Linha, &
	  lvl_Filial

String lvs_Tipo, &
		 lvs_DDD , &
		 lvs_Fone
dc_uo_ds_base lvo_Fone

lvo_Fone = Create dc_uo_ds_base
lvo_Fone.of_ChangeDataObject("ds_ge063_telefones")
lvl_Filial = dw_1.Object.Cd_Filial[1]

lvl_Rows = lvo_Fone.Retrieve(lvl_Filial)

If lvl_Rows >= 0 Then

	For lvl_Linha = 1 To lvl_Rows
		
		lvs_Tipo = lvo_Fone.Object.Id_Tipo	  [lvl_Linha]
		lvs_DDD  = lvo_Fone.Object.Nr_DDD 	  [lvl_Linha]
		lvs_Fone = lvo_Fone.Object.Nr_Telefone[lvl_Linha]
		
		If lvs_Tipo = 'F' Then		
			dw_1.Object.Nr_Ddd_Fax[1] = lvs_DDD
			dw_1.Object.Nr_Fax	 [1] = lvs_Fone
		Else
			dw_1.Object.Nr_Ddd_Telefone[1] = lvs_DDD
			dw_1.Object.Nr_Telefone		[1] = lvs_Fone
		End If
	Next
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreram erros ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es dos telefones.")
End If
end subroutine

public function boolean wf_grava_rede_filial (long pl_filial);String ls_Parametro
String ls_Rede

dw_1.AcceptText()

ls_Rede 			= dw_1.Object.id_rede_filial			[1]
ls_Parametro	= dw_1.Object.id_parametro_rede	[1]

If ls_Parametro <> ls_Rede Then
	If ls_Parametro = '' Then
		Insert Into parametro_loja(	cd_filial,
											cd_parametro,
											vl_parametro)
					Values (:pl_filial,
							  'ID_REDE_FILIAL',
							  :ls_Rede)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback();
			SqlCa.of_MsgdbError('Erro ao incluir a rede da filial. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_grava_rede_filial')
			Return False
		End If
	Else
		Update parametro_loja
			Set vl_parametro = :ls_Rede
		Where cd_parametro = 'ID_REDE_FILIAL'
			And cd_filial = :pl_filial
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback();
			SqlCa.of_MsgdbError('Erro ao alterar a rede da filial. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_grava_rede_filial')
			Return False
		End If
	End If
End If
	
Return True
end function

public function boolean wf_verifica_altera_rede ();Long ll_Achou
Long ll_Filial

dw_1.Accepttext( )
ll_Filial = dw_1.Object.cd_filial [1]

Select	 Count(1)
	Into :ll_Achou
From resumo_movimento_estoque
Where cd_filial = :ll_Filial
	And dh_resumo >= ( Select dateadd(day, -90, dh_movimentacao)
								From parametro
								Where id_parametro = '1' )
	And vl_venda_avista > 0
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgdbError('Erro na consulta da movimenta$$HEX2$$e700e300$$ENDHEX$$o da filial. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_altera_rede')
	Return False
End If

If ll_Achou > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial possui movimenta$$HEX2$$e700e300$$ENDHEX$$o nos $$HEX1$$fa00$$ENDHEX$$ltimos 90 dias." + &
									"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel alterar a rede.", Exclamation!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_grava_filial_sap ();String lvs_Filial
String lvs_Filial_SAP
String lvs_Filial_SAP_Ant
String lvs_Tipo_Alteracao

String lvs_Aux
String lvs_Aux2

dw_1.AcceptText()

If dw_1.GetItemStatus (1, "cd_filial_sap", Primary!) <> NotModified!	Then
	//Exibe confirma$$HEX2$$e700e300$$ENDHEX$$o
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Essa altera$$HEX2$$e700e300$$ENDHEX$$o valer$$HEX1$$e100$$ENDHEX$$ para todas as integra$$HEX2$$e700f500$$ENDHEX$$es efetuadas pelos sistemas.~r~r"+&
						"Deseja realmente alterar a filial SAP?", Exclamation!, YesNo!, 2) = 2 Then Return True
	//Pega valores da datawindow
	lvs_Filial				= String(dw_1.Object.cd_filial [1])
	lvs_Filial_SAP		= dw_1.Object.cd_filial_sap	[1]
	lvs_Filial_SAP_Ant = dw_1.GetItemString(1, "cd_filial_sap", Primary!, true) //valor original do retrieve
	
	//Verifica se j$$HEX1$$e100$$ENDHEX$$ existe alguma filial Sybase apontando para a mesma filial SAP
	Select isf.cd_chave_legado, f.nm_fantasia
	Into :lvs_Aux, :lvs_Aux2
	from integracao_sap isf
	left outer join filial f
		on f.cd_filial = cast(isf.cd_chave_legado as integer)
	Where isf.cd_chave_sap = :lvs_Filial_SAP
		and isf.cd_empresa = 1000
		and isf.cd_tabela = 'FILIAL'
	Using SQLCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback();
		SqlCa.of_MsgdbError('N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel verificar se o c$$HEX1$$f300$$ENDHEX$$digo filial sap informado j$$HEX1$$e100$$ENDHEX$$ pertence a outra filial.')
		Return False
		
	ElseIf SqlCa.SqlCode = 0 Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo de filial SAP "+lvs_Filial_SAP+" j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ sendo utilizado pela filial "+lvs_Aux+" - "+lvs_Aux2+".~r~r"+ &
							"Deseja continuar mesmo assim?", Exclamation!, YesNo!, 2) = 2 Then Return True
	End If
	
	//Se o valor anterior for vazio significa que deve ser feito um insert
	If IsNull(lvs_Filial_SAP_Ant) or (lvs_Filial_SAP_Ant = '') Then
		lvs_Tipo_Alteracao = "I"
		
		Insert Into integracao_sap(	cd_empresa,
											cd_tabela,
											cd_chave_legado,
											cd_chave_sap)
					Values (1000,
							  'FILIAL',
							  :lvs_Filial,
							  :lvs_Filial_SAP)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback();
			SqlCa.of_MsgdbError('Erro ao incluir a rede da filial. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_grava_filial_sap')
			Return False
		End If
	Else
		lvs_Tipo_Alteracao = "A"
		
		Update integracao_sap
			Set cd_chave_sap = :lvs_Filial_SAP
		Where cd_empresa = 1000
			And cd_tabela = 'FILIAL'
			And cd_chave_legado = :lvs_Filial
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback();
			SqlCa.of_MsgdbError('Erro ao alterar a rede da filial. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_grava_filial_sap')
			Return False
		End If
	End If
	
	//Insere log altera$$HEX2$$e700e300$$ENDHEX$$o
	Insert Into historico_alteracao_tabela(nm_tabela, de_chave, nm_coluna, de_alteracao_de, de_alteracao_para, nr_matric_alteracao, id_alteracao)
	Values ('FILIAL', :lvs_Filial, 'CD_FILIAL_SAP', :lvs_Filial_SAP_Ant, :lvs_Filial_SAP, :gvo_aplicacao.ivo_seguranca.nr_matricula, :lvs_Tipo_Alteracao)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es. " + SqlCa.SQLErrText, StopSign!)
		SqlCa.of_RollBack()
		Return False
	End If
End If
	
Return True
end function

public function boolean wf_verifica_movimento_estoque ();Long ll_Achou
Long ll_Filial

dw_1.Accepttext( )
ll_Filial = dw_1.Object.cd_filial [1]

Select	 top 1 1
	Into :ll_Achou
From resumo_movto_estq_prd
Where cd_filial = :ll_Filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgdbError('Erro na consulta da movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque da filial. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_movimento_estoque')
	Return False
End If

If IsNull(ll_Achou) Then ll_Achou = 0

Return (ll_Achou = 1)
end function

on w_ge063_cadastro_filial.create
call super::create
end on

on w_ge063_cadastro_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_cidade)
Destroy(ivo_filial)
Destroy(ivo_filial_centralizadora)
Destroy(ivo_Filial_sede_drogaexpress)
Destroy(ivo_usuario)
end event

event ue_preopen;call super::ue_preopen;ivo_Cidade 						  	= Create uo_cidade
ivo_Filial 						  		= Create uo_filial
ivo_filial_centralizadora			= Create uo_filial
ivo_filial_sede_drogaexpress	= Create uo_filial
ivo_usuario							= Create uo_usuario
end event

event ue_postopen;call super::ue_postopen;//Grava Log Altera$$HEX2$$e700f500$$ENDHEX$$es
ivb_grava_log = True
end event

event open;call super::open;//Chamado 	249074
if gvo_aplicacao.ivo_seguranca.cd_sistema <> "CT" Then
	dw_1.Post of_set_somente_leitura( False )
End if
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge063_cadastro_filial
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge063_cadastro_filial
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge063_cadastro_filial
integer x = 37
integer y = 48
integer width = 2080
integer height = 2028
string dataobject = "dw_ge063_cadastro_filial"
boolean vscrollbar = false
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_cidade"
		If Data <> ivo_Cidade.Nm_Cidade Then
			Return 1
		End If
	Case "de_filial_centralizadora"	
		If data = "" or IsNull(data) Then
		   SetNull(ivo_filial_centralizadora.cd_Filial)
		   ivo_filial_centralizadora.nm_fantasia   = ""
		   dw_1.Object.Cd_filial_centralizadora[1] = ivo_filial_centralizadora.cd_filial
		   dw_1.Object.de_filial_centralizadora[1] = ivo_filial_centralizadora.nm_fantasia
		End If	
	Case "de_filial_sede_drogaexpress"	
		If data = "" or IsNull(data) Then
			SetNull(ivo_filial_sede_drogaexpress.cd_Filial)
			ivo_filial_sede_drogaexpress.nm_fantasia   = ""
			dw_1.Object.Cd_filial_sede_drogaexpress[1] = ivo_filial_sede_drogaexpress.cd_filial
			dw_1.Object.de_filial_sede_drogaexpress[1] = ivo_filial_sede_drogaexpress.nm_fantasia
		End If
	Case  "nm_usuario" 
		If Data <> ivo_Usuario.Nm_Usuario Then 
		//dw_1.Event ue_Pos(1,"nm_usuario")
		Return 1
		End If
	Case 'id_rede_filial'
		If wf_verifica_altera_rede() Then Return 1
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Cidade) Then
	This.Object.Cd_Cidade[1] = ivo_Cidade.Cd_Cidade
	This.Object.Nm_Cidade[1] = ivo_Cidade.Nm_Cidade
End If

If IsValid(ivo_filial_centralizadora) Then 
	dw_1.Object.de_filial_centralizadora[1]    = ivo_filial_centralizadora.Nm_Fantasia
End If	

If IsValid(ivo_filial_sede_drogaexpress) Then 
	dw_1.Object.de_filial_sede_drogaexpress[1] = ivo_filial_sede_drogaexpress.Nm_Fantasia
End If	
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_localizacao"
			ivo_Filial.of_Localiza_Filial(This.GetText(), "", "")
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				
				SetNull(ivo_filial_centralizadora.cd_Filial)
				ivo_filial_centralizadora.nm_fantasia = ""
				SetNull(ivo_filial_sede_drogaexpress.cd_Filial)
				ivo_filial_sede_drogaexpress.nm_fantasia = ""				
				
				This.Event ue_Retrieve()
			End If
			
		Case "nm_cidade"
			wf_Localiza_Cidade(This.GetText())
			
		Case "de_filial_centralizadora"
			wf_localiza_filial_centralizadora(This.GetText())

		Case "de_filial_sede_drogaexpress"
			wf_localiza_filial_sede_drogaexpress(This.GetText())
		Case "nm_usuario"
			ivo_usuario.ivl_filial = 2
			ivo_usuario.of_localiza_usuario(This.GetText())
			If ivo_Usuario.localizado Then
				dw_1.object.nr_matricula_radar[1] = ivo_usuario.nr_matricula
				dw_1.object.nm_usuario  [1] = ivo_usuario.nm_usuario
			End If
		Case "de_gerente"
			dw_1.Accepttext( )
			ivo_usuario.ivl_filial = dw_1.Object.cd_filial[1]
			ivo_usuario.of_localiza_usuario(This.GetText())
			If ivo_Usuario.localizado Then
				dw_1.object.nr_matricula_gerente	[1] = ivo_usuario.nr_matricula
				dw_1.object.de_gerente				[1] = ivo_usuario.nm_usuario
			End If
		Case "de_responsavel"
			dw_1.Accepttext( )
			ivo_usuario.ivl_filial = dw_1.Object.cd_filial[1]
			ivo_usuario.of_localiza_usuario(This.GetText())
			If ivo_Usuario.localizado Then
				dw_1.object.nr_matric_responsavel_anvisa	[1] = ivo_usuario.nr_matricula
				dw_1.object.de_responsavel					[1] = ivo_usuario.nm_usuario
			End If
	End Choose
End If

ivm_Menu.mf_Excluir(False)
end event

event dw_1::ue_recuperar;// Override
Return This.Retrieve(ivo_Filial.Cd_Filial)
end event

event dw_1::constructor;call super::constructor;ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao"}

This.of_SetColSelection(True)
end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivo_Cidade.of_Inicializa()
	//Inicializa a DW de rede da filial
	This.Object.id_rede_filial [1] = ""
	is_Cd_UF = ''
End If

Return AncestorReturnValue
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;Long lvl_filial
Long lvl_Porte

dw_1.AcceptText()

If pl_Linhas > 0 Then
	
	ivo_Cidade.of_Inicializa()
	
	ivo_Cidade.of_Localiza_Cidade(String(This.Object.Cd_Cidade[1]))
	
	lvl_filial = This.Object.cd_filial_centralizadora[1]
	If Not IsNull(lvl_filial) Then
		wf_localiza_filial_centralizadora(String(lvl_filial))
	End If
	
	lvl_filial = This.Object.cd_filial_sede_drogaexpress[1]
	If Not IsNull(lvl_filial) Then
		wf_localiza_filial_sede_drogaexpress(String(lvl_filial))
	End If
	
	wf_Localiza_Telefones()
	
	lvl_Porte = This.Object.cd_porte [1]
	If (Not IsNull(lvl_Porte))and(lvl_Porte > 0) Then
		This.Object.cd_perfil_filial [1] = lvl_Porte
	End If
	
	//Antes da altreracao
	is_Cd_UF = This.Object.cd_uf [1]
	
End If

Return pl_Linhas
end event

event dw_1::ue_preupdate;call super::ue_preupdate;String 	lvs_Nm_Fantasia, &
			lvs_Nm_Razao_Social, &
			lvs_Nr_Insc_Estadual, &
			lvs_Nr_CNPJ, &
			lvs_De_Endereco, &
			lvs_De_Bairro, &
			lvs_Nr_Cep, &
			ls_Rede,&
			ls_Cd_UF
			
Integer	lvi_Cd_Regiao, &
			lvi_Cont

Long	lvl_Cd_Filial, &
		lvl_Cd_Cidade, &
		lvl_Perfil
			
This.AcceptText()

lvl_Cd_Filial				= This.Object.Cd_Filial					[1]
ls_Rede					= This.Object.id_rede_filial				[1]
lvs_Nm_Fantasia 		= This.Object.Nm_Fantasia				[1]
lvs_Nm_Razao_Social	= This.Object.Nm_Razao_Social		[1]
lvs_Nr_Insc_Estadual	= This.Object.Nr_Inscricao_Estadual	[1]
lvs_Nr_CNPJ				= This.Object.Nr_CGC					[1]
lvs_De_Endereco		= This.Object.De_Endereco				[1]
lvs_De_Bairro			= This.Object.De_Bairro					[1]
lvs_Nr_Cep				= This.Object.Nr_CEP						[1]
lvi_Cd_Regiao			= This.Object.Cd_Regiao					[1]
lvl_Cd_Cidade			= This.Object.Cd_Cidade					[1]
ls_Cd_UF					= This.Object.cd_uf						[1]

If (ls_Rede = "")and(lvs_Nr_CNPJ<>'84683481000177') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione a rede da filial.", Exclamation!)
	This.Event ue_Pos(1, "id_rede_filial")
	Return -1
End If

If IsNull(lvs_Nm_Fantasia) or lvs_Nm_Fantasia = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Favor informar o campo [Fantasia].", Exclamation!)
	This.Event ue_Pos(1, "nm_fantasia")
	Return -1
End If

If IsNull(lvs_Nm_Razao_Social) or lvs_Nm_Razao_Social = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Favor informar o campo [Raz$$HEX1$$e300$$ENDHEX$$o Social].", Exclamation!)
	This.Event ue_Pos(1, "nm_razao_social")
	Return -1
End If

If IsNull(lvs_Nr_Insc_Estadual) or lvs_Nr_Insc_Estadual = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Favor informar o campo [Insc. Estadual].", Exclamation!)
	This.Event ue_Pos(1, "nr_inscricao_estadual")
	Return -1
End If

If IsNull(lvs_Nr_CNPJ) or lvs_Nr_CNPJ = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Favor informar o campo [CNPJ].", Exclamation!)
	This.Event ue_Pos(1, "nr_cgc")
	Return -1
End If

If IsNull(lvs_De_Endereco) or lvs_De_Endereco = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Favor informar o campo [Endere$$HEX1$$e700$$ENDHEX$$o].", Exclamation!)
	This.Event ue_Pos(1, "de_endereco")
	Return -1
End If

If IsNull(lvs_De_Bairro) or lvs_De_Bairro = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Favor informar o campo [Bairro].", Exclamation!)
	This.Event ue_Pos(1, "de_bairro")
	Return -1
End If

If IsNull(lvs_Nr_Cep) or lvs_Nr_Cep = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Favor informar o campo [Cep].", Exclamation!)
	This.Event ue_Pos(1, "nr_cep")
	Return -1
End If

If lvl_Cd_Cidade = 0 or IsNull(lvl_Cd_Cidade) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Favor informar o campo [Cidade].", Exclamation!)
	This.Event ue_Pos(1, "nm_cidade")
	Return -1
End If	

If lvi_Cd_Regiao = 0 or IsNull(lvi_Cd_Regiao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Favor informar o campo [Regi$$HEX1$$e300$$ENDHEX$$o].", Exclamation!)
	This.Event ue_Pos(1, "cd_regiao")
	Return -1
End If

//Atual
If Trim(ls_Cd_UF) <> '' and Not IsNull(ls_Cd_UF) Then
	//Anterior
	If Trim(is_Cd_UF) <> '' and Not IsNull(is_Cd_UF) Then
		If ls_Cd_UF <> is_Cd_UF And wf_verifica_movimento_estoque() Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida a altera$$HEX2$$e700e300$$ENDHEX$$o de UF para filial, caso esteja querendo reaproveitar o CNPJ ent$$HEX1$$e300$$ENDHEX$$o INATIVE a filial " + String(lvl_Cd_Filial) + " e crie uma nova com o mesmo CNPJ.", Exclamation!)
			This.Event ue_Pos(1, "cd_uf")
			Return -1
		End If
	End If
End If

If Not wf_Grava_Rede_Filial(lvl_Cd_Filial) Then
	Return -1
End If

If Not wf_grava_filial_sap() Then
	Return -1
End If

This.Object.Cd_Filial_Centro_Distribuicao	[1] = 534
This.Object.Cd_Perfil_Filial						[1] = 0

Return AncestorReturnValue
end event

event dw_1::ue_update;call super::ue_update;Long lvl_Count
Long lvl_Filial

Date lvdt_Porte

//Verifica se existe porte da filial, caso n$$HEX1$$e300$$ENDHEX$$o cadastra como porte 1
If AncestorReturnValue >= 0 Then
	This.AcceptText( )
	lvl_Filial = This.Object.cd_filial [1]

	Select count(1)
	Into :lvl_Count
	From filial_porte
	Where cd_filial = :lvl_filial
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel verificar se a filial os c$$HEX1$$e100$$ENDHEX$$lculos de porte da filial!',Exclamation!)
	ElseIf lvl_Count = 0 Then
		lvdt_Porte = gf_primeiro_dia_mes(RelativeDate(gf_primeiro_dia_mes(Today()),-1))
		
		Insert Into filial_porte (cd_filial, dh_porte, cd_porte, cd_porte_calculado, vl_venda_liquida)
		Values (:lvl_filial, :lvdt_Porte, 1, 1, 0.00)
		Using SQLCa;	
		
		If SQLCa.SQLCode <> 0 Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel cadastrar um porte para a filial!',Exclamation!)
		End If
	End If
End If

Return AncestorReturnValue
end event

event dw_1::ue_cancel;call super::ue_cancel;ivm_Menu.mf_Excluir(False)
is_Cd_UF = ''
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge063_cadastro_filial
integer x = 18
integer y = 0
integer width = 2121
integer height = 2084
integer taborder = 20
end type

