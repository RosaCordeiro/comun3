HA$PBExportHeader$uo_estabelecimento_cartao.sru
forward
global type uo_estabelecimento_cartao from nonvisualobject
end type
end forward

global type uo_estabelecimento_cartao from nonvisualobject
end type
global uo_estabelecimento_cartao uo_estabelecimento_cartao

type variables
string cd_estabelecimento, &
          nm_estabelecimento

long cd_filial
end variables

forward prototypes
public function boolean of_localiza_codigo (long al_administradora, string as_codigo)
public function boolean of_localiza (long al_administradora, string as_parametro)
public subroutine of_inicializa ()
end prototypes

public function boolean of_localiza_codigo (long al_administradora, string as_codigo);Boolean lvb_Localizado = False

Select e.cd_estabelecimento,
       e.cd_filial,
       f.nm_fantasia
Into :This.cd_estabelecimento,
     :This.cd_filial,
	  :This.nm_estabelecimento
From cartao_estabelecimento e,
     filial f
Where e.cd_administradora  = :al_Administradora
  and e.cd_estabelecimento = :as_Codigo
  and f.cd_filial = e.cd_filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Localizado = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Estabelecimento '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", Information!)
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Estabelecimento")
End Choose

Return lvb_Localizado
end function

public function boolean of_localiza (long al_administradora, string as_parametro);Boolean lvb_Localizado = False

String lvs_Parametro, &
       lvs_Retorno

lvs_Parametro = String(al_Administradora, "000") + as_Parametro

OpenWithParm(w_ge017_Selecao_Estabelecimento_Cartao, lvs_Parametro)

lvs_Retorno = Message.StringParm

If Not IsNull(lvs_Retorno) Then
	lvb_Localizado = This.of_Localiza_Codigo(al_Administradora, lvs_Retorno)
End If		

Return lvb_Localizado
end function

public subroutine of_inicializa ();SetNull(This.Cd_Estabelecimento)
This.Nm_Estabelecimento = ""

SetNull(This.Cd_Filial)
end subroutine

on uo_estabelecimento_cartao.create
TriggerEvent( this, "constructor" )
end on

on uo_estabelecimento_cartao.destroy
TriggerEvent( this, "destructor" )
end on

