HA$PBExportHeader$w_ge538_reenvio_scanntech.srw
forward
global type w_ge538_reenvio_scanntech from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_envio from commandbutton within tabpage_1
end type
type cb_fechamento from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_email_diario from commandbutton within tabpage_1
end type
type gb_5 from groupbox within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_5 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_5 dw_5
end type
end forward

global type w_ge538_reenvio_scanntech from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge538_reenvio_scanntech"
integer width = 3936
integer height = 2928
string title = "GE538 - Monitoramento Scanntech"
end type
global w_ge538_reenvio_scanntech w_ge538_reenvio_scanntech

type variables
lstr_scanntech istr_param

String ivs_Operador
end variables

forward prototypes
public function boolean wf_valida_forma_pagamento (date pdh_data_mov, long pl_cd_filial, long pl_nr_nf, string ps_de_especie, string ps_de_serie, ref string ps_forma_pagto)
public function boolean wf_libera_reprocessamento (datetime adh_processamento)
public function boolean wf_libera_processamento (datetime pdh_movimento, string ps_id_tipo_envio, ref long pl_existe)
public function boolean wf_verifica_reprocessar_fechamento ()
public function boolean wf_libera_reprocessar_fechamento ()
end prototypes

public function boolean wf_valida_forma_pagamento (date pdh_data_mov, long pl_cd_filial, long pl_nr_nf, string ps_de_especie, string ps_de_serie, ref string ps_forma_pagto);String lvs_forma_pagto
DateTime ldh_data_1,ldh_data_2


ldh_data_1 =  DateTime(String(pdh_data_mov) + ' 00:00:00.000')
ldh_data_2 =  DateTime(String(pdh_data_mov) + ' 23:59:59.000')


Select cd_forma_pagamento
    Into :lvs_forma_pagto
  From nf_venda les  noholdlock
Where les.de_especie IN ('CF','NFC','SAT') 
    and les.dh_movimentacao_caixa Between :ldh_data_1 And :ldh_data_2
    and les.cd_filial             = :pl_cd_filial
    and les.nr_nf                = :pl_nr_nf
    and les.de_especie        = :ps_de_especie
    and les.de_serie            = :ps_de_serie;
	 
If Sqlca.Sqlcode = 100 Then
   Return False	
End If

ps_forma_pagto = lvs_forma_pagto

Return True	 
end function

public function boolean wf_libera_reprocessamento (datetime adh_processamento);/*
Helpdesk = 1147550
Autor = Jo$$HEX1$$e300$$ENDHEX$$o Batista Lopes da Silva
Data: 26/05/2022
Motivo: Quando houver ID_TIPO_ENVIO = 'F' (FECHAMENTO) e id_situacao = 'P'	(PENDENTE), o usu$$HEX1$$e100$$ENDHEX$$rio
        s$$HEX1$$f300$$ENDHEX$$ poder$$HEX1$$e100$$ENDHEX$$ escolher uma linha por vez para reprocessar o fechamento, o c$$HEX1$$f300$$ENDHEX$$digo abaixo vai
		  atualizar a dh_terminio da tabela log_scanntech_proc para NULL, liberando o registro para 
		  novo processamento.
*/	

datetime ldt_null, ldh_inicio, ldh_fim

/* For$$HEX1$$e700$$ENDHEX$$a Null (Nulo) como valor da vari$$HEX1$$e100$$ENDHEX$$vel */
setnull(ldt_null)

/* Transforma o parametro recebido para conter hora inicial e final para pegar dia cheio */
ldh_inicio = DateTime(String(date(adh_processamento)) + ' 00:00:00.000')
ldh_fim = DateTime(String(date(adh_processamento)) + ' 23:59:59.000')
		
UPDATE log_scanntech_proc 
   SET dh_terminio = :ldt_null
 WHERE dh_inicio between :ldh_inicio and :ldh_fim
   AND id_bloco = 0
	AND id_tipo_envio = 'F'
   AND dh_terminio is not null
 USING SQLCA;

if sqlca.sqlcode = -1 then
	gvo_aplicacao.of_grava_log("Erro ao Atualizar dados do LOG Processamento Scanntech")
	SqlCa.of_rollback( ); 
	return false
else
	SqlCa.of_commit( ); 	 
end if

return true
end function

public function boolean wf_libera_processamento (datetime pdh_movimento, string ps_id_tipo_envio, ref long pl_existe);Long ll_existe

DateTime ldh_data_1, ldh_data_2

String ls_data

ls_data = String(Date(pdh_movimento))

ldh_data_1 =  DateTime(String(ls_data) + ' 00:00:00.000')
ldh_data_2 =  DateTime(String(ls_data) + ' 23:59:59.000')

Select count(1)
    Into :ll_existe
 From log_exportacao_scanntech
 Where dh_movimentacao_caixa Between :ldh_data_1 and :ldh_data_2
    And id_situacao = 'P'
   And id_tipo_envio =:ps_id_tipo_envio
Using Sqlca;


If Sqlca.Sqlcode = - 1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao acessar tabela LOG EXPORTACAO SCANNTECH.",stopsign!)
	Return False
End If	
	
If ll_existe = 0 Then	
	Return False
End If	

pl_existe = 	ll_existe
	
Return True	
	

end function

public function boolean wf_verifica_reprocessar_fechamento ();long ll_count_proc, ll_count_export

