HA$PBExportHeader$w_ge635_consulta_convenio.srw
forward
global type w_ge635_consulta_convenio from dc_w_sheet
end type
type tab_1 from tab within w_ge635_consulta_convenio
end type
type tabpage_1 from userobject within tab_1
end type
type cb_negociacao from commandbutton within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_negociacao cb_negociacao
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_2 from dc_uo_dw_base within tabpage_2
end type
type pb_2 from picturebutton within tabpage_2
end type
type lb_uf from listbox within tabpage_2
end type
type pb_1 from picturebutton within tabpage_2
end type
type sle_desc_filial from singlelineedit within tabpage_2
end type
type st_1 from statictext within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type lb_rede from listbox within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type gb_4 from groupbox within tabpage_2
end type
type gb_7 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
dw_2 dw_2
pb_2 pb_2
lb_uf lb_uf
pb_1 pb_1
sle_desc_filial sle_desc_filial
st_1 st_1
st_2 st_2
lb_rede lb_rede
st_3 st_3
gb_3 gb_3
gb_4 gb_4
gb_7 gb_7
end type
type tabpage_3 from userobject within tab_1
end type
type dw_5 from dc_uo_dw_base within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type gb_5 from groupbox within tabpage_3
end type
type gb_2 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_5 dw_5
dw_4 dw_4
gb_5 gb_5
gb_2 gb_2
end type
type tabpage_4 from userobject within tab_1
end type
type pb_3 from picturebutton within tabpage_4
end type
type dw_7 from dc_uo_dw_base within tabpage_4
end type
type dw_6 from dc_uo_dw_base within tabpage_4
end type
type gb_1 from groupbox within tabpage_4
end type
type tabpage_4 from userobject within tab_1
pb_3 pb_3
dw_7 dw_7
dw_6 dw_6
gb_1 gb_1
end type
type tabpage_5 from userobject within tab_1
end type
type dw_8 from dc_uo_dw_base within tabpage_5
end type
type gb_6 from groupbox within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_8 dw_8
gb_6 gb_6
end type
type tabpage_6 from userobject within tab_1
end type
type dw_9 from dc_uo_dw_base within tabpage_6
end type
type gb_8 from groupbox within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_9 dw_9
gb_8 gb_8
end type
type tab_1 from tab within w_ge635_consulta_convenio
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
type st_confirmar from statictext within w_ge635_consulta_convenio
end type
end forward

global type w_ge635_consulta_convenio from dc_w_sheet
integer x = 215
integer y = 220
integer width = 4261
integer height = 2188
string title = "GE635 - Consulta de Conv$$HEX1$$ea00$$ENDHEX$$nios"
boolean resizable = false
boolean ivb_grava_log = true
event ue_addrow ( )
event ue_deleterow ( )
tab_1 tab_1
st_confirmar st_confirmar
end type
global w_ge635_consulta_convenio w_ge635_consulta_convenio

type variables
uo_convenio ivo_convenio

uo_Cidade ivo_Cidade

uo_Filial ivo_Filial

uo_Usuario ivo_Usuario

boolean ivb_Check

boolean ivb_Inclusao = False

end variables

forward prototypes
public subroutine wf_localiza_convenio ()
public subroutine wf_localiza_cidade ()
public subroutine wf_insere_layout_default ()
public subroutine wf_converte_null_para_zero ()
public subroutine wf_localiza_filial ()
public function integer wf_consiste_salva ()
public function boolean wf_convenio_subordinado (long pl_convenio)
public function boolean wf_convenio_controle (long pl_convenio)
public subroutine wf_localiza_usuario ()
public function boolean wf_verifica_cnpj (string ps_cnpj)
public subroutine wf_altera_data_fechamento ()
end prototypes

event ue_addrow();If Tab_1.SelectedTab = 4 Then
	Tab_1.TabPage_4.dw_7.Event ue_AddRow()
ElseIf Tab_1.SelectedTab = 6 Then
	Tab_1.TabPage_6.dw_9.Event ue_AddRow()	
Else
	Tab_1.TabPage_1.dw_1.Event ue_AddRow()
End If
end event

event ue_deleterow();If Tab_1.SelectedTab = 4 Then
	Tab_1.TabPage_4.dw_7.Event ue_DeleteRow()
ElseIf Tab_1.SelectedTab = 6 Then
	Tab_1.TabPage_6.dw_9.Event ue_DeleteRow()
End If
end event

public subroutine wf_localiza_convenio ();String  	lvs_Convenio, &
		lvs_Usuario_Resp

Integer lvi_Retorno_Salva

// Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio deseja salvar as informa$$HEX2$$e700f500$$ENDHEX$$es alteradas
// antes de recuperar a nova linha
lvi_Retorno_Salva = wf_Valida_Salva()

If lvi_Retorno_Salva = 0 Then
	Return
End If

// Verifica o par$$HEX1$$e200$$ENDHEX$$metros digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio
lvs_Convenio = Tab_1.TabPage_1.dw_1.GetText()

ivo_Convenio.of_Localiza_Convenio(lvs_Convenio)

Tab_1.TabPage_1.cb_negociacao.Enabled = False

If ivo_Convenio.Localizado Then	
	Tab_1.TabPage_1.dw_1.Object.cd_convenio[1] = ivo_convenio.cd_convenio
	
	Tab_1.TabPage_1.dw_1.Event ue_Retrieve()
	Tab_1.TabPage_6.dw_9.Event ue_Retrieve()
	
	If IsNull(Tab_1.TabPage_1.dw_1.Object.id_notificacao_cobranca [1]) Then Tab_1.TabPage_1.dw_1.Object.id_notificacao_cobranca [1] = "S"
	
	Tab_1.TabPage_1.cb_negociacao.Enabled 	= false
	ivb_Inclusao											= False
	
	lvs_Usuario_Resp = Tab_1.TabPage_1.dw_1.Object.Nr_Matricula_Responsavel_CIA[1]
	
	If (Not IsNull(lvs_Usuario_Resp )) Then
		ivo_Usuario.of_Localiza_Usuario( lvs_Usuario_Resp )
	
		// Verifica se o Usu$$HEX1$$e100$$ENDHEX$$rio foi localizada e atualiza a DW
		If ivo_Usuario.Localizado Then
			Tab_1.TabPage_1.dw_1.Object.Nr_Matricula_Responsavel_CIA	[1] = ivo_Usuario.Nr_Matricula
			Tab_1.TabPage_1.dw_1.Object.Nm_Usuario_Responsavel			[1] = ivo_Usuario.Nm_Usuario
		End If	
	End If	
End If
end subroutine

public subroutine wf_localiza_cidade ();String lvs_Cidade

// Verifica o par$$HEX1$$e200$$ENDHEX$$metros digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio
lvs_Cidade = Tab_1.TabPage_1.dw_1.GetText()

ivo_Cidade.of_Localiza_Cidade(lvs_Cidade)

If ivo_Cidade.Localizada Then
	Tab_1.TabPage_1.dw_1.Object.Cd_Cidade[1] = ivo_Cidade.Cd_Cidade
	Tab_1.TabPage_1.dw_1.Object.Nm_Cidade[1] = ivo_Cidade.Nm_Cidade
End If
end subroutine

