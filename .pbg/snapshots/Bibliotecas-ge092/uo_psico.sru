HA$PBExportHeader$uo_psico.sru
forward
global type uo_psico from nonvisualobject
end type
end forward

global type uo_psico from nonvisualobject
end type
global uo_psico uo_psico

forward prototypes
public function boolean of_verifica_data_final_sngpc (ref date pdt_fim_movimento)
end prototypes

public function boolean of_verifica_data_final_sngpc (ref date pdt_fim_movimento);DateTime ldh_data

Select coalesce(max(dt_fim_movimento), '20000101')
  Into :ldh_data
  From sngpc_historico_arquivo
Where id_aceito <> 'N'
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError('LOCALIZA$$HEX2$$c700c200$$ENDHEX$$O')
	Return False
End If
 
pdt_fim_movimento = Date(ldh_data)

Return True
end function

on uo_psico.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_psico.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

