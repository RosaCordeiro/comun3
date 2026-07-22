HA$PBExportHeader$w_ge463_alteracao_produto.srw
forward
global type w_ge463_alteracao_produto from dc_w_cadastro_selecao_lista
end type
type dw_3 from dc_uo_dw_base within w_ge463_alteracao_produto
end type
type cb_1 from commandbutton within w_ge463_alteracao_produto
end type
type gb_3 from groupbox within w_ge463_alteracao_produto
end type
type dw_4 from dc_uo_dw_base within w_ge463_alteracao_produto
end type
type cb_atualiza_ncm from commandbutton within w_ge463_alteracao_produto
end type
type st_1 from statictext within w_ge463_alteracao_produto
end type
end forward

global type w_ge463_alteracao_produto from dc_w_cadastro_selecao_lista
integer width = 4800
integer height = 2380
string title = "GE463 - Altera$$HEX2$$e700e300$$ENDHEX$$o Fiscal Produtos"
boolean resizable = false
dw_3 dw_3
cb_1 cb_1
gb_3 gb_3
dw_4 dw_4
cb_atualiza_ncm cb_atualiza_ncm
st_1 st_1
end type
global w_ge463_alteracao_produto w_ge463_alteracao_produto

type variables
uo_produto ivo_produto

uo_ge220_tributacao_produto ivo_tributacao //GE220
uo_ncm ivo_ncm //GE021
uo_cest ivo_cest //GE021

dc_uo_ds_base ivds_Ncm_UF

Boolean ivb_Email_Email = False

end variables

forward prototypes
public subroutine wf_localiza_produto (long pl_produto)
public subroutine wf_insere_padrao ()
public function boolean wf_atualiza_revisao_fiscal (long pl_produto)
public function boolean wf_atualiza_tributacao_ncm (long pl_ncm)
public subroutine wf_atualiza_sit_especial ()
public function boolean wf_valida_tributacao_ncm ()
public function boolean wf_updatespending ()
public function boolean wf_atualiza_tributacao_ncm_uf (long pl_ncm)
public function boolean wf_preenche_cest (boolean pb_aviso)
public subroutine wf_verifica_envio_email (long pl_produto)
public subroutine wf_limpa_situacao_ncm ()
public function boolean wf_limpa_tributacao_produto_divergente (string ps_lista_pis)
public function boolean wf_valida_tributacao_lista_pis (string ps_lista_pis)
public function boolean wf_atualiza_lista_pis_cofins_ncm ()
public function boolean wf_envia_email ()
end prototypes

public subroutine wf_localiza_produto (long pl_produto);String lvs_Descricao, &
		lvs_apresentacao_venda

Long lvl_Produto

Date lvdh_Revisao

select p.cd_produto, 
		p.de_produto,
		p.de_apresentacao_venda,
		pc.dh_revisao_fiscal
into    :lvl_Produto,
		:lvs_Descricao,
		:lvs_apresentacao_venda,
		:lvdh_Revisao
 from produto_geral p
 inner join produto_central pc
 	on pc.cd_produto = p.cd_produto
 where p.cd_produto = :pl_produto
  Using SqlCa;
	
ivb_Email_Email = IsNull(lvdh_Revisao)

dw_1.Object.de_localizacao [1] = ''

ivo_produto.of_localiza_codigo_interno( pl_produto)

dw_4.Event ue_Retrieve()

dw_2.Event ue_Retrieve()	 

dw_3.Enabled = True
dw_4.Enabled = True
dw_4.ivm_menu.mf_confirmar(True)
dw_4.ivm_menu.mf_cancelar(True)		
dw_2.ivm_menu.mf_confirmar(True)
dw_2.ivm_menu.mf_cancelar(True)	
end subroutine

public subroutine wf_insere_padrao ();// Coloca o item TODAS
Long lvl_Nulo

DataWindowChild ldw_Child

SetNull(lvl_Nulo)

If dw_3.GetChild("cd_mensagem_fiscal", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_mensagem_fiscal",lvl_Nulo)
	ldw_Child.SetItem(1,"de_mensagem_fiscal","NENHUMA")
	
	dw_3.Object.cd_mensagem_fiscal[1] = lvl_Nulo
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'NENHUMA' na coluna mensagem fiscal.", StopSign!)
End If
end subroutine

public function boolean wf_atualiza_revisao_fiscal (long pl_produto);Boolean lvb_Sucesso = True

String lvs_Responsavel
String lvs_Email

lvs_Responsavel = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

UPDATE produto_central  
   SET id_revisao_fiscal 				= 'C',   
       dh_revisao_fiscal 				= getDate(),   
       nr_matricula_revisao_fiscal 	= :lvs_Responsavel
where cd_produto 					= :pl_produto
Using SqlCa;

Choose Case SqlCa.SqlCode	
	Case 100
		lvb_Sucesso = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no update do produto_central." + SqlCa.SqlErrText, StopSign!, Ok!)
		lvb_Sucesso = False
	Case 0
		lvb_Sucesso = True		
		If ivb_email_email Then
			s_email lvst_email
			ivo_produto.Of_Localiza_codigo_interno(pl_produto)
			lvst_email.ps_mensagem = '<ul><li>'+String(pl_produto)+' -  '+ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque+'</li></ul>'
			
			/* Email para o Comprador */
			Select u.de_endereco_email
			Into :lvs_Email
			From produto_central p
			Inner Join usuario u
				on u.nr_matricula = p.nr_matricula_comprador
			Where p.cd_produto = :pl_produto
				and u.de_endereco_email is not null
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then
				MessageBox('Erro','Falha ao localizar o email do comprador deste produto.',Exclamation!)
			End If
			
			lvst_email.ps_to[1] = lvs_Email
			lvst_email.pb_assinatura = True
			gf_ge202_envia_email_padrao(157,lvst_email)
			
		End If
End Choose

Return lvb_Sucesso
end function

public function boolean wf_atualiza_tributacao_ncm (long pl_ncm);String lvs_Pis
String lvs_Lei_G
String lvs_Cest

Decimal{2} lvdc_IPI

dw_4.AcceptText( )

dw_4.Object.pc_ipi [1] =  ivo_ncm.pc_ipi 
lvs_Pis	 = dw_4.Object.id_situacao_pis_cofins	[1]
lvs_Lei_G	 = dw_4.Object.id_lei_generico				[1]

If lvs_Pis <> ivo_ncm.Id_Pis_Cofins Then
	dw_4.Object.id_situacao_pis_cofins [1] = ivo_ncm.Id_Pis_Cofins
	lvs_Cest = dw_4.Object.cd_cest [1]
	
	If (Not IsNull(lvs_Cest))and(lvs_Cest<>'') Then
		If Not wf_preenche_cest(False) Then
			If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','A tributa$$HEX2$$e700e300$$ENDHEX$$o PIS/COFINS foi alterada, isso pode alterar tamb$$HEX1$$e900$$ENDHEX$$m o c$$HEX1$$f300$$ENDHEX$$digo CEST.~r'+&
							'Deseja conferir?',Question!,YesNo!,1) = 1 Then 
				dw_4.Event ue_Pos(1,'de_cest')
				Return False
			End If
		End If
	End If
