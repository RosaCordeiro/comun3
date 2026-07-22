HA$PBExportHeader$uo_ge039_vale_desconto.sru
forward
global type uo_ge039_vale_desconto from nonvisualobject
end type
end forward

global type uo_ge039_vale_desconto from nonvisualobject
end type
global uo_ge039_vale_desconto uo_ge039_vale_desconto

forward prototypes
public function boolean of_pc_desconto (long al_campanha, ref decimal adc_pc_desconto)
public function boolean of_emite_cupom_pos_venda (string as_cliente, string as_matricula)
protected function boolean of_retorna_vale_desconto_matriz (long al_campanha, string as_matricula, string as_cliente, datetime adt_impressao, ref string as_nr_vale, ref string as_cd_uf, ref string as_id_rede, ref string as_cidade_ibge, ref long as_qt_filiais)
public function boolean of_formata_cidades (string as_cidade_ibge, ref string as_cidades)
public function boolean of_reimprimir (string as_cliente)
public function boolean of_localiza_vale_desconto (string as_vale, string as_de_vale, ref long al_campanha)
public function boolean of_formata_utilizacao (string as_cliente, string as_uf, string as_rede, string as_cidade_ibge, long al_qt_filiais, ref string as_utilizacao)
end prototypes

public function boolean of_pc_desconto (long al_campanha, ref decimal adc_pc_desconto);Decimal ldc_Desc

//Busca o primeiro registro da campanha_produto
//Caso a campanha seja para um grupo de produtos o pc_desconto deve ser o mesmo.

Select COALESCE(pc_desconto,0)
	into :ldc_Desc
from campanha_produto
	where nr_campanha = :al_campanha
Limit 1
Using SqlCa;

Choose Case  SqlCa.SqlCode 
	Case -1
		SqlCa.Of_msgDbError("Erro ao localizar o pc_desconto da campanha " + String(al_campanha ))
		adc_pc_desconto = 0
		Return False
	Case 100
		adc_pc_desconto = 0
	Case 0
		adc_pc_desconto = ldc_Desc
End Choose

Return True





end function

public function boolean of_emite_cupom_pos_venda (string as_cliente, string as_matricula);String ls_Impressoras_PDV, ls_Nome_Ipressora_INI
String ls_Nome_Cliente, ls_produto, ls_Nome_Rede_Filial
String ls_Pc_Desconto
String  ls_Validade, ls_dados[]
String ls_Retorno, ls_Nr_Vale
String ls_UF_Campanha, ls_Rede_Campanha, ls_Cidade_Ibge_Campanha
String ls_Ref_Utilizacao, ls_Nome_Cidades

DateTime ldt_termino, ldt_Inicio, ldt_Impressao

Long ll_Linhas, ll_Row, ll_Campanha, ll_Qt_Maxima, ll_Qt_Filais_Campanha

LongLong ll_Vale

Integer i, ll_Retorno, li_Dig_Inicio, li_Digito_Fim

