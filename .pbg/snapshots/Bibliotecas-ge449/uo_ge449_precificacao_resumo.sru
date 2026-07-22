HA$PBExportHeader$uo_ge449_precificacao_resumo.sru
forward
global type uo_ge449_precificacao_resumo from nonvisualobject
end type
end forward

global type uo_ge449_precificacao_resumo from nonvisualobject
end type
global uo_ge449_precificacao_resumo uo_ge449_precificacao_resumo

type variables
Date adh_inicio_mes
Date adh_termino_mes

dc_uo_ds_base ids_PRD

String is_Tipo_Precificacao
end variables

forward prototypes
public subroutine of_grava_log (string as_mensagem)
public function boolean of_grava_resumo (date adh_resumo)
public function boolean of_carrega_produtos ()
public function boolean of_valida_resumo ()
public function boolean of_grava_precificacao (integer ai_tipo_precificacao, string as_uf, string as_rede, string as_subcategoria, string as_matricula_responsavel)
public function boolean of_grava_produtos ()
private function boolean of_grava_desconto (string as_pbm)
end prototypes

public subroutine of_grava_log (string as_mensagem);String ls_Anexo[]

gf_ge202_envia_email_automatico(146, "", as_mensagem, ls_Anexo[])
end subroutine

public function boolean of_grava_resumo (date adh_resumo);Boolean lvb_Sucesso = False

adh_inicio_mes 	= gf_Primeiro_Dia_Mes(adh_Resumo)
adh_termino_mes 	= gf_Retorna_Ultimo_Dia_Mes(adh_Resumo)

//If Not This.of_valida_resumo() Then Return True

//// Carrega os produtos que ser$$HEX1$$e300$$ENDHEX$$o utiizados nas fun$$HEX2$$e700f500$$ENDHEX$$es abaixo
If This.of_carrega_produtos() Then
	//Grava informa$$HEX2$$e700f500$$ENDHEX$$es dos produtos / qtde / custo / faturamento
	If This.Of_Grava_Produtos() Then
		//Medicamento (sem considerar PBM)
		If This.of_grava_desconto("N") Then
			//Medicamento (somente PBM)
			If This.of_grava_desconto("S") Then
				lvb_Sucesso = True
			End If
		End If
	End If
End If

If lvb_Sucesso Then
	SQLCa.Of_Commit()
Else
	SQLCa.Of_RollBack()
End If

Return lvb_Sucesso
end function

public function boolean of_carrega_produtos ();String ls_AppendWhere

If Not ids_PRD.of_ChangeDataObject("ds_ge449_lista_produto", False) Then 
	This.of_Grava_Log("Erro na troca da dw [ds_ge449_lista_produto].")
	Return False
End If

ls_AppendWhere = ''

// Tipo de c$$HEX1$$e100$$ENDHEX$$lculo espec$$HEX1$$ed00$$ENDHEX$$fico
If Not IsNull(is_Tipo_Precificacao) and (is_Tipo_Precificacao<>"") Then
	ls_AppendWhere = "s.cd_tipo_precificacao = "+is_Tipo_Precificacao
Else
	ls_AppendWhere = "coalesce(s.cd_tipo_precificacao,0) > 0"
End If

ids_PRD.of_AppendWhere(ls_AppendWhere)
//ids_PRD.of_AppendWhere("s.cd_subcategoria='104003021'")
		
If ids_PRD.Retrieve(adh_inicio_mes) < 0 Then
	SqlCa.of_RollBack();
	of_Grava_Log("Erro ao recuperar a lista de produtos.")
	Return False
End If

Return True
end function

public function boolean of_valida_resumo ();Date ldh_Parametro

Long ll_Produtos

String ls_MSG

ldh_Parametro = gf_Primeiro_Dia_Mes(Date(gf_GetServerDate()))

If adh_inicio_mes >= ldh_Parametro Then	
	If Not gvb_auto Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Resumo de precifica$$HEX2$$e700e300$$ENDHEX$$o deve ser inferior a '" + String(adh_inicio_mes) + "'.")
	Else
		This.of_Grava_Log("Resumo de precifica$$HEX2$$e700e300$$ENDHEX$$o deve ser inferior a '" + String(adh_inicio_mes) + "'.")
	End If
	
	Return False
