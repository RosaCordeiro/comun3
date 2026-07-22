HA$PBExportHeader$dc_uo_dberror.sru
forward
global type dc_uo_dberror from nonvisualobject
end type
end forward

global type dc_uo_dberror from nonvisualobject
end type
global dc_uo_dberror dc_uo_dberror

type variables
Private String ivs_Erro_Saida_Padrao = 'MESSAGEBOX'

long ivl_sqldbcode

String is_SqlState

// Mant$$HEX1$$e900$$ENDHEX$$m o padr$$HEX1$$e300$$ENDHEX$$o ou altera para Log, pode ser implementado para email futuramente.

string ivs_sqlerrtext, &
         ivs_sqlsyntax, &
         ivs_database, &
         ivs_mensagem, &
         ivs_parametro

// Par$$HEX1$$e200$$ENDHEX$$metros para mensagens de erro
String ivs_parm_msg_erro[]
end variables

forward prototypes
public subroutine of_trata_erro ()
public function string of_msg_sybase ()
public function string of_msg_anywhere ()
public function string of_separa_mensagem (ref integer pi_posicao_inicial)
public function string of_tabela_primaria_anywhere (string ps_tabela_estrangeira, string ps_constraint)
public function string of_tabela_primaria_sybase (string ps_tabela_estrangeira, string ps_constraint)
public subroutine of_log_erro (integer pi_arquivo)
public function string of_msg_postgresql ()
public subroutine of_erro_saida (string ps_titulo, string ps_texto)
public subroutine of_set_erro_saida_padrao (string ps_valor)
public function string of_get_erro_saida_padrao ()
public function boolean of_grava_log (integer pi_arquivo, string ps_mensagem)
end prototypes

public subroutine of_trata_erro ();String lvs_Banco, &
       lvs_Mensagem

Integer lvi_Parametros

// Verifica de acordo com o banco da transa$$HEX2$$e700e300$$ENDHEX$$o, se o erro $$HEX1$$e900$$ENDHEX$$ tratado ou n$$HEX1$$e300$$ENDHEX$$o. Se sim, monta
// o c$$HEX1$$f300$$ENDHEX$$digo do erro. Se n$$HEX1$$e300$$ENDHEX$$o deixa ir a mensagem de erro que veio
lvs_Banco = Upper(This.ivs_DataBase)	

If IsNull(lvs_Banco) or lvs_Banco = "" Then
	lvs_Banco = Upper(SqlCa.ivs_DataBase)
End If

Choose Case lvs_Banco	
	Case "SYBASE"
		// Chama a fun$$HEX2$$e700e300$$ENDHEX$$o de tratamento de erro do Sybase
		lvs_Mensagem = of_Msg_Sybase()
		
		If Trim(lvs_Mensagem) <> "" Then
			//Alterado para n$$HEX1$$e300$$ENDHEX$$o exibir mensagem de erro quando estiver no modo autom$$HEX1$$e100$$ENDHEX$$tico
			//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, StopSign!)	
			This.of_Erro_Saida( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', lvs_Mensagem)
		End If		
		
	Case "ANYWHERE"	, "POSTGRESQL"
		// Chama a fun$$HEX2$$e700e300$$ENDHEX$$o de tratamento de erro do POSTGRESQL. A fun$$HEX2$$e700e300$$ENDHEX$$o of_erro_saida mostra mensagem quando a vari$$HEX1$$e100$$ENDHEX$$vel ivs_Erro_Saida_Padrao assim estiver definida
		lvs_Mensagem = of_Msg_PostgreSQL()
		
	Case Else
		lvs_Mensagem = "Banco de dados desconhecido '" + lvs_Banco + "'." + "~r~r" + This.ivs_Mensagem
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, StopSign!)	
End Choose
end subroutine

public function string of_msg_sybase ();String lvs_Mensagem, &
       lvs_Tabela, &
		 lvs_Coluna, &
		 lvs_Constraint, &
		 lvs_dbName, &
		 lvs_Indice, &
		 lvs_Tabela_Estrangeira, &
		 lvs_Tabela_Primaria

Integer lvi_Posicao_Inicial = 1, &
        lvi_Posicao_Final

