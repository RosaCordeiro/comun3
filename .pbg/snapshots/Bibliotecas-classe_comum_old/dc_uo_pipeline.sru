HA$PBExportHeader$dc_uo_pipeline.sru
forward
global type dc_uo_pipeline from userobject
end type
type dw_erro from dc_uo_dw_base within dc_uo_pipeline
end type
type dw_resumo from dc_uo_dw_base within dc_uo_pipeline
end type
type gb_1 from groupbox within dc_uo_pipeline
end type
type gb_erros from groupbox within dc_uo_pipeline
end type
end forward

global type dc_uo_pipeline from userobject
integer width = 1189
integer height = 1280
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_erro dw_erro
dw_resumo dw_resumo
gb_1 gb_1
gb_erros gb_erros
end type
global dc_uo_pipeline dc_uo_pipeline

type variables
dc_uo_pipeline_base ivo_pipeline

transaction ivtr_origem, ivtr_destino
end variables

forward prototypes
public subroutine of_setdataobject (string ps_dataobject)
public function boolean of_start ()
public subroutine of_settransobject (transaction ptr_origem, transaction ptr_destino)
public function long of_registros_lidos ()
public function long of_registros_gravados ()
public function long of_registros_erro ()
public function boolean of_start (long al_parametro)
public function boolean of_start (date adt_data)
public function boolean of_start (long al_parametro, date adt_data)
public function boolean of_start (long pl_filial_origem, long pl_filial_destino, long pl_nota, string ps_especie, string ps_serie)
public function boolean of_start (string as_parametro)
end prototypes

public subroutine of_setdataobject (string ps_dataobject);This.ivo_Pipeline.DataObject = ps_DataObject
end subroutine

public function boolean of_start ();Integer lvi_Retorno

DateTime lvdh_Nulo

SetNull(lvdh_Nulo)

dw_Resumo.Object.Dh_Inicio[1]  = DateTime(Today(), Now())
dw_Resumo.Object.Dh_Termino[1] = lvdh_Nulo

lvi_Retorno = This.ivo_Pipeline.Start(This.ivtr_Origem, This.ivtr_Destino, dw_Erro)

dw_Resumo.Object.Dh_Termino[1] = DateTime(Today(), Now())

If lvi_Retorno < 0 Then
	Return False
Else
	Return True
End If
end function

public subroutine of_settransobject (transaction ptr_origem, transaction ptr_destino);This.ivtr_Origem  = ptr_Origem
This.ivtr_Destino = ptr_Destino
end subroutine

public function long of_registros_lidos ();Return This.dw_Resumo.Object.Qt_Registros_Lidos[1]
end function

public function long of_registros_gravados ();Return This.dw_Resumo.Object.Qt_Registros_Gravados[1]
end function

public function long of_registros_erro ();Return This.dw_Resumo.Object.Qt_Registros_Erro[1]
end function

public function boolean of_start (long al_parametro);Integer lvi_Retorno

DateTime lvdh_Nulo

SetNull(lvdh_Nulo)

dw_Resumo.Object.Dh_Inicio [1] = DateTime(Today(), Now())
dw_Resumo.Object.Dh_Termino[1] = lvdh_Nulo

lvi_Retorno = This.ivo_Pipeline.Start(This.ivtr_Origem, This.ivtr_Destino, dw_Erro, al_Parametro)

dw_Resumo.Object.Dh_Termino[1] = DateTime(Today(), Now())

If lvi_Retorno < 0 Then
	Return False
Else
	Return True
End If
end function

public function boolean of_start (date adt_data);Integer lvi_Retorno

DateTime lvdh_Nulo

SetNull(lvdh_Nulo)

dw_Resumo.Object.Dh_Inicio [1] = DateTime(Today(), Now())
dw_Resumo.Object.Dh_Termino[1] = lvdh_Nulo

lvi_Retorno = This.ivo_Pipeline.Start(This.ivtr_Origem, This.ivtr_Destino, dw_Erro, adt_Data)

dw_Resumo.Object.Dh_Termino[1] = DateTime(Today(), Now())

If lvi_Retorno < 0 Then
	Return False
Else
	Return True
End If
end function

public function boolean of_start (long al_parametro, date adt_data);Integer lvi_Retorno

DateTime lvdh_Nulo

SetNull(lvdh_Nulo)

dw_Resumo.Object.Dh_Inicio [1] = DateTime(Today(), Now())
dw_Resumo.Object.Dh_Termino[1] = lvdh_Nulo

lvi_Retorno = This.ivo_Pipeline.Start(This.ivtr_Origem, This.ivtr_Destino, dw_Erro, al_Parametro, adt_Data)

dw_Resumo.Object.Dh_Termino[1] = DateTime(Today(), Now())

If lvi_Retorno < 0 Then
	Return False
Else
	Return True
End If
end function

public function boolean of_start (long pl_filial_origem, long pl_filial_destino, long pl_nota, string ps_especie, string ps_serie);Integer lvi_Retorno

lvi_Retorno = This.ivo_Pipeline.Start(This.ivtr_Origem, This.ivtr_Destino, dw_erro, pl_filial_origem, &
												  pl_filial_destino, pl_nota, ps_especie, ps_serie)

If lvi_Retorno < 0 Then
	Return False
Else
	Return True
End If
end function

public function boolean of_start (string as_parametro);Integer lvi_Retorno

DateTime lvdh_Nulo

SetNull(lvdh_Nulo)

dw_Resumo.Object.Dh_Inicio [1] = DateTime(Today(), Now())
dw_Resumo.Object.Dh_Termino[1] = lvdh_Nulo

lvi_Retorno = This.ivo_Pipeline.Start(This.ivtr_Origem, This.ivtr_Destino, dw_Erro, as_Parametro)

dw_Resumo.Object.Dh_Termino[1] = DateTime(Today(), Now())

If lvi_Retorno < 0 Then
	Return False
Else
	Return True
End If
end function

on dc_uo_pipeline.create
this.dw_erro=create dw_erro
this.dw_resumo=create dw_resumo
this.gb_1=create gb_1
this.gb_erros=create gb_erros
this.Control[]={this.dw_erro,&
this.dw_resumo,&
this.gb_1,&
this.gb_erros}
end on

on dc_uo_pipeline.destroy
destroy(this.dw_erro)
destroy(this.dw_resumo)
destroy(this.gb_1)
destroy(this.gb_erros)
end on

event constructor;ivo_Pipeline = Create dc_uo_Pipeline_Base

ivo_Pipeline.ivdw_Resumo = dw_Resumo

dw_Resumo.Event ue_AddRow()
end event

event destructor;Destroy(ivo_Pipeline)
end event

type dw_erro from dc_uo_dw_base within dc_uo_pipeline
integer x = 46
integer y = 572
integer width = 1083
integer height = 648
integer taborder = 30
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_resumo from dc_uo_dw_base within dc_uo_pipeline
integer x = 32
integer y = 60
integer width = 1111
integer height = 436
boolean bringtotop = true
string dataobject = "dc_dw_pipeline"
end type

type gb_1 from groupbox within dc_uo_pipeline
integer x = 14
integer width = 1143
integer height = 512
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Resumo"
borderstyle borderstyle = styleraised!
end type

type gb_erros from groupbox within dc_uo_pipeline
integer x = 14
integer y = 512
integer width = 1143
integer height = 736
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Erros"
borderstyle borderstyle = styleraised!
end type

