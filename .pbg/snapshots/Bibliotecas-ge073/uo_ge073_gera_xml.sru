HA$PBExportHeader$uo_ge073_gera_xml.sru
$PBExportComments$Objeto para gerar arquivo xml
forward
global type uo_ge073_gera_xml from nonvisualobject
end type
end forward

global type uo_ge073_gera_xml from nonvisualobject
end type
global uo_ge073_gera_xml uo_ge073_gera_xml

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
public subroutine of_acao_erro (string ps_mensagem)
public function string of_identa (string ps_registro, long pl_tabulacao)
public function boolean of_fecha_arquivo ()
public function boolean of_abre_arquivo (string ps_arquivo)
public function boolean of_grava_arquivo (string ps_registro)
public function boolean of_abre_tag (string ps_tag, long pl_identacao)
public function boolean of_elemento (string ps_tag, string ps_string, long pl_identacao)
public function boolean of_fecha_tag (string ps_tag, long pl_identacao)
public subroutine of_set_identa (boolean pb_identa)
public function string of_abre_tag (string ps_tag, long pl_identacao, boolean pb_grava_arquivo)
public function string of_elemento (string ps_tag, string ps_string, long pl_identacao, boolean pb_grava_arquivo)
public function string of_fecha_tag (string ps_tag, long pl_identacao, boolean pb_grava_arquivo)
public function string of_busca_conteudo_tag (string ps_texto, string ps_tag)
public function boolean of_divide_grupo_tag (ref string ps_texto, string ps_tag, ref string ps_primeiro_grupo)
public function string of_substitui_caracteres (string ps_texto)
end prototypes

public subroutine of_acao_erro (string ps_mensagem);/* ps_Acao_Erro: 
* M = Mensagem
* E = Email
* L = Log
*/

Choose Case ivs_Acao_Erro
	Case 'M'
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', ps_Mensagem )
		
	Case 'L'
		//Grava Log
		
	Case 'E'
		// Envia email
End Choose

end subroutine

public function string of_identa (string ps_registro, long pl_tabulacao);Long lvl_Linha

For lvl_Linha = 1 To pl_Tabulacao
	ps_Registro = ivs_Tab + ps_Registro
Next

Return ps_Registro
end function

public function boolean of_fecha_arquivo ();Integer li_Close

li_Close = FileClose( ivi_Arquivo_Xml )

If li_Close = -1 Then
	
	This.of_Acao_Erro( 'Erro ao tentar fechar o arquivo ' + ivs_Arquivo_Xml )
	
	Return False
End If

Return True
end function

public function boolean of_abre_arquivo (string ps_arquivo);This.ivs_Arquivo_Xml = ps_Arquivo

If IsNull( ivs_Arquivo_Xml ) Or Trim( ivs_Arquivo_Xml ) = '' Then
	This.of_Acao_Erro( 'N$$HEX1$$e300$$ENDHEX$$o foi definido o arquivo XML a ser gerado.' )
	Return False
End If

ivi_Arquivo_Xml  = FileOpen(ivs_Arquivo_Xml , TextMode!, Write!, LockReadWrite!, Replace! )

If ivi_Arquivo_Xml = -1 Then
	
	This.of_Acao_Erro( 'Erro ao tentar abrir o arquivo ' + ivs_Arquivo_Xml )
	
	Return False
End If

Return True
end function

public function boolean of_grava_arquivo (string ps_registro);Integer lvi_write

lvi_Write = FileWriteEx( ivi_Arquivo_Xml, ps_Registro )

If lvi_Write < 0 Then
	This.of_Acao_Erro( "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar registro no arquivo '" + ivs_Arquivo_Xml + "'" )
	Return False
End If

Return True
end function

public function boolean of_abre_tag (string ps_tag, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + ">", pl_Identacao) + ivs_Enter

Return This.of_Grava_Arquivo( lvs_Retorno )

end function

public function boolean of_elemento (string ps_tag, string ps_string, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + ">" + ps_String + "</" + ps_Tag + ">", pl_identacao) + ivs_Enter

Return This.of_Grava_Arquivo( lvs_Retorno )
end function

public function boolean of_fecha_tag (string ps_tag, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("</" + ps_Tag + ">", pl_identacao) + ivs_Enter

Return This.of_Grava_Arquivo( lvs_Retorno )
end function

public subroutine of_set_identa (boolean pb_identa);If pb_Identa Then
	ivs_Enter = Char(13) + Char(10)
	ivs_Tab	= Char(9)
Else
	ivs_Enter = ''
	ivs_Tab	= ''
End If
end subroutine

public function string of_abre_tag (string ps_tag, long pl_identacao, boolean pb_grava_arquivo);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + ">", pl_Identacao) + ivs_Enter

//if pb_grava_arquivo then
//	This.of_Grava_Arquivo( lvs_Retorno )
//end if

Return lvs_Retorno

end function

public function string of_elemento (string ps_tag, string ps_string, long pl_identacao, boolean pb_grava_arquivo);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + ">" + ps_String + "</" + ps_Tag + ">", pl_identacao) + ivs_Enter

