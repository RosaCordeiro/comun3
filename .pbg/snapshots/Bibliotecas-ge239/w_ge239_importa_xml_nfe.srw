HA$PBExportHeader$w_ge239_importa_xml_nfe.srw
forward
global type w_ge239_importa_xml_nfe from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge239_importa_xml_nfe
end type
type cb_1 from commandbutton within w_ge239_importa_xml_nfe
end type
type gb_3 from groupbox within w_ge239_importa_xml_nfe
end type
end forward

global type w_ge239_importa_xml_nfe from dc_w_selecao_lista_relatorio
integer width = 3415
integer height = 1904
dw_4 dw_4
cb_1 cb_1
gb_3 gb_3
end type
global w_ge239_importa_xml_nfe w_ge239_importa_xml_nfe

forward prototypes
public function boolean wf_cabecalho_nota (t_infnfe a_infnfe, boolean ab_verifica_diverg)
public function boolean wf_dados_itens (t_infnfe a_infnfe, boolean ab_verifica_diverg)
end prototypes

public function boolean wf_cabecalho_nota (t_infnfe a_infnfe, boolean ab_verifica_diverg);Long 	ll_Pedido,&
        	ll_Qt_Pedido,&
		ll_Linhas	  

dc_uo_ds_base lvds

String ls_Cnpj
  
dw_2.Object.cd_unidade_federacao[1]	=	a_infnfe.ide.cuf  
dw_2.Object.id_natureza_operacao[1]	=	a_infnfe.ide.natOp	  
dw_2.Object.de_especie[1]					=	"NFE" 
dw_2.Object.de_serie[1]						=	a_infnfe.ide.serie  
dw_2.Object.nr_nf[1]							=	a_infnfe.ide.nNF  
dw_2.Object.dh_emissao[1]					=	a_infnfe.ide.dEmi

ls_Cnpj = a_infnfe.emit.CNPJ

//emit**********************************************************************
dw_1.AcceptText()

ll_Pedido = dw_1.Object.nr_pedido[1]	

If not IsNull(ll_Pedido) Then

	Select count(*) 
	Into :ll_Qt_Pedido
	From pedido_central 
	Where nr_pedido = :ll_Pedido
	
	Using SqlCa;
	
	If SqlCa.SqlCode = 0 Then	
		If ll_Qt_Pedido < 1 Then
			MessageBox("Aviso", "Pedido n$$HEX1$$e300$$ENDHEX$$o cadastrado. Confira se digitou corretamente o n$$HEX1$$fa00$$ENDHEX$$mero do pedido.")
			dw_1.Event ue_Pos(1, "nr_pedido")	
			Return False
		End If	
	Else
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade de pedido.")
		Return False
	End If	
End If	
  
 
lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge239_fornecedor") Then
	Destroy(lvds)
	Return False
End If

If IsNull(ll_Pedido) Then	
	lvds.Object.Datawindow.Table.Select = 	"select  f.cd_fornecedor, f.nm_razao_social, f.cd_condicao_pagamento, c.de_condicao, f.nr_cgc  "+&
														"from fornecedor f, condicao_pagamento c "+&
														"where f.cd_condicao_pagamento = c.cd_condicao "+&
														"and f.nr_cgc= '"+ls_Cnpj+"' " +&
														"and (f.id_situacao ='A' or f.id_situacao is null)"														
Else
	lvds.Object.Datawindow.Table.Select = 	"select fo.cd_fornecedor, fo.nm_razao_social, fo.nr_cgc, pe.cd_condicao_pagamento, c.de_condicao "+&
														"from pedido_central pe, fornecedor fo, condicao_pagamento c  "+&
														"where pe.cd_fornecedor = fo.cd_fornecedor "+&
														"and fo.cd_condicao_pagamento = c.cd_condicao  "+&
														"and nr_pedido = "+String(ll_Pedido)
End If

lvds.Retrieve()
ll_Linhas = lvds.RowCount()

If (ll_Linhas = 1) or (ls_Cnpj = '84704683000158') Then  //84704683000158 $$HEX1$$e900$$ENDHEX$$ o cnpj da Quimidrol
	dw_2.Object.cd_fornecedor[1]  				=  lvds.Object.cd_fornecedor[1] 
	dw_2.Object.nm_fornecedor[1] 				=  lvds.Object.nm_razao_social[1] 
	dw_2.Object.cd_condicao_pagamento[1] 	=  lvds.Object.cd_condicao_pagamento[1] 
	dw_2.Object.de_condicao[1]					=  lvds.Object.de_condicao[1] 
	If lvds.Object.nr_cgc[1] <>ls_Cnpj Then
		//if aVerificaDiverg then
		//	divergencia.pGravaDivergenciaNota('2', edPedido.Text, edChave.Text,'Fornecedor com CNPJ diferente do pedido. CNPJ pedido: '+qrOutros.FieldByName('nr_cgc').asString+ ' CNPJ Nota: ' + ainfNfe.emit.CNPJ);

   		MessageBox("Aviso", "Chave de acesso e Pedido n$$HEX1$$e300$$ENDHEX$$o conferem. Ou~r"+&
                          		"Fornecedor com CNPJ diferente do pedido! Nesse caso Informe o setor de Compras.~r"+&
                          		"CNPJ pedido: "+String(dw_2.Object.nr_cgc[1])+ " CNPJ emitido: " + String(ls_Cnpj))
	End If
