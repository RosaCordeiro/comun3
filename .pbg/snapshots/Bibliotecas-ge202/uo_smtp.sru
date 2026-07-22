HA$PBExportHeader$uo_smtp.sru
forward
global type uo_smtp from n_winsock
end type
type uuid from structure within uo_smtp
end type
type systemtime from structure within uo_smtp
end type
type time_zone_information from structure within uo_smtp
end type
end forward

type uuid from structure
	unsignedlong		data1
	integer		data2
	integer		data3
	blob		data4
end type

type systemtime from structure
	integer		wyear
	integer		wmonth
	integer		wdayofweek
	integer		wday
	integer		whour
	integer		wminute
	integer		wsecond
	integer		wmilliseconds
end type

type time_zone_information from structure
	long		bias
	character		standardname[32]
	systemtime		standarddate
	long		standardbias
	character		daylightname[32]
	systemtime		daylightdate
	long		daylightbias
end type

global type uo_smtp from n_winsock
end type
global uo_smtp uo_smtp

type prototypes
Function ulong CreateFile ( &
	string lpFileName, &
	ulong dwDesiredAccess, &
	ulong dwShareMode, &
	ulong lpSecurityAttributes, &
	ulong dwCreationDisposition, &
	ulong dwFlagsAndAttributes, &
	ulong hTemplateFile &
	) Library "kernel32.dll" Alias For "CreateFileW"

Function boolean CloseHandle ( &
	ulong hObject &
	) Library "kernel32.dll"

Function boolean ReadFile ( &
	ulong hFile, &
	Ref blob lpBuffer, &
	ulong nNumberOfBytesToRead, &
	Ref ulong lpNumberOfBytesRead, &
	ulong lpOverlapped &
	) Library "kernel32.dll"

Function long UuidCreate ( &
	Ref UUID pId &
	) Library "rpcrt4.dll"

Function long UuidToString ( &
	Ref UUID Uuid, &
	Ref ulong StringUuid &
	) Library "rpcrt4.dll" Alias For "UuidToStringW"

Function long RpcStringFree ( &
	Ref ulong pString &
	) Library "rpcrt4.dll" Alias For "RpcStringFreeW"

Subroutine CopyMemory ( &
	Ref string Destination, &
	ulong Source, &
	long Length &
	) Library  "kernel32.dll" Alias For "RtlMoveMemory"

Function ulong FindMimeFromData ( &
	ulong pBC, &
	string pwzUrl, &
	blob pBuffer, &
	ulong cbSize, &
	ulong pwzMimeProposed, &
	ulong dwMimeFlags, &
	ref ulong ppwzMimeOut, &
	ulong dwReserved &
	) Library "urlmon.dll"

Function long SendStringMessage ( &
	long hWnd, &
	uint Msg, &
	Ref string wParam, &
	long lParam &
	) Library "user32.dll" Alias For "SendMessageW"

Function Long GetTimeZoneInformation ( &
	Ref TIME_ZONE_INFORMATION lpTimeZoneInformation &
	) Library "kernel32.dll"


FUNCTION int GetModuleFileNameA(ulong hinstModule, REF string lpszPath, ulong cchPath) LIBRARY "kernel32"  alias for "GetModuleFileNameA;Ansi"
end prototypes

type variables
Private:

Constant	String CRLF = Char(13) + Char(10)

Boolean ib_html
Boolean ib_receipt
Boolean ib_authenticate = True
Boolean ib_logfile

Integer ii_port = 587

String is_server = '172.19.2.100'
//String is_server = '10.0.0.15'
//String is_server = '10.0.4.25'

String is_filelog

String is_userid = "envio@companhialatinoamericana.com.br"
String is_passwd = "qK#tH10sUX$5"
String is_subject
String is_body
String is_FromEmail
String is_FromName
String is_ToEmail[]
String is_ToName[]
String is_CcEmail[]
String is_CcName[]
String is_BccEmail[]
String is_BccName[]
String is_AttachFile[]
Public String is_LastError


Uint iui_socket

public Boolean ib_grava_log_db = True

end variables

forward prototypes
public subroutine of_setport (integer ai_port)
public subroutine of_setserver (string as_server)
public subroutine of_setsubject (string as_subject)
public subroutine of_setfrom (string as_email, string as_name)
public function integer of_addcc (string as_email)
public function integer of_addto (string as_email)
public function boolean of_sendmail ()
public function integer of_addfile (string as_filename)
public subroutine of_reset ()
public subroutine of_setlogin (string as_userid, string as_passwd)
private function boolean of_auth ()
private function boolean of_sendmsg (string as_cmd)
public subroutine of_setbody (string as_body, boolean ab_html)
public subroutine of_setreceipt (boolean ab_receipt)
public subroutine of_setfrom (string as_email)
public function integer of_addto (string as_email, string as_name)
public function integer of_addcc (string as_email, string as_name)
public function integer of_addbcc (string as_email)
public function integer of_addbcc (string as_email, string as_name)
private function string of_encode64 (string as_data)
private function string of_generate_guid ()
private function string of_data ()
private function string of_findmimefromdata (string as_filename, ref blob ablob_filedata)
private function boolean of_readfile (string as_filename, ref blob ablob_data)
public function boolean of_sendmail_start ()
public function boolean of_sendmail_stop ()
public function boolean of_sendmail_msg ()
public subroutine of_setlogfile (boolean ab_logfile)
public subroutine of_logmsg (string as_msgtext)
public subroutine of_deletelogfile ()
public function string of_timezoneoffset ()
public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace)
private subroutine of_grava_log_db ()
public function string of_getserver ()
public function boolean of_retorna_emails (string ps_email, ref string ps_array_email[])
public function boolean of_email_interno (string ps_email)
public function boolean of_envia_email (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[], string ps_copia[], string ps_copia_oculta[], string ps_anexo[], boolean pb_contem_anexo)
public function boolean of_envia_email (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[], string ps_copia[], string ps_copia_oculta[])
public function boolean of_envia_email (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[], string ps_copia[])
public function boolean of_envia_email (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[])
public function boolean of_envia_email_anexo (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[], string ps_copia[], string ps_anexo[])
public function boolean of_envia_email_anexo (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[], string ps_copia[], string ps_copia_oculta[], string ps_anexo[])
public subroutine of_setfilelog (string ps_filelog)
public function string of_getfilelog ()
public function string of_getapplicationpath ()
end prototypes

