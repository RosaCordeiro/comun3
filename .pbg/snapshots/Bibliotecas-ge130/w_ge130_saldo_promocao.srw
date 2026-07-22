HA$PBExportHeader$w_ge130_saldo_promocao.srw
forward
global type w_ge130_saldo_promocao from dc_w_selecao_lista_relatorio
end type
type st_confirmar from statictext within w_ge130_saldo_promocao
end type
type cb_gera_planilha from commandbutton within w_ge130_saldo_promocao
end type
type dw_4 from dc_uo_dw_base within w_ge130_saldo_promocao
end type
type cb_faltas from commandbutton within w_ge130_saldo_promocao
end type
end forward

global type w_ge130_saldo_promocao from dc_w_selecao_lista_relatorio
string accessiblename = "Saldo de Produtos em Promo$$HEX2$$e700e300$$ENDHEX$$o (GE130)"
integer width = 2912
integer height = 1692
string title = "GE130 - Saldo de Produtos em Promo$$HEX2$$e700e300$$ENDHEX$$o"
st_confirmar st_confirmar
cb_gera_planilha cb_gera_planilha
dw_4 dw_4
cb_faltas cb_faltas
end type
global w_ge130_saldo_promocao w_ge130_saldo_promocao

type variables
boolean ivb_check

uo_promocao ivo_promocao

dc_uo_ds_base ids_venda
end variables

forward prototypes
public function long wf_tem_item_selecionado ()
public function long wf_qt_venda_mes (long al_filial, long al_produto, date adt_data)
public function long wf_localiza_estoque_minimo (long al_promocao, long al_filial, long al_produto)
public function long wf_localiza_saldo_pendente (long al_filial, long al_produto)
public subroutine wf_gera_planilha (string as_uf, string as_path)
public function boolean wf_movimentacao_produto (long al_filial, long al_produto, ref date adh_inclusao, ref date adh_ultima_entrada, ref date adh_ultima_venda)
public function boolean wf_carrega_venda (date adt_resumo, long al_filial, long al_produto, ref long al_qtd_venda)
end prototypes

public function long wf_tem_item_selecionado ();
Long 	ll_Row,&
         ll_Selecionado

ll_Selecionado = 0
For ll_Row = 1 To dw_2.RowCount()
	If dw_2.Object.id_selecao	[ll_Row] = "S" Then
		ll_Selecionado ++
	End If	
Next

Return ll_Selecionado
end function

public function long wf_qt_venda_mes (long al_filial, long al_produto, date adt_data);Long lvl_Qtde

select isnull(sum(qt_venda - qt_devolucao_venda) , 0)
into :lvl_Qtde
from resumo_produto_filial
where cd_produto = :al_produto
and dh_resumo = :adt_data
and cd_filial = :al_filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		MessageBox("Erro","Erro ao localizar a qtde vendida no mes "+String(adt_data, "mm/yyyy")+ SqlCa.SQLErrText)
		Return -1		
	Case 100
		Return 0
End Choose

Return lvl_Qtde
end function

public function long wf_localiza_estoque_minimo (long al_promocao, long al_filial, long al_produto);Long ll_Estoque_minimo =0

select qt_estoque_minimo
	into :ll_Estoque_minimo
	From promocao_sos_estoque_minimo
Where cd_promocao_sos = :al_promocao
	and cd_filial				= :al_filial
	and cd_produto			= :al_produto
 Using SqlCa;
 
Choose Case SqlCa.SqlCode	
	Case 0
	
	Case 100
		SetNull(ll_Estoque_minimo)
	Case -1
		SqlCa.of_msgdbError("Erro ao localizar o estoque minimo. (" + String(al_promocao) +  "-" + String(al_filial) + "-" + String(al_produto) + ")." + SqlCa.SqlErrText )
End Choose

Return ll_Estoque_minimo
end function

public function long wf_localiza_saldo_pendente (long al_filial, long al_produto);Long ll_Saldo =0

select sum(i.qt_faturada) as qt_faturada
	into :ll_Saldo
from nf_compra_pendente n
	 join nf_compra_pendente_produto i
	  on i.cd_filial 				= n.cd_filial
	and i.cd_fornecedor 	= n.cd_fornecedor
	and i.nr_nf 				= n.nr_nf
	and i.de_especie			= n.de_especie
	and i.de_serie			= n.de_serie
	and i.cd_produto			= :al_Produto
	and n.cd_filial				= :al_Filial
 Using SqlCa;
 
