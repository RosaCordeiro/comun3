HA$PBExportHeader$w_ge184_movimentos_cartao.srw
forward
global type w_ge184_movimentos_cartao from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge184_movimentos_cartao from dc_w_selecao_lista_relatorio
integer width = 5010
integer height = 2620
string title = "GE184 - Relat$$HEX1$$f300$$ENDHEX$$rio de Movimenta$$HEX2$$e700e300$$ENDHEX$$o de Cart$$HEX1$$f500$$ENDHEX$$es"
boolean resizable = false
long backcolor = 80269524
end type
global w_ge184_movimentos_cartao w_ge184_movimentos_cartao

type variables
uo_cartao_tipo_operacao ivo_tipo

uo_estabelecimento_cartao ivo_estabelecimento
end variables

forward prototypes
public function string wf_nome_administradora ()
public function integer of_lastpos (string as_source, string as_target, long al_start)
end prototypes

public function string wf_nome_administradora ();String lvs_Nome

DataWindowChild lvdwc

Integer lvi_Linha

If dw_1.GetChild("cd_administradora", lvdwc) = 1 Then
	lvi_Linha = lvdwc.GetRow()
	
	lvs_Nome = lvdwc.GetItemString(lvi_Linha, "nm_administradora")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do nome da administradora.", StopSign!)
End If

Return lvs_Nome


end function

public function integer of_lastpos (string as_source, string as_target, long al_start);Long	ll_Cnt, ll_Pos

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(as_target) or IsNull(al_start) Then
	SetNull(ll_Cnt)
	Return ll_Cnt
End If

//Check for an empty string
If LenA(as_Source) = 0 Then
	Return 0
End If

// Check for the starting position, 0 means start at the end.
If al_start=0 Then  
	al_start=LenA(as_Source)
End If

//Perform find
For ll_Cnt = al_start to 1 Step -1
	ll_Pos = PosA(as_Source, as_Target, ll_Cnt)
	If ll_Pos = ll_Cnt Then 
		//String was found
		Return ll_Cnt
	End If
Next

//String was not found
Return 0
end function

on w_ge184_movimentos_cartao.create
call super::create
end on

on w_ge184_movimentos_cartao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;If Not ivo_Tipo.of_Localiza_Todos() Then
	Close(This)
End If

This.ivm_Menu.mf_Recuperar(True)
ivm_Menu.ivb_Permite_Imprimir = True

dw_1.Object.dt_inicio[1] 	= Today()
dw_1.Object.dt_termino[1] 	= Today()
end event

event close;call super::close;Destroy(ivo_Tipo)
Destroy(ivo_Estabelecimento)
end event

event open;call super::open;ivo_Estabelecimento = Create uo_Estabelecimento_Cartao
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

event ue_preopen;call super::ue_preopen;ivo_Tipo = Create uo_Cartao_Tipo_Operacao

MaxWidth	= 5040
MaxHeight	= 9999
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge184_movimentos_cartao
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge184_movimentos_cartao
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge184_movimentos_cartao
integer x = 27
integer y = 332
integer width = 4933
integer height = 2096
integer weight = 700
string text = "Lista dos Movimentos"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge184_movimentos_cartao
integer x = 27
integer y = 0
integer width = 3406
integer height = 324
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge184_movimentos_cartao
integer x = 55
integer y = 52
integer width = 3342
integer height = 264
string dataobject = "dw_ge184_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_estabelecimento" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Estabelecimento.Nm_Estabelecimento Then
			Return 1
		End If
	Else
		ivo_Estabelecimento.of_Inicializa()
		
		This.Object.Cd_Estabelecimento[1] = ivo_Estabelecimento.Cd_Estabelecimento
		This.Object.Nm_Estabelecimento[1] = ivo_Estabelecimento.Nm_Estabelecimento		
	End If
End If

Parent.ivm_Menu.mf_Recuperar(True)
This.ivm_Menu.mf_SalvarComo(False)
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Estabelecimento) Then
	This.Object.Cd_Estabelecimento[1] = ivo_Estabelecimento.Cd_Estabelecimento
	This.Object.Nm_Estabelecimento[1] = ivo_Estabelecimento.Nm_Estabelecimento
End If
end event

event dw_1::ue_key;Long lvl_Administradora

