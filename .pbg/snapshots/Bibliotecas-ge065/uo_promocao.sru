HA$PBExportHeader$uo_promocao.sru
forward
global type uo_promocao from nonvisualobject
end type
end forward

global type uo_promocao from nonvisualobject
end type
global uo_promocao uo_promocao

type variables
Boolean Localizado

Long cd_promocao

String nm_promocao, &
          id_tipo_promocao, &
          id_situacao, &
          id_filial_altera_estoque, cd_promocao_sap

DateTime dh_inicio,      &
	dh_termino, &
                dh_inicio_estoque_minimo, &
                dh_termino_estoque_minimo

string ivs_tipo, ivs_somente_promocao_filial

long ivl_Filial_Parametro, ivl_Filial_Matriz
string is_id_vending_machine = ''
end variables

forward prototypes
public subroutine of_localiza (string ps_parametro)
public subroutine of_localiza_codigo (long pl_promocao)
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (long pl_promocao, string ps_promocao_sap)
public subroutine of_localiza (string ps_parametro, boolean pb_usa_codigo_sap)
end prototypes

public subroutine of_localiza (string ps_parametro);of_localiza(ps_parametro, false)
end subroutine

public subroutine of_localiza_codigo (long pl_promocao);of_localiza_codigo(pl_promocao,'')
end subroutine

public subroutine of_localiza_generica (string ps_parametro);String lvs_Promocao
st_generica lst_param

ps_Parametro = ivs_Tipo + ivs_Somente_Promocao_Filial + ps_Parametro

if ivl_Filial_Parametro = ivl_Filial_Matriz Then //Matriz

	if is_id_vending_machine <> '' and not isnull(is_id_vending_machine) then
	
		lst_param.string_par[1] = ps_Parametro
		lst_param.string_par[2] = is_id_vending_machine
	
		OpenWithParm(w_ge065_Selecao_Promocao_matriz, lst_param)
	else
		OpenWithParm(w_ge065_Selecao_Promocao_matriz, ps_Parametro)
	end if
else
	
	OpenWithParm(w_ge065_Selecao_Promocao, ps_Parametro)
	
end if

lvs_Promocao = Message.StringParm

If IsNull(lvs_Promocao) Then
	Localizado = False
Else
	of_Localiza_Codigo(Long(lvs_Promocao))
End If
end subroutine

public subroutine of_inicializa ();SetNull(Cd_Promocao)
Nm_Promocao = ''
SetNull(Dh_Inicio)
SetNull(Dh_Termino)
SetNull(Dh_Inicio_Estoque_Minimo)
SetNull(Dh_Termino_Estoque_Minimo)
SetNull(cd_promocao_sap)




end subroutine

public subroutine of_localiza_codigo (long pl_promocao, string ps_promocao_sap);String lvs_Tipo

Long lvl_Produtos_Promocao

If pl_promocao > 0 Then //Procura pelo c$$HEX1$$f300$$ENDHEX$$digo Legado

	if ivl_Filial_Parametro = ivl_Filial_Matriz Then //Matriz
	
		Select cd_promocao_sos,   
				 nm_promocao_sos,   
				 dh_inicio,   
				 dh_termino,  
				 id_tipo_promocao,
				 id_situacao,
				 id_filial_altera_estoque,
				 dh_inicio_estoque_minimo,
				 dh_termino_estoque_minimo,
				 cd_promocao_sap
		Into :cd_promocao,   
			  :nm_promocao,   
			  :dh_inicio,   
			  :dh_termino,   
			  :id_tipo_promocao,
			  :id_situacao,
			  :id_filial_altera_estoque,
			  :dh_inicio_estoque_minimo,
			  :dh_termino_estoque_minimo,
			  :cd_promocao_sap
		From promocao_sos  
		Where cd_promocao_sos = :pl_Promocao
			and ( coalesce(id_vending_machine,'N') = :is_id_vending_machine or :is_id_vending_machine = '' )
		Using SqlCa;
	
	else
	
		Select cd_promocao_sos,   
					 nm_promocao_sos,   
					 dh_inicio,   
					 dh_termino,  
					 id_tipo_promocao,
					 id_situacao,
					 id_filial_altera_estoque,
					 dh_inicio_estoque_minimo,
					 dh_termino_estoque_minimo,
					 cd_promocao_sap
			Into :cd_promocao,   
				  :nm_promocao,   
				  :dh_inicio,   
				  :dh_termino,   
				  :id_tipo_promocao,
				  :id_situacao,
				  :id_filial_altera_estoque,
				  :dh_inicio_estoque_minimo,
				  :dh_termino_estoque_minimo,
				  :cd_promocao_sap
			From promocao_sos  
			Where cd_promocao_sos = :pl_Promocao
			Using SqlCa;
		
	end if
	
