HA$PBExportHeader$w_ge243_consulta_compra_pendente.srw
forward
global type w_ge243_consulta_compra_pendente from dc_w_selecao_lista_relatorio
end type
type cb_1 from commandbutton within w_ge243_consulta_compra_pendente
end type
end forward

global type w_ge243_consulta_compra_pendente from dc_w_selecao_lista_relatorio
string tag = "w_ge243_consulta_compra_pendente"
integer width = 3653
integer height = 2008
string title = "GE243 - Consulta Notas Fiscais de Compra Pendentes de Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Estoque"
cb_1 cb_1
end type
global w_ge243_consulta_compra_pendente w_ge243_consulta_compra_pendente

type variables
uo_filial ivo_filial

uo_fornecedor ivo_fornecedor

dc_uo_odbc ivo_odbc

dc_uo_transacao ivo_db_filial
end variables

forward prototypes
public function boolean wf_conecta_filial (long al_filial)
public function boolean wf_verifica_atualizacao_estoque (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_linha)
end prototypes

public function boolean wf_conecta_filial (long al_filial);String lvs_Odbc_Destino
		 
// Se estiver conectado desconecta
If ivo_DB_Filial.of_isConnected() Then ivo_DB_Filial.of_Disconnect()

lvs_Odbc_Destino = ivo_Odbc.of_Localiza(al_Filial)

ivo_DB_Filial.ivs_DataBase = "ANYWHERE"

If Not ivo_DB_Filial.of_Connect(lvs_Odbc_Destino, "RO") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao conectar ao banco de dados da Filial '" + String(al_Filial) + "'.")
	Return False
End If

Return True
end function

public function boolean wf_verifica_atualizacao_estoque (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_linha);boolean lb_Sucesso = True

Long ll_Retorno

DateTime lvdh_Data_Atualizacao

Select dh_atualizacao_estoque
Into	:lvdh_Data_Atualizacao
From nf_compra
Where 	cd_filial			= :al_Filial
	and 	cd_fornecedor 	= :as_Fornecedor
	and 	nr_nf				= :al_Nota
	and 	de_especie 		= :as_especie
	and 	de_serie			= :as_serie
	and	dh_atualizacao_estoque is not null
	Using ivo_db_filial;
	
Choose Case ivo_db_filial.SqlCode
	Case 0
		dw_2.Object.id_estoque_atualizado_loja	[al_Linha] = 'S'		
		dw_2.Object.dh_atualizacao_estoque		[al_Linha] = lvdh_Data_Atualizacao
		
	Case 100
		dw_2.Object.id_estoque_atualizado_loja[al_Linha] = 'N'	
		
	Case -1
		ivo_db_filial.of_MsgDbError("Filial: " + String(al_Filial) + " - Localiza$$HEX2$$e700e300$$ENDHEX$$o da nota fiscal de compra " + String(al_Nota) + ".")
		lb_Sucesso = False
End Choose
	
Return lb_Sucesso
end function

on w_ge243_consulta_compra_pendente.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge243_consulta_compra_pendente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;ivo_Filial 			= Create uo_Filial
ivo_Fornecedor 	= Create uo_Fornecedor
ivo_odbc = Create dc_uo_odbc 
ivo_db_filial = Create dc_uo_transacao 

dw_1.Object.dt_termino	[1] = Date( gf_getserverdate() )
dw_1.Object.dt_inicio		[1] = Relativedate( Date(gf_getserverdate()), -30 )

ivm_Menu.mf_SalvarComo(True)

end event

event close;call super::close;Destroy ivo_Filial
Destroy ivo_Fornecedor
Destroy ivo_odbc
Destroy ivo_db_filial
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge243_consulta_compra_pendente
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge243_consulta_compra_pendente
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge243_consulta_compra_pendente
integer y = 368
integer width = 3566
integer height = 1316
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge243_consulta_compra_pendente
integer width = 2848
integer height = 340
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge243_consulta_compra_pendente
integer x = 59
integer y = 80
integer width = 2793
integer height = 240
string dataobject = "dw_ge243_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;ivm_Menu.mf_SalvarComo(True)

Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;ivm_Menu.mf_SalvarComo(True)

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
			End If

		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
	
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial 
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If	
	
	End Choose
End If




	
end event

event dw_1::editchanged;call super::editchanged;ivm_Menu.mf_SalvarComo(True)