Choose Case SqlCa.SqlCode	
	Case 0
		If ll_Saldo = 0 Then SetNull( ll_Saldo )
	Case -1
		SqlCa.of_msgdbError("Erro ao localizar a qt_faturada da tb nf_compra_pendente_produto. (" + String(al_filial) + "-" + String(al_produto) + ")." + SqlCa.SqlErrText )
End Choose

Return ll_Saldo
end function

public subroutine wf_gera_planilha (string as_uf, string as_path);Long ll_QTde

Integer li_retorno

String ls_Arquivo, ls_Nome_Arquivo

SetPointer(HourGlass!)

ls_Nome_Arquivo = as_path + 'falta_produto_' + as_uf + '_' +  String(Day(Today()), '00') + '_' + String(Month(Today()), '00') + '_' + String(Year (Today()), '0000') + '.xls'

If FileExists(ls_Nome_Arquivo) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + ls_Nome_Arquivo + "' existente ?", Question!, YesNo!, 1) =  1 Then 
		If Not FileDelete(ls_Nome_Arquivo) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + ls_Nome_Arquivo + "'.", StopSign!)
			Return
		End If
	Else
		Return 
   End If   
End If

DataStore lds_1

lds_1     	= Create DataStore

dc_uo_transacao  SqlCa_Aux

SqlCa_Aux   = Create dc_uo_transacao

SqlCa_Aux = SqlCa;

SqlCa_Aux.AutoCommit = True

Connect Using SqlCa_Aux;

lds_1.DataObject = "ds_ge130_falta_planograma"
lds_1.SetTransObject(SqlCa)

ll_QTde = lds_1.Retrieve(as_uf)

If ll_QTde > 0 Then
	If lds_1.SaveAs(ls_Nome_Arquivo, Excel!, True) <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + ls_Nome_Arquivo + "'.", StopSign!)
	End If
Else
	If as_UF = 'XX' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada para a UF '" + as_UF + "'.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada para a REDE.")
	End If
End If 

Destroy lds_1

SetPointer(Arrow!)
end subroutine

public function boolean wf_movimentacao_produto (long al_filial, long al_produto, ref date adh_inclusao, ref date adh_ultima_entrada, ref date adh_ultima_venda);String ls_Erro

SetNull(adh_Inclusao)

//Inclus$$HEX1$$e300$$ENDHEX$$o GC / C$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o
Select Top 1 h.dh_alteracao
	Into: adh_Inclusao
From historico_promocao_estoque_min h
	Inner Join promocao_sos s
		On s.cd_promocao_sos = h.cd_promocao
Where h.cd_filial = :al_Filial
	And h.cd_produto = :al_Produto
	And s.id_tipo_promocao = 'P'
	And s.dh_inicio <= (Select dh_movimentacao From parametro Where id_parametro = '1')
	And (s.dh_termino >= (Select dh_movimentacao From parametro Where id_parametro = '1') Or s.dh_termino Is Null)
	And coalesce(h.qt_estoque_minimo_anterior, 0) <> coalesce(h.qt_estoque_minimo_atual, 0)
Order By h.dh_alteracao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0

	Case 100
		
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a data de inclus$$HEX1$$e300$$ENDHEX$$o do produto '" + String(al_Produto) + "' na filial '" + String(al_Filial) + "'. " + ls_Erro, StopSign!)
		Return False
End Choose

SetNull(adh_Ultima_Entrada)

//$$HEX1$$da00$$ENDHEX$$ltima Entrada
Select Max(dh_movimento)
	Into: adh_Ultima_Entrada
From movimento_estoque
Where cd_filial_movimento = :al_Filial
	And cd_produto = :al_Produto
	And dh_movimento >= '20110101'
	And cd_tipo_movimento In (3,5,8)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a $$HEX1$$fa00$$ENDHEX$$ltima entrada na filial '" + String(al_Filial) + "' do produto '" + String(al_Produto) + "'. " + ls_Erro, StopSign!)
	Return False
End If

SetNull(adh_Ultima_Venda)

//$$HEX1$$da00$$ENDHEX$$ltima Venda
Select Max(dh_movimento)
	Into: adh_Ultima_Venda
From movimento_estoque
Where cd_filial_movimento = :al_Filial
	And cd_produto = :al_Produto
	And dh_movimento >= '20110101'
	And cd_tipo_movimento In (1)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a $$HEX1$$fa00$$ENDHEX$$ltima venda na filial '" + String(al_Filial) + "' do produto '" + String(al_Produto) + "'. " + ls_Erro, StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_carrega_venda (date adt_resumo, long al_filial, long al_produto, ref long al_qtd_venda);Long ll_Find

