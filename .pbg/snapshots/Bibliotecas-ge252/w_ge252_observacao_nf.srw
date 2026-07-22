HA$PBExportHeader$w_ge252_observacao_nf.srw
forward
global type w_ge252_observacao_nf from dc_w_response_ok_cancela
end type
type st_alerta from statictext within w_ge252_observacao_nf
end type
end forward

global type w_ge252_observacao_nf from dc_w_response_ok_cancela
string tag = "w_ge252_observacao_nf"
integer width = 2098
integer height = 952
string title = "GE252 - Motivo da Devolu$$HEX2$$e700e300$$ENDHEX$$o e Volume"
st_alerta st_alerta
end type
global w_ge252_observacao_nf w_ge252_observacao_nf

type variables

String ivs_motivo

String ivs_fantasia
String ivs_cidade
String ivs_uf
String ivs_cgc
String ivs_cpf
String ivs_nr_inscricao
String ivs_endereco
String ivs_transportadora
String ivs_fornecedor_aux



end variables

forward prototypes
public function boolean wf_localiza_transporte (string as_fornecedor)
public subroutine wf_limpa_campos ()
public function boolean wf_carrega_combo_transpotadora (string as_fornecedor)
public subroutine wf_insere_padrao ()
end prototypes

public function boolean wf_localiza_transporte (string as_fornecedor);
wf_limpa_campos() 
	
// Consulta dados do Transportador Na Open	
Select  top 1 b.nm_razao_social , c.nm_cidade, c.cd_unidade_federacao, b.nr_cgc,b.nr_cpf, b.nr_inscricao_estadual, (b.de_endereco+','+cast(b.nr_endereco as char)), b.cd_fornecedor 
Into 	 :ivs_fantasia,	:ivs_cidade,:ivs_uf,	:ivs_cgc,	:ivs_cpf,	:ivs_nr_inscricao,	:ivs_endereco, :ivs_transportadora
From   fornecedor_transportadora a
inner join fornecedor b on a.cd_transportadora  = b.cd_fornecedor
inner join cidade c on c.cd_cidade = b.cd_cidade
where  a.cd_fornecedor in (:as_fornecedor)
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar dados da transportadora")
	Return False
Else
	// Carrega dados na Dw - Transporte
		dw_1.object.nm_razao_social	[1]	= ivs_fantasia
		dw_1.object.cd_transportador	[1]	= ivs_transportadora
		dw_1.object.nm_cidade			[1]	= ivs_cidade
		dw_1.object.nm_uf				[1]	= ivs_uf
		dw_1.object.nr_cnpj				[1]	= ivs_cgc
		dw_1.object.nr_inscricao_uf		[1]	= ivs_nr_inscricao
		dw_1.object.nm_endereco		[1]	= ivs_endereco
		dw_1.object.nr_cpf				[1]	= ivs_cpf				
End If 

Return True


end function

public subroutine wf_limpa_campos ();

SetNull(ivs_fantasia)
SetNull(ivs_cidade)
SetNull(ivs_uf)
SetNull(ivs_cgc)
SetNull(ivs_cpf)
SetNull(ivs_nr_inscricao)
SetNull(ivs_endereco)
SetNull(ivs_transportadora)
SetNull(ivs_motivo)

end subroutine

public function boolean wf_carrega_combo_transpotadora (string as_fornecedor);DataWindowChild lvdwc

String ls_SQL
	
