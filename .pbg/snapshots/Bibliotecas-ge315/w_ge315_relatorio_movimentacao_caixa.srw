HA$PBExportHeader$w_ge315_relatorio_movimentacao_caixa.srw
forward
global type w_ge315_relatorio_movimentacao_caixa from dc_w_2tab_consulta_selecao_lista_det
end type
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_4 dw_4
end type
type tabpage_4 from userobject within tab_1
end type
type gb_5 from groupbox within tabpage_4
end type
type dw_5 from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_1
gb_5 gb_5
dw_5 dw_5
end type
type tabpage_5 from userobject within tab_1
end type
type gb_6 from groupbox within tabpage_5
end type
type dw_6 from dc_uo_dw_base within tabpage_5
end type
type tabpage_5 from userobject within tab_1
gb_6 gb_6
dw_6 dw_6
end type
type lb_arquivos from listbox within w_ge315_relatorio_movimentacao_caixa
end type
end forward

global type w_ge315_relatorio_movimentacao_caixa from dc_w_2tab_consulta_selecao_lista_det
integer width = 3886
integer height = 1876
string title = "GE315 - Relat$$HEX1$$f300$$ENDHEX$$rio de Movimenta$$HEX2$$e700e300$$ENDHEX$$o de Caixa"
lb_arquivos lb_arquivos
end type
global w_ge315_relatorio_movimentacao_caixa w_ge315_relatorio_movimentacao_caixa

type variables
Private:
uo_filial ivo_filial

dc_uo_ds_base ivds_1

String ivs_caixa
Long ivl_controle
Datetime ivdh_Movimento

boolean ivb_caixa_geral = false

dc_uo_api ivo_api
dc_uo_ftp ivo_ftp
Constant String FTP_Servidor	= 'ftp://10.0.4.30'
Constant String FTP_Usuario	= 'caixafilial'
Constant String FTP_Senha		= 'Spum@qa8res#'

String ivs_Dir
end variables

forward prototypes
public function boolean wf_caixa_geral (string as_caixa)
public function integer wf_preparar_impressao ()
public function string wf_nome_usuario (string ps_matricula)
public subroutine wf_atualiza_estornos ()
public subroutine wf_retorna_arquivos_ftp ()
public subroutine wf_ajusta_filtros ()
public function boolean wf_saldo_controle_caixa (string as_caixa, long al_controle, datetime adh_movimento, ref decimal adc_saldo)
end prototypes

public function boolean wf_caixa_geral (string as_caixa);Boolean lvb_Geral = False

String lvs_Geral

Select id_caixa_geral Into :lvs_Geral
From caixa
Where cd_caixa = :as_Caixa
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvs_Geral = "S" Then lvb_Geral = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Caixa '" + as_Caixa + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Identifica$$HEX2$$e700e300$$ENDHEX$$o do Caixa Geral")
End Choose

Return lvb_Geral
end function

public function integer wf_preparar_impressao ();Long lvl_Total, &
     lvl_Contador

String lvs_Matricula_Gerente, &
       lvs_Nome_Gerente, &
		 lvs_Matricula_Conferente, &
		 lvs_Nome_Conferente, &
		 lvs_DW, &
		 lvs_Estorno

Decimal lvdc_Saldo_Anterior

If ivb_Caixa_Geral Then
	If Not wf_Saldo_Controle_Caixa(ivs_Caixa, ivl_Controle - 1, ivdh_Movimento, ref lvdc_Saldo_Anterior) Then
		Return -1
	End If
	
	lvs_DW = "dw_ge315_relatorio_caixa_geral"
Else	
	lvs_DW = "dw_ge315_relatorio_caixa_controle"
End If

If Not ivds_1.of_ChangeDataObject(lvs_DW) Then Return -1

lvl_Total = ivds_1.Retrieve(ivs_Caixa, ivl_Controle)

If lvl_Total <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na recupera$$HEX2$$e700e300$$ENDHEX$$o dos dados para impress$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
	Return -1
End If

// Atualiza os estornos
For lvl_Contador = 1 To lvl_Total
	lvs_Estorno = ivds_1.Object.Id_Estorno[lvl_Contador]
	
	If IsNull(lvs_Estorno) Then
		ivds_1.Object.Id_Estorno[lvl_Contador] = "N"
	End If
Next

