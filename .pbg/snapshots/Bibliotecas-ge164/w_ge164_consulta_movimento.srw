HA$PBExportHeader$w_ge164_consulta_movimento.srw
forward
global type w_ge164_consulta_movimento from dc_w_selecao_lista_relatorio
end type
type cb_1 from commandbutton within w_ge164_consulta_movimento
end type
end forward

global type w_ge164_consulta_movimento from dc_w_selecao_lista_relatorio
integer width = 4005
integer height = 2200
string title = "GE164 - Consulta Movimento WMS"
cb_1 cb_1
end type
global w_ge164_consulta_movimento w_ge164_consulta_movimento

type variables
uo_produto ivo_produto
uo_Usuario ivo_Usuario
end variables

forward prototypes
public function boolean wf_filial (long al_codigo, ref string as_nome)
public function boolean wf_fornecedor (string as_codigo, ref string as_nome)
public function boolean wf_saldo_produto (date adt_inicio, long al_produto, ref long al_saldo)
public function boolean wf_saldo_produto_movimento (date adt_inicio, date adt_fim, long al_produto, ref long al_saldo)
public function string uof_json_value (string as_value)
public function string uof_json_number (long an_value)
public function string uof_json_dec (decimal an_value)
public function string uof_json_datetime (datetime adt_value)
public function boolean wf_verifica_filial_endereco (string as_endereco)
end prototypes

public function boolean wf_filial (long al_codigo, ref string as_nome);Boolean lvb_Sucesso = False

Select cast(cd_filial as varchar)+' - '+nm_fantasia  Into :as_Nome
From filial
Where cd_filial = :al_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(al_Codigo) + "' n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nome da Filial")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_fornecedor (string as_codigo, ref string as_nome);Boolean lvb_Sucesso = False

Select nm_razao_social Into :as_Nome
From fornecedor
Where cd_fornecedor = :as_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nome do Fornecedor")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_saldo_produto (date adt_inicio, long al_produto, ref long al_saldo);Date ldt_Saldo

ldt_Saldo = RelativeDate(adt_inicio, -1)

select coalesce(sum(qt_saldo) , 0)
Into :al_saldo
from wms_saldo_produto_lote
where cd_produto = :al_produto
  and dh_saldo in (select max(dh_saldo) from wms_saldo_produto_lote
							where cd_produto = :al_produto
							  and dh_saldo < :adt_inicio)
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o saldo do produto produto.")
End If

Return True
end function

public function boolean wf_saldo_produto_movimento (date adt_inicio, date adt_fim, long al_produto, ref long al_saldo);Long 	ll_Saldo_Entrada,&
		ll_Saldo_Saida
						  
select coalesce(sum(a.qt_movimento * a.qt_caixa_padrao), 0)
Into :ll_Saldo_Entrada
from wms_movimento_estoque a
inner join wms_tipo_movimento_estoque b on b.cd_tipo_movimento = a.cd_tipo_movimento
where a.cd_produto = :al_produto
and  b.id_entrada_saida = 'E' 
and dh_movimento between :adt_inicio and :adt_Fim
group by b.id_entrada_saida
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o saldo de entrada do produto.")
	Return False	
End If			
	
select coalesce(sum(a.qt_movimento * a.qt_caixa_padrao), 0)
Into :ll_Saldo_Saida 
from wms_movimento_estoque a
inner join wms_tipo_movimento_estoque b on b.cd_tipo_movimento = a.cd_tipo_movimento
where a.cd_produto = :al_produto
and  b.id_entrada_saida = 'S' 
and dh_movimento between :adt_inicio and :adt_Fim
group by b.id_entrada_saida 
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o saldo de sa$$HEX1$$ed00$$ENDHEX$$da do produto.")
	Return False
End If

al_saldo = ll_Saldo_Entrada - ll_Saldo_Saida

Return True
end function

public function string uof_json_value (string as_value);// Retorna "null" se estiver vazio ou NULL, sen$$HEX1$$e300$$ENDHEX$$o retorna valor entre aspas, escapado
IF IsNull(as_value) OR Trim(as_value) = "" THEN
    RETURN "null"
END IF

