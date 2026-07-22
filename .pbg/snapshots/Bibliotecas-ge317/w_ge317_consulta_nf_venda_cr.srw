HA$PBExportHeader$w_ge317_consulta_nf_venda_cr.srw
forward
global type w_ge317_consulta_nf_venda_cr from dc_w_2tab_consulta_selecao_lista_2det
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type pb_copia_chave from picturebutton within tabpage_1
end type
type cb_ver_nf_alteracao from commandbutton within tabpage_2
end type
type cb_imp_det_venda from commandbutton within tabpage_2
end type
type dw_relatorio_detalhe_cv from dc_uo_dw_base within tabpage_2
end type
type cb_receitas from commandbutton within tabpage_2
end type
type cb_forma_pagamento from commandbutton within tabpage_2
end type
type dw_relatorio from dc_uo_dw_base within w_ge317_consulta_nf_venda_cr
end type
end forward

global type w_ge317_consulta_nf_venda_cr from dc_w_2tab_consulta_selecao_lista_2det
integer width = 3913
integer height = 2044
string title = "GE317 - Consulta de Notas Fiscais de Vendas"
dw_relatorio dw_relatorio
end type
global w_ge317_consulta_nf_venda_cr w_ge317_consulta_nf_venda_cr

type variables
Private:
uo_Filial ivo_Filial

uo_convenio		ivo_convenio
uo_conveniado ivo_conveniado
uo_cliente		ivo_cliente
 
String ivs_chave_acesso

Boolean ivb_Inserir_Receita = False
end variables

forward prototypes
public subroutine wf_localiza_cliente ()
public subroutine wf_localiza_convenio ()
public subroutine wf_localiza_filial ()
public subroutine wf_verifica_existe_alteracao_nota ()
public function boolean wf_verifica_lancamento_receita ()
public subroutine wf_localiza_conveniado ()
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_localiza_cliente ();String lvs_Cliente

lvs_Cliente = Tab_1.TabPage_1.dw_1.GetText()
	
ivo_Cliente.of_Localiza_Cliente(lvs_Cliente)

If ivo_Cliente.Localizado Then
	Tab_1.TabPage_1.dw_1.Object.Cd_Cliente[1] = ivo_Cliente.Cd_Cliente
  	Tab_1.TabPage_1.dw_1.Object.Nm_Cliente[1] = ivo_Cliente.Nm_Cliente
End If


end subroutine

public subroutine wf_localiza_convenio ();String lvs_Convenio

lvs_Convenio = Tab_1.TabPage_1.dw_1.GetText()
	
ivo_Convenio.of_Localiza_Convenio(lvs_Convenio)

If ivo_Convenio.Localizado Then
	Tab_1.TabPage_1.dw_1.Object.Cd_Convenio				[1] = ivo_Convenio.Cd_Convenio
	Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia_Convenio	[1] = ivo_Convenio.Nm_Fantasia
	Tab_1.TabPage_1.dw_1.Object.nm_conveniado.TabSequence = Long(Tab_1.TabPage_1.dw_1.Object.nm_fantasia_convenio.TabSequence) + 5
Else
	Tab_1.TabPage_1.dw_1.Object.nm_conveniado.TabSequence = 0
End If

ivo_conveniado.Of_inicializa( )
Tab_1.TabPage_1.dw_1.Object.nm_conveniado	[1] = ivo_conveniado.nm_conveniado
Tab_1.TabPage_1.dw_1.Object.cd_conveniado		[1] = ivo_conveniado.cd_conveniado


end subroutine

public subroutine wf_localiza_filial ();String lvs_Filial

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Filial = Tab_1.TabPage_1.dw_1.GetText()
	
ivo_Filial.of_Localiza_Filial(lvs_Filial)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Filial.Localizada Then
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
  	Tab_1.TabPage_1.dw_1.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
Else

	SetNull(ivo_Filial.Cd_Filial)
	ivo_Filial.Nm_Fantasia = ""
	
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
  	Tab_1.TabPage_1.dw_1.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
End If


end subroutine

public subroutine wf_verifica_existe_alteracao_nota ();Long 	lvl_Linha_Ativa, &
		lvl_Cd_Filial, &
		lvl_Nr_Nf, &
		lvl_Cont
		
String 	lvs_De_Especie, &
			lvs_De_Serie			
			
Tab_1.TabPage_2.cb_ver_nf_alteracao.Enabled = False

lvl_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial  	= Tab_1.TabPage_1.dw_2.Object.Cd_Filial		[lvl_Linha_Ativa]
lvl_Nr_NF      	= Tab_1.TabPage_1.dw_2.Object.Nr_NF			[lvl_Linha_Ativa]
lvs_De_Especie = Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvl_Linha_Ativa]
lvs_De_Serie   	= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvl_Linha_Ativa]