// Atualiza o Saldo do Dia Anterior
If ivb_Caixa_Geral Then
	ivds_1.Object.Vl_Saldo_Dia_Anterior[1] = lvdc_Saldo_Anterior
End If

lvs_Matricula_Gerente    = ivds_1.Object.Nr_Matricula_Gerente    [1]
lvs_Matricula_Conferente = ivds_1.Object.Nr_Matricula_Conferencia[1]

If Not IsNull(lvs_Matricula_Gerente) and Trim(lvs_Matricula_Gerente) <> "" Then
	lvs_Nome_Gerente = wf_Nome_Usuario(lvs_Matricula_Gerente)
	ivds_1.Object.Gerente.Text = lvs_Nome_Gerente + " (" + lvs_Matricula_Gerente + ")"
End If

If Not IsNull(lvs_Matricula_Conferente) and Trim(lvs_Matricula_Conferente) <> "" Then
	lvs_Nome_Conferente = wf_Nome_Usuario(lvs_Matricula_Conferente)
	ivds_1.Object.Conferente.Text = lvs_Nome_Conferente + " (" + lvs_Matricula_Conferente + ")"
End If

Return lvl_Total
end function

public function string wf_nome_usuario (string ps_matricula);String lvs_Nm_Usuario

Select nm_usuario into :lvs_Nm_Usuario
from usuario
where nr_matricula = :ps_Matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do usu$$HEX1$$e100$$ENDHEX$$rio.")
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o localizado.",StopSign!)
End Choose

Return lvs_Nm_Usuario
end function

public subroutine wf_atualiza_estornos ();Long lvl_Total, &
     lvl_Contador
	  
String lvs_Estorno

lvl_Total = Tab_1.TabPage_2.dw_3.RowCount()

For lvl_Contador = 1 To lvl_Total
	lvs_Estorno = Tab_1.TabPage_2.dw_3.Object.Id_Estorno[lvl_Contador]
	
	If IsNull(lvs_Estorno) Then
		Tab_1.TabPage_2.dw_3.Object.Id_Estorno[lvl_Contador] = "N"
	End If
Next
end subroutine

public subroutine wf_retorna_arquivos_ftp ();Long lvl_Item
Long lvl_Filial
Datetime lvdh_Movimentacao

String lvs_Msg

s_ftpdirlist lvo_fileftplist[]

Tab_1.tabpage_5.dw_6.Reset()

ivo_ftp.of_conecta_ftp(gvo_aplicacao.ivo_seguranca.cd_sistema+"_"+gvo_aplicacao.ivo_seguranca.of_get_usuario_windows( ), &
						FTP_Servidor, FTP_Usuario, FTP_Senha)
If ivo_ftp.of_ftp_set_dir(String(ivdh_Movimento, "YYYY/MM/DD")+"/"+Mid(ivs_caixa, 1, 4), lvs_Msg) > 0 Then
	ivo_ftp.of_ftp_lista_arquivos("*.PDF", ref lvo_fileftplist)
	
	For lvl_Item = 1 To UpperBound(lvo_fileftplist)
		Tab_1.tabpage_5.dw_6.InsertRow(0)
		
		Tab_1.tabpage_5.dw_6.Object.nm_arquivo		[lvl_Item] = lvo_fileftplist[lvl_Item].s_filename
		Tab_1.tabpage_5.dw_6.Object.dh_modificado	[lvl_Item] = lvo_fileftplist[lvl_Item].dt_lastwritetime
		Tab_1.tabpage_5.dw_6.Object.de_tipo 			[lvl_Item] = Upper(ivo_api.of_get_filedescription( lvo_fileftplist[lvl_Item].s_filename ))
		Tab_1.tabpage_5.dw_6.Object.nr_tamanho		[lvl_Item] = (lvo_fileftplist[lvl_Item].db_filesize + 1024) / 1024
	Next
End If
ivo_ftp.of_desconecta_ftp( )
end subroutine

public subroutine wf_ajusta_filtros ();DataWindowChild lvdwc_Child