Try 	
	ldt_Impressao = gf_getServerDate()
	
	ls_Nome_Ipressora_INI = PDV.nm_impressora_nfce
	
	dc_uo_ds_base lds_Produtos
	lds_Produtos = Create dc_uo_ds_base
	
	If Not lds_Produtos.of_ChangeDataObject("ds_ge039_cupom_pos_venda") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_ChangeDataObject. ds_ge039_cupom_pos_venda.")
		Return False
	End If
	
	lds_Produtos.of_appendwhere( "c.dh_inicio_impressao_cupom <= dbo.uf_dh_parametro() AND dbo.uf_dh_parametro() <= c.dh_termino_impressao_cupom")
	
	ll_Linhas = lds_Produtos.Retrieve( as_Cliente )
	
	Choose Case ll_Linhas
		Case is < 0 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve, DS ds_ge039_cupom_pos_venda.~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_emite_cupom_pos_venda", StopSign!)
			Return False
		Case 0
			//Nenhuma campanha para o cliente
			Return True
		Case is > 0 
			ll_Campanha = lds_Produtos.Object.nr_campanha[ 1 ]
			
			//Verifica o nr vale desconto no distribuido		
			If Not This.of_Retorna_Vale_Desconto_Matriz( ll_Campanha, as_Matricula, as_Cliente, ldt_Impressao, Ref ls_Nr_Vale, Ref ls_UF_Campanha, Ref ls_Rede_Campanha, Ref ls_Cidade_Ibge_Campanha, Ref ll_Qt_Filais_Campanha) Then
				Return False	
			End If
			
			//Nenhum vale dispon$$HEX1$$ed00$$ENDHEX$$vel para emiss$$HEX1$$e300$$ENDHEX$$o.
			If IsNull( ls_Nr_Vale ) Or Long(ls_Nr_Vale) = 0 Then
				Return True
			End If
			
			If Not This.of_formata_utilizacao( as_Cliente, ls_UF_Campanha, ls_Rede_Campanha, ls_Cidade_Ibge_Campanha, ll_Qt_Filais_Campanha, Ref ls_Ref_Utilizacao) Then
				Return False		
			End If
							
			ll_Vale 			= LongLong(ls_Nr_Vale)
			li_Dig_Inicio 	= Rand(9)
			li_Digito_Fim 	= Rand(9)
			
			ls_Nr_Vale = String(ll_Vale, '0000000000')			
			ls_Nr_Vale = String(li_Dig_Inicio) + ls_Nr_Vale + String(li_Digito_Fim)		
			
			lds_Produtos.Object.nr_vale_desconto	[1] = gf_ean128( ls_Nr_Vale, True )
			lds_Produtos.Object.de_vale_desconto	[1] = ls_Nr_Vale
			lds_Produtos.Object.de_ref_utilizacao 	[1] = ls_Ref_Utilizacao
			
	End Choose
	
	If PDV.Fabricante = 'NFCE' Or PDV.Fabricante = "SAT" Then		
		ls_Impressoras_PDV = PrintGetPrinters( )
		
		If PosA( ls_Impressoras_PDV, ls_Nome_Ipressora_INI ) = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma impressora fiscal ou n$$HEX1$$e300$$ENDHEX$$o fiscal cadastrada neste computador.", StopSign!)
			Return False
		End If
				
		If PrintSetPrinter ( ls_Nome_Ipressora_INI ) < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao selecionar a impressora: " + ls_Nome_Ipressora_INI + ".", StopSign!)
			Return False
		End If
		
		//Imprimi via DataWindow
		lds_Produtos.Print()
	Else
		//Impressora fiscal		
		ls_Nome_Rede_Filial 	= lds_Produtos.Object.nm_rede_filial 			[ 1 ]	
		ldt_Inicio					= DateTime(lds_Produtos.Object.dh_inicio		[ 1 ])
		ldt_Termino				= DateTime(lds_Produtos.Object.dh_termino	[ 1 ])

		If ldt_Inicio = ldt_Termino Then
			ls_Validade = 'V$$HEX1$$e100$$ENDHEX$$lido em ' +	 String(ldt_Inicio, 'dd/mm/yyyy') + '.'
		Else
			ls_Validade = 'V$$HEX1$$e100$$ENDHEX$$lido de ' +	 String(ldt_Inicio, 'dd/mm/yyyy') + ' at$$HEX1$$e900$$ENDHEX$$ ' + String(ldt_Termino, 'dd/mm/yyyy') + '.'
		End If
		
		i++; ls_dados[ i ] = Space(48)
		i++; ls_dados[ i ] = PDV.of_centraliza_texto("CUPOM DE DESCONTO")
		i++; ls_dados[ i ] = Space(48)
		i++; ls_dados[ i ] = "------------------------------------"
		i++; ls_Dados[ i ] = Space(48)
		
		For ll_Row = 1 To ll_Linhas
			ls_produto 			= lds_Produtos.Object.de_produto_ecf			[ ll_Row ] //Cod do produto no inicio da descricao
			ls_Pc_Desconto 	= String(lds_Produtos.Object.pc_desconto		[ ll_Row ], '##0')	
			ll_Qt_Maxima		= lds_Produtos.Object.qt_maxima_venda		[ ll_Row ]
			
			i++; ls_Dados[ i ] 	= Upper(Mid(ls_produto, 1,1) ) + Lower(Mid(ls_produto, 2) )		
			If ll_Qt_Maxima > 0 Then
				i++; ls_Dados[ i ] 	= "* Limitado a " +String(ll_Qt_Maxima) + " Un."		
			End If
			i++; ls_Dados[ i ] 	= Space(48)
			i++; ls_Dados[ i ] 	= Upper("C") + Lower("om  ") + ls_Pc_Desconto + UPPER(" % de desconto")
			i++; ls_Dados[ i ] 	= Space(48)
			i++; ls_dados[ i ] 	= "------------------------------------"					
		Next
				
		i++; ls_Dados[ i ] = "Nr. Cupom Desconto: " + ls_Nr_Vale	
		i++; ls_dados[ i ] = "------------------------------------"					
		
		i++; ls_Dados[ i ] = Space(48)
		i++; ls_Dados[ i ] = "Apresente este cupom para obter o desconto."
		i++; ls_Dados[ i ] = "V$$HEX1$$e100$$ENDHEX$$lido apenas para clientes"
		i++; ls_Dados[ i ] = "  cadastrados no Clube " + ls_Nome_Rede_Filial + "."
		i++; ls_Dados[ i ] = IIF( ldt_Inicio = ldt_Termino , 'V$$HEX1$$e100$$ENDHEX$$lido em ' + String(ldt_Inicio,'dd/mm/yyyy') +'.', 'V$$HEX1$$e100$$ENDHEX$$lido de ' +  String(ldt_Inicio,'dd/mm/yyyy') + ' at$$HEX1$$e900$$ENDHEX$$ ' + String(ldt_Termino, 'dd/mm/yyyy')+'.'  )
		
		i++; ls_Dados[ i ] = ls_Ref_Utilizacao
		i++; ls_Dados[ i ] = Space(48)	
				
		If Not PDV.of_emite_comprovante("", ls_Dados[], 0, True, ls_Nr_Vale ) Then	
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao imprimir o vale desconto.~rFa$$HEX1$$e700$$ENDHEX$$a a reimpress$$HEX1$$e300$$ENDHEX$$o no sistema Retaguarda Loja, menu: Utilit$$HEX1$$e100$$ENDHEX$$rio/ Reimpress$$HEX1$$e300$$ENDHEX$$o Vale Desconto.", Exclamation!)
		End If
		
	End If
		
	Return True
	