Select count(1)
Into :lvl_Cont
From nf_venda_alteracao
Where cd_filial 		= :lvl_Cd_Filial
  and nr_nf			= :lvl_Nr_Nf
  and de_especie	= :lvs_De_Especie
  and de_serie		= :lvs_De_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao consultar a nota na tabela nf_venda_alteracao.", StopSign!)
End If

If lvl_Cont > 0 Then
	Tab_1.TabPage_2.cb_ver_nf_alteracao.Enabled = True
End If
end subroutine

public function boolean wf_verifica_lancamento_receita ();Long lvl_Total_Rec
Long lvl_Cd_Filial
Long lvl_Nr_NF
Long lvl_Linha_Ativa

String lvs_De_Especie
String lvs_De_Serie
String lvs_Tipo_Venda

Tab_1.TabPage_2.cb_receitas.Enabled = False
ivb_Inserir_Receita = False
Tab_1.TabPage_2.cb_receitas.Text 		= 'Exibir Receitas'

lvl_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial  	= Tab_1.TabPage_1.dw_2.Object.Cd_Filial			[lvl_Linha_Ativa]
lvl_Nr_NF      	= Tab_1.TabPage_1.dw_2.Object.Nr_NF				[lvl_Linha_Ativa]
lvs_De_Especie = Tab_1.TabPage_1.dw_2.Object.De_Especie		[lvl_Linha_Ativa]
lvs_De_Serie   	= Tab_1.TabPage_1.dw_2.Object.De_Serie			[lvl_Linha_Ativa]
lvs_Tipo_Venda= Tab_1.TabPage_1.dw_2.Object.id_tipo_venda	[lvl_Linha_Ativa]

Select coalesce(count(1),0)
Into :lvl_Total_Rec
From receita r
Where r.cd_filial = :lvl_Cd_Filial
	And r.nr_nf = :lvl_Nr_NF
	And r.de_especie = :lvs_De_Especie
	And r.de_serie = :lvs_De_Serie
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o receita." )
	Return False
End If

Tab_1.TabPage_2.cb_receitas.Enabled = (lvl_Total_Rec > 0)

If lvs_Tipo_Venda = 'CV' Then
	If Not Tab_1.TabPage_2.cb_receitas.Enabled Then
		//Habilita bot$$HEX1$$e300$$ENDHEX$$o Inserir Receita
		Tab_1.TabPage_2.cb_receitas.Text 		= 'Inserir Receitas'
		Tab_1.TabPage_2.cb_receitas.Enabled	= True
		ivb_Inserir_Receita = True
	End If
End If

Return (lvl_Total_Rec > 0)
end function

public subroutine wf_localiza_conveniado ();Long lvl_Convenio
String lvs_Conveniado

lvs_Conveniado	= Tab_1.TabPage_1.dw_1.GetText()
lvl_Convenio		= Tab_1.TabPage_1.dw_1.Object.cd_convenio [1]

If Not IsNull(lvl_Convenio) and (lvl_Convenio > 0 ) then
	ivo_Conveniado.of_Localiza_conveniado( lvl_Convenio, lvs_Conveniado)
	
	If ivo_Conveniado.Localizado Then
		Tab_1.TabPage_1.dw_1.Object.Cd_Conveniado	[1] = ivo_Conveniado.Cd_conveniado
		Tab_1.TabPage_1.dw_1.Object.Nm_conveniado	[1] = ivo_Conveniado.Nm_conveniado
	End If
End If
end subroutine

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*Tipo Canal Venda*/
ldwc_Child  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("id_tipo_canal" )
ldwc_Child.SetItem(1, "id_tipo_canal_venda", "")
ldwc_Child.SetItem(1, "de_tipo_canal_venda", "TODAS")
//Tab_1.TabPage_1.dw_1.Object.id_tipo_canal[1] = ""

/*Canal Venda*/
ldwc_Child  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("id_canal_venda" )			
ldwc_Child.SetItem(1, "cd_canal_venda", "")
ldwc_Child.SetItem(1, "de_canal_venda", "TODAS")
//Tab_1.TabPage_1.dw_1.Object.id_canal_venda[1] = ""
end subroutine

on w_ge317_consulta_nf_venda_cr.create
int iCurrent
call super::create
this.dw_relatorio=create dw_relatorio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_relatorio
end on

on w_ge317_consulta_nf_venda_cr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_relatorio)
end on

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Convenio)
Destroy(ivo_Cliente)
Destroy(ivo_conveniado)
end event

event open;call super::open;ivl_Largura_1 = 3845
ivl_Altura_1  = 1830

ivl_Largura_2 = 3383
ivl_Altura_2  = 1830

dw_relatorio.ivm_menu.ivb_permite_imprimir = True

end event

event ue_postopen;call super::ue_postopen;//Habilita Menu
ivm_Menu.Mf_Recuperar(True)

Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_de[1]  = Today()
Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_ate[1] = Today()

