HA$PBExportHeader$w_ge395_semana_remanej_filial.srw
forward
global type w_ge395_semana_remanej_filial from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge395_semana_remanej_filial
end type
type dw_3 from datawindow within w_ge395_semana_remanej_filial
end type
end forward

global type w_ge395_semana_remanej_filial from dc_w_cadastro_selecao_lista
integer width = 1824
integer height = 1684
string title = "GE395 - Semana Remanejamento Filial"
cb_1 cb_1
dw_3 dw_3
end type
global w_ge395_semana_remanej_filial w_ge395_semana_remanej_filial

type variables
uo_filial io_filial

string is_filiais, is_nulo
Long ivl_linhas
end variables

forward prototypes
public function boolean wf_atualiza_filial_semana (long al_filial, long al_semana)
public function boolean wf_perfil_liberado (string is_matricula)
end prototypes

public function boolean wf_atualiza_filial_semana (long al_filial, long al_semana);Long ll_Qtd
String  ls_MSG      

select  count(*) 
Into 	  :ll_Qtd
from   filial a
inner  join remanejamento_filial_semana b
on      a.cd_filial = b.cd_filial
where  a.cd_filial =:al_filial
Using SqlCA;


If SqlCa.SqlCode = -1 Then
	ls_MSG = 	"Erro ao consultar remanejamento filial semana': " + SQLCA.SQLErrText
	MessageBox("Erro", ls_MSG, StopSign!)
	Return False
End If


If (ll_Qtd>0)  Then 
	Update remanejamento_filial_semana
	set       id_semana=:al_semana
	where  cd_filial=:al_filial
	Using SqlCA;	


	If SqlCa.SqlCode = -1 Then
	   ls_MSG = 	"Atualiza$$HEX2$$e700e300$$ENDHEX$$o da remanejamento filial semana: " + SQLCA.SQLErrText
	   SqlCa.of_Rollback()
	   MessageBox("Erro", ls_MSG, StopSign!)
	   Return False
	End If
End If 


Return True






end function

public function boolean wf_perfil_liberado (string is_matricula);//String ls_Usuario
//
//Select nr_matricula
//Into :ls_Usuario
//From usuario_sistema
//Where cd_sistema			= 'GC'
//   and nr_matricula		= :is_matricula
//   and cd_perfil_usuario	in (1)
////   and cd_perfil_usuario	in (5, 32)
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//	 Case 0
//		Return True
//	 Case 100
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o esta liberado para este procedimento. ~rPerfil autorizado: GERENTE LOGISTICA e COORDENADORES", Exclamation!)
//	 Case -1 
//		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do perfil do usu$$HEX1$$e100$$ENDHEX$$rio do FA. " + SqlCa.SqlErrText)
//End Choose
//
Return True
//
end function

on w_ge395_semana_remanej_filial.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_3
end on

on w_ge395_semana_remanej_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_3)
end on

event open;call super::open;io_Filial = Create uo_Filial
end event

event close;call super::close;Destroy(io_Filial)
end event

event ue_postopen;call super::ue_postopen;dw_2.Retrieve()
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge395_semana_remanej_filial
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge395_semana_remanej_filial
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge395_semana_remanej_filial
integer x = 55
integer y = 72
integer width = 1682
integer height = 196
string dataobject = "dw_ge395_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long ll_Lojas

dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "id_filiais"
		
		If Data = 'C' Then
		
			is_filiais = is_nulo 
			
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			ll_Lojas = Message.DoubleParm
			
			If ll_Lojas > 0 Then
				is_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
			
		End If
		
End Choose

end event

event dw_1::ue_key;call super::ue_key;String ls_Coluna

ls_Coluna = This.GetColumnName()

If	ls_Coluna = "nm_filial" Then
		
	If key = KeyEnter! Then	io_Filial.of_Localiza_Filial(This.GetText())		
	
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge395_semana_remanej_filial
integer y = 296
integer width = 1728
integer height = 1076
integer weight = 700
fontcharset fontcharset = ansi!
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge395_semana_remanej_filial
integer width = 1728
integer height = 268
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge395_semana_remanej_filial
integer x = 69
integer width = 1650
integer height = 952
string dataobject = "dw_ge395_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	ls_Filial,&
			ls_Semana

dw_1.AcceptText()			
		
ls_Filial		=	dw_1.object.id_filiais	[1]
ls_Semana =  dw_1.object.id_semana[1]

If ls_Filial = 'C' Then
	If Not IsNull(is_Filiais) Then
		dw_2.of_AppendWhere("a.cd_filial in (" + is_Filiais + ")")
	End If
End If

If (ls_Semana<>"Todas")  Then 
   dw_2.of_AppendWhere(" b.id_semana =  "+string (ls_Semana) )
End If 


Return AncestorReturnValue
end event

event dw_2::itemchanged;call super::itemchanged;
Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <>io_filial.nm_fantasia	Then
				Return 1
			End If
		Else

			io_filial.of_inicializa( )
			
			This.Object.cd_produto[This.GetRow()] =io_filial.cd_filial
			This.Object.de_Produto[This.GetRow()] =io_filial.nm_fantasia
		End If
			
End Choose
end event

event dw_2::ue_key;call super::ue_key;Long ll_Qtd,&
	   	ll_Filial
			
