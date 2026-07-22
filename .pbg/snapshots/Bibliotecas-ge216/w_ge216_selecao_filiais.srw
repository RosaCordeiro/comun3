HA$PBExportHeader$w_ge216_selecao_filiais.srw
forward
global type w_ge216_selecao_filiais from dc_w_selecao_generica
end type
type st_confirmar from statictext within w_ge216_selecao_filiais
end type
type cb_planilha from commandbutton within w_ge216_selecao_filiais
end type
end forward

global type w_ge216_selecao_filiais from dc_w_selecao_generica
integer width = 2949
integer height = 1760
string title = "GE216 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Filiais Personalizada"
st_confirmar st_confirmar
cb_planilha cb_planilha
end type
global w_ge216_selecao_filiais w_ge216_selecao_filiais

type variables
uo_ge216_filiais	iuo_filiais
uo_filial				ivo_filial		//GE009
uo_Cidade			ivo_Cidade	//GE008

Boolean ivb_Check
end variables

forward prototypes
public subroutine wf_insere_uf_default ()
public subroutine wf_insere_cidade_default ()
public subroutine wf_lista_cidades (string as_uf)
public subroutine wf_insere_rede_default ()
public function boolean wf_marca_filiais_planilha (dc_uo_ds_base ads)
public subroutine wf_insere_regiao_default ()
end prototypes

public subroutine wf_insere_uf_default ();If gvo_Aplicacao.ivs_database <> 'POSTGRESQL' Then

	DataWindowChild lvds_UF
	
	lvds_UF = dw_1.of_InsertRow_DDDW("cd_uf")
	//
	lvds_UF.SetItem(1, "cd_unidade_federacao", "TD")
	lvds_UF.SetItem(1, "nm_unidade_federacao", "TODAS")
	//
	dw_1.Object.cd_uf[1] = "TD"
End If

end subroutine

public subroutine wf_insere_cidade_default ();DataWindowChild lvds_UF

lvds_UF = dw_1.of_InsertRow_DDDW("cd_cidade")
//
lvds_UF.SetItem(1, "cd_cidade", 0)
lvds_UF.SetItem(1, "nm_cidade", "TODAS")
//
dw_1.Object.cd_cidade[1] = 0

end subroutine

public subroutine wf_lista_cidades (string as_uf);DataWindowChild lvdwc

String lvs_SQL, lvs_SQL_Original