datetime ldh_mov_caixa

boolean lb_return

string ls_data

lb_return = false

tab_1.tabpage_1.dw_1.AcceptText()

ldh_mov_caixa = tab_1.tabpage_1.dw_2.Object.dh_movimentacao_caixa[tab_1.tabpage_1.dw_2.getrow()]

ls_data = String(Date(ldh_mov_caixa))

istr_param.dt_inicial = DateTime(ls_data + ' 00:00:00.000')
istr_param.dt_final   = DateTime(ls_data + ' 23:59:59.000')

//Consulta 1
SELECT coalesce(count(*),0)
  INTO :ll_count_proc
  FROM log_scanntech_proc
 WHERE dh_inicio BETWEEN :istr_param.dt_inicial and :istr_param.dt_final
   AND dh_terminio is not null 
   AND id_bloco = 0 
 USING sqlca;
 
If Sqlca.Sqlcode = -1 Then
	gvo_aplicacao.of_grava_log("Erro ao validar dados na tabela LOG_SCANNTECH_PROC!")
	Return False
End If 

if ll_count_proc > 0 then
	//Consulta 2:
	SELECT coalesce(count(*),0)
	  INTO :ll_count_export
	  FROM log_exportacao_scanntech
	 WHERE dh_movimentacao_caixa BETWEEN :istr_param.dt_inicial and :istr_param.dt_final
		AND id_tipo_envio  = 'F' 
		AND id_situacao  = 'S'
	 USING sqlca;
	 
	If Sqlca.Sqlcode = -1 Then
		gvo_aplicacao.of_grava_log("Erro ao validar dados na tabela LOG_EXPORTACAO_SCANNTECH")
		Return False
	End If 
else
	lb_return = false
end if 

//Se a consulta 1 e a consulta 2 retornarem registros hanilitar re-envio
if ll_count_proc > 0 and ll_count_export > 0 then lb_return = true

return lb_return
end function

public function boolean wf_libera_reprocessar_fechamento ();/*
Helpdesk = 1153046
Autor = Jo$$HEX1$$e300$$ENDHEX$$o Batista Lopes da Silva
Data: 05/07/2022
Motivo: Quando houver ID_TIPO_ENVIO = 'F' (FECHAMENTO) e id_situacao = 'S'	(SUCESSO), o usu$$HEX1$$e100$$ENDHEX$$rio
        poder$$HEX1$$e100$$ENDHEX$$ escolher uma data e reprocessar o fechamento para as filiais desejadas.
		  O c$$HEX1$$f300$$ENDHEX$$digo abaixo vai atualizar a dh_terminio da tabela log_scanntech_proc para NULL, 
		  liberando o registro para  novo processamento.
*/	

long ll_filial

integer li_linha, li_linhas

datetime ldt_null

dc_uo_ds_Base ds_itens_selecionados

/* 
For$$HEX1$$e700$$ENDHEX$$a Null (Nulo) como valor da vari$$HEX1$$e100$$ENDHEX$$vel 
*/
setnull(ldt_null)

/*
Abre janela para sele$$HEX2$$e700e300$$ENDHEX$$o de todas as filiais que o usu$$HEX1$$e100$$ENDHEX$$rio deseja reprocessar
*/
openwithparm(w_ge538_lista_filial_reprocessamento, istr_param)

istr_param = message.powerobjectparm

/* 
Se a sele$$HEX2$$e700e300$$ENDHEX$$o de filiais foi cancelada para o processamento e retorna False 
*/
if istr_param.cancel = 'S' then return false

/* Datastore que carrega as filiais selecionadas */
ds_itens_selecionados = Create dc_uo_ds_base
If Not ds_itens_selecionados.of_ChangeDataObject('dw_ge538_reprocessar_fechamento') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no changedata da 'dw_ge538_reprocessar_fechamento'.")
	Return False
End If

ds_itens_selecionados = istr_param.ds_itens_selecionados
//ds_itens_selecionados.ShareData(tab_1.tabpage_1.dw_6)
//tab_1.tabpage_1.dw_6.accepttext()
li_linhas = ds_itens_selecionados.rowcount()

/*
Verifica a quantidade de linhas (Filiais) selecionadas para reprocessar
*/

/*
Para cada linha selecionada prepara os registros para um novo processamento
*/

for li_linha = 1 to li_linhas
	
	/*
	Filial que foi selecionada para reprocessar, contida da Datastore que voltou da janela de sele$$HEX2$$e700e300$$ENDHEX$$o
	*/	
	//ll_filial = tab_1.tabpage_1.dw_6.getitemnumber(li_linha, 'filial_cd_filial')
	ll_filial = ds_itens_selecionados.object.filial_cd_filial[li_linha]
	
	/* 
	Se houver linhas para reprocessar atualiza o Log Scanntech Proc na primeira volta do FOR
	pois s$$HEX1$$f300$$ENDHEX$$ existe uma linha para todo o processamento (Cabe$$HEX1$$e700$$ENDHEX$$a/Capa do Processamento)
	*/
	if li_linha = 1 then
		UPDATE log_scanntech_proc 
			SET dh_terminio = :ldt_null
		 WHERE dh_inicio between :istr_param.dt_inicial and :istr_param.dt_final
		   AND id_bloco = 0
   		AND id_tipo_envio = 'F'
		   AND dh_terminio is not null
   	 USING SQLCA;
		 
		if sqlca.sqlcode = -1 then
			gvo_aplicacao.of_grava_log("Erro ao Atualizar dados LOG_SCANNTECH_PROC ")
			SqlCa.of_rollback( ); 
			return false
		end if
	end if
	
	/* 
	Para cada filial selecionada, atualiza a situacao para "P", Pendente de Processamento 
	(Itens do Processamento)
	*/
	UPDATE log_exportacao_scanntech
		SET id_situacao = 'P'
	 WHERE dh_movimentacao_caixa BETWEEN :istr_param.dt_inicial and :istr_param.dt_final
		AND id_tipo_envio  = 'F' 
		AND id_situacao  = 'S'
		AND cd_filial = :ll_filial
	 USING sqlca;
		 
	If Sqlca.Sqlcode = -1 Then
		gvo_aplicacao.of_grava_log("Erro ao validar dados na tabela LOG_EXPORTACAO_SCANNTECH")
		SqlCa.of_rollback( ); 
		Return False
	End If 
	
	/*
	Commit na linha atual do procesamento
	*/
	SqlCa.of_commit( ); 	 