// Verifica o erro retornado e efetua o tratamento
Choose Case This.ivl_SqldbCode
		
	Case 2601 // Erro de Chave Prim$$HEX1$$e100$$ENDHEX$$ria Duplicada
		
		lvs_Tabela = of_Separa_Mensagem(lvi_Posicao_Inicial)		
		
		lvs_Mensagem = "Registro j$$HEX1$$e100$$ENDHEX$$ existe na tabela " + lvs_Tabela + "."
		
	Case 546 // Inclus$$HEX1$$e300$$ENDHEX$$o de linhas sem as PK$$HEX1$$b400$$ENDHEX$$s referenciadas previamente cadastradas

		lvs_dbName             = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_Tabela_Estrangeira = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_Constraint         = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_Tabela_Primaria    = of_Tabela_Primaria_Sybase(lvs_Tabela, lvs_Constraint)

		lvs_Mensagem = "N$$HEX1$$e300$$ENDHEX$$o existe chave prim$$HEX1$$e100$$ENDHEX$$ria na tabela " + lvs_Tabela_Primaria + &
		               ", para satisfazer a restri$$HEX2$$e700e300$$ENDHEX$$o de integridade " + lvs_Constraint + &
							" da tabela " + lvs_Tabela_Estrangeira + "."
		
	Case 233 // Inclus$$HEX1$$e300$$ENDHEX$$o de valores nulos em colunas NOT NULL
		
		lvs_Mensagem = This.ivs_Mensagem
		
		lvi_Posicao_Inicial = PosA(lvs_Mensagem, "The column ") + 11
		lvi_Posicao_Final   = PosA(lvs_Mensagem, " in table ")
		
		lvs_Coluna = Upper(MidA(lvs_Mensagem, lvi_Posicao_Inicial, lvi_Posicao_Final - lvi_Posicao_Inicial))
		
		lvi_Posicao_Inicial = lvi_Posicao_Final + 10
		lvi_Posicao_Final   = PosA(lvs_Mensagem, " does not ")
				
		lvs_Tabela = Upper(MidA(lvs_Mensagem, lvi_Posicao_Inicial, lvi_Posicao_Final - lvi_Posicao_Inicial))
		
		lvs_Mensagem = "Coluna " + lvs_Coluna + " da tabela " + lvs_Tabela + " n$$HEX1$$e300$$ENDHEX$$o pode ser nula."
		
	Case 2615 // Inclus$$HEX1$$e300$$ENDHEX$$o/altera$$HEX2$$e700e300$$ENDHEX$$o em uma coluna com valores j$$HEX1$$e100$$ENDHEX$$ cadastrados
		       // que faz parte de um $$HEX1$$ed00$$ENDHEX$$ndice UNIQUE

		lvs_Tabela = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_Indice = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_dbName = of_Separa_Mensagem(lvi_Posicao_Inicial)

		lvs_Mensagem = "$$HEX1$$cd00$$ENDHEX$$ndice " + lvs_Indice + " da tabela " + lvs_Tabela + " deve ser $$HEX1$$fa00$$ENDHEX$$nico."

	Case 547  // Altera$$HEX2$$e700e300$$ENDHEX$$o/exclus$$HEX1$$e300$$ENDHEX$$o de PK com refer$$HEX1$$ea00$$ENDHEX$$ncias
		       // para outras tabelas
		
		lvs_dbName     = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_Tabela     = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_Constraint = of_Separa_Mensagem(lvi_Posicao_Inicial)

		lvs_Mensagem = "A chave prim$$HEX1$$e100$$ENDHEX$$ria da tabela " + lvs_Tabela + &
		               " $$HEX1$$e900$$ENDHEX$$ referenciada por outra(s) tabela(s) atrav$$HEX1$$e900$$ENDHEX$$s da restri$$HEX2$$e700e300$$ENDHEX$$o" + &
							" de integridade " + lvs_Constraint + "."
		
	Case 3607 // Divis$$HEX1$$e300$$ENDHEX$$o por ZERO (232 overflow)
		
		lvs_Mensagem = "Divis$$HEX1$$e300$$ENDHEX$$o por zero."
		
	Case Else
		
		lvs_Mensagem = This.ivs_Mensagem
		
End Choose

If lvs_Mensagem <> This.ivs_Mensagem Then
	If Trim(This.ivs_Parametro) <> "" Then
		lvs_Mensagem = lvs_Mensagem + "~r~rPar$$HEX1$$e200$$ENDHEX$$metro: " + This.ivs_Parametro
	End If
End If

Return lvs_Mensagem
end function