public subroutine of_setport (integer ai_port);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetPort
//
// PURPOSE:    This function is used to set the port the server is using.
//					The default is 25 and usually does not need to change.
//
// ARGUMENTS:  ai_port - Server port
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

ii_port = ai_port

end subroutine

public subroutine of_setserver (string as_server);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetServer
//
// PURPOSE:    This function is used to set the server name
//
// ARGUMENTS:  as_server - Server name
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_server = as_server

end subroutine

public subroutine of_setsubject (string as_subject);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetSubject
//
// PURPOSE:    This function is used to set the message subject.
//
// ARGUMENTS:  as_subject - Subject
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_subject = as_subject

end subroutine

public subroutine of_setfrom (string as_email, string as_name);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetFrom
//
// PURPOSE:    This function is used to set the sender's
//					email address and name.
//
// ARGUMENTS:  as_email - Sender's Email address
//					as_name	- Sender's Name
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_FromEmail = as_email
is_FromName = as_name

end subroutine

public function integer of_addcc (string as_email);Return This.Of_Addcc(as_email, "")

end function

public function integer of_addto (string as_email);Return This.Of_AddTo(as_email, "")

end function

public function boolean of_sendmail ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SendMail
//
// PURPOSE:    This function is the main process to send the email.
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

If Not of_SendMail_Start() Then
	Return False
End If

If Not of_SendMail_Msg() Then
	Return False
End If

If Not of_SendMail_Stop() Then
	Return False
End If

Return True

end function

public function integer of_addfile (string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddFile
//
// PURPOSE:    This function is used to add an attachment.
//
// ARGUMENTS:  as_filename - Filename
//
// RETURN:     Index to attachment array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_next

li_next = UpperBound(is_AttachFile) + 1

is_AttachFile[li_next] = as_filename

Return li_next

end function

public subroutine of_reset ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Reset
//
// PURPOSE:    This function is used to reset all the arrays.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_empty[]

is_ToEmail = ls_empty
is_ToName = ls_empty
is_CcEmail = ls_empty
is_CcName = ls_empty
is_BccEmail = ls_empty
is_BccName = ls_empty
is_AttachFile = ls_empty

end subroutine

public subroutine of_setlogin (string as_userid, string as_passwd);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetLogin
//
// PURPOSE:    This function is used to set the userid and password when the
//					SMTP server requires authentication.
//
// ARGUMENTS:  as_userid - Server userid
//					as_passwd - Server password
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_userid = as_userid
is_passwd = as_passwd
ib_authenticate = True

end subroutine

private function boolean of_auth ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Auth
//
// PURPOSE:    This function is used to send Userid/Password to SMTP server.
//					It is called by of_SendMail when of_SetLogin has been called.
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant	Integer REPLY_OK = 250
Constant	Integer REPLY_AUTH = 334
Constant	Integer REPLY_AUTHOK = 235
String ls_msg, ls_reply, ls_userid, ls_passwd
Integer li_rc, li_response

// encode userid/password in Base-64
ls_userid = of_Encode64(is_userid)
ls_passwd = of_Encode64(is_passwd)

// start conversation with server
ls_msg = "EHLO " + of_GetHostName() + CRLF
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
	this.of_LogError(iERROR, "Command Failed: " + ls_msg)
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)
li_response = Integer(Left(ls_reply,3))
If li_response <> REPLY_OK Then
	this.of_LogError(iERROR, "Command Failed: " + &
		ls_msg + "~r~n" + ls_reply)
	Return False
End If

// request login
ls_msg = "AUTH LOGIN" + CRLF
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
	this.of_LogError(iERROR, "Command Failed: " + ls_msg)
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)
li_response = Integer(Left(ls_reply,3))
If li_response <> REPLY_AUTH Then
	this.of_LogError(iERROR, "Command Failed: " + &
		ls_msg + "~r~n" + ls_reply)
	Return False
End If

// return userid
ls_msg = ls_userid
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
	this.of_LogError(iERROR, "Command Failed: " + ls_msg)
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)
li_response = Integer(Left(ls_reply,3))
If li_response <> REPLY_AUTH Then
	this.of_LogError(iERROR, "Command Failed: " + &
		ls_msg + "~r~n" + ls_reply)
	Return False
End If

// return password
ls_msg = ls_passwd
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
	this.of_LogError(iERROR, "Command Failed: " + ls_msg)
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)
li_response = Integer(Left(ls_reply,3))
If li_response <> REPLY_AUTHOK Then
	this.of_LogError(iERROR, "Command Failed: " + &
		ls_msg + "~r~n" + ls_reply)
	Return False
End If

Return True

end function

private function boolean of_sendmsg (string as_cmd);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SendMsg
//
// PURPOSE:    This function is used by other functions to send a message and
//					receive any reply.
//
// ARGUMENTS:  as_cmd - SMTP command to be sent
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// 11/18/2008	RolandS		Added logging
// -----------------------------------------------------------------------------

Constant	Integer REPLY_READY = 220
Constant	Integer REPLY_OK = 250
Constant	Integer REPLY_START = 354
String ls_reply, ls_command
Integer li_rc
Long ll_totbytes, ll_length

ll_length = Len(as_cmd)

do while ll_totbytes < ll_length
	// grab a piece of data
	ls_command = Mid(as_cmd, ll_totbytes + 1, MAX_SEND_BUFFER)
	ll_totbytes += Len(ls_command)
	// send the piece of data
	li_rc = of_Send(iui_socket, ls_command)
	If li_rc < 1 Then Return False