End If

Return True
end function

public subroutine wf_atualiza_sit_especial ();Long lvl_Linha
Long lvl_Count
Long lvl_Situacao

String lvs_UF
String lvs_Sit

For lvl_Linha = 1 To dw_2.RowCount()
	lvs_UF 		= dw_2.Object.cd_unidade_federacao	[lvl_Linha]
	lvl_Situacao = dw_2.Object.nr_ncm_situacao			[lvl_Linha]
	
	If Not IsNull(lvl_Situacao) and (lvl_Situacao > 0) Then
		Select coalesce(id_padrao,'N')
		Into :lvs_Sit
		From ncm_situacao_especial
		Where nr_ncm = :ivo_ncm.nr_ncm
			And cd_uf = :lvs_UF
			And nr_sequencial = :lvl_Situacao
		Using SQLCa;
	Else
		lvs_Sit = 'N'
	End If
	
	If lvs_Sit = 'S' Then
		dw_2.Object.id_sit_especial [lvl_Linha] = 'N'
	Else
		dw_2.Object.id_sit_especial [lvl_Linha] = 'S'
	End If
Next	

end subroutine

public function boolean wf_valida_tributacao_ncm ();Long lvl_Linha
Long lvl_Find
Long lvl_NCM
Long lvl_Resp
Long lvl_Situacao
Long lvl_Count
Long lvl_Trib
Long lvl_Tipo

Boolean lvb_OK = True
Boolean lvb_Uf_OK = True
Boolean lvb_Cest

String lvs_UF
String lvs_UF_Diverg = ''
String lvs_Pis_Cofins
String lvs_Trib
String lvs_Cest
String lvs_Origem
String lvs_Find

Datetime lvdh_Movimento

dw_4.AcceptText()
dw_3.AcceptText()
dw_2.AcceptText()

lvl_NCM = dw_4.Object.nr_classificacao_fiscal [1]
lvs_Pis_Cofins 	= dw_4.Object.id_situacao_pis_cofins	[1]
lvs_Cest			= dw_4.Object.cd_cest						[1]
lvs_Origem		= dw_4.Object.cd_st_origem				[1]

/* Valida Campos Produto */
If IsNull(lvs_Pis_Cofins) or (lvs_Pis_Cofins = "") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a situa$$HEX2$$e700e300$$ENDHEX$$o PIS / COFINS.",Exclamation!)
	dw_4.Event ue_Pos(1,"id_situacao_pis_cofins")
	Return False
End If
	
Select count(1)
Into :lvl_Count
From ncm_pis_cofins
Where id_lista_pis_cofins = :lvs_Pis_Cofins
	And nr_ncm = :lvl_NCM
Using SQLCa;
		
If SQLCa.SQLCode = -1 Then
	SQLCa.Of_msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o listas dispon$$HEX1$$ed00$$ENDHEX$$veis NCM." )
	Return False
ENd If

If SQLCa.SQLCode = 100 or lvl_Count = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Situa$$HEX2$$e700e300$$ENDHEX$$o PIS / COFINS n$$HEX1$$e300$$ENDHEX$$o configurada na NCM.",Exclamation!)
	dw_4.Event ue_Pos(1,"id_situacao_pis_cofins")
	Return False
End If

If IsNull(lvs_Origem) or (lvs_Origem = "") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a origem do produto.",Exclamation!)
	dw_4.Event ue_Pos(1,"cd_st_origem")
	Return False
End If

If ivds_Ncm_UF.Retrieve(lvl_NCM) > 0 Then
	
	For lvl_Linha = 1 To dw_2.RowCount()
		lvb_Uf_OK = True
		lvs_UF 		= dw_2.Object.cd_unidade_federacao	[lvl_Linha]
		lvl_Situacao	= dw_2.Object.nr_ncm_situacao			[lvl_Linha]
		
		If Not IsNull(lvl_Situacao) and (lvl_Situacao > 0) Then
			lvs_Find = "cd_uf='"+lvs_UF+"' and nr_sequencial="+String(lvl_Situacao)
		else
			lvs_Find = "cd_uf='"+lvs_UF+"' and id_padrao = 'S'"
		End If
		
		lvl_Find = ivds_Ncm_UF.Find(lvs_Find,1,ivds_Ncm_UF.RowCount())
		
		if lvl_Find > 0 Then
			If dw_2.Object.cd_mensagem_fiscal	[lvl_Linha] <> ivds_Ncm_UF.Object.cd_mensagem_fiscal	[lvl_Find] Then lvb_Uf_OK = False
			If dw_2.Object.cd_tipo_icms			[lvl_Linha] <> ivds_Ncm_UF.Object.cd_tipo_icms				[lvl_Find] Then lvb_Uf_OK = False
			If dw_2.Object.cd_tributacao_icms	[lvl_Linha] <> ivds_Ncm_UF.Object.cd_tributacao_icms		[lvl_Find] Then lvb_Uf_OK = False
			If dw_2.Object.cd_tributacao_produto[lvl_Linha] <> ivds_Ncm_UF.Object.cd_tributacao_produto	[lvl_Find] Then lvb_Uf_OK = False
		Else
			If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','N$$HEX1$$e300$$ENDHEX$$o foi encontrada configura$$HEX2$$e700e300$$ENDHEX$$o da NCM '+String(lvl_NCM)+' para '+lvs_UF+'.~r~nDeseja salvar esta altera$$HEX2$$e700e300$$ENDHEX$$o mesmo assim?',Question!,YesNo!,2) = 2 Then
				Return False
			End If
		End If
		
		If Not lvb_Uf_OK Then
			lvb_OK = lvb_Uf_OK
			If lvs_UF_Diverg<>'' Then lvs_UF_Diverg += ', '
			lvs_UF_Diverg += lvs_UF
		End If
	Next
	
	If lvb_OK Then
		ivo_ncm.Of_Atualiza()
		If dw_4.Object.pc_ipi 						[1] <> ivo_ncm.pc_ipi Then 
			lvs_UF_Diverg = ' * Aliquota IPI'
			lvb_OK = False
		End If
			
		If Not lvb_OK Then
			lvl_Resp = MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Diferen$$HEX1$$e700$$ENDHEX$$a(s) entre a tributa$$HEX2$$e700e300$$ENDHEX$$o do produto e da NCM '+String(lvl_NCM,'00000000')+' em:~r'+lvs_UF_Diverg+'.~r~r' +&
											'Deseja atualizar as informa$$HEX2$$e700f500$$ENDHEX$$es desse produto pelas configura$$HEX2$$e700f500$$ENDHEX$$es da NCM?',Question!,YesNoCancel!,3)
			Choose Case lvl_Resp
				Case 1
					lvb_OK = wf_atualiza_tributacao_ncm(lvl_NCM)
				Case 2
					lvb_OK = True
				Case 3 
					dw_4.Event ue_Pos(1,'id_situacao_pis_cofins')
			End Choose		
		End if
	Else
		lvl_Resp = MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Existem diferen$$HEX1$$e700$$ENDHEX$$as entre a tributa$$HEX2$$e700e300$$ENDHEX$$o do produto e da NCM '+String(lvl_NCM)+' para a(s) UF(s) '+lvs_UF_Diverg+'.~r~r' +&
										'Deseja atualizar as informa$$HEX2$$e700f500$$ENDHEX$$es desse produto pelas configura$$HEX2$$e700f500$$ENDHEX$$es da NCM?',Question!,YesNoCancel!,3)
		Choose Case lvl_Resp
			Case 1
				lvb_OK = wf_atualiza_tributacao_ncm_uf(lvl_NCM)
			Case 2
				lvb_OK = True
			Case 3 
				dw_2.Event ue_Pos(lvl_Linha,'cd_tributacao_icms')
		End Choose		
	End If
