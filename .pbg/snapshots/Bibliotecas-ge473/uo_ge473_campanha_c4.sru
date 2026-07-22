HA$PBExportHeader$uo_ge473_campanha_c4.sru
forward
global type uo_ge473_campanha_c4 from nonvisualobject
end type
end forward

global type uo_ge473_campanha_c4 from nonvisualobject
end type
global uo_ge473_campanha_c4 uo_ge473_campanha_c4

type variables
uo_ge473_comum io_Comum

Boolean ib_continue = False
String is_chave_sap
long il_tabela = 80

string is_cd_tipo_campanha
string is_de_campanha
String is_nr_campanha
Long il_nr_campanha_legado
datetime idt_inicio_imp, idt_fim_imp



end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_atualiza_campanha (long al_controle, long al_tabela)
public function boolean of_insere_campanha_sap_cliente (long al_controle_pai, ref string as_log)
public function boolean of_insere_campanha_sap (ref string as_log)
public function boolean of_insere_campanha_sap_cupom (long al_controle_pai, ref string as_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);
Try	
	
	if isnull(is_cd_tipo_campanha) or is_cd_tipo_campanha = '' Then
		as_log = 'O tipo da Campanha n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
		return false
	end if
	
	if isnull(is_de_campanha) or is_de_campanha = '' Then
		as_log = 'A descri$$HEX2$$e700e300$$ENDHEX$$o da Campanha n$$HEX1$$e300$$ENDHEX$$o pode ser nula.'
		return false
	end if
	
	if isnull(is_nr_campanha) or is_nr_campanha = '' Then
		as_log = 'O n$$HEX1$$fa00$$ENDHEX$$mero da Campanha n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
		return false
	end if
	
	Choose Case is_cd_tipo_campanha
		CAse '107'
			is_cd_tipo_campanha = 'EX'
		Case '115'
			is_cd_tipo_campanha = 'PI'
		Case '116'
			is_cd_tipo_campanha = 'CP'
		Case '117'
			is_cd_tipo_campanha = 'CD'
		Case '118'
			is_cd_tipo_campanha = 'AP'
		Case '119'
			is_cd_tipo_campanha = 'CP'	
		Case 'POS'
			is_cd_tipo_campanha = 'CD'
		Case Else
			is_cd_tipo_campanha = 'AP'
			
	End Choose

//"107" o id_tipo_campanha ser$$HEX1$$e100$$ENDHEX$$ igual "EX" - Ex-Clientes
//"115" o id_tipo_campanha ser$$HEX1$$e100$$ENDHEX$$ igual "PI" - Produtos de Interesse
//"116" o id_tipo_campanha ser$$HEX1$$e100$$ENDHEX$$ igual "CP" - Cupom Pr$$HEX1$$e900$$ENDHEX$$
//"117" o id_tipo_campanha ser$$HEX1$$e100$$ENDHEX$$ igual "CD" - Cupom Desconto
//"118" o id_tipo_campanha ser$$HEX1$$e100$$ENDHEX$$ igual "AP" - A$$HEX2$$e700e300$$ENDHEX$$o Produto
//as demais que vc porventura receba ser$$HEX1$$e100$$ENDHEX$$ = "AP"
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try

	Setnull(is_cd_tipo_campanha)
	Setnull(is_de_campanha)
	Setnull(is_nr_campanha)
	
Catch ( runtimeerror lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Campanha C4 - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_campanha_c4.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_campanha_c4 lo_campanha
			 
			Try
				lo_campanha	= Create uo_ge473_campanha_c4
				lo_campanha.of_atualiza_campanha( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_campanha)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Campanha C4 - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_campanha_c4.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log);
select de_chave_sap
into :as_chave_sap
from interface_sap
where nr_controle = :al_controle
Using SQLCA;

if sqlca.sqlcode = -1 then 
	as_log = 'Erro ao consultar a tabela "interface_sap": ' + sqlca.sqlerrtext
	return false
