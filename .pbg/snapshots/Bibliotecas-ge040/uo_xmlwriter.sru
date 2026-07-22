HA$PBExportHeader$uo_xmlwriter.sru
forward
global type uo_xmlwriter from nonvisualobject
end type
end forward

global type uo_xmlwriter from nonvisualobject
end type
global uo_xmlwriter uo_xmlwriter

type variables
Boolean ivb_Indent = False

Integer ivi_Arquivo // Ponteiro do arquivo XML

String ivs_Memoria // String que fica na mem$$HEX1$$f300$$ENDHEX$$ria at$$HEX1$$e900$$ENDHEX$$ que seja gravada no arquivo

String ivs_Elementos_Abertos[] // Armazena os elementos abertos para fechar posteriormente

String ivs_Enter = '' // String que armazena e grava quebra de linha caso ivb_Indent = True
String ivs_Tab	=  '' // String que armazena e grava tabula$$HEX2$$e700e300$$ENDHEX$$o caso ivb_Indent = True
end variables

forward prototypes
public function boolean of_open (string ps_arquivo)
public subroutine of_close ()
public function boolean of_start_document ()
public function boolean of_start_document (string ps_version, string ps_encoding)
public subroutine of_write_attribute (string ps_chave, string ps_valor)
public function boolean of_write_element (string ps_chave, string ps_valor)
public function boolean of_end_element ()
public function boolean of_end_document ()
public subroutine of_start_element (string ps_element)
public function boolean of_end_all_elements ()
public subroutine of_set_indent (boolean pb_indent)
private function boolean of_grava_memoria_pendente ()
private function boolean of_grava_registro (string ps_string)
private function string of_indent (long pl_tabs)
public subroutine _exemplo_de_uso ()
end prototypes

public function boolean of_open (string ps_arquivo);/* Abre um novo arquivo, ou substitui um existente
* ps_Arquivo: String contendo o caminho completo do arquivo XML */

Long ll_Pos

