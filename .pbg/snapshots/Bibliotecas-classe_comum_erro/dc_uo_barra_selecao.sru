HA$PBExportHeader$dc_uo_barra_selecao.sru
forward
global type dc_uo_barra_selecao from userobject
end type
type cd_move_um_baixo from commandbutton within dc_uo_barra_selecao
end type
type cd_move_ultima_linha from commandbutton within dc_uo_barra_selecao
end type
type cd_move_primeira_linha from commandbutton within dc_uo_barra_selecao
end type
type cd_move_um_cima from commandbutton within dc_uo_barra_selecao
end type
end forward

global type dc_uo_barra_selecao from userobject
integer width = 526
integer height = 616
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event type boolean ue_permite_deselecionar ( integer ai_linha )
event type boolean ue_permite_selecionar ( integer ai_linha )
event ue_move_um_cima ( )
event ue_move_um_baixo ( )
event ue_move_primeira_linha ( )
event ue_move_ultima_linha ( )
cd_move_um_baixo cd_move_um_baixo
cd_move_ultima_linha cd_move_ultima_linha
cd_move_primeira_linha cd_move_primeira_linha
cd_move_um_cima cd_move_um_cima
end type
global dc_uo_barra_selecao dc_uo_barra_selecao

type variables
dc_uo_dw_base idw

Protected:
Boolean ivb_Habilitado = True
end variables

forward prototypes
public subroutine of_habilita ()
public subroutine of_limpa_dw_destino ()
public subroutine of_habilita_controle (boolean pb_habilita)
end prototypes

event type boolean ue_permite_deselecionar(integer ai_linha);Return True
end event

event type boolean ue_permite_selecionar(integer ai_linha);//Integer lvi_Find
//	
//If IsNull(ivs_Find) or Trim(ivs_Find) = "" Then Return True
//	
//lvi_Find = idw_Destino.Find(ivs_Find, 0, idw_Destino.RowCount())
//	
//If lvi_Find > 0 Then
//	Return False
//End If
//
Return True
end event

event ue_move_um_cima();Long ll_Linha

String ls_Coluna, ls_Nome, ls_Ordem, ls_Bloqueio, ls_Bloqueio_1

If idw.RowCount() > 0 Then
	ll_Linha = idw.GetRow()
	
	If ll_Linha > 1 Then
		
		ls_Bloqueio_1 =  idw.Object.bloqueio	[ll_Linha - 1]
		
		If ls_Bloqueio_1 = "S" Then
			Return
		End If
		
		ls_Coluna 	= idw.Object.coluna	[ll_Linha]
		ls_Nome 		= idw.Object.nome	[ll_Linha]
		ls_Ordem	= idw.Object.ordem	[ll_Linha]
		ls_Bloqueio	= idw.Object.bloqueio[ll_Linha]
		
		idw.Object.coluna		[ll_Linha] = idw.Object.coluna		[ll_Linha - 1]
		idw.Object.nome		[ll_Linha] = idw.Object.nome		[ll_Linha - 1]
		idw.Object.ordem		[ll_Linha] = idw.Object.ordem		[ll_Linha - 1]
		idw.Object.bloqueio	[ll_Linha] = idw.Object.bloqueio	[ll_Linha - 1]
		
		
		idw.Object.coluna		[ll_Linha - 1] 		= ls_Coluna
		idw.Object.nome		[ll_Linha - 1] 		= ls_Nome
		idw.Object.ordem		[ll_Linha - 1] 		= ls_Ordem
		idw.Object.bloqueio	[ll_Linha - 1] 		= ls_Bloqueio
		
		idw.ScrollToRow(ll_Linha - 1)
		idw.SetRow(ll_Linha - 1)
	End If
End If

end event

event ue_move_um_baixo();Long ll_Linha

String ls_Coluna, ls_Nome, ls_Ordem, ls_Bloqueio

If idw.RowCount() > 0 Then
	ll_Linha = idw.GetRow()
	
	If ll_Linha < idw.RowCount() Then
		
		ls_Coluna 	= idw.Object.coluna	[ll_Linha]
		ls_Nome 		= idw.Object.nome	[ll_Linha]
		ls_Ordem	= idw.Object.ordem	[ll_Linha]
		ls_Bloqueio	= idw.Object.bloqueio[ll_Linha]
		
		If ls_Bloqueio = "S" Then
			Return
		End If
		
		idw.Object.coluna		[ll_Linha] = idw.Object.coluna		[ll_Linha + 1]
		idw.Object.nome		[ll_Linha] = idw.Object.nome		[ll_Linha + 1]
		idw.Object.ordem		[ll_Linha] = idw.Object.ordem		[ll_Linha + 1]
		idw.Object.bloqueio	[ll_Linha] = idw.Object.bloqueio	[ll_Linha + 1]
		
		idw.Object.coluna		[ll_Linha + 1] 		= ls_Coluna
		idw.Object.nome		[ll_Linha + 1] 		= ls_Nome
		idw.Object.ordem		[ll_Linha + 1] 		= ls_Ordem
		idw.Object.bloqueio	[ll_Linha + 1] 		= ls_Bloqueio
		
		idw.ScrollToRow(ll_Linha + 1)
		idw.SetRow(ll_Linha + 1)
	End If