end if

as_chave_sap =  gf_Tira_Zero_Esquerda(as_chave_sap)

return True
end function

public function boolean of_atualiza_campanha (long al_controle, long al_tabela);
Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente
		
String	ls_Log
Boolean	lb_Sucesso = True		

Try
	
	if Not io_Comum.of_atualizacao_pendente( al_controle, ref ll_registro_pendente, ref ls_log) Then 
		lb_sucesso = false
		return false
	end if
		
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_registro_pendente = 0 Then Return True
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	if Not this.of_carrega_chave( al_controle, ref is_chave_sap, ref ls_log ) Then Return False
	 
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If lo_Comum.of_processa_carrega_dados(al_controle, ref ls_Log) Then
		
		ll_linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		For ll_Linha = 1 To ll_linhas
			
			this.of_inicializa_variaveis( ref ls_log )
		
			is_cd_tipo_campanha = lo_Comum.ids_lista_registros.object.cd_tipo_campanha[ll_linha]
			is_de_campanha = lo_Comum.ids_lista_registros.object.de_campanha[ll_linha]
			is_nr_campanha = lo_Comum.ids_lista_registros.object.nr_campanha[ll_linha]
			
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio_impressao_cupom[ll_Linha], 'DATA INICIO IMPRESSAO CUPOM', ref idt_inicio_imp, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if
			
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino_impressao_cupom[ll_Linha], 'DATA TERMINO IMPRESSAO CUPOM', ref idt_fim_imp, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if
			
			if isvalid(w_aguarde_3) Then
//				w_aguarde_3.wf_settext('Remanejamento: ' + is_cd_remanejamento, 3 )
			end if
			
			If Not This.of_Valida_Dados(Ref ls_Log) Then
				lb_sucesso = false
				return false
			end if
			
			Select min(nr_campanha) 
			into :il_nr_campanha_legado
			from campanha
			where nr_campanha_sap = :is_nr_campanha;
			
			if sqlca.sqlcode = -1 then
				lb_sucesso = false
				ls_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_campanha ~nErro ao consultar a tabela CAMPANHA: ~n' + sqlca.sqlerrtext
				return false
			end if
			
			If Not This.of_insere_campanha_sap( ref ls_log ) Then
				lb_Sucesso	= False
				return false
			end if
			
			If Not This.of_insere_campanha_sap_cliente(al_controle, ref ls_log ) Then
				lb_Sucesso	= False
				return false
			end if
				
			If Not This.of_insere_campanha_sap_cupom(al_controle, ref ls_log ) Then
				lb_Sucesso	= False
				return false
			end if 

			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
			end if
			
		Next
		
	Else
		lb_sucesso = false
		Return False
	End If	
	
	Destroy(lo_comum)	
			
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 202, ls_Log)
	End If
		
	Destroy(lo_comum)
	
End Try

Return lb_Sucesso
end function

public function boolean of_insere_campanha_sap_cliente (long al_controle_pai, ref string as_log);Long ll_linhas
Long ll_linha, ll_existe
Long ll_controle_filho, ll_cd_produto
string ls_id_excluido, ls_id_incluido, ls_nr_cpf, ls_cd_cliente
String ls_chave_sap_filial

