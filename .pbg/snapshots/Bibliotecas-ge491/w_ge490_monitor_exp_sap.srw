HA$PBExportHeader$w_ge490_monitor_exp_sap.srw
forward
global type w_ge490_monitor_exp_sap from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_cancelamento from commandbutton within tabpage_1
end type
type cb_executar from commandbutton within tabpage_1
end type
end forward

global type w_ge490_monitor_exp_sap from dc_w_2tab_consulta_selecao_lista_det
integer width = 3890
integer height = 2376
string title = "GE490 - Monitor Exporta$$HEX2$$e700e300$$ENDHEX$$o SAP [Subida]"
end type
global w_ge490_monitor_exp_sap w_ge490_monitor_exp_sap

type variables
boolean ivb_Check
end variables

forward prototypes
public function boolean wf_processa ()
end prototypes

public function boolean wf_processa ();String ls_Log, ls_Chave, ls_status

Long ll_Linhas, ll_Linha, ll_nr_atualizacao, ll_Tabela
int  li_ret
boolean ll_retorno = true
datastore lds_dados
uo_ge490_exportacao_sap luo_exportacao

luo_exportacao = create uo_ge490_exportacao_sap

lds_dados = create datastore
lds_dados.dataobject = tab_1.TabPage_1.dw_2.dataobject

if tab_1.TabPage_1.dw_2.rowscopy(1,tab_1.TabPage_1.dw_2.rowcount(), primary!, lds_dados, 1, primary!) < 0 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao copiar dados (Rowscopy) da datawindow "dw_ge490_lista".')
	return false
end if

lds_dados.setsort('nr_atualizacao A')
lds_dados.sort()

try

	ll_Linhas = lds_dados.RowCount()
	
	If ll_Linhas > 0 Then 
		
		Open(w_Aguarde_2)
		
		w_aguarde_2.uo_progress.of_setmax(ll_Linhas)		
					
		For ll_Linha =1 To ll_Linhas
			
			If lds_dados.Object.id_processa[ll_Linha] = 'S' and (lds_dados.Object.id_status_integracao[ll_Linha]  = 'C' or lds_dados.Object.id_status_integracao[ll_Linha]  = 'E' or lds_dados.Object.id_status_integracao[ll_Linha]  = 'I') Then
				
				ll_nr_atualizacao =lds_dados.Object.nr_atualizacao[ll_Linha]
				ll_Tabela = lds_dados.Object.cd_tabela[ll_Linha]
				ls_status = lds_dados.Object.id_status_integracao[ll_Linha]
				
				//Se for a interface de Pedido Distribuidora e o pedido estiver como Integrado: Chama a interface de Retorno.
				if ll_tabela = 45 and ls_status = 'I' Then
					ll_tabela = 65
				end if
				
				if luo_exportacao.uf_exportar( ll_tabela , ll_nr_atualizacao, ref ls_Log ) = false Then
					ll_retorno = false
				end if
		 
			End If
			//w_aguarde.uo_progress.of_setprogress(ll_linha)
//			w_aguarde_2.uo_progress.of_setprogress(ll_linha)	
			
			w_aguarde_2.uo_progress.of_setprogress(ll_linha)
		
		Next
			
	End If
	
finally
	If Isvalid(w_Aguarde_2) Then Close(w_Aguarde_2)
	
	if ll_retorno = False Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_Log)
	end if
	
end try

Return True
end function

on w_ge490_monitor_exp_sap.create
int iCurrent
call super::create
end on

on w_ge490_monitor_exp_sap.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DataWindowChild lvdwc

String ls_SQL

Long ll_Tabela_Defaut

Tab_1.TabPage_1.dw_1.AcceptText()

Tab_1.TabPage_1.dw_1.Object.dh_inicio[1] = relativedate(date(gf_GetServerDate()),- 5)
Tab_1.TabPage_1.dw_1.Object.dh_fim[1] = date(gf_GetServerDate())