Finally
	If IsValid( lds_Produtos ) 	Then Destroy lds_Produtos
End Try


end function

protected function boolean of_retorna_vale_desconto_matriz (long al_campanha, string as_matricula, string as_cliente, datetime adt_impressao, ref string as_nr_vale, ref string as_cd_uf, ref string as_id_rede, ref string as_cidade_ibge, ref long as_qt_filiais);String ls_Retorno

Boolean lb_Sucesso = False

Try
	SetNull(as_Nr_Vale)	
	
	uo_transacao_remota lo_Distribuido
	lo_Distribuido = Create uo_transacao_remota
	lo_Distribuido.of_bancoproducao( )
	lo_Distribuido.of_ConverteVirgula( True )
	lo_Distribuido.of_define_variaveis( True )
				
	lo_Distribuido.of_Executa_Rotina('0147',{ String( gvo_Parametro.cd_Filial ), String (al_Campanha), "'" + as_Matricula + "'", "'"+String(adt_impressao, 'YYYYMMDD HH:MM:SS')+"'", "'" + as_Cliente +"'" } )
	lo_Distribuido.of_retorno_dados(Ref ls_Retorno)
	
	If lo_Distribuido.of_Erro_Execucao() Or lo_Distribuido.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.~r~rO Vale Desconto do cliente n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ emitido.", StopSign!)
		Return False
	Else
		If lo_Distribuido.of_Linhas() > 0 Then
			
			If lo_Distribuido.of_Retorno('nr_vale_desconto', Ref as_Nr_Vale) Then
				If lo_Distribuido.of_Retorno('cd_uf', Ref as_cd_uf) Then
					If lo_Distribuido.of_Retorno('id_rede', Ref as_id_rede) Then
						If lo_Distribuido.of_Retorno('cd_cidade_ibge', Ref as_cidade_ibge) Then
							If lo_Distribuido.of_Retorno('qt_filiais', Ref as_qt_filiais) Then
								lb_Sucesso = True
							End If
						End If
					End If
				End If
			End If
			
			Return lb_Sucesso
		End If
	End If

