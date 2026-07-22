HA$PBExportHeader$w_ge259_manutencao_pedido.srw
forward
global type w_ge259_manutencao_pedido from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_lista_separacao from commandbutton within tabpage_1
end type
type cb_gerar_picking from commandbutton within tabpage_1
end type
type cb_finalizar_separacao from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type st_confirmar from statictext within w_ge259_manutencao_pedido
end type
end forward

global type w_ge259_manutencao_pedido from dc_w_2tab_consulta_selecao_lista_det
integer width = 3369
integer height = 1868
string title = "GE259 - Manuten$$HEX2$$e700e300$$ENDHEX$$o de Pedidos"
st_confirmar st_confirmar
end type
global w_ge259_manutencao_pedido w_ge259_manutencao_pedido

type variables
uo_filial ivo_filial
uo_ge547_fatura_automatico lo_finaliza

string ivs_filiais, ivs_nulo

boolean ivb_Check
Boolean ivb_Controlado_Lote = False
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public function boolean wf_pedido_selecionado ()
public function boolean wf_verifica_picking (long al_linha, boolean ab_mostrar_mensagem)
public function boolean wf_verifica_produto_sem_aloc_flow ()
public function boolean wf_atualiza_situacao_pedido (long al_filial, long al_pedido)
public function boolean wf_valida_quantidade_pedido (long al_filial, long al_pedido)
public function boolean wf_verifica_situacao_pedido (long al_filial, long al_pedido)
public function boolean wf_atualiza_pedido_distribuidora (long al_filial, long al_pedido_distribuidora, ref string as_erro)
public function boolean wf_atualiza_pedido_almoxarifado (long al_filial, long al_pedido, ref string as_erro)
end prototypes

public subroutine wf_localiza_filial ();STRING lvs_Filial

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Filial = Tab_1.TabPage_1.dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Filial)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Filial.Localizada Then
	Tab_1.TabPage_1.dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
	Tab_1.TabPage_1.dw_1.Object.nm_filial[1] = ivo_Filial.nm_fantasia
Else

	SetNull(ivo_Filial.Cd_Filial)
	ivo_Filial.Nm_Fantasia = ""
	
	Tab_1.TabPage_1.dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	Tab_1.TabPage_1.dw_1.Object.nm_filial[1] = ivo_filial.nm_fantasia
	
End If

end subroutine

public function boolean wf_pedido_selecionado ();Integer li_Find

li_Find = Tab_1.TabPage_1.dw_2.Find("id_gera_lista = 'S'", 1, Tab_1.TabPage_1.dw_2.RowCount())

If li_Find < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe pedido selecionado para a gera$$HEX2$$e700e300$$ENDHEX$$o do picking.")
	Return False
Else
	If li_Find > 0 Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confima a gera$$HEX2$$e700e300$$ENDHEX$$o do picking dos pedidos selecionados ?", Question!, YesNo!, 2) = 2 Then
			Return False
		End If
	End If
End If

Return True
end function

public function boolean wf_verifica_picking (long al_linha, boolean ab_mostrar_mensagem);Long ll_Picking, ll_Filial, ll_Pedido, ll_Esteira

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Filial 		= Tab_1.TabPage_1.dw_2.Object.cd_filial		[al_Linha]
ll_Pedido 	= Tab_1.TabPage_1.dw_2.Object.nr_pedido	[al_Linha]
ll_Esteira	= Tab_1.TabPage_1.dw_1.Object.cd_esteira [1]

Select count(*)
Into :ll_Picking
From wms_lista_separacao
Where cd_filial 							= :ll_Filial
	and nr_pedido_distribuidora 	= :ll_Pedido
Using SqlCa;

If Sqlca.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o picking.")
	Return False
End If

//If ll_Picking > 0 Then
//	If ab_mostrar_mensagem Then
//		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ foi gerado o picking deste pedido para a esteira '" + string(ll_Esteira) + "'.")
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ foi gerado o picking deste pedido.")
//	End If
//	Return False
//End If

Return True

end function

public function boolean wf_verifica_produto_sem_aloc_flow ();Long ll_Produtos

