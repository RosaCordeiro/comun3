HA$PBExportHeader$uo_ge651_rh_central.sru
forward
global type uo_ge651_rh_central from nonvisualobject
end type
end forward

global type uo_ge651_rh_central from nonvisualobject
end type
global uo_ge651_rh_central uo_ge651_rh_central

type variables
dc_uo_transacao Rubi
dc_uo_encript ivo_Encript
end variables

forward prototypes
public function integer of_abre_arquivo_log (string ps_arquivo)
public function boolean of_grava_log (string ps_Mensagem, integer pi_log)
public subroutine of_exclui_log_vazio (string ps_Arquivo)
public function boolean of_insere_conveniado_central (integer pi_log)
public function boolean of_insere_usuario_central (integer pi_log)
public subroutine of_disconnect_rubi (integer pi_log)
public function boolean of_connecta_rubi (integer pi_log)
public function boolean of_insere_gerentes (integer pi_log)
public function boolean of_nr_bloqueio (ref long pl_bloqueio, integer pi_log)
public function boolean of_atualiza_gerente (integer pi_log)
public function boolean of_verifica_disque_entrega (long pl_filial, ref boolean pb_disque, integer pi_log)
public function boolean of_atualiza_farmaceuticos (integer pi_log)
public subroutine of_atualiza_bionitgen ()
public function boolean of_inativa_usuario (integer pi_log)
public function boolean of_reativa_usuario (integer pi_log)
public function string of_trata_situacao_usuario (string ps_matricula, long ps_situacao_rh)
public function boolean of_verifica_usuario_isento_inativacao (string ps_matricula)
public function boolean of_insere_conveniado_central (integer pi_log, long al_convenio, string as_matricula, string as_nome, string as_senha, decimal adc_limite, string as_cpf, string as_sexo)
public function boolean of_insere_usuario_filial (long pl_filial, string ps_matricula, string ps_cbo, string ps_cargo, integer pi_idade, integer pi_log, dc_uo_transacao ptr_base)
public function boolean of_insere_usuario_filial (long pl_filial, string ps_sistema, string ps_matricula, integer pi_perfil, integer pi_log, dc_uo_transacao ptr_base)
public function boolean of_insere_usuario_filial (long pl_filial, string ps_sistema, string ps_matricula, string ps_cbo, string ps_cargo, integer pi_log, dc_uo_transacao ptr_base)
public function boolean of_exclui_usuario_filial (string ps_matricula, string ps_sistema, integer pi_log, dc_uo_transacao ptr_base)
public function integer of_perfil_usuario_sistema (string ps_cbo, string ps_cargo, integer pi_log, long pl_filial, string ps_sistema, dc_uo_transacao ptr_base)
public function boolean of_atualiza_vacinador (integer pi_log)
public subroutine of_atualizacao_rh_central ()
public subroutine of_mensagem_processo (string as_erro_msg)
end prototypes

public function integer of_abre_arquivo_log (string ps_arquivo);Integer lvi_Arquivo_Log

lvi_Arquivo_Log = FileOpen(ps_Arquivo, LineMode!, Write!, Shared!, Append!)

If lvi_Arquivo_Log = -1 Then	
	of_mensagem_processo ('Erro na abertura do arquivo : ' + ps_Arquivo + '.')
	Halt Close	
End If

Return lvi_Arquivo_Log
end function

public function boolean of_grava_log (string ps_Mensagem, integer pi_log);Integer lvi_Status

String lvs_Mensagem 

lvs_Mensagem = String(Today(), 'dd/mm/yyyy') + ' ' + &
               String(Now(), 'hh:mm:ss') + ' ' + ps_Mensagem
	
lvi_Status = FileWrite(pi_LOG, lvs_Mensagem)

If lvi_Status <> LenA(lvs_Mensagem) Then	
	of_mensagem_processo ('Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo de log.')
	Return False
Else
	Return True
End If
end function

public subroutine of_exclui_log_vazio (string ps_Arquivo);// Se o arquivo de log estiver vazio, exclui o arquivo
If FileExists(ps_Arquivo) Then
	If FileLength(ps_Arquivo) = 0 Then		
		FileDelete(ps_Arquivo)
	End If
End If
end subroutine

public function boolean of_insere_conveniado_central (integer pi_log);Boolean lvb_Commit						= True
Boolean lb_Open							= False
Boolean lb_Grava_Convenio_Vacina 	= False //Novo Convenio CLAMED

Long lvl_Rows , &
	 lvl_Linha, &
	 lvl_Convenio, &
	 lvl_Cargo,&
	 lvl_Empresa,&
	 lvl_Filial, &
	 lvl_Bloqueio, &
	 ll_Find

Long lvl_Convenio_Vacina
	  
String lvs_Matricula, &
		 lvs_Nome     , &
		 lvs_Achou	  , &
		 lvs_Senha    , &
		 lvs_Cpf        , &
		 lvs_Possui_DC,&
		 lvs_Tipo_Sexo
		 
Decimal lvdc_Limite

If Not IsValid(w_Aguarde) Then
	lb_Open = True
	Open(w_Aguarde)
End If

w_Aguarde.Title = 'Inserindo conveniados. Aguarde...'

dc_uo_ds_base lvds_Rubi
				  
lvds_Rubi = Create dc_uo_ds_base
	
lvds_Rubi.of_SetTransObject(Rubi)
	
If Not lvds_Rubi.of_ChangeDataObject('ds_ge651_lista_conveniados_inseridos') Then
	lvb_Commit = False
End If

lvds_Rubi.Retrieve()

lvl_Rows = lvds_Rubi.RowCount()

If lvl_Rows > 0 Then
	w_Aguarde.uo_Progress.of_SetMax( lvl_Rows )
End If

For lvl_Linha = 1 To lvl_Rows
	w_Aguarde.Title = 'Inserindo / Atualizando conveniados . Aguarde...' + String( lvl_Linha ) + ' de ' + String( lvl_Rows )
	w_Aguarde.uo_Progress.of_SetProgress( lvl_Linha )
	
	//Inicializa a gravacao convenio Vacina
	lb_Grava_Convenio_Vacina = False	
	
	lvs_Matricula	= Trim( lvds_Rubi.Object.Nr_Matricula		[lvl_Linha] )
	lvs_Nome		= Trim( lvds_Rubi.Object.Nm_Conveniado	[lvl_Linha] )
	lvs_Senha		= '' // lvds_Rubi.Object.De_Senha			[lvl_Linha]
	lvl_Cargo			= Long(lvds_Rubi.Object.Cargo					[lvl_Linha] )
	lvl_Empresa		= Long(lvds_Rubi.Object.Cd_Empresa		[lvl_Linha] )
	lvl_Filial			= Long(lvds_Rubi.Object.Cd_Filial 				[lvl_Linha] )
	lvs_Cpf			= Trim( lvds_Rubi.Object.Cpf					[lvl_Linha] )
	lvs_Possui_DC	= lvds_Rubi.Object.Possui_DC					[lvl_Linha]
	lvs_Tipo_Sexo  = lvds_Rubi.Object.Tipo_Sexo					[lvl_Linha]
		
	Choose Case lvl_Cargo
		Case 752, 764, 901, 956
			lvdc_Limite = 100.00
			
		Case 690, 790, 1437 // Estagi$$HEX1$$e100$$ENDHEX$$rios (chamado: 1810930)
			Continue // N$$HEX1$$e300$$ENDHEX$$o insere o conveniado
			
		Case Else
			SetNull(lvdc_Limite)
	End Choose
	
	Choose Case lvl_Empresa
		Case 1 // CLAMED		
			lvl_Convenio 			= 50805
			lvl_Convenio_Vacina 	= 54627
			//Inclui tambem para o convenio CLAMED - VACINA
			lb_Grava_Convenio_Vacina = True
			
		Case 2 // INCOR
			lvl_Convenio = 51135
			
		Case 3 // Quimidrol
			lvl_Convenio = 50633
			
		Case 6 // NEXT STEP ( FISK )
			lvl_Convenio = 52920
		
		Case Else //Empresa 4 - AB - Ainda n$$HEX1$$e300$$ENDHEX$$o temos definicao para esse caso
			Continue
			
	End Choose
	
	If Not of_Insere_Conveniado_Central(pi_Log, lvl_Convenio, lvs_Matricula, lvs_Nome, lvs_Senha, lvdc_Limite, lvs_Cpf, lvs_Tipo_Sexo ) Then
		lvb_Commit = False
		Exit
	End If
	
	//Convenio CLAMED - VACINA
	If lb_Grava_Convenio_Vacina Then
		If Not of_Insere_Conveniado_Central(pi_Log, lvl_Convenio_Vacina, lvs_Matricula, lvs_Nome, lvs_Senha, lvdc_Limite, lvs_Cpf, lvs_Tipo_Sexo ) Then
			lvb_Commit = False
			Exit
		End If
	End If
	