ivo_Filial   		= Create uo_Filial
ivo_Convenio	= Create uo_Convenio
ivo_Cliente  		= Create uo_Cliente
ivo_conveniado	= Create uo_conveniado

wf_insere_padrao()
end event

event ue_print;call super::ue_print;dw_relatorio.Event ue_print()
end event

event ue_printimmediate;call super::ue_printimmediate;dw_relatorio.Event ue_printimmediate()
end event

event ue_saveas;dw_relatorio.Event ue_SaveAs()
end event

event ue_preopen;call super::ue_preopen;Maxheight = 9999
end event

event resize;call super::resize;Tab_1.Height = NewHeight - 10

Tab_1.Tabpage_1.gb_2.Height	= Newheight - Tab_1.Tabpage_1.gb_2.Y - 140
Tab_1.Tabpage_1.dw_2.Height	= Newheight - Tab_1.Tabpage_1.dw_2.Y - 180
Tab_1.Tabpage_1.dw_5.Y = NewHeight - 270
Tab_1.Tabpage_1.pb_copia_chave.Y = NewHeight - 280

Tab_1.Tabpage_2.gb_4.Height	= Newheight - Tab_1.Tabpage_2.gb_4.Y - 140
Tab_1.Tabpage_2.dw_4.Height	= Newheight - Tab_1.Tabpage_2.dw_4.Y - 180
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge317_consulta_nf_venda_cr
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge317_consulta_nf_venda_cr
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge317_consulta_nf_venda_cr
integer x = 9
integer width = 3845
integer height = 1832
end type

event tab_1::selectionchanging;//OverRide

SetPointer(HourGlass!)

String lvs_Tipo_Venda, lvs_dw_Detalhe

Long lvl_Linha 

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If NewIndex = 2 Then
	If lvl_Linha > 0 Then
		
		lvs_Tipo_Venda = Tab_1.TabPage_1.dw_2.Object.id_tipo_venda[lvl_Linha]
		
		lvs_dw_Detalhe = 'dw_ge317_detalhe_nf_venda_' + lower(lvs_Tipo_Venda)
		
		//Verifica se existe a necessidade de troca de dw 
		//conforme o tipo de nf de venda selecionado
		If Tab_1.TabPage_2.dw_3.DataObject <> lvs_dw_Detalhe Then
			Tab_1.TabPage_2.dw_3.DataObject  = lvs_dw_Detalhe
			Tab_1.TabPage_2.dw_3.SetTransObject(Sqlca)
		End If	
		
		// Verifica se existe notas alteradas
		wf_Verifica_Existe_Alteracao_Nota()
		//Verifica se existe receitas lan$$HEX1$$e700$$ENDHEX$$adas para esta venda
		wf_verifica_lancamento_receita()
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
		
		Tab_1.TabPage_2.cb_imp_det_venda.Enabled = False
		
		If upper(lvs_Tipo_Venda) = "CV" Then			
			Tab_1.TabPage_2.cb_imp_det_venda.Enabled = True
			
			Tab_1.TabPage_2.dw_Relatorio_Detalhe_CV.Event ue_Retrieve()
		End If

		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		

SetPointer(Arrow!)
end event

event tab_1::selectionchanged;//OVerRide
SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_2.dw_3.SetFocus()
End Choose
	
Parent.Width  = This.Width + 80
Parent.Height = This.Height + 160			

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
event create ( )
event destroy ( )
integer width = 3808
integer height = 1716
dw_5 dw_5
pb_copia_chave pb_copia_chave
end type

