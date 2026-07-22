HA$PBExportHeader$w_ge424_cadastro_fabricante.srw
forward
global type w_ge424_cadastro_fabricante from dc_w_cadastro_freeform
end type
end forward

global type w_ge424_cadastro_fabricante from dc_w_cadastro_freeform
integer width = 1719
integer height = 620
string title = "GE424 - Cadastro de Fabricante"
long backcolor = 80269524
end type
global w_ge424_cadastro_fabricante w_ge424_cadastro_fabricante

type variables
uo_Fabricante ivo_Fabricante
end variables

forward prototypes
public function boolean wf_proximo_codigo ()
end prototypes

public function boolean wf_proximo_codigo ();Long lvl_Fabricante, &
     lvl_Proximo_Fabricante

Select max(cd_fabricante)
Into :lvl_Fabricante
From fabricante
Using SqlCa;

If SqlCa.SqlCode = 0 Then
	If IsNull(lvl_Fabricante) Then
		lvl_Proximo_Fabricante = 1
	Else
		lvl_Proximo_Fabricante = lvl_Fabricante + 1
	End If
	
	dw_1.Object.Cd_Fabricante[1] = lvl_Proximo_Fabricante
	
	Return True
Else
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo do fabricante")
	Return False
End If

Return True
end function

on w_ge424_cadastro_fabricante.create
call super::create
end on

on w_ge424_cadastro_fabricante.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Fabricante = Create uo_Fabricante
end event

event close;call super::close;Destroy(ivo_Fabricante)
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Fabricante

dw_1.AcceptText()

If Not gf_Verifica_Cutover("DH_CUTOVER_MATCH_CODE") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais permitida atualiza$$HEX2$$e700e300$$ENDHEX$$o por esta tela. Utilizar o SAP.", Exclamation!)
	Return False
End If

lvl_Fabricante = dw_1.Object.cd_fabricante[1]

If IsNull(lvl_Fabricante) Then
	If Not wf_Proximo_Codigo() Then Return False
End If

Return True
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge424_cadastro_fabricante
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge424_cadastro_fabricante
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge424_cadastro_fabricante
integer x = 32
integer y = 48
integer width = 1605
integer height = 336
string dataobject = "dw_ge424_cadastro"
boolean vscrollbar = false
end type

event dw_1::ue_key;If Key = KeyEnter! Then
	
	If This.GetColumnName() = "localizacao" Then
		
			ivo_Fabricante.of_Localiza_Fabricante(This.GetText())
			
			If ivo_Fabricante.Localizado Then
				This.Event ue_Reset()
				This.Event ue_Retrieve()
			End If
			
	End If
	
End If
end event

event dw_1::constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"localizacao"}

This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
		
	Case "nr_cgc"	
		If Not ( gf_CGC_Valido( data ) ) Then 		
			// CGC Invalido, continua com foco no campo CGC //
			RETURN 1 		  
		End If
		
End Choose
end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivo_Fabricante.of_Inicializa()

End If

Return AncestorReturnValue
end event

event dw_1::ue_recuperar;// Override

Return This.Retrieve(ivo_Fabricante.Cd_Fabricante)
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge424_cadastro_fabricante
integer x = 14
integer y = 0
integer width = 1637
integer height = 412
end type

