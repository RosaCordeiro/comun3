HA$PBExportHeader$w_ge607_consulta_documentos_sybase_mult.srw
forward
global type w_ge607_consulta_documentos_sybase_mult from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge607_consulta_documentos_sybase_mult from dc_w_selecao_lista_relatorio
string accessiblename = "GE607 Pendencias Sybase x TDF"
integer width = 3863
integer height = 2028
string title = "GE607 - Pend$$HEX1$$ea00$$ENDHEX$$ncias Exporta$$HEX2$$e700e300$$ENDHEX$$o TDF x Sybase"
end type
global w_ge607_consulta_documentos_sybase_mult w_ge607_consulta_documentos_sybase_mult

type variables
String ivs_Filiais

uo_filial				ivo_filial
uo_ge216_filiais	ivo_filiais
dc_uo_transacao	itr_Mult
end variables

forward prototypes
public function boolean wf_conecta_banco_mult ()
public function long wf_processar (datetime p_dh_inico, datetime p_dh_fim, character p_selecao, long p_cd_filial)
public function boolean of_existe_doc_filial_destino_mult (datetime a_dh_exportacao, long a_cd_filial, long a_nr_nf, string a_de_especie, string a_de_serie, ref long a_ret, ref string a_msg)
end prototypes

public function boolean wf_conecta_banco_mult ();String lvs_Conexao

lvs_Conexao = IIF(SQLCa.Banco_Producao, "clamprod", "clamteste")

If Not gf_conecta_banco_mult( itr_Mult, lvs_Conexao ) Then
	Return False
End If

Return True
end function

public function long wf_processar (datetime p_dh_inico, datetime p_dh_fim, character p_selecao, long p_cd_filial);Long	lvl_For,&
		lvl_For_Doc,&
		lvl_Row,&
		lvl_Total,&
		lvl_Total_Mult,&
		lvl_Total_Doc,&
		lvl_Cd_Filial,&
		lvl_Find,&
		lvl_nr_nf,&
		lvl_Cd_Filial_Destino
		
String	lvs_nm_Fantasia,&
		lvs_Find_doc,&
		lvs_de_especie,&
		lvs_de_serie, &
		lvs_id_tipo_nf,&
		lvs_id_situacao_docto,&
		lvs_id_situacao_log,&
		lvs_cd_Fornecedor,&
		lvs_msg, &
		lvs_Chave
		
DateTime lvdt_dh_exportacao, &
			 lvdt_dh_Movto

dc_uo_ds_base lvds_Filial
dc_uo_ds_base lvds_doc
dc_uo_ds_base lvds_mult

