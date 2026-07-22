HA$PBExportHeader$w_ge103_consulta_saldo_filial.srw
forward
global type w_ge103_consulta_saldo_filial from dc_w_response
end type
type gb_1 from groupbox within w_ge103_consulta_saldo_filial
end type
type dw_1 from dc_uo_dw_base within w_ge103_consulta_saldo_filial
end type
end forward

global type w_ge103_consulta_saldo_filial from dc_w_response
integer width = 3323
integer height = 680
string title = "GE103 - Saldo Filial"
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
end type
global w_ge103_consulta_saldo_filial w_ge103_consulta_saldo_filial

type variables
uo_produto ivo_produto
dc_uo_odbc ivo_Odbc
uo_ge136_transacao_remota	ivtr_Filial

long ivl_produto
Long ivl_Filial
end variables

forward prototypes
public function string wf_identifica_valor_parametro (string ps_parametro, integer pi_coluna)
public function boolean wf_filial_sistema_java (long al_filial, ref string as_sistema_java, ref string as_erro)
public function boolean wf_conecta_banco_filial (long al_filial, dc_uo_odbc ao_odbc, ref dc_uo_transacao ao_transacao, ref string as_id_pdv_java, ref string as_erro)
end prototypes

public function string wf_identifica_valor_parametro (string ps_parametro, integer pi_coluna);String lvs_Coluna

Integer lvi_Contador, &
        lvi_Posicao = -2, &
        lvi_Start

For lvi_Contador = 1 To pi_Coluna
	lvi_Start = lvi_Posicao + 3
	
	lvi_Posicao = PosA(ps_Parametro, "@#!", lvi_Start)
Next

If lvi_Posicao = 0 Then
	lvs_Coluna = MidA(ps_Parametro, lvi_Start)
Else
	lvs_Coluna = MidA(ps_Parametro, lvi_Start, lvi_Posicao - lvi_Start)
End If

Return lvs_Coluna
end function

public function boolean wf_filial_sistema_java (long al_filial, ref string as_sistema_java, ref string as_erro);Select coalesce(id_sistema_novo, 'N')
Into :as_Sistema_Java
From filial
Where cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0		
		Return True
		
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel verificar se a filial "+String(al_Filial)+" $$HEX1$$e900$$ENDHEX$$ com sistema Java."
		Return False
		
	Case -1		
		as_Erro = "Erro ao verificar se a filial "+String(al_Filial)+" $$HEX1$$e900$$ENDHEX$$ com sistema Java: " + SqlCa.SqlErrText
		Return False		
End Choose

Return False
end function

public function boolean wf_conecta_banco_filial (long al_filial, dc_uo_odbc ao_odbc, ref dc_uo_transacao ao_transacao, ref string as_id_pdv_java, ref string as_erro);String	ls_DataBase,&
		ls_ServerName,&
		ls_Ip,&
		ls_Odbc,&
		ls_Id_Pdv_Java
		
		
select		de_database,
			de_servername,
			de_ip,
			coalesce(id_pdv_java, 'N')
Into	:ls_DataBase,
		:ls_ServerName,
		:ls_Ip,
		:ls_Id_Pdv_Java
from parametro_odbc
where cd_filial = :al_Filial
using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		as_Id_Pdv_java = ls_Id_Pdv_Java
	Case 100
		as_Erro = "Par$$HEX1$$e200$$ENDHEX$$metros do sistema n$$HEX1$$e300$$ENDHEX$$o localizados para criar a ODBC da filial "+String(al_Filial)+"."
		Return False
	Case -1
		as_Erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos par$$HEX1$$e200$$ENDHEX$$metros do ODBC da filial "+String(al_Filial)+".~rErro: " + SqlCa.SqlErrText
		Return False
End Choose

ls_Odbc = String(al_Filial, "0000")	

If SQLCa.Database = 'homologa' then
	If ls_Id_Pdv_Java = "S" Then
		ao_Odbc.ivs_DataBase		= ls_DataBase
		ao_Odbc.ivs_ServerName	= ls_ServerName
		ao_Odbc.ivs_ip					= "pgcentralhmg.clamed.com.br"
		ao_Odbc.ivs_Pdv_Java		= ls_Id_Pdv_Java
		
		ao_Odbc.of_grava_regedit_odbc(al_Filial)
	Else
		ls_Odbc 				 	= "0000_Loja_SC"
	End If
Else
	ao_Odbc.ivs_DataBase		= ls_DataBase
	ao_Odbc.ivs_ServerName	= ls_ServerName
	ao_Odbc.ivs_ip					= ls_Ip 
	ao_Odbc.ivs_Pdv_Java		= ls_Id_Pdv_Java
	
	ao_Odbc.of_grava_regedit_odbc(al_Filial)