public subroutine wf_insere_layout_default ();
Integer lvi_rc

DataWindowChild lvdwc_LayOut

lvi_rc = Tab_1.TabPage_4.dw_6.GetChild("cd_layout_arquivo", lvdwc_LayOut)

If lvi_rc <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da datawindow child layout arquivo.", Exclamation!)
Else
	lvdwc_LayOut.InsertRow(1)
		
	lvdwc_LayOut.SetItem(1, "cd_layout_arquivo", 0)
	lvdwc_LayOut.SetItem(1, "de_layout_arquivo", "NENHUM")
	
	tab_1.tabpage_4.dw_6.Object.cd_layout_arquivo[1] = 0
End If

lvi_rc = Tab_1.TabPage_4.dw_6.GetChild("cd_layout_relatorio", lvdwc_LayOut)

If lvi_rc <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da datawindow child layout relat$$HEX1$$f300$$ENDHEX$$rio.", Exclamation!)
Else
	lvdwc_LayOut.InsertRow(1)
		
	lvdwc_LayOut.SetItem(1, "cd_layout_relatorio", 0)
	lvdwc_LayOut.SetItem(1, "de_layout_relatorio", "NENHUM")
	
		tab_1.tabpage_4.dw_6.Object.cd_layout_relatorio[1] = 0
End If

Tab_1.TabPage_4.dw_6.Object.Cd_LayOut_Arquivo[1] = 0
Tab_1.TabPage_4.dw_6.Object.Cd_LayOut_Relatorio[1] = 0
end subroutine

public subroutine wf_converte_null_para_zero ();
If IsNull(Tab_1.TabPage_1.dw_1.Object.Cd_LayOut_Arquivo[1]) Then
	Tab_1.TabPage_4.dw_6.Object.Cd_LayOut_Arquivo[1] = 0
End If

If IsNull(Tab_1.TabPage_1.dw_1.Object.Cd_LayOut_Relatorio[1]) Then			
	Tab_1.TabPage_4.dw_6.Object.Cd_LayOut_Relatorio[1] = 0
End If		

end subroutine

public subroutine wf_localiza_filial ();
STRING lvs_Filial

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Filial = Tab_1.TabPage_1.dw_1.GetText()
	
ivo_Filial.of_Localiza_Filial(lvs_Filial)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Filial.Localizada Then
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial_Centralizadora[1] = ivo_Filial.Cd_Filial
  	Tab_1.TabPage_1.dw_1.Object.Filial_nm_fantasia[1]       = ivo_Filial.Nm_Fantasia
End If


end subroutine

public function integer wf_consiste_salva ();
Integer lvi_Retorno, &
        lvi_Retorno_Salva

SetPointer(HourGlass!)

// Verifica se houve altera$$HEX2$$e700e300$$ENDHEX$$o na DW de detalhes
lvi_Retorno_Salva = wf_Valida_Salva()

Choose Case lvi_Retorno_Salva
	Case OK_SEM_PENDENCIAS, &
		  OK_COM_PENDENCIAS, &
		  OK_SUCESSO_UPDATE, &
		  OK_SEM_UPDATE
		  
		// Desabilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
		ivm_Menu.mf_Confirmar(False)
		ivm_Menu.mf_Cancelar(False)		
//		ivm_Menu.m_Editar.m_ConfirmarOperacao.Enabled = False
//		ivm_Menu.m_Editar.m_CancelarOperacao.Enabled = False
		
		// Continua
		lvi_Retorno = 1
	Case CANCELAR_ERRO_PENDENCIAS, &
		  CANCELAR_ERRO_UPDATE

		// Desabilita a fun$$HEX2$$e700e300$$ENDHEX$$o de confirma$$HEX2$$e700e300$$ENDHEX$$o
		ivm_Menu.mf_Confirmar(False)
//		ivm_Menu.mf_Cancelar(False)		
//		ivm_Menu.m_Editar.m_ConfirmarOperacao.Enabled = False

		// N$$HEX1$$e300$$ENDHEX$$o permite
		lvi_Retorno = 0
	Case CANCELAR_UPDATE

		// N$$HEX1$$e300$$ENDHEX$$o permite
		lvi_Retorno = 0
End Choose

Return lvi_Retorno
end function

public function boolean wf_convenio_subordinado (long pl_convenio);
Boolean lvb_Retorno

Long lvl_Convenio_Controle

String lvs_Fantasia_Controle, &
       lvs_Fantasia_Subordinado

Select rcc.cd_convenio_controle,
       ctr.nm_fantasia,
		 sub.nm_fantasia
Into :lvl_Convenio_Controle,
     :lvs_Fantasia_Controle,
	  :lvs_Fantasia_Subordinado
From relacao_controle_convenio rcc,
     convenio sub,
	  convenio ctr
Where ctr.cd_convenio = rcc.cd_convenio_controle
  and sub.cd_convenio = rcc.cd_convenio_subordinado
  and rcc.cd_convenio_subordinado = :pl_Convenio;
  
Choose Case SqlCa.SqlCode
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Procedimento n$$HEX1$$e300$$ENDHEX$$o permitido. O conv$$HEX1$$ea00$$ENDHEX$$nio '" + lvs_Fantasia_Subordinado + " (" + &
		           String(pl_Convenio) + ")' j$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ subordinado ao conv$$HEX1$$ea00$$ENDHEX$$nio '" + &
					  lvs_Fantasia_Controle + " (" + String(lvl_Convenio_Controle) + ")'.", &
					  Exclamation!)
					  
		lvb_Retorno = True
	Case 100
		lvb_Retorno = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio subordinado." + SqlCa.SqlErrText, StopSign!, Ok!)
		lvb_Retorno = True
End Choose

Return lvb_Retorno
end function

public function boolean wf_convenio_controle (long pl_convenio);
Boolean lvb_Retorno

Long lvl_Total

Select count(*)
Into :lvl_Total
From relacao_controle_convenio
Where cd_convenio_controle = :pl_Convenio;
  
Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvl_Total) And lvl_Total > 0 Then			  
			lvb_Retorno = True
		Else
			lvb_Retorno = False
		End If
	Case 100
		lvb_Retorno = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio controle." + SqlCa.SqlErrText, StopSign!, Ok!)
		lvb_Retorno = True
End Choose

Return lvb_Retorno
end function

public subroutine wf_localiza_usuario ();
String lvs_Usuario

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Usuario = Tab_1.TabPage_1.dw_1.GetText()
	
ivo_Usuario.of_Localiza_Usuario(lvs_Usuario)

// Verifica se o Usu$$HEX1$$e100$$ENDHEX$$rio foi localizada e atualiza a DW
If ivo_Usuario.Localizado Then
	Tab_1.TabPage_1.dw_1.Object.Nr_Matricula_Responsavel_Cia[1] 	= ivo_Usuario.Nr_Matricula
  	Tab_1.TabPage_1.dw_1.Object.Nm_Usuario_Responsavel[1]   		= ivo_Usuario.Nm_Usuario
End If

end subroutine

public function boolean wf_verifica_cnpj (string ps_cnpj);Integer lvi_Cont

Select count(1)
Into :lvi_Cont
From convenio
where nr_cgc = :ps_cnpj
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio com o CNPJ:[" + ps_cnpj + "]", StopSign!)
	Return False