Try 
	
	If Not wf_conecta_banco_mult() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Falha ao obter conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados ORACLE.", Exclamation!)
		Return 0
	End If
	
	lvds_Filial = create dc_uo_ds_base 
	lvds_Mult = create dc_uo_ds_base
	lvds_Doc = create dc_uo_ds_base
	
	If Not lvds_Doc.of_changedataobject( "dw_ge607_lista")  Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Falha ao mudar o dataobject dw_ge607_lista.", Exclamation!)
		Return 0
	End If
	
	If Not lvds_Filial.of_changedataobject( "dw_ge607_filial")  Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Falha ao mudar o dataobject dw_ge607_filial.", Exclamation!)
		Return 0
	End If
	If Not lvds_Mult.of_changedataobject( "dw_ge607_mult")  Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Falha ao mudar o dataobject dw_ge607_mult.", Exclamation!)
		Return 0
	End If
	
	lvds_Filial.of_settransobject(SQLCA)
	lvds_Doc.of_settransobject(SQLCA)
	lvds_Mult.of_settransobject(itr_Mult)
	
	If p_Selecao = "U" Then
		If Not IsNull(p_cd_filial) and (p_cd_filial > 0) Then
			ivs_Filiais = String(p_cd_filial)
		Else
			ivs_Filiais=''
		End If
	End If
	
	If ivs_Filiais <> "" Then
		lvds_Filial.of_appendwhere(" f.cd_filial in ( " + ivs_Filiais + ")")
	End If
	
	lvl_Total = lvds_Filial.Retrieve(p_dh_inico,p_dh_fim)
	
	If lvl_Total < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Falha no retrieve da dw_ge607_filial.", Exclamation!)
		Return 0
	End If
	
	dw_2.Reset()
	Open(w_Aguarde)
	Open(w_Aguarde_2)
	w_Aguarde_2.move(w_Aguarde_2.x,w_Aguarde_2.y+w_Aguarde.height)
	
	w_Aguarde.Title = "Processando filiais ... "
	w_Aguarde.uo_Progress.of_setmax(lvl_Total)
	dw_2.Setredraw(False)
	
	For lvl_For = 1 To lvl_Total
				
		lvl_Cd_Filial			= lvds_Filial.object.cd_filial	[lvl_For]
		lvs_nm_Fantasia	= lvds_Filial.object.nm_filial	[lvl_For]
		
		w_Aguarde.Title = "Processando Filial "+lvs_nm_Fantasia+". Em " + String(lvl_For) + " de " + String(lvl_Total)
		w_Aguarde.uo_Progress.of_setprogress(lvl_For)
		
		lvl_Total_Doc = lvds_Doc.Retrieve(p_dh_inico,p_dh_fim,lvl_Cd_Filial)
	
		If lvl_Total_Doc < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Falha no retrieve da dw_ge607_lista.", Exclamation!)
			Return 0
		End If
		
		//Ver se a filial da mult leva o codigo sybase
		lvl_Total_Mult = lvds_Mult.Retrieve(p_dh_inico,lvl_Cd_Filial,'PRD','PADRAO','P')
	
		If lvl_Total_Mult < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Falha no retrieve da dw_ge607_mult.", Exclamation!)
			Return 0
		End If
		
		w_Aguarde_2.uo_Progress.of_reset()
		w_Aguarde_2.Title = "Processando documentos ... "
		w_Aguarde_2.uo_Progress.of_setmax(lvl_Total_Doc)
		
		For lvl_For_Doc = 1 To lvl_Total_Doc
			
			w_Aguarde_2.uo_Progress.of_setprogress(lvl_For_Doc)
			
			lvl_nr_nf					= lvds_Doc.object.nr_nf							[lvl_For_Doc]
			lvs_de_especie			= lvds_Doc.object.de_especie					[lvl_For_Doc]
			lvs_de_serie				= lvds_Doc.object.de_serie						[lvl_For_Doc]
			lvs_id_tipo_nf			= lvds_Doc.object.id_tipo_nf					[lvl_For_Doc]
			lvs_id_situacao_docto	= lvds_Doc.object.id_situacao_docto			[lvl_For_Doc]
			lvs_id_situacao_log	= lvds_Doc.object.id_situacao_log				[lvl_For_Doc]
			lvs_cd_Fornecedor		= lvds_Doc.object.cd_Fornecedor				[lvl_For_Doc]
			lvdt_dh_exportacao	= lvds_Doc.object.dh_exportacao				[lvl_For_Doc]
			lvdt_dh_Movto			= lvds_Doc.object.dh_movimentacao_caixa	[lvl_For_Doc]
			lvl_Cd_Filial_Destino	= lvds_Doc.object.cd_filial_destino				[lvl_For_Doc]
			lvs_Chave				= lvds_Doc.object.de_chave_acesso			[lvl_For_Doc]
			
			//Na mult esta com o codigo do modelo
			Choose Case lvs_de_especie 
				Case 'NFE'
					lvs_de_especie = '55'
					
					Do While Len(lvs_de_serie)<3
						lvs_de_serie = '0'+lvs_de_serie
					Loop
				Case 'NFC'
					lvs_de_especie = '65'
				Case Else
					//
			End Choose
			
			//Na mult 3 digitos com zeros (0) a esquerda
			If Long(lvs_de_serie) > 0 Then
				lvs_de_serie = String(Long(lvs_de_serie),"000")
			End If
			
			lvl_Find = 0
			lvs_msg = ""
			If IsNull(lvs_cd_Fornecedor) Then lvs_cd_Fornecedor = ''
			
			//Tratamento pra transferencias. No sybase gera 2 registros no log ('ST' e 'ET') na mesma filial
			//Na mult gera 1 registro no log pra cada tipo de documento 
			If lvs_id_tipo_nf = 'ET' And lvl_Cd_Filial_Destino > 0 Then
				
				If Not This.of_existe_doc_filial_destino_mult( p_dh_inico, lvl_Cd_Filial_Destino,lvl_nr_nf, lvs_de_especie, lvs_de_serie, ref lvl_Find, ref lvs_msg) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_msg, StopSign!)
					Return 0
				End If
				
			Else
				
				lvs_Find_doc = " nr_nf="+String(lvl_nr_nf)+&
					" and de_especie='"+lvs_de_especie+"'"+&
					" and de_serie='"+lvs_de_serie+"'"
				If Trim(lvs_cd_Fornecedor) <> "" Then lvs_Find_doc = lvs_Find_doc + " and cd_Fornecedor='"+lvs_cd_Fornecedor+"'"
				
				lvl_Find = lvds_Mult.find(lvs_Find_doc,1, lvl_Total_Mult)
								
			End If
			
			Choose Case lvl_Find
				Case Is < 0 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Falha no find da dw_ge607_mult.",StopSign!)
					Return 0
				Case Is > 0
					//
				Case 0
					lvl_Row = dw_2.InsertRow(0)
					dw_2.object.nm_filial						[lvl_Row] = lvs_nm_Fantasia	
					dw_2.object.nr_nf							[lvl_Row] = lvl_nr_nf	
					dw_2.object.de_especie					[lvl_Row] = lvs_de_especie
					dw_2.object.de_serie						[lvl_Row] = lvs_de_serie
					dw_2.object.id_tipo_nf					[lvl_Row] = lvs_id_tipo_nf
			 		dw_2.object.id_situacao_docto			[lvl_Row] = lvs_id_situacao_docto
			 		dw_2.object.id_situacao_log			[lvl_Row] = lvs_id_situacao_log
					dw_2.object.cd_Fornecedor				[lvl_Row] = lvs_cd_Fornecedor
					dw_2.object.dh_exportacao				[lvl_Row] = lvdt_dh_exportacao
					dw_2.object.cd_filial_destino			[lvl_Row] = lvl_Cd_Filial_Destino
					dw_2.object.de_chave_acesso			[lvl_Row] = lvs_Chave
					dw_2.object.dh_movimentacao_caixa	[lvl_Row] = lvdt_dh_Movto
			End Choose
		Next
		
	Next
	