End If
	
If ao_Odbc.of_Connect(ls_Odbc, 'dbo', 'teste') Then
	
	If ls_Id_Pdv_Java = "S" Then
		ao_transacao.ivs_database = "POSTGRESQL_JAVA"
	else
		ao_transacao.ivs_database = "POSTGRESQL"
	End If

	If Not ao_transacao.of_Connect(ls_Odbc, "") Then 
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar no banco de dados da filial.~r~rFilial "+String(al_Filial)+"."
		Return False
	End If			
Else
	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar no banco de dados da filial.~r~rFilial "+String(al_Filial)+"."
	Return False
End If

Return True
end function

on w_ge103_consulta_saldo_filial.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_ge103_consulta_saldo_filial.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;//OverRide

Long lvl_Nulo

Boolean	lvb_Sucesso = False

String	ls_Odbc, &
		ls_Parametro,&
		ls_Filial_Java,&
		ls_Erro

pb_Help.Visible = False

ls_Parametro = Message.StringParm

ivo_Produto 	= Create uo_Produto
ivo_Odbc			= Create dc_uo_odbc
ivtr_Filial 	= Create uo_ge136_transacao_remota
ivtr_Filial.ivb_Mostra_Msg_Erro = False

ivl_Produto	= Long(wf_Identifica_Valor_Parametro(ls_Parametro, 1))
ivl_Filial		= Long(wf_Identifica_Valor_Parametro(ls_Parametro, 2))
SetNull(lvl_Nulo)

If Not wf_filial_sistema_java(ivl_Filial, Ref ls_Filial_Java, Ref ls_Erro) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro)
	CloseWithReturn(This, lvl_Nulo)
	Return -1
End If

If ls_Filial_Java = "S" Then
	Try
		dc_uo_transacao Transact_Saldo
		Transact_Saldo = create dc_uo_transacao

		If Not dw_1.of_ChangeDataObject("dw_ge103_lista_saldo_filial_java") Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a DataWindow dw_ge103_lista_saldo_filial_java")
			CloseWithReturn(This, lvl_Nulo)
			Return -1
		End If

		If not wf_Conecta_Banco_Filial(ivl_Filial, ivo_Odbc, ref  Transact_Saldo, Ref  ls_Filial_Java, Ref ls_Erro) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao conectar no banco central" + ls_Erro)
			CloseWithReturn(This, lvl_Nulo)
			Return -1
		End If

		dw_1.SetTransObject(Transact_Saldo)

		If dw_1.Retrieve(ivl_Filial, ivl_Produto) < 1 Then
			CloseWithReturn(This, lvl_Nulo)
		End If

	Finally
		Destroy(Transact_Saldo)
	End Try

Else
	ivo_Odbc.of_Atualiza_Odbcs( String( ivl_Filial ) )
	
	lvb_Sucesso = gf_GE136_Conecta_Banco_Filial( ivl_Filial, Ref ivtr_Filial )
	
	If lvb_Sucesso Then
		ivo_Produto.of_Localiza_Codigo_Interno(ivl_Produto)
	
		If ivo_Produto.Localizado Then
			
			dw_1.of_SetTransObject( ivtr_Filial )
			
			This.Title = This.Title + ' - ' + String(ivl_Filial)
		
			dw_1.Event ue_Retrieve()
			
			If dw_1.RowCount() = 0 Then
				CloseWithReturn(This, lvl_Nulo)
			End If
		End If
	Else
		If ivtr_Filial.ivs_Msg_Erro <> '' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivtr_Filial.ivs_Msg_Erro, Exclamation!)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar no banco de dados da filial "+String(ivl_Filial), Exclamation!)
		End If
		CloseWithReturn(This, lvl_Nulo)
		Return -1
	End If
End If
end event

event close;call super::close;If ivtr_Filial.of_IsConnected( ) Then ivtr_Filial.of_Disconnect( )	
ivo_Odbc.of_deleta_regedit_odbc( String( ivl_Filial, "0000" ) )

Destroy(ivo_Produto)
Destroy ivo_Odbc
Destroy ivtr_Filial
end event

type pb_help from dc_w_response`pb_help within w_ge103_consulta_saldo_filial
integer y = 1044
end type

type gb_1 from groupbox within w_ge103_consulta_saldo_filial
integer x = 32
integer y = 20
integer width = 3241
integer height = 544
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 80269524
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge103_consulta_saldo_filial
integer x = 64
integer y = 60
integer width = 3195
integer height = 472
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge103_lista_saldo_filial"
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide

Return This.Retrieve(ivo_Produto.cd_produto)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

