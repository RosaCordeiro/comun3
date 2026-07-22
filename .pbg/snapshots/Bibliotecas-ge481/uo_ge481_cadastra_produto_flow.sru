HA$PBExportHeader$uo_ge481_cadastra_produto_flow.sru
forward
global type uo_ge481_cadastra_produto_flow from nonvisualobject
end type
end forward

global type uo_ge481_cadastra_produto_flow from nonvisualobject
end type
global uo_ge481_cadastra_produto_flow uo_ge481_cadastra_produto_flow

type variables
Boolean lb_Controlado_Lote_Endereco  = False, ib_ignora_sem_endereco_vago = False
Boolean ib_Envia_Email = True
String is_End_Cadastrado
String is_CadastrouEndControlado
end variables

forward prototypes
private function boolean of_custo_produto (long al_produto, ref decimal adc_custo, ref string as_erro)
private function boolean of_esteira_produto (long al_produto, ref long al_esteira, ref string as_geladeira, ref string as_erro)
public function boolean of_lista_produtos_sem_endereco_flow ()
private function boolean of_localiza_endereco_vago_flow (long al_produto, long al_esteira, string as_geladeira, ref string as_endereco, ref string as_endereco_flow, ref string as_erro, string as_origem_excesso, ref string as_achou_vago, boolean ab_abast_controlado)
public function boolean of_cadastra_produto_flow (ref st_ge481_cadastra_prd_flow ast_produtos[], string as_matricula, ref string as_erro, boolean ab_abast_controlado)
end prototypes

private function boolean of_custo_produto (long al_produto, ref decimal adc_custo, ref string as_erro);
select coalesce(vl_custo_medio, 0.00)
Into :adc_Custo
from vw_saldo_atual_produto
where cd_filial = 534
and cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
	Case 100
		adc_Custo = 0.00
	Case -1
		as_Erro	=  "Erro ao localizar o custo do produto na tabela 'vw_saldo_atual_produto': "+SqlCa.SqlErrText
		Return False
End Choose

If adc_Custo = 0 or isNull(adc_Custo) Then
	select vl_preco_reposicao
	Into :adc_Custo
	from produto_uf
	where cd_produto = :al_Produto
	and cd_unidade_federacao = 'SC'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode 
		Case 0
		Case 100
			adc_Custo = 0.00
		Case -1
			as_Erro	= "Erro ao localizar o custo do produto na tabela 'produto_uf': "+SqlCa.SqlErrText
			Return False
	End Choose
End If

Return True
end function

private function boolean of_esteira_produto (long al_produto, ref long al_esteira, ref string as_geladeira, ref string as_erro);/* Para registro, o trecho do codigo abaixo tamb$$HEX1$$e900$$ENDHEX$$m foi criado no banco como uma fun$$HEX2$$e700e300$$ENDHEX$$o: dbo.fn_wms_retorna_esteira_produto(cd_produto) */


String	ls_Geladeira,&
		ls_Vigiado,&
		ls_Grupo_Psico,&
		ls_Subcategoria,&
		ls_Categoria,&
		ls_Erro
		
as_Geladeira = "N"		
		
Select	isNull(a.id_geladeira, 'N'),
		isNull(b.id_vigiado, 'N'),
		a.cd_grupo_psico,
		substring(a.cd_subcategoria, 1, 1),
		substring(a.cd_subcategoria,1,6)
Into	:ls_Geladeira,
		:ls_Vigiado,
		:ls_Grupo_Psico,
		:ls_Subcategoria,
		:ls_Categoria
From produto_geral a 
inner join produto_central b on b.cd_produto = a.cd_produto
where a.cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto "+String(al_Produto)+", fun$$HEX2$$e700e300$$ENDHEX$$o: 'wf_Esteira_Produto'."
		Return False
	Case -1
	ls_Erro	=	"Erro ao verificar se o produto $$HEX1$$e900$$ENDHEX$$ vigiado ou geladeira: "+SqlCa.SqlErrText
	Return False
End Choose