select count(distinct w.cd_produto)
Into :ll_Produtos
from wms_localizacao w
inner join produto_geral g on g.cd_produto = w.cd_produto
inner join vw_wms_endereco v on v.cd_endereco = w.cd_endereco
where not exists (select * from wms_endereco_produto e where e.cd_produto = w.cd_produto)
  and isnull(v.id_utiliza_saldo, 'S') = 'S'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar wf_verifica_produto_sem_aloc_flow.", Exclamation!)
	Return False
Else
	If ll_Produtos > 0 Then			
		//Open(w_ws012_produto_sem_aloc_flow_resp)
		Return False	
	End If	
End If

Return True
end function

public function boolean wf_atualiza_situacao_pedido (long al_filial, long al_pedido);String ls_MSG

Boolean lb_Somente_Esteiras_Ativas 

If Not gf_wms_somente_esteiras_ativas(ref lb_Somente_Esteiras_Ativas) Then
	Return False
End If

If lb_Somente_Esteiras_Ativas  Then
	Update pedido_distribuidora
	Set id_situacao = 'S'
	Where cd_filial							=	:al_Filial
		and nr_pedido_distribuidora 	=	:al_Pedido
	Using SqlCa;
	
	If Sqlca.SqlCode = -1 Then
		ls_MSG = 	"Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + String(al_Pedido) + "'. '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
	End If
End If

Return True
end function

public function boolean wf_valida_quantidade_pedido (long al_filial, long al_pedido);String ls_MSG

Long ll_Qtde

Select count(*)
Into :ll_Qtde
From pedido_distribuidora_produto
where cd_filial =:al_Filial
	and nr_pedido_distribuidora = :al_pedido
	and qt_lista_separacao > qt_atendida
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_MSG = 	"Erro verifica$$HEX2$$e700e300$$ENDHEX$$o da quantidade pedida do pedido '" + String(al_Pedido) + "'. '" + SQLCA.SQLErrText + "'."
	SqlCa.of_RollBack()
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
	Return False
Else
	If ll_Qtde > 0 Then
		ls_MSG = 	"Existem produtos no pedido '" + String(al_Pedido) + "' com quantidade no picking maior que do pedido."
		SqlCa.of_RollBack()
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
	End If
End If

Return true
end function

public function boolean wf_verifica_situacao_pedido (long al_filial, long al_pedido);String ls_MSG

Long ll_Qtde, ll_Picking

String ls_Situacao

Select count(*)
Into :ll_Picking
From wms_lista_separacao
Where cd_filial 							= :al_filial
	and nr_pedido_distribuidora 	= :al_Pedido
Using SqlCa;

If Sqlca.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o picking.")
	Return False
End If

If ll_Picking > 0 Then
	//If ab_mostrar_mensagem Then
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ foi gerado o picking deste pedido para a esteira '" + string(ll_Esteira) + "'.")
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ foi gerado o picking deste pedido.")
	//End If
	Return False
End If

//Select id_situacao
//Into :ls_Situacao
//From pedido_distribuidora
//where cd_filial =:al_Filial
//	and nr_pedido_distribuidora = :al_pedido
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	ls_MSG = 	"Erro ao verificar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + String(al_Pedido) + "'. '" + SQLCA.SQLErrText + "'."
//	SqlCa.of_RollBack()
//	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
//	Return False
//Else
//	If ls_Situacao <> 'C' Then
//		ls_MSG = 	"J$$HEX1$$e100$$ENDHEX$$ foi gerado ."
//		SqlCa.of_RollBack()
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
//		Return False
//	End If
//End If

Return true
end function

public function boolean wf_atualiza_pedido_distribuidora (long al_filial, long al_pedido_distribuidora, ref string as_erro);Update pedido_distribuidora
Set id_situacao = 'T'
Where cd_filial = :al_filial
  and nr_pedido_distribuidora = :al_pedido_distribuidora
  and id_situacao = 'S'
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.Of_RollBack()
	as_Erro = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido distribuidora: "+SqlCa.SqlErrText
	Return False
End If

Return True
end function

