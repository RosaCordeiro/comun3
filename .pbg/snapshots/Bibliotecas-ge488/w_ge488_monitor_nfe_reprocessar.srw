HA$PBExportHeader$w_ge488_monitor_nfe_reprocessar.srw
forward
global type w_ge488_monitor_nfe_reprocessar from dc_w_2tab_consulta_selecao_lista_det
end type
type gb_4 from groupbox within tabpage_1
end type
type mle_erro from multilineedit within tabpage_1
end type
type cb_reprocessar from commandbutton within tabpage_1
end type
type cb_reproc_local from commandbutton within tabpage_1
end type
type cb_reproc_xml from commandbutton within tabpage_1
end type
type cb_inutilizada from commandbutton within tabpage_1
end type
type cbx_1 from checkbox within tabpage_2
end type
end forward

global type w_ge488_monitor_nfe_reprocessar from dc_w_2tab_consulta_selecao_lista_det
integer width = 5115
integer height = 2272
string title = "GE488 - Monitor Notas Fiscais Reprocessadas"
end type
global w_ge488_monitor_nfe_reprocessar w_ge488_monitor_nfe_reprocessar

type variables
Boolean ivb_Check = False

uo_Filial 						ivo_Filial				//GE009
uo_Fornecedor				ivo_Fornecedor
uo_ge238_importa_xml	ivo_xml_imp
end variables

forward prototypes
public function boolean wf_salvar (ref string as_erro)
public subroutine wf_habilita_menu (boolean ab_habilita)
public function boolean wf_verifica_produtos_nf ()
public function boolean wf_marca_nfe_reprocessar (string ps_chave_acesso)
public function integer wf_processa_xml (string ps_arquivo)
end prototypes

public function boolean wf_salvar (ref string as_erro);Long	ll_Produto,&
		ll_produto_Original,&
		ll_Linha,&
		ll_Linhas,&
		ll_nr_item,&
		ll_Qtde
		
String 	ls_Erro,&
			ls_de_chave_acesso

Tab_1.TabPage_2.dw_3.AcceptText()

//Salva altera$$HEX2$$e700e300$$ENDHEX$$o no produto
Tab_1.TabPage_2.dw_3.AcceptText()

ll_Linhas	= Tab_1.TabPage_2.dw_3.RowCount()

For ll_Linha = 1 To ll_Linhas
	ll_produto				= Tab_1.TabPage_2.dw_3.Object.cd_produto						[ll_Linha]
	ll_produto_Original	= Tab_1.TabPage_2.dw_3.Object.cd_produto_original			[ll_Linha]
	ls_de_chave_acesso	= Tab_1.TabPage_2.dw_3.Object.de_chave_acesso				[ll_Linha]
	ll_nr_item				= Tab_1.TabPage_2.dw_3.Object.nr_item							[ll_Linha]
	
	If IsNull(ll_produto) Then ll_produto = 0
	If IsNull(ll_produto_Original) Then ll_produto_Original = 0
	
	If ll_produto <> ll_produto_Original Then
		Update nfe_reprocessada_item
		Set cd_produto = :ll_Produto
		Where de_chave_acesso	= :ls_de_chave_acesso
			and nr_item				= :ll_nr_item
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro =  "Erro ao atualizar o c$$HEX1$$f300$$ENDHEX$$digo do produto: "+  SqlCa.SQLErrText
			Return False
		End If	
	End If
Next

select count(*)
into	:ll_Qtde
from nfe_reprocessada_item
where	de_chave_acesso	= :ls_de_chave_acesso
	and	cd_produto is null
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro =  "Erro ao verificar se tem algum produto sem c$$HEX1$$f300$$ENDHEX$$digo: "+  SqlCa.SQLErrText
	Return False
End If

If ll_Qtde = 0 Then
	update nfe_reprocessada
	set	id_status = 'P',
		de_erro = null
	where de_chave_acesso = :ls_de_chave_acesso
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro =  "Erro ao alterar o status da nota para 'Processada': "+  SqlCa.SQLErrText
		Return False
	End If
	
	If SqlCa.SqlnRows <>1 Then
		as_Erro =  "Ao alterar o status da nota para 'Processada' deveria ter atualizado 1 registro, mas atualizou "+String(SqlCa.SqlnRows)+" registro(s). "
		Return False
	End If
End If

Return True
end function

public subroutine wf_habilita_menu (boolean ab_habilita);This.ivm_Menu.mf_Confirmar(ab_Habilita)
This.ivm_Menu.mf_Cancelar(ab_Habilita)
end subroutine

