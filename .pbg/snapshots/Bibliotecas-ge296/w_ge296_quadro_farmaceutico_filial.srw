HA$PBExportHeader$w_ge296_quadro_farmaceutico_filial.srw
forward
global type w_ge296_quadro_farmaceutico_filial from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge296_quadro_farmaceutico_filial from dc_w_selecao_lista_relatorio
integer width = 2007
string title = "GE296 - Impress$$HEX1$$e300$$ENDHEX$$o Quadro de Farmac$$HEX1$$ea00$$ENDHEX$$uticos por Filial"
long backcolor = 80269524
end type
global w_ge296_quadro_farmaceutico_filial w_ge296_quadro_farmaceutico_filial

type variables
uo_filial ivo_Filial
end variables

forward prototypes
public function string wf_quebras (long pl_linhas)
public function string wf_quebras_parana (long pl_linhas)
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
		
	Case 4
		Return "~r~r"
		
End Choose

end function

on w_ge296_quadro_farmaceutico_filial.create
call super::create
end on

on w_ge296_quadro_farmaceutico_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy ivo_Filial

end event

event ue_preopen;call super::ue_preopen;ivo_Filial = Create uo_Filial //ge009

end event

event ue_postopen;call super::ue_postopen;This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_preprint;//OverRide
Long ll_Empresa  , &
     ll_Tipo     , &
	  ll_Matricula, &
	  ll_Filial   , &
	  ll_Linha    , &
	  ll_Linhas 
	  
String ls_Texto , &
	    ls_Cgc   , &
		 ls_Farm  , &
		 ls_Quebra, &
		 ls_Crf   , &
		 ls_Insc  , &
		 ls_Texto_Crf, &
		 ls_Imprimir, &
		 ls_Uf      , &
		 ls_Dw

//dw_3.Event ue_Reset()

ls_Dw = 'dw_ge296_relatorio'
ls_Uf = ivo_Filial.Cd_Unidade_Federacao

If ls_Uf = 'PR' Then ls_Dw = 'dw_ge296_relatorio_parana'

dw_3.of_ChangeDataObject(ls_Dw)	
dw_3.Retrieve(ivo_Filial.Nr_Cgc)

dw_3.Object.st_Prefeitura.Visible      = False
dw_3.Object.st_Prefeitura_Fone.Visible = False

ll_Linhas = 0

For ll_Linha = 1 To dw_2.RowCount()
	ls_Imprimir = dw_2.Object.Id_Selecao[ll_Linha]
	
	If ls_Imprimir = 'S' Then ll_Linhas++
Next

If ll_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio selecionar pelo menos um farmac$$HEX1$$ea00$$ENDHEX$$utico.")
	Return -1
End If	

If ls_Uf = 'PR' Then
	ls_Quebra = wf_Quebras_Parana(ll_Linhas)
Else
	ls_Quebra = wf_Quebras(ll_Linhas)
End If

ls_Farm        = ls_Quebra
ls_Texto_Crf   = ls_Quebra

If ll_Linhas >= 7 Then
	ls_Farm      = "~r"
	ls_Texto_Crf = "~r"
End If



For ll_Linha = 1 To dw_2.RowCount()
	ls_Imprimir = dw_2.Object.Id_Selecao[ll_Linha]
	
	If ls_Imprimir <> 'S' Then Continue
			
	ls_Farm += dw_2.Object.Nome[ll_Linha] + "~r"
	
	ll_Empresa	= dw_2.Object.Empresa         [ll_Linha]
	ll_Tipo		= dw_2.Object.Tipo_Colaborador[ll_Linha]
	ll_Matricula	= dw_2.Object.Matricula       [ll_Linha]
	ls_Crf			= dw_2.Object.Registro        [ll_Linha]
	ls_Insc		= "INSCRI$$HEX2$$c700c300$$ENDHEX$$O NO CRF / " + dw_2.Object.Cd_Uf_Conselho[ll_Linha]
	
	DECLARE sp_quadro procedure for sp_monta_quadro_horarios 
	  ( p_empresa			=> :ll_Empresa,
		p_tipo					=> :ll_Tipo,
		p_matricula			=> :ll_Matricula
	  )
	 Using gtr_RH;	
	
/*	Declare sp_quadro procedure For sp_monta_quadro_horarios
		@empresa			= :ll_Empresa,
		@tipo					= :ll_Tipo,
		@matricula			= :ll_Matricula, 
		@texto_completo	= :ls_Texto
	 Using gtran_rh;
*/	 
	 
	Execute sp_quadro;
	
	Fetch sp_quadro into :ls_texto;
	
	Close sp_Quadro;
	
	Choose Case gtr_RH.SqlCode
		Case -1
			gtr_RH.of_MsgDbError()
			Exit
	End Choose
	
	ls_Farm += ls_texto + ls_Quebra
	
	Close sp_quadro;
	
	ls_Texto_Crf += ls_Insc + "~r" + ls_Crf + ls_Quebra
		
	dw_3.Object.Farm_txt.text = ls_Farm
	dw_3.Object.Crf_txt.text  = ls_Texto_Crf
	
Next

If ivo_Filial.Cd_Cidade = 17 Then
	dw_3.Object.st_Prefeitura.Visible      = True
	dw_3.Object.st_Prefeitura_Fone.Visible = True
End If

Return 1
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge296_quadro_farmaceutico_filial
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge296_quadro_farmaceutico_filial
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge296_quadro_farmaceutico_filial
integer y = 220
integer width = 1888
integer height = 1172
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge296_quadro_farmaceutico_filial
integer width = 1486
integer height = 200
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge296_quadro_farmaceutico_filial
integer x = 64
integer width = 1417
integer height = 84
string dataobject = "dw_ge296_selecao_filial"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
		This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia	
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia	
		End If
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge296_quadro_farmaceutico_filial
integer y = 272
integer width = 1829
integer height = 1096
string dataobject = "dw_ge296_lista_farmaceutico_filial"
end type

event dw_2::ue_recuperar;//OverRide

Return This.Retrieve(ivo_Filial.cd_filial)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;If IsNull(ivo_Filial.Cd_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial para localizar os farmac$$HEX1$$ea00$$ENDHEX$$uticos.")
	dw_1.Event ue_Pos(1, "nm_filial")
	Return -1
End If

Return 1
end event

event dw_2::constructor;call super::constructor;
If Not gf_conecta_banco_rh(gtr_RH, "vetorh_ti") Then
	MessageBox('Falha!','N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar o banco de dados ORACLE_RH. ~r~nA tela "'+Parent.Title+'" ser$$HEX1$$e100$$ENDHEX$$ encerrrada.',StopSign!)
	Close(Parent)
	Return
Else
	This.SetTransObject(gtr_RH)
	dw_3.SetTransObject(gtr_RH)
End if
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge296_quadro_farmaceutico_filial
integer x = 1458
integer y = 52
integer height = 192
string dataobject = "dw_ge296_relatorio"
end type

