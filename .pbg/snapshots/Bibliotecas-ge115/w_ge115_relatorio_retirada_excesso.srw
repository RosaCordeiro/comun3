HA$PBExportHeader$w_ge115_relatorio_retirada_excesso.srw
forward
global type w_ge115_relatorio_retirada_excesso from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge115_relatorio_retirada_excesso from dc_w_selecao_lista_relatorio
string accessiblename = "Relat$$HEX1$$f300$$ENDHEX$$rio de retirada de excesso (GE115)"
integer width = 4896
integer height = 1872
string title = "GE115 - Relat$$HEX1$$f300$$ENDHEX$$rio de Retirada de Excesso"
end type
global w_ge115_relatorio_retirada_excesso w_ge115_relatorio_retirada_excesso

type variables
uo_Filial 								io_Filial_Origem	//GE009
uo_Filial 								io_Filial_Destino	//GE009
uo_Produto 							io_Produto			//GE001
uo_ge115_remanejamento		io_Remanejamento
end variables

forward prototypes
public function boolean wf_obtem_tipo_remanejamento (long al_remanejamento, ref string as_tipo)
public subroutine wf_muda_dw_2 (string as_tipo)
end prototypes

public function boolean wf_obtem_tipo_remanejamento (long al_remanejamento, ref string as_tipo);SELECT COALESCE (id_remanejamento_via_prestes, 'N')
  INTO :as_tipo
  FROM remanejamento
 WHERE cd_remanejamento = :al_remanejamento
 USING SQLCA;

Choose case SQLCA.SQLCode
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Remanejamento n$$HEX1$$e300$$ENDHEX$$o encontrado!')
		Return False
	case is < 0
		SQLCA.of_Msgdberror ('Erro ao verificar o tipo de remanejamento!')
		Return False
End choose

If as_tipo = 'S' then
	as_tipo = 'P'
End if

Return True
end function

public subroutine wf_muda_dw_2 (string as_tipo);If IsNull (as_tipo) or as_tipo = 'N' then
	dw_1.Object.id_tipo_remanejamento [1] = 'N'
	dw_2.of_ChangeDataObject ('dw_ge115_lista_resultado', True)
else
	dw_1.Object.id_tipo_remanejamento [1] = 'P'
	dw_2.of_ChangeDataObject ('dw_ge115_lista_resultado_prestes', True)
End if
end subroutine

on w_ge115_relatorio_retirada_excesso.create
call super::create
end on

on w_ge115_relatorio_retirada_excesso.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;io_Filial_Origem		= Create uo_Filial
io_Filial_Destino		= Create uo_Filial
io_Produto				= Create uo_Produto
io_Remanejamento	= Create uo_Ge115_Remanejamento
end event

event close;call super::close;Destroy( io_Filial_Origem )
Destroy( io_Filial_Destino )
Destroy( io_Produto )
Destroy( io_Remanejamento )
end event

event ue_postopen;call super::ue_postopen;Long ll_Filial
Long ll_Filial_Matriz

gf_Filiais_Parametro( ref ll_Filial, ref ll_Filial_Matriz )

If ll_Filial <> ll_Filial_Matriz Then
	io_Filial_Origem.of_Localiza_Codigo( ll_Filial )
	
	If io_Filial_Origem.Localizada Then
		dw_1.Object.Cd_Filial_Origem	[ 1 ] = io_Filial_Origem.Cd_Filial
		dw_1.Object.Nm_Filial_Origem	[ 1 ] = io_Filial_Origem.Nm_Fantasia
	End If
	
	dw_1.Object.Cd_Filial_Origem.Protect	= 1
	dw_1.Object.Nm_Filial_Origem.Protect	= 1
End If

ivm_Menu.ivb_Permite_Imprimir	=	True
end event

event ue_retrieve;//OverRide

dw_2.Event getFocus( )

dw_2.Event ue_Retrieve()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge115_relatorio_retirada_excesso
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge115_relatorio_retirada_excesso
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge115_relatorio_retirada_excesso
integer x = 14
integer y = 352
integer width = 4832
integer height = 1304
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge115_relatorio_retirada_excesso
integer x = 14
integer y = 12
integer width = 3694
integer height = 332
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge115_relatorio_retirada_excesso
integer x = 46
integer y = 76
integer width = 3639
integer height = 240
string dataobject = "dw_ge115_selecao_remanejamento"
end type

event dw_1::ue_key;call super::ue_key;dw_1.AcceptText()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case	"nm_filial_origem"
			io_Filial_Origem.of_Localiza_Filial( This.GetText( ) )
			
			dw_1.Object.Nm_Filial_Origem	[1]	= io_Filial_Origem.Nm_Fantasia
			dw_1.Object.Cd_Filial_Origem	[1]	= io_Filial_Origem.Cd_Filial
				
			Case "nm_filial_destino"
				io_Filial_Destino.of_Localiza_Filial( This.GetText( ) )
				
				dw_1.Object.Nm_Filial_Destino[1] = io_Filial_Destino.Nm_Fantasia
				dw_1.Object.Cd_Filial_Destino [1] = io_Filial_Destino.Cd_Filial
				
			Case "desc_produto"
				io_Produto.of_Localiza_Produto( This.GetText( ) )

				dw_1.Object.Desc_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
				dw_1.Object.Cd_Produto		[1] = io_Produto.Cd_Produto				
				
			Case "de_remanejamento"
				io_Remanejamento.of_Localiza ( This.GetText( ) )
				
				dw_1.Object.De_Remanejamento[1] = io_Remanejamento.is_De_Remanejamento
				dw_1.Object.Cd_Remanejamento[1] = io_Remanejamento.il_Cd_Remanejamento
				
				If io_remanejamento.ib_localizado then
					wf_muda_dw_2 (io_remanejamento.is_id_remanejamento_via_prestes)
				End if
				
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.of_RestoreOriginalSql( )

