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
Long  il_Tabela = 41

DateTime idt_Inicio
DateTime idt_Termino

Decimal idc_pc_comissao

String is_Tipo_Comissao


		
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_valida_dados (string as_log)
public function boolean of_insere_comissao (ref string as_log, long al_controle)
public function boolean of_atualiza_comissao_produto (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_atualiza_comissao (long al_controle, long al_tabela)
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

public function boolean of_valida_dados (string as_log);

Return False
end function

public function boolean of_insere_comissao (ref string as_log, long al_controle);DateTime ldh_Termino
Date ldh_Termino_Alterada
Decimal ldc_Comissao
Long ll_Tipo_Comissao_CLAM
Long ll_Controle
Long ll_QtdDelete
String lvs_Chave, lvs_Nulo

SetNull(lvs_Nulo) 
ll_QtdDelete = 0  


Choose Case is_Tipo_Comissao
	Case 'ZC01'; ll_Tipo_Comissao_CLAM = 1
	Case 'ZC02'; ll_Tipo_Comissao_CLAM = 2
	Case 'ZC03'; ll_Tipo_Comissao_CLAM = 3		
	Case Else
		as_Log = "Tipo de comiss$$HEX1$$e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida, diferente da esperada  [ZC01/ZC02/ZC03]."
		Return False
End Choose

il_Tipo_Comissao = ll_Tipo_Comissao_CLAM

If idc_pc_comissao > 10 Then
	as_Log = "O percentual de comissao n$$HEX1$$e300$$ENDHEX$$o pode ser superior a 10%."
	Return False
End If

lvs_Chave = String(il_Produto) + '@#!' + String(ll_Tipo_Comissao_CLAM)+'@#!' +String(is_Tipo_Comissao) 		

Delete From tipo_comissao_produto_sap
 Where cd_produto = :il_Produto
	and cd_tipo_comissao = :ll_Tipo_Comissao_CLAM
	and (dh_inicio between :idt_Inicio and :idt_Termino
	 or dh_termino between :idt_Inicio and :idt_Termino
	 or :idt_Inicio between dh_inicio and dh_termino
	 or :idt_Termino between dh_inicio and dh_termino)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		as_Log	= "Erro ao localizar registro na tabela 'tipo_comissao_produto_sap - 1'. Erro: "+ SqlCa.SqlErrText
		Return False
End Choose




If idc_pc_comissao > 0   Then 
	INSERT INTO tipo_comissao_produto_sap  
		(cd_produto,   
	   cd_tipo_comissao,   
	   dh_inicio,   
	   dh_termino,   
	   pc_comissao,
	   dh_inclusao,
	   dh_alteracao,
		nr_controle_interf_inclusao)  
	VALUES 
		(:il_Produto,   
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
	
	If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO_SAP', lvs_Chave, 'PC_COMISSAO', lvs_Nulo , String(idc_pc_comissao) , 'SAP001', 'I', Ref as_log, False) Then Return False
End If 	
	
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

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Produto - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_comissao_produto  lo_comissao_produto
			 
			Try
				lo_comissao_produto	= Create uo_ge473_comissao_produto
				lo_comissao_produto.of_atualiza_comissao(lds.Object.nr_controle[ll_Linha],   il_Tabela)
			Finally
				Destroy(uo_ge473_comissao_produto)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface FornecedorConexao - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_atualiza_comissao (long al_controle, long al_tabela);Boolean lb_Sucesso = True

Long ll_Atualizacao_Pend
Long ll_Linhas
Long ll_Linha
Long ll_Pos

String ls_Log
String ls_Tipo_Chave
String ls_PRD_Chave

Try
		
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
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_reset()
				w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
			end if
			
			
			For ll_Linha = 1 To ll_Linhas
				
				If Not This.of_inicializa_variaveis(Ref ls_Log) Then 
					lb_Sucesso = False
					Return False
				End If
				
				// Produto
				If Not lo_Comum.of_Localiza_Codigo_Produto_Legado(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha], Ref il_Produto, Ref ls_Log) Then 
					lb_Sucesso = False
					Return False
				End If
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.wf_settext('Produto: ' + String(il_Produto), 3 )
				end if
				
				//dh_inicio
				If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio[ll_Linha], 'DH_INICIO', ref  idt_Inicio, ref ls_Log) Then 
					lb_Sucesso = False
					Return False				
				End If
				
				//dh_termino
				If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino[ll_Linha], 'DH_TERMINO', ref  idt_Termino, ref ls_Log) Then 	
					lb_Sucesso = False
					Return False				
				End If
			
				//pc_comissao
				If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_comissao[ll_Linha], 'PC_COMISSAO', ref idc_pc_comissao, ref ls_Log) Then 
					lb_Sucesso = False
					Return False
				End If
				
				//id_tipo_comissao
				is_Tipo_Comissao = lo_Comum.ids_lista_registros.Object.id_tipo_comissao[ll_Linha]
				
				If Not This.of_insere_comissao(ref ls_Log, al_controle) Then
					lb_Sucesso = False
					Return False
				End If
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
				end if
				
			Next
			
			lb_Sucesso = This.of_atualiza_comissao_produto(Ref ls_Log)
			
		Else
			ls_Log  = "N$$HEX1$$e300$$ENDHEX$$o foram localizados itens na tabela [INTERFACE_SAP_ITEM]."
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
		lo_Comum.of_grava_erro(al_controle, 190, ls_Log)
	End If
	
	Destroy lo_Comum	
	
End Try
	

Return True
end function

on uo_ge473_comissao_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_comissao_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

