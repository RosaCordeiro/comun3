HA$PBExportHeader$uo_produto_abcfarma.sru
forward
global type uo_produto_abcfarma from nonvisualobject
end type
end forward

global type uo_produto_abcfarma from nonvisualobject
end type
global uo_produto_abcfarma uo_produto_abcfarma

type variables
Boolean Localizado

Long Cd_Produto_ABCFarma

String	De_Produto, &
		De_Apresentacao, &
		De_ControlePreco, &
		De_Fabricante, &
		ivs_Descricao_Apresentacao, &
		De_Codigo_Barras
end variables

forward prototypes
public subroutine of_localiza_produto (string ps_parametro)
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_codigo (long pl_produto)
public subroutine of_inicializa ()
public subroutine of_localiza_codigo_barras (string ps_codigo_barras)
end prototypes

public subroutine of_localiza_produto (string ps_parametro);Integer lvi_Tamanho

// Retira os espa$$HEX1$$e700$$ENDHEX$$os em branco
ps_Parametro = Trim(ps_Parametro)

// Verifica o tamanho da string recebida como par$$HEX1$$e200$$ENDHEX$$metro
lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi passado um par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica se o par$$HEX1$$e200$$ENDHEX$$metro recebido $$HEX1$$e900$$ENDHEX$$ num$$HEX1$$e900$$ENDHEX$$rico
	If IsNumber(ps_Parametro) Then
		
		If lvi_Tamanho <= 8 Then
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o pelo c$$HEX1$$f300$$ENDHEX$$digo
			of_Localiza_Codigo(Long(ps_Parametro))
		Else
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o pelo EAN
			of_Localiza_Codigo_Barras(ps_Parametro)
		End If
		
		// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
		// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
		If Not Localizado Then
			of_Localiza_Generica("")
		End If	
		
	Else // Par$$HEX1$$e200$$ENDHEX$$metro recebido $$HEX1$$e900$$ENDHEX$$ string
		
		// Abre a lista de produtos com a descri$$HEX2$$e700e300$$ENDHEX$$o
		// semelhante ao par$$HEX1$$e200$$ENDHEX$$metro recebido
		of_Localiza_Generica(ps_Parametro)
		
	End If
	
Else
	// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
	of_Localiza_Generica("")
End If	
end subroutine

public subroutine of_localiza_generica (string ps_parametro);String lvs_Produto

OpenWithParm(w_ge011_Selecao_Produto_ABCFarma, ps_Parametro)

lvs_Produto = Message.StringParm

If IsNull(lvs_Produto) Then
	Localizado = False
Else
	of_Localiza_Codigo(Long(lvs_Produto))
End If
end subroutine

public subroutine of_localiza_codigo (long pl_produto);Select	cd_produto_abcfarma,
       	de_produto, 
	   	de_apresentacao,
	   	id_controle_preco,
	   	nm_fabricante,
	   	de_codigo_barras
Into	:Cd_Produto_ABCFarma,
		:De_Produto,
	  	:De_Apresentacao,
	  	:De_ControlePreco,
	 	:De_Fabricante,
	  	:De_Codigo_Barras
From produto_abcfarma
Where cd_produto_abcfarma = :pl_Produto
Using SqlCa;
	
If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	ivs_Descricao_Apresentacao = Trim(De_Produto) + " : " + Trim(De_Apresentacao)		
	Localizado = True
End If
end subroutine

public subroutine of_inicializa ();Localizado = False

SetNull(Cd_Produto_ABCFarma)
SetNull(De_Produto)
SetNull(De_Apresentacao)
SetNull(ivs_Descricao_Apresentacao)
SetNull(De_ControlePreco)
SetNull(De_Fabricante)
SetNull(De_Codigo_Barras)
end subroutine

public subroutine of_localiza_codigo_barras (string ps_codigo_barras);Select	cd_produto_abcfarma,
       	de_produto, 
	   	de_apresentacao,
	   	id_controle_preco,
	   	nm_fabricante,
		de_codigo_barras
Into	:Cd_Produto_ABCFarma,
       	:De_Produto,
	  	:De_Apresentacao,
	  	:De_ControlePreco,
	  	:De_Fabricante,
	  	:De_Codigo_Barras
From produto_abcfarma
Where de_codigo_barras = :ps_codigo_barras
Using SqlCa;
	
If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	ivs_Descricao_Apresentacao = Trim(De_Produto) + " : " + Trim(De_Apresentacao)		
	Localizado = True
End If
end subroutine

on uo_produto_abcfarma.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_produto_abcfarma.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