End If

If lvi_Cont >= 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","CNPJ j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado na base. Gentileza verificar.", Information!)
	Return False
End If

Return True
	
end function

public subroutine wf_altera_data_fechamento ();Long lvl_Linha
Long lvl_Dia_Base

Datetime lvdh_Fechamento
Datetime lvdh_Movimento
Datetime lvdh_Aux

lvdh_Movimento = gf_getserverdate()

Tab_1.Tabpage_1.Dw_1.Accepttext( )
lvl_Dia_Base = Tab_1.Tabpage_1.Dw_1.Object.nr_dia_base [1]

For lvl_Linha = 1 To Tab_1.tabpage_6.dw_9.RowCount()
	lvdh_Fechamento= Tab_1.tabpage_6.dw_9.Object.dh_fechamento [lvl_Linha]
	
	If lvdh_Fechamento >= lvdh_Movimento Then
		lvdh_Aux = Datetime(gf_retorna_ultimo_dia_mes(Date(String(lvdh_Fechamento,'YYYY/MM')+'/01')))
		
		If lvl_Dia_Base > Day(Date(lvdh_Aux)) Then
			lvdh_Fechamento = lvdh_Aux
		Else
			lvdh_Fechamento = Datetime(String(lvdh_Fechamento,'YYYY/MM')+'/'+String(lvl_Dia_Base,"00"))
		End If
		
		Tab_1.tabpage_6.dw_9.Object.dh_fechamento [lvl_Linha] = lvdh_Fechamento
	End If 	
Next
end subroutine

event ue_cancel;call super::ue_cancel;Tab_1.TabPage_1.dw_1.Event ue_Cancel()
Tab_1.TabPage_2.dw_3.Event ue_Cancel()
Tab_1.TabPage_3.dw_5.Event ue_Cancel()
//Tab_1.TabPage_4.dw_6.Event ue_Cancel()
Tab_1.TabPage_4.dw_7.Event ue_Cancel()
Tab_1.TabPage_5.dw_8.Event ue_Cancel()
end event

event close;call super::close;Destroy(ivo_Convenio)
Destroy(ivo_Cidade)
Destroy(ivo_Filial)
Destroy(ivo_Usuario)
end event

on w_ge635_consulta_convenio.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_confirmar
end on

on w_ge635_consulta_convenio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.st_confirmar)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]

Tab_1.TabPage_1.dw_1.ShareData(Tab_1.TabPage_4.dw_6)

Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_5.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_6.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_7.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_5.dw_8.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_6.dw_9.of_SetMenu(This.ivm_Menu)

// Cria o objeto de localiza$$HEX2$$e700e300$$ENDHEX$$o de conv$$HEX1$$ea00$$ENDHEX$$nios
ivo_Convenio = Create uo_Convenio

// Cria o objeto de localiza$$HEX2$$e700e300$$ENDHEX$$o de cidades
ivo_Cidade = Create uo_Cidade

// Cria o objeto de localiza$$HEX2$$e700e300$$ENDHEX$$o de filial
ivo_Filial = Create uo_Filial

ivo_Usuario = Create uo_Usuario

// Insere uma linha na DW principal
Tab_1.TabPage_1.dw_1.Event ue_AddRow()

wf_Insere_LayOut_Default()

// Recupera as linhas das DWs de filial e condi$$HEX2$$e700e300$$ENDHEX$$o de venda
//Tab_1.TabPage_2.dw_2.Event pfc_Retrieve()
Tab_1.TabPage_3.dw_4.Event ue_Retrieve()

// Habilita o menu de inclus$$HEX1$$e300$$ENDHEX$$o
//ivm_Menu.mf_Incluir(True)

Tab_1.TabPage_1.dw_1.SetFocus()

//Habilita Grava$$HEX2$$e700e300$$ENDHEX$$o de Log de Altera$$HEX2$$e700e300$$ENDHEX$$o
ivb_grava_log = True
end event

event ue_save;call super::ue_save;If AncestorReturnValue > 0 Then
	If Tab_1.TabPage_5.dw_8.GetRow() = 0 Then
		Tab_1.TabPage_5.dw_8.Event ue_AddRow()
	End If
	
	Tab_1.TabPage_2.dw_2. Event ue_Retrieve()
	Tab_1.TabPage_6.dw_9. Event ue_Retrieve()
End If

If AncestorReturnValue = 1 Then
	wf_Converte_Null_Para_Zero()	
//	ib_DisableCloseQuery = True
End If

Return AncestorReturnValue
end event

event ue_presave;call super::ue_presave;String 	lvs_Nm_Razao_Social, &
			lvs_Nm_Fantasia, &
			lvs_Nr_CNPJ, &
			lvs_Nr_Insc_Estadual, &
			lvs_De_Endereco, &
			lvs_De_Bairro, &
			lvs_Nr_CEP, &
			lvs_Id_Produtor_Rural, &
			lvs_Nr_CPF, &
			lvs_Nr_Endereco, &
			lvs_Nulo, &
			lvs_Email, &
			lvs_Id_Email_Cobr
			
Long	lvl_Cd_Cidade, &
		lvl_Cd_Filial_Centralizadora, &
		lvl_Cd_Portador		, &
		lvl_Linha		
		
Integer	lvi_Nr_Dia_Base		

SetNull(lvs_Nulo)

Tab_1.TabPage_1.dw_1.AcceptText()

lvs_Nm_Razao_Social 		= Tab_1.TabPage_1.dw_1.Object.Nm_Razao_Social			[1]
lvs_Nm_Fantasia				= Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia				[1]
lvs_Nr_CNPJ						= Trim(Tab_1.TabPage_1.dw_1.Object.Nr_CGC				[1])
lvs_Nr_CPF						= Trim(Tab_1.TabPage_1.dw_1.Object.Nr_CPF				[1])
lvs_Nr_Insc_Estadual			= Tab_1.TabPage_1.dw_1.Object.Nr_Inscricao_Estadual		[1]
lvs_De_Endereco				= Tab_1.TabPage_1.dw_1.Object.De_Endereco				[1]
lvs_De_Bairro					= Tab_1.TabPage_1.dw_1.Object.De_Bairro					[1]
lvl_Cd_Cidade					= Tab_1.TabPage_1.dw_1.Object.Cd_Cidade					[1]
lvl_Cd_Filial_Centralizadora	= Tab_1.TabPage_1.dw_1.Object.Cd_Filial_Centralizadora	[1]
lvs_Nr_CEP						= Tab_1.TabPage_1.dw_1.Object.Nr_CEP						[1]
lvl_Cd_Portador				= Tab_1.TabPage_1.dw_1.Object.Cd_Portador					[1]
lvs_Id_Produtor_Rural		= Tab_1.TabPage_1.dw_1.Object.Id_Produtor_Rural			[1]
lvi_Nr_Dia_Base 				= Tab_1.TabPage_1.dw_1.Object.nr_dia_base					[1]
lvs_Nr_Endereco				= Tab_1.TabPage_1.dw_1.Object.nr_endereco					[1]
lvs_Email							= Tab_1.TabPage_1.dw_1.Object.de_endereco_email		[1]
lvs_Id_Email_Cobr				= Tab_1.TabPage_1.dw_1.Object.id_notificacao_cobranca	[1]