If Key = KeyEnter! Then	
	If This.GetColumnName() = "nm_estabelecimento" Then
		This.AcceptText()		
		
		lvl_Administradora = This.Object.Cd_Administradora[1]
		
		If ivo_Estabelecimento.of_Localiza(lvl_Administradora, This.GetText()) Then		
			This.Object.Cd_Estabelecimento[1] = ivo_Estabelecimento.Cd_Estabelecimento
			This.Object.Nm_Estabelecimento[1] = ivo_Estabelecimento.Nm_Estabelecimento
		End If
	End If
End If

Parent.ivm_Menu.mf_Recuperar(True)
end event

event dw_1::editchanged;call super::editchanged;Parent.ivm_Menu.mf_Recuperar(True)
This.ivm_Menu.mf_SalvarComo(False)	 


end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge184_movimentos_cartao
integer x = 46
integer y = 404
integer width = 4887
integer height = 2008
string dataobject = "dw_ge184_carga_movimentos_operacao"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// Override

Long   lvl_Administradora

Date   	lvdt_Inicio, &
      		lvdt_Termino				

String 	lvs_Estabelecimento, &
       		lvs_estabelecimento_f , &
       		lvs_Modelo, &
		 	lvs_Tipo, &
		 	lvs_operacao, &
		 	lvs_tipo_data, &
		 	lvs_Conciliada, &
			lvs_Id_Status_Sitef
		 
dw_1.AcceptText()

lvl_Administradora  		= dw_1.Object.cd_Administradora[1]
lvdt_Inicio       			     = dw_1.Object.dt_Inicio[1]
lvdt_Termino        			= dw_1.Object.dt_Termino[1]
lvs_Estabelecimento  		= dw_1.Object.cd_Estabelecimento[1]
lvs_operacao        			= dw_1.Object.id_operacao[1]
lvs_tipo_data      			= dw_1.Object.id_tipo_data[1]
lvs_Conciliada				= dw_1.Object.id_conciliada[1]
lvs_Id_Status_Sitef 		= dw_1.Object.id_status_sitef	[1]	

If IsNull(lvl_Administradora) or lvl_Administradora = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a administradora.", Exclamation!)
	dw_1.Event ue_Pos(1, "cd_administradora")
	Return -1
End If

If   IsNull(lvs_Estabelecimento) or lvs_Estabelecimento = "" Then
	  lvs_estabelecimento   = '000000000'
     lvs_estabelecimento_f = '999999999'
Else 
	  lvs_estabelecimento_f = lvs_estabelecimento  
End If

