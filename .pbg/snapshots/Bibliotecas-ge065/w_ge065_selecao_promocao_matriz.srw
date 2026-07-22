HA$PBExportHeader$w_ge065_selecao_promocao_matriz.srw
forward
global type w_ge065_selecao_promocao_matriz from dc_w_selecao_generica
end type
end forward

global type w_ge065_selecao_promocao_matriz from dc_w_selecao_generica
integer x = 850
integer y = 436
integer width = 2921
integer height = 1660
string title = "GE065 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Promo$$HEX2$$e700f500$$ENDHEX$$es"
long backcolor = 80269524
end type
global w_ge065_selecao_promocao_matriz w_ge065_selecao_promocao_matriz

type variables
string ivs_tipo, ivs_somente_promocao_loja
string is_id_vending_machine
end variables

on w_ge065_selecao_promocao_matriz.create
call super::create
end on

on w_ge065_selecao_promocao_matriz.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

st_generica lst_param

if isvalid(message.powerobjectparm) Then
	if message.powerobjectparm.classname() = lst_param.classname() Then
		lst_param = message.powerobjectparm
		
		lvs_Parametro = lst_param.string_par[1]
		is_id_vending_machine = lst_param.string_par[2]
		
	end if
	
else
	lvs_Parametro = Message.StringParm
	setnull(is_id_vending_machine)
end if

ivs_Tipo = Left(lvs_Parametro, 1)

ivs_Somente_Promocao_Loja = Mid(lvs_Parametro, 2,1)

lvs_Parametro = Mid(lvs_Parametro, 3)

If lvs_Parametro <> "" Then
	dw_1.Object.nm_promocao_sos[1] = lvs_Parametro
End If

ivb_Pesquisa_Direta = True

//Se o sistema for GC e se a promo$$HEX2$$e700e300$$ENDHEX$$o for do tipo planograma
If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "GC" And ivs_Tipo = "P" Then
	If Not dw_2.of_ChangeDataObject("dw_ge065_lista_gc_planograma") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_changedataobject do evento open.", StopSign!)
		Return
	End If
	
	dw_2.Width = 3438
	gb_2.Width = 3493
	This.Width = 3561	
End If

dw_2.of_SetRowSelection()
end event

event ue_postopen;call super::ue_postopen;dw_2.SetFocus()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge065_selecao_promocao_matriz
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge065_selecao_promocao_matriz
integer x = 23
integer y = 276
integer width = 2862
integer height = 1164
long backcolor = 80269524
string text = "Lista de Promo$$HEX2$$e700f500$$ENDHEX$$es"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge065_selecao_promocao_matriz
integer x = 23
integer y = 8
integer width = 2862
integer height = 256
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge065_selecao_promocao_matriz
integer x = 46
integer y = 64
integer width = 2802
integer height = 184
string dataobject = "dw_ge065_selecao_matriz"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge065_selecao_promocao_matriz
integer x = 46
integer y = 336
integer width = 2802
integer height = 1076
string dataobject = "dw_ge065_lista_matriz"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao,&
	   lvs_SQL,&
	   lvs_Vigente,&
	   lvs_SQL2,&
	   ls_cd_promocao_sap,&
	   ls_in_sap

dw_1.AcceptText()

lvs_Descricao = Trim(dw_1.Object.nm_promocao_sos[1])
lvs_Vigente   = dw_1.Object.id_vigente[1]

ls_cd_promocao_sap = dw_1.object.cd_promocao_sap[1]
ls_in_sap = dw_1.object.in_sap[1]