Else
	Return False
End If

/* Valida$$HEX2$$e700e300$$ENDHEX$$o Campos UF */
For lvl_Linha = 1 To dw_2.RowCount()
	lvs_UF	= dw_2.Object.cd_unidade_federacao	[lvl_Linha]
	lvs_Trib	= dw_2.Object.cd_tributacao_icms	 	[lvl_Linha]
	lvl_Trib	= dw_2.Object.cd_tributacao_produto 	[lvl_Linha]
	lvl_Tipo	= dw_2.Object.cd_tipo_icms	 			[lvl_Linha]
	
	If IsNull(lvs_Trib) or (lvs_Trib = "") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS para a UF "+lvs_UF+".",Exclamation!)
		dw_2.Event ue_Pos(lvl_Linha,"cd_tributacao_icms")
		dw_3.Event ue_Pos(lvl_Linha,"cd_tributacao_icms")
		Return False
	End If
	
	If IsNull(lvl_Trib) or (lvl_Trib < 0) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a tributa$$HEX2$$e700e300$$ENDHEX$$o produto para a UF "+lvs_UF+".",Exclamation!)
		dw_2.Event ue_Pos(lvl_Linha,"cd_tributacao_produto")
		dw_3.Event ue_Pos(lvl_Linha,"cd_tributacao_produto")
		Return False
	End If
	
	If IsNull(lvl_Tipo) or (lvl_Tipo < 0) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione o tipo ICMS para a UF "+lvs_UF+".",Exclamation!)
		dw_2.Event ue_Pos(lvl_Linha,"cd_tipo_icms")
		dw_3.Event ue_Pos(lvl_Linha,"cd_tipo_icms")
		Return False
	End If
Next	


/* Valida$$HEX2$$e700e300$$ENDHEX$$o Obrigatoriedade do CEST */
lvb_Cest = (IsNull(lvs_Cest) or (lvs_Cest=''))
If lvb_Cest Then
	For lvl_Linha = 1 To dw_2.RowCount()
		lvs_UF	= dw_2.Object.cd_unidade_federacao	[lvl_Linha]
		lvs_Trib	= dw_2.Object.cd_tributacao_icms	 	[lvl_Linha]
		
		lvb_Cest = (lvs_Trib = '1')
		If lvb_Cest Then Exit
	Next	
End If

If lvb_Cest Then 
	gf_data_parametro(lvdh_Movimento)
	If lvdh_Movimento < Datetime('2017/07/01') Then
		lvb_OK = (MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Este produto est$$HEX1$$e100$$ENDHEX$$ configurado para ICMS ST e em produtos com ST $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o CEST.~r~r'+ &
										'Deseja continuar sem informar o CEST?',Question!,YesNo!,2) = 1)
	Else
		lvb_OK = False
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Favor preecher o campo CEST ou alterar a tributa$$HEX2$$e700e300$$ENDHEX$$o da UF '+lvs_UF+'! ~r~n'+ &
						'Pois este produto est$$HEX1$$e100$$ENDHEX$$ configurado para ICMS ST e em produtos com ST $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o CEST.',Exclamation!)	
	End If
	
	If not lvb_OK Then	dw_4.Event ue_pos(1,'de_cest')
End If

Return lvb_OK
end function

public function boolean wf_updatespending ();SUPER::FUNCTION wf_updatespending()

Return True
end function

public function boolean wf_atualiza_tributacao_ncm_uf (long pl_ncm);Long lvl_Linha
Long lvl_Find
Long lvl_Situacao

String lvs_UF
String lvs_Find

dw_2.AcceptText( )

dw_2.SetRedraw(False)
dw_4.SetRedraw(False)

If ivds_Ncm_UF.Retrieve(pl_ncm) > 0 Then
	
	For lvl_Linha = 1 To dw_2.RowCount()
		lvs_UF 		= dw_2.Object.cd_unidade_federacao	[lvl_Linha]
		lvl_Situacao = dw_2.Object.nr_ncm_situacao			[lvl_Linha]
		
		//If Not IsNull(lvl_Situacao) and (lvl_Situacao > 0) Then
		//	lvs_Find = "cd_uf='"+lvs_UF+"' and nr_sequencial="+String(lvl_Situacao)
		//else
			lvs_Find = "cd_uf='"+lvs_UF+"' and id_padrao = 'S'"
		//End If
		
		lvl_Find = ivds_Ncm_UF.Find(lvs_Find,1,ivds_Ncm_UF.RowCount())
		
		if lvl_Find > 0 Then
			dw_2.Object.nr_ncm_situacao			[lvl_Linha] = ivds_Ncm_UF.Object.nr_sequencial			[lvl_Find] 
			dw_2.Object.cd_mensagem_fiscal		[lvl_Linha] = ivds_Ncm_UF.Object.cd_mensagem_fiscal	[lvl_Find] 
			dw_2.Object.cd_tipo_icms				[lvl_Linha] = ivds_Ncm_UF.Object.cd_tipo_icms			[lvl_Find] 
			dw_2.Object.cd_tributacao_icms		[lvl_Linha] = ivds_Ncm_UF.Object.cd_tributacao_icms	[lvl_Find] 
			dw_2.Object.cd_tributacao_produto	[lvl_Linha] = ivds_Ncm_UF.Object.cd_tributacao_produto[lvl_Find] 
		End If
	Next
	
End If

wf_atualiza_sit_especial()

dw_2.SetRedraw(True)
dw_4.SetRedraw(True)
dw_2.Event ue_atualiza_detalhe(dw_2.GetRow())

This.ivm_menu.mf_confirmar(True)
This.ivm_menu.mf_cancelar(True)
This.ivb_valida_salva = True

Return True
end function

public function boolean wf_preenche_cest (boolean pb_aviso);Long lvl_NCM

String lvs_Lei_G
String lvs_Pis

Boolean lvb_Altera = True

dw_4.Accepttext( )
lvl_NCM	= dw_4.Object.nr_classificacao_fiscal	[1]
lvs_Pis	= dw_4.Object.id_situacao_pis_cofins[1]
lvs_Lei_G	= dw_4.Object.id_lei_generico			[1]

ivo_cest.of_localiza_cest_ncm(lvl_NCM,lvs_Pis,lvs_Lei_G)

If pb_aviso and ivo_cest.Localizado Then lvb_Altera= (MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Este produto tem ICMS ST e o CEST n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ preenchido.~r'+ &
																					'Deseja que o sistema preencha o CEST?',Question!,YesNo!,1) = 1)