public function boolean wf_atualiza_pedido_almoxarifado (long al_filial, long al_pedido, ref string as_erro);Boolean lb_Pedido_Almoxarifado_Novo

Long ll_Volume

If Not gf_Pedido_Almoxarifado_Novo(al_Filial, Ref lb_Pedido_Almoxarifado_Novo, Ref as_Erro) Then
	Return False
End If

If Not lb_Pedido_Almoxarifado_Novo Then
	Return True
End If

		
Update pedido_almoxarifado
Set id_situacao 	= 'T'
Where cd_filial 		= :al_Filial
	And nr_pedido 	in (Select nr_pedido_almoxarifado
							From pedido_distribuidora_almox
							Where cd_filial 						= :al_Filial
							And nr_pedido_distribuidora 	= :al_Pedido)
Using SqlCa;	
	
If  SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido almoxarifado': "+SqlCa.SqlErrText
	Return False
End If		

Return True
end function

on w_ge259_manutencao_pedido.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
end on

on w_ge259_manutencao_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_confirmar)
end on

event ue_preopen;call super::ue_preopen;//ivl_Altura_1  = 1668  // Heigth
//ivl_Largura_1 = 3314  // Width
//
//ivl_Altura_2  = 1668  // Heigth
//ivl_Largura_2 = 3314  // Width


end event

event ue_postopen;call super::ue_postopen;ivo_Filial = Create uo_Filial
//ivo_Pedido = Create uo_Pedido_Filial

ivb_Controlado_Lote = gf_pad_picking_lote() 



end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(lo_finaliza)
//Destroy(ivo_Pedido)
end event

event ue_printimmediate;call super::ue_printimmediate;Tab_1.TabPage_2.dw_3.Event ue_Print()
end event

event open;call super::open;String ls_Folder

String ls_Validar[]

ls_Folder	= "c:\windows\fonts"

ls_Validar = {'IDAutomationHC39M.ttf'}

If Not FileExists( ls_Folder + '\' + ls_Validar[1] ) Then				
	If Not gf_download_matriz(ls_Validar, ls_Validar, ls_Folder, 'fonts',  False) Then Return

	If RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", "IDAutomationHC39M (TrueType)", RegString!, "IDAutomationHC39M.ttf" ) = -1 Then
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instalar a fonte necess$$HEX1$$e100$$ENDHEX$$ria para impress$$HEX1$$e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo de barras.~rAvise o setor de Inform$$HEX1$$e100$$ENDHEX$$tica.', Information! )
	End If
End If	
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge259_manutencao_pedido
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge259_manutencao_pedido
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge259_manutencao_pedido
integer x = 9
integer width = 3314
integer height = 1668
long backcolor = 79741120
end type

event tab_1::selectionchanged;// OverRide

SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()

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
integer width = 3278
integer height = 1552
long picturemaskcolor = 553648127
cb_lista_separacao cb_lista_separacao
cb_gerar_picking cb_gerar_picking
cb_finalizar_separacao cb_finalizar_separacao
cb_1 cb_1
end type

on tabpage_1.create
this.cb_lista_separacao=create cb_lista_separacao
this.cb_gerar_picking=create cb_gerar_picking
this.cb_finalizar_separacao=create cb_finalizar_separacao
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_lista_separacao
this.Control[iCurrent+2]=this.cb_gerar_picking
this.Control[iCurrent+3]=this.cb_finalizar_separacao
this.Control[iCurrent+4]=this.cb_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_lista_separacao)
destroy(this.cb_gerar_picking)
destroy(this.cb_finalizar_separacao)
destroy(this.cb_1)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 14
integer y = 292
integer width = 3241
integer height = 1240
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 14
integer width = 2619
integer height = 268
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 32
integer y = 88
integer width = 2592
integer height = 188
string dataobject = "dw_ge259_selecao_manutencao_pedido"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

Choose Case dwo.Name
	Case "id_filiais"
		
		If Data = 'C' Then
		
			ivs_filiais = ivs_nulo 
			
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
			
		End If
		
End Choose