If ls_Categoria = "102153" Then //Vacinas

	al_Esteira = 6

ElseIf ls_Geladeira = "S" Then//Geladeira
				
	al_Esteira = 4
	
	as_Geladeira = "S"
	
ElseIf  Not IsNull(ls_Grupo_Psico)  or  (ls_Vigiado = "S") Then //Controlados e vigiados	
	
	 al_Esteira = 3
	 
ElseIf (ls_Subcategoria = "1") and  IsNull(ls_Grupo_Psico) and (ls_Vigiado <> "S") and (ls_Geladeira <> "S") Then //Medicamentos
	
	al_Esteira = 2
	
ElseIf (ls_Subcategoria = '2') or (ls_Subcategoria = '3') or (ls_Subcategoria = '4') Then //Perfumaria
	
	al_Esteira = 1
	
ElseIf (ls_Subcategoria = '5') Then //Almoxarifado
	
	al_Esteira = 5
	
Else
	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel definir de que esteira $$HEX1$$e900$$ENDHEX$$ o produto "+String(al_Produto)+", ao tentar cadastrar ele em um endere$$HEX1$$e700$$ENDHEX$$o do flow rack."
	Return False
End If

Return True
end function

public function boolean of_lista_produtos_sem_endereco_flow ();Long ll_Qtd_Registros 

	
	





Return True 
end function

private function boolean of_localiza_endereco_vago_flow (long al_produto, long al_esteira, string as_geladeira, ref string as_endereco, ref string as_endereco_flow, ref string as_erro, string as_origem_excesso, ref string as_achou_vago, boolean ab_abast_controlado);String	ls_Erro,&
		ls_Produto_Grande

// Recebe a Informa$$HEX2$$e700e300$$ENDHEX$$o Quando Ret.Excesso
If IsNull(as_origem_excesso) or as_origem_excesso = ""  Then as_origem_excesso = 'N'

SetNull(as_Endereco)
SetNull(as_Endereco_Flow)

//Geladeira
If as_Geladeira = "S" Then
	SELECT	top 1 e.cd_endereco,
				e.de_endereco_flow_rack
	Into	:as_Endereco,
			:as_Endereco_Flow
	FROM vw_wms_endereco e
	WHERE (e.id_flow_rack = 'S' and e.id_flow_rack_bairro = 'S')
		and not exists (select * from wms_endereco_produto p where p.cd_endereco = e.cd_endereco)
		and not exists (select * from wms_endereco_balanceamento b where b.cd_endereco = e.cd_endereco)
		and not exists (select 1 from wms_localizacao wl where wl.cd_endereco	= e.cd_endereco)
		and e.cd_esteira = :al_Esteira
		and e.cd_rua in ('85')
		and (SELECT dbo.wms_retorna_end_bloqueado(e.cd_endereco)) = 'N'
	order by (Case e.cd_andar when '1' then '1'
									 when '2' then '2'
									 when '3' then '3'
									 when '0' then '4'
									 when '4' then '5'
									 when '5' then '6'
									when '6' then '7'
									when '7' then '8'
									else '9' end),
				e.cd_rua desc
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode 
		Case 0
			Return True
		Case 100
			if ib_ignora_sem_endereco_vago then
				//Retorna false para indicar que n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ endere$$HEX1$$e700$$ENDHEX$$o, mas, a seguir no c$$HEX1$$f300$$ENDHEX$$digo o processo $$HEX1$$e900$$ENDHEX$$ continua com sucesso.
				Return False
			else
				SqlCa.of_Rollback()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum endere$$HEX1$$e700$$ENDHEX$$o vago para ser cadastrado o produto de GELADEIRA "+String(al_Produto)+" sem endere$$HEX1$$e700$$ENDHEX$$o no flow rack.")
				Return False
			end if
		Case -1
			ls_Erro	= SqlCa.SqlErrText
			SqlCa.of_Rollback()
			MessageBox("Erro", "Erro ao localizar endere$$HEX1$$e700$$ENDHEX$$o vago no flow rack: "+ls_Erro+".")
			Return False
	End Choose	
