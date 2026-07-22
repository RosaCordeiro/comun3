HA$PBExportHeader$w_ge605_cadastro.srw
$PBExportComments$Cadastro de correspond$$HEX1$$ea00$$ENDHEX$$ncias DExPARA da interface com o SAP
forward
global type w_ge605_cadastro from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge605_cadastro from dc_w_cadastro_selecao_lista
string tag = "w_ge605_cadastro"
integer width = 4581
integer height = 2368
string title = "GE605 - Cadastro DePara - Interface SAP "
end type
global w_ge605_cadastro w_ge605_cadastro

type variables
Integer						ii_qt_parcelas
Long							il_Empresa_Sap
String						is_tp_tabela

uo_condicao_pagamento	ivo_condicao
uo_usuario					ivo_usuario
end variables

forward prototypes
public function boolean wf_verifica_item_sap (string as_chave_sap, long al_linha, ref string as_descricao, ref string as_msg)
public function boolean wf_verifica_item_legado (long al_chave_legado, long al_linha, ref string as_descricao, ref string as_msg)
end prototypes

public function boolean wf_verifica_item_sap (string as_chave_sap, long al_linha, ref string as_descricao, ref string as_msg);Long		ll_linha, ll_tot_lin
String	ls_Find

as_descricao = ''

ll_tot_lin = dw_2.RowCount ()

ll_linha = dw_2.Find ("cd_chave_sap = '" + as_chave_sap + "'", 1, ll_tot_lin)

Do Until ll_linha = 0
	If ll_linha = al_linha then
		ll_linha = dw_2.Find ("cd_chave_sap = '" + as_chave_sap + "'", ll_linha + 1, ll_tot_lin)
	else
		/* N$$HEX1$$e300$$ENDHEX$$o permitir$$HEX1$$e100$$ENDHEX$$ gravar item que j$$HEX1$$e100$$ENDHEX$$ esteja cadastrado */ 
		as_msg = 'Item j$$HEX1$$e100$$ENDHEX$$ cadastrado - Verifique: ' + as_chave_sap
		Return False
	End if
Loop

Return True
end function

public function boolean wf_verifica_item_legado (long al_chave_legado, long al_linha, ref string as_descricao, ref string as_msg);Long		ll_linha, ll_tot_lin
String	ls_Find

as_descricao = ''

ll_tot_lin = dw_2.RowCount ()

ll_linha = dw_2.Find ("cd_chave_legado = '" + String (al_chave_legado) + "'", 1, ll_tot_lin)

Do Until ll_linha = 0
	If ll_linha = al_linha then
		If ll_linha = ll_tot_lin then
			ll_linha = 0
		else
			ll_linha = dw_2.Find ("cd_chave_legado = '" + String (al_chave_legado) + "'", ll_linha + 1, ll_tot_lin)
		End if
	else
		/* N$$HEX1$$e300$$ENDHEX$$o permitir$$HEX1$$e100$$ENDHEX$$ gravar item que j$$HEX1$$e100$$ENDHEX$$ esteja cadastrado */ 
		as_msg = 'Item j$$HEX1$$e100$$ENDHEX$$ cadastrado - Verifique: ' + String (al_chave_legado)
		Return False
	End if
Loop

Choose case is_tp_tabela
	case 'CONDICAO_PAGAMENTO'
		SELECT de_condicao
		     , qt_parcelas
		  INTO :as_descricao
		     , :ii_qt_parcelas
		  FROM condicao_pagamento
		 WHERE COALESCE (id_situacao, 'A') = 'A'
			AND cd_condicao = CAST (:al_chave_legado AS DECIMAL)
		 USING SQLCA;
			
	case 'GRUPO_COMPRADOR'
		//N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio buscar informa$$HEX2$$e700e300$$ENDHEX$$o adicional na tabela USUARIO, pois ela j$$HEX1$$e100$$ENDHEX$$ foi pesquisada pelo objeto UO_USUARIO
		SQLCa.SQLCode = 0
End choose

