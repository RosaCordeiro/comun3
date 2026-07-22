HA$PBExportHeader$uo_subgrupo_produto.sru
forward
global type uo_subgrupo_produto from nonvisualobject
end type
end forward

global type uo_subgrupo_produto from nonvisualobject
end type
global uo_subgrupo_produto uo_subgrupo_produto

type variables
Boolean Localizado

Long cd_grupo_produto, &
         cd_subgrupo_produto

String de_subgrupo_produto

long ivl_grupo

string ivs_parametro
end variables

forward prototypes
public subroutine of_localiza (long pl_categoria, string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (long pl_grupo, long pl_subgrupo)
public subroutine of_localiza_generica (long pl_grupo, string ps_parametro)
end prototypes

public subroutine of_localiza (long pl_categoria, string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da cidade
		of_Localiza_Codigo(pl_Categoria, Long(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica(pl_Categoria, "")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		of_Localiza_Generica(pl_Categoria, ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica(pl_Categoria, "")
End If
end subroutine

public subroutine of_inicializa ();SetNull(This.Cd_Grupo_Produto)
SetNull(This.Cd_SubGrupo_Produto)
SetNull(This.De_SubGrupo_Produto)
end subroutine

public subroutine of_localiza_codigo (long pl_grupo, long pl_subgrupo);Select cd_grupo_produto,
       cd_subgrupo_produto,
       de_subgrupo_produto
Into :cd_grupo_produto,
     :cd_subgrupo_produto,
     :de_subgrupo_produto
From subgrupo_produto
Where cd_grupo_produto    = :pl_Grupo
  and cd_subgrupo_produto = :pl_SubGrupo;

Choose Case SqlCa.SqlCode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do subgrupo." + SqlCa.SqlErrText, StopSign!)
		Localizado = False
	Case 100
		Localizado = False
	Case 0
		Localizado = True
End Choose
end subroutine

public subroutine of_localiza_generica (long pl_grupo, string ps_parametro);String lvs_SubGrupo

This.ivl_Grupo     = pl_Grupo
This.ivs_Parametro = ps_Parametro

OpenWithParm(w_ge057_Selecao_SubGrupo_Produto, This)

lvs_SubGrupo = Message.StringParm

If Not IsNull(lvs_SubGrupo) Then
	of_Localiza_Codigo(pl_Grupo, Long(lvs_SubGrupo))
Else
	Localizado = False
End If
end subroutine

on uo_subgrupo_produto.create
TriggerEvent( this, "constructor" )
end on

on uo_subgrupo_produto.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;This.of_Inicializa()
end event

