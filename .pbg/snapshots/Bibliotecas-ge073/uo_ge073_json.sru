HA$PBExportHeader$uo_ge073_json.sru
$PBExportComments$Objeto para gerar arquivo xml
forward
global type uo_ge073_json from nonvisualobject
end type
end forward

global type uo_ge073_json from nonvisualobject
end type
global uo_ge073_json uo_ge073_json

type variables
Integer ivi_Arquivo_Xml

Boolean ivb_Grava_Arquivo = true
String ivs_Acao_Erro = 'M'
String ivs_Arquivo_Xml

//String ivs_Enter = Char(13) + Char(10)
String ivs_Enter = ''
//String ivs_Tab = Char(9)
String ivs_Tab = ""
end variables

forward prototypes
public function string of_busca_conteudo_campo (string ps_json, string ps_campo)
public function boolean of_divide_grupo_json_tag (ref string ps_texto, string ps_tag, ref string ps_primeiro_grupo, string ps_tag_fechamento)
public function boolean of_divide_grupo_json_completo (ref string ps_texto, ref string ps_primeiro_grupo, string ps_tag_abertura)
public function string of_busca_conteudo_campo (string ps_json, string ps_campo, boolean pb_substiui_null)
public function boolean of_existe_campo (string ps_json, string ps_campo)
public function boolean of_divide_grupo_json_tag_vtex (ref string ps_texto, string ps_tag, ref string ps_primeiro_grupo, string ps_tag_fechamento)
public function string of_busca_conteudo_campo_vtex (string ps_json, string ps_campo)
end prototypes

public function string of_busca_conteudo_campo (string ps_json, string ps_campo);Return This.of_Busca_conteudo_campo( ps_json, ps_campo, true )
end function

public function boolean of_divide_grupo_json_tag (ref string ps_texto, string ps_tag, ref string ps_primeiro_grupo, string ps_tag_fechamento);//Par$$HEX1$$e200$$ENDHEX$$metros:
//ps_texto - String na qual a tag ser$$HEX1$$e100$$ENDHEX$$ buscada
//ps_tag - tag que ser$$HEX1$$e100$$ENDHEX$$ buscada. Ex: "Cliente"
//ps_primeiro grupo - Retorna uma string com todo o conte$$HEX1$$fa00$$ENDHEX$$do dentro da tag , incluindo as subtags
// Retorna se encontrou conte$$HEX1$$fa00$$ENDHEX$$do na tag ou n$$HEX1$$e300$$ENDHEX$$o.
//ps_Tag_fechamento pode ser }, ] etc

Long ll_Pos, ll_Posicao_ini, ll_Posicao_fim, ll_Tamanho_tag, ll_tamanho_conteudo

String ls_mensagem, ls_Restante_Arquivo

ps_primeiro_grupo = ''

ps_tag = '"' + ps_tag + '"'
ll_Pos = Pos(ps_texto,ps_tag)
ll_Tamanho_tag = Len(ps_tag)

If ll_Pos > 0 Then
		
	ll_Posicao_ini =  ll_Pos + ll_Tamanho_tag
	ll_Posicao_fim = Pos(Mid(ps_texto, ll_Posicao_ini), ps_Tag_fechamento) + ll_Posicao_ini
	ll_tamanho_conteudo = ll_Posicao_fim - ll_Posicao_ini
	ps_primeiro_grupo = Mid(ps_texto, ll_Posicao_ini, ll_tamanho_conteudo)
End if

ps_texto = Mid(ps_texto, ll_Posicao_fim + ll_Tamanho_tag )

If ps_primeiro_grupo = '' Then
	Return False
End If

Return True

end function

public function boolean of_divide_grupo_json_completo (ref string ps_texto, ref string ps_primeiro_grupo, string ps_tag_abertura);//Par$$HEX1$$e200$$ENDHEX$$metros:
//ps_texto - String na qual a tag ser$$HEX1$$e100$$ENDHEX$$ buscada
//ps_texto - Retorna o que sobrou no arquivo, abaixo do fechamento da tag 
//ps_primeiro_grupo - Retorna uma string com todo o conte$$HEX1$$fa00$$ENDHEX$$do dentro da tag , incluindo as subtags
//ps_tag_abertura - Indica se o grupo ser$$HEX1$$e100$$ENDHEX$$ dividido por { ou [
// Retorna se encontrou conte$$HEX1$$fa00$$ENDHEX$$do ou n$$HEX1$$e300$$ENDHEX$$o.