If Tab_1.TabPage_1.dw_1.GetChild("cd_caixa", lvdwc_Child) > 0 Then
	If lvdwc_Child.GetRow() > 0 Then
		//O item selecionado $$HEX1$$e900$$ENDHEX$$ caixa geral?
		If lvdwc_Child.GetItemString(lvdwc_Child.GetRow(), "id_caixa_geral") = "S" Then
			Tab_1.TabPage_1.dw_1.Object.id_situacao.TabSequence	= 50
			Tab_1.TabPage_1.dw_1.Object.id_arq_dig.TabSequence	= 60
			Tab_1.TabPage_1.dw_1.Object.id_sit_dig.TabSequence		= 70			
		Else
			Tab_1.TabPage_1.dw_1.Object.id_situacao.TabSequence	= 0
			Tab_1.TabPage_1.dw_1.Object.id_arq_dig.TabSequence	= 0
			Tab_1.TabPage_1.dw_1.Object.id_sit_dig.TabSequence		= 0
			Tab_1.TabPage_1.dw_1.Object.id_situacao	[1] = "T"
			Tab_1.TabPage_1.dw_1.Object.id_arq_dig	[1] = "T"
			Tab_1.TabPage_1.dw_1.Object.id_sit_dig	[1] = "T"
		End If
	End If
End If
end subroutine

public function boolean wf_saldo_controle_caixa (string as_caixa, long al_controle, datetime adh_movimento, ref decimal adc_saldo);Boolean lvb_Sucesso = False
String lvs_PDV_Novo

Select top 1 cc.vl_saldo_final Into :adc_Saldo
From controle_caixa cc
Where cc.cd_caixa          	= :as_Caixa
  and cc.nr_controle_caixa	>= :al_Controle - 3
  and cc.nr_controle_caixa  	<= :al_Controle
  and cc.dh_movimentacao_caixa >= dateadd(dd, -31, :adh_movimento)
Order by cc.nr_controle_caixa desc
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo do controle '" + String(al_Controle) + "' do caixa '" + as_Caixa + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo do Controle do Caixa")
End Choose

Return lvb_Sucesso
end function

on w_ge315_relatorio_movimentacao_caixa.create
int iCurrent
call super::create
this.lb_arquivos=create lb_arquivos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lb_arquivos
end on

on w_ge315_relatorio_movimentacao_caixa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lb_arquivos)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.Dt_Inicio		[1] = Today()
Tab_1.TabPage_1.dw_1.Object.Dt_Termino	[1] = Today()

This.ivm_menu.ivb_permite_imprimir = True
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_5.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.ivo_controle_menu.of_imprimir(False)
Tab_1.TabPage_4.dw_5.ivo_controle_menu.of_imprimir(False)

ivs_Dir = ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Diretorio", "Arquivos_Digitalizados_Caixa", "")
If Trim(ivs_Dir) = "" Then
	ivs_Dir = gvo_aplicacao.ivs_path_arquivos+"Arquivos_Digitalizados_Caixa\"
    	SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Diretorio", "Arquivos_Digitalizados_Caixa",ivs_Dir)
End If
If Not DirectoryExists(ivs_Dir) then CreateDirectory( ivs_Dir )

end event

event close;call super::close;Long lvl_Item

lb_arquivos.DirList(ivs_Dir+'\*.*', 0)
For lvl_Item = 1 To lb_arquivos.TotalItems( )
	FileDelete(ivs_Dir+lb_arquivos.Text(lvl_Item))
Next

ChangeDirectory(gvo_aplicacao.ivs_path_arquivos)
RemoveDirectory(ivs_Dir)

Destroy(ivo_Filial)
Destroy(ivds_1)
Destroy(ivo_ftp)
Destroy(ivo_api)
end event

event ue_print;Long lvl_Linhas, &
     lvl_Linhas_Detalhe

lvl_Linhas = wf_preparar_impressao()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		ivds_1.Print()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
	End If
End If


end event

event ue_printimmediate;call super::ue_printimmediate;Long lvl_Linhas, &
     lvl_Linhas_Detalhe

lvl_Linhas = wf_preparar_impressao()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		ivds_1.Print()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!, Ok!)
	End If
End If


end event

event ue_preopen;call super::ue_preopen;ivo_ftp	= Create dc_uo_ftp
ivo_Filial	= Create uo_Filial
ivds_1	= Create dc_uo_ds_base
ivo_api	= Create dc_uo_api

Maxheight = 9999
end event

event resize;//override
Tab_1.Height = NewHeight - 10

