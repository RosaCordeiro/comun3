HA$PBExportHeader$w_ge541_wms_int_sap_monitor.srw
forward
global type w_ge541_wms_int_sap_monitor from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_solicitar from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type gb_6 from groupbox within tabpage_2
end type
type dw_5 from dc_uo_dw_base within tabpage_2
end type
type cbx_somente_diferenca from checkbox within tabpage_2
end type
type st_confirmar from statictext within w_ge541_wms_int_sap_monitor
end type
type gb_5 from groupbox within w_ge541_wms_int_sap_monitor
end type
end forward

global type w_ge541_wms_int_sap_monitor from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge541_wms_int_sap_monitor"
integer width = 4206
integer height = 2424
string title = "GE541 - Monitor Integra$$HEX2$$e700e300$$ENDHEX$$o WMS SAP"
long backcolor = 67108864
st_confirmar st_confirmar
gb_5 gb_5
end type
global w_ge541_wms_int_sap_monitor w_ge541_wms_int_sap_monitor

type variables
uo_filial io_filial
uo_fornecedor ivo_Fornecedor

Boolean ivb_Check

uo_ge473_comum iuo_ge473_comum

String is_SqlWMP

String is_Parametro, is_Operador

String is_Nr_Nf, is_Serie, is_Especie, is_Chave_NF_Origem
Long il_Chave_Integracao
Datetime idh_Inclusao	

String is_endereco_cancelamento, is_Endereco_Avaria, is_Endereco_Falta
end variables

forward prototypes
public subroutine wf_insere_padrao ()
public function boolean wf_grava_log (dc_uo_transacao ao_trans_mult, long al_nr_atualizacao, ref string as_log)
public function long wf_retorna_filial (long pl_filial)
public function boolean wf_cancela_integracao (long al_produto, string as_lote, date adt_validade, long al_qtde)
public function boolean wf_carrega_dados (long al_produto, long al_nr_nf_dev, string as_serie_dev, string as_especie_dev, ref long al_nr_nf_comp, ref string as_serie_comp, ref string as_especie_comp, ref string as_cd_fornecedor, ref string as_grupo_psico, ref string as_log)
public function boolean wf_busca_endereco_cancelamento (ref string ps_log)
public function boolean wf_grava_ajuste_estoque_wms (long al_produto, string as_endereco_entrada, string as_lote, datetime adt_validade, long al_qtde_movimento, ref string as_log)
public function boolean wf_verifica_usuario_ti ()
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

public function boolean wf_cancela_integracao (long al_produto, string as_lote, date adt_validade, long al_qtde);Long ll_Controle

Select nr_controle
Into :ll_Controle
from wms_segregado_recebimento
where cd_produto  =:al_produto
   and nr_lote = :as_lote
   and dh_validade = :adt_validade
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
		
		update wms_segregado_recebimento
		set qt_lote = qt_lote + :al_qtde
		where cd_produto  	=:al_produto
			and nr_lote 			=:as_lote
			and dh_validade 	=:adt_validade
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao atualizar o segregado recebimento.")
			Return False
		End If
				
	Case 100	
		
		  INSERT INTO wms_segregado_recebimento  ( cd_endereco, cd_produto, nr_lote, dh_validade, qt_lote )  
		  VALUES ( 'A900060A', :al_produto, :as_lote, :adt_validade, :al_qtde)
		  Using SqlCa;
		  
		  If SqlCa.SqlCode = - 1 Then
 			SqlCa.of_MsgDbError("Erro ao localizar o segregado recebimento.")
			 Return False
		  End If
		
	Case -1 
		SqlCa.of_MsgDbError("Erro ao localizar o segregado recebimento.")
		Return False
		
End Choose

Return True

end function

public function boolean wf_carrega_dados (long al_produto, long al_nr_nf_dev, string as_serie_dev, string as_especie_dev, ref long al_nr_nf_comp, ref string as_serie_comp, ref string as_especie_comp, ref string as_cd_fornecedor, ref string as_grupo_psico, ref string as_log);
SetNull(al_nr_nf_comp)
SetNull(as_serie_comp)
SetNull(as_especie_comp)
SetNull(as_cd_fornecedor)
SetNull(as_grupo_psico)

is_Chave_NF_Origem = '534/' + string(al_nr_nf_dev) + '/' + as_serie_dev + '/' + as_especie_dev
		
select top 1 ndc.cd_fornecedor, 
		 ndc.nr_nf_compra, 
		 ndc.de_serie_compra,
		 ndc.de_especie_compra
  into  :as_cd_fornecedor,
		 :al_nr_nf_comp,
		 :as_serie_comp,
		 :as_especie_comp
  from nf_devolucao_compra ndc
 inner join nf_devolucao_compra_prd_lote ndcpl 
 			on ndcpl.cd_filial 	= ndc.cd_filial 
		  and ndcpl.nr_nf 		= ndc.nr_nf  
		  and ndcpl.de_especie 	= ndc.de_especie  
		  and ndcpl.de_serie 	= ndc.de_serie  
 where ndc.cd_filial 	= 534
  	and ndc.nr_nf 			= :al_nr_nf_dev
	and ndc.de_serie 		= :as_serie_dev
	and ndc.de_especie 	= :as_especie_dev
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_log = 'Dados n$$HEX1$$e300$$ENDHEX$$o localizados da nota de compra. Origem: [' + is_Chave_NF_Origem + '] .'
		return false
	Case -1
		as_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_carrega_dados.' + '~n' + sqlca.SqlErrText
		return false
End Choose

select cd_grupo_psico 
into :as_grupo_psico
from produto_geral 
where cd_produto = :al_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_log = 'Produto ' + string (al_produto) + ' n$$HEX1$$e300$$ENDHEX$$o encontrado!'
		return false
	Case -1
		as_log = 'Erro ao buscar grupo psico do Produto ' + string (al_produto) + '~n' + sqlca.SqlErrText
		return false
End Choose

return True

end function

public function boolean wf_busca_endereco_cancelamento (ref string ps_log);String	ls_param_end


ls_param_end	= 'CD_ENDERECO_SEG_NF_REENTRADA'

SELECT vl_parametro
  INTO :is_endereco_cancelamento
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

ls_param_end   = 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_AVARIA'

SELECT vl_parametro
  INTO :is_Endereco_Avaria
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

ls_param_end   = 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_FALTA'