next

return true
end function

on w_ge538_reenvio_scanntech.create
int iCurrent
call super::create
end on

on w_ge538_reenvio_scanntech.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date ldh_mov_caixa
DateTime ldh_data_1, ldh_data_2


ldh_mov_caixa = RelativeDate( Today(), -1 )

Tab_1.TabPage_1.dw_1.AcceptText()

Tab_1.TabPage_1.dw_1.object.dh_mov_caixa_1[1] = ldh_mov_caixa
Tab_1.TabPage_1.dw_1.object.dh_mov_caixa_2[1] = ldh_mov_caixa
Tab_1.TabPage_1.dw_1.object.selecao_parametro[1] = '0'
Tab_1.TabPage_1.dw_1.object.situacao[1] = 'T'

tab_1.tabpage_1.dw_1.object.dh_envio[1] = 'S'
Tab_1.TabPage_1.dw_1.SetFocus()

this.Event ue_retrieve()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge538_reenvio_scanntech
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge538_reenvio_scanntech
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge538_reenvio_scanntech
string tag = "dw_ge538_reenvio_vendas"
integer x = 9
integer y = 16
integer width = 3803
integer height = 2504
tabpage_3 tabpage_3
end type

event tab_1::selectionchanged;// Overrider

end event

event tab_1::selectionchanging;// Overrider
end event

on tab_1.create
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
end on

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3767
integer height = 2388
string text = "Resumo"
cb_envio cb_envio
cb_fechamento cb_fechamento
cb_1 cb_1
cb_email_diario cb_email_diario
end type

on tabpage_1.create
this.cb_envio=create cb_envio
this.cb_fechamento=create cb_fechamento
this.cb_1=create cb_1
this.cb_email_diario=create cb_email_diario
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_envio
this.Control[iCurrent+2]=this.cb_fechamento
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_email_diario
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_envio)
destroy(this.cb_fechamento)
destroy(this.cb_1)
destroy(this.cb_email_diario)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 548
integer width = 3593
integer height = 1764
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer y = 8
integer width = 3593
integer height = 544
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer y = 56
integer width = 2473
integer height = 464
string dataobject = "dw_ge538_parametros_reenvio"
end type

event dw_1::itemchanged;call super::itemchanged;tab_1.tabpage_2.dw_3.object.t_erro.text = ''
tab_1.tabpage_2.dw_4.reset()
end event

event dw_1::clicked;call super::clicked;if this.object.dh_envio[1] = 'S' then
   this.object.t_periodo.text = 'Data envio:'	
else
   this.object.t_periodo.text = 'Data Venda:'		
end if
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 612
integer width = 1586
integer height = 1368
string dataobject = "dw_ge538_resumo"
end type

event dw_2::clicked;call super::clicked;DateTime ldh_mov_caixa

string lvs_id_tipo_envio, ls_situacao

Long ll_existe, ll_find

AcceptText( )

tab_1.tabpage_1.cb_envio.enabled = False
tab_1.tabpage_1.cb_fechamento.enabled = False
istr_param.reprocessar_fechamento = false

If rowcount() = 0 Then Return -1

if row > 0 then
	//A $$HEX1$$fa00$$ENDHEX$$ltima aba fica habilitada apenas para o id_tipo_envio vendas
	If This.Object.Id_Tipo_Envio[Row] <> "V" Then	
		Tab_1.TabPage_3.visible = False
	Else
		Tab_1.TabPage_3.visible = True
	End If
	
	ldh_mov_caixa = Object.dh_movimentacao_caixa[Row]
	lvs_id_tipo_envio = Object.id_tipo_envio[Row]
		
	tab_1.tabpage_2.dw_3.event ue_recuperar( )
	tab_1.tabpage_3.dw_5.event ue_recuperar( )
	
	If lvs_id_tipo_envio = 'V' Then Tab_1.TabPage_3.visible = False
	
	If Not wf_libera_processamento(ldh_mov_caixa,lvs_id_tipo_envio, Ref ll_existe) Then 
		if lvs_id_tipo_envio = 'V' then Return -1
	end if
		
	if ll_existe > 0 then
		If lvs_id_tipo_envio = 'V' Then tab_1.tabpage_1.cb_envio.enabled = True
		If lvs_id_tipo_envio = 'F' Then tab_1.tabpage_1.cb_fechamento.enabled = True	
	end if
	
	/* Libera Reprocessar Fechamento */
	If lvs_id_tipo_envio = 'F' then
		ls_situacao = Object.Id_Situacao[row] 
		if ls_situacao = 'SUCESSO' then
			istr_param.reprocessar_fechamento = wf_verifica_reprocessar_fechamento()
			tab_1.tabpage_1.cb_fechamento.enabled = istr_param.reprocessar_fechamento
		end if
	end if
