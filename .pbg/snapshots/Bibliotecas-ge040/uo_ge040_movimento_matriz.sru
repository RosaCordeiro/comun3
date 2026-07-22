HA$PBExportHeader$uo_ge040_movimento_matriz.sru
forward
global type uo_ge040_movimento_matriz from nonvisualobject
end type
end forward

global type uo_ge040_movimento_matriz from nonvisualobject
end type
global uo_ge040_movimento_matriz uo_ge040_movimento_matriz

type variables
CONSTANT Long cd_filial_entrada = 534
CONSTANT Long qt_dias_retrieve = 1095 //3 $$HEX1$$fa00$$ENDHEX$$ltimos anos

Long il_Filial_Parametro
Long il_Filial_Matriz	

Boolean Movimento_Localizado = False

//Valores referentes a nota de ORIGEM
Long Nr_Nf

//Emissao Nf 
Date dh_movimento

String de_especie
String de_serie
String de_chave_acesso
String tipo_Operacao	//Devolucao ou Transferencia
String cd_cst_tributacao
String cd_cst_origem

//Valores Unit$$HEX1$$e100$$ENDHEX$$rios
Decimal{6} vl_bc_icms
Decimal{6} vl_icms
Decimal{6} pc_icms

Decimal{6} vl_bc_icms_st
Decimal{2} pc_icms_st
Decimal{6} vl_icms_st
Decimal{6} vl_custo_unitario

Decimal{6} vl_bc_icms_antecipacao 		
Decimal{6} pc_mva_icms_antecipacao
Decimal{2} pc_icms_antecipacao 		
Decimal{6} vl_icms_antecipacao

Decimal{6} vl_icms_operacao
Decimal{2} pc_icms_diferido
Decimal{6} vl_icms_diferido
Decimal{6} vl_bc_icms_st_retido
Decimal{2} pc_st_retido
Decimal{6} vl_icms_st_retido



end variables

forward prototypes
public function boolean of_verifica_movimento_matriz (long al_filial, long al_produto)
public subroutine of_inicializa ()
end prototypes

public function boolean of_verifica_movimento_matriz (long al_filial, long al_produto);Boolean lb_Sucesso = True

String ls_SQL, ls_Dados, ls_Especie, ls_Serie

Long ll_Retorno, ll_Nota_Entrada, ll_Row, ll_Nota

Date ldh_Inicio, ldh_Termino

