HA$PBExportHeader$w_ge175_alteracao_parametro_loja.srw
forward
global type w_ge175_alteracao_parametro_loja from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge175_alteracao_parametro_loja from dc_w_cadastro_selecao_lista
string accessiblename = "Cadastro de dados de RT do SNGPC (GE175)"
integer width = 2149
integer height = 868
string title = "GE175 - Altera$$HEX2$$e700e300$$ENDHEX$$o Par$$HEX1$$e200$$ENDHEX$$metros"
end type
global w_ge175_alteracao_parametro_loja w_ge175_alteracao_parametro_loja

type variables
uo_filial	io_Filial // GE009

String is_Odbc

String is_Insert_Parametros[]
end variables

forward prototypes
public function boolean wf_atualiza_parametro_loja_definicao (string ps_valor)
public function boolean wf_atualiza_parametro_filial ()
public function boolean wf_desconecta_filial ()
public function boolean wf_conecta_filial ()
public function boolean wf_insert_parametro_loja (string ps_parametro, string ps_valor)
public function boolean wf_insert_parametros_na_filial (string ps_parametro, string ps_valor)
end prototypes

public function boolean wf_atualiza_parametro_loja_definicao (string ps_valor);Long ll_Linha

String ls_Parametro

dw_2.AcceptText( )

For ll_Linha = 1 To dw_2.RowCount( )
	ls_Parametro	= dw_2.Object.Cd_Parametro	[ ll_Linha ]
	
	Update parametro_loja_definicao
	Set	id_exporta_filial 	= :ps_Valor
	Where cd_parametro 	= :ls_Parametro
	And cd_parametro NOT IN ( 'ID_NFE_LIBERADA', 'NR_NF_NFCE' )
	USING  SqlCa;

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_MsgdbError("Erro ao atualizar a tabela PARAMETRO_LOJA_DEFINICAO - " + ls_Parametro + " .")
		Return False
	End If
Next

SqlCa.of_Commit()

Return True
end function

public function boolean wf_atualiza_parametro_filial ();//Funcao descontinuada

Return False


//dw_1.AcceptText( )
//dw_2.AcceptText( )
//
//dwItemStatus ldwis_Status
//
//Long ll_Linha
//
//Integer li_Count
//
//String ls_Codigo
//String ls_Valor
//
//For ll_Linha = 1 To dw_2.RowCount( )
//	
//	ldwis_Status = dw_2.GetItemStatus( ll_Linha, 'vl_parametro', Primary! )
//			
//	If ldwis_Status = DataModified! or ldwis_Status = NewModified! Then
//	
//		ls_Codigo	= dw_2.Object.Cd_Parametro	[ ll_Linha ]
//		ls_Valor		= dw_2.Object.Vl_Parametro	[ ll_Linha ]
//		
//		//Paremetro nao deve ser alterado para n$$HEX1$$e300$$ENDHEX$$o mudar o sequencial de notas NFCE da filial
//		If ls_Codigo = 'NR_NF_NFCE' Then
//			dw_2.Object.Cd_Parametro	[ ll_Linha ] = 0
//			Continue
//		End If
//				
//		Select Count(*) 
//		 Into :li_Count
//		 From parametro_loja
//		 Where cd_parametro = :ls_Codigo
//		 Using itr_Filial;
//		
//		If itr_Filial.SqlCode = -1 Then
//			itr_Filial.Of_MsgdbError("Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro " + ls_Codigo )
//			Return False
//		End If
//		
//		If li_Count = 0 Then
//			Insert Into parametro_loja(cd_parametro, vl_parametro)	
//				Values( :ls_Codigo, :ls_Valor )
//			Using itr_Filial;
//			
//		Else
//			Update parametro_loja
//			Set	vl_parametro	= :ls_Valor
//			Where cd_parametro = :ls_Codigo
//			Using itr_Filial;
//		End If
//	
//		If itr_Filial.SqlCode = -1 Then
//			itr_Filial.of_Rollback()
//			itr_Filial.Of_MsgdbError("Erro ao atualizar a tabela PARAMETRO_LOJA - FILIAL")
//			Return False
//		End If
//		
//	End If //ldwis_Status
//
//Next
//
//itr_Filial.of_Commit()

//Return True
end function

public function boolean wf_desconecta_filial ();//If itr_Filial.of_IsConnected( ) Then
//	itr_Filial.of_Disconnect( )
//End If

Return False
end function

public function boolean wf_conecta_filial ();//Boolean lb_Sucesso = True
//
//Try
//	dw_1.AcceptText( )
//	
//	Open(w_Aguarde)
//	w_Aguarde.Title = "Conectando no banco de dados da filial " + String( io_Filial.Cd_Filial )
//	
//	Return gf_GE136_Conecta_Banco_Filial( io_Filial.Cd_Filial, Ref itr_Filial )
//
//Catch( Exception ex )
//	MessageBox( "Exeption", ex.getMessage( ), StopSign! )
//	
//Finally
//	If IsValid( w_Aguarde ) Then Close( w_Aguarde )
//	
//End Try

Return False
end function

public function boolean wf_insert_parametro_loja (string ps_parametro, string ps_valor);//************************
//Insere parametro_loja na matriz

Boolean lb_Sucesso = False

