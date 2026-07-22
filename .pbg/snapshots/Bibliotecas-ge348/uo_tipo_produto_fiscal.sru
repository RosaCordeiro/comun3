HA$PBExportHeader$uo_tipo_produto_fiscal.sru
forward
global type uo_tipo_produto_fiscal from nonvisualobject
end type
end forward

global type uo_tipo_produto_fiscal from nonvisualobject
end type
global uo_tipo_produto_fiscal uo_tipo_produto_fiscal

type variables
Boolean Localizado = False

Long Cd_Tipo_Produto_Fiscal
String De_Tipo_Produto_Fiscal
Long Cd_Tipo_Produto
String De_Tipo_Produto

Private:
uo_tributacao_icms ivo_Tributacao_ICMS
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_codigo (long pl_tipo_prod_fiscal)
public function boolean of_localiza (string ps_parametro, string ps_uf)
public function boolean of_localiza (string ps_parametro, string ps_uf, long pl_ncm)
public function boolean of_localiza_generico (string ps_parametro, string ps_uf, long pl_ncm)
public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref long pl_tipo_produto)
public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref string ps_antecipa_icms)
public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref long pl_tipo_produto, ref long pl_tipo_produto_fiscal)
public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref long pl_tipo_produto, ref long pl_tipo_produto_fiscal, ref string ps_antecipacao_icms, ref decimal pdc_mva_antecipacao_icms)
public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref long pl_tipo_produto, ref long pl_tipo_produto_fiscal, ref string ps_permissao_transferencia, ref long pl_mensagem_transferencia, ref string ps_permissao_devolucao, ref long pl_mensagem_devolucao)
public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref long pl_tipo_produto, ref long pl_tipo_produto_fiscal, ref string ps_antecipa_icms, ref decimal pdc_mva_antecipa_icms, ref string ps_permissao_transferencia, ref long pl_mensagem_transferencia, ref string ps_permissao_devolucao, ref long pl_mensagem_devolucao)
private function boolean of_filial_matriz ()
public function boolean of_grupo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao, ref long pl_grupo)
public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_ncm, ref long pl_tipo_produto, ref long pl_tipo_produto_fiscal, ref string ps_antecipa_icms, ref decimal pdc_mva_antecipa_icms, ref string ps_permissao_transferencia, ref long pl_mensagem_transferencia, ref string ps_permissao_devolucao, ref long pl_mensagem_devolucao)
public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_ncm, ref long pl_tipo_produto)
end prototypes

public subroutine of_inicializa ();Localizado = False

SetNull( Cd_Tipo_Produto_Fiscal )
SetNull( De_Tipo_Produto_Fiscal )
SetNull( Cd_Tipo_Produto )
SetNull( De_Tipo_Produto )
end subroutine

public function boolean of_localiza (string ps_parametro);Return This.of_localiza( ps_parametro, '')
end function

public function boolean of_localiza_codigo (long pl_tipo_prod_fiscal);Select tf.cd_tipo_produto_fiscal,
		 tf.de_tipo_produto_fiscal,
		 t.cd_tipo_produto,
		 t.de_tipo_produto
Into 	:Cd_Tipo_Produto_Fiscal,
		:De_Tipo_Produto_Fiscal,
		:Cd_Tipo_Produto,
		:De_Tipo_Produto
From tipo_produto_fiscal tf
inner join tipo_produto t
	on t.cd_tipo_produto = tf.cd_tipo_produto
Where cd_tipo_produto_fiscal = :pl_tipo_prod_fiscal
Using SQLCa;

This.Localizado = ( SQLCa.SQLCode = 0)

If SQLCa.SQLCode = -1 Then
	SQLCa.of_msgdberror('Localizar informa$$HEX2$$e700f500$$ENDHEX$$es tipo produto fiscal.')
End If

Return This.Localizado
end function

public function boolean of_localiza (string ps_parametro, string ps_uf);Long lvl_NCM

SetNull(lvl_NCM)

Return This.Of_localiza( ps_parametro, ps_uf, lvl_NCM)
end function

public function boolean of_localiza (string ps_parametro, string ps_uf, long pl_ncm);This.Of_inicializa( )

If IsNumber(ps_parametro) Then
	This.Of_localiza_codigo( Long( ps_parametro ) )
End If

