HA$PBExportHeader$w_ge540_monitor_estorno_recebimento.srw
forward
global type w_ge540_monitor_estorno_recebimento from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_2
end type
type gb_6 from groupbox within tabpage_2
end type
type st_confirmar from statictext within w_ge540_monitor_estorno_recebimento
end type
type gb_5 from groupbox within w_ge540_monitor_estorno_recebimento
end type
end forward

global type w_ge540_monitor_estorno_recebimento from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge540_monitor_estorno_recebimento"
integer width = 4965
integer height = 2448
string title = "GE540 - Monitor Estorno de Recebimento"
long backcolor = 67108864
st_confirmar st_confirmar
gb_5 gb_5
end type
global w_ge540_monitor_estorno_recebimento w_ge540_monitor_estorno_recebimento

type variables
uo_filial io_filial
uo_fornecedor ivo_Fornecedor

Boolean ivb_Check

uo_ge473_comum iuo_ge473_comum
end variables

forward prototypes
public subroutine wf_insere_padrao ()
public function boolean wf_grava_log (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao, ref string as_log)
public function long wf_retorna_filial (long pl_filial)
public function boolean wf_grava_log_exportacao_sap (string as_nr_recebimento, string as_de_chave_acesso, string as_cd_fornecedor, datetime adh_recebimento)
public subroutine wf_setar_parametros_monitor_erros (string as_fornecedor, string as_tipo)
end prototypes

public subroutine wf_insere_padrao ();
end subroutine

public function boolean wf_grava_log (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao, ref string as_log);

Insert into log_exportacao_sap_hist ( NR_ATUALIZACAO,
												CD_EMPRESA,
												DH_DOCUMENTO,
												DH_LANCAMENTO,
												CD_TIPO_DOCUMENTO,
												NR_DOCUMENTO_REF,
												DE_TEXTO,
												CD_MOEDA,
												CD_FILIAL,
												NR_IDF_DOCTO,
												ID_SITUACAO_DOCTO,
												ID_STATUS_INTEGRACAO,
												DH_EXPORTACAO,
												NR_DOCUMENTO_SAP,
												DH_ESTORNADO_SAP,
												DH_EXCLUIDO_SAP,
												CD_TIPO_DOC_MULT,
												DE_TIPO_DOC_MULT,
												ID_ESTORNAR,
												DE_ERRO,
												NR_DOCUMENTO_SAP_ESTORNADO,
												CD_CHAVE_INTERFACE,
												CD_AMBIENTE_SAP,
												QT_LANCAMENTO,
												NR_IDF_PADRAO_DOCTO,
												NR_MATRICULA,
												DT_REGISTRO,
												HOST_NAME)
Select NR_ATUALIZACAO,
			CD_EMPRESA,
			DH_DOCUMENTO,
			DH_LANCAMENTO,
			CD_TIPO_DOCUMENTO,
			NR_DOCUMENTO_REF,
			DE_TEXTO,
			CD_MOEDA,
			CD_FILIAL,
			NR_IDF_DOCTO,
			ID_SITUACAO_DOCTO,
			ID_STATUS_INTEGRACAO,
			DH_EXPORTACAO,
			NR_DOCUMENTO_SAP,
			DH_ESTORNADO_SAP,
			DH_EXCLUIDO_SAP,
			CD_TIPO_DOC_MULT,
			DE_TIPO_DOC_MULT,
			ID_ESTORNAR,
			DE_ERRO,
			NR_DOCUMENTO_SAP_ESTORNADO,
			CD_CHAVE_INTERFACE,
			CD_AMBIENTE_SAP,
			QT_LANCAMENTO,
			NR_IDF_PADRAO_DOCTO,
			:gvo_aplicacao.ivo_seguranca.nr_matricula,
			getdate(),
			host_name()
	from log_exportacao_sap
	where nr_atualizacao = :al_nr_atualizacao
Using ao_trans_mult;

if ao_trans_mult.sqlcode = -1 then
	as_log = 'objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_grava_log ~nErro ao inserir registro na tabela "log_exportacao_sap_hist": ' + sqlca.sqlerrtext
	return false
end if

return true
end function

public function long wf_retorna_filial (long pl_filial);Long ll_Filial