//If dwo.name = "nm_filial" Then
//		
//	If IsNull(data) or data = "" Then
//			
//		SetNull(ivo_Filial.cd_filial)			
//		ivo_filial.nm_fantasia = ""
//	
//		This.Object.cd_filial[row] = ivo_filial.cd_filial
//		This.Object.nm_filial[row] = ivo_filial.nm_fantasia
//	
//	End If
//	
//	If data <> ivo_filial.nm_fantasia Then
//		Return 1
//	End If	
//	
//End If	
//
end event

event dw_1::ue_key;call super::ue_key;STRING lvs_Coluna

lvs_Coluna = This.GetColumnName()

If	lvs_Coluna = "nm_filial" Then
		
	If key = KeyEnter! Then	ivo_Filial.of_Localiza_Filial(This.GetText())		
	
End If
end event

event dw_1::ue_addrow;call super::ue_addrow;Date lvdh_Movimento

lvdh_Movimento = Date(gf_getserverdate())

This.Object.dh_emissao_de [1] = RelativeDate(lvdh_Movimento,-2)
This.Object.dh_emissao_ate[1] = lvdh_Movimento

Return AncestorReturnValue
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
event ue_mousemove pbm_mousemove
integer x = 50
integer y = 380
integer width = 3182
integer height = 1140
string dataobject = "dw_ge259_lista_manutencao_pedido"
string ivs_cor_linha_padrao = ""
string ivs_cor_coluna_normal = ""
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long     lvl_filial,&
		   ll_rota 	

String   lvs_situacao,&
			lvs_where,&
			lvs_Filial
		 
Date   	lvdh_emissao_de,&
			lvdh_emissao_ate,&
			lvdh_faturamento_de,&
			lvdh_faturamento_ate
			
	
Tab_1.TabPage_1.dw_1.AcceptText()			
		
lvs_Filial                  = Tab_1.TabPage_1.dw_1.object.id_filiais[1]
lvs_situacao             = Tab_1.TabPage_1.dw_1.object.id_situacao[1]

lvdh_emissao_de      = Tab_1.TabPage_1.dw_1.object.dh_emissao_de [1]
lvdh_emissao_ate     = Tab_1.TabPage_1.dw_1.object.dh_emissao_ate[1]
// Adicionado Filtro para Rota
ll_rota					=  Tab_1.TabPage_1.dw_1.object.nr_rota[1]

lvs_where = ''

If lvs_Filial = 'C' Then
	If Not IsNull(ivs_Filiais) Then
		lvs_where += "f.cd_filial in (" + ivs_Filiais + ")"		
	End If
End If

//If Not IsNull(lvl_filial) and lvl_filial <> 0 Then
//	lvs_where += "f.cd_filial = " + String(lvl_filial)
//End If	


If lvs_situacao <> 'TODOS' Then
	If lvs_situacao = 'Z' Then
		If lvs_where <> '' Then lvs_where += " and "
		lvs_where += "pd.id_situacao in ('S', 'T')"
	Else
		If lvs_where <> '' Then lvs_where += " and "
		lvs_where += "pd.id_situacao = '" + lvs_situacao + "'"
	End If
End If

If Not IsNull(lvdh_emissao_de) Then
	If lvs_where <> '' Then lvs_where += " and "
	lvs_where += "pd.dh_emissao >= '" + String(lvdh_emissao_de,'yyyy/mm/dd') + "'"
End If

// Adicionado Filtro para Rota
If ll_rota > 0 Then
	If lvs_where <> '' Then lvs_where += " and " 
	lvs_where += "f.nr_rota_entrega  = " + string (ll_rota) 
End If

If Not IsNull(lvdh_emissao_ate) Then
	If lvs_where <> '' Then lvs_where += " and " 
	lvs_where += "pd.dh_emissao <= '" + String(lvdh_emissao_ate,'yyyy/mm/dd') + "'"
End If	

If lvs_where <> '' Then
	This.of_AppendWhere(lvs_where)
End If	