Next

Destroy(lvds_Rubi)

If lb_Open Then Close(w_Aguarde)

Return lvb_Commit
end function

public function boolean of_insere_usuario_central (integer pi_log);Integer li_Idade

Boolean lvb_Commit	= True
Boolean lb_Open		= False

Long lvl_Rows			 , &
	   lvl_Linha			 , &
	   lvl_Filial			 , &
	   lvl_Comissao_Aux, &
	   lvl_Comissao
	  
String lvs_Matricula	, &
		 lvs_Nome     	, &
		 lvs_Achou		, &
		 lvs_Senha		, &
		 lvs_CBO          // CBO -> $$HEX1$$e900$$ENDHEX$$ o cargo do usu$$HEX1$$e100$$ENDHEX$$rio conforme Comiss$$HEX1$$e300$$ENDHEX$$o Brasileira de Ocupa$$HEX2$$e700f500$$ENDHEX$$es,

String	 ls_Cargo
String	 ls_Cargo_Grav
		 
String lvs_Cpf
String lvs_Cliente

If Not IsValid(w_Aguarde) Then
	lb_Open = True
	Open(w_Aguarde)
End If

w_Aguarde.Title = 'Inserindo usu$$HEX1$$e100$$ENDHEX$$rios. Aguarde...'

dc_uo_ds_base lvds_Cargo_Sybase
lvds_Cargo_Sybase = Create dc_uo_ds_base

If Not lvds_Cargo_Sybase.of_ChangeDataObject('ds_ge651_cargo_sybase', False) Then
	Return False
End If

lvds_Cargo_Sybase.Retrieve()

dc_uo_ds_base lvds_Rubi
lvds_Rubi = Create dc_uo_ds_base
	
lvds_Rubi.of_SetTransObject(Rubi)
	
If Not lvds_Rubi.of_ChangeDataObject('ds_ge651_lista_usuarios_inseridos', False) Then
	lvb_Commit = False
End If
				
lvds_Rubi.Retrieve()

lvl_Rows = lvds_Rubi.RowCount()

If lvl_Rows > 0 Then
	w_Aguarde.uo_Progress.of_SetMax( lvl_Rows )
End If

For lvl_Linha = 1 To lvl_Rows
	w_Aguarde.Title = 'Inserindo / Atualizando usu$$HEX1$$e100$$ENDHEX$$rios . Aguarde...' + String( lvl_Linha ) + ' de ' + String( lvl_Rows )
	w_Aguarde.uo_Progress.of_SetProgress( lvl_Linha )
	
	lvb_Commit = True
	
	lvs_Matricula 	= Trim( lvds_Rubi.Object.Nr_Matricula	[lvl_Linha] )
	lvs_Nome      	= Trim( lvds_Rubi.Object.Nm_Usuario 	[lvl_Linha] )
	lvl_Filial	     	= lvds_Rubi.Object.Cd_Filial      	[lvl_Linha]
	lvl_Comissao 	= lvds_Rubi.Object.Comissao     	[lvl_Linha]
	lvs_CBO			= lvds_Rubi.Object.CBO 				[lvl_Linha]
	lvs_Cpf			= Trim( String( lvds_Rubi.Object.NumCpf[lvl_Linha]	) )
	lvs_Cpf			= Fill( '0', 11 ) + lvs_Cpf
	lvs_Cpf			= RightA( lvs_Cpf, 11 )
	ls_Cargo			= lvds_Rubi.Object.cd_cargo [lvl_Linha]
	ls_Cargo_Grav	= ls_Cargo
	li_Idade			= Integer( lvds_Rubi.Object.Idade [lvl_Linha] )
		
	// Funcion$$HEX1$$e100$$ENDHEX$$rios da Log$$HEX1$$ed00$$ENDHEX$$stica
	If lvl_Filial = 100 Then
		lvl_Filial = 534
	End If

//Chamado 1052741: Trecho comentado para sincronizar todos os cargos, pois h$$HEX1$$e100$$ENDHEX$$ necessidade para o novo PDV
//	//Se for filial 534 verifica e sincroniza apenas os cargos cadastrados no sybase
//	If lvl_Filial = 534  Then
//		If lvds_Cargo_Sybase.Find("cd_cargo_rh='"+ls_Cargo_Grav+"'", 1, lvds_Cargo_Sybase.RowCount()) <= 0 Then
//			SetNull(ls_Cargo_Grav)
//		End If
//	End If
		
	If lvl_Comissao = 0 Then
		SetNull(lvl_Comissao)
	End If
	
   //Verifica se o Usu$$HEX1$$e100$$ENDHEX$$rio j$$HEX1$$e100$$ENDHEX$$ Existe
	Select nm_usuario
	  Into :lvs_Achou
	  From usuario
	 Where nr_matricula = :lvs_Matricula
	Using SqlCa;

	Choose Case SqlCa.SqlCode
				
		Case -1 //Erro
			SqlCa.of_LogdbError(pi_Log, 'USU$$HEX1$$c100$$ENDHEX$$RIO (' + lvs_Matricula + ') Localiza$$HEX2$$e700e300$$ENDHEX$$o')
			lvb_Commit = False

		Case 100 //N$$HEX1$$e300$$ENDHEX$$o Encontrou
			lvs_Senha = ivo_encript.of_encripta(lvs_Matricula)
			
			INSERT INTO usuario
					(nr_matricula,
					 nm_usuario,
					 de_senha,
					 cd_filial,
					 cd_filial_atualizacao,
					 dh_atualizacao_filial,
					 id_situacao,
					 nr_cpf,
					 id_isento_biometria,
					 id_senha_criptografada,
					 cd_cargo_rh)
			VALUES (:lvs_Matricula,
					 :lvs_Nome,
					 :lvs_Senha,
					 :lvl_Filial,
					 534,
					 getdate(),
					 'A',
					 :lvs_Cpf,
					 'N',
					 'S',
					 :ls_Cargo_Grav)
			 USING SQLCA;
		
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_LogdbError(pi_Log, 'USU$$HEX1$$c100$$ENDHEX$$RIO (' + lvs_Matricula + ') Inclus$$HEX1$$e300$$ENDHEX$$o')
				lvb_Commit = False
			End If
			
			If lvb_Commit Then
				INSERT INTO vendedor
						(nr_matricula_vendedor,
						 pc_comissao,
						 cd_tipo_comissao)
				VALUES (:lvs_Matricula,
						  0,
						  :lvl_Comissao)
				USING SqlCa;

				If SqlCa.SqlCode = -1 Then
					SqlCa.of_LogdbError(pi_Log, 'VENDEDOR (' + lvs_Matricula + ') Inclus$$HEX1$$e300$$ENDHEX$$o')
					lvb_Commit = False
				End If //Erro SqlCa
			End If
			
			// S$$HEX1$$f300$$ENDHEX$$ vai incluir quando o usu$$HEX1$$e100$$ENDHEX$$rio for novo
			If lvb_Commit Then
				If Not of_Insere_Usuario_Filial(lvl_Filial, lvs_Matricula, lvs_CBO, ls_Cargo, li_Idade, pi_Log, SqlCa) Then
					lvb_Commit = False
				End If
			End If
			
		Case 0 //Encontrou - Atualiza o Nome
				
					UPDATE usuario
						 SET 	nm_usuario				= :lvs_Nome,
							   	nr_cpf					= :lvs_Cpf,
								cd_cargo_rh				= :ls_Cargo_Grav,
								cd_filial_atualizacao	= 534,
								dh_atualizacao_filial	= getdate()
					WHERE nr_matricula 		=   :lvs_Matricula
						AND 	((nm_usuario	<> :lvs_Nome) OR
							   	(coalesce(nr_cpf,'')<> coalesce(:lvs_Cpf,'')) OR
								(coalesce(cd_cargo_rh,'')	<> coalesce(:ls_Cargo_Grav,'')))
					 USING SqlCa;
				
					If SqlCa.SqlCode = -1 Then
						SqlCa.of_LogdbError(pi_Log, 'USU$$HEX1$$c100$$ENDHEX$$RIO (' + lvs_Matricula + ') Atualiza$$HEX2$$e700e300$$ENDHEX$$o')
						lvb_Commit = False
					End If
				
				If lvb_Commit Then
					SELECT cd_tipo_comissao
					  INTO :lvl_Comissao_Aux
					  FROM vendedor
					 WHERE nr_matricula_vendedor = :lvs_Matricula
					 Using SqlCa;
					
					Choose Case SqlCa.SqlCode
						Case -1 //Erro
							SqlCa.of_LogdbError(pi_Log, 'VENDEDOR (' + lvs_Matricula + ') Localiza$$HEX2$$e700e300$$ENDHEX$$o')
							lvb_Commit = False
							
						Case 100 //N$$HEX1$$e300$$ENDHEX$$o Encontrou
							If lvb_Commit Then								
								INSERT INTO vendedor
										(nr_matricula_vendedor,
										 pc_comissao,
										 cd_tipo_comissao)
								VALUES (:lvs_MAtricula,
										  0,
										  :lvl_Comissao)
								USING SqlCa;
								
								If SqlCa.SqlCode = -1 Then
									SqlCa.of_LogdbError(pi_Log, 'VENDEDOR (' + lvs_Matricula + ') Inclus$$HEX1$$e300$$ENDHEX$$o')
									lvb_Commit = False
								End If //Erro SqlCa
							End If // Commit And Filial
							
						Case 0						
								
							UPDATE vendedor
								SET cd_tipo_comissao		  = :lvl_Comissao
							 WHERE nr_matricula_vendedor = :lvs_Matricula
							 	And coalesce(cd_tipo_comissao,0)	  <> coalesce(:lvl_Comissao,0)
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
								SqlCa.of_LogdbError(pi_Log, 'VENDEDOR (' + lvs_Matricula + ') Atualiza$$HEX2$$e700e300$$ENDHEX$$o')
								lvb_Commit = False
							End If //Erro SqlCa
					End Choose
					
				End If
				
				If lvb_Commit Then
					If Not of_Insere_Usuario_Filial(lvl_Filial, lvs_Matricula, lvs_CBO, ls_Cargo, li_Idade, pi_Log, SqlCa) Then
						lvb_Commit = False
					End If
				End If				
				
	End Choose
	
	If lvb_Commit Then
		SqlCa.of_Commit()
	Else
		SqlCa.of_RollBack()		
	End If		

