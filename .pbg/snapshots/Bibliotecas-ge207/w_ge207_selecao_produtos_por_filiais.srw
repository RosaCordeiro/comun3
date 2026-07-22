HA$PBExportHeader$w_ge207_selecao_produtos_por_filiais.srw
forward
global type w_ge207_selecao_produtos_por_filiais from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge207_selecao_produtos_por_filiais from dc_w_selecao_lista_relatorio
integer width = 3195
integer height = 1976
string title = "GE207 - Consulta Produto por Grupo Almoxarifado"
end type
global w_ge207_selecao_produtos_por_filiais w_ge207_selecao_produtos_por_filiais

type variables
uo_Produto ivo_Produto

uo_Selecao_Filiais ivo_Filiais

String ivs_Filiais
end variables

forward prototypes
public subroutine wf_seleciona_filiais ()
end prototypes

public subroutine wf_seleciona_filiais ();Integer lvi_Linhas, &
        lvi_Row, &
		  lvi_Filial

ivs_Filiais = "("

OpenWithParm(w_ge044_selecao_filiais, ivo_Filiais)

ivo_Filiais = Message.PowerObjectParm

If IsNull(ivo_Filiais) Then 
	ivs_Filiais = ""
	Return
End If

lvi_Linhas = UpperBound(ivo_Filiais.Cd_Filial)

For lvi_Row = 1 To lvi_Linhas
	
	lvi_Filial = ivo_Filiais.Cd_Filial[lvi_Row]
	
	ivs_Filiais += String(lvi_Filial)
	
	If lvi_Row <> lvi_Linhas Then
		ivs_Filiais += ","
	End If
Next

ivs_Filiais += ")"

If lvi_Linhas = 0 Then ivs_Filiais = ""
end subroutine

on w_ge207_selecao_produtos_por_filiais.create
call super::create
end on

on w_ge207_selecao_produtos_por_filiais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Produto 	= Create uo_Produto
ivo_Filiais	= Create uo_Selecao_Filiais
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filiais)
end event

event ue_postopen;call super::ue_postopen;DateTime ldh_Server_Date

DataWindowChild lvds_Grupo

//nome da coluna a ser modificada
//id_subgrupo
lvds_Grupo = dw_1.of_InsertRow_DDDW("id_grupo")
//
lvds_Grupo.SetItem(1, "cd_subgrupo", "000")
lvds_Grupo.SetItem(1, "de_subgrupo", "TODOS")
//
dw_1.Object.id_grupo[1] = "000"

ldh_Server_Date = gf_GetServerDate()

dw_1.Object.Dt_Inicio		[1] = Date(ldh_Server_Date)
dw_1.Object.Dt_Termino	[1] = Date(ldh_Server_Date)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge207_selecao_produtos_por_filiais
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge207_selecao_produtos_por_filiais
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge207_selecao_produtos_por_filiais
integer y = 444
integer width = 3090
integer height = 1328
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge207_selecao_produtos_por_filiais
integer y = 8
integer width = 2258
integer height = 420
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge207_selecao_produtos_por_filiais
integer x = 64
integer y = 80
integer width = 2208
integer height = 332
string dataobject = "dw_ge207_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = keyEnter! Then
	
	If This.GetColumnName() = "de_produto" Then
     	
		ivo_Produto.of_Localiza_Produto(This.GetText())
		  
		If ivo_Produto.Localizado Then
			
			This.Object.de_produto[1] = ivo_Produto.de_Produto
			This.Object.cd_produto[1] = ivo_Produto.cd_Produto
			
		End If
	End If 	
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case "de_produto"
		If Not IsNull(Data) Or Data <> "" Then
			If Data <> ivo_Produto.de_Produto Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.de_produto[1] = ivo_Produto.de_Produto
			This.Object.cd_produto[1] = ivo_Produto.cd_Produto
			
		End If
		
	Case "id_filial"
		
		If Data = "C" Then
			SETPOINTER(HourGlass!)
			
			wf_Seleciona_Filiais()
			
			SETPOINTER(Arrow!)
		Else
			ivs_Filiais = ""
		End If
		
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge207_selecao_produtos_por_filiais
integer x = 78
integer y = 516
integer width = 3013
integer height = 1236
string dataobject = "dw_ge207_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide

Date  lvdh_Inicio,&
		lvdh_Termino

Long  lvl_Produto 

String lvs_Subgrupo
         
dw_1.AcceptText()

lvdh_Inicio 		=	 dw_1.Object.dt_inicio	[1]
lvdh_Termino 	=	 dw_1.Object.dt_termino	[1]	
lvl_Produto		=	 dw_1.Object.cd_produto[1]
lvs_SubGrupo   =   dw_1.Object.id_grupo	[1]

If IsNull (lvdh_Inicio)  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.",Information!)
	dw_1.Event ue_Pos(1,"dt_inicio")
	Return -1
End If

If IsNull (lvdh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.",Information!)
	dw_1.Event ue_Pos(1,"dt_termino")
	Return -1
End If

If lvdh_Inicio > lvdh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor que a do t$$HEX1$$e900$$ENDHEX$$rmino.",Information!)
	dw_1.Event ue_Pos(1,"dt_inicio")
	Return -1
End If

If ivs_Filiais <> "" And Not IsNull(ivs_Filiais) Then
	This.of_AppendWhere_Subquery("f.cd_filial in " + ivs_Filiais, 4)
End If

If Not IsNull(lvl_Produto) Then
	This.of_AppendWhere_Subquery("g.cd_produto = " + String(lvl_Produto), 4)
End If

If lvs_SubGrupo <> "000" Then
	This.of_AppendWhere_Subquery("v.cd_subgrupo = '" + lvs_SubGrupo + "'", 4)
End If

Return This.Retrieve(lvdh_Inicio, lvdh_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
Else	
	This.ivm_Menu.mf_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge207_selecao_produtos_por_filiais
integer x = 2674
integer y = 28
integer height = 172
end type

