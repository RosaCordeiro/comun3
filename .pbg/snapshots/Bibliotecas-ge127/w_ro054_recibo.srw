HA$PBExportHeader$w_ro054_recibo.srw
forward
global type w_ro054_recibo from dc_w_response_ok_cancela
end type
end forward

global type w_ro054_recibo from dc_w_response_ok_cancela
integer width = 1385
integer height = 640
string title = "RO054 - Recibo de entrega de m$$HEX1$$ed00$$ENDHEX$$dia magn$$HEX1$$e900$$ENDHEX$$tica"
long backcolor = 80269524
end type
global w_ro054_recibo w_ro054_recibo

forward prototypes
public function boolean wf_grava_arquivo_pdf (dc_uo_ds_base a_ds, string as_nome)
public function string wf_appendwhere (long pl_filial)
end prototypes

public function boolean wf_grava_arquivo_pdf (dc_uo_ds_base a_ds, string as_nome);Long li_job, &
     li_Retorno

li_Job = PrintOpen(as_nome)

If li_job > 1 Then
	
	li_Retorno = PrintDataWindow ( li_job, a_DS )
	
	If li_Retorno <> - 1 Then
		li_Retorno = PrintDataWindow ( li_job, a_DS )
	End If
	
	If li_Retorno = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo PDF '" + as_Nome + "'")
		PrintClose(li_job)
		Return False
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo PDF '" + as_Nome + "'.")
	Return False
End If

PrintClose(li_job)
Return True
end function

public function string wf_appendwhere (long pl_filial);Long	ll_Rows, &
		ll_Row , &
		ll_Mes , &
		ll_Ano
	
String	ls_Retorno = "", &
		ls_Mes			, &
		ls_Codigo		, &
		ls_Grupo			, &
		ls_Gerar			, &
		ls_Periodo		, &
		ls_Anual			, &
		ls_Ano

dw_1.AcceptText()

/* * */
Long ll_Arquivo
Long ll_Pos
Long ll_Relatorio
Long ll_Filiais

String ls_Grupo_Aux
String ls_Periodo_Aux
String ls_Filial
String ls_Arquivos[]
String ls_Arquivo
String ls_Relatorios[]

ls_Relatorios = {	'RMNA', &
						'RMNRB2', &
						'BMPO', &
						'BALAQ', &
						'LIVRO' }
						
ls_Filial = String( pl_Filial, '0000' )
						
gf_dir_list( 'c:\pdf\gravados', ls_Filial + '*.pdf', 0, ls_Arquivos )

If UpperBound( ls_Arquivos ) = 0 Then 
	Return ''
End If