If dw_1.GetChild("cd_cidade", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
			
	lvs_SQL_Original = 	"SELECT distinct c.cd_cidade  , " +&
								"c.nm_cidade " +&
								"FROM cidade c, filial f  " +&
								"where c.cd_cidade	= f.cd_cidade " +&
								"and f.id_situacao = 'A' "
	lvdwc.SetSQLSelect(lvs_SQL_Original)
	lvdwc.Retrieve()
	
	If as_UF <> "TD" Then
		lvs_SQL = lvdwc.GetSQLSelect()
		lvs_SQL = lvs_SQL + "and c.cd_unidade_federacao = '" + as_UF + "'"
		lvdwc.SetSQLSelect(lvs_SQL)
		lvdwc.Retrieve()
	End If
	
	wf_Insere_Cidade_Default()
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild cidade.")
End If
end subroutine

public subroutine wf_insere_rede_default ();DataWindowChild lvds_UF

lvds_UF = dw_1.of_InsertRow_DDDW("id_rede")
//
lvds_UF.SetItem(1, "vl_parametro", "TD")
lvds_UF.SetItem(1, "rede", "TODAS")
//
dw_1.Object.id_rede[1] = "TD"

end subroutine

public function boolean wf_marca_filiais_planilha (dc_uo_ds_base ads);Long ll_Linha
Long ll_Find
Long ll_Primeira

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	ll_Find = ads.Find("cd_filial = " + String(dw_2.Object.Cd_Filial[ll_Linha]), 1, dw_2.RowCount())
	
	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da data store. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_marca_filiais_planilha.", StopSign!)
		Return False
	End If
	
	//Se a filial da dw_2 n$$HEX1$$e300$$ENDHEX$$o estiver na planilha, desmarca a filial da dw_2
	If ll_Find = 0 Then
		dw_2.Object.Id_Selecionar[ll_Linha] = "N"
	End If
Next

SetNull(ll_Find)

ll_Find = dw_2.Find("id_selecionar = 'S'", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da dw_2. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_marca_filiais_planilha.")
	Return False
End If

If ll_Find > 0 Then
	dw_2.Event ue_Pos(ll_Find, "id_selecionar")
End If

Return True
end function

public subroutine wf_insere_regiao_default ();Integer 	lvi_Retorno, &
        		lvi_Linha

Long lvl_Regiao

DataWindowChild lvdwc

lvi_Retorno = dw_1.GetChild("cd_regiao", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_regiao", 0)
		lvdwc.SetItem(lvi_Linha, "de_regiao", "TODAS")
		
		select cd_regiao
		Into :lvl_Regiao
		From regiao
		Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
		Using SQLCa;
		
		If SQLCa.SQLCode = 0 Then
			dw_1.Object.cd_regiao[1] = lvl_Regiao
		Else
			dw_1.Object.cd_regiao[1] = 0	
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da regi$$HEX1$$e300$$ENDHEX$$o default.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If
end subroutine

on w_ge216_selecao_filiais.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
this.cb_planilha=create cb_planilha
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
this.Control[iCurrent+2]=this.cb_planilha
end on

on w_ge216_selecao_filiais.destroy
call super::destroy
destroy(this.st_confirmar)
destroy(this.cb_planilha)
end on

event ue_postopen;call super::ue_postopen;wf_insere_uf_default()
wf_insere_cidade_default()
wf_Insere_Rede_Default()
wf_Insere_Regiao_Default()
end event

event open;call super::open;iuo_filiais 	= Create uo_ge216_filiais
ivo_Filial		= Create uo_Filial
ivo_Cidade	= Create uo_Cidade

iuo_filiais = Message.PowerObjectParm
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Cidade)
end event

event ue_preopen;call super::ue_preopen;If gvo_Aplicacao.ivs_database = 'POSTGRESQL' Then
	dw_1.of_Changedataobject( "dw_ge216_selecao_filial" )
	dw_2.of_Changedataobject( "dw_ge216_lista_filial" )
Else
	dw_1.of_Changedataobject( "dw_ge216_selecao" )
	dw_2.of_Changedataobject( "dw_ge216_lista" )
End If

dw_2.of_SetRowSelection("if (id_selecionar = ~"S~", rgb(0, 255, 0), rgb(255, 255, 255) )","")
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge216_selecao_filiais
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge216_selecao_filiais
integer y = 448
integer width = 2862
integer height = 1048
string text = "Filiais"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge216_selecao_filiais
integer y = 0
integer width = 2747
integer height = 436
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge216_selecao_filiais
integer x = 55
integer y = 72
integer width = 2688
integer height = 348
string dataobject = "dw_ge216_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If lvs_Coluna = 'cd_uf' Then
	wf_Lista_Cidades(data)
End If

If lvs_Coluna = "nm_fantasia" Then

	If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial		[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
		End If	
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	If This.GetColumnName() = "nm_fantasia" Then
		
		ivo_Filial.of_Localiza_Filial(This.GetText())
				
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial		[1]	= ivo_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1]	= ivo_Filial.Nm_Fantasia	
			
			If ivo_Filial.cd_Filial = 534 Then
				
				ivo_Cidade.of_Localiza_Codigo(ivo_Filial.cd_cidade)
				
				If Not ivo_Cidade.Localizada Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cidade n$$HEX1$$e300$$ENDHEX$$o localizada.")
					Return
				End If
					
				dw_2.Object.Cd_Filial						[1]	= ivo_Filial.Cd_Filial
				dw_2.Object.Nm_Fantasia				[1]	= ivo_Filial.Nm_Fantasia
				dw_2.OBject.id_rede_filial				[1]	= "N/D"
				dw_2.Object.nm_cidade					[1]	= ivo_Filial.Nm_Cidade
				dw_2.Object.cd_unidade_federacao	[1]	= ivo_Cidade.Cd_Unidade_Federacao
				
				dw_2.Object.id_selecionar				[1]	= "S"
				
				cb_Pesquisar.Default = False
				
				cb_Selecionar.Default = False
				
				cb_Selecionar.Enabled = True
											
			End If
			
			
		End If
	End If
	
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
End If
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge216_selecao_filiais
event ue_mousemove pbm_mousemove
integer y = 528
integer width = 2793
integer height = 936
string dataobject = "dw_ge216_lista"
end type

event dw_2::ue_mousemove;If This.RowCount() > 0 Then
	If xpos >= st_confirmar.X and (xpos <= st_confirmar.x + st_confirmar.Width) and &
		  ypos >= 0 and ypos < 40 Then	 
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
End If
end event

event dw_2::ue_recuperar;// OverRide

String	lvs_UF,&
		lvs_Rede,&
		lvs_Beauty,&
		lvs_24horas,&
		lvs_AbreDomingo,&
		lvs_fpb
		
Long 	lvl_Cidade,&
		lvl_Filial,&
		lvl_Insert, &
		ll_Regiao

dw_1.AcceptText()

lvs_UF 				= dw_1.Object.cd_uf					[1]
lvs_Rede				= dw_1.Object.id_rede				[1]
lvl_Cidade			= dw_1.Object.cd_cidade			[1]
lvl_Filial				= dw_1.Object.cd_filial				[1]
lvs_Beauty			= dw_1.Object.id_loja_beauty		[1]
lvs_24Horas			= dw_1.Object.id_24horas			[1]
lvs_AbreDomingo	= dw_1.Object.id_abre_domingo	[1]
ll_Regiao				= dw_1.Object.Cd_Regiao			[1]
lvs_fpb				= dw_1.Object.id_programa_fpb	[1]

If lvs_Beauty = 'S' Then
	dw_2.of_AppendWhere("f.cd_filial in (select cd_filial from parametro_loja where cd_parametro = 'ID_LOJA_BEAUTY_CLUB' " +&
			  						"and vl_parametro = 'S')")
End If

If lvs_fpb = 'S' Then
	dw_2.of_AppendWhere("f.cd_filial in (select cd_filial from parametro_loja where cd_parametro = 'ID_POSSUI_VIDALINK' " +&
			  						"and vl_parametro = 'S')")
End If

If lvs_UF <> 'TD' Then
	dw_2.of_AppendWhere("c.cd_unidade_federacao = '" + lvs_UF + "'")
End If

If lvs_Rede <> 'TD' Then
	dw_2.of_AppendWhere("f.id_rede_filial = '" + lvs_Rede + "'")
End If

If lvl_Cidade <> 0 Then
	dw_2.of_AppendWhere("c.cd_cidade = " + String(lvl_Cidade))
End If

If Not IsNull(lvl_Filial) Then
//	If lvl_Filial = 534 Then
//		lvl_Insert = dw_2.InsertRow(0)
//		dw_2.Object.cd_filial			[lvl_Insert] = 534
//		dw_2.Object.nm_fantasia	[lvl_Insert] = "ESTOQUE CENTRAL - PERINI"
//	Else
		dw_2.of_AppendWhere("f.cd_filial = " + String(lvl_Filial))
//	End If
End If

If lvs_24Horas = 'S' Then
	dw_2.of_AppendWhere("f.id_24horas = 'S'")
End If

If lvs_AbreDomingo = 'S' Then
	dw_2.of_AppendWhere("f.id_abre_domingo = 'S'")
End If

If ll_Regiao > 0 Then
	dw_2.of_AppendWhere("f.cd_regiao = " + String(ll_Regiao))
End If

Return dw_2.Retrieve()
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

//This.of_SetRowSelection()

//if( id_selecionadar = 'S', rgb(255, 255, 255), rgb(0, 0, 0))
//rgb(255, 255, 0), rgb(255, 255, 255)

This.of_SetRowSelection("if (id_selecionar = ~"S~", rgb(0, 255, 0), rgb(255, 255, 255) )","")
end event

event dw_2::clicked;// OverRide
If dwo.name = 'id_imagem' Then Return

If Row > 0 Then This.SetRow(Row)

String lvs_titulo
String lvs_coluna
String lvs_sort_atual
String lvs_Cabecalho

Integer lvi_tamanho

If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then

	lvs_titulo 		= This.GetObjectAtPointer()
	lvs_Cabecalho  = This.GetBandAtPointer()
		
	If LeftA(lvs_Cabecalho, 6) = "header" Then
		
		lvi_tamanho = PosA(lvs_titulo,CharA(9))-1
		
		If lvi_tamanho > 0 Then
			
			lvs_titulo = LeftA(lvs_titulo, lvi_tamanho)
			
			This.of_Marca_Coluna_Ativa_Ordenacao(lvs_titulo)
			
			lvs_Coluna = LeftA(lvs_Titulo,lvi_Tamanho -2 )
					
			lvs_sort_atual = This.Object.DataWindow.Table.Sort
			
			lvi_tamanho 	= LenA(lvs_sort_atual) - 2
			lvs_titulo  	= LeftA(lvs_sort_atual, lvi_tamanho)
			
			If lvs_coluna = lvs_titulo Then
				
				lvs_sort_atual = RightA(lvs_sort_atual, 1)
				
				If lvs_sort_atual = "A" Then
					lvs_sort_atual = " D"
				Else
					lvs_sort_atual = " A"
				End If
				
				lvs_coluna = lvs_coluna + lvs_sort_atual
			Else
				lvs_coluna += " A"				
			End If
			
			This.SetSort(lvs_coluna)
			This.Sort()
			This.GroupCalc()
		End If	
		
	End If
	
End If	
end event

event dw_2::doubleclicked;call super::doubleclicked;String lvs_Incluir_Excluir,&
	   lvs_Marcacao

Integer lvi_Row
		  
If dwo.Name = "id_imagem" Then
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check 	 = False
		// Excluir
		lvs_Incluir_Excluir = "E"
	Else
		lvs_Marcacao = 'S'
		ivb_Check 	 = True
		// Incluir
		lvs_Incluir_Excluir = "I"
	End If
	
	For lvi_Row = 1 To This.RowCount()
		This.Object.Id_selecionar[lvi_Row] = lvs_Marcacao
	Next
	
End If


end event

event dw_2::itemchanged;call super::itemchanged;//Long lvl_Lojas
//
//If dwo.name = 'id_selecionar' Then
//	lvl_Lojas = dw_2.GetItemNumber(dw_2.RowCount(), "filial_total")
//	
//	If lvl_Lojas = 1 Then
//		st_Mensagem2.Text = "1 loja selecionada."
//	Else
//		st_Mensagem2.Text = string(lvl_Lojas) + " lojas selecionadas."
//	End If
//End If


end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge216_selecao_filiais
integer x = 2139
integer y = 1536
integer width = 357
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Lojas, lvl_Linha, lvl_Contador

lvl_Lojas = dw_2.GetItemNumber(dw_2.RowCount(), "filial_total")
	
If lvl_Lojas > 0 Then
		
		For lvl_Linha = 1 To dw_2.RowCount()
			
			If dw_2.Object.id_selecionar[lvl_Linha] = 'S' Then
				
				lvl_Contador ++
				
				iuo_filiais.ivl_filial			[lvl_Contador] = dw_2.Object.cd_filial		[lvl_Linha]
				iuo_filiais.cd_filial			[lvl_Contador] = dw_2.Object.cd_filial		[lvl_Linha]
				iuo_filiais.nm_fantasia	[lvl_Contador] = dw_2.Object.nm_fantasia	[lvl_Linha]
				
				If lvl_Contador = 1 Then
					iuo_filiais.ivs_filiais =  String(dw_2.Object.cd_filial[lvl_Linha])
				Else
					iuo_filiais.ivs_filiais =  iuo_filiais.ivs_filiais + ", " + String(dw_2.Object.cd_filial[lvl_Linha])
				End If
				
			End If
			
		Next
		
		If lvl_Contador = dw_2.RowCount() Then
			iuo_filiais.ib_todas_filiais = True
		Else
			iuo_filiais.ib_todas_filiais = False
		End If
				
		CloseWithReturn ( Parent, dw_2.GetItemNumber(dw_2.RowCount(), "filial_total") )
		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma loja.")
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge216_selecao_filiais
integer x = 2537
integer y = 1536
integer width = 357
end type

event cb_cancelar::clicked;call super::clicked;//Close(Parent)

CloseWithReturn ( Parent, 0 )
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge216_selecao_filiais
integer x = 1710
integer y = 1536
integer width = 357
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge216_selecao_filiais
integer y = 1536
integer width = 763
integer height = 100
end type

type st_confirmar from statictext within w_ge216_selecao_filiais
boolean visible = false
integer x = 1746
integer y = 468
integer width = 855
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
boolean enabled = false
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
boolean focusrectangle = false
end type

type cb_planilha from commandbutton within w_ge216_selecao_filiais
integer x = 837
integer y = 1536
integer width = 658
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Filtrar Filial via Planilha"
end type

event clicked;Long ll_Find

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	ll_Find = dw_2.Find("id_selecionar = 'S'", 1, dw_2.RowCount())
	
	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
		Return -1
	End If
	
	//Se tem filial marcada
	If ll_Find> 0 Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Se continuar TODAS as filiais marcadas atualmente ser$$HEX1$$e300$$ENDHEX$$o desmarcadas e ser$$HEX1$$e300$$ENDHEX$$o consideradas somente filiais que estiverem na planilha." + &
							"~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then Return -1
	End If
End If

//Inicializa os objetos e par$$HEX1$$e200$$ENDHEX$$metros de sele$$HEX2$$e700e300$$ENDHEX$$o da tela
ivo_filial.of_Inicializa()
ivo_Cidade.of_Inicializa()

dw_1.Object.Id_Rede			[1] = "TD"
dw_1.Object.Cd_Filial			[1] = ivo_Filial.Cd_Filial
dw_1.Object.Nm_Fantasia	[1] = ivo_Filial.Nm_Fantasia
dw_1.Object.Cd_UF			[1] = "TD"
dw_1.Object.Cd_Cidade		[1] = 0

dw_1.Object.Id_Loja_Beauty	[1] = "N"
dw_1.Object.Id_24horas			[1] = "N"
dw_1.Object.Id_Abre_Domingo	[1] = "N"

dw_2.Event ue_Retrieve()

Try

	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge216_filial_selec_planilha") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a data store 'ds_ge216_filial_selec_planilha'.", StopSign!)
		Return -1
	End If
	
	OpenWithParm(w_ge216_seleciona_filial_planilha, lds)
	
	lds = Message.PowerObjectParm
		
	If lds.RowCount() > 0 Then
		wf_Marca_Filiais_Planilha(lds)
	End If

Finally	
	If IsValid(lds) Then Destroy(lds)
End Try
end event