Next

Destroy(lvds_Rubi)
Destroy(lvds_Cargo_Sybase)

If lb_Open Then Close(w_Aguarde)

Return lvb_Commit
end function

public subroutine of_disconnect_rubi (integer pi_log);Integer lvi_Retorno

Rubi.of_Disconnect();

lvi_Retorno = Rubi.SqlCode

If lvi_Retorno = -1 Then
	This.of_Grava_Log('N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel desconnectar do banco de dados do RH. ' + Rubi.SQLErrText, pi_Log)
End If
end subroutine

public function boolean of_connecta_rubi (integer pi_log);Rubi = Create dc_uo_transacao
Rubi.ivs_DataBase = 'ORACLE_RH'

Return Rubi.of_Connect( 'vetorh_ti', 'TDC' )

//Return Rubi.of_Connect('VETORH_HOMOLOG', '')  // ORACLE

end function

public function boolean of_insere_gerentes (integer pi_log);Boolean lvb_Commit = True
Boolean lb_Open = False

Long lvl_Rows  , &
	  lvl_Linha , &
	  lvl_Filial, &
	  lvl_Filial_Aux = 0, &
	  lvl_Achou
	  
String lvs_Nome, &
		 lvs_Matricula, &
		 lvs_Situacao, &
		 ls_Achou
		 
If Not IsValid(w_Aguarde) Then
	lb_Open = True
	Open(w_Aguarde)
End If
w_Aguarde.Title = 'Inserindo gerentes das filiais. Aguarde...'

dc_uo_ds_base lvds_Rubi
lvds_Rubi = Create dc_uo_ds_base
	
lvds_Rubi.of_SetTransObject(Rubi)
	
If Not lvds_Rubi.of_ChangeDataObject('ds_ge651_lista_gerentes') Then
	lvb_Commit = False
End If
				
lvds_Rubi.Retrieve()

lvl_Rows = lvds_Rubi.RowCount()

If lvl_Rows > 0 Then
	w_Aguarde.uo_Progress.of_SetMax( lvl_Rows )
End If

 Delete 
 From filial_gerente
  Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(pi_Log, 'FILIAL_GERENTE (' + String(lvl_Filial) + ' - ' + lvs_Matricula + ') Exclus$$HEX1$$e300$$ENDHEX$$o')
		SqlCa.of_RollBack()
Else	
	SqlCa.of_Commit()
End If
	
For lvl_Linha = 1 To lvl_Rows
	lvl_Filial 	      = Long(lvds_Rubi.Object.Filial[lvl_Linha])
	lvs_Matricula = String(lvds_Rubi.Object.Matricula[lvl_Linha])
	lvs_Situacao  = String(lvds_Rubi.Object.DesSit   [lvl_Linha])
	
	if lvl_Filial = 795 then
		lvl_filial = lvl_filial
	end if
	
	If Upper(Trim(lvs_Situacao)) = 'TRABALHANDO' Then
		SetNull(lvs_Situacao)
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress( lvl_Linha )
	w_Aguarde.Title = 'Atualizando gerentes da filial ' + String(lvl_Filial) + '. Aguarde...'
	
		
	Insert Into filial_gerente
	  (cd_filial, nr_matricula, de_situacao)
	Values(:lvl_Filial, :lvs_Matricula, :lvs_Situacao)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(pi_Log, 'FILIAL_GERENTE (' + String(lvl_Filial) + ' - ' + lvs_Matricula + ') Inclus$$HEX1$$e300$$ENDHEX$$o')
		SqlCa.of_RollBack()
	Else
		SqlCa.of_Commit()
	End If		
  
Next

Destroy(lvds_Rubi)

If lb_Open Then Close(w_Aguarde)

Return lvb_Commit
end function

public function boolean of_nr_bloqueio (ref long pl_bloqueio, integer pi_log);Boolean lvb_Sucesso = True

Select max(nr_bloqueio)
  Into :pl_bloqueio
  From bloqueio
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(pi_Log, 'NR_BLOQUEIO -  LOCALIZA$$HEX2$$c700c300$$ENDHEX$$O')
	lvb_Sucesso = False
Else
	pl_bloqueio++
End If
 
Return lvb_Sucesso
end function

public function boolean of_atualiza_gerente (integer pi_log);Boolean lvb_Commit = True
Boolean lb_Open      = False

Long ll_Linha, &
	   ll_Total, &
	   ll_Filial, &
	   ll_Filial_Aux = 0, &
  	   ll_Find
		
String ls_Matricula, &
         ls_Matricula_Aux, &
		ls_Situacao, &
		ls_Situacao_Aux
		
If Not IsValid(w_Aguarde) Then
	lb_Open = True
	Open(w_Aguarde)
End If

w_Aguarde.Title = 'Atualizando gerente das filiais. Aguarde...'

dc_uo_ds_base lvds_Rubi
lvds_Rubi = Create dc_uo_ds_base
	
lvds_Rubi.of_SetTransObject(Rubi)
	
