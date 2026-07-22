HA$PBExportHeader$w_ge091_relatorio_cheques_funcionarios.srw
forward
global type w_ge091_relatorio_cheques_funcionarios from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge091_relatorio_cheques_funcionarios from dc_w_selecao_lista_relatorio
integer width = 3625
integer height = 1892
string title = "GE091 - Relat$$HEX1$$f300$$ENDHEX$$rio de Cheques de Funcion$$HEX1$$e100$$ENDHEX$$rios"
long backcolor = 80269524
end type
global w_ge091_relatorio_cheques_funcionarios w_ge091_relatorio_cheques_funcionarios

type variables
uo_filial                    ivo_filial
uo_filial                    ivo_portador
uo_cliente_cheque ivo_cliente
uo_banco               ivo_banco

dc_uo_transacao rubi

dc_uo_ds_base ivo_Func 
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_cliente ()
public subroutine wf_localiza_portador ()
public subroutine wf_localiza_banco ()
public function boolean wf_conecta_banco_rh ()
public function boolean wf_atualiza_informacoes ()
end prototypes

public subroutine wf_localiza_filial ();STRING lvs_Filial

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Filial = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Filial)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Filial.Localizada Then
	dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
	dw_1.Object.nm_filial[1] = ivo_Filial.nm_fantasia
Else

	SetNull(ivo_Filial.Cd_Filial)
	ivo_Filial.Nm_Fantasia = ""
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	dw_1.Object.nm_filial[1] = ivo_filial.nm_fantasia
End If

end subroutine

public subroutine wf_localiza_cliente ();STRING lvs_Cliente

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Cliente = dw_1.GetText()

ivo_Cliente.of_Localiza_Cliente(lvs_Cliente)

// Verifica se o Cliente foi localizada e atualiza a DW
If ivo_Cliente.Localizado Then
	dw_1.Object.nr_cpf_cliente[1] = ivo_Cliente.nr_cpf
	dw_1.Object.nm_cliente    [1] = ivo_Cliente.nm_cliente
Else

	SetNull(ivo_Cliente.nm_cliente)
	ivo_Cliente.nm_cliente = ""
	
	dw_1.Object.nr_cpf_cliente[1] = ivo_Cliente.nr_cpf
	dw_1.Object.nm_cliente    [1] = ivo_Cliente.nm_cliente
End If

end subroutine

public subroutine wf_localiza_portador ();STRING lvs_Portador

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Portador = dw_1.GetText()

ivo_Portador.of_Localiza_Filial(lvs_Portador)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Portador.Localizada Then
	dw_1.Object.cd_portador[1] = ivo_Portador.cd_filial
	dw_1.Object.nm_portador[1] = ivo_Portador.nm_fantasia
Else

	SetNull(ivo_Portador.Cd_Filial)
	ivo_Portador.Nm_Fantasia = ""
	
	dw_1.Object.cd_portador[1] = ivo_Portador.cd_filial
	dw_1.Object.nm_portador[1] = ivo_Portador.nm_fantasia
End If

end subroutine

public subroutine wf_localiza_banco ();STRING lvs_Banco

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Banco = dw_1.GetText()

ivo_Banco.of_Localiza_Banco(lvs_Banco)

// Verifica se o Banco foi localizado e atualiza a DW
If ivo_Banco.Localizado Then
	dw_1.Object.cd_Banco[1] = ivo_Banco.cd_banco
	dw_1.Object.nm_Banco[1] = ivo_Banco.nm_Banco
Else

	SetNull(ivo_Banco.nm_Banco)
	ivo_Banco.nm_Banco = ""
	
	dw_1.Object.cd_Banco[1] = ivo_Banco.cd_banco
	dw_1.Object.nm_Banco[1] = ivo_Banco.nm_banco
End If

end subroutine

public function boolean wf_conecta_banco_rh ();Rubi = Create dc_uo_transacao
Rubi.ivs_DataBase = 'ORACLE_RH'

