HA$PBExportHeader$uo_transacao_remota.sru
forward
global type uo_transacao_remota from nonvisualobject
end type
end forward

global type uo_transacao_remota from nonvisualobject
end type
global uo_transacao_remota uo_transacao_remota

type variables
// Script que o distribu$$HEX1$$ed00$$ENDHEX$$do deve executar
//CONSTANT STRING SCRIPT_CONSULTA  = "sybase/consulta.gambi.cgi"
CONSTANT STRING SCRIPT_CONSULTA  = "sybase/consulta.cgi"
CONSTANT STRING SCRIPT_RELATORIO = "sybase/relatorio.cgi"

//N$$HEX1$$fa00$$ENDHEX$$mero m$$HEX1$$e100$$ENDHEX$$ximo de linhas que o distribuido retorna, conforme o script executado
CONSTANT LONG MAX_LINHAS_SCRIPT_CONSULTA	= 400
CONSTANT LONG MAX_LINHAS_SCRIPT_RELATORIO	= 1000

PROTECTED:
Boolean ib_BancoProducao = False
Boolean ib_Debug = False
Boolean ib_Erro = False
Boolean ib_ErroConexao = False
Boolean ib_ConverteVirgula=False
Boolean ib_DefVariaveis=False
Boolean ib_ExecutaPing=True

String is_servidor = '10.0.0.27'
String is_url = SCRIPT_CONSULTA

String is_SQLErro
String is_Rotina

Long il_Linhas
Long il_Rows


PUBLIC:

Boolean ib_MostraRetorno = False
inet intranet
uo_internetresult result
Long il_Filial
String is_Erro

//Usado para comparar os arquivos do Troca dados Loja --> Troca dados Central
Boolean ib_Compara_Md5_TDC = False
String is_FTP_TROCA_DADOS

// Colocado esta informa$$HEX2$$e700e300$$ENDHEX$$o na gf_servidor_intranet
///String is_servidor_intranet = 'intranet.clamed.com.br'
//String is_servidor_intranet_des = 'intranet-homologa.clamed.com.br'

String is_servidor_intranet
String is_servidor_intranet_des
String is_diretorio_script_intranet = '_distribuido'
String is_Retorno

end variables

forward prototypes
public subroutine of_bancoproducao ()
public subroutine of_debug (boolean pb_flag)
public function boolean of_executa_rotina (string as_funcao, string as_args[])
public function boolean of_processa_retorno_transacao ()
public function string of_captura_valor_flag (string ps_flag)
public subroutine of_msgerror (string ps_consulta)
public function boolean of_retorno (string ps_coluna, ref string ps_retorno)
public function boolean of_retorno (string ps_coluna, ref long pl_retorno)
public function boolean of_retorno (string ps_coluna, ref decimal pdc_retorno)
public function datetime of_data_parametro_central ()
public function boolean of_retorno (string ps_coluna, ref datetime pdh_datetime)
public function boolean of_retorno (ref datastore pds_datastore)
public function boolean of_desconto_cartao_unimed (string as_cartao, ref decimal adc_desconto)
public function boolean of_insert_registro (string as_tabela, string as_colunas, string as_values, ref long al_regitros)
public function boolean of_delete_registro (string as_tabela, string as_where, ref long al_regitros)
public function boolean of_update_registro (string as_tabela, string as_set, string as_where, ref long al_regitros)
public function boolean of_retrieve (ref datastore pds_datastore)
public function boolean of_retorno_dados (ref string ps_dados)
public function boolean of_retrieve (string ps_sql, ref string ps_dados)
public function boolean of_erro_execucao ()
public function boolean of_erro_conexao ()
public function long of_linhas ()
public function long of_rows ()
public function boolean of_retorno (string ps_coluna, ref boolean pb_retorno)
public subroutine of_convertevirgula (boolean pb_flag)
public subroutine of_define_variaveis (boolean pb_flag)
public subroutine of_relatorio (boolean ab_relatorio)
public function boolean of_consulta_cheque (string ps_cpf)
public function boolean of_envia_email_cliente_clube (string ps_nm_cliente, string ps_de_email)
public function boolean of_executa_rotina_intranet (string ps_script, string ps_argumentos)
public function boolean of_executa_rotina_intranet (string ps_script, string ps_argumentos, boolean pb_base_producao)
public function boolean of_update_registro (string as_tabela, string as_set, string as_where, ref long al_regitros, ref string as_mensagem)
public function boolean of_executa_rotina_generica (string ps_script, string ps_argumentos)
public function boolean of_ping ()
public function string of_retorno_dados_intranet ()
public subroutine of_executa_ping (boolean pb_executa)
public function boolean of_retorno (string ps_coluna, ref integer pdi_retorno)
public function boolean of_verifica_unimed_clamed (string as_cartao)
public function boolean of_verifica_cartao_saude (string as_convenios, string as_cartao, string as_tipo_cartao, ref long al_convenio)
end prototypes

public subroutine of_bancoproducao ();This.ib_BancoProducao = True
end subroutine