public function string of_msg_anywhere ();String lvs_Mensagem, &
       lvs_Tabela, &
		 lvs_Coluna, &
		 lvs_Constraint, &
		 lvs_Indice, &
		 lvs_Tabela_Primaria, &
		 lvs_Tabela_Estrangeira

Integer lvi_Posicao_Inicial = 1

// Verifica o erro retornado e efetua o tratamento

Choose Case This.ivl_SqldbCode
		
	Case -193 // Erro de Chave Prim$$HEX1$$e100$$ENDHEX$$ria Duplicada
		
		lvs_Tabela = of_Separa_Mensagem(lvi_Posicao_Inicial)	

		lvs_Mensagem = "Registro j$$HEX1$$e100$$ENDHEX$$ existe na tabela " + lvs_Tabela + "."
		
	Case -194 // Inclus$$HEX1$$e300$$ENDHEX$$o de linhas sem as PK$$HEX1$$b400$$ENDHEX$$s referenciadas
		       // previamente cadastradas

		lvs_Constraint         = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_Tabela_Estrangeira = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_Tabela_Primaria    = of_Tabela_Primaria_Anywhere(lvs_Tabela_Estrangeira, lvs_Constraint)

		lvs_Mensagem = "N$$HEX1$$e300$$ENDHEX$$o existe chave prim$$HEX1$$e100$$ENDHEX$$ria na tabela " + lvs_Tabela_Primaria + &
		               ", para satisfazer a restri$$HEX2$$e700e300$$ENDHEX$$o de integridade " + lvs_Constraint + &
							" da tabela " + lvs_Tabela_Estrangeira + "."
		
	Case -195 // Inclus$$HEX1$$e300$$ENDHEX$$o de valores nulos em colunas NOT NULL
		
		lvs_Coluna = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_Tabela = of_Separa_Mensagem(lvi_Posicao_Inicial)

		lvs_Mensagem = "Coluna " + lvs_Coluna + " da tabela " + lvs_Tabela + " n$$HEX1$$e300$$ENDHEX$$o pode ser nula."
		
	Case -196 // Inclus$$HEX1$$e300$$ENDHEX$$o/altera$$HEX2$$e700e300$$ENDHEX$$o em uma coluna com valores j$$HEX1$$e100$$ENDHEX$$ cadastrados
		       // que faz parte de um $$HEX1$$ed00$$ENDHEX$$ndice UNIQUE

		lvs_Indice = of_Separa_Mensagem(lvi_Posicao_Inicial)
		lvs_Tabela = of_Separa_Mensagem(lvi_Posicao_Inicial)

		lvs_Mensagem = "$$HEX1$$cd00$$ENDHEX$$ndice " + lvs_Indice + " da tabela " + lvs_Tabela + " deve ser $$HEX1$$fa00$$ENDHEX$$nico."

	Case -198 // Altera$$HEX2$$e700e300$$ENDHEX$$o/exclus$$HEX1$$e300$$ENDHEX$$o de PK com refer$$HEX1$$ea00$$ENDHEX$$ncias
		       // para outras tabelas
		
		lvs_Tabela = of_Separa_Mensagem(lvi_Posicao_Inicial)

		lvs_Mensagem = "A chave prim$$HEX1$$e100$$ENDHEX$$ria da tabela " + lvs_Tabela + " $$HEX1$$e900$$ENDHEX$$ referenciada por outra(s) tabela(s)."
		
	Case -628, 1003 // Divis$$HEX1$$e300$$ENDHEX$$o por ZERO
		
		lvs_Mensagem = "Divis$$HEX1$$e300$$ENDHEX$$o por zero."
		
	Case Else
		
		lvs_Mensagem = This.ivs_Mensagem
		
End Choose

If lvs_Mensagem <> This.ivs_Mensagem Then
	If Trim(This.ivs_Parametro) <> "" Then
		lvs_Mensagem = lvs_Mensagem + "~r~rPar$$HEX1$$e200$$ENDHEX$$metro: " + This.ivs_Parametro
	End If
End If

Return lvs_Mensagem
end function

public function string of_separa_mensagem (ref integer pi_posicao_inicial);Integer lvi_Pos1, &
        lvi_Pos2

String lvs_Mensagem, &
       lvs_Retorno

lvs_Mensagem = This.ivs_Mensagem

lvi_Pos1 = PosA(lvs_Mensagem, "'", pi_Posicao_Inicial)
lvi_Pos2 = PosA(lvs_Mensagem, "'", lvi_Pos1 + 1)