If lvb_Altera Then
	dw_4.Object.de_cest [1] = ivo_cest.de_cest
	dw_4.Object.cd_cest [1] = ivo_cest.cd_cest
End If

Return ivo_cest.Localizado
end function

public subroutine wf_verifica_envio_email (long pl_produto);DateTime lvdh_Revisao

Select pc.dh_revisao_fiscal
Into    :lvdh_Revisao
 from produto_geral p
 inner join produto_central pc
 	on pc.cd_produto = p.cd_produto
 where p.cd_produto = :pl_produto
 	and  pc.id_revisao_fiscal = "C"
	and p.id_situacao <> "I"
  Using SqlCa;
  
  Choose Case SqlCa.SqlCode
	Case 0
		  ivb_Email_Email = IsNull(lvdh_Revisao)
	Case 100
		ivb_Email_Email = False
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o produto.")
		Return
End Choose
  
   

end subroutine

public subroutine wf_limpa_situacao_ncm ();Long lvl_Linha
Long lvl_Null

dw_2.SetRedraw(False)
dw_2.Post SetRedraw(True)

SetNull(lvl_Null)

For lvl_Linha = 1 To dw_2.RowCount()
	dw_2.Object.nr_ncm_situacao [lvl_Linha] = lvl_Null
Next

wf_atualiza_sit_especial()
end subroutine

public function boolean wf_limpa_tributacao_produto_divergente (string ps_lista_pis);Long lvl_Find
Long lvl_Aux
Long lvl_Seq

String lvs_Uf

lvl_Find = dw_3.Find("id_tributacao_lista_pis_cofins<>'' and id_tributacao_lista_pis_cofins<>'"+ps_lista_pis+"'",1,dw_3.RowCount())

Do While lvl_Find > 0
	
	ivo_tributacao.Of_inicializa( )

	dw_3.Object.cd_tributacao_produto			[lvl_Find] = ivo_tributacao.cd_tributacao_produto
	dw_3.Object.id_tributacao_lei_generico		[lvl_Find] = ivo_tributacao.lei_generico
	dw_3.Object.id_tributacao_lista_pis_cofins	[lvl_Find] = ivo_tributacao.Lista_pis_cofins	
	
	lvl_Aux = lvl_Find + 1	
	If lvl_Aux > dw_3.RowCount() Then Exit
	lvl_Find = dw_3.Find("id_tributacao_lista_pis_cofins<>'' and id_tributacao_lista_pis_cofins<>'"+ps_lista_pis+"'",lvl_Aux,dw_3.RowCount())
Loop

lvl_Find = dw_3.Find("IsNull(cd_tributacao_produto)",1,dw_3.RowCount())

If lvl_Find > 0 Then
	lvs_Uf 	= dw_3.Object.cd_unidade_federacao	[lvl_Find]
	
	lvl_Aux = dw_2.Find("cd_unidade_federacao='"+lvs_Uf+"'",1,dw_2.RowCount())
	dw_2.Event ue_Pos(lvl_Aux,"cd_unidade_federacao")
	dw_3.Event ue_Pos(lvl_Find,"cd_tributacao_produto")
End If

Return True
end function

public function boolean wf_valida_tributacao_lista_pis (string ps_lista_pis);Return Not dw_3.Find("id_tributacao_lista_pis_cofins<>'' and id_tributacao_lista_pis_cofins<>'"+ps_lista_pis+"'",1,dw_3.RowCount())  > 0
end function

public function boolean wf_atualiza_lista_pis_cofins_ncm ();Long lvl_NCM

DataWindowChild ldw_Child

dw_4.Accepttext( )
lvl_NCM = dw_4.Object.nr_classificacao_fiscal [1]

If dw_4.GetChild("id_situacao_pis_cofins", ldw_Child) = 1 Then
	ldw_Child.SetTrans( SQLCa )
	ldw_Child.SetTransObject( SQLCa )
	ldw_Child.Retrieve(lvl_NCM)
End If

Return True
end function

public function boolean wf_envia_email ();String ls_Anexo[]
String ls_Mensagem
String ls_Produto
String ls_Email
String ls_Erro

s_email str

Select u.de_endereco_email
	Into :ls_Email
From produto_central c
	Inner Join usuario u
		On u.nr_matricula = c.nr_matricula_comprador
Where cd_produto = :ivo_Produto.Cd_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		str.ps_to[1] = ls_Email
		
	Case 100
		
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta do e-mail do comprador do produto. " + ls_Erro, StopSign!)
		Return False
End Choose

ls_Produto = ivo_Produto.De_Produto + " : " + ivo_Produto.De_Apresentacao_Venda

ls_Mensagem = "* " + String(ivo_Produto.Cd_Produto) + " - " + ls_Produto

str.ps_Mensagem = ls_Mensagem
str.pb_Assinatura = True

gf_ge202_envia_email_padrao(142, str, True)

Return True
end function

on w_ge463_alteracao_produto.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_1=create cb_1
this.gb_3=create gb_3
this.dw_4=create dw_4
this.cb_atualiza_ncm=create cb_atualiza_ncm
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.cb_atualiza_ncm
this.Control[iCurrent+6]=this.st_1
end on

on w_ge463_alteracao_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.dw_4)
destroy(this.cb_atualiza_ncm)
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;String lvs_Prod

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2, dw_4}
This.wf_SetUpdate_DW(lvo_Update)


dw_3.Event ue_AddRow()
dw_4.Event ue_AddRow()
dw_1.SetFocus()

ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Imprimir(False)
ivm_Menu.mf_Filtrar(False)
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

wf_insere_padrao()

lvs_Prod = Message.StringParm

If Not IsNull(lvs_Prod) and (Trim(lvs_Prod) <> '') Then
	If ivo_produto.Of_localiza_codigo_interno(Long(lvs_Prod)) Then
		dw_4.Event ue_Retrieve()
		dw_2.Event ue_Retrieve()	
		
		dw_3.Enabled = True
		dw_4.Enabled = True
	End If
End If



// Verifica CutOver Material
If not gf_verifica_cutover("DH_CUTOVER_MATERIAL") Then 
	dw_4.Object.de_ncm.protect = 1
	dw_4.Object.de_cest.protect = 1
	dw_4.Object.cd_st_origem.protect = 1
	dw_4.Object.id_situacao_pis_cofins.protect = 1
	dw_4.Object.de_historico_fiscal.protect = 1

	dw_3.Object.nr_ncm_situacao.protect = 1	
	
	st_1.visible = True
	st_1.text = 'Alguns campos n$$HEX1$$e300$$ENDHEX$$o podem mais serem alterados devido ao SAP.'
End If 
end event

event close;call super::close;Destroy(ivo_tributacao)
Destroy(ivds_Ncm_UF)
Destroy(ivo_Produto)
Destroy(ivo_ncm)
Destroy(ivo_cest)
end event

event ue_cancel;call super::ue_cancel;ivo_ncm.Of_inicializa( )
ivo_cest.Of_inicializa( )

dw_3.Reset()
dw_4.Reset()

