HA$PBExportHeader$w_ge454_cadastro_forn_dist_conexao.srw
forward
global type w_ge454_cadastro_forn_dist_conexao from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge454_cadastro_forn_dist_conexao from dc_w_cadastro_selecao_lista
integer width = 3662
integer height = 1924
string title = "GE454 - Cadastro de Distribuidora por Laborat$$HEX1$$f300$$ENDHEX$$rio"
end type
global w_ge454_cadastro_forn_dist_conexao w_ge454_cadastro_forn_dist_conexao

type variables
Boolean ivb_Check

date idt_datahoje
end variables

forward prototypes
public function boolean wf_verifica_projeto_conexao (string as_laboratorio, ref string as_projeto)
public function boolean wf_marca_check ()
public function boolean wf_verifica_van ()
end prototypes

public function boolean wf_verifica_projeto_conexao (string as_laboratorio, ref string as_projeto);Select id_projeto_conexao
	Into :as_Projeto
From fornecedor
Where cd_fornecedor = :as_Laboratorio
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Erro", "Erro ao verificar o projeto conex$$HEX1$$e300$$ENDHEX$$o do laborat$$HEX1$$f300$$ENDHEX$$rio.")
	Return False
End If
end function

public function boolean wf_marca_check ();Long ll_Linha

dw_2.AcceptText()


For ll_Linha = 1 To dw_2.RowCount()
	dw_2.Object.Id_Atual[ll_Linha] = dw_2.Object.Id_Anterior[ll_Linha]
Next

dw_2.ResetUpdate ()

Return True

end function

public function boolean wf_verifica_van ();String ls_Lab
String ls_Van

dw_1.AcceptText()

//Captura a van que transmite o pedido do fornecedor
ls_Lab = dw_1.Object.Cd_Laboratorio[1]

Select c.de_projeto_conexao
	Into :ls_Van
From fornecedor f
	Inner Join conexao c
		On c.id_projeto_conexao = f.id_projeto_conexao
Where f.cd_fornecedor = :ls_Lab
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Erro", "Erro ao verificar a Van do fornecedor '" + ls_Lab + "'.", StopSign!)
	Return False
End If

dw_1.Object.De_Conexao[1] = ls_Van
end function

on w_ge454_cadastro_forn_dist_conexao.create
call super::create
end on

on w_ge454_cadastro_forn_dist_conexao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;idt_datahoje =  Date(gf_getserverdate() )
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

dw_1.AcceptText()

DataWindowChild lvdwc

Integer lvi_Retorno
Integer lvi_Row

//Remove o 0000-00000 TODAS
If dw_1.GetChild("cd_laboratorio", lvdwc) = 1 Then
	lvdwc.DeleteRow(1)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end event

event ue_cancel;call super::ue_cancel;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Cancelar(False)
ivm_Menu.mf_Confirmar(False)

ivb_Valida_Salva = False

dw_1.Enabled = True
end event

event ue_save;call super::ue_save;Long ll_Linha

Long ll_cd_motivo_bloqueio

Long ll_cd_motivo_bloqueio_antes, ll_cd_motivo_bloqueio_atual

Datetime ldh_inicio_bloqueio
Datetime ldh_termino_bloqueio

Datetime ldh_data_inicio_antes, ldh_data_inicio_atual 
Datetime ldh_data_termino_antes, ldh_data_termino_atual

String ls_Anterior
String ls_Laboratorio
String ls_Distribuidora
String ls_Atual
String ls_Erro, ls_Mensagem

Boolean lb_Sucesso = False

dw_1.AcceptText()
dw_2.AcceptText()

ls_Laboratorio = dw_1.Object.Cd_Laboratorio[1]