String ls_MSG			

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fantasia"

			io_Filial.of_Localiza_filial( This.GetText() )				
						
			If io_Filial.localizada Then 
				ll_Filial = io_Filial.cd_filial
				
				select 	COUNT(*) 
				Into       :ll_Qtd
				from   	filial a
				inner  	join remanejamento_filial_semana b
				on 	 	a.cd_filial = b.cd_filial
				inner 	join cidade c 
				on 		c.cd_cidade = a.cd_cidade
				where  	a.id_situacao = 'A'
				and     a.cd_filial = :ll_Filial
				Using SqlCA;
								
				If SqlCa.SqlCode = -1 Then
				    ls_MSG = 	"Erro ao consultar quantidade de filial remanejamento': " + SQLCA.SQLErrText
				    MessageBox("Erro", ls_MSG, StopSign!)
					Return -1 
				End If
				
				
				If (ll_Qtd=0) Then 
					This.Object.cd_filial [This.GetRow()] = io_Filial.cd_filial
					This.Object.nm_fantasia[This.GetRow()] = io_Filial.nm_fantasia
					This.Object.cd_unidade_federacao[This.GetRow()] = io_Filial.cd_unidade_federacao
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial j$$HEX1$$e100$$ENDHEX$$ tem Semana de Remanejamento: Editar Filial:"+String(ll_Filial),  Information! )				
					dw_2.Retrieve()
				End If 
				
			End If 
			
			
	End Choose
End If
end event

type cb_1 from commandbutton within w_ge395_semana_remanej_filial
integer x = 1225
integer y = 1380
integer width = 539
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Arquivo"
end type

event clicked;String lvs_Path,				&
	     lvs_Nome_Arquivo,	&
		 lvs_Arquivo,			&
		 lvs_Msg, 				&
		 lvs_Nulo,				&
		 lvs_Filial,				&
		 lvs_Semana,			&
		 ls_MSG


Integer lvi_Arquivo,&
		    lvi_Retorno, &
             lvi_Nulo

Long lvl_Linhas,	& 
	  lvl_Linha,		&
	  lvl_Prim_Semana,&
	  lvl_Ult_Semana
  
		  
dw_3.AcceptText()

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os dados devem estar da seguinte forma:~r~r" + &
                     	"Coluna A = Filial.~r" + &
					"Coluna B = N$$HEX1$$fa00$$ENDHEX$$mero da Semana")

lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo <> 1 Then Return

ivl_Linhas = 0

dw_3.Object.nm_arquivo[1] = lvs_Path

lvs_Msg = "Importar os produtos com os descontos do arquivo selecionado ?"
		  
If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Question!, OkCancel!, 2) = 2 Then Return

dw_2.SetRedRaw(False)

dw_3.AcceptText()
lvs_Arquivo = dw_3.Object.nm_arquivo [1]

dc_uo_excel lvo_Excel

lvo_Excel = Create dc_uo_excel

Open(w_Aguarde)


// Verifica a Primeira e Ultima Semana
select min(id_semana) as Pri_Semana, 
          max(id_semana) as Ult_Semana 
Into :	lvl_Prim_Semana,
	   :lvl_Ult_Semana
from remanejamento_filial_semana
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	ls_MSG = 	"Erro ao consultar remanejamento filial semana': " + SQLCA.SQLErrText
	MessageBox("Erro", ls_MSG, StopSign!)
	Return -1
End If

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
	
		// Leitura do Arquivo
		For lvl_Linha = 1 To lvl_Linhas
		
			lvs_Filial 	  = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A"))
			lvs_Semana = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B"))
			io_filial.of_Localiza_codigo_ativa(long(lvs_Filial)) 
			
			If IsNull(lvs_Filial) or IsNull(lvs_Semana)   Then
			   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor esta vazio na Linha: " + String(lvl_Linha),  Information! )
			   Return -1
			End If
			
			// Localiza a Filial
			If io_filial.Localizada Then 
				// Semana informada no Arquivo : Valida
				If long(lvs_Semana)>=lvl_Prim_Semana  and long(lvs_Semana)<=lvl_Ult_Semana   Then
					If Not wf_atualiza_filial_semana (long(lvs_Filial), long(lvs_Semana) ) Then Exit			
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Semana Inv$$HEX1$$e100$$ENDHEX$$lida! Semana :"+string(lvs_Semana)+"Na Linha :"+String(lvl_Linha),  Information! )
					Exit
				End If 
			Else 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial n$$HEX1$$e300$$ENDHEX$$o localizada! Na Linha :"+String(lvl_Linha),  Information! )
				Exit				
			End If 
					
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
			
		Next
	
		If ivl_Linhas > 0 Then
			Parent.ivm_Menu.mf_Confirmar(True)
			Parent.ivm_Menu.mf_Cancelar(True)
			Parent.ivb_Valida_Salva = True
		End If

	End If //Linha

End If //Excel

Close(w_Aguarde)

dw_2.SetRedRaw(True)
SqlCa.of_Commit()	
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o realizada para as Filiais!",  Information! )
dw_2.Retrieve()
Destroy(lvo_Excel)
end event

type dw_3 from datawindow within w_ge395_semana_remanej_filial
boolean visible = false
integer x = 59
integer y = 1136
integer width = 1454
integer height = 128
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ge395_selecao_arquivo"
boolean border = false
boolean livescroll = true
end type