end if
end event

event dw_2::constructor;call super::constructor;//String lvs_Coluna[], &
//       lvs_Nome[]
//
//// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
//This.ivb_Ordena_Colunas = True
//
//lvs_Coluna = {"nr_atualizacao", "cd_chave", "cd_filial"}
//
//lvs_Nome = {"Seq.", "Chave", "Filial"}
//
//This.of_SetSort(lvs_Coluna, lvs_Nome)
//This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_recuperar;// Overrider
string ls_data_1,ls_data_2
dateTime ldh_data_1, ldh_data_2
long lvl_liberar_envio, lvl_liberar_fechamento
long ll_Index_SubQuery	, ll_retrieve
string ls_situacao, ls_tipo_envio, ls_forma_envio, lvs_filter, ls_nf_canceladas

dw_1.AcceptText()
Tab_1.tabpage_2.dw_3.reset()

ls_situacao = tab_1.tabpage_1.dw_1.object.situacao[1]
ls_tipo_envio = tab_1.tabpage_1.dw_1.object.selecao_parametro[1]
ls_nf_canceladas = tab_1.tabpage_1.dw_1.object.nf_cancelado[1]

lvs_filter = ""

//tab_1.tabpage_2.dw_3.setFilter(lvs_filter)
//tab_1.tabpage_2.dw_3.Filter()

of_RestoreOriginalSQL()

ll_Index_SubQuery	= 1

ls_data_1 = String(tab_1.tabpage_1.dw_1.Object.dh_mov_caixa_1[1])
ls_data_2 = String(tab_1.tabpage_1.dw_1.Object.dh_mov_caixa_2[1])

ldh_data_1 =  DateTime( ls_data_1 + ' 00:00:00.000')
ldh_data_2 =  DateTime( ls_data_2 + ' 23:59:59.000')

If date(ldh_data_1) > date(ldh_data_2) Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data final.",stopsign!)
   dw_1.setfocus()
	return -1
End If

If tab_1.tabpage_1.dw_1.object.dh_envio[1] = 'S' Then
	of_AppendWhere(" dh_movimentacao_caixa BetWeen ' " + String(ldh_data_1, "yyyymmdd hh:mm:ss")  + " '  And ' "  +  String(ldh_data_2, "yyyymmdd hh:mm:ss")  + " ' ", ll_Index_SubQuery )  
Else
	of_AppendWhere(" dh_envio BetWeen ' " + String(ldh_data_1, "yyyymmdd hh:mm:ss")  + " '  And ' "  +  String(ldh_data_2, "yyyymmdd hh:mm:ss")  + " ' ", ll_Index_SubQuery )  
//  of_AppendWhere_SubQuery(" dh_envio = '"+String(ldh_data, "yyyymmdd")+"'", ll_Index_SubQuery)	
End If

// 1 = Vendas - 2 = Fechamento - 0 (zero) = Todos
if ls_tipo_envio = '1' then 
   of_AppendWhere(" id_tipo_envio = 'V' ", ll_Index_SubQuery)
elseif ls_tipo_envio = '2' then 
   of_AppendWhere(" id_tipo_envio = 'F' ", ll_Index_SubQuery)		
end if	

// P = Pendente - S = Sucesso Envio	- T = Todos
// Pendentes somente Vendas, pois Fechamento ser$$HEX1$$e100$$ENDHEX$$ enviado pelo agendamento
If ls_situacao <> 'T' Then of_AppendWhere(" log_exportacao_scanntech.id_situacao = '" + ls_situacao + "'", ll_Index_SubQuery)

//Notas Canceladas
if ls_nf_canceladas = 'S' then of_AppendWhere(" ( dh_cancelado IS NOT NULL  ) ", ll_Index_SubQuery) 		 	

ll_retrieve = Retrieve()

Return ll_retrieve
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long ll_Linha

String ls_Situacao

If pl_Linhas > 0 Then
	
	For ll_Linha = 1 To pl_Linhas
		ls_Situacao = gf_valida_status_movimento(This.Object.dh_movimentacao_caixa[ll_Linha] ,This.Object.id_tipo_envio[ll_Linha])
			
		If Upper(ls_Situacao) = "ERRO" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no evento ue_Postretrieve da dw_2. Chamada da fun$$HEX2$$e700e300$$ENDHEX$$o gf_valida_status_movimento.")
			Return -1
		End If
		
		This.Object.Id_Situacao[ll_Linha] = ls_Situacao
	Next
End If

Return pl_Linhas
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
event create ( )
event destroy ( )
integer width = 3767
integer height = 2388
gb_5 gb_5
dw_4 dw_4
end type

on tabpage_2.create
this.gb_5=create gb_5
this.dw_4=create dw_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.dw_4
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_5)
destroy(this.dw_4)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3776
integer height = 1492
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3653
integer height = 1940
string dataobject = "dw_ge538_reenvio_vendas"
boolean vscrollbar = true
end type

