HA$PBExportHeader$uo_ncm.sru
forward
global type uo_ncm from nonvisualobject
end type
end forward

global type uo_ncm from nonvisualobject
end type
global uo_ncm uo_ncm

type variables
Boolean Localizado = False

Long Nr_NCM
String De_NCM
String Id_Pis_Cofins

Decimal{2} Pc_IPI

Boolean Situacao_Especial = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza (long pl_ncm, string ps_parametro)
public function boolean of_localiza_codigo (long pl_ncm)
public function Boolean of_atualiza ()
end prototypes

public subroutine of_inicializa ();Localizado = False
SetNull(Nr_NCM)
SetNull(De_NCM)
SetNull(Id_Pis_Cofins)
SetNull(Pc_IPI)
Situacao_Especial = False
end subroutine

public function boolean of_localiza (string ps_parametro);Long lvl_Null

SetNull(lvl_Null)

Return Of_Localiza(lvl_Null, ps_parametro)
end function

public function boolean of_localiza (long pl_ncm, string ps_parametro);String lvs_Parm

If IsNumber(Trim(ps_parametro)) Then
	If This.Of_Localiza_Codigo(Long(ps_parametro)) Then
		If Localizado Then
			Return True
		End If
	End If
End If

If IsNull(pl_ncm) Then 
	lvs_Parm = ';'
Else 
	lvs_Parm = String(pl_ncm)+';'
End If

lvs_Parm += ps_parametro

OpenWithParm(w_ge021_selecao_ncm,lvs_Parm)
ps_parametro = Message.StringParm

If IsNumber(Trim(ps_parametro)) Then
	If This.Of_Localiza_Codigo(Long(ps_parametro)) Then
		If Localizado Then
			Return True
		End If
	End If
End If

Return Localizado
end function

public function boolean of_localiza_codigo (long pl_ncm);Long lvl_NCM
Long lvl_Sit
String lvs_NCM
String lvs_Pis_Cofins

Decimal{2} lvdc_Pc_IPI

This.Of_Inicializa()

select de_ncm, nr_ncm, pc_ipi, id_lista_pis_cofins
Into :lvs_NCM, :lvl_NCM, :lvdc_Pc_IPI, :lvs_Pis_Cofins
From ncm
Where nr_ncm = :pl_ncm
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	Localizado		= True
	Nr_NCM			= lvl_NCM
	De_NCM			= lvs_NCM
	Id_Pis_Cofins	= lvs_Pis_Cofins
	Pc_IPI				= lvdc_Pc_IPI
End If 

select count(1)
Into :lvl_Sit
From ncm_situacao_especial
Where nr_ncm = :pl_ncm
Using SQLCa;

Situacao_Especial = (lvl_Sit > 0)

Return Localizado
end function

public function Boolean of_atualiza ();Return This.Of_localiza_codigo(This.nr_ncm)
end function

on uo_ncm.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ncm.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