If Not Rubi.of_connect('vetorh_ti', gvo_Aplicacao.ivo_Seguranca.Cd_Sistema) Then
   Destroy(Rubi)
	Return False
End If

ivo_Func = Create dc_uo_ds_base
ivo_Func.of_SetTransObject(Rubi)

If Not ivo_Func.of_ChangeDataObject("ds_ge091_lista_cpf_funcionario") Then
	Destroy(ivo_Func)
	Return False
End If
				
Return True
end function

public function boolean wf_atualiza_informacoes ();Boolean lvb_Sucesso = True

Long lvl_Func,&
	 lvl_Linhas,&
	 lvl_Linha,&
	 lvl_Find 
	 
String lvs_CPF,&
	   lvs_Funcionario
	   
Any lvs_Teste

Decimal lvdc_CPF

ivo_Func.Retrieve()

lvl_Func   = ivo_Func.RowCount()
lvl_Linhas = dw_2.RowCount()

If lvl_Func > 0 Then
	
	For lvl_Linha = 1 To lvl_Linhas
		
		lvdc_CPF  = Dec(dw_2.Object.nr_cpf_cliente[lvl_Linha])
		
		lvl_Find  = ivo_Func.Find ("nr_cpf = " + String(lvdc_CPF), 1, lvl_Func )
	
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o CPF do funcion$$HEX1$$e100$$ENDHEX$$rio '" + String(lvl_Find) + "' .")
			lvb_Sucesso = False
			Exit
		Else
			If lvl_Find = 0 Then
				lvs_Funcionario = "N"
			Else
				lvs_Funcionario = "S"
			End If
		End If
		
		dw_2.Object.id_funcionario[lvl_Linha] = lvs_Funcionario
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum CPF de funcion$$HEX1$$e100$$ENDHEX$$rio foi encontrado.")
	lvb_Sucesso = False
End If

Return lvb_Sucesso 
end function

on w_ge091_relatorio_cheques_funcionarios.create
call super::create
end on

on w_ge091_relatorio_cheques_funcionarios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_filial) 
Destroy(ivo_portador)
Destroy(ivo_banco) 
Destroy(ivo_cliente) 
Destroy(ivo_Func)

Disconnect Using Rubi;
end event

event ue_postopen;call super::ue_postopen;
ivo_filial   = Create uo_Filial
ivo_portador = Create uo_Filial
ivo_banco    = Create uo_Banco
ivo_cliente  = Create uo_cliente_cheque

If Not wf_Conecta_Banco_RH() Then
	Close(This)
End If

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_preprint;call super::ue_preprint;String lvs_cpf,&
       lvs_nm_cliente,&
       lvs_cd_banco,&
		 lvs_nm_banco,&
		 lvs_nm_filial,&
		 lvs_nm_portador
		 
Long   lvl_filial,&
       lvl_portador

Date   lvdh_emissao_de,&
		 lvdh_emissao_ate,&
		 lvdh_vencto_de,&
		 lvdh_vencto_ate,&
		 lvdh_dev_de,&
		 lvdh_dev_ate,&
		 lvdh_baixa_de,&
		 lvdh_baixa_ate 
			
lvs_cpf          = dw_1.object.nr_cpf_cliente[1]
lvs_nm_cliente   = dw_1.object.nm_cliente    [1]

If LenA(Trim(lvs_cpf)) = 11 Then
	lvs_nm_cliente   = dw_1.object.nm_cliente[1] + " (" + String(lvs_cpf,'@@@.@@@.@@@-@@') + ")"
Else	
	lvs_nm_cliente   = dw_1.object.nm_cliente[1] + " (" + String(lvs_cpf,'@@.@@@.@@@/@@@@-@@') + ")"
End If	

lvl_filial       = dw_1.object.cd_filial[1]
lvs_nm_filial    = dw_1.object.nm_filial[1]

lvl_portador     = dw_1.object.cd_portador[1]
lvs_nm_portador  = dw_1.object.nm_portador[1]

lvs_cd_banco     = dw_1.object.cd_banco[1]
lvs_nm_banco     = dw_1.object.nm_banco[1]