public function boolean wf_verifica_produtos_nf ();String ls_Chave_Acesso
String ls_Tipo_NF
String ls_Compl

Long lvl_Linha_DW2
Long lvl_Linha
Long lvl_Find
Long lvl_Produto

Try
	dc_uo_ds_base lvds_Prod_Divergencia
	lvds_Prod_Divergencia = Create dc_uo_ds_base 
	lvds_Prod_Divergencia.Of_ChangeDataObject('ds_ge488_itens_divergentes')
	
	lvl_Linha_DW2 = Tab_1.TabPage_1.dw_2.GetRow()
	
	ls_Chave_Acesso	= Tab_1.TabPage_1.dw_2.Object.de_chave_acesso		[lvl_Linha_DW2]
	ls_Tipo_NF			= Tab_1.TabPage_1.dw_2.Object.id_tipo_nf				[lvl_Linha_DW2]
	ls_Compl				= Tab_1.TabPage_1.dw_2.Object.id_nf_complementar	[lvl_Linha_DW2]
	
	//Se for nota complementar n$$HEX1$$e300$$ENDHEX$$o valida
	If ls_Compl = "S" then Return True
	
	lvds_Prod_Divergencia.Retrieve(ls_Chave_Acesso)
	For lvl_Linha = 1 To lvds_Prod_Divergencia.RowCount()
		lvl_Produto 	= lvds_Prod_Divergencia.Object.cd_produto [lvl_Linha]
		
		lvl_Find		= Tab_1.TabPage_2.dw_3.Find("cd_produto = "+String(lvl_Produto), 1,  Tab_1.TabPage_2.dw_3.RowCount())
		
		If lvl_Find > 0 Then Tab_1.TabPage_2.dw_3.Object.id_divergencia [lvl_Find] = "S"
	Next	
		
Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_Erro.GetMessage())
	Return False
	
Finally
	If IsValid(lvds_Prod_Divergencia) Then Destroy(lvds_Prod_Divergencia)
End Try

Return True
end function

public function boolean wf_marca_nfe_reprocessar (string ps_chave_acesso);delete from nfe_reprocessada_item
where de_chave_acesso = :ps_chave_acesso
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Rollback()
	SQLCa.Of_Msgdberror( "Exclus$$HEX1$$e300$$ENDHEX$$o itens (nfe_reprocessada_item)." )
	Return False
End If

delete from nfe_reprocessada_duplicata
where de_chave_acesso = :ps_chave_acesso
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Rollback()
	SQLCa.Of_Msgdberror( "Exclus$$HEX1$$e300$$ENDHEX$$o itens (nfe_reprocessada_duplicata)." )
	Return False
End If

update nfe_reprocessada
set id_status = 'R', dh_requisicao = getdate(), de_erro = null
where de_chave_acesso = :ps_chave_acesso
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Rollback()
	SQLCa.Of_Msgdberror( "Atualiza$$HEX2$$e700e300$$ENDHEX$$o status (nfe_reprocessada)." )
	Return False
End If

SQLCa.Of_Commit()

Return True
end function

public function integer wf_processa_xml (string ps_arquivo);String lvs_Nome,&
	   	lvs_Nulo, &
		lvs_Mensagem, &
		lvs_XML, &
		lvs_Chave_Acesso, &
		lvs_Data_Emissao, &
		lvs_CNPJ, &
		lvs_Status, &
		lvs_Mensagem_Erro, &
		lvs_id_nf_complementar, &
		lvs_FinNFe, &
		lvs_ChvRet, &
		lvs_Especie, &
		lvs_Serie

Long lvl_Linha, lvl_NF

Datetime lvdh_Emissao, lvdh_Movto

Integer lvi_Retorno
Integer lvi_Arquivo

uo_ge488_reprocessa_xml_drcst lvo_rep_XML