/* Pega o conte$$HEX1$$fa00$$ENDHEX$$do entre chaves, independente de quantas chaves e colchetes abrem e fecham antes de fechar a principal:
Exemplo tag = {
[
	{//ps_primeiro_grupo inicia aqui
		 "Cliente":{},
		 "Produto":[{}]
	}//ps_primeiro_grupo termina aqui
	
	{// daqui para baixo retorna no ps_texto
		 "Cliente":{},
		 "Produto":[{}]
	}
]

Exemplo tag = [
[//ps_primeiro_grupo inicia aqui
	{
		 "Cliente":{},
		 "Produto":[{}]
	}	
	{
		 "Cliente":{},
		 "Produto":[{}]
	}
]//ps_primeiro_grupo termina aqui

*/

Long ll_Pos, ll_Posicao_ini, ll_Posicao_fim, ll_Tamanho_tag, ll_tamanho_conteudo, ll_tamanho_string, ll_caracter, ll_qtd_abertuta, ll_qtd_fechamento

String ls_Tag_fechamento, ls_mensagem, ls_Restante_Arquivo

ps_primeiro_grupo = ''

If ps_tag_abertura = '{' Then
	ls_Tag_fechamento = '}'
End If
If ps_tag_abertura = '[' Then
	ls_Tag_fechamento = ']'
End If

ll_Pos = Pos(ps_texto, ps_tag_abertura)
ll_Tamanho_String = Len(ps_texto)

If ll_Pos > 0 Then	
	ll_Posicao_ini =  ll_Pos + 1
	ll_qtd_fechamento = 0
	ll_qtd_abertuta = 0
	
	For ll_caracter = 1 to ll_Tamanho_String Step 1
		If ll_caracter < ll_Posicao_ini  Then Continue
		If Mid(ps_texto, ll_caracter, 1)  = ps_tag_abertura Then
			ll_qtd_abertuta += 1
		End If
		
		If Mid(ps_texto, ll_caracter, 1) = ls_Tag_fechamento Then
			ll_qtd_fechamento += 1
			If ll_qtd_fechamento > ll_qtd_abertuta Then				
				ll_Posicao_fim = ll_caracter
				Exit
			End If
		End If		

	Next
	ll_tamanho_conteudo = ll_Posicao_fim - ll_Posicao_ini
	ps_primeiro_grupo = Mid(ps_texto, ll_Posicao_ini, ll_tamanho_conteudo)
End If

//Tag fechamento come$$HEX1$$e700$$ENDHEX$$a na posi$$HEX2$$e700e300$$ENDHEX$$o fim, + tamanho da tag + 1 = caracter ap$$HEX1$$f300$$ENDHEX$$s >
ps_texto = Mid(ps_texto, ll_Posicao_fim + ll_Tamanho_tag + 1)

If ps_primeiro_grupo = '' Then
	Return False
End If

Return True

end function

public function string of_busca_conteudo_campo (string ps_json, string ps_campo, boolean pb_substiui_null);Long ll_Pos_De
Long ll_Pos_Ate

String ls_Valor

// Para localizar o nome completo do campo, exemplo: "vl_bc_icms". Sem essa condicao, caso encontrasse antes o vl_bc_icms_st, consideraria este ao inv$$HEX1$$e900$$ENDHEX$$s do procurado.
ps_Campo = gf_Replace( ps_Campo, '"', '', 0 )
ps_Campo = '"' + ps_Campo + '"'

If ps_Campo = '"dh_ultimo_acesso"' Then
	ps_Campo = ps_Campo
End If

// Localiza a letra inicial do campo
ll_Pos_De = PosA( ps_Json , ps_Campo, 1 )

// Localiza o separador de campo/valor (:) e retorna a posi$$HEX2$$e700e300$$ENDHEX$$o do proximo caracter
ll_Pos_De = PosA( ps_Json, ':', ll_Pos_De + 1 ) + 1

// Quebra a string Json retirando o nome do campo de seu inicio
ps_Json = Trim( Mid( ps_Json, ll_Pos_De ) )