End If

//Verifica se $$HEX1$$e900$$ENDHEX$$ produto grande
select coalesce(id_produto_grande_wms, 'N')
Into	:ls_Produto_Grande
from produto_central
where cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 100
		SqlCa.of_Rollback()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto "+String(al_Produto)+" fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_localiza_endereco_vago_flow'. Verifaca se o produto $$HEX1$$e900$$ENDHEX$$ grande.")
		Return False
	Case -1
		ls_Erro	= SqlCa.SqlErrText
		SqlCa.of_Rollback()
		MessageBox("Erro", "Erro ao localizar a dimens$$HEX1$$e300$$ENDHEX$$o do produto "+String(al_Produto)+": "+ls_Erro+".")
		Return False
End Choose


//Produto Grande
If ls_Produto_Grande = "S" Then
	SELECT	top 1 e.cd_endereco,
				e.de_endereco_flow_rack
	Into	:as_Endereco,
			:as_Endereco_Flow
	FROM vw_wms_endereco e
	inner join wms_endereco b on b.cd_endereco = e.cd_endereco
	WHERE (e.id_flow_rack = 'S' and e.id_flow_rack_bairro = 'S')
		and not exists (select * from wms_endereco_produto p where p.cd_endereco = e.cd_endereco)
		and not exists (select * from wms_endereco_balanceamento b where b.cd_endereco = e.cd_endereco)
		and not exists (select 1 from wms_localizacao wl where wl.cd_endereco	= e.cd_endereco)
		and e.cd_esteira = :al_Esteira
		and coalesce(b.id_produto_grande, 'N') = 'S'
		and (SELECT dbo.wms_retorna_end_bloqueado(e.cd_endereco)) = 'N'
	order by (Case e.cd_andar when '1' then '1'
									 when '2' then '2'
									 when '3' then '3'
									 when '0' then '4'
									 when '4' then '5'
									 when '5' then '6'
									when '6' then '7'
									when '7' then '8'
									else '9' end),
				e.cd_rua desc
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode 
	Case 100
		//Se n$$HEX1$$e300$$ENDHEX$$o licalizou nenhum endere$$HEX1$$e700$$ENDHEX$$o grande livre, localiza qualquer endere$$HEX1$$e700$$ENDHEX$$o
		SELECT	top 1 e.cd_endereco,
			e.de_endereco_flow_rack
		Into	:as_Endereco,
				:as_Endereco_Flow
		FROM vw_wms_endereco e
		WHERE (e.id_flow_rack = 'S' and e.id_flow_rack_bairro = 'S')
			and not exists (select * from wms_endereco_produto p where p.cd_endereco = e.cd_endereco)
			and not exists (select * from wms_endereco_balanceamento b where b.cd_endereco = e.cd_endereco)
			and not exists (select 1 from wms_localizacao wl where wl.cd_endereco	= e.cd_endereco)
			and e.cd_esteira = :al_Esteira
			and e.cd_rua not in ('85', '70') //[85 -> Geladeira] [70 -> Baixo Giro]
			and (SELECT dbo.wms_retorna_end_bloqueado(e.cd_endereco)) = 'N'
		order by (Case e.cd_andar when '1' then '1'
										 when '2' then '2'
										 when '3' then '3'
										 when '0' then '4'
										 when '4' then '5'
										 when '5' then '6'
										when '6' then '7'
										when '7' then '8'
										else '9' end),
					e.cd_rua desc
	    Using SqlCa;
		Choose Case SqlCa.SqlCode 
			Case 100
				if ib_ignora_sem_endereco_vago then
					//Retorna false para indicar que n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ endere$$HEX1$$e700$$ENDHEX$$o, mas, a seguir no c$$HEX1$$f300$$ENDHEX$$digo o processo $$HEX1$$e900$$ENDHEX$$ continua com sucesso.
					Return False
				else
					SqlCa.of_Rollback()
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum endere$$HEX1$$e700$$ENDHEX$$o vago para ser cadastrado o produto "+String(al_Produto)+" sem endere$$HEX1$$e700$$ENDHEX$$o no flow rack.")
					Return False
				end if
			Case -1
				ls_Erro	= SqlCa.SqlErrText
				SqlCa.of_Rollback()
				MessageBox("Erro", "Erro ao localizar endere$$HEX1$$e700$$ENDHEX$$o vago no flow rack: "+ls_Erro+".")
				Return False
		End Choose		
	Case -1
		ls_Erro	= SqlCa.SqlErrText
		SqlCa.of_Rollback()
		MessageBox("Erro", "Erro ao localizar endere$$HEX1$$e700$$ENDHEX$$o vago no flow rack: "+ls_Erro+".")
		Return False
	End Choose		
