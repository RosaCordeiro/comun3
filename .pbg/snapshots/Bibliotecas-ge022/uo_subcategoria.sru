HA$PBExportHeader$uo_subcategoria.sru
forward
global type uo_subcategoria from nonvisualobject
end type
end forward

global type uo_subcategoria from nonvisualobject
end type
global uo_subcategoria uo_subcategoria

type variables
String De_Subcategoria
String Cd_Subcategoria

String De_Categoria
String Cd_Categoria

String De_Subgrupo
String Cd_Subgrupo

String De_Grupo
String Cd_Grupo

Boolean Localizado
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (string ps_categoria)
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza (string ps_parametro, string ps_grupo, string ps_subgrupo, string ps_categoria)
public function boolean of_localiza (string ps_parametro, string ps_grupo)
public function boolean of_localiza (string ps_parametro, string ps_grupo, string ps_subgrupo)
end prototypes

public subroutine of_inicializa ();SetNull(De_Subcategoria)
SetNull(Cd_Subcategoria)

SetNull(De_Categoria)
SetNull(Cd_Categoria)

SetNull(De_Subgrupo)
SetNull(Cd_Subgrupo)

SetNull(De_Grupo)
SetNull(Cd_Grupo)

Localizado = False
end subroutine

public function boolean of_localiza_codigo (string ps_categoria);If Localizado Then This.Of_Inicializa()

select sc.cd_subcategoria, 
		sc.de_subcategoria, 
		c.cd_categoria, 
		c.de_categoria, 
		s.cd_subgrupo,
		s.de_subgrupo,
		g.cd_grupo,
		g.de_grupo
Into	:Cd_Subcategoria,
		:De_Subcategoria,
		:Cd_Categoria,
		:De_Categoria,
		:Cd_Subgrupo,
		:De_Subgrupo,
		:Cd_Grupo,
		:De_Grupo
From subcategoria sc
Inner Join categoria c
	On c.cd_categoria = sc.cd_categoria
Inner Join subgrupo s
	on s.cd_subgrupo = c.cd_subgrupo
Inner Join grupo g
	on g.cd_grupo = s.cd_grupo
Where sc.cd_subcategoria = :ps_categoria
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_MsgDbError('Localiza c$$HEX1$$f300$$ENDHEX$$digo subcategoria produto.')
End If

Localizado = (SQLCa.SQLCode = 0)

Return Localizado
end function

public function boolean of_localiza (string ps_parametro);Return This.Of_Localiza(ps_parametro,'')
end function

public function boolean of_localiza (string ps_parametro, string ps_grupo, string ps_subgrupo, string ps_categoria);String lvs_Parm
String lvs_Codigo

If Localizado Then This.Of_Inicializa()

If (Len(ps_parametro)=9)and(IsNumber(ps_parametro)) Then
	This.Of_localiza_codigo(ps_parametro)
End If

If Not(Localizado) Then
	lvs_Parm = ps_parametro+';'
	If Trim(ps_grupo) <> '' Then lvs_Parm += ps_grupo
	lvs_Parm += ';'
	If Trim(ps_subgrupo) <> '' Then lvs_Parm += ps_subgrupo
	lvs_Parm += ';'
	If Trim(ps_categoria) <> '' Then lvs_Parm += ps_categoria
	lvs_Parm += ';'
	
	OpenWithParm(w_ge022_selecao_subcategoria,lvs_Parm)
	
	lvs_Codigo = Message.StringParm
	If lvs_Codigo<>'' Then 
		This.Of_Localiza_Codigo(lvs_Codigo)
	Else
		This.Of_Inicializa( )
	End if
End If

Return Localizado
end function

public function boolean of_localiza (string ps_parametro, string ps_grupo);Return This.Of_Localiza(ps_parametro,ps_grupo,'')
end function

public function boolean of_localiza (string ps_parametro, string ps_grupo, string ps_subgrupo);Return This.Of_Localiza(ps_parametro,ps_grupo,ps_subgrupo,'')
end function

on uo_subcategoria.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_subcategoria.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