// Verifica se o valor do campo inicia com (") aspa dupla. Caso TRUE, o campo termina na ocorrencia de (",) aspa dupla seguida de virgula, caso FALSE, o campo termina na ocorrencia da (,) virgula
If LeftA( ps_Json, 1 ) = '"' Then
	
	// Remove a aspa dupla inicial para (") para n$$HEX1$$e300$$ENDHEX$$o causar problema na procura de teminador de valor (",) quando o valor come$$HEX1$$e700$$ENDHEX$$a com (,)
	ps_Json		= Mid( ps_Json, 2 )
	ll_Pos_Ate	= PosA( ps_Json, '",' )
Else
	ll_Pos_Ate = PosA( ps_Json, ',' )
End If

// Quando for o $$HEX1$$fa00$$ENDHEX$$ltimo valor, considera a posicao de termino o final da string Json
If ll_Pos_Ate < 1 Then
	ll_Pos_Ate = LenA( ps_Json ) - 1
Else
	ll_Pos_Ate = ll_Pos_Ate - 1
End If

// Captura o valor entre o primeiro caracter e o da posicao do delimitador
ls_Valor	= MidA( ps_Json, 1, ll_Pos_Ate )

// Remove ENTER
ls_Valor	= gf_Replace( ls_Valor,char(13) + char(10),'',0 ) // ENTER

// Remove (") aspa dupla
ls_Valor = gf_Replace( ls_Valor,'"','',0 )

// Remove a chave de fechamento
ls_Valor = gf_Replace( ls_Valor,'}','',0 ) //Quando $$HEX1$$e900$$ENDHEX$$ o $$HEX1$$fa00$$ENDHEX$$ltimo campo do grupo n$$HEX1$$e300$$ENDHEX$$o tem ',' depois do campo, por isso vai at$$HEX1$$e900$$ENDHEX$$ a tag de fechamento '},'

// Remove o colchete de fechamento
ls_Valor	= gf_Replace( ls_Valor,']','',0 ) //Quando $$HEX1$$e900$$ENDHEX$$ o $$HEX1$$fa00$$ENDHEX$$ltimo campo do grupo n$$HEX1$$e300$$ENDHEX$$o tem ',' depois do campo, por isso vai at$$HEX1$$e900$$ENDHEX$$ a tag de fechamento '],'

// Remove espacos do inicio e do final
ls_Valor = Trim( ls_Valor )

// Como a integracao FARMAGORA espera VALOR branco quando encontra NULL, e isso foge ao padrao, foi criada uma funcao para indicar se substitui o NULL por branco
If Upper(ls_Valor) = 'NULL' And pb_Substiui_Null Then
	ls_Valor	= ''
End If

Return ls_Valor

end function

public function boolean of_existe_campo (string ps_json, string ps_campo);ps_Campo = gf_replace( ps_Campo, '"', '', 0 )
ps_Campo = '"' + ps_Campo + '"' // Para localizar o nome completo do campo, exemplo: "vl_mb_icms". Sem essa condicao, caso encontrasse antes o vl_bc_icms_st, consideraria este ao inv$$HEX1$$e900$$ENDHEX$$s do procurado.

Return ( PosA( ps_Json , ps_Campo ) > 0 )
end function

public function boolean of_divide_grupo_json_tag_vtex (ref string ps_texto, string ps_tag, ref string ps_primeiro_grupo, string ps_tag_fechamento);//Par$$HEX1$$e200$$ENDHEX$$metros:
//ps_texto - String na qual a tag ser$$HEX1$$e100$$ENDHEX$$ buscada
//ps_tag - tag que ser$$HEX1$$e100$$ENDHEX$$ buscada. Ex: "Cliente"
//ps_primeiro grupo - Retorna uma string com todo o conte$$HEX1$$fa00$$ENDHEX$$do dentro da tag , incluindo as subtags
// Retorna se encontrou conte$$HEX1$$fa00$$ENDHEX$$do na tag ou n$$HEX1$$e300$$ENDHEX$$o.
//ps_Tag_fechamento pode ser }, ] etc

Long ll_Pos, ll_Posicao_ini, ll_Posicao_fim, ll_Tamanho_tag, ll_tamanho_conteudo

String ls_mensagem, ls_Restante_Arquivo

ps_primeiro_grupo = ''

ps_tag = '"' + ps_tag + '"'
ll_Pos = Pos(ps_texto,ps_tag)
ll_Tamanho_tag = Len(ps_tag)

