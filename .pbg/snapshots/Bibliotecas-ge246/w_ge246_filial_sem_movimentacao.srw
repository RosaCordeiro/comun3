HA$PBExportHeader$w_ge246_filial_sem_movimentacao.srw
forward
global type w_ge246_filial_sem_movimentacao from dc_w_selecao_lista_relatorio
end type
type cb_exportacao_cheque from commandbutton within w_ge246_filial_sem_movimentacao
end type
end forward

global type w_ge246_filial_sem_movimentacao from dc_w_selecao_lista_relatorio
string accessiblename = "Consulta Filiais sem Movimenta$$HEX2$$e700e300$$ENDHEX$$o (GE246)"
integer width = 2930
integer height = 1844
string title = "GE246 - Consulta de Filiais sem Movimenta$$HEX2$$e700e300$$ENDHEX$$o"
cb_exportacao_cheque cb_exportacao_cheque
end type
global w_ge246_filial_sem_movimentacao w_ge246_filial_sem_movimentacao

on w_ge246_filial_sem_movimentacao.create
int iCurrent
call super::create
this.cb_exportacao_cheque=create cb_exportacao_cheque
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_exportacao_cheque
end on

on w_ge246_filial_sem_movimentacao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_exportacao_cheque)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dt_Movimentacao[1] = RelativeDate( Today(), -1 )
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge246_filial_sem_movimentacao
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge246_filial_sem_movimentacao
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge246_filial_sem_movimentacao
integer x = 18
integer y = 312
integer width = 2848
integer height = 1308
string text = "Lista de Filiais"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge246_filial_sem_movimentacao
integer x = 18
integer y = 0
integer width = 2016
integer height = 308
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge246_filial_sem_movimentacao
integer x = 41
integer y = 52
integer width = 1975
integer height = 236
string dataobject = "dw_ge246_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = 'id_log_fechamento' Then
	If Data = 'S' Then
		dw_2.of_ChangeDataObject("dw_ge246_lista_log_fechamento")
	Else
		dw_2.of_ChangeDataObject("dw_ge246_lista")
	End If
	
	dw_2.of_SetRowSelection()
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge246_filial_sem_movimentacao
integer x = 37
integer y = 364
integer width = 2807
integer height = 1224
string dataobject = "dw_ge246_lista_log_fechamento"
end type

event dw_2::ue_recuperar;// Override

Date lvdt_Movimentacao

String	lvs_Controle
String	lvs_AbreDomingo
String ls_Aberta, ls_Recebe_Nf_Transf

dw_1.AcceptText()

lvdt_Movimentacao 	= dw_1.Object.Dt_Movimentacao	[1]
lvs_AbreDomingo		= dw_1.Object.id_abre_domingo	[1]
ls_Aberta				= dw_1.Object.id_aberta							[1]
ls_Recebe_Nf_Transf	= dw_1.Object.id_recebe_nf_transferencia	[1]