Choose case SQLCa.SQLCode
	case -1
		SQLCa.Of_RollBack()
		SQLCa.Of_MsgDbError ('Falha ao buscar a chave do legado')
		Return False
	case 100
		as_msg = 'A chave ' + String (al_chave_legado) + ' n$$HEX1$$e300$$ENDHEX$$o existe no legado!'
		Return False
End choose

Return True
end function

on w_ge605_cadastro.create
call super::create
end on

on w_ge605_cadastro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Condicao                    = Create uo_Condicao_Pagamento
ivo_Condicao.ib_Valida_Situacao = True

ivo_usuario                     = Create uo_usuario
end event

event close;call super::close;Destroy ivo_Condicao
Destroy ivo_usuario
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge605_cadastro
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge605_cadastro
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge605_cadastro
integer width = 1783
string dataobject = "dw_ge605_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Reset ()
end event

event dw_1::ue_addrow;call super::ue_addrow;dw_1.Object.cd_empresa [1] = 1000

Return 1
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge605_cadastro
integer width = 4471
integer height = 1864
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge605_cadastro
integer width = 4471
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge605_cadastro
event wf_verifica_insere ( string as_tabela )
integer x = 59
integer y = 348
integer width = 4398
integer height = 1792
string dataobject = "dw_ge605_cadastro_cond_pgto"
end type

event dw_2::ue_recuperar;//override
Long	ll_Totlin

dw_1.AcceptText ()

il_Empresa_Sap = dw_1.Object.cd_empresa [1]
is_tp_tabela   = dw_1.Object.tp_tabela  [1]

Choose Case is_tp_tabela
	Case 'CONDICAO_PAGAMENTO'
		This.of_ChangeDataObject ('dw_ge605_cadastro_cond_pgto')
	Case 'GRUPO_COMPRADOR'
		This.of_ChangeDataObject ('dw_ge605_cadastro_grp_comprdr')
End Choose 		

This.SetRedraw (False)

ll_Totlin = This.Retrieve (il_Empresa_Sap, is_tp_tabela)

If ll_Totlin < 0 then
	This.Reset ()
	Return -1
End If

SetPointer (Arrow!)
This.SetRedraw (True)

Return This.RowCount ()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.Sort ()

Return pl_linhas
end event

event dw_2::constructor;call super::constructor;This.Of_Setrowselection ()

end event

event dw_2::itemchanged;call super::itemchanged;DWItemStatus	ldwis_estado_linha
String			ls_descricao, ls_msg
String			ls_msg_cond_pagto = 'A altera$$HEX2$$e700e300$$ENDHEX$$o da correspond$$HEX1$$ea00$$ENDHEX$$ncia entre as chaves de CONDI$$HEX2$$c700c300$$ENDHEX$$O DE PAGAMENTO no legado e no SAP pode afetar os pedidos pendentes.'
String			ls_msg_grp_comprd = 'A altera$$HEX2$$e700e300$$ENDHEX$$o da correspond$$HEX1$$ea00$$ENDHEX$$ncia entre as chaves de GRUPO COMPRADOR no legado e no SAP pode afetar os pedidos pendentes.'

ldwis_estado_linha = This.GetItemStatus (row, 0, Primary!)

Choose case is_tp_tabela
	case 'CONDICAO_PAGAMENTO'
		ls_msg = ls_msg_cond_pagto
	case 'GRUPO_COMPRADOR'
		ls_msg = ls_msg_grp_comprd
End choose

Choose case dwo.Name
		
	case 'cd_chave_sap'
		If ldwis_estado_linha = NotModified!  or &
			ldwis_estado_linha = DataModified! then
			If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!', &
								ls_msg + '~n~rDeseja continuar mesmo assim?', &
								Question!, YesNo!, 2) = 2 then
				Return 1
			End if
		End if

		If Not wf_verifica_item_sap (data, row, Ref ls_descricao, Ref ls_msg) then 
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg)
			Return 1
		End if

End choose

This.Object.dh_inclusao           [row] = gf_GetServerDate ()
This.Object.nr_matricula_inclusao [row] = gvo_Aplicacao.ivo_seguranca.nr_matricula
This.Object.nm_usuario            [row] = gvo_Aplicacao.ivo_seguranca.nm_usuario