ll_Find = ids_Venda.Find("cd_filial = " + String(al_Filial) + " and cd_produto = " + String(al_Produto) + " and dh_resumo = Date('" + String(adt_Resumo, "yyyy/mm/dd") + "')" , 1, ids_Venda.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_carrega_venda. ", StopSign!)
	Return False
End If

If ll_Find > 0 Then
	al_Qtd_Venda = ids_Venda.Object.Qt_Venda[ll_Find]
Else
	al_Qtd_Venda = 0
End If

Return True
end function

on w_ge130_saldo_promocao.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
this.cb_gera_planilha=create cb_gera_planilha
this.dw_4=create dw_4
this.cb_faltas=create cb_faltas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
this.Control[iCurrent+2]=this.cb_gera_planilha
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.cb_faltas
end on

on w_ge130_saldo_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_confirmar)
destroy(this.cb_gera_planilha)
destroy(this.dw_4)
destroy(this.cb_faltas)
end on

event close;call super::close;Destroy(ivo_Promocao)
Destroy(ids_Venda)
end event

event resize;call super::resize;//
//cb_gera_planilha.x = NewWidth - 539
//cb_gera_planilha.y = NewHeight - 112
//
//gb_2.width = NewWidth - 59
//gb_2.height = NewHeight - 452
//
//dw_2.width = NewWidth - 114
//dw_2.height = NewHeight - 536
end event

event open;call super::open;dw_3.Visible = False
dw_4.Visible = False

ivb_permite_fechar = false
end event

event ue_preopen;call super::ue_preopen;ivo_Promocao = Create uo_Promocao
ids_Venda = Create dc_uo_ds_base

If Not ids_Venda.of_ChangeDataObject("ds_ge130_vendas") Then
	Destroy(ids_Venda)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge130_vendas'.", StopSign!)
	Return
End If
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge130_saldo_promocao
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge130_saldo_promocao
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge130_saldo_promocao
integer x = 27
integer y = 368
integer width = 2821
integer height = 1004
integer weight = 700
string text = "Lista de Promo$$HEX2$$e700f500$$ENDHEX$$es"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge130_saldo_promocao
integer x = 27
integer width = 1737
integer height = 344
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge130_saldo_promocao
integer x = 64
integer y = 76
integer width = 1655
integer height = 264
string dataobject = "dw_ge130_selecao"
end type

event dw_1::ue_key;call super::ue_key;String lvs_Promocao

If Key = KeyEnter! Then
	If This.GetColumnName() = "de_promocao" Then
		lvs_Promocao = This.GetText()

		ivo_Promocao.of_Localiza(lvs_Promocao)

		If ivo_Promocao.Localizado Then
			This.Object.cd_Promocao[1] = ivo_Promocao.Cd_Promocao
			This.Object.de_Promocao[1] = ivo_Promocao.nm_promocao
			
		End If
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
	Case "qt_saldo"
		This.Object.id_zero [ 1 ] = 'N'
		
End Choose

dw_2.Event ue_Reset()


end event

event dw_1::itemchanged;call super::itemchanged;
Choose Case dwo.Name
	Case "de_promocao"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Promocao.nm_promocao Then
				Return 1
			End If
		Else
			ivo_Promocao.of_Inicializa()
			
			This.Object.Cd_Promocao[1] = ivo_Promocao.Cd_Promocao
			This.Object.De_Promocao[1] = ivo_Promocao.nm_promocao
		End If
		
	Case "id_zero"
		
		This.Object.qt_saldo [ 1 ] = 0
		
	Case "qt_saldo"
		
		This.Object.id_zero [ 1 ] = 'N'
	
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge130_saldo_promocao
event ue_mousemove pbm_mousemove
event ue_doubleclicked ( ) External
integer x = 59
integer y = 444
integer width = 2766
integer height = 908
string dataobject = "dw_ge130_lista"
boolean hscrollbar = true
end type

event dw_2::ue_mousemove;If This.RowCount() > 0 Then
	If (xpos >= 2575 and (xpos <= (2575 + 73))) and &
		  (ypos >= 12 and (ypos <= (12 + 64))) Then	 
		
		dw_2.object.id_selecionar.TransparentColor = ''
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
		dw_2.object.id_selecionar.TransparentColor = '12632256'
	End If
End If
end event

event dw_2::doubleclicked;call super::doubleclicked;Long lvl_Row
String lvs_Marcacao,&
	   lvs_Nulo 

SetNull(lvs_Nulo)