on tabpage_1.create
this.dw_5=create dw_5
this.pb_copia_chave=create pb_copia_chave
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.pb_copia_chave
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.pb_copia_chave)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer y = 688
integer width = 3762
integer height = 1024
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer width = 3762
integer height = 668
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer width = 3488
integer height = 560
string dataobject = "dw_ge317_selecao_nf_venda_cr"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "de_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.of_inicializa( )
			
			This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
			This.Object.De_Filial	[1] = ivo_Filial.Nm_Fantasia			
		End If
	Case "nm_cliente"
		If Trim(Data) <> "" Then
			If Data <> ivo_Cliente.Nm_Cliente Then
				Return 1
			End If	
		Else			
			ivo_Cliente.of_inicializa( )
			
			This.Object.Cd_Cliente	[1] = ivo_Cliente.Cd_Cliente
			This.Object.Nm_Cliente	[1] = ivo_Cliente.Nm_Cliente
		End If		
	Case "nm_conveniado"
		If Trim(Data) <> "" Then
			If Data <> ivo_Conveniado.nm_conveniado Then
				Return 1
			End If	
		Else			
			ivo_Conveniado.of_inicializa( )
			
			This.Object.cd_conveniado	[1] = ivo_Conveniado.Cd_conveniado
			This.Object.nm_conveniado	[1] = ivo_Conveniado.nm_conveniado
		End If		
	Case "nm_fantasia_convenio"
		If Trim(Data) <> "" Then
			If Data <> ivo_Convenio.Nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Convenio.Of_inicializa( )
			This.Object.Cd_Convenio					[1] = ivo_Convenio.Cd_Convenio
			This.Object.Nm_Fantasia_Convenio	[1] = ivo_Convenio.Nm_Fantasia		
			
			ivo_conveniado.of_inicializa( )
			This.Object.cd_conveniado	[1] = ivo_Conveniado.Cd_conveniado
			This.Object.nm_conveniado	[1] = ivo_Conveniado.nm_conveniado
			Tab_1.TabPage_1.dw_1.Object.nm_conveniado.TabSequence = 0
		End If		
	Case "id_agrupa_filial"
		If Trim(Data) = "S" Then
			Parent.dw_2.ShareDataOff( )
			Parent.dw_2.of_changedataobject('dw_ge317_lista_nf_venda_agrupa_filial')
			dw_relatorio.of_changedataobject('dw_ge317_relatorio_filial')
			Parent.dw_2.ShareData(dw_relatorio)
			Parent.dw_2.ivb_ordena_colunas = False
		Else
			Parent.dw_2.ShareDataOff( )
			Parent.dw_2.of_changedataobject('dw_ge317_lista_nf_venda_cr')		
			dw_relatorio.of_changedataobject('dw_ge317_relatorio')
			Parent.dw_2.ShareData(dw_relatorio)
			Parent.dw_2.ivb_ordena_colunas = True	
		End If
	Case "id_tipo_canal"
		DatawindowChild lvdw_Child
		If dw_1.GetChild("id_canal_venda", lvdw_Child) > 0 Then
			lvdw_Child.SetTransObject( SQLCa )
			lvdw_Child.SetFilter("isNull(id_tipo_canal) or id_tipo_canal = '"+Data+"'")
			lvdw_Child.Filter()
		End If		
		This.Object.id_canal_venda 		[1] = ""
End Choose		
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	dw_1.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
End If	

If IsValid(ivo_Cliente) Then 
	dw_1.Object.Nm_Cliente[1] = ivo_Cliente.Nm_Cliente
End If	

If IsValid(ivo_Convenio) Then 
	dw_1.Object.Nm_Fantasia_Convenio[1] = ivo_Convenio.Nm_Fantasia
End If	

If IsValid(ivo_Conveniado) Then 
	dw_1.Object.Nm_Conveniado[1] = ivo_Conveniado.Nm_conveniado
End If	
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = dw_1.GetColumnName()

	Choose Case lvs_Coluna
		Case "de_filial"
			wf_Localiza_Filial()
		Case "nm_cliente"
			wf_Localiza_Cliente()
		Case "nm_fantasia_convenio"
			wf_Localiza_Convenio()		
		Case "nm_conveniado"
			wf_localiza_conveniado()
	End Choose
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer x = 64
integer y = 764
integer width = 3680
integer height = 932
string dataobject = "dw_ge317_lista_nf_venda_cr"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	lvs_Where, &
		lvs_Especie, &
		lvs_Serie, &
		lvs_Situacao, &
		lvs_Tipo_Venda, &
		lvs_Agrupa_Filial, &
		lvs_Cliente, &
		lvs_Conveniado, &
		lvs_Forma_Pagto,&
		lvs_Anexa, &
		lvs_Canal_Venda, &
		lvs_Tipo_Canal, &
		lvs_nr_servico
		 
Decimal {2} lvdc_Valor_de, &
            lvdc_Valor_Ate
		   
Date  lvdt_Emissao_de, lvdt_Emissao_ate

Long	lvl_Filial, &
     	lvl_Nota_Fiscal, &
	  	lvl_Convenio,&
	  	lvl_Ecf,&
	  	lvl_Lote,&
	  	lvl_Seq_Equipto
	  