SELECT vl_parametro
  INTO :is_Endereco_Falta
  FROM wms_parametro
 WHERE cd_parametro = :ls_param_end
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		ps_log = "Erro ao obter o endere$$HEX1$$e700$$ENDHEX$$o de destino no par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ':~n~n~r' + SQLCA.SQLErrText
		Return False
	case 100
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro '" + ls_param_end + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!'
		Return False
End choose

Return True
end function

public function boolean wf_grava_ajuste_estoque_wms (long al_produto, string as_endereco_entrada, string as_lote, datetime adt_validade, long al_qtde_movimento, ref string as_log);String ls_Erro
String ls_Comentario

Long ll_nr_ajuste_estoque

Date ldh_Movimento

ldh_Movimento = Date(gf_GetServerDate())

Select coalesce(max(nr_ajuste), 0) + 1 
Into :ll_nr_ajuste_estoque
From wms_ajuste_estoque
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_RollBack()
	MessageBox("Erro", "Erro ao inserir dados na tabela 'wms_ajuste_estoque': "+ ls_Erro)		
	Return False
End If

ls_Comentario = 'NOTA DE REENTRADA (DIVERSA): ' + is_Chave_NF_Origem

INSERT INTO wms_ajuste_estoque (	nr_ajuste,   
												cd_produto,   
												cd_endereco,   
												nr_lote,   
												dh_validade,   
												qt_caixa_padrao,   
												qt_ajuste,   
												id_entrada_saida,   
												dh_ajuste,   
												dh_movimentacao_caixa,   
												de_comentario_ajuste,   
												nr_matricula_responsavel,
												cd_motivo_ajuste)  
VALUES (:ll_nr_ajuste_estoque, 	//nr_ajuste,   
			:al_produto,					//cd_produto,   
			:as_endereco_entrada,	//cd_endereco,   
			:as_lote,						//nr_lote,   
			:adt_validade,				//dh_validade,   
			1,  							// qt_caixa_padrao
			:al_qtde_movimento, 		//qt_ajuste,   
			'E', 							//id_entrada_saida,   
			getdate(),					//dh_ajuste,   
			:ldh_Movimento,			//dh_movimentacao_caixa,   
			:ls_Comentario, 			//de_comentario_ajuste,   
			:is_Operador,						//nr_matricula_responsavel
			42) 							//cd_motivo_ajuste
Using SqlCa;

//42 - AUTORIZADAS PELO COMPRAS

If SqlCa.SqlCode = -1 Then
	as_log = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_ajuste_estoque_wms' + '~nProblemas ao inserir "wms_ajuste_estoque": ~n' + sqlca.SqlErrText
	SqlCa.of_RollBack()
	return false
End If

Return True

end function

public function boolean wf_verifica_usuario_ti ();If gvo_Aplicacao.ivo_Seguranca.nr_matricula = '14231' or &
	gvo_Aplicacao.ivo_Seguranca.nr_matricula = '14174' or &
	gvo_Aplicacao.ivo_Seguranca.nr_matricula = '215672' or &
	gvo_Aplicacao.ivo_Seguranca.nr_matricula = '505091' or &
	gvo_Aplicacao.ivo_Seguranca.nr_matricula = '505107' or &
	gvo_Aplicacao.ivo_Seguranca.nr_matricula = '995670' or &
	gvo_Aplicacao.ivo_Seguranca.nr_matricula = '995810' or &
	gvo_Aplicacao.ivo_Seguranca.nr_matricula = '505315' Then
	Return True
End If
end function

on w_ge541_wms_int_sap_monitor.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
this.Control[iCurrent+2]=this.gb_5
end on

on w_ge541_wms_int_sap_monitor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_confirmar)
destroy(this.gb_5)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.dt_inicio_inclusao[1] = RelativeDate(Date(gf_GetServerDate()),  -6)
Tab_1.TabPage_1.dw_1.Object.dt_termino_inclusao[1] = Date(gf_GetServerDate())

wf_insere_padrao()

Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)

iuo_ge473_comum	= Create uo_ge473_comum
ivo_Fornecedor		= Create uo_Fornecedor

//#if defined DEBUG then
//   tab_1.tabpage_1.cb_processar.visible = True
//#end if

SetNull(is_Parametro)
is_Parametro	= Trim(Message.StringParm)

If Not IsNull(is_Parametro) and Trim(is_Parametro) <> "" and is_parametro <> 'w_ge541_wms_int_sap_monitor' Then
	Long ll_Pos_A, ll_Pos_H, ll_Pos_S, ll_Pos_P
	
	ll_Pos_A = Pos(is_Parametro, "@") + 1
	ll_Pos_H = Pos(is_Parametro, "#") + 1
	ll_Pos_S = Pos(is_Parametro, "$") + 1
	ll_Pos_P = Pos(is_Parametro, "%") + 1
	
	il_Chave_Integracao 	= Long(Left(is_Parametro, ll_Pos_A - 2))
	is_Nr_Nf 					= Mid(is_Parametro, ll_Pos_A, (ll_Pos_H - ll_Pos_A) - 1)
	is_Serie 					= Mid(is_Parametro, ll_Pos_H, (ll_Pos_S - ll_Pos_H) - 1)
	is_Especie 				= Mid(is_Parametro, ll_Pos_S, (ll_Pos_P - ll_Pos_S) - 1)
	idh_Inclusao				= datetime(Mid(is_Parametro, ll_Pos_P))
	
	tab_1.tabpage_1.dw_1.object.nr_nota[1] = Long(is_Nr_Nf)
	tab_1.tabpage_1.dw_1.object.de_serie[1] = is_Serie
	tab_1.tabpage_1.dw_1.object.de_especie[1] = is_Especie
	tab_1.tabpage_1.dw_1.object.nr_integracao[1] = il_Chave_Integracao
	tab_1.tabpage_1.dw_1.object.dt_inicio_inclusao[1] = idh_Inclusao
	tab_1.tabpage_1.dw_1.object.id_situacao[1] = 'T'

	This.event ue_retrieve( )
	
End If

end event

event open;call super::open;io_Filial = Create uo_Filial

ivb_Check = False
end event

event close;call super::close;Destroy(io_Filial)
Destroy(ivo_Fornecedor)
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge541_wms_int_sap_monitor
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge541_wms_int_sap_monitor
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge541_wms_int_sap_monitor
integer x = 32
integer y = 0
integer width = 4110
integer height = 2228
end type