public subroutine of_debug (boolean pb_flag);ib_Debug = pb_flag
end subroutine

public function boolean of_executa_rotina (string as_funcao, string as_args[]);String 	ls_url
String		ls_argumentos
String 	ls_producao
String 	ls_headers
String 	ls_DefVariaveis
String 	ls_ConverteVirgula
String 	ls_Parametro
String		ls_Erro
String		ls_ComputerName

Long		ll_length
Long		ll_sucesso
Long 		ll_Arg

Blob 		lb_args


If Not This.of_Ping( ) Then
	This.ib_ErroConexao = True
	This.is_Erro = "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do [" + This.is_Servidor + "]."
	Return False
End If

This.is_Rotina = String(Long(as_funcao),'0000')

If This.ib_BancoProducao Then
	ls_Producao = '1'
Else
	ls_Producao = '0'
End If

//Parametro para realiza$$HEX2$$e700e300$$ENDHEX$$o de teste no desenvolvimento - parametro_loja: ID_BASE_PRODUCAO (S,N)
Select vl_parametro
 Into :ls_Parametro
from parametro_loja
Where cd_parametro = 'ID_BASE_PRODUCAO'
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	If Trim(ls_Parametro) = "S"  Then
		ls_Producao = '1'
	Else
		ls_Producao = '0'
	End If
End If

If This.ib_DefVariaveis Then
	ls_DefVariaveis = '1'
	ls_ConverteVirgula = '1'
Else
	
	ls_DefVariaveis = '0'
	
	If ib_ConverteVirgula Then
		ls_ConverteVirgula = '1'
	Else	
		ls_ConverteVirgula = '0'
	End If	
	
End If

ls_ComputerName = gvo_Aplicacao.is_ComputerName

If IsNull( ls_ComputerName ) Then ls_ComputerName = ""

ls_url = "http://" + This.is_Servidor + "/" + This.is_Url

ls_argumentos = "&filial=" + String(This.il_Filial) + "&host=" + ls_ComputerName + "&flag=" + ls_Producao + "&funcao=" + This.is_Rotina + "&defVariaveis=" + ls_DefVariaveis + "&ConverteVirgula=" + ls_ConverteVirgula

For ll_Arg = 1 To UpperBound(as_Args[])
	
	ls_argumentos += '&VAR' + String(ll_Arg) + '=' + as_Args[ll_Arg]
	
Next	

This.ib_Erro 	= False
This.is_Erro 	= ''
This.il_Linhas	= 0

If IsNull( ls_argumentos ) Then
	This.ib_ErroConexao = True
	This.is_Erro = "Par$$HEX1$$e200$$ENDHEX$$metro recebido com valor NULL~rGE105 - uo_transacao_remota.of_Executa_Rotina()"
	Return False
End If

lb_args 		= blob(ls_argumentos, EncodingAnsi!)

ll_length 	= Len(lb_args)

This.ib_ErroConexao = False

ll_Sucesso = intranet.PostURL(ls_url,lb_args,ls_headers,This.Result)

ls_headers = ''

If This.ib_MostraRetorno Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Retorno da transa$$HEX2$$e700e300$$ENDHEX$$o: ' + This.Result.is_data)
End If

Choose Case ll_Sucesso
	Case 1 // Sucesso
		Return This.of_Processa_Retorno_Transacao()
		
	Case -2
		ls_Erro = "URL Inv$$HEX1$$e100$$ENDHEX$$lida"
		
	Case -4
		ls_Erro = "Sem conex$$HEX1$$e300$$ENDHEX$$o com a Internet"
		
	Case -5
		ls_Erro = "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ suporte para conex$$HEX1$$e300$$ENDHEX$$o segura (HTTPS )"
		
	Case -6
		ls_Erro = "Requisi$$HEX2$$e700e300$$ENDHEX$$o falhou"
		
	Case Else
		ls_Erro = "General error"
		
End Choose

This.ib_Erro				= True
This.ib_ErroConexao	= True
This.is_Erro = 'Erro ao se conectar ao servidor (' + String(ll_Sucesso) + ' - ' + ls_Erro + ')'
Return False
end function

public function boolean of_processa_retorno_transacao ();
String ls_Dados
String ls_Enter

Long ll_Pos
Long ll_Max

ls_Dados = This.Result.is_data

If Mid(ls_Dados,1,5) = 'ERRO:' Then
	This.ib_Erro 	 = True
	This.is_Erro 	 = This.of_Captura_Valor_Flag('msg')
	This.is_SQLErro = This.of_Captura_Valor_Flag('sql')