Else
	If al_Esteira <> 3  Then  // Outras Esteiras
			// Regra para N$$HEX1$$c300$$ENDHEX$$O EXCESSO
			If as_origem_excesso  = 'N' Then 
				SELECT	top 1 e.cd_endereco,
							e.de_endereco_flow_rack
				Into	:as_Endereco,
						:as_Endereco_Flow
				FROM vw_wms_endereco e
				inner join wms_endereco b on b.cd_endereco = e.cd_endereco
				WHERE (e.id_flow_rack = 'S' and e.id_flow_rack_bairro = 'S')
				and not exists (select * from wms_endereco_produto p where p.cd_endereco = e.cd_endereco )
				and not exists (select * from wms_endereco_balanceamento b where b.cd_endereco = e.cd_endereco)
				and not exists (select 1 from wms_localizacao wl where wl.cd_endereco	= e.cd_endereco)
				and e.cd_esteira = :al_Esteira
				and coalesce(b.id_produto_grande, 'N') <> 'S'
				and e.cd_rua not in ('85', '70') //[85 -> Geladeira] [70 -> Baixo Giro]
				and (SELECT dbo.wms_retorna_end_bloqueado(e.cd_endereco)) = 'N'
				order by (Case e.cd_andar when '1' then '1'
												 when '2' then '2'
												 when '3' then '3'
												 when '0' then '4'
												 when '4' then '5'
												 when '5' then '6'
												when '6' then '7'
												when '7' then '8'
												else '9' end),
							e.cd_rua desc
				Using SqlCa;		
			Else
				/// Chamado 911914:  Nova Regra para Ret.Excesso
				SELECT	top 1  e.cd_endereco,  
		 					e.de_endereco_flow_rack
			 	Into	:as_Endereco,
						:as_Endereco_Flow
				FROM vw_wms_endereco e
				inner join wms_endereco b on b.cd_endereco = e.cd_endereco
				inner join wms_esteira c on c.cd_esteira  = e.cd_esteira 
				WHERE (e.id_flow_rack = 'S' and e.id_flow_rack_bairro = 'S')
				and not exists (select * from wms_endereco_produto p where p.cd_endereco = e.cd_endereco )
				and not exists (select * from wms_endereco_balanceamento b where b.cd_endereco = e.cd_endereco)	
				and not exists (select 1 from wms_localizacao wl where wl.cd_endereco	= e.cd_endereco)
				and coalesce(b.id_produto_grande, 'N') <> 'S'
				and e.cd_rua not in ('85', '70')   
				and e.cd_esteira = :al_Esteira
				and (SELECT dbo.wms_retorna_end_bloqueado(e.cd_endereco)) = 'N'
				order by (Case e.cd_andar	when '7' then '1'
												when '0' then '2'
										 		when '6' then '3'
												when '1' then '4'
									    			when '5' then '6'											
												when '2' then '7'
												when '4' then '8'											
												when '3' then '9'
											else '5' end),  
							e.cd_rua desc	
				Using SqlCa;		
			End If 
	Else  // Esteira Controlado
		SELECT	top 1 e.cd_endereco,
					e.de_endereco_flow_rack
		Into	:as_Endereco,
				:as_Endereco_Flow
		FROM vw_wms_endereco e
		inner join wms_endereco b on b.cd_endereco = e.cd_endereco
		WHERE (e.id_flow_rack = 'S' and e.id_flow_rack_bairro = 'S')
		and not exists (select * from wms_endereco_produto p where p.cd_endereco = e.cd_endereco )
		and not exists (select * from wms_endereco_balanceamento b where b.cd_endereco = e.cd_endereco)
		and not exists (select 1 from wms_localizacao wl where wl.cd_endereco	= e.cd_endereco)
		and e.cd_esteira = :al_Esteira
		and coalesce(b.id_produto_grande, 'N') <> 'S'
		and coalesce(e.id_endereco_pad_picking, 'N') = 'S'
		and e.cd_rua not in ('85' ) //[85 -> Geladeira]          // Colocado NOT EXISTS ABAIXO:  N$$HEX1$$e300$$ENDHEX$$o deve cadastrar na mesma rua.
		and (SELECT dbo.wms_retorna_end_bloqueado(e.cd_endereco)) = 'N'
		and not exists (Select *  From wms_endereco_produto pe
							Inner join wms_endereco e1 on e1.cd_endereco = pe.cd_endereco
							Where pe.cd_produto =:al_produto
							And   e1.cd_rua = e.cd_rua)
		order by (Case e.cd_andar when '1' then '1'
										 when '2' then '2'
										 when '3' then '3'
										 when '0' then '4'
										 when '4' then '5'
										 when '5' then '6'
										when '6' then '7'
										when '7' then '8'
										else '9' end),
						e.cd_rua desc
	     Using SqlCa;				