This.of_AppendWhere("((coalesce(id_pedido_almoxarifado, 'N') <> 'S') or (exists (	select * from parametro_loja x "+&
							"where x.cd_filial= pd.cd_filial "+&
							"and x.cd_parametro = 'DH_INICIA_PEDIDO_ALMOXARIFADO_NOVO' "+&
							"and cast(substring(vl_parametro, 7, 4) + substring(vl_parametro, 4, 2) + substring(vl_parametro, 1, 2) as date) < = (select dh_movimentacao from parametro where id_parametro = '1')) ))")
			
Return 1
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"nr_pedido","cd_filial", "nm_filial","id_situacao","dh_emissao","nr_prioridade_faturamento"}

lvs_Nome = {"Pedido","C$$HEX1$$f300$$ENDHEX$$digo Filial", "Nome Filial", "Situa$$HEX2$$e700e300$$ENDHEX$$o","Data Emiss$$HEX1$$e300$$ENDHEX$$o","Prioridade"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		 


end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;String lvs_Situacao

If currentrow > 0 Then

	lvs_Situacao = This.object.id_situacao[currentrow]

	This.ivm_Menu.ivb_Permite_Imprimir = True

	Choose Case lvs_Situacao
		Case 'C'
			This.ivo_Controle_Menu.of_Imprimir(True)
		//	cb_finalizar_separacao.Enabled = False
		Case 'S'
			This.ivo_Controle_Menu.of_Imprimir(True)
	//		cb_finalizar_separacao.Enabled = True
		Case Else	
			This.ivo_Controle_Menu.of_Imprimir(False)
	///		cb_finalizar_separacao.Enabled = False
	End Choose
	
End If	
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long ll_Filial, ll_Pedido, ll_Row, ll_Qtde

If This.RowCount() > 0 Then 

	This.Event rowfocuschanged(1)
	
	//Essa rotina $$HEX1$$e900$$ENDHEX$$ tempor$$HEX1$$e100$$ENDHEX$$ria, implanta$$HEX2$$e700e300$$ENDHEX$$o do sistema nos controlados
	For ll_Row = 1 To pl_Linhas
		If This.Object.id_situacao[ll_Row] = "S" Then
			
			ll_Filial 		= This.Object.cd_filial[ll_Row]
			ll_Pedido 	= This.Object.nr_pedido[ll_Row]
			
			Select count(nr_pedido_distribuidora)
			Into :ll_Qtde
			From wms_lista_separacao
			where cd_filial = :ll_Filial
			and nr_pedido_distribuidora = :ll_Pedido
			Using SqlCa;
			
			If Sqlca.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Erro no select da 'wms_lista_separacao'.")
				Return -1
			End If
	
			 If ll_Qtde = 0 Then
				This.Object.id_situacao[ll_Row] = "C"
			End If		
		End If
	Next
	//At$$HEX1$$e900$$ENDHEX$$ aqui
	

//	cb_reimpressao.Enabled = True
	
Else
	
//	cb_reimpressao.Enabled = False
	
End If	

Return AncestorReturnValue
	
end event

event dw_2::itemchanged;call super::itemchanged;Long ll_Filial, ll_Pedido

If dwo.name = 'id_gera_lista' Then
	If data = 'S' Then	
		
		If gvs_somente_controlado = 'S' Then
			If This.Object.id_situacao[row] <> 'C' and This.Object.id_situacao[row] <> 'S'  Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido COLODADO poder$$HEX1$$e100$$ENDHEX$$ ser selecionado.", Exclamation!)
				Return 1
			End If
		Else
			If This.Object.id_situacao[row] <> 'C' Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido COLODADO poder$$HEX1$$e100$$ENDHEX$$ ser selecionado.", Exclamation!)
				Return 1
			End If
		End If
		
		If Not wf_verifica_picking(row, true) Then Return 1
	End If
End If

Return 0
end event

event dw_2::doubleclicked;call super::doubleclicked;String lvs_Marcacao, ls_Situacao, lvs_Marcacao2

Integer lvi_Row
		  
If dwo.Name = "id_imagem_t" Then
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check 	 = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check 	 = True
	End If
	
	For lvi_Row = 1 To This.RowCount()
		
		lvs_Marcacao2 = lvs_Marcacao
		
		If lvs_Marcacao2 = "S" Then
		
			ls_Situacao = This.Object.id_situacao[lvi_Row]
			
			If gvs_somente_controlado = "S" Then
				If ls_Situacao <> 'C' and ls_Situacao <> 'S' Then lvs_Marcacao2 = "N"
			Else
				If ls_Situacao <> 'C' Then lvs_Marcacao2 = "N"
			End If
			
			If lvs_Marcacao2 = "S" Then
				If Not wf_verifica_picking(lvi_Row, False) Then lvs_Marcacao2 = "N"
			End If
		End If
		
		This.Object.id_gera_lista[lvi_Row] = lvs_Marcacao2
	Next
	
End If
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3278
integer height = 1552
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 14
integer y = 16
integer width = 3241
integer height = 1512
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 64
integer width = 3159
integer height = 1420
string dataobject = "dw_ge259_detalhe_manutencao_pedido"
boolean vscrollbar = true
string ivs_cor_linha_padrao = ""
string ivs_cor_coluna_normal = ""
end type

event dw_3::ue_recuperar;//OVERRIDE

Long lvl_Linha,&
     lvl_Filial,&
     lvl_Pedido

lvl_Linha  = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Filial = Tab_1.TabPage_1.dw_2.Object.cd_filial[lvl_Linha]
lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.nr_pedido[lvl_Linha]

Return This.Retrieve(lvl_Filial,lvl_Pedido)
end event

event dw_3::ue_print;call super::ue_print;//Long    lvl_Linha,&
//        lvl_Produto,&
//		  lvl_Pedido,&
//		  lvl_Filial,&
//		  lvl_Row
//		  
//String  lvs_Linha,&
//        lvs_Descricao,&
//		  lvs_Barras,&
//		  lvs_Filial
//
//Integer lvi_Retorno,&
//        lvi_Quantidade
//
//SetPointer(HourGlass!)
//
//This.Event ue_Retrieve()
//
//If This.RowCount() > 0 Then
//
//	ivo_impressao.of_inicializar()
//	ivo_impressao.of_colunas(80)
//	ivo_impressao.of_titulo_relatorio('LISTAGEM DE SEPARACAO DE PEDIDO')
//	ivo_impressao.of_usa_cabecalho(True)
//	
//	lvl_Row = Tab_1.TabPage_1.dw_2.GetRow()
//	
//	lvl_Filial = Tab_1.TabPage_1.dw_2.Object.cd_filial[lvl_Row]
//	lvs_Filial = Tab_1.TabPage_1.dw_2.Object.nm_filial[lvl_Row]
//	lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.nr_pedido[lvl_Row]
//	
//	ivo_impressao.of_insere_linha('FILIAL : ' + Upper(lvs_Filial) + '(' + String(lvl_Filial) + ')' + ' PEDIDO : ' + String(lvl_Pedido,'000000'))
//	ivo_impressao.of_insere_linha('')
//	ivo_impressao.of_insere_linha('CODIGO PRODUTO                                   COD.BARRAS  QTD.      ')
//	ivo_impressao.of_insere_linha(Fill('-',80))
//	ivo_impressao.of_insere_linha('')
//		
//	For lvl_Linha = 1 To This.RowCount()
//		
//		lvl_Produto    = This.Object.cd_produto      [lvl_Linha]
//		lvs_Descricao  = This.Object.de_produto      [lvl_Linha]
//		lvs_Barras     = This.Object.de_codigo_barras[lvl_Linha]
//		lvi_Quantidade = This.Object.qt_pedida       [lvl_Linha]
//		
//		lvs_Descricao  = Trim(lvs_Descricao) + Fill(' ',40 -Len(Trim(lvs_Descricao)))
//		
//		lvs_Linha = String(lvl_Produto,'000000') + '  ' + lvs_Descricao + '  ' + String(lvi_Quantidade) + ' ' + lvs_Barras
//		
//		ivo_impressao.of_insere_linha(lvs_Linha)
//		
//	Next
//	
//	ivo_impressao.of_finalizar()     // Finaliza Relat$$HEX1$$f300$$ENDHEX$$rio
//	ivo_impressao.of_imprimir()
//
//End If
//
//
//
//
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_lista_separacao from commandbutton within tabpage_1
boolean visible = false
integer x = 2295
integer y = 20
integer width = 192
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Picking - nao usar"
end type

event clicked;//Long ll_Filial, ll_Pedido, ll_Linha, ll_Linhas, ll_Esteira, ll_Row, ll_Esteiras, ll_NR_Esteira
//
//Integer li_Log
//
//String lvs_Arquivo, ls_Impr_Picking, ls_Impr_Etiquetas
//
//dc_uo_ds_base lds_Etiquetas
//dc_uo_ds_base lds_Esteira
//
//Boolean lb_Imprimiu = False, ll_Sucesso = True
//
//Try
//	
//	lds_Esteira = Create dc_uo_ds_base
//	If Not lds_Esteira.of_ChangeDataObject("ds_wms05_esteira") Then		
//		Return 1
//	End If
//	
//	ll_Esteiras = lds_Esteira.Retrieve()
//	
//	If ll_Esteiras <= 0 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as esteiras (Linhas).")
//		Return -1
//	End If
//	
//	Tab_1.TabPage_1.dw_2.AcceptText()
//	
//	ll_Linhas = Tab_1.TabPage_1.dw_2.RowCount()
//	
//	//wf_Verifica_produto_Sem_Aloc_Flow()
//	
//	If Not wf_Pedido_Selecionado() Then Return
//	
//	uo_ge259_pedido_filial lds
//	lds = Create uo_ge259_pedido_filial
//	
//	lvs_Arquivo = gvo_Aplicacao.ivs_Path_Arquivos + "Picking"
//	
//	If Not gf_Cria_Logs(lvs_Arquivo, 1, ref li_Log) Then
//		Return 
//	End If
//	
//	lds.ii_Log = li_Log
//				
//	For ll_Linha = 1 To ll_linhas
//		If Tab_1.TabPage_1.dw_2.Object.id_gera_lista[ll_Linha] = 'S' Then
//			
//			ll_Sucesso = True
//			
//			ll_Filial    = Tab_1.TabPage_1.dw_2.Object.cd_filial 	 [ll_Linha]
//			ll_Pedido = Tab_1.TabPage_1.dw_2.Object.nr_pedido [ll_Linha]
//			
//			If Not wf_verifica_situacao_pedido(ll_Filial, ll_Pedido) Then Exit
//			
//			If wf_Atualiza_Situacao_Pedido(ll_Filial, ll_Pedido)	Then
//				For ll_Esteira = 1 To ll_Esteiras
//					
//					ll_NR_Esteira = lds_Esteira.Object.cd_esteira[ll_Esteira]
//					
////					If Not lds.of_gera_lista_separacao_Nova(ll_Filial, ll_Pedido, ll_NR_Esteira) Then
////						ll_Sucesso = False
////						Exit
////					End If
//				Next
//			Else
//				ll_Sucesso = False
//			End If
//			
//			If ll_Sucesso Then
//				If wf_Valida_Quantidade_Pedido(ll_Filial, ll_Pedido)	Then
//					SqlCa.of_Commit();
//				End If
//			Else
//				SqlCa.of_RollBack()
//			End If
//			
//		End If						
//	Next
//
//	FileClose(li_Log)
//
//Finally	
//	Destroy(lds)	
//	Destroy(lds_Etiquetas)
//	Destroy(lds_Esteira)
//End Try
//
//Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

type cb_gerar_picking from commandbutton within tabpage_1
integer x = 2661
integer y = 176
integer width = 581
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Gerar Picking"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o do Picking ?", Question!, YesNo!, 2) = 2 Then Return