Finally
	If IsValid(lo_Distribuido) Then Destroy lo_Distribuido	
End Try
end function

public function boolean of_formata_cidades (string as_cidade_ibge, ref string as_cidades);Integer i, li_Linhas

Try
	dc_uo_ds_base lo_Cidades
	lo_Cidades = Create dc_uo_ds_base
	
	If Not lo_Cidades.Of_ChangeDataObject("ds_ge039_cidade") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Of_ChangeDataObject  ds_ge039_cidade~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_formata_cidades")	
		Return False
	End If
	
	If lo_Cidades.Retrieve( as_Cidade_IBGE ) < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve. ds_ge039_cidade")
		Return False
	End If
	
	For i= 1 To lo_Cidades.RowCount()
		as_Cidades += lo_Cidades.Object.nm_cidade[ i ] + ', '		
	Next
	
	as_Cidades = MidA( as_Cidades, 1, LenA(as_Cidades) - 2)
	
	Return True
Finally
	If IsValid(lo_Cidades) Then Destroy lo_Cidades 
End Try
end function

public function boolean of_reimprimir (string as_cliente);
//N$$HEX1$$e300$$ENDHEX$$o concluida
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel.", Exclamation!)
Return False

String ls_Retorno
String ls_Nr_Vale, ls_UF_Campanha, ls_Cidade_Ibge, ls_Rede_Campanha
String ls_Ref_Utilizacao

Long ll_Qt_Filiais

Try
	uo_transacao_remota lo_Distribuido
	lo_Distribuido = Create uo_transacao_remota
	lo_Distribuido.of_bancoproducao( )
	lo_Distribuido.of_ConverteVirgula( True )
	lo_Distribuido.of_define_variaveis( True )
				
	lo_Distribuido.of_Executa_Rotina('0006',{ "select top 1 v.nr_vale, s.cd_unidade_federacao, s.id_rede_filial, s.cd_cidade_ibge, COALESCE((select count(cd_filial) from campanha_filial where nr_campanha = v.nr_campanha),0) as qt_filiais "+&
															"from vale_desconto v inner join campanha c on c.nr_campanha = v.nr_campanha inner join campanha_cliente cc on cc.nr_campanha = c.nr_campanha and cc.cd_cliente = v.cd_cliente_entrega inner join promocao_sos s on s.nr_oferta_sap = c.nr_campanha_sap " + & 
															"Where cc.cd_cliente = '" +as_cliente+ "' +  and c.dh_inicio <= getdate() and c.dh_termino >= getdate() and v.dh_impressao is not null and v.nr_nf_venda is null order by v.dh_impressao desc" } )

	lo_Distribuido.of_retorno_dados(Ref ls_Retorno)
	
	If lo_Distribuido.of_Erro_Execucao() Or lo_Distribuido.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.~r~rO Vale Desconto do cliente n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ reemitido.", StopSign!)
		Return False
	Else
		If lo_Distribuido.of_Linhas() > 0 Then
			If lo_Distribuido.of_Retorno('v.nr_vale', Ref ls_Nr_Vale) Then
				If lo_Distribuido.of_Retorno('s.cd_unidade_federacao', Ref ls_UF_Campanha) Then
					If lo_Distribuido.of_Retorno('s.id_rede_filial', Ref ls_Rede_Campanha) Then
						If lo_Distribuido.of_Retorno('s.cd_cidade_ibge', Ref ls_Cidade_Ibge) Then
							If lo_Distribuido.of_Retorno('qt_filiais', Ref ll_Qt_Filiais) Then
								
								
							End If
						End If
					End If
				End If
			End If
		End If
	End If
	
	If Not This.of_formata_utilizacao( as_Cliente, ls_UF_Campanha, ls_Rede_Campanha, ls_Cidade_Ibge, ll_Qt_Filiais, Ref ls_Ref_Utilizacao) Then
		Return False		
	End If
	