elseif not isnull(ps_promocao_sap) and ps_promocao_sap <> '' Then //Procura pelo c$$HEX1$$f300$$ENDHEX$$digo SAP

	if ivl_Filial_Parametro = ivl_Filial_Matriz Then //Matriz
	
		Select cd_promocao_sos,   
			 nm_promocao_sos,   
			 dh_inicio,   
			 dh_termino,  
			 id_tipo_promocao,
			 id_situacao,
			 id_filial_altera_estoque,
			 dh_inicio_estoque_minimo,
			 dh_termino_estoque_minimo,
			 cd_promocao_sap
		Into :cd_promocao,   
			  :nm_promocao,   
			  :dh_inicio,   
			  :dh_termino,   
			  :id_tipo_promocao,
			  :id_situacao,
			  :id_filial_altera_estoque,
			  :dh_inicio_estoque_minimo,
			  :dh_termino_estoque_minimo,
			  :cd_promocao_sap
		From promocao_sos  
		Where cd_promocao_sap = :ps_Promocao_sap
			and ( coalesce(id_vending_machine,'N') = :is_id_vending_machine or :is_id_vending_machine = '' )
		Using SqlCa;
	
	else

		Select cd_promocao_sos,   
			 nm_promocao_sos,   
			 dh_inicio,   
			 dh_termino,  
			 id_tipo_promocao,
			 id_situacao,
			 id_filial_altera_estoque,
			 dh_inicio_estoque_minimo,
			 dh_termino_estoque_minimo,
			 cd_promocao_sap
		Into :cd_promocao,   
			  :nm_promocao,   
			  :dh_inicio,   
			  :dh_termino,   
			  :id_tipo_promocao,
			  :id_situacao,
			  :id_filial_altera_estoque,
			  :dh_inicio_estoque_minimo,
			  :dh_termino_estoque_minimo,
			  :cd_promocao_sap
		From promocao_sos  
		Where cd_promocao_sap = :ps_Promocao_sap
		Using SqlCa;
	
	end if
	
	pl_promocao = cd_promocao
	
end if

Choose Case SqlCa.SqlCode
	Case 0
		
		If ivs_Somente_Promocao_Filial = 'S' Then
			Select count(*)
			Into :lvl_Produtos_Promocao
			From promocao_sos_produto
			Where cd_promocao_sos = :pl_Promocao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos Produtos da Promo$$HEX2$$e700e300$$ENDHEX$$o")
				Localizado = False
				Return
			End If
			
			If lvl_Produtos_Promocao = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o esta liberada para a sua loja.")
				Localizado = False
				Return
			End If			
		End If
		
		If IsNull(This.Id_Filial_Altera_Estoque) Then This.Id_Filial_Altera_Estoque = "N"
		
		If This.ivs_Tipo <> "T" Then
			Choose Case ivs_Tipo  
				Case "N" ; lvs_Tipo = "NORMAL"
				Case "S" ; lvs_Tipo = "SOS"
				Case "F" ; lvs_Tipo = "FARMAGORA"
				Case "P" ; lvs_Tipo = "PLANOGRAMA"
				Case "C" ; lvs_Tipo = "PBM CLAMED"
				Case "V";  lvs_Tipo = "VINCULADA"
				Case "Q";  lvs_Tipo = "PROGRESSIVA"
				Case "J";  lvs_Tipo = "JORNADA - PROGRES"
				Case "M"	;  lvs_Tipo = "CRM"
					
			End Choose
			
			If This.Id_Tipo_Promocao <> This.ivs_Tipo Then
				If (This.Id_Tipo_Promocao = 'G' or This.Id_Tipo_Promocao = 'M') And This.ivs_Tipo = 'N' Then
					Localizado = True
				elseIf (This.Id_Tipo_Promocao = 'J') And This.ivs_Tipo = 'Q' Then
					Localizado = True
				Else
					If ivs_Tipo = 'X' Then 
						Localizado = True
					Else
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o selecionada n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ do tipo '" + lvs_Tipo + "'.", StopSign!)
						Localizado = False
					End If
				End If
			Else
				Localizado = True
			End If
		Else
			Localizado = True
		End If
					
	Case 100
		Localizado = False
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Promo$$HEX2$$e700e300$$ENDHEX$$o")
		Localizado = False
End Choose
end subroutine

public subroutine of_localiza (string ps_parametro, boolean pb_usa_codigo_sap);Integer lvi_Tamanho

lvi_Tamanho = Len(ps_Parametro)

If lvi_Tamanho > 0 Then
	
	if pb_usa_codigo_sap = true Then
		
		of_Localiza_Codigo(0, ps_Parametro)

		If Not Localizado Then
			of_Localiza_Generica("")
		End If
		
	else
	
		If IsNumber(ps_Parametro) Then
			of_Localiza_Codigo(Long(ps_Parametro))
	
			If Not Localizado Then
				of_Localiza_Generica("")
			End If
		Else
			of_Localiza_Generica(ps_Parametro)
		End If
		
	end if
Else
	of_Localiza_Generica("")
End If
end subroutine

on uo_promocao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_promocao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivs_Tipo = "T" // Todas as promo$$HEX2$$e700f500$$ENDHEX$$es

SetNull(cd_promocao)
Nm_Promocao = ""

ivs_Somente_Promocao_Filial = "N"

Select cd_filial, cd_filial_matriz
Into :ivl_Filial_Parametro, :ivl_Filial_Matriz
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial dos par$$HEX1$$e200$$ENDHEX$$metros n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		SetNull(This.ivl_Filial_Parametro)
		SetNull(This.ivl_Filial_Matriz)
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial dos par$$HEX1$$e200$$ENDHEX$$metros." + SqlCa.SqlErrText, StopSign!)
		SetNull(This.ivl_Filial_Parametro)
		SetNull(This.ivl_Filial_Matriz)
End Choose
end event