If IsNull(lvs_Id_Produtor_Rural) Then lvs_Id_Produtor_Rural = "N"

If lvs_Id_Produtor_Rural = "N" Then
	If (IsNull(lvs_Nr_CNPJ) or Trim(lvs_Nr_CNPJ) = "")  Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar o CNPJ  do Conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nr_cgc")
		Return False
	End If
	
	If Not gf_CGC_Valido(lvs_Nr_CNPJ) Then 
		Tab_1.TabPage_1.dw_1.Object.nr_CGC[1] = ''
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nr_cgc")
		Return False 
	End If
	
	Tab_1.TabPage_1.dw_1.Object.Nr_CPF[1] = lvs_Nulo
Else 
	If (IsNull(lvs_Nr_CNPJ) or Trim(lvs_Nr_CNPJ) = "") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar o CEI do Produtor Rural!", Exclamation!)
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nr_cgc")
		Return False
	End If

	If (IsNull(lvs_Nr_CPF) or Trim(lvs_Nr_CPF) = "") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar o CPF do Produtor Rural!", Exclamation!)
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nr_cpf")
		Return False
	End If
End If

If IsNull(lvs_Nm_Fantasia) or Trim(lvs_Nm_Fantasia) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar o Nome Fantasia do Conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nm_fantasia")
	Return False
End If

If IsNull(lvs_Nm_Razao_Social) or Trim(lvs_Nm_Razao_Social) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar a Raz$$HEX1$$e300$$ENDHEX$$o Social do Conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nm_razao_social")
	Return False
End If

If IsNull(lvs_Nr_Insc_Estadual) or Trim(lvs_Nr_Insc_Estadual) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar a Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual do conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nr_inscricao_estadual")
	Return False
End If

If IsNull(lvs_De_Endereco) or Trim(lvs_De_Endereco) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar o Endere$$HEX1$$e700$$ENDHEX$$o do Conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_endereco")
	Return False
End If

If IsNull(lvs_Nr_Endereco) or Trim(lvs_Nr_Endereco) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar o n$$HEX1$$fa00$$ENDHEX$$mero do endere$$HEX1$$e700$$ENDHEX$$o do Conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nr_endereco")
	Return False
End If

If IsNull(lvs_De_Bairro) or Trim(lvs_De_Bairro) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar o Bairro do Conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_bairro")
	Return False
End If

If IsNull(lvl_Cd_Cidade) or lvl_Cd_Cidade = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar a Cidade do Conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nm_cidade")
	Return False
End If

If IsNull(lvs_Nr_CEP) or Trim(lvs_Nr_CEP) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar o CEP do Conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nr_cep")
	Return False
End If

If IsNull(lvl_Cd_Filial_Centralizadora) or lvl_Cd_Filial_Centralizadora = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar a Filial Centralizadora do Conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "filial_nm_fantasia")
	Return False
End If

If IsNull(lvl_Cd_Portador) or lvl_Cd_Portador = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar o Portador do T$$HEX1$$ed00$$ENDHEX$$tulo do Conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "cd_portador")
	Return False
End If

If IsNull(lvi_Nr_Dia_Base) or lvi_Nr_Dia_Base = 0 or lvi_Nr_Dia_Base > 31 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Gentileza informar o dia base de fechamento do conv$$HEX1$$ea00$$ENDHEX$$nio!", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nr_dia_base")
	Return False
End If

If lvi_Nr_Dia_Base > 31 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","O Dia Base n$$HEX1$$e300$$ENDHEX$$o pode ser maior que 31.", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nr_dia_base")
	Return False
End If

If lvs_Id_Email_Cobr = "S" Then
	If (Pos(lvs_Email, ",") > 0) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O endere$$HEX1$$e700$$ENDHEX$$o de email n$$HEX1$$e300$$ENDHEX$$o pode conter v$$HEX1$$ed00$$ENDHEX$$rgulas.",Exclamation!)
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_endereco_email")
		Return False
	End If
	
	If (Pos(lvs_Email, "(") > 0)or(Pos(lvs_Email, ")") > 0) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O endere$$HEX1$$e700$$ENDHEX$$o de email n$$HEX1$$e300$$ENDHEX$$o pode conter par$$HEX1$$ea00$$ENDHEX$$nteses.",Exclamation!)
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_endereco_email")
		Return False
	End If
	
	If (Not (Pos(lvs_Email, ".") > 0))or(Not (Pos(lvs_Email, "@") > 0)) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O endere$$HEX1$$e700$$ENDHEX$$o de email inv$$HEX1$$e100$$ENDHEX$$lido.~r~n"+ &
		 				"Favor informar um email v$$HEX1$$e100$$ENDHEX$$lido ou desmarcar o envio de email de vencimento de t$$HEX1$$ed00$$ENDHEX$$tulo.",Exclamation!)
		Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_endereco_email")
		Return False		
	End If
End If

Tab_1.TabPage_1.dw_1.Object.de_endereco_email [1] = Trim(lvs_Email)

Tab_1.TabPage_6.dw_9.AcceptText()

If lvi_Nr_Dia_Base <> 0 and ivb_Inclusao Then
	
	Long lvl_Find
	
	lvl_Find = Tab_1.TabPage_6.dw_9.Find("isNull(dh_fechamento)", 1, Tab_1.TabPage_6.dw_9.RowCount())
	Do While lvl_Find > 0
		Tab_1.TabPage_6.dw_9.DeleteRow(lvl_Find)
		lvl_Find = Tab_1.TabPage_6.dw_9.Find("isNull(dh_fechamento)", 1, Tab_1.TabPage_6.dw_9.RowCount())
	Loop
		
	If Tab_1.TabPage_6.dw_9.RowCount() = 0 Then
		
		Long 	lvl_Cont
				
		Date 	lvdt_Atual, &
				lvdt_Vencimento, &
				lvdt_Ult_Dia
		
		lvdt_Atual = Date(gf_GetServerDate())
		
		For lvl_Cont = -1 To 4
			
			lvl_Linha = Tab_1.TabPage_6.dw_9.Event ue_AddRow()
			
			If gf_DateAdd(lvdt_Atual, 'month', lvl_Cont, ref lvdt_Vencimento) Then			
				lvdt_Ult_Dia = gf_retorna_ultimo_dia_mes(DateTime( String(Year(lvdt_Vencimento)) + "/" + String(Month(lvdt_Vencimento))+"/01"))
				
				Tab_1.TabPage_6.dw_9.Object.Cd_Convenio		[lvl_Linha] = Tab_1.TabPage_1.dw_1.Object.Cd_Convenio[1]
				Tab_1.TabPage_6.dw_9.Object.Dh_Fechamento	[lvl_Linha] = DateTime( String(Year(lvdt_Vencimento)) + "/" + String(Month(lvdt_Vencimento)) + "/" + String(IIF(Day(lvdt_Ult_Dia)>lvi_Nr_Dia_Base,lvi_Nr_Dia_Base,Day(lvdt_Ult_Dia))))			
			End If						
		Next	
	End If	
End If

Return True
end event