dw_3.Event ue_AddRow()
dw_4.Event ue_AddRow()

dw_3.Enabled = False
dw_4.Enabled = False

This.ivm_Menu.mf_Confirmar	(False)
This.ivm_Menu.mf_Cancelar	(False)

dw_1.SetFocus()

cb_atualiza_ncm.Enabled = False

end event

event ue_save;call super::ue_save;//Boolean lb_Sucesso = False

Long ll_Produto

If AncestorReturnValue = 1 Then
	dw_1.AcceptText()
	
	ll_Produto = dw_4.Object.cd_produto	[1]
	
	//Atualiza Revisao Fiscal
	If wf_atualiza_revisao_fiscal(ll_Produto) Then
//		If gf_ge448_Grava_revisao(ivo_Produto.Cd_Produto) Then
//			If wf_Envia_Email() Then
//				lb_Sucesso = True
//			End If
//		End If
//	End If
//	
//	If lb_Sucesso Then
		SqlCa.of_Commit();
		
		This.Event ue_Cancel()
		
		Return 1
	Else
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na revis$$HEX1$$e300$$ENDHEX$$o fiscal do produto '" + String(ll_Produto) + "'.")
		Return -1
	End If
End If
end event

event ue_preupdate;call super::ue_preupdate;String lvs_Pis_Cofins
String lvs_Trib
String lvs_UF
String lvs_Cest
String lvs_Origem

Long lvl_Linha
Long lvl_Trib
Long lvl_Tipo

Datetime lvdh_Movimento

Boolean lvb_Erro
		
dw_4.AcceptText()
dw_3.AcceptText()
dw_2.AcceptText()

If not wf_valida_tributacao_ncm() then Return False

lvs_Pis_Cofins 	= dw_4.Object.id_situacao_pis_cofins[1]
lvs_Cest			= dw_4.Object.cd_cest					[1]
lvs_Origem		= dw_4.Object.cd_st_origem			[1]

/* Valida Campos Produto */
If IsNull(lvs_Pis_Cofins) or (lvs_Pis_Cofins = "") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a situa$$HEX2$$e700e300$$ENDHEX$$o Pis / Cofins.")
	dw_4.Event ue_Pos(1,"id_situacao_pis_cofins")
	Return False
End If

If IsNull(lvs_Origem) or (lvs_Origem = "") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a origem do produto.")
	dw_4.Event ue_Pos(1,"cd_st_origem")
	Return False
End If

/* Valida tributa$$HEX2$$e700e300$$ENDHEX$$o produto icms */
If Not wf_valida_tributacao_lista_pis(lvs_Pis_Cofins) then
	If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Existe(m) tributa$$HEX2$$e700e300$$ENDHEX$$o($$HEX1$$f500$$ENDHEX$$es) informadas que s$$HEX1$$e300$$ENDHEX$$o espec$$HEX1$$ed00$$ENDHEX$$ficas de outra lista PIS/COFINS. '+ &
						'Isso pode gerar uma inconsist$$HEX1$$ea00$$ENDHEX$$ncia nos c$$HEX1$$e100$$ENDHEX$$lculos dos tributos.~r~n~r~n'+ &
						'Deseja continuar salvar assim mesmo?',Exclamation!,YesNo!,2)=2 Then
		wf_limpa_tributacao_produto_divergente(lvs_Pis_Cofins)
	End If
End if

/* Valida$$HEX2$$e700e300$$ENDHEX$$o Campos UF */
For lvl_Linha = 1 To dw_2.RowCount()
	lvs_UF	= dw_2.Object.cd_unidade_federacao	[lvl_Linha]
	lvs_Trib	= dw_2.Object.cd_tributacao_icms	 	[lvl_Linha]
	lvl_Trib	= dw_2.Object.cd_tributacao_produto 	[lvl_Linha]
	lvl_Tipo	= dw_2.Object.cd_tipo_icms	 			[lvl_Linha]
	
	If IsNull(lvs_Trib) or (lvs_Trib = "") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS para a UF "+lvs_UF+".",Exclamation!)
		dw_2.Event ue_Pos(lvl_Linha,"cd_tributacao_icms")
		dw_3.Event ue_Pos(lvl_Linha,"cd_tributacao_icms")
		Return False
	End If
	
	If IsNull(lvl_Trib) or (lvl_Trib < 0) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a tributa$$HEX2$$e700e300$$ENDHEX$$o produto para a UF "+lvs_UF+".",Exclamation!)
		dw_2.Event ue_Pos(lvl_Linha,"cd_tributacao_produto")
		dw_3.Event ue_Pos(lvl_Linha,"cd_tributacao_produto")
		Return False
	End If
	
	If IsNull(lvl_Tipo) or (lvl_Tipo < 0) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione o tipo ICMS para a UF "+lvs_UF+".",Exclamation!)
		dw_2.Event ue_Pos(lvl_Linha,"cd_tipo_icms")
		dw_3.Event ue_Pos(lvl_Linha,"cd_tipo_icms")
		Return False
	End If
Next	

/* Valida$$HEX2$$e700e300$$ENDHEX$$o Obrigatoriedade do CEST */
lvb_Erro = (IsNull(lvs_Cest) or (lvs_Cest=''))
If lvb_Erro Then
	lvl_Linha = dw_2.Find("cd_tributacao_icms='1'",1,dw_2.RowCount())
	
	lvb_Erro = (lvl_Linha > 0)
	
	If lvb_Erro Then
		lvs_UF	= dw_2.Object.cd_unidade_federacao	[lvl_Linha]
		lvs_Trib	= dw_2.Object.cd_tributacao_icms	 	[lvl_Linha]
		
		gf_data_parametro(lvdh_Movimento)
		If lvdh_Movimento < Datetime('2017/07/01') Then
			lvb_Erro = (MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Este produto est$$HEX1$$e100$$ENDHEX$$ configurado para ICMS ST e em produtos com ST $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o CEST.~r~r'+ &
											'Deseja continuar sem informar o CEST?',Exclamation!,YesNo!,2) = 2)
		Else
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Favor preecher o campo CEST ou alterar a tributa$$HEX2$$e700e300$$ENDHEX$$o da UF '+lvs_UF+'! ~r~n'+ &
							'Pois este produto est$$HEX1$$e100$$ENDHEX$$ configurado para ICMS ST e em produtos com ST $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar o CEST.',Exclamation!)	
		End If
		
		If lvb_Erro Then
			dw_4.Event ue_pos(1,'de_cest')
			Return False
		End If
	End if
End If

dw_4.Object.Nr_Matricula_Atualizacao[1] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

Return True
end event

event ue_preopen;call super::ue_preopen;ivo_Produto 		= Create uo_Produto
ivo_tributacao 	= Create uo_ge220_tributacao_produto
ivo_ncm 			= Create uo_ncm
ivds_Ncm_UF	= Create dc_uo_ds_base
ivo_cest			= Create uo_cest

ivds_Ncm_UF.Of_ChangeDataObject('ds_ge463_ncm_uf')

ivb_grava_log = True

MaxHeight = 2330
MaxWidth = 4820
end event