Try
	//Abre o arquivo
	lvi_Arquivo = FileOpen (ps_Arquivo  , TextMode! , Read!, Shared! )
	FileReadEx (lvi_Arquivo, lvs_Xml) 
	FileClose (lvi_Arquivo)
	If (Pos(lower(lvs_Xml), "<protnfe") > 0) and (Pos(lower(lvs_Xml), "<nfe") > 0) Then
		//Captura informa$$HEX2$$e700f500$$ENDHEX$$es
		lvs_Chave_Acesso			= gf_get_value_tag(lvs_Xml,"chNFe", 1)
		lvs_CNPJ						= gf_get_value_tag(lvs_Xml, "CNPJ", 1)
		lvs_FinNFe					= gf_get_value_tag(lvs_Xml, "finNFe", 1)
		lvs_Serie						= gf_get_value_tag(lvs_Xml, "serie", 1)
		lvl_NF							= long(gf_get_value_tag(lvs_Xml, "nNF", 1))
		lvs_Especie					= 'NFE'
		lvs_id_nf_complementar	= IIF(lvs_FinNFe="2", 'S', 'N')
		lvs_ChvRet					= gf_get_value_tag(lvs_Xml, "refNFe", 1)
		lvs_Data_Emissao			= Mid(gf_get_value_tag(lvs_Xml, "dhEmi", 1), 1, 10)
		If IsNull(lvs_Data_Emissao) or lvs_Data_Emissao="" Then lvs_Data_Emissao = Mid(gf_get_value_tag(lvs_Xml, "dEmi", 1), 1, 10)
		lvdh_Emissao = Datetime(lvs_Data_Emissao)
		lvs_Data_Emissao = gf_retorna_so_numeros(lvs_Data_Emissao)
		
		If lvs_id_nf_complementar = "S" Then
			Open(w_ge488_data_entrada)
			
			lvdh_Movto = Datetime(Message.StringParm)
			If IsNull(lvdh_Movto) then Return -1
		End If
		
		//Envia o XML ao FTP
		If ivo_xml_imp.io_Ftp.of_Conecta_ftp("FI", ivo_xml_imp.is_ftp_xml_endereco, ivo_xml_imp.is_ftp_xml_usuario, ivo_xml_imp.is_ftp_xml_senha, Ref lvs_Mensagem_Erro) Then
			If ivo_xml_imp.of_envia_ftp_clamed( ps_Arquivo, lvs_Data_Emissao, lvs_CNPJ, lvs_Chave_Acesso, 'NFE') Then
				//Cria o objeto
				If Not IsValid(lvo_rep_XML) Then lvo_rep_XML = Create uo_ge488_reprocessa_xml_drcst
				//Verifica se j$$HEX1$$e100$$ENDHEX$$ existe requisi$$HEX2$$e700e300$$ENDHEX$$o de reprocessamento
				select id_status
				Into :lvs_Status
				From nfe_reprocessada
				Where de_chave_acesso = :lvs_Chave_Acesso
				Using SQLCa;
				
				Choose Case SQLCa.SQLCode
					Case -1
						SQLCa.Of_Msgdberror( "Verificar nota reprocessamento." )
						Return -1		
						
					Case 100
						If lvs_id_nf_complementar = 'N' or IsNull(lvs_id_nf_complementar) Then 
							SetNull(lvs_ChvRet)
							SetNull(lvdh_Emissao)
							SetNull(lvl_NF)
							SetNull(lvs_Serie)
							SetNull(lvs_Especie)
						End If
						
						insert into nfe_reprocessada(de_chave_acesso, id_status, dh_requisicao, id_nf_complementar, de_chave_acesso_ref, dh_emissao, nr_nf, de_serie, de_especie, dh_movimento) 
						values(:lvs_Chave_Acesso, 'R', getdate(), :lvs_id_nf_complementar, :lvs_ChvRet, :lvdh_Emissao, :lvl_NF, :lvs_Serie, :lvs_Especie, :lvdh_Movto)
						Using SQLCa;
						
						If SQLCa.SQLCode = -1 Then
							SQLCa.Of_Msgdberror( "Inserir nota para reprocessamento." )
							Return -1
						End If
					
					Case 0
						//Erro
						If lvs_Status = "E" Then
							wf_marca_nfe_reprocessar(lvs_Chave_Acesso)
						//Sucesso
						ElseIf lvs_Status = "S" Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Esse XML j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ processado com sucesso no sistema!")
							Return 0
						End If
				End Choose
				
				//Solicita reprocessamento
				lvo_rep_XML.of_reprocessar_xml( lvs_Chave_Acesso , ps_Arquivo)
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel enviar o arquivo XML para o FTP da Clamed.", Exclamation!)
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar ao FTP da Clamed.", Exclamation!)
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O Arquivo selecionado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ um arquivo XML de NFe processada.", Exclamation!)
		Return -1
	End If
	
Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_erro.GetMessage(), StopSign!)
	Return -1
	
Finally
	If IsValid(lvo_rep_XML) Then Destroy(lvo_rep_XML)
End Try
end function

on w_ge488_monitor_nfe_reprocessar.create
int iCurrent
call super::create
end on

on w_ge488_monitor_nfe_reprocessar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Object.dh_inicio	[1]		= RelativeDate(Date(gf_GetServerDate()), -30)
Tab_1.TabPage_1.dw_1.Object.dh_termino	[1]		= Date(gf_GetServerDate())


