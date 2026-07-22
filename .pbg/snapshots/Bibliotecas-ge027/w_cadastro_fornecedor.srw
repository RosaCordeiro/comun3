HA$PBExportHeader$w_cadastro_fornecedor.srw
forward
global type w_cadastro_fornecedor from w_1dw_cadastro_freeform
end type
type gb_1 from groupbox within w_cadastro_fornecedor
end type
end forward

global type w_cadastro_fornecedor from w_1dw_cadastro_freeform
int Width=1874
int Height=1628
boolean TitleBar=true
string Title="GE027 - Cadastro de Fornecedores"
long BackColor=80269524
gb_1 gb_1
end type
global w_cadastro_fornecedor w_cadastro_fornecedor

type variables
Uo_Fornecedor                 ivo_fornecedor
uo_Cidade                         ivo_Cidade_Fornecedor
uo_Condicao_Pagamento ivo_Condicao
end variables

forward prototypes
public subroutine wf_localiza_fornecedor ()
public subroutine wf_localiza_cidade ()
public subroutine wf_nome_cidade_fornecedor (string ps_cidade)
public function integer wf_consiste_salva ()
public subroutine wf_localiza_condicao_pagamento ()
end prototypes

public subroutine wf_localiza_fornecedor ();STRING lvs_fornecedor

lvs_fornecedor = dw_1.GetText()

ivo_fornecedor.Of_Localiza_fornecedor(lvs_fornecedor)

If ivo_fornecedor.Localizado Then
	
	dw_1.Object.cd_fornecedor[1]      = ivo_fornecedor.cd_fornecedor
   dw_1.Object.nm_razao_social[1]    = ivo_fornecedor.nm_fantasia
	dw_1.Event pfc_Retrieve()
	dw_1.Object.Nm_localiza[1]        = ''
	
	ivm_Menu_Janela.m_Editar.m_incluir.Enabled = True
	
	
End If

end subroutine

public subroutine wf_localiza_cidade ();String lvs_Cidade

// Verifica qual o par$$HEX1$$e200$$ENDHEX$$metros digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio
lvs_Cidade = dw_1.GetText()

ivo_Cidade_fornecedor.of_Localiza_Cidade(lvs_Cidade)

If ivo_Cidade_Fornecedor.Localizada Then
	dw_1.Object.Cd_Cidade[1] = ivo_Cidade_Fornecedor.cd_cidade
	dw_1.Object.Nm_Cidade[1] = ivo_Cidade_Fornecedor.nm_cidade
End If
end subroutine

public subroutine wf_nome_cidade_fornecedor (string ps_cidade);ivo_Cidade_fornecedor.of_Localiza_Cidade(ps_cidade)

// Alimenta o nome da cidade do cliente
If ivo_Cidade_Fornecedor.Localizada Then
	dw_1.Object.Nm_Cidade[1] = ivo_Cidade_Fornecedor.Nm_Cidade
End If

end subroutine

public function integer wf_consiste_salva ();Integer lvi_Retorno, &
        lvi_Retorno_Salva

SetPointer(HourGlass!)

// Verifica se houve altera$$HEX2$$e700e300$$ENDHEX$$o na DW de detalhes
lvi_Retorno_Salva = wf_Salva()

Choose Case lvi_Retorno_Salva
	Case OK_SEM_PENDENCIAS, &
		  OK_COM_PENDENCIAS, &
		  OK_SUCESSO_UPDATE, &
		  OK_SEM_UPDATE
		  
		// Desabilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False
		ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = False
		
		// Continua
		lvi_Retorno = 1
	Case CANCELAR_ERRO_PENDENCIAS, &
		  CANCELAR_ERRO_UPDATE

		// Desabilita a fun$$HEX2$$e700e300$$ENDHEX$$o de confirma$$HEX2$$e700e300$$ENDHEX$$o
		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False

		// N$$HEX1$$e300$$ENDHEX$$o permite
		lvi_Retorno = 0
	Case CANCELAR_UPDATE

		// N$$HEX1$$e300$$ENDHEX$$o permite
		lvi_Retorno = 0
End Choose

Return lvi_Retorno
end function

public subroutine wf_localiza_condicao_pagamento ();// Verifica qual o par$$HEX1$$e200$$ENDHEX$$metros digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

If ivo_Condicao.of_Localiza(dw_1.GetText()) Then
	dw_1.Object.Cd_Condicao_Pagamento[1] = ivo_Condicao.cd_Condicao
	dw_1.Object.De_Condicao_Pagamento[1] = ivo_Condicao.de_Condicao
