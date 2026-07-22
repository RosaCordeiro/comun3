HA$PBExportHeader$w_ge501_vtex_liberacao.srw
forward
global type w_ge501_vtex_liberacao from dc_w_cadastro_freeform
end type
end forward

global type w_ge501_vtex_liberacao from dc_w_cadastro_freeform
integer width = 2519
integer height = 2056
string title = "GE501 - Cadastro Seller VTEX"
end type
global w_ge501_vtex_liberacao w_ge501_vtex_liberacao

type variables
uo_filial ivo_filial

uo_fornecedor ivo_fornecedor
end variables

forward prototypes
public subroutine wf_configura_seller ()
public subroutine wf_salva_parametro_loja ()
end prototypes

public subroutine wf_configura_seller ();long ll_cd_filial

ll_cd_filial = dw_1.object.cd_filial[1]

uo_ge501_configuracao luo_vtex
luo_vtex = create uo_ge501_configuracao
luo_vtex.of_processa_configuracao(ivo_filial.id_rede_filial, ll_cd_filial)
destroy(luo_vtex)
end subroutine

public subroutine wf_salva_parametro_loja ();long ll_linha, ll_cd_filial, ll_existe
string ls_id_motoboy, ls_id_motoboy_orig , ls_cd_prestador, ls_cd_prestador_orig
boolean lb_sucesso = false, lb_alterado = false

ll_linha = dw_1.getrow()

Try

	if ll_linha > 0 then
		
		//ls_id_motoboy_orig = dw_1.getitemstring(ll_linha, 'id_motoboy_ecommerce', primary!, true)
		ls_id_motoboy = dw_1.object.id_motoboy_ecommerce[ll_linha]
		ll_cd_filial = dw_1.object.cd_filial[ll_linha]
		ls_cd_prestador = dw_1.object.cd_prestador[ll_linha]
		
		select vl_parametro
		into :ls_id_motoboy_orig
		from parametro_loja
		where cd_filial = :ll_cd_filial
		and cd_parametro = 'ID_MOTOBOY_ECOMMERCE';
		
		if sqlca.sqlcode = -1 then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela parametro_loja: ' + sqlca.sqlerrtext)
			return 
		elseif sqlca.sqlcode = 100 then
			ll_existe = 0
		Else
			ll_existe = 1
		End if
		
		if isnull(ls_id_motoboy_orig) or ls_id_motoboy_orig = ''  then ls_id_motoboy_orig = 'N'
		if isnull(ls_id_motoboy) or ls_id_motoboy = '' then ls_id_motoboy = 'N'
		
		if ls_id_motoboy_orig <> ls_id_motoboy Then
			
			if ll_existe = 0 or isnull(ll_existe) Then
				
				if ls_id_motoboy = 'S' Then
					
					insert into parametro_loja(cd_filial, cd_parametro, vl_parametro)
					Values( :ll_cd_filial, 'ID_MOTOBOY_ECOMMERCE', :ls_id_motoboy);
					
					if sqlca.sqlcode = -1 then
						sqlca.of_rollback( )
						messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao inserir registro na tabela parametro_loja: ' + sqlca.sqlerrtext)
						return 
					End if
					
					lb_alterado = True
					
				End if
			Else
			
				Update parametro_loja
				set vl_parametro = :ls_id_motoboy
				where cd_filial = :ll_cd_filial
				and cd_parametro = 'ID_MOTOBOY_ECOMMERCE';
				
				if sqlca.sqlcode = -1 then
					sqlca.of_rollback( )
					messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao atualizar a tabela parametro_loja: ' + sqlca.sqlerrtext)
					return 
				End if
				
				lb_alterado = true
				
			End if
			
		End if
		
		select vl_parametro
		into :ls_cd_prestador_orig
		from parametro_loja
		where cd_filial = :ll_cd_filial
		and cd_parametro = 'CD_PRESTADOR_SERVICO_DISQUE_ENTREGA';
		
		if sqlca.sqlcode = -1 then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela parametro_loja: ' + sqlca.sqlerrtext)
			return 
		elseif sqlca.sqlcode = 100 then
			ll_existe = 0
		Else
			ll_existe = 1
		End if
		
		if isnull(ls_cd_prestador) then ls_cd_prestador = ''
		if isnull(ls_cd_prestador_orig) then ls_cd_prestador_orig = ''
		
		if ls_cd_prestador_orig <> ls_cd_prestador Then
		
			if ll_existe > 0 Then
				
				Update parametro_loja
				set vl_parametro = :ls_cd_prestador
				where cd_filial = :ll_cd_filial
				and cd_parametro = 'CD_PRESTADOR_SERVICO_DISQUE_ENTREGA';
				
				if sqlca.sqlcode = -1 then
					messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao atualizar a tabela parametro_loja: ' + sqlca.sqlerrtext)
					return 
				End if
				lb_alterado = true
				
			Else
				
				if ls_cd_prestador <> '' and not isnull(ls_cd_prestador) Then
				
					insert into parametro_loja(cd_filial, cd_parametro, vl_parametro)
						Values( :ll_cd_filial, 'CD_PRESTADOR_SERVICO_DISQUE_ENTREGA', :ls_cd_prestador);
						
						if sqlca.sqlcode = -1 then
							sqlca.of_rollback( )
							messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao inserir registro na tabela parametro_loja: ' + sqlca.sqlerrtext)
							return 
						End if
						lb_alterado = true
						
				ENd if
			ENd if		
		ENd if
	
	End if	
	
	lb_sucesso = true
	