event open;call super::open;st_confirmar.Visible = False
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge635_consulta_convenio
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge635_consulta_convenio
end type

type tab_1 from tab within w_ge635_consulta_convenio
event create ( )
event destroy ( )
integer y = 8
integer width = 4233
integer height = 2000
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean multiline = true
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event selectionchanging;If newindex <> 1 Then

	String lvs_nm_fantasia

	lvs_nm_fantasia = tab_1.tabpage_1.dw_1.Object.nm_fantasia[1]

	If lvs_nm_fantasia = '' or IsNull(lvs_nm_fantasia) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Informe o conv$$HEX1$$ea00$$ENDHEX$$nio.", Exclamation!,Ok!)
		Return 1
	End If
End If

end event

event selectionchanged;SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
//		This.Width = 1985
//		This.Height = 2050	
		
		This.Width = 3575
		This.Height = 2000	
		
		ivm_Menu.m_Editar.m_Excluir.Enabled = False
	Case 2
		This.Width = 3575
		This.Height = 2000	
		
		ivm_Menu.m_Editar.m_Incluir.Enabled = False		
		ivm_Menu.m_Editar.m_Excluir.Enabled = False
		Tab_1.TabPage_2.dw_2.Event  ue_Retrieve()
	Case 3
//		This.Width =  3625  //3322 // 68 //2656
		//This.Width =  3918  //3322 // 68 //2656
		This.Width =  4251
		This.Height = 1719
		
		ivm_Menu.m_Editar.m_Excluir.Enabled = False		
	Case 4
		This.Width  = 2820
		This.Height = 1610
		
		ivm_Menu.m_Editar.m_Incluir.Enabled = True
		ivm_Menu.m_Editar.m_Excluir.Enabled = True
		
	Case 5
		This.Width  = 2629
		This.Height = 1080		
		
		ivm_Menu.m_Editar.m_Incluir.Enabled = False					
		ivm_Menu.m_Editar.m_Excluir.Enabled = False
		
		Tab_1.TabPage_5.dw_8.Event  ue_Retrieve()
		
	Case 6
		This.Width  = 2629
		This.Height = 1080		
		
		ivm_Menu.m_Editar.m_Incluir.Enabled = True					
		ivm_Menu.m_Editar.m_Excluir.Enabled = True
		
End Choose

Parent.Width = This.Width + 60
Parent.Height = This.Height + 135
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4197
integer height = 1884
long backcolor = 79741120
string text = "Principal"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_negociacao cb_negociacao
dw_1 dw_1
end type

on tabpage_1.create
this.cb_negociacao=create cb_negociacao
this.dw_1=create dw_1
this.Control[]={this.cb_negociacao,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.cb_negociacao)
destroy(this.dw_1)
end on

type cb_negociacao from commandbutton within tabpage_1
integer x = 3122
integer y = 20
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Negocia$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;OpenSheetWithParm(w_cr173_negociacao_convenio, String(ivo_convenio.Cd_Convenio), dc_w_mdi)
end event

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 9
integer y = 24
integer width = 3543
integer height = 1864
integer taborder = 50
string dataobject = "dw_ge635_detalhe_cadastro_convenio"
end type

event constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"nm_fantasia_localizacao"}
This.of_SetColSelection(True)
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then 	
	Tab_1.TabPage_1.dw_1.Object.Dh_Alteracao[1]           		= DateTime(gvo_Parametro.of_Dh_Movimentacao())
	Tab_1.TabPage_1.dw_1.Object.Nr_Matricula_Alteracao[1] 	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

	Tab_1.TabPage_1.dw_1.Object.Dh_Atualizacao[1]        			= DateTime(gvo_Parametro.of_Dh_Movimentacao())
	Tab_1.TabPage_1.dw_1.Object.Nr_Matricula_Atualizacao[1] 	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

	Tab_1.TabPage_4.dw_6.Object.Cd_LayOut_Arquivo[1]      	= 0
	Tab_1.TabPage_4.dw_6.Object.Cd_LayOut_Relatorio[1]    	= 0	

	// Restaura os valores do objeto de localiza$$HEX2$$e700e300$$ENDHEX$$o de cidades
	SetNull(ivo_Cidade.Cd_Cidade)
	ivo_Cidade.Nm_Cidade = ""
	
	// Restaura os valores do objeto de localiza$$HEX2$$e700e300$$ENDHEX$$o de filiais
	SetNull(ivo_Filial.Cd_Filial)
	ivo_Filial.Nm_Fantasia = ""	
	
	// Seleciona o folder 1 para o preenchimento do cadastro do conv$$HEX1$$ea00$$ENDHEX$$nio
	Tab_1.SelectTab(1)

	// Limpa as DWs de filiais e condi$$HEX2$$e700f500$$ENDHEX$$es de venda selecionadas
	Tab_1.TabPage_2.dw_3.Reset()
	Tab_1.TabPage_3.dw_5.Reset()
	Tab_1.TabPage_4.dw_7.Reset()	
	
	// Determina o tipo de a$$HEX2$$e700e300$$ENDHEX$$o de cancelamento
	ivi_Tipo_Cancelar = ADDROW
	ivb_Inclusao			= True
	
	This.SetFocus()
End If

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()

	Choose Case lvs_Coluna
		Case "nm_fantasia_localizacao"
			wf_Localiza_Convenio()
		Case "nm_cidade"
			wf_Localiza_Cidade()
		Case "filial_nm_fantasia"
			Wf_Localiza_Filial()
		Case "nm_usuario_responsavel"
			wf_Localiza_Usuario()
	End Choose
End If

end event

event ue_recuperar;//OverRide
Long lvl_Convenio

Integer lvi_Linhas

String lvs_Id_Produtor_Rural

SetPointer(HourGlass!)

lvl_convenio = This.Object.cd_convenio[1]

lvi_Linhas = This.Retrieve(lvl_Convenio)

ivm_Menu.m_Editar.m_C.Enabled			= False
ivm_Menu.m_Editar.m_Colar.Enabled 		= False

If lvi_Linhas = 1 Then
	// Atualiza o objeto de localiza$$HEX2$$e700e300$$ENDHEX$$o de cidades conforme a linha recuperada
	ivo_Cidade.Nm_Cidade = This.Object.Nm_Cidade[1]
	
	//Atualiza o object de localiza$$HEX2$$e700e300$$ENDHEX$$o de filial conforme a linha recuperada
	ivo_Filial.Nm_Fantasia = This.Object.filial_nm_fantasia[1]
	
	// Recupera as DWs de filiais e condi$$HEX2$$e700f500$$ENDHEX$$es de venda selecionadas para o conv$$HEX1$$ea00$$ENDHEX$$nio
	Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
	Tab_1.TabPage_3.dw_5.Event ue_Retrieve()
	Tab_1.TabPage_4.dw_7.Event ue_Retrieve()
	
	wf_Converte_Null_Para_Zero()
	
