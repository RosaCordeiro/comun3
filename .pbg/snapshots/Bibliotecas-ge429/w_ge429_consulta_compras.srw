HA$PBExportHeader$w_ge429_consulta_compras.srw
forward
global type w_ge429_consulta_compras from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge429_consulta_compras from dc_w_cadastro_selecao_lista
integer x = 5
integer y = 16
integer width = 4343
integer height = 2164
string title = "GE429 - Consulta de Pedidos de Fornecedores por Comprador"
end type
global w_ge429_consulta_compras w_ge429_consulta_compras

type variables
uo_ge149_Comprador ivo_comprador
end variables

forward prototypes
public subroutine wf_localiza_matricula ()
end prototypes

public subroutine wf_localiza_matricula ();String lvs_Nulo

dw_1.AcceptText()

ivo_comprador.of_Localiza_Comprador(dw_1.GetText())

If ivo_comprador.Localizado Then
	
	dw_1.Object.nr_matricula[1] = ivo_comprador.nr_matricula
	dw_1.Object.nm_comprador[1] = ivo_comprador.nm_usuario	
Else
	
	SetNull(lvs_Nulo)
	
	dw_1.Object.nr_matricula[1] = lvs_Nulo
	dw_1.Object.nm_comprador[1] = ''

End If
end subroutine

on w_ge429_consulta_compras.create
call super::create
end on

on w_ge429_consulta_compras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Parametro

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

dw_1.Object.Dt_Inicio		[1] = lvdt_Parametro
dw_1.Object.Dt_Termino	[1] = lvdt_Parametro

This.ivm_Menu.ivb_Permite_Excluir = False

ivo_comprador = Create uo_ge149_Comprador

dw_2.ivo_Controle_Menu.of_SalvarComo(True)
dw_2.ivo_Controle_Menu.of_Incluir(False)
end event

event close;call super::close;Destroy(ivo_comprador)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge429_consulta_compras
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge429_consulta_compras
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge429_consulta_compras
integer x = 55
integer y = 80
integer width = 1906
integer height = 244
string dataobject = "dw_ge429_selecao"
end type

event dw_1::ue_key;String lvs_coluna
If key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case 'nm_comprador'			
			wf_Localiza_Matricula()		
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;String lvs_Nulo

dw_2.Event ue_Reset()

Choose Case dwo.Name 
	Case "nm_comprador"
	
		SetNull(lvs_Nulo)
	
		If Data = "" Or IsNull(Data) Then
			This.Object.nr_matricula[1] = lvs_nulo
			Return 0
		End If	
		
		If Data <> ivo_comprador.nm_usuario Then Return 1
		
End Choose
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge429_consulta_compras
integer x = 23
integer y = 364
integer width = 4229
integer height = 1584
integer weight = 700
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge429_consulta_compras
integer x = 23
integer width = 1975
integer height = 344
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge429_consulta_compras
integer x = 55
integer y = 420
integer width = 4174
integer height = 1512
string dataobject = "dw_ge429_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_recuperar;//Override

Date lvdt_Inicio, &
     lvdt_Termino

Long lvl_Linhas

String lvs_usuario

dw_1.AcceptText()

lvdt_Inicio		= dw_1.Object.Dt_Inicio 		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]
lvs_usuario		= dw_1.Object.nr_matricula	[1]

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

Open(w_aguarde)
w_aguarde.title="Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es, aguarde..."

lvl_Linhas = This.Retrieve(lvdt_Inicio, lvdt_Termino)

Close(w_aguarde)
Return lvl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_nr_matricula
String ls_Id_Pedido

dw_1.accepttext()

lvs_nr_matricula	= dw_1.Object.nr_matricula	[1]
ls_Id_Pedido		= dw_1.Object.Id_Pedido	[1]

If Not IsNull(lvs_nr_matricula) Then	
	This.of_AppendWhere("pc.nr_matricula_cadastramento = '" + lvs_nr_matricula+"'")	
End If

Choose Case ls_Id_Pedido
		
	Case "N"
		This.of_AppendWhere("(pc.id_pbm = 'N' or pc.id_pbm is null) and (pc.id_farmacia_governo = 'N' or pc.id_farmacia_governo is null)")
		
	Case "R"
		This.of_AppendWhere("pc.id_pbm = 'S'")
		
	Case "F"
		This.of_AppendWhere("pc.id_farmacia_governo = 'S'")
		
	Case "B"
		This.of_AppendWhere("pc.id_atende_falta_pedido_uf = 'BA'")
		
End Choose

Return 1
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[], &
	   lvs_Bloqueio[]
	   
lvs_Coluna = {"nr_matricula","cd_fornecedor","nm_fantasia","cd_produto","de_produto",&
              "de_apresentacao","nm_fantasia_1","de_condicao","id_situacao","qt_pedida",&
			  "qt_recebida","vl_preco_unitario","pc_desconto_produto","pc_desconto_pedido",&
			  "vl_total"}

lvs_Nome = {"Matricula","Fornecedor","Nome fantasia","C$$HEX1$$f300$$ENDHEX$$digo produto","Descri$$HEX2$$e700e300$$ENDHEX$$o produto",&
              "Descri$$HEX2$$e700e300$$ENDHEX$$o apresentacao","Nome fantasia_1","Condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento","Situa$$HEX2$$e700e300$$ENDHEX$$o","Qtde pedida",&
			  "Qtde recebida","Valor de f$$HEX1$$e100$$ENDHEX$$brica","Desconto produto","Desconto pedido",&
			  "Valor total"}
				

lvs_Bloqueio = {"N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N", "N"}
				
This.of_SetSort(lvs_Coluna, lvs_Nome, lvs_Bloqueio)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.ivb_Ordena_Colunas = True
end event

