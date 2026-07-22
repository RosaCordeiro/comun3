HA$PBExportHeader$uo_dependente_conveniado.sru
forward
global type uo_dependente_conveniado from nonvisualobject
end type
end forward

global type uo_dependente_conveniado from nonvisualobject
end type
global uo_dependente_conveniado uo_dependente_conveniado

type variables
Boolean Localizado

LONG     cd_convenio,  &
               cd_dependente

STRING cd_conveniado, &
               nm_conveniado, &
               nm_convenio

String nm_dependente, &
          de_relacao_dependencia	

long 	ivl_convenio, &
		ivl_filial_parametro, &
		ivl_filial_matriz

string ivs_conveniado, &
         ivs_dependente
end variables

forward prototypes
public subroutine of_localiza_codigo (long pl_convenio, string ps_conveniado, long pl_dependente)
public subroutine of_localiza_dependente (long pl_convenio, string ps_conveniado, string ps_dependente)
public subroutine of_localiza_generica (long pl_convenio, string ps_conveniado, string ps_parametro)
public subroutine of_localiza_codigo_filial (long pl_convenio, string ps_conveniado, long pl_dependente)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_codigo (long pl_convenio, string ps_conveniado, long pl_dependente);Select dep.cd_dependente,
       dep.nm_dependente,
       dep.de_relacao_dependencia
Into :This.cd_dependente,
     :This.nm_dependente,
     :This.de_relacao_dependencia
From dependente_conveniado dep
Where dep.cd_convenio   = :pl_convenio
  and dep.cd_conveniado = :ps_conveniado 
  and dep.cd_dependente = :pl_dependente;
  
Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True		
	Case 100
		Localizado = False		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do dependente do conveniado." + SqlCa.SqlErrText, StopSign!)
		Localizado = False
End Choose
end subroutine

public subroutine of_localiza_dependente (long pl_convenio, string ps_conveniado, string ps_dependente);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Dependente)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then		
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Dependente) And LenA(ps_Dependente) <= 4 Then		
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do dependente
		of_Localiza_Codigo(pl_Convenio, ps_Conveniado, Long(ps_Dependente))

		If Not Localizado Then
			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica(pl_Convenio, ps_Conveniado, "")	
		End If	
	Else	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		of_Localiza_Generica(pl_Convenio, ps_Conveniado, ps_Dependente)
	End If	
Else	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica(pl_Convenio, ps_Conveniado, "")
End If

end subroutine

public subroutine of_localiza_generica (long pl_convenio, string ps_conveniado, string ps_parametro);String lvs_Dependente

This.ivl_Convenio   = pl_Convenio
This.ivs_Conveniado = ps_Conveniado
This.ivs_Dependente = ps_Parametro

OpenWithParm(w_ge034_Selecao_Dependente_Conveniado, This)

lvs_Dependente = Message.StringParm

If Not IsNull(lvs_Dependente) Then
	If This.ivl_Filial_Parametro = This.ivl_Filial_Matriz Then
		of_Localiza_Codigo(pl_Convenio, ps_Conveniado, Long(lvs_Dependente))
	Else
		of_Localiza_Codigo_Filial(pl_Convenio, ps_Conveniado, Long(lvs_Dependente))
	End If
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_codigo_filial (long pl_convenio, string ps_conveniado, long pl_dependente);//Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais usada porque $$HEX1$$e900$$ENDHEX$$ feita a verifica$$HEX2$$e700e300$$ENDHEX$$o de bloqueios em outro momento na venda.

Select dep.cd_dependente,
       dep.nm_dependente,
       dep.de_relacao_dependencia
Into :This.cd_dependente,
     :This.nm_dependente,
     :This.de_relacao_dependencia
From dependente_conveniado dep
Where dep.cd_convenio   = :pl_convenio
  and dep.cd_conveniado = :ps_conveniado 
  and dep.cd_dependente = :pl_dependente
  and not Exists ( Select b.cd_dependente
			             From bloqueio b
                          inner join motivo_bloqueio m on m.cd_motivo_bloqueio 	= b.cd_motivo_bloqueio 
														   and m.id_permite_visualizacao = 'N' 
				          Where b.cd_convenio   		= dep.cd_convenio
					    	  and b.cd_conveniado 		= dep.cd_conveniado
					       and b.cd_dependente 		= dep.cd_dependente 
		              	  and b.dh_liberacao is null );
  
Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True		
	Case 100
		Localizado = False		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do dependente do conveniado." + SqlCa.SqlErrText, StopSign!)
		Localizado = False
End Choose
end subroutine

public subroutine of_inicializa ();Localizado = False

SetNull( cd_convenio )
SetNull( cd_dependente )
SetNull( cd_conveniado )
SetNull( nm_conveniado )
SetNull( nm_convenio )
SetNull( nm_dependente )
SetNull( de_relacao_dependencia )
SetNull( ivl_convenio )
SetNull( ivl_filial_parametro )
SetNull( ivl_filial_matriz )
SetNull( ivs_conveniado )
SetNull( ivs_dependente )
end subroutine

on uo_dependente_conveniado.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_dependente_conveniado.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Select cd_filial, 
       cd_filial_matriz
Into :This.ivl_Filial_Parametro,
     :This.ivl_Filial_Matriz
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
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