Choose Case dwo.Name 
			
	Case 'id_selecionar'
			
		If ivb_Check Then
			lvs_Marcacao = 'N'
			ivb_Check = False
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		Else
			lvs_Marcacao = 'S'
			ivb_Check = True
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		End If
		
		For lvl_Row = 1 To This.RowCount()
					
			dw_2.Object.Id_selecao[lvl_Row] = lvs_Marcacao
			
		Next
		
End Choose
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String 	lvs_Tipo
Long		lvl_Promocao

dw_2.Event ue_Reset()

dw_1.AcceptText()

lvl_Promocao 	= dw_1.Object.cd_promocao	[1]
lvs_Tipo   		= dw_1.Object.id_Tipo			[1]

If not IsNull(lvl_Promocao) Then
	This.of_AppendWhere("p.cd_promocao_sos = " +  String(lvl_Promocao))
End If	

If (not IsNull(lvs_Tipo))  and (lvs_Tipo <> 'T') Then
	This.of_AppendWhere("p.id_tipo_promocao = '" +  lvs_Tipo+"'")
End If	

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge130_saldo_promocao
integer x = 2327
integer y = 20
integer width = 475
integer height = 168
string dataobject = "dw_ge130_saldo_produto"
boolean vscrollbar = false
end type

event dw_3::ue_preretrieve;call super::ue_preretrieve;
//Long 	ll_Row
//String ls_Promocao
//
//If not wf_tem_item_selecionado() Then
//	Messagebox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ promo$$HEX2$$e700e300$$ENDHEX$$o selecionada.")
//	Return 0		
//End If	
//
//ls_Promocao = ""
//
//For ll_Row = 1 To dw_2.RowCount()
//	If dw_2.Object.id_selecao	[ll_Row] = "S" Then
//		If ls_Promocao = "" Then
//			ls_Promocao = String(dw_2.Object.cd_promocao_sos	[ll_Row])
//		Else
//			ls_Promocao = ls_Promocao +", "+ String(dw_2.Object.cd_promocao_sos	[ll_Row])
//		End If	
//	End If	
//Next
//
//
//dw_3.of_AppendWhere(" p.cd_promocao_sos in (" + ls_Promocao+")" )
//
Return AncestorReturnValue
end event

type st_confirmar from statictext within w_ge130_saldo_promocao
boolean visible = false
integer x = 1673
integer y = 412
integer width = 951
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos"
boolean focusrectangle = false
end type

type cb_gera_planilha from commandbutton within w_ge130_saldo_promocao
integer x = 2368
integer y = 1384
integer width = 480
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Planilha"
end type

event clicked;Date 	ldt_Mes1,&
		ldt_Mes2,&
		ldt_Mes3,&
		ldt_Mes4,&
		ldt_Mes5,&
		ldt_Mes6,&
		ldt_Mes7,&
		ldt_Mes8,&
		ldt_Mes9,&
		ldt_Mes10,&
		ldt_Mes11,&
		ldt_Mes12,&
		ldt_Atual, &
		ldh_Inclusao_GC, &
		ldh_Ultima_Entrada, &
		ldh_Ultima_Venda
		
Integer 	lvi_Retorno, &
			li_qt_Saldo

Long 		ll_Row,&
			ll_Itens,&
			ll_Itens_Row,&
			ll_Promocao,&
			ll_Selecionados,&
			ll_Qtde_Itens,&
			ll_Qt_Mensagem,&
			ll_Filial,&
			ll_Produto, &
			ll_Filial_Ant = 0, &
			ll_Qt_Venda
			
String 	ls_Promocao,&
			lvs_Path,&
	   		lvs_Arquivo,&
			ls_Sit_Produto,&
			ls_Zero

dw_1.AcceptText()

ll_Selecionados = wf_tem_item_selecionado()

If  ll_Selecionados  < 1 Then
	Messagebox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ promo$$HEX2$$e700e300$$ENDHEX$$o selecionada.")
	Return 0		
End If	

If ll_Selecionados > 10 Then
	If MessageBox("Alerta", "Tem mais do que 10 Promo$$HEX2$$e700f500$$ENDHEX$$es selecionadas, a gera$$HEX2$$e700e300$$ENDHEX$$o da planilha poder$$HEX1$$e100$$ENDHEX$$ demorar.~rDeseja Continuar?",  Exclamation!, OKCancel!, 2) <> 1 Then
		Return 0
	End If	
End If	

ls_Promocao = ""
ll_Itens_Row = 1
ll_Qt_Mensagem = 1

ls_Sit_Produto 	= dw_1.Object.id_situacao_prd		[ 1 ]
li_qt_Saldo		= dw_1.Object.qt_saldo				[ 1 ]
ls_Zero			= dw_1.Object.id_zero				[ 1 ]

