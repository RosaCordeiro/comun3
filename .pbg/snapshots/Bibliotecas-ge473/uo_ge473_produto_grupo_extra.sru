HA$PBExportHeader$uo_ge473_produto_grupo_extra.sru
forward
global type uo_ge473_produto_grupo_extra from nonvisualobject
end type
end forward

global type uo_ge473_produto_grupo_extra from nonvisualobject
end type
global uo_ge473_produto_grupo_extra uo_ge473_produto_grupo_extra

type variables
Boolean 	ib_execucao_simultanea=false
Long 		il_tabela = 137
Long 		il_nr_requisicao
String	is_de_chave_acesso_sap

end variables

forward prototypes
public subroutine of_processa_atualizacao (long al_tabela)
public function boolean of_atualiza_area_atuacao (string as_codigo_sap, string as_descricao, ref string as_log)
public function boolean of_atualiza_atributo (string as_codigo_sap, string as_descricao, ref string as_log)
public function boolean of_atualiza_posologia (string as_codigo_sap, string as_descricao, ref string as_log)
public function boolean of_atualiza_precaucoes (string as_codigo_sap, string as_descricao, ref string as_log)
public function boolean of_atualiza_publico_dest (string as_codigo_sap, string as_descricao, ref string as_log)
public function boolean of_atualiza_faixa_etaria (string as_codigo_sap, string as_descricao, ref string as_log)
public function boolean of_atualiza_selo (string as_codigo_sap, string as_descricao, ref string as_log)
public function boolean of_atualiza_texto_min_saude (string as_codigo_sap, string as_descricao, ref string as_log)
public function boolean of_atualiza_produto_grupo_extra (long al_controle, long al_tabela)
end prototypes

public subroutine of_processa_atualizacao (long al_tabela);dc_uo_ds_base	lds_controle

Long				ll_Linhas,      &
					ll_Linha,       &
					ll_nr_controle, &
					ll_controles_gerando

Try
	
	lds_controle = Create dc_uo_ds_base
	
	If Not lds_controle.of_ChangeDataObject ('ds_ge473_lista_controles', False) then
		gvo_aplicacao.of_grava_log('Interface Produto Grupo Extra - Erro ao alterar a DW [ds_ge473_lista_controles] - uo_ge473_produto_grupo_extra.of_processa_atualizacao')
		Return
	End if
	
	ll_Linhas = lds_controle.Retrieve (al_Tabela)
	
	Choose case ll_Linhas
		case is > 0
			For ll_Linha = 1 To ll_Linhas
				uo_ge473_produto_grupo_extra	luo_ge473_produto_grupo_extra
				
				Try
					luo_ge473_produto_grupo_extra = Create uo_ge473_produto_grupo_extra
					luo_ge473_produto_grupo_extra.of_atualiza_produto_grupo_extra (lds_controle.Object.nr_controle [ll_Linha], al_tabela)
					
				Finally
					Destroy luo_ge473_produto_grupo_extra
				End try
				
			Next
			
		case is < 0
			gvo_aplicacao.of_grava_log ("Interface Produto Grupo Extra - Erro ao recuperar os dados da DW [ds_ge473_lista_controles] - uo_ge473_produto_grupo_extra.of_processa_atualizacao")
		
	End choose
	
Finally
	Destroy lds_controle
End try
end subroutine

public function boolean of_atualiza_area_atuacao (string as_codigo_sap, string as_descricao, ref string as_log);Long	ll_Prox_Codigo

UPDATE produto_area_atuacao
  	SET de_produto_area_atuacao = :as_descricao
 WHERE cd_codigo_sap = :as_codigo_sap
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	as_log = 'Erro ao atualizar a descri$$HEX2$$e700e300$$ENDHEX$$o do produto_area_atuacao (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
	Return False
End if