Finally
	dw_2.Setredraw(True)
	itr_Mult.of_disconnect()
	Destroy(lvds_Filial)
	Destroy(lvds_mult)
	Close(w_Aguarde_2)
	Close(w_Aguarde)
End Try

Return lvl_Total
end function

public function boolean of_existe_doc_filial_destino_mult (datetime a_dh_exportacao, long a_cd_filial, long a_nr_nf, string a_de_especie, string a_de_serie, ref long a_ret, ref string a_msg);select count(1)
into :a_ret
from log_exportacao_docto
where cd_ambiente_sap = 'PRD'
  and cd_integracao = 'PADRAO'
  and dh_exportacao >= :a_dh_exportacao
  and id_situacao_log = 'P'
  and cd_filial = :a_cd_filial
  and nr_nf = :a_nr_nf
  and de_especie = :a_de_especie
  and de_serie = :a_de_serie
using itr_Mult;

If IsNull(a_ret) Then a_ret = 0

If itr_Mult.sqlcode < 0 Then
	a_msg = "Falha ao consultar documento do origem {log_exportacao_docto} na Mult. "+itr_Mult.sqlerrtext
	Return False
End If

Return True
end function

on w_ge607_consulta_documentos_sybase_mult.create
call super::create
end on

on w_ge607_consulta_documentos_sybase_mult.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.object.dh_inicio		[1] = Date('01/'+String( RelativeDate(Today(), -1),'mm/yyyy'))
dw_1.object.dh_fim		[1] = RelativeDate(Today(), -1)
end event

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_filiais)
end event

event resize;call super::resize;gb_2.width = newWidth - 45
gb_2.Height = newHeight - 396

dw_2.width = newWidth - 87
dw_2.Height = newHeight - 472
end event

event ue_preopen;call super::ue_preopen;MaxWidth 	= 5550
MaxHeight 	= 9999

