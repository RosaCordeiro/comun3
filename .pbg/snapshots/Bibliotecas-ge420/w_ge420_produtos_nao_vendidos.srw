HA$PBExportHeader$w_ge420_produtos_nao_vendidos.srw
forward
global type w_ge420_produtos_nao_vendidos from dc_w_selecao_lista_relatorio
end type
type cb_1 from commandbutton within w_ge420_produtos_nao_vendidos
end type
end forward

global type w_ge420_produtos_nao_vendidos from dc_w_selecao_lista_relatorio
integer width = 2350
integer height = 696
string title = "GE420 - Lista de Produtos n$$HEX1$$e300$$ENDHEX$$o Vendidos"
long backcolor = 80269524
cb_1 cb_1
end type
global w_ge420_produtos_nao_vendidos w_ge420_produtos_nao_vendidos

type variables
uo_filial ivo_filial

dc_uo_transacao SqlCa_CO

DATAWINDOWCHILD ivdwc_grupo
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();String lvs_Filial

dw_1.AcceptText()

lvs_Filial = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Filial)

If ivo_Filial.Localizada Then
	
	dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	dw_1.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
	
	dw_1.Object.id_rede[1] = ''
End If
end subroutine

on w_ge420_produtos_nao_vendidos.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge420_produtos_nao_vendidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event open;call super::open;ivo_Filial = Create uo_Filial

SqlCa_CO   = Create dc_uo_transacao

SqlCa_CO = SqlCa

SqlCa_CO.AutoCommit = True

Connect Using SqlCa_CO;

end event

event close;call super::close;Destroy ivo_Filial
end event

event ue_postopen;call super::ue_postopen;//sle_1.Text = 'c:\pedro\compras\produtos_nao_vendidos.xls' 
             
ivdwc_grupo  = dw_1.of_InsertRow_DDDW("grupo" )			

ivdwc_grupo.SetItem(1, "cd_grupo", "0" 		     )
ivdwc_grupo.SetItem(1, "de_grupo", "TODOS"  )

dw_1.Object.grupo [1] = 0
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge420_produtos_nao_vendidos
integer x = 37
integer y = 884
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge420_produtos_nao_vendidos
integer x = 0
integer y = 812
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge420_produtos_nao_vendidos
boolean visible = false
integer x = 155
integer y = 384
integer width = 1202
integer height = 264
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge420_produtos_nao_vendidos
integer x = 23
integer y = 12
integer width = 2258
integer height = 352
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge420_produtos_nao_vendidos
integer x = 37
integer y = 72
integer width = 2222
integer height = 268
integer taborder = 50
string dataobject = "dw_ge420_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;cb_1.Enabled = False
dw_1.Object.nr_linhas_t.Text = ''

Choose Case dwo.name
	Case "nm_filial"
		
		If IsNull(data) or data = "" Then
					
			SetNull(ivo_filial.cd_filial)
			ivo_filial.nm_fantasia = ""
			
			This.Object.cd_filial[row] = ivo_filial.cd_filial
			This.Object.nm_filial[row] = ivo_filial.nm_fantasia
			
		End If
		
		If data <> ivo_filial.nm_fantasia Then
			Return 1
		End If
		
	Case 'id_rede'
		ivo_filial.of_inicializa()
		
		This.Object.cd_filial[row] 	= ivo_filial.cd_filial
		This.Object.nm_filial[row] 	= ivo_filial.nm_fantasia			
End Choose
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If key = KeyEnter! Then
	
	wf_Localiza_Filial()
	
End If
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;If dwo.Name = "dias" Then
	This.SelectText(1,6)
End If
end event

event dw_1::editchanged;call super::editchanged;cb_1.Enabled = False

Choose Case dwo.name
	Case "nm_filial"
		
		If IsNull(data) or data = "" Then
					
			SetNull(ivo_filial.cd_filial)
			ivo_filial.nm_fantasia = ""
			
			This.Object.cd_filial[row] = ivo_filial.cd_filial
			This.Object.nm_filial[row] = ivo_filial.nm_fantasia			
		End If
		
		If data <> ivo_filial.nm_fantasia Then
			Return 1
		End If
		
	Case 'id_rede'
		ivo_filial.of_inicializa()
		
		This.Object.cd_filial[row] 	= ivo_filial.cd_filial
		This.Object.nm_filial[row] 	= ivo_filial.nm_fantasia			
End Choose

dw_1.Object.nr_linhas_t.Text = ''
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge420_produtos_nao_vendidos
boolean visible = false
integer x = 530
integer y = 408
integer width = 791
integer height = 208
integer taborder = 60
string dataobject = "ds_ge420_lista"
end type

event dw_2::ue_recuperar;//OverRide

Long lvl_Filial

Integer lvi_Dias, &
        lvi_Grupo

String ls_Rede

Date ldt_Periodo

dw_1.AcceptText()

lvl_Filial 		= dw_1.Object.Cd_Filial	[1]
lvi_Dias   	= dw_1.Object.Dias		[1]
lvi_Grupo  	= dw_1.Object.Grupo		[1]
ls_Rede		= dw_1.Object.id_rede	[1]

If IsNull(lvl_Filial) And (Trim(ls_Rede) = '' Or IsNull(ls_Rede) ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a filial ou a rede filial.", exclamation!)
	dw_1.SetColumn("nm_filial")
	Return -1
End If

If lvi_Dias = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O n$$HEX1$$fa00$$ENDHEX$$mero de dias deve ser maior que zero.", exclamation!)
	dw_1.SetColumn("dias")	
	Return -1
End If

ldt_Periodo = RelativeDate( Date(gf_GetServerDate()), - lvi_Dias )

If Not IsNull( lvl_Filial ) Then
	This.of_Appendwhere_subquery("v.cd_filial = " + String(lvl_Filial),1 ) 
	This.of_Appendwhere_subquery("v.cd_filial = " + String(lvl_Filial),3 ) 
Else 
	This.of_Appendwhere_subquery("f.id_rede = '" + String(ls_Rede)+"'" , 1) 
	This.of_Appendwhere_subquery("f.id_rede = '" + String(ls_Rede)+"'" , 3) 
End If

If lvi_Grupo <> 0 Then
	This.of_Appendwhere_subquery("g.cd_grupo_produto = " + String(lvi_Grupo), 1) 
	This.of_Appendwhere_subquery("g.cd_grupo_produto = " + String(lvi_Grupo), 3) 
End If

Return This.Retrieve( ldt_Periodo )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	cb_1.Enabled = True
	dw_1.Object.nr_linhas_t.Text = String( pl_Linhas,'#,##0' ) + ' registro(s) encontrado(s)'
Else
	cb_1.Enabled = False
	dw_1.Object.nr_linhas_t.Text = 'Nenhum registro encontrado'
End If

Return pl_linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge420_produtos_nao_vendidos
boolean visible = false
integer y = 616
integer taborder = 70
end type

type cb_1 from commandbutton within w_ge420_produtos_nao_vendidos
integer x = 1742
integer y = 388
integer width = 539
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Salvar em Arquivo"
end type

event clicked;dw_2.Event ue_SaveAs()
end event