Else	
	
	If Not Mid(ls_Dados,1,6) = '000000' Then
		ll_Pos = Pos(ls_Dados, '000000')	
		
		This.il_Linhas = Long(Mid(ls_Dados,ll_Pos+8,06))
		This.il_Rows   = Long(Mid(ls_Dados,ll_Pos+14,07))
		
		This.ib_Erro = True
		
		//N$$HEX1$$fa00$$ENDHEX$$mero m$$HEX1$$e100$$ENDHEX$$ximo de linhas que o distribuido retorna, conforme o script executado
		If is_url = SCRIPT_CONSULTA Then
			ll_Max = MAX_LINHAS_SCRIPT_CONSULTA
		Else
			ll_Max = MAX_LINHAS_SCRIPT_RELATORIO
		End If
		
		If This.il_Linhas = ll_Max And This.il_Rows = -1 Then
			This.is_Erro = "Muitos registros retornados, por favor, informe mais dados para a busca."
		Else
			This.is_Erro = 'Erro no layout do retorno'
		End If
	Else
		This.il_Linhas = Long(Mid(ls_Dados,08,06))
		This.il_Rows   = Long(Mid(ls_Dados,15,06))
	End If
	
End If	

Return True
end function

public function string of_captura_valor_flag (string ps_flag);
String ls_Flag
String ls_Retorno
String ls_Byte

Long	ll_Pos
Long	ll_Inicio
Long	ll_Final

ll_Pos = Pos(result.is_data,ps_flag,1)

If Not ll_Pos = 0 Then

	ll_Inicio = ll_Pos + Len(ps_flag) + 1 
	
	ll_Final  = Pos(result.is_data,';',ll_Inicio) - ll_Inicio
	
	ls_Flag	 = Mid(result.is_data,ll_Inicio,ll_Final)
		
End If	

//Retira caracter TAB

For ll_Pos = 1 To Len(ls_Flag)
	
	ls_Byte = Mid(ls_Flag,ll_Pos,1)
	
	If Not ( ls_Byte = Char(10) or ls_Byte = Char(9) ) Then
		ls_Retorno += Mid(ls_Flag,ll_Pos,1)
	End If	
Next	

Return ls_Retorno
	




end function

public subroutine of_msgerror (string ps_consulta);String ls_Mensagem

ls_Mensagem = 'Rotina:' + This.is_Rotina

If Not IsNull( ps_consulta ) And Trim( ps_consulta ) <> ''  Then ls_Mensagem += ' - ' + ps_consulta
If Not IsNull( This.is_Erro ) And Trim( This.is_Erro ) <> '' Then ls_Mensagem += '~n~n' + 'Retorno: ' + This.is_Erro
If Not IsNull( Result.is_Data ) And Trim( Result.is_Data ) <> '' Then ls_Mensagem += '~n~n' + 'Dados: ' + Result.is_Data

If This.is_SQLErro <> '' Then ls_Mensagem += '~n~nSQL: ' + This.is_SQLErro
										 
MessageBox("Transa$$HEX2$$e700e300$$ENDHEX$$o Remota", ls_Mensagem, StopSign!)
end subroutine

public function boolean of_retorno (string ps_coluna, ref string ps_retorno);String	ls_Retorno

Long		ll_Inicio
Long     ll_Bytes

ls_Retorno = This.Result.is_data

ll_Inicio 	= Pos(ls_Retorno, ps_coluna )

If ll_Inicio = 0 Then Return True

ll_Inicio  	+= Len(ps_coluna) + 1

For ll_Bytes = ll_Inicio To Len(ls_Retorno)
	
	If Mid(ls_Retorno,ll_Bytes,1) = Char(9) or Mid(ls_Retorno,ll_Bytes,1) = Char(10) Then Exit
	
Next

ps_retorno 	= Mid(ls_Retorno,ll_Inicio, ll_Bytes - ll_Inicio)

If Trim(ps_retorno) = '' Then	SetNull(ps_retorno)
		
Return True
end function

public function boolean of_retorno (string ps_coluna, ref long pl_retorno);String ls_Retorno

If Not This.of_Retorno(Ref ps_coluna, Ref ls_Retorno) Then Return False

If Trim(ls_Retorno) = '' Then
	SetNull(pl_Retorno)
Else
	pl_retorno = Long(ls_Retorno)
End If	

Return True
end function

public function boolean of_retorno (string ps_coluna, ref decimal pdc_retorno);Decimal{2} ldc_Retorno

String ls_Retorno

If Not This.of_Retorno(Ref ps_coluna, Ref ls_Retorno) Then Return False

ls_Retorno = gf_Replace(ls_Retorno,".",",",0)

If ls_Retorno = '' Then
	SetNull(pdc_retorno)
Else	
	//ldc_Retorno	= Dec(ls_Retorno)/100
	pdc_retorno = Dec(ls_Retorno)
End If	

Return True

end function

public function datetime of_data_parametro_central ();DateTime lvdh_Parametro

This.of_Define_Variaveis(True)

This.of_executa_rotina('0105', {''} )

If This.ib_Erro Then	
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Movimenta$$HEX2$$e700e300$$ENDHEX$$o")
	SetNull(lvdh_Parametro)
Else

	If Not This.of_Retorno('dh_movimentacao', Ref lvdh_Parametro) Then
		SetNull(lvdh_Parametro)
	Else
	
		If This.il_Linhas = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
			SetNull(lvdh_Parametro)
		End If
		
	End If		
		
End If	

Return lvdh_Parametro
end function

public function boolean of_retorno (string ps_coluna, ref datetime pdh_datetime);String ls_Retorno
String ls_Data
String ls_Hora