Tab_1.Tabpage_1.gb_2.Height	= Newheight - Tab_1.Tabpage_1.gb_2.Y - 140
Tab_1.Tabpage_1.dw_2.Height	= Newheight - Tab_1.Tabpage_1.dw_2.Y - 180

Tab_1.Tabpage_2.gb_3.Height	= Newheight - Tab_1.Tabpage_2.gb_3.Y - 140
Tab_1.Tabpage_2.dw_3.Height	= Newheight - Tab_1.Tabpage_2.dw_3.Y - 180

Tab_1.Tabpage_3.gb_4.Height	= Newheight - Tab_1.Tabpage_3.gb_4.Y - 140
Tab_1.Tabpage_3.dw_4.Height	= Newheight - Tab_1.Tabpage_3.dw_4.Y - 180

Tab_1.Tabpage_4.gb_5.Height	= Newheight - Tab_1.Tabpage_4.gb_5.Y - 140
Tab_1.Tabpage_4.dw_5.Height	= Newheight - Tab_1.Tabpage_4.dw_5.Y - 180

Tab_1.Tabpage_5.gb_6.Height	= Newheight - Tab_1.Tabpage_5.gb_6.Y - 140
Tab_1.Tabpage_5.dw_6.Height	= Newheight - Tab_1.Tabpage_5.dw_6.Y - 180
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge315_relatorio_movimentacao_caixa
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge315_relatorio_movimentacao_caixa
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge315_relatorio_movimentacao_caixa
integer x = 5
integer y = 4
integer width = 3831
integer height = 1672
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

event tab_1::selectionchanged;// Override
SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width = 3845
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2	
		This.Width = 3845
		Tab_1.TabPage_2.dw_3.SetFocus()
	Case 3
		This.Width = 2350
		Tab_1.TabPage_3.dw_4.SetFocus()
	Case 4
		This.Width = 2250
		Tab_1.TabPage_4.dw_5.SetFocus()
	Case 5
		This.Width = 3845
		wf_retorna_arquivos_ftp( )
End Choose

Parent.Width  = This.Width	+ This.X + 75

SetPointer(Arrow!)
end event

event tab_1::selectionchanging;// Override
String lvs_DW

Choose Case NewIndex
	Case 1
		Tab_1.TabPage_1.dw_2.ivm_menu.mf_salvarcomo( Tab_1.TabPage_1.dw_2.RowCount() > 0 )
		
	Case 2
	
		String aux
		aux = String(ivl_Controle)
		aux= ivs_Caixa
		
		If ivl_Controle <> 0 Or ivs_Caixa <> "" Then
		
			If ivb_Caixa_Geral Then
				lvs_DW = "dw_ge315_detalhe_lancamento_geral"
			Else
				lvs_DW = "dw_ge315_detalhe_lancamento_controle"
			End If
			
			Tab_1.TabPage_2.dw_3.of_ChangeDataObject(lvs_DW)		
			
			Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
			//Permite Troca do Folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If

	Case 3
		If ivl_Controle = 0 Or ivs_Caixa = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		Else
			Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
			Return 0
		End If

	Case 4
		If ivl_Controle = 0 Or ivs_Caixa = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		Else
			Tab_1.TabPage_4.dw_5.Event ue_Retrieve()
			Return 0
		End If

	Case 5
		If ivl_Controle = 0 Or ivs_Caixa = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os arquivos digitalizados.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		Else
			Return 0
		End If
End Choose
end event

on tab_1.create
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
this.Control[iCurrent+2]=this.tabpage_4
this.Control[iCurrent+3]=this.tabpage_5
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3794
integer height = 1556
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 14
integer y = 348
integer width = 3758
integer height = 1184
integer taborder = 10
string text = "Lista de Controles de Caixa"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 9
integer width = 2885
integer height = 324
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 27
integer y = 76
integer width = 2853
integer height = 248
integer taborder = 30
string dataobject = "dw_ge315_selecao"
end type

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;This.DataObject = "dw_ge315_selecao"
Return 1
end event

event dw_1::ue_addrow;call super::ue_addrow;This.SetTransObject(SqlCa)
This.of_Populate_DDDW("cd_caixa")

Return AncestorReturnValue
end event

event dw_1::ue_populate_dddw;Long lvl_Filial

String lvs_Nulo

pdwc_DDDW.SetTransObject(SqlCa)

