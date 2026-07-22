HA$PBExportHeader$w_ge410_de_para_fornecedor_produto.srw
forward
global type w_ge410_de_para_fornecedor_produto from dc_w_cadastro_freeform
end type
end forward

global type w_ge410_de_para_fornecedor_produto from dc_w_cadastro_freeform
integer width = 2098
integer height = 680
string title = "GE410 - Altera$$HEX2$$e700e300$$ENDHEX$$o de Fornecedor de Produtos"
end type
global w_ge410_de_para_fornecedor_produto w_ge410_de_para_fornecedor_produto

type variables
uo_Fornecedor ivo_Fornecedor_de, &
                         ivo_Fornecedor_para
end variables

on w_ge410_de_para_fornecedor_produto.create
call super::create
end on

on w_ge410_de_para_fornecedor_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;// Cria o objeto fornecedor
ivo_Fornecedor_de   = Create uo_Fornecedor
ivo_Fornecedor_para = Create uo_Fornecedor
end event

event close;call super::close;// Destr$$HEX1$$f300$$ENDHEX$$i o objeto de localiza$$HEX2$$e700e300$$ENDHEX$$o de fornecedor
Destroy(ivo_Fornecedor_de)
Destroy(ivo_Fornecedor_para)
end event

event ue_save;call super::ue_save;STRING  lvs_Fornecedor_de, &
 		  lvs_Fornecedor_para, &
		  lvs_mensagem
			
LONG lvl_Produtos_Alterados			

dw_1.AcceptText()
	
lvs_Fornecedor_de   = dw_1.Object.Cd_Fornecedor_De[1]
lvs_Fornecedor_para = dw_1.Object.Cd_Fornecedor_Para[1] 

If ( IsNull(lvs_Fornecedor_de) or IsNull(lvs_Fornecedor_para) ) or &
	( lvs_Fornecedor_de = lvs_Fornecedor_para ) Then
	
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o' , 'Preencha corretamente todos os campos. $$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio que eles sejam diferentes.' , Information! , Ok! ) 		

	Return 0
	
End If	

SetPointer(HourGlass!)
	
Update produto_geral
Set cd_fornecedor_usual   = :lvs_Fornecedor_para
Where cd_fornecedor_usual = :lvs_Fornecedor_de
Using Sqlca;

lvl_Produtos_Alterados = Sqlca.Sqlnrows

If Sqlca.Sqlcode = -1 Then
	  SqlCa.of_MsgDbError()
	  SqlCa.of_RollBack()
Else
	SqlCa.of_Commit()
	  
	  lvs_mensagem = 'Foram alterados ' + String( lvl_Produtos_Alterados ) + ' produto(s).'
	  MessageBox( 'Sucesso' ,  lvs_mensagem, Information!, Ok! )
	  
	  ivm_Menu.mf_Confirmar( False )
	  ivm_Menu.mf_Cancelar( False )
					
End If

SetPointer(Arrow!)
	
Return AncestorReturnValue
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge410_de_para_fornecedor_produto
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge410_de_para_fornecedor_produto
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge410_de_para_fornecedor_produto
integer x = 55
integer y = 72
integer width = 1957
integer height = 380
string dataobject = "dw_ge410_de_para_fornecedor_produto"
boolean vscrollbar = false
end type

event dw_1::ue_key;call super::ue_key;Boolean lvb_Habilita

STRING  lvs_Coluna

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
			
	If lvs_Coluna = "nm_razao_social_de" Then
	
		ivo_Fornecedor_de.of_Localiza_Fornecedor(dw_1.GetText())
		
		// Se localizar o fornecedor atualiza a DW
		If ivo_Fornecedor_de.Localizado Then   
			dw_1.Object.Cd_Fornecedor_de	[1] = ivo_Fornecedor_de.Cd_Fornecedor
			dw_1.Object.Nm_Razao_Social_de[1] = ivo_Fornecedor_de.Nm_razao_social
		Else	
			ivo_Fornecedor_de.of_Inicializa()
			
			dw_1.Object.Cd_Fornecedor_de		[1] = ivo_Fornecedor_de.Cd_Fornecedor   
			dw_1.Object.Nm_Razao_Social_de	[1]	= ivo_Fornecedor_de.Nm_razao_social 
		End If
		
	End If	
	
	If lvs_Coluna = "nm_razao_social_para" Then
	
		ivo_Fornecedor_para.of_Localiza_Fornecedor(dw_1.GetText())
		
		// Se localizar o fornecedor atualiza a DW
		If ivo_Fornecedor_para.Localizado Then   			
			dw_1.Object.Cd_Fornecedor_para		[1] = ivo_Fornecedor_para.Cd_Fornecedor
			dw_1.Object.Nm_Razao_Social_para	[1] = ivo_Fornecedor_para.Nm_razao_social
			
			lvb_Habilita = True
				
		Else
			ivo_Fornecedor_para.of_Inicializa()
			
			dw_1.Object.Cd_Fornecedor_para		[1]   	= ivo_Fornecedor_para.Cd_Fornecedor   
			dw_1.Object.Nm_Razao_Social_para	[1]	= ivo_Fornecedor_para.Nm_razao_social 
			
			lvb_Habilita = False
			
		End If
		
		ivm_Menu.mf_Confirmar( lvb_Habilita )
		ivm_Menu.mf_Cancelar( lvb_Habilita )
		
	End If	
				
End If
end event

event dw_1::constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"nm_razao_social_de", "nm_razao_social_para"}

This.of_SetColSelection(True)
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge410_de_para_fornecedor_produto
integer x = 32
integer y = 24
integer width = 1993
integer height = 432
end type