Choose Case pl_filial
	Case 1, 534 // ESTOQUE CENTRAL
		ll_Filial = 100
	Case 2, 688	// MATRIZ E MANIP. JOINVILLE
		ll_Filial = 534
	Case 809		// FARMAGORA
		ll_Filial = 790
	Case 695 	//JOINVILLE_DE
		ll_Filial = 149
	Case 696		//JARAGUA_DE
		ll_Filial = 84
	Case 699		//DE_FLORIPA
		ll_Filial = 301
	Case 700		//BLUMENAU_DE
		ll_Filial = 136
	Case 701		//CRICIUMA_DE
		ll_Filial = 107
	Case 704		//ITAJAI_DE
		ll_Filial = 71
	Case 705 	//LAGES_DE
		ll_Filial = 42
	Case 708 	//TUBAR$$HEX1$$c300$$ENDHEX$$O_DE
		ll_Filial = 550
	Case	709	//BALNEARIO CAMBORIU_DE					
		ll_Filial = 592
	Case 712	  	//CHAPECO_DE
		ll_Filial = 39
	Case 733	 	//GASPAR_DE
		ll_Filial = 330
	Case Else		
		ll_Filial = pl_filial
End Choose

Return ll_Filial
end function

public function boolean wf_grava_log_exportacao_sap (string as_nr_recebimento, string as_de_chave_acesso, string as_cd_fornecedor, datetime adh_recebimento);String ls_Log

st_log_export_sap st_log


st_log.id_tipo_nf 			= 'WMS'
st_log.cd_tipo_documento   = 'WMS'
st_log.id_tipo_log 			= 76
st_log.cd_chave 				= as_nr_recebimento
st_log.cd_parametro_geral  = 'DH_INICIO_OPERACAO_SAP'
st_log.cd_chave_interface	= as_de_chave_acesso
st_log.nr_nf					= Long(mid(as_de_chave_acesso, 26,9))
st_log.cd_fornecedor			= as_cd_fornecedor
st_log.dh_documento			= adh_recebimento

If Not gf_insere_log_exportacao_sap(st_log, ref ls_Log) then
	Sqlca.of_rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Log)
	Return False
End If			

Return True
end function

public subroutine wf_setar_parametros_monitor_erros (string as_fornecedor, string as_tipo);Date	ld_null


SetNull(ld_null)

This.Tab_1.TabPage_1.dw_1.Object.dt_inicio_emissao[1] = Date('1900-01-01')
This.Tab_1.TabPage_1.dw_1.Object.dt_termino_emissao[1] = Date('2500-12-31')

This.Tab_1.TabPage_1.dw_1.Object.id_situacao[1]	= as_tipo

ivo_Fornecedor.of_Localiza_Fornecedor(as_fornecedor)

If ivo_Fornecedor.Localizado Then
	This.Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor	[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Tab_1.TabPage_1.dw_1.Object.Nm_Fornecedor	[1] = ivo_Fornecedor.Nm_Razao_Social
End If

This.Tab_1.TabPage_1.dw_2.Trigger Event ue_recuperar()
end subroutine

on w_ge540_monitor_estorno_recebimento.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
this.Control[iCurrent+2]=this.gb_5
end on

on w_ge540_monitor_estorno_recebimento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_confirmar)
destroy(this.gb_5)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.dt_inicio_emissao[1] = RelativeDate(Date(gf_GetServerDate()),  -6)
Tab_1.TabPage_1.dw_1.Object.dt_termino_emissao[1] = Date(gf_GetServerDate())

wf_insere_padrao()

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)

iuo_ge473_comum	= Create uo_ge473_comum
ivo_Fornecedor		= Create uo_Fornecedor

//#if defined DEBUG then
//   tab_1.tabpage_1.cb_processar.visible = True
//#end if
//

end event

event open;call super::open;io_Filial = Create uo_Filial

ivb_Check = False
end event

event close;call super::close;Destroy(io_Filial)
Destroy(ivo_Fornecedor)
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge540_monitor_estorno_recebimento
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge540_monitor_estorno_recebimento
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge540_monitor_estorno_recebimento
integer x = 27
integer y = 4
integer width = 4869
integer height = 2228
end type

event tab_1::selectionchanged;//OverRide

//Tab_1.TabPage_2.cbx_1.Checked = False
end event