//If  gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "EX" Then
//	
//	Choose Case gvo_Aplicacao.ivo_Seguranca.Cd_Sistema 
//		Case "GC"; ll_Tabela_Defaut = 1 	// Produto
//		Case "CO"; ll_Tabela_Defaut = 41 // Comiss$$HEX1$$e300$$ENDHEX$$o
//		Case "GP"; ll_Tabela_Defaut = 24 // Pre$$HEX1$$e700$$ENDHEX$$o 
//	End Choose
//		
//	If Tab_1.TabPage_1.dw_1.GetChild("cd_tabela", lvdwc) = 1 Then
//		
//		lvdwc.SetTransObject(SQLCA)
//					 
//		ls_SQL	=	"SELECT	tabela_interface_sap.cd_tabela,  " +& 
//						"tabela_interface_sap.de_tabela nm_tabela  " +& 
//						"FROM tabela_interface_sap  " +& 
//						"WHERE id_integra_legado = 'S'  " +& 
//						"AND coalesce(id_tabela_pai, 'N') = 'S'  " +& 
//					     "and id_subida_descida = 'D' " +&
//  					    "and id_situacao = 'A' " +&
//						"and cd_sistema in ('"+ gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + "')"
//		
//		lvdwc.SetSQLSelect(ls_SQL)
//			
//		lvdwc.Retrieve()
//		
//		Tab_1.TabPage_1.dw_1.Object.cd_tabela[1] = ll_Tabela_Defaut
//
//	Else
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild tabelas.")
//	End If
//End If
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge490_monitor_exp_sap
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge490_monitor_exp_sap
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge490_monitor_exp_sap
integer width = 3817
integer height = 2172
end type

event tab_1::selectionchanged;//
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3781
integer height = 2056
cb_cancelamento cb_cancelamento
cb_executar cb_executar
end type

on tabpage_1.create
this.cb_cancelamento=create cb_cancelamento
this.cb_executar=create cb_executar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelamento
this.Control[iCurrent+2]=this.cb_executar
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_cancelamento)
destroy(this.cb_executar)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer width = 3726
integer height = 1640
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer y = 24
integer width = 3054
integer height = 328
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer y = 92
integer width = 2994
string dataobject = "dw_ge490_selecao"
end type

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer width = 3675
integer height = 1540
string dataobject = "dw_ge490_lista"
end type

event dw_2::ue_recuperar;//OverRide
Long	ll_Tabela,&
		ll_Index_SubQuery,&
		ll_Controle		

String	ls_Situacao

DateTime	ldh_Inicio,&
				ldh_Fim

This.of_RestoreOriginalSQL()

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.dh_inicio				[1]
ldh_Fim			= dw_1.Object.dh_fim				[1]
ll_Tabela			= dw_1.Object.cd_tabela			[1]
ls_Situacao		= dw_1.Object.id_situacao			[1]
ll_Controle		= dw_1.Object.nr_controle			[1]

ll_Index_SubQuery	= 1

If IsNull(ll_Tabela)	Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a tabela.")
	dw_1.SetColumn("cd_tabela")
	Return 1
End If

If Not IsNull(ldh_Inicio) and Not IsNull(ldh_Fim) Then
	If ldh_Inicio > ldh_Fim Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data final.")
		dw_1.SetColumn("dh_inicio")
		Return 1
	End If
End If

If Not IsNull(ldh_Inicio) Then
	This.of_AppendWhere_SubQuery("ls.dh_exportacao >= '"+String(ldh_Inicio, "yyyymmdd")+"'", ll_Index_SubQuery)
	
	This.of_AppendWhere_SubQuery("pd.dh_emissao >= '"+String(ldh_Inicio, "yyyymmdd")+"'", 2)
End If

If Not IsNull(ldh_Fim) Then
	This.of_AppendWhere_SubQuery("ls.dh_exportacao <= '"+String(ldh_Fim, "yyyymmdd 23:59:59")+"'", ll_Index_SubQuery)
	
	This.of_AppendWhere_SubQuery("pd.dh_emissao <= '"+String(ldh_Fim, "yyyymmdd 23:59:59")+"'", 2)