If ll_Pos > 0 Then
		
	ll_Posicao_ini =  ll_Pos + ll_Tamanho_tag
	ll_Posicao_fim = Pos(Mid(ps_texto, ll_Posicao_ini), ps_Tag_fechamento) + ll_Posicao_ini
	ll_tamanho_conteudo = ll_Posicao_fim - ll_Posicao_ini
	ps_primeiro_grupo = Mid(ps_texto, ll_Posicao_ini, ll_tamanho_conteudo)
End if

ps_texto = Mid(ps_texto, ll_Posicao_fim )

If ps_primeiro_grupo = '' Then
	Return False
End If

Return True

end function

public function string of_busca_conteudo_campo_vtex (string ps_json, string ps_campo);Long ll_Pos_De
Long ll_Pos_Ate

String ls_Valor

// Para localizar o nome completo do campo, exemplo: "vl_bc_icms". Sem essa condicao, caso encontrasse antes o vl_bc_icms_st, consideraria este ao inv$$HEX1$$e900$$ENDHEX$$s do procurado.
ps_Campo = gf_Replace( ps_Campo, '"', '', 0 )
ps_Campo = '"' + ps_Campo + '"'

If ps_Campo = '"dh_ultimo_acesso"' Then
	ps_Campo = ps_Campo
End If

// Localiza a letra inicial do campo
ll_Pos_De = Pos( ps_Json , ps_Campo, 1 )

if ll_pos_de = 0 then
	setnull(ls_valor)
	return ls_valor
end if

// Localiza o separador de campo/valor (:) e retorna a posi$$HEX2$$e700e300$$ENDHEX$$o do proximo caracter
ll_Pos_De = Pos( ps_Json, ':', ll_Pos_De + 1 ) + 1

// Quebra a string Json retirando o nome do campo de seu inicio
ps_Json = Trim( Mid( ps_Json, ll_Pos_De ) )

// Verifica se o valor do campo inicia com (") aspa dupla. Caso TRUE, o campo termina na ocorrencia de (",) aspa dupla seguida de virgula, caso FALSE, o campo termina na ocorrencia da (,) virgula
If Left( ps_Json, 1 ) = '"' Then
	
	// Remove a aspa dupla inicial para (") para n$$HEX1$$e300$$ENDHEX$$o causar problema na procura de teminador de valor (",) quando o valor come$$HEX1$$e700$$ENDHEX$$a com (,)
	ps_Json		= Mid( ps_Json, 2 )
	ll_Pos_Ate	= Pos( ps_Json, '",' )
Else
	ll_Pos_Ate = Pos( ps_Json, ',' )
End If

// Quando for o $$HEX1$$fa00$$ENDHEX$$ltimo valor, considera a posicao de termino o final da string Json
If ll_Pos_Ate < 1 Then
	ll_Pos_Ate = Len( ps_Json )
Else
	ll_Pos_Ate = ll_Pos_Ate - 1
End If

// Captura o valor entre o primeiro caracter e o da posicao do delimitador
ls_Valor	= Mid( ps_Json, 1, ll_Pos_Ate )

// Remove ENTER
ls_Valor	= gf_Replace( ls_Valor,char(13) + char(10),'',0 ) // ENTER

// Remove (") aspa dupla
ls_Valor = gf_Replace( ls_Valor,'"','',0 )

// Remove a chave de fechamento
ls_Valor = gf_Replace( ls_Valor,'}','',0 ) //Quando $$HEX1$$e900$$ENDHEX$$ o $$HEX1$$fa00$$ENDHEX$$ltimo campo do grupo n$$HEX1$$e300$$ENDHEX$$o tem ',' depois do campo, por isso vai at$$HEX1$$e900$$ENDHEX$$ a tag de fechamento '},'

// Remove o colchete de fechamento
ls_Valor	= gf_Replace( ls_Valor,']','',0 ) //Quando $$HEX1$$e900$$ENDHEX$$ o $$HEX1$$fa00$$ENDHEX$$ltimo campo do grupo n$$HEX1$$e300$$ENDHEX$$o tem ',' depois do campo, por isso vai at$$HEX1$$e900$$ENDHEX$$ a tag de fechamento '],'

// Remove espacos do inicio e do final
ls_Valor = Trim( ls_Valor )

if Upper(ls_valor) = 'NULL' or trim(ls_valor) = '' Then
	setnull(ls_valor)
end if

Return ls_Valor

end function

on uo_ge073_json.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge073_json.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