End If

end event

event ue_move_primeira_linha();//Long ll_Linha
//
//String ls_Coluna, ls_Nome, ls_Ordem, ls_Bloqueio, ls_Bloqueio_1
//
//If idw.RowCount() > 0 Then
//	ll_Linha = idw.GetRow()
//	
//	If ll_Linha > 1 Then
//		
//		ls_Bloqueio_1 = idw.Object.bloqueio	[1]
//		
//		If ls_Bloqueio_1 = "S" Then
//			//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Teste")	
//			Return
//		End If
//		
//		ls_Coluna 	= idw.Object.coluna	[ll_Linha]
//		ls_Nome 		= idw.Object.nome	[ll_Linha]
//		ls_Ordem	= idw.Object.ordem	[ll_Linha]
//		ls_Bloqueio	= idw.Object.bloqueio[ll_Linha]
//		
//		idw.Object.coluna		[ll_Linha] = idw.Object.coluna		[1]
//		idw.Object.nome		[ll_Linha] = idw.Object.nome		[1]
//		idw.Object.ordem		[ll_Linha] = idw.Object.ordem		[1]
//		idw.Object.bloqueio	[ll_Linha] = idw.Object.bloqueio	[1]
//		
//		idw.Object.coluna		[1] 		= ls_Coluna
//		idw.Object.nome		[1] 		= ls_Nome
//		idw.Object.ordem		[1] 		= ls_Ordem
//		idw.Object.bloqueio	[1] 		= ls_Bloqueio
//		
//		idw.ScrollToRow(1)
//		idw.SetRow(1)
//		
//	End If
//End If

Long	ll_Linha,&
		ll_Linhas,&
		ll_Row

String		ls_Coluna,&
			ls_Nome,&
			ls_Ordem,&
			ls_Bloqueio,&
			ls_Bloqueio_1

If idw.RowCount() > 0 Then
	ll_Linha = idw.GetRow()
	
	If ll_Linha > 1 Then
		
		ls_Bloqueio_1 =  idw.Object.bloqueio	[1]
		
		If ls_Bloqueio_1 = "S" Then
			Return
		End If
		
		ls_Bloqueio_1 =  idw.Object.bloqueio	[ll_Linha]
		
		If ls_Bloqueio_1 = "S" Then
			Return
		End If
		
		ll_Row = idw.GetRow()
		
		DO WHILE ll_Row > 1
			ls_Coluna 	= idw.Object.coluna	[ll_Row]
			ls_Nome 		= idw.Object.nome	[ll_Row]
			ls_Ordem	= idw.Object.ordem	[ll_Row]
			ls_Bloqueio	= idw.Object.bloqueio[ll_Row]
			
			idw.Object.coluna		[ll_Row] = idw.Object.coluna		[ll_Row - 1]
			idw.Object.nome		[ll_Row] = idw.Object.nome		[ll_Row - 1]
			idw.Object.ordem		[ll_Row] = idw.Object.ordem		[ll_Row - 1]
			idw.Object.bloqueio	[ll_Row] = idw.Object.bloqueio		[ll_Row - 1]
			
			
			idw.Object.coluna		[ll_Row - 1] 		= ls_Coluna
			idw.Object.nome		[ll_Row - 1] 		= ls_Nome
			idw.Object.ordem		[ll_Row - 1] 		= ls_Ordem
			idw.Object.bloqueio	[ll_Row - 1] 		= ls_Bloqueio
			
			ll_Row = ll_Row - 1
		
LOOP
		
		idw.ScrollToRow(1)
		idw.SetRow(1)
		
	End If
End If

end event

event ue_move_ultima_linha();//Long ll_Linha
//
//String ls_Coluna, ls_Nome, ls_Ordem, ls_Bloqueio
//
//If idw.RowCount() > 0 Then
//	ll_Linha = idw.GetRow()
//	
//	If ll_Linha < idw.RowCount() Then
//		
//		ls_Coluna 	= idw.Object.coluna	[ll_Linha]
//		ls_Nome 		= idw.Object.nome	[ll_Linha]
//		ls_Ordem	= idw.Object.ordem	[ll_Linha]
//		ls_Bloqueio	= idw.Object.bloqueio[ll_Linha]
//		
//		If ls_Bloqueio = "S" Then
//			Return
//		End If
//		
//		idw.Object.coluna		[ll_Linha] = idw.Object.coluna		[idw.RowCount()]
//		idw.Object.nome		[ll_Linha] = idw.Object.nome		[idw.RowCount()]
//		idw.Object.ordem		[ll_Linha] = idw.Object.ordem		[idw.RowCount()]
//		idw.Object.bloqueio	[ll_Linha] = idw.Object.bloqueio	[idw.RowCount()]
//		
//		idw.Object.coluna		[idw.RowCount()] 		= ls_Coluna
//		idw.Object.nome		[idw.RowCount()] 		= ls_Nome
//		idw.Object.ordem		[idw.RowCount()] 		= ls_Ordem
//		idw.Object.bloqueio	[idw.RowCount()] 		= ls_Bloqueio
//		
//		idw.ScrollToRow(idw.RowCount())
//		idw.SetRow(idw.RowCount())
//	End If
//End If