If dw_2.RowCount() > 0 Then
	For ll_Linha = 1 To dw_2.RowCount()
		
		If dw_2.GetItemStatus (ll_Linha, 0, Primary!) = DataModified! Then
			
			ls_Anterior 		 			= dw_2.Object.Id_Anterior				[ll_Linha]
			ls_Atual			 	 		= dw_2.Object.Id_Atual					[ll_Linha]
			ls_Distribuidora 	 		= dw_2.Object.Cd_Distribuidora		[ll_Linha]
			ldh_inicio_bloqueio 		= dw_2.Object.dh_inicio_bloqueio		[ll_Linha]
			ldh_termino_bloqueio 	= dw_2.Object.dh_termino_bloqueio	[ll_Linha]
			ll_cd_motivo_bloqueio 	= dw_2.Object.cd_motivo_bloqueio	[ll_Linha]
		
		
			
			//Se o produto veio MARCADO e foi desmarcado
			If ls_Anterior = 'S' And ls_Atual = 'N' Then
				
				Delete From distribuidora_forn_conexao
				Where cd_distribuidora = :ls_Distribuidora
					And cd_fornecedor = :ls_Laboratorio
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					lb_Sucesso = False
					ls_Erro = SqlCa.SqlErrText
					SqlCa.of_Rollback();
					MessageBox("Erro", "Erro ao excluir a distribuidora '" + ls_Distribuidora + "'. " + ls_Erro, StopSign!)
					Return -1
				End If
				
				lb_Sucesso = True
				
				If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',& 
																		String(ls_Laboratorio)+";"+String(ls_Distribuidora),& 
																		'ID_ATUAL', 'S', ls_Atual, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "E", Ref ls_Mensagem, True) Then Return -1
				If Not Isnull(ldh_inicio_bloqueio) then
					If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',& 
																		String(ls_Laboratorio)+";"+String(ls_Distribuidora),& 
																		'DH_INICIO_BLOQUEIO', string(ldh_inicio_bloqueio) , '', gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "E", Ref ls_Mensagem, True) Then Return -1
				End If
				
				If Not Isnull(ldh_termino_bloqueio) then
					If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',& 
																		String(ls_Laboratorio)+";"+String(ls_Distribuidora),& 
																		'DH_TERMINO_BLOQUEIO',  string(ldh_termino_bloqueio), '', gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "E", Ref ls_Mensagem, True) Then Return -1
				End If
				
				If Not Isnull(ll_cd_motivo_bloqueio) then
					If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',& 
																		String(ls_Laboratorio)+";"+String(ls_Distribuidora),& 
																		'CD_MOTIVO_BLOQUEIO',  string(ll_cd_motivo_bloqueio), '', gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "E", Ref ls_Mensagem, True) Then Return -1
				End If	
					
			End If
			
			//Se o produto veio DESMARCADO e foi marcado
			If ls_Anterior = 'N' And ls_Atual = 'S' Then
				
				If ldh_termino_bloqueio <=  ldh_inicio_bloqueio Then
					dw_2.Event ue_Pos(ll_Linha, "dh_termino_bloqueio")
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de termino tem que ser superior a data de inicio.",Exclamation!)
					Return -1
				End If
				
				Insert Into distribuidora_forn_conexao(cd_distribuidora, cd_fornecedor, dh_inicio_bloqueio, dh_termino_bloqueio, cd_motivo_bloqueio)
					Values(:ls_Distribuidora, :ls_Laboratorio, :ldh_inicio_bloqueio, :ldh_termino_bloqueio, :ll_cd_motivo_bloqueio)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					lb_Sucesso = False
					ls_Erro = SqlCa.SqlErrText
					SqlCa.of_Rollback();
					MessageBox("Erro", "Erro ao inserir a distribuidora '" + ls_Distribuidora + "'. " + ls_Erro, StopSign!)
					Return -1
				End If
				
				lb_Sucesso = True
				
				If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',& 
																		String(ls_Laboratorio)+";"+String(ls_Distribuidora),& 
																		'ID_ATUAL', 'N', ls_Atual, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "I", Ref ls_Mensagem, True) Then Return -1
																		
				If Not Isnull(ldh_inicio_bloqueio) then
					If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',& 
																		String(ls_Laboratorio)+";"+String(ls_Distribuidora),& 
																		'DH_INICIO_BLOQUEIO', '' , string(ldh_inicio_bloqueio), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "I", Ref ls_Mensagem, True) Then Return -1
				End If
				
				If Not Isnull(ldh_termino_bloqueio) then
					If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',& 
																		String(ls_Laboratorio)+";"+String(ls_Distribuidora),& 
																		'DH_TERMINO_BLOQUEIO', '', string(ldh_termino_bloqueio), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "I", Ref ls_Mensagem, True) Then Return -1
				End If
				
				If Not Isnull(ll_cd_motivo_bloqueio) then
					If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',& 
																		String(ls_Laboratorio)+";"+String(ls_Distribuidora),& 
																		'CD_MOTIVO_BLOQUEIO', '', string(ll_cd_motivo_bloqueio), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "I", Ref ls_Mensagem, True) Then Return -1
				End If
				
			End If
			 
			//Altera$$HEX2$$e700e300$$ENDHEX$$o da data
			ldh_data_inicio_antes = dw_2.GetItemDateTime (ll_linha, 'dh_inicio_bloqueio' , Primary!, True)
			ldh_data_inicio_atual  = dw_2.GetItemDateTime (ll_linha, 'dh_inicio_bloqueio', Primary!, False)
			
			ldh_data_termino_antes = dw_2.GetItemDatetime (ll_linha, 'dh_termino_bloqueio' , Primary!, True)
			ldh_data_termino_atual = dw_2.GetItemDatetime (ll_linha, 'dh_termino_bloqueio', Primary!, False)
			
			ll_cd_motivo_bloqueio_antes = dw_2.GetItemnumber( ll_linha,	'cd_motivo_bloqueio', Primary!, True)
			ll_cd_motivo_bloqueio_atual = dw_2.GetItemnumber( ll_linha,	'cd_motivo_bloqueio', Primary!, False)
			
			
			
			If Not lb_Sucesso Then
				If ((ldh_data_inicio_antes <> ldh_data_inicio_atual Or Isnull (ldh_data_inicio_antes)) Or &
					(ldh_data_termino_antes <> ldh_data_termino_atual Or Isnull (ldh_data_termino_antes))) And ls_Atual = 'S' Then
					
					If Not Isnull (ll_cd_motivo_bloqueio) Then
						If Isnull( ldh_data_inicio_atual) Then
							dw_2.Event ue_Pos(ll_Linha, "dh_inicio_bloqueio")
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Colocar a data de inicio.",Exclamation!)
							Return -1
						End If
						
						If Isnull( ldh_data_termino_atual) Then
							dw_2.Event ue_Pos(ll_Linha, "dh_termino_bloqueio")
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Colocar a data de fim.",Exclamation!)
							Return -1
						End If
					End If
					
					If ldh_termino_bloqueio <=  ldh_inicio_bloqueio Then
						dw_2.Event ue_Pos(ll_Linha, "dh_termino_bloqueio")
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de termino tem que ser superior a data de inicio.",Exclamation!)
						Return -1
					End If
					
					If Isnull(ll_cd_motivo_bloqueio) Then
						dw_2.Event ue_Pos(ll_Linha, "cd_motivo_bloqueio")
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tem que inserir um motivo.",Exclamation!)
						Return -1
					End If
				
					Update distribuidora_forn_conexao
						Set dh_inicio_bloqueio = :ldh_inicio_bloqueio,
							 dh_termino_bloqueio = :ldh_termino_bloqueio,
							 cd_motivo_bloqueio = :ll_cd_motivo_bloqueio
						Where cd_fornecedor = :ls_Laboratorio 
						And cd_distribuidora = :ls_distribuidora
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
							lb_Sucesso = False
							ls_Erro = SqlCa.SqlErrText
							SqlCa.of_Rollback();
							MessageBox("Erro", "Erro ao atualizar as data'" + string(ldh_inicio_bloqueio) +" "+ string(ldh_termino_bloqueio) +  "'. " + ls_Erro, StopSign!)
							Return -1
					End If
							
					lb_Sucesso = True
					
					If Isnull(ldh_data_inicio_antes) Then
						If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',& 
																			String(ls_Laboratorio)+";"+String(ls_Distribuidora),& 
																			'DH_INICIO_BLOQUEIO', String(ldh_data_inicio_antes), String(ldh_data_inicio_atual), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "I", Ref ls_Mensagem, True) Then Return -1
				
					End If
				
					If ldh_data_inicio_antes <> ldh_data_inicio_atual Then
						If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',& 
																			String(ls_Laboratorio)+";"+String(ls_Distribuidora),& 
																			'DH_INICIO_BLOQUEIO', String(ldh_data_inicio_antes), String(ldh_data_inicio_atual), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "A", Ref ls_Mensagem, True) Then Return -1
					End If
					
					 If  Isnull (ldh_data_termino_antes) Then
						If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',&
																			String(ls_Laboratorio)+";"+String(ls_Distribuidora),&
																			'DH_TERMINO_BLOQUEIO', String(ldh_data_termino_antes), String(ldh_data_termino_atual), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,"I", Ref ls_Mensagem, True) Then Return -1
					End If
					
					If ldh_data_termino_antes <> ldh_data_termino_atual Then
						If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',&
																			String(ls_Laboratorio)+";"+String(ls_Distribuidora),&
																			'DH_TERMINO_BLOQUEIO', String(ldh_data_termino_antes), String(ldh_data_termino_atual), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,"A", Ref ls_Mensagem, True) Then Return -1
					End If
					
				
					If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',&
																			String(ls_Laboratorio)+";"+String(ls_Distribuidora),&
																			'CD_MOTIVO_BLOQUEIO', '', String(ll_cd_motivo_bloqueio), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,"I", Ref ls_Mensagem, True) Then Return -1
	
				End If
			End If
			
			If (ll_cd_motivo_bloqueio_antes <> ll_cd_motivo_bloqueio_atual) Then
				
				If Isnull(ldh_inicio_bloqueio) Or Isnull(ldh_termino_bloqueio) Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tem que inserir as datas.",Exclamation!)
						Return -1
				End If
				
				Update distribuidora_forn_conexao
					Set cd_motivo_bloqueio = :ll_cd_motivo_bloqueio
					Where cd_fornecedor = :ls_Laboratorio 
					And cd_distribuidora = :ls_distribuidora
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
						lb_Sucesso = False
						ls_Erro = SqlCa.SqlErrText
						SqlCa.of_Rollback();
						MessageBox("Erro", "Erro ao atualizar as data'" + string(ldh_inicio_bloqueio) +" "+ string(ldh_termino_bloqueio) +  "'. " + ls_Erro, StopSign!)
						Return -1
				End If
				
				lb_Sucesso = True
				
				If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_FORN_CONEXAO',&
																			String(ls_Laboratorio)+";"+String(ls_Distribuidora),&
																			'CD_MOTIVO_BLOQUEIO',String(ll_cd_motivo_bloqueio_antes),String(ll_cd_motivo_bloqueio_atual), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,"A", Ref ls_Mensagem, True) Then Return -1
			End If
		End if
    Next
	If lb_Sucesso Then
		SqlCa.of_Commit();
		ivb_Valida_Salva = False
		dw_2.Event ue_Retrieve()
	Else
		Sqlca.of_rollback( )
	End If