If dw_1.GetChild("cd_transportador", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
	
	ls_SQL = " select a.cd_fornecedor, a.nm_razao_social, "+&
				" (case when a.id_fisica_juridica = 'J' then "+&
				"	case when len(a.nr_cgc)=14 then substring(a.nr_cgc,1,2)||'.'||substring(a.nr_cgc,3,3)||'.'||substring(a.nr_cgc,6,3)||'/'||substring(a.nr_cgc,9,4)||'-'||substring(a.nr_cgc,13,2) "+&
				"	else '' end  "+&
				" else "+&
				"	case when len(a.nr_cpf)=11 then substring(a.nr_cpf,1,3)||'.'||substring(a.nr_cpf,4,3)||'.'||substring(a.nr_cpf,7,3)||'-'||substring(a.nr_cpf,10,2) "+&
				"	else '' end "+&
				" end) as cnpj_numero "+&
				" from fornecedor a " +&
				" inner join fornecedor_transportadora b on a.cd_fornecedor = b.cd_transportadora  " +& 
				" where a.id_fornecedor_transportadora is not null       "+&
				" and b.cd_fornecedor   in ( " + as_fornecedor + ")"

	
	lvdwc.SetSQLSelect(ls_SQL)
		
	lvdwc.Retrieve()
	wf_Insere_Padrao()
	Return True 
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild transportador.")
	Return False
End If




end function

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child
dw_1.Object.cd_transportador  [1] = "0"
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_transportador" )			
ldwc_Child.SetItem(1, "cd_fornecedor", "0")
ldwc_Child.SetItem(1, "nm_razao_social", "NENHUM TRANSPORTADOR DA LISTA")
end subroutine

on w_ge252_observacao_nf.create
int iCurrent
call super::create
this.st_alerta=create st_alerta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_alerta
end on

on w_ge252_observacao_nf.destroy
call super::destroy
destroy(this.st_alerta)
end on

event ue_postopen;call super::ue_postopen;// Verifica Parametro Ativo e Fornecedor Associado
If len(ivs_fornecedor_aux) > 11  Then
	st_alerta.Visible = True
	If wf_carrega_combo_transpotadora(ivs_fornecedor_aux) Then 
		dw_1.object.cd_transportador.protect = 0
	End If 
ElseIf If_fornecedor_transporte(Mid(ivs_fornecedor_aux, 2, 9)) Then 
   	If wf_carrega_combo_transpotadora(ivs_fornecedor_aux) Then 
		dw_1.object.cd_transportador.protect = 0
	End If 
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O Fornecedor n$$HEX1$$e300$$ENDHEX$$o tem Transportador associado. Solicite a configura$$HEX2$$e700e300$$ENDHEX$$o para coordena$$HEX2$$e700e300$$ENDHEX$$o!~rMenu: Cadastro > Vincular Fornecedor ao Transportador.")
	wf_insere_padrao()
	dw_1.object.cd_transportador.protect = 1
	Return 
End If 
	
end event

event open;call super::open;String ls_Parametro
ls_Parametro = Message.StringParm	
ivs_fornecedor_aux = trim(ls_Parametro) //Mid(ls_Parametro, 1, 9)


end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge252_observacao_nf
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge252_observacao_nf
integer width = 2039
integer height = 844
string text = "Observa$$HEX2$$e700e300$$ENDHEX$$o e Transporte da NF de Devolu$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge252_observacao_nf
integer y = 88
integer width = 1961
integer height = 620
string dataobject = "dw_ge252_observacao_nf"
end type

event dw_1::itemchanged;call super::itemchanged;String ls_Dado
ls_Dado = dwo.name

If	ls_Dado = 'cd_transportador' Then 
	// Quando Selecionar : Nenhum da Lista
	If Long(data)=0  Then 		
		dw_1.object.nm_cidade			[1]	= ''
		dw_1.object.nm_uf				[1]	= ''
		dw_1.object.nr_cnpj				[1]	= ''
		dw_1.object.nr_inscricao_uf		[1]	= ''
		dw_1.object.nm_endereco		[1]	= ''
		dw_1.object.nr_cpf				[1]	= ''
		dw_1.object.cd_transportador	[1]	= '0'	
		//st_texto.text  = "Nota sera gerada/enviada sem o Transportador!"
	Else
		// Quando Selecionar outro Transportador
		Select  top 1 b.nm_razao_social , c.nm_cidade, c.cd_unidade_federacao, b.nr_cgc,b.nr_cpf, b.nr_inscricao_estadual, (b.de_endereco+','+cast(b.nr_endereco as char)), b.cd_fornecedor 
		Into 	 :ivs_fantasia,	:ivs_cidade,:ivs_uf,	:ivs_cgc,	:ivs_cpf,	:ivs_nr_inscricao,	:ivs_endereco, :ivs_transportadora
		From   fornecedor_transportadora a
		inner join fornecedor b on a.cd_transportadora  = b.cd_fornecedor
		inner join cidade c on c.cd_cidade = b.cd_cidade
		where  a.cd_transportadora=:data
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao localizar dados da transportadora")
			Return -1
		Else
			// Carrega dados na Dw - Transporte
			dw_1.object.nm_razao_social	[1]	= ivs_fantasia
			dw_1.object.cd_transportador	[1]	= ivs_transportadora
			dw_1.object.nm_cidade			[1]	= ivs_cidade
			dw_1.object.nm_uf				[1]	= ivs_uf
			dw_1.object.nr_cnpj				[1]	= ivs_cgc
			dw_1.object.nr_inscricao_uf		[1]	= ivs_nr_inscricao
			dw_1.object.nm_endereco		[1]	= ivs_endereco
			dw_1.object.nr_cpf				[1]	= ivs_cpf		
			//st_texto.text   = "Nota sera gerada/enviada com o Transportador selecionado!"
		End If 		
	End If
End If 
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge252_observacao_nf
integer x = 1339
integer y = 708
integer width = 315
integer weight = 700
end type

event cb_ok::clicked;call super::clicked;String ls_Observacao
String ls_Transportador
String ls_Valor

dw_1.AcceptText( )

//io_Nota.il_Motivo_Devolucao 	=	dw_1.Object.cd_motivo_devolucao	[1]
//io_Nota.is_Motivo_Devolucao 	= 	dw_1.Object.de_motivo_devolucao	[1]
//io_Nota.idc_peso_bruto			=	dw_1.Object.qt_peso_bruto				[1]
//io_Nota.idc_peso_liquido		= 	dw_1.Object.qt_peso_liquido				[1]
//io_Nota.is_Numero_Volume	= 	dw_1.Object.nr_volume						[1]
//io_Nota.is_Marca_Volume		= 	dw_1.Object.de_marca_volume			[1]
//io_Nota.is_Especie_Volume		= 	dw_1.Object.de_especie_volume		[1]
//io_Nota.il_Qtde_Volume			= 	dw_1.Object.qt_volume						[1]
//
//If IsNull(io_Nota.il_Motivo_Devolucao) Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo da devolu$$HEX2$$e700e300$$ENDHEX$$o.")
//	dw_1.Event ue_Pos(1, "cd_motivo_devolucao")
//	Return
//End If

//If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o da nota fiscal de devolu$$HEX2$$e700e300$$ENDHEX$$o ?", Question!, YesNo!, 2) = 1 Then
//	io_Nota.ib_Processo_Motivo_Transporte_Canc = False
//Else
//	io_Nota.ib_Processo_Motivo_Transporte_Canc = True
//End If

ls_Observacao 		= dw_1.Object.de_observacao[1]
ls_Transportador 	= dw_1.Object.cd_transportador[1]

If IsNull(ls_Observacao) Then ls_Observacao = ''

ls_Valor				= ls_Transportador + ';' +ls_Observacao 

CloseWithReturn(Parent, ls_Valor)



end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge252_observacao_nf
integer x = 1687
integer y = 708
integer width = 315
end type

type st_alerta from statictext within w_ge252_observacao_nf
boolean visible = false
integer x = 82
integer y = 684
integer width = 1248
integer height = 144
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "ATEN$$HEX2$$c700c300$$ENDHEX$$O: A Observa$$HEX2$$e700e300$$ENDHEX$$o e Transporte selecionados ser$$HEX1$$e300$$ENDHEX$$o registrados para todos os agrupamentos marcados como resolvidos!"
boolean focusrectangle = false
end type