ivo_filial		= Create uo_filial
ivo_filiais		= Create uo_ge216_filiais
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge607_consulta_documentos_sybase_mult
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge607_consulta_documentos_sybase_mult
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge607_consulta_documentos_sybase_mult
integer y = 292
integer width = 3744
integer height = 1532
string text = "Lista de notas com diverg$$HEX1$$ea00$$ENDHEX$$ncia"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge607_consulta_documentos_sybase_mult
integer width = 2825
integer height = 264
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge607_consulta_documentos_sybase_mult
integer width = 2752
integer height = 188
string dataobject = "dw_ge607_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

Choose Case dwo.name
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_inicializa( )
			
			This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia			
		End If
		
	Case "id_filial"
		ivs_filiais = "" 
		If Data = 'C' Then
					
			OpenWithParm(w_ge216_selecao_filiais, ivo_filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = ivo_filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
				Data = "T"
				dw_1.Object.id_filial [Row] = Data
			End If
			
		End If
End Choose

This.accepttext( )
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName() 
			
		Case "nm_filial"
			ivo_filial.of_Localiza_filial(This.GetText())
			
			If ivo_filial.Localizada Then
				 This.Object.cd_filial	[1] = ivo_filial.Cd_Filial
				 This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
			Else 
				ivo_filial.of_Inicializa()
			End If
	End Choose
	This.accepttext( )
End If
end event

event dw_1::editchanged;call super::editchanged;ivm_Menu.mf_salvarcomo( False)


end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) then
	If ivo_Filial.Localizada Then
		This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
	End If
End If
This.accepttext( )
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge607_consulta_documentos_sybase_mult
integer y = 360
integer width = 3698
integer height = 1456
string dataobject = "dw_ge607_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//OverRider
DateTime ldh_inicio
DateTime ldh_fim

Long lvl_Filial_Filtro

String lvs_Selecao
String lvs_Parametro

dw_1.AcceptText()

ldh_inicio			= dw_1.Object.dh_inicio	[1]
ldh_fim			= DateTime(Date(dw_1.Object.dh_fim	[1]),Time("23:59:59"))
lvl_Filial_Filtro	= dw_1.Object.cd_filial	[1]
lvs_Selecao		= dw_1.Object.id_filial	[1]

If IsNUll(ldh_inicio)  or IsNUll(ldh_fim) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Datas de exporta$$HEX2$$e700e300$$ENDHEX$$o inicial e final s$$HEX1$$e300$$ENDHEX$$o obrigat$$HEX1$$f300$$ENDHEX$$rias.")
	Return -1
End If	

If Date(ldh_inicio) > Date(ldh_fim) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data de exporta$$HEX2$$e700e300$$ENDHEX$$o inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data final.")
	Return -1
End If	

//Valida datas anteriores a limpeza do log
uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral
lvo_Parametro.of_localiza_parametro("DH_LIMPA_LOG_EXPORTACAO_DOCTO", ref lvs_Parametro)
Destroy(lvo_Parametro)

If Date(ldh_inicio) < Date(lvs_Parametro) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data do $$HEX1$$fa00$$ENDHEX$$ltimo expurgo do log de exporta$$HEX2$$e700e300$$ENDHEX$$o de documentos.~r~n~r~n$$HEX1$$da00$$ENDHEX$$ltimo expurgo em: '"+ lvs_Parametro +"'",Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If 

//Validar maximo de 31 dias
If RelativeDate(Date(ldh_inicio),31) < Date(ldh_fim) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Per$$HEX1$$ed00$$ENDHEX$$odo m$$HEX1$$e100$$ENDHEX$$ximo de consulta deve ser de 31 dias.")
	Return -1
End If	

//Validar maximo de 31 dias p/ pra traz
If RelativeDate(Today(),-31) > Date(ldh_inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Per$$HEX1$$ed00$$ENDHEX$$odo m$$HEX1$$e100$$ENDHEX$$ximo de consulta $$HEX1$$e900$$ENDHEX$$ 31 dias anteriores a data atual.")
	Return -1
End If	

Return wf_processar(ldh_inicio, ldh_fim, lvs_Selecao, lvl_Filial_Filtro)

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;dw_2.of_SetRowSelection()

ivm_Menu.mf_salvarcomo( pl_linhas > 0)

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;ivm_Menu.mf_salvarcomo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge607_consulta_documentos_sybase_mult
integer x = 2400
integer y = 56
integer width = 384
integer height = 108
end type