If Not IsDate(String(lvdt_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

//Soma dia na Data de Termino
//lvdt_Termino     = RelativeDate(lvdt_Termino, 1)	

 // Classificado pela data de opera$$HEX2$$e700e300$$ENDHEX$$o da compra
If lvs_tipo_data = 'O'   Then  
      lvdt_Termino  = RelativeDate(lvdt_Termino, 1) 
      If Not This.of_ChangeDataObject("dw_ge184_carga_movimentos_operacao")  Then Return -1
Else 	 	
	   // Classificado pela data de credito da compra ( = C)
	   If Not This.of_ChangeDataObject("dw_ge184_carga_movimentos_credito") Then Return -1
End If

If lvs_operacao <> "T" Then
	dw_2.of_AppendWhere("id_tipo_operacao = '" + lvs_Operacao + "'")   
End If

If lvs_Conciliada <> "T"  and (lvl_Administradora <> 2 or lvl_Administradora <> 18 or lvl_Administradora <> 21) Then
	dw_2.of_AppendWhere("isnull(id_conciliada, 'N') = '" + lvs_Conciliada + "'")   
End If

If lvs_Id_Status_Sitef <> 'T' Then
	If lvs_Id_Status_Sitef = 'D' Then
		dw_2.of_AppendWhere("coalesce(cco.id_status_sitef, '') <> 'E'")
	Else
		dw_2.of_AppendWhere("cco.id_status_sitef = '" + lvs_Id_Status_Sitef+"'")	
	End If
End If

If Not dw_3.of_ChangeDataObject("dw_ge184_relatorio") Then Return -1

dw_2.Sort()
dw_3.Sort()

This.ShareData(dw_3)

This.of_SetRowSelection()

Return This.Retrieve(lvl_Administradora    , &
                               lvs_Estabelecimento   , &
						    lvs_Estabelecimento_f , &
						     lvdt_Inicio           , &
							lvdt_Termino)							 
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(True)	 
 Parent.ivm_Menu.mf_Recuperar(True)
// This.ivm_Menu.ivb_Permite_Imprimir = True

Parent.ivm_Menu.mf_Imprimir(true)

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;//This.SetRedraw(False)

/*String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"vl_operacao","vl_parcela","nr_nsu","nr_nf","dh_operacao","dh_credito","nr_parcela","qt_parcelas","cd_filial","nr_lote"}
 				  
lvs_Nome   = {"vl_operacao","vl_parcela","nr_nsu","nr_nf","dh_operacao","dh_credito","nr_parcela","qt_parcelas","cd_filial","nr_lote"}
 
This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)*/

This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_saveas;//OverRide

String 	lvs_Arquivo, &
       		lvs_Diretorio, &
		lvs_Aux, &
		lvs_Extensao

Integer lvi_Retorno, &
		lvi_Pos
		
This.SetFocus()		

// Verifica o nome do arquivo
If Trim(This.ivs_Arquivo_SalvarComo) = "" or IsNull(This.ivs_Arquivo_SalvarComo) Then
	lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
											lvs_Diretorio, &
											lvs_Arquivo, &
											"XLS; XLSX", "Arquivos do Excel (*.XLS; *.XLSX),*.XLS; *.XLSX")
	
	If lvi_Retorno = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
		Return 
	Else
		If lvi_Retorno = 0 Then Return
	End If
Else
	lvs_Diretorio = This.ivs_Arquivo_SalvarComo
End If

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_Diretorio) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
		If Not FileDelete(lvs_Diretorio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
			Return
		End If
	Else
		Return 
   End If   
End If

lvi_Pos = of_LastPos(lvs_Diretorio, ".", LenA(lvs_Diretorio))

If lvi_Pos > 0 Then
	lvs_Aux 		= LeftA(lvs_Diretorio, (lvi_Pos - 1))
	lvs_Extensao 	= Upper(RightA(lvs_Diretorio, (LenA(lvs_Diretorio) - lvi_Pos)))
Else
	lvs_Aux 		= lvs_Diretorio
	lvs_Extensao 	= ""
End if

// Salva o arquivo
If lvs_Extensao = "XLSX" Then
	lvi_Retorno = This.SaveAs(lvs_Diretorio, XLSX!, True)
Else
	If (dw_2.RowCount() > 65535) Then
		lvs_Diretorio 	= lvs_Diretorio+"X"		
		lvi_Retorno 	= This.SaveAs(lvs_Diretorio, XLSX!, True)
	Else
		lvi_Retorno = This.SaveAs(lvs_Diretorio, Excel!, True)
	End If
End If

If lvi_Retorno <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao salvar o arquivo '" + lvs_Diretorio + "'.", StopSign!)	
	Return 
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
End If
end event

event dw_2::editchanged;call super::editchanged;If dw_2.RowCount() > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge184_movimentos_cartao
integer x = 3497
integer y = 28
integer width = 224
integer height = 252
integer taborder = 50
string dataobject = "dw_ge184_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Long lvl_Administradora

Date lvdt_Inicio, &
     lvdt_Termino

String lvs_Administradora, &
       	lvs_Periodo, &
		lvs_Estabelecimento 
	
//		
dw_1.AcceptText()
dw_2.AcceptText()

lvl_Administradora 	= dw_1.Object.Cd_Administradora   [1]
lvdt_Inicio        			= dw_1.Object.Dt_Inicio      	 	   [1]
lvdt_Termino       		= dw_1.Object.Dt_Termino       	   [1]
lvs_Estabelecimento 	= dw_1.Object.Nm_Estabelecimento [1]

lvs_Periodo = String(lvdt_Inicio, "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + String(lvdt_Termino, "dd/mm/yyyy")

lvs_Administradora = wf_Nome_Administradora()
lvs_Administradora += " (" + String(lvl_Administradora) + ")"

dw_3.Object.t_Cabecalho_Administradora.Text = lvs_Administradora
dw_3.Object.t_Cabecalho_Periodo.Text        	 = lvs_Periodo
//dw_3.Object.t_Estabelecimento.Text				 = lvs_Estabelecimento

If lvs_Estabelecimento = "" Then
	dw_3.Object.t_Estabelecimento.Text = "TODOS"
Else
	dw_3.Object.t_Estabelecimento.Text = lvs_Estabelecimento	
End If

dw_3.Sort()
dw_3.GroupCalc()

Return AncestorReturnValue
end event