lvdh_emissao_de  = dw_1.object.dh_emissao_de[1]
lvdh_emissao_ate = dw_1.object.dh_emissao_ate[1]
lvdh_vencto_de   = dw_1.object.dh_vencto_de[1]
lvdh_vencto_ate  = dw_1.object.dh_vencto_ate[1]
lvdh_dev_de      = dw_1.object.dh_devolucao_de[1]
lvdh_dev_ate     = dw_1.object.dh_devolucao_ate[1]
lvdh_baixa_de    = dw_1.object.dh_baixa_de[1]
lvdh_baixa_ate   = dw_1.object.dh_baixa_ate[1]

dw_3.object.st_cliente.text = lvs_nm_cliente

If Not IsNull(lvdh_emissao_de) or Not IsNull(lvdh_emissao_ate) Then
	dw_3.object.st_emissao.text    = String(lvdh_emissao_de ,'dd/mm/yyyy') + ' at$$HEX1$$e900$$ENDHEX$$ ' + String(lvdh_emissao_ate,'dd/mm/yyyy')
End If

If Not IsNull(lvdh_vencto_de) or Not IsNull(lvdh_vencto_ate) Then
	dw_3.object.st_vencimento.text = String(lvdh_vencto_de  ,'dd/mm/yyyy') + ' at$$HEX1$$e900$$ENDHEX$$ ' + String(lvdh_vencto_ate,'dd/mm/yyyy')
End If

If Not IsNull(lvdh_dev_de) or Not IsNull(lvdh_dev_ate) Then
	dw_3.object.st_devolucao.text  = String(lvdh_dev_de     ,'dd/mm/yyyy') + ' at$$HEX1$$e900$$ENDHEX$$ ' + String(lvdh_dev_ate,'dd/mm/yyyy')
End If

If Not IsNull(lvdh_baixa_de) or Not IsNull(lvdh_baixa_ate) Then
	dw_3.object.st_baixa.text      = String(lvdh_baixa_de   ,'dd/mm/yyyy') + ' at$$HEX1$$e900$$ENDHEX$$ ' + String(lvdh_baixa_ate,'dd/mm/yyyy')
End If
  
Return AncestorReturnValue
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge091_relatorio_cheques_funcionarios
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge091_relatorio_cheques_funcionarios
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge091_relatorio_cheques_funcionarios
integer x = 14
integer y = 480
integer width = 3552
integer height = 1208
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge091_relatorio_cheques_funcionarios
integer x = 14
integer y = 12
integer width = 3552
integer height = 440
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge091_relatorio_cheques_funcionarios
integer x = 50
integer y = 72
integer width = 2944
integer height = 364
string dataobject = "dw_ge091_selecao"
end type

event dw_1::ue_key;call super::ue_key;STRING lvs_Coluna

lvs_Coluna = This.GetColumnName()

Choose Case lvs_Coluna
		
	Case "nm_cliente"
	
		If Key = KeyEnter! Then	Wf_Localiza_Cliente()
		
	Case "nm_filial"
		
		If key = KeyEnter! Then	Wf_Localiza_Filial()
		
	Case "nm_banco"
	
		If Key = KeyEnter! Then	Wf_Localiza_Banco()

   Case "nm_portador"
	
		If Key = KeyEnter! Then	Wf_Localiza_Portador()

End Choose