If Not lvds_Rubi.of_ChangeDataObject('ds_ge651_lista_gerentes') Then
	lvb_Commit = False
End If

//lvds_Rubi.of_AppendWhere( "UPPER(dessit) = 'TRABALHANDO'" )
lvds_Rubi.of_AppendWhere( "((UPPER(dessit) NOT LIKE '%AUX%'  AND UPPER(dessit) NOT LIKE '%ACI%') OR dessit IS NULL )" )
ll_Total = lvds_Rubi.Retrieve()

If ll_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax( ll_Total )
End If

For ll_Linha = 1 To ll_Total
	ll_Filial		= Long( lvds_Rubi.Object.Filial			[ll_Linha] )
	ls_Matricula = String( lvds_Rubi.Object.Matricula	[ll_Linha] )
	ls_Situacao  = String( lvds_Rubi.Object.DesSit		[ll_Linha] )
	
	w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
	w_Aguarde.Title = 'Atualizando gerente da filial ' + String(ll_Filial) + '. Aguarde...'
	
	UPDATE usuario_sistema_filial
		 SET cd_perfil_usuario	= 1
	WHERE nr_matricula			= :ls_Matricula
		AND cd_perfil_usuario 	<> 1
	 USING SqlCa;
	
	 If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(pi_Log, 'USUARIO_SISTEMA_FILIAL (' + String(ll_Filial) + ' - ' + ls_Matricula + ') Atualiza$$HEX2$$e700e300$$ENDHEX$$o' )
		SqlCa.of_RollBack()
	 Else
		SqlCa.of_Commit()	
	 End If
	 
	 
	INSERT
		INTO usuario_sistema_filial (	cd_filial,
												cd_sistema,
												nr_matricula,
												cd_perfil_usuario )
	SELECT	f.cd_filial,
				p.cd_sistema,
				:ls_Matricula,
				p.cd_perfil_usuario
		FROM	perfil_usuario p
				INNER JOIN filial f
					ON 1 = 1
				INNER JOIN sistema s
					ON s.cd_sistema = p.cd_sistema
		 WHERE p.de_perfil_usuario in ( 'GERENTE', 'GERENTE DE LOJA')
		 	 AND s.id_loja = 'S'
			 AND f.id_situacao = 'A'
			 AND f.cd_filial NOT IN (1,2,534,1000)
			 AND f.cd_filial NOT IN ( SELECT cd_filial FROM usuario_sistema_filial WHERE nr_matricula = :ls_Matricula )
	 USING SqlCa;
	
	 If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(pi_Log, 'USUARIO_SISTEMA_FILIAL (' + String(ll_Filial) + ' - ' + ls_Matricula + ') Inclus$$HEX1$$e300$$ENDHEX$$o' )
		SqlCa.of_RollBack()
	 Else
		SqlCa.of_Commit()	
	 End If
	
	/**************/
	
	If Upper(Trim(ls_Situacao)) <> 'TRABALHANDO' Then
		ll_Find = lvds_Rubi.Find('filial = ' + String(ll_Filial) + ' and matricula <> ' + ls_Matricula + " and lower( dessit ) = 'trabalhando'"  , 1, ll_Total)
		
		If ll_find > 0 Then
			ls_Matricula	= String( lvds_Rubi.Object.Matricula[ll_find] )
			ls_Situacao	= String( lvds_Rubi.Object.DesSit    [ll_find] )
			
			If ll_Linha < ll_find Then
				ll_Linha = ll_find
			End If
		End If
	End If
	
    Update filial
	     set nr_matricula_gerente = :ls_Matricula
	where cd_filial = :ll_Filial
	    and COALESCE( nr_matricula_gerente, '' ) <> :ls_Matricula
	  Using SqlCa;
	  
	 If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(pi_Log, 'FILIAL (' + String(ll_Filial) + ' - ' + ls_Matricula + ') Atualiza$$HEX2$$e700e300$$ENDHEX$$o')
		SqlCa.of_RollBack()
	 Else
		SqlCa.of_Commit()	
	 End If
Next

Destroy(lvds_Rubi)

If lb_Open Then Close(w_Aguarde)

Return True
end function

public function boolean of_verifica_disque_entrega (long pl_filial, ref boolean pb_disque, integer pi_log);Long lvl_Achou

Date 	lvdt_Movimento_Inicial,&
		lvdt_Movimento_Final

lvdt_Movimento_Final = Date(gf_GetServerDate())

lvdt_Movimento_Inicial = RelativeDate(lvdt_Movimento_Final,  - 10)

Select Count(nr_nf)
Into :lvl_Achou
From nf_venda
Where dh_movimentacao_caixa between :lvdt_Movimento_Inicial and :lvdt_Movimento_Final
	and cd_filial 						=: pl_Filial
    and nr_pedido_drogaexpress 	is not null
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(pi_Log, ' NF VENDA (' + String(pl_Filial) + ') Localiza$$HEX2$$e700e300$$ENDHEX$$o')						
	Return False
End If

If lvl_Achou > 0 Then
	pb_Disque = True
Else
	pb_Disque = False
End If

Return True
end function

public function boolean of_atualiza_farmaceuticos (integer pi_log);Boolean lvb_Commit = True
Boolean lb_Open      = False

Long ll_Linha			, &
	   ll_Total			, &
	   ll_Filial				, &
	   ll_Filial_Aux = 0	, &
  	   ll_Find
		
String ls_Matricula				, &
         ls_Numero_Registro	, &
		ls_Uf_Crf
		
If Not IsValid(w_Aguarde) Then
	lb_Open = True
	Open(w_Aguarde)
End If

w_Aguarde.Title = 'Atualizando cadastro de farmac$$HEX1$$ea00$$ENDHEX$$uticos. Aguarde...'
Yield( )

dc_uo_ds_base lvds_Rubi
lvds_Rubi = Create dc_uo_ds_base
	
lvds_Rubi.of_SetTransObject(Rubi)
	
If Not lvds_Rubi.of_ChangeDataObject('ds_ge651_lista_farmaceuticos') Then
	lvb_Commit = False
End If

ll_Total = lvds_Rubi.Retrieve()

If ll_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax( ll_Total )
End If

For ll_Linha = 1 To ll_Total
	ls_Matricula				= String( lvds_Rubi.Object.Matricula			[ll_Linha] )
	ls_Numero_Registro	= String( lvds_Rubi.Object.Registro			[ll_Linha] )
	ls_Uf_Crf					= String( lvds_Rubi.Object.Cd_Uf_Conselho	[ll_Linha] )
	
	w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
	w_Aguarde.Title = 'Atualizando farmac$$HEX1$$ea00$$ENDHEX$$utico ' + ls_Matricula + '. Aguarde...'
	Yield( )
	
    Update usuario
	    Set nr_registro_crf	= :ls_Numero_Registro,
			 cd_uf_crf		= :ls_Uf_Crf
	Where nr_matricula = :ls_Matricula
		And ((coalesce(cd_uf_crf,'') <> coalesce(:ls_Uf_Crf,'') 
			or coalesce(nr_registro_crf,'') <> coalesce(:ls_Numero_Registro,'')))
	  Using SqlCa;
	  
	 If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(pi_Log, 'Matr$$HEX1$$ed00$$ENDHEX$$cula (' + ls_Matricula + ') Atualiza$$HEX2$$e700e300$$ENDHEX$$o do CRF :: uo_ge651_rh_central.of_atualiza_farmaceuticos( pi_log )')
		SqlCa.of_RollBack()
	 Else
		SqlCa.of_Commit()	
	 End If
	
Next

Destroy(lvds_Rubi)

If lb_Open Then Close(w_Aguarde)

Return True
end function

public subroutine of_atualiza_bionitgen ();Boolean lb_Sucesso = True

Integer li_Retorno
Integer li_File

String ls_Log
String ls_Caminho_Log