If Not This.of_Retorno(Ref ps_coluna, Ref ls_Retorno) Then Return False

pdh_datetime = Datetime(Date(Mid(ls_Retorno,1,10)),Time(Mid(ls_Retorno,12,8)))

If Date(pdh_datetime) = Date('1900/01/01') Then	SetNull(pdh_datetime)

Return True
end function

public function boolean of_retorno (ref datastore pds_datastore);String	ls_retorno
String	ls_dados

Long		ll_retorno
Long 		ll_inicio
Long 		ll_fim

ls_Retorno = This.Result.is_data

If Mid(ls_Retorno,8,6) = '000000' Then
	This.il_Linhas = 0
	Return True
End If	

ll_inicio = Pos(ls_Retorno,'<inicio>')
ll_fim    = Pos(ls_Retorno,'<fim>')

If ll_Inicio = 0 Then Return True

If ll_inicio > 0 And ll_fim <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel recuperar todas as informa$$HEX2$$e700f500$$ENDHEX$$es do servidor distribuido. ~r~rFavor informar o CPD.", StopSign!)
	
	Return False	
Else
	ll_inicio += 8
	
	ls_dados  = Mid(ls_Retorno,ll_inicio, ll_fim - ll_inicio)
	
	ll_Retorno = pds_datastore.ImportString(ls_dados)
	
	If ll_Retorno > 0 Then
		This.il_Linhas = pds_datastore.RowCount()
		Return True
	Else
		This.ib_Erro = True
		This.is_Erro = "Erro ao importar retorno da consulta para datastore (" + String(ll_Retorno) + ")"
		Return False
	End If			
End If

Return True
end function

public function boolean of_desconto_cartao_unimed (string as_cartao, ref decimal adc_desconto);String ls_contrato
Boolean lb_Sucesso

This.of_BancoProducao()

This.of_Define_Variaveis(True)
This.of_ConverteVirgula(True)

This.of_executa_rotina('0144', {"'"+as_cartao+"'"} )  //Era a 0107

If This.of_Erro_Execucao() Or This.of_Erro_Conexao() Then
	SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do desconto Unimed no distribu$$HEX1$$ed00$$ENDHEX$$do.")
	adc_desconto = 000.00
Else	
	If This.of_Linhas() > 0 Then	
		If Not This.of_Retorno('pc_desconto', Ref adc_desconto) Then 	adc_desconto = 000.00
		
		If Not This.of_Retorno('nr_contrato', Ref ls_contrato) Then 	ls_contrato = ''
		
		If Trim(ls_contrato) <> '' And Not IsNull(ls_contrato ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cart$$HEX1$$e300$$ENDHEX$$o UNIMED '" + as_Cartao + "' sem desconto vinculado.", Exclamation!)
			adc_desconto = 000.00					
		Else
			lb_sucesso = True
		End If	
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cart$$HEX1$$e300$$ENDHEX$$o UNIMED '" + as_Cartao + "' n$$HEX1$$e300$$ENDHEX$$o localizado.~n~n" + &
									 "Imposs$$HEX1$$ed00$$ENDHEX$$vel conceder desconto.", Exclamation!)
		adc_desconto = 000.00		
	End If		
		
End If	

Return lb_Sucesso
end function

public function boolean of_insert_registro (string as_tabela, string as_colunas, string as_values, ref long al_regitros);
Boolean lb_Sucesso

String ls_Colunas
String ls_Values

ls_Colunas = "(" + as_colunas + ")"
ls_Values  = "(" + as_values  + ")"

al_regitros = 0

//Insert gen$$HEX1$$e900$$ENDHEX$$rico

This.of_executa_rotina('000008', {as_Tabela, ls_Colunas, ls_Values } )

If This.ib_Erro Then	
	This.of_MsgError("Inserindo registro.")
	lb_Sucesso = False
Else
	
	lb_Sucesso = True
	
	al_regitros = This.il_Rows
				
End If	

Return lb_Sucesso

end function

public function boolean of_delete_registro (string as_tabela, string as_where, ref long al_regitros);
Boolean lb_Sucesso

String ls_Colunas
String ls_Values

al_regitros = 0

//Insert gen$$HEX1$$e900$$ENDHEX$$rico
This.of_executa_rotina('000009', {as_Tabela, as_where } )

If This.ib_Erro Then	
	This.of_MsgError("Deletando registro.")
	lb_Sucesso = False
Else
	
	lb_Sucesso = True
	
	al_regitros = This.il_Rows
				
End If	

Return lb_Sucesso

end function

public function boolean of_update_registro (string as_tabela, string as_set, string as_where, ref long al_regitros);
Boolean lb_Sucesso

String ls_Colunas
String ls_Values

al_regitros = 0

//Update gen$$HEX1$$e900$$ENDHEX$$rico
This.of_executa_rotina('000010', {as_Tabela, as_Set, as_where } )

If This.ib_Erro Then	
	This.of_MsgError("Alterando registro(s).")
	lb_Sucesso = False