End If 	
	
	//// Para as Consultas Acima
	Choose Case SqlCa.SqlCode 
	Case 0
			If ab_abast_controlado and al_Esteira  = 3  Then  // Veio do Abastecimento e Controlado  
				If Not IsNull (as_Endereco) Then  as_achou_vago = "S"
			End If 	
	Case 100
		if ib_ignora_sem_endereco_vago then
			//Retorna false para indicar que n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ endere$$HEX1$$e700$$ENDHEX$$o, mas, a seguir no c$$HEX1$$f300$$ENDHEX$$digo o processo $$HEX1$$e900$$ENDHEX$$ continua com sucesso.
			Return False
		else
			If ab_abast_controlado and al_Esteira  = 3  Then  // Veio do Abastecimento e Controlado  
				If IsNull(as_Endereco) Then as_achou_vago = "N"
			Else
				SqlCa.of_Rollback()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum endere$$HEX1$$e700$$ENDHEX$$o vago para ser cadastrado o produto "+String(al_Produto)+" sem endere$$HEX1$$e700$$ENDHEX$$o no flow rack.")
				Return False
			End If 	
		end if
	Case -1
		ls_Erro	= SqlCa.SqlErrText
		SqlCa.of_Rollback()
		MessageBox("Erro", "Erro ao localizar endere$$HEX1$$e700$$ENDHEX$$o vago no flow rack: "+ls_Erro+".")
		Return False
	End Choose	
End If

Return True

end function

public function boolean of_cadastra_produto_flow (ref st_ge481_cadastra_prd_flow ast_produtos[], string as_matricula, ref string as_erro, boolean ab_abast_controlado);
Long	ll_Linha,&
		ll_Linhas,&
		ll_Produto,&
		ll_Qt_Cadastrar,&
		ll_Esteira,&
		ll_Produto_Aux,&
		ll_Nr_Linha,& 
		ll_Cont
		
String	ls_Msg_Email,&
		ls_De_Produto,&
		ls_Grupo,&
		ls_Exclusivo_Pedido_Falta_BA,&
		ls_Geladeira,&
		ls_Exclusivo_Pedido_Falta_Uf,&
		ls_Endereco,&
		ls_Endereco_Flow,&
		ls_Uf,&
		ls_Endereco_Aux,&
		ls_nr_lote,&
		ls_vigiado,&
		ls_controlado,&
		ls_origem_excesso,&
		ls_NomeEsteira,&
		ls_CadastrouEndereco