End If

// Um tipo espec$$HEX1$$ed00$$ENDHEX$$fico de c$$HEX1$$e100$$ENDHEX$$lculo
If Not IsNull(is_Tipo_Precificacao) and (is_Tipo_Precificacao <> "") Then
	Select count(1) 
	Into :ll_Produtos 
	from resumo_precificacao r
	inner join produto_geral g
		on g.cd_produto = r.cd_produto
	Inner Join subcategoria s
		on s.cd_subcategoria = g.cd_subcategoria
	Where r.dh_resumo = :adh_inicio_mes
		and s.cd_tipo_precificacao = cast(:is_Tipo_Precificacao as integer)
	Using SqlCa;
Else
	Select count(1) 
	Into :ll_Produtos 
	from resumo_precificacao r
	inner join produto_geral g
		on g.cd_produto = r.cd_produto
	Inner Join subcategoria s
		on s.cd_subcategoria = g.cd_subcategoria
	Where r.dh_resumo = :adh_inicio_mes
		and coalesce(s.cd_tipo_precificacao,0) > 0
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	ls_MSG = SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_Grava_Log("Erro ao verificar o resumo de precifica$$HEX2$$e700e300$$ENDHEX$$o '" +  ls_MSG + "'.")
	Return False
End If

If ll_Produtos > 0 Then
	This.of_Grava_Log("Resumo de precifica$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ existente para o per$$HEX1$$ed00$$ENDHEX$$odo '" + String(adh_inicio_mes) + "'.")
	
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'RO' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Resumo de precifica$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ existente para o per$$HEX1$$ed00$$ENDHEX$$odo '" + String(adh_inicio_mes) + "'.")
	End If
	
	Return False
End If

Return True
end function

public function boolean of_grava_precificacao (integer ai_tipo_precificacao, string as_uf, string as_rede, string as_subcategoria, string as_matricula_responsavel);Long ll_Proximo

Select coalesce(max(nr_precificacao), 0) + 1
Into :ll_Proximo
From precificacao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	of_Grava_Log("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo de precific$$HEX1$$e300$$ENDHEX$$o.")
	Return False
End If

INSERT INTO precificacao  ( nr_precificacao, cd_tipo_precificacao, cd_uf, id_rede_filial,  cd_subcategoria, dh_inclusao,  nr_matricula_responsavel, id_situacao)  
VALUES ( :ll_Proximo, :ai_tipo_precificacao, :as_uf,  :as_rede, :as_subcategoria, getdate(), :as_matricula_responsavel, 'P')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	of_Grava_Log("Erro ao incluir a precifica$$HEX2$$e700e300$$ENDHEX$$o.")
	Return False
End If

SqlCa.of_Commit();

Return True
end function

public function boolean of_grava_produtos ();String ls_MSG

Open(w_Aguarde)
w_Aguarde.Title = "Gravando produtos..."

If Not IsNull(is_Tipo_Precificacao) and (is_Tipo_Precificacao <> "") Then
	INSERT INTO resumo_precificacao  ( dh_resumo, cd_produto, cd_uf, id_rede_filial, pc_desconto, vl_preco_liquido, vl_custo, pc_desconto_pbm, qt_vendida) 
	Select		r.dh_resumo,
				r.cd_produto,
				c.cd_unidade_federacao,
				f.id_rede_filial,
				0.00,
				sum(r.vl_venda) as vl_fat_liquido,
				sum((r.vl_comissao + coalesce(r.vl_cmv_gerencial, 0))) as vl_custo,
				0.00,
				sum(r.qt_venda - r.qt_devolucao_venda) as qt_vendida
	from resumo_produto_filial r (index idx_data_filial)
	inner join filial f (index pk_filial)
		on f.cd_filial = r.cd_filial
	inner join cidade c (index pk_cidade)
		on c.cd_cidade = f.cd_cidade
	inner join produto_geral g (index pk_produto_geral)
		on g.cd_produto = r.cd_produto
	inner join subcategoria s (index pk_subcategoria)
		on s.cd_subcategoria = g.cd_subcategoria
	where r.dh_resumo = :adh_inicio_mes
		and s.cd_tipo_precificacao = cast(:is_Tipo_Precificacao as integer)
		and (r.qt_venda - coalesce(r.qt_devolucao_venda,0)) > 0
		and not exists (select 1 from resumo_precificacao rp1 
							where rp1.dh_resumo = r.dh_resumo 
								and rp1.cd_produto = r.cd_produto 
								and rp1.cd_uf = c.cd_unidade_federacao
								and rp1.id_rede_filial = f.id_rede_filial)
	group by r.dh_resumo,
				r.cd_produto,
				c.cd_unidade_federacao,
				f.id_rede_filial
	Using SQLCa;