ldt_Atual	= Date(String(gf_GetServerDate(), "01/mm/yyyy"))

ldt_Mes12	= Date(String(RelativeDate(ldt_Atual, -1), "01/mm/yyyy"))
ldt_Mes11	= Date(String(RelativeDate(ldt_Mes12, -1), "01/mm/yyyy"))
ldt_Mes10	= Date(String(RelativeDate(ldt_Mes11, -1), "01/mm/yyyy"))
ldt_Mes9		= Date(String(RelativeDate(ldt_Mes10, -1), "01/mm/yyyy"))
ldt_Mes8		= Date(String(RelativeDate(ldt_Mes9, -1), "01/mm/yyyy"))
ldt_Mes7		= Date(String(RelativeDate(ldt_Mes8, -1), "01/mm/yyyy"))

ldt_Mes6	= Date(String(RelativeDate(ldt_Mes7, -1), "01/mm/yyyy"))
ldt_Mes5	= Date(String(RelativeDate(ldt_Mes6, -1), "01/mm/yyyy"))
ldt_Mes4	= Date(String(RelativeDate(ldt_Mes5, -1), "01/mm/yyyy"))
ldt_Mes3	= Date(String(RelativeDate(ldt_Mes4, -1), "01/mm/yyyy"))
ldt_Mes2	= Date(String(RelativeDate(ldt_Mes3, -1), "01/mm/yyyy"))
ldt_Mes1	= Date(String(RelativeDate(ldt_Mes2, -1), "01/mm/yyyy"))

dw_4.Modify("qt_mes1.dbName='Qt_Venda_"+String(ldt_Mes1, "mm_yyyy")+"'")
dw_4.Modify("qt_mes1.Initial='0'")
dw_4.Modify("qt_mes2.dbName='Qt_Venda_"+String(ldt_Mes2, "mm_yyyy")+"'")
dw_4.Modify("qt_mes2.Initial='0'")
dw_4.Modify("qt_mes3.dbName='Qt_Venda_"+String(ldt_Mes3, "mm_yyyy")+"'")
dw_4.Modify("qt_mes3.Initial='0'")
dw_4.Modify("qt_mes4.dbName='Qt_Venda_"+String(ldt_Mes4, "mm_yyyy")+"'")
dw_4.Modify("qt_mes4.Initial='0'")
dw_4.Modify("qt_mes5.dbName='Qt_Venda_"+String(ldt_Mes5, "mm_yyyy")+"'")
dw_4.Modify("qt_mes5.Initial='0'")
dw_4.Modify("qt_mes6.dbName='Qt_Venda_"+String(ldt_Mes6, "mm_yyyy")+"'")
dw_4.Modify("qt_mes6.Initial='0'")

dw_4.Modify("qt_mes7.dbName='Qt_Venda_"+String(ldt_Mes7, "mm_yyyy")+"'")
dw_4.Modify("qt_mes7.Initial='0'")
dw_4.Modify("qt_mes8.dbName='Qt_Venda_"+String(ldt_Mes8, "mm_yyyy")+"'")
dw_4.Modify("qt_mes8.Initial='0'")
dw_4.Modify("qt_mes9.dbName='Qt_Venda_"+String(ldt_Mes9, "mm_yyyy")+"'")
dw_4.Modify("qt_mes9.Initial='0'")
dw_4.Modify("qt_mes10.dbName='Qt_Venda_"+String(ldt_Mes10, "mm_yyyy")+"'")
dw_4.Modify("qt_mes10.Initial='0'")
dw_4.Modify("qt_mes11.dbName='Qt_Venda_"+String(ldt_Mes11, "mm_yyyy")+"'")
dw_4.Modify("qt_mes11.Initial='0'")
dw_4.Modify("qt_mes12.dbName='Qt_Venda_"+String(ldt_Mes12, "mm_yyyy")+"'")
dw_4.Modify("qt_mes12.Initial='0'")

dw_4.Modify("qt_mes_atual.Initial='0'")

dw_4.Event ue_Reset()

Open(w_ge130_aguarde)

w_ge130_aguarde.Title = "Gerando o Arquivo..."
w_ge130_aguarde.uo_Progress_1.of_SetMax(ll_Selecionados)