lvs_Where = ''

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Emissao_de  	= Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_de			[1]
lvdt_Emissao_ate 	= Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_ate		[1]
lvl_Filial       		= Tab_1.TabPage_1.dw_1.Object.Cd_Filial					[1]
lvl_Nota_Fiscal  	= Tab_1.TabPage_1.dw_1.Object.Nr_Nf						[1]
lvs_Especie      		= Tab_1.TabPage_1.dw_1.Object.De_Especie				[1] 
lvs_Serie        		= Tab_1.TabPage_1.dw_1.Object.De_Serie					[1]
lvs_Situacao     	= Tab_1.TabPage_1.dw_1.Object.Id_Cancelada			[1]
lvs_Tipo_Venda   	= Tab_1.TabPage_1.dw_1.Object.Id_Tipo_Venda			[1]
lvdc_Valor_de    	= Tab_1.TabPage_1.dw_1.Object.Vl_Valor_de				[1]
lvdc_Valor_Ate   	= Tab_1.TabPage_1.dw_1.Object.Vl_Valor_ate			[1]
lvl_Convenio     	= Tab_1.TabPage_1.dw_1.Object.Cd_Convenio			[1]
lvs_Cliente      		= Tab_1.TabPage_1.dw_1.Object.Cd_Cliente				[1]
lvl_Ecf          		= Tab_1.TabPage_1.dw_1.Object.nr_ecf						[1] 
lvs_Conveniado		= Tab_1.TabPage_1.dw_1.Object.cd_conveniado			[1] 
lvl_Lote				= Tab_1.TabPage_1.dw_1.Object.nr_lote_convenio		[1] 
lvs_Forma_Pagto	= Tab_1.TabPage_1.dw_1.Object.cd_forma_pagto		[1] 
lvl_Seq_Equipto	= Tab_1.TabPage_1.dw_1.Object.nr_seq_equipamento	[1]
lvs_Anexa			= Tab_1.TabPage_1.dw_1.Object.id_anexa					[1]
lvs_Canal_Venda	= Tab_1.TabPage_1. dw_1.Object.id_canal_venda		[1]
lvs_Tipo_Canal		= Tab_1.TabPage_1.dw_1.Object.id_tipo_canal			[1]
lvs_nr_servico		= Tab_1.TabPage_1.dw_1.Object.nr_nf_servico			[1]

If Not IsNull(lvdt_Emissao_de) Then 
	This.of_AppendWhere(" nf.dh_movimentacao_caixa >= '" + string(lvdt_Emissao_de,'yyyy/mm/dd') + "'")
End If	

If Not IsNull(lvdt_Emissao_ate) Then 
	This.of_AppendWhere("nf.dh_movimentacao_caixa <= '" + string(lvdt_Emissao_ate,'yyyy/mm/dd') + "'")
End If	

If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
	This.of_AppendWhere(" nf.cd_filial = " + String(lvl_Filial))
End If	

If Not IsNull(lvl_Nota_Fiscal) Then
	This.of_AppendWhere(" nf.nr_nf = " + String(lvl_Nota_Fiscal))
End If	

If (Not IsNull(lvs_Especie))and(Trim(lvs_Especie)<>'') Then
	This.of_AppendWhere(" nf.de_especie = '" + lvs_Especie + "'")
End If	

If (Not IsNull(lvs_Serie))and(Trim(lvs_Serie)<>'') Then
	This.of_AppendWhere(" nf.de_serie = '" + lvs_Serie + "'")
End If

If (Not IsNull(lvl_Ecf)) and (lvl_Ecf > 0) Then
	This.of_AppendWhere(" nf.nr_ecf = " + String(lvl_Ecf))
End If	

If (Not IsNull(lvl_Lote)) and (lvl_Lote > 0) Then
	This.of_AppendWhere(" nf.nr_lote_convenio = " + String(lvl_Lote))
End If	

If lvs_Tipo_Venda <> 'TO' Then
	This.of_AppendWhere(" nf.id_tipo_venda = '" + lvs_tipo_venda + "'")
End If

If lvs_Forma_Pagto <> 'TD' Then
	This.of_AppendWhere(" coalesce(nf.cd_forma_pagamento,'DI') = '" + lvs_Forma_Pagto + "'")
End If

If lvs_Situacao <> "T" Then
   If lvs_Situacao = 'S' Then
		This.of_AppendWhere(" nf.dh_cancelamento is not null")
		
	Elseif lvs_Situacao = 'D' Then
		This.of_AppendWhere(" nf.dh_devolucao is not null")
		
	Elseif lvs_Situacao = 'E' Then
		This.of_AppendWhere(" nf.dh_devolucao is null")
		
	Else
		This.of_AppendWhere(" nf.dh_cancelamento is null")
	End If	
End If	

If Not IsNull(lvl_Convenio) Then
	This.of_AppendWhere(" nf.cd_convenio = " + String(lvl_Convenio))
End If

If (Not IsNull(lvs_Conveniado))and(Trim(lvs_Conveniado)<>'') Then
	This.of_AppendWhere(" nf.cd_conveniado = '" + lvs_Conveniado + "'")
End If

If (Not IsNull(lvs_Cliente))and(Trim(lvs_Cliente)<>'') Then
	This.of_AppendWhere(" nf.cd_cliente = '" + lvs_Cliente + "'")
End If

If lvl_Seq_Equipto > 0 Then
	This.of_AppendWhere(" nf.nr_coo_ecf = " + String(lvl_Seq_Equipto))
End If

If lvdc_Valor_de <> 0.00 Then
	This.of_AppendWhere(" nf.vl_total_nf >= " + gf_Valor_Com_Ponto(lvdc_Valor_de))
End If

If lvdc_Valor_ate <> 0.00 Then
	This.of_AppendWhere(" nf.vl_total_nf <= " + gf_Valor_Com_Ponto(lvdc_Valor_ate))