Try
	Pipeline lo_Pipe
	lo_Pipe = Create Pipeline
	
	dc_uo_ds_base lo_Error
	lo_Error = Create dc_uo_ds_base
	
	lo_Pipe.DataObject = 'pl_tdc012_identificacao_biometrica_central_senior'

	li_Retorno = lo_Pipe.Start( SqlCa, Rubi, lo_Error )
	
	ls_Log =	"Lidos: '"    + String(lo_Pipe.RowsRead   , "000000") + "' || " + &
				"Gravados: '" + String(lo_Pipe.RowsWritten - lo_Pipe.RowsInError, "000000") + "' || " + &
				"Errados: '"  + String(lo_Pipe.RowsInError    , "000000") + "'"
				
	
	
	ls_Caminho_Log = ProfileString( gvo_Aplicacao.ivs_Arquivo_Ini, 'Diretorio', 'Diretorio', '' )
	
	If ( lo_Pipe.RowsWritten - lo_Pipe.RowsInError ) > 0 Then
		Rubi.of_Commit( )
		
		If DirectoryExists( ls_Caminho_Log ) Then
			li_File = FileOpen( ls_Caminho_Log + '\identificacao_biometrica_central_rh.log', LineMode!, Write!, LockWrite!, Append! )
			
			If li_File > 0 Then
				FileWrite( li_File, String( DateTime( Today(), Now() ) ) + '  ' + ls_Log )
			End If
		End If
	End If
	
Catch( Exception ex )
Finally
	FileClose( li_File )
	Destroy lo_Pipe
	Destroy lo_Error
End Try
end subroutine

public function boolean of_inativa_usuario (integer pi_log);Boolean lvb_Commit = True

Long	lvl_Rows
Long	lvl_Linha
Long	lvl_Sit_Afa
Long	lvl_Filial

Datetime lvdh_Afast
	  
String lvs_Matricula
String lvs_Nome
String lvs_CPF
String lvs_Cargo
String lvs_Sit_Usu
String lvs_Msg_Email

dc_uo_ds_base lvds_Rubi
lvds_Rubi = Create dc_uo_ds_base
	
lvds_Rubi.of_SetTransObject(Rubi)
	
If Not lvds_Rubi.of_ChangeDataObject('ds_ge651_colaborador_rh') Then
	lvb_Commit = False
End If
lvds_Rubi.of_appendwhere( 'datafa >= current_date - 31' )
				
lvds_Rubi.Retrieve()

lvl_Rows = lvds_Rubi.RowCount()

For lvl_Linha = 1 To lvl_Rows
	lvs_Matricula	= lvds_Rubi.Object.matricula		[lvl_Linha]
	lvs_Nome		= lvds_Rubi.Object.nome			[lvl_Linha]
	lvl_Sit_Afa		= lvds_Rubi.Object.sitafa				[lvl_Linha]
	lvl_Filial			= lvds_Rubi.Object.filial				[lvl_Linha]
	lvs_Cargo		= lvds_Rubi.Object.descargo		[lvl_Linha]
	lvs_CPF			= String(lvds_Rubi.Object.numcpf	[lvl_Linha], '00000000000')
	lvdh_Afast		= lvds_Rubi.Object.datafa			[lvl_Linha]
	
	lvs_Sit_Usu = This.Of_trata_situacao_usuario( lvs_Matricula, lvl_Sit_Afa)
	
	// Consulta novamente na view com o tipo 2
	// Chamado: 2233936 - Ajuste no Processo de Inativa$$HEX2$$e700e300$$ENDHEX$$o de Usu$$HEX1$$e100$$ENDHEX$$rio
	If lvs_Sit_Usu <> 'A' Then
		
		select sitafa 
		Into :lvl_Sit_Afa
		from vdc_lista_colaboradores
		where empresa = 1
		   and tipcol = 2
		   and matricula = :lvs_Matricula
		Using Rubi;		

		Choose Case Rubi.SqlCode
			Case 0
				lvs_Sit_Usu = This.Of_trata_situacao_usuario( lvs_Matricula, lvl_Sit_Afa)
			Case 100
				//
			Case -1
				Rubi.of_LogdbError(pi_Log, 'USU$$HEX1$$c100$$ENDHEX$$RIO INATIVO (' + lvs_Matricula + ') Atualiza$$HEX2$$e700e300$$ENDHEX$$o')
				Destroy(lvds_Rubi)
				Return False
		End Choose
		
	End If	
	
	UPDATE usuario
		SET id_situacao  = :lvs_Sit_Usu,
			  cd_filial_atualizacao = 534,
			  dh_atualizacao_filial = getdate()
	 WHERE nr_matricula = :lvs_Matricula
	   AND id_situacao  <> :lvs_Sit_Usu
	 Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(pi_Log, 'USU$$HEX1$$c100$$ENDHEX$$RIO INATIVO (' + lvs_Matricula + ') Atualiza$$HEX2$$e700e300$$ENDHEX$$o')
		lvb_Commit = False
	End If
	
	//CHAMADO 480359: Envio de e-mail quando inativar usu$$HEX1$$e100$$ENDHEX$$rios da matriz
	If lvs_Sit_Usu = 'I' and SqlCa.SQLNRows = 1 and (lvl_Filial = 534 or lvl_Filial = 2) Then
		lvs_Msg_Email = 'O(a) colaborador(a) '+lvs_Nome+' foi inativado(a) nos sistemas, devido a seu afastamento em '+String(lvdh_Afast, 'DD/MM/YYYY')+'.<br />~n'+ &
							  '<br /><b>Matr$$HEX1$$ed00$$ENDHEX$$cula:</b> ' + lvs_Matricula + &
							  '<br /><b>Nome:</b> ' + lvs_Nome + &   
							  '<br /><b>CPF:</b> ' + Mid(lvs_CPF, 1,3)+'.'+Mid(lvs_CPF, 4,3)+'.'+Mid(lvs_CPF, 7,3)+'-'+Mid(lvs_CPF, 10,2) + &   
							  '<br /><b>Cargo:</b> ' + lvs_Cargo + &  
							  '<br /><b>Filial:</b> ' + String(lvl_Filial)
		gf_ge202_envia_email_automatico(170, '', lvs_Msg_Email)				
	End If
	
	If lvs_Sit_Usu = 'I' Then
		Delete from usuario_sistema_filial
			Where nr_matricula = :lvs_Matricula
		 Using SqlCa;
		 
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(pi_Log, 'USU$$HEX1$$c100$$ENDHEX$$RIO INATIVO (' + lvs_Matricula + ') Exclus$$HEX1$$e300$$ENDHEX$$o usuario_sistema_filial')
			lvb_Commit = False
		End If
	End If

Next

Destroy(lvds_Rubi)

Return lvb_Commit
end function

public function boolean of_reativa_usuario (integer pi_log);Boolean lvb_Commit = True

Long	lvl_Rows
Long	lvl_Linha
Long	lvl_Find
Long lvl_Sit_Afa
	  
String lvs_Matricula
String lvs_Sit_Usu