Long 	ll_Linha,&
		ll_Linhas,&
		ll_Row

String		ls_Coluna,&
			ls_Nome,&
			ls_Ordem,&
			ls_Bloqueio

If idw.RowCount() > 0 Then
	ll_Linha	= idw.GetRow()
	ll_Linhas	= idw.RowCount()
	
	If ll_Linha < ll_Linhas Then
		
		ls_Bloqueio	= idw.Object.bloqueio[ll_Linha]
				
		If ls_Bloqueio = "S" Then
			Return
		End If
	
		For ll_Row = ll_Linha To ll_Linhas
			
			If ll_Row < ll_Linhas Then
			
				ls_Coluna 	= idw.Object.coluna	[ll_Row]
				ls_Nome 		= idw.Object.nome	[ll_Row]
				ls_Ordem	= idw.Object.ordem	[ll_Row]
				ls_Bloqueio	= idw.Object.bloqueio[ll_Row]
				
				idw.Object.coluna		[ll_Row] = idw.Object.coluna		[ll_Row + 1]
				idw.Object.nome		[ll_Row] = idw.Object.nome		[ll_Row + 1]
				idw.Object.ordem		[ll_Row] = idw.Object.ordem		[ll_Row + 1]
				idw.Object.bloqueio	[ll_Row] = idw.Object.bloqueio		[ll_Row + 1]
				
				idw.Object.coluna		[ll_Row + 1] 		= ls_Coluna
				idw.Object.nome		[ll_Row + 1] 		= ls_Nome
				idw.Object.ordem		[ll_Row + 1] 		= ls_Ordem
				idw.Object.bloqueio	[ll_Row + 1] 		= ls_Bloqueio
				
			End If
			
		Next
		
		idw.ScrollToRow(ll_Linhas)
		idw.SetRow(ll_Linhas)
		
	End If
End If

end event

public subroutine of_habilita ();//If idw.RowCount() > 0 Then
//	If ivb_Habilitado Then
//		cd_move_um_cima.Enabled = True
//		//cb_Seleciona_Todos.Enabled = True
//	Else
//		cd_move_um_cima.Enabled = False
//		//cb_Seleciona_Todos.Enabled = False
//	End If
//Else
//	cd_move_um_cima.Enabled = False
//	//cb_Seleciona_Todos.Enabled = False
//End If
//
end subroutine

public subroutine of_limpa_dw_destino ();//Integer lvi_Linhas, &
//        lvi_Linha
//
//lvi_Linhas = idw_Destino.RowCount()
//
//For lvi_Linha = 1 To lvi_Linhas
//	idw_Destino.DeleteRow(1)
//Next
end subroutine

public subroutine of_habilita_controle (boolean pb_habilita);ivb_Habilitado = pb_Habilita

of_Habilita()
end subroutine

on dc_uo_barra_selecao.create
this.cd_move_um_baixo=create cd_move_um_baixo
this.cd_move_ultima_linha=create cd_move_ultima_linha
this.cd_move_primeira_linha=create cd_move_primeira_linha
this.cd_move_um_cima=create cd_move_um_cima
this.Control[]={this.cd_move_um_baixo,&
this.cd_move_ultima_linha,&
this.cd_move_primeira_linha,&
this.cd_move_um_cima}
end on

on dc_uo_barra_selecao.destroy
destroy(this.cd_move_um_baixo)
destroy(this.cd_move_ultima_linha)
destroy(this.cd_move_primeira_linha)
destroy(this.cd_move_um_cima)
end on

type cd_move_um_baixo from commandbutton within dc_uo_barra_selecao
integer x = 14
integer y = 296
integer width = 114
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;Parent.Event ue_move_um_baixo()

of_Habilita()
end event

type cd_move_ultima_linha from commandbutton within dc_uo_barra_selecao
integer x = 14
integer y = 204
integer width = 114
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;Parent.Event ue_move_ultima_linha()

of_Habilita()
end event

type cd_move_primeira_linha from commandbutton within dc_uo_barra_selecao
integer x = 14
integer y = 104
integer width = 114
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;Parent.Event ue_move_primeira_linha()

of_Habilita()
end event

type cd_move_um_cima from commandbutton within dc_uo_barra_selecao
string tag = "teste"
integer x = 14
integer y = 12
integer width = 114
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;Parent.Event ue_move_um_cima()

of_Habilita()
end event