End If

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Cancelar(False)
ivm_Menu.mf_Confirmar(False)

dw_1.Enabled = True

Return AncestorReturnValue
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge454_cadastro_forn_dist_conexao
integer x = 37
integer y = 924
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge454_cadastro_forn_dist_conexao
integer x = 0
integer y = 852
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge454_cadastro_forn_dist_conexao
integer y = 76
integer width = 1646
integer height = 176
string dataobject = "dw_ge454_selecao"
end type

event dw_1::ue_cancel;//OverRide
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "cd_laboratorio" Then
	If wf_Verifica_Van() Then Return -1
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge454_cadastro_forn_dist_conexao
integer y = 288
integer width = 3575
integer height = 1436
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge454_cadastro_forn_dist_conexao
integer y = 0
integer width = 1801
integer height = 284
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge454_cadastro_forn_dist_conexao
integer x = 78
integer y = 356
integer width = 3511
integer height = 1356
string dataobject = "dw_ge454_lista"
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText()

If IsNull(dw_1.Object.Cd_Laboratorio[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o laborat$$HEX1$$f300$$ENDHEX$$rio.")
	Return -1
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

String ls_Projeto

dw_1.AcceptText()

If Not wf_Verifica_Projeto_Conexao(dw_1.Object.Cd_Laboratorio[1], Ref ls_Projeto) Then Return -1

Return This.Retrieve(dw_1.Object.Cd_Laboratorio[1], ls_Projeto)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Parent.ivm_Menu.mf_Incluir(False)
Parent.ivm_Menu.mf_Excluir(False)

If pl_Linhas > 0 Then
	If Not wf_Marca_Check() Then Return -1
End If

Return pl_Linhas
end event

event dw_2::editchanged;call super::editchanged;Parent.ivm_Menu.mf_Incluir(False)
Parent.ivm_Menu.mf_Excluir(False)

ivb_Valida_Salva = True

dw_1.Enabled = False
end event

event dw_2::itemchanged;call super::itemchanged;date ldt_data


Choose case dwo.Name
	case 'dh_inicio_bloqueio' 
		ldt_data = date(data)
		
		if IsNull(ldt_data) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
			Return 1
		End If
	
		If ldt_data < idt_datahoje Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de inicio n$$HEX1$$e300$$ENDHEX$$o pode ser anterior a data de hoje.",Exclamation!)
			Return 1
		End if

	case  'dh_termino_bloqueio'
		ldt_data = date(data)
		
		if IsNull(ldt_data) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de fim.", Exclamation!)
			Return 1
		End If
	
		If ldt_data <= idt_datahoje Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de termino n$$HEX1$$e300$$ENDHEX$$o pode ser anterior a data de hoje.",Exclamation!)
			Return 1
		End if
End Choose

Parent.ivm_Menu.mf_Incluir(False)
Parent.ivm_Menu.mf_Excluir(False)

ivb_Valida_Salva = True

dw_1.Enabled = False

Return 0
end event

event dw_2::doubleclicked;call super::doubleclicked;If dwo.Name = 'st_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For lvl_Row = 1 To This.RowCount()				
		This.Object.Id_Atual[lvl_Row] = lvs_Marcacao		
	Next
	
	Parent.ivm_Menu.mf_Cancelar(True)
	Parent.ivm_Menu.mf_Confirmar(True)
	
	ivb_Valida_Salva = True
End If
end event

event dw_2::buttonclicked;call super::buttonclicked;String lvs_Parametro
String lvs_Codigo
String lvs_Laboratorio

lvs_Laboratorio 			= String(dw_1.Object.cd_laboratorio[1])
lvs_Codigo			= String(dw_2.Object.cd_distribuidora[row])

lvs_Parametro	= lvs_Laboratorio+";"+lvs_Codigo

OpenWithParm(w_ge454_historico, lvs_Parametro)
end event

event dw_2::itemfocuschanged;call super::itemfocuschanged;Parent.ivm_Menu.mf_Incluir(False)
Parent.ivm_Menu.mf_Excluir(False)
ivb_Valida_Salva = True
end event