This.AcceptText()
lvl_Filial = This.Object.Cd_Filial[1]

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	pdwc_DDDW.Retrieve(lvl_Filial)
	
	SetNull(lvs_Nulo)
	This.Object.Cd_Caixa[1] = lvs_Nulo
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.nm_filial	[1] = ivo_filial.Nm_Fantasia
			This.Object.cd_filial	[1] = ivo_filial.Cd_Filial
					
		End If	
	Case "cd_caixa"
		Post wf_ajusta_filtros( )
End Choose
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			
			This.of_Populate_DDDW("cd_caixa")
		End If
	End If
End If
end event

event dw_1::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = "nm_filial" Then
	
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.nm_filial	[1] = ivo_filial.Nm_Fantasia
		This.Object.cd_filial	[1] = ivo_filial.Cd_Filial
				
	End If	
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 37
integer y = 412
integer width = 3721
integer height = 1100
integer taborder = 40
string dataobject = "dw_ge315_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// Override
String lvs_Caixa

Date lvdt_Inicio, &
     lvdt_Termino
	  
dw_1.AcceptText()

lvs_Caixa			= dw_1.Object.Cd_Caixa		[1]
lvdt_Inicio		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

Return This.Retrieve(lvs_Caixa, lvdt_Inicio, lvdt_Termino)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	ivs_Caixa				= This.Object.Cd_Caixa						[CurrentRow]
	ivl_Controle			= This.Object.Nr_Controle_Caixa			[CurrentRow]
	ivdh_Movimento	= This.Object.Dh_Movimentacao_Caixa	[CurrentRow]
	
	ivb_Caixa_Geral = wf_Caixa_Geral(ivs_Caixa)
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
End If

This.ivo_Controle_Menu.of_SalvarComo(pl_Linhas > 0)
This.ivo_controle_menu.of_imprimir(False)

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;SetNull( ivs_caixa )
SetNull( ivl_controle )
SetNull( ivdh_Movimento )
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Situacao
String lvs_Arq_Dig
String lvs_Sit_Dig
String lvs_Caixa

Date lvdt_Inicio, &
     lvdt_Termino
	  
Long lvl_Filial


Parent.Dw_1.Accepttext( )
lvs_Situacao 	= Dw_1.Object.id_situacao	[1]
lvs_Arq_Dig	 	= Dw_1.Object.id_arq_dig	[1]
lvs_Sit_Dig	 	= Dw_1.Object.id_sit_dig	[1]
lvl_Filial			= dw_1.Object.Cd_Filial		[1]
lvs_Caixa			= dw_1.Object.Cd_Caixa		[1]
lvdt_Inicio		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