If Not This.Localizado Then
	This.Of_localiza_generico( ps_parametro, ps_uf, pl_ncm)
End If

Return This.Localizado
end function

public function boolean of_localiza_generico (string ps_parametro, string ps_uf, long pl_ncm);String lvs_Parametro

This.Of_inicializa( )

lvs_Parametro = ps_parametro+';'
lvs_Parametro += IIF(IsNull(ps_uf),"",ps_uf)+';'
lvs_Parametro += IIF(IsNull(pl_ncm),"",String(pl_ncm))

OpenWithParm(w_ge348_selecao_tipo_prod_fiscal,lvs_Parametro)

lvs_Parametro = Message.StringParm

If (Trim(lvs_Parametro)<>"") and (IsNumber(lvs_Parametro)) Then 
	This.Of_localiza_codigo( Long( lvs_Parametro ) )
End If

Return This.Localizado
end function

public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref long pl_tipo_produto);Long lvl_tipo_produto_fiscal

Return This.of_tipo_produto_fiscal_uf( 	ps_uf									, &
													pl_produto							, &
													ps_tributacao_icms				, &
													pl_tipo_produto						, &
													lvl_tipo_produto_fiscal)
end function

public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref string ps_antecipa_icms);Long lvl_Tipo_Produto
Long lvl_Tipo_Produto_Fiscal
Decimal lvdc_MVA																		

SetNull(ps_antecipa_icms)

Return This.of_tipo_produto_fiscal_uf(	ps_uf							, &
													pl_produto					, &
													ps_tributacao_icms		, &													
													lvl_Tipo_Produto			, &
													lvl_Tipo_Produto_Fiscal	, &
													ps_antecipa_icms			, &
													lvdc_MVA)
end function

public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref long pl_tipo_produto, ref long pl_tipo_produto_fiscal);String lvs_Antecipa_ICMS

Decimal lvdc_mva_antecipacao_icms

Return This.of_tipo_produto_fiscal_uf( 	ps_uf									, &
													pl_produto							, &
													ps_tributacao_icms				, &		
													pl_tipo_produto						, &
													pl_tipo_produto_fiscal				, &
													lvs_Antecipa_ICMS				, &
													lvdc_mva_antecipacao_icms	)
end function

public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref long pl_tipo_produto, ref long pl_tipo_produto_fiscal, ref string ps_antecipacao_icms, ref decimal pdc_mva_antecipacao_icms);String lvs_permissao_transferencia
String lvs_permissao_devolucao

Long lvl_mensagem_transferencia
Long lvl_mensagem_devolucao 

Return This.of_tipo_produto_fiscal_uf( 	ps_uf									, &
													pl_produto							, &
													ps_tributacao_icms				, &
													pl_tipo_produto						, &
													pl_tipo_produto_fiscal				, &
													ps_antecipacao_icms				, &
													pdc_mva_antecipacao_icms		, &
													lvs_permissao_transferencia	, &
													lvl_mensagem_transferencia	, &
													lvs_permissao_devolucao		, &
													lvl_mensagem_devolucao)
end function

public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref long pl_tipo_produto, ref long pl_tipo_produto_fiscal, ref string ps_permissao_transferencia, ref long pl_mensagem_transferencia, ref string ps_permissao_devolucao, ref long pl_mensagem_devolucao);String lvs_Antecipa_ICMS

Decimal lvdc_MVA_Antecipacao

Return This.of_tipo_produto_fiscal_uf( 	ps_uf									, &
													pl_produto							, &
													ps_tributacao_icms				, &		
													pl_tipo_produto						, &
													pl_tipo_produto_fiscal				, &
													lvs_Antecipa_ICMS				, &
													lvdc_MVA_Antecipacao			, &
													ps_permissao_transferencia		, &
													pl_mensagem_transferencia	, &
													ps_permissao_devolucao			, &
													pl_mensagem_devolucao)
end function

public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao_icms, ref long pl_tipo_produto, ref long pl_tipo_produto_fiscal, ref string ps_antecipa_icms, ref decimal pdc_mva_antecipa_icms, ref string ps_permissao_transferencia, ref long pl_mensagem_transferencia, ref string ps_permissao_devolucao, ref long pl_mensagem_devolucao);String lvs_Tipo
String lvs_Antecipa_ICMS