end event

event ue_save;call super::ue_save;String	ls_Erro

If wf_Salvar(Ref ls_Erro) Then
	SqlCa.of_Commit()
	wf_Habilita_Menu(False)
	ivb_Valida_Salva = False
Else
	SqlCa.of_RollBack()
	MessageBox("Erro", ls_Erro)
End If

Return 1
end event

event ue_cancel;call super::ue_cancel;If Tab_1.TabPage_2.dw_3.Event ue_Recuperar() <> -1 Then
	wf_Habilita_Menu(False)
	This.ivb_Valida_Salva = False
End If
end event

event ue_preopen;call super::ue_preopen;MaxHeight = 9999
Maxwidth = 9999

ivo_Filial 			= Create uo_Filial
ivo_Fornecedor	= Create uo_Fornecedor
ivo_xml_imp		= Create uo_ge238_importa_xml
ivo_xml_imp.of_parametro_conexao_ftp()
end event

event resize;call super::resize;Tab_1.Height = NewHeight - 20
Tab_1.Width = NewWidth - 30

//Altura
Tab_1.Tabpage_1.gb_2.Height	= NewHeight - Tab_1.Tabpage_1.gb_2.Y - Tab_1.Tabpage_1.gb_4.Height - 160
Tab_1.Tabpage_1.dw_2.Height	= Tab_1.Tabpage_1.gb_2.Height - 120

Tab_1.Tabpage_1.gb_4.Y 		= Tab_1.Tabpage_1.gb_2.Y + Tab_1.Tabpage_1.gb_2.Height + 10
Tab_1.Tabpage_1.mle_erro.Y 	= Tab_1.Tabpage_1.gb_4.Y + 65

Tab_1.Tabpage_2.gb_3.Height	= NewHeight - Tab_1.Tabpage_2.gb_3.Y - 160
Tab_1.Tabpage_2.dw_3.Height	= Tab_1.Tabpage_2.gb_3.Height - 120

//largura
Tab_1.Tabpage_1.gb_2.Width		= Tab_1.Width - 80
Tab_1.Tabpage_1.dw_2.Width		= Tab_1.Width - 160
Tab_1.Tabpage_1.gb_4.Width 		= Tab_1.Width - 80
Tab_1.Tabpage_1.mle_erro.Width	= Tab_1.Width - 160
Tab_1.Tabpage_2.gb_3.Width		= Tab_1.Width - 80
Tab_1.Tabpage_2.dw_3.Width		= Tab_1.Width - 160
end event

event close;call super::close;If IsValid(ivo_Filial) Then Destroy(ivo_Filial)
If IsValid(ivo_Fornecedor) Then Destroy(ivo_Fornecedor)
If IsValid(ivo_xml_imp) Then Destroy(ivo_xml_imp)
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge488_monitor_nfe_reprocessar
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge488_monitor_nfe_reprocessar
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge488_monitor_nfe_reprocessar
integer y = 4
integer width = 5038
integer height = 2064
end type

event tab_1::selectionchanged;//OverRide

If newIndex = 1 Then
	Parent.ivm_Menu.mf_recuperar(True)
	
	If oldIndex <> 1 Then
		Tab_1.TabPage_1.dw_2.SetFocus()	
	End If
	
	If oldIndex = 2 Then
		Tab_1.TabPage_1.dw_1.SetFocus()	
	End If
Else
	Parent.ivm_Menu.mf_recuperar(False)
End If
end event

event tab_1::selectionchanging;call super::selectionchanging;If (OldIndex = 2) And (NewIndex = 1) Then
	If ivb_Valida_Salva = True Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "H$$HEX1$$e100$$ENDHEX$$ informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas.")
		Return 1
	End If
End If
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 5001
integer height = 1948
gb_4 gb_4
mle_erro mle_erro
cb_reprocessar cb_reprocessar
cb_reproc_local cb_reproc_local
cb_reproc_xml cb_reproc_xml
cb_inutilizada cb_inutilizada
end type

