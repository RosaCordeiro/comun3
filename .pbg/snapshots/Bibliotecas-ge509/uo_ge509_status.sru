HA$PBExportHeader$uo_ge509_status.sru
forward
global type uo_ge509_status from nonvisualobject
end type
end forward

global type uo_ge509_status from nonvisualobject
end type
global uo_ge509_status uo_ge509_status

type variables
string is_objeto
string is_url_interface = 'https://integracao.equilibriumsc.com/api/v1/ordemServico/'
string is_status
long il_cd_filial
long il_nr_pedido

end variables

forward prototypes
public function boolean of_retorno (string ps_json, ref string ps_log)
public function boolean of_processa_status (long pl_cd_filial, long pl_nr_pedido, string ps_id_pedido, ref string ps_status, ref string ps_log)
end prototypes

public function boolean of_retorno (string ps_json, ref string ps_log);long ll_linha
long ll_existe
long ll_sequencial
string ls_json_restante
string ls_info_status
string ls_status
string ls_cd_status
string ls_data
string ls_retorno
datetime ldt_status

dc_uo_ds_base lds_status

Try

	lds_status = create dc_uo_ds_base
	
	if not lds_status.of_changedataobject( 'ds_ge509_pedido_status' , false) Then
		ps_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_retorno ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge509_pedido_status'
		return false
	end if
	
	uo_ge073_json luo_gera_json
	
	luo_gera_json = Create uo_ge073_json 
	
	ls_json_restante = ps_json
	
	is_status = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'situacao')
	is_status = Upper(is_status)
	
//	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'status', ref ls_info_status, ']')
//	
//	//Pega todos os status e grava no banco de dados.
//	Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_info_status, Ref ls_retorno,'{') 
//		
//		ls_status = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'status')
//		ls_cd_status = mid(ls_status,1,10)
//		
//		ls_data = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'data')
//	
//		ldt_status = Datetime( date( mid(ls_data, 1, 10) ), time( mid(ls_data, 12, 8) ) ) 
//		
//		if ls_status <> '' and not isnull(ls_status) Then
//			
//			ll_linha = lds_status.insertrow( 0 )
//		
//			lds_status.object.id_status[ll_linha] = ls_status
//			lds_status.object.dt_status[ll_linha] = ldt_status
	
			//"2020-05-08T10:17:42
		
//			Select count(*)
//			into :ll_existe
//			from pedido_ecommerce_entrega_rast
//			where cd_filial_ecommerce = :il_cd_filial
//				and nr_pedido = :il_nr_pedido
//				and de_status = :ls_status;
//		
//			if sqlca.sqlcode = -1 then
//				ps_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_retorno ; ' + 'Problemas ao consultar a tabela "pedido_ecommerce_entrega_rast": ' + sqlca.sqlerrtext
//				return false
//			end if
//		
//			if ll_existe = 0 or isnull(ll_existe) Then
		
//				Select max(nr_sequencial)
//				into :ll_sequencial
//				from pedido_ecommerce_entrega_rast
//				where cd_filial_ecommerce = :il_cd_filial
//					and nr_pedido = :il_nr_pedido;
//				
//				if sqlca.sqlcode = -1 then
//					ps_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_retorno ; ' + 'Problemas ao consultar a tabela "pedido_ecommerce_entrega_rast": ' + sqlca.sqlerrtext
//					return false
//				end if
//				
//				if ll_sequencial = 0 or isnull(ll_sequencial) Then
//					ll_sequencial = 1
//				else
//					ll_sequencial++
//				end if
		
//				insert into pedido_ecommerce_entrega_rast(cd_filial_ecommerce, 
//																			nr_pedido,
//																			nr_sequencial,
//																			cd_status,
//																			de_status,
//																			dh_status,
//																			dh_inclusao)
//				Values(:il_cd_filial,
//						:il_nr_pedido,
//						:ll_sequencial,
//						:ls_cd_status,
//						:ls_status,
//						:ldt_status,
//						getdate() );
//			
//				if sqlca.sqlcode = -1 then
//					ps_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_retorno ; ' + 'Problemas ao inserir registro na tabela "pedido_ecommerce_entrega_rast": ' + sqlca.sqlerrtext
//					return false
//				end if
			
//			end if		
//					
//		end if
//	
//	Loop
	
	//Busca o status mais recente (status atual)
//	if lds_status.rowcount() > 0 Then
//		
//		lds_status.find('upper(id_status) = "ENTREGUE"'
//		
//		lds_status.setsort( 'data desc')
//		lds_status.sort()
//		
//		is_status = Upper( lds_status.object.id_status[1])
//		
//	else
//		is_status = ''
//	end if
	
Finally
	
	destroy(luo_gera_json)
	destroy(lds_status)
end Try

return true
end function

public function boolean of_processa_status (long pl_cd_filial, long pl_nr_pedido, string ps_id_pedido, ref string ps_status, ref string ps_log);string ls_log
string ls_retorno

long ll_linhas
long ll_for

uo_ge509_comum luo_comum


try 

	il_cd_filial = pl_cd_filial
	il_nr_pedido = pl_nr_pedido

	luo_comum = create uo_ge509_comum

	luo_comum.of_get( is_url_interface + ps_id_pedido , ls_retorno, ref ls_log )
		
	if ls_log <> '' and not isnull(ls_log) Then
		ps_log = ls_log
		return false
	end if
	
	if Not this.of_retorno( ls_retorno, ref ps_log ) Then return false
	
	if isnull(is_status) Then is_status = '' 
	
//	if is_status = '' Then
//		ps_log = is_objeto + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel obter o status do pedido.'
//		return false
//	end if
	
	ps_status = is_status

Finally
		
	destroy(luo_comum)
	
End try

return true
end function

on uo_ge509_status.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge509_status.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - ' + 'Objeto: ' + this.classname() + ' - '
end event

