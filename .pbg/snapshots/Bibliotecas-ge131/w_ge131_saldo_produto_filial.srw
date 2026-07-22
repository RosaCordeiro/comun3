HA$PBExportHeader$w_ge131_saldo_produto_filial.srw
forward
global type w_ge131_saldo_produto_filial from dc_w_sheet
end type
type cb_1 from commandbutton within w_ge131_saldo_produto_filial
end type
type dw_1 from dc_uo_dw_base within w_ge131_saldo_produto_filial
end type
type gb_1 from groupbox within w_ge131_saldo_produto_filial
end type
end forward

global type w_ge131_saldo_produto_filial from dc_w_sheet
string accessiblename = "Saldo de Produto por Filial (GE131)"
integer width = 1865
integer height = 652
string title = "GE131 - Saldo de Produto por Filial"
boolean resizable = false
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge131_saldo_produto_filial w_ge131_saldo_produto_filial

type variables
uo_Produto 										io_Produto
uo_ge216_filiais									io_Filiais

String is_arquivo_Produtos
end variables

forward prototypes
public function boolean wf_importa_excel (ref string ps_produtos_in)
public function integer wf_fileopen ()
public subroutine wf_gera_excel (datastore pds_excel, long pl_linhas)
end prototypes

public function boolean wf_importa_excel (ref string ps_produtos_in);Boolean lb_Sucesso = True
Long ll_Total, ll_Row, ll_Produto

Try

	Open( w_Aguarde )
	w_Aguarde.Title = "Lendo dados do arquivo : '" + Upper( is_arquivo_Produtos ) + "'."
	
	dc_uo_Excel lo_Excel
	lo_Excel = Create dc_uo_Excel
	
	lo_Excel.uo_Referencia_Objeto_Excel( is_arquivo_Produtos )
	ll_Total = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
	
	w_Aguarde.uo_Progress.of_SetMax( ll_Total )
	
	SetPointer(HourGlass!)
	
	For ll_Row = 1 To ll_Total
		
		w_Aguarde.uo_Progress.of_SetProgress( ll_Row )
		
		//Leitura da coluna A - Produto
		ll_Produto = Long( lo_Excel.uo_Lendo_Dados( ll_Row, "A") )
		
		io_Produto.of_localiza_codigo_interno( ll_Produto )
		
		If Not io_Produto.Localizado Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + String (ll_Produto) + " n$$HEX1$$e300$$ENDHEX$$o foi localizado.~rLinha: " + String(ll_Row) )
			lb_Sucesso = False
			Exit
		End If
				
		ps_Produtos_IN += String( ll_Produto ) + ","	
				
		Yield()	 
			 
	Next
	
Finally
	If IsValid(lo_Excel) Then Destroy lo_Excel
	Close( w_Aguarde )
	ps_Produtos_IN = Mid( ps_Produtos_IN, 1, LenA(ps_Produtos_IN) -1 )
	Return lb_Sucesso
	
End Try
end function

public function integer wf_fileopen ();String ls_Path
String ls_Arquivo
Integer li_arquivo

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
				   "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto.")

li_arquivo = GetFileOpenName("Selecione o arquivo", &
										   ls_Path, &
										   ls_Arquivo  , &
											"XLS", &
											+ "Arquivo Excel (*.XLS;*.XLSX),*.XLS;*.XLSX")
																
Choose Case li_Arquivo
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao abrir o arquivo '" + ls_Arquivo + "'.")
		Return -1
	Case 0
		Return 0
	Case 1
		is_arquivo_Produtos = ls_Path
End Choose
end function

public subroutine wf_gera_excel (datastore pds_excel, long pl_linhas);String ls_Path
String ls_Arquivo

Integer li_Retorno

If pl_Linhas > 64000 Then
	li_retorno = GetFileSaveName('Arquivo', ls_Path, ls_Arquivo, 'txt', 'Arquivo de Texto (*.txt),*.txt')
Else
	li_retorno = GetFileSaveName('Arquivo', ls_Path, ls_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')
End If

If li_retorno = 1 Then
                
	// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
	If FileExists(ls_Path) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + ls_Path + "' existente ?", Question!, YesNo!, 1) =  1 Then 
			If Not FileDelete(ls_Path) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + ls_Path + "'.", StopSign!)
				Return
			End If
		Else
			Return 
		End If   
	End If
	
	If pl_Linhas > 64000 Then
		li_retorno = pds_Excel.SaveAs( ls_Path, Text!	, True )
	Else
		li_retorno = pds_Excel.SaveAs( ls_Path, Excel!, True )
	End If
	
	If li_retorno = 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + ls_Path + "'.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + ls_Path + "'.", StopSign!)
	End If
	