//	If Not This.of_atualiza_vale_desconto_local( ls_Nr_Vale, ldt_Impressao, as_Matricula,  as_cliente) Then
//		Return False
//	End If
			
//	ll_Vale 			= LongLong(ls_Nr_Vale)
//	li_Dig_Inicio 	= Rand(9)
//	li_Digito_Fim 	= Rand(9)
//	
//	ls_Nr_Vale = String(ll_Vale, '0000000000')			
//	ls_Nr_Vale = String(li_Dig_Inicio) + ls_Nr_Vale + String(li_Digito_Fim)		
//	
//	lds_Produtos.Object.nr_vale_desconto	[1] = gf_ean128( ls_Nr_Vale, True )
//	lds_Produtos.Object.de_vale_desconto	[1] = ls_Nr_Vale
//	lds_Produtos.Object.de_ref_utilizacao 	[1] = ls_Ref_Utilizacao
	
	
	
	
	
	
	Return True
Finally
	
End Try
end function

public function boolean of_localiza_vale_desconto (string as_vale, string as_de_vale, ref long al_campanha);Boolean lb_Sucesso = False

Long ll_Nf_Venda

DateTime ldh_Inicio, ldh_Termino, ldh_Parametro

String ls_Retorno

Try
	ldh_Parametro = gvo_Parametro.dh_movimentacao
	
	SetNull(al_campanha)
	
	If LenA( as_vale ) > 10 Then 
		as_vale = String( Long(Mid( as_vale, 2, 10 ) ) ) 
	End If
		
	uo_transacao_remota lo_Distribuido
	lo_Distribuido = Create uo_transacao_remota
	lo_Distribuido.of_bancoproducao( )
	lo_Distribuido.of_ConverteVirgula( True )
	lo_Distribuido.of_define_variaveis( True )
				
	lo_Distribuido.of_Executa_Rotina('0006',{"select COALESCE(v.nr_nf_venda, 0) as nr_nf_venda, Convert(char(10),c.dh_inicio,103) as dh_inicio, Convert(char(10),c.dh_termino,103) as dh_termino, c.nr_campanha as nr_campanha 	from vale_desconto v	inner join campanha c on c.nr_campanha = v.nr_campanha where v.nr_vale = '" + as_Vale + "'"} )
	lo_Distribuido.of_retorno_dados(Ref ls_Retorno)
	
	If lo_Distribuido.of_Erro_Execucao() Or lo_Distribuido.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.~r~rN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel verificar a vig$$HEX1$$ea00$$ENDHEX$$ncia do vale desconto.", StopSign!)
		Return False
	Else
		If lo_Distribuido.of_Linhas() > 0 Then
			If lo_Distribuido.of_Retorno('nr_nf_venda', Ref ll_Nf_Venda) Then
				If lo_Distribuido.of_Retorno('dh_inicio', Ref ldh_Inicio) Then
					If lo_Distribuido.of_Retorno('dh_termino', Ref ldh_Termino) Then
						If lo_Distribuido.of_Retorno('nr_campanha', Ref al_campanha) Then
							lb_Sucesso = True
						End If
					End If
				End If
			End If			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Vale Desconto " + as_de_vale + " n$$HEX1$$e300$$ENDHEX$$o localizado.", Exclamation!)
			Return False	
		End If
	End if
	
	If Not lb_Sucesso Then Return lb_Sucesso
	
	If ll_Nf_Venda > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Vale Desconto j$$HEX1$$e100$$ENDHEX$$ utilizado.", Exclamation!)
		Return False
	End If
	
	If Date(ldh_Parametro) >= Date(ldh_Inicio) And Date(ldh_Parametro) <= Date(ldh_Termino) Then
		Return True
	Else	
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo para a utiliza$$HEX2$$e700e300$$ENDHEX$$o do vale desconto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ vigente.", Exclamation!)
		Return False 
	End If
		