Try
	dc_uo_ds_base lvds_Rubi
	lvds_Rubi = Create dc_uo_ds_base
		
	lvds_Rubi.of_SetTransObject(Rubi)
	If Not lvds_Rubi.of_ChangeDataObject('ds_ge651_colaborador_rh', False) Then
		SqlCa.of_LogdbError(pi_Log, 'REATIVA$$HEX2$$c700c300$$ENDHEX$$O USU$$HEX1$$c100$$ENDHEX$$RIO (' + lvs_Matricula + ') - ds_ge651_colaborador_rh.')
		Return False
	End If
	lvds_Rubi.of_appendwhere( ' sitafa not in (1, 7, 13, 51, 999)' )		
	lvds_Rubi.Retrieve()
	
	dc_uo_ds_base lvds_Afastados
	lvds_Afastados = Create dc_uo_ds_base
	If Not lvds_Afastados.of_ChangeDataObject('ds_ge651_colab_afastados',False) Then
		SqlCa.of_LogdbError(pi_Log, 'REATIVA$$HEX2$$c700c300$$ENDHEX$$O USU$$HEX1$$c100$$ENDHEX$$RIO (' + lvs_Matricula + ') - ds_ge651_colab_afastados.')
		Return False
	End If
	lvl_Rows = lvds_Afastados.Retrieve()
	
	For lvl_Linha = 1 To lvl_Rows
		lvs_Matricula	= lvds_Afastados.Object.nr_matricula	[lvl_Linha]
		
		lvl_Find = lvds_Rubi.Find("matricula='"+lvs_Matricula+"'", 1, lvds_Rubi.RowCount())
		
		If lvl_Find = 0 Then
			select sitafa
			Into :lvl_Sit_Afa
			From vdc_lista_colaboradores
			Where matricula = :lvs_Matricula
				And empresa = 1
				And tipcol = 1
			Using Rubi;
			
			If Rubi.SQLCode = -1 Then
				SqlCa.of_LogdbError(pi_Log, "REATIVA$$HEX2$$c700c300$$ENDHEX$$O USU$$HEX1$$c100$$ENDHEX$$RIO (" + lvs_Matricula + ") - Localiza$$HEX2$$e700e300$$ENDHEX$$o situa$$HEX2$$e700e300$$ENDHEX$$o usu$$HEX1$$e100$$ENDHEX$$rio no RH.")
				Continue
			End If
			
			lvs_Sit_Usu = This.Of_Trata_Situacao_Usuario( lvs_Matricula, lvl_Sit_Afa)
			
			UPDATE usuario
				SET id_situacao  = :lvs_Sit_Usu,
					  cd_filial_atualizacao = 534,
					  dh_atualizacao_filial = getdate()
			 WHERE nr_matricula = :lvs_Matricula
				AND id_situacao  <> :lvs_Sit_Usu
			 Using SqlCa;
			
			
			If SQLCa.SQLCode = -1 Then
				SqlCa.of_LogdbError(pi_Log, "REATIVA$$HEX2$$c700c300$$ENDHEX$$O USU$$HEX1$$c100$$ENDHEX$$RIO (" + lvs_Matricula + ") - Atualiza$$HEX2$$e700e300$$ENDHEX$$o usu$$HEX1$$e100$$ENDHEX$$rio sybase.")
				Continue
			Else
				SQLCa.Of_commit( )
			End If
		End If
	Next
	
Finally
	Destroy(lvds_Rubi)
	Destroy(lvds_Afastados)
End Try

Return lvb_Commit
end function

public function string of_trata_situacao_usuario (string ps_matricula, long ps_situacao_rh);String lvs_Sit_Usu, ls_id_pessoa_juridica


select
	Coalesce(id_pessoa_juridica, 'N')
into
	:ls_id_pessoa_juridica
from
	usuario
where
	nr_matricula = :ps_matricula
using
	SQLCA;

If ls_id_pessoa_juridica = 'S' Then
	//Se for pessoa juridica verifica se est$$HEX1$$e100$$ENDHEX$$ afastado ou n$$HEX1$$e300$$ENDHEX$$o.
	If of_verifica_usuario_isento_inativacao( ps_matricula ) Then
		lvs_Sit_Usu = "A"
	Else
		lvs_Sit_Usu = "F"
	End If
Else
	//Conforme email do Linhares em 11/04/2017
	Choose Case ps_situacao_rh
		Case 7  //DEMITIDO
			lvs_Sit_Usu = "I"
	
		Case 1, 13, 51, 999 //1=TRABALHANDO, 13=AVISO PR$$HEX1$$c900$$ENDHEX$$VIO; 51=TRABALHANDO NOTURNO; 999=MARCA$$HEX2$$c700c300$$ENDHEX$$O INV$$HEX1$$c100$$ENDHEX$$LIDA
			lvs_Sit_Usu = "A"
	
		Case Else
			//Alguns cargos por serem de confian$$HEX1$$e700$$ENDHEX$$a permitem o trabalho nas f$$HEX1$$e900$$ENDHEX$$rias.
			If of_verifica_usuario_isento_inativacao( ps_matricula ) Then
				lvs_Sit_Usu = "A"
			Else
				lvs_Sit_Usu = "F"
			End If
	End Choose
End If

Return lvs_Sit_Usu
end function

public function boolean of_verifica_usuario_isento_inativacao (string ps_matricula);String lvs_Afastamento

Select coalesce(id_afastamento,'S')
Into :lvs_Afastamento
From usuario
Where nr_matricula = :ps_matricula
Using SQLCa;

Return lvs_Afastamento = 'N'
end function

public function boolean of_insere_conveniado_central (integer pi_log, long al_convenio, string as_matricula, string as_nome, string as_senha, decimal adc_limite, string as_cpf, string as_sexo);String lvs_Nome, &
       lvs_Cpf
		 
