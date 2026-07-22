HA$PBExportHeader$dc_uo_pipeline_base.sru
forward
global type dc_uo_pipeline_base from pipeline
end type
end forward

global type dc_uo_pipeline_base from pipeline
end type
global dc_uo_pipeline_base dc_uo_pipeline_base

type variables
dc_uo_dw_base ivdw_resumo
end variables

on dc_uo_pipeline_base.create
call pipeline::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_pipeline_base.destroy
call pipeline::destroy
TriggerEvent( this, "destructor" )
end on

event pipemeter;ivdw_Resumo.Object.Qt_Registros_Lidos[1]    = RowsRead
ivdw_Resumo.Object.Qt_Registros_Gravados[1] = RowsWritten - RowsInError
ivdw_Resumo.Object.Qt_Registros_Erro[1]     = RowsInError
end event