Return 0
end event

event dw_2::ue_addrow;call super::ue_addrow;Long	ll_linha

This.Of_Setrowselection ()

ll_linha = AncestorReturnValue

This.Object.cd_empresa [ll_linha] = il_Empresa_Sap
This.Object.cd_tabela  [ll_linha] = is_tp_tabela

This.Setcolumn ('cd_chave_legado')
This.Setfocus () 

Return AncestorReturnValue
end event

event dw_2::ue_preupdate;call super::ue_preupdate;DateTime	ldt_valor_ant, ldt_valor_atu
Long		ll_linha, ll_tot_del
String	ls_nulo, ls_log, ls_valor_ant, ls_valor_atu, ls_coluna

If This.ModifiedCount () + This.DeletedCount () = 0 then
	Return 1
End if

SetNull (ls_nulo)

ll_linha = This.GetNextModified (0, Primary!)
		
Do While ll_linha > 0
	
	If IsNull (This.Object.cd_chave_legado [ll_linha]) or This.Object.cd_chave_legado [ll_linha] = '' then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a chave no legado!', Exclamation!)
		
		Choose case is_tp_tabela
			case 'CONDICAO_PAGAMENTO'
				ls_coluna = 'de_condicao'
			case 'GRUPO_COMPRADOR'
				ls_coluna = 'usuario_comprador'
		End choose
		
		This.Event ue_Pos (ll_linha, ls_coluna)
		Return -1				
	End If
	
	If IsNull (This.Object.cd_chave_sap [ll_linha]) or This.Object.cd_chave_sap [ll_linha] = '' then
		Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'Informe a chave no SAP!', Exclamation!)
		This.Event ue_Pos (ll_linha, 'cd_chave_sap')
		Return -1
	End if

	Choose case This.GetItemStatus (ll_linha, 0, Primary!)
		//Inclus$$HEX1$$f500$$ENDHEX$$es
		case NewModified!
			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
																	  'CD_EMPRESA', ls_nulo, String (This.Object.cd_empresa [ll_linha]), gvo_Aplicacao.ivo_seguranca.nr_matricula, 'I', Ref ls_log, True) then
				Return -1
			End if
			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
																	  'CD_TABELA', ls_nulo, This.Object.cd_tabela [ll_linha], gvo_Aplicacao.ivo_seguranca.nr_matricula, 'I', Ref ls_log, True) then
				Return -1
			End if
			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
																	  'CD_CHAVE_LEGADO', ls_nulo, This.Object.cd_chave_legado [ll_linha], gvo_Aplicacao.ivo_seguranca.nr_matricula, 'I', Ref ls_log, True) then
				Return -1
			End if
			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
																	  'CD_CHAVE_SAP', ls_nulo, This.Object.cd_chave_sap [ll_linha], gvo_Aplicacao.ivo_seguranca.nr_matricula, 'I', Ref ls_log, True) then
				Return -1
			End if
			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
																	  'DH_INCLUSAO', ls_nulo, String (This.Object.dh_inclusao [ll_linha], 'dd/mm/yyyy hh:mm:ss'), gvo_Aplicacao.ivo_seguranca.nr_matricula, 'I', Ref ls_log, True) then
				Return -1
			End if
			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
																	  'NR_MATRICULA_INCLUSAO', ls_nulo, This.Object.nr_matricula_inclusao [ll_linha], gvo_Aplicacao.ivo_seguranca.nr_matricula, 'I', Ref ls_log, True) then
				Return -1
			End if
			
		//Altera$$HEX2$$e700f500$$ENDHEX$$es
		case DataModified!
			
			ls_valor_ant = This.GetItemString (ll_linha, 'cd_chave_legado', Primary!, True)
			ls_valor_atu = This.GetItemString (ll_linha, 'cd_chave_legado', Primary!, False)
			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
																	  'CD_CHAVE_LEGADO', ls_valor_ant, ls_valor_atu, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'A', Ref ls_log, True) then
				Return -1
			End if
			
			ls_valor_ant = This.GetItemString (ll_linha, 'cd_chave_sap', Primary!, True)
			ls_valor_atu = This.GetItemString (ll_linha, 'cd_chave_sap', Primary!, False)
			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
																	  'CD_CHAVE_SAP', ls_valor_ant, ls_valor_atu, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'A', Ref ls_log, True) then
				Return -1
			End if
			
			ldt_valor_ant = This.GetItemDateTime (ll_linha, 'dh_inclusao', Primary!, True)
			ldt_valor_atu = This.GetItemDateTime (ll_linha, 'dh_inclusao', Primary!, False)
			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
																	  'DH_INCLUSAO', String (ldt_valor_ant, 'dd/mm/yyyy hh:mm:ss'), String (ldt_valor_atu, 'dd/mm/yyyy hh:mm:ss'), gvo_Aplicacao.ivo_seguranca.nr_matricula, 'A', Ref ls_log, True) then
				Return -1
			End if
			
			ls_valor_ant = This.GetItemString (ll_linha, 'nr_matricula_inclusao', Primary!, True)
			ls_valor_atu = This.GetItemString (ll_linha, 'nr_matricula_inclusao', Primary!, False)
			If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
																	  String (il_Empresa_Sap) + '@#!' + This.Object.cd_chave_legado [ll_linha] + '@#!' + is_tp_tabela, &
																	  'NR_MATRICULA_INCLUSAO', ls_valor_ant, ls_valor_atu, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'A', Ref ls_log, True) then
				Return -1
			End if
	End choose
	
	ll_linha = This.GetNextModified (ll_linha, Primary!)
	
