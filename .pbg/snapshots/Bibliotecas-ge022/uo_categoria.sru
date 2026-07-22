HA$PBExportHeader$uo_categoria.sru
forward
global type uo_categoria from nonvisualobject
end type
end forward

global type uo_categoria from nonvisualobject
end type
global uo_categoria uo_categoria

type variables
String De_Categoria
String Cd_Categoria

String De_Grupo
String Cd_Grupo

String De_Subgrupo
String Cd_Subgrupo

Boolean Localizado
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (string ps_categoria)
public function boolean of_localiza (string ps_parametro, string ps_grupo, string ps_subgrupo)
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza (string ps_parametro, string ps_grupo)
end prototypes

public subroutine of_inicializa ();SetNull(De_Categoria)
SetNull(Cd_Categoria)

SetNull(De_Grupo)
SetNull(Cd_Grupo)

SetNull(De_Subgrupo)
SetNull(Cd_Subgrupo)

Localizado = False
end subroutine

public function boolean of_localiza_codigo (string ps_categoria);If Localizado Then This.Of_Inicializa()

select c.cd_categoria, 
		c.de_categoria, 
		s.cd_subgrupo,
		s.de_subgrupo,
		g.cd_grupo,
		g.de_grupo
Into	:Cd_Categoria,
		:De_Categoria,
		:Cd_Subgrupo,
		:De_Subgrupo,
		:Cd_Grupo,
		:De_Grupo
From categoria c
Inner Join subgrupo s
	on s.cd_subgrupo = c.cd_subgrupo
Inner Join grupo g
	on g.cd_grupo = s.cd_grupo
Where c.cd_categoria = :ps_categoria
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_MsgDbError('Localiza c$$HEX1$$f300$$ENDHEX$$digo categoria produto.')
End If

Localizado = (SQLCa.SQLCode = 0)

Return Localizado
end function

public function boolean of_localiza (string ps_parametro, string ps_grupo, string ps_subgrupo);String lvs_Parm
String lvs_Codigo

If Localizado Then This.Of_Inicializa()

If (Len(ps_parametro)=6)and(IsNumber(ps_parametro)) Then
	This.Of_localiza_codigo(ps_parametro)
End If

If Not(Localizado) Then
	lvs_Parm = ps_parametro+';'
	If Trim(ps_grupo) <> '' Then lvs_Parm += ps_grupo
	lvs_Parm += ';'
	If Trim(ps_subgrupo) <> '' Then lvs_Parm += ps_subgrupo
	lvs_Parm += ';'
	
	OpenWithParm(w_ge022_selecao_categoria,lvs_Parm)
	
	lvs_Codigo = Message.StringParm
	If lvs_Codigo<>'' Then 
		This.Of_Localiza_Codigo(lvs_Codigo)
	Else
		This.Of_Inicializa( )
	End if
End If

Return Localizado
end function

public function boolean of_localiza (string ps_parametro);Return This.Of_Localiza(ps_parametro,'')
end function

public function boolean of_localiza (string ps_parametro, string ps_grupo);Return This.Of_Localiza(ps_parametro,ps_grupo,'')
end function

on uo_categoria.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_categoria.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

