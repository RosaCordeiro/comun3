HA$PBExportHeader$w_ge161_inclui_filial.srw
forward
global type w_ge161_inclui_filial from dc_w_response
end type
type gb_1 from groupbox within w_ge161_inclui_filial
end type
type dw_1 from dc_uo_dw_base within w_ge161_inclui_filial
end type
type cb_confirmar from commandbutton within w_ge161_inclui_filial
end type
type cb_cancelar from commandbutton within w_ge161_inclui_filial
end type
end forward

global type w_ge161_inclui_filial from dc_w_response
string tag = "w_ge161_inclui_filial"
integer width = 1938
integer height = 648
string title = "GE161 - Cadastro de Filial na Distribuidora"
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
end type
global w_ge161_inclui_filial w_ge161_inclui_filial

type variables
uo_filial ivo_filial
end variables

forward prototypes
public function boolean wf_valida_informacoes (string as_distribuidora, long al_filial, string as_filial_distribuidora)
public function boolean wf_verifica_distribuidora_homologando ()
end prototypes

public function boolean wf_valida_informacoes (string as_distribuidora, long al_filial, string as_filial_distribuidora);Integer lvi_Count

Long lvl_Filial

Select count(*) 
Into :lvi_Count
From filial_distribuidora
Where cd_filial        =:al_filial
  and cd_distribuidora =:as_distribuidora
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial na distribuidora.")
Else
	// Se a loja n$$HEX1$$e300$$ENDHEX$$o estiver cadastrada na distribuidora
	If lvi_Count = 0 Then
		
		Select cd_filial 
		Into :lvl_Filial
		From filial_distribuidora
		Where cd_distribuidora        =:as_distribuidora
		  and cd_filial_distribuidora =:as_filial_distribuidora
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo da filial na distribuidora.")
		Else
			If IsNull(lvl_Filial) or lvl_Filial = 0 Then
				Return True
			Else 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo '" + as_Filial_Distribuidora +&
									  "' j$$HEX1$$e100$$ENDHEX$$ esta cadastrado para a filial '" + String(lvl_Filial) +&
									  "' na distribuidora '" + as_Distribuidora + "'.")
			End If
		End If
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + String(al_Filial) + "' j$$HEX1$$e100$$ENDHEX$$ esta cadastrada na distribuidora '" +&
							  as_Distribuidora + "'.")
	End If
End If

Return False
end function

public function boolean wf_verifica_distribuidora_homologando ();String ls_Distribuidora
String ls_Situacao
String ls_Homologando

dw_1.AcceptText()

ls_Situacao		= dw_1.Object.Id_Situacao			[1]
ls_Distribuidora	= dw_1.Object.Cd_Distribuidora	[1]

If ls_Situacao = "A" Then

	Select Coalesce(id_homologando_pedido, "N")
		Into :ls_Homologando
	From distribuidora_uf
	Where cd_distribuidora = :ls_Distribuidora
		And cd_unidade_federacao = :ivo_Filial.Cd_Unidade_Federacao
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If ls_Homologando = "S" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Distribuidora em fase de homologa$$HEX2$$e700e300$$ENDHEX$$o. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel relacionar a filial como 'ATIVA'.", Exclamation!)
				dw_1.Event ue_Pos(1, "id_situacao")
				Return False
			End If	
			
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o id_homologando na distribuidora '" + ls_Distribuidora + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_distribuidora_homologando.", StopSign!)
			Return False
			
		Case -1
			SqlCa.of_MsgdbError("Erro ao localizado o id_homologando. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_distribuidora_homologando.")
			Return False
	End Choose
End If
	
Return True
end function

on w_ge161_inclui_filial.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_confirmar
this.Control[iCurrent+4]=this.cb_cancelar
end on

on w_ge161_inclui_filial.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
end on

event ue_postopen;call super::ue_postopen;ivo_Filial = Create uo_Filial

dw_1.Event ue_AddRow()