Finally	
	if lb_sucesso = True Then
		if lb_alterado = true then
			SQLCA.of_commit( )
		ENd if
	ELse
		SQLCA.of_rollback( )
	ENd if
End Try
end subroutine

on w_ge501_vtex_liberacao.create
call super::create
end on

on w_ge501_vtex_liberacao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_filial)
end event

event ue_preopen;call super::ue_preopen;ivo_Filial 						  		= Create uo_filial
ivo_fornecedor = create uo_fornecedor
end event

event ue_save;call super::ue_save;If AncestorReturnValue > 0 Then
	wf_configura_seller()
	
	wf_salva_parametro_loja()
	
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge501_vtex_liberacao
integer x = 9
integer y = 1992
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge501_vtex_liberacao
integer x = 0
integer y = 1944
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge501_vtex_liberacao
integer x = 64
integer width = 2359
integer height = 1736
string dataobject = "dw_ge501_liberacao"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_1::ue_preupdate;call super::ue_preupdate;Long	ll_Filial
Long ll_Dia_Carga
datetime ldt_nulo
String ls_situacao_nova, ls_situacao_antiga
String ls_Rede
String ls_URL
String ls_Chave
String ls_Token
String ls_Grupo
String ls_id_motoboy_ecommerce
String ls_cd_prestador

setnull(ldt_nulo)			
			
This.AcceptText()

ll_Filial 	= This.Object.Cd_Filial	   				[1]
ls_Rede 	= This.Object.id_rede_filial				[1]
ls_URL	= This.Object.cd_url_integracao		[1]
ls_Chave = This.Object.cd_chave_integracao	[1]
ls_Token = This.Object.cd_token_integracao	[1]
ls_id_motoboy_ecommerce = This.Object.id_motoboy_ecommerce[1]
ls_cd_prestador = This.Object.cd_prestador[1]

ll_Dia_Carga	= This.Object.nr_dia_carga_completa[1]
ls_Grupo 			= This.Object.cd_grupo_execucao_tarefa[1]