For ll_Arquivo = 1 To UpperBound( ls_Arquivos )
	ls_Arquivo = ls_Arquivos[ ll_Arquivo ]
	
	If PosA( ls_Arquivo, '_CD' ) = 0 Then Continue
	
	For ll_Relatorio = 1 To UpperBound( ls_Relatorios )
		ls_Codigo = ls_Relatorios[ ll_Relatorio ]
		
		If PosA( ls_Arquivo, ls_Codigo ) > 0 Then
			Exit
		End If
	Next
	
	ll_Pos = PosA( ls_Arquivo, '_', 5 + LenA( ls_Codigo ) )
	ls_Grupo = MidA( ls_Arquivo, ll_Pos +1,  PosA( ls_Arquivo, '_', ll_Pos +1 ) - ( ll_Pos +1 ) )
	
	ll_Pos = LenA( ls_Grupo )
	
	ls_Grupo_Aux = ls_Grupo
	ls_Grupo = ''
	Do While ll_Pos > 0
		ls_Grupo += MidA( ls_Grupo_Aux, 0, 2 ) + ','
		ls_Grupo_Aux = MidA( ls_Grupo_Aux, 3 )
		ll_Pos -= 2
	Loop

	ls_Grupo = MidA( ls_Grupo, 0, LenA( ls_Grupo ) -1 )
	
	ls_Periodo_Aux = MidA( ls_Arquivo, LenA( ls_Arquivo ) -7, 1 )
	
	ls_Anual = 'N'
	ls_Gerar = 'N'
	
	If ls_Periodo_Aux = 'A' Then
		ls_Anual = "S"
	Else
		ls_Gerar = "S"
	End If

	ll_Mes	  = dw_1.Object.Mes	  [1]
	ll_Ano 	  = dw_1.Object.Ano	  [1]
	ls_Ano     = "/" + String(ll_Ano)
	ls_Periodo = String(dw_1.Object.Periodo[1]) + "$$HEX1$$ba00$$ENDHEX$$ TRIMESTRE"
	
	Choose Case ls_Codigo
		Case 'RMNA'
			ls_Retorno += "~rREL. MENSAL DE NOTIF. DE RECEITA 'A' (RMNRA) - "
			ls_Retorno += Upper( gf_Mes_Extenso(ll_Mes) ) + ls_Ano
			
		Case 'RMNRB2'
			ls_Retorno += "~rREL. MENSAL DE NOTIF. DE RECEITA 'B2' (RMNRB2) - "
			ls_Retorno += Upper( gf_Mes_Extenso(ll_Mes) ) + ls_Ano
			
		Case 'BMPO'
			If ls_Gerar = "S" Then
				ls_Retorno += "~rBALAN$$HEX1$$c700$$ENDHEX$$O DE MEDICAMENTOS (BMPO) - " + ls_Grupo + " - " + ls_Periodo + ls_Ano
			End If
			
			If ls_Anual = "S" Then
				ls_Retorno += "~rBALAN$$HEX1$$c700$$ENDHEX$$O DE MEDICAMENTOS (BMPO) - " + ls_Grupo + " - ANUAL" + ls_Ano
			End If
			
		Case 'BALAQ'
			If ls_Gerar = "S" Then
				ls_Retorno += "~rBAL. DAS AQUISI$$HEX2$$c700d500$$ENDHEX$$ES DE MEDIC. - " + ls_Grupo + " - " + ls_Periodo + ls_Ano
			End If
			
			If ls_Anual = "S" Then
				ls_Retorno += "~rBAL. DAS AQUISI$$HEX2$$c700d500$$ENDHEX$$ES DE MEDIC. - " + ls_Grupo + " - ANUAL" + ls_Ano
			End If
			
		Case 'LIVRO'
			If ls_Gerar = "S" Then
				ls_Retorno += "~rLIVRO TRIMESTRAL - " + ls_Grupo + " - " + ls_Periodo + ls_Ano
			End If
			
			If ls_Anual = "S" Then
				ls_Retorno += "~rLIVRO ANUAL - " + ls_Grupo + " - ANUAL" + ls_Ano
			End If
			
	End Choose
Next
/* * */

Return ls_Retorno
end function

on w_ro054_recibo.create
call super::create
end on

on w_ro054_recibo.destroy
call super::destroy
end on

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ro054_recibo
integer x = 9
integer width = 1317
integer height = 392
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ro054_recibo
integer x = 27
integer width = 1275
integer height = 304
string dataobject = "dw_ro054_selecao_recibo"
end type

event dw_1::itemchanged;//OverRide
end event

event dw_1::editchanged;//OverRide

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ro054_recibo
integer x = 672
integer y = 428
string facename = "Verdana"
end type

event cb_ok::clicked;Long ll_Filial
Long ll_Filiais
Long ll_Loop
	  
String lvs_Tipo,&
       lvs_AppendWhere,&
		 lvs_Nome_Arquivo
		 
dw_1.AcceptText()

Open(w_Aguarde)

dc_uo_ds_base lvo
lvo = Create dc_uo_ds_base

dc_uo_ds_base lds_Filiais
lds_Filiais = Create dc_uo_ds_base
lds_Filiais.of_ChangeDataObject('dw_ro054_lista_filial')
ll_Filiais = lds_Filiais.Retrieve()

w_Aguarde.uo_Progress.of_SetMax( ll_Filiais )

lvo.of_ChangeDataObject("dw_ro054_recibo")

For ll_Loop = 1 To ll_Filiais
	lvo.Reset()
	
	ll_Filial = Long( lds_Filiais.Object.cd_Filial[ ll_Loop ] )
	
	w_Aguarde.Title = "Gerando o Recibo de Entrega " + String(ll_Filial, "0000") + " ..."
	
	lvs_AppendWhere = wf_AppendWhere( ll_Filial )
	
	If lvs_AppendWhere = '' Then Continue
	
	lvo.Retrieve(ll_Filial, lvs_AppendWhere)
	
	lvs_Nome_Arquivo = String(ll_Filial,'0000') + '_Recibo_Entrega.pdf'

	If lvo.RowCount() = 1 Then 
		wf_grava_arquivo_pdf(lvo, lvs_Nome_Arquivo)
	End If	
			
Next

Destroy( lds_Filiais )
Destroy(lvo)
Close(w_Aguarde)
Close(Parent)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ro054_recibo
integer x = 1015
integer y = 428
string facename = "Verdana"
end type

