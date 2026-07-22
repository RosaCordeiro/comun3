HA$PBExportHeader$uo_ge206_paf.sru
forward
global type uo_ge206_paf from nonvisualobject
end type
end forward

global type uo_ge206_paf from nonvisualobject
end type
global uo_ge206_paf uo_ge206_paf

type variables
dc_uo_ds_base ids_Produto

String is_Path_Arquivos_TL = 'c:\sistemas\versao\'
String is_Path_Arquivos_CL = 'c:\sistemas\cl\'

String is_Arquivo_Produto_Geral = 'paf_produto_geral.dbf'
end variables

forward prototypes
public function integer of_exporta_produto_geral ()
public subroutine of_baixa_arquivos_ftp ()
end prototypes

public function integer of_exporta_produto_geral ();Decimal ldc_Desconto

Long ll_Linha
Long ll_Linhas

Try
	Open( w_Aguarde )
	w_Aguarde.Title = "Gerando arquivo de dados para paf-ecf: " + is_Arquivo_Produto_Geral
	
	uo_Produto lo_Produto
	lo_Produto = Create uo_Produto
	
	dc_uo_encript lo
	lo = Create dc_uo_encript
	
	ll_Linhas = ids_Produto.Retrieve( )
	ids_Produto.SetSort( 'de_produto asc, de_apresentacao_venda asc' )
	ids_Produto.Sort( )
	
	w_Aguarde.uo_Progress.of_SetMax( ll_Linhas )
	
	If ll_Linhas < 0 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar os dados da DS ds_tl_produto_geral", StopSign! )
		Return -1
	End If

	For ll_Linha = 1 To ll_Linhas
		lo_Produto.of_Localiza_Codigo_Interno( Long( ids_Produto.Object.Cd_Produto[ ll_Linha ] ) )
		ldc_Desconto = lo_Produto.of_Desconto_Filial( )
		
		ids_Produto.Object.Vl_Preco_Venda_Atual	[ ll_Linha ] = lo.of_Encripta( ids_Produto.Object.Vl_Preco_Venda_Atual	[ ll_Linha ] )
		ids_Produto.Object.Qt_Saldo_Final			[ ll_Linha ] = lo.of_Encripta( ids_Produto.Object.Qt_Saldo_Final			[ ll_Linha ] )
		ids_Produto.Object.Pc_Desconto_Atual		[ ll_Linha ] = lo.of_Encripta( gf_Valor_Com_Ponto( ldc_Desconto ) )
		
		w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
	Next
	
	If ids_Produto.SaveAs( is_Path_Arquivos_TL + is_Arquivo_Produto_Geral, Text!, False ) = -1 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar os dados da 'ds_tl_produto_geral'", StopSign! )
		Return -1
	End If
	
	Return 1
	
Catch( Exception ex )
	MessageBox( "Exception", ex.getMessage( ), StopSign! )
	
Finally
	Close( w_Aguarde )
	Destroy lo
	Destroy lo_Produto
End Try
end function

public subroutine of_baixa_arquivos_ftp ();String ls_Servidor
String ls_Msg

Try
	uo_parametro_filial lo_Parametro
	lo_Parametro = Create uo_Parametro_Filial
	
	If lo_Parametro.of_Localiza_Parametro( 'DE_ENDERECO_SERVIDOR_FTP', Ref ls_Servidor, False ) Then
	
		dc_uo_ftp lo_Ftp
		lo_Ftp = Create dc_uo_ftp
	
		If lo_Ftp.of_Conecta_Ftp( 'uo_ge206_paf', ls_Servidor, 'pdv2', 'pdv2', Ref ls_Msg ) Then
			lo_Ftp.of_Ftp_GetFile( is_Arquivo_Produto_Geral, is_Path_Arquivos_CL + is_Arquivo_Produto_Geral, Ref ls_Msg )
		End If
	End If
	
Finally
	lo_Ftp.of_Desconecta_Ftp( )
	If IsValid( lo_Ftp ) Then Destroy lo_Ftp

	If IsValid( lo_Parametro ) Then Destroy lo_Parametro
End Try
end subroutine

on uo_ge206_paf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge206_paf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;Destroy ids_Produto
end event

event constructor;ids_Produto = Create dc_uo_ds_base

If Not ids_Produto.of_ChangeDataObject( 'ds_ge206_produto_geral' ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no ChangeDataObject 'ds_tl_produto_geral'", StopSign! )
	Return -1
End If
end event