Finally
	If IsValid( lo_Distribuido ) Then Destroy lo_Distribuido
End Try
end function

public function boolean of_formata_utilizacao (string as_cliente, string as_uf, string as_rede, string as_cidade_ibge, long al_qt_filiais, ref string as_utilizacao);String ls_Ref_Utilizacao, ls_Nome_Cidades

/*
Ordem|	UF|		REDE|	CIDADE|	Observa$$HEX2$$e700e300$$ENDHEX$$o
1$$HEX1$$ba00$$ENDHEX$$			    |		    PP|			  |	lojas especificas
2$$HEX1$$ba00$$ENDHEX$$			    |		    PP|   2910800|	cidade especifica
3$$HEX1$$ba00$$ENDHEX$$			BA|		    PP|			  |	todas as lojas da uf e rede
*/

as_utilizacao = ""

If Trim(as_cidade_ibge)	= '' Then SetNull(as_cidade_ibge)
If Trim(as_uf) 			   	= '' Then SetNull(as_uf)
If Trim(as_rede) 		   	= '' Then SetNull(as_rede)

If IsNull(as_rede) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Par$$HEX1$$e200$$ENDHEX$$metros da campanha de Cupom Desconto para o cliente: " + as_cliente + " n$$HEX1$$e300$$ENDHEX$$o foram localizados.", Exclamation!)
	Return False
End If

IF IsNull(as_cidade_ibge) AND IsNull(as_uf) Then //1$$HEX1$$ba00$$ENDHEX$$ por Loja especifica. Se houver mais lojas vinvuladas mostrar apenas o end da filial de impressao
	 //Especifico da loja de impressao
	 ls_Ref_Utilizacao = 'V$$HEX1$$e100$$ENDHEX$$lido no endere$$HEX1$$e700$$ENDHEX$$o impresso neste cupom.'
	 
ElseIF  IsNull(as_uf) AND Not IsNull(as_cidade_ibge) Then //2$$HEX1$$ba00$$ENDHEX$$ por Cidade
	
	If Not This.of_formata_cidades( as_cidade_ibge, Ref ls_Nome_Cidades) Then
		Return False
	End If
	
	//Se Encontrar ',' existe mais cidades com o mesmo c$$HEX1$$f300$$ENDHEX$$d IBGE
	ls_Ref_Utilizacao = IIF(PosA(ls_Nome_Cidades, ',') > 0, 'V$$HEX1$$e100$$ENDHEX$$lido nas cidades ', 'V$$HEX1$$e100$$ENDHEX$$lido na cidade ')	 + ls_Nome_Cidades
					
	ls_Ref_Utilizacao += ' em lojas da Rede ' + gvo_Parametro.id_rede_filial + ' no Estado ' + gvo_Parametro.ivs_uf_filial
	
ElseIF Not IsNull(as_uf) AND IsNull(as_cidade_ibge) Then //3$$HEX1$$ba00$$ENDHEX$$ por UF
	ls_Ref_Utilizacao = 'V$$HEX1$$e100$$ENDHEX$$lido em lojas da Rede ' + gvo_Parametro.id_rede_filial + ' no Estado ' +gvo_Parametro.ivs_uf_filial +"."