end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "nm_cliente"
		
		If IsNull(data) or data = "" Then
					
			SetNull(ivo_cliente.nr_cpf)
			ivo_cliente.nm_cliente = ""
			
			This.Object.nr_cpf_cliente[row] = ivo_cliente.nr_cpf
			This.Object.nm_cliente    [row] = ivo_cliente.nm_cliente
			
		End If
		
		If data <> ivo_cliente.nm_cliente Then
			Return 1
		End If
		
	Case "nm_filial"
		
		If IsNull(data) or data = "" Then
					
			SetNull(ivo_Filial.cd_filial)			
			ivo_filial.nm_fantasia = ""
			
			This.Object.cd_filial[row] = ivo_filial.cd_filial
			This.Object.nm_filial[row] = ivo_filial.nm_fantasia
			
		End If
		
		If data <> ivo_filial.nm_fantasia Then
			Return 1
		End If	
		
	Case "nm_portador"
		
		If IsNull(data) or data = "" Then
					
			SetNull(ivo_Portador.cd_filial)			
			ivo_portador.nm_fantasia = ""
			
			This.Object.cd_portador[row] = ivo_portador.cd_filial
			This.Object.nm_portador[row] = ivo_portador.nm_fantasia
			
		End If
		
		If data <> ivo_portador.nm_fantasia Then
			Return 1
		End If		
		
	Case "nm_banco"
		
		If IsNull(data) or data = "" Then
					
			SetNull(ivo_banco.cd_banco)	
			ivo_banco.nm_banco = ""
			
			This.Object.cd_banco[row] = ivo_banco.cd_banco
			This.Object.nm_banco[row] = ivo_banco.nm_banco
			
		End If
		
		If data <> ivo_Banco.nm_banco Then
			Return 1
		End If			
				
End Choose		
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge091_relatorio_cheques_funcionarios
integer x = 37
integer y = 556
integer width = 3506
integer height = 1112
string dataobject = "dw_ge091_lista"
end type

event dw_2::constructor;call super::constructor;//SORT E FILTER DA CLASSE NOVA 
//CONSTRUCTOR DA DW_2

String lvs_Coluna[], &
       lvs_Nome[]
		 
//lvs_Coluna = {"nm_cliente", "cd_banco","nr_agencia","nr_conta","nr_cheque","vl_cheque", &
//              "dh_emissao","dh_vencimento","dh_devolucao","dh_baixa"}
//
//lvs_Nome = {"cliente","banco","ag$$HEX1$$ea00$$ENDHEX$$ncia","conta","cheque","valor do cheque","emiss$$HEX1$$e300$$ENDHEX$$o", &
//            "vencimento","devolu$$HEX2$$e700e300$$ENDHEX$$o","baixa"}
//
//This.of_SetSort(lvs_Coluna, lvs_Nome)
//This.of_SetFilter(lvs_Coluna, lvs_Nome)
//
This.of_SetRowSelection("","If (  IsNull( dh_baixa ) and Not IsNull(  dh_devolucao ), 255 , rgb(0,0,0) )")


end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long     lvl_filial,&
         lvl_portador

String   lvs_banco,&
         lvs_cpf,&
			lvs_id_baixa
			
Date   	lvdh_emissao_de,&
			lvdh_emissao_ate,&
			lvdh_vencto_de,&
			lvdh_vencto_ate,&
			lvdh_dev_de,&
			lvdh_dev_ate,&
			lvdh_baixa_de,&
			lvdh_baixa_ate
			
dw_1.AcceptText()			
			
lvs_cpf          = dw_1.object.nr_cpf_cliente  [1]
lvl_filial       = dw_1.object.cd_filial       [1]
lvl_portador     = dw_1.object.cd_portador     [1]
lvs_banco        = dw_1.object.cd_banco        [1]
//lvs_Id_Baixa     = dw_1.Object.id_baixa        [1]

lvdh_emissao_de  = dw_1.object.dh_emissao_de   [1]
lvdh_emissao_ate = dw_1.object.dh_emissao_ate  [1]
lvdh_vencto_de   = dw_1.object.dh_vencto_de    [1]
lvdh_vencto_ate  = dw_1.object.dh_vencto_ate   [1]
lvdh_dev_de      = dw_1.object.dh_devolucao_de [1]
lvdh_dev_ate     = dw_1.object.dh_devolucao_ate[1]
lvdh_baixa_de    = dw_1.object.dh_baixa_de     [1]
lvdh_baixa_ate   = dw_1.object.dh_baixa_ate    [1]

dw_2.SetFilter("")
dw_2.Filter()

