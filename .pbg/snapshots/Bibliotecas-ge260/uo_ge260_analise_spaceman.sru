HA$PBExportHeader$uo_ge260_analise_spaceman.sru
forward
global type uo_ge260_analise_spaceman from nonvisualobject
end type
end forward

global type uo_ge260_analise_spaceman from nonvisualobject
end type
global uo_ge260_analise_spaceman uo_ge260_analise_spaceman

type variables
Boolean Localizada

Long nr_analise
Long cd_promocao

String nm_promocao
String de_analise
String is_id_vending_machine = 'N'

dateTime dh_inclusao

Long cd_remanejamento
end variables

forward prototypes
public subroutine of_localiza (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_codigo (long pl_analise)
end prototypes

public subroutine of_localiza (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = Len(ps_Parametro)

If lvi_Tamanho > 0 Then
	If IsNumber(ps_Parametro) Then
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizada Then
			of_Localiza_Generica("")
		End If
	Else
		of_Localiza_Generica(ps_Parametro)
	End If
Else
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_inicializa ();SetNull( Nr_Analise )

de_analise = ''

SetNull( dh_inclusao )


end subroutine

public subroutine of_localiza_generica (string ps_parametro);String ls_Analise
st_generica lst_param

if not isnull( is_id_vending_machine ) and is_id_vending_machine <> '' Then

	lst_param.string_par[1] = ps_Parametro
	lst_param.string_par[2] = is_id_vending_machine
	
	OpenWithParm(w_ge260_selecao_analise, lst_param)
else

	OpenWithParm(w_ge260_selecao_analise, ps_Parametro)	
	
end if

ls_Analise = Message.StringParm

If IsNull(ls_Analise) Then
	Localizada = False
Else
	of_Localiza_Codigo(Long(ls_Analise))
End If
end subroutine

public subroutine of_localiza_codigo (long pl_analise);if isnull( is_id_vending_machine ) or is_id_vending_machine = '' Then

	Select 	a.nr_analise,   
				a.de_analise,
				a.dh_inclusao,
				a.cd_remanejamento
	Into	:nr_analise,
			:de_analise,
			:dh_inclusao,
			:cd_remanejamento
	From analise_spaceman a
	 Where a.nr_analise = :pl_analise
	Using SqlCa;

else
	
	Select 	a.nr_analise,   
				a.de_analise,
				a.dh_inclusao,
				a.cd_remanejamento
	Into	:nr_analise,
			:de_analise,
			:dh_inclusao,
			:cd_remanejamento
	From analise_spaceman a
	 Where a.nr_analise = :pl_analise
		and ( coalesce(a.id_vending_machine,'N') = :is_id_vending_machine )
	Using SqlCa;
	
end if

Choose Case SqlCa.SqlCode
	Case 0
		Localizada = True		
		
	Case 100
		Localizada = False
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da An$$HEX1$$e100$$ENDHEX$$lise Spaceman")
		Localizada = False
End Choose

if Localizada = True and is_id_vending_machine = 'S' Then
	
		Select p.nm_promocao_sos,
				 p.cd_promocao_sos
		into :nm_promocao, 
			  :cd_promocao		
		from analise_spaceman_promocao ap
			inner join promocao_sos p on p.cd_promocao_sos = ap.cd_promocao
		where ap.nr_analise = :nr_analise;
		
		if SQLCA.sqlcode = -1 then
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da An$$HEX1$$e100$$ENDHEX$$lise Spaceman")
			Localizada = False
		end if
			
end if
end subroutine

on uo_ge260_analise_spaceman.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge260_analise_spaceman.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