Else
	
	lb_Sucesso = True
	
	al_regitros = This.il_Rows
				
End If	

Return lb_Sucesso

end function

public function boolean of_retrieve (ref datastore pds_datastore);
String lvs_Sintaxe
String lvs_SQL
String lvs_Erro

lvs_SQL = pds_datastore.GetSQLSelect()

// Determina a sintaxe para cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow
lvs_Sintaxe = SqlCa.SyntaxFromSQL(lvs_SQL, "Style(Type=Grid)", lvs_Erro)

pds_datastore.Create(lvs_Sintaxe, lvs_Erro)

If Trim(lvs_Erro) <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da datastore para retrieve.")
	Return False
End If

This.of_executa_Rotina('00006',{lvs_SQL})

If This.ib_Erro Then	
	This.of_MsgError("Erro no retrieve.")
	Return False
End If	

If This.of_Retorno(Ref pds_datastore) Then
	Return True
Else	
	Return False
End If

end function

public function boolean of_retorno_dados (ref string ps_dados);String	ls_retorno
String	ls_dados

Long		ll_retorno
Long 		ll_inicio
Long 		ll_fim

ls_Retorno = This.Result.is_data

If Mid(ls_Retorno,8,6) = '000000' Then
	This.il_Linhas = 0
	Return True
End If	

ll_inicio = Pos(ls_Retorno,'<inicio>')
ll_fim    = Pos(ls_Retorno,'<fim>')

If ll_inicio > 0 And ll_fim <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel recuperar todas as informa$$HEX2$$e700f500$$ENDHEX$$es do servidor distribuido. ~r~rFavor informar o CPD.", StopSign!)
	
	Return False	
Else
	ll_inicio += 8

	ps_dados  = Mid(ls_Retorno,ll_inicio, ll_fim - ll_inicio)
End If

Return True


end function

public function boolean of_retrieve (string ps_sql, ref string ps_dados);
This.of_executa_Rotina('00006',{ps_sql})

If This.ib_Erro Then
	This.of_MsgError("Erro no retrieve.")
	Return False
End If	

If This.of_Retorno_Dados(Ref ps_dados) Then
	Return True
Else	
	Return False
End If

end function

public function boolean of_erro_execucao ();
Return This.ib_Erro
end function

public function boolean of_erro_conexao ();
Return This.ib_ErroConexao
end function

public function long of_linhas ();Return This.il_Linhas
end function

public function long of_rows ();
Return This.il_Rows
end function

public function boolean of_retorno (string ps_coluna, ref boolean pb_retorno);String ls_Retorno

If Not This.of_Retorno(Ref ps_coluna, Ref ls_Retorno) Then Return False

If ls_Retorno = "S" Then
	pb_retorno = True
Else
	pb_retorno = False
End If	

Return True
end function

public subroutine of_convertevirgula (boolean pb_flag);ib_ConverteVirgula=pb_flag

end subroutine

public subroutine of_define_variaveis (boolean pb_flag);ib_DefVariaveis=pb_flag
end subroutine

public subroutine of_relatorio (boolean ab_relatorio);If ab_Relatorio Then
	This.is_url = SCRIPT_RELATORIO
Else
	This.is_url = SCRIPT_CONSULTA
End If
end subroutine

public function boolean of_consulta_cheque (string ps_cpf);String ls_url
String ls_argumentos
String ls_headers
String ls_Nome
String ls_Mensagem
String ls_Tipo = '2'
String ls_erro

Long ll_length
Long ll_sucesso
Long ll_Arg

Blob lb_args

Boolean lb_Retorno = True

If Len(ps_Cpf) = 14 Then
	ls_Tipo = '1'
End If

If Not gf_servidor_intranet(True, Ref is_servidor_intranet , Ref ls_erro) Then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro localiza$$HEX2$$e700e300$$ENDHEX$$o servidor intranet: Produ$$HEX2$$e700e300$$ENDHEX$$o'" + ls_erro + "'.", StopSign!)
	Return False	
End If

ls_url        = This.is_Servidor_Intranet + "/_distribuido/consulta_cheque.php"
ls_argumentos = "valor=" + ps_Cpf + "&tipo=" + ls_Tipo + "&pdv=" + gvo_Aplicacao.is_ComputerName

lb_args 		= blob(ls_argumentos, EncodingANSI!)
ll_length 	= Len(lb_args)

ls_headers = "Content-Type: " + &
				 "application/x-www-form-urlencoded~n" + &
				 "Content-Length: " + String( ll_length ) + "~n~n"

ll_Sucesso = intranet.PostURL(ls_url,lb_args,ls_headers,This.result)

If This.ib_MostraRetorno Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Retorno da transa$$HEX2$$e700e300$$ENDHEX$$o: ' + This.Result.is_data)
End If