Else
	//if aVerificaDiverg then
	//	divergencia.pGravaDivergenciaNota('2', edPedido.Text, edChave.Text, 'Fornecedor '+edNmFornecedor.Text+' com CNPJ n$$HEX1$$e300$$ENDHEX$$o cadastrado');
//            
	MessageBox("Aviso", "Fornecedor com CNPJ n$$HEX1$$e300$$ENDHEX$$o cadastrado!~rInforme o setor de COMPRAS.")
	Return False
End If
Destroy(lvds)

 //<dest>'*******************************************************************
 
 lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge239_filial") Then
	Destroy(lvds)
	Return False
End If

lvds.Retrieve(ls_Cnpj)
ll_Linhas = lvds.RowCount()

If (ll_Linhas = 1) or (ls_Cnpj ='84683481000177') Then
	dw_2.Object.cd_filial[1]  				=  lvds.Object.cd_filial[1] 
	dw_2.Object.nm_fantasia_filial[1]  	=  lvds.Object.nm_fantasia[1] 
	dw_2.Object.id_email[1]  				=  a_infNfe.dest.email
Else
	MessageBox("Aviso", "Filial com CNPJ n$$HEX1$$e300$$ENDHEX$$o cadastrado!~rVerifique se esta nota pertence a CLAMED.")
	Destroy(lvds)
	Return False
End If
Destroy(lvds)

//'<ICMSTot>'***********************************************************
dw_2.Object.vl_bc_icms[1] 				=  a_infNfe.total.ICMSTot.vBC
dw_2.Object.vl_icms[1] 					=  a_infNfe.total.ICMSTot.vICMS
dw_2.Object.vl_bc_icms_st[1] 			=  a_infNfe.total.ICMSTot.vBCST
dw_2.Object.vl_icms_st[1] 				=  a_infNfe.total.ICMSTot.vST
dw_2.Object.vl_total_produtos[1] 		=  a_infNfe.total.ICMSTot.vProd
dw_2.Object.vl_frete[1] 					=  a_infNfe.total.ICMSTot.vFrete
dw_2.Object.vl_seguro[1] 				=  a_infNfe.total.ICMSTot.vSeg
dw_2.Object.vl_desconto[1] 			=  a_infNfe.total.ICMSTot.vDesc
dw_2.Object.vl_ipi[1] 					=  a_infNfe.total.ICMSTot.vIPI
dw_2.Object.vl_outras_despesas[1] 	=  a_infNfe.total.ICMSTot.vOutro
dw_2.Object.vl_total_nf[1] 				=  a_infNfe.total.ICMSTot.vNF

Return True
end function

public function boolean wf_dados_itens (t_infnfe a_infnfe, boolean ab_verifica_diverg);Long ll_Qt_Itens, i

ll_Qt_Itens = UpperBound(a_infnfe.det[])
	
For i = 1 to  ll_Qt_Itens
	