uo_ge259_pedido_filial lds
lds = Create uo_ge259_pedido_filial

lds.of_processa_geracao_picking()

Destroy(lds)

Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

type cb_finalizar_separacao from commandbutton within tabpage_1
integer x = 2656
integer y = 48
integer width = 581
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Finaliza Separa$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;Long	lvl_Pedido,&
       	lvl_Filial,&
		ll_Listas

String lvs_Filial,&
		ls_Erro,&
		ls_Anexo[]

Boolean lb_Sucesso

Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este processo esta sendo feito de FORMA AUTOM$$HEX1$$c100$$ENDHEX$$TICA!. Bot$$HEX1$$e300$$ENDHEX$$o Desativado", Information!)
Return




lo_finaliza = create uo_ge547_fatura_automatico
	


lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.nr_pedido[dw_2.GetRow()]
lvl_Filial = Tab_1.TabPage_1.dw_2.Object.cd_filial[dw_2.GetRow()]
lvs_Filial = Tab_1.TabPage_1.dw_2.Object.nm_filial[dw_2.GetRow()] + " (" + String(lvl_Filial) + ")"

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Finalizar separa$$HEX2$$e700e300$$ENDHEX$$o do pedido : " + String(lvl_Pedido) + " da filial : " + lvs_Filial + " ?", Question!, YesNo!, 2 ) = 2 Then Return