event tab_1::selectionchanged;//OverRide

//Tab_1.TabPage_2.cbx_1.Checked = False
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4073
integer height = 2112
cb_solicitar cb_solicitar
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type

on tabpage_1.create
this.cb_solicitar=create cb_solicitar
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_solicitar
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_solicitar)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 9
integer y = 436
integer width = 4037
integer height = 1668
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 9
integer width = 4037
integer height = 420
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 59
integer y = 72
integer width = 3365
integer height = 356
string dataobject = "dw_ge541_wms_int_sap_parametros"
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
integer x = 32
integer y = 492
integer width = 3986
integer height = 1596
string dataobject = "dw_ge541_wms_int_sap_detalhes"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;Long		ll_nr_nf, ll_cd_tipo, ll_nr_integracao, ll_Agrupamento
Date		ldt_inicio_inclusao, ldt_termino_inclusao
String	ls_id_situacao, ls_cd_fornecedor, ls_de_serie, ls_de_especie, ls_cd_chave, ls_dados, ls_Nota


Tab_1.TabPage_1.dw_1.AcceptText()		

ldt_Inicio_inclusao	= Tab_1.TabPage_1.dw_1.Object.dt_inicio_inclusao[1]
ldt_Termino_inclusao	= Tab_1.TabPage_1.dw_1.Object.dt_termino_inclusao[1]
ls_id_situacao			= Tab_1.TabPage_1.dw_1.Object.id_situacao[1]
ll_cd_tipo				= Tab_1.TabPage_1.dw_1.Object.cd_tipo[1]
ls_cd_fornecedor		= Tab_1.TabPage_1.dw_1.Object.cd_fornecedor[1]
ll_nr_nf					= Tab_1.TabPage_1.dw_1.Object.nr_nota[1]
ls_de_serie				= Tab_1.TabPage_1.dw_1.Object.de_serie[1]
ls_de_especie			= Tab_1.TabPage_1.dw_1.Object.de_especie[1]
ll_nr_integracao		= Tab_1.TabPage_1.dw_1.Object.nr_integracao[1]
ls_cd_chave				= Tab_1.TabPage_1.dw_1.Object.cd_chave[1]
ll_Agrupamento		= Tab_1.TabPage_1.dw_1.Object.nr_agrupamento_dev_compra[1]
ls_dados					= Tab_1.TabPage_1.dw_1.Object.de_dados_adicionais[1]
ls_Nota  					= Tab_1.TabPage_1.dw_1.Object.id_nota[1]

If IsNull(ldt_Inicio_inclusao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar a data de in$$HEX1$$ed00$$ENDHEX$$cio de inclus$$HEX1$$e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_inclusao")
	Return -1
End If

If IsNull(ldt_Termino_inclusao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar a data de t$$HEX1$$e900$$ENDHEX$$rmino de inclus$$HEX1$$e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino_inclusao")
	Return -1
End If

If ldt_Inicio_inclusao > ldt_Termino_inclusao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio de inclus$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino de inclus$$HEX1$$e300$$ENDHEX$$o.", Information!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio_inclusao")
	Return -1
End If

dw_2.SetRedraw(False)

if ls_id_situacao <> 'T' then
	This.of_appendwhere_subquery(" w.id_situacao = '" + ls_id_situacao + "'", 2)
end if

if ll_cd_tipo > 0 and not IsNull(ll_cd_tipo) then
	This.of_appendwhere_subquery(" w.cd_tipo = " + String(ll_cd_tipo), 2)
end if

This.of_appendwhere_subquery(" cast(w.dh_inclusao as date)  between '"+String(ldt_Inicio_inclusao, "YYYYMMDD")+"' and '"+String(ldt_Termino_inclusao, "YYYYMMDD")+"'", 2)

if not IsNull(ls_cd_fornecedor) and Trim(ls_cd_fornecedor) <> '' then
	This.of_appendwhere_subquery(" w.cd_fornecedor = '" + ls_cd_fornecedor + "'", 2)
end if

If ls_Nota = 'S' Then
	This.of_appendwhere_subquery("w.nr_nf is null ", 2)
End If

If ll_nr_nf > 0 Then
	This.of_appendwhere_subquery("w.nr_nf = "+String(ll_nr_nf), 2)
End If

if not IsNull(ls_de_serie) and trim(ls_de_serie) <> '' then
	This.of_appendwhere_subquery(" w.de_serie = '" + ls_de_serie + "'", 2)
end if

if not IsNull(ls_de_especie) and trim(ls_de_especie) <> '' then
	This.of_appendwhere_subquery(" w.de_especie= '" + ls_de_especie + "'", 2)
end if

//if not IsNull(ls_cd_chave) and trim(ls_cd_chave) <> '' then
//	This.of_appendwhere_subquery(" w.cd_chave_interface = '" + ls_cd_chave + "'", 1)
//end if

// Consulta a chave tanto na wms_int_sap quanto na log_exportacao_sap
if not IsNull(ls_cd_chave) and trim(ls_cd_chave) <> '' then
	This.of_appendwhere_subquery("( w.cd_chave_interface = '" + ls_cd_chave + "' or " + "w.nr_integracao in (select cast(dbo.retorna_so_numeros(cd_chave) as numeric) from dbo.log_exportacao_sap les  where dh_exportacao >= '" + String(ldt_Inicio_inclusao, "YYYYMMDD") + "' and cd_chave_interface = '" + ls_cd_chave + "') )", 2)
end if

if not IsNull(ls_dados) and trim(ls_dados) <> '' then
	This.of_appendwhere_subquery(" w.de_dados_adicionais like '%" + ls_dados + "%'", 2)
end if

If ll_nr_integracao	> 0 Then
	This.of_appendwhere_subquery("w.nr_integracao = "+String(ll_nr_integracao), 2)
End If

If ll_Agrupamento	> 0 Then
	This.of_appendwhere_subquery("w.nr_agrupamento_dev_compra = "+String(ll_Agrupamento), 2)
End If


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

event dw_2::constructor;call super::constructor;// Habilitar a linha de sele$$HEX2$$e700e300$$ENDHEX$$o (list)
This.of_SetRowSelection()

end event

event dw_2::destructor;call super::destructor;destroy iuo_ge473_comum
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4073
integer height = 2112
gb_6 gb_6
dw_5 dw_5
cbx_somente_diferenca cbx_somente_diferenca
end type

on tabpage_2.create
this.gb_6=create gb_6
this.dw_5=create dw_5
this.cbx_somente_diferenca=create cbx_somente_diferenca
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_6
this.Control[iCurrent+2]=this.dw_5
this.Control[iCurrent+3]=this.cbx_somente_diferenca
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_6)
destroy(this.dw_5)
destroy(this.cbx_somente_diferenca)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 5
integer y = 4
integer width = 3703
integer height = 300
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 32
integer y = 48
integer width = 3662
integer height = 240
string dataobject = "dw_ge541_wms_int_sap_detalhes_saldo"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::ue_recuperar;Long		ll_linha, ll_total_linhas, ll_nr_integracao, ll_cd_tipo
String	ls_de_erro, ls_cd_chave