on tabpage_1.create
this.gb_4=create gb_4
this.mle_erro=create mle_erro
this.cb_reprocessar=create cb_reprocessar
this.cb_reproc_local=create cb_reproc_local
this.cb_reproc_xml=create cb_reproc_xml
this.cb_inutilizada=create cb_inutilizada
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.mle_erro
this.Control[iCurrent+3]=this.cb_reprocessar
this.Control[iCurrent+4]=this.cb_reproc_local
this.Control[iCurrent+5]=this.cb_reproc_xml
this.Control[iCurrent+6]=this.cb_inutilizada
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.mle_erro)
destroy(this.cb_reprocessar)
destroy(this.cb_reproc_local)
destroy(this.cb_reproc_xml)
destroy(this.cb_inutilizada)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 556
integer width = 4960
integer height = 996
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3584
integer height = 432
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 55
integer y = 96
integer width = 3543
integer height = 340
string dataobject = "dw_ge488_filtro"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case Dwo.Name		
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_filial.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_filial.of_Inicializa()
			
			This.Object.cd_filial	[ Row ] = ivo_filial.cd_filial
			This.Object.nm_filial	[ Row ] = ivo_filial.nm_fantasia
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.cd_fornecedor	[ Row ] = ivo_Fornecedor.cd_fornecedor
			This.Object.nm_fornecedor	[ Row ] = ivo_Fornecedor.nm_fantasia
		End If
End Choose
end event

event dw_1::editchanged;call super::editchanged;mle_erro.Text = ""
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName() 	
		
		Case "nm_filial"
			ivo_Filial.of_inicializa( )
			ivo_Filial.Of_Localiza_Filial( This.GetText(), "A")
			
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			
		Case "nm_fornecedor"
			ivo_Fornecedor.of_inicializa( )
			ivo_Fornecedor.Of_Localiza_fornecedor( This.GetText() )
			
			This.Object.nm_fornecedor	[1] = ivo_Fornecedor.nm_fantasia
			This.Object.cd_fornecedor	[1] = ivo_Fornecedor.cd_fornecedor
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.nm_filial [1] = ivo_filial.nm_fantasia
End If

If IsValid(ivo_Fornecedor) Then
	This.Object.nm_fornecedor [1] = ivo_Fornecedor.nm_fantasia
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
event ue_atualiza_botoes ( )
integer y = 628
integer width = 4878
integer height = 884
string dataobject = "dw_ge488_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_atualiza_botoes();cb_reprocessar.Enabled = (This.Find('id_selecao ="S" and id_status<>"R" ', 1, This.RowCount()) > 0)
cb_reproc_local.Enabled = (This.Find('id_selecao ="S" and id_status<>"R" ', 1, This.RowCount()) > 0)
cb_inutilizada.Enabled = (This.Find('id_selecao ="S"', 1, This.RowCount()) > 0)
end event

event dw_2::ue_recuperar;//OverRide
DateTime	ldh_Inicio,&
				ldh_Termino

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.dh_inicio		[1]
ldh_Termino	= dw_1.Object.dh_termino	[1]

ldh_Termino	= DateTime(String(ldh_Termino, "dd/mm/yyyy")+" 23:59:59")

Return This.Retrieve(ldh_Inicio, ldh_Termino)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	mle_Erro.Text	= This.Object.de_erro	[CurrentRow]	
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.Of_Salvarcomo( pl_Linhas > 0 )
This.ivo_controle_menu.Of_Filtrar( pl_Linhas > 0 )
This.ivo_controle_menu.Of_Classificar( pl_Linhas > 0 )
This.ivo_controle_menu.Of_Localizar( pl_Linhas > 0 )

This.Post Event ue_Atualiza_Botoes()

ivb_Check = False

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivo_controle_menu.Of_Salvarcomo( False )
This.ivo_controle_menu.Of_Filtrar( False )
This.ivo_controle_menu.Of_Classificar( False )
This.ivo_controle_menu.Of_Localizar( False )

mle_erro.Text = ""

This.Post Event ue_Atualiza_Botoes()
end event

event dw_2::getfocus;call super::getfocus;This.Of_SetSort( )
This.Of_SetFilter( )
end event

event dw_2::itemchanged;call super::itemchanged;This.Post Event ue_Atualiza_Botoes()
end event

event dw_2::doubleclicked;call super::doubleclicked;Long lvl_Row

String lvs_Marcacao
String lvs_Status

If Dwo.Name = 'id_selecao_t' Then	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	This.SetRedraw(False)
	For lvl_Row = 1 To This.RowCount()
		lvs_Status = This.Object.id_status [lvl_Row]
		
		If lvs_Status = 'E' Then
			This.Object.id_selecao [lvl_Row] = lvs_Marcacao
		End If
	Next
	This.SetRedraw(True)
End If

This.Post Event ue_atualiza_botoes( )
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Chave_Acesso
String lvs_Tipo_NF
String lvs_Fornecedor
String lvs_Serie
String lvs_Especie
String lvs_Situacao

Long lvl_Filial
Long lvl_Nr_NF