event dw_3::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]

// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True

lvs_Coluna = {"nr_atualizacao", "cd_chave", "cd_filial"}

lvs_Nome = {"Seq.", "Chave", "Filial"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()
end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;If Tab_1.TabPage_2.dw_3.RowCount() > 0 Then
	Tab_1.TabPage_2.dw_4.Object.de_erro[1] = This.Object.de_erro[Tab_1.TabPage_2.dw_3.GetRow()]
End If
end event

event dw_3::clicked;call super::clicked; dc_uo_ds_base lds_ge538_forma_pagto

DateTime ldh_mov_caixa, ldh_data_1, ldh_data_2

Long lvl_nr_nf, ll_Index_SubQuery, lvl_row_detalhe, lvl_cd_filial

String lvs_de_especie, lvs_de_serie, lvs_forma_pagto, lvs_filtro, lvs_de_forma_pagamento, lvs_id_situacao, lvs_cd_forma_pagto, lvs_id_tipo_envio

String lvs_filial_scanntech


If row > 0 Then
	
    Tab_1.TabPage_3.visible = True
	Tab_1.TabPage_2.dw_4.Object.de_erro[1] =	This.Object.de_erro						[Row]
	ldh_mov_caixa										=	This.Object.dh_movimentacao_caixa	[Row]
	lvl_nr_nf												=	This.Object.nr_nf							[Row]
	lvs_de_especie										=	This.Object.de_especie					[Row]
	lvs_de_serie											=	This.Object.de_serie						[Row]
	lvs_forma_pagto									=	This.Object.cd_forma_pagamento		[Row]
	lvs_id_situacao										=	This.Object.id_situacao					[Row]
	lvl_cd_filial											=	This.Object.cd_filial						[Row]
	lvs_id_tipo_envio									=	This.Object.id_tipo_envio				[Row]
	lvs_filial_scanntech                                	= 	This.Object.cd_filial_scanntech		 	[Row]
	
	
	ldh_data_1 =  DateTime(String(Date(ldh_mov_caixa)) + ' 00:00:00.000')
    ldh_data_2 =  DateTime(String(Date(ldh_mov_caixa)) + ' 23:59:59.000')
				
	If IsValid(lds_ge538_forma_pagto) Then
	   Destroy lds_ge538_forma_pagto
     End If

     Tab_1.TabPage_2.dw_3.Event ue_retrieve()

     lds_ge538_forma_pagto = create dc_uo_ds_base
		
     If Not lds_ge538_forma_pagto.of_ChangeDataObject( 'ddw_forma_pagamento' , False) Then 
	   //
    End If	
	
	lvl_row_detalhe = lds_ge538_forma_pagto.retrieve()
	
	 If not wf_valida_forma_pagamento(Date(ldh_mov_caixa),lvl_cd_filial,lvl_nr_nf	,lvs_de_especie,lvs_de_serie,Ref lvs_cd_forma_pagto ) Then
		lvs_forma_pagto = '0'	
	 End If
	
    If lvs_id_tipo_envio <> 'F' Then	
		lvs_filtro = " id_forma_pagamento = '" + lvs_cd_forma_pagto + "'" 

		lds_ge538_forma_pagto.SetFilter(lvs_filtro)
		lds_ge538_forma_pagto.Filter( )      
	
	  	lvs_de_forma_pagamento = lds_ge538_forma_pagto.object.de_descricao_forma_pagamento[1]	
	  	Tab_1.TabPage_3.dw_5.object.de_forma_pagto			[1]		= 	lvs_de_forma_pagamento	
	  	Tab_1.TabPage_3.dw_5.object.cd_forma_pagamento	[1]		=	lvs_cd_forma_pagto
	  	Tab_1.TabPage_3.dw_5.object.scanntech					[1]		=	lvs_forma_pagto
		 
    End if 
	
	
	If lvs_filial_scanntech = '' or IsNull(lvs_filial_scanntech) Then
		Tab_1.TabPage_2.dw_4.Object.de_erro[1] = 'FAVOR VERIFICAR SE PARA ESSA FILIAL EXISTE UM C$$HEX1$$d300$$ENDHEX$$DIGO SCANNTECH CADASTRADO.'
	Else	
		Tab_1.TabPage_2.dw_4.Object.de_erro[1] = This.Object.de_erro[Row]
	End If
   
	lds_ge538_forma_pagto.SetFilter("")
	lds_ge538_forma_pagto.Filter( )      	
	
	tab_1.tabpage_3.dw_5.event ue_recuperar( )
	
End If
end event

event dw_3::ue_retrieve;call super::ue_retrieve;////Override
//Date ldh_data
//DateTime ldh_data_1, ldh_data_2
//
//Long lvl_liberar_envio, lvl_liberar_fechamento
//
Long ll_Index_SubQuery	, ll_retrieve
//
//String ls_situacao, ls_tipo_envio, ls_forma_envio, lvs_filter, ls_nf_canceladas
//
//cb_envio.enabled 			= False
//cb_fechamento.enabled	= False
//
//dw_1.AcceptText()
//
//ls_situacao = dw_1.object.situacao[1]
//ls_tipo_envio = dw_1.object.selecao_parametro[1]
////ls_forma_envio = dw_1.object.forma_envio[1]
//ls_nf_canceladas = dw_1.object.nf_cancelado[1]
//
//tab_1.tabpage_2.dw_4.reset()
//
//lvs_filter = ""
//
//tab_1.tabpage_2.dw_3.setFilter(lvs_filter)
//tab_1.tabpage_2.dw_3.Filter()
//
//This.of_RestoreOriginalSQL()
//
//dw_1.AcceptText()
//
//ll_Index_SubQuery	= 1
//
//ldh_data		= dw_1.Object.dh_mov_caixa[1]
//
//ldh_data_1 =  DateTime(String(Date(ldh_data)) + ' 00:00:00.000')
//ldh_data_2 =  DateTime(String(Date(ldh_data)) + ' 23:59:59.000')
//
//
//
//
//If tab_1.tabpage_1.dw_1.object.dh_envio[1] = 'S' Then
//  This.of_AppendWhere_SubQuery(" dh_movimentacao_caixa    BetWeen ' " + String(ldh_data_1, "yyyymmdd hh:mm:ss")  + " '  And ' "  +  String(ldh_data_2, "yyyymmdd hh:mm:ss")  + " ' ", ll_Index_SubQuery )  
//																	//	String(ldh_data_2 "yyyymmdd hh:mm:ss") + " ' ")
//Else
//  This.of_AppendWhere_SubQuery(" dh_envio = '"+String(ldh_data, "yyyymmdd")+"'", ll_Index_SubQuery)	
//End If
//
//// 1 = Vendas - 2 = Fechamento - 0 (zero) = Todos
//if ls_tipo_envio = '1' then 
//   This.of_AppendWhere_SubQuery(" id_tipo_envio = 'V' ", ll_Index_SubQuery)
//    lvl_liberar_envio++	
//elseif ls_tipo_envio = '2' then 
//   This.of_AppendWhere_SubQuery(" id_tipo_envio = 'F' ", ll_Index_SubQuery)		
//    lvl_liberar_fechamento++	
//end if	
//
//// P = Pendente - S = Sucesso Envio	- T = Todos
//// Pendentes somente Vendas, pois Fechamento ser$$HEX1$$e100$$ENDHEX$$ enviado pelo agendamento
//If ls_situacao = 'P' Then
//	 lvl_liberar_envio++
//	 lvl_liberar_fechamento++
//  	This.of_AppendWhere_SubQuery(" log_exportacao_scanntech.id_situacao = 'P' ", ll_Index_SubQuery)
//Elseif ls_situacao = 'S' then   
//	This.of_AppendWhere_SubQuery("  log_exportacao_scanntech.id_situacao = 'S'  ", ll_Index_SubQuery) 	
//End if
//
////Notas Canceladas
//if ls_nf_canceladas = 'S' then
//   This.of_AppendWhere_SubQuery(" ( dh_cancelado IS NOT NULL  ) ", ll_Index_SubQuery) 		 	
//end if
//
//
////
////string ls_teste
////
////ls_teste = this.getsqlselect( )
//
//ll_retrieve = This.Retrieve()
//
//if ll_retrieve > 0 then 
//	 if this.find( " id_situacao  =  'P' ", 1 , this.rowcount() ) > 0 then
//	   this.object.t_erro.text = 'Status Envio: Lote enviado com Erro'
//	   this.modify(" t_erro.color=255")	
//     else
//	  this.object.t_erro.text = 'Status Envio: Lote enviado com Sucesso'
//	  this.modify(" t_erro.color=RGB(0,0,128)")		
//	end if
//end if
//
//
//if lvl_liberar_envio = 2 and ll_retrieve > 0 then
//  cb_envio.enabled = true	
//  cb_fechamento.enabled = false
//elseif lvl_liberar_fechamento = 2 and ll_retrieve > 0 then
//  cb_fechamento.enabled = true		
//  cb_envio.enabled = false	
//end if
//
//lvl_liberar_envio = 0
//
Return ll_retrieve
//
end event

event dw_3::ue_recuperar;//Override
DateTime ldh_data_1, ldh_data_2

Long lvl_liberar_envio, lvl_liberar_fechamento, ll_Linha

Long ll_Index_SubQuery	, ll_retrieve

String ls_situacao, ls_tipo_envio, ls_forma_envio, lvs_filter, ls_nf_canceladas

DateTime ldh_data



ls_situacao		= tab_1.tabpage_1.dw_2.object.id_situacao[tab_1.tabpage_1.dw_2.getrow()]
ls_tipo_envio	= tab_1.tabpage_1.dw_2.object.id_tipo_envio[tab_1.tabpage_1.dw_2.getrow()]
ldh_data			= tab_1.tabpage_1.dw_2.Object.dh_movimentacao_caixa[tab_1.tabpage_1.dw_2.getrow()]

If ls_situacao = 'PENDENTE' Then
	ls_situacao = 'P'
Else
	ls_situacao = 'S'
End If	

This.of_RestoreOriginalSQL()

ll_Index_SubQuery	= 1

ldh_data_1 =  DateTime(String(Date(ldh_data)) + ' 00:00:00.000')
ldh_data_2 =  DateTime(String(Date(ldh_data)) + ' 23:59:59.000')

If tab_1.tabpage_1.dw_1.object.dh_envio[1] = 'S' Then
  This.of_AppendWhere(" dh_movimentacao_caixa    BetWeen ' " + String(ldh_data_1, "yyyymmdd hh:mm:ss")  + " '  And ' "  +  String(ldh_data_2, "yyyymmdd hh:mm:ss")  + " ' ", ll_Index_SubQuery )  
																	//	String(ldh_data_2 "yyyymmdd hh:mm:ss") + " ' ")
Else
  This.of_AppendWhere(" dh_envio    BetWeen ' " + String(ldh_data_1, "yyyymmdd hh:mm:ss")  + " '  And ' "  +  String(ldh_data_2, "yyyymmdd hh:mm:ss")  + " ' ", ll_Index_SubQuery )  
  //This.of_AppendWhere(" dh_envio = '"+String(ldh_data, "yyyymmdd")+"'", ll_Index_SubQuery)	
End If

This.of_AppendWhere(" id_tipo_envio = '" + ls_tipo_envio + "'", ll_Index_SubQuery)

This.of_AppendWhere(" log_exportacao_scanntech.id_situacao = '" + ls_situacao + "'", ll_Index_SubQuery)


//Notas Canceladas
if ls_nf_canceladas = 'S' then
   This.of_AppendWhere_SubQuery(" ( dh_cancelado IS NOT NULL  ) ", ll_Index_SubQuery) 		 	
end if



//string ls_teste
//
//ls_teste = this.getsqlselect( )

ll_Linha = This.GetRow()

ll_retrieve = This.Retrieve()

if ll_retrieve > 0 then 
	 if this.find( " id_situacao  =  'P' ", 1 , this.rowcount() ) > 0 then
	   this.object.t_erro.text = 'Status Envio: Lote enviado com Erro'
	   this.modify(" t_erro.color=255")	
     else
	  this.object.t_erro.text = 'Status Envio: Lote enviado com Sucesso'
	  this.modify(" t_erro.color=RGB(0,0,128)")		
	end if
end if

This.SetRow(ll_Linha)
This.ScrollToRow(ll_Linha)

//if lvl_liberar_envio = 2 and ll_retrieve > 0 then
//  cb_envio.enabled = true	
//  cb_fechamento.enabled = false
//elseif lvl_liberar_fechamento = 2 and ll_retrieve > 0 then
//  cb_fechamento.enabled = true		
//  cb_envio.enabled = false	
//end if

lvl_liberar_envio = 0

Return ll_retrieve

end event

event dw_3::ue_postretrieve;//OverRide

Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True

//	This.ScrollToRow(1)
//	This.Event RowFocusChanged(1)
//	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Classificar)
This.ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)
This.ivo_Controle_Menu.of_Localizar(lvb_Localizar)
This.ivo_Controle_Menu.of_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