Else
	INSERT INTO resumo_precificacao  ( dh_resumo, cd_produto, cd_uf, id_rede_filial, pc_desconto, vl_preco_liquido, vl_custo, pc_desconto_pbm, qt_vendida) 
	Select		r.dh_resumo,
				r.cd_produto,
				c.cd_unidade_federacao,
				f.id_rede_filial,
				0.00,
					sum(r.vl_venda) as vl_fat_liquido,
				sum((r.vl_comissao + coalesce(r.vl_cmv_gerencial, 0))) as vl_custo,
				0.00,
				sum(r.qt_venda - r.qt_devolucao_venda) as qt_vendida
	from resumo_produto_filial r (index idx_data_filial)
	inner join filial f (index pk_filial)
		on f.cd_filial = r.cd_filial
	inner join cidade c (index pk_cidade)
		on c.cd_cidade = f.cd_cidade
	where r.dh_resumo = :adh_inicio_mes
		and (r.qt_venda - coalesce(r.qt_devolucao_venda,0)) > 0
		and not exists (select 1 from resumo_precificacao rp1 
							where rp1.dh_resumo = r.dh_resumo 
								and rp1.cd_produto = r.cd_produto 
								and rp1.cd_uf = c.cd_unidade_federacao
								and rp1.id_rede_filial = f.id_rede_filial)
	group by r.dh_resumo,
				r.cd_produto,
				c.cd_unidade_federacao,
				f.id_rede_filial
	Using SQLCa;
End If

Close(w_Aguarde)

If SqlCa.SqlCode = -1 Then
	ls_MSG = SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_Grava_Log("Carga produtos / faturamento / quantidade / custo - Erro ao gravar o resumo de precifica$$HEX2$$e700e300$$ENDHEX$$o dos produtos - '" +  ls_MSG + "'.")
	Return False
End If

Return True
end function

private function boolean of_grava_desconto (string as_pbm);Long ll_Linha, ll_Linhas, ll_Produto, ll_Linha_Venda, ll_Linhas_Venda

String ls_MSG, ls_UF, ls_Rede, ls_Tipo, ls_Dh_Inicio_Comando, ls_DW

Decimal ldc_Desconto