Loop

//Exclus$$HEX1$$f500$$ENDHEX$$es
ll_tot_del = This.DeletedCount ()
		
For ll_linha = 1 to ll_tot_del
	
	ls_valor_ant = This.GetItemString (ll_linha, 'cd_chave_legado', Delete!, True)
	
	If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
															  String (il_Empresa_Sap) + '@#!' + ls_valor_ant + '@#!' + is_tp_tabela, &
															  'CD_EMPRESA', String (This.GetItemNumber (ll_linha, 'cd_empresa', Delete!, True)), ls_nulo, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'E', Ref ls_log, True) then
		Return -1
	End if
	If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
															  String (il_Empresa_Sap) + '@#!' + ls_valor_ant + '@#!' + is_tp_tabela, &
															  'CD_TABELA', This.GetItemString (ll_linha, 'cd_tabela', Delete!, True), ls_nulo, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'E', Ref ls_log, True) then
		Return -1
	End if
	If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
															  String (il_Empresa_Sap) + '@#!' + ls_valor_ant + '@#!' + is_tp_tabela, &
															  'CD_CHAVE_LEGADO', This.GetItemString (ll_linha, 'cd_chave_legado', Delete!, True), ls_nulo, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'E', Ref ls_log, True) then
		Return -1
	End if
	If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
															  String (il_Empresa_Sap) + '@#!' + ls_valor_ant + '@#!' + is_tp_tabela, &
															  'CD_CHAVE_SAP', This.GetItemString (ll_linha, 'cd_chave_sap', Delete!, True), ls_nulo, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'E', Ref ls_log, True) then
		Return -1
	End if
	If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
															  String (il_Empresa_Sap) + '@#!' + ls_valor_ant + '@#!' + is_tp_tabela, &
															  'DH_INCLUSAO', String (This.GetItemDateTime (ll_linha, 'dh_inclusao', Delete!, True), 'dd/mm/yyyy hh:mm:ss'), ls_nulo, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'E', Ref ls_log, True) then
		Return -1
	End if
	If Not gf_Grava_Historico_Alteracao_Tabela ('INTEGRACAO_SAP', &
															  String (il_Empresa_Sap) + '@#!' + ls_valor_ant + '@#!' + is_tp_tabela, &
															  'NR_MATRICULA_INCLUSAO', This.GetItemString (ll_linha, 'nr_matricula_inclusao', Delete!, True), ls_nulo, gvo_Aplicacao.ivo_seguranca.nr_matricula, 'E', Ref ls_log, True) then
		Return -1
	End if
	
