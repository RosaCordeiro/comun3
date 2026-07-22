HA$PBExportHeader$w_ge188_consulta_tarefas_automaticas_resp.srw
forward
global type w_ge188_consulta_tarefas_automaticas_resp from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge188_consulta_tarefas_automaticas_resp
end type
type dw_2 from dc_uo_dw_base within w_ge188_consulta_tarefas_automaticas_resp
end type
end forward

global type w_ge188_consulta_tarefas_automaticas_resp from dc_w_response
integer width = 8059
integer height = 2592
string title = "GE188 - Consulta $$HEX1$$da00$$ENDHEX$$ltima Tarefas Automatica"
windowstate windowstate = maximized!
boolean center = true
dw_1 dw_1
dw_2 dw_2
end type
global w_ge188_consulta_tarefas_automaticas_resp w_ge188_consulta_tarefas_automaticas_resp

type variables
Long MaxWidth
Long MaxHeight

Integer ivl_Tolerancia = 90
end variables

on w_ge188_consulta_tarefas_automaticas_resp.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_ge188_consulta_tarefas_automaticas_resp.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

event resize;call super::resize;/*
If MaxWidth > 0 Then
	//Ajusta a largura da Datawindow com a nova largura da tela - 80
	Dw_1.Width = NewWidth - Dw_1.X - 80
	//Ajusta a largura da Datawindow com a nova largura da tela - 80
End If

If MaxHeight > 0 Then
	//Ajusta a altura do GroupBox com a nova altura da tela - altura dos filtros
	//Ajusta a altura da Datawindow com a nova altura da tela - altura dos filtros
	Dw_1.Height = NewHeight - Dw_1.Y - 80
End If

*/
end event

event ue_preopen;call super::ue_preopen;dw_1.SetRedraw( False )
MaxHeight = 9000
end event

event ue_postopen;call super::ue_postopen;dw_2.InsertRow(0)

dw_1.X = (This.WorkSpaceWidth() - dw_1.Width ) / 2
dw_2.X = (This.WorkSpaceWidth() - dw_2.Width ) / 2
dw_1.Height = (This.WorkSpaceHeight() - dw_2.Height - 200)

dw_2.Y = (This.WorkSpaceHeight() - dw_2.Height - 100)

dw_1.Event ue_Retrieve()

dw_2.Object.st_ultimo_refresh.visible = True
end event

event timer;call super::timer;dw_1.Event ue_Retrieve()
end event

event open;call super::open;Timer(90)
end event

type pb_help from dc_w_response`pb_help within w_ge188_consulta_tarefas_automaticas_resp
end type

type dw_1 from dc_uo_dw_base within w_ge188_consulta_tarefas_automaticas_resp
integer width = 8041
integer height = 2156
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge188_lista_resp"
boolean vscrollbar = true
string ivs_cor_linha_padrao = ""
end type

event constructor;call super::constructor;//This.of_setrowselection("~tIf(getrow()= currentRow(), rgb(0,128,128),If(Today() > dh_limite  , rgb(255,0,0),rgb(255,255,255)))", "~tIf(getrow()= currentRow(),rgb(255,255,255),rgb(0,0,0))")

This.ivb_Ordena_Colunas = True
end event

event ue_postretrieve;call super::ue_postretrieve;Decimal ldc_Pc_Log_Used

Long ll_Diferenca,&
		ll_contagem
		
This.SetRedraw(False)

Open( w_Aguarde )

ldc_Pc_Log_Used = SqlCa.of_Get_Sybase_Pc_Log_In_Use( )
dw_2.Object.pc_Log_Usado[1] = ldc_Pc_Log_Used
dw_2.Object.qt_agendamento_total[1] = dw_1.RowCount()


SELECT count(*) 
INTO :ll_Diferenca
FROM master..sysprocesses
USING SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_msgdberror( )
	Case Else
		dw_2.Object.qt_conexoes_syb[1] = ll_Diferenca
End Choose

SELECT count(distinct(p.hostname))
INTO :ll_contagem
FROM master..syslocks l
JOIN master..sysprocesses p ON l.spid = p.spid
WHERE p.blocked > 1
AND time_blocked > 1
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_msgdberror( )
	Case Else
		dw_2.Object.qt_travamento_online[1] = ll_contagem
End Choose


Close( w_Aguarde )

This.SetRedraw(True)

Return pl_Linhas
end event

event ue_preretrieve;call super::ue_preretrieve;Return AncestorReturnValue
end event

event ue_retrieve;// OverRide
If Not SqlCa.of_Isconnected( ) Then
	gvo_Aplicacao.of_Connect( )
End If

This.of_settransobject( SqlCa )

SUPER::EVENT ue_retrieve( )

dw_2.Object.st_ultimo_refresh.Text = "$$HEX1$$da00$$ENDHEX$$ltimo refresh: " + String( gf_getServerDate ( ), "dd/mm hh:mm:ss" )

If SqlCa.of_Isconnected( ) Then
	SqlCa.of_Disconnect( )
End If

Return 1
end event

type dw_2 from dc_uo_dw_base within w_ge188_consulta_tarefas_automaticas_resp
integer x = 14
integer y = 2156
integer width = 8023
integer height = 336
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_ge188_logs"
end type