event tab_1::selectionchanging;SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		Tab_1.TabPage_2.dw_5.Event ue_Recuperar()

		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4832
integer height = 2112
cb_1 cb_1
cb_2 cb_2
end type

on tabpage_1.create
this.cb_1=create cb_1
this.cb_2=create cb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 46
integer y = 344
integer width = 4896
integer height = 1740
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 37
integer width = 4050
integer height = 324
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 59
integer y = 72
integer width = 4014
integer height = 260
string dataobject = "dw_ge540_parametros"
end type

event dw_1::itemchanged;call super::itemchanged;Long	ll_Nulo

If dwo.Name = "nm_fantasia" Then
	
	SetNull(ll_Nulo)
	
	If data = "" or IsNull(data) Then
		This.Object.cd_filial[1] = ll_Nulo
	Else
		If Data <> io_filial.nm_fantasia Then Return 1
	End If	
	
End If

if dwo.name = "nm_fornecedor" then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
	End If
end if
end event

event dw_1::ue_key;call super::ue_key;String	ls_Coluna,&
		ls_Filial

If Key = KeyEnter! Then

	ls_Coluna = This.GetColumnName()

	If ls_Coluna = "nm_fantasia" Then

		ls_Filial = Tab_1.TabPage_1.dw_1.GetText()

		io_Filial.of_Localiza_Filial(ls_Filial)
		
		// Verifica se a Filial foi localizada e atualiza a DW
		If io_Filial.Localizada  Then
			Tab_1.TabPage_1.dw_1.Object.cd_filial			[1] = io_Filial.cd_filial
			Tab_1.TabPage_1.dw_1.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
		Else
		
			SetNull(io_Filial.Cd_Filial)
			io_Filial.Nm_Fantasia = ""
			
			Tab_1.TabPage_1.dw_1.Object.cd_filial[1] = io_filial.cd_filial
			Tab_1.TabPage_1.dw_1.Object.nm_fantasia[1] = io_filial.nm_fantasia
			
		End If
		
	End If
	
	if ls_coluna = 'nm_fornecedor' then
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())

		If ivo_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor	[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor	[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
	end if
End If
end event

event dw_1::constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
event ue_mousemove pbm_mousemove
integer x = 69
integer y = 400
integer width = 4837
integer height = 1668
string dataobject = "dw_ge540_detalhes"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_mousemove;If This.RowCount() > 0 Then
	If (xpos >= Long(This.Object.id_imagem.X)  and (xpos <= (Long(This.Object.id_imagem.X)  + 73))) and &
		  (ypos >= Long(This.Object.id_imagem.Y)	and (ypos <= (Long(This.Object.id_imagem.Y) + 64))) Then	 
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
End If
end event

event dw_2::ue_recuperar;Long		ll_nr_pedido, ll_nr_nf
Date		ldt_inicio_emissao, &
			ldt_termino_emissao
String	ls_id_situacao, ls_id_status, ls_de_chave_acesso, ls_cd_fornecedor, ls_nr_recebimento


Tab_1.TabPage_1.dw_1.AcceptText()		

ldt_Inicio_emissao	= Tab_1.TabPage_1.dw_1.Object.dt_inicio_emissao[1]
ldt_Termino_emissao	= Tab_1.TabPage_1.dw_1.Object.dt_termino_emissao[1]
ls_id_situacao			= Tab_1.TabPage_1.dw_1.Object.id_situacao[1]
ls_id_status			= String(Tab_1.TabPage_1.dw_1.Object.id_status[1])
ls_de_chave_acesso	= Tab_1.TabPage_1.dw_1.Object.de_chave_acesso[1]
ls_cd_fornecedor		= Tab_1.TabPage_1.dw_1.Object.cd_fornecedor[1]
ls_nr_recebimento		= Tab_1.TabPage_1.dw_1.Object.nr_recebimento[1]
ll_nr_pedido			= Tab_1.TabPage_1.dw_1.Object.nr_pedido[1]
ll_nr_nf					= Tab_1.TabPage_1.dw_1.Object.nr_nota[1]

If IsNull(ldt_Inicio_emissao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar a data de in$$HEX1$$ed00$$ENDHEX$$cio de emiss$$HEX1$$e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_emissao")
	Return -1
End If

If IsNull(ldt_Termino_emissao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar a data de t$$HEX1$$e900$$ENDHEX$$rmino de emiss$$HEX1$$e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino_emissao")
	Return -1
End If

If ldt_Inicio_emissao > ldt_Termino_emissao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio de emiss$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino de emissa$$HEX1$$e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_emissao")
	Return -1
End If

dw_2.SetRedraw(False)

if ls_id_situacao <> 'T' then
	This.of_AppendWhere(" r.id_situacao = '" + ls_id_situacao + "'", 1)
end if

if ls_id_status <> 'T' then
	This.of_AppendWhere(" r.id_status = '" + ls_id_status + "'", 1)
end if

This.of_AppendWhere(" cast(r.dh_recebimento as date)  between '"+String(ldt_inicio_emissao, "YYYYMMDD")+"' and '"+String(ldt_termino_emissao, "YYYYMMDD")+"'", 1)

If ll_nr_pedido > 0 Then
	This.of_AppendWhere("r.nr_pedido = "+String(ll_nr_pedido), 1)
End If

if not IsNull(ls_cd_fornecedor) and Trim(ls_cd_fornecedor) <> '' then
	This.of_AppendWhere(" r.cd_fornecedor = '" + ls_cd_fornecedor + "'", 1)
end if

If ll_nr_nf > 0 Then
	This.of_AppendWhere("cast(substring(r.de_chave_acesso, 26,9) as int) = "+String(ll_nr_nf), 1)
End If

if not IsNull(ls_nr_recebimento) and Trim(ls_nr_recebimento) <> '' then
	This.of_AppendWhere(" r.nr_recebimento = '" + ls_nr_recebimento + "'", 1)
end if

if not IsNull(ls_de_chave_acesso) and trim(ls_de_chave_acesso) <> '' then
	if len(trim(ls_de_chave_acesso)) <> 44 then
		This.of_AppendWhere(" (r.de_chave_acesso like '%" + ls_de_chave_acesso + "%' or r.de_chave_acesso_alterada like '%" + ls_de_chave_acesso + "%')", 1)
	else
		This.of_AppendWhere(" (r.de_chave_acesso = '" + ls_de_chave_acesso + "' or r.de_chave_acesso_alterada = '" + ls_de_chave_acesso + "') ", 1)
	end if
end if

If This.Retrieve(1000) < 0 Then
	This.Reset()
	Return -1
End If

If IsValid(w_Aguarde) Then
	Close(w_Aguarde)
End If
	
SetPointer(Arrow!)

This.Trigger Event RowFocusChanged(dw_2.getRow())

dw_2.SetRedraw(True)

Return This.RowCount()
end event

event dw_2::doubleclicked;call super::doubleclicked;Long lvl_Row
	  
String lvs_Marcacao,&
	   lvs_Nulo 

SetNull(lvs_Nulo)

Choose Case dwo.Name 
			
	Case 'id_imagem'
			
		If ivb_Check Then
			lvs_Marcacao = 'N'
			ivb_Check = False
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		Else
			lvs_Marcacao = 'S'
			ivb_Check = True
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		End If
		
		For lvl_Row = 1 To This.RowCount()
					
			This.Object.id_selecionar[lvl_Row] = lvs_Marcacao
			
		Next
		
End Choose
end event

event dw_2::constructor;call super::constructor;// Habilitar a linha de sele$$HEX2$$e700e300$$ENDHEX$$o (list)
This.of_SetRowSelection()

end event

event dw_2::destructor;call super::destructor;destroy iuo_ge473_comum
end event

event dw_2::clicked;call super::clicked;if row = 0 then
	this.groupcalc()
end if
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4832
integer height = 2112
dw_5 dw_5
gb_6 gb_6
end type

on tabpage_2.create
this.dw_5=create dw_5
this.gb_6=create gb_6
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.gb_6
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.gb_6)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 5
integer y = 24
integer width = 3319
integer height = 788
string text = "Produtos"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 32
integer y = 80
integer width = 3278
integer height = 720
string dataobject = "dw_ge540_produtos"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::ue_recuperar;Long		ll_linha, ll_total_linhas
String	ls_nr_recebimento


ll_linha = Tab_1.TabPage_1.dw_2.GetRow()

ls_nr_recebimento	= Tab_1.TabPage_1.dw_2.Object.nr_recebimento[ll_linha]

ll_total_linhas = This.Retrieve(ls_nr_recebimento)

if ll_total_linhas > 0 then
	Tab_1.TabPage_2.dw_5.trigger event ue_recuperar()
end if

Return ll_total_linhas




	
	



end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_3::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type cb_1 from commandbutton within tabpage_1
integer x = 4133
integer y = 76
integer width = 677
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Solicitar Estorno"
end type

event clicked;DateTime	ldh_estornado, ldh_solicitacao_estorno, ldh_dh_atual, ldh_recebimento
Long		ll_exists, ll_for
String	ls_Operador, ls_de_chave_acesso, ls_nr_recebimento, ls_cd_fornecedor, ls_id_selecionar


if not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE540_MONITOR_ESTORNO_RECEBIMENTO", ref ls_Operador) then return

for ll_for = 1 to Tab_1.TabPage_1.dw_2.RowCount()
	ls_id_selecionar	= Tab_1.TabPage_1.dw_2.Object.id_selecionar[ll_for]
	
	if ls_id_selecionar = 'S' then
		ls_nr_recebimento		= Tab_1.TabPage_1.dw_2.Object.nr_recebimento[ll_for]
		ls_de_chave_acesso	= Tab_1.TabPage_1.dw_2.Object.de_chave_acesso[ll_for]
		ls_cd_fornecedor		= Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[ll_for]
		ldh_recebimento		= Tab_1.TabPage_1.dw_2.Object.dh_recebimento[ll_for]
		
		ll_exists	= 0
		
		select 1
		  into :ll_exists
		  from nf_compra_pendente
		 where de_chave_acesso	= :ls_de_chave_acesso;
		
		if sqlca.SqlCode < 0 then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: clicked' + '~nErro ao encontrar nf_compra_pendente: ~n' + sqlca.SqlErrText, StopSign!)
			
			return
		end if
		
		if ll_exists = 1 then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O recebimento n$$HEX1$$e300$$ENDHEX$$o pode ser estornado pois a confer$$HEX1$$ea00$$ENDHEX$$ncia da mercadoria j$$HEX1$$e100$$ENDHEX$$ foi iniciada.', StopSign!)
			
			return
		end if
		
		ll_exists	= 0
		
		select 1
		  into :ll_exists
		  from nf_compra
		 where de_chave_acesso	= :ls_de_chave_acesso;
		
		if sqlca.SqlCode < 0 then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: clicked' + '~nErro ao encontrar nf_compra: ~n' + sqlca.SqlErrText, StopSign!)
			
			return
		end if
		
		if ll_exists = 1 then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O recebimento n$$HEX1$$e300$$ENDHEX$$o pode ser estornado porque a nota foi confirmada.', StopSign!)
			
			return
		end if
		
		select dh_estornado
		  into :ldh_estornado
		  from recebimento_sap
		 where nr_recebimento = :ls_nr_recebimento;
		 
		if sqlca.SqlCode < 0 then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: clicked' + '~nErro ao buscar o campo dh_estornado na tabela recebimento_sap: ~n' + sqlca.SqlErrText, StopSign!)
			
			return
		end if
		
		if not IsNull(ldh_estornado) and Date(ldh_estornado) <> Date('1900-01-01') then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O recebimento j$$HEX1$$e100$$ENDHEX$$ foi estornado.', StopSign!)
			
			return
		end if
		
		select dh_solicitacao_estorno
		  into :ldh_solicitacao_estorno
		  from recebimento_sap
		 where nr_recebimento = :ls_nr_recebimento;
		 
		if sqlca.SqlCode < 0 then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: clicked' + '~nErro ao buscar o campo dh_solicitacao_estorno na tabela recebimento_sap: ~n' + sqlca.SqlErrText, StopSign!)
			
			return
		end if
		
		if not IsNull(ldh_solicitacao_estorno) and Date(ldh_solicitacao_estorno) <> Date('1900-01-01') then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A solicita$$HEX2$$e700e300$$ENDHEX$$o de estorno do recebimento j$$HEX1$$e100$$ENDHEX$$ foi realizada.', StopSign!)
			
			return
		end if
		
		ldh_dh_atual	= gf_getserverdate()
		
		update recebimento_sap
			set nr_matricula_solic_estorno	= :ls_Operador,
				 dh_solicitacao_estorno			= :ldh_dh_atual,
				 id_situacao						= 'X'
		 where nr_recebimento	= :ls_nr_recebimento;
		 
		if sqlca.SqlCode < 0 then
			sqlca.of_rollback();
			
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: clicked' + '~nErro ao atualizar solicita$$HEX2$$e700e300$$ENDHEX$$o de estorno na recebimento_sap: ~n' + sqlca.SqlErrText, StopSign!)
			
			return
		end if
		
		update nf_agendamento_ent
			set dh_cancelamento_agendamento		= getdate(),
				 nr_matricula_canc_agendamento	= '14330',
				 de_motivo_canc_agendamento  		= 'RECEB. ESTORNADO NO SAP'
		 where de_chave_acesso = :ls_de_chave_acesso;
		
		if sqlca.SqlCode < 0 then
			sqlca.of_rollback();
			
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: clicked' + '~nErro ao cancelar agendamento da nf: ~n' + sqlca.SqlErrText, StopSign!)
			
			return
		end if
		
		if not wf_grava_log_exportacao_sap(ls_nr_recebimento, ls_de_chave_acesso, ls_cd_fornecedor, ldh_recebimento) then
			return
		end if
		
		commit;
	end if
next

Tab_1.TabPage_1.dw_2.Trigger Event ue_recuperar()
Tab_1.TabPage_1.dw_2.SetFocus()
end event

type cb_2 from commandbutton within tabpage_1
integer x = 4133
integer y = 184
integer width = 677
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Colocar como pendente"
end type

event clicked;Long		ll_for
String	ls_id_selecionar, ls_nr_recebimento, ls_de_chave_acesso


for ll_for = 1 to Tab_1.TabPage_1.dw_2.RowCount()
	ls_id_selecionar	= Tab_1.TabPage_1.dw_2.Object.id_selecionar[ll_for]
	
	if ls_id_selecionar = 'S' then
		ls_nr_recebimento		= Tab_1.TabPage_1.dw_2.Object.nr_recebimento[ll_for]
		ls_de_chave_acesso	= Tab_1.TabPage_1.dw_2.Object.de_chave_acesso[ll_for]
		
		update recebimento_sap
			set id_situacao	= 'C'
		 where nr_recebimento	= :ls_nr_recebimento;
		 
		if sqlca.SqlCode < 0 then
			sqlca.of_rollback();
			
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: clicked' + '~nErro ao colocar recebimento_sap como pendente: ~n' + sqlca.SqlErrText, StopSign!)
			
			return
		end if
		
		if ls_de_chave_acesso <> '' then
			delete from nf_agendamento_ent_divergencia
					where de_chave_acesso	= :ls_de_chave_acesso;
					
			if sqlca.SqlCode < 0 then
				sqlca.of_rollback();
				
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: clicked' + '~nErro ao deletar as divergencias do agendamento: ~n' + sqlca.SqlErrText, StopSign!)
				
				return
			end if
		end if
				
		commit;
	end if
next

Tab_1.TabPage_1.dw_2.Trigger Event ue_recuperar()
Tab_1.TabPage_1.dw_2.SetFocus()
end event

type dw_5 from dc_uo_dw_base within tabpage_2
integer x = 32
integer y = 868
integer width = 3287
integer height = 1036
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge540_log"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;Long		ll_linha, ll_total_linhas
String	ls_nr_recebimento


ll_linha = Tab_1.TabPage_2.dw_3.GetRow()

ls_nr_recebimento		= Tab_1.TabPage_2.dw_3.Object.nr_recebimento[ll_linha]

This.of_SetRowSelection()

ll_total_linhas = This.Retrieve(ls_nr_recebimento)

Return ll_total_linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type gb_6 from groupbox within tabpage_2
integer x = 5
integer y = 816
integer width = 3319
integer height = 1120
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Log Exporta$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type st_confirmar from statictext within w_ge540_monitor_estorno_recebimento
boolean visible = false
integer x = 3968
integer y = 732
integer width = 709
integer height = 68
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
boolean focusrectangle = false
end type

type gb_5 from groupbox within w_ge540_monitor_estorno_recebimento
integer x = 23
integer y = 812
integer width = 3456
integer height = 1168
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