event resize;call super::resize;dw_2.Width = 1879
dw_2.Height = 1260
gb_3.Height = 1355
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge463_alteracao_produto
integer x = 41
integer y = 2544
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge463_alteracao_produto
integer x = 5
integer y = 2472
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge463_alteracao_produto
integer x = 50
integer y = 76
integer width = 1454
integer height = 112
string dataobject = "dw_ge463_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then	
	Choose Case This.GetColumnName()
		Case "de_localizacao"
			
			If ivw_ParentWindow.ivb_Valida_Salva Then
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes que ao continuar ser$$HEX1$$e300$$ENDHEX$$o perdidas.~rDeseja continuar?", Question!, YesNo!,2) = 2 Then
					dw_4.Object.de_produto	[1] = ivo_Produto.de_produto + ': '+ivo_produto.de_apresentacao_venda
					Return 1
				Else				
					//Parent.Event ue_Cancel()
					
					dw_2.Reset()
					dw_3.Reset()
					dw_4.Reset()
					
					dw_4.Event ue_AddRow()
					
					dw_1.SetFocus()
					
					This.ivm_Menu.mf_Confirmar(False)
					This.ivm_Menu.mf_Cancelar(False)
					
					Parent.ivb_Valida_Salva = False
					dw_3.Enabled = False
					dw_4.Enabled = False
				End If
			End If
				
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			cb_atualiza_ncm.Enabled = ivo_Produto.Localizado
			
			If ivo_Produto.Localizado Then
				
				wf_verifica_envio_email(ivo_Produto.cd_produto)
				
				This.Object.de_localizacao [1] = ''
				dw_4.Event ue_Retrieve()
				dw_2.Event ue_Retrieve()	
				
				dw_3.Enabled = True
				dw_4.Enabled = True
				dw_4.SetFocus()
				
			End If
			
	End Choose
End If

Parent.ivm_Menu.mf_Excluir(False)
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Null

SetNull(lvl_Null)

Choose Case Dwo.Name		
	Case "de_produto"
				
			If Not IsNull(Data) and Trim(Data) <> "" Then
				If Data <> ivo_Produto.de_produto Then
					Return 1
				End If
			Else
				
				If ivw_ParentWindow.ivb_Valida_Salva Then
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes que ao continuar ser$$HEX1$$e300$$ENDHEX$$o perdidas.~rDeseja continuar?", Question!, YesNo!,2) = 2 Then
						This.Object.de_produto			[1] = ivo_Produto.de_produto
						Return 1
					End If
				End If
				
				ivo_Produto.of_Inicializa()
				
				This.Object.Cd_Produto					[1] = ivo_Produto.cd_produto
				This.Object.de_produto					[1] = ivo_Produto.de_produto
									
				Parent.Event ue_Cancel()
				
				dw_1.SetFocus()
				
				This.ivm_Menu.mf_Confirmar(False)
				This.ivm_Menu.mf_Cancelar(False)
				
				Parent.ivb_Valida_Salva = False
				
			End If	
			
End Choose
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge463_alteracao_produto
integer x = 1989
integer y = 1232
integer width = 2770
integer height = 964
integer weight = 700
string text = "Detalhes Trib. para UF Selecionada"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge463_alteracao_produto
integer x = 27
integer y = 0
integer width = 1934
integer height = 212
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge463_alteracao_produto
event ue_atualiza_detalhe ( long al_linha )
integer x = 46
integer y = 912
integer width = 1897
integer height = 1272
integer taborder = 40
string dataobject = "dw_ge463_selecao_uf"
end type

event dw_2::ue_atualiza_detalhe(long al_linha);String lvs_Sit
//DataWindowChild ldw_Child

dw_3.of_Populate_DDDW("cd_tributacao_produto")
dw_3.of_Populate_DDDW("cd_tributacao_icms")
dw_3.of_Populate_DDDW("nr_ncm_situacao")
dw_3.of_Populate_DDDW("cd_tipo_icms") 

dw_3.ScrollToRow(al_Linha)
dw_3.SetRow(al_Linha)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	This.Post Event ue_Atualiza_Detalhe(CurrentRow)
End If

Parent.ivm_Menu.mf_Excluir(False)
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()

This.ShareData(dw_3)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	wf_atualiza_sit_especial()
End If

Return pl_Linhas
end event

event dw_2::ue_recuperar;//OverRide
Long lvl_Produto

dw_1.acceptText()

lvl_Produto = dw_4.Object.cd_produto[1]

If Not IsNull(lvl_Produto) Then
	Return This.Retrieve(lvl_Produto)
Else
	Return -1
End If
end event

event dw_2::scrollvertical;call super::scrollvertical;//dw_3.Object.datawindow.verticalscrollposition = scrollpos
end event

type dw_3 from dc_uo_dw_base within w_ge463_alteracao_produto
integer x = 2011
integer y = 1336
integer width = 2734
integer height = 844
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_ge463_detalhe_uf_produto"
end type

event ue_addrow;//Override

Return This.InsertRow(0)
end event

event ue_populate_dddw;call super::ue_populate_dddw;Long lvl_NCM
String lvs_UF
Long lvl_Linha

dw_2.AcceptText()
lvs_UF	= dw_2.Object.Cd_Unidade_Federacao	[dw_2.GetRow()]
lvl_NCM	= dw_4.Object.nr_classificacao_fiscal		[dw_4.GetRow()]

pdwc_dddw.SetTransObject(SqlCa)

Choose Case ps_Coluna
	Case "cd_tipo_icms" 
		pdwc_dddw.Retrieve(lvs_UF)
	Case "nr_ncm_situacao" 
		pdwc_dddw.Retrieve(lvl_NCM, lvs_UF)
		lvl_Linha = pdwc_dddw.InsertRow(1)	
		pdwc_dddw.SetItem(1,"nr_ncm",lvl_NCM)
		pdwc_dddw.SetItem(1,"cd_uf",lvs_UF)
		pdwc_dddw.SetItem(1,"de_situacao_especial","NENHUMA")
	Case Else
		pdwc_dddw.Retrieve()
End Choose
end event

event doubleclicked;call super::doubleclicked;String lvs_UF
String lvs_Pis
String lvs_Lei

Long lvl_Tributacao_Atual
Long lvl_Situacao
Long lvl_Tributacao_Selecionada
Long lvl_NCM
	