end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge243_consulta_compra_pendente
integer x = 55
integer y = 428
integer width = 3497
integer height = 1244
string dataobject = "dw_ge243_lista"
end type

event dw_2::ue_recuperar;// Override

String ls_Fornecedor
String ls_Tipo
String ls_Conferente

Long ll_NF
Long ll_Filial
Long ll_Pedido

Date ldt_Inicio
Date ldt_Termino
Date ldt_Vencimento
		
dw_1.AcceptText()

ldt_Inicio    			= dw_1.Object.Dt_Inicio     			[1]
ldt_Termino   			= dw_1.Object.Dt_Termino    		[1]
ll_Filial     				= dw_1.Object.Cd_Filial     			[1]
ls_Fornecedor	 		= dw_1.Object.Cd_Fornecedor 		[1]
ll_NF         				= dw_1.Object.Nr_NF         			[1]
ldt_Vencimento		= dw_1.Object.Dt_vencimento 		[1]

If IsNull(ldt_Inicio) or Not IsDate(String(ldt_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(ldt_Termino) or Not IsDate(String(ldt_Termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If ldt_Inicio > ldt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1	
End If

If Not IsNull(ls_Fornecedor) and ls_Fornecedor <> "" Then
	This.of_AppendWhere("n.cd_fornecedor = '" + ls_Fornecedor + "'")
End If

If Not IsNull(ll_Filial) and ll_Filial > 0 Then
	This.of_AppendWhere("n.cd_filial = " + String(ll_Filial) )
End If

If Not IsNull(ll_NF) and ll_NF > 0 Then
	This.of_AppendWhere("n.nr_nf = " + String(ll_NF) )
End If

If Not IsNull( ldt_Vencimento ) Then
	This.of_AppendWhere( "t.dh_vencimento <= '" + String( ldt_Vencimento, 'yyyy/mm/dd') + "'" )	
End If

Return This.Retrieve(ldt_Inicio, ldt_Termino)
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_SalvarComo(True)

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge243_consulta_compra_pendente
integer x = 3131
integer y = 64
integer width = 256
integer height = 164
end type

type cb_1 from commandbutton within w_ge243_consulta_compra_pendente
integer x = 2331
integer y = 1708
integer width = 1198
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Verifica Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Estoque na Filial"
end type

event clicked;Long lvl_Filial, lvl_Nota, lvl_Linha, lvl_Linhas, lvl_Filial_Anterior

String lvs_Fornecedor, lvs_Especie, lvs_Serie

dw_2.AcceptText()

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a verifica$$HEX2$$e700e300$$ENDHEX$$o de atualiza$$HEX2$$e700e300$$ENDHEX$$o de estoque nas lojas ?", Question!, YesNo!, 2) = 2 Then
	Return
End If

lvl_Linhas = dw_2.RowCount()

If lvl_Linhas > 0 Then
	
	Open(w_Aguarde)
	
	w_Aguarde.uo_progress.of_SetMax(lvl_Linhas)
	
	For lvl_Linha = 1 To lvl_Linhas
	
		lvl_Filial		= dw_2.Object.cd_filial[lvl_Linha]
		lvl_Nota		= dw_2.Object.nr_nf[lvl_Linha]
		lvs_Fornecedor	= dw_2.Object.cd_fornecedor[lvl_Linha]
		lvs_Especie	= dw_2.Object.de_especie[lvl_Linha]
		lvs_Serie		= dw_2.Object.de_serie[lvl_Linha]
		
		w_Aguarde.Title = "Verificando as notas da filial '" + string(lvl_Filial) + "'..."
		
		If lvl_Filial_Anterior <> lvl_Filial Then
			If Not wf_Conecta_Filial(lvl_Filial) Then
				Continue
			End If 
			lvl_Filial_Anterior = lvl_Filial
		End If
		
		wf_Verifica_Atualizacao_Estoque(lvl_Filial, lvs_Fornecedor, lvl_Nota, lvs_Especie, lvs_Serie, lvl_Linha)

		w_Aguarde.uo_progress.of_SetProgress(lvl_Linha)
			
		If lvl_Linha = lvl_Linhas Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Verifica$$HEX2$$e700e300$$ENDHEX$$o conclu$$HEX1$$ed00$$ENDHEX$$da com sucesso!")
		End If
			
	Next
	
	Close(w_Aguarde)

End If
end event

