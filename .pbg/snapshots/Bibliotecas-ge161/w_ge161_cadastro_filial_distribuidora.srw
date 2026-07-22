HA$PBExportHeader$w_ge161_cadastro_filial_distribuidora.srw
forward
global type w_ge161_cadastro_filial_distribuidora from dc_w_cadastro_selecao_lista
end type
type cb_incluir from commandbutton within w_ge161_cadastro_filial_distribuidora
end type
type cb_importar from commandbutton within w_ge161_cadastro_filial_distribuidora
end type
end forward

global type w_ge161_cadastro_filial_distribuidora from dc_w_cadastro_selecao_lista
string tag = "w_ge161_cadastro_filial_distribuidora"
integer width = 3694
integer height = 2188
string title = "GE161 - Cadastro de Filial na Distribuidora"
boolean resizable = false
cb_incluir cb_incluir
cb_importar cb_importar
end type
global w_ge161_cadastro_filial_distribuidora w_ge161_cadastro_filial_distribuidora

type variables
uo_filial ivo_filial

string ivs_filiais, ivs_nulo

uo_ge216_filiais ivo_Selecao_filiais

String is_Uf
String is_Homologando

Boolean ib_Distrib_Conv = False
end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
public function boolean wf_le_dados_planilha ()
public function boolean wf_verifica_distribuidora_homologando (string as_situacao)
public function boolean wf_valida_informacoes (long al_filial, string as_distribuidora, boolean ab_mostra_mensagem)
public function boolean wf_grava_filial_distribuidora (long al_filial, string as_distribuidora, string as_filial_dist, string as_gln)
end prototypes

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

public function boolean wf_le_dados_planilha ();Any la_Dado

Boolean lb_Sucesso = False

Long ll_Linha
Long ll_Linhas
Long ll_Filial
Long ll_Tamanho

String ls_Distribuidora
String ls_Filial_Dist
String ls_Arquivo
String ls_ValorPara
String ls_GLN

dw_1.AcceptText()

ls_Distribuidora = dw_1.Object.Cd_Distribuidora[1]

dc_uo_excel lo_Excel
lo_Excel = Create dc_uo_excel

ls_Arquivo = dw_1.Object.De_Arquivo[1]

Open(w_Aguarde)
w_Aguarde.Title = "Importando Planilha..."

//Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
	
	//C$$HEX1$$f300$$ENDHEX$$digo da filial
	ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If ll_Linhas > 0 Then	
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
					
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			
			If Not IsNumber(String(la_Dado)) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo '" + String(la_Dado) + "' da filial inv$$HEX1$$e100$$ENDHEX$$lido.")
				Continue
			End If
			
			ll_Filial = Long(la_Dado)
									
			//C$$HEX1$$f300$$ENDHEX$$digo da filial na distribuidora
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
							
			ls_Filial_Dist = String(la_Dado)
			
			ll_Tamanho = LenA(ls_Filial_Dist)
			
			If ll_Tamanho > 20 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial na distribuidora '" + ls_Filial_Dist + "' inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
				Continue
			End If
			
			If Not wf_Valida_Informacoes(ll_Filial, "", True) Then
				lb_Sucesso = False
				Exit
			End If
					
			//Se for distribuidora de conveni$$HEX1$$ea00$$ENDHEX$$ncia
			If ib_Distrib_Conv Then
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "C")
				
				If Not IsNumber(String(la_Dado)) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo '" + String(la_Dado) + "' GLN inv$$HEX1$$e100$$ENDHEX$$lido.")
					Continue
				End If
				
				ls_GLN = String(la_Dado)
			End If
			
			If Not wf_Grava_Filial_Distribuidora(ll_Filial, ls_Distribuidora, ls_Filial_Dist, ls_GLN) Then
				lb_Sucesso = False
				Exit
			Else
				lb_Sucesso = True
			End If			
		Next
		
		If lb_Sucesso Then
			Close(w_Aguarde)
			Destroy(lo_Excel)			
			SqlCa.of_Commit();			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filiais inclu$$HEX1$$ed00$$ENDHEX$$das com sucesso.")
			dw_2.Event ue_Retrieve()
			dw_2.SetFocus()
		Else
			Close(w_Aguarde)
			Destroy(lo_Excel)
			SqlCa.of_RollBack();
			Return False
		End If
	End If