loop

// receive response
of_Recv(iui_socket, ls_reply)

// record to logfile if option is turned on
of_Logmsg(ls_command)
of_Logmsg(ls_reply)

// check for errors
choose case Integer(Left(ls_reply, 3))
	case REPLY_OK, REPLY_READY, REPLY_START
		Return True
	case else
		this.of_LogError(iERROR, &
					"Server Error:~r~n~r~n" + ls_reply + "~r~n" + &
					"Command:~r~n~r~n" + Left(as_cmd, 300))
		Return False
end choose

Return True

end function

public subroutine of_setbody (string as_body, boolean ab_html);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetBody
//
// PURPOSE:    This function is used to set the contents of the message body.
//
// ARGUMENTS:  as_cmd  - SMTP command to be sent
//					ab_html - The text contains HTML
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_body = as_body
ib_html = ab_html

end subroutine

public subroutine of_setreceipt (boolean ab_receipt);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetReceipt
//
// PURPOSE:    This function is used to set whether return receipt is requested.
//
// ARGUMENTS:  ab_receipt - True/False
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

ib_receipt = ab_receipt

end subroutine

public subroutine of_setfrom (string as_email);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetFrom
//
// PURPOSE:    This function is used to set the sender's
//					email address.
//
// ARGUMENTS:  as_email - Sender's Email address
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

is_FromEmail = as_email
is_FromName = ""

end subroutine

public function integer of_addto (string as_email, string as_name);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddTo
//
// PURPOSE:    This function is used to add a primary send to
//					email address and name.
//
// ARGUMENTS:  as_email - Email address
//					as_name	- Recipient name
//
// RETURN:     Index to To array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_next
Integer li_Linha
String ls_Email[]

//Transforma o email em array de emails, caso tenha ";"
This.Of_Retorna_Emails(as_email, ref ls_Email)

For li_Linha = 1 To UpperBound(ls_Email)
	li_next = UpperBound(is_ToEmail) + 1
	is_ToEmail	[li_next] = ls_Email[li_Linha]
	is_ToName	[li_next] = as_name
Next

Return li_next

end function

public function integer of_addcc (string as_email, string as_name);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddCc
//
// PURPOSE:    This function is used to add a CC send to
//					email address and name.
//
// ARGUMENTS:  as_email - Email address
//					as_name	- Recipient name
//
// RETURN:     Index to To array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_next
Integer li_Linha
String ls_Email[]

//Transforma o email em array de emails, caso tenha ";"
This.Of_Retorna_Emails(as_email, ref ls_Email)

For li_Linha = 1 To UpperBound(ls_Email)
	li_next = UpperBound(is_CcEmail) + 1
	is_CcEmail	[li_next] = ls_Email[li_Linha]
	is_CcName	[li_next] = as_name
Next

Return li_next

end function

public function integer of_addbcc (string as_email);Return This.Of_AddBcc(as_email, "")

end function

public function integer of_addbcc (string as_email, string as_name);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_AddBcc
//
// PURPOSE:    This function is used to add a Blind CC send to
//					email address and name.
//
// ARGUMENTS:  as_email - Email address
//					as_name	- Recipient name
//
// RETURN:     Index to To array
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 01/30/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Integer li_Next
Integer li_Linha
String ls_Email[]

//Transforma o email em array de emails, caso tenha ";"
This.Of_Retorna_Emails(as_email, ref ls_Email)

For li_Linha = 1 To UpperBound(ls_Email)
	li_next = UpperBound(is_BccEmail) + 1
	is_BccEmail	[li_next] = ls_Email[li_Linha]
	is_BccName	[li_next] = as_name
Next 

Return li_next

end function