End If

If lvs_Anexa <> "" Then
	If lvs_Anexa = 'N' Then
		This.Of_AppendWhere("nf.nr_nf_anexa is null")
	Else
		This.Of_AppendWhere("nf.nr_nf_anexa is not null")
	End If
End If

If lvs_Tipo_Canal <> "" Then
	This.Of_AppendWhere("cnv.id_tipo_canal = '"+lvs_Tipo_Canal+"'")
	
	//Otimiza$$HEX2$$e700e300$$ENDHEX$$o da gera$$HEX2$$e700e300$$ENDHEX$$o
	Choose Case lvs_Tipo_Canal
		Case "EC"
			This.Of_AppendWhere("nf.nr_pedido_ecommerce > 0") 
			
		Case "LI" //Licita$$HEX2$$e700e300$$ENDHEX$$o
			This.Of_AppendWhere("nf.id_licitacao='S'")
	End Choose
End If

If lvs_Canal_Venda <> "" Then
	If lvs_Canal_Venda = "AP" Then
		This.of_AppendWhere("coalesce(pe.id_ecommerce,'1')='2'") //Todas as vendas VTEX, depois ajustar o filtro quando for poss$$HEX1$$ed00$$ENDHEX$$vel identificar
		This.of_AppendWhere("pe.de_canal_compra_vtex in ('app_android', 'app_ios', 'app_android_n', 'app_ios_n')") 
	Else
		If lvdt_Emissao_de > Date("2020/10/08") Then This.Of_AppendWhere("nf.cd_canal_venda = '"+lvs_Canal_Venda+"'")
		This.Of_AppendWhere("cnv.cd_canal_venda = '"+lvs_Canal_Venda+"'")
		This.of_AppendWhere("coalesce(pe.de_canal_compra_vtex,'') not in ('app_android', 'app_ios', 'app_android_n', 'app_ios_n')") 
	End If	
End If

If Not IsNull(lvs_nr_servico) And Trim(lvs_nr_servico) <> "" Then	
	This.of_AppendWhere(" ns.nr_nf_servico = '" + lvs_nr_servico + "'") 
End If	

String vls_Sql
vls_Sql = This.GetSqlSelect()

dw_relatorio.ivm_menu.mf_imprimir(False)
dw_relatorio.ivm_menu.mf_salvarcomo(False)

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.of_SetRowSelection("", "If ( Not IsNull( dh_cancelamento ) , RGB(255,0,0) , RGB(0,0,0))") 
End If

Parent.pb_copia_chave.visible = (pl_linhas > 0)
This.ivo_Controle_menu.of_Imprimir(pl_Linhas > 0)
This.ivo_Controle_menu.of_SalvarComo(pl_Linhas > 0)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
This.ShareData(dw_relatorio)

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial","nr_nf","de_especie","de_serie","nr_ecf","nr_coo_ecf","dh_emissao","dh_movimentacao_caixa","id_tipo_venda","pc_desconto","vl_total_nf","dh_cancelamento"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo da Filial", "Nr NF","Esp$$HEX1$$e900$$ENDHEX$$cie","S$$HEX1$$e900$$ENDHEX$$rie","Nr. ECF","Sequ$$HEX1$$ea00$$ENDHEX$$ncia","Data de Emiss$$HEX1$$e300$$ENDHEX$$o","Data de Movimenta$$HEX2$$e700e300$$ENDHEX$$o","Tipo Venda","% de desconto","Total Nota","Data de Cancelamento"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If  This.RowCount() > 0 Then	
	tab_1.tabpage_1.dw_5.Object.chave_acesso[1] = This.Object.de_chave_acesso[currentrow]	
End If
end event

event dw_2::ue_retrieve;call super::ue_retrieve;If AncestorReturnValue > 0 Then
	ivm_Menu.mf_SalvarComo(True)
Else	
	ivm_Menu.mf_SalvarComo(False)
End if	

Return AncestorReturnValue 

end event

event dw_2::ue_reset;call super::ue_reset;This.ivo_Controle_menu.of_Imprimir(False)
This.ivo_Controle_menu.of_SalvarComo(False)
Parent.pb_copia_chave.visible = False
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 3808
integer height = 1716
cb_ver_nf_alteracao cb_ver_nf_alteracao
cb_imp_det_venda cb_imp_det_venda
dw_relatorio_detalhe_cv dw_relatorio_detalhe_cv
cb_receitas cb_receitas
cb_forma_pagamento cb_forma_pagamento
end type

