HA$PBExportHeader$uo_ge473_comissao_produto.sru
forward
global type uo_ge473_comissao_produto from nonvisualobject
end type
end forward

global type uo_ge473_comissao_produto from nonvisualobject
end type
global uo_ge473_comissao_produto uo_ge473_comissao_produto

type variables
Long il_Produto
Long il_Tipo_Comissao

DateTime idt_Inicio
DateTime idt_Termino

Decimal idc_pc_comissao

String is_Tipo_Comissao


		
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_atualiza_comissao (long al_controle, string as_chave)
public function boolean of_valida_dados (string as_log)
public function boolean of_insere_comissao (ref string as_log, long al_controle)
public function boolean of_atualiza_comissao_produto (ref string as_log)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
			 
		setnull(il_Produto)
		setnull(il_Tipo_Comissao)
		setnull(idt_Inicio)
		setnull(idt_Termino)
		setnull(idc_pc_comissao)
		setnull(is_Tipo_Comissao)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as variaveis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_atualiza_comissao (long al_controle, string as_chave);Boolean lb_Sucesso = False

Long ll_Atualizacao_Pend
Long ll_Linhas
Long ll_Linha
Long ll_Pos

String ls_Log
String ls_Tipo_Chave
String ls_PRD_Chave

Try
	
	Open(w_aguarde)
	w_aguarde.Title = "Processando Comiss$$HEX1$$e300$$ENDHEX$$o Produto.."
		
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		If ll_Linhas > 0  Then
			
			ll_Pos = Pos(as_chave, "@#!") 
			
			If ll_Pos > 0 Then
				ls_PRD_Chave = Mid(as_chave, 1, ll_Pos -1 )
				ls_Tipo_Chave = Mid(as_chave, ll_Pos + 3)
			Else
				ls_Log  = "N$$HEX1$$e300$$ENDHEX$$o localizado o separadora [@#!] na chave recebida do SAP."
				Return False
			End If
			
			If Not IsNumber(ls_PRD_Chave) Then
				ls_Log  = "Chave (material/produto) informado na INTERFACE_SAP do pai est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
				Return False
			End If
			
			For ll_Linha = 1 To ll_Linhas
				
				If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
				
				// Produto
				If Not lo_Comum.of_Localiza_Codigo_Produto_Legado(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha], Ref il_Produto, Ref ls_Log) Then Return False
				
				//dh_inicio
				If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio[ll_Linha], 'DH_INICIO', ref  idt_Inicio, ref ls_Log) Then Return False				
				
				//dh_termino
				If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino[ll_Linha], 'DH_TERMINO', ref  idt_Termino, ref ls_Log) Then 	Return False				
			
				//pc_comissao
				If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_comissao[ll_Linha], 'PC_COMISSAO', ref idc_pc_comissao, ref ls_Log) Then Return False
				
				//id_tipo_comissao
				is_Tipo_Comissao = lo_Comum.ids_lista_registros.Object.id_tipo_comissao[ll_Linha]
				
				If ls_Tipo_Chave <> is_Tipo_Comissao Then
					ls_Log  = "O tipo da comiss$$HEX1$$e300$$ENDHEX$$o informado na chave esta diferente do CD_PRODUTO_SAP da INTERFACE_SAP_ITEM."
					Return False
				End If
													
				If Long(ls_PRD_Chave) <> Long(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha]) Then
					ls_Log  = "O material/produto informado na chave esta diferente do CD_PRODUTO_SAP da INTERFACE_SAP_ITEM."
					Return False
				End If
								
				If This.of_insere_comissao(ref ls_Log, al_controle) Then
					lb_Sucesso	= True
				End If
				
			Next
			
			lb_Sucesso = This.of_atualiza_comissao_produto(Ref ls_Log)
			
		Else
			ls_Log  = "Foram localizados itens na tabela [INTERFACE_SAP_ITEM]."
			Return False
		End If
		
	End If

Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_comissao_produto], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_comissao]. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally
		
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum	
	
	If IsValid(w_aguarde) Then Close( w_aguarde )
End Try
	

Return True
end function

public function boolean of_valida_dados (string as_log);

Return False
end function

public function boolean of_insere_comissao (ref string as_log, long al_controle);DateTime ldh_Termino

Decimal ldc_Comissao

Long ll_Tipo_Comissao_CLAM

Choose Case is_Tipo_Comissao
	Case 'ZC01'; ll_Tipo_Comissao_CLAM = 1
	Case 'ZC02'; ll_Tipo_Comissao_CLAM = 2
	Case Else
		as_Log = "Tipo de comiss$$HEX1$$e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida, diferente da esperada  [ZC01/ZC02]."
		Return False
End Choose

il_Tipo_Comissao = ll_Tipo_Comissao_CLAM

If idc_pc_comissao > 5 Then
	as_Log = "O percentual de desconto n$$HEX1$$e300$$ENDHEX$$o pode ser superior a 5%."
	Return False
End If
		
Select pc_comissao, dh_termino
Into :ldc_Comissao, :ldh_Termino
From tipo_comissao_produto_sap
Where cd_produto  			= :il_Produto
	and cd_tipo_comissao 	= :ll_Tipo_Comissao_CLAM
	and dh_inicio				= :idt_Inicio 
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	
		If (ldc_Comissao <> idc_pc_comissao) or (ldh_Termino <> idt_Termino) Then
						
			  UPDATE tipo_comissao_produto_sap  
			  SET pc_comissao = :idc_pc_comissao, dh_termino 	= :idt_Termino, dh_alteracao = getdate(), nr_controle_interf_alteracao = :al_controle
			  Where cd_produto  			= :il_Produto
				 and cd_tipo_comissao 	= :ll_Tipo_Comissao_CLAM
				 and dh_inicio				= :idt_Inicio 
			  Using SqlCa;
			  
			  If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao atualizar o registro na tabela 'tipo_comissao_produto_sap'. Erro: "+ SqlCa.SqlErrText
				Return False	
			  End If
				
		End If
		
	Case 100
		
		  INSERT INTO tipo_comissao_produto_sap  ( cd_produto,   
																  cd_tipo_comissao,   
																  dh_inicio,   
																  dh_termino,   
																  pc_comissao,
																  dh_inclusao,
																  dh_alteracao,
																  nr_controle_interf_inclusao)  
		  VALUES (:il_Produto,   
					  :ll_Tipo_Comissao_CLAM,   
					  :idt_Inicio,   
					  :idt_Termino,   
					  :idc_pc_comissao,
					  getdate(),
					  getdate(),
					  :al_controle)
		Using SqlCa;
					  
		 If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao inserir registro na tabela 'tipo_comissao_produto_sap'. Erro: "+ SqlCa.SqlErrText
			Return False
		 End If
			
	Case -1
		as_Log	= "Erro ao localizar registro na tabela 'tipo_comissao_produto_sap'. Erro: "+ SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_atualiza_comissao_produto (ref string as_log);Boolean lb_Retorno

Date ldh_Movimento

ldh_Movimento = Date(gf_GetServerDate())

uo_ge486_comissao_produto lo
lo = Create uo_ge486_comissao_produto

lb_Retorno = lo.of_atualiza_comissao(il_Produto, il_Tipo_Comissao,ldh_Movimento, ref as_log )

Destroy lo

Return lb_Retorno

end function

on uo_ge473_comissao_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_comissao_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