type cb_envio from commandbutton within tabpage_1
boolean visible = false
integer x = 2711
integer y = 152
integer width = 791
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Reprocessar Envio Vendas"
end type

event clicked;uo_ge538_scanntech_lote uo_ge538_reprocessa_envio

Boolean lb_ret

String lvs_filter

Long lvl_row, lvl_cont, lvl_cd_filial, lvl_nr_nf

Datetime ldh_mov_caixa

lvl_row = tab_1.tabpage_2.dw_3.rowcount() 

if lvl_row = 0 then
  Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existe envio de Vendas para Reprocessar."	)
  return	
end if 

if IsValid(uo_ge538_reprocessa_envio) then
  Destroy uo_ge538_reprocessa_envio	
end if

uo_ge538_reprocessa_envio = create uo_ge538_scanntech_lote

If Not IsValid(w_aguarde) then
	Open(w_aguarde)
End If	
		
w_aguarde.Title = "Processo Envio Scanntech.."
w_aguarde.uo_progress.of_reset()
w_aguarde.uo_progress.Of_SetMax(lvl_row)		

For lvl_cont = 1 To lvl_row
	
	// Somente $$HEX1$$e900$$ENDHEX$$ enviado as vendas, o fechamento $$HEX1$$e900$$ENDHEX$$ processado por agendamento.
	ldh_mov_caixa		=  tab_1.tabpage_2.dw_3.object.dh_movimentacao_caixa[lvl_cont]
   	lvl_cd_filial			=  tab_1.tabpage_2.dw_3.object.cd_filial[lvl_cont]	
   	lvl_nr_nf				=  tab_1.tabpage_2.dw_3.object.nr_nf[lvl_cont]
	
	w_aguarde.Title = "Envio Scanntech da Loja:"  + String(lvl_cd_filial)  + "- Nro:" + String(lvl_cont)+" De:"+String(lvl_row)				
	 
   	lb_ret = uo_ge538_reprocessa_envio.of_reprocessa_envio_vendas(ldh_mov_caixa, lvl_cd_filial, lvl_nr_nf)
 
	
   	If lb_ret = false then
		// Continua o processamento para ir atualizando os status dos movimentos	
			continue		
   	End if	
	w_aguarde.uo_progress.Of_SetProgress(lvl_cont)	