ll_linha = Tab_1.TabPage_1.dw_2.GetRow()

ll_cd_tipo = Tab_1.TabPage_1.dw_2.GetItemNumber(ll_linha,"cd_tipo")
If ll_cd_tipo = 6 Then //Consulta Saldo
	Tab_1.TabPage_2.cbx_somente_diferenca.visible = true
	Tab_1.TabPage_2.cbx_somente_diferenca.checked = false
	Tab_1.TabPage_2.dw_3.of_changedataobject("dw_ge541_wms_int_sap_detalhes_saldo")
	Tab_1.TabPage_2.dw_5.of_changedataobject("dw_ge541_wms_int_sap_produtos_wmp")

	Tab_1.TabPage_2.dw_3.y 			= 48
	Tab_1.TabPage_2.dw_3.height 	= 240
	Tab_1.TabPage_2.gb_3.y			= 4
	Tab_1.TabPage_2.gb_3.height	= 300
	Tab_1.TabPage_2.dw_5.y 			= 344
	Tab_1.TabPage_2.dw_5.height 	= 1736
	Tab_1.TabPage_2.gb_6.y			= 296
	Tab_1.TabPage_2.gb_6.height	= 1804	
	
	If IsNull(is_SqlWMP) or is_SqlWMP = '' Then
		is_SqlWMP = Tab_1.TabPage_2.dw_5.of_getsql( )
	Else
		Tab_1.TabPage_2.dw_5.of_changesql( is_SqlWMP )
	End If
Else
	Tab_1.TabPage_2.cbx_somente_diferenca.visible = false
	Tab_1.TabPage_2.dw_3.of_changedataobject("dw_ge541_wms_int_sap_consulta_detalhes")
	Tab_1.TabPage_2.dw_5.of_changedataobject("dw_ge541_wms_int_sap_produtos")
	
	Tab_1.TabPage_2.dw_3.y 			= 80
	Tab_1.TabPage_2.dw_3.height 	= 588
	Tab_1.TabPage_2.gb_3.y			= 20
	Tab_1.TabPage_2.gb_3.height	= 656
	Tab_1.TabPage_2.dw_5.y 			= 720
	Tab_1.TabPage_2.dw_5.height 	= 1368
	Tab_1.TabPage_2.gb_6.y			= 672
	Tab_1.TabPage_2.gb_6.height	= 1436

End If


ll_nr_integracao	= Tab_1.TabPage_1.dw_2.Object.nr_integracao[ll_linha]

ll_total_linhas = This.Retrieve(ll_nr_integracao)

if ll_total_linhas > 0 then
	ls_cd_chave	= This.GetItemString(1, 'cd_chave')
	
	if Not IsNull(ls_cd_chave) and Trim(ls_cd_chave) <> '' then
		select de_erro
		  into :ls_de_erro
		  from log_exportacao_sap
		 where cd_chave	= :ls_cd_chave;
		 
		This.SetItem(1, 'de_erro', ls_de_erro)
	end if
	
	Tab_1.TabPage_2.dw_5.trigger event ue_recuperar()
end if

Return ll_total_linhas




	
	



end event

event dw_3::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event dw_3::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type cb_solicitar from commandbutton within tabpage_1
integer x = 3355
integer y = 180
integer width = 654
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Solicitar Conf. Saldo"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma a solicita$$HEX2$$e700e300$$ENDHEX$$o da valida$$HEX2$$e700e300$$ENDHEX$$o de saldo SAP x LEGADO ?",Question!,YesNo!) = 1 Then
	Open(w_ge541_wms_solicita_conf_saldo)
	
	If Message.doubleparm = 1 Then
		tab_1.tabpage_1.dw_2.event ue_recuperar( )
	End If
	
End If
end event

type cb_1 from commandbutton within tabpage_1
integer x = 3355
integer y = 72
integer width = 654
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar Integra$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;Boolean lb_Sucesso = True

Long ll_Integracao
Long ll_Tipo
Long ll_Linha, ll_Linhas
Long ll_Produto
Long ll_Qtde
Long ll_Nulo

DateTime ldh_Validade

String ls_Situacao
String ls_Lote
String ls_Nulo

ll_Tipo  			= Tab_1.TabPage_1.dw_2.GetItemNumber(Tab_1.TabPage_1.dw_2.GetRow(),"cd_tipo")
ll_Integracao  	= Tab_1.TabPage_1.dw_2.GetItemNumber(Tab_1.TabPage_1.dw_2.GetRow(),"nr_integracao")
ls_Situacao 		= Tab_1.TabPage_1.dw_2.GetItemString(Tab_1.TabPage_1.dw_2.GetRow(),"id_situacao")



If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja cancelar a solicita$$HEX2$$e700e300$$ENDHEX$$o de devolu$$HEX2$$e700e300$$ENDHEX$$o de compra ?", Question!, YesNo!, 2) = 2 Then
	Return
End If

If ll_Tipo <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cancelamento permitido somente para o tipo [1].")
	Return
End If

If ls_Situacao <> 'I' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Permitido somente para a situa$$HEX2$$e700e300$$ENDHEX$$o Integrada.")
	Return
End If

dc_uo_ds_base lo
lo = Create dc_uo_ds_base