For ll_Row = 1 To dw_2.RowCount()	
	
	If dw_2.Object.id_selecao	[ll_Row] = "S" Then	
		
		w_ge130_aguarde.st_message_1.Text = "Processando promo$$HEX2$$e700e300$$ENDHEX$$o "+String(ll_Qt_Mensagem)+" de "+String(ll_Selecionados)				
		
		ll_Promocao = dw_2.Object.cd_promocao_sos	[ll_Row] 
		
		dw_3.Event ue_Reset()
		dw_3.of_RestoreOriginalSQL()
		
		If ls_Sit_Produto <> 'T' Then dw_3.of_AppendWhere_SubQuery( "g.id_situacao = '" + ls_Sit_Produto + "'" , 2)
		
		If (Not IsNull( li_qt_Saldo ) And li_qt_Saldo > 0 ) And ls_Zero = 'N' Then dw_3.of_AppendWhere_SubQuery( "v.qt_saldo_final = " + String( li_qt_Saldo ), 2)
		
		If ls_Zero = 'S' Then dw_3.of_AppendWhere_SubQuery( "v.qt_saldo_final = 0 ", 2)
		
		ll_Qtde_Itens = dw_3.Retrieve(ll_Promocao, DateTime(ldt_Atual))
		
		If ll_Qtde_Itens = -1 Then
			MessageBox("Erro", "Erro ao localizar os produtos da promo$$HEX2$$e700e300$$ENDHEX$$o "+String(ll_Promocao))
			Close(w_ge130_aguarde)
			Return
		End If

		w_ge130_aguarde.uo_Progress_2.of_SetMax(ll_Qtde_Itens)
		
		For ll_Itens = 1 To ll_Qtde_Itens
			
			w_ge130_aguarde.st_message_2.Text = "Processando produto por filial "+String(ll_Itens)+" de "+String(ll_Qtde_Itens)
						
			ll_Filial		= dw_3.Object.cd_filial		[ll_Itens]
			ll_Produto	= dw_3.Object.cd_produto	[ll_Itens]
			
			dw_4.Object.cd_promocao_sos			[ll_Itens_Row]  = dw_3.Object.cd_promocao_sos			[ll_Itens]
			dw_4.Object.nm_promocao_sos		[ll_Itens_Row]  = dw_3.Object.nm_promocao_sos		[ll_Itens]
			dw_4.Object.dh_inicio					[ll_Itens_Row]  = dw_3.Object.dh_inicio						[ll_Itens]
			dw_4.Object.dh_termino					[ll_Itens_Row]  = dw_3.Object.dh_termino					[ll_Itens]
			dw_4.Object.cd_produto					[ll_Itens_Row]  = dw_3.Object.cd_produto					[ll_Itens]
			dw_4.Object.de_produto					[ll_Itens_Row]  = dw_3.Object.de_produto					[ll_Itens]
			dw_4.Object.de_apresentacao_venda	[ll_Itens_Row]  = dw_3.Object.de_apresentacao_venda	[ll_Itens]
			dw_4.Object.cd_filial						[ll_Itens_Row]  = dw_3.Object.cd_filial						[ll_Itens]
			dw_4.Object.nm_fantasia				[ll_Itens_Row]  = dw_3.Object.nm_fantasia					[ll_Itens]
			dw_4.Object.id_situacao					[ll_Itens_Row]  = dw_3.Object.id_situacao					[ll_Itens]
			dw_4.Object.vl_fator_conversao		[ll_Itens_Row]  = dw_3.Object.vl_fator_conversao		[ll_Itens]
			dw_4.Object.qt_estoque_base			[ll_Itens_Row]  = dw_3.Object.qt_estoque_base			[ll_Itens]
			dw_4.Object.saldo_filial					[ll_Itens_Row]  = dw_3.Object.saldo_filial					[ll_Itens]
			dw_4.Object.saldo_matriz				[ll_Itens_Row]  = dw_3.Object.saldo_matriz				[ll_Itens]
			dw_4.Object.De_Movel					[ll_Itens_Row]  = dw_3.Object.De_Movel					[ll_Itens]
			
			If Not wf_Movimentacao_Produto(ll_Filial, ll_Produto, Ref ldh_Inclusao_GC, Ref ldh_Ultima_Entrada, Ref ldh_Ultima_Venda) Then Return -1
			
			dw_4.Object.Dh_Inclusao			[ll_Itens_Row] = ldh_Inclusao_GC
			dw_4.Object.Dh_Ultima_Entrada	[ll_Itens_Row] = ldh_Ultima_Entrada
			dw_4.Object.Dh_Ultima_Venda		[ll_Itens_Row] = ldh_Ultima_Venda
			
			dw_4.Object.qt_estoque_minimo		[ll_Itens_Row]  = dw_3.Object.qt_estoque_minimo	[ll_Itens]
			dw_4.Object.qt_saldo_pendente		[ll_Itens_Row]  = dw_3.Object.qt_saldo_pendente	[ll_Itens]
			