Integer li_count

If ps_Valor = '' Then ps_Valor = '?'

SELECT count(*)
	INTO :li_count
FROM parametro_loja
WHERE cd_filial 		 = :io_Filial.Cd_Filial
	AND cd_parametro = :ps_parametro
USING SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro: " + ps_parametro + " .")
	Return False
End If
		
If li_count = 0 Then //INSERT
	INSERT INTO parametro_loja ( cd_filial, cd_parametro, vl_parametro )
		SELECT :io_Filial.Cd_Filial, :ps_parametro, :ps_Valor
 		  FROM parametro
		WHERE id_parametro = '1'
			AND NOT EXISTS ( SELECT *
									   FROM parametro_loja AS x
									 WHERE x.cd_filial 			= :io_Filial.Cd_Filial
									 	AND  x.cd_parametro = :ps_parametro )
	USING SqlCa;

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_MsgdbError("Erro no insert do par$$HEX1$$e200$$ENDHEX$$metro: " + ps_parametro + " .")
		Return False
	End If
	
	SqlCa.of_Commit()
End If

Return True


end function

public function boolean wf_insert_parametros_na_filial (string ps_parametro, string ps_valor);////**********************
////Grava parametro_loja na filial
//
//Boolean lb_Sucesso = False
//
//Integer li_count
//
//If ps_Valor = '' Then ps_Valor = '?'
//
//SELECT count(*)
//	INTO :li_count
//FROM parametro_loja
//WHERE cd_parametro = :ps_parametro
//USING itr_Filial;
//
//If itr_Filial.SqlCode = -1 Then
//	itr_Filial.of_MsgdbError("Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro: " + ps_parametro + ". Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_insert_parametros_na_filial(string,string)")
//	Return False
//End If
//		
//If li_count = 0 Then //INSERT
//	INSERT INTO parametro_loja ( cd_parametro, vl_parametro )
//		SELECT :ps_parametro, :ps_Valor
// 		  FROM parametro
//		WHERE id_parametro = '1'
//			AND NOT EXISTS ( SELECT *
//									   FROM parametro_loja AS x
//									 WHERE x.cd_parametro = :ps_parametro )
//	USING itr_Filial;
//
//	If itr_Filial.SqlCode = -1 Then
//		itr_Filial.of_Rollback()
//		itr_Filial.of_MsgdbError("Erro no insert do par$$HEX1$$e200$$ENDHEX$$metro: " + ps_parametro + ". Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_insert_parametros_na_filial(string,string)")
//		Return False
//	End If
//	
//	itr_Filial.of_Commit()
//End If

Return True


end function

on w_ge175_alteracao_parametro_loja.create
call super::create
end on

on w_ge175_alteracao_parametro_loja.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;io_Filial	= Create uo_Filial
end event

event close;call super::close;Destroy io_Filial

end event

event ue_postopen;call super::ue_postopen;This.ivm_Menu.mf_Incluir( False )
This.ivm_Menu.mf_Excluir( False )

ivb_grava_log = True
end event

event ue_update;// OverRide
Boolean lb_Retorno = False

String ls_Parametro_Odbc
String ls_Msg

lb_Retorno = dw_2.Event ue_Update( ) > 0

If lb_Retorno Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Altera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso." )
End If
	
Return lb_Retorno
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge175_alteracao_parametro_loja
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge175_alteracao_parametro_loja
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge175_alteracao_parametro_loja
integer x = 50
integer y = 76
integer width = 1993
integer height = 80
string dataobject = "dw_ge175_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "nm_fantasia"
		If Trim(Data) <> "" Then
			If Data <> io_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			io_Filial.of_Inicializa( )
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia[1] = io_Filial.Nm_Fantasia			
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;String ls_Coluna

ls_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	
	Choose Case ls_Coluna
		Case "nm_fantasia"
			io_Filial.of_Localiza_Filial( This.GetText( ) )
			
			If io_Filial.Localizada Then
				This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
			Else
			//	cb_Inventario.Enabled = False
			End If
	End Choose
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset( )
end event

event dw_1::losefocus;call super::losefocus;If IsValid( io_Filial ) Then
	If io_Filial.Cd_Filial <> This.Object.Cd_Filial[ 1 ] Then
		This.Object.Nm_Fantasia[ 1 ] = io_Filial.Nm_Fantasia
	End If
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge175_alteracao_parametro_loja
integer x = 23
integer y = 200
integer width = 2062
integer height = 456
string text = "Par$$HEX1$$e200$$ENDHEX$$metros"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge175_alteracao_parametro_loja
integer x = 23
integer width = 2062
integer height = 188
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge175_alteracao_parametro_loja
integer x = 64
integer y = 264
integer width = 2002
integer height = 360
string dataobject = "dw_ge175_lista"
end type

event dw_2::ue_recuperar;// OverRide

Return This.Retrieve( io_Filial.Cd_Filial, is_Insert_Parametros[] )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Parent.ivm_Menu.mf_Excluir( False )
Parent.ivm_Menu.mf_Incluir( False )

Return AncestorReturnValue
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;If Not io_Filial.Localizada Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma filial para recuperar os dados.", Information! )
	Return -1
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.Of_grava_log(True)
end event