If IsNull(ll_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a filial.", Exclamation!)
	This.Event ue_Pos(1, "cd_filial")
	Return -1
End If	

If IsNull(ls_Rede) or Trim(ls_Rede) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a rede.", Exclamation!)
	This.Event ue_Pos(1, "id_rede_filial")
	Return -1
End If

If ( IsNull(ls_cd_prestador) or Trim(ls_cd_prestador) = '' ) and ls_id_motoboy_ecommerce = 'S' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O prestador de servi$$HEX1$$e700$$ENDHEX$$o de Motoboy deve ser informado.", Exclamation!)
	This.Event ue_Pos(1, "nm_prestador")
	Return -1
End If

If IsNull(ls_URL) or Trim(ls_URL) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a URL.", Exclamation!)
	This.Event ue_Pos(1, "cd_url_integracao")
	Return -1
End If

If IsNull(ls_Chave) or Trim(ls_Chave) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a chave para integra$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
	This.Event ue_Pos(1, "cd_chave_integracao")
	Return -1
End If

If IsNull(ls_Token) or Trim(ls_Token) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o TOKEN para integra$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
	This.Event ue_Pos(1, "cd_token_integracao")
	Return -1
End If

If IsNull(ls_Grupo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O grupo da execu$$HEX2$$e700e300$$ENDHEX$$o da tarefa.", Exclamation!)
	This.Event ue_Pos(1, "cd_grupo_execucao_tarefa")
	Return -1
End If	

If IsNull(ll_Dia_Carga) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o dia do m$$HEX1$$ea00$$ENDHEX$$s que ser$$HEX1$$e100$$ENDHEX$$ realizada a carga completa de saldo.", Exclamation!)
	This.Event ue_Pos(1, "nr_dia_carga_completa")
	Return -1
End If	

If ll_Dia_Carga <= 0 or ll_Dia_Carga > 30 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O dia do m$$HEX1$$ea00$$ENDHEX$$s da carga completa de saldo deve estar entre [1-30].", Exclamation!)
	This.Event ue_Pos(1, "nr_dia_carga_completa")
	Return -1
End If

if this.getitemstatus(1,0,primary!) = Datamodified! Then
	ls_situacao_nova = this.getitemstring(1,'id_situacao', primary!, false)
	ls_situacao_antiga = this.getitemstring(1,'id_situacao', primary!, true)
	
	//Se houve altera$$HEX2$$e700e300$$ENDHEX$$o de status, for$$HEX1$$e700$$ENDHEX$$ar a realizar nova configura$$HEX2$$e700e300$$ENDHEX$$o de seller na VTEX
	if ls_situacao_antiga <> ls_situacao_nova Then
		this.object.dh_configuracao_seller[1] = ldt_nulo
	end if
	
end if

Return AncestorReturnValue
end event

event dw_1::constructor;call super::constructor;ivs_Coluna_Sem_Validacao_Salva = {"nm_filial"}

This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;String ls_URL

Long ll_Filial

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		
	Case 'nm_prestador'
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_prestador[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_prestador[1] = ivo_Fornecedor.Nm_Razao_Social
			End If
			
			Parent.ivm_Menu.mf_Confirmar(True)
			Parent.ivm_Menu.mf_Cancelar(True)

			
		Case "nm_filial"
			
			ivo_filial.of_Localiza_Filial(This.GetText())

			// Verifica se a Filial foi localizada e atualiza a DW
			If ivo_filial.Localizada Then
				dw_1.Object.cd_filial	[1] = ivo_filial.cd_filial
				dw_1.Object.nm_filial	[1] = ivo_filial.nm_fantasia
				dw_1.Object.id_rede_filial	[1] = ivo_filial.id_rede_filial
				
				Choose Case ivo_filial.id_rede_filial
					Case 'PP'
						ls_URL = 'https://precopopularXXX.myvtex.com/'
					Case 'DC'
						ls_URL = 'https://drogariacatarinenseXXX.myvtex.com/'
					Case 'FA'
						ls_URL = "https://farmagoraXXX.myvtex.com/"
					Case Else
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Rede n$$HEX1$$e300$$ENDHEX$$o prevista.")
				End Choose
				
				dw_1.Object.cd_url_integracao	[1] = gf_Replace(ls_URL, 'XXX', string(ivo_filial.cd_filial), 0)		
				
				Select cd_filial
				Into :ll_Filial
				From ecommerce_rede_filial
				where cd_filial = :ivo_filial.cd_filial
					and id_ecommerce = '2'
					and id_rede_filial = :ivo_filial.id_rede_filial
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgDbError("Erro ao localizar a filial")
					Return
				End IF
				
				If ll_Filial > 0 Then
					This.Event ue_Retrieve()
				Else
					This.Reset()
					This.Event ue_AddRow()
					
					dw_1.Object.cd_filial	[1] = ivo_filial.cd_filial
					dw_1.Object.nm_filial	[1] = ivo_filial.nm_fantasia
					dw_1.Object.id_rede_filial	[1] = ivo_filial.id_rede_filial
					
					Choose Case ivo_filial.id_rede_filial
						Case 'PP'
							ls_URL = 'https://precopopularXXX.myvtex.com/'
						Case 'DC'
							ls_URL = 'https://drogariacatarinenseXXX.myvtex.com/'
						Case 'FA'
							ls_URL = "https://farmagoraXXX.myvtex.com/"
						Case Else
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Rede n$$HEX1$$e300$$ENDHEX$$o prevista.")
					End Choose
				
					dw_1.Object.cd_url_integracao	[1] = gf_Replace(ls_URL, 'XXX', string(ivo_filial.cd_filial), 0)		
					
					dw_1.Event ue_Pos(1, 'cd_chave_integracao')
				End If
			Else
				SetNull(ivo_filial.cd_Filial)
				ivo_filial.nm_fantasia   = ""
				dw_1.Object.cd_filial	[1] = ivo_filial.cd_filial
				dw_1.Object.nm_filial	[1] = ivo_filial.nm_fantasia
				dw_1.Object.id_rede_filial	[1] = ivo_filial.id_rede_filial
				dw_1.Object.cd_url_integracao	[1] = ''
			End If
			
	End Choose
End If

ivm_Menu.mf_Excluir(False)
end event

event dw_1::itemchanged;call super::itemchanged;string ls_nulo

Choose Case dwo.Name

	Case "nm_filial"	
		this.Reset()
		If data = "" or IsNull(data) Then
			SetNull(ivo_filial.cd_Filial)
			ivo_filial.nm_fantasia   = ""
			setnull(ivo_filial.id_rede_filial)
		   	dw_1.Object.cd_filial			[1] = ivo_filial.cd_filial
		   	dw_1.Object.nm_filial			[1] = ivo_filial.nm_fantasia
			dw_1.Object.id_rede_filial	[1] = ivo_filial.id_rede_filial
			dw_1.Object.cd_url_integracao	[1] = ''
		End If	
	
	Case 'id_situacao'
		
		if data = 'I' then
			this.object.id_abrangente[1] = 'N'
		End if
		
	Case 'id_abrangente'
		
		if this.object.id_situacao[1] = 'I' then return 1
		
	Case 'id_motoboy_ecommerce'
		
		If data = 'N' then
			setnull(ls_nulo)
			this.object.cd_prestador[1] = ls_nulo
			this.object.nm_prestador[1] = ls_nulo
		ENd if
		
End Choose
end event

event dw_1::ue_recuperar;// Override
Return This.Retrieve('2', ivo_filial.id_rede_filial, ivo_filial.cd_filial)
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_1.Object.nm_filial	[1] = ivo_filial.nm_fantasia
End If

Return AncestorReturnValue
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge501_vtex_liberacao
integer width = 2409
integer height = 1844
end type