End If
end subroutine

on w_cadastro_fornecedor.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on w_cadastro_fornecedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
end on

event close;call super::close;Destroy(ivo_fornecedor)
Destroy(ivo_Cidade_Fornecedor)
Destroy(ivo_Condicao)
end event

event pfc_postopen;call super::pfc_postopen;ivo_Fornecedor        =  Create Uo_Fornecedor
ivo_Cidade_Fornecedor = Create uo_Cidade
ivo_Condicao 			 = Create uo_Condicao_Pagamento

ivb_Menu_Exclusao = False

end event

event pfc_preupdate;call super::pfc_preupdate;SetPointer(HourGlass!)

String lvs_tipo, lvs_inscricao, lvs_cpf, lvs_cgc
Long lvl_linha

// Faz consist$$HEX1$$ea00$$ENDHEX$$ncia de digita$$HEX2$$e700e300$$ENDHEX$$o de cpf, cgc e inscri$$HEX2$$e700e300$$ENDHEX$$o estadual
lvl_linha = dw_1.GetRow()

If lvl_Linha < 1 Then Return 1

lvs_tipo = dw_1.Object.id_fisica_juridica[lvl_linha]
lvs_cpf =  dw_1.Object.nr_cpf[lvl_linha]
lvs_cgc =  dw_1.Object.nr_cgc[lvl_linha]
lvs_inscricao = dw_1.Object.nr_inscricao_estadual[lvl_linha]

If lvs_tipo = 'F' Then
	If IsNull(lvs_cpf) or Trim(lvs_cpf) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar o CPF.", Information!, Ok!)
		dw_1.SetColumn("nr_cpf")
		dw_1.Setfocus()
		Return -1
	End If
Else
	If (IsNull(lvs_cgc) or Trim(lvs_cgc) = "" ) or &
	   (IsNull(lvs_inscricao) or Trim(lvs_inscricao) = "") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor conferir a Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual e o CGC.", Information!, Ok!)
		dw_1.SetColumn("nr_inscricao_estadual")
		dw_1.Setfocus()
		Return -1
	End If
End If

Return 1
end event

event cancelar;call super::cancelar;// Chama os eventos cancelar das data windows
dw_1.Event Cancelar()

end event