End If

end subroutine

on w_ge131_saldo_produto_filial.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_ge131_saldo_produto_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;io_Produto 	= Create uo_Produto
io_Filiais 		= Create uo_ge216_filiais

dw_1.Event ue_AddRow()
end event

event close;call super::close;If isValid(io_Produto) Then Destroy io_Produto
If isValid(io_Filiais) Then Destroy io_Filiais

end event

type cb_1 from commandbutton within w_ge131_saldo_produto_filial
integer x = 1307
integer y = 388
integer width = 517
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Planilha"
end type

event clicked;Long ll_Produto, ll_Linhas
String ls_ID_Produtos, ls_Produtos_In

Try

	dc_uo_ds_base lds_Excel
	lds_Excel = Create dc_uo_ds_base
	
	If Not lds_Excel.of_ChangeDataObject( "ds_ge131_excel" ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento ChangeDataObejct DS ds_ge131_excel.")
		Return
	End If
	
	dw_1.AcceptText()
	
	ll_produto 			= dw_1.Object.cd_produto	[ 1 ]
	ls_ID_Produtos 	= dw_1.Object.id_produtos	[ 1 ]
	
	If Not IsNull( ll_produto ) Then 
		lds_Excel.of_AppendWhere( "vp.cd_produto = " + String( ll_Produto ))
	ElseIf ls_ID_Produtos = 'C' Then
		If Not wf_Importa_excel( Ref ls_Produtos_In ) Then Return
		
		lds_Excel.of_AppendWhere( "vp.cd_produto in ( "+ls_Produtos_In+")" )
	End If
			
	If Not IsNull( io_Filiais.ivs_Filiais ) And io_Filiais.ivs_Filiais <> "" Then 
		lds_Excel.of_AppendWhere( "vp.cd_filial in ( " + io_Filiais.ivs_Filiais + " )" )
	End If
	
	ll_Linhas = lds_Excel.Retrieve()
	
	If ll_Linhas = -1 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve DS ds_ge131_excel.")
		Return
	End If
	
	If ll_Linhas > 0 Then wf_Gera_Excel( lds_Excel, ll_Linhas )
	
Catch(RuntimeError lre)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gerar a planilha.~r~r" + lre.GetMessage( ), StopSign! )
	
Finally
	If IsValid( lds_Excel ) Then Destroy lds_Excel
End Try
end event

type dw_1 from dc_uo_dw_base within w_ge131_saldo_produto_filial
integer x = 59
integer y = 88
integer width = 1723
integer height = 236
integer taborder = 20
string dataobject = "dw_ge131_selecao"
end type

event ue_key;call super::ue_key;If Key = KeyEnter! Then

	Choose Case This.GetColumnName()
			
		Case "de_produto"
			io_Produto.of_Localiza_produto( This.GetText() )
			
			If Not io_Produto.Localizado Then Return
				
			This.Object.cd_produto		[ 1 ] = io_Produto.cd_produto
			This.Object.de_produto		[ 1 ] = io_Produto.de_produto + " : " + io_Produto.de_apresentacao_venda
			
			This.Object.id_Produtos		[ 1 ] = 'T'
			
	End Choose
	
End If
end event

event itemchanged;call super::itemchanged;Integer li_Linhas

Choose Case dwo.Name
		
	Case 'de_produto'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Produto.de_Produto Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.cd_produto	[ 1 ] = io_Produto.cd_produto
			This.Object.de_produto	[ 1 ] = io_Produto.de_Produto
		End If
		
	Case 'id_filiais'
		If Data = "C" Then //Conjunto de Filiais
			OpenWithParm( w_ge216_selecao_filiais, io_Filiais )
			
			li_Linhas = Message.DoubleParm
			
			If li_Linhas = 0 Then This.Object.id_Filiais[ 1 ] = 'T'
		Else
			 io_Filiais.ivs_Filiais = ""
		End If
			
	Case 'id_produtos'
		If Data = "C" Then //Conjunto de Produto
			io_Produto.of_Inicializa()
			This.Object.cd_produto	[ 1 ] = io_Produto.cd_produto
			This.Object.de_produto	[ 1 ] = io_Produto.de_Produto
			
			If wf_fileOpen() = 0 Then
				This.Object.id_Produtos[1] = 'T'
				Return 1
			ENd If						
		End If
		
End Choose
end event

type gb_1 from groupbox within w_ge131_saldo_produto_filial
integer x = 18
integer y = 12
integer width = 1806
integer height = 356
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