try
	
	If Not lo.of_changeDataObject("dw_ge541_wms_int_sap_detalhes_canc") Then Return
	
	ll_Linhas = lo.Retrieve(ll_Integracao)
	
	For ll_Linha = 1 to ll_Linhas
		
		ls_Lote 		= lo.Object.nr_lote[ll_Linha]
		ll_Produto 	= lo.Object.cd_produto[ll_Linha]
		ll_Qtde		= lo.Object.qt_lote[ll_Linha]
		ldh_Validade= lo.Object.dh_validade[ll_Linha]
		
		uo_ge258_movimentacao lo_Movimentacao

		SetNull(ls_Nulo)
		SetNull(ll_Nulo)
		
		lo_Movimentacao = create uo_ge258_movimentacao

		lo_Movimentacao.ivb_Commit = False
				
		If Not lo_Movimentacao.of_Insere_Movimentacao('A900060A',&
																	ls_Nulo,&
																	ll_Produto,&
																	1,&
																	ls_Lote,&
																	Date(ldh_Validade),&
																	ll_Qtde,&
																	'G',&
																	534,&
																	ls_Nulo,&
																	ll_Nulo,&
																	ls_Nulo,&
																	ls_Nulo,&
																	gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,&
																	ll_Nulo) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Erro na lo_Movimentacao.of_Insere_Movimentacao. Produto: '+ String(ll_Produto))
			lb_Sucesso = False
			Return																					 
		End If
				
		If Not wf_cancela_integracao(ll_Produto, ls_Lote, Date(ldh_Validade), ll_Qtde) Then
			lb_Sucesso = False
			Return
		End If
		
	Next	
	
finally
	
	If lb_Sucesso Then
		
		Update wms_int_sap
		set id_situacao = 'X'
		Where nr_integracao = :ll_Integracao
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao cancelar a integra$$HEX2$$e700e300$$ENDHEX$$o.")
			Sqlca.of_Rollback();
		Else
			Sqlca.of_Commit();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Integra$$HEX2$$e700e300$$ENDHEX$$o SAP cancelada com sucesso.")
		End If
		
	Else
		Sqlca.of_Rollback();
	End If
	
end try

end event

type cb_2 from commandbutton within tabpage_1
integer x = 3355
integer y = 284
integer width = 654
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Enviar Nova Solicita$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;Boolean lb_Sucesso = True

Long ll_Integracao
Long ll_Tipo
Long ll_Linha, ll_Linhas
Long ll_Produto
Long ll_Qtde
Long ll_Nulo
Long ll_Nota

String ls_Situacao
String ls_Nulo
String ls_log
String ls_fornecedor

If Not wf_verifica_usuario_ti() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente usu$$HEX1$$e100$$ENDHEX$$rio da TI poder$$HEX1$$e100$$ENDHEX$$ executar esta funcionalidade.", Exclamation!)
	Return 
End IF

ll_Tipo  			= Tab_1.TabPage_1.dw_2.GetItemNumber(Tab_1.TabPage_1.dw_2.GetRow(),"cd_tipo")
ll_Integracao  	= Tab_1.TabPage_1.dw_2.GetItemNumber(Tab_1.TabPage_1.dw_2.GetRow(),"nr_integracao")
ls_Situacao 		= Tab_1.TabPage_1.dw_2.GetItemString(Tab_1.TabPage_1.dw_2.GetRow(),"id_situacao")
ls_fornecedor   = Tab_1.TabPage_1.dw_2.GetItemString(Tab_1.TabPage_1.dw_2.GetRow(),"cd_fornecedor")
ll_Nota			= Tab_1.TabPage_1.dw_2.GetItemNumber(Tab_1.TabPage_1.dw_2.GetRow(),"nr_nf")

/// deixar somente para descarte

If ll_Tipo <> 4 and ll_Tipo <> 3 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este processo $$HEX1$$e900$$ENDHEX$$ somente para as notas DESCARTE do SEGREGADO ou INVENT$$HEX1$$c100$$ENDHEX$$RIO.", Exclamation!)
	Return
End If

If Not IsNull(ll_Nota) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta solicita$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ possui nota fiscal.", Exclamation!)
	Return
End If

If ls_Situacao <> 'P' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente solicita$$HEX2$$e700f500$$ENDHEX$$es processadas poder$$HEX1$$e300$$ENDHEX$$o ser reenviadas.")
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja enviar uma nova solicita$$HEX2$$e700e300$$ENDHEX$$o p/ gerar NF de DESCARTE/INVENT$$HEX1$$c100$$ENDHEX$$RIO ?~r~rIntegra$$HEX2$$e700e300$$ENDHEX$$o:" + String(ll_Integracao), Question!, YesNo!, 2) = 2 Then
	Return
End If

Update wms_int_sap
set id_situacao = 'C', cd_chave_interface_ant = cd_chave_interface,  cd_chave_interface = null
Where nr_integracao = :ll_Integracao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao reenviar a integra$$HEX2$$e700e300$$ENDHEX$$o.")
	Sqlca.of_Rollback();
End If

st_log_export_sap st_log

Choose Case ll_Tipo
	Case 4
		st_log.cd_chave 				= String(ll_Integracao)
		st_log.id_tipo_nf 			= 'WMA'
		st_log.cd_tipo_documento	= 'WMA'
		st_log.id_tipo_log 			= 73
		st_log.cd_filial  			= ll_Nulo
		st_log.nr_nf  					= ll_Nulo
		st_log.de_especie  			= ls_Nulo
		st_log.de_serie  				= ls_Nulo
		st_log.cd_fornecedor			= ls_fornecedor
		st_log.cd_parametro_geral	= 'DH_INICIO_OPERACAO_SAP'
	Case 3
		st_log.cd_chave 				= String(ll_Integracao)
		st_log.id_tipo_nf 			= 'WMI'
		st_log.cd_tipo_documento	= 'WMI'
		st_log.id_tipo_log 			= 73
		st_log.cd_filial  			= ll_Nulo
		st_log.nr_nf  					= ll_Nulo
		st_log.de_especie  			= ls_Nulo
		st_log.de_serie  				= ls_Nulo
		st_log.cd_fornecedor			= ls_fornecedor
		st_log.cd_parametro_geral	= 'DH_INICIO_OPERACAO_SAP'
		st_log.cd_integer				= Long(String(gf_getserverdate(), 'yyyy'))
		st_log.cd_varchar				= 'INVENTARIO'
End Choose

If gf_insere_log_exportacao_sap(st_log, ref ls_log) then
	Sqlca.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nova solicita$$HEX2$$e700e300$$ENDHEX$$o criada com sucesso.")
	tab_1.tabpage_1.dw_2.event ue_recuperar( )