Next

Close(w_Aguarde)

cb_envio.enabled = true	

dw_2.Event ue_recuperar()








end event

type cb_fechamento from commandbutton within tabpage_1
integer x = 2706
integer y = 148
integer width = 791
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Reprocessar Vendas"
end type

event clicked;DateTime dh_data_envio, dh_data_fechamento
Boolean lb_retorno
Long ll_row
String lvs_filter

uo_ge538_scanntech_lote  uo_ge538_fechamento_diario

if IsValid(uo_ge538_fechamento_diario) then Destroy uo_ge538_fechamento_diario
uo_ge538_fechamento_diario = create uo_ge538_scanntech_lote

ll_row = dw_2.getrow()

dh_data_envio = dw_2.Object.dh_movimentacao_caixa[ll_row]
dh_data_fechamento = DateTime(String(dh_data_envio, "yyyy/mm/dd hh:mm"))
	 
Try
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Deseja realmente Reprocessar o Fechamento do Dia?', Exclamation! , YesNo!, 2 ) = 2 Then
		Return
	else
		if istr_param.reprocessar_fechamento = false then
			if not wf_libera_reprocessamento(dh_data_fechamento) then return
		else
			/* 
			Faz a libera$$HEX2$$e700e300$$ENDHEX$$o do reprocessamento conforme data selecionada e filiais selecionadas
			O parametro de data inicial e final j$$HEX1$$e100$$ENDHEX$$ foi carregado no clicked dos movimentos
			*/
			if not wf_libera_reprocessar_fechamento() then return
		end if
		
		uo_ge538_fechamento_diario.of_processa_fechamento_diario(Date(dh_data_fechamento))
	end if
	