Else
	//Campanha n$$HEX1$$e300$$ENDHEX$$o prevista
	//Verificar cadastro da campanha/promocao_sos
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Par$$HEX1$$e200$$ENDHEX$$metros da campanha de Cupom Desconto para o cliente: " + as_cliente + " n$$HEX1$$e300$$ENDHEX$$o foram localizados.", Exclamation!)
	Return False
End If

as_utilizacao = ls_Ref_Utilizacao

Return True


//This.of_Formata_Utilizacao()
			
			/*
			Ordem|	UF|		REDE|	CIDADE|	Observa$$HEX2$$e700e300$$ENDHEX$$o
			1$$HEX1$$ba00$$ENDHEX$$			    |		    PP|			  |	lojas especificas
			2$$HEX1$$ba00$$ENDHEX$$			    |		    PP|   2910800|	cidade especifica
			3$$HEX1$$ba00$$ENDHEX$$			BA|		    PP|			  |	todas as lojas da uf e rede
			
			
			If Trim(ls_Cidade_Ibge_Campanha)	= '' Then SetNull(ls_Cidade_Ibge_Campanha)
			If Trim(ls_UF_Campanha) 			   	= '' Then SetNull(ls_UF_Campanha)
			If Trim(ls_Rede_Campanha) 		   	= '' Then SetNull(ls_Rede_Campanha)
			
			If IsNull(ls_Rede_Campanha) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Par$$HEX1$$e200$$ENDHEX$$metros da campanha de Cupom Desconto para o cliente: " + as_cliente + " n$$HEX1$$e300$$ENDHEX$$o foram localizados", Exclamation!)
				Return False
			End If
			
			IF IsNull(ls_Cidade_Ibge_Campanha) AND IsNull(ls_UF_Campanha) Then //1$$HEX1$$ba00$$ENDHEX$$ por Loja especifica. Se houver mais lojas vinvuladas mostrar apenas o end da filial de impressao
				 //Especifico da loja de impressao
				 ls_Ref_Utilizacao = 'V$$HEX1$$e100$$ENDHEX$$lido no endere$$HEX1$$e700$$ENDHEX$$o impresso neste cupom.'
				 
			ElseIF  IsNull(ls_UF_Campanha) AND Not IsNull(ls_Cidade_Ibge_Campanha) Then //2$$HEX1$$ba00$$ENDHEX$$ por Cidade
				
				If Not This.of_formata_cidades( ls_Cidade_Ibge_Campanha, Ref ls_Nome_Cidades) Then
					Return False
				End If
				
				//Se Encontrar ',' existe mais cidades com o mesmo c$$HEX1$$f300$$ENDHEX$$d IBGE
				ls_Ref_Utilizacao = IIF(PosA(ls_Nome_Cidades, ',') > 0, 'V$$HEX1$$e100$$ENDHEX$$lido nas cidades ', 'V$$HEX1$$e100$$ENDHEX$$lido na cidade ')	 + ls_Nome_Cidades
								
				ls_Ref_Utilizacao += ' em lojas da Rede ' + ls_Rede_Campanha + ' no Estado ' + gvo_Parametro.ivs_uf_filial
				
			ElseIF Not IsNull(ls_UF_Campanha) AND IsNull(ls_Cidade_Ibge_Campanha) Then //3$$HEX1$$ba00$$ENDHEX$$ por UF
				ls_Ref_Utilizacao = 'V$$HEX1$$e100$$ENDHEX$$lido em lojas da Rede ' + ls_Rede_Campanha + ' no Estado ' +ls_UF_Campanha +"."
			Else
				//Campanha n$$HEX1$$e300$$ENDHEX$$o prevista
				//Verificar cadastro da campanha/promocao_sos
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Par$$HEX1$$e200$$ENDHEX$$metros da campanha de Cupom Desconto para o cliente: " + as_cliente + " n$$HEX1$$e300$$ENDHEX$$o foram localizados", Exclamation!)
				Return False
			End If
			*/		
end function

on uo_ge039_vale_desconto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge039_vale_desconto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