DateTime	lvdh_Inicio,&
				lvdh_Termino

mle_erro.Text = ""

dw_1.AcceptText()

lvdh_Inicio			= dw_1.Object.dh_inicio				[1]
lvdh_Termino		= dw_1.Object.dh_termino			[1]
lvs_Situacao			= dw_1.Object.id_situacao			[1]
lvs_Tipo_NF			= dw_1.Object.id_tipo_nf			[1]
lvs_Fornecedor		= dw_1.Object.cd_fornecedor		[1]
lvs_Chave_Acesso	= dw_1.Object.de_chave_acesso	[1]
lvl_Filial				= dw_1.Object.cd_filial				[1]
lvl_Nr_NF			= dw_1.Object.nr_nf					[1]
lvs_Especie			= dw_1.Object.de_especie			[1]
lvs_Serie				= dw_1.Object.de_serie				[1]

If IsNull(lvdh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(lvdh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If lvdh_Termino <  lvdh_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A date de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If lvs_Situacao <> "T" Then
	This.of_appendwhere( "a.id_status = '"+lvs_Situacao+"'")
End If

If lvs_Tipo_NF <> "" Then
	This.of_appendwhere( "a.id_tipo_nf = '"+lvs_Tipo_NF+"'")
End If

If lvs_Fornecedor <> "" Then
	This.of_appendwhere( "a.cd_fornecedor = '"+lvs_Fornecedor+"'")
End If

If lvs_Chave_Acesso <> "" Then
	This.of_appendwhere( "a.de_chave_acesso = '"+lvs_Chave_Acesso+"'")
End If

If lvl_Filial > 0 Then
	This.of_appendwhere( "a.cd_filial = "+String(lvl_Filial))
End If

If lvl_Nr_NF > 0 Then
	This.of_appendwhere( "a.nr_nf = "+String(lvl_Nr_NF))
End If

If lvs_Especie <> "" Then
	This.of_appendwhere( "a.de_especie = '"+lvs_Especie+"'")
End If

If lvs_Serie <> "" Then
	This.of_appendwhere( "a.de_serie = '"+lvs_Serie+"'")
End If

Return AncestorReturnValue
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 5001
integer height = 1948
string text = "Produtos"
cbx_1 cbx_1
end type

on tabpage_2.create
this.cbx_1=create cbx_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cbx_1)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer y = 112
integer width = 4965
integer height = 1824
string text = "Produtos"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer y = 176
integer width = 4882
integer height = 1728
string dataobject = "dw_ge488_lista_detalhes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::ue_recuperar;//OverRide

String	ls_Chave_Acesso

ls_Chave_Acesso	= Tab_1.TabPage_1.dw_2.Object.de_chave_acesso	[Tab_1.TabPage_1.dw_2.GetRow()]

Return	Tab_1.TabPage_2.dw_3.Retrieve(ls_Chave_Acesso)

end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection('if(id_divergencia="S", if(getrow() = currentrow(), rgb(174, 174, 0), rgb(255, 255, 128)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255,255,255)))', "", false)
end event

event dw_3::doubleclicked;call super::doubleclicked;String	ls_Chave_Acesso,&
		ls_De_Produto

Long	ll_Item,&
		ll_Produto,&
		ll_Retorno

If This.RowCount() > 0 Then
	
	This.AcceptText()
	
	ls_Chave_Acesso 	=	This.Object.de_chave_acesso	[This.GetRow()]
	ll_Item				=	This.Object.nr_item				[This.GetRow()]
	ll_Produto			=	This.Object.cd_produto			[This.GetRow()]
	ls_De_Produto		=	This.Object.de_produto			[This.GetRow()]
	
	
	If Not IsNull(ll_Produto) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Aten$$HEX2$$e700e300$$ENDHEX$$o! Esse produto j$$HEX1$$e100$$ENDHEX$$ possui c$$HEX1$$f300$$ENDHEX$$digo.~rDeseja alter$$HEX1$$e100$$ENDHEX$$-lo?", Question!, YesNo!, 2) = 2 Then
			Return -1
		End If
	End If
	
	OpenWithParm(w_ge488_localizar_produto, ls_Chave_Acesso+";"+ls_De_Produto)
	
	ll_Retorno	= Message.DoubleParm
	
	If ll_Retorno <> -1 Then
		This.Object.cd_produto[This.GetRow()]	= 	ll_Retorno
		
		wf_Habilita_Menu(True)
		ivb_Valida_Salva = True
	End If
	
	Post wf_verifica_produtos_nf( )
End If
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.Of_Salvarcomo( pl_Linhas > 0 )
This.ivo_controle_menu.Of_Filtrar( pl_Linhas > 0 )
This.ivo_controle_menu.Of_Classificar( pl_Linhas > 0 )
This.ivo_controle_menu.Of_Localizar( pl_Linhas > 0 )

wf_verifica_produtos_nf()

Return AncestorReturnValue
end event

event dw_3::getfocus;call super::getfocus;This.Of_SetSort( )
This.Of_SetFilter( )
end event

type gb_4 from groupbox within tabpage_1
integer x = 23
integer y = 1576
integer width = 4960
integer height = 356
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Erro"
borderstyle borderstyle = styleraised!
end type

type mle_erro from multilineedit within tabpage_1
integer x = 59
integer y = 1632
integer width = 4887
integer height = 260
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 134217857
long backcolor = 16777215
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
end type

type cb_reprocessar from commandbutton within tabpage_1
integer x = 41
integer y = 460
integer width = 622
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Reprocessar"
end type

event clicked;String lvs_Chave_Acesso

Long lvl_Linha
Long lvl_Count = 0

lvl_Linha = Parent.dw_2.GetRow()

Try
	Parent.dw_2.SetRedraw(False)
	Parent.dw_2.SetFilter("id_selecao = 'S'")
	Parent.dw_2.Filter()
	
	If Parent.dw_2.RowCount() > 0 Then
		For lvl_Linha = 1 To Parent.dw_2.RowCount()
			lvs_Chave_Acesso = Parent.dw_2.Object.de_chave_acesso [lvl_Linha]
			
			wf_marca_nfe_reprocessar(lvs_Chave_Acesso)
			
			lvl_Count++
			
			Parent.dw_2.Object.id_selecao [lvl_Linha] = 'N'
		Next
		
		MessageBox("Sucesso", "Foi(ram) marcado(s) para reprocessar "+String(lvl_Count)+" registro(s).")
		Parent.dw_2.Post Event ue_Retrieve()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um registro para reprocessar.")
	End If
	
Catch (RuntimeError lvo_Erro)
	
Finally
	Parent.dw_2.SetFilter("")
	Parent.dw_2.Filter()
	Parent.dw_2.SetRedraw(True)
End Try
end event

type cb_reproc_local from commandbutton within tabpage_1
integer x = 672
integer y = 460
integer width = 649
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Reproc. Imediato"
end type

event clicked;String lvs_Chave_Acesso

Long lvl_Linha
Long lvl_Count = 0

lvl_Linha = Parent.dw_2.GetRow()
uo_ge488_reprocessa_xml_drcst lvo_rep_XML

Try
	lvo_rep_XML = Create uo_ge488_reprocessa_xml_drcst
	
	Parent.dw_2.SetRedraw(False)
	Parent.dw_2.SetFilter("id_selecao = 'S'")
	Parent.dw_2.Filter()
	
	If Parent.dw_2.RowCount() > 0 Then
		For lvl_Linha = 1 To Parent.dw_2.RowCount()
			lvs_Chave_Acesso = Parent.dw_2.Object.de_chave_acesso [lvl_Linha]
			
			If wf_marca_nfe_reprocessar(lvs_Chave_Acesso) Then
				lvo_rep_XML.of_reprocessar_xml( lvs_Chave_Acesso )
				Parent.dw_2.Object.id_selecao [lvl_Linha] = 'N'
				lvl_Count++
			End If
		Next
		
		MessageBox("Sucesso", "Foi(ram) reprocessado(s) "+String(lvl_Count)+" NFe(s).")
		Parent.dw_2.Post Event ue_Retrieve()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um registro para reprocessar.")
	End If
	
Catch (RuntimeError lvo_Erro)
	
Finally
	Parent.dw_2.SetFilter("")
	Parent.dw_2.Filter()
	Parent.dw_2.SetRedraw(True)
	
	If IsValid(lvo_rep_XML) Then Destroy(lvo_rep_XML)
End Try
end event

type cb_reproc_xml from commandbutton within tabpage_1
integer x = 1961
integer y = 460
integer width = 613
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Processar XML"
end type

event clicked;String lvs_Arquivo,&
	   	lvs_Nome

Integer lvi_Retorno
Integer lvi_Arquivo

Try
	lvi_Retorno = GetFileOpenName("Selecione o arquivo XML", lvs_Arquivo, lvs_Nome, "XML", "Arquivo XML (*.XML),*.XML")
	
	If lvi_Retorno = 1 Then 
		wf_processa_xml(lvs_Arquivo)
	End If
	
Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_erro.GetMessage(), StopSign!)
	Return -1
	