If SQLCA.SQLNRows = 0 then
	
	SELECT COALESCE (MAX (cd_produto_area_atuacao), 0) + 1
	  INTO :ll_Prox_Codigo
	  FROM produto_area_atuacao
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro ao obter o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo na tabela produto_area_atuacao: ' + SQLCA.SQLErrText
		Return False
	End if
	
	INSERT INTO produto_area_atuacao
					( cd_produto_area_atuacao
					, de_produto_area_atuacao
					, cd_codigo_sap)
			VALUES
					( :ll_Prox_Codigo
					, :as_descricao
					, :as_codigo_sap)
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o na tabela produto_area_atuacao (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
		Return False
	End if
	
End if

Return True
end function

public function boolean of_atualiza_atributo (string as_codigo_sap, string as_descricao, ref string as_log);Long	ll_Prox_Codigo

UPDATE produto_atributo
  	SET de_produto_atributo = :as_descricao
 WHERE cd_codigo_sap = :as_codigo_sap
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	as_log = 'Erro ao atualizar a descri$$HEX2$$e700e300$$ENDHEX$$o do produto_atributo (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
	Return False
End if

If SQLCA.SQLNRows = 0 then
	
	SELECT COALESCE (MAX (cd_produto_atributo), 0) + 1
	  INTO :ll_Prox_Codigo
	  FROM produto_atributo
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro ao obter o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo na tabela produto_atributo: ' + SQLCA.SQLErrText
		Return False
	End if
	
	INSERT INTO produto_atributo
					( cd_produto_atributo
					, de_produto_atributo
					, cd_codigo_sap)
			VALUES
					( :ll_Prox_Codigo
					, :as_descricao
					, :as_codigo_sap)
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o na tabela produto_atributo (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
		Return False
	End if
	
End if

Return True
end function

public function boolean of_atualiza_posologia (string as_codigo_sap, string as_descricao, ref string as_log);Long	ll_Prox_Codigo

UPDATE produto_posologia
  	SET de_produto_posologia = :as_descricao
 WHERE cd_codigo_sap = :as_codigo_sap
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	as_log = 'Erro ao atualizar a descri$$HEX2$$e700e300$$ENDHEX$$o do produto_posologia (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
	Return False
End if

If SQLCA.SQLNRows = 0 then
	
	SELECT COALESCE (MAX (cd_produto_posologia), 0) + 1
	  INTO :ll_Prox_Codigo
	  FROM produto_posologia
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro ao obter o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo na tabela produto_posologia: ' + SQLCA.SQLErrText
		Return False
	End if
	
	INSERT INTO produto_posologia
					( cd_produto_posologia
					, de_produto_posologia
					, cd_codigo_sap)
			VALUES
					( :ll_Prox_Codigo
					, :as_descricao
					, :as_codigo_sap)
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o na tabela produto_posologia (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
		Return False
	End if
	
End if

Return True
end function

public function boolean of_atualiza_precaucoes (string as_codigo_sap, string as_descricao, ref string as_log);Long	ll_Prox_Codigo

UPDATE produto_precaucoes
  	SET de_produto_precaucoes = :as_descricao
 WHERE cd_codigo_sap = :as_codigo_sap
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	as_log = 'Erro ao atualizar a descri$$HEX2$$e700e300$$ENDHEX$$o do produto_precaucoes (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
	Return False
End if

If SQLCA.SQLNRows = 0 then
	
	SELECT COALESCE (MAX (cd_produto_precaucoes), 0) + 1
	  INTO :ll_Prox_Codigo
	  FROM produto_precaucoes
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro ao obter o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo na tabela produto_precaucoes: ' + SQLCA.SQLErrText
		Return False
	End if
	
	INSERT INTO produto_precaucoes
					( cd_produto_precaucoes
					, de_produto_precaucoes
					, cd_codigo_sap)
			VALUES
					( :ll_Prox_Codigo
					, :as_descricao
					, :as_codigo_sap)
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o na tabela produto_precaucoes (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
		Return False
	End if
	
End if

Return True
end function

public function boolean of_atualiza_publico_dest (string as_codigo_sap, string as_descricao, ref string as_log);Long	ll_Prox_Codigo

UPDATE produto_publico_dest
  	SET de_produto_publico_dest = :as_descricao
 WHERE cd_codigo_sap = :as_codigo_sap
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	as_log = 'Erro ao atualizar a descri$$HEX2$$e700e300$$ENDHEX$$o do produto_publico_dest (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
	Return False
End if

If SQLCA.SQLNRows = 0 then
	
	SELECT COALESCE (MAX (cd_produto_publico_dest), 0) + 1
	  INTO :ll_Prox_Codigo
	  FROM produto_publico_dest
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro ao obter o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo na tabela produto_publico_dest: ' + SQLCA.SQLErrText
		Return False
	End if
	
	INSERT INTO produto_publico_dest
					( cd_produto_publico_dest
					, de_produto_publico_dest
					, cd_codigo_sap)
			VALUES
					( :ll_Prox_Codigo
					, :as_descricao
					, :as_codigo_sap)
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o na tabela produto_publico_dest (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
		Return False
	End if
	
End if

Return True
end function

public function boolean of_atualiza_faixa_etaria (string as_codigo_sap, string as_descricao, ref string as_log);Long	ll_Prox_Codigo

UPDATE produto_faixa_etaria
  	SET de_produto_faixa_etaria = :as_descricao
 WHERE cd_codigo_sap = :as_codigo_sap
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	as_log = 'Erro ao atualizar a descri$$HEX2$$e700e300$$ENDHEX$$o do produto_faixa_etaria (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
	Return False
End if

If SQLCA.SQLNRows = 0 then
	
	SELECT COALESCE (MAX (cd_produto_faixa_etaria), 0) + 1
	  INTO :ll_Prox_Codigo
	  FROM produto_faixa_etaria
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro ao obter o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo na tabela produto_faixa_etaria: ' + SQLCA.SQLErrText
		Return False
	End if
	
	INSERT INTO produto_faixa_etaria
					( cd_produto_faixa_etaria
					, de_produto_faixa_etaria
					, cd_codigo_sap)
			VALUES
					( :ll_Prox_Codigo
					, :as_descricao
					, :as_codigo_sap)
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o na tabela produto_faixa_etaria (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
		Return False
	End if
	
End if

Return True
end function

public function boolean of_atualiza_selo (string as_codigo_sap, string as_descricao, ref string as_log);Long	ll_Prox_Codigo

UPDATE produto_selo
  	SET de_produto_selo = :as_descricao
 WHERE cd_codigo_sap = :as_codigo_sap
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	as_log = 'Erro ao atualizar a descri$$HEX2$$e700e300$$ENDHEX$$o do produto_selo (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
	Return False
End if

If SQLCA.SQLNRows = 0 then
	
	SELECT COALESCE (MAX (cd_produto_selo), 0) + 1
	  INTO :ll_Prox_Codigo
	  FROM produto_selo
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro ao obter o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo na tabela produto_selo: ' + SQLCA.SQLErrText
		Return False
	End if
	
	INSERT INTO produto_selo
					( cd_produto_selo
					, de_produto_selo
					, cd_codigo_sap)
			VALUES
					( :ll_Prox_Codigo
					, :as_descricao
					, :as_codigo_sap)
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o na tabela produto_selo (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
		Return False
	End if
	
End if

Return True
end function

public function boolean of_atualiza_texto_min_saude (string as_codigo_sap, string as_descricao, ref string as_log);Long	ll_Prox_Codigo

UPDATE produto_texto_min_saude
  	SET de_produto_texto_min_saude = :as_descricao
 WHERE cd_codigo_sap = :as_codigo_sap
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	as_log = 'Erro ao atualizar a descri$$HEX2$$e700e300$$ENDHEX$$o do produto_texto_min_saude (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
	Return False
End if

If SQLCA.SQLNRows = 0 then
	
	SELECT COALESCE (MAX (cd_produto_texto_min_saude), 0) + 1
	  INTO :ll_Prox_Codigo
	  FROM produto_texto_min_saude
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro ao obter o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo na tabela produto_texto_min_saude: ' + SQLCA.SQLErrText
		Return False
	End if
	
	INSERT INTO produto_texto_min_saude
					( cd_produto_texto_min_saude
					, de_produto_texto_min_saude
					, cd_codigo_sap)
			VALUES
					( :ll_Prox_Codigo
					, :as_descricao
					, :as_codigo_sap)
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_log = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o na tabela produto_texto_min_saude (c$$HEX1$$f300$$ENDHEX$$digo SAP: ' + as_codigo_sap + '): ' + SQLCA.SQLErrText
		Return False
	End if
	
End if

Return True
end function

public function boolean of_atualiza_produto_grupo_extra (long al_controle, long al_tabela);Boolean 			lb_Sucesso = False
Long 				ll_Atualizacao_Pend, ll_Linhas, ll_for
String 			ls_Log, ls_Chave_Controle, &
					ls_Campo, ls_Codigo, ls_Descricao
uo_ge473_comum	luo_ge473_comum

Try
	luo_ge473_comum = Create uo_ge473_comum
	
	SELECT de_chave_sap
	  INTO :is_de_chave_acesso_sap
	  FROM interface_sap
	 WHERE cd_tabela   = :il_Tabela
		AND nr_controle = :al_controle
	 USING SQLCA;
	
	If SQLCA.SQLCode = -1 then
		ls_Log = 'Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: ' + String (al_controle) + '. Erro: ' + SQLCA.SQLErrText
		Return False
	End if
	
	If Not luo_ge473_comum.of_atualizacao_pendente (al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 then Return True
	
	If Not luo_ge473_comum.of_Muda_Situacao_Interface (al_Controle, Ref ls_Log) then Return False
	If Not luo_ge473_comum.of_localiza_chave_controle (al_Controle, Ref ls_Chave_Controle, Ref ls_Log) then Return False
	
	If luo_ge473_comum.of_processa_carrega_dados (al_controle, Ref ls_Log) then
		
		ll_Linhas = luo_ge473_comum.ids_lista_registros.RowCount ()
		
		If IsValid (w_aguarde_3) then
			w_aguarde_3.uo_progress_2.of_reset ()
			w_aguarde_3.uo_progress_2.of_setmax (ll_linhas)
		End if
		
		For ll_for = 1 to ll_linhas
			ls_Campo     = luo_ge473_comum.ids_lista_registros.Object.campo     [ll_for]
			ls_Codigo    = luo_ge473_comum.ids_lista_registros.Object.codigo    [ll_for]
			ls_Descricao = luo_ge473_comum.ids_lista_registros.Object.descricao [ll_for]
			
			Choose case Upper (ls_Campo)
				case 'ZCD_AREA_ATUACAO'
					If not of_atualiza_area_atuacao (ls_Codigo, ls_Descricao, Ref ls_Log) then Return False
					
				case 'ZCD_ATRIBUTO'
					If not of_atualiza_atributo (ls_Codigo, ls_Descricao, Ref ls_Log) then Return False
					
				case 'ZCD_POSOLOGIA'
					If not of_atualiza_posologia (ls_Codigo, ls_Descricao, Ref ls_Log) then Return False
					
				case 'ZCD_PRECAUCOES'
					If not of_atualiza_precaucoes (ls_Codigo, ls_Descricao, Ref ls_Log) then Return False
					
				case 'ZCD_PUBLICO_DESTINADO'
					If not of_atualiza_publico_dest (ls_Codigo, ls_Descricao, Ref ls_Log) then Return False
					
				case 'ZCD_FAIXA_ETARIA'
					If not of_atualiza_faixa_etaria (ls_Codigo, ls_Descricao, Ref ls_Log) then Return False
					
				case 'ZCD_SELO'
					If not of_atualiza_selo (ls_Codigo, ls_Descricao, Ref ls_Log) then Return False
					
				case 'ZDE_SEQ_MINISTERIO_SAUDE'
					If not of_atualiza_texto_min_saude (ls_Codigo, ls_Descricao, Ref ls_Log) then Return False
					
			End choose
			
		next	
		
		lb_Sucesso = true
	End if

Catch (RunTimeError	lo_rte)
	ls_Log = 'Objeto [uo_ge473_produto_grupo_extra], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_produto_grupo_extra]. Erro: ' + lo_rte.GetMessage ()
	Return False
	
Finally
	
	If lb_Sucesso then
		SqlCa.of_Commit ()
	else
		SQLCA.of_RollBack ()
		luo_ge473_comum.of_grava_erro (al_controle, 175, ls_Log)
	End if
	
	Destroy luo_ge473_comum
	
End try

Return True
end function

on uo_ge473_produto_grupo_extra.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_produto_grupo_extra.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