on tabpage_2.create
this.cb_ver_nf_alteracao=create cb_ver_nf_alteracao
this.cb_imp_det_venda=create cb_imp_det_venda
this.dw_relatorio_detalhe_cv=create dw_relatorio_detalhe_cv
this.cb_receitas=create cb_receitas
this.cb_forma_pagamento=create cb_forma_pagamento
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ver_nf_alteracao
this.Control[iCurrent+2]=this.cb_imp_det_venda
this.Control[iCurrent+3]=this.dw_relatorio_detalhe_cv
this.Control[iCurrent+4]=this.cb_receitas
this.Control[iCurrent+5]=this.cb_forma_pagamento
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_ver_nf_alteracao)
destroy(this.cb_imp_det_venda)
destroy(this.dw_relatorio_detalhe_cv)
destroy(this.cb_receitas)
destroy(this.cb_forma_pagamento)
end on

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer y = 1136
integer width = 3291
integer height = 568
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer y = 20
integer width = 3287
integer height = 1020
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer y = 88
integer width = 3227
integer height = 924
string dataobject = "dw_ge317_detalhe_nf_venda_cv"
end type

event dw_3::ue_recuperar;//OverRide
Long 	lvl_Cd_Filial, &
     	lvl_Nr_NF
	  
String 	lvs_De_Especie, &
	       	lvs_De_Serie
		 
Long 	lvi_Linha_Ativa, &
        		lvi_Linhas
		  
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial		= Tab_1.TabPage_1.dw_2.Object.Cd_Filial		[lvi_Linha_Ativa]
lvl_Nr_NF		= Tab_1.TabPage_1.dw_2.Object.Nr_NF			[lvi_Linha_Ativa]
lvs_De_Especie	= Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvi_Linha_Ativa]
lvs_De_Serie	= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvi_Linha_Ativa]

lvi_Linhas = This.Retrieve(	lvl_Cd_Filial, &
                           			lvl_Nr_NF, &
									lvs_De_Especie, &
									lvs_De_Serie)
									
Return lvi_Linhas
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer y = 1216
integer width = 3209
integer height = 476
string dataobject = "dw_ge317_detalhe_itens_nf_venda_cr"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_4::ue_recuperar;//OverRide
Long 	lvl_Cd_Filial, &
     	lvl_Nr_NF
	  
String lvs_De_Especie, &
       	lvs_De_Serie
		 
Long 	lvi_Linha_Ativa
		  
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial  	= Tab_1.TabPage_1.dw_2.Object.Cd_Filial		[lvi_Linha_Ativa]
lvl_Nr_NF      	= Tab_1.TabPage_1.dw_2.Object.Nr_NF			[lvi_Linha_Ativa]
lvs_De_Especie = Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvi_Linha_Ativa]
lvs_De_Serie   	= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvi_Linha_Ativa]
									
Return This.Retrieve(	lvl_Cd_Filial		, &
							lvl_Nr_NF		, &
							lvs_De_Especie	, &
							lvs_De_Serie)
end event

event dw_4::constructor;call super::constructor;This.of_SetRowSelection()
end event

type dw_5 from dc_uo_dw_base within tabpage_1
integer x = 654
integer y = 1608
integer width = 1582
integer height = 72
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge317_chave_acesso"
end type

event itemchanged;call super::itemchanged;insertRow(1)

end event

type pb_copia_chave from picturebutton within tabpage_1
boolean visible = false
integer x = 2208
integer y = 1596
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean originalsize = true
string picturename = "Copy!"
alignment htextalign = left!
end type

event clicked;Integer lvi_Retorno

Long lvl_Linha

Tab_1.TabPage_1.dw_5.SetFocus()

Tab_1.TabPage_1.dw_5.SelectText(1, 44)

lvl_Linha = Tab_1.TabPage_1.dw_5.GetRow()

lvi_Retorno = Tab_1.TabPage_1.dw_5.Copy()

Choose Case lvi_Retorno
	Case -1  // Vazio
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o foi selecionada para a c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -2  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -9  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
End Choose

end event

type cb_ver_nf_alteracao from commandbutton within tabpage_2
integer x = 2651
integer y = 1056
integer width = 658
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Exibir Altera$$HEX2$$e700f500$$ENDHEX$$es Notas"
end type

event clicked;Long 	lvl_Linha_Ativa, &
		lvl_Cd_Filial, &
		lvl_Nr_Nf, &
		lvl_Cont
		
String 	lvs_De_Especie, &
			lvs_De_Serie, &
			lvs_Parametro
			
lvl_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial  	= Tab_1.TabPage_1.dw_2.Object.Cd_Filial		[lvl_Linha_Ativa]
lvl_Nr_NF      	= Tab_1.TabPage_1.dw_2.Object.Nr_NF			[lvl_Linha_Ativa]
lvs_De_Especie = Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvl_Linha_Ativa]
lvs_De_Serie   	= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvl_Linha_Ativa]

lvs_Parametro 	= String(lvl_Cd_Filial, "0000") + String(lvl_Nr_NF, "00000000") + RightA(space(3) + lvs_De_Especie, 3) + RightA(space(3) +  lvs_De_Serie, 3)