Long lvl_NCM
Long lvl_Msg_Transf
Long lvl_Msg_Devol

Decimal{4} lvdc_MVA

Boolean lvb_Ok = True

/* Verifica$$HEX2$$e700f500$$ENDHEX$$es */
If IsNull(ps_uf) or (Trim(ps_uf)="") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Uf n$$HEX1$$e300$$ENDHEX$$o informada para a fun$$HEX2$$e700e300$$ENDHEX$$o of_tipo_produto_fiscal_uf().",Exclamation!)
	lvb_Ok = False
End If

If IsNull(pl_produto) or (Not (pl_produto > 0)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto n$$HEX1$$e300$$ENDHEX$$o informado para a fun$$HEX2$$e700e300$$ENDHEX$$o of_tipo_produto_fiscal_uf().",Exclamation!)
	lvb_Ok = False
End If

ivo_Tributacao_ICMS.Of_localiza_tributacao( ps_tributacao_icms )

//If Not ivo_Tributacao_ICMS.Of_localiza_tributacao( ps_tributacao_icms ) Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS inv$$HEX1$$e100$$ENDHEX$$lida para a fun$$HEX2$$e700e300$$ENDHEX$$o of_tipo_produto_fiscal_uf().",Exclamation!)
//	lvb_Ok = False
//End If

/*** In$$HEX1$$ed00$$ENDHEX$$cio Fun$$HEX2$$e700e300$$ENDHEX$$o ***/
If lvb_Ok Then	
	/*Localiza NCM*/	
	Select nr_classificacao_fiscal
	Into :lvl_NCM
	From produto_geral
	Where cd_produto = :pl_produto
	Using SQLCa;
	
	//Retorna o tipo de produto atrav$$HEX1$$e900$$ENDHEX$$s da NCM
	lvb_Ok = This.Of_Tipo_Produto_Fiscal_UF( ps_uf, lvl_NCM, ref pl_tipo_produto, ref pl_tipo_produto_fiscal, ref lvs_Antecipa_ICMS, ref lvdc_MVA, ref ps_permissao_transferencia, ref lvl_Msg_Transf, ref ps_permissao_devolucao, ref lvl_Msg_Devol)
	
	//Se conseguiu retornar os valores
	If lvb_Ok Then	
		//Aplica regras tribut$$HEX1$$e100$$ENDHEX$$rias
		//Somente $$HEX1$$e900$$ENDHEX$$ feita antecipa$$HEX2$$e700e300$$ENDHEX$$o de ICMS em produtos tributados e n$$HEX1$$e300$$ENDHEX$$o sujeitos a ICMS ST
		If ivo_Tributacao_ICMS.id_icms_normal = "S" and ivo_Tributacao_ICMS.id_icms_st = "N" Then
			ps_antecipa_icms 			= lvs_Antecipa_ICMS
			pdc_mva_antecipa_icms	= lvdc_MVA
		End If
		
		//A mensagem $$HEX1$$e900$$ENDHEX$$ somente para opera$$HEX2$$e700f500$$ENDHEX$$es em que o produto $$HEX1$$e900$$ENDHEX$$ sujeito a ICMS ST
		If ivo_Tributacao_ICMS.id_icms_st = "S" Then
			pl_mensagem_transferencia	= lvl_Msg_Transf
			pl_mensagem_devolucao		= lvl_Msg_Devol
		End If
	End If	
End If

Return lvb_Ok
end function

private function boolean of_filial_matriz ();Long lvl_Filial, lvl_Filial_Matriz

Select cd_filial, cd_filial_matriz 
Into :lvl_Filial, :lvl_Filial_Matriz
From parametro
Where id_parametro = '1'
Using SQLCa;

Return (lvl_Filial = lvl_Filial_Matriz)
end function

public function boolean of_grupo_produto_fiscal_uf (string ps_uf, long pl_produto, string ps_tributacao, ref long pl_grupo);Long ll_Tipo_Produto

If Not of_tipo_produto_fiscal_uf(ps_uf, pl_produto, ps_tributacao, ref ll_Tipo_Produto) Then Return False
	
//1	MEDICAMENTO
//2	PERFUMARIA
//3	PRODUTOS ALIMENT$$HEX1$$cd00$$ENDHEX$$CIOS
//4	OUTROS
	
Select cd_tipo_produto
Into :pl_grupo
From tipo_produto_fiscal
Where cd_tipo_produto_fiscal = :ll_Tipo_Produto
Using SQLCa;
	
Choose Case SQLCa.SQLCode
	Case -1
		SQLCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do GRUPO do produto "+String(pl_produto)+", fun$$HEX2$$e700e300$$ENDHEX$$o of_grupo_produto_fiscal_uf().")
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tipo do produto n$$HEX1$$e300$$ENDHEX$$o localizado na tabela [TIPO_PRODUTO_FISCAL], na fun$$HEX2$$e700e300$$ENDHEX$$o of_grupo_produto_fiscal_uf().",Exclamation!)
		Return False
End Choose

Return True
end function

public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_ncm, ref long pl_tipo_produto, ref long pl_tipo_produto_fiscal, ref string ps_antecipa_icms, ref decimal pdc_mva_antecipa_icms, ref string ps_permissao_transferencia, ref long pl_mensagem_transferencia, ref string ps_permissao_devolucao, ref long pl_mensagem_devolucao);String lvs_Tipo
String lvs_Antecipa_ICMS