End If

Return True
end function

public function boolean wf_verifica_distribuidora_homologando (string as_situacao);String ls_Distribuidora
String ls_Homologando

dw_1.AcceptText()

ls_Distribuidora	= dw_1.Object.Cd_Distribuidora[1]

If as_Situacao = "A" Then

	Select Coalesce(id_homologando_pedido, "N")
		Into :ls_Homologando
	From distribuidora_uf
	Where cd_distribuidora = :ls_Distribuidora
		And cd_unidade_federacao = :ivo_Filial.Cd_Unidade_Federacao
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If ls_Homologando = "S" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Distribuidora em fase de homologa$$HEX2$$e700e300$$ENDHEX$$o. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel relacionar a filial como 'ATIVA'.", Exclamation!)
				Return False
			End If			
			
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o id_homologando na distribuidora '" + ls_Distribuidora + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_distribuidora_homologando.", StopSign!)
			Return False
			
		Case -1
			SqlCa.of_MsgdbError("Erro ao localizado o id_homologando. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_distribuidora_homologando.")
			Return False
	End Choose
End If
	
Return True
end function

public function boolean wf_valida_informacoes (long al_filial, string as_distribuidora, boolean ab_mostra_mensagem);String ls_Distribuidora

ls_Distribuidora = dw_1.Object.Cd_Distribuidora[1]

//Se na dw_1 o campo distribuidora estiver como 'TODAS', ser$$HEX1$$e100$$ENDHEX$$ utilizada a distribuidora da dw_2
If ls_Distribuidora = "000000000" Then
	ls_Distribuidora = as_Distribuidora
End If

is_Uf = ""
is_Homologando = ""

Select cd_uf
	Into :is_Uf