lvs_Retorno = MidA(lvs_Mensagem, lvi_Pos1 + 1, lvi_Pos2 - lvi_Pos1 - 1)
						 
pi_Posicao_Inicial = lvi_Pos2 + 1

Return Upper(lvs_Retorno)
end function

public function string of_tabela_primaria_anywhere (string ps_tabela_estrangeira, string ps_constraint);String lvs_Tabela_Primaria

Select Primary_TName Into :lvs_Tabela_Primaria
From SYS.SysForeignKeys
Where Foreign_TName = :ps_tabela_estrangeira
  and Role          = :ps_constraint;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da tabela prim$$HEX1$$e100$$ENDHEX$$ria.", StopSign!)
	Return ""
End If

Return Upper(lvs_Tabela_Primaria)
end function

public function string of_tabela_primaria_sybase (string ps_tabela_estrangeira, string ps_constraint);//String lvs_Tabela_Primaria
//
//Select Primary_TName Into :lvs_Tabela_Primaria
//From SYS.SysForeignKeys
//Where Foreign_TName = :ps_tabela_estrangeira
//  and Role          = :ps_constraint;
//
//If SqlCa.SqlCode = -1 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da tabela prim$$HEX1$$e100$$ENDHEX$$ria.",StopSign!,Ok!)
//	Return ""
//End If
//
//Return lvs_Tabela_Primaria

Return Upper("tabela prim$$HEX1$$e100$$ENDHEX$$ria")
end function

public subroutine of_log_erro (integer pi_arquivo);String lvs_Banco, &
       lvs_Mensagem, &
		 lvs_Log

Integer lvi_Parametros

// Verifica de acordo com o banco da transa$$HEX2$$e700e300$$ENDHEX$$o, se o erro $$HEX1$$e900$$ENDHEX$$ tratado ou n$$HEX1$$e300$$ENDHEX$$o. Se sim, monta
// o c$$HEX1$$f300$$ENDHEX$$digo do erro. Se n$$HEX1$$e300$$ENDHEX$$o deixa ir a mensagem de erro que veio
lvs_Banco = Upper(This.ivs_DataBase)	

Choose Case lvs_Banco	
	Case "SYBASE"
		// Chama a fun$$HEX2$$e700e300$$ENDHEX$$o de tratamento de erro do Sybase
		lvs_Mensagem = of_Msg_Sybase()
		
	Case "ANYWHERE"	, "POSTGRESQL"
		// Chama a fun$$HEX2$$e700e300$$ENDHEX$$o de tratamento de erro do anywhere
		lvs_Mensagem = of_Msg_PostgreSQL()

	Case Else
		lvs_Mensagem = "Banco de dados desconhecido '" + lvs_Banco + "'." + "~r~r" + This.ivs_Mensagem
End Choose

lvs_Log = This.ivs_Parametro

If Trim(lvs_Mensagem) <> "" Then	lvs_Log += CharA(13) + CharA(10) + lvs_Mensagem

of_Grava_Log(pi_Arquivo, lvs_Log)		
		

end subroutine

public function string of_msg_postgresql ();String	lvs_Mensagem, &
			lvs_Tabela, &
			lvs_Coluna, &
			lvs_Constraint, &
			lvs_Indice, &
			lvs_Tabela_Primaria, &
			lvs_Tabela_Estrangeira

Integer lvi_Posicao_Inicial = 1

Try
	// Tratamento do sqlstate vide tabela dispov$$HEX1$$ed00$$ENDHEX$$vel em https://www.postgresql.org/docs/current/static/errcodes-appendix.htmle
	This.is_SqlState = MidA( This.ivs_SqlErrText, PosA( Lower( This.ivs_SqlErrText ), 'sqlstate = ' ) + 11 , 5 )
Catch( Exception ex )
	This.of_Erro_Saida( "Exception", ex.getMessage( ) + '~rdc_uo_dberror.of_msg_postgresql( )' )
	SetNull( This.is_SqlState )
End Try

