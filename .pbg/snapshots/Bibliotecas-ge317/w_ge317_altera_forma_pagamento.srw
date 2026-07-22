HA$PBExportHeader$w_ge317_altera_forma_pagamento.srw
forward
global type w_ge317_altera_forma_pagamento from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge317_altera_forma_pagamento
end type
type gb_2 from groupbox within w_ge317_altera_forma_pagamento
end type
end forward

global type w_ge317_altera_forma_pagamento from dc_w_response_ok_cancela
string tag = "w_ge317_consulta_nf_venda_alteracao"
integer width = 1646
integer height = 1228
string title = "GE317 - Forma de Pagamento"
dw_2 dw_2
gb_2 gb_2
end type
global w_ge317_altera_forma_pagamento w_ge317_altera_forma_pagamento

type variables
String	ivs_Especie, &
		ivs_Serie
		
Long 	ivl_Cd_Filial, &
		ivl_Nr_Nf
end variables

event open;call super::open;String lvs_Parm
long lvl_linha_dw2

lvs_Parm = Message.StringParm

ivl_Cd_Filial 	= Long(MidA(lvs_Parm, 1, 4))
ivl_Nr_Nf		= Long(MidA(lvs_Parm, 5,8))
ivs_Especie 	= Trim(MidA(lvs_Parm, 13,3))
ivs_Serie		= Trim(MidA(lvs_Parm, 16,3))

lvl_linha_dw2 = dw_2.Event ue_recuperar()
if lvl_linha_dw2 > 0 then dw_1.Event ue_recuperar()
end event

on w_ge317_altera_forma_pagamento.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge317_altera_forma_pagamento.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_postopen;//OverRide

ivo_dbError = Create dc_uo_dbError


end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge317_altera_forma_pagamento
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge317_altera_forma_pagamento
integer y = 0
integer width = 1605
integer height = 392
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge317_altera_forma_pagamento
integer x = 32
integer y = 412
integer width = 1586
integer height = 592
string dataobject = "dw_ge317_forma_pagto_multiplas_formas"
boolean vscrollbar = true
string ivs_cor_linha_padrao = ""
boolean ivb_ordena_colunas = true
end type

event dw_1::ue_recuperar;// OverRide

Return This.Retrieve(ivl_Cd_Filial, ivl_Nr_Nf, ivs_Especie, ivs_Serie)
end event

event dw_1::itemchanged;call super::itemchanged;
if dwo.name = 'cd_forma_pagamento' then
	cb_ok.enabled = (data = 'DI')
	if data <> 'DI' then return 1
end if

end event

event dw_1::constructor;call super::constructor;This.Of_SetRowSelection( )
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge317_altera_forma_pagamento
integer x = 1312
integer y = 1028
boolean enabled = false
end type

event cb_ok::clicked;call super::clicked;long lvl_linha, lvl_count_cco
String lvs_Retorno
datetime lvdh_Servidor
string lvs_nr_matricula

if dw_2.ModifiedCount()+dw_1.ModifiedCount() > 0 then 
	
	//Se cartao, verifica se existe na CCO
	if dw_2.getitemstring( 1, 'cd_forma_pagamento') = 'CP' or dw_2.getitemstring( 1, 'cd_forma_pagamento') = 'CA' then
		Select count(1) into :lvl_count_cco From cartao_comprovante_operacao cco (index idx_nf_venda) Where cco.cd_filial = :ivl_Cd_Filial and cco.nr_nf = :ivl_Nr_Nf and cco.de_serie = :ivs_Serie and cco.de_especie = :ivs_Especie Using SQLCa;
		If SQLCa.SQLCode = -1 Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',' Falha na consulta da comprovante cart$$HEX1$$e300$$ENDHEX$$o!',Exclamation!)
			dw_2.event ue_pos( 1, 'cd_forma_pagamento')
			Return
		End If

		if lvl_count_cco = 0 then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',' Para escolha '+ dw_2.getitemstring( 1, 'cd_forma_pagamento') + ' n$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o lan$$HEX1$$e700$$ENDHEX$$amento do comprovante de cart$$HEX1$$e300$$ENDHEX$$o!',Exclamation!)
			dw_2.event ue_pos( 1, 'cd_forma_pagamento')
			Return
		end if
	end if
	
	//Somente deixa salvar se usuario tiver permissao....
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE317_ALTERA_FORMA_PAGTO_VENDA", ref lvs_nr_matricula) Then 
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Acesso n$$HEX1$$e300$$ENDHEX$$o permitido para altera$$HEX2$$e700e300$$ENDHEX$$o nesta funcionalidade!',Exclamation!)
		return
	end if

	lvdh_Servidor = gf_getserverdate()

	Update log_exportacao_docto
	set id_situacao_log 		= 'X',
		 nr_matricula_revisao	= :lvs_nr_matricula,
		 dh_revisao				= :lvdh_Servidor,
		 dh_exclusao			= :lvdh_Servidor,
		 de_revisao				=	'ALTERADO FORMA PAGTO',
		 id_revisado				=	'R'
	Where  cd_filial 				= :ivl_Cd_Filial
		and nr_nf 					= :ivl_Nr_Nf
		and de_especie 			= :ivs_Especie
		and de_serie 				= :ivs_Serie
		and cd_ambiente_sap 	in ('SPQ','PRD')
		and id_situacao_log		= 'E' 		
	Using sqlca;

	dw_2.update( )
	dw_1.update( )
	
	sqlca.of_commit( )
	
end if

CloseWithReturn(Parent, 'Sucesso')
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge317_altera_forma_pagamento
integer x = 978
integer y = 1028
end type

type dw_2 from dc_uo_dw_base within w_ge317_altera_forma_pagamento
integer x = 32
integer y = 32
integer width = 1573
integer height = 344
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge317_forma_pagto_detalhe"
end type

event ue_recuperar;// OverRide

Return This.Retrieve(ivl_Cd_Filial, ivl_Nr_Nf, ivs_Especie, ivs_Serie)
end event

event itemchanged;call super::itemchanged;
//if dwo.name = 'cd_forma_pagamento' then
////	if data = 'DI' then
////		cb_ok.enabled = true
////	else
////		cb_ok.enabled = false
////	end if
////
////	if data <> 'DI' then return 1
//	
//
//	
//end if

cb_ok.enabled = true
end event

type gb_2 from groupbox within w_ge317_altera_forma_pagamento
integer x = 23
integer y = 380
integer width = 1605
integer height = 636
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