Else
	Sqlca.of_rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_log)
	Return
End If



end event

type cb_3 from commandbutton within tabpage_1
integer x = 1257
integer y = 52
integer width = 654
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Dividir Solicita$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;Long ll_Integracao
Long ll_Tipo
Long ll_Linha, ll_Linhas
Long ll_Nota
Long ll_Sequencial
Long ll_Integracao_Nova
Long ll_Qtde_Itens_Nova_Int
Long ll_Qtde_Itens

String ls_Situacao
String ls_Nulo
String ls_log
String ls_fornecedor
String ls_Erro

ll_Qtde_Itens_Nova_Int = 250

If Not wf_verifica_usuario_ti() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente usu$$HEX1$$e100$$ENDHEX$$rio da TI poder$$HEX1$$e100$$ENDHEX$$ executar esta funcionalidade.", Exclamation!)
	Return 
End IF

ll_Tipo  			= Tab_1.TabPage_1.dw_2.GetItemNumber(Tab_1.TabPage_1.dw_2.GetRow(),"cd_tipo")
ll_Integracao  	= Tab_1.TabPage_1.dw_2.GetItemNumber(Tab_1.TabPage_1.dw_2.GetRow(),"nr_integracao")
ls_Situacao 		= Tab_1.TabPage_1.dw_2.GetItemString(Tab_1.TabPage_1.dw_2.GetRow(),"id_situacao")
ll_Nota  			= Tab_1.TabPage_1.dw_2.GetItemNumber(Tab_1.TabPage_1.dw_2.GetRow(),"nr_nf")

If ll_Tipo <> 4 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este processo $$HEX1$$e900$$ENDHEX$$ somente para as notas DESCARTE do SEGREGADO.", Exclamation!)
	Return
End If

If Not IsNull(ll_Nota) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta solicita$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ possui nota fiscal.", Exclamation!)
	Return
End If

If ls_Situacao <> 'X' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente solicita$$HEX2$$e700f500$$ENDHEX$$es CANCELADA poder$$HEX1$$e300$$ENDHEX$$o ser QUEBRADAS.")
	Return
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Repetir este passo at$$HEX1$$e900$$ENDHEX$$ aparecer a mensagem: N$$HEX1$$e300$$ENDHEX$$o existem mais produtos para serem divididos.", Exclamation!)

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja criar uma nova solicita$$HEX2$$e700e300$$ENDHEX$$o p/ gerar NF de DESCARTE ?~r~rIntegra$$HEX2$$e700e300$$ENDHEX$$o:" + String(ll_Integracao), Question!, YesNo!, 2) = 2 Then
	Return
End If

select count(*)
Into :ll_Qtde_Itens
from wms_int_sap_detalhe
where nr_integracao =:ll_Integracao
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar a quantidade de intens da integra$$HEX2$$e700e300$$ENDHEX$$o")
	return
End If

If ll_Qtde_Itens <= ll_Qtde_Itens_Nova_Int Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade de itens da integra$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ menor que '" + string(ll_Qtde_Itens_Nova_Int) + "'.~rN$$HEX1$$e300$$ENDHEX$$o precisa quebrar.", Exclamation!)
	Return
End If

dc_uo_ds_base lds

lds = Create dc_uo_ds_base

// pega somente os produto com o de_erro nulo, pois quando $$HEX1$$e900$$ENDHEX$$ criada uma nova solicita$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ gravado o novo numero no erro
// com isso podemos executar quantas vezes necess$$HEX1$$e100$$ENDHEX$$rio
If Not lds.of_ChangeDataObject("ds_ge541_wms_int_sap_lista_prd") Then
	Sqlca.of_RollBack()
	destroy(lds)
	return
End If

// S$$HEX1$$f300$$ENDHEX$$ retorna com erro nulo, os que tiverem preenchidos j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e300$$ENDHEX$$o em outro wms_int_sap
ll_Linhas = lds.Retrieve(ll_Integracao)

If ll_linhas = 0  Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem mais produtos para serem divididos.")
	Return
End If

Open(w_Aguarde)
w_Aguarde.Title = "Aguarde"

select max(nr_integracao) + 1
Into :ll_Integracao_Nova
from wms_int_sap 
where nr_integracao >= 999000
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar a pr$$HEX1$$f300$$ENDHEX$$xima integra$$HEX2$$e700f500$$ENDHEX$$ acima de 999000")
	Sqlca.of_RollBack()
	Close(w_aguarde)
	Return
End If

ls_Erro = String(ll_Integracao_Nova)

INSERT INTO wms_int_sap ( nr_integracao,cd_tipo,dh_inclusao,id_situacao,cd_fornecedor,cd_filial,cd_transportadora,qt_volume,de_especie_volume,
									 de_marca_volume,nr_volume,qt_peso_liquido,qt_peso_bruto,de_dados_adicionais,cd_motivo_devolucao,nr_documento_sap,   
 									 nr_ano_documento_sap,nr_agrupamento_dev_compra,nr_inventario,cd_tipo_movimento_sap,cd_direcao_movimento_sap, 
									 de_erro,cd_cliente,id_somente_com_saldo,cd_produto,cd_deposito,cd_fornecedor_incineracao,cd_centro_custo_sap,nr_matricula_responsavel,   
									 cd_tipo_frete,cd_conta_sap)  
 select    :ll_Integracao_Nova,cd_tipo,getdate(),'C',cd_fornecedor,cd_filial,cd_transportadora,qt_volume,de_especie_volume,de_marca_volume,   
 			nr_volume,qt_peso_liquido,qt_peso_bruto,de_dados_adicionais,cd_motivo_devolucao,nr_documento_sap,nr_ano_documento_sap, 
			nr_agrupamento_dev_compra,nr_inventario,cd_tipo_movimento_sap,cd_direcao_movimento_sap,de_erro,cd_cliente,id_somente_com_saldo,   
           	cd_produto,cd_deposito,cd_fornecedor_incineracao,cd_centro_custo_sap,nr_matricula_responsavel,cd_tipo_frete,cd_conta_sap
from wms_int_sap
where nr_integracao = :ll_Integracao // cria uma c$$HEX1$$f300$$ENDHEX$$pia da integra$$HEX2$$e700e300$$ENDHEX$$o atual, mas com um novo n$$HEX1$$fa00$$ENDHEX$$mero de integra$$HEX2$$e700e300$$ENDHEX$$o
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao inserir a nova solicita$$HEX2$$e700e300$$ENDHEX$$o")
	Sqlca.of_RollBack()
	Close(w_aguarde)
	Return