If ll_Sucesso <> 1 Then
	Choose Case ll_Sucesso
		Case -1 
			ls_Mensagem = 'General error'
			
		Case -2
			ls_Mensagem = 'Invalid URL'
			
		Case -4
			ls_Mensagem = 'Cannot connect to the Internet'
			
		Case -6
			ls_Mensagem = 'Internet request failed'
			
	End Choose	
	
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na conex$$HEX1$$e300$$ENDHEX$$o.~n~n Fun$$HEX2$$e700e300$$ENDHEX$$o PostURL~n ' + String(ll_Sucesso) + ' ' + ls_Mensagem, StopSign!)
	Return False
	
End If

Choose Case Mid(This.Result.is_data, 1, 2)
	Case "ME"
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retorno da consulta~n~n" + Mid(This.Result.is_data, 3), StopSign!)
			Return False
			
			
	Case "00" //Nada consta
		Return True
		
	Case "21"
			Select nm_cliente
			  Into :ls_Nome
			  From cliente_cheque
			 Where nr_cpf = :ps_Cpf
			 Using SqlCa;
			 
		Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_MsgDbError('LOCALIZA$$HEX2$$c700c300$$ENDHEX$$O DE CLIENTE_CHEQUE')
				Return False
				
			Case 0
				
			Case 100
				ls_Nome = "CADASTRO DE CLIENTE CHEQUE N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO"
				
		End Choose
		
		ls_Mensagem = "CPF/CNPJ: '" + ps_Cpf + "'~n" + &
						  "Nome: '" + ls_Nome + "'~n~n" + &
						  "Existem pend$$HEX1$$ea00$$ENDHEX$$ncias no cadastro.~n~n" + &
						  "Por favor, procure o gerente do banco."
						  
		lb_Retorno = False
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem)

End Choose

Return lb_Retorno
end function

public function boolean of_envia_email_cliente_clube (string ps_nm_cliente, string ps_de_email);String ls_argumentos

ls_argumentos = "cliente=" + ps_nm_cliente + "&email=" + ps_de_email

Return this.of_executa_rotina_intranet('email_cliente_clube', ls_argumentos)
end function

public function boolean of_executa_rotina_intranet (string ps_script, string ps_argumentos);Return This.of_Executa_Rotina_Intranet( ps_Script, ps_Argumentos, True )
end function

public function boolean of_executa_rotina_intranet (string ps_script, string ps_argumentos, boolean pb_base_producao);//**** O teste da base de producao foi alterado para utilizar o parametro ID_BASE_PRODUCAO
//If Not pb_Base_Producao Then
//	is_servidor_intranet = is_servidor_intranet_des
//End If

String ls_url
String ls_argumentos
String ls_headers
String ls_Mensagem = ""
String ls_Parametro
String ls_erro

Long ll_length
Long ll_sucesso
Long ll_Arg
Blob lb_args
	
// URL
If Not gf_servidor_intranet(True, Ref is_servidor_intranet , Ref ls_erro) Then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro localiza$$HEX2$$e700e300$$ENDHEX$$o servidor intranet: Produ$$HEX2$$e700e300$$ENDHEX$$o'" + ls_erro + "'.", StopSign!)
	Return False	
End If 

//Usado no TL nos envios de arquivos do troca dados para a matriz
If ib_Compara_Md5_TDC Then
	This.is_Servidor_Intranet = 'http:\\' + is_FTP_TROCA_DADOS
End If

// Forma URL
If (ps_script='atualiza_tipo_relatorio') or (ps_script='leitor.malote.lacre') Then 
   ls_url = This.is_Servidor_Intranet + "/malote/" + ps_script + ".php"
ElseIf ps_script = "finaliza_transferencia" Then
	ls_url = This.is_Servidor_Intranet + "/_distribuido/" + ps_script + ".php"
Elseif Trim(This.is_diretorio_script_intranet ) <> '' Then
	ls_url = This.is_Servidor_Intranet + "/" + This.is_diretorio_script_intranet + "/" + ps_script + ".php"
Else	
	ls_url = This.is_Servidor_Intranet + "/_distribuido/" + ps_script + ".php"
	/* Para eventuais condicionais no php para identificar a origem da execu$$HEX2$$e700e300$$ENDHEX$$o da pagina */
	If Trim( ps_argumentos ) <> "" And Not IsNull(  ps_argumentos ) Then
		ps_argumentos += "&"
	End If
	ps_argumentos += "id_distribuido=1"
	/********/
End If

lb_args	= blob( ps_argumentos, EncodingANSI! )
ll_length 	= Len(lb_args)
ls_headers = "Content-Type: " + &
				 "application/x-www-form-urlencoded~n" + &
				 "Content-Length: " + String( ll_length ) + "~n~n"

ll_Sucesso = intranet.PostURL( ls_url,lb_args,ls_headers,This.result )

is_Retorno = This.result.is_data