//			dw_4.Object.qt_mes1						[ll_Itens_Row]  = wf_Qt_Venda_Mes(ll_Filial, ll_Produto, ldt_Mes1) //dw_3.Object.qt_mes1		[ll_Itens]
//			dw_4.Object.qt_mes2						[ll_Itens_Row]  = wf_Qt_Venda_Mes(ll_Filial, ll_Produto, ldt_Mes2) //dw_3.Object.qt_mes2		[ll_Itens]
//			dw_4.Object.qt_mes3						[ll_Itens_Row]  = wf_Qt_Venda_Mes(ll_Filial, ll_Produto, ldt_Mes3) //dw_3.Object.qt_mes3		[ll_Itens]
//			dw_4.Object.qt_mes4						[ll_Itens_Row]  = wf_Qt_Venda_Mes(ll_Filial, ll_Produto, ldt_Mes4) //dw_3.Object.qt_mes4		[ll_Itens]
//			dw_4.Object.qt_mes5						[ll_Itens_Row]  = wf_Qt_Venda_Mes(ll_Filial, ll_Produto, ldt_Mes5) //dw_3.Object.qt_mes5		[ll_Itens]
//			dw_4.Object.qt_mes6						[ll_Itens_Row]  = wf_Qt_Venda_Mes(ll_Filial, ll_Produto, ldt_Mes6) //dw_3.Object.qt_mes6		[ll_Itens]
//			dw_4.Object.qt_mes_atual				[ll_Itens_Row]  = wf_Qt_Venda_Mes(ll_Filial, ll_Produto, ldt_Atual) //dw_3.Object.qt_mes_atual	[ll_Itens]
			