Choose case dwo.Name
	case "desc_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			io_Produto.Of_Inicializa()
			
			dw_1.Object.Desc_Produto	[ 1 ] = io_Produto.ivs_Descricao_Apresentacao_Venda
			dw_1.Object.Cd_Produto		[ 1 ] = io_Produto.Cd_Produto
		End If
		
	case 'id_tipo_remanejamento'
		wf_muda_dw_2 (data)
		
End choose

Return AncestorReturnValue
end event

event dw_1::editchanged;call super::editchanged;Long ll_Nulo

SetNull( ll_Nulo )

dw_2.Of_RestoreOriginalSql()

If Data = "" Or IsNull( Data ) Then
	Choose Case dwo.Name
		Case "nm_filial_origem"
			This.Object.Cd_Filial_Origem[1] = ll_Nulo
			
		Case "nm_filial_destino"
			This.Object.Cd_Filial_Destino[1] = ll_Nulo
			
		Case "de_remanejamento"
			This.Object.Cd_Remanejamento[1] = ll_Nulo

	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid( io_Produto ) Then
	If IsNull( dw_1.Object.Desc_Produto[ 1 ] ) Then
		io_Produto.of_Inicializa( )		
	End If
	
	dw_1.Object.Desc_Produto	[ 1 ] = io_Produto.ivs_Descricao_Apresentacao_Venda
	dw_1.Object.Cd_Produto		[ 1 ] = io_Produto.Cd_Produto
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge115_relatorio_retirada_excesso
integer x = 41
integer y = 408
integer width = 4773
integer height = 1232
string dataobject = "dw_ge115_lista_resultado"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Periodo_De
DateTime ldh_Periodo_Ate

Long ll_Filial_Origem
Long ll_Filial_Destino
Long ll_Remanejamento
Long ll_Produto

String ls_Situacao, &
			ls_Tipo

dw_1.AcceptText( )

ldh_Periodo_De		= dw_1.Object.Dh_Periodo_De	[ 1 ]
ldh_Periodo_Ate	= dw_1.Object.Dh_Periodo_Ate[ 1 ]

ll_Filial_Origem		= dw_1.Object.Cd_Filial_Origem		[ 1 ]
ll_Filial_Destino		= dw_1.Object.Cd_Filial_Destino		[ 1 ]
ls_Situacao			= dw_1.Object.Id_Situacao				[ 1 ]
ll_Remanejamento	= dw_1.Object.Cd_Remanejamento	[ 1 ]
ll_Produto			= dw_1.Object.Cd_Produto				[ 1 ]
ls_Tipo           = dw_1.Object.id_tipo_remanejamento [ 1 ]

If Not IsNull( ldh_Periodo_De ) And Not IsDate( String( ldh_Periodo_De, "dd/mm/yyyy" ) ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dh_periodo_de")
	Return -1
End If

If Not IsNull( ldh_Periodo_Ate ) And Not IsDate( String( ldh_Periodo_Ate, "dd/mm/yyyy" ) ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dh_periodo_ate")
	Return -1
End If

If Not IsNull( ll_Filial_Origem ) Then
	This.of_AppendWhere( "rr.cd_filial_origem = " + String( ll_Filial_Origem ) )
End If

If Not IsNull( ll_Filial_Destino ) Then
	This.of_AppendWhere( "rr.cd_filial_destino = " + String( ll_Filial_Destino ))
End If

If ls_Situacao <> "T" Then
	This.of_AppendWhere( "rr.id_situacao = '" + ls_Situacao + "'")
End If

If Not IsNull( ll_Remanejamento ) Then
	This.of_AppendWhere( "rr.cd_remanejamento = " + String( ll_Remanejamento ))
//	If ls_Tipo = 'T' then
//		If not wf_obtem_tipo_remanejamento (ll_Remanejamento, Ref ls_Tipo) then
//			Return -1
//		End if
//	End if
//	If ls_Tipo = 'P' then
////		This.of_AppendWhere( "rr.cd_remanejamento = " + String( ll_Remanejamento ))
//	End if
End If

If ldh_Periodo_De > ldh_Periodo_Ate Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_periodo_de")
	Return -1	
End If

If Not IsNull( ldh_Periodo_Ate ) Then
	This.of_AppendWhere( "r.dh_calculo <= '" + String( ldh_Periodo_Ate, 'yyyymmdd' ) + "'" )
End If

If Not IsNull( ldh_Periodo_De ) Then
	This.of_AppendWhere( "r.dh_calculo >= '" + String( ldh_Periodo_De, 'yyyymmdd' ) + "'")
End If

If Not IsNull( ll_Produto ) Then
	This.of_AppendWhere( "rr.cd_produto = " + String( ll_Produto ))
End If

//Choose case ls_Tipo
//	case 'N'				//remanejamentos normais
//		This.of_AppendWhere ("(r.id_remanejamento_via_prestes IS NULL OR r.id_remanejamento_via_prestes = 'N')")
//	case 'P'				//remanejamentos de prestes
//		This.of_AppendWhere ("r.id_remanejamento_via_prestes = 'S'")
//End choose

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If AncestorReturnValue > 0 Then
	ivm_Menu.mf_SalvarComo( True )
Else
	ivm_Menu.mf_SalvarComo( False )
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge115_relatorio_retirada_excesso
integer x = 2706
integer y = 1212
integer width = 265
integer height = 224
string dataobject = "dw_ge115_relatorio_resultado"
end type

event dw_3::ue_printimmediate;call super::ue_printimmediate;This.groupcalc( )
end event

event dw_3::ue_preprint;call super::ue_preprint;This.groupcalc( )

Return AncestorReturnValue
end event