//Return This.of_Grava_Arquivo( lvs_Retorno )

Return lvs_Retorno
end function

public function string of_fecha_tag (string ps_tag, long pl_identacao, boolean pb_grava_arquivo);String lvs_Retorno

lvs_Retorno = This.of_Identa("</" + ps_Tag + ">", pl_identacao) + ivs_Enter

//Return This.of_Grava_Arquivo( lvs_Retorno )

Return lvs_Retorno
end function

public function string of_busca_conteudo_tag (string ps_texto, string ps_tag);//ps_texto -  String na qual a tag ser$$HEX1$$e100$$ENDHEX$$ buscada
//ps_tag - tag que ser$$HEX1$$e100$$ENDHEX$$ buscada. Ex: erro
//Retorna conte$$HEX1$$fa00$$ENDHEX$$do entre a tag. Ex: <erro>Conte$$HEX1$$fa00$$ENDHEX$$do</erro>

Long ll_Pos, ll_Posicao_ini, ll_Posicao_fim, ll_Tamanho_tag, ll_tamanho_conteudo

String ls_Conteudo, ls_Tag_fechamento, ls_mensagem

ls_Conteudo = ''
ps_tag = '<' + ps_tag + '>'
ll_Pos = Pos(ps_texto,ps_tag)
ll_Tamanho_tag = Len(ps_tag)

If ll_Pos > 0 Then
	ls_Tag_fechamento = '</' + Mid(ps_tag, 2,ll_Tamanho_tag)
	
	ll_Posicao_ini =  ll_Pos + ll_Tamanho_tag
	ll_Posicao_fim = Pos(ps_texto, ls_Tag_fechamento)
	ll_tamanho_conteudo = ll_Posicao_fim - ll_Posicao_ini
	ls_Conteudo = Mid(ps_texto, ll_Posicao_ini, ll_tamanho_conteudo)
End if

Return ls_Conteudo
end function

public function boolean of_divide_grupo_tag (ref string ps_texto, string ps_tag, ref string ps_primeiro_grupo);//Par$$HEX1$$e200$$ENDHEX$$metros:
//ps_texto - String na qual a tag ser$$HEX1$$e100$$ENDHEX$$ buscada
//ps_texto - Retorna o que sobrou no arquivo, abaixo do fechamento da tag pesquisada
//ps_tag - tag que ser$$HEX1$$e100$$ENDHEX$$ buscada. Ex: <erro>
//ps_primeiro grupo - Retorna uma string com todo o conte$$HEX1$$fa00$$ENDHEX$$do dentro da tag pesquisada, incluindo as subtags
// Retorna se encontrou conte$$HEX1$$fa00$$ENDHEX$$do na tag ou n$$HEX1$$e300$$ENDHEX$$o.

Long ll_Pos, ll_Posicao_ini, ll_Posicao_fim, ll_Tamanho_tag, ll_tamanho_conteudo

String ls_Tag_fechamento, ls_mensagem, ls_Restante_Arquivo

ps_primeiro_grupo = ''
ps_tag = '<' + ps_tag + '>'
ll_Pos = Pos(ps_texto,ps_tag)
ll_Tamanho_tag = Len(ps_tag)

If ll_Pos > 0 Then
	ls_Tag_fechamento = '</' + Mid(ps_tag, 2,ll_Tamanho_tag)
		
	ll_Posicao_ini =  ll_Pos + ll_Tamanho_tag
	ll_Posicao_fim = Pos(ps_texto, ls_Tag_fechamento)
	ll_tamanho_conteudo = ll_Posicao_fim - ll_Posicao_ini
	ps_primeiro_grupo = Mid(ps_texto, ll_Posicao_ini, ll_tamanho_conteudo)
End if

//Tag fechamento come$$HEX1$$e700$$ENDHEX$$a na posi$$HEX2$$e700e300$$ENDHEX$$o fim, + tamanho da tag + 1 = caracter ap$$HEX1$$f300$$ENDHEX$$s >
ps_texto = Mid(ps_texto, ll_Posicao_fim + ll_Tamanho_tag + 1)

If ps_primeiro_grupo = '' Then
	Return False
End If

Return True


end function

public function string of_substitui_caracteres (string ps_texto);

// Substitui & comercial
ps_texto = gf_replace(ps_texto, '&' , '$amp;' ,0)
ps_texto = gf_replace(ps_texto, '$amp;' , '&amp;' ,0)

// Substitui aspas simples
ps_texto = gf_replace(ps_texto, "'" , ' &apos;' ,0)

// Substitui aspas duplas
ps_texto = gf_replace(ps_texto, '"', '&quot;' ,0)

// Substitui menor que
ps_texto = gf_replace(ps_texto, '<', '&lt;' ,0)

// Substitui maior que
ps_texto = gf_replace(ps_texto, '>', '%&gt;' ,0)

Return ps_texto 
end function

on uo_ge073_gera_xml.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge073_gera_xml.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

