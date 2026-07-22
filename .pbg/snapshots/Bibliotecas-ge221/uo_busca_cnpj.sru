HA$PBExportHeader$uo_busca_cnpj.sru
forward
global type uo_busca_cnpj from uo_web_browser
end type
end forward

global type uo_busca_cnpj from uo_web_browser
end type
global uo_busca_cnpj uo_busca_cnpj

type variables
uo_pessoa_juridica ivo_pj

Boolean Localizado = False
Boolean Capturado = True
end variables

forward prototypes
private function string of_getvalue (string ps_html, string ps_campo)
private function string of_getstringafter (string ps_string, string ps_campo)
private subroutine of_limpavalores ()
public subroutine of_setdados ()
public function boolean of_buscadados ()
public function string of_replace (string ps_assunto, string ps_pesquisa, string ps_substitui)
end prototypes

private function string of_getvalue (string ps_html, string ps_campo);//Retorna o valor de um dado da p$$HEX1$$e100$$ENDHEX$$gina da receita conforme layout HTML
String ls_Temp

ls_Temp = Mid(ps_Html,Pos(Upper(ps_Html),ps_Campo)+Len(ps_Campo)+1,Len(ps_Html)-(Pos(Upper(ps_Html),ps_Campo)+(Len(ps_Campo)+1)));
ls_Temp = Mid(ls_Temp,Pos(Upper(ls_Temp),'<B>')+3,Pos(Upper(ls_Temp),'</B>')-(Pos(Upper(ls_Temp),'<B>')+3));

//Retorna o valor
Return ls_Temp;
end function

private function string of_getstringafter (string ps_string, string ps_campo);//Captura uma string ap$$HEX1$$f300$$ENDHEX$$s uma outra string
String ls_Temp

ls_Temp = Mid(ps_String,Pos(Upper(ps_String),ps_Campo)+Len(ps_Campo)+1,Len(ps_String)-(Pos(ps_String,ps_Campo)+(Len(ps_Campo)+1)));

//Retorna o valor posterior a string passada como par$$HEX1$$e300$$ENDHEX$$metro
Return ls_Temp;
end function

private subroutine of_limpavalores ();//Limpa as vari$$HEX1$$e100$$ENDHEX$$veis
ivo_pj.of_Clear()
Localizado = False
Capturado = True
end subroutine

public subroutine of_setdados ();//Atribui os dados encontrados para as vari$$HEX1$$e100$$ENDHEX$$veis
String lvs_Doc
String lvs_Temp

Long 	lvl_Pos

//Captura o Inner HTML Source da p$$HEX1$$e100$$ENDHEX$$gina para localizar os valores
lvs_Doc = 	This.InnerHTML

//Localiza os valores
ivo_pj.Razao_Social	= Trim(of_GetValue(lvs_Doc,'NOME EMPRESARIAL'))	
ivo_pj.Fantasia 		= Trim(of_GetValue(lvs_Doc,'T$$HEX1$$cd00$$ENDHEX$$TULO DO ESTABELECIMENTO (NOME DE FANTASIA)'))
ivo_pj.Rua				= Trim(of_GetValue(lvs_Doc,'LOGRADOURO'))
lvs_Temp				= Trim(of_getstringafter(lvs_Doc,'LOGRADOURO'))
ivo_pj.Nro				= Trim(of_GetValue(lvs_Temp,'N$$HEX1$$da00$$ENDHEX$$MERO'))
ivo_pj.Compl			= Trim(of_GetValue(lvs_Doc,'COMPLEMENTO'))
ivo_pj.CEP				= Trim(of_replace(of_replace(of_GetValue(lvs_Doc,'CEP'),'.',''),'-',''))
ivo_pj.Bairro			= Trim(of_GetValue(lvs_Doc,'BAIRRO/DISTRITO'))
ivo_pj.Cidade			= Trim(of_GetValue(lvs_Doc,'MUNIC$$HEX1$$cd00$$ENDHEX$$PIO'))
ivo_pj.UF					= Trim(of_GetValue(lvs_Doc,'UF'))
This.Localizado = True
This.Localizado = False
end subroutine

public function boolean of_buscadados ();//Busca os dados de CNPJ da Receita

//Seta vari$$HEX1$$e100$$ENDHEX$$veis como false para posterior verifica$$HEX2$$e700e300$$ENDHEX$$o
Localizado = False
Capturado = False

//Navega para a URL e preenche com o CNPJ informado no par$$HEX1$$e200$$ENDHEX$$metro
This.of_navigate('http://servicos.receita.fazenda.gov.br/Servicos/cnpjreva/Cnpjreva_Solicitacao_CS.asp?cnpj='+ivo_pj.CNPJ)

//Retorna se o cadastro foi encontrado ou n$$HEX1$$e300$$ENDHEX$$o
Return Localizado
end function

public function string of_replace (string ps_assunto, string ps_pesquisa, string ps_substitui);Long lvl_Pos
Long lvl_Len

lvl_Pos = PosA(ps_Assunto, ps_Pesquisa)
lvl_Len = LenA(ps_Pesquisa)

Do While lvl_Pos > 0
	ps_Assunto = ReplaceA(ps_Assunto, lvl_Pos, lvl_Len, ps_Substitui)	
	lvl_Pos = PosA(ps_Assunto, ps_Pesquisa)
Loop

Return ps_Assunto
end function

on uo_busca_cnpj.create
call super::create
end on

on uo_busca_cnpj.destroy
call super::destroy
end on

event documentcomplete;call super::documentcomplete;//Limpa os valores
This.of_LimpaValores()
//Verifica se a p$$HEX1$$e100$$ENDHEX$$gina ap$$HEX1$$f300$$ENDHEX$$s t$$HEX1$$e900$$ENDHEX$$rmino do carregamento e a p$$HEX1$$e100$$ENDHEX$$gina de dados da receita
If (This.of_geturl( ) = 'http://servicos.receita.fazenda.gov.br/Servicos/cnpjreva/Cnpjreva_Comprovante.asp') Then
      //Seta os dados as vari$$HEX1$$e100$$ENDHEX$$veis
		of_SetDados()
End If
end event

