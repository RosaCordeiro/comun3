HA$PBExportHeader$uo_classificacao_produto.sru
forward
global type uo_classificacao_produto from nonvisualobject
end type
end forward

global type uo_classificacao_produto from nonvisualobject
end type
global uo_classificacao_produto uo_classificacao_produto

type variables
string cd_grupo, &
         de_grupo, &
         cd_subgrupo, &
         de_subgrupo, &
         cd_categoria, &
         de_categoria, &
         cd_subcategoria, &
         de_subcategoria
	
Integer cd_grupo_antigo
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_generica (string as_nivel)
public function boolean of_localiza_codigo (string as_nivel, string as_codigo)
public function boolean of_localiza (string as_nivel, string as_parametro)
public function boolean wf_localiza_grupo (string as_parametro)
public function boolean wf_localiza_subgrupo (string as_parametro)
public function boolean of_localiza_categoria (string as_parametro)
public function boolean of_localiza_subcategoria (string as_parametro)
public function boolean of_localiza_grupo (string as_parametro)
public function boolean of_localiza_subgrupo (string as_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(This.Cd_Grupo)
SetNull(This.De_Grupo)
SetNull(This.Cd_SubGrupo)
SetNull(This.De_SubGrupo)
SetNull(This.Cd_Categoria)
SetNull(This.De_Categoria)
SetNull(This.Cd_SubCategoria)
SetNull(This.De_SubCategoria)
SetNull(This.cd_grupo_antigo)

end subroutine

public function boolean of_localiza_generica (string as_nivel);String lvs_Retorno

OpenWithParm(w_ge022_Selecao_Classificacao_Produto, as_Nivel)

lvs_Retorno = Message.StringParm

If Not IsNull(lvs_Retorno) Then
	Return This.of_Localiza_Codigo(as_Nivel, lvs_Retorno)
Else
	Return False
End If
end function

public function boolean of_localiza_codigo (string as_nivel, string as_codigo);Boolean lvb_Sucesso = False

Choose Case as_Nivel
	Case "1"
		Select cd_grupo,
				 de_grupo,
				 cd_grupo_antigo
		Into :cd_grupo,
			  :de_grupo,
			  :cd_grupo_antigo
		From grupo
		Where cd_grupo = :as_Codigo
		Using SqlCa;
		
	Case "2"
		Select g.cd_grupo,
				 g.de_grupo,
				 s.cd_subgrupo,
				 s.de_subgrupo,
				 g.cd_grupo_antigo
		Into :cd_grupo,
			  :de_grupo,
			  :cd_subgrupo,
			  :de_subgrupo,
			  :cd_grupo_antigo
		From subgrupo s,
			  grupo g
		Where s.cd_subgrupo = :as_Codigo
		  and g.cd_grupo    = s.cd_grupo
		Using SqlCa;
		
	Case "3"
		Select g.cd_grupo,
				 g.de_grupo,
				 s.cd_subgrupo,
				 s.de_subgrupo,
				 c.cd_categoria,
				 c.de_categoria,
				 g.cd_grupo_antigo
		Into :cd_grupo,
			  :de_grupo,
			  :cd_subgrupo,
			  :de_subgrupo,
			  :cd_categoria,
			  :de_categoria,
			  :cd_grupo_antigo
		From categoria c,
			  subgrupo s,
			  grupo g
		Where c.cd_categoria = :as_Codigo
		  and s.cd_subgrupo  = c.cd_subgrupo
		  and g.cd_grupo     = s.cd_grupo
		Using SqlCa;
		
	Case "4"
		Select g.cd_grupo,
				 g.de_grupo,
				 s.cd_subgrupo,
				 s.de_subgrupo,
				 c.cd_categoria,
				 c.de_categoria,
				 t.cd_subcategoria,
				 t.de_subcategoria,
				 g.cd_grupo_antigo
		Into :cd_grupo,
			  :de_grupo,
			  :cd_subgrupo,
			  :de_subgrupo,
			  :cd_categoria,
			  :de_categoria,
			  :cd_subcategoria,
			  :de_subcategoria,
			  :cd_grupo_antigo
		From subcategoria t,
			  categoria c,
			  subgrupo s,
			  grupo g
		Where t.cd_subcategoria = :as_Codigo
		  and c.cd_categoria = t.cd_categoria
		  and s.cd_subgrupo  = c.cd_subgrupo
		  and g.cd_grupo     = s.cd_grupo
		Using SqlCa;
End Choose

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Classifica$$HEX2$$e700e300$$ENDHEX$$o - Nivel '" + as_Nivel + "'")
End Choose

Return lvb_Sucesso
end function

public function boolean of_localiza (string as_nivel, string as_parametro);Boolean lvb_Sucesso = False

If LenA(as_Parametro) > 0 Then
	If IsNumber(as_Parametro) Then
		lvb_Sucesso = This.of_Localiza_Codigo(as_Nivel, as_Parametro)
	End If
End If

If Not lvb_Sucesso Then
	lvb_Sucesso = This.of_Localiza_Generica(as_Nivel)
End If

Return lvb_Sucesso
end function

public function boolean wf_localiza_grupo (string as_parametro);Return This.of_Localiza("1", as_Parametro)
end function

public function boolean wf_localiza_subgrupo (string as_parametro);Return This.of_Localiza("2", as_Parametro)
end function

public function boolean of_localiza_categoria (string as_parametro);Return This.of_Localiza("3", as_Parametro)
end function

public function boolean of_localiza_subcategoria (string as_parametro);Return This.of_Localiza("4", as_Parametro)
end function

public function boolean of_localiza_grupo (string as_parametro);Return This.of_Localiza("1", as_Parametro)
end function

public function boolean of_localiza_subgrupo (string as_parametro);Return This.of_Localiza("2", as_Parametro)
end function

on uo_classificacao_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_classificacao_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