End If


If Not IsNull(ll_Tabela) and (ll_Tabela <> 0) Then
	This.of_AppendWhere_SubQuery("tis.cd_tabela = "+String(ll_Tabela), ll_Index_SubQuery)
	
	This.of_AppendWhere_SubQuery("ti.cd_tabela = "+String(ll_Tabela), 2)
End If

If Not Isnull(ll_Controle) and ll_Controle > 0 Then
	This.of_AppendWhere_SubQuery("ls.nr_atualizacao = "+String(ll_Controle), ll_Index_SubQuery)
	
	This.of_AppendWhere_SubQuery("pd.nr_pedido_distribuidora = "+String(ll_Controle), 2)
End If

If ls_Situacao <> "T" Then
	If ls_Situacao = 'CE' Then //COLOCADO ou ERRO
		This.of_AppendWhere_SubQuery("ls.id_status_integracao in ('C', 'E')", ll_Index_SubQuery)
		
		This.of_AppendWhere_SubQuery("pd.id_exportacao_sap in ('C', 'E')", 2)
	Else
		This.of_AppendWhere_SubQuery("ls.id_status_integracao = '"+ls_Situacao+"'", ll_Index_SubQuery)
		
		This.of_AppendWhere_SubQuery("pd.id_exportacao_sap = '"+ls_Situacao+"'", 2)
	End If
End If

string ls_teste	
	
ls_teste = this.getsqlselect( )	
	
Return This.Retrieve()
end event

event dw_2::doubleclicked;call super::doubleclicked;String	lvs_Marcacao

Long	ll_Row

If dwo.Name = 'id_imagem' Then
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For ll_Row = 1 To This.RowCount()
				
		If lvs_Marcacao = 'S' Then
			If This.Object.id_status_integracao[ll_Row] = 'C' or This.Object.id_status_integracao[ll_Row] = 'E'  Then
				This.Object.id_processa[ll_Row] = lvs_Marcacao
			End If
		Else
			This.Object.id_processa[ll_Row] = lvs_Marcacao
		End If
	
	Next
	
End If		
end event

event dw_2::constructor;call super::constructor;// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 then
	cb_cancelamento.Enabled = True
Else
	cb_cancelamento.Enabled = False
End If

Return pl_Linhas
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3781
integer height = 2056
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3753
integer height = 2040
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3666
integer height = 1892
string dataobject = "dw_ge490_detalhes"
boolean vscrollbar = true
end type

event dw_3::ue_preretrieve;call super::ue_preretrieve;long ll_linha, ll_cd_tabela, ll_nr_pedido, ll_cd_filial

ll_linha = tab_1.tabpage_1.dw_2.getrow()
			
ll_cd_tabela = tab_1.tabpage_1.dw_2.object.cd_tabela[ll_linha]

if ll_cd_tabela = 45 Then
	
	ll_cd_filial = tab_1.tabpage_1.dw_2.object.cd_filial[ll_linha]
	ll_nr_pedido = tab_1.tabpage_1.dw_2.object.nr_atualizacao[ll_linha]
	
	this.of_appendwhere( 'cd_filial = ' + string(ll_cd_filial))
	this.of_appendwhere( 'nr_pedido_distribuidora = ' + string(ll_nr_pedido))
				
end if

return 1
end event

type cb_cancelamento from commandbutton within tabpage_1
integer x = 3168
integer y = 112
integer width = 512
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
string text = "Cancelar"
end type

event clicked;Long ll_Tabela
Long ll_Linha
Long ll_Linhas
Long ll_Controle
long ll_nr_atualizacao

String ls_Situacao
String ls_MSG
String ls_Motivo

tab_1.TabPage_1.dw_2.AcceptText()

ll_Linhas = tab_1.TabPage_1.dw_2.RowCount()

If ll_Linhas = 0 Then Return