If ll_Sucesso <> 1 Then
	Choose Case ll_Sucesso
		Case -1 
			ls_Mensagem = 'General error'			
		Case -2
			ls_Mensagem = 'Invalid URL'			
		Case -4
			ls_Mensagem = 'Cannot connect to the Internet'			
		Case -6
			ls_Mensagem = 'Internet request failed'			
	End Choose
	
	// DEBUG para transfer$$HEX1$$ea00$$ENDHEX$$ncias que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o registrando na intranet
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema ='TD' Then
		Integer li_Log
		String ls_Arquivo_Log
		
		ls_Arquivo_Log = "c:\sistemas\troca_dados_central\arquivos\registra_transferencia_intranet.log"
		
		li_Log =  FileOpen( ls_Arquivo_Log, LineMode!, Write!, Shared!, Append!)
		If li_Log > 0 Then
			FileWrite( li_Log, String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + " :: " + ps_argumentos + " :: ERRO: " + ls_Mensagem )			
			FileClose( li_Log )
		Else
			if not gvb_Auto then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro na abertura do arquivo de log '" + ls_Arquivo_Log + "'.", StopSign!)
			end if
		End If
		
	End If
	
	If ib_MostraRetorno and not gvb_Auto Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na conex$$HEX1$$e300$$ENDHEX$$o.~n~n Fun$$HEX2$$e700e300$$ENDHEX$$o PostURL~n ' + String(ll_Sucesso) + ' ' + ls_Mensagem, StopSign!)
	End If
	
	Return False	
End If

Return True
end function

public function boolean of_update_registro (string as_tabela, string as_set, string as_where, ref long al_regitros, ref string as_mensagem);// Fun$$HEX2$$e700e300$$ENDHEX$$o que n$$HEX1$$e300$$ENDHEX$$o apresenta mensagem de erro, mas retorna atrav$$HEX1$$e900$$ENDHEX$$s do argumento recebido por refer$$HEX1$$ea00$$ENDHEX$$ncia [as_Mensagem]
Boolean lb_Sucesso

String ls_Colunas
String ls_Values

al_regitros = 0

//Update gen$$HEX1$$e900$$ENDHEX$$rico
This.of_executa_rotina('000010', {as_Tabela, as_Set, as_where } )

If This.ib_Erro Then	
	as_Mensagem = 'Rotina:' + This.is_Rotina + ' - ' + "Alterando registro(s)." + '~n~n' + 'Retorno: ' + This.is_Erro 
	If This.is_SQLErro <> '' Then as_Mensagem += '~n~nSQL: ' + This.is_SQLErro
	
	lb_Sucesso = False
Else
	
	lb_Sucesso = True
	
	al_regitros = This.il_Rows
				
End If	

Return lb_Sucesso

end function

public function boolean of_executa_rotina_generica (string ps_script, string ps_argumentos);String ls_url
String ls_argumentos
String ls_headers
String ls_Mensagem

Long ll_length
Long ll_sucesso
Long ll_Arg

Blob lb_args

ls_url      = ps_script

lb_args	= blob( ps_argumentos, EncodingANSI! )
ll_length 	= Len(lb_args)

ls_headers = "Content-Type: " + &
				 "application/x-www-form-urlencoded~n" + &
				 "Content-Length: " + String( ll_length ) + "~n~n"

ll_Sucesso = intranet.PostURL( ls_url,lb_args,ls_headers,This.result )

If ll_Sucesso <> 1 Then
	Choose Case ll_Sucesso
		Case -1 
			ls_Mensagem = 'General error'
			
		Case -2
			ls_Mensagem = 'Invalid URL'
			
		Case -4
			ls_Mensagem = 'Cannot connect to the Internet'
			
		Case -6
			ls_Mensagem = 'Internet request failed'
			
	End Choose	
	
	If ib_MostraRetorno Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na conex$$HEX1$$e300$$ENDHEX$$o.~n~n Fun$$HEX2$$e700e300$$ENDHEX$$o PostURL~n ' + String(ll_Sucesso) + ' ' + ls_Mensagem, StopSign!)
	End If
	
	Return False
	
End If

Return True
end function

public function boolean of_ping ();If Not This.ib_ExecutaPing Then Return True

Integer li_Loop = 0

Boolean lb_Successo = True

Double ldbl_Elapsed

uo_ge040_Network lo_Ping

Try
	lo_Ping = Create uo_ge040_Network
	lo_Ping.of_Performance_Beg()
	
	Do 
		li_Loop++
		lb_Successo = lo_Ping.of_Ping( This.is_Servidor )
	Loop While ( Not lb_Successo ) And ( li_Loop < 3 )

	ldbl_Elapsed = lo_Ping.of_Performance_End()

Catch( Exception ex )
	//
Finally
	Destroy lo_Ping
End Try

Return lb_Successo
end function

public function string of_retorno_dados_intranet ();Return This.Result.is_data
end function

public subroutine of_executa_ping (boolean pb_executa);This.ib_ExecutaPing = pb_Executa
end subroutine

public function boolean of_retorno (string ps_coluna, ref integer pdi_retorno);Integer ldi_Retorno

String ls_Retorno

If Not This.of_Retorno( Ref ps_coluna, Ref ls_Retorno ) Then Return False

If ls_Retorno = '' Then
	SetNull(pdi_retorno)
Else	
	pdi_retorno = Integer(ls_Retorno)
End If	

Return True
end function

public function boolean of_verifica_unimed_clamed (string as_cartao);String ls_contrato
Boolean lb_Sucesso