SetPointer(HourGlass!)

// Verifica Se Picking Controlado N$$HEX1$$e300$$ENDHEX$$o Gerado.
If ivb_Controlado_Lote Then 
	If Not lo_finaliza.of_verifica_controlado_em_separacao(lvl_Filial,lvl_Pedido, ref ls_Erro) Then 
		gf_ge202_envia_email_automatico(276,"Picking de Controlado N$$HEX1$$e300$$ENDHEX$$o Gerado", ls_Erro, ls_Anexo )
	End If 
End If 


If Not lo_finaliza.of_verifica_situacao_pedido(lvl_Filial,lvl_Pedido, Ref ls_Erro ) Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Situa$$HEX2$$e700e300$$ENDHEX$$o do Pedido J$$HEX1$$e100$$ENDHEX$$ esta como Terminada", Information!)
	Return
End If 

Select count(*) 
Into :ll_Listas
From wms_lista_separacao
Where cd_filial 							= :lvl_Filial
	and nr_pedido_distribuidora 	= :lvl_Pedido
	and (dh_termino_conferencia 	is null or (dh_termino_conferencia is not null and id_atualizacao_mov_estoque = 'N'))
	and dh_cancelamento is null
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.Of_MsgDbError("Erro ao localizar se exite lista se separa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o conferida.")
	Return