End If

w_Aguarde.uo_Progress.of_setmax(ll_Linhas)

For ll_Linha = 1 To ll_Linhas
	
	// Finaliza integra$$HEX2$$e700e300$$ENDHEX$$o
	If ll_linha > ll_Qtde_Itens_Nova_Int Then 
		exit
	End If
		
	ll_Sequencial = lds.Object.nr_sequencial[ll_Linha]
	
	INSERT INTO wms_int_sap_detalhe ( nr_integracao,nr_sequencial, cd_produto,nr_lote,qt_lote,dh_fabricacao,dh_validade,cd_chave_movimento_estoque_wms,nr_ajuste_estoque,   
	 												id_entrada_saida,cd_deposito_sap_saida,cd_deposito_sap_entrada,cd_produto_sap,vl_preco,pc_desconto,cd_unidade_medida, 
													qt_saldo_legado,de_erro,id_reajustado )  
	select  :ll_Integracao_Nova,:ll_Linha,cd_produto,nr_lote,qt_lote,dh_fabricacao,dh_validade,cd_chave_movimento_estoque_wms,nr_ajuste_estoque,id_entrada_saida,   
				cd_deposito_sap_saida, cd_deposito_sap_entrada,cd_produto_sap,vl_preco,pc_desconto,cd_unidade_medida,qt_saldo_legado,de_erro,id_reajustado
	from wms_int_sap_detalhe
	where nr_integracao = :ll_Integracao // integra$$HEX2$$e700e300$$ENDHEX$$o atual
	  and nr_sequencial =: ll_Sequencial // sequencial da integra$$HEX2$$e700e300$$ENDHEX$$o atual
	using sqlca;
    
	If Sqlca.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao inserir a nova solicita$$HEX2$$e700e300$$ENDHEX$$o detalhe")
		Sqlca.of_RollBack()
		Close(w_aguarde)
		Return
	End If
 
	update wms_int_sap_detalhe
	set de_erro = :ls_Erro
	where nr_integracao = :ll_Integracao // integra$$HEX2$$e700e300$$ENDHEX$$o atual
	and nr_sequencial =: ll_Sequencial // sequencial da integra$$HEX2$$e700e300$$ENDHEX$$o atual
	using sqlca;
		 
	If Sqlca.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao inserir a nova solicita$$HEX2$$e700e300$$ENDHEX$$o detalhe")
		Sqlca.of_RollBack()
		Close(w_aguarde)
		Return
	End If
	

	w_aguarde.uo_progress.of_setprogress(ll_Linha)
Next

destroy(lds)

SqlCa.of_Commit()

Close(w_aguarde)

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Terminou.")

tab_1.tabpage_1.dw_2.event ue_recuperar( )

//
//st_log_export_sap st_log
//
//st_log.cd_chave 				= String(ll_Integracao)
//st_log.id_tipo_nf 				= 'WMA'
//st_log.cd_tipo_documento	= 'WMA'
//st_log.id_tipo_log 				= 73
//st_log.cd_filial  					= ll_Nulo
//st_log.nr_nf  					= ll_Nulo
//st_log.de_especie  			= ls_Nulo
//st_log.de_serie  				= ls_Nulo
//st_log.cd_fornecedor			= ls_fornecedor
//st_log.cd_parametro_geral	= 'DH_INICIO_OPERACAO_SAP'
//
//If gf_insere_log_exportacao_sap(st_log, ref ls_log) then
//	Sqlca.of_Commit();
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nova solicita$$HEX2$$e700e300$$ENDHEX$$o criada com sucesso.")
//	tab_1.tabpage_1.dw_2.event ue_recuperar( )
//Else
//	Sqlca.of_rollback();
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_log)
//	Return
//End If
//
//

end event

type gb_6 from groupbox within tabpage_2
integer x = 5
integer y = 296
integer width = 4032
integer height = 1804
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

type dw_5 from dc_uo_dw_base within tabpage_2
integer x = 32
integer y = 344
integer width = 3991
integer height = 1736
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge541_wms_int_sap_produtos"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;Long		ll_linha, ll_nr_item, ll_total_linhas

ll_linha = Tab_1.TabPage_1.dw_2.GetRow()

il_Chave_Integracao	= Tab_1.TabPage_1.dw_2.Object.nr_integracao[ll_linha]

This.of_SetRowSelection()

ll_total_linhas = This.Retrieve(il_Chave_Integracao)

Return ll_total_linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event clicked;call super::clicked;String ls_log, ls_Lote, ls_Grupo_Psico, ls_cd_fornecedor, &
		 ls_serie_dev, ls_especie_dev, ls_serie_comp, ls_especie_comp,&
		 ls_Endereco_Entrada, ls_Endereco_Saida, ls_Nulo, ls_Id_Reajustado
		
Long ll_Produto, ll_Qt_Lote, ll_cd_motivo_devolucao, ll_qt_nf_dev,&
		ll_nr_nf_dev, ll_nr_nf_comp, ll_Nulo, ll_nr_sequencial, ll_nr_integracao

Datetime ldh_Validade

Boolean lb_Sucesso = True

