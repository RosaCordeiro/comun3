HA$PBExportHeader$uo_cest.sru
forward
global type uo_cest from nonvisualobject
end type
end forward

global type uo_cest from nonvisualobject
end type
global uo_cest uo_cest

type variables
String	De_Cest
String	Cd_Cest

Boolean Localizado = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (string ps_cest)
public function boolean of_localiza (string ps_cest, string ps_parametro, long pl_ncm, string ps_lista, string ps_tipo)
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_cest_ncm (long pl_ncm, string ps_pis_cofins, string ps_lei_generico)
public function boolean of_valida_cest_ncm (string ps_cest, long pl_ncm)
public function boolean of_localiza_cest_produto (long al_produto, ref string as_cest)
end prototypes

public subroutine of_inicializa ();SetNull(De_Cest)
SetNull(Cd_Cest)

Localizado = False
end subroutine

public function boolean of_localiza_codigo (string ps_cest);String lvs_Cd_Cest
String lvs_De_Cest

This.Of_Inicializa()

ps_cest = gf_replace(ps_cest,'.','',0)

Select cd_cest, de_cest
Into :lvs_Cd_Cest, :lvs_De_Cest
from cest
Where cd_cest = :ps_cest
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	De_Cest = lvs_De_Cest
	Cd_Cest = lvs_Cd_Cest
	
	Localizado = True
End If

Return Localizado
end function

public function boolean of_localiza (string ps_cest, string ps_parametro, long pl_ncm, string ps_lista, string ps_tipo);String lvs_Parm

This.Of_Inicializa()

If (Len(ps_parametro)=9) and Pos(ps_parametro,'.')>0 Then ps_parametro = gf_replace(ps_parametro,'.','',0)

If IsNumber(ps_parametro)and(Len(Trim(ps_parametro))=7) Then
	If This.Of_Localiza_Codigo(Trim(ps_parametro)) Then
		If Localizado Then
			Return True
		End If
	End If
End If

//C$$HEX1$$f300$$ENDHEX$$digo CEST Atual
If Not IsNull(ps_cest) Then 
	lvs_Parm = ps_cest
End If

//Texto Filtro
lvs_Parm += ';'
lvs_Parm += ps_parametro

//NCM
lvs_Parm += ';'
If Not IsNull(pl_ncm) Then 
	lvs_Parm += String(pl_ncm)
End If

//Lista Classifica$$HEX2$$e700e300$$ENDHEX$$o PIS / COFINS
lvs_Parm += ';'
If Not IsNull(ps_lista) Then 
	lvs_Parm += ps_lista
End If

//Tipo Medicamento = Classifica$$HEX2$$e700e300$$ENDHEX$$o Lei Gen$$HEX1$$e900$$ENDHEX$$rico
lvs_Parm += ';'
If Not IsNull(ps_tipo) Then 
	lvs_Parm += ps_tipo
End If

OpenWithParm(w_ge021_selecao_cest,lvs_Parm)
ps_parametro = Message.StringParm

If (Trim(ps_parametro)<>'') Then
	If This.Of_Localiza_Codigo(ps_parametro) Then
		If Localizado Then
			Return True
		End If
	End If
End If

Return Localizado
end function

public function boolean of_localiza (string ps_parametro);Long lvl_Null

SetNull(lvl_Null)

Return This.Of_localiza( '',ps_parametro,lvl_Null, '', '')
end function

public function boolean of_localiza_cest_ncm (long pl_ncm, string ps_pis_cofins, string ps_lei_generico);String lvs_Cest = ''
Long lvl_Count

If Not IsNull(ps_lei_generico) and (ps_lei_generico <> '') Then
	If ps_lei_generico = "E" then ps_lei_generico = "S"
	
	Select coalesce(count(1),0)
	Into :lvl_Count
	From cest_ncm
	Where ((nr_ncm_inicial = :pl_ncm and nr_ncm_final is null)
			or (nr_ncm_inicial <=  :pl_ncm and nr_ncm_final >= :pl_ncm))
		and id_lista_pis_cofins = :ps_pis_cofins
		and id_tipo_produto = :ps_lei_generico
	Using SQLCa;

	If lvl_Count = 1 Then
		Select cd_cest
		Into :lvs_Cest
		From cest_ncm
		Where ((nr_ncm_inicial = :pl_ncm and nr_ncm_final is null)
				or (nr_ncm_inicial <=  :pl_ncm and nr_ncm_final >= :pl_ncm))
			and id_lista_pis_cofins = :ps_pis_cofins
			and id_tipo_produto = :ps_lei_generico
		Using SQLCa;		
	End If
End if

If (lvs_Cest = '')and(Not IsNull(ps_pis_cofins) and (ps_pis_cofins<>'')) Then
	Select coalesce(count(1),0)
	Into :lvl_Count
	From cest_ncm
	Where ((nr_ncm_inicial = :pl_ncm and nr_ncm_final is null)
		or (nr_ncm_inicial <=  :pl_ncm and nr_ncm_final >= :pl_ncm))
		and id_lista_pis_cofins = :ps_pis_cofins
	Using SQLCa;

	If lvl_Count = 1 Then
		Select cd_cest
		Into :lvs_Cest
		From cest_ncm
		Where ((nr_ncm_inicial = :pl_ncm and nr_ncm_final is null)
			or (nr_ncm_inicial <=  :pl_ncm and nr_ncm_final >= :pl_ncm))
		and id_lista_pis_cofins = :ps_pis_cofins
		Using SQLCa;		
	End If
End If

If (lvs_Cest = '') Then
	Select coalesce(count(1),0)
	Into :lvl_Count
	From cest_ncm
	Where ((nr_ncm_inicial = :pl_ncm and nr_ncm_final is null)
		or (nr_ncm_inicial <=  :pl_ncm and nr_ncm_final >= :pl_ncm))
	Using SQLCa;

	If lvl_Count = 1 Then
		Select cd_cest
		Into :lvs_Cest
		From cest_ncm
		Where ((nr_ncm_inicial = :pl_ncm and nr_ncm_final is null)
			or (nr_ncm_inicial <=  :pl_ncm and nr_ncm_final >= :pl_ncm))
		Using SQLCa;		
	End If
End If

Return This.Of_localiza_codigo(lvs_Cest)
end function

public function boolean of_valida_cest_ncm (string ps_cest, long pl_ncm);Long lvl_Count = 0

String lvs_Where = ''

If (Not IsNull(pl_ncm)) and (pl_ncm >= 0) Then
	
	select count(1)
	Into :lvl_Count
	From cest c
	Where c.cd_cest = :ps_cest
		and (exists (select 1 from cest_ncm cn1 where cn1.cd_cest = c.cd_cest and cn1.nr_ncm_inicial = :pl_ncm and cn1.nr_ncm_final is null)
		 	or exists (select 1 from cest_ncm cn1 where cn1.cd_cest = c.cd_cest and cn1.nr_ncm_inicial <= :pl_ncm and cn1.nr_ncm_final >=:pl_ncm))
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o cest." )
		lvl_Count = 0
	End If
End If

Return lvl_Count > 0
end function

public function boolean of_localiza_cest_produto (long al_produto, ref string as_cest);String ls_Cest
SetNull(ls_Cest)

Select 	cd_cest
Into		:ls_Cest
From	 	produto_geral
Where	cd_produto = :al_produto
Using SqlCA;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o cest do Produto." )
End If


If ls_Cest<>'' or Not IsNull(ls_Cest) or ls_Cest<>'0000000'    Then 
	as_cest = ls_Cest
Else
	SetNull(as_cest)
End If 

Return True 
end function

on uo_cest.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cest.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