End If

If ll_Listas > 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem volumes que ainda n$$HEX1$$e300$$ENDHEX$$o foram conferidos.~r~r" +&
										"MEDICAMENTOS / CONTROLADOS / PERFUMARIA", Information!)
	Return
End If

//Update pedido_distribuidora
//Set id_situacao = 'T'
//Where cd_filial = :lvl_Filial
//  and nr_pedido_distribuidora = :lvl_Pedido
//  and id_situacao = 'S'
//Using Sqlca;
//
//If Sqlca.Sqlcode = -1 Then
//	Sqlca.Of_RollBack()
//	Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
//	Return
//Else
//	Sqlca.of_Commit()
//	Tab_1.TabPage_1.dw_2.Event ue_Retrieve()	
//End If

If wf_Atualiza_Pedido_Distribuidora(lvl_Filial, lvl_Pedido, Ref ls_Erro) Then
	If wf_Atualiza_Pedido_Almoxarifado(lvl_Filial, lvl_Pedido, Ref ls_Erro) Then
		lb_Sucesso = True
	End If	
End if

If lb_Sucesso Then
	Sqlca.of_Commit()
	Tab_1.TabPage_1.dw_2.Event ue_Retrieve()	
Else
	Sqlca.Of_RollBack()
	MessageBox("Erro", ls_Erro)
End If









end event

type cb_1 from commandbutton within tabpage_1
boolean visible = false
integer x = 2039
integer y = 1000
integer width = 416
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Finaliza Teste"
end type

event clicked;uo_ge547_fatura_automatico lo_fat
				Try
				     lo_fat = create uo_ge547_fatura_automatico
					lo_fat.of_finaliza_separacao( )
				 
				Finally
				 	Destroy (uo_ge547_fatura_automatico)
				End Try		
end event

type st_confirmar from statictext within w_ge259_manutencao_pedido
boolean visible = false
integer x = 2149
integer y = 460
integer width = 855
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
boolean focusrectangle = false
end type