dw_1.Object.Nr_GLN.Visible = 0
dw_1.Object.Nr_GLN_t.Visible = 0

end event

event close;call super::close;Destroy(ivo_Filial)
end event

type pb_help from dc_w_response`pb_help within w_ge161_inclui_filial
end type

type gb_1 from groupbox within w_ge161_inclui_filial
integer x = 23
integer width = 1856
integer height = 428
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge161_inclui_filial
integer x = 50
integer y = 64
integer width = 1810
integer height = 332
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge161_cadastro"
end type

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	If dw_1.GetColumnName() = "nm_fantasia" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.cd_filial  [1] = ivo_Filial.cd_filial
			This.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
	
			dw_1.SetTabOrder("cd_distribuidora", 20)
			dw_1.SetTabOrder("cd_filial_distribuidora", 30)
			dw_1.SetTabOrder("id_situacao", 40)	
			dw_1.SetTabOrder("nr_gln", 50)	
			
			String ls_SQL
			
			DataWindowChild lvdwc
			
			If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then

			lvdwc.SetTransObject(SQLCA)
					
//			ls_Sql = " Select Distinct a.cd_distribuidora, f.nm_fantasia " + &
//						" From filial_distribuidora As a " + &
//						"	Inner Join vw_filial As v " + &
//						"		On v.cd_filial = a.cd_filial " + &
//						"	Inner Join fornecedor As f " + &
//						"		On f.cd_fornecedor = a.cd_distribuidora " + &
//						" Where v.cd_uf = '" + ivo_Filial.Cd_Unidade_Federacao + "'" + &
//						"	 And f.id_distribuidora = 'S' " + &
//						"	 And a.id_situacao = 'A' " + &
//						" Order by f.nm_fantasia "

			ls_Sql = " Select	d.cd_distribuidora, f.nm_fantasia " + &
						" From fornecedor as f " + &
						"	Inner Join distribuidora_uf as d " + &
						"		On d.cd_distribuidora = f.cd_fornecedor " + &
						" Where d.cd_unidade_federacao = '" + ivo_Filial.Cd_Unidade_Federacao + "'" + &
						"	And f.id_distribuidora = 'S' " + &
						" Order By f.nm_fantasia "
			
			lvdwc.SetSQLSelect(ls_SQL)
			
				If lvdwc.Retrieve() < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a distribuidora.")
					Return -1
				End If		
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild distribuidora por uf.")
				Return -1
			End If
		End If
	End If
End If
end event

event itemchanged;call super::itemchanged;Boolean lb_Conveniencia

Long lvl_Nulo

String ls_Nulo

String ls_Erro

SetNull(lvl_Nulo)

cb_confirmar.Default = False

This.AcceptText()

If This.GetColumnName() = "nm_fantasia" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		dw_1.Object.cd_filial  [1] = ivo_Filial.cd_filial
		dw_1.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
	End If
	
	SetNull(ls_Nulo)
	This.Object.Cd_Distribuidora[1] = ls_Nulo
End If

If This.GetColumnName() = "cd_filial_distribuidora" Then
	cb_confirmar.Default = True
End If

If This.GetColumnName() = "cd_distribuidora" Then
	If Not gf_Retorna_Distribuidora_Conveniencia(dw_1.Object.Cd_Distribuidora[row], True, Ref lb_Conveniencia, Ref ls_Erro) Then Return -1
	
	If Not lb_Conveniencia Then
		dw_1.Object.Nr_GLN.Visible = 0
		dw_1.Object.Nr_GLN_t.Visible = 0
	Else
		dw_1.Object.Nr_GLN.Visible = 1
		dw_1.Object.Nr_GLN_t.Visible = 1
	End If
End If
end event

event losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;String ls_Nulo

This.AcceptText()

If This.GetColumnName() = "nm_fantasia" Then
	
	SetNull(ls_Nulo)
	This.Object.Cd_Distribuidora[1] = ls_Nulo
End If
end event

type cb_confirmar from commandbutton within w_ge161_inclui_filial
integer x = 1097
integer y = 448
integer width = 389
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar"
end type

event clicked;Boolean lb_Conveniencia

DateTime ldh_Alteracao

String	lvs_Distribuidora,&
	   	lvs_Filial_Dist,&
	   	lvs_Situacao, &
		ls_Nulo, &
		ls_GLN, &
		ls_Erro

Long lvl_Filial

dw_1.AcceptText()

SetNull(ls_Nulo)

ldh_Alteracao = gf_GetServerDate()

lvs_Distribuidora	= dw_1.Object.cd_distribuidora       	[1] 
lvs_Filial_Dist   		= dw_1.Object.cd_filial_distribuidora	[1] 
lvl_Filial		  		= dw_1.Object.cd_filial              		[1] 
lvs_Situacao      	= dw_1.Object.id_situacao 	       		[1]
ls_GLN				= dw_1.Object.Nr_GLN					[1]

If IsNull(lvl_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "nm_fantasia")
	Return -1
End If

If IsNull(lvs_Distribuidora) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "cd_distribuidora")
	Return -1
End If

If IsNull(lvs_Filial_Dist) or Trim(lvs_Filial_Dist) = ""  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo da filial na distribuidora.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "cd_filial_distribuidora")
	Return -1
End If

If Not wf_Valida_Informacoes(lvs_Distribuidora, lvl_Filial, lvs_Filial_Dist) Then Return

If Not wf_Verifica_Distribuidora_Homologando() Then Return

If Not gf_Retorna_Distribuidora_Conveniencia(lvs_Distribuidora, True, Ref lb_Conveniencia, Ref ls_Erro) Then Return -1

If lb_Conveniencia Then
	If lvs_Situacao = "A" Then
		If Not gf_ge161_Verifica_Filial_Ativa_Conveniencia(lvl_Filial, lvs_Distribuidora) Then Return -1
	End If
	
	If IsNull(ls_GLN) Or Trim(ls_GLN) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o GLN.", Exclamation!)
		dw_1.SetFocus()
		dw_1.Event ue_Pos(1, "nr_gln")
		Return -1
	End If
Else
	SetNull(ls_GLN)
End If

SetPointer(HourGlass!)

Insert Into filial_distribuidora  
          ( cd_filial,   
            cd_distribuidora,   
            cd_filial_distribuidora,   
            nr_prioridade,   
            id_situacao,   
            nr_sequencial_arquivo,
		   nr_matric_alteracao_situacao,
		   dh_alteracao_situacao,
		   nr_gln)
Values ( :lvl_Filial,   
	     :lvs_Distribuidora,   
	     :lvs_Filial_Dist,
		 0,
	     :lvs_Situacao,   
	     null,
		 :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
		 :ldh_Alteracao,
		 :ls_GLN)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o da filial '" + String(lvl_Filial) + "' na distribuidora '" + lvs_Distribuidora + "'.")
	SqlCa.of_RollBack();
Else
	SqlCa.of_Commit();	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial foi inclu$$HEX1$$ed00$$ENDHEX$$da com sucesso.")
	
	dw_1.Object.Cd_Distribuidora[1] = ls_Nulo
	
	ivo_Filial.of_Inicializa()
	
	dw_1.Object.cd_filial					[1] = ivo_Filial.cd_filial
	dw_1.Object.nm_fantasia			[1] = ivo_Filial.nm_fantasia
	dw_1.Object.cd_filial_distribuidora	[1] = ""
	dw_1.Object.Nr_GLN					[1] = ls_Nulo
	
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "nm_fantasia")
	
	cb_confirmar.Default = False
End If

SetPointer(Arrow!)
end event

type cb_cancelar from commandbutton within w_ge161_inclui_filial
integer x = 1518
integer y = 448
integer width = 366
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "C&ancelar"
end type

event clicked;CloseWithReturn(Parent, "X")
end event