Choose case dwo.name
	Case "bt_ajustar"
		If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE541_WMS_INT_SAP_BT_AJUSTE", ref is_Operador) Then 
			lb_Sucesso = False
			Return -1
		End If
		gvo_Aplicacao.ivo_Seguranca.of_Localiza_Usuario(is_Operador)
		
		Try
			Open(w_aguarde)
	
			If Not wf_busca_endereco_cancelamento(ref ls_log) Then 
				lb_Sucesso = False
				SqlCa.of_Rollback()
				Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',ls_log)
				Return -1
			End If
			
			ll_nr_nf_dev	= Dw_3.object.nr_nf			[1]
			ls_serie_dev		= Dw_3.object.de_serie		[1]
			ls_especie_dev	= Dw_3.object.de_especie	[1]
			ll_cd_motivo_devolucao 	= Dw_3.object.cd_motivo_devolucao	[1]
			
			ll_Produto 		= Long(This.object.cd_produto		[row])
			ll_Qt_Lote 		= Long(This.object.qt_lote			[row])
			ldh_Validade 	= This.object.dh_validade			[row]
			ls_Lote			= This.object.nr_lote					[row]
			ls_Id_Reajustado = This.object.id_reajustado		[row]
			ll_nr_sequencial	= This.object.nr_sequencial		[row]
			ll_qt_nf_dev 		= Long(This.object.qt_nf_dev 	[row])
			
			ll_Qt_Lote = ll_Qt_Lote - ll_qt_nf_dev
			
			If ls_Id_Reajustado <> 'S' Then
			
				If Not wf_carrega_dados(ll_Produto, ll_nr_nf_dev, ls_serie_dev, ls_especie_dev, &
													Ref ll_nr_nf_comp, Ref ls_serie_comp, Ref ls_especie_comp, Ref ls_cd_fornecedor, Ref ls_Grupo_Psico, &
													Ref ls_Log) Then
					lb_Sucesso = False
					SqlCa.of_Rollback()
					Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',ls_log)
					Return -1
				End If
				
				update item_nf_compra_lote
					set qt_devolvida = qt_devolvida - :ll_Qt_Lote
				 where cd_produto		= :ll_Produto
					and nr_lote			= :ls_Lote
					//and dh_validade	= :ldh_Validade
					and cd_filial		= 534
					and cd_fornecedor	= :ls_cd_fornecedor
					and nr_nf			= :ll_nr_nf_comp
					and de_serie		= :ls_serie_comp
					and de_especie		= :ls_especie_comp
				Using SQLCA;
				
				If SqlCa.SqlCode = -1 Then
					lb_Sucesso = False
					SqlCa.of_Rollback()
					Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'Problemas ao atualizar a quantidade devolvida na tabela item_nf_compra_lote: ~n' + sqlca.SqlErrText)
					return -1
				End If
				
				Choose case ll_cd_motivo_devolucao
					case 1 //AVARIA
						ls_Endereco_Entrada = is_Endereco_Avaria
					case 5 //FALTA
						ls_Endereco_Entrada = is_Endereco_Falta
					case else //outros tipos de devolu$$HEX2$$e700e300$$ENDHEX$$o v$$HEX1$$e300$$ENDHEX$$o para o endere$$HEX1$$e700$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rico
						ls_Endereco_Entrada = is_endereco_cancelamento
				End choose
				
				uo_ge258_movimentacao lo_Movimentacao
							
				SetNull(ll_Nulo)
				SetNull(ls_Nulo)
				
				Try
					lo_Movimentacao = Create uo_ge258_movimentacao
					
					lo_Movimentacao.ivb_Commit = False
					
					SetNull(ls_Endereco_Saida)
					
					If Not lo_Movimentacao.of_insere_movimentacao(	ls_Endereco_Entrada,&
																					ls_Endereco_Saida,&
																					ll_produto,&
																					1,&
																					ls_Lote,&
																					Date(ldh_Validade),&
																					ll_Qt_Lote,&
																					"J",&
																					534,&
																					ls_Nulo,&  
																					ll_nr_nf_comp,&
																					ls_especie_comp,&
																					ls_serie_comp,&
																					is_Operador) Then
						lb_Sucesso = False
						SqlCa.of_Rollback()
						Return -1
					End If
					
					INSERT INTO wms_segregado_recebimento  (cd_endereco,   
																		 cd_fornecedor,   
																		 nr_nf,   
																		 de_especie,   
																		 de_serie,   
																		 cd_produto,   
																		 nr_lote,   
																		 dh_validade,   
																		 qt_lote)  
					VALUES (	:ls_Endereco_Entrada,   
								:ls_cd_fornecedor,   
								:ll_nr_nf_comp,   
								:ls_especie_comp,   
								:ls_serie_comp,   
								:ll_produto,   
								:ls_Lote,   
								:ldh_Validade,   
								:ll_Qt_Lote)
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						lb_Sucesso = False
						SqlCa.of_Rollback()
						Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', "Problema na inclus$$HEX1$$e300$$ENDHEX$$o do lote na tabela wms_segregado_recebimento '" + SQLCA.SQLErrText + "'.")
						Return -1
					End If
				Finally
					Destroy(lo_Movimentacao)	
				End Try	
				
				If Not wf_grava_ajuste_estoque_wms(ll_produto, ls_Endereco_Entrada, ls_Lote, ldh_Validade, ll_Qt_Lote, ref ls_log ) Then
					lb_Sucesso = False
					SqlCa.of_Rollback()
					Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',ls_log)
					Return -1
				End If
				
				update wms_int_sap_detalhe
					set id_reajustado = 'S'
				 where nr_integracao = :il_Chave_Integracao
					and nr_sequencial = :ll_nr_sequencial
					and cd_produto		= :ll_Produto
					and nr_lote			= :ls_Lote
				Using SQLCA;
				
				If SqlCa.SqlCode = -1 Then
					lb_Sucesso = False
					SqlCa.of_Rollback()
					Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'Problemas ao atualizar id_reajustado na tabela wms_int_sap_detalhe: ~n' + sqlca.SqlErrText)
					return -1
				End If
				
				If lb_Sucesso Then		
					SqlCa.of_Commit()
					Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Ajuste realizado com sucesso!')
					This.event ue_recuperar( )
				End If
				
			Else
				SqlCa.of_Rollback()
				Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Produto j$$HEX1$$e100$$ENDHEX$$ foi reajustado anteriormente.')
				Return 1
			End If
		Finally
			If IsValid(w_aguarde) Then Close(w_aguarde)
		End Try
End Choose

end event

type cbx_somente_diferenca from checkbox within tabpage_2
integer x = 2117
integer y = 352
integer width = 1413
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Mostrar somente registros com diferen$$HEX1$$e700$$ENDHEX$$a de saldo"
end type

event clicked;If this.checked Then
	Tab_1.TabPage_2.dw_5.of_appendwhere("coalesce(w.qt_lote,0) <> coalesce(w.qt_saldo_legado,0)")
Else
	Tab_1.TabPage_2.dw_5.of_changesql( is_SqlWMP )
End If

Tab_1.TabPage_2.dw_5.trigger event ue_recuperar()
end event

type st_confirmar from statictext within w_ge541_wms_int_sap_monitor
boolean visible = false
integer x = 3968
integer y = 732
integer width = 91
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

type gb_5 from groupbox within w_ge541_wms_int_sap_monitor
integer x = 23
integer y = 812
integer width = 2994
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

