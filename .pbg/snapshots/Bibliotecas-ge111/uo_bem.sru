HA$PBExportHeader$uo_bem.sru
forward
global type uo_bem from nonvisualobject
end type
end forward

global type uo_bem from nonvisualobject
end type
global uo_bem uo_bem

type variables
Long ivl_Filial_Parametro

Boolean Localizado

DateTime dh_aquisicao

Decimal vl_bem

Long cd_filial

String cd_bem, &
          cd_plaqueta, &
          de_bem, &
          cd_unidade_medida, &
          cd_conta_contabil, &
          id_tipo_bem, &
          cd_bem_principal


end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_bem (string as_parametro)
public function boolean of_localiza_bem (string as_parametro, long al_filial)
public function boolean of_localiza_generica (string as_parametro)
public function boolean of_localiza_codigo (string as_plaqueta)
public function boolean of_localiza_codigo (string as_plaqueta, long al_filial)
end prototypes

public subroutine of_inicializa ();//Parametro s$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ alimentado na Matriz, onde h$$HEX1$$e100$$ENDHEX$$ a possibilidade de escolher a filial
SetNull(ivl_Filial_Parametro)

vl_bem = 0.00

SetNull(cd_filial)

SetNull(dh_aquisicao)
SetNull(cd_bem)
SetNull(cd_plaqueta)
SetNull(de_bem)
SetNull(cd_unidade_medida)
SetNull(cd_conta_contabil)

This.Localizado = False
end subroutine

public function boolean of_localiza_bem (string as_parametro);Integer lvi_Tamanho, i

Localizado = False

// Retira os espa$$HEX1$$e700$$ENDHEX$$os em branco
as_Parametro = Trim(as_Parametro)

// Verifica o tamanho da string recebida como par$$HEX1$$e200$$ENDHEX$$metro
lvi_Tamanho = LenA(as_Parametro)

// Verifica se foi passado um par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o pelo c$$HEX1$$f300$$ENDHEX$$digo do bem
	This.of_Localiza_Codigo(as_Parametro)
				
	// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelo m$$HEX1$$e900$$ENDHEX$$todo anterior
	// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
	If Not Localizado Then
		This.of_Localiza_Generica(as_Parametro)
	End If
Else
	// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
	This.of_Localiza_Generica("")
End If	

Return Localizado
end function

public function boolean of_localiza_bem (string as_parametro, long al_filial);ivl_Filial_Parametro = al_Filial

Return This.of_localiza_bem(as_parametro)
end function

public function boolean of_localiza_generica (string as_parametro);String lvs_Bem

This.de_bem = as_parametro

OpenWithParm(w_ge111_Selecao_Bem, This)

lvs_Bem = Message.StringParm

If IsNull(lvs_Bem) Then
	This.Localizado = False
Else
	This.of_Localiza_Codigo(lvs_Bem)
End If

Return Localizado
end function

public function boolean of_localiza_codigo (string as_plaqueta);Long lvl_Filial

If Not IsNull(ivl_Filial_Parametro) And ivl_Filial_Parametro <> 0 Then
	lvl_Filial = ivl_Filial_Parametro
Else
	lvl_Filial = gvo_Parametro.of_Filial()
End If

Return This.Of_Localiza_codigo(as_plaqueta, lvl_Filial)
end function

public function boolean of_localiza_codigo (string as_plaqueta, long al_filial);Select	cd_bem,
			cd_plaqueta,
			de_bem,
			cd_unidade_medida,
			cd_conta_contabil,
			cd_filial,
			vl_bem,
			dh_aquisicao,
			coalesce(id_tipo,'1') as id_tipo,
			cd_bem_principal
Into	:cd_bem,
		:cd_plaqueta,
		:de_bem,
		:cd_unidade_medida,
		:cd_conta_contabil,
		:cd_filial,
		:vl_bem,
		:dh_aquisicao, 
         :id_tipo_bem, 
         :cd_bem_principal
From bem
Where cd_plaqueta = :as_plaqueta
  And cd_filial = :al_filial
  And dh_baixa is null
Using SqlCa;

Choose Case SqlCa.SqlCode	
	Case 100
		Localizado = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do bem." + SqlCa.SqlErrText, StopSign!, Ok!)
		Localizado = False
	Case 0
		Localizado = True
End Choose

Return Localizado
end function

on uo_bem.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_bem.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

