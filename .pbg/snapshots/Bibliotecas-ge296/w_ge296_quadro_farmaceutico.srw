HA$PBExportHeader$w_ge296_quadro_farmaceutico.srw
forward
global type w_ge296_quadro_farmaceutico from dc_w_selecao_lista_relatorio
end type
type cb_1 from commandbutton within w_ge296_quadro_farmaceutico
end type
type cb_marcar from commandbutton within w_ge296_quadro_farmaceutico
end type
end forward

global type w_ge296_quadro_farmaceutico from dc_w_selecao_lista_relatorio
integer width = 1824
integer height = 2064
string title = "GE296 - Impress$$HEX1$$e300$$ENDHEX$$o Quadro Farmac$$HEX1$$ea00$$ENDHEX$$uticos"
string menuname = "m_janelas"
long backcolor = 80269524
cb_1 cb_1
cb_marcar cb_marcar
end type
global w_ge296_quadro_farmaceutico w_ge296_quadro_farmaceutico

type variables
uo_selecao_filiais ivo_Filial 

boolean ivb_check
end variables

forward prototypes
public function string wf_quebras (long pl_linhas)
public function string wf_quebras_parana (long pl_linhas)
public subroutine wf_insere_padrao ()
end prototypes

public function string wf_quebras (long pl_linhas);Choose Case pl_Linhas
	Case 1
		Return "~r~r~r~r~r~r"
		
	Case 2
		Return "~r~r~r~r~r"
		
	Case 3
		Return "~r~r~r~r"
		
	Case 4
		Return "~r~r~r"
		

	Case 5
		Return "~r~r"

	Case 6
		Return "~r~r"

	Case 7
		Return "~r~r"

End Choose

end function

public function string wf_quebras_parana (long pl_linhas);Choose Case pl_Linhas
	Case 1
		Return "~r~r~r~r~r"
		
	Case 2
		Return "~r~r~r~r"
		
	Case 3
		Return "~r~r~r"
		
End Choose

end function

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child

If dw_1.GetChild("id_tipo", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"vl_parametro","TD")
	ldw_Child.SetItem(1,"rede","TODOS")
	
	dw_1.Object.id_tipo[1] = "TD"
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' no filtro 'Rede Filial'.", StopSign!)
End If

end subroutine

on w_ge296_quadro_farmaceutico.create
int iCurrent
call super::create
if this.MenuName = "m_janelas" then this.MenuID = create m_janelas
this.cb_1=create cb_1
this.cb_marcar=create cb_marcar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_marcar
end on

on w_ge296_quadro_farmaceutico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_marcar)
end on

event ue_postopen;call super::ue_postopen;
if Not gf_conecta_banco_rh(gtr_rh, "vetorh_ti") Then
	MessageBox('Falha!','Falha ao tentar conectar ao banco de dados ORACLE_RH.~rA tela ser$$HEX1$$e100$$ENDHEX$$ encerrada!')
	Close(This)
else
	dw_3.of_SetTransObject(gtr_rh)
End If

wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge296_quadro_farmaceutico
integer x = 73
integer y = 1244
integer width = 1637
integer height = 148
string dataobject = "dw_auxilio_visual"
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge296_quadro_farmaceutico
integer x = 37
integer y = 1172
integer width = 1728
integer height = 236
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aux$$HEX1$$ed00$$ENDHEX$$lio Visual"
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge296_quadro_farmaceutico
integer y = 220
integer width = 1719
integer height = 1512
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge296_quadro_farmaceutico
integer width = 1719
integer height = 200
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge296_quadro_farmaceutico
integer x = 64
integer y = 80
integer width = 1243
integer height = 88
integer taborder = 40
string dataobject = "dw_ge296_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;//Integer lvi_Linhas,&
//		lvi_Linha
//		
//String lvs_Tipo,&
//	   lvs_Imprimir
//	   
//lvi_Linhas = dw_1.RowCount()
//
//For lvi_Linha = 1 To lvi_Linhas
//	
//	lvs_Tipo = dw_1.Object.vl_parametro[lvi_Linha]
//	
//	If Data <> 'TD' Then
//		If Data = lvs_Tipo Then
//			lvs_Imprimir = 'S'
//		Else
//			lvs_Imprimir = 'N'
//		End If
//	Else
//		lvs_Imprimir = 'S'
//	End If
//	
//	dw_1.Object.id_imprimir[lvi_Linha] = lvs_Imprimir
//Next


cb_Marcar.Text = "Marcar &Todas"
cb_Marcar.Enabled = False
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge296_quadro_farmaceutico
event ue_mousemove pbm_mousemove
integer x = 64
integer y = 312
integer width = 1655
integer height = 1400
integer taborder = 50
string dataobject = "dw_ge296_lista_filiais"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText()

String ls_Rede

ls_Rede = dw_1.Object.Id_Tipo[1]

If ls_Rede <> 'TD' Then
	This.of_AppendWhere("p.vl_parametro = '" + ls_Rede + "'")
End If

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	cb_Marcar.Enabled = True
Else
	cb_Marcar.Enabled = False
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge296_quadro_farmaceutico
integer x = 978
integer y = 1248
integer height = 304
integer taborder = 60
string dataobject = "dw_ge296_relatorio"
end type

type cb_1 from commandbutton within w_ge296_quadro_farmaceutico
integer x = 1198
integer y = 76
integer width = 448
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Imprimir"
end type