If Not IsDate(String(lvdt_Movimentacao, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_movimentacao")
	Return -1
End If

lvs_Controle = "CONTROLE_EXPORTACAO_" + String(lvdt_Movimentacao, "yymmdd")

//Return This.Retrieve(lvdt_Movimentacao, lvs_Controle)

If lvs_AbreDomingo = 'S' Then 
	of_AppendWhere("f.id_abre_domingo = 'S'", 1)
End If

If ls_Aberta = 'S' Then 
	of_AppendWhere("COALESCE(f.id_aberta,'S') = 'S'", 1)
	of_AppendWhere("COALESCE(f.id_aberta,'S') = 'S'", 3)
End If

If ls_Recebe_Nf_Transf = 'S' Then 
	of_AppendWhere("COALESCE(f.id_recebe_nf_transferencia,'S') = 'S'", 1)
	of_AppendWhere("COALESCE(f.id_recebe_nf_transferencia,'S') = 'S'", 3)
End If

Return This.Retrieve(lvdt_Movimentacao)
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]

lvs_Coluna = {"cd_filial", &
				  "nm_fantasia", &
				  "hr_abertura", &
				  "hr_fechamento"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo da Filial", &
				"Nome da Filial", &
				"Abertura", &
				"Fechamento"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long ll_Linha
Long ll_Filial
Long ll_Dia_Semana
Long ll_Find

String ls_Dias_Procura
String ls_Horario

dc_uo_ds_base lds_1
lds_1 = Create dc_uo_ds_base

If Not lds_1.of_ChangeDataObject('ds_ge246_horario_funcionamento') Then Return -1

ll_Dia_Semana = DayNumber( Date( dw_1.Object.Dt_Movimentacao[1] ) )

Choose Case ll_Dia_Semana
	Case 2,3,4,5,6
		ls_Dias_Procura = "'00', '01', '02', '03'"
		
	Case 1
		ls_Dias_Procura = "'02', '03', '05', '06', '07', '08'"
		
	Case 7
		ls_Dias_Procura = "'01', '02', '03', '04', '06', '07'"
		
End Choose

lds_1.of_AppendWhere("substring(vl_parametro, 1, 2) in ( " + ls_Dias_Procura + ")")
lds_1.Retrieve()

For ll_Linha = 1 To This.RowCount()
	ll_Filial = This.Object.Cd_Filial[ ll_Linha ]
	
	Select vl_parametro
	   Into :ls_Horario
     From parametro_loja
   Where cd_filial = :ll_Filial
	   And cd_parametro = 'DE_HORARIO_1'
	   And substring(vl_parametro, 1, 2) = '10'
     Using SqlCa;
	  
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o de hor$$HEX1$$e100$$ENDHEX$$rio da filial ' + String(ll_Filial) )
			
		Case 0
			This.Object.hr_Fechamento[ ll_Linha ] = '24H'
			
		Case 100			
		 
			ll_Find = lds_1.Find("cd_filial = " + String(ll_Filial), 1, lds_1.RowCount())
			
			If ll_Find < 1 Then
				This.Object.hr_Fechamento[ ll_Linha ] = '$$HEX1$$d100$$ENDHEX$$ ABRE'
			Else
				ls_Horario = lds_1.Object.hr_funcionamento[ll_Find]
				
				This.Object.hr_Abertura		[ ll_Linha ] = MidA(ls_Horario, 3, 2) + ':' + MidA(ls_Horario, 5, 2)
				This.Object.hr_fechamento	[ ll_Linha ] = MidA(ls_Horario, 7, 2) + ':' + MidA(ls_Horario, 9, 2)
			End If
			
	End Choose
	
Next	

Destroy lds_1

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge246_filial_sem_movimentacao
integer x = 1787
integer y = 796
integer width = 187
integer height = 152
integer taborder = 50
end type

type cb_exportacao_cheque from commandbutton within w_ge246_filial_sem_movimentacao
boolean visible = false
integer x = 1221
integer y = 64
integer width = 343
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exporta$$HEX2$$e700e300$$ENDHEX$$o Cheque"
end type

event clicked;String lvs_Banco, &
       lvs_Agencia, &
		 lvs_Conta, &
		 lvs_Cheque

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Temp = 1, &
	  lvl_Sequencial = 1

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
If Not lvds_1.of_ChangeDataObject("dw_ge246_exportacao_cheque") Then Return

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Atualizando Tabela Tempor$$HEX1$$e100$$ENDHEX$$ria para Exporta$$HEX2$$e700e300$$ENDHEX$$o..."

lvl_Total = lvds_1.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvs_Banco   = lvds_1.Object.Cd_Banco  [lvl_Contador]
		lvs_Agencia = lvds_1.Object.Nr_Agencia[lvl_Contador]
		lvs_Conta   = lvds_1.Object.Nr_Conta  [lvl_Contador]
		lvs_Cheque  = lvds_1.Object.Nr_Cheque [lvl_Contador]
		
		Insert Into ademir_log (cd_banco,
		                        nr_agencia,   
										nr_conta,
										nr_cheque,
           							nr_sequencial)  
  		Values (:lvs_Banco, 
		        :lvs_Agencia,
				  :lvs_Conta,
				  :lvs_Cheque,
		        :lvl_Sequencial)
		Using SqlCa;

		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Controle")
			Exit
		End If
		
		If lvl_Temp = 1000 Then
			SqlCa.of_Commit()
			lvl_Sequencial ++
			lvl_Temp = 1
		Else
			lvl_Temp ++
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	SqlCa.of_Commit()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cheques n$$HEX1$$e300$$ENDHEX$$o localizados.", StopSign!)
End If

Close(w_Aguarde)
SetPointer(Arrow!)
end event