If dwo.Name = "cd_tributacao_produto" Then		
	lvl_Situacao 			= dw_3.Object.nr_ncm_situacao			[Row]
	
	If IsNull(lvl_Situacao) or (lvl_Situacao = 0) Then
		
		//UF
		lvs_UF 					= dw_2.Object.Cd_Unidade_Federacao	[dw_2.GetRow()]
		lvl_NCM 					= dw_4.Object.nr_classificacao_fiscal		[1]
		lvs_Pis 					= dw_4.Object.id_situacao_pis_cofins	[1]
		lvs_Lei 					= dw_4.Object.id_lei_generico				[1]
		//Tributacao Atual
		lvl_Tributacao_Atual	= dw_3.Object.cd_tributacao_produto	[Row]
		
		ivo_tributacao.Of_localiza_Generica ('', lvs_UF, lvl_Tributacao_Atual,lvl_NCM,lvs_Pis,lvs_Lei)
			
		If ivo_Tributacao.Localizado Then
			If (lvs_Pis <> ivo_tributacao.Lista_pis_cofins) and (Not IsNull(ivo_tributacao.Lista_pis_cofins)) and(ivo_tributacao.Lista_pis_cofins<>'') and (Not IsNull(lvs_Pis)) Then
				If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','A lista PIS/COFINS da tributa$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ diferente da definida neste produto. ~r~nDeseja continuar mesmo assim?',Exclamation!,YesNo!,2) = 2 Then 
					Return -1
				End If
			End If
			
			lvl_Tributacao_Selecionada = ivo_Tributacao.Cd_Tributacao_Produto
			This.Object.id_tributacao_lei_generico		[Row] = ivo_tributacao.lei_generico
			This.Object.id_tributacao_lista_pis_cofins	[Row] = ivo_tributacao.Lista_pis_cofins
			
			If IsNull(lvl_Tributacao_Atual) or (lvl_Tributacao_Atual <> lvl_Tributacao_Selecionada) Then
				
				dw_3.Object.cd_tributacao_produto[row] = lvl_Tributacao_Selecionada
				
				dw_3.Event ue_Pos(row,"pc_icms_compra_preco")
				
				This.ivm_Menu.mf_Confirmar(True)
				This.ivm_Menu.mf_Cancelar(True)
				
				ivw_ParentWindow.ivb_Valida_Salva 	= True
				
			End If
		End If
	End If
End If
end event

event itemchanged;call super::itemchanged;DataWindowChild ldw_Child

Choose Case Dwo.Name
	Case 'cd_tipo_icms'
		If This.GetChild(Dwo.Name, ldw_Child) = 1 Then
			This.Object.pc_icms	[Row] = ldw_Child.GetItemDecimal(ldw_Child.GetRow(),'pc_icms')
			This.Object.pc_fcp		[Row] = ldw_Child.GetItemDecimal(ldw_Child.GetRow(),'pc_fcp')
		End If
	Case 'nr_ncm_situacao'
		If (Not IsNull(Data)) and (Data <> '') Then
			If This.GetChild(Dwo.Name, ldw_Child) = 1 Then
				This.Object.cd_tipo_icms				[Row] = ldw_Child.GetItemNumber(ldw_Child.GetRow(),'cd_tipo_icms')
				This.Object.cd_tributacao_icms		[Row] = ldw_Child.GetItemString(ldw_Child.GetRow(),'cd_tributacao_icms')
				This.Object.cd_mensagem_fiscal	[Row] = ldw_Child.GetItemNumber(ldw_Child.GetRow(),'cd_mensagem_fiscal')
				This.Object.cd_tributacao_produto	[Row] = ldw_Child.GetItemNumber(ldw_Child.GetRow(),'cd_tributacao_produto')
				This.Object.pc_reducao_base_st	[Row] = ldw_Child.GetItemNumber(ldw_Child.GetRow(),'pc_reducao_base_st')
				This.Object.id_sit_especial			[Row] = IIF(ldw_Child.GetItemString(ldw_Child.GetRow(),'id_padrao')='S','N','S')
			End If
		End if
End Choose

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva 	= True


end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva 	= True
end event

event getfocus;call super::getfocus;ivo_Controle_Menu.of_Atualiza()
end event

event rowfocuschanged;call super::rowfocuschanged;If dw_2.GetRow() <> CurrentRow Then
	dw_2.Post ScrollToRow(CurrentRow)
	dw_2.Post SetRow(CurrentRow)
End If
end event

event scrollvertical;call super::scrollvertical;If dw_2.GetRow() > 0 Then
	This.Post ScrollToRow(dw_2.GetRow())
	Return -1
End if
end event

type cb_1 from commandbutton within w_ge463_alteracao_produto
integer x = 1513
integer y = 60
integer width = 411
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Pend$$HEX1$$ea00$$ENDHEX$$ncias"
end type

event clicked;String lvs_Produto

SetPointer(HourGlass!)

If Parent.ivb_Valida_Salva Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes que ao continuar ser$$HEX1$$e300$$ENDHEX$$o perdidas.~rDeseja continuar?", Question!, YesNo!,2) = 2 Then
		Return -1
	Else
			
		ivm_Menu.mf_Confirmar(False)
		ivm_Menu.mf_Cancelar(False)
		
		ivb_Valida_Salva = False
	End If
End If

Open(w_ge463_consulta_pendencia_produtos)

SetPointer(Arrow!)

lvs_Produto = Message.StringParm

If Not IsNull(lvs_Produto) Then
	wf_localiza_produto(Long(lvs_produto))
End If

cb_atualiza_ncm.Enabled = (Not IsNull(lvs_Produto))


end event

type gb_3 from groupbox within w_ge463_alteracao_produto
integer x = 18
integer y = 848
integer width = 1943
integer height = 1348
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "U.F.~'s com Filiais Ativas"
end type

type dw_4 from dc_uo_dw_base within w_ge463_alteracao_produto
event ue_set_lista_pis_cofins ( string ps_valor )
integer x = 18
integer y = 224
integer width = 4763
integer height = 1008
integer taborder = 30
boolean enabled = false
string dataobject = "dw_ge463_pis_fiscal"
end type

event ue_set_lista_pis_cofins(string ps_valor);This.Object.id_situacao_Pis_Cofins [This.GetRow()] = ps_valor
end event

event itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case 'de_ncm' 
		If Data <> ivo_ncm.de_ncm Then
			If Data <> '' Then
				Return 1
			Else
				ivo_ncm.of_inicializa( )
				This.Object.de_ncm 					[Row] = ivo_ncm.de_ncm
				This.Object.nr_classificacao_fiscal	[Row] = ivo_ncm.nr_ncm
				
				wf_preenche_cest(False)	
			End If
		End If
	Case 'de_cest' 
		If Data <> ivo_cest.de_cest Then
			If Data <> '' Then
				Return 1
			Else
				ivo_cest.of_inicializa( )
				This.Object.cd_cest [Row] = ivo_cest.cd_cest
				This.Object.de_cest [Row] = ivo_cest.de_cest
			End If
		End If
	Case 'id_situacao_pis_cofins'

		If Not wf_valida_tributacao_lista_pis(Data) Then
			If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Existe(m) tributa$$HEX2$$e700e300$$ENDHEX$$o($$HEX1$$f500$$ENDHEX$$es) informadas que s$$HEX1$$e300$$ENDHEX$$o espec$$HEX1$$ed00$$ENDHEX$$ficas de outra lista PIS/COFINS. '+ &
								'Se a lista for alterada essa(s) tributa$$HEX2$$e700e300$$ENDHEX$$o($$HEX1$$f500$$ENDHEX$$es) ser$$HEX1$$e300$$ENDHEX$$o removidas.~r~n~r~n'+ &
								'Deseja continuar com a altera$$HEX2$$e700e300$$ENDHEX$$o?',Exclamation!,YesNo!,2)=2 Then
				Data = This.Object.id_situacao_pis_cofins [Row] 
				
				This.Post Event ue_set_lista_pis_cofins(Data)
				
				Return -1
			Else
				wf_limpa_tributacao_produto_divergente(Data)
			End If
		End If
		
		wf_preenche_cest(False)