//	If a_infnfe.det[i].prod.cEAN <> "" Then
//            qrOutros.Close;
//            qrOutros.CommandText:=
//            'select cd_produto '+
//            //2.15 Alterado para buscar o c$$HEX1$$f300$$ENDHEX$$digo do produto da tabela codigo_barras_produto
//            //' from produto_geral '+
//            ' from codigo_barras_produto '+
//            ' where de_codigo_barras like ''%'+ aNota.det[i].prod.cEAN +'''';
//
//            qrOutros.Open;
//
//            if qrOutros.fieldByName('cd_produto').AsString = '' then
//            begin
//                qrOutros.Close;
//                qrOutros.CommandText:=
//                'select * from produto_central pc, produto_geral pg'+
//                ' where pc.cd_produto_fornecedor = '''+aNota.det[i].prod.cProd+
//                ''' and pc.cd_produto = pg.cd_produto'+
//                ' and pg.cd_fornecedor_usual ='''+ edCdFornecedor.Text +'''' ;
//                qrOutros.Open;
//            end;
//
//
//            stGrid.Cells[00,i]:= qrOutros.fieldByName('cd_produto').AsString;
//            //2.04
//            if (Trim(qrOutros.fieldByName('cd_produto').AsString) = '') and aVerificaDiverg then
//              Divergencia.pDivergenciaProduto(aNota.det[i].prod.cEAN, aNota.det[i].prod.xProd, edPedido.Text, edChave.Text, 'Nao foi localizado o codigo do produto com EAN do XML', 6);
//        end
//        else
//        begin
//            stGrid.Cells[00,i]:= '';
//            //2.04 N$$HEX1$$e300$$ENDHEX$$o tem c$$HEX1$$f300$$ENDHEX$$digo barras no xml
//            if aVerificaDiverg then
//              Divergencia.pDivergenciaProduto('', aNota.det[i].prod.xProd, edPedido.Text, edChave.Text, 'Produto esta sem o codigo de barras no XML', 7);
//	End If
//		  	
	dw_4.Object.de_produto[i] 	= a_infnfe.det[i].prod.xprod
	dw_4.Object.item[i]         	= String(i)

Next	

Return True
end function

on w_ge239_importa_xml_nfe.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.cb_1=create cb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.gb_3
end on

on w_ge239_importa_xml_nfe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.gb_3)
end on

event ue_postopen;call super::ue_postopen;dw_2.Event ue_AddRow()
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge239_importa_xml_nfe
integer y = 356
integer width = 3319
integer height = 568
integer weight = 700
string facename = "Verdana"
string text = "Cabe$$HEX1$$e700$$ENDHEX$$alho"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge239_importa_xml_nfe
integer width = 2213
integer height = 324
integer weight = 700
string facename = "Verdana"
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge239_importa_xml_nfe
integer width = 2153
string dataobject = "dw_ge239_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge239_importa_xml_nfe
integer y = 412
integer width = 3264
integer height = 500
string dataobject = "dw_ge239_detalhes_cabecalho"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_2::constructor;//OverRider

String lvs_DataObject

This.of_SetTransObject(SqlCa)

lvs_DataObject = This.DataObject

If Trim(This.DataObject) <> "" Then
	ivs_SQL_Original = This.Object.DataWindow.Table.Select
End If

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()

end event

event dw_2::ue_recuperar;//OverRider

String ls_Xml
integer li_FileOpen

dc_uo_nfe lo_NFE

t_infnfe lt_InfNFe


li_FileOpen = FileOpen ("C:\35131102259684000176550030000098451230337004-nfe.xml", TextMode! , Read!, LockRead! )
FileReadEx (li_FileOpen, ls_Xml) 
FileClose (li_FileOpen)

If ls_Xml <> "" Then
	
	lo_NFE 	= Create dc_uo_nfe
	lo_NFE.of_read_xml(ls_Xml, True, Ref lt_InfNFe)

	wf_cabecalho_nota(lt_InfNFe, True)
	wf_dados_itens(lt_InfNFe, True)


	Destroy(lo_NFE)
	
End If

Return 1



end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge239_importa_xml_nfe
boolean visible = false
integer x = 2610
integer y = 0
integer width = 379
integer height = 140
end type

type dw_4 from dc_uo_dw_base within w_ge239_importa_xml_nfe
integer x = 78
integer y = 1004
integer width = 3241
integer height = 680
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge239_itens"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_1 from commandbutton within w_ge239_importa_xml_nfe
integer x = 2606
integer y = 96
integer width = 457
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Teste "
end type

event clicked;String ls_Xml, ls_Chave_Acesso, ls_Mensagem_Log
integer li_FileOpen
Long ll_Pedido, ll_Filial
Date ldt_Emissao

dc_uo_importa_nf_pedido_eletronico lo_NFE


//
//ll_Pedido = 3049
//ls_Chave_Acesso = "42131182873068000140550010088861661995436806"
//ll_Filial = 68
//ldt_Emissao = Date("11/11/2013")

ll_Pedido = 3049
ls_Chave_Acesso = "35131102259684000176550030000098451230337004"
ll_Filial = 68
ldt_Emissao = Date("27/09/2013")

lo_NFE = Create dc_uo_importa_nf_pedido_eletronico
If Not lo_NFE.of_Importa_Nf(ls_Chave_Acesso, ldt_Emissao, ll_Pedido, ll_Filial, "C:\zTeste_2\", Ref ls_Mensagem_Log) Then
	MessageBox("Erro", ls_Mensagem_Log)	
End If
Destroy(lo_NFE)


end event

type gb_3 from groupbox within w_ge239_importa_xml_nfe
integer x = 41
integer y = 944
integer width = 3314
integer height = 764
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Itens"
end type

