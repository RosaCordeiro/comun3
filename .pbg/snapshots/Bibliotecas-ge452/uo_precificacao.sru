HA$PBExportHeader$uo_precificacao.sru
forward
global type uo_precificacao from nonvisualobject
end type
end forward

global type uo_precificacao from nonvisualobject
end type
global uo_precificacao uo_precificacao

type variables
Boolean Localizada = False

Long nr_precificacao
Long cd_tipo_precificacao
String cd_uf
String id_rede_filial
String cd_subcategoria
String id_situacao
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (long pl_codigo)
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza (string ps_parametro, string ps_uf, string ps_rede)
public function boolean of_localiza (string ps_parametro, long pl_tipo_precificacao, string ps_uf, string ps_rede)
public function boolean of_localiza_generica (long pl_tipo_precificacao, string ps_uf, string ps_rede, string ps_subcategoria, string ps_situacao)
public function boolean of_localiza_situacao (string ps_parametro, string ps_situacao)
public function boolean of_localiza (string ps_parametro, long pl_tipo_precificacao, string ps_uf, string ps_rede, string ps_subcategoria, string ps_situacao)
end prototypes

public subroutine of_inicializa ();Localizada = False

SetNull( nr_precificacao )
SetNull( cd_tipo_precificacao )
SetNull( cd_uf )
SetNull( id_rede_filial )
SetNull( cd_subcategoria )
SetNull( id_situacao )
end subroutine

public function boolean of_localiza_codigo (long pl_codigo);This.Of_Inicializa( )

select nr_precificacao,
		cd_tipo_precificacao, 
		cd_uf,
		id_rede_filial,
		cd_subcategoria,
		id_situacao
Into :nr_precificacao,
	  :cd_tipo_precificacao,
	  :cd_uf,
	  :id_rede_filial, 
	  :cd_subcategoria,
	  :id_situacao
From precificacao
Where nr_precificacao = :pl_codigo
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o precifica$$HEX2$$e700e300$$ENDHEX$$o por c$$HEX1$$f300$$ENDHEX$$digo." )
End if

This.Localizada = (SQLCa.SQLCode = 0)

Return This.Localizada
end function

public function boolean of_localiza (string ps_parametro);Return This.Of_localiza( ps_parametro, "", "")
end function

public function boolean of_localiza (string ps_parametro, string ps_uf, string ps_rede);Long lvl_Null

SetNull( lvl_Null ) 

Return This.of_localiza( ps_parametro, lvl_Null, ps_uf, ps_rede)
end function

public function boolean of_localiza (string ps_parametro, long pl_tipo_precificacao, string ps_uf, string ps_rede);Return This.Of_Localiza( ps_parametro, pl_tipo_precificacao, ps_uf, ps_rede, "", "")
end function

public function boolean of_localiza_generica (long pl_tipo_precificacao, string ps_uf, string ps_rede, string ps_subcategoria, string ps_situacao);String lvs_Parametro = ""
String lvs_tipo_precificacao = ""

lvs_tipo_precificacao = String(pl_tipo_precificacao)

If IsNull(ps_uf) Then ps_uf = ""
if IsNull(ps_rede) Then ps_rede = ""
If IsNull(ps_subcategoria) Then ps_subcategoria = ""
If IsNull(ps_situacao) Then ps_situacao = ""
If IsNull(lvs_tipo_precificacao) Then lvs_tipo_precificacao = ""

lvs_Parametro = lvs_tipo_precificacao+";"+ps_uf+";"+ps_rede+";"+ps_subcategoria+";"+ps_situacao
OpenWithParm(w_ge452_selecao_precificacao, lvs_Parametro)

If IsNumBer(Message.StringParm) Then
	This.Of_localiza_codigo( Long(Message.StringParm) )
End If

Return This.Localizada
end function

public function boolean of_localiza_situacao (string ps_parametro, string ps_situacao);Long lvl_null

SetNull( lvl_null )

Return This.of_localiza( ps_parametro, lvl_null, "", "", "", ps_situacao)
end function

public function boolean of_localiza (string ps_parametro, long pl_tipo_precificacao, string ps_uf, string ps_rede, string ps_subcategoria, string ps_situacao);This.Of_inicializa( )

If IsNumber(ps_parametro) Then
	This.Of_Localiza_Codigo( Long(ps_parametro) )
End If

If Not This.Localizada Then
	This.Of_Localiza_Generica( pl_tipo_precificacao, ps_uf, ps_rede, ps_subcategoria, ps_situacao)
End If

Return This.Localizada
end function

on uo_precificacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_precificacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