If PosA( Lower( This.ivs_SqlErrText ), 'connection dead' ) > 0 Then
	This.of_Erro_Saida( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados foi encerrada.~r~rReabra o sistema para continuar utilizando.' )
	Halt Close
	Return 'A conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados foi encerrada.~r~rReabra o sistema para continuar utilizando.'
End If

This.ivs_SqlErrText = gf_Replace( This.ivs_SqlErrText, "Error while executing the query", "", 0 )

lvs_Mensagem = ""

Choose Case This.is_SqlState
	Case '08S01' // Perda de conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados | ESTE C$$HEX1$$d300$$ENDHEX$$DIGO N$$HEX1$$c300$$ENDHEX$$O EST$$HEX1$$c100$$ENDHEX$$ PREVISTO NA TABELA DE ERROS DO POSTGRESQL
		lvs_Mensagem += "A conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados foi encerrada.~r~rReabra o sistema para continuar utilizando.~r~n~r~n" + This.ivs_SqlErrText
		
	Case '22001' // string_data_right_truncation
		lvs_Mensagem += "Valor maior que o permitido para o campo do banco de dados.~r~n~r~n" + This.ivs_SqlErrText
		
	Case '23502' // Viola$$HEX2$$e700e300$$ENDHEX$$o de campo not null
		lvs_Mensagem += "Viola$$HEX2$$e700e300$$ENDHEX$$o de campo not null.~r~n~r~n" + This.ivs_SqlErrText

	Case '23503' // Viola$$HEX2$$e700e300$$ENDHEX$$o de integridade
		lvs_Mensagem += "Viola$$HEX2$$e700e300$$ENDHEX$$o de integridade.~r~n~r~n" + This.ivs_SqlErrText

	Case '23505' // Erro de Chave Prim$$HEX1$$e100$$ENDHEX$$ria Duplicada
		lvs_Mensagem += "Registro j$$HEX1$$e100$$ENDHEX$$ existe na tabela.~r~n~r~n" + This.ivs_SqlErrText
		
	Case '26000' // Invalid SQL Statement Name
		lvs_Mensagem += "Objeto referenciado no SQL n$$HEX1$$e300$$ENDHEX$$o existe.~r~n~r~n" + This.ivs_SqlErrText
		
	Case '42703' // Coluna referenciada no SQL n$$HEX1$$e300$$ENDHEX$$o existe
		lvs_Mensagem += "Coluna referenciada no SQL n$$HEX1$$e300$$ENDHEX$$o existe.~r~n~r~n" + This.ivs_SqlErrText
		
	Case '42P01' // Tabela referenciada no SQL n$$HEX1$$e300$$ENDHEX$$o existe
		lvs_Mensagem += "Tabela referenciada no SQL n$$HEX1$$e300$$ENDHEX$$o existe.~r~n~r~n" + This.ivs_SqlErrText
		
	Case Else
		lvs_Mensagem = This.ivs_Mensagem
		
		// Verifica o erro retornado e efetua o tratamento
		Choose Case This.ivl_SqldbCode
				
			Case -194 // Inclus$$HEX1$$e300$$ENDHEX$$o de linhas sem as PK$$HEX1$$b400$$ENDHEX$$s referenciadas
						 // previamente cadastradas
		
				lvs_Constraint         = of_Separa_Mensagem(lvi_Posicao_Inicial)
				lvs_Tabela_Estrangeira = of_Separa_Mensagem(lvi_Posicao_Inicial)
				lvs_Tabela_Primaria    = of_Tabela_Primaria_Anywhere(lvs_Tabela_Estrangeira, lvs_Constraint)
		
				lvs_Mensagem = "N$$HEX1$$e300$$ENDHEX$$o existe chave prim$$HEX1$$e100$$ENDHEX$$ria na tabela " + lvs_Tabela_Primaria + &
									", para satisfazer a restri$$HEX2$$e700e300$$ENDHEX$$o de integridade " + lvs_Constraint + &
									" da tabela " + lvs_Tabela_Estrangeira + "."
				
			Case -195 // Inclus$$HEX1$$e300$$ENDHEX$$o de valores nulos em colunas NOT NULL
				
				lvs_Coluna = of_Separa_Mensagem(lvi_Posicao_Inicial)
				lvs_Tabela = of_Separa_Mensagem(lvi_Posicao_Inicial)
		
				lvs_Mensagem = "Coluna " + lvs_Coluna + " da tabela " + lvs_Tabela + " n$$HEX1$$e300$$ENDHEX$$o pode ser nula."
				
			Case -196 // Inclus$$HEX1$$e300$$ENDHEX$$o/altera$$HEX2$$e700e300$$ENDHEX$$o em uma coluna com valores j$$HEX1$$e100$$ENDHEX$$ cadastrados
						 // que faz parte de um $$HEX1$$ed00$$ENDHEX$$ndice UNIQUE
		
				lvs_Indice = of_Separa_Mensagem(lvi_Posicao_Inicial)
				lvs_Tabela = of_Separa_Mensagem(lvi_Posicao_Inicial)
		
				lvs_Mensagem = "$$HEX1$$cd00$$ENDHEX$$ndice " + lvs_Indice + " da tabela " + lvs_Tabela + " deve ser $$HEX1$$fa00$$ENDHEX$$nico."
		
			Case -198 // Altera$$HEX2$$e700e300$$ENDHEX$$o/exclus$$HEX1$$e300$$ENDHEX$$o de PK com refer$$HEX1$$ea00$$ENDHEX$$ncias
						 // para outras tabelas
				
				lvs_Tabela = of_Separa_Mensagem(lvi_Posicao_Inicial)
		
				lvs_Mensagem = "A chave prim$$HEX1$$e100$$ENDHEX$$ria da tabela " + lvs_Tabela + " $$HEX1$$e900$$ENDHEX$$ referenciada por outra(s) tabela(s)."
				
			Case -628, 1003 // Divis$$HEX1$$e300$$ENDHEX$$o por ZERO
				
				lvs_Mensagem = "Divis$$HEX1$$e300$$ENDHEX$$o por zero."
				
			Case Else
				
				lvs_Mensagem = This.ivs_Mensagem
				
		End Choose
End Choose

If lvs_Mensagem <> This.ivs_Mensagem Then
	If Trim(This.ivs_Parametro) <> "" Then
		lvs_Mensagem = lvs_Mensagem + "~r~rPar$$HEX1$$e200$$ENDHEX$$metro: " + This.ivs_Parametro
	End If
End If

This.of_Erro_Saida( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', lvs_Mensagem )

Return lvs_Mensagem
end function

public subroutine of_erro_saida (string ps_titulo, string ps_texto);If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'TL' or gvb_Auto Then This.of_SEt_erro_saida_padrao( 'LOG' )

Choose Case Upper( This.ivs_Erro_Saida_Padrao )
	Case 'MESSAGEBOX'
		If Trim( ps_Texto ) <> "" Then
			MessageBox( ps_Titulo, ps_Texto, StopSign! )
		End If
		
	Case 'LOG'
		If Trim( ps_Texto ) <> "" Then
			This.of_Grava_Log( gvo_Aplicacao.ivi_Log, This.ivs_Parametro + CharA(13) + CharA(10) + 'Titulo: ' + ps_Titulo + ' :: Mensagem: ' + ps_Texto )
		End If
		
End Choose
end subroutine

public subroutine of_set_erro_saida_padrao (string ps_valor);ps_Valor = Upper( ps_Valor )

Choose Case ps_Valor
	Case 'MESSAGEBOX'
		// OK
		
	Case 'LOG'
		// OK
		
	Case Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sa$$HEX1$$ed00$$ENDHEX$$da de erro '" + ps_Valor + "' n$$HEX1$$e300$$ENDHEX$$o previsto em dc_uo_dberror.of_set_erro_saida_padrao( string )", StopSign! )
		ps_Valor = 'MESSAGEBOX'
		
End Choose

This.ivs_Erro_Saida_Padrao = ps_Valor
end subroutine

public function string of_get_erro_saida_padrao ();String lvs_Retorno

//Caso esteja vazio seta padr$$HEX1$$e300$$ENDHEX$$o
If IsNull(This.ivs_Erro_Saida_Padrao) or This.ivs_Erro_Saida_Padrao = "" Then This.ivs_Erro_Saida_Padrao = IIF(gvb_Auto, "LOG", "MESSAGEBOX")

//Retorna tipo de erro
If gvb_Auto Then
	lvs_Retorno = "LOG"
Else
	lvs_Retorno = This.ivs_Erro_Saida_Padrao
End If

Return lvs_Retorno
end function

public function boolean of_grava_log (integer pi_arquivo, string ps_mensagem);ps_mensagem = gf_Replace(ps_mensagem, "~r~n", " | ", 0)
ps_mensagem = gf_Replace(ps_mensagem, "~n", " | ", 0)
ps_mensagem = gf_Replace(ps_mensagem, "~r", " | ", 0)

return gf_grava_log_basico(pi_arquivo, ps_mensagem)
end function

on dc_uo_dberror.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_dberror.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