private function string of_encode64 (string as_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Encode64
//
// PURPOSE:    This function converts string to blob and
//					calls ancestor function.
//
// ARGUMENTS:  as_data - String containing data
//
// RETURN:     String containing encoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Return of_Encode64(Blob(as_data, EncodingAnsi!))

end function

private function string of_generate_guid ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Generate_GUID
//
// PURPOSE:    This function is used to generate a GUID.
//
// RETURN:     GUID string
//
// DATE        PROG/ID          DESCRIPTION OF CHANGE / REASON
// ----------  --------         -----------------------------------------------------
// 01/19/2006   RolandS         Initial coding
// -----------------------------------------------------------------------------

UUID lstr_UUID
Constant Long RPC_S_OK = 0
Constant Long SZ_UUID_LEN = 36
ULong lul_ptrUuid
String ls_Uuid

lstr_UUID.Data4 = Blob(Space(8), EncodingAnsi!)
If UuidCreate(lstr_UUID) = RPC_S_OK Then
	If UuidToString(lstr_UUID, lul_ptrUuid) = RPC_S_OK Then
		ls_Uuid = Space(SZ_UUID_LEN)
		CopyMemory(ls_Uuid, lul_ptrUuid, SZ_UUID_LEN*2)
		RpcStringFree(lul_ptrUuid)
		ls_Uuid = Upper(ls_Uuid)
	End If
End If

Return ls_Uuid

end function

private function string of_data ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Data
//
// PURPOSE:    This function is used to build the DATA portion of the message.
//					It is called by of_SendMail.
//
// RETURN:     A string containing the data to send.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// 06/12/2008	RolandS		Added Content-ID
// 08/17/2008	RolandS		Added Date
// 08/11/2009	RolandS		Added Time Zone Offset to date
// -----------------------------------------------------------------------------

String ls_data, ls_boundary, ls_filename, ls_encoded, ls_type
Integer li_idx, li_max
DateTime ldt_current
Environment le_env
Blob lblb_data

GetEnvironment(le_env)

ldt_current = DateTime(Today(), Now())
ls_data  = "Date: " + String(ldt_current, "ddd, dd mmm yyyy hh:mm:ss")
ls_data += " " + of_TimeZoneOffset() + CRLF

If is_FromName = "" Then
	ls_data += 'From: <' + is_FromEmail + '>' + CRLF
Else
	ls_data += 'From: ' + is_FromName
	ls_data += ' <' + is_FromEmail + '>' + CRLF
End If

If ib_receipt Then
	If is_FromName = "" Then
		ls_data += 'Disposition-Notification-To: <'
		ls_data += is_FromEmail + '>' + CRLF
	Else
		ls_data += 'Disposition-Notification-To: ' + is_FromName
		ls_data += ' <' + is_FromEmail + '>' + CRLF
	End If
End If

ls_data += 'User-Agent: TopWiz PowerBuilder '
ls_data += String(le_env.PBMajorRevision) + '.'
ls_data += String(le_env.PBMinorRevision) + ' '
ls_data += 'SMTP Object' + CRLF

ls_data += 'X-Accept-Language: en-us, en' + CRLF

ls_data += 'MIME-Version: 1.0' + CRLF

li_max = UpperBound(is_ToEmail)
For li_idx = 1 To li_max
	If is_ToName[li_idx] = "" Then
		ls_data += 'To: <' + is_ToEmail[li_idx] + '>' + CRLF
	Else
		ls_data += 'To: ' + is_ToName[li_idx]
		ls_data += ' <' + is_ToEmail[li_idx] + '>' + CRLF
	End If
Next

li_max = UpperBound(is_CcEmail)
For li_idx = 1 To li_max
	If is_CcName[li_idx] = "" Then
		ls_data += 'Cc: <' + is_CcEmail[li_idx] + '>' + CRLF
	Else
		ls_data += 'Cc: ' + is_CcName[li_idx]
		ls_data += ' <' + is_CcEmail[li_idx] + '>' + CRLF
	End If
Next

//CCO
li_max = UpperBound(is_BccEmail)
For li_idx = 1 To li_max
	If is_BccEmail[li_idx] = "" Then
		ls_data += 'Cco: <' + is_BccEmail[li_idx] + '>' + CRLF
	Else
		ls_data += 'Cco: ' + is_BccEmail[li_idx]
		ls_data += ' <' + is_BccEmail[li_idx] + '>' + CRLF
	End If
Next

ls_data += 'Reply-To: <' + is_FromEmail + '>' + CRLF

ls_data += "Subject: " + is_subject + CRLF

// now the actual content of the email

li_max = UpperBound(is_attachfile)

// attachment header
If li_max > 0 Then
	ls_boundary = of_generate_guid()
	If Pos(Lower(is_body), "cid:attach.") > 0 Then
		ls_data += 'Content-Type: multipart/related;' + CRLF
	Else
		ls_data += 'Content-Type: multipart/mixed;' + CRLF
	End If
	ls_data += ' boundary="' + ls_boundary + '"' + CRLF
	ls_data += CRLF
	ls_data += 'This is a multi-part message in MIME format.' + CRLF
	ls_data += '--' + ls_boundary + CRLF
End If

// text or html section
If ib_html Then
	ls_data += 'Content-Type: text/html; charset=ISO-8859-1;format=flowed' + CRLF
Else
	ls_data += 'Content-Type: text/plain; charset=ISO-8859-1;format=flowed' + CRLF
End If
ls_data += 'Content-Transfer-Encoding: 7bit' + CRLF + CRLF

ls_data += is_body + CRLF

// add attachments
For li_idx = 1 To li_max
	If this.of_readfile(is_attachfile[li_idx], lblb_data) Then
		// add boundary
		ls_data += CRLF + '--' + ls_boundary + CRLF
		// determine content type
		ls_filename = Mid(is_attachfile[li_idx], &
							LastPos(is_attachfile[li_idx], "\") + 1)
		ls_type = this.of_FindMimeFromData(is_attachfile[li_idx], lblb_data)
		ls_data += 'Content-Type: ' + ls_type + ';' + CRLF
		ls_data += ' name="' + ls_filename + '"' + CRLF
		// add attachment header and data
		If Lower(Left(ls_type, 4)) = "text" Then
			ls_data += 'Content-Transfer-Encoding: 7bit' + CRLF
			ls_data += 'Content-Disposition: inline;' + CRLF
			ls_data += ' filename="' + ls_filename + '"' + CRLF
			ls_data += 'Content-ID: <attach.' + String(li_idx) + '>' + CRLF
			ls_data += CRLF + String(lblb_data, EncodingAnsi!)
		Else
			ls_data += 'Content-Transfer-Encoding: base64' + CRLF
			ls_data += 'Content-Disposition: inline;' + CRLF
			ls_data += ' filename="' + ls_filename + '"' + CRLF
			ls_data += 'Content-ID: <attach.' + String(li_idx) + '>' + CRLF
			// encode the binary data
			ls_encoded = this.of_encode64(lblb_data)
			ls_data += CRLF + ls_encoded
		End If
	End If
Next

// if attachments, add end boundary
If li_max > 0 Then
	ls_data += '--' + ls_boundary + '--'
End If

// final double CRLF
ls_data += CRLF + '.' + CRLF

Return ls_data

end function

private function string of_findmimefromdata (string as_filename, ref blob ablob_filedata);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_FindMimeFromData
//
// PURPOSE:    This function is determines the file MIME type.
//
// ARGUMENTS:  as_filename - Filename
//					ablob_data	- By ref blob of the file contents
//
// RETURN:     MIME Type
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/05/2006	RolandS		Initial coding
// 10/22/2009	RolandS		Changed return to ulong & added err msg
// -----------------------------------------------------------------------------

Constant ulong E_INVALIDARG	= 2147942487	// &h80070057
Constant ulong E_OUTOFMEMORY	= 2147942414	// &h8007000E
Constant ulong NOERROR			= 0
String ls_mimetype, ls_errmsg
ULong lul_ptr, lul_rtn

If FileExists(as_filename) Then
	lul_rtn = FindMimeFromData(0, as_filename, ablob_filedata, &
					Len(ablob_filedata), 0, 0, lul_ptr, 0)
	choose case lul_rtn
		case NOERROR
			ls_mimetype = String(lul_ptr, "address")
		case E_INVALIDARG
			ls_errmsg = "One or more of the arguments passed to the function were invalid."
			ls_errmsg += "~r~n~r~nFilename: " + as_filename
			this.of_LogError(iERROR, "of_FindMimeFromData: " + ls_errmsg)
		case E_OUTOFMEMORY
			ls_errmsg = "The function could not allocate enough memory to complete the call."
			ls_errmsg += "~r~n~r~nFilename: " + as_filename
			this.of_LogError(iERROR, "of_FindMimeFromData: " + ls_errmsg)
		case else
			ls_errmsg = "Error " + String(lul_rtn)
			ls_errmsg += "~r~n~r~nFilename: " + as_filename
			this.of_LogError(iERROR, "of_FindMimeFromData: " + ls_errmsg)
	end choose
Else
	ls_errmsg = "The file was not found."
	ls_errmsg += "~r~n~r~nFilename: " + as_filename
	this.of_LogError(iERROR, "of_FindMimeFromData: " + ls_errmsg)
End If

Return ls_mimetype

end function

private function boolean of_readfile (string as_filename, ref blob ablob_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_ReadFile
//
// PURPOSE:    This function is used to read an attachment from disk to a blob.
//
// ARGUMENTS:  as_filename - Filename
//					ablob_data	- By ref blob to receive the file contents
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

// constants for CreateFile API function
Constant ULong INVALID_HANDLE_VALUE = -1
Constant ULong GENERIC_READ     = 2147483648
Constant ULong GENERIC_WRITE    = 1073741824
Constant ULong FILE_SHARE_READ  = 1
Constant ULong FILE_SHARE_WRITE = 2
Constant ULong CREATE_NEW			= 1
Constant ULong CREATE_ALWAYS		= 2
Constant ULong OPEN_EXISTING		= 3
Constant ULong OPEN_ALWAYS			= 4
Constant ULong TRUNCATE_EXISTING = 5

ULong lul_file, lul_bytes, lul_length
Blob lblob_filedata
Boolean lb_result

// get file length
lul_length = FileLength(as_filename)

// open file for read
lul_file = CreateFile(as_filename, GENERIC_READ, &
					FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
If lul_file = INVALID_HANDLE_VALUE Then
	Return False
End If

// read the entire file contents in one shot
lblob_filedata = Blob(Space(lul_length), EncodingAnsi!)
lb_result = ReadFile(lul_file, lblob_filedata, &
					lul_length, lul_bytes, 0)
ablob_data = BlobMid(lblob_filedata, 1, lul_length)

// close the file
CloseHandle(lul_file)

Return lb_result

end function

public function boolean of_sendmail_start ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SendMail_Start
//
// PURPOSE:    This function starts the sendmail session.
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant	String REPLY_READY = "220"
String ls_reply, ls_msg
Integer li_rc

// Initialize Winsock
of_Startup()

// Connect to server
iui_socket = of_Connect(is_server, ii_port)
If iui_socket = 0 Then 
	This.of_LogMsg("Falha na abertura da conex$$HEX1$$e300$$ENDHEX$$o.~rServidor: "+is_server+"~rPorta: " +String(ii_port))
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)
If Left(ls_reply, 3) <> REPLY_READY Then
	this.of_LogError(iERROR, "Connect Failed: " + ls_reply)
	Return False
End If

// start conversation with server
If ib_authenticate Then
	If Not of_auth() Then
		of_Close(iui_socket)
		Return False
	End If
Else
	ls_msg = "EHLO " + of_GetHostName() + CRLF
	If Not of_SendMsg(ls_msg) Then
		of_Close(iui_socket)
		Return False
	End If
End If

Return True

end function

public function boolean of_sendmail_stop ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SendMail_Stop
//
// PURPOSE:    This function ends the sendmail session.
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_reply, ls_msg
Integer li_rc

// quit the session
ls_msg = "QUIT" + CRLF
li_rc = of_Send(iui_socket, ls_msg)
If li_rc < 1 Then
	of_Close(iui_socket)
	Return False
End If

// receive response
of_Recv(iui_socket, ls_reply)

// close the socket
of_Close(iui_socket)

Return True

end function

public function boolean of_sendmail_msg ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SendMail_Msg
//
// PURPOSE:    This function sends the email to the server.
//
// RETURN:     True = Success, False = Failure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 03/30/2005	RolandS		Initial coding
// 11/18/2008	RolandS		Removed space between : and <
// -----------------------------------------------------------------------------

Constant	String REPLY_READY = "220"
String ls_reply, ls_msg, ls_data
Integer li_rc, li_idx, li_max

// build the data string
ls_data = of_data()

// from email address
ls_msg = "MAIL FROM:<" + Trim(Lower(is_FromEmail)) + ">" + CRLF
If Not of_SendMsg(ls_msg) Then
	of_Close(iui_socket)
	Return False
End If

// to email address
li_max = UpperBound(is_ToEmail)
For li_idx = 1 To li_max
	If Trim(is_ToEmail[li_idx])<> '' Then
		ls_msg = "RCPT TO:<" + Trim(Lower(is_ToEmail[li_idx])) + ">" + CRLF
		If Not of_SendMsg(ls_msg) Then
			of_Close(iui_socket)
			Return False
		End If
	End If
Next

// cc email address
li_max = UpperBound(is_CcEmail)
For li_idx = 1 To li_max
	If Trim(is_CcEmail[li_idx]) <> '' Then
		ls_msg = "RCPT TO:<" + Trim(Lower(is_CcEmail[li_idx])) + ">" + CRLF
		If Not of_SendMsg(ls_msg) Then
			of_Close(iui_socket)
			Return False
		End If
	End If
Next

// bcc email address
li_max = UpperBound(is_BccEmail)
For li_idx = 1 To li_max
	If Trim(is_BccEmail[li_idx]) <> '' then
		ls_msg = "RCPT TO:<" + Trim(Lower(is_BccEmail[li_idx])) + ">" + CRLF
		If Not of_SendMsg(ls_msg) Then
			of_Close(iui_socket)
			Return False
		End If
	End If
Next

// data header
ls_msg = "DATA" + CRLF
If Not of_SendMsg(ls_msg) Then
	of_Close(iui_socket)
	Return False
End If

// send data
If Not of_SendMsg(ls_data) Then
	of_Close(iui_socket)
	Return False
End If

Return True
end function

public subroutine of_setlogfile (boolean ab_logfile);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_SetLogfile
//
// PURPOSE:    This function is used to set whether a logfile is created.
//
// ARGUMENTS:  ab_logfile - True/False
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 11/18/2008	RolandS		Initial coding
// -----------------------------------------------------------------------------

ib_logfile = ab_logfile

end subroutine

public subroutine of_logmsg (string as_msgtext);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Logmsg
//
// PURPOSE:    This function writes text messages to a log file.
//
// ARGUMENTS:  as_msgtext - Message to be written to file
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 11/18/2008	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_fname
Integer li_fnum

If ib_logfile Then
	ls_fname = This.Of_GetFileLog( )
	li_fnum = FileOpen(ls_fname, LineMode!, Write!)
	FileWrite(li_fnum, as_msgtext)
	FileClose(li_fnum)
End If

end subroutine

public subroutine of_deletelogfile ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_DeleteLogfile
//
// PURPOSE:    This function deletes the log file.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 11/18/2008	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_fname

ls_fname = GetCurrentDirectory() + "\smtp_logfile.txt"

FileDelete(ls_fname)

end subroutine

public function string of_timezoneoffset ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_TimeZoneOffset
//
// PURPOSE:    This function returns the timezone offset string.
//
// RETURN:     Offset
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/11/2009	RolandS		Initial coding
// -----------------------------------------------------------------------------

TIME_ZONE_INFORMATION lstr_tzi
Integer li_hour, li_minute
Long ll_rtn, ll_bias
String ls_offset

ll_rtn = GetTimeZoneInformation(lstr_tzi)

If ll_rtn = 2 Then
	ll_bias = lstr_tzi.Bias + lstr_tzi.DaylightBias
Else
	ll_bias = lstr_tzi.Bias
End If

li_hour   = Abs(ll_bias) / 60
li_minute = Abs(ll_bias) - (li_hour * 60)

ls_offset =  String(li_hour, "00") + String(li_minute, "00")
If ll_bias < 0 Then
	ls_offset = "+" + ls_offset
Else
	ls_offset = "-" + ls_offset
End If

Return ls_offset

end function

public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace);String ls_newstring
Long ll_findstr, ll_replace, ll_pos

// get length of strings
ll_findstr = Len(as_findstr)
ll_replace = Len(as_replace)

// find first occurrence
ls_newstring = as_oldstring
ll_pos = Pos(ls_newstring, as_findstr)

Do While ll_pos > 0
	// replace old with new
	ls_newstring = Replace(ls_newstring, ll_pos, ll_findstr, as_replace)
	// find next occurrence
	ll_pos = Pos(ls_newstring, as_findstr, (ll_pos + ll_replace))
Loop

Return ls_newstring

end function

private subroutine of_grava_log_db ();Boolean lb_Retorno

Integer li_idx

String ls_Remetente
String ls_Destinatario	=	''
String ls_Copia			=	''
String ls_Copia_Oculta =	''
String ls_Assunto		=	''
String ls_Corpo			=	''
ls_Remetente = is_FromEmail

For li_idx = 1 To UpperBound(is_ToEmail)
	ls_Destinatario += is_ToEmail[li_idx] + ';'
Next

For li_idx = 1 To UpperBound(is_CcEmail)
	ls_Copia += is_CcEmail[li_idx] + ';'
Next

For li_idx = 1 To UpperBound(is_BCcEmail)
	ls_Copia_Oculta += is_BCcEmail[li_idx] + ';'
Next

ls_Assunto	=	is_subject

ls_Corpo = is_body

dc_uo_transacao ltr_Intranet
ltr_Intranet = Create dc_uo_transacao

ltr_Intranet.ivs_DataBase = "MYSQL"
ltr_Intranet.ivs_Usuario = 'gambiarra'

lb_Retorno = ltr_Intranet.of_Connect("Intranet", "TO")

Insert Into log_envio_email
	(de_aplicacao,
	 de_titulo,
	 de_remetente,
	 de_destinatario,
	 de_copia,
	 de_copia_oculta,
	 de_corpo)
 Values
 	('TO',
	 :ls_Assunto,
	 :ls_Remetente,
	 :ls_Destinatario,
	 :ls_Copia,
	 :ls_Copia_Oculta,
	 :ls_Corpo
	 )
Using ltr_Intranet;

ltr_Intranet.of_Commit()

Destroy ltr_Intranet
end subroutine

public function string of_getserver ();// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_getServer
//
// PURPOSE:    This function is used to return the server name
//
// ARGUMENTS:  (NONE)
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 30/10/2014	Gambiarra		Initial coding
// -----------------------------------------------------------------------------

Return This.is_server

end function

public function boolean of_retorna_emails (string ps_email, ref string ps_array_email[]);String lvs_Email
Integer lvi_Next = 1

ps_array_email = {""}

ps_email = gf_replace(ps_email, '~r~n','',0)
ps_email = gf_replace(ps_email, '~n','',0)

//Enquanto houver ";"
Do While Pos(ps_email, ";") > 0
	//Captura o email existente at$$HEX1$$e900$$ENDHEX$$ o pr$$HEX1$$f300$$ENDHEX$$ximo ";"
	lvs_Email = Trim(Mid(ps_email, 1, Pos(ps_email, ";") - 1))
	//Verifica se email n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ vazio
	If lvs_Email<>"" Then
		//Somente ser$$HEX1$$e300$$ENDHEX$$o enviados emails para endere$$HEX1$$e700$$ENDHEX$$os internos quando estiver no HOMOLOGA
		If This.Of_Email_Interno(lvs_Email) or SQLCa.Banco_Producao Then
			ps_array_email [ lvi_Next ] = lvs_Email
			lvi_Next ++
		End If
	End If
	//Exclui o email j$$HEX1$$e100$$ENDHEX$$ adicionado no array da vari$$HEX1$$e100$$ENDHEX$$vel
	ps_email = Mid(ps_email, Pos(ps_email, ";") + 1)
Loop

//Armazena o valor restante na vari$$HEX1$$e100$$ENDHEX$$vel pois pode acontecer de n$$HEX1$$e300$$ENDHEX$$o ter nenhum ";"
ps_email = Trim(ps_email)
If ps_email <> "" Then
	//Somente ser$$HEX1$$e300$$ENDHEX$$o enviados emails para endere$$HEX1$$e700$$ENDHEX$$os internos quando estiver no HOMOLOGA
	If This.Of_Email_Interno(ps_email) or SQLCa.Banco_Producao Then
		ps_array_email [ lvi_Next ] = ps_email
	End If
End If

Return (UpperBound(ps_array_email) > 0)
end function

public function boolean of_email_interno (string ps_email);Long lvl_Linha

String lvs_Dominios[] = {"clamed.com.br", "cialatinoamericana.com.br", "drogarialocal.com.br", "drogaria.local", "drogariacatarinense.com.br", "clamedlocal.com.br"}

For lvl_Linha = 1 To UpperBound(lvs_Dominios)
	If Pos(ps_email, lvs_Dominios[lvl_Linha] ) > 0 Then
		Return True
	End If
Next

Return False
end function

public function boolean of_envia_email (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[], string ps_copia[], string ps_copia_oculta[], string ps_anexo[], boolean pb_contem_anexo);//** Envio de Email  -  Exemplo de Uso
//
//uo_smtp lo_smtp
//
//lo_smtp = Create uo_smtp
//
//String ls_To[], &
//		   ls_Cc[], &
//         ls_Bcc[]
//
//ls_To = {"email@destinatario1.com.br", "email@destinatario2.com.br"}
//ls_Cc = {"email@copia1.com.br", "email@copia2.com.br"}
//ls_Bcc = {"email@copia1.com.br", "email@copia2.com.br"}
//
//lo_smtp.of_envia_email("Nome Remetente", &
//							    "email@remetente", &
//								"Assunto", &
//							     "<tag html se precisar>Corpo do Email</tag hrml se precisar>", &
//								 ls_To, &
//								 ls_Cc, &
//								 ls_Bcc)
//								 
//Destroy lo_smtp

Long ll_Contador
String ls_Corpo

of_SetFrom(ps_Email_Remetente, ps_Nome_Remetente)
of_SetSubject(ps_assunto)

If pb_contem_anexo Then
	ls_Corpo = ps_conteudo
	//Conte$$HEX1$$fa00$$ENDHEX$$do formatado em html n$$HEX1$$e300$$ENDHEX$$o funciona com anexo
	of_SetBody(ls_Corpo, False)
Else
	If Not (Pos(ps_conteudo, "<html") > 0) Then
		ls_Corpo = "<html><body>"+ps_conteudo+"</body></html>"
		ls_Corpo = of_replaceall(ls_Corpo, "~r~n","<br />~r~n")
		ls_Corpo = of_replaceall(ls_Corpo, "~r~n~r~n","~r~n")
	Else
		ls_Corpo = ps_conteudo
	End If
	
	of_SetBody(ls_Corpo, True)
End If

of_Reset()

For ll_Contador = 1 To UpperBound(ps_Destinatario)
	of_AddTo(ps_destinatario[ll_Contador])
Next

For ll_Contador = 1 To UpperBound(ps_Copia)
	of_AddCc(ps_Copia[ll_Contador])
Next	

For ll_Contador = 1 To UpperBound(ps_Copia_Oculta)
	of_AddBcc(ps_Copia_Oculta[ll_Contador])
Next	

For ll_Contador = 1 To UpperBound(ps_Anexo)
	of_addfile(ps_Anexo[ll_Contador])
Next	

If of_SendMail() Then
	is_LastError = ""
	If ib_grava_log_db Then
		of_Grava_Log_Db()
	End If
Else
	is_LastError = is_msgtext
	Return False
End If

Return True

end function

public function boolean of_envia_email (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[], string ps_copia[], string ps_copia_oculta[]);//** Envio de Email  -  Exemplo de Uso
//
//uo_smtp lo_smtp
//
//lo_smtp = Create uo_smtp
//
//String ls_To[], &
//		   ls_Cc[], &
//         ls_Bcc[]
//
//ls_To = {"email@destinatario1.com.br", "email@destinatario2.com.br"}
//ls_Cc = {"email@copia1.com.br", "email@copia2.com.br"}
//ls_Bcc = {"email@copia1.com.br", "email@copia2.com.br"}
//
//lo_smtp.of_envia_email("Nome Remetente", &
//							    "email@remetente", &
//								"Assunto", &
//							     "<tag html se precisar>Corpo do Email</tag hrml se precisar>", &
//								 ls_To, &
//								 ls_Cc, &
//								 ls_Bcc)
//								 
//Destroy lo_smtp

String ls_Anexo[]

Return This.of_envia_email(ps_nome_remetente, &
									ps_email_remetente, &
									ps_assunto, &
									ps_conteudo, &
									ps_Destinatario, &
									ps_Copia, &
									ps_copia_oculta, &
									ls_Anexo, &
									 False)
end function

public function boolean of_envia_email (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[], string ps_copia[]);//uo_smtp lo_smtp
//
//lo_smtp = Create uo_smtp
//
//String ls_To[], &
//		   ls_Cc[]
//
//ls_To = {"email@destinatario1.com.br", "email@destinatario2.com.br"}
//ls_Cc = {"email@copia1.com.br", "email@copia2.com.br"}
//
//lo_smtp.of_envia_email("Nome Remetente", &
//							    "email@remetente", &
//								"Assunto", &
//							     "<tag html se precisar>Corpo do Email</tag hrml se precisar>", &
//								 ls_To, &
//								 ls_Cc)
//								 
//Destroy lo_smtp

String ls_Bcc[]

Return This.of_envia_email(ps_nome_remetente, &
									ps_email_remetente, &
									ps_assunto, &
									ps_conteudo, &
									ps_Destinatario, &
									ps_Copia, &
									ls_Bcc)
end function

public function boolean of_envia_email (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[]);//uo_smtp lo_smtp
//
//lo_smtp = Create uo_smtp
//
//String ls_To[]
//
//ls_To = {"email@destinatario1.com.br", "email@destinatario2.com.br"}
//
//lo_smtp.of_envia_email("Nome Remetente", &
//							    "email@remetente", &
//								"Assunto", &
//							     "<tag html se precisar>Corpo do Email</tag hrml se precisar>", &
//								 ls_To)
//								 
//Destroy lo_smtp

String ls_Cc[]
String ls_Bcc[]

Return This.of_envia_email(ps_nome_remetente, &
									ps_email_remetente, &
									ps_assunto, &
									ps_conteudo, &
									ps_Destinatario, &
									ls_Cc, &
									ls_Bcc)


end function

public function boolean of_envia_email_anexo (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[], string ps_copia[], string ps_anexo[]);//Alterado por Wagner 18/07/2013
//
//- N$$HEX1$$e300$$ENDHEX$$o usar formata$$HEX2$$e700e300$$ENDHEX$$o em html no corpo do e-mail;
//- N$$HEX1$$e300$$ENDHEX$$o anexar mais de 10 arquivos;
//- N$$HEX1$$e300$$ENDHEX$$o ultrapassar 2 mb de arquivos para as Filiais e 5 mb para o depto de Inform$$HEX1$$e100$$ENDHEX$$tica;

//-----------------------------------------------------------------------------
//	Colocar o caminho dos arquivos no par$$HEX1$$e200$$ENDHEX$$metro PS_ANEXO[]
// 	EX: ps_Anexo = {"C:\relatorio1.pdf", "C:\relatorio2.pdf"}
//-----------------------------------------------------------------------------

String ls_Bcc[]

Return This.of_envia_email(ps_nome_remetente, &
									ps_email_remetente, &
									ps_assunto, &
									ps_conteudo, &
									ps_Destinatario, &
									ps_copia, &
									ls_Bcc, &
									ps_anexo, True)

end function

public function boolean of_envia_email_anexo (string ps_nome_remetente, string ps_email_remetente, string ps_assunto, string ps_conteudo, string ps_destinatario[], string ps_copia[], string ps_copia_oculta[], string ps_anexo[]);//Alterado por Wagner 18/07/2013
//
//- N$$HEX1$$e300$$ENDHEX$$o usar formata$$HEX2$$e700e300$$ENDHEX$$o em html no corpo do e-mail;
//- N$$HEX1$$e300$$ENDHEX$$o anexar mais de 10 arquivos;
//- N$$HEX1$$e300$$ENDHEX$$o ultrapassar 2 mb de arquivos para as Filiais e 5 mb para o depto de Inform$$HEX1$$e100$$ENDHEX$$tica;

//-----------------------------------------------------------------------------
//	Colocar o caminho dos arquivos no par$$HEX1$$e200$$ENDHEX$$metro PS_ANEXO[]
// 	EX: ps_Anexo = {"C:\relatorio1.pdf", "C:\relatorio2.pdf"}
//-----------------------------------------------------------------------------

Return This.of_envia_email(ps_nome_remetente, &
									ps_email_remetente, &
									ps_assunto, &
									ps_conteudo, &
									ps_Destinatario, &
									ps_copia, &
									ps_copia_oculta, &
									ps_anexo, True)

end function

public subroutine of_setfilelog (string ps_filelog);is_filelog = ps_filelog
end subroutine

public function string of_getfilelog ();If IsNull(is_filelog) or Trim(is_filelog)="" Then is_filelog = This.Of_GetApplicationPath( )+"\smtp_logfile.txt"

Return is_filelog
end function

public function string of_getapplicationpath ();string lvs_Path
unsignedlong lul_handle

Long lvl_Aux

lvs_Path = Space(1024)

lul_handle = Handle(GetApplication())
GetModuleFileNameA(lul_handle, lvs_Path, 1024)

lvl_Aux = Len(lvs_Path)
Do While lvl_Aux > 0
	If Mid(lvs_Path, lvl_Aux, 1) = "\" Then
		lvs_Path = Mid(lvs_Path, 1, lvl_Aux)
		Exit
	End If
	lvl_Aux --
Loop

Return lvs_Path
end function

on uo_smtp.create
call super::create
end on

on uo_smtp.destroy
call super::destroy
end on

event constructor;call super::constructor;String ls_Log

ls_Log = IIF(ib_logfile, "S", "N")

is_server		= ProfileString(gvo_aplicacao.ivs_arquivo_ini,"Email", "Servidor", is_server)
ii_port		= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini,"Email", "Porta", String(ii_port)))
is_filelog		= ProfileString(gvo_aplicacao.ivs_arquivo_ini,"Email", "Arquivo_Log", is_filelog)
ls_Log		= ProfileString(gvo_aplicacao.ivs_arquivo_ini,"Email", "Grava_Log", ls_Log)
ib_authenticate = ((Not IsNull(is_userid)) and (is_userid<>""))

This.Of_SetLogFile(ls_Log = "S")

// SMTP is Ansi
This.of_SetUnicode(False, False)

end event