Decimal	ldc_Media,&
			ldc_Custo
			
s_email lst_Email			


	
ll_Linhas	= UpperBound(ast_Produtos[])
		
If ll_Linhas	> 0 Then
	ls_Msg_Email = 	"Ol$$HEX1$$e100$$ENDHEX$$!<br><br>" +&
							"Segue produtos cadastrados no flow rack:<br><br>~n"+&
							"<table border=2  style='table-layout: fixed; width: 1445px; overflow: hidden;'>~n"+&
							"<tr>~n"+&
							"<th WIDTH=100 align=left><FONT size=2 face=Verdana>C$$HEX1$$f300$$ENDHEX$$digo</font></th>~n"+&
							"<th WIDTH=420 align=left><FONT size=2 face=Verdana>Descri$$HEX2$$e700e300$$ENDHEX$$o</font></th>~n"+&
							"<th WIDTH=120><FONT size=2 face=Verdana>Grupo</font></th>~n"+&
							"<th WIDTH=115><FONT size=2 face=Verdana>Qtde. Receb.</font></th>~n"+&
							"<th><FONT size=2 face=Verdana>Media Transfer$$HEX1$$ea00$$ENDHEX$$ncia</font></th>~n"+&
							"<th><FONT size=2 face=Verdana>Endere$$HEX1$$e700$$ENDHEX$$o</font></th>~n"+&
							"<th><FONT size=2 face=Verdana>Custo</font></th>~n"+&
							"<th><FONT size=2 face=Verdana>UF</font></th>~n"+&
							"</tr>~n"
							
							
	For ll_linha  = 1 To ll_Linhas
		ll_Cont								= 0 
		ll_Produto							= ast_Produtos[ll_Linha].cd_produto
		ls_De_Produto						= ast_Produtos[ll_Linha].de_produto
		ls_Grupo								= ast_Produtos[ll_Linha].de_grupo
		ll_Qt_Cadastrar						= ast_Produtos[ll_Linha].qt_cadastrar
		ldc_Media							= Round(ast_Produtos[ll_Linha].qt_media_transferencia, 2)
		ls_Exclusivo_Pedido_Falta_BA	= ast_Produtos[ll_Linha].id_exclusivo_bahia
		ls_origem_excesso				= ast_Produtos[ll_Linha].id_origem_excesso
		SetNull(ls_CadastrouEndereco) 
		
		// Esteira do Produto
		If Not gf_wms_Esteira_Produto(ll_Produto, Ref ll_Esteira, Ref ls_Geladeira,  Ref ls_Controlado, Ref ls_Vigiado,  Ref ls_NomeEsteira, Ref as_Erro) Then
			Return False
		End If
				
				
		If  Not IsNull(ls_Controlado) and ll_Esteira = 3  Then 
			ls_nr_lote	= ast_Produtos[ll_Linha].nr_lote
		Else
			SetNull(ls_nr_lote)
		End If 
				
		
		//********Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado em algum endere$$HEX1$$e700$$ENDHEX$$o********
		If (Not IsNull(ls_Controlado)  and  ll_Esteira = 3)  Then 
			Select cd_produto
			Into :ll_Produto_Aux
			From wms_endereco_produto
			Where	cd_produto	= :ll_Produto
			And 		nr_lote  =:ls_nr_lote
			Using SqlCa;
				
			Choose Case SqlCa.SqlCode
				Case 0
					Continue
				Case 100
				Case -1
					as_Erro	= "Erro ao verificar se o produto '"+String(ll_Produto)+"' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado em algum endere$$HEX1$$e700$$ENDHEX$$o: "+ SqlCa.SqlErrText
					Return False
			End Choose
		Else
			Select cd_produto
			Into :ll_Produto_Aux
			From wms_endereco_produto
			Where	cd_produto	= :ll_Produto			
			Using SqlCa;
				
			Choose Case SqlCa.SqlCode
				Case 0
					Continue
				Case 100
				Case -1
					as_Erro	= "Erro ao verificar se o produto '"+String(ll_Produto)+"' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado em algum endere$$HEX1$$e700$$ENDHEX$$o: "+ SqlCa.SqlErrText
					Return False
			End Choose
		End If 
		//**************************************************************
		
		If Not of_Custo_Produto(ll_Produto, Ref ldc_Custo, Ref as_Erro) Then
			Return False
		End If
		
		If ls_Exclusivo_Pedido_Falta_BA = "S" Then
			ls_Exclusivo_Pedido_Falta_Uf = "BA"
		Else
			SetNull(ls_Exclusivo_Pedido_Falta_Uf)
		End If
		
		If Not of_Localiza_Endereco_Vago_Flow(ll_Produto, ll_Esteira, ls_Geladeira, Ref ls_Endereco, Ref ls_Endereco_Flow, &
														  Ref as_Erro, ls_origem_excesso, Ref ls_CadastrouEndereco,ab_abast_controlado) Then
			If ib_ignora_sem_endereco_vago Then
				//Caso ignore o fato de n$$HEX1$$e300$$ENDHEX$$o haver endere$$HEX1$$e700$$ENDHEX$$os disponiveis, o sistema ignora e continua o processo.
				Return True
			Else
				Return False
			End If
		End If
				
		//Utilizada na fun$$HEX2$$e700e300$$ENDHEX$$o wf_gera_movimentacao da w_ws060_alterar_lote
		is_End_Cadastrado = ls_Endereco
		
		//*****Select para verificar se tem outro processo utilizando o endere$$HEX1$$e700$$ENDHEX$$o*********
		Select cd_endereco
		Into :ls_Endereco_Aux
		From wms_endereco_produto
		Where	cd_endereco	= :ls_Endereco
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				//Se j$$HEX1$$e100$$ENDHEX$$ tiver sendo utilizado o endere$$HEX1$$e700$$ENDHEX$$o, localiza novamente
				If Not of_Localiza_Endereco_Vago_Flow(ll_Produto, ll_Esteira, ls_Geladeira, Ref ls_Endereco, Ref ls_Endereco_Flow, Ref as_Erro, ls_origem_excesso, Ref ls_CadastrouEndereco, ab_abast_controlado) Then
					Return False
				End If
			Case 100
			Case -1
				as_Erro	= "Erro ao verificar se o endere$$HEX1$$e700$$ENDHEX$$o '"+ls_Endereco+"' no flow rack j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ sendo utilizado: "+ SqlCa.SqlErrText
				Return False
		End Choose
		//**************************************************************
		
		
		//********Verifica novamente se j$$HEX1$$e100$$ENDHEX$$ tem algum produto cadastrado no endere$$HEX1$$e700$$ENDHEX$$o****
		Select cd_produto
		Into :ll_Produto_Aux
		From wms_endereco_produto
		Where	cd_endereco	= :ls_Endereco
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				as_Erro	= "O sistema est$$HEX1$$e100$$ENDHEX$$ tentando cadastrar o produto "+String(ll_Produto)+" no endere$$HEX1$$e700$$ENDHEX$$o "+ls_Endereco+", mas ele j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ sendo utilizado pelo produto "+String(ll_Produto_Aux)+".~r~rExecuta o procedimento novamente para que o produto seja cadastrado automaticamente em outro endere$$HEX1$$e700$$ENDHEX$$o."
				Return False
			Case 100
			Case -1
				as_Erro	= "Erro ao verificar se o endere$$HEX1$$e700$$ENDHEX$$o '"+ls_Endereco+"' no flow rack j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ sendo utilizado: "+ SqlCa.SqlErrText
				Return False
		End Choose
		//**************************************************************
		
		// Processo Apenas para Abastecimento Controlado
		// Novo Campo na Estrutura: Marca como N$$HEX1$$c300$$ENDHEX$$O ENCONTRADO endere$$HEX1$$e700$$ENDHEX$$o Vago no Flow
		// Usado na WS002
		// Este Campo   :  ls_CadastrouEndereco vem da :  of_Localiza_Endereco_Vago_Flow()		

		If ab_abast_controlado Then 
			If Not IsNull(ls_Controlado)  and  ll_Esteira = 3 Then 
				ast_Produtos[ll_Linha].id_cadastrou_endereco =  ls_CadastrouEndereco 
			End If 
			If ls_CadastrouEndereco = "N" Then Continue 	
		End If 	
		
		Insert into wms_endereco_produto(
			cd_produto,
			cd_endereco,
			nr_prioridade,
			cd_esteira,
			nr_matricula_responsavel,
			nr_lote )
		values(
			:ll_Produto,
			:ls_Endereco,
			9,
			:ll_Esteira,
			:as_Matricula,
			:ls_nr_lote )
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro	= "Erro ao cadastrar o produto "+String(ll_Produto)+" em um endere$$HEX1$$e700$$ENDHEX$$o no flow rack: "+ SqlCa.SqlErrText
			Return False
		End If
		
		//********Verifica novamente se j$$HEX1$$e100$$ENDHEX$$ tem algum produto cadastrado no endere$$HEX1$$e700$$ENDHEX$$o****		
		Select cd_produto
		Into :ll_Produto_Aux
		From wms_endereco_produto
		Where	cd_endereco	= :ls_Endereco
		and	cd_produto		<> :ll_Produto			
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
				Case 0
					as_Erro	= "O sistema est$$HEX1$$e100$$ENDHEX$$ tentando cadastrar o produto "+String(ll_Produto)+" no endere$$HEX1$$e700$$ENDHEX$$o "+ls_Endereco+", mas ele j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ sendo utilizado pelo produto "+String(ll_Produto_Aux)+".~r~rExecuta o procedimento novamente para que o produto seja cadastrado automaticamente em outro endere$$HEX1$$e700$$ENDHEX$$o."
					Return False
				Case 100
				Case -1
					as_Erro	= "Erro ao verificar se o endere$$HEX1$$e700$$ENDHEX$$o '"+ls_Endereco+"' no flow rack j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ sendo utilizado: "+ SqlCa.SqlErrText
					Return False
			End Choose		
		//**************************************************************
			
		
		If isnull(ls_Exclusivo_Pedido_Falta_Uf) Then
			ls_Uf = ""
		Else
			ls_Uf  = ls_Exclusivo_Pedido_Falta_Uf
		End If		
		
		
		ls_Msg_Email +=	"<tr>~n"+&
								"<td><FONT size=2 face=Verdana>"+String(ll_Produto)+"</font></td>~n"+&
								"<td><FONT size=2 face=Verdana>"+ls_De_Produto+"</font></td>~n"+&
								"<td><FONT size=2 face=Verdana><center>"+ls_Grupo+"</center></font></td>~n"+&
								"<td><FONT size=2 face=Verdana><center>"+String(ll_Qt_Cadastrar)+"</center></font></td>~n"+&
								"<td><FONT size=2 face=Verdana><center>"+String(ldc_Media)+"</center></font></td>~n"+&
								"<td><FONT size=2 face=Verdana><center>"+ls_Endereco_Flow+"</center></font></td>~n"+&
								"<td><FONT size=2 face=Verdana><center>"+String(ldc_Custo, "###,##0.00")+"</center></font></td>~n"+&
								"<td><FONT size=2 face=Verdana><center>"+ls_Uf+"</center></font></td>~n"+&
								"</tr>~n"
	Next	
	
	ls_Msg_Email += "</table>	~n"

	lst_Email.ps_mensagem	= ls_Msg_Email
	lst_Email.pb_assinatura = True
	
	If ib_Envia_Email Then
		If Not gf_ge202_envia_email_padrao(25, lst_Email, False)	Then
			as_Erro = "Erro ao enviar email dos produtos que foram cadastrados no flow rack."
			Return False
		End If
	End If
	
End If

Return True
end function

on uo_ge481_cadastra_produto_flow.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge481_cadastra_produto_flow.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;SetNull(is_End_Cadastrado)
end event