ll_Tabela		= tab_1.TabPage_1.dw_1.Object.cd_tabela		[1]
ls_Situacao 	= tab_1.TabPage_1.dw_1.Object.id_situacao	[1]

If ll_Tabela = 0 or IsNull(ll_Tabela) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma tabela.", Exclamation!)
	Return
End If

If ls_Situacao = 'X' or ls_Situacao = 'T' or ls_Situacao = 'P' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a situa$$HEX2$$e700e300$$ENDHEX$$o COLOCADO ou com ERRO.", Exclamation!)
	Return
End If

If tab_1.TabPage_1.dw_2.find('id_processa = "S"',1,  tab_1.TabPage_1.dw_2.rowcount( ) ) = 0 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum registro foi selecionado.')
	Return
End If

If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma o CANCELAMENTO do processamento dos itens selecionados ?', Question!, YesNo!, 2) = 2 Then Return 

try
		
	OpenWithParm(w_ge473_motivo_cancelamento,"")
	ls_Motivo = Message.StringParm
		
	If IsNull(ls_Motivo) Then Return	
	
	ls_Motivo = ' Motivo Canc.: ' + gvo_Aplicacao.ivo_Seguranca.Nr_Matricula + ' (usu$$HEX1$$e100$$ENDHEX$$rio)  - ' + ls_Motivo
	
	Open(w_Aguarde)
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	w_Aguarde.Title = "Cancelando os itens selecionados..."
	
	For ll_Linha = 1 To ll_Linhas
		
		If tab_1.TabPage_1.dw_2.Object.id_processa[ll_Linha] = 'S' Then
			
			ll_nr_atualizacao	= tab_1.TabPage_1.dw_2.Object.nr_atualizacao[ll_Linha]
			ll_tabela = tab_1.TabPage_1.dw_2.Object.cd_tabela[ll_Linha]
			
			if ll_tabela = 45 Then
	
				Update pedido_distribuidora
				set id_exportacao_sap = 'X', dh_exportacao_sap = null
				where nr_pedido_distribuidora = :ll_nr_atualizacao;
			
				If SqlCa.Sqlcode = -1 Then
					ls_MSG = "Erro ao cancelar o processamento do Pedido [" + String(ll_nr_atualizacao) + "]. Erro: "+ SqlCa.SqlErrText
					SqlCa.of_Rollback( )
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG)
					Return 			
				End If
			
			else
				
				Update log_exportacao_sap
				Set id_status_integracao = 'D', dh_exportacao = getdate(), de_erro = (Case when de_erro is null Then :ls_Motivo else de_erro + :ls_Motivo END)
				Where nr_atualizacao = :ll_nr_atualizacao
					and id_status_integracao <> 'P'
				Using SqlCa;
				
				If SqlCa.Sqlcode = -1 Then
					ls_MSG = "Erro ao cancelar o processamento do registro [" + String(ll_nr_atualizacao) + "]. Erro: "+ SqlCa.SqlErrText
					SqlCa.of_Rollback( )
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG)
					Return 			
				End If
			
			End if	
			
			SqlCa.of_Commit();
			
		End If
	
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
	
	tab_1.TabPage_1.dw_2.Event ue_Retrieve()

finally
	Close(w_Aguarde)
end try







end event

type cb_executar from commandbutton within tabpage_1
integer x = 3168
integer y = 224
integer width = 512
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Executar"
end type

event clicked;//id_processa

Long ll_Itens_Selec

ll_Itens_Selec = tab_1.TabPage_1.dw_2.find('id_processa = "S" ', 1, tab_1.TabPage_1.dw_2.rowcount() )

If ll_Itens_Selec = 0 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum registro foi selecionado.')
	Return
End If

If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Cofirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o dos itens selecionados ?', Question!, YesNo!, 2) = 2 Then Return 

Open(w_Aguarde)

w_Aguarde.title = 'Atualizando o Sybase...'

wf_processa()

Close(w_Aguarde)

tab_1.TabPage_1.dw_2.Event ue_Recuperar()


end event