From vw_filial
Where cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		If ab_Mostra_Mensagem Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a filial '" + String(al_Filial) + "'.", StopSign!)
			Return False
		End If
		
	Case  -1
		SqlCa.of_MsgdbError("Erro ao localizar a UF da filial '" + String(al_Filial) + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_valida_informacoes")
		Return False
End Choose

Select id_homologando_pedido
	Into :is_Homologando
From distribuidora_uf
Where cd_distribuidora = :ls_Distribuidora
	And cd_unidade_federacao = :is_Uf
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		If ab_Mostra_Mensagem Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "UF '" + is_Uf + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ relacionada para a distribuidora '" + ls_Distribuidora + "'. Filial '" + String(al_Filial) + "'.", Exclamation!)
			Return False
		End If
		
	Case  -1
		SqlCa.of_MsgdbError("Erro ao localizar a UF '" + is_Uf + "' para a distribuidora '" + ls_Distribuidora + "'. Filial '" + String(al_Filial) + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_valida_informacoes")
		Return False
End Choose

Return True
end function

public function boolean wf_grava_filial_distribuidora (long al_filial, string as_distribuidora, string as_filial_dist, string as_gln);DateTime ldh_Alteracao

Integer lvi_Count

Long lvl_Filial

String ls_Situacao

ldh_Alteracao = gf_GetServerDate()

If is_Homologando = "S" Then
	ls_Situacao = "I"
Else
	ls_Situacao = "A"
End If

If ib_Distrib_Conv Then
	If ls_Situacao = "A" Then
		If Not gf_ge161_Verifica_Filial_Ativa_Conveniencia(al_Filial, as_Distribuidora) Then Return False
		
		If Not gf_ge4480_Altera_Parametro_Ped_Conve(al_Filial, "S") Then Return False
	Else
		If Not gf_ge4480_Altera_Parametro_Ped_Conve(al_Filial, "N") Then Return False
	End If
	
//	If IsNull(as_GLN) Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o GLN para a filial " + String(al_Filial) + ".", Exclamation!)
//		Return False
//	End If
End If

Select count(*) 
Into :lvi_Count
From filial_distribuidora
Where cd_filial        =:al_filial
  and cd_distribuidora =:as_distribuidora
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial na distribuidora.")
Else
	//Se a loja n$$HEX1$$e300$$ENDHEX$$o estiver cadastrada na distribuidora
	If lvi_Count = 0 Then
		
		Select cd_filial 
		Into :lvl_Filial
		From filial_distribuidora
		Where cd_distribuidora		=:as_distribuidora
		  and cd_filial_distribuidora	=:as_filial_dist
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo da filial na distribuidora.")
			Return False
		End If
		
		If IsNull(lvl_Filial) or lvl_Filial = 0 Then
			
			Insert Into filial_distribuidora  
					  ( cd_filial,
						cd_distribuidora,
						cd_filial_distribuidora,
						nr_prioridade,
						id_situacao,
						nr_sequencial_arquivo,
						nr_matric_alteracao_situacao,
					   	dh_alteracao_situacao,
						nr_gln)
			Values (  :al_filial,
					  	:as_Distribuidora,
					  	:as_filial_dist,
					 	0,
					  	:ls_Situacao,
					  	Null,
						:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
						:ldh_Alteracao,
						:as_GLN)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a filial " + String(al_Filial) + " na distribuidora " + as_Distribuidora + ". " + SqlCa.SqlErrText, StopSign!)
				Return False
			End If			
			
		Else 
			//Filial j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrada
			Return True
		End If

	Else
		//Filial j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrada
		Return True
	End If
End If
end function

on w_ge161_cadastro_filial_distribuidora.create
int iCurrent
call super::create
this.cb_incluir=create cb_incluir
this.cb_importar=create cb_importar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_incluir
this.Control[iCurrent+2]=this.cb_importar
end on

on w_ge161_cadastro_filial_distribuidora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_incluir)
destroy(this.cb_importar)
end on

event ue_postopen;// OverRide

ivo_dbError 			= Create dc_uo_dbError

ivo_Selecao_filiais 	= Create uo_ge216_filiais

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_AddRow()
dw_1.SetFocus()

This.ivm_Menu.mf_Recuperar(True)

ivo_Filial = Create uo_Filial

wf_Insere_Distribuidora_Default()

dw_2.ivo_Controle_Menu.of_SalvarComo(True)


end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Selecao_filiais)

end event

event ue_cancel;//OverRide

dw_2.Event ue_Cancel()
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge161_cadastro_filial_distribuidora
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge161_cadastro_filial_distribuidora
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge161_cadastro_filial_distribuidora
integer x = 37
integer y = 56
integer width = 1664
integer height = 332
string dataobject = "dw_ge161_selecao"
end type

event dw_1::ue_key;call super::ue_key;If dw_1.GetColumnName() = "nm_fantasia" Then
	If Key = KeyEnter! Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
					
			This.Object.cd_filial  		[1] = ivo_Filial.cd_filial
			This.Object.nm_fantasia	[1] = ivo_Filial.nm_fantasia
			
			This.Object.id_conjunto_filial[1] = "T"	
			
		End If
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
End If
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

Long lvl_Lojas

SetNull(lvl_Nulo)