If lvs_Descricao <> "" and Not IsNull(lvs_Descricao) Then
	If IsNumber(lvs_Descricao) Then
		This.of_AppendWhere("p.cd_promocao_sos = " + lvs_Descricao  )
	Else
		If ivs_Tipo <> "P" Then
			This.of_AppendWhere("p.nm_promocao_sos like '" + lvs_Descricao + "%'")
		Else			
			//Se a promo$$HEX2$$e700e300$$ENDHEX$$o for planograma, localiza pelo c$$HEX1$$f300$$ENDHEX$$digo da filial (se estiver no cluster), sen$$HEX1$$e300$$ENDHEX$$o procura no formato antigo (p.nm_promocao_sos like '" + lvs_Descricao + "%')
			//Para filiais que estiverem no cluster, o usu$$HEX1$$e100$$ENDHEX$$rio faz a pesquisa por "%013" e o sistema busca as promo$$HEX2$$e700f500$$ENDHEX$$es do tipo planograma para a filial 13
			If MidA(lvs_Descricao, 1, 1) = "%" And IsNumber(MidA(lvs_Descricao, 2)) Then
				This.of_AppendWhere("exists (select * from promocao_sos_filial f where f.cd_promocao_sos = p.cd_promocao_sos and (f.cd_filial = " + MidA(lvs_Descricao, 2) + &
											" or p.nm_promocao_sos like '" + lvs_Descricao + "%'))")
			Else
				This.of_AppendWhere("p.nm_promocao_sos like '" + lvs_Descricao + "%'")
			End If
		End If
	End If
End If

If ivs_Tipo <> 'T' Then
	If ivs_Tipo = 'N' Then
		This.of_AppendWhere("p.id_tipo_promocao in ( 'N','G','M') " )
	ElseIf ivs_Tipo = 'X' Then
		This.of_AppendWhere("p.id_tipo_promocao <> 'P' ")
	elseif ivs_Tipo = 'Q' Then
		This.of_AppendWhere("p.id_tipo_promocao in ( 'Q','J') " )
	Else		
		This.of_AppendWhere("p.id_tipo_promocao = '" + ivs_Tipo + "'")
	End If
End If

if ls_cd_promocao_sap <> '' and not isnull(ls_cd_promocao_sap) Then
	
	This.of_AppendWhere("p.cd_promocao_sap = '" + ls_cd_promocao_sap + "'" )
	
end if

if ls_in_sap = 'S' Then
	
	This.of_AppendWhere("p.cd_promocao_sap is not null" )
	
end if

if is_id_vending_machine <> '' and not isnull(is_id_vending_machine) Then
	This.of_AppendWhere("coalesce(p.id_vending_machine, 'N') = '" + is_id_vending_machine + "'" )
end if

lvs_SQL = "(select * from promocao_sos p1, parametro p2 " +&
		  "where p1.dh_inicio <= p2.dh_movimentacao " +& 
		  "		and (p1.dh_termino is null or p1.dh_termino >= p2.dh_movimentacao) " +&
		  "		and p.cd_promocao_sos = p1.cd_promocao_sos)"

If lvs_Vigente <> "T" Then
	// somente as vigentes
	If lvs_Vigente = "V" Then
		This.of_AppendWhere(" exists " + lvs_SQL)
	Else
		This.of_AppendWhere("not exists " + lvs_SQL)
	End If
End If

If ivs_Somente_Promocao_Loja = 'S' Then
	
	lvs_SQL2 = "(select x.cd_promocao_sos, count(*) " +&
		   	  "from promocao_sos_produto x " +&
			  "where x.cd_promocao_sos = p.cd_promocao_sos " +&
			  "and p.id_filial_altera_estoque = 'S' " +&
			  "group by x.cd_promocao_sos " +&
			  "having count(*) > 0) "
			  
	This.of_AppendWhere(" exists " + lvs_SQL2)
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge065_selecao_promocao_matriz
integer x = 1989
integer y = 1456
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Promocao

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Promocao = dw_2.Object.Cd_Promocao_SOS[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Promocao))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma promo$$HEX2$$e700e300$$ENDHEX$$o na lista.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge065_selecao_promocao_matriz
integer x = 2418
integer y = 1456
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Nulo

SetNull(lvs_Nulo)

CloseWithReturn(Parent, lvs_Nulo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge065_selecao_promocao_matriz
integer x = 1591
integer y = 1456
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge065_selecao_promocao_matriz
integer y = 1468
integer width = 955
long backcolor = 80269524
end type

