HA$PBExportHeader$w_ge347_cadastro_promocao_pbm.srw
forward
global type w_ge347_cadastro_promocao_pbm from w_ge347_cadastro_promocao_vinculada
end type
end forward

global type w_ge347_cadastro_promocao_pbm from w_ge347_cadastro_promocao_vinculada
string title = "GE347 - Cadastro de Promo$$HEX2$$e700f500$$ENDHEX$$es PBM CLAMED"
end type
global w_ge347_cadastro_promocao_pbm w_ge347_cadastro_promocao_pbm

on w_ge347_cadastro_promocao_pbm.create
call super::create
end on

on w_ge347_cadastro_promocao_pbm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Super::EVENT ue_PostOpen() // Para execu$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo ancestral

ivo_Promocao.ivs_Tipo = "C"
end event

event open;// OverRide
Try
	SetPointer(HourGlass!)

	This.Event ue_PreOpen()
	
	Choose Case il_Retorno
		Case -1
			Close( This )
	
		Case 1
			This.Post Event ue_PostOpen()
			
			If LenA(This.Title) = 0 Then
				If IsValid(gvo_Aplicacao) Then This.Title = gvo_Aplicacao.iapp_Aplicacao.DisplayName
			End If
	End Choose
	
Catch( Exception ex )
	MessageBox( "Exception", ex.getMessage( ) )
	
Finally
	SetPointer(Arrow!)
	
End Try

Boolean lvb_Habilita = False	

If IsValid( This ) Then // O Close no c$$HEX1$$f300$$ENDHEX$$digo ancestral destoy a tela causando erro nos testes abaixo
	
	// Atualiza as vari$$HEX1$$e100$$ENDHEX$$veis de controle de acesso as fun$$HEX2$$e700f500$$ENDHEX$$es do menu
	If IsValid(gvo_Aplicacao) And IsValid( ivm_Menu ) Then		
		ivm_Menu.ivb_Permite_Incluir	= gvo_Aplicacao.ivo_Seguranca.of_Get_Id_Inclusao( )
		ivm_Menu.ivb_Permite_Alterar	= gvo_Aplicacao.ivo_Seguranca.of_Get_Id_Alteracao( )
		ivm_Menu.ivb_Permite_Excluir	= gvo_Aplicacao.ivo_Seguranca.of_Get_Id_Exclusao( )
		
		// Atualiza o menu da janela para permanecer as fun$$HEX2$$e700f500$$ENDHEX$$es desabilitadas
		// conforme o menu principal
		Choose Case gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
			Case 'RL', 'CL', 'EL', 'VV', 'TL', 'DB', 'BL', 'AU', 'CP', 'AT'
				//SISTEMAS DE LOJA N$$HEX1$$c300$$ENDHEX$$O ATUALIZAR$$HEX1$$c300$$ENDHEX$$O NOVAMENTE O MENU
			Case Else
				gvo_Aplicacao.ivo_Seguranca.of_Habilita_Menu(ivm_Menu)	
		End Choose
		
		//	//////// procedimento HELP ////////
		If Lower( RightA( Trim( gvo_Aplicacao.ivs_Path_Manual ), 3 ) ) = 'chm' Then
			If This.AccessibleName <> '' Then
				lvb_Habilita = True
			End If		
		Else
			lvb_Habilita = True
	//		If FileExists(gvo_Aplicacao.ivs_Path_Manual  + gvo_Aplicacao.ivo_Seguranca.Cd_Sistema +"/" + Trim(This.ClassName())  + ".html") Then
	//			lvb_Habilita = True
	//		End If
		End If
		
		If IsValid(ivm_Menu) Then	
			ivm_Menu.mf_Habilita_Help(lvb_Habilita)
		End If	
		//	//////// procedimento HELP ////////		
	End If
	
	// Comentado por Fernando Cambiaghi em 31/08/2016, pois estava deslocando as telas que estavam com a propriedade [center] marcada
	// Posiciona a janela
	X = 1	
	Y = 1
	
	// Prepara a exibi$$HEX2$$e700e300$$ENDHEX$$o da janela
	This.SetRedraw(False)
	
End If

ids = Create dc_uo_ds_base