Long lvl_Msg_Transf
Long lvl_Msg_Devol
Long lvl_SQLCode

Decimal{4} lvdc_MVA

Boolean lvb_Ok = True

Try
	/* Verifica$$HEX2$$e700f500$$ENDHEX$$es */
	If IsNull(ps_uf) or (Trim(ps_uf)="") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Uf n$$HEX1$$e300$$ENDHEX$$o informada para a fun$$HEX2$$e700e300$$ENDHEX$$o of_tipo_produto_fiscal_uf().",Exclamation!)
		lvb_Ok = False
	End If
	
	If IsNull(pl_ncm) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","NCM n$$HEX1$$e300$$ENDHEX$$o informada para a fun$$HEX2$$e700e300$$ENDHEX$$o of_tipo_produto_fiscal_uf().",Exclamation!)
		lvb_Ok = False
	End If
	
	If lvb_Ok Then
		ps_antecipa_icms = "N"
		
		/* Localiza Tipo Fiscal Espec$$HEX1$$ed00$$ENDHEX$$fico */
		/*Utiliza$$HEX2$$e700e300$$ENDHEX$$o do cursor com SQL fixo*/
		DECLARE lcu_tipo_fiscal CURSOR FOR
		select 	'1' as id_tipo,
					tf.cd_tipo_produto, 
					tf.cd_tipo_produto_fiscal, 
					tu.id_antecipa_icms, 
					tu.pc_antecipacao_icms, 
					tu.id_permissao_devolucao, 
					tu.cd_msg_devolucao,
					tu.id_permissao_transferencia,
					tu.cd_msg_transferencia
		from tipo_produto_fiscal_ncm tn
		Inner Join tipo_produto_fiscal tf
			on tf.cd_tipo_produto_fiscal = tn.cd_tipo_produto_fiscal+0
		Inner Join tipo_produto_fiscal_uf tu
			on tu.cd_tipo_produto_fiscal = tf.cd_tipo_produto_fiscal+0
			and  tu.cd_uf = :ps_uf
		Where tn.nr_ncm_inicial = :pl_ncm
			And tn.nr_ncm_final is null
		
		UNION
		select 	'2' as id_tipo,
					tf.cd_tipo_produto, 
					tf.cd_tipo_produto_fiscal, 
					tu.id_antecipa_icms, 
					tu.pc_antecipacao_icms, 
					tu.id_permissao_devolucao, 
					tu.cd_msg_devolucao,
					tu.id_permissao_transferencia,
					tu.cd_msg_transferencia
		from tipo_produto_fiscal_ncm tn
		Inner Join tipo_produto_fiscal tf
			on tf.cd_tipo_produto_fiscal = tn.cd_tipo_produto_fiscal+0
		Inner Join tipo_produto_fiscal_uf tu
			on tu.cd_tipo_produto_fiscal = tf.cd_tipo_produto_fiscal+0
			and  tu.cd_uf = :ps_uf
		Where tn.nr_ncm_inicial <= :pl_ncm
			And tn.nr_ncm_final >= :pl_ncm
			And tn.nr_ncm_final is not null
		
		UNION
		select 	'3' as id_tipo,
					tf.cd_tipo_produto, 
					tf.cd_tipo_produto_fiscal, 
					tu.id_antecipa_icms, 
					tu.pc_antecipacao_icms, 
					tu.id_permissao_devolucao, 
					tu.cd_msg_devolucao,
					tu.id_permissao_transferencia,
					tu.cd_msg_transferencia
		from tipo_produto_fiscal tf
		Inner Join tipo_produto_fiscal_uf tu
			on tu.cd_tipo_produto_fiscal = tf.cd_tipo_produto_fiscal+0
			and tu.cd_uf = :ps_uf
		Where tf.cd_tipo_produto = 4
		order by 1
		Using SQLCa;
			
		// Abrindo o cursor
		OPEN lcu_tipo_fiscal;
	
		// Buscar a primeira linha do resultado
		FETCH lcu_tipo_fiscal INTO 	:lvs_Tipo, &	
											:pl_tipo_produto, &
											:pl_tipo_produto_fiscal, &
											:ps_antecipa_icms, &
											:pdc_mva_antecipa_icms, &
											:ps_permissao_transferencia, &
											:pl_mensagem_transferencia, &
											:ps_permissao_devolucao, &
											:pl_mensagem_devolucao;
		//Guarda o SQLCode
		lvl_SQLCode = SQLCa.SQLCode
		
		// No fim fechar o cursor
		CLOSE lcu_tipo_fiscal;
		
		Choose Case lvl_SQLCode
			Case -1
				If gvb_Auto Then
					gvo_aplicacao.Of_Grava_Log("Localiza$$HEX2$$e700e300$$ENDHEX$$o tipo produto da NCM "+String(pl_ncm)+", fun$$HEX2$$e700e300$$ENDHEX$$o of_tipo_produto_fiscal_uf().")
				Else
					SQLCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o tipo produto da NCM "+String(pl_ncm)+", fun$$HEX2$$e700e300$$ENDHEX$$o of_tipo_produto_fiscal_uf().")
				End If
				lvb_Ok = False
				
			Case 0
				//Localiza os valores para essa classe
				This.Of_Localiza_Codigo(pl_tipo_produto_fiscal)
				
			Case 100
				//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tipo produto n$$HEX1$$e300$$ENDHEX$$o localizado, na fun$$HEX2$$e700e300$$ENDHEX$$o of_tipo_produto_fiscal_uf().",Exclamation!)
				lvb_Ok = False
		End Choose
	End If	