If IsNull(lvl_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a Filial.", StopSign!)
	dw_1.Event ue_Pos(1, "nm_filial")
	Return -1
End If

If IsNull(lvs_Caixa) or lvs_Caixa = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o caixa.", StopSign!)
	dw_1.Event ue_Pos(1, "cd_caixa")
	Return -1
End If

If Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvs_Situacao <> "T" Then
	This.of_appendwhere("coalesce(c.id_situacao,'N')='"+ lvs_Situacao+"'")
End If	

Choose Case lvs_Arq_Dig
	Case "S"
		This.of_appendwhere("coalesce(c.nr_contador_anexos,0)>0")		
	Case "N"
		This.of_appendwhere("coalesce(c.nr_contador_anexos,0)=0")	
End Choose

If lvs_Sit_Dig <> "T" Then
	This.of_appendwhere("coalesce(c.id_situacao_anexos,'N')='"+ lvs_Sit_Dig+"'")
End If	

Return AncestorReturnValue
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3794
integer height = 1556
string text = "Lan$$HEX1$$e700$$ENDHEX$$amentos"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 18
integer y = 0
integer width = 3758
integer height = 1540
string text = ""
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 50
integer y = 36
integer width = 3717
integer height = 1472
string dataobject = "dw_ge315_detalhe_lancamento_controle"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::ue_recuperar;// Override
Return This.Retrieve(ivs_Caixa, ivl_Controle)
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;// Override
Decimal lvdc_Saldo_Anterior

If pl_Linhas > 0 Then
	If This.DataObject = "dw_ge315_detalhe_lancamento_geral" Then
		If Not wf_Saldo_Controle_Caixa(ivs_Caixa, ivl_Controle - 1, ivdh_Movimento, ref lvdc_Saldo_Anterior) Then
			Return -1
		End If
		
		This.Object.Vl_Saldo_Dia_Anterior[1] = lvdc_Saldo_Anterior
	End If
	
	// Verifica os estornos nulos
	wf_Atualiza_Estornos()
End If

This.ivo_Controle_Menu.of_Imprimir(pl_Linhas > 0)
This.ivo_Controle_Menu.of_SalvarComo(pl_Linhas > 0)
This.Of_SetRowSelection()
This.Of_SetSort()

Return pl_Linhas
end event

event dw_3::constructor;call super::constructor;//This.ivb_Selecao_Linhas = True

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3794
integer height = 1556
long backcolor = 67108864
string text = "Tesouraria"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage_3
integer x = 18
integer width = 2277
integer height = 1536
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 50
integer y = 48
integer width = 2213
integer height = 1464
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge315_detalhe_tesouraria"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//OverRide

Return This.Retrieve(ivs_Caixa, ivl_Controle)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
This.Of_SetSort()
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_Controle_Menu.of_SalvarComo(pl_Linhas > 0)
This.ivo_Controle_Menu.of_Imprimir(pl_Linhas > 0)

Return AncestorReturnValue
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3794
integer height = 1556
long backcolor = 67108864
string text = "Dep$$HEX1$$f300$$ENDHEX$$sitos"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_5 gb_5
dw_5 dw_5
end type

on tabpage_4.create
this.gb_5=create gb_5
this.dw_5=create dw_5
this.Control[]={this.gb_5,&
this.dw_5}
end on

on tabpage_4.destroy
destroy(this.gb_5)
destroy(this.dw_5)
end on

type gb_5 from groupbox within tabpage_4
integer x = 18
integer width = 2176
integer height = 1540
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_5 from dc_uo_dw_base within tabpage_4
integer x = 46
integer y = 44
integer width = 2121
integer height = 1468
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge315_detalhe_deposito"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//OverRide

Return This.Retrieve(ivs_Caixa, ivl_Controle)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
This.Of_SetSort()

end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_Controle_Menu.of_SalvarComo(pl_Linhas > 0)
This.ivo_Controle_Menu.of_Imprimir(pl_Linhas > 0)

Return AncestorReturnValue
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3794
integer height = 1556
long backcolor = 67108864
string text = "Arq. Digitalizados"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_6 gb_6
dw_6 dw_6
end type

on tabpage_5.create
this.gb_6=create gb_6
this.dw_6=create dw_6
this.Control[]={this.gb_6,&
this.dw_6}
end on

on tabpage_5.destroy
destroy(this.gb_6)
destroy(this.dw_6)
end on

type gb_6 from groupbox within tabpage_5
integer x = 14
integer y = 12
integer width = 3758
integer height = 1524
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_6 from dc_uo_dw_base within tabpage_5
integer x = 59
integer y = 76
integer width = 3685
integer height = 1432
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge315_arquivos_ftp"
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;String ls_filename
String ls_tempfile

If This.RowCount() > 0 Then
	SetPointer(HourGlass!)
	ls_filename = This.Object.nm_arquivo [This.GetRow()]
	ivo_ftp.of_conecta_ftp(gvo_aplicacao.ivo_seguranca.cd_sistema+"_"+gvo_aplicacao.ivo_seguranca.of_get_usuario_windows( ), &
						FTP_Servidor, FTP_Usuario, FTP_Senha)
	ivo_ftp.of_ftp_set_dir(String(ivdh_Movimento, "YYYY/MM/DD")+"/"+Mid(ivs_caixa, 1, 4)+"/")
	ls_tempfile = ivs_Dir + ls_filename
	
	If ivo_ftp.of_ftp_getfile( ls_filename, ls_tempfile ) Then
		SetPointer(Arrow!)
		gf_Run(ls_tempfile, 1, False)
		ivo_ftp.of_desconecta_ftp( )
	Else
		ivo_ftp.of_desconecta_ftp( )
		Return
	End If
End If
end event

event constructor;call super::constructor;This.Of_Setrowselection( )
end event

type lb_arquivos from listbox within w_ge315_relatorio_movimentacao_caixa
boolean visible = false
integer x = 3461
integer y = 64
integer width = 265
integer height = 180
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean border = false
end type