type dw_1 from w_1dw_cadastro_freeform`dw_1 within w_cadastro_fornecedor
int X=41
int Y=56
int Width=1760
int Height=1352
boolean BringToTop=true
string DataObject="dw_detalhe_fornecedor"
end type

event dw_1::tecla;call super::tecla;String  lvs_coluna

lvs_coluna = This.GetColumnName()
If lvs_coluna = "nm_localiza" Then
   
	If Key = KeyEnter! Then
 		wf_Localiza_Fornecedor()		 
	End If
	
ElseIf lvs_coluna = 'nm_cidade' Then 
	
	If key = KeyEnter! Then
		wf_localiza_cidade()
	End If 

ElseIf  lvs_coluna = 'de_condicao_pagamento' Then 
	
	If key = KeyEnter! Then
		wf_localiza_condicao_pagamento()
	End If 
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name 
	Case "nr_cgc"	
		If Not ( gf_CGC_Valido( data ) ) Then 		
			// CGC Invalido, continua com foco no campo CGC //
			RETURN 1 		  
		End If
	  
	Case "nr_cpf"	  
		If Not ( gf_Nr_CPF_Valido( data ) ) Then 		
			// CGC Invalido, continua com foco no campo CGC //
			RETURN 1 		  
		End If
		
	Case "id_fisica_juridica"		
		If data = "F"  Then 			
			This.Object.Nr_CGC[1] = ''
			This.Object.nr_inscricao_estadual[1] = ''			
		Else			
			This.Object.Nr_CPF[1] = ''			
		End If 	
		
	Case "nm_cidade" 
		If data <> ivo_cidade_fornecedor.nm_cidade or &
			IsNull(ivo_cidade_fornecedor.nm_cidade) Then
			Return 1
		End If 
		
	Case "de_condicao_pagamento" 
		If Not IsNull(Data) and Trim(data) <> "" Then
			
			If data <> ivo_Condicao.de_Condicao or &
				IsNull(ivo_Condicao.de_Condicao) Then
				Return 1
			End If 
			
		Else
			
			ivo_Condicao.of_Inicializa()
			This.Object.Cd_Condicao_Pagamento[1] = ivo_Condicao.Cd_Condicao
			This.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
			
		End If
		
End Choose

ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled  = True

end event

event dw_1::editchanged;call super::editchanged;If dwo.name = "nm_localiza" Then
	ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False
	ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled  = False
End If

end event

event dw_1::itemerror;call super::itemerror;Return 1
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Cidade_Fornecedor) Then
	This.Object.nm_Cidade[1] = ivo_Cidade_Fornecedor.Nm_Cidade
End If

If IsValid(ivo_Condicao) Then
	This.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
End If
end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;String lvs_Fornecedor, &
		 lvs_cd_cidade
		 
Integer lvi_Linha , &
		  lvi_Cd_Condicao


// Set nulo o nome da cidade Anterior
SetNull(ivo_fornecedor.nm_fantasia)

This.AcceptText()
lvs_Fornecedor  = This.Object.Cd_Fornecedor			[1]

If LenA(Trim(lvs_Fornecedor)) = 9 Then
	lvi_Linha = This.Retrieve(lvs_fornecedor)

	If lvi_Linha < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor " + lvs_fornecedor+ " n$$HEX1$$e300$$ENDHEX$$o localizado.", Information!, Ok!)
	End If
	
	// Alimenta a vari$$HEX1$$e100$$ENDHEX$$vel de inst$$HEX1$$e200$$ENDHEX$$ncia da cidade de cliente
	lvs_cd_cidade = String(This.Object.cd_cidade[1])
	If Trim(lvs_cd_cidade) <> '' and Not IsNull(lvs_cd_cidade) Then 
		wf_nome_cidade_fornecedor(lvs_cd_cidade)
	End If
	
	lvi_Cd_Condicao = This.Object.Cd_Condicao_Pagamento[1]
	
	If ivo_Condicao.of_Localiza_Codigo(lvi_Cd_Condicao) Then
		dw_1.Object.de_condicao_pagamento[1] = ivo_Condicao.De_Condicao
	End If
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do fornecedor inv$$HEX1$$e100$$ENDHEX$$lido. Retrieve cancelado.", StopSign!, Ok!)
End If

// Alimenta a vari$$HEX1$$e100$$ENDHEX$$vel cancelar
ivi_tipo_cancelar = RETRIEVE
Return lvi_Linha
end event

event dw_1::constructor;call super::constructor;// Array de colunas que n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o atualizaveis
ivs_colunas_sem_closequery = {"nm_localiza"}
ivi_Tipo_Cancelar = 0

end event

event dw_1::pfc_preinsertrow;call super::pfc_preinsertrow;Integer lvi_Retorno

lvi_Retorno = wf_Consiste_Salva()

If lvi_Retorno = 1 Then
	This.Reset()
	
	// Apaga o Nome do Cliente Anterior
	If IsValid(ivo_fornecedor) Then
		 ivo_fornecedor.nm_razao_social = ''
	End If

	// Apaga a Cidade Anterior do Cliente 
	If	IsValid(ivo_cidade_fornecedor) Then
		ivo_cidade_fornecedor.nm_cidade = ''
	End If

End If

Return lvi_Retorno
end event

event dw_1::pfc_updateprep;call super::pfc_updateprep;String lvs_Proximo_Fornecedor, &
       lvs_Ultimo_Fornecedor

Long lvl_Ultimo_Sequencial, &
     lvl_Filial

If IsNull(This.Object.Cd_Fornecedor[1]) Then
	
	lvl_Filial = gvo_Parametro.of_Filial()
	
	Select max(cd_fornecedor) Into :lvs_Ultimo_Fornecedor
	From fornecedor
	Where cd_filial = :lvl_Filial;
	
	If SqlCa.SqlCode = 0 Then
		If IsNull(lvs_Ultimo_Fornecedor) Then
			lvl_Ultimo_Sequencial = 0
		Else
			lvl_Ultimo_Sequencial = Long(RightA(lvs_Ultimo_Fornecedor, 5))
		End If
		
		lvs_Proximo_Fornecedor = String(lvl_Filial, "0000") + String(lvl_Ultimo_Sequencial + 1, "00000")
		
		This.Object.Cd_Fornecedor[1] = lvs_Proximo_Fornecedor
		This.Object.Cd_Filial[1]     = lvl_Filial
		
		Return 1
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro durante a determina$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo do fornecedor.", StopSign!, Ok!)
		Return -1
	End If
Else
	Return 1
End If



end event

type gb_1 from groupbox within w_cadastro_fornecedor
int X=23
int Width=1792
int Height=1428
int TabOrder=10
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