//Verifica se o Usu$$HEX1$$e100$$ENDHEX$$rio j$$HEX1$$e100$$ENDHEX$$ Existe
Select nm_conveniado,
		 nr_cpf
  Into :lvs_Nome,
       :lvs_Cpf
  From conveniado
 Where cd_convenio   = :al_Convenio
   And cd_conveniado = :as_Matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100 //N$$HEX1$$e300$$ENDHEX$$o Encontrou
		INSERT INTO conveniado(cd_convenio,
							   cd_conveniado,
							   nm_conveniado,
							   id_somente_titular,
							   id_obedece_restricao,
							   cd_filial_atualizacao,
							   dh_atualizacao,
							   nr_matricula_atualizacao,
							   de_senha,
							   vl_limite,
							   nr_cpf, 
							   id_sexo )
		VALUES (:al_Convenio,
				:as_Matricula,
				:as_Nome,
				'N',
				'S',
				534,
				GETDATE(),
				'999999',
				:as_Senha,
				:adc_Limite,
				:as_cpf,
				:as_sexo)
		USING SQLCA;
	
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(pi_Log, "CONVENIADO (" + String(al_Convenio) + " - " + as_Matricula + ") Inclus$$HEX1$$e300$$ENDHEX$$o")
			Return False
		End If
		
	Case -1 
		SqlCa.of_LogdbError(pi_Log, "CONVENIADO (" + String(al_Convenio) + " - " + as_Matricula + ") Localiza$$HEX2$$e700e300$$ENDHEX$$o")
		Return False
	Case 0
		// Se existir, atualiza nome e cpf
		If lvs_Nome <> as_Nome Or lvs_Cpf <> as_cpf Or IsNull(lvs_Cpf) Then
		
			Update conveniado
				Set nm_conveniado = :as_Nome,
					 nr_cpf        = :as_cpf,
					 cd_filial_atualizacao = 534,
					 dh_atualizacao = getdate(),
					 nr_matricula_atualizacao = '999999'
			 Where cd_convenio   = :al_Convenio
			   	And cd_conveniado = :as_Matricula
				And coalesce(nr_cpf,'') <> coalesce(:as_cpf,'')
				And coalesce(nm_conveniado,'') <> coalesce(:as_Nome,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				SqlCa.of_LogdbError(pi_Log, "CONVENIADO (" + String(al_Convenio) + " - " + as_Matricula + ") Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
				Return False
			End If
			
		End If
		
End Choose

Return True
end function

public function boolean of_insere_usuario_filial (long pl_filial, string ps_matricula, string ps_cbo, string ps_cargo, integer pi_idade, integer pi_log, dc_uo_transacao ptr_base);If Not This.Of_insere_usuario_filial( pl_filial, 'RL', ps_matricula, ps_cbo, ps_cargo, pi_log, ptr_base) Then Return False

If Not This.Of_insere_usuario_filial( pl_filial, 'SL', ps_matricula, ps_cbo, ps_cargo, pi_log, ptr_base) Then Return False

If pi_Idade >= 18 Then // Chamado 289225
	If Not This.Of_insere_usuario_filial( pl_filial, 'CL', ps_matricula, ps_cbo, ps_cargo, pi_log, ptr_base) Then Return False
End If

Return True
end function

public function boolean of_insere_usuario_filial (long pl_filial, string ps_sistema, string ps_matricula, integer pi_perfil, integer pi_log, dc_uo_transacao ptr_base);If pi_Perfil = 8  Or ( ps_sistema = 'SL' AND pi_perfil = 1 )	Then // Gerente Trainee insere perfil para todas as filiais //Sistema PDV JAVA insere no perfil GERENTE
	UPDATE usuario_sistema_filial
	SET cd_perfil_usuario 	= :pi_Perfil
	WHERE nr_matricula 		= :ps_Matricula
		And cd_sistema 		= :ps_sistema
		AND coalesce(cd_perfil_usuario,0) <> :pi_Perfil
		AND nr_chamado is null
	 USING ptr_base;
	 
	If ptr_base.SqlCode = -1 Then
		ptr_base.of_LogdbError( pi_Log, " USU$$HEX1$$c100$$ENDHEX$$RIO SISTEMA FILIAL(" + String(pl_Filial)  + " - " + ps_Sistema + " - " + ps_Matricula + " - " + String(pi_Perfil) + ") Atualiza$$HEX2$$e700e300$$ENDHEX$$o" )						
		Return False
	End If

	INSERT
	INTO usuario_sistema_filial (	cd_filial,
											cd_sistema,
											nr_matricula,
											cd_perfil_usuario )
	SELECT	f.cd_filial,
				:ps_Sistema,
				:ps_Matricula,
				:pi_Perfil
	FROM		filial f
	WHERE	f.cd_filial NOT IN (1,2,534,1000)
		AND	f.id_situacao = 'A'
		AND	NOT EXISTS ( SELECT 1
									 FROM usuario_sistema_filial x
								   WHERE x.cd_filial				= f.cd_filial
									   AND x.cd_sistema			= :ps_Sistema
									   AND x.nr_matricula			= :ps_Matricula)
	USING ptr_base;
Else
	UPDATE usuario_sistema_filial
	SET cd_perfil_usuario = :pi_Perfil
	WHERE nr_matricula = :ps_Matricula
		And cd_sistema = :ps_sistema
		AND coalesce(cd_perfil_usuario,0) <> :pi_Perfil
		AND nr_chamado is null
	 USING ptr_base;
	 
	If ptr_base.SqlCode = -1 Then
		ptr_base.of_LogdbError( pi_Log, ' USU$$HEX1$$c100$$ENDHEX$$RIO SISTEMA FILIAL(' + String(pl_Filial)  + ' - ' + ps_Sistema + ' - ' + ps_Matricula + ' - ' + String(pi_Perfil) + ') Atualiza$$HEX2$$e700e300$$ENDHEX$$o' )						
		Return False
	End If
	
	INSERT
	INTO usuario_sistema_filial (	cd_filial,
											cd_sistema,
											nr_matricula,
											cd_perfil_usuario )
	SELECT	f.cd_filial,
				:ps_Sistema,
				:ps_Matricula,
				:pi_Perfil
	FROM		filial f
	WHERE	f.cd_filial NOT IN (1,2,1000)
		AND	f.id_situacao = 'A'
		AND 	f.cd_filial = :pl_filial
		AND	NOT EXISTS ( SELECT 1
									 FROM usuario_sistema_filial x
								   WHERE x.cd_filial				= f.cd_filial
									   AND x.cd_sistema			= :ps_Sistema
									   AND x.nr_matricula			= :ps_Matricula)
	USING ptr_base;
End If

If ptr_base.SqlCode = -1 Then
	ptr_base.of_LogdbError( pi_Log, ' USU$$HEX1$$c100$$ENDHEX$$RIO SISTEMA FILIAL(' + String(pl_Filial)  + ' - ' + ps_Sistema + ' - ' + ps_Matricula + ' - ' + String(pi_Perfil) + ') Inclus$$HEX1$$e300$$ENDHEX$$o' )						
	Return False
End If

Return True
end function

public function boolean of_insere_usuario_filial (long pl_filial, string ps_sistema, string ps_matricula, string ps_cbo, string ps_cargo, integer pi_log, dc_uo_transacao ptr_base);Boolean lvb_Disque_Entrega = False

Integer lvi_Perfil_Novo
Integer lvi_Perfil_Atual
Long lvl_Chamado

Long lvl_Achou

lvi_Perfil_Novo = of_Perfil_Usuario_Sistema( ps_CBO, ps_Cargo, pi_Log, pl_Filial, ps_sistema, ptr_base )

If lvi_Perfil_Novo > 0 Then	
	Select cd_filial, cd_perfil_usuario, coalesce(nr_chamado,0)
	Into :lvl_Achou, :lvi_Perfil_Atual, :lvl_Chamado
	From usuario_sistema_filial
	Where cd_filial				= :pl_Filial
		and cd_sistema			= :ps_sistema
		and nr_matricula		= :ps_Matricula
	Using ptr_base;
	
	Choose Case ptr_base.SqlCode
		Case 0
			If (lvi_Perfil_Novo <> lvi_Perfil_Atual) and (lvl_Chamado=0) Then
				If Not of_Insere_Usuario_Filial(pl_Filial, ps_sistema, ps_Matricula, lvi_Perfil_Novo, pi_Log, ptr_base) Then
					Return False
				End If
			End If
			
		Case 100
			If Not of_Insere_Usuario_Filial(pl_Filial, ps_sistema, ps_Matricula, lvi_Perfil_Novo, pi_Log, ptr_base) Then
				Return False
			End If
			
		Case -1 
				ptr_base.of_LogdbError(pi_Log, ' USU$$HEX1$$c100$$ENDHEX$$RIO SISTEMA FILIAL(' + String(pl_Filial)  + ' - ' + ps_sistema + ' - ' + ps_Matricula + ' - ' + String(lvi_Perfil_Novo) + ') Localiza$$HEX2$$e700e300$$ENDHEX$$o')						
				Return False
	End Choose
Else
	If Not This.of_Exclui_Usuario_Filial(ps_sistema, ps_Matricula, pi_Log, ptr_base) Then
		Return False
	End If
End If

Return True
end function

public function boolean of_exclui_usuario_filial (string ps_matricula, string ps_sistema, integer pi_log, dc_uo_transacao ptr_base);Delete from usuario_sistema_filial
Where cd_sistema			= :ps_sistema
	and nr_matricula		= :ps_Matricula
	and nr_chamado	is null
Using ptr_base;
	
If ptr_base.SqlCode = -1 Then
	ptr_base.of_LogdbError(pi_Log, ' USU$$HEX1$$c100$$ENDHEX$$RIO SISTEMA FILIAL(' + ps_sistema + ' - ' + ps_Matricula + ') Exclus$$HEX1$$e300$$ENDHEX$$o')						
	Return False
End If

Return True
end function

public function integer of_perfil_usuario_sistema (string ps_cbo, string ps_cargo, integer pi_log, long pl_filial, string ps_sistema, dc_uo_transacao ptr_base);Integer lvi_Perfil

Long lvl_Total

//Busca o perfil de destino na tabela
select cd_perfil_usuario
Into :lvi_Perfil
From perfil_sistema_cargo
Where cd_sistema = :ps_sistema
	And cd_cargo_rh = :ps_cargo
Using ptr_base;

Choose Case ptr_base.SQLCode
	Case -1 		// ERRO
		ptr_base.of_LogdbError(pi_Log, 'Localiza$$HEX2$$e700e300$$ENDHEX$$o perfil destino usu$$HEX1$$e100$$ENDHEX$$rio '+ptr_base.SQLErrText)
		Return 0
		
	Case 100		// SEM REGISTRO
		select count(1)
		Into :lvl_Total
		From perfil_sistema_cargo
		Where cd_sistema = :ps_sistema
		Using ptr_base;
		
		//Se tiver cargos com perfis definidos para esse sistema, mas n$$HEX1$$e300$$ENDHEX$$o encontrou perfil o retorno $$HEX1$$e900$$ENDHEX$$ 0
		If lvl_Total > 0 Then Return 0

	Case 0 		// SUCESSO
		Return lvi_Perfil
		
End Choose

Choose Case ps_CBO
	Case '142320' 
		lvi_Perfil = 1 // Gerente

		If Long( ps_Cargo ) = 757 Or Long( ps_Cargo ) = 773 Then
			lvi_Perfil = 8 // Gerente Trainee
		End If
		
	Case '223405', '520110'	
		lvi_Perfil = 2 // Farmac$$HEX1$$ea00$$ENDHEX$$utico / Respons$$HEX1$$e100$$ENDHEX$$vel

	Case '325110',	'354135', '354205', '410105', '411005', '411010', '412205', '414215', '515225', '516115', '521130', '521125', '521110'
		lvi_Perfil = 3 // Atendente
		
	Case '421125'
		lvi_Perfil = 4 // Caixa
		
		If ps_Sistema = 'RL' Then
			lvi_Perfil = 3
		End If
		
	Case Else 
		lvi_Perfil = 0
		
End Choose

//Sistema Seguran$$HEX1$$e700$$ENDHEX$$a de acesso
If ps_Sistema = 'SA' Then	
	If lvi_Perfil = 1 or lvi_Perfil = 2 Then		
		lvi_Perfil = 2
	Else 
		lvi_Perfil = 0
	End If
End If

Return lvi_Perfil
end function

public function boolean of_atualiza_vacinador (integer pi_log);Boolean lb_Open      = False

Long ll_Linha			, &
	   ll_Total			, &
  	   ll_Find
		
String ls_Matricula,&
		 ls_Vacinador
		 
dc_uo_ds_base lvds_Rubi		 
		 
Try
	If Not IsValid(w_Aguarde) Then
		lb_Open = True
		Open(w_Aguarde)
	End If
	
	w_Aguarde.Title = 'Atualizando cadastro de vacinador. Aguarde...'
	Yield( )
	
	lvds_Rubi = Create dc_uo_ds_base
		
	lvds_Rubi.of_SetTransObject(Rubi)
		
	If Not lvds_Rubi.of_ChangeDataObject('ds_ge651_lista_vacinadores') Then
		This.of_Grava_Log( 'Erro no of_ChangeDataObject ds_ge651_lista_vacinadores :: uo_ge651_rh_central.of_atualiza_vacinador', pi_Log)
		Return False	
	End If
	
	ll_Total = lvds_Rubi.Retrieve()
	
	If ll_Total < 0 Then
		This.of_Grava_Log( 'Erro no retrieve da ds_ge651_lista_vacinadores :: uo_ge651_rh_central.of_atualiza_vacinador', pi_Log)
		Return False
	End If
	
	If ll_Total > 0 Then
		w_Aguarde.uo_Progress.of_SetMax( ll_Total )
	End If
	
	For ll_Linha = 1 To ll_Total
		ls_Matricula				= String( lvds_Rubi.Object.nr_matricula		[ll_Linha] )
		ls_Vacinador			=  lvds_Rubi.Object.id_vacinador				[ll_Linha]
		
		w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
		w_Aguarde.Title = 'Atualizando vacinadores ' + ls_Matricula + '. Aguarde...'
		Yield( )
		
		 Update usuario
			 Set id_vacinador	= :ls_Vacinador
		Where nr_matricula = :ls_Matricula
			And (coalesce(id_vacinador, '') <> coalesce(:ls_Vacinador, ''))
		  Using SqlCa;
		  
		 If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(pi_Log, 'Matr$$HEX1$$ed00$$ENDHEX$$cula (' + ls_Matricula + ') Atualiza$$HEX2$$e700e300$$ENDHEX$$o do vacinador :: uo_ge651_rh_central.of_atualiza_vacinador( pi_log )')
			SqlCa.of_RollBack()
		 Else
			SqlCa.of_Commit()	
		 End If
	Next
Finally	
	Destroy(lvds_Rubi)
	
	If lb_Open Then Close(w_Aguarde)
End Try	

Return True
end function

public subroutine of_atualizacao_rh_central ();//RETURN // Para migra$$HEX2$$e700e300$$ENDHEX$$o do banco para Oracle
//String ls_Servidor
//
//SELECT COALESCE( vl_parametro, 'CIA-112' )
//INTO :ls_Servidor
//FROM parametro_geral
//WHERE cd_parametro = 'DE_SERVIDOR_TDC_EXPORTACAO_COMUM'
//USING SqlCa;
//
//Choose Case SqlCa.SqlCode
//	Case -1
//		of_mensagem_processo ('Erro ao buscar o par$$HEX1$$e200$$ENDHEX$$metro DE_SERVIDOR_TDC_EXPORTACAO_COMUM na tabela PARAMETRO_GERAL: ' + SQLCA.SQLErrText)
//		Return
//		
//	Case 100
//		of_mensagem_processo ('Servidor de exporta$$HEX2$$e700e300$$ENDHEX$$o de log comum n$$HEX1$$e300$$ENDHEX$$o configurado em parametro_geral.')
//		Return
//		
//	Case 0
//		If ls_Servidor <> gvo_Aplicacao.is_ComputerName Then
//			Return
//		End If
//End Choose

Boolean lvb_Commit = True

String lvs_Arquivo, &
		 lvs_Path
		 
Integer lvi_Arquivo_Log

lvs_Path = gvo_Aplicacao.of_GetFromINI('Diretorio', 'Diretorio')

Window Aguarde
Aguarde = Create w_Aguarde
Open(Aguarde)
Aguarde.Title = 'Atualizando dados conforme o banco do RH...'

lvs_Arquivo = lvs_Path + '/Atualiza$$HEX2$$e700e300$$ENDHEX$$o_RH_CENTRAL_' + String(today(), 'yymmdd') + '.log'

Integer lvi_Log

lvi_Log = of_Abre_Arquivo_Log(lvs_Arquivo)

If Not of_connecta_Rubi(lvi_Log) Then
	lvb_Commit = False
End If

If lvb_Commit Then
	Aguarde.Title = 'Atualizando gerentes da tabela filial_gerente...'
	of_Insere_Gerentes(lvi_Log)

	Aguarde.Title = 'Atualizando gerente da tabela filial...'
	of_Atualiza_Gerente(lvi_Log)

	Aguarde.Title = 'Atualizando usu$$HEX1$$e100$$ENDHEX$$rios ativos...'
	of_Insere_Usuario_Central(lvi_Log)
	
	Aguarde.Title = 'Atualizando reativa usu$$HEX1$$e100$$ENDHEX$$rios inativos...'
	of_Reativa_Usuario(lvi_Log)

	Aguarde.Title = 'Atualizando usu$$HEX1$$e100$$ENDHEX$$rios inativos...'
	of_Inativa_Usuario(lvi_Log)

	Aguarde.Title = 'Atualizando conveniados...'
	of_Insere_Conveniado_Central(lvi_Log)

	Aguarde.Title = 'Atualizando cadastro de farmac$$HEX1$$ea00$$ENDHEX$$uticos...'
	of_Atualiza_Farmaceuticos( lvi_Log )
	
	Aguarde.Title = 'Atualizando cadastro de vacinadores...'
	of_Atualiza_Vacinador( lvi_Log )

//	Aguarde.Title = 'Atualizando cadastro digitias...'
//	of_Atualiza_Bionitgen( )
End If

If lvb_Commit Then
	Commit Using SqlCa;
Else
	Rollback Using SqlCa;
End If

If lvb_Commit Then
	of_Disconnect_Rubi(lvi_Log)
End If

FileClose(lvi_Log)

of_Exclui_Log_Vazio(lvs_Arquivo)

Close(Aguarde)
end subroutine

public subroutine of_mensagem_processo (string as_erro_msg);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

String	ls_Msg

s_email	lst_Email					

// PROCEDIMENTOS

ls_Msg =	'<b>ATEN$$HEX2$$c700c300$$ENDHEX$$O!!!!!'             + '<br><br>' + &
			'<b>Atualiza$$HEX2$$e700e300$$ENDHEX$$o RH - CENTRAL' + '<br></b>' + &
			'<b>Sistema EXPORTACAO'       + '<br></b>' + &
			'<b>Mensagem: ' + as_erro_msg + '<br></b>'
			
lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

gf_ge202_envia_email_padrao (345, lst_Email)

Return
end subroutine

on uo_ge651_rh_central.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge651_rh_central.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_Encript 		= Create dc_uo_encript

end event

event destructor;Destroy(ivo_Encript)

end event