End Choose

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva = True
end event

event editchanged;call super::editchanged;This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)

ivw_ParentWindow.ivb_Valida_Salva 	= True
end event

event getfocus;call super::getfocus;Parent.ivm_Menu.mf_Excluir(False)
end event

event ue_key;call super::ue_key;Long lvl_NCM
String lvs_Cest
String lvs_Lista
String lvs_Tipo

If Key = KeyEnter! Then
	This.Accepttext( )
	
	Choose Case This.GetColumnName()
		Case 'de_ncm'
			lvl_NCM = This.Object.nr_classificacao_fiscal	[1]
			ivo_ncm.of_localiza(lvl_NCM, This.GetText() )
			
			If ivo_ncm.Localizado Then
				This.Object.nr_classificacao_fiscal	[1] = ivo_ncm.nr_ncm
				This.Object.de_ncm					[1] = ivo_ncm.de_ncm
				
				If IsNull(lvl_NCM) or (lvl_NCM <> ivo_ncm.nr_ncm) Then
					If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Deseja alterar a tributa$$HEX2$$e700e300$$ENDHEX$$o deste produto pela tributa$$HEX2$$e700e300$$ENDHEX$$o da NCM selecionada?',Question!,YesNo!,1) = 1 Then
						wf_atualiza_tributacao_ncm(ivo_ncm.nr_ncm)
						wf_atualiza_tributacao_ncm_uf(ivo_ncm.nr_ncm)
					Else
						wf_limpa_situacao_ncm()
					End If
					
					
					wf_preenche_cest(False)
					/*ivo_cest.Of_inicializa( )			
					This.Object.cd_cest	[1] = ivo_cest.cd_cest
					This.Object.de_cest	[1] = ivo_cest.de_cest*/
				End if
			Else
				If (Not IsNull(lvl_NCM)) and (lvl_NCM > 0) Then 
					ivo_ncm.of_localiza(String(lvl_NCM))
				Else
					ivo_ncm.Of_inicializa( )
					
					ivo_cest.Of_inicializa( )			
					This.Object.cd_cest	[1] = ivo_cest.cd_cest
					This.Object.de_cest	[1] = ivo_cest.de_cest
				End If
				
				This.Object.nr_classificacao_fiscal	[1] = ivo_ncm.nr_ncm
				This.Object.de_ncm					[1] = ivo_ncm.de_ncm	
			End If
			
			wf_atualiza_sit_especial()
			This.Accepttext( )
		Case 'de_cest'
			lvs_Cest	= This.Object.cd_cest						[1]
			lvl_NCM	= This.Object.nr_classificacao_fiscal	[1]
			lvs_Lista	= This.Object.id_situacao_pis_cofins	[1]
			lvs_Tipo	= This.Object.id_lei_generico			[1]
			
			ivo_cest.of_localiza(lvs_Cest, This.GetText(), lvl_NCM, lvs_Lista, lvs_Tipo )
			
			If ivo_cest.Localizado Then
				This.Object.cd_cest	[1] = ivo_cest.cd_cest
				This.Object.de_cest	[1] = ivo_cest.de_cest
			Else
				If (Not IsNull(lvs_Cest)) and (Trim(lvs_Cest)<>'') Then 
					ivo_cest.of_localiza_codigo( lvs_Cest )
				Else
					ivo_cest.Of_inicializa( )
				End If
				
				This.Object.cd_cest	[1] = ivo_cest.cd_cest
				This.Object.de_cest	[1] = ivo_cest.de_cest
			End If			
			This.Accepttext( )
	End Choose
End If

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)
ivw_ParentWindow.ivb_Valida_Salva 	= True
end event

event losefocus;call super::losefocus;If IsValid(ivo_ncm) Then
	This.Object.de_ncm [1] = ivo_ncm.de_ncm
End If

If IsValid(ivo_cest) Then
	This.Object.de_cest [1] = ivo_cest.de_cest
End If
end event

event ue_postretrieve;call super::ue_postretrieve;DateTime ldh_Ult_Alter

String ls_Matricula
String ls_Nome_Usuario

This.AcceptText()

If pl_Linhas > 0 Then
	ivo_ncm.of_localiza_codigo(This.Object.nr_classificacao_fiscal [1] )
	If Not ivo_cest.of_localiza_codigo( This.Object.cd_cest [1] ) Then
		wf_preenche_cest(True)
	End If
	
	wf_atualiza_lista_pis_cofins_ncm()
	
	If Not gf_Ultima_Alter_Cad_Prod(String(This.Object.Cd_Produto[1]), Ref ldh_Ult_Alter, Ref ls_Matricula, Ref ls_Nome_Usuario) Then Return -1
	
	If ldh_Ult_Alter = DateTime("01/01/1900") Then
		SetNull(ls_Nome_Usuario)
		SetNull(ls_Matricula)
		SetNull(ldh_Ult_Alter)
	End If
	
	This.Object.Nm_Usuario_Atualizacao		[1] = ls_Nome_Usuario
	This.Object.Nm_Matricula_Atualizacao	[1] = ls_Matricula
	This.Object.Dh_Atualizacao_Prd			[1] = ldh_Ult_Alter
End If

Return AncestorReturnValue
end event

event ue_recuperar;//override
Return This.Retrieve(ivo_Produto.cd_produto)
end event

event ue_update;call super::ue_update;String lvs_Historico
Long lvl_Produto

If AncestorReturnValue > -1 Then
	dw_4.Accepttext( )
	lvs_Historico	= This.Object.de_historico_fiscal	[1]
	lvl_Produto	= This.Object.cd_produto 			[1]
	
	update produto_central
	set de_historico_fiscal = :lvs_Historico
	where cd_produto = :lvl_Produto
		And coalesce(de_historico_fiscal,'') <> :lvs_Historico
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_msgdberror('Atualiza$$HEX2$$e700e300$$ENDHEX$$o produto central.')
		SQLCa.Of_RollBack()
		Return -1
	End if
End if

Return AncestorReturnValue
end event

type cb_atualiza_ncm from commandbutton within w_ge463_alteracao_produto
integer x = 3918
integer y = 116
integer width = 841
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Validar Tributa$$HEX2$$e700e300$$ENDHEX$$o NCM"
end type

event clicked;Long lvl_NCM

dw_4.Accepttext( )
lvl_NCM = dw_4.Object.nr_classificacao_fiscal [1]

If Not IsNull(lvl_NCM) and (lvl_NCM >0) Then
	If wf_valida_tributacao_ncm() Then
		MessageBox('Sucesso!','Valida$$HEX2$$e700e300$$ENDHEX$$o encerrada com sucesso!')
	End If
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Primeiramente preencha o NCM para este produto!',Exclamation!)
	dw_4.Event ue_Pos(1,'de_ncm')
End If
end event

type st_1 from statictext within w_ge463_alteracao_produto
boolean visible = false
integer x = 1993
integer y = 32
integer width = 1723
integer height = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