// Escapar aspas e barras
string ls_aux
ls_aux = gf_Replace(as_value, "\", "\\", 0)      // barra invertida
ls_aux = gf_Replace(ls_aux, '"', '\"', 0)        // aspas dupla

RETURN '"' + ls_aux + '"'

end function

public function string uof_json_number (long an_value);IF IsNull(an_value) THEN
    RETURN "null"
END IF

RETURN String(an_value)

end function

public function string uof_json_dec (decimal an_value);IF IsNull(an_value) THEN
    RETURN "null"
END IF

RETURN String(an_value)

end function

public function string uof_json_datetime (datetime adt_value);IF IsNull(adt_value) THEN
    RETURN "null"
END IF

RETURN '"' + String(adt_value, "yyyy-mm-ddThh:mm:ssZ") + '"'

end function

public function boolean wf_verifica_filial_endereco (string as_endereco);Long	ll_Filial

SELECT cd_filial
  INTO :ll_Filial
  FROM vw_wms_endereco
 WHERE cd_endereco = :as_endereco
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar o endere$$HEX1$$e700$$ENDHEX$$o ' + as_endereco + ': ' + SQLCA.SQLErrText, Exclamation!)
		Return False
		
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Endere$$HEX1$$e700$$ENDHEX$$o ' + as_endereco + ' n$$HEX1$$e300$$ENDHEX$$o localizado!', Exclamation!)
		Return False
		
	case 0
		If ll_Filial <> gl_cd_filial then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O endere$$HEX1$$e700$$ENDHEX$$o ' + as_endereco + ' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ localizado neste CD!', Exclamation!)
			Return False
		End if
		
End choose

Return True
end function

on w_ge164_consulta_movimento.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge164_consulta_movimento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event close;call super::close;Destroy(ivo_Produto)
end event

event ue_postopen;//OverRide
ivo_dbError = Create dc_uo_dbError
DataWindowChild lvdwc


dw_1.Event ue_AddRow()
dw_1.SetFocus()

This.ivm_Menu.mf_Recuperar(True)

ivo_Produto = Create uo_Produto
ivo_Usuario = Create uo_Usuario
 
ivm_Menu.ivb_Permite_Imprimir = True

dw_1.Object.Dt_Inicio [1] = Date("01/" + String(Today(), "mm/yyyy"))
dw_1.Object.Dt_Termino[1] = Today()


If dw_1.GetChild("id_tipo_movimento", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_tipo_movimento", 0)
	lvdwc.SetItem(1, "de_tipo_movimento",   "TODOS OS MOVIMENTOS")
	
	dw_1.Object.id_tipo_movimento[1] = 0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do tipo de movimento.")
End If

end event

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino


If AncestorReturnValue > 0 Then
	lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
	lvdt_Termino = dw_1.Object.Dt_Termino[1]

	dw_3.Object.Cabecalho_Periodo.Text	 	= String(lvdt_Inicio, "dd/mm/yyyy") + "  at$$HEX1$$e900$$ENDHEX$$  " + String(lvdt_Termino, "dd/mm/yyyy")
	dw_3.Object.Cabecalho_Produto.Text 	= ivo_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(ivo_Produto.Cd_Produto) + ")"
	dw_3.Object.t_saldo_inical.Text			= String(dw_2.GetItemNumber(1, "compute_3"), "#,##0")
	dw_3.Object.t_saldo_final.Text				= String(dw_2.GetItemNumber(1, "compute_2"), "#,##0")
End If

Return AncestorReturnValue
end event

event ue_preopen;call super::ue_preopen;MaxHeight = 9999
MaxWidth = 9999
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge164_consulta_movimento
integer y = 1392
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge164_consulta_movimento
integer y = 1320
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge164_consulta_movimento
integer y = 588
integer width = 3909
integer height = 1416
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge164_consulta_movimento
integer y = 8
integer width = 2633
integer height = 580
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge164_consulta_movimento
integer x = 64
integer y = 60
integer width = 2551
integer height = 500
string dataobject = "dw_ge164_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_produto"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque	Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto[1] = ivo_Produto.cd_produto
			This.Object.Nm_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque		
		End If
	Case "nm_usuario"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Usuario.nm_usuario Then
				Return 1
			End If
		Else
			ivo_Usuario.of_Inicializa()
			
			This.Object.Nr_Matricula			 [1] = ivo_Usuario.Nr_Matricula
			This.Object.Nm_Usuario       	 [1] = ivo_Usuario.Nm_Usuario
		End If
		
	case 'cd_endereco'
		If not IsNull (data) and Trim (data) <> '' then
			If not wf_verifica_filial_endereco (data) then Return 1
		End if
		
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	This.Object.Nm_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.cd_produto	[1] = ivo_Produto.cd_produto
				This.Object.nm_produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
		Case "nm_usuario"
	
			ivo_Usuario.of_Localiza_Usuario( This.GetText() )
			
			If ivo_Usuario.Localizado Then
				This.Object.Nr_Matricula		[1] = ivo_Usuario.Nr_Matricula
				This.Object.Nm_Usuario		[1] = ivo_Usuario.Nm_Usuario
			End If
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge164_consulta_movimento
integer x = 73
integer y = 652
integer width = 3849
integer height = 1336
string dataobject = "dw_ge164_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Contador, &
     lvl_Filial,&
	 lvl_Tamanho, &
	 lvl_Filial_Origem, &
	 lvl_Filial_Destino, &
	 lvl_Tipo_Movimento
	  
String lvs_Fornecedor, &
		 lvs_Origem_Destino
		 
Boolean	lvb_Classificar, &
        	    lvb_Filtrar, &
		  	lvb_Localizar, &
		  	lvb_Excluir,&
			lvb_Salvar  

If pl_Linhas > 0 Then
	
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)


	This.SetRow(1)
	This.SetFocus()
	
	This.SetRedraw(False)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Origem e Destino dos Movimentos..."
	
	w_Aguarde.uo_Progress.of_SetMax(pl_Linhas)
	
	For lvl_Contador = 1 To pl_Linhas
		lvl_Filial     = This.Object.Cd_Filial    [lvl_Contador]
		lvs_Fornecedor = This.Object.Cd_Fornecedor[lvl_Contador]
		lvs_Origem_Destino = ""
		lvl_Tamanho = Len (lvs_Fornecedor)   //  Tamanho do campo Fornecedor
		
		If Not IsNull(lvs_Fornecedor)  and lvl_Tamanho = 9   Then
			//lvs_Origem_Destino	= lvs_Fornecedor + ' - FORN'
			wf_Fornecedor(lvs_Fornecedor, ref lvs_Origem_Destino)
		Else
			If Not IsNull(lvl_Filial) Then
				//lvs_Origem_Destino	= String(lvl_Filial) + ' - FILIAL'
				lvl_Tipo_Movimento = This.Object.cd_tipo_movimento [lvl_Contador]
				
				Choose case lvl_Tipo_Movimento
					case 49 //sa$$HEX1$$ed00$$ENDHEX$$da transf cd
						lvl_Filial_Destino = This.Object.cd_filial_destino [lvl_Contador]
						wf_Filial(lvl_Filial_Destino, ref lvs_Origem_Destino)
						
					case 50	//entrada transf cd
						lvl_Filial_Origem = This.Object.cd_filial_origem [lvl_Contador]
						wf_Filial(lvl_Filial_Origem, ref lvs_Origem_Destino)
						
					case else
						wf_Filial(lvl_Filial, ref lvs_Origem_Destino)
						if lvl_Filial = 534 or lvl_Filial = 294 then lvs_Origem_Destino = 'FOR' + lvs_Origem_Destino
				End choose
				
			End If
		End If
		
		If Trim(lvs_Origem_Destino) <> "" Then
			This.Object.De_Origem_Destino[lvl_Contador] = lvs_Origem_Destino
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	Close(w_Aguarde)
	This.SetRedraw(True)

Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Excluir(lvb_Excluir)
Parent.ivm_menu.mf_Salvarcomo(pl_linhas>0)



Return pl_Linhas
end event

event dw_2::ue_recuperar;// Override

Long 		lvl_Produto, &
	  		lvl_Saldo_Inicial,&
			ll_Saldo,&
			ll_Saldo_Movimento,&
			ll_TipoMovimento,&
			ll_nr_nf,&
			ll_agrupamento

Date lvdt_Inicio, &
     lvdt_Termino
	  
String ls_Lote, &
		 ls_cd_endereco, &
		 ls_nr_matricula, &
		 ls_id_tipo_saldo, &
		 ls_id_entrada_saida
	  
dw_1.AcceptText()

lvl_Produto  			= dw_1.Object.Cd_Produto			[1]
lvdt_Inicio  			= dw_1.Object.Dt_Inicio				[1]
lvdt_Termino 			= dw_1.Object.Dt_Termino			[1]
ls_Lote					= dw_1.Object.nr_lote				[1]
ll_TipoMovimento  	= dw_1.Object.id_tipo_movimento	[1]
ls_cd_endereco			= dw_1.Object.cd_endereco			[1]
ls_nr_matricula		= dw_1.Object.nr_matricula			[1]
ll_nr_nf					= dw_1.Object.nr_nf					[1]
ll_agrupamento			= dw_1.Object.nr_agrupamento_dev_compra[1]
ls_id_tipo_saldo		= dw_1.Object.id_utiliza_saldo[1]
ls_id_entrada_saida	= dw_1.Object.id_saida_entrada[1]

If IsNull(lvl_Produto) or lvl_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.", Information!)
	dw_1.Event ue_Pos(1, "nm_produto")
	Return -1
End If

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

wf_Saldo_Produto(lvdt_Inicio, lvl_Produto, ref ll_Saldo )

wf_saldo_produto_movimento(lvdt_Inicio, lvdt_Termino, lvl_Produto, ref ll_Saldo_Movimento )

If Not IsNull(ls_Lote) and Trim(ls_Lote) <> "" Then
	This.of_AppendWhere_SubQuery("wme.nr_lote = '"+ls_Lote+"'", 2)	
End If

If Not IsNull(ll_agrupamento) and ll_agrupamento > 0 Then
	This.of_AppendWhere_SubQuery("s.nr_agrupamento_dev_compra = " + string(ll_agrupamento), 3)	
End If


If Not IsNull(ll_nr_nf) and ll_nr_nf > 0 Then
	This.of_AppendWhere_SubQuery("wme.nr_nf = " + string(ll_nr_nf), 2)	
End If


If ll_TipoMovimento<>0 Then 
	This.of_AppendWhere_SubQuery("wme.cd_tipo_movimento =" +String(ll_TipoMovimento), 2)	
//This.of_AppendWhere_SubQuery("wme.cd_tipo_movimento  in (9,13,19)", 2)
//This.of_AppendWhere_SubQuery("wme.cd_tipo_movimento  in (19)", 2)

End If

if trim(ls_cd_endereco) = '' then
	SetNull(ls_cd_endereco)
end if

if trim(ls_nr_matricula) = '' then
	SetNull(ls_nr_matricula)
end if

This.of_AppendWhere_SubQuery ('wb.cd_filial = ' + String (gl_cd_filial), 3)

string ls_query
ls_query = this.getsqlselect()



Return This.Retrieve(lvl_Produto, lvdt_Inicio,  lvdt_Termino, ll_Saldo, ll_Saldo_Movimento, ls_cd_endereco, ls_nr_matricula, ls_id_tipo_saldo, ls_id_entrada_saida)
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_Imprimir(False)
This.ivm_menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge164_consulta_movimento
integer x = 2711
integer y = 28
integer height = 256
string dataobject = "dw_ge164_lista_relatorio"
end type

type cb_1 from commandbutton within w_ge164_consulta_movimento
boolean visible = false
integer x = 2907
integer y = 1036
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "none"
end type

event clicked;datetime	ldt_dh_movimento, ldt_dh_inclusao_movimento, ldt_dh_validade
long ll_rowcount, ll_for, ll_qt_movimento, ll_qt_caixa_padrao, ll_cd_filial, ll_qt_saldo, ll_qt_saldo_inicial, ll_qt_saldo_movimento, &
	ll_nr_agrup
string ls_de_tipo_movimento, ls_cd_endereco_localizacao, ls_nr_lote, ls_de_origem_destino, ls_cd_fornecedor, ls_id_entrada_saida, &
	ls_id_cancelamento, ls_nm_usuario, ls_de_dados_adicionais, ls_json


gvo_aplicacao.ivs_tipo_log = 'JSON'

ll_Rowcount = dw_2.rowcount()

for ll_for = 1 to ll_rowcount
	ldt_dh_movimento = dw_2.GetItemDateTime(ll_for, 'dh_movimento') 
	ldt_dh_inclusao_movimento = dw_2.GetItemDateTime(ll_for, 'dh_inclusao_movimento') 
	ldt_dh_validade = dw_2.GetItemDateTime(ll_for, 'dh_validade') 
	ls_de_tipo_movimento	= dw_2.GetItemString(ll_for, 'de_tipo_movimento')
	ls_cd_endereco_localizacao	= dw_2.GetItemString(ll_for, 'cd_endereco_localizacao')
	ls_nr_lote	= dw_2.GetItemString(ll_for, 'nr_lote')
	ls_de_origem_destino	= dw_2.GetItemString(ll_for, 'de_origem_destino')
	ls_cd_fornecedor= dw_2.GetItemString(ll_for, 'cd_fornecedor')
	ls_id_entrada_saida= dw_2.GetItemString(ll_for, 'id_entrada_saida')
	ls_id_cancelamento= dw_2.GetItemString(ll_for, 'id_cancelamento')
	ls_nm_usuario= dw_2.GetItemString(ll_for, 'nm_usuario')
	ls_de_dados_adicionais= dw_2.GetItemString(ll_for, 'de_dados_adicionais')
	ll_qt_movimento	= dw_2.GetItemNumber(ll_for, 'qt_movimento')
	ll_qt_caixa_padrao	= dw_2.GetItemNumber(ll_for, 'qt_caixa_padrao')
	ll_cd_filial	= dw_2.GetItemNumber(ll_for, 'cd_filial')
	ll_qt_saldo	= dw_2.GetItemNumber(ll_for, 'qt_saldo')
	ll_qt_saldo_inicial	= dw_2.GetItemNumber(ll_for, 'qt_saldo_inicial')
	ll_qt_saldo_movimento	= dw_2.GetItemNumber(ll_for, 'qt_saldo_movimento')
	ll_nr_agrup	= dw_2.GetItemNumber(ll_for, 'nr_agrup')
	
	ls_json = &
    "{" + &
    '"dh_movimento":'              + uof_json_datetime(ldt_dh_movimento)             + "," + &
    '"dh_inclusao_movimento":'     + uof_json_datetime(ldt_dh_inclusao_movimento)    + "," + &
    '"dh_validade":'               + uof_json_datetime(ldt_dh_validade)              + "," + &
    '"de_tipo_movimento":'         + uof_json_value(ls_de_tipo_movimento)            + "," + &
    '"cd_endereco_localizacao":'   + uof_json_value(ls_cd_endereco_localizacao)      + "," + &
    '"nr_lote":'                   + uof_json_value(ls_nr_lote)                      + "," + &
    '"de_origem_destino":'         + uof_json_value(ls_de_origem_destino)            + "," + &
    '"cd_fornecedor":'             + uof_json_value(ls_cd_fornecedor)                + "," + &
    '"id_entrada_saida":'          + uof_json_value(ls_id_entrada_saida)             + "," + &
    '"id_cancelamento":'           + uof_json_value(ls_id_cancelamento)              + "," + &
    '"nm_usuario":'                + uof_json_value(ls_nm_usuario)                   + "," + &
    '"de_dados_adicionais":'       + uof_json_value(ls_de_dados_adicionais)          + "," + &
    '"qt_movimento":'              + uof_json_number(ll_qt_movimento)                + "," + &
    '"qt_caixa_padrao":'           + uof_json_number(ll_qt_caixa_padrao)             + "," + &
    '"cd_filial":'                 + uof_json_number(ll_cd_filial)                   + "," + &
    '"qt_saldo":'                  + uof_json_number(ll_qt_saldo)                    + "," + &
    '"qt_saldo_inicial":'          + uof_json_number(ll_qt_saldo_inicial)            + "," + &
    '"qt_saldo_movimento":'        + uof_json_number(ll_qt_saldo_movimento)          + "," + &
    '"nr_agrup":'                  + uof_json_number(ll_nr_agrup)                    + &
    "}"
	 
	 gvo_aplicacao.of_grava_log(ls_json)
next

gvo_aplicacao.of_fecha_log()
end event