Choose Case This.GetColumnName()
		
	Case "nm_fantasia" 
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			dw_1.Object.cd_filial  		[1] = ivo_Filial.cd_filial
			dw_1.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
		End If
	
	Case "id_conjunto_filial"
		
		ivs_filiais = ivs_nulo 
		
		If Data = 'C' Then
							
			OpenWithParm(w_ge216_selecao_filiais, ivo_Selecao_filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				
				ivo_Filial.of_Inicializa()
			
				dw_1.Object.cd_filial  		[1] = ivo_Filial.cd_filial
				dw_1.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
					
				ivs_filiais = ivo_Selecao_filiais.ivs_filiais
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")					
			End If

		End If
		
	Case "cd_distribuidora"
		If Data <> "000000000" Then
			Cb_Importar.Enabled = True
		Else
			Cb_Importar.Enabled = False
		End If
		
End Choose

dw_2.Reset()
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge161_cadastro_filial_distribuidora
integer x = 14
integer y = 432
integer width = 3648
integer height = 1456
string text = "Lista de Filiais"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge161_cadastro_filial_distribuidora
integer x = 14
integer y = 0
integer width = 1719
integer height = 420
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge161_cadastro_filial_distribuidora
integer x = 46
integer y = 492
integer width = 3561
integer height = 1364
string dataobject = "dw_ge161_lista_distribuidora"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Distribuidora,&
	   lvs_Filial_Distr,&
	   lvs_Situacao,&
	   lvs_DW,&
	   lvs_Text,&
	   lvs_Conjunto,&
	   ls_Retorno

Long lvl_Filial

dw_1.AcceptText()

lvs_Distribuidora 		= dw_1.Object.cd_distribuidora       	[1]
lvl_Filial        			= dw_1.Object.cd_filial              		[1]
lvs_Filial_Distr  			= dw_1.Object.cd_filial_distribuidora	[1]
lvs_Situacao      		= dw_1.Object.id_situacao            	[1]
lvs_Conjunto			= dw_1.Object.id_conjunto_filial     	[1]

ls_Retorno = Message.StringParm

If lvs_Distribuidora <> "000000000" Then
	lvs_DW   = "dw_ge161_lista_distribuidora"
	lvs_Text = "Lista de Filiais" 
ElseIf Not IsNull(lvl_Filial) Then
	lvs_Dw = "dw_ge161_lista_filial"
	lvs_Text = "Lista de Distribuidoras" 
Else
	If ls_Retorno <> "" And ls_Retorno <> "X" Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor ou a filial para efetuar a sele$$HEX2$$e700e300$$ENDHEX$$o.")
		Return -1
	End If
End If

If lvs_DW = "" Then
	Return -1
	
Else
	If dw_2.of_ChangeDataObject(lvs_DW) Then 
		This.of_SetRowSelection()
		gb_2.Text = lvs_Text
	Else
		Return -1
	End If
	
	If lvs_Distribuidora <> "000000000" Then
		dw_2.of_AppendWhere_SubQuery("fd.cd_distribuidora = '" + lvs_Distribuidora + "'", 3)
	End If
	
	If Not IsNull(lvl_Filial) Then
		dw_2.of_AppendWhere_SubQuery("fd.cd_filial = " + String(lvl_Filial), 3)
	End If
	
	If lvs_Situacao <> "T" Then
		dw_2.of_AppendWhere_SubQuery("fd.id_situacao = '" + lvs_Situacao + "'", 3)
	End If
	
	If Not IsNull(lvs_Filial_Distr) and Trim(lvs_Filial_Distr) <> "" Then
		dw_2.of_AppendWhere_SubQuery("fd.cd_filial_distribuidora = '" + lvs_Filial_Distr + "'", 3)
	End If
	
	If lvs_Conjunto = "C" Then
		If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
			dw_2.of_AppendWhere_SubQuery("fd.cd_filial in (" + ivs_Filiais + ")", 3)
		End If
	End If
End If

Return 1
end event

event dw_2::constructor;// OverRide

String lvs_DataObject

This.of_SetTransObject(SqlCa)

lvs_DataObject = This.DataObject

If Trim(This.DataObject) <> "" Then
	ivs_SQL_Original = This.Object.DataWindow.Table.Select
End If

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()

ivb_Selecao_Linhas = True

This.of_SetRowSelection()



end event

event dw_2::ue_preupdate;call super::ue_preupdate;Integer	lvi_Linhas, &
			lvi_Linha, &
			lvi_Prazo_Entrega, &
			lvi_Retorno = 1

Long		ll_Filial, &
			ll_Conveniencia

String 	lvs_Situacao, &
			lvs_Filial_Dist, &
			ls_ValorPara, &
			ls_Distribuidora, &
			ls_GLN, &
			lvs_Erro

Decimal 	lvde_Minimo_Pedido

Boolean	lvb_Alterou_CD_Filial_Distrib, &
			lvb_Alterou_ID_Situacao, &
			lvb_Alterou_NR_Gln, &
			lvb_Alterou_Minimo_Ped, &
			lvb_Alterou_Prazo, &
			lvb_Alterou_Horario_Corte
			
DateTime 	lvdh_Horario_Corte

dw_2.AcceptText()

lvi_Linhas = dw_2.RowCount()

If lvi_Linhas > 0 Then
	
	For lvi_Linha = 1 To lvi_Linhas
		
		ll_Filial 					= This.GetItemNumber(lvi_Linha, 'Cd_Filial')
		ll_Conveniencia			= This.GetItemNumber(lvi_Linha, 'Id_Conveniencia')
		lvi_Prazo_Entrega		= This.GetItemNumber(lvi_Linha, 'nr_prazo_entrega')
		lvde_Minimo_Pedido	= This.GetItemNumber(lvi_Linha, 'vl_minimo_pedido')
		ls_Distribuidora			= This.GetItemString(lvi_Linha, 'Cd_Distribuidora')
		ls_GLN					= This.GetItemString(lvi_Linha, 'Nr_GLN')
		lvs_Filial_Dist			= This.GetItemString(lvi_Linha, 'cd_filial_distribuidora')
		lvs_Situacao				= This.GetItemString(lvi_Linha, 'id_situacao')
		lvdh_Horario_Corte	= This.GetItemDateTime(lvi_Linha, 'dh_horario_corte')
		
		If IsNull(ll_Filial) Or ll_Filial = 0 Then ll_Filial = ivo_Filial.Cd_Filial
		
		If IsNull(lvs_Filial_Dist) or Trim(lvs_Filial_Dist) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo da filial na distribuidora.")
			dw_2.SetFocus()
			dw_2.Event ue_Pos(lvi_Linha, "cd_filial_distribuidora")
			lvi_Retorno = -1
		End If
		
		If lvs_Situacao <> 'A' and lvs_Situacao <> 'I' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A situa$$HEX2$$e700e300$$ENDHEX$$o deve ser 'A' - Ativo ou 'I' - Inativo.")
			dw_2.SetFocus()
			dw_2.Event ue_Pos(lvi_Linha, "id_situacao")
			lvi_Retorno = -1
		End If
		
		lvb_Alterou_CD_Filial_Distrib	= gf_Houve_Alteracao_Dw(This, 'CD_FILIAL_DISTRIBUIDORA', lvi_Linha, Ref ls_ValorPara)
		lvb_Alterou_ID_Situacao			= gf_Houve_Alteracao_Dw(This, 'ID_SITUACAO', lvi_Linha, Ref ls_ValorPara)
		lvb_Alterou_NR_Gln				= gf_Houve_Alteracao_Dw(This, 'NR_GLN', lvi_Linha, Ref ls_ValorPara)
		lvb_Alterou_Minimo_Ped			= gf_Houve_Alteracao_Dw(This, 'VL_MINIMO_PEDIDO', lvi_Linha, Ref ls_ValorPara)
		lvb_Alterou_Prazo					= gf_Houve_Alteracao_Dw(This, 'NR_PRAZO_ENTREGA', lvi_Linha, Ref ls_ValorPara)
		lvb_Alterou_Horario_Corte		= gf_Houve_Alteracao_Dw(This, 'DH_HORARIO_CORTE', lvi_Linha, Ref ls_ValorPara)
		
		If lvb_Alterou_Minimo_Ped Then
			// Se alterou para 0, gravar NULL.
			If lvde_Minimo_Pedido = 0 Then
				SetNull(lvde_Minimo_Pedido)
				This.SetItem(lvi_Linha, "vl_minimo_pedido", lvde_Minimo_Pedido)
			End If
		End If
		
		If lvb_Alterou_Prazo Then
			// Se alterou para 0, gravar NULL.
			If lvi_Prazo_Entrega = 0 Then
				SetNull(lvi_Prazo_Entrega)
				This.SetItem(lvi_Linha, "nr_prazo_entrega", lvi_Prazo_Entrega)
			End If
		End If
		
		If lvb_Alterou_Horario_Corte Then
			// Se alterou para 00:00, gravar NULL.
			If String(lvdh_Horario_Corte, "hh:mm") = "00:00" Then
				SetNull(lvdh_Horario_Corte)
				This.SetItem(lvi_Linha, "dh_horario_corte", lvdh_Horario_Corte)
			End If
		End If
		
		If lvi_Retorno = 1 Then
			If lvb_Alterou_ID_Situacao Then
				If wf_Valida_Informacoes(ll_Filial, ls_Distribuidora, True) Then
					If is_Homologando = "S" Then
						If lvs_Situacao = "A" Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Distribuidora '" + ls_Distribuidora + "' est$$HEX1$$e100$$ENDHEX$$ em fase de homologa$$HEX2$$e700e300$$ENDHEX$$o na UF '"+is_UF+"'.~r~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel alterar a situa$$HEX2$$e700e300$$ENDHEX$$o para 'ATIVA'.", Exclamation!)
							dw_2.Event ue_Pos(lvi_Linha, "id_situacao")
							lvi_Retorno = -1
						End If
					End If
				Else
					lvi_Retorno = -1
				End If
				
				If ll_Conveniencia > 0 Then
					If lvs_Situacao = "A" Then
						If Not gf_ge161_Verifica_Filial_Ativa_Conveniencia(ll_Filial, ls_Distribuidora) Then
							dw_2.Event ue_Pos(lvi_Linha, "id_situacao")
							lvi_Retorno = -1
						End If
						
						If Not gf_ge4480_Altera_Parametro_Ped_Conve(ll_Filial, "S") Then lvi_Retorno = -1
					Else
						If Not gf_ge4480_Altera_Parametro_Ped_Conve(ll_Filial, "N") Then lvi_Retorno = -1
					End If
						
					//Somente 1 distribuidora de conveni$$HEX1$$ea00$$ENDHEX$$ncia pode estar ativa por loja
//					If lvi_Retorno = 1 Then
//						If (Trim(ls_GLN) = "" Or IsNull(ls_GLN)) Then
//							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o GLN para a filial '" + String(ll_Filial) + "'.", Exclamation!)
//							dw_2.Event ue_Pos(lvi_Linha, "nr_gln")
//							lvi_Retorno = -1
//						End If
//					End If
					
				End If//conv>0
			End If//altsit
		End If//ret=1
		
		
//		If lvb_Alterou_NR_Gln Then
//			If (Trim(ls_GLN) = "" Or IsNull(ls_GLN)) And lvs_Situacao = "A" Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o GLN para a filial '" + String(ll_Filial) + "' e distribuidora '"+ls_Distribuidora+"'.", Exclamation!)
//				dw_2.Event ue_Pos(lvi_Linha, "nr_gln")
//				lvi_Retorno = -1
//			End If
//		End If
		
		// Gravar hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o e matr$$HEX1$$ed00$$ENDHEX$$cula
		If lvi_Retorno = 1 Then
			If lvb_Alterou_Minimo_Ped Then
				If Not gf_Grava_Historico_Alteracao_Tabela('FILIAL_DISTRIBUIDORA', ls_Distribuidora+'@#!'+String(ll_Filial), 'VL_MINIMO_PEDIDO', String(This.GetItemNumber(lvi_Linha, 'VL_MINIMO_PEDIDO', Primary!, True), '###,##0.00'), String(lvde_Minimo_Pedido), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref lvs_Erro, True) Then
					lvi_Retorno = -1
				End If
			End If
			
			If lvb_Alterou_Prazo Then
				If Not gf_Grava_Historico_Alteracao_Tabela('FILIAL_DISTRIBUIDORA', ls_Distribuidora+'@#!'+String(ll_Filial), 'NR_PRAZO_ENTREGA', String(This.GetItemNumber(lvi_Linha, 'NR_PRAZO_ENTREGA', Primary!, True)), String(lvi_Prazo_Entrega), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref lvs_Erro, True) Then
					lvi_Retorno = -1
				End If
			End If
			
			If lvb_Alterou_Horario_Corte Then
				If Not gf_Grava_Historico_Alteracao_Tabela('FILIAL_DISTRIBUIDORA', ls_Distribuidora+'@#!'+String(ll_Filial), 'DH_HORARIO_CORTE', String(This.GetItemDateTime(lvi_Linha, 'DH_HORARIO_CORTE', Primary!, True), "hh:mm"), String(lvdh_Horario_Corte), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref lvs_Erro, True) Then
					lvi_Retorno = -1
				End If
			End If
			
			If lvi_Retorno = 1 And (lvb_Alterou_CD_Filial_Distrib Or lvb_Alterou_ID_Situacao Or lvb_Alterou_Minimo_Ped Or lvb_Alterou_Prazo Or lvb_Alterou_Horario_Corte) Then
				This.SetItem(lvi_Linha, 'Nr_Matric_Alteracao_Situacao', gvo_Aplicacao.ivo_Seguranca.Nr_Matricula)
				This.SetItem(lvi_Linha, 'Nm_Usuario', gvo_Aplicacao.ivo_Seguranca.Nm_Usuario)
				This.SetItem(lvi_Linha, 'Dh_Alteracao_Situacao', gf_GetServerDate())
			End If
		End If
		
		If lvi_Retorno = -1 Then
			Exit
		End If
	Next
End If 

Return lvi_Retorno
end event

event dw_2::itemchanged;call super::itemchanged;// N$$HEX1$$e300$$ENDHEX$$o permitir valor negativo.
Choose Case dwo.Name
	Case "vl_minimo_pedido", "nr_prazo_entrega"
		If Dec(Data) < 0 Then Return 1
End Choose
end event

type cb_incluir from commandbutton within w_ge161_cadastro_filial_distribuidora
integer x = 3205
integer y = 1904
integer width = 457
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir Filial"
end type

event clicked;OpenWithParm(w_ge161_inclui_filial, "")

dw_2.Event ue_Retrieve()
end event

type cb_importar from commandbutton within w_ge161_cadastro_filial_distribuidora
integer x = 9
integer y = 1904
integer width = 544
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Importar &Planilha"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo
String ls_Erro

dw_1.AcceptText()

If Not gf_Retorna_Distribuidora_Conveniencia(dw_1.Object.Cd_Distribuidora[1], True, Ref ib_Distrib_Conv, Ref ls_Erro) Then Return -1

If Not ib_Distrib_Conv Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma: (SEM CABE$$HEX1$$c700$$ENDHEX$$ALHO)~r" + &
					"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da filial (INTERNO)" + &
					"~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo da filial na DISTRIBUIDORA")
	
Else
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma: (SEM CABE$$HEX1$$c700$$ENDHEX$$ALHO)~r" + &
					"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da filial (INTERNO)" + &
					"~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo da filial na DISTRIBUIDORA" + &
					"~rColuna C = N$$HEX1$$fa00$$ENDHEX$$mero GLN (se n$$HEX1$$e300$$ENDHEX$$o for informado a filial ficar$$HEX1$$e100$$ENDHEX$$ inativa)")
End If
				
li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a importa$$HEX2$$e700e300$$ENDHEX$$o da planilha?", Question!, YesNo!, 2) = 2 Then
		Return -1
	End If
	
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	
	If Not wf_Le_Dados_Planilha() Then
		Return -1
	End If
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
End If
end event