Next

Return 1
end event

event dw_2::ue_key;call super::ue_key;DWItemStatus	ldwis_estado_linha
Long				ll_linha
String			ls_descricao, ls_msg
String			ls_msg_cond_pagto = 'A altera$$HEX2$$e700e300$$ENDHEX$$o da correspond$$HEX1$$ea00$$ENDHEX$$ncia entre as chaves de CONDI$$HEX2$$c700c300$$ENDHEX$$O DE PAGAMENTO no legado e no SAP pode afetar os pedidos pendentes.'
String			ls_msg_grp_comprd = 'A altera$$HEX2$$e700e300$$ENDHEX$$o da correspond$$HEX1$$ea00$$ENDHEX$$ncia entre as chaves de GRUPO COMPRADOR no legado e no SAP pode afetar os pedidos pendentes.'

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case 'de_condicao'
			Choose case is_tp_tabela
				case 'CONDICAO_PAGAMENTO'
					ll_linha = This.GetRow ()
					ldwis_estado_linha = This.GetItemStatus (ll_linha, 0, Primary!)
					If ldwis_estado_linha = NotModified!  or &
						ldwis_estado_linha = DataModified! then
						If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!', &
											ls_msg_cond_pagto + '~n~rDeseja continuar mesmo assim?', &
											Question!, YesNo!, 2) = 2 then
							Return 1
						End if
					End if
					If ivo_Condicao.of_Localiza (This.GetText ()) then
						If Not wf_verifica_item_legado (ivo_Condicao.cd_condicao, ll_linha, Ref ls_descricao, Ref ls_msg) then 
							MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg)
							Return 1
						else
							This.Object.cd_chave_legado       [ll_linha] = String (ivo_Condicao.cd_condicao)
							This.Object.de_condicao           [ll_linha] = ls_descricao
							This.Object.qt_parcelas           [ll_linha] = ii_qt_parcelas
							This.Object.dh_inclusao           [ll_linha] = gf_GetServerDate ()
							This.Object.nr_matricula_inclusao [ll_linha] = gvo_Aplicacao.ivo_seguranca.nr_matricula
							This.Object.nm_usuario            [ll_linha] = gvo_Aplicacao.ivo_seguranca.nm_usuario
							This.SetColumn ('cd_chave_sap')
							This.Post SetRow (ll_linha)
							This.SetFocus ()
						End If
					End If
			End choose
			
		case 'usuario_comprador'
			Choose case is_tp_tabela
				case 'GRUPO_COMPRADOR'
					ll_linha = This.GetRow ()
					ldwis_estado_linha = This.GetItemStatus (ll_linha, 0, Primary!)
					If ldwis_estado_linha = NotModified!  or &
						ldwis_estado_linha = DataModified! then
						If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!', &
											ls_msg_grp_comprd + '~n~rDeseja continuar mesmo assim?', &
											Question!, YesNo!, 2) = 2 then
							Return 1
						End if
					End if
					
					ivo_usuario.of_localiza_usuario (This.GetText ())
					
					If ivo_usuario.Localizado then
						If Not wf_verifica_item_legado (Long (ivo_usuario.nr_matricula), ll_linha, Ref ls_descricao, Ref ls_msg) then 
							MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg)
							Return 1
						else
							This.Object.cd_chave_legado       [ll_linha] = ivo_usuario.nr_matricula
							This.Object.usuario_comprador     [ll_linha] = ivo_usuario.nm_usuario
							This.Object.dh_inclusao           [ll_linha] = gf_GetServerDate ()
							This.Object.nr_matricula_inclusao [ll_linha] = gvo_Aplicacao.ivo_seguranca.nr_matricula
							This.Object.nm_usuario            [ll_linha] = gvo_Aplicacao.ivo_seguranca.nm_usuario
							This.SetColumn ('cd_chave_sap')
							This.Post SetRow (ll_linha)
							This.SetFocus ()
						End If
					End If
			End choose
			
	End Choose
End If
end event

