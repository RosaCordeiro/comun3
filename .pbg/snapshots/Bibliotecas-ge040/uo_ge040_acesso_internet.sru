HA$PBExportHeader$uo_ge040_acesso_internet.sru
forward
global type uo_ge040_acesso_internet from nonvisualobject
end type
end forward

global type uo_ge040_acesso_internet from nonvisualobject
end type
global uo_ge040_acesso_internet uo_ge040_acesso_internet

type prototypes
// Declara$$HEX2$$e700e300$$ENDHEX$$o de fun$$HEX2$$e700f500$$ENDHEX$$es externas da API do Windows 
FUNCTION long    InternetOpenA      (string lpszAgent,        long   dwAccessType, string lpszProxy,   string lpszProxyBypass, long dwFlags)                 LIBRARY "wininet.dll" ALIAS FOR "InternetOpenA;Ansi"
FUNCTION long    InternetOpenUrlA   (long   hInternetSession, string lpszUrl,      string lpszHeaders, long   dwHeadersLength, long dwFlags, long dwContext) LIBRARY "wininet.dll" ALIAS FOR "InternetOpenUrlA;Ansi"
FUNCTION boolean InternetCloseHandle(long   hInternet)                                                                                                       LIBRARY "wininet.dll" ALIAS FOR "InternetCloseHandle"
end prototypes

forward prototypes
public function boolean of_testa_conexao (ref string as_erro)
end prototypes

public function boolean of_testa_conexao (ref string as_erro);Boolean	lb_Sucesso = False
Long		li_internet_session, li_internet_file
String	ls_url_teste


// Abre uma sess$$HEX1$$e300$$ENDHEX$$o de internet
li_internet_session = InternetOpenA ('PowerBuilder', 1, '', '', 0)

// Verifica se a sess$$HEX1$$e300$$ENDHEX$$o de internet foi aberta com sucesso
If li_internet_session = 0 then
	as_erro = 'Falha de conex$$HEX1$$e300$$ENDHEX$$o com a internet, favor tentar novamente em instantes'
	Return lb_Sucesso
End if

// Abre uma URL para verifica$$HEX2$$e700e300$$ENDHEX$$o de conex$$HEX1$$e300$$ENDHEX$$o
ls_url_teste	= 'http://www.google.com'
li_internet_file = InternetOpenUrlA (li_internet_session, ls_url_teste, '', 0, 0, 0)

If li_internet_file = 0 then
	ls_url_teste	= 'https://www.clamed.com.br'
	li_internet_file = InternetOpenUrlA (li_internet_session, ls_url_teste, '', 0, 0, 0)
end if

// Verifica se a URL foi aberta com sucesso
If li_internet_file = 0 then
	as_erro = 'Falha ao abrir uma URL para teste da conex$$HEX1$$e300$$ENDHEX$$o.~r~r' + 'URL Teste: ' + ls_url_teste
else
	as_erro = ''
	// Fecha o identificador de arquivo da internet
	InternetCloseHandle (li_internet_file)
	lb_Sucesso = True
End if

// Fecha a sess$$HEX1$$e300$$ENDHEX$$o de internet
InternetCloseHandle (li_internet_session)

Return lb_Sucesso
end function

on uo_ge040_acesso_internet.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge040_acesso_internet.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