//			dw_4.Object.qt_estoque_minimo		[ll_Itens_Row]  = wf_Localiza_Estoque_Minimo( ll_Promocao, ll_Filial, ll_Produto )
//			dw_4.Object.qt_saldo_pendente		[ll_Itens_Row]  = wf_Localiza_Saldo_Pendente( ll_Filial, ll_Produto )

			//Quando trocar a filial consulta o per$$HEX1$$ed00$$ENDHEX$$odo de vendas de 1 ano
			If (ll_Filial <> ll_Filial_Ant) Then
				ids_Venda.Reset()

				If ids_Venda.Retrieve(DateTime(ldt_Mes1), DateTime(ldt_Atual), ll_Filial, ll_Promocao) < 0 Then
					Destroy(ids_Venda)
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar os dados da data store 'ds_ge130_vendas'.", StopSign!)
					Return -1
				End If
				
				ll_Filial_Ant = ll_Filial
			End If
						
			If Not wf_Carrega_Venda(ldt_Mes1, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes1[ll_Itens_Row] = ll_Qt_Venda
			
			If Not wf_Carrega_Venda(ldt_Mes2, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes2[ll_Itens_Row] = ll_Qt_Venda
			
			If Not wf_Carrega_Venda(ldt_Mes3, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes3[ll_Itens_Row] = ll_Qt_Venda
			
			If Not wf_Carrega_Venda(ldt_Mes4, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes4[ll_Itens_Row] = ll_Qt_Venda
		
			If Not wf_Carrega_Venda(ldt_Mes5, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes5[ll_Itens_Row] = ll_Qt_Venda
		
			If Not wf_Carrega_Venda(ldt_Mes6, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes6[ll_Itens_Row] = ll_Qt_Venda
		
			If Not wf_Carrega_Venda(ldt_Mes7, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes7[ll_Itens_Row] = ll_Qt_Venda
		
			If Not wf_Carrega_Venda(ldt_Mes8, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes8[ll_Itens_Row] = ll_Qt_Venda
		
			If Not wf_Carrega_Venda(ldt_Mes9, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes9[ll_Itens_Row] = ll_Qt_Venda
		
			If Not wf_Carrega_Venda(ldt_Mes10, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes10[ll_Itens_Row] = ll_Qt_Venda
		
			If Not wf_Carrega_Venda(ldt_Mes11, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes11[ll_Itens_Row] = ll_Qt_Venda
		
			If Not wf_Carrega_Venda(ldt_Mes12, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes12[ll_Itens_Row] = ll_Qt_Venda
		
			If Not wf_Carrega_Venda(ldt_Atual, ll_Filial, ll_Produto, Ref ll_Qt_Venda) Then Return -1
			dw_4.Object.qt_mes_atual[ll_Itens_Row] = ll_Qt_Venda
		
			ll_Itens_Row++
			w_ge130_aguarde.uo_Progress_2.of_SetProgress(ll_Itens)
		Next	
	
		w_ge130_aguarde.uo_Progress_1.of_SetProgress(ll_Qt_Mensagem)
		ll_Qt_Mensagem++
	End If
	Yield() //Atualiza a tela
Next

Sleep(2)
Close(w_ge130_aguarde)

		
ll_Qtde_Itens = dw_4.RowCount() 

If ll_Qtde_Itens > 0 Then   
  	If ll_Qtde_Itens <= 63000 Then		
		lvi_retorno = GetFileSaveName('Arquivo', lvs_Path, lvs_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')
		
		If lvi_retorno = 1 Then
			If dw_4.SaveAs(lvs_Path, Excel!, True) = 1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
			End If
		End If
	Else
		lvi_retorno = GetFileSaveName('Arquivo', lvs_Path, lvs_Arquivo, 'txt', 'Arquivo Texto (*.txt),*.txt')
		
		If lvi_retorno = 1 Then		
			If dw_4.SaveAs(lvs_Path, Text!, True) = 1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
			End If
		End If
	End If
		
Else
	If  wf_tem_item_selecionado() > 0 Then	
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ itens para serem exportados.")
	End If	
End If
end event

type dw_4 from dc_uo_dw_base within w_ge130_saldo_promocao
integer x = 1806
integer y = 24
integer height = 160
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge130_saldo_produto_exporta"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type cb_faltas from commandbutton within w_ge130_saldo_promocao
integer x = 1161
integer y = 1384
integer width = 1166
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Faltas dos Produtos de Planogramas (XLS)"
end type

event clicked;Long ll_Linhas, ll_Linha

String ls_UF, ls_Path

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o das planilhas de todas as UF's ?" +&
		"~r ~rOs 50 primeiros produtos ativos de todas as promo$$HEX2$$e700f500$$ENDHEX$$es de planograma.",  Question!, YesNo!, 2) = 2 Then Return


try
	Open(w_Aguarde)
	
	ls_Path = gvo_Aplicacao.of_GetFromINI("Diretorio", 'Diretorio')

	If ls_Path = '' Then Return

	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge130_uf") Then Return
	
	lds.Retrieve()
	
	ll_Linhas = lds.RowCount()
	
	If ll_Linhas > 0 Then
			
		w_aguarde.uo_progress.of_setmax(ll_Linhas + 1)
		
		For ll_Linha = 1  To ll_Linhas
			ls_UF = lds.Object.cd_uf[ll_Linha]
			w_Aguarde.Title = "Gerando os dados da UF '" + ls_UF + "' ..."
			wf_gera_planilha(ls_UF, ls_Path)
			w_aguarde.uo_progress.of_setprogress(ll_Linha)
		Next 		
		
		wf_gera_planilha('XX', ls_Path)
		w_Aguarde.Title = "Gerando os dados da REDE ..."
		w_aguarde.uo_progress.of_setprogress(ll_Linha + 1)
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os arquivos foram salvos no diret$$HEX1$$f300$$ENDHEX$$rio '" + ls_Path + "'.")
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma UF foi localizada.")
	End If
	
finally
	Destroy(lds)
	Close(w_Aguarde)
end try



//Long ll_QTde
//
//Integer li_retorno
//
//String ls_Path, ls_Arquivo
//
//If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o da planilha ?~r ~rOs 30 primeiros produtos ativos de todas as promo$$HEX2$$e700f500$$ENDHEX$$es de planograma.",  Question!, YesNo!, 2) = 2 Then Return
//
//SetPointer(HourGlass!)
//
//DataStore lds_1
//
//lds_1     	= Create DataStore
//
//dc_uo_transacao  SqlCa_Aux
//
//SqlCa_Aux   = Create dc_uo_transacao
//
//SqlCa_Aux = SqlCa;
//
//SqlCa_Aux.AutoCommit = True
//
//Connect Using SqlCa_Aux;
//
//lds_1.DataObject = "ds_ge130_falta_planograma"
//lds_1.SetTransObject(SqlCa)
//
//ll_QTde = lds_1.Retrieve("T")
//
//If ll_QTde > 0 Then
//	
//	li_retorno = GetFileSaveName('Arquivo', ls_Path, ls_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')
//		
//	If li_retorno = 1 Then
//		If lds_1.SaveAs(ls_Path, Excel!, True) = 1 Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + ls_Path + "'.")
//		Else
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + ls_Path + "'.", StopSign!)
//		End If
//	End If
//	
//Else
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
//End If 
//
//Destroy lds_1
//
//SetPointer(Arrow!)
end event