If Not IsNull(lvs_cpf) and Trim(lvs_cpf) <> '' Then
	This.of_AppendWhere("cheque.nr_cpf_cliente = '" + lvs_cpf + "'")
End If	

If Not IsNull(lvl_filial) and lvl_filial <> 0 Then
	This.of_AppendWhere("cheque.cd_filial_inclusao = " + String(lvl_filial))
End If	

If Not IsNull(lvl_portador) and lvl_portador <> 0 Then
	This.of_AppendWhere("cheque.cd_portador = " + String(lvl_portador))
End If	

If Not IsNull(lvs_banco) and Trim(lvs_banco) <> '' Then
	This.of_AppendWhere("cheque.cd_banco = '" + lvs_banco + "'")
End If	

If Not IsNull(lvdh_emissao_de)Then
	This.of_AppendWhere("cheque.dh_emissao >= '" + String(lvdh_emissao_de,'yyyy/mm/dd') + "'")
End If	

If Not IsNull(lvdh_emissao_ate)Then
	This.of_AppendWhere("cheque.dh_emissao <= '" + String(lvdh_emissao_ate,'yyyy/mm/dd') + "'")
End If	

If Not IsNull(lvdh_vencto_de)Then
	This.of_AppendWhere("cheque.dh_vencimento >= '" + String(lvdh_vencto_de,'yyyy/mm/dd') + "'")
End If	

If Not IsNull(lvdh_vencto_ate)Then
	This.of_AppendWhere("cheque.dh_vencimento <= '" + String(lvdh_vencto_ate,'yyyy/mm/dd') + "'")
End If	

If Not IsNull(lvdh_dev_de)Then
	This.of_AppendWhere("cheque.dh_devolucao >= '" + String(lvdh_dev_de,'yyyy/mm/dd') + "'")
End If	

If Not IsNull(lvdh_dev_ate)Then
	This.of_AppendWhere("cheque.dh_devolucao <= '" + String(lvdh_dev_ate,'yyyy/mm/dd') + "'")
End If	

If Not IsNull(lvdh_dev_de) or &
   Not IsNull(lvdh_dev_ate) Then
	This.of_AppendWhere("cheque.dh_baixa is null")
End If

If Not IsNull(lvdh_baixa_de) Then
	This.of_AppendWhere("cheque.dh_baixa >= '" + String(lvdh_baixa_de,'yyyy/mm/dd') + "'")
End If

If Not IsNull(lvdh_baixa_ate) Then
	This.of_AppendWhere("cheque.dh_baixa <= '" + String(lvdh_baixa_ate,'yyyy/mm/dd') + "'")
End If

//// Baixado
//If lvs_id_baixa = 'B' Then
//	This.of_AppendWhere('cheque.dh_baixa is not null')	
////Nao Baixado
//ElseIf lvs_id_baixa = 'N' Then 
//	This.of_AppendWhere('cheque.dh_baixa is null')
//End IF	

dw_2.SetRedraw(False)

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;// Habilita o bot$$HEX1$$e300$$ENDHEX$$o imprimir, mesmo sem linha para impress$$HEX1$$e300$$ENDHEX$$o

Parent.ivm_Menu.mf_Imprimir(True)

If pl_linhas > 0 Then
	
	dw_2.SetRedraw(False)
	
	dw_1.AcceptText()
	
	Long lvl_Linha
	
	dw_3.Event ue_Retrieve()
		
	lvl_Linha = dw_3.RowCount()
		
	If lvl_Linha > 0 Then
		ivm_Menu.mf_SalvarComo(True)
	End If	
	
	If Not wf_Atualiza_Informacoes() Then Return -1		
	
	dw_2.SetRedraw(True)
	
	dw_2.SetFilter("id_funcionario = 'S'")
	dw_2.Filter()

	dw_2.GroupCalc()
	
Else
	ivm_Menu.mf_SalvarComo(False)
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge091_relatorio_cheques_funcionarios
integer x = 3031
integer y = 104
integer width = 398
integer height = 228
string dataobject = "dw_ge091_relatorio"
end type