If Not ids.of_ChangeDataObject("ds_ge347_produto_normal") Then
	Destroy(ids)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge347_produto_normal'.", StopSign!)
	Return -1
End If

SetNull(ivs_Responsavel)
Boolean lb_Permite_alterar

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE347_LIBERACAO_PROCEDIMENTO_PROMO_PBM", ref ivs_Responsavel) Then 
	Return Close( This )
End If
end event

type dw_visual from w_ge347_cadastro_promocao_vinculada`dw_visual within w_ge347_cadastro_promocao_pbm
end type

type gb_aux_visual from w_ge347_cadastro_promocao_vinculada`gb_aux_visual within w_ge347_cadastro_promocao_pbm
end type

type gb_6 from w_ge347_cadastro_promocao_vinculada`gb_6 within w_ge347_cadastro_promocao_pbm
end type

type cb_selecao_filiais from w_ge347_cadastro_promocao_vinculada`cb_selecao_filiais within w_ge347_cadastro_promocao_pbm
end type

type gb_2 from w_ge347_cadastro_promocao_vinculada`gb_2 within w_ge347_cadastro_promocao_pbm
end type

type cb_selecao_filial from w_ge347_cadastro_promocao_vinculada`cb_selecao_filial within w_ge347_cadastro_promocao_pbm
integer x = 590
end type

type dw_4 from w_ge347_cadastro_promocao_vinculada`dw_4 within w_ge347_cadastro_promocao_pbm
end type

type dw_2 from w_ge347_cadastro_promocao_vinculada`dw_2 within w_ge347_cadastro_promocao_pbm
end type

type dw_7 from w_ge347_cadastro_promocao_vinculada`dw_7 within w_ge347_cadastro_promocao_pbm
end type

type dw_3 from w_ge347_cadastro_promocao_vinculada`dw_3 within w_ge347_cadastro_promocao_pbm
end type

type dw_8 from w_ge347_cadastro_promocao_vinculada`dw_8 within w_ge347_cadastro_promocao_pbm
end type

type dw_9 from w_ge347_cadastro_promocao_vinculada`dw_9 within w_ge347_cadastro_promocao_pbm
end type

type gb_3 from w_ge347_cadastro_promocao_vinculada`gb_3 within w_ge347_cadastro_promocao_pbm
end type

type dw_1 from w_ge347_cadastro_promocao_vinculada`dw_1 within w_ge347_cadastro_promocao_pbm
string dataobject = "dw_ge347_promocao_pbm"
end type

type dw_5 from w_ge347_cadastro_promocao_vinculada`dw_5 within w_ge347_cadastro_promocao_pbm
end type

type cb_1 from w_ge347_cadastro_promocao_vinculada`cb_1 within w_ge347_cadastro_promocao_pbm
end type

type cb_2 from w_ge347_cadastro_promocao_vinculada`cb_2 within w_ge347_cadastro_promocao_pbm
end type

type cb_3 from w_ge347_cadastro_promocao_vinculada`cb_3 within w_ge347_cadastro_promocao_pbm
end type

type st_1 from w_ge347_cadastro_promocao_vinculada`st_1 within w_ge347_cadastro_promocao_pbm
end type

type st_2 from w_ge347_cadastro_promocao_vinculada`st_2 within w_ge347_cadastro_promocao_pbm
end type

type st_3 from w_ge347_cadastro_promocao_vinculada`st_3 within w_ge347_cadastro_promocao_pbm
end type

type st_4 from w_ge347_cadastro_promocao_vinculada`st_4 within w_ge347_cadastro_promocao_pbm
end type

type st_5 from w_ge347_cadastro_promocao_vinculada`st_5 within w_ge347_cadastro_promocao_pbm
end type

type st_6 from w_ge347_cadastro_promocao_vinculada`st_6 within w_ge347_cadastro_promocao_pbm
end type

type cb_4 from w_ge347_cadastro_promocao_vinculada`cb_4 within w_ge347_cadastro_promocao_pbm
boolean visible = false
boolean enabled = false
end type

type gb_4 from w_ge347_cadastro_promocao_vinculada`gb_4 within w_ge347_cadastro_promocao_pbm
end type

type gb_1 from w_ge347_cadastro_promocao_vinculada`gb_1 within w_ge347_cadastro_promocao_pbm
end type