ll_Pos	=	Pos ( ps_Arquivo, '\' )

If ll_Pos = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deve ser informado o caminho completo do arquivo XML.", StopSign!)
	Return False
End If

ivi_Arquivo = FileOpen( ps_Arquivo, StreamMode!, Write!, Shared!, Replace! )

If ivi_Arquivo >= 0 Then Return True

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir o arquivo '" + ps_Arquivo + "'", StopSign!)
SetNull( ivi_Arquivo )

Return False
end function

public subroutine of_close ();/* Fecha todos os elementos abertos e fecha o arquivo */

Long ll_Nulo

This.of_End_All_Elements()

setNull( This.ivi_Arquivo )
setNull( This.ivs_Memoria )

FileClose( This.ivi_Arquivo )
end subroutine

public function boolean of_start_document ();/* Grava o in$$HEX1$$ed00$$ENDHEX$$cio do documento XML com padr$$HEX1$$e300$$ENDHEX$$o vers$$HEX1$$e300$$ENDHEX$$o 1.0 e encoding UTF-8 */

Return This.of_Start_Document( '1.0', 'UTF-8' )
end function

public function boolean of_start_document (string ps_version, string ps_encoding);/* Grava o in$$HEX1$$ed00$$ENDHEX$$cio do documento XML */

Return This.of_Grava_Registro( '<?xml version="' + ps_version + '" encoding="' + ps_encoding + '">' )
end function

public subroutine of_write_attribute (string ps_chave, string ps_valor);/* Atribui um atributo para o $$HEX1$$fa00$$ENDHEX$$ltimo elemento aberto */

ivs_Memoria += ' ' + ps_Chave + '="' + ps_valor + '"'
end subroutine

public function boolean of_write_element (string ps_chave, string ps_valor);/* Grava um elemento com valor no arquivo */

Boolean lb_Sucesso = True

lb_Sucesso = This.of_Grava_Memoria_Pendente()

If lb_Sucesso Then

	lb_Sucesso	=	This.of_Grava_registro( 	This.of_Indent( UpperBound( ivs_Elementos_Abertos ) ) + &
														'<' + ps_Chave + '>' + &
														ps_Valor	+ &
														'</' + ps_Chave + '>')

End If
													
Return lb_Sucesso
end function

public function boolean of_end_element ();/* Fecha o $$HEX1$$fa00$$ENDHEX$$ltimo elemento aberto */

Boolean lb_Sucesso = True

Long ll_Elementos
Long ll_Contador

String ls_Elemento
String ls_Array[]

lb_Sucesso = This.of_Grava_Memoria_Pendente()

If Not lb_Sucesso Then Return False

ll_Elementos = UpperBound( ivs_Elementos_Abertos	)

If ll_Elementos = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nenhum elemento aberto no XML para fechar. { of_end_element() }", StopSign!)
	Return False
End If

ls_Elemento = ivs_Elementos_Abertos[ ll_Elementos ]
lb_Sucesso = This.of_Grava_Registro( This.of_Indent( UpperBound( ivs_Elementos_Abertos ) -1 ) + &
												  '</' + ls_Elemento + '>' )


// Exclui a $$HEX1$$fa00$$ENDHEX$$ltima chave e seu respectivo valor do array ivs_Elementos_Abertos
If lb_Sucesso Then
	If ll_Elementos > 1 Then
		For ll_Contador = 1 To ll_Elementos -1
			ls_Array[ll_Contador] = ivs_Elementos_Abertos[ ll_Contador ]			
		Next
	End If
	
	ivs_Elementos_Abertos = ls_Array
End If
//

Return lb_Sucesso
end function

public function boolean of_end_document ();/* Fecha todos os elementos abertos */

Return This.of_End_All_Elements()
end function

public subroutine of_start_element (string ps_element);/* Inicia um elemento, deixando-o numa vari$$HEX1$$e100$$ENDHEX$$vel de inst$$HEX1$$e200$$ENDHEX$$ncia para grava$$HEX2$$e700e300$$ENDHEX$$o posterior
* a grava$$HEX2$$e700e300$$ENDHEX$$o no arquivo $$HEX1$$e900$$ENDHEX$$ feita quando $$HEX1$$e900$$ENDHEX$$ iniciado novo elemento ou fechado algum */

Long ll_Elementos

This.of_Grava_Memoria_Pendente()

ll_Elementos = UpperBound( ivs_Elementos_Abertos	)
ll_Elementos++

ivs_Elementos_Abertos[ ll_Elementos ] = ps_Element

This.ivs_Memoria = ps_Element
end subroutine

public function boolean of_end_all_elements ();/* Fecha todos os elementos abertos */

Boolean lb_Sucesso = True

Long ll_Elementos
Long ll_Contador

ll_Elementos = UpperBound( This.ivs_Elementos_Abertos )

If ll_Elementos = 0 Then
	Return True
End If

For ll_Contador = 1 To ll_Elementos
	lb_Sucesso = This.of_End_Element()
	
	If Not lb_Sucesso Then
		Exit
	End If
Next

Return lb_Sucesso
end function

public subroutine of_set_indent (boolean pb_indent);/* Configura as tabula$$HEX2$$e700f500$$ENDHEX$$es e quebras de linha do XML
* o padr$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ sem tabula$$HEX2$$e700e300$$ENDHEX$$o e sem quebra de linha */

This.ivb_Indent = pb_Indent

If pb_Indent Then
	ivs_Enter = Char(13) + Char(10)
	ivs_Tab	= Char(9)
Else
	ivs_Enter = ''
	ivs_Tab	= ''
End If
end subroutine

private function boolean of_grava_memoria_pendente ();/* Grava o $$HEX1$$fa00$$ENDHEX$$ltimo elemento aberto */

Boolean lb_Sucesso = True

If Not IsNull( ivs_Memoria ) Then
	lb_Sucesso = This.of_Grava_Registro( This.of_Indent( UpperBound( ivs_Elementos_Abertos ) -1) + &
													  '<' + ivs_Memoria + '>' )
End If

If lb_Sucesso Then
	setNull( ivs_Memoria )
End If

Return lb_Sucesso
end function

private function boolean of_grava_registro (string ps_string);/* Grava a string passada como argumento no arquivo aberto */

Integer lvi_Status

ps_String =  + ps_String + ivs_Enter
		  
lvi_Status = FileWrite( ivi_Arquivo, ps_String )

If lvi_Status <> LenA( ps_String ) Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro '" + ps_String + "' no arquivo XML.", StopSign!)
	Return False
End If

Return True
end function

private function string of_indent (long pl_tabs);/* Retorna a quantidade de TABs que ser$$HEX1$$e300$$ENDHEX$$o gravados, de acordo com a Indenta$$HEX2$$e700e300$$ENDHEX$$o */

Long ll_Contador

String ls_Retorno = ''

If pl_Tabs < 1 Then Return ''

For ll_Contador = 1 To pl_Tabs
	ls_Retorno += ivs_Tab
Next

Return ls_Retorno
end function

public subroutine _exemplo_de_uso ();uo_XmlWriter lo_Xml
lo_Xml = Create uo_XmlWriter
lo_Xml.of_Set_Indent( True ) // Se quiser que o arquivo fique formatado com tabula$$HEX2$$e700f500$$ENDHEX$$es e quebras de linha

lo_Xml.of_Open( 'c:\sistemas\teste.XML' )
lo_Xml.of_Start_Document() // Opcionalmente, podem ser passados os par$$HEX1$$e200$$ENDHEX$$metros version e encoding
									 // Ex: lo_Xml.of_Start_Document('1.0', "UTF-8")
lo_Xml.of_Start_Element( "filmes" )
lo_Xml.of_Write_Attribute( "ano", "2012" )

lo_Xml.of_Start_Element( "comedia" )
lo_Xml.of_Write_Element( "titulo", "007 contra Godzila" )
lo_Xml.of_Write_Element( "titulo", "O ataque dos bichos preguicas" )
lo_Xml.of_End_Element()

lo_Xml.of_Start_Element( "drama" )
lo_Xml.of_Write_Element( "titulo", "Dia de pagamento" )
lo_Xml.of_Write_Element( "titulo", "Quando toca o despertador" )
lo_Xml.of_End_Element()

Destroy lo_Xml

/* XML gerado
<?xml version="1.0" encoding="UTF-8">  // lo_Xml.of_Start_Document()
<filmes ano="2012"> 						  // lo_Xml.of_Start_Element( "filmes" ) + lo_Xml.of_Write_Attribute( "ano", "2012" )
	<comedia> 									  // lo_Xml.of_Start_Element( "comedia" )
		<titulo>007 contra Godzila</titulo> // lo_Xml.of_Write_Element( "titulo", "007 contra Godzila" )
		<titulo>O ataque dos bichos preguicas</titulo>
	</comedia>									  // lo_Xml.of_End_Element()
	<drama>
		<titulo>Dia de pagamento</titulo>
		<titulo>Quando toca o despertador</titulo>
	</drama>
</filmes> 										 // Destroy lo_Xml
*/
end subroutine

on uo_xmlwriter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_xmlwriter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;This.of_Close()
end event

event constructor;setNull( ivs_Memoria )
end event