try
	
	If as_pbm = "S" Then
		ls_Tipo 	= "% Desconto PBM"
		ls_DW	= "ds_ge449_vendas_desconto_pbm"
	Else
		ls_Tipo = "% Desconto"
		ls_DW	= "ds_ge449_vendas_desconto"
	End If
	
	ll_Linhas = 	ids_PRD.RowCount()
		
	If ll_Linhas > 0 Then
		
		Open(w_Aguarde)
		w_aguarde.uo_progress.of_setmax(ll_Linhas)
		w_Aguarde.Title = "Resumo Precifica$$HEX2$$e700e300$$ENDHEX$$o - " + ls_Tipo
		
		ls_Dh_Inicio_Comando = String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" )
					
		dc_uo_ds_base lds_venda
		lds_venda = Create dc_uo_ds_base
		
		If Not lds_Venda.of_ChangeDataObject(ls_DW, False) Then 
			This.of_Grava_Log(ls_Tipo + " - Erro na troca da dw ["+ls_DW+"].")
			Return False
		End If
				
		For ll_Linha = 1 To ll_Linhas
			
			w_Aguarde.Title = "Resumo Precifica$$HEX2$$e700e300$$ENDHEX$$o - " + ls_Tipo+" - "+String(ll_Linha)+" de "+String(ll_Linhas)
			ll_Produto = ids_PRD.Object.cd_produto[ll_Linha]
			
			ll_Linhas_Venda = lds_venda.Retrieve(adh_inicio_mes, adh_termino_mes, ll_Produto)
			
			If ll_Linhas_Venda > 0 Then
				
				For ll_Linha_Venda  = 1 To ll_Linhas_Venda
					
					ls_UF 				= lds_venda.Object.cd_unidade_federacao	[ll_Linha_Venda]
					ls_Rede 			= lds_venda.Object.id_rede_filial				[ll_Linha_Venda]
					ldc_Desconto 	= lds_venda.Object.pc_desconto				[ll_Linha_Venda]
									
					If as_pbm = "S" Then
						
						Update resumo_precificacao
						Set pc_desconto_pbm= :ldc_Desconto
						Where dh_resumo	 	= :adh_inicio_mes
							and cd_produto 	= :ll_Produto
							and cd_uf 			= :ls_UF
							and id_rede_filial 	= :ls_Rede
						Using SqlCa;
													
					Else
						
						Update resumo_precificacao
						Set pc_desconto 		= :ldc_Desconto
						Where dh_resumo	 	= :adh_inicio_mes
							and cd_produto 	= :ll_Produto
							and cd_uf 			= :ls_UF
							and id_rede_filial 	= :ls_Rede
						Using SqlCa;
													
					End If
					
					Choose Case SqlCa.SqlCode
						Case 0
							If SQLCa.SQLNRows = 0 Then						
							
								If as_pbm = "S" Then
								
									INSERT INTO resumo_precificacao  ( dh_resumo, cd_produto, cd_uf, id_rede_filial, pc_desconto, vl_preco_liquido, vl_custo, pc_desconto_pbm, qt_vendida)  
									VALUES (:adh_inicio_mes, :ll_Produto, :ls_UF, :ls_Rede, 0.00, 0.00, 0.00, :ldc_Desconto, 0) 
									Using SqlCa;
								
								Else
									
									INSERT INTO resumo_precificacao  ( dh_resumo, cd_produto, cd_uf, id_rede_filial, pc_desconto, vl_preco_liquido, vl_custo, pc_desconto_pbm, qt_vendida)  
									VALUES (:adh_inicio_mes, :ll_Produto, :ls_UF, :ls_Rede, :ldc_Desconto, 0.00, 0.00,0.00,0) 
									Using SqlCa;
									
								End If
								
								If SqlCa.SqlCode = -1 Then
									ls_MSG = SqlCa.SqlErrText
									SqlCa.of_RollBack()
									This.of_Grava_Log(ls_Tipo + " - Erro ao inserir o resumo de precifica$$HEX2$$e700e300$$ENDHEX$$o do produto [" + String(ll_Produto) + "] - '" +  ls_MSG + "'.")
									Return False
								End If
							End If
							
						Case -1
							ls_MSG = SqlCa.SqlErrText
							SqlCa.of_RollBack()
							This.of_Grava_Log(ls_Tipo + " - Erro ao atualizar o resumo de precifica$$HEX2$$e700e300$$ENDHEX$$o do produto [" + String(ll_Produto) + "] - '" +  ls_MSG + "'.")
							Return False
					End Choose
					
				Next
				
			ElseIf ll_Linhas_Venda < 0 Then
				SqlCa.of_RollBack();
				of_Grava_Log(ls_Tipo + " - Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es do produto [" + String(ll_Produto) + "].")
				Return False
			End If
						
			w_aguarde.uo_progress.of_setprogress(ll_Linha)
			
		Next
		
		of_Grava_Log(	"Precificacao. " + ls_Tipo + " | In$$HEX1$$ed00$$ENDHEX$$cio: " + ls_Dh_Inicio_Comando + " | T$$HEX1$$e900$$ENDHEX$$rmino: " + String( DateTime( Today( ), Now( ) ), "dd/mm/yy hh:mm:ss" ))
		
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack();
		of_Grava_Log(ls_Tipo + " - Erro ao recuperar a lista de produtos.")
		Return False
	End If
	
finally
	If IsValid(lds_venda) Then Destroy lds_venda
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
end try

Return True
end function

on uo_ge449_precificacao_resumo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge449_precificacao_resumo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_PRD = Create dc_uo_ds_base
end event

event destructor;Destroy ids_PRD
end event