//	ib_DisableCloseQuery = True
	
	ivm_Menu.m_Editar.m_C.Enabled			= True
	ivm_Menu.m_Editar.m_Colar.Enabled		= True
	
	lvs_Id_Produtor_Rural = Tab_1.TabPage_1.dw_1.Object.Id_Produtor_Rural[1]
	
	If lvs_Id_Produtor_Rural = "S" Then
		This.Modify("nr_cgc"+".Format='@@.@@@.@@@@@/@@'")		
	Else
		This.Modify("nr_cgc"+".Format='@@.@@@.@@@/@@@@-@@'")
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Conv$$HEX1$$ea00$$ENDHEX$$nio " + String(lvl_Convenio) + " n$$HEX1$$e300$$ENDHEX$$o cadastrado.", Exclamation!, Ok! )
End If

// Determina o tipo de a$$HEX2$$e700e300$$ENDHEX$$o de cancelamento
ivi_Tipo_Cancelar = RETRIEVE
	
SetPointer(Arrow!)

Return lvi_Linhas
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
event ue_mouse_move pbm_mousemove
integer x = 18
integer y = 100
integer width = 4197
integer height = 1884
long backcolor = 79741120
string text = "Filiais"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_3 dw_3
dw_2 dw_2
pb_2 pb_2
lb_uf lb_uf
pb_1 pb_1
sle_desc_filial sle_desc_filial
st_1 st_1
st_2 st_2
lb_rede lb_rede
st_3 st_3
gb_3 gb_3
gb_4 gb_4
gb_7 gb_7
end type

on tabpage_2.create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.pb_2=create pb_2
this.lb_uf=create lb_uf
this.pb_1=create pb_1
this.sle_desc_filial=create sle_desc_filial
this.st_1=create st_1
this.st_2=create st_2
this.lb_rede=create lb_rede
this.st_3=create st_3
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_7=create gb_7
this.Control[]={this.dw_3,&
this.dw_2,&
this.pb_2,&
this.lb_uf,&
this.pb_1,&
this.sle_desc_filial,&
this.st_1,&
this.st_2,&
this.lb_rede,&
this.st_3,&
this.gb_3,&
this.gb_4,&
this.gb_7}
end on

on tabpage_2.destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.pb_2)
destroy(this.lb_uf)
destroy(this.pb_1)
destroy(this.sle_desc_filial)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.lb_rede)
destroy(this.st_3)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_7)
end on

type dw_3 from dc_uo_dw_base within tabpage_2
event ue_mouse_move pbm_mousemove
integer x = 1797
integer y = 92
integer width = 1705
integer height = 1756
integer taborder = 20
string dataobject = "dw_ge635_lista_filial_convenio_selecionada"
boolean vscrollbar = true
end type

event ue_mouse_move;If This.RowCount() > 0 Then
//	If xpos >= st_confirmar.X and (xpos <= st_confirmar.x + st_confirmar.Width) and &	
	If (xpos <= st_confirmar.x + st_confirmar.Width) and &
		  ypos >= 0 and ypos < 40 Then	 
		
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

event constructor;call super::constructor;This.of_SetRowSelection()
//ib_IsUpdateAble = True

ivi_Tipo_Cancelar = RETRIEVE
end event

event ue_recuperar;//OverRide
Long lvl_Convenio

Integer lvi_Linhas

lvl_Convenio = Tab_1.TabPage_1.dw_1.Object.Cd_Convenio[1]

If Not IsNull(lvl_Convenio) and lvl_Convenio > 0 Then
	lvi_Linhas = This.Retrieve(lvl_Convenio)
Else
	This.Reset()
End If

//uo_Barra_Selecao.of_Habilita()

Return lvi_Linhas
end event

event doubleclicked;call super::doubleclicked;If dwo.Name = 'st_cadastra' Then
	
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
		This.Object.Id_Permite_Cadastramento[lvl_Row] = lvs_Marcacao		
	Next
	
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
	ivb_valida_salva = True
End If
end event

type dw_2 from dc_uo_dw_base within tabpage_2
integer x = 64
integer y = 536
integer width = 1527
integer height = 1320
integer taborder = 20
string dataobject = "dw_ge635_lista_filial_convenio"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
//ib_IsUpdateAble = False
end event

event rowfocuschanged;call super::rowfocuschanged;Long lvl_Filial

If This.RowCount() > 0 Then
	lvl_Filial = This.Object.Cd_Filial[CurrentRow]

//	uo_Barra_Selecao.ivs_Find = "cd_filial = " + String(lvl_Filial)
End If
end event

event ue_recuperar;//OverRide
Integer lvi_Linhas, &
		lvi_Row, &
		lvi_Total

Long	lvl_Convenio

Tab_1.TabPage_1.dw_1.AcceptText()

lvl_Convenio = ivo_Convenio.Cd_Convenio//Tab_1.TabPage_1.dw_1.Object.Cd_Convenio[1]
lvi_Linhas = This.Retrieve(lvl_Convenio)

//uo_Barra_Selecao.of_Habilita()

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
lvds_1.of_ChangeDataObject("dw_lista_filial_convenio_uf")

lvi_Total = lvds_1.Retrieve(lvl_Convenio)

lb_UF.Reset()

If lvi_Total > 0 Then
	For lvi_Row = 1 to lvi_Total
		lb_UF.AddItem(lvds_1.Object.UF[lvi_Row])
	Next
End If

Destroy lvds_1

dc_uo_ds_Base lvds_2
lvds_2 = Create dc_uo_ds_Base
lvds_2.of_ChangeDataObject("dw_lista_filial_rede")

lvi_Total = lvds_2.Retrieve(lvl_Convenio)

lb_Rede.Reset()

If lvi_Total > 0 Then
	For lvi_Row = 1 to lvi_Total
		lb_Rede.AddItem(lvds_2.Object.Id_Rede[lvi_Row])
	Next
End If

Destroy lvds_2

Return lvi_Linhas
end event

type pb_2 from picturebutton within tabpage_2
integer x = 1495
integer y = 348
integer width = 110
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "Layer!"
alignment htextalign = left!
string powertiptext = "Limpar o Filtro"
end type

event clicked;sle_desc_filial.Text = ""
Tab_1.TabPage_2.dw_2.SetFilter("")
Tab_1.TabPage_2.dw_2.Filter()	

Tab_1.TabPage_2.dw_2.Sort()

//uo_barra_selecao.of_Habilita()
end event

type lb_uf from listbox within tabpage_2
integer x = 64
integer y = 112
integer width = 352
integer height = 332
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean vscrollbar = true
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within tabpage_2
integer x = 1385
integer y = 348
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "Horizontal!"
alignment htextalign = left!
string powertiptext = "Filtrar os Dados"
end type

event clicked;Integer lvi_Total

Long lvl_Item

String 	lvs_Selecao = "", &
		lvs_Filtro_Desc = "", &
		lvs_Rede = "", &
		lvs_Filtrar

Boolean lvb_Selecionado =  False

Tab_1.TabPage_2.dw_2.SetFilter("")
Tab_1.TabPage_2.dw_2.Filter()	

lvi_Total = lb_UF.TotalItems()

//Loop UF
For lvl_Item = 1 to lvi_Total
	If lb_UF.State(lvl_Item) = 1 Then
		lvs_selecao += "'" + lb_UF.Text(lvl_Item) + "'" + ","
		lvb_Selecionado = True
	End If
Next

If lvb_Selecionado Then
	lvs_Selecao 	= MidA(lvs_Selecao, 1, Len(lvs_Selecao) - 1)
	lvs_Filtrar 		= "UF  in (" + lvs_Selecao + " ) and " 