event clicked;Long ll_Empresa  , &
     ll_Tipo     , &
	  ll_Matricula, &
	  ll_Filial   , &
	  ll_Linha    , &
	  ll_Linhas   , &
	  ll_Linha_Farm, &
	  ll_Linhas_Farm, &
	  lvl_Cidade
	  
String ls_Texto = space(200) , &
	    ls_Cgc   , &
		 ls_Farm  , &
		 ls_Quebra, &
		 ls_Crf   , &
		 ls_Insc  , &
		 ls_Texto_Crf, &
		 ls_Imprimir, &
		 ls_Uf      , &
		 ls_Dw

dc_uo_ds_base lo_Farm
lo_Farm = Create dc_uo_ds_base

ll_Linhas = dw_2.RowCount()

For ll_Linha = 1 To ll_Linhas
	
	ls_Dw = 'dw_ge296_relatorio'
	
	ls_Uf = dw_2.Object.Cd_Unidade_Federacao[ll_Linha]
	
	If ls_Uf = 'PR' Then ls_Dw = 'dw_ge296_relatorio_parana'
	
	dw_3.of_ChangeDataObject(ls_Dw)	
	
	lo_Farm.of_ChangeDataObject('ds_ge296_farmaceuticos')
	lo_Farm.of_SetTransObject(gtr_rh)

	
	ls_Imprimir = dw_2.Object.Id_Imprimir[ll_Linha]
	
	If ls_Imprimir = "S" Then
		dw_3.Event ue_Reset()
		
		ls_Cgc	= dw_2.Object.Nr_Cgc	[ll_Linha]
		ll_Filial	= dw_2.Object.Cd_Filial	[ll_Linha]
		
		dw_3.Retrieve(ls_Cgc)
		
		dw_3.Object.st_Prefeitura.Visible      = False
		dw_3.Object.st_Prefeitura_Fone.Visible = False
		
		/////////////////////////////////////////////
		ll_Linhas_Farm = lo_Farm.Retrieve(ll_Filial)
		
		If ls_Uf = 'PR' Then
			ls_Quebra = wf_Quebras_Parana(ll_Linhas_Farm)
		Else
			ls_Quebra = wf_Quebras(ll_Linhas_Farm)
		End If
		
		ls_Farm        = ls_Quebra
		ls_Texto_Crf   = ls_Quebra
		
		If ll_Linhas_Farm >= 7 Then
			ls_Farm      = "~r"
			ls_Texto_Crf = "~r"
		End If
		
		For ll_Linha_Farm = 1 To ll_Linhas_Farm
			ls_Farm += lo_Farm.Object.Nome[ll_Linha_Farm] + "~r"
			
			ll_Empresa		= lo_Farm.Object.Empresa				[ll_Linha_Farm]
			ll_Tipo			= lo_Farm.Object.Tipo_Colaborador	[ll_Linha_Farm]
			ll_Matricula		= lo_Farm.Object.Matricula				[ll_Linha_Farm]
			ls_Crf				= lo_Farm.Object.Registro				[ll_Linha_Farm]
			ls_Insc			= "INSCRI$$HEX2$$c700c300$$ENDHEX$$O NO CRF / " + lo_Farm.Object.Cd_Uf_Conselho[ll_Linha_Farm]
			
			DECLARE sp_quadro procedure for sp_monta_quadro_horarios 
			  ( p_empresa			=> :ll_Empresa,
				p_tipo					=> :ll_Tipo,
				p_matricula			=> :ll_Matricula
			  )
			 Using gtr_rh;	
			
			/*Declare sp_quadro procedure For sp_monta_quadro_horarios
				@empresa			= :ll_Empresa,
				@tipo					= :ll_Tipo,
				@matricula			= :ll_Matricula, 
				@texto_completo	= :ls_Texto
			 Using io_Rubi;*/
			 
			Execute sp_quadro;
			
			Fetch sp_quadro Into :ls_Texto;
			
			Close sp_Quadro;
			
			Choose Case gtr_rh.SqlCode
				Case -1
					gtr_rh.of_MsgDbError()
					Exit
			End Choose
			
			ls_Farm += ls_texto + ls_Quebra
			
			ls_Texto_Crf += ls_Insc + "~r" + ls_Crf + ls_Quebra
		Next
		
		dw_3.Object.Farm_txt.text = ls_Farm
		dw_3.Object.Crf_txt.text  = ls_Texto_Crf
		/////////////////////////////////////////////
		
		lvl_Cidade = dw_2.Object.Cd_Cidade[ll_Linha]
		If lvl_Cidade = 17 Then
			dw_3.Object.st_Prefeitura.Visible			= True
			dw_3.Object.st_Prefeitura_Fone.Visible	= True
		End If
		
		dw_3.Event ue_PrintImmediate()
		
	End If
	
Next

Destroy lo_Farm
end event

type cb_marcar from commandbutton within w_ge296_quadro_farmaceutico
integer x = 1189
integer y = 1756
integer width = 571
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Marcar &Todas"
end type

event clicked;String ls_Selecao

Long ll_Linha


If This.Text = "Marcar &Todas" Then
	This.Text = "Desmarcar &Todas"
	ls_Selecao = "S"
Else
	This.Text = "Marcar &Todas"
	ls_Selecao = "N"
End If

For ll_Linha = 1 To dw_2.RowCount()
	dw_2.Object.Id_Imprimir[ll_Linha] = ls_Selecao
Next
end event