Try

	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_filial
	FROM interface_sap  i 
	Where i.cd_tabela = 81
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If

	If ll_Controle_filho = 0 Or IsNull(ll_Controle_filho) Then
		return true
	End If		
		
	ls_chave_sap_filial = gf_Tira_Zero_Esquerda(ls_chave_sap_filial)	
		
	if ls_chave_sap_filial <> is_chave_sap Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de Campanha [' + ls_chave_sap_filial + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de Campanha cliente [' + is_chave_sap + '].'
		return false
	end if
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then	
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ls_id_excluido = lo_Comum.ids_lista_registros.Object.id_excluido[ll_Linha]
			ls_id_incluido =  lo_Comum.ids_lista_registros.Object.id_incluido[ll_Linha]
			ls_nr_cpf = lo_Comum.ids_lista_registros.Object.nr_cpf[ll_Linha]
	
			if ( isnull(ls_id_excluido) or ls_id_excluido = '' ) and ( ls_id_incluido = '' or isnull(ls_id_incluido) )  then
				as_log = 'O tipo de opera$$HEX2$$e700e300$$ENDHEX$$o referente ao cliente deve ser informado (inclus$$HEX1$$e300$$ENDHEX$$o/exclus$$HEX1$$e300$$ENDHEX$$o).'
				return false
			end if
			
			if ( ls_id_excluido = 'X' ) and ( ls_id_incluido = 'X' )  then
				as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar tipo de opera$$HEX2$$e700e300$$ENDHEX$$o referente ao cliente (inclus$$HEX1$$e300$$ENDHEX$$o/exclus$$HEX1$$e300$$ENDHEX$$o).'
				return false
			end if
			
			if ls_nr_cpf = '' or isnull(ls_nr_cpf)  then
				as_log = 'O CPF do cliente n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
				return false
			end if
			
			Select cd_cliente
			into :ls_cd_cliente
			from cliente
			where nr_cpf_cgc = :ls_nr_cpf;
			
			if sqlca.sqlcode = -1 then
				as_log = 'Objeto: '  + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha_sap_cliente ~nErro ao consultar registro na tabela CLIENTE :~n' + sqlca.sqlerrtext
				return false
			end if
			
			if ls_cd_cliente = '' or isnull(ls_cd_cliente) Then
				//as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar cliente com o seguinte CPF: ' + ls_nr_cpf
				//return false
				Continue
			end if
			
			//Campanha_cliente
			if il_nr_campanha_legado > 0 Then
				
				if ls_id_excluido = 'X' Then
					
					delete from campanha_cliente
					where nr_campanha = :il_nr_campanha_legado
						and cd_cliente = :ls_cd_cliente;
						
					if sqlca.sqlcode = -1 then
						as_log = 'Objeto: '  + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha_sap_cliente ~nErro ao excluir registro na tabela CAMPANHA_CLIENTE :~n' + sqlca.sqlerrtext
						return false
					end if
					
				elseif ls_id_incluido = 'X' Then
					
					select count(*)
					into :ll_existe
					from campanha_cliente
					where cd_cliente = :ls_cd_cliente
					and nr_campanha = :il_nr_campanha_legado;
					
					if sqlca.sqlcode = -1 then
						as_log = 'Objeto: '  + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha_sap_cliente ~nErro ao consultar registro na tabela CAMPANHA_CLIENTE :~n' + sqlca.sqlerrtext
						return false
					end if
					
					if ll_existe = 0 or isnull(ll_existe) Then
					
						insert into campanha_cliente(cd_cliente, nr_campanha)
							values(:ls_cd_cliente, :il_nr_campanha_legado);
						
						if sqlca.sqlcode = -1 then
							as_log = 'Objeto: '  + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha_sap_cliente ~nErro ao inserir registro na tabela CAMPANHA_CLIENTE :~n' + sqlca.sqlerrtext
							return false
						end if
					end if
					
				end if
				
			end if
			
		Next
		
	Else
		Return False
	End If	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_campanha_sap_cliente'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_insere_campanha_sap (ref string as_log);Long ll_existe
string ls_id_avisa_cliente

Try
	
	if is_cd_tipo_campanha = 'CP' or is_cd_tipo_campanha = 'CD' Then
		ls_id_avisa_cliente = 'N'
	else
		ls_id_avisa_cliente = 'S'
	end if
	
	if il_nr_campanha_legado = 0 or isnull(il_nr_campanha_legado) Then
		
		Select max(nr_campanha)
		into :il_nr_campanha_legado
		from campanha;
		
		If sqlca.sqlcode = -1 then
			as_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha ~nErro ao consultar a tabela "campanha": ~n' + sqlca.sqlerrtext
			return false
		end if
		
		if il_nr_campanha_legado = 0 or isnull(il_nr_campanha_legado) Then
			il_nr_campanha_legado = 1
		else
			il_nr_campanha_legado++
		end if
	
		insert into campanha( nr_campanha, 
									nm_campanha, 
									dh_inicio, 
									dh_termino, 
									id_tipo_campanha,
									nr_campanha_sap,
									id_envia_loja,
									id_avisa_cliente,
									id_envia_bi,
									dh_inicio_impressao_cupom,
									dh_termino_impressao_cupom)
			Values (:il_nr_campanha_legado,
						:is_de_campanha,
						getdate(),
						getdate(),
						:is_cd_tipo_campanha,
						:is_nr_campanha,
						'S',
						:ls_id_avisa_cliente,
						'S',
						:idt_inicio_imp,
						:idt_fim_imp);
						
		If sqlca.sqlcode = -1 then
			as_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha_sap ~nErro ao inserir registro na tabela "campanha": ~n' + sqlca.sqlerrtext
			return false
		end if		
	
	Else
	
		Update campanha
		set nm_campanha = :is_de_campanha, id_tipo_campanha = :is_cd_tipo_campanha,
			dh_inicio_impressao_cupom = :idt_inicio_imp,
			dh_termino_impressao_cupom = :idt_fim_imp,
			id_avisa_cliente = :ls_id_avisa_cliente
		where nr_campanha = :il_nr_campanha_legado;
	
		If sqlca.sqlcode = -1 then
			as_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha_sap ~nErro ao atualizar registro na tabela "campanha": ~n' + sqlca.sqlerrtext
			return false
		end if		
	
	end if

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_campanha_sap'. Erro: "+lo_rte.GetMessage( )
	Return False	
End Try	

Return True
end function

public function boolean of_insere_campanha_sap_cupom (long al_controle_pai, ref string as_log);Long ll_linhas
Long ll_linha, ll_existe
Long ll_controle_filho
string ls_nr_cupom
String ls_chave_sap_filial

Try

	if il_nr_campanha_legado = 0 or isnull(il_nr_campanha_legado) Then return true

	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_filial
	FROM interface_sap  i 
	Where i.cd_tabela = 85
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If

	If ll_Controle_filho = 0 Or IsNull(ll_Controle_filho) Then
		return true
	End If		
		
	ls_chave_sap_filial = gf_Tira_Zero_Esquerda(ls_chave_sap_filial)	
		
	if ls_chave_sap_filial <> is_chave_sap Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de Campanha [' + ls_chave_sap_filial + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de Campanha cupom [' + is_chave_sap + '].'
		return false
	end if
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then	
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ls_nr_cupom = lo_Comum.ids_lista_registros.Object.nr_cupom[ll_Linha]
			
			Select count(*)
			into :ll_existe
			from vale_desconto
			where nr_vale = :ls_nr_cupom;
			
			if sqlca.sqlcode = -1 then
				as_log = 'Objeto: '  + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha_sap_cupom ~nErro ao consultar registro na tabela VALE_DESCONTO :~n' + sqlca.sqlerrtext
				return false
			end if
			
			if ll_existe > 0 Then continue
			
			insert into vale_desconto(nr_vale, nr_campanha)
				values(:ls_nr_cupom, :il_nr_campanha_legado);
			
			if sqlca.sqlcode = -1 then
				as_log = 'Objeto: '  + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha_sap_cupom ~nErro ao inserir registro na tabela VALE_DESCONTO :~n' + sqlca.sqlerrtext
				return false
			end if
			
		Next
		
	Else
		Return False
	End If	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_campanha_sap_cupom'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

on uo_ge473_campanha_c4.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_campanha_c4.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