OpenWithParm(w_ge317_consulta_nf_venda_alteracao, lvs_Parametro)
end event

type cb_imp_det_venda from commandbutton within tabpage_2
integer x = 1929
integer y = 1056
integer width = 713
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Imprimir Detalhes Venda"
end type

event clicked;Tab_1.TabPage_2.dw_Relatorio_Detalhe_CV.Event ue_Print()
end event

type dw_relatorio_detalhe_cv from dc_uo_dw_base within tabpage_2
boolean visible = false
integer x = 3182
integer y = 184
integer width = 489
integer height = 232
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge317_rel_detalhe_cv"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_retrieve;//OverRide
Long 	lvl_Cd_Filial, &
     	lvl_Nr_NF
	  
String 	lvs_De_Especie, &
	       	lvs_De_Serie
		 
Long 	lvi_Linha_Ativa, &
        		lvi_Linhas
		  
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial		= Tab_1.TabPage_1.dw_2.Object.Cd_Filial		[lvi_Linha_Ativa]
lvl_Nr_NF		= Tab_1.TabPage_1.dw_2.Object.Nr_NF			[lvi_Linha_Ativa]
lvs_De_Especie	= Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvi_Linha_Ativa]
lvs_De_Serie	= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvi_Linha_Ativa]

lvi_Linhas = This.Retrieve(	lvl_Cd_Filial, &
                           			lvl_Nr_NF, &
									lvs_De_Especie, &
									lvs_De_Serie)
									
Return lvi_Linhas
end event

event constructor;call super::constructor;This.Visible = False
end event

type cb_receitas from commandbutton within tabpage_2
integer x = 1445
integer y = 1056
integer width = 480
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Exibir Receitas"
end type

event clicked;Long 	lvl_Linha_Ativa, &
		lvl_Cd_Filial, &
		lvl_Nr_Nf, &
		lvl_Cont
		
String 	lvs_De_Especie, &
			lvs_De_Serie, &
			lvs_Parametro
			
lvl_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial  	= Tab_1.TabPage_1.dw_2.Object.Cd_Filial		[lvl_Linha_Ativa]
lvl_Nr_NF      	= Tab_1.TabPage_1.dw_2.Object.Nr_NF			[lvl_Linha_Ativa]
lvs_De_Especie = Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvl_Linha_Ativa]
lvs_De_Serie   	= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvl_Linha_Ativa]

lvs_Parametro 	= String(lvl_Cd_Filial, "0000") + String(lvl_Nr_NF, "00000000") + RightA(space(3) + lvs_De_Especie, 3) + RightA(space(3) +  lvs_De_Serie, 3)

If Not ivb_Inserir_Receita Then
	lvs_Parametro += 'N'
Else
	lvs_Parametro += 'S'
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esta nota n$$HEX1$$e300$$ENDHEX$$o possui receitas vinculadas.~r~rDeseja inserir receitas para esta venda?", Question!, YesNo!, 2) = 2 Then
		Return -1
	End If
End If

OpenWithParm(w_ge317_consulta_receita_nf, lvs_Parametro)

wf_verifica_lancamento_receita( )
end event

type cb_forma_pagamento from commandbutton within tabpage_2
integer x = 823
integer y = 1056
integer width = 613
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Forma de Pagamento"
end type

event clicked;Long 	lvl_Linha_Ativa, lvl_Cd_Filial, lvl_Nr_Nf, lvl_Cont		
String 	lvs_De_Especie, lvs_De_Serie, lvs_Parametro
			
lvl_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial  	= Tab_1.TabPage_1.dw_2.Object.Cd_Filial		[lvl_Linha_Ativa]
lvl_Nr_NF      	= Tab_1.TabPage_1.dw_2.Object.Nr_NF			[lvl_Linha_Ativa]
lvs_De_Especie = Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvl_Linha_Ativa]
lvs_De_Serie   	= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvl_Linha_Ativa]

lvs_Parametro 	= String(lvl_Cd_Filial, "0000") + String(lvl_Nr_NF, "00000000") + RightA(space(3) + lvs_De_Especie, 3) + RightA(space(3) +  lvs_De_Serie, 3)

OpenWithParm(w_ge317_altera_forma_pagamento, lvs_Parametro)

end event

type dw_relatorio from dc_uo_dw_base within w_ge317_consulta_nf_venda_cr
boolean visible = false
integer x = 3314
integer y = 1112
integer height = 248
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge317_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Fim

String lvs_Tipo_Venda

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Inicio	= Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_de		[1]
lvdt_Fim		= Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_ate	[1]

lvs_Tipo_Venda   	= Tab_1.TabPage_1.dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_venda)',1)")

This.Object.st_periodo.Text = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio)+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim)
This.Object.st_tipo.Text		= 'Tipo Venda: '+lvs_Tipo_Venda

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

event constructor;call super::constructor;This.Visible = False
end event