Try	
	This.of_Inicializa( )
		
	//Para n$$HEX1$$e300$$ENDHEX$$o pegar nota pendente do perini que ainda n$$HEX1$$e300$$ENDHEX$$o foi enviada ao sefaz.
	ldh_Termino 	= RelativeDate( Date (gvo_Parametro.of_dh_movimentacao()), -1 ) 
	
	// $$HEX1$$da00$$ENDHEX$$ltimos 3 anos
	ldh_Inicio		= RelativeDate( ldh_Termino, - This.qt_dias_retrieve )
	
	dc_uo_ds_base lvds
	lvds = Create Dc_uo_ds_base
	lvds.of_ChangeDataObject( "ds_ge040_nota_fiscal_entrada" )
	
	lvds.Reset()
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Aguarde, recuperando as Informa$$HEX2$$e700f500$$ENDHEX$$es na Matriz..."
	
	uo_Filial lo_Filial
	lo_Filial = Create uo_Filial
	lo_Filial.of_localiza_codigo( al_Filial )
	
	//Tratamento para evitar a localizacao de notas fiscais emitadas para outro estado.
	//Ex. Filial 808 era do RS e passou para SC
	If lo_Filial.cd_unidade_federacao = 'SC' Then
		lvds.of_AppendWhere("c.cd_natureza_operacao < 6000" )
	Else
		lvds.of_AppendWhere("c.cd_natureza_operacao >= 6000")
	End If
	
	Destroy lo_Filial
	
	//***appendwhere
	lvds.of_AppendWhere("a.cd_filial_movimento = " + String( al_filial ) )
	lvds.of_AppendWhere("a.cd_produto = " + String( al_produto ) )
	lvds.of_AppendWhere("cd_filial_movimento = " + String( al_filial ),2)
	lvds.of_AppendWhere("cd_produto = " + String( al_produto ), 2)
	lvds.of_AppendWhere("dh_movimento between '" + String( ldh_Inicio,"YYYYMMDD" ) + "' and '" + String( ldh_Termino,"YYYYMMDD") + "'", 2 )
	
	//Na matriz n$$HEX1$$e300$$ENDHEX$$o conecta no distribuido, retrieve direto
	If il_Filial_Parametro <> il_Filial_Matriz Then
		uo_Transacao_Remota lvo_Conexao  //GE105
		lvo_Conexao = Create uo_Transacao_Remota
		
		lvo_Conexao.of_BancoProducao( )
		lvo_Conexao.of_Relatorio( True )
		lvo_Conexao.of_ConverteVirgula( True )
	
		ls_SQL = lvds.GetSQLSelect()
		
		lvo_Conexao.of_Retrieve(ls_SQL, Ref ls_Dados)
		
		If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
			lb_Sucesso = False
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge040_movimento_matriz.of_verifica_movimento_matriz().")
		Else
			//-1 Nenhuma linha retornada
			//-3  Invalid argument
			If lvds.ImportString( ls_Dados ) < -1 Then
				lb_Sucesso = False
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao copiar as informa$$HEX2$$e700f500$$ENDHEX$$es do servidor distribu$$HEX1$$ed00$$ENDHEX$$do para a DataWindow local.~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge040_movimento_matriz.of_verifica_movimento_matriz(Long,Long)")
			End If
		End If
	
		If IsValid( lvo_Conexao ) Then Destroy( lvo_Conexao )
	
		//Erro no retrieve ou na conexao com a matriz, aborta o processo
		If Not lb_Sucesso Then
			Close( w_Aguarde )
			Return lb_Sucesso
		End If
		
	Else //Retrieve na matriz
		lvds.Retrieve()
		
		If lvds.RowCount() < 0 Then
			Open( w_Aguarde )
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve, filial: " + String(al_Filial) + ", produto: " + String(al_produto) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_ge040_movimento_matriz.of_verifica_movimento_matriz(Long,Long)", StopSign! )
			Return False
		End If
	End If
	
	//Inicia sempre como TRANSFERENCIA, se houver movimento muda para DEVOLUCAO
	This.Tipo_Operacao = 'T' 

	This.Movimento_Localizado = ( lvds.RowCount( ) > 0 )
	
	If This.Movimento_Localizado Then
		This.Tipo_Operacao = 'D'
		
		//Emissao Nf 
		This.dh_movimento 		= Date(lvds.Object.dh_movimento	[1])
		
		This.nr_Nf 					= lvds.Object.nr_nf				[1]
		This.de_especie 			= lvds.Object.de_especie 		[1]
		This.de_serie 				= lvds.Object.de_serie 			[1]
		This.de_chave_acesso	= lvds.Object.de_chave_acesso[1]
		
		This.vl_bc_icms 			= lvds.Object.vl_bc_icms			[1]
		This.vl_icms 				=  lvds.Object.vl_icms			[1]
		This.pc_icms 				=  lvds.Object.pc_icms			[1]
		
		This.vl_bc_icms_st 		= lvds.Object.vl_bc_icms_st		[1]
		This.pc_icms_st 			= lvds.Object.pc_icms_st			[1]
		This.vl_icms_st 			= lvds.Object.vl_icms_st			[1]
		
		This.vl_custo_unitario 	= lvds.Object.vl_custo_unitario	[1]
		
		This.vl_bc_icms_antecipacao 		= lvds.Object.vl_bc_icms_antecipacao		[1]
		This.pc_mva_icms_antecipacao 	= lvds.Object.pc_mva_icms_antecipacao		[1]
		This.pc_icms_antecipacao 			= lvds.Object.pc_icms_antecipacao			[1]
		This.vl_icms_antecipacao 			= lvds.Object.vl_icms_antecipacao				[1]
		
		This.vl_icms_operacao				= lvds.Object.vl_icms_operacao				[1]
		This.pc_icms_diferido					= lvds.Object.pc_icms_diferido					[1]
		This.vl_icms_diferido					= lvds.Object.vl_icms_diferido					[1]	
		
		This.cd_cst_tributacao 				= lvds.Object.cd_cst_tributacao				[1]
		This.cd_cst_origem					= lvds.Object.cd_cst_origem					[1]
	End If
	
	w_Aguarde.Title = "Finalizando comunica$$HEX2$$e700e300$$ENDHEX$$o com a matriz..."
	SetPointer( Arrow! )
	
	Close( w_Aguarde )
	
	Return lb_Sucesso
	
Finally
	If IsValid( lvds )  			Then Destroy( lvds )
End Try
end function

public subroutine of_inicializa ();This.Movimento_Localizado = False

SetNull( This.Nr_Nf )

SetNull( This.dh_movimento )

SetNull( This.de_especie )
SetNull( This.de_serie )
SetNull( This.de_chave_acesso )
SetNull( This.tipo_Operacao )

SetNull( This.vl_bc_icms )
SetNull( This.vl_icms )
SetNull( This.pc_icms )

SetNull( This.vl_bc_icms_st )
SetNull( This.pc_icms_st )
SetNull( This.vl_icms_st )
SetNull( This.vl_custo_unitario )

SetNull( This.vl_bc_icms_antecipacao )
SetNull( This.pc_mva_icms_antecipacao )
SetNull( This.pc_icms_antecipacao )
SetNull( This.vl_icms_antecipacao )
SetNull( This.cd_cst_tributacao )

SetNull( This.vl_icms_operacao )
SetNull( This.pc_icms_diferido )			
SetNull( This.vl_icms_diferido )
SetNull( This.vl_bc_icms_st_retido )
SetNull( This.pc_st_retido )
SetNull( This.vl_icms_st_retido )
SetNull( This.cd_cst_origem )





end subroutine

on uo_ge040_movimento_matriz.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge040_movimento_matriz.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Select cd_filial, 
       cd_filial_matriz
Into :This.il_Filial_Parametro,
     :This.il_Filial_Matriz
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial dos par$$HEX1$$e200$$ENDHEX$$metros n$$HEX1$$e300$$ENDHEX$$o localizada. Local: uo_ge040_movimento_matriz.Event Constructor()", StopSign!)
		SetNull(This.il_Filial_Parametro)		
		SetNull(This.il_Filial_Matriz)				
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial dos par$$HEX1$$e200$$ENDHEX$$metros. Local: uo_ge040_movimento_matriz.Event Constructor()" + SqlCa.SqlErrText, StopSign!)
		SetNull(This.il_Filial_Parametro)
		SetNull(This.il_Filial_Matriz)				
End Choose

This.of_Inicializa()
end event