End If

lvi_Total = lb_Rede.TotalItems()

lvb_Selecionado = False

//Loop Rede
For lvl_Item = 1 to lvi_Total
	If lb_Rede.State(lvl_Item) = 1 Then
		lvs_Rede += "'" + lb_Rede.Text(lvl_Item) + "'" + ","
		lvb_Selecionado = True
	End If
Next

If lvb_Selecionado Then
	lvs_Rede 	= MidA(lvs_Rede, 1, Len(lvs_Rede) - 1)
	lvs_Filtrar += "id_rede  in (" + lvs_Rede + " ) and "
End If

If sle_desc_filial.Text <> '' Then
	lvs_Filtro_Desc = sle_desc_filial.Text
	lvs_Filtrar 		+= "nm_fantasia like '%" +  lvs_Filtro_Desc + "%' and "
End If

lvs_Filtrar = MidA(lvs_Filtrar, 1, Len(lvs_Filtrar) - 4)

Tab_1.TabPage_2.dw_2.SetFilter(lvs_Filtrar)	
Tab_1.TabPage_2.dw_2.Filter()

//uo_barra_selecao.of_Habilita()
end event

type sle_desc_filial from singlelineedit within tabpage_2
integer x = 850
integer y = 112
integer width = 750
integer height = 80
integer taborder = 41
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
textcase textcase = upper!
end type

event getfocus;This.SelectedText()
end event

type st_1 from statictext within tabpage_2
integer x = 850
integer y = 60
integer width = 759
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filtre pelo nome da Filial"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_2
integer x = 78
integer y = 52
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "UF"
boolean focusrectangle = false
end type

type lb_rede from listbox within tabpage_2
integer x = 457
integer y = 112
integer width = 352
integer height = 332
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean vscrollbar = true
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_2
integer x = 466
integer y = 52
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Rede"
boolean focusrectangle = false
end type

type gb_3 from groupbox within tabpage_2
integer x = 32
integer y = 480
integer width = 1591
integer height = 1392
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filiais Cadastradas e n$$HEX1$$e300$$ENDHEX$$o liberadas"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_2
integer x = 1765
integer width = 1765
integer height = 1872
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filiais Selecionadas"
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within tabpage_2
integer x = 32
integer width = 1591
integer height = 464
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filtros"
end type

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4197
integer height = 1884
long backcolor = 79741120
string text = "Condi$$HEX2$$e700f500$$ENDHEX$$es"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_5 dw_5
dw_4 dw_4
gb_5 gb_5
gb_2 gb_2
end type

on tabpage_3.create
this.dw_5=create dw_5
this.dw_4=create dw_4
this.gb_5=create gb_5
this.gb_2=create gb_2
this.Control[]={this.dw_5,&
this.dw_4,&
this.gb_5,&
this.gb_2}
end on

on tabpage_3.destroy
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.gb_5)
destroy(this.gb_2)
end on

type dw_5 from dc_uo_dw_base within tabpage_3
integer x = 50
integer y = 744
integer width = 4119
integer height = 808
integer taborder = 20
string dataobject = "dw_ge635_lista_condicao_convenio_selecionada"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

ivi_Tipo_Cancelar = RETRIEVE
end event

event getfocus;call super::getfocus;string ls_codigo
string ls_descricao

If This.RowCount() > 0 Then
	ls_codigo    = String(This.object.cd_condicao_convenio[getrow()])
	ls_descricao = This.object.de_condicao_convenio[getrow()]
	
	This.object.st_condicao_convenio.text = ls_descricao + ' (' + ls_codigo + ')'
End If
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_codigo
string ls_descricao

If currentrow > 0 Then
	
	ls_codigo    = String(This.object.cd_condicao_convenio[currentrow])
   ls_descricao = This.object.de_condicao_convenio[currentrow]

	This.object.st_condicao_convenio.text = ls_descricao + ' (' + ls_codigo + ')'

End If																	 
end event

event ue_recuperar;//OverRide
Long lvl_Convenio

Integer lvi_Linhas

lvl_Convenio = Tab_1.TabPage_1.dw_1.Object.Cd_Convenio[1]

If Not IsNull(lvl_Convenio) and lvl_Convenio > 0 Then
	lvi_Linhas = This.Retrieve(lvl_Convenio)
Else
	This.Reset()
End If

//uo_Barra_Selecao_Condicao.of_Habilita()

Return lvi_Linhas
end event

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 59
integer y = 76
integer width = 1536
integer height = 572
integer taborder = 20
string dataobject = "dw_ge635_lista_condicao_convenio"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
//ib_IsUpdateAble = False
end event

event rowfocuschanged;call super::rowfocuschanged;Long lvl_Condicao

If Not IsNull(CurrentRow ) and CurrentRow > 0 Then
   lvl_Condicao = This.Object.Cd_Condicao_Convenio[CurrentRow]
End If

end event

event ue_recuperar;//OverRide
Integer lvi_Linhas

lvi_Linhas = This.Retrieve()


Return lvi_Linhas
end event

type gb_5 from groupbox within tabpage_3
integer x = 23
integer y = 684
integer width = 4160
integer height = 888
integer taborder = 31
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Condi$$HEX2$$e700f500$$ENDHEX$$es Selecionadas"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within tabpage_3
integer x = 32
integer y = 20
integer width = 1591
integer height = 652
integer taborder = 31
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Condi$$HEX2$$e700f500$$ENDHEX$$es Dispon$$HEX1$$ed00$$ENDHEX$$veis"
borderstyle borderstyle = styleraised!
end type

type tabpage_4 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4197
integer height = 1884
long backcolor = 79741120
string text = "Par$$HEX1$$e200$$ENDHEX$$metros"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
pb_3 pb_3
dw_7 dw_7
dw_6 dw_6
gb_1 gb_1
end type

on tabpage_4.create
this.pb_3=create pb_3
this.dw_7=create dw_7
this.dw_6=create dw_6
this.gb_1=create gb_1
this.Control[]={this.pb_3,&
this.dw_7,&
this.dw_6,&
this.gb_1}
end on

on tabpage_4.destroy
destroy(this.pb_3)
destroy(this.dw_7)
destroy(this.dw_6)
destroy(this.gb_1)
end on

type pb_3 from picturebutton within tabpage_4
integer x = 1696
integer y = 64
integer width = 96
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "Find!"
alignment htextalign = left!
string powertiptext = "Consultar layouts de conv$$HEX1$$ea00$$ENDHEX$$nios (Padr$$HEX1$$e300$$ENDHEX$$o)"
end type

event clicked;String lvs_Move

lvs_Move = "1815|680"
OpenWithParm(w_cr244_consulta_layout_arq_convenios,lvs_Move)
end event

type dw_7 from dc_uo_dw_base within tabpage_4
integer x = 59
integer y = 328
integer width = 2674
integer height = 1112
integer taborder = 20
string dataobject = "dw_ge635_relacao_controle_convenio"
end type

event constructor;call super::constructor;This.of_SetRowSelection()
ivi_Tipo_Cancelar = RETRIEVE
end event

event losefocus;call super::losefocus;Integer lvi_Linha