This.of_BancoProducao()

This.of_Define_Variaveis(True)
This.of_ConverteVirgula(True)

This.of_executa_rotina('0006', {"Select nr_contrato from unimed_contrato where CHARINDEX( nr_contrato, substring('" + as_cartao + "',3,8) ) > 0"} ) 

If This.of_Erro_Execucao() Or This.of_Erro_Conexao() Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do contrato Unimed no distribu$$HEX1$$ed00$$ENDHEX$$do.")
Else	
	If This.of_Linhas() > 0 Then	
		
		If Not This.of_Retorno('nr_contrato', Ref ls_contrato) Then 	ls_contrato = ''
		
		If Trim(ls_contrato) <> '' And Not IsNull(ls_contrato ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cart$$HEX1$$e300$$ENDHEX$$o UNIMED '" + as_Cartao + "' sem desconto vinculado.", Exclamation!)
		Else
			lb_sucesso = True
		End If	
	Else
		lb_sucesso = True
	End If		
		
End If	

Return lb_Sucesso
end function

public function boolean of_verifica_cartao_saude (string as_convenios, string as_cartao, string as_tipo_cartao, ref long al_convenio);String ls_cartao
String ls_cpf

Boolean lb_Sucesso

This.of_BancoProducao()

This.of_Define_Variaveis(True)
This.of_ConverteVirgula(True)

If as_tipo_cartao = '2' Then
	as_cartao = Trim(as_cartao)
	This.of_executa_rotina('0006', {"Select cd_convenio, nr_cpf from cartao_saude where cd_convenio in( " + as_convenios  + ") and nr_cpf = '" + as_cartao + "' and id_situacao = 'A'" } ) 
Else
	This.of_executa_rotina('0006', {"Select cd_convenio, nr_cartao from cartao_saude where cd_convenio in( " + as_convenios  + ") and nr_cartao = '" + as_cartao + "' and id_situacao = 'A'" } ) 
End If

If This.of_Erro_Execucao() Or This.of_Erro_Conexao() Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o cart$$HEX1$$e300$$ENDHEX$$o plano sa$$HEX1$$fa00$$ENDHEX$$de no distribu$$HEX1$$ed00$$ENDHEX$$do.")
Else	
	If This.of_Linhas() > 0 Then	
		
		If as_tipo_cartao = '2' Then 
			If Not This.of_Retorno('nr_cpf', Ref ls_cpf) Then 	ls_cpf = ''
			
			If Trim(ls_cpf) <> '' And Not IsNull(ls_cpf ) Then
				lb_sucesso = True
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O CPF informado n$$HEX1$$e300$$ENDHEX$$o possui cadastro no conv$$HEX1$$ea00$$ENDHEX$$nio Clinipam.", Exclamation!)			
			End If
			
		Else
			If Not This.of_Retorno('nr_cartao', Ref ls_cartao) Then 	ls_cartao = ''
			
			If Trim(ls_cartao) <> '' And Not IsNull(ls_cartao ) Then
				lb_sucesso = True
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de '" + as_Cartao + "' n$$HEX1$$e300$$ENDHEX$$o encontrado.", Exclamation!)			
			End If
		End If
		
		If Not This.of_Retorno('cd_convenio', Ref al_convenio) Then lb_sucesso = false
	Else
		If as_tipo_cartao = '2' Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O CPF informado n$$HEX1$$e300$$ENDHEX$$o possui cadastro no conv$$HEX1$$ea00$$ENDHEX$$nio Clinipam.", Exclamation!)			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de '" + as_Cartao + "' inativo ou n$$HEX1$$e300$$ENDHEX$$o encontrado.", Exclamation!)			
		End If
	End If		
		
End If	

Return lb_Sucesso
end function

on uo_transacao_remota.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_transacao_remota.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;intranet = CREATE inet
result 	= CREATE uo_internetresult

Long ll_Filial_Matriz

If Not gf_Filiais_Parametro( Ref This.il_Filial, Ref ll_Filial_Matriz ) Then
	Return -1
End If

If This.il_Filial <> ll_Filial_Matriz Then
	SELECT vl_parametro
	INTO :This.is_Servidor
	FROM parametro_loja
	WHERE cd_parametro = 'DE_ENDERECO_SERVIDOR_DISTRIBUIDO'
	USING SqlCa;
Else
	SELECT vl_parametro
	INTO :This.is_Servidor
	FROM parametro_loja
	WHERE cd_filial = :This.il_Filial
	AND cd_parametro = 'DE_ENDERECO_SERVIDOR_DISTRIBUIDO'
	USING SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError( "LOCALIZA$$HEX2$$c700c300$$ENDHEX$$O DO PAR$$HEX1$$c200$$ENDHEX$$METRO 'DE_ENDERECO_SERVIDOR_DISTRIBUIDO'." )
		Return -1
		
	Case 100
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro 'DE_ENDERECO_SERVIDOR_DISTRIBUIDO' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign! )
		Return -1
End Choose

end event

event destructor;Destroy(intranet)
Destroy(result)

end event