Finally
	//
End Try
end event

type cb_inutilizada from commandbutton within tabpage_1
integer x = 1330
integer y = 460
integer width = 622
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Marcar Inutilizada"
end type

event clicked;String lvs_Chave_Acesso
String lvs_Msg_Erro

Long lvl_Linha
Long lvl_Count = 0

lvl_Linha = Parent.dw_2.GetRow()

Try
	Parent.dw_2.SetRedraw(False)
	Parent.dw_2.SetFilter("id_selecao = 'S'")
	Parent.dw_2.Filter()
	
	If Parent.dw_2.RowCount() > 0 Then
		If Not gvo_Aplicacao.ivo_Seguranca.of_libera_acesso_procedimento("GE488_MARCA_NFE_INUTILIZADA") Then
			MessageBox("Seguran$$HEX1$$e700$$ENDHEX$$a do Sistema", "Procedimento n$$HEX1$$e300$$ENDHEX$$o liberado para este usu$$HEX1$$e100$$ENDHEX$$rio.", Exclamation!, Ok!)
			Return -1
		End If
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A(s) nota(s) somente deve(m) ser marcada(s) para inutilizar "+&
			"se sua chave de acesso for inexistente no SEFAZ, e o fornecedor n$$HEX1$$e300$$ENDHEX$$o tiver a chave correta.~r~r"+ &
			"Deseja continuar e marcar como inutilizado a(s) nota(s) selecionada(s)?", Exclamation!, YesNo!, 2) = 1 Then
			
			lvs_Msg_Erro = "NFe marcada como inutilizada por " + gvo_aplicacao.ivo_seguranca.nm_usuario + " (" + gvo_aplicacao.ivo_seguranca.nr_matricula + ") em " + String(Today(), "DD/MM/YYYY HH:MM:SS")+"."
			
			For lvl_Linha = 1 To Parent.dw_2.RowCount()
				lvs_Chave_Acesso = Parent.dw_2.Object.de_chave_acesso [lvl_Linha]
				
				If Parent.dw_2.Object.id_status [lvl_Linha] <> "E" Then	
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota "+lvs_Chave_Acesso+" est$$HEX1$$e100$$ENDHEX$$ com o status de processada com sucesso.~r~rDeseja realmente inutiz$$HEX1$$e100$$ENDHEX$$-la?", Exclamation!, YesNo!, 2) = 2 Then Continue
				End If
				
				update nfe_reprocessada
				set id_status = "X",
					de_erro = :lvs_Msg_Erro
				Where de_chave_acesso = :lvs_Chave_Acesso
				Using SQLCa;
				
				If SQLCa.SQLCode = -1 Then
					SQLCa.Of_Rollback()
					SQLCa.Of_MsgDbError( "Atualizar NFe para inutilizada." )
					Return -1
				End If
				
				delete from nota_origem_retencao_st
				Where de_chave_acesso = :lvs_Chave_Acesso
				Using SQLCa;
				
				If SQLCa.SQLCode = -1 Then
					SQLCa.Of_Rollback()
					SQLCa.Of_MsgDbError( "Excluir NFe da tabela nota_origem_retencao_st." )
					Return -1
				End If
				
				SQLCa.Of_Commit()
				
				lvl_Count++
				
				Parent.dw_2.Object.id_selecao [lvl_Linha] = 'N'
			Next
			
			MessageBox("Sucesso", "Foi(ram) marcado(s) para inutilizar "+String(lvl_Count)+" registro(s).")
			Parent.dw_2.Post Event ue_Retrieve()
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um registro para inutilizar.")
	End If
	
Catch (RuntimeError lvo_Erro)
	
Finally
	Parent.dw_2.SetFilter("")
	Parent.dw_2.Filter()
	Parent.dw_2.SetRedraw(True)
End Try
end event

type cbx_1 from checkbox within tabpage_2
integer x = 32
integer y = 32
integer width = 1285
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Mostrar apenas os produtos com diverg$$HEX1$$ea00$$ENDHEX$$ncias"
end type

event clicked;Tab_1.TabPage_2.dw_3.SetRedraw(false)

If This.Checked Then
	Tab_1.TabPage_2.dw_3.SetFilter("isnull(cd_produto)")	
	Tab_1.TabPage_2.dw_3.Filter()
Else
	Tab_1.TabPage_2.dw_3.SetFilter("")
	Tab_1.TabPage_2.dw_3.Filter()	
End If

Tab_1.TabPage_2.dw_3.Sort()
Tab_1.TabPage_2.dw_3.SetRedraw(true)
end event