lvi_Linha = This.GetRow()

If lvi_Linha > 0 Then
	This.Object.Nm_Fantasia_Localizacao[lvi_Linha] = This.Object.Nm_Fantasia[lvi_Linha]
End If
end event

event ue_key;call super::ue_key;uo_Convenio lvo_Convenio

String lvs_Coluna, &
       lvs_Convenio

Integer lvi_Linha

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "nm_fantasia_localizacao" Then				
		lvs_Convenio = This.GetText()
		
		lvo_Convenio = Create uo_Convenio
		
		lvo_Convenio.of_Localiza_Convenio(lvs_Convenio)
		
		If lvo_Convenio.Localizado Then
			If Not wf_Convenio_Controle(lvo_Convenio.Cd_Convenio) Then
				If Not wf_Convenio_Subordinado(lvo_Convenio.Cd_Convenio) Then
					lvi_Linha = This.GetRow()
					
					This.Object.Cd_Convenio_Subordinado[lvi_Linha]  = lvo_Convenio.Cd_Convenio
					This.Object.Nm_Fantasia[lvi_Linha]              = lvo_Convenio.Nm_Fantasia
					This.Object.Nm_Fantasia_Localizacao[lvi_Linha]  = lvo_Convenio.Nm_Fantasia			
					
					This.AcceptText()
				End If
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Procedimento n$$HEX1$$e300$$ENDHEX$$o permitido. O conv$$HEX1$$ea00$$ENDHEX$$nio '" + lvo_Convenio.Nm_Fantasia + " (" + &
		                 String(lvo_Convenio.Cd_Convenio) + ")' possui conv$$HEX1$$ea00$$ENDHEX$$nios subordinados.", &
					        Exclamation!)				
			End If
		End If
		
		Destroy(lvo_Convenio)		
	End If
End If
end event

event ue_recuperar;//OverRide
Long lvl_Convenio

Integer lvi_Linhas, &
        lvi_Linha

lvl_Convenio = Tab_1.TabPage_1.dw_1.Object.Cd_Convenio[1]

If Not IsNull(lvl_Convenio) and lvl_Convenio > 0 Then
	lvi_Linhas = This.Retrieve(lvl_Convenio)
	
	For lvi_Linha = 1 To lvi_Linhas
		This.Object.Nm_Fantasia_Localizacao[lvi_Linha] = This.Object.Nm_Fantasia[lvi_Linha]
	Next
Else
	This.Reset()
End If

Return lvi_Linhas
end event

type dw_6 from dc_uo_dw_base within tabpage_4
integer x = 5
integer y = 8
integer width = 1929
integer height = 264
integer taborder = 20
string dataobject = "dw_ge635_cadastro_convenio_fechamento"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type gb_1 from groupbox within tabpage_4
integer x = 27
integer y = 272
integer width = 2729
integer height = 1204
integer taborder = 31
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Conv$$HEX1$$ea00$$ENDHEX$$nios Subordinados"
borderstyle borderstyle = styleraised!
end type

type tabpage_5 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4197
integer height = 1884
long backcolor = 79741120
string text = "Endere$$HEX1$$e700$$ENDHEX$$o Cobran$$HEX1$$e700$$ENDHEX$$a"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_8 dw_8
gb_6 gb_6
end type

on tabpage_5.create
this.dw_8=create dw_8
this.gb_6=create gb_6
this.Control[]={this.dw_8,&
this.gb_6}
end on

on tabpage_5.destroy
destroy(this.dw_8)
destroy(this.gb_6)
end on

type dw_8 from dc_uo_dw_base within tabpage_5
integer x = 55
integer y = 64
integer width = 2459
integer height = 852
integer taborder = 20
string dataobject = "dw_ge635_endereco_cobranca_convenio"
end type

event constructor;call super::constructor;//ib_IsUpdateAble = True

ivi_Tipo_Cancelar = RETRIEVE

This.of_SetColSelection(True)

end event

event ue_key;call super::ue_key;uo_Cidade lvo_Cidade

String 	lvs_Coluna, &
       		lvs_Cidade

Integer lvi_Linha

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "nm_cidade" Then				
		lvs_Cidade = This.GetText()
		
		lvo_Cidade = Create uo_Cidade
		
		lvo_Cidade.of_Localiza_Cidade(lvs_Cidade)
		
		If lvo_Cidade.Localizada Then
			lvi_Linha = This.GetRow()
			
			This.Object.Cd_Cidade	[lvi_Linha]  = lvo_Cidade.Cd_Cidade
			This.Object.Nm_Cidade[lvi_Linha]	= lvo_Cidade.Nm_Cidade
			
			This.AcceptText()
		End If
		
		Destroy(lvo_Cidade)		
	End If
End If
end event

event ue_recuperar;//OverRide
Long lvl_Convenio

Integer lvi_Linhas, &
        lvi_Linha

lvl_Convenio = Tab_1.TabPage_1.dw_1.Object.Cd_Convenio[1]

If Not IsNull(lvl_Convenio) and lvl_Convenio > 0 Then
	lvi_Linhas = This.Retrieve(lvl_Convenio)
	
	If lvi_Linhas = 0 Then
		This.Event ue_AddRow()
	End If
Else
	This.Event ue_AddRow()
End If

Return lvi_Linhas
end event

type gb_6 from groupbox within tabpage_5
integer x = 14
integer y = 8
integer width = 2546
integer height = 940
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Endere$$HEX1$$e700$$ENDHEX$$o de Cobran$$HEX1$$e700$$ENDHEX$$a"
borderstyle borderstyle = styleraised!
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4197
integer height = 1884
long backcolor = 79741120
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo Fechamento"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_9 dw_9
gb_8 gb_8
end type

on tabpage_6.create
this.dw_9=create dw_9
this.gb_8=create gb_8
this.Control[]={this.dw_9,&
this.gb_8}
end on

on tabpage_6.destroy
destroy(this.dw_9)
destroy(this.gb_8)
end on

type dw_9 from dc_uo_dw_base within tabpage_6
integer x = 32
integer y = 68
integer width = 585
integer height = 856
integer taborder = 20
string dataobject = "dw_ge635_lista_periodo_fechamento"
boolean vscrollbar = true
end type

event constructor;call super::constructor;ivi_Tipo_Cancelar = RETRIEVE

//This.of_SetColSelection(True)
This.of_SetRowSelection()
end event

event ue_recuperar;//OverRide
Long lvl_Convenio

Integer lvi_Linhas, &
        lvi_Linha

lvl_Convenio = Tab_1.TabPage_1.dw_1.Object.Cd_Convenio[1]

If Not IsNull(lvl_Convenio) and lvl_Convenio > 0 Then
	lvi_Linhas = This.Retrieve(lvl_Convenio)

	If lvi_Linhas = 0 Then
		This.Event ue_AddRow()
	End If
Else
	This.Event ue_AddRow()
End If

Return lvi_Linhas
end event

type gb_8 from groupbox within tabpage_6
integer x = 14
integer y = 8
integer width = 649
integer height = 940
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

type st_confirmar from statictext within w_ge635_consulta_convenio
integer x = 2533
integer y = 144
integer width = 1001
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
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
boolean focusrectangle = false
end type