Catch (RuntimeError lvo_Erro)
	lvb_Ok = False
	
	Try
		CLOSE lcu_tipo_fiscal;
	Finally
		If Not gvb_Auto Then
			MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
		Else
			gvo_aplicacao.Of_grava_log(lvo_Erro.GetMessage())
		End If
	End Try
	
Finally
	If Not lvb_Ok Then
		SetNull(pl_tipo_produto)
		SetNull(pl_tipo_produto_fiscal)
		SetNull(ps_antecipa_icms)
		SetNull(pdc_mva_antecipa_icms)
		SetNull(ps_permissao_transferencia)
		SetNull(pl_mensagem_transferencia)
		SetNull(ps_permissao_devolucao)
		SetNull(pl_mensagem_devolucao)
	End If
End Try

Return lvb_Ok
end function

public function boolean of_tipo_produto_fiscal_uf (string ps_uf, long pl_ncm, ref long pl_tipo_produto);Long lvl_Tipo_Prod_Fiscal
String lvs_antecipa_icms
Decimal lvdc_mva_antecipa_icms
String lvs_permissao_transferencia
Long lvl_mensagem_transferencia
String lvs_permissao_devolucao
Long lvl_mensagem_devolucao

Return This.Of_Tipo_Produto_Fiscal_UF(ps_uf, pl_ncm, ref pl_tipo_produto, ref lvl_Tipo_Prod_Fiscal, ref lvs_antecipa_icms, ref lvdc_mva_antecipa_icms, ref lvs_permissao_transferencia, ref lvl_mensagem_transferencia, ref lvs_permissao_devolucao, ref lvl_mensagem_devolucao)

end function

on uo_tipo_produto_fiscal.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tipo_produto_fiscal.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_Tributacao_ICMS = Create uo_tributacao_icms
end event

event destructor;If IsValid(ivo_Tributacao_ICMS) Then Destroy(ivo_Tributacao_ICMS)
end event