Catch (RunTimeError lo_error)
   Destroy uo_ge538_fechamento_diario
Finally
   Destroy uo_ge538_fechamento_diario
End Try	

enabled = false
tab_1.tabpage_1.dw_2.Event ue_recuperar()
tab_1.tabpage_1.dw_2.Event ue_postretrieve(tab_1.tabpage_1.dw_2.rowcount())
end event

type cb_1 from commandbutton within tabpage_1
integer x = 2711
integer y = 256
integer width = 791
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Liberar Fechamento"
end type

event clicked;String ls_ok_cancelado

lstr_scanntech lstr_parm


OpenWithParm(w_ge538_libera_reprocessamento, lstr_parm )
	
lstr_parm = Message.Powerobjectparm

If lstr_parm.as_botao = 'CA' Then
     Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Procedimento cancelado.',stopsign!)
	Return
End If

uo_ge538_scanntech_lote luo_lote

luo_lote = create uo_ge538_scanntech_lote

luo_lote.of_liberar_movimento_processamento( Date(lstr_parm.dh_inicio), Date(lstr_parm.dh_termino), lstr_parm.cd_filial )

Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Data foi liberado para reprocessamento autom$$HEX1$$e100$$ENDHEX$$tico.') 

Destroy luo_lote
end event

type cb_email_diario from commandbutton within tabpage_1
boolean visible = false
integer x = 1627
integer y = 280
integer width = 402
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Email Di$$HEX1$$e100$$ENDHEX$$rio"
end type

event clicked;Try
				    	uo_ge538_scanntech_lote lo_scann_email
					 lo_scann_email = create uo_ge538_scanntech_lote
				 	lo_scann_email.of_envia_email_diario()
				    ///gf_atualiza_data_execucao_tarefa( 187 ,true)
				Finally
				 	Destroy (lo_scann_email)
				End Try	
end event

type gb_5 from groupbox within tabpage_2
integer x = 23
integer y = 2056
integer width = 3598
integer height = 308
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Mensagem"
end type

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 55
integer y = 2120
integer width = 3474
integer height = 220
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge538_erro"
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3767
integer height = 2388
long backcolor = 67108864
string text = "Valores"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_3.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_3.destroy
destroy(this.dw_5)
end on

type dw_5 from dc_uo_dw_base within tabpage_3
integer x = 5
integer y = 8
integer width = 3694
integer height = 2320
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge538_dados_nota_envio"
end type

event ue_recuperar;// Overrider
DateTime ldh_mov_caixa, ldh_data_1, ldh_data_2

Long lvl_nr_nf, ll_Index_SubQuery, ll_row

String lvs_de_especie, lvs_de_serie, lvs_forma_pagto, lvs_filtro, lvs_de_forma_pagamento

ll_row	= tab_1.tabpage_2.dw_3.GetRow()

If ll_row > 0 Then
	ldh_mov_caixa   =		tab_1.tabpage_2.dw_3.Object.dh_movimentacao_caixa[ll_row]
	lvl_nr_nf            =		tab_1.tabpage_2.dw_3.Object.nr_nf[ll_row]
	lvs_de_especie   =		tab_1.tabpage_2.dw_3.Object.de_especie[ll_row]
	lvs_de_serie       =	tab_1.tabpage_2.dw_3.Object.de_serie[ll_row]
	lvs_forma_pagto =	tab_1.tabpage_2.dw_3.Object.cd_forma_pagamento[ll_row]
	
	ldh_data_1 =  DateTime(String(Date(ldh_mov_caixa)) + ' 00:00:00.000')
    ldh_data_2 =  DateTime(String(Date(ldh_mov_caixa)) + ' 23:59:59.000')
End If

This.of_RestoreOriginalSQL()

this.AcceptText()

ll_Index_SubQuery	= 1

This.of_AppendWhere_SubQuery(   " dh_movimentacao_caixa = '"+String(ldh_mov_caixa, "yyyymmdd")+"' AND"  + &
                                                    " nr_nf = " + String(lvl_nr_nf) + " AND"  + &
											  " de_especie = '" + lvs_de_especie + "' AND"  + &
  											  " de_serie = '" + lvs_de_serie + "' "  , ll_Index_SubQuery)


This.Retrieve()

if ll_row < 1 then return 0



end event

