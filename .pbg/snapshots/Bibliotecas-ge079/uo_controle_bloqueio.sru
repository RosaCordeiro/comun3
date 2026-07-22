HA$PBExportHeader$uo_controle_bloqueio.sru
forward
global type uo_controle_bloqueio from nonvisualobject
end type
end forward

global type uo_controle_bloqueio from nonvisualobject
end type
global uo_controle_bloqueio uo_controle_bloqueio

type variables
string ivs_sql_base

long   cd_convenio
string cd_conveniado
long   cd_dependente
end variables

forward prototypes
public function boolean of_cliente_bloqueado (string as_cliente, string as_dependente, string as_tipo_venda, ref string as_matricula)
public function boolean of_lista_bloqueio_nova (string as_bloqueio[])
public function boolean of_mostra_bloqueio_nova (datastore pds_bloqueio, string ps_banco, ref string as_matricula)
public subroutine of_carrega_bloqueio (string as_bloqueio, datastore as_datastore)
public function boolean of_convenio_bloqueado (long al_convenio, string as_conveniado, long al_dependente, ref string as_matricula)
public function boolean of_convenio_bloqueado_nova_old (long al_convenio, string as_conveniado, long al_dependente, ref string as_matricula)
public function boolean of_convenio_bloqueado_nova (long al_convenio, string as_conveniado, long al_dependente, ref string as_matricula)
public function boolean of_bloqueado_nova (string as_sql, ref string as_matricula)
public function boolean of_bloqueado (string as_sql, ref string as_matricula)
public function boolean of_cliente_bloqueado_nova (string as_cliente, string as_dependente, string as_tipo_venda, ref string as_matricula)
end prototypes

public function boolean of_cliente_bloqueado (string as_cliente, string as_dependente, string as_tipo_venda, ref string as_matricula);String lvs_SQL

lvs_SQL = ivs_SQL_Base

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do cliente
Choose Case as_Tipo_Venda
	Case "CR"
		lvs_SQL += " and b.id_tipo_bloqueio in ('CLI', 'CRE')"
	Case "CC"
		lvs_SQL += " and b.id_tipo_bloqueio in ('CLI', 'CCO')"
	Case Else
		lvs_SQL += " and b.id_tipo_bloqueio = 'CLI'"
End Choose

lvs_SQL += " and b.cd_cliente = '" + as_Cliente + "'"

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do dependente do cliente
If Not IsNull(as_Dependente) Then
	lvs_SQL += " union " + ivs_SQL_Base + " and b.id_tipo_bloqueio = 'DEP' and b.cd_cliente_dependente = '" + as_Dependente + "'"
End If

Return This.of_Bloqueado(lvs_SQL, ref as_Matricula)
end function

public function boolean of_lista_bloqueio_nova (string as_bloqueio[]);
//OpenWithParm(w_ge079_lista_bloqueio_nova, as_Bloqueio[])

Return True



end function

public function boolean of_mostra_bloqueio_nova (datastore pds_bloqueio, string ps_banco, ref string as_matricula);String 	ls_Retorno

Boolean	lb_Bloqueado

uo_Parametro_Controle_Bloqueio lvo_Parametro
lvo_Parametro = Create uo_Parametro_Controle_Bloqueio

lvo_Parametro.ivds_1 = pds_bloqueio

lvo_Parametro.ivs_Banco = ps_banco

OpenWithParm(w_ge079_Lista_Bloqueio, lvo_Parametro)

ls_Retorno = Message.StringParm

If IsNull(ls_Retorno) Then
	lb_Bloqueado = True
Else
	lb_Bloqueado = False
	
	as_Matricula = ls_Retorno
	
End If

Destroy(lvo_Parametro)

Return lb_Bloqueado
end function

public subroutine of_carrega_bloqueio (string as_bloqueio, datastore as_datastore);Long ll_Pos
Long ll_Inicio
Long ll_Row

String ls_Bloqueio
				
ll_Pos = PosA(as_Bloqueio,';',1)

ll_Inicio = 1

as_datastore.Reset()
				
Do While ll_Pos > 0
	
	ll_Row = as_datastore.InsertRow(0)
	
	ls_Bloqueio = MidA(as_Bloqueio,ll_Inicio,46)
	
	as_datastore.object.cd_motivo_bloqueio		[ll_Row] = MidA(as_Bloqueio,ll_Inicio,3)
	as_datastore.object.de_motivo_bloqueio		[ll_Row] = MidA(as_Bloqueio,ll_Inicio+4,40)
	as_datastore.object.id_permite_liberacao	[ll_Row] = MidA(as_Bloqueio,ll_Inicio+45,01)

	
	ll_Inicio = ll_Pos + 1
	
	ll_Pos = PosA(as_Bloqueio,';',ll_Inicio)

Loop

end subroutine

public function boolean of_convenio_bloqueado (long al_convenio, string as_conveniado, long al_dependente, ref string as_matricula);String lvs_SQL, &
       lvs_Convenio, &
	   lvs_Conveniado, &
	   lvs_Dependente
	   
This.cd_convenio   = al_convenio
This.cd_conveniado = as_conveniado
This.cd_dependente	= al_dependente	   

lvs_Convenio = " and b.cd_convenio = " + String(al_Convenio)

lvs_Conveniado = " and b.cd_conveniado = '" + as_Conveniado + "'"

lvs_Dependente = " and b.cd_dependente = " + String(al_Dependente)

lvs_SQL = ivs_SQL_Base

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do conv$$HEX1$$ea00$$ENDHEX$$nio
lvs_SQL += " and b.id_tipo_bloqueio = 'CON'" + lvs_Convenio

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do conveniado
lvs_SQL += " union " + ivs_SQL_Base + " and b.id_tipo_bloqueio = 'CDO'" + lvs_Convenio + lvs_Conveniado

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do dependente do conveniado
If Not IsNull(al_Dependente) Then
	lvs_SQL += " union " + ivs_SQL_Base + " and b.id_tipo_bloqueio = 'DCO'" + lvs_Convenio + lvs_Conveniado + lvs_Dependente
End If

Return This.of_Bloqueado(lvs_SQL, ref as_Matricula)
end function

public function boolean of_convenio_bloqueado_nova_old (long al_convenio, string as_conveniado, long al_dependente, ref string as_matricula);String lvs_SQL, &
       lvs_Convenio, &
   	   lvs_Conveniado, &
	   lvs_Dependente,&
	   lvs_Sql_Base
	   

This.cd_convenio   = al_convenio
This.cd_conveniado = as_conveniado
This.cd_dependente	= al_dependente

lvs_SQL_Base = "select m.id_permite_liberacao 'id_permite_liberacao', count(*) " + &
			   "from bloqueio b, motivo_bloqueio m " + &
			   "where m.cd_motivo_bloqueio = b.cd_motivo_bloqueio " + &
			   "and b.dh_liberacao is null"	   	   

lvs_Convenio = " and b.cd_convenio = " + String(al_Convenio)

lvs_Conveniado = " and b.cd_conveniado = '" + as_Conveniado + "'"

lvs_Dependente = " and b.cd_dependente = " + String(al_Dependente)

lvs_SQL = lvs_SQL_Base

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do conv$$HEX1$$ea00$$ENDHEX$$nio
lvs_SQL += " and b.id_tipo_bloqueio = 'CON'" + lvs_Convenio + " group by m.id_permite_liberacao"

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do conveniado
lvs_SQL += " union " + lvs_SQL_Base + " and b.id_tipo_bloqueio = 'CDO'" + lvs_Convenio + lvs_Conveniado + " group by m.id_permite_liberacao"

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do dependente do conveniado
If Not IsNull(al_Dependente) Then
	lvs_SQL += " union " + lvs_SQL_Base + " and b.id_tipo_bloqueio = 'DCO'" + lvs_Convenio + lvs_Conveniado + lvs_Dependente + " group by m.id_permite_liberacao"
End If

Return This.of_Bloqueado_Nova(lvs_SQL, ref as_Matricula)
end function

public function boolean of_convenio_bloqueado_nova (long al_convenio, string as_conveniado, long al_dependente, ref string as_matricula);String 	lvs_SQL, &
       	lvs_Convenio, &
  	   	lvs_Conveniado, &
	   	lvs_Dependente,&
	   	lvs_Sql_Base  

This.cd_convenio   = al_convenio
This.cd_conveniado = as_conveniado
This.cd_dependente	= al_dependente

lvs_Sql_Base = "select b.id_tipo_bloqueio, " + &
				 	       "b.cd_motivo_bloqueio as 'cd_motivo_bloqueio', " + &
					       "m.de_motivo_bloqueio as 'de_motivo_bloqueio', " + &
				 	       "m.id_permite_liberacao as 'id_permite_liberacao'" + &
					"from bloqueio b, motivo_bloqueio m " + &
				  "where m.cd_motivo_bloqueio = b.cd_motivo_bloqueio " + &
					 "and b.dh_liberacao is null"

lvs_Convenio = " and b.cd_convenio = " + String(al_Convenio)

lvs_Conveniado = " and b.cd_conveniado = '" + as_Conveniado + "'"

lvs_Dependente = " and b.cd_dependente = " + String(al_Dependente)

lvs_SQL = lvs_SQL_Base

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do conv$$HEX1$$ea00$$ENDHEX$$nio
lvs_SQL += " and b.id_tipo_bloqueio = 'CON'" + lvs_Convenio

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do conveniado
lvs_SQL += " union " + lvs_SQL_Base + " and b.id_tipo_bloqueio = 'CDO'" + lvs_Convenio + lvs_Conveniado

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do dependente do conveniado
If Not IsNull(al_Dependente) Then
	lvs_SQL += " union " + lvs_SQL_Base + " and b.id_tipo_bloqueio = 'DCO'" + lvs_Convenio + lvs_Conveniado + lvs_Dependente
End If

Return This.of_Bloqueado_Nova(lvs_SQL, ref as_Matricula)
end function

public function boolean of_bloqueado_nova (string as_sql, ref string as_matricula);Boolean lb_Sucesso, &
        lb_Bloqueado

String  ls_Erro, &
	    ls_Sintaxe, &
        ls_Retorno, &
	    ls_Banco, &
		ls_Mensagem

Long	ll_Row, &
		lvl_Retorno

// Determina a sintaxe para cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow
ls_Sintaxe = SqlCa.SyntaxFromSQL(as_SQL, "Style(Type=Grid)", ls_Erro)

If Trim(ls_Erro) <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da sintaxe da datawindow para consulta dos bloqueios.")
	Return True
Else
	
	// Cria a datawindow
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	
	lvds_1.Create(ls_Sintaxe, ls_Erro)
	
	If Trim(ls_Erro) <> "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow para consulta dos bloqueios.")
		Destroy(lvds_1)
		Return True
	Else
		lvds_1.SetTransObject(SqlCa)
	End If
End If

// Tenta consultar os bloqueios no banco de dados da matriz
Open(w_Aguarde)
w_Aguarde.Title = "Consultando Bloqueios na Matriz..."

//--- Novo
uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
	
ls_Banco = "Banco Matriz"
	
lvo_Conexao.of_Retrieve(as_SQL, ref ls_retorno)

If Not lvo_Conexao.of_Erro_Execucao() And Not lvo_Conexao.of_Erro_Conexao() Then
	If IsNull(ls_Retorno) Or Trim(ls_Retorno) = '' Then
		ls_retorno = '0'
	Else
		lvl_Retorno = lvds_1.ImportString(ls_Retorno)
		
		If lvl_Retorno >= 0 Then			
	
			If lvds_1.RowCount() > 0 Then
			
				lb_Sucesso = True	
				
				ls_retorno = '1'						// Bloqueado com permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
				
				For ll_Row = 1 To lvds_1.RowCount()				
					If lvds_1.object.id_permite_liberacao[ll_Row] = "N" Then
						ls_retorno = "100" 		 	// Bloqueado sem permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
					End If
				Next
				
			ElseIf lvds_1.RowCount() = 0 Then
				ls_retorno = '0'						// Nenhum Bloqueio
			End If
		End If
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na Conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribuido. A consulta ser$$HEX1$$e100$$ENDHEX$$ realizada no banco local.")
End If

Destroy(lvo_Conexao)

Close(w_Aguarde)


// Se n$$HEX1$$e300$$ENDHEX$$o conseguiu consultar na matriz, consulta na loja
If Not lb_Sucesso Then
	
	ls_Retorno = ''
	ls_Banco   = "Banco Local"
	
//	// Determina a sintaxe para cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow
//	ls_Sintaxe = SqlCa.SyntaxFromSQL(as_SQL, "Style(Type=Grid)", ls_Erro)
//	
//	If Trim(ls_Erro) <> "" Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da sintaxe da datawindow para consulta dos bloqueios.")		
//	Else
//	
//		// Cria a datawindow
//		//dc_uo_ds_Base lvds_1
//		lvds_1 = Create dc_uo_ds_Base
//		
//		lvds_1.Create(ls_Sintaxe, ls_Erro)
//		
//		If Trim(ls_Erro) <> "" Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow para consulta dos bloqueios.")
//		Else
//		
//			lvds_1.SetTransObject(SqlCa)
//				
		If lvds_1.Retrieve() = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta dos bloqueios no banco de dados local.")
		Else
		
			If lvds_1.RowCount() > 0 Then
				ls_Retorno = '1'					// Bloqueado com permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
				
				For ll_Row = 1 To lvds_1.RowCount()				
					If lvds_1.object.id_permite_liberacao[ll_Row] = "N" Then
						ls_Retorno = "100" 		 	// Bloqueado sem permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
						Exit
					End If		
				Next
			
			ElseIf lvds_1.RowCount() = 0 Then
				ls_Retorno = '0'					// Nenhum Bloqueio
			End If
			
			lb_Sucesso = True
			
		End If
//		End If		
//	End If		
End If

// Verifica se conseguiu consultar na matriz ou na loja
If lb_Sucesso Then
	
	If ls_Retorno = "0" Then
		lb_Bloqueado = False
	Else		

		OpenWithParm(w_ge079_bloqueio,ls_retorno)
			
		Choose Case Message.StringParm
			Case "CANCELAR"
				lb_Bloqueado = True
			Case "DETALHES"
				lb_Bloqueado = This.of_convenio_bloqueado(This.cd_convenio,This.cd_conveniado,This.cd_dependente,Ref as_matricula)
			Case "LIBERAR"
				If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_BLOQUEIO_CLIENTE", ref as_matricula) Then 
					lb_Bloqueado = True
				Else
					lb_Bloqueado = False
				End If
		End Choose
			
	End If
	
Else
	lb_Bloqueado = True
End If

Destroy(lvds_1)

Return lb_Bloqueado
end function

public function boolean of_bloqueado (string as_sql, ref string as_matricula);Boolean lvb_Sucesso, &
        lvb_Bloqueado

String lvs_Erro, &
		 lvs_Sintaxe, &
       lvs_Retorno, &
		 lvs_Banco

Long lvl_Linhas

// Determina a sintaxe para cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow
lvs_Sintaxe = SqlCa.SyntaxFromSQL(as_SQL, "Style(Type=Grid)", lvs_Erro)

If Trim(lvs_Erro) <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da sintaxe da datawindow para consulta dos bloqueios.")
	Return True
End If

// Cria a datawindow
dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

lvds_1.Create(lvs_Sintaxe, lvs_Erro)

If Trim(lvs_Erro) <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow para consulta dos bloqueios.")
	Destroy(lvds_1)
	Return True
End If

lvds_1.SetTransObject(SqlCa)

// Tenta consultar os bloqueios no banco de dados da matriz
Open(w_Aguarde)
w_Aguarde.Title = "Consultando Bloqueios na Matriz..."

// Objeto Transa$$HEX2$$e700e300$$ENDHEX$$o Remota Nova
uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvs_Banco = "Banco Matriz"

If lvo_Conexao.of_Retrieve(Ref lvds_1) Then 
	lvb_Sucesso = True
	lvl_Linhas	= lvo_Conexao.of_Linhas()
End If

Destroy(lvo_Conexao)
Close(w_Aguarde)

// Se n$$HEX1$$e300$$ENDHEX$$o conseguiu consultar na matriz, consulta na loja
If Not lvb_Sucesso Then
	lvs_Banco = "Banco Local"
	
	lvl_Linhas = lvds_1.Retrieve()
	
	If lvl_Linhas = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta dos bloqueios no banco de dados local.")
	Else
		lvb_Sucesso = True
	End If
End If

// Verifica se conseguiu consultar na matriz ou na loja
If lvb_Sucesso Then
	If lvl_Linhas > 0 Then
		// Se existir algum bloqueio, atualiza o objeto par$$HEX1$$e200$$ENDHEX$$metro e abre a janela para mostr$$HEX1$$e100$$ENDHEX$$-los
		// A datawindow $$HEX1$$e900$$ENDHEX$$ passada j$$HEX1$$e100$$ENDHEX$$ carregada, para n$$HEX1$$e300$$ENDHEX$$o precisar fazer um retrieve na janela novamente

		uo_Parametro_Controle_Bloqueio lvo_Parametro
		lvo_Parametro = Create uo_Parametro_Controle_Bloqueio
		
		lvo_Parametro.ivds_1 = lvds_1
		
		lvo_Parametro.ivs_Banco = lvs_Banco
		
		OpenWithParm(w_ge079_Lista_Bloqueio, lvo_Parametro)
		
		lvs_Retorno = Message.StringParm

		If IsNull(lvs_Retorno) Then
			lvb_Bloqueado = True
		Else
			lvb_Bloqueado = False
			
			as_Matricula = lvs_Retorno
		End If
		
		Destroy(lvo_Parametro)
	End If
Else
	lvb_Bloqueado = True
End If

Destroy(lvds_1)

Return lvb_Bloqueado
end function

public function boolean of_cliente_bloqueado_nova (string as_cliente, string as_dependente, string as_tipo_venda, ref string as_matricula);// Nova implementa$$HEX2$$e700e300$$ENDHEX$$o problema vers$$HEX1$$e300$$ENDHEX$$o PB 7.0

String	lvs_SQL
String 	lvs_Mensagem

String 	lvs_Erro, &
		 	lvs_Sintaxe, &
       	lvs_Retorno, &
		 	lvs_Banco

String	ls_Erro, &
	    	ls_Sintaxe, &
        	ls_Retorno, &
	    	ls_Banco, &
			ls_Mensagem
			
String 	ls_Bloqueio	
			 
Long		ll_Linha
Long		ll_Linhas
Long    	ll_Row
Long 		ll_Pos
Long		lvl_Retorno

Boolean 	lb_Sucesso, &
        	lb_Bloqueado

lvs_SQL = 	"select b.id_tipo_bloqueio, " + &
				"b.cd_motivo_bloqueio as cd_motivo_bloqueio, " + &
				"m.de_motivo_bloqueio as de_motivo_bloqueio, " + &
				"m.id_permite_liberacao as id_permite_liberacao " + &
				"from bloqueio b, motivo_bloqueio m " + &
				"where m.cd_motivo_bloqueio = b.cd_motivo_bloqueio " + &
				"and b.dh_liberacao is null"

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do cliente
Choose Case as_Tipo_Venda
	Case "CR"
		lvs_SQL += " and b.id_tipo_bloqueio in ('CLI', 'CRE')"
	Case "CC"
		lvs_SQL += " and b.id_tipo_bloqueio in ('CLI', 'CCO')"
	Case Else
		lvs_SQL += " and b.id_tipo_bloqueio = 'CLI'"
End Choose

lvs_SQL += " and b.cd_cliente = '" + as_Cliente + "'"

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do dependente do cliente
If Not IsNull(as_Dependente) Then
	lvs_SQL += " union " + ivs_SQL_Base + " and b.id_tipo_bloqueio = 'DEP' and b.cd_cliente_dependente = '" + as_Dependente + "'"
End If

// Determina a sintaxe para cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow
ls_Sintaxe = SqlCa.SyntaxFromSQL(lvs_SQL, "Style(Type=Grid)", ls_Erro)

If Trim(ls_Erro) <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da sintaxe da datawindow para consulta dos bloqueios.")		
	Return True
Else

	// Cria a datawindow
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	
	lvds_1.Create(ls_Sintaxe, ls_Erro)
	
	If Trim(ls_Erro) <> "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow para consulta dos bloqueios.")
		Return True
	Else
		lvds_1.SetTransObject(SqlCa)
	End If	
	
End If

// Tenta consultar os bloqueios no banco de dados da matriz
Open(w_Aguarde)
w_Aguarde.Title = "Consultando Bloqueios na Matriz..."

	
ls_Banco = "Banco Matriz"

//----Novo----
uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Retrieve(lvs_Sql, Ref lvs_Retorno)

If Not lvo_Conexao.of_Erro_Execucao() And Not lvo_Conexao.of_Erro_Conexao() Then
	lb_Sucesso = True
	
	If IsNull(lvs_Retorno) Or Trim(lvs_Retorno) = '' Then
		ls_retorno = '0'
	Else
		lvl_Retorno = lvds_1.ImportString(lvs_Retorno)
		
		If lvl_Retorno >= 0 Then
			
			ls_bloqueio = ''
	
			If lvds_1.RowCount() > 0 Then
			
				ls_retorno = '1'						// Bloqueado com permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
			
				For ll_linha = 1 To lvds_1.RowCount()
					
					ls_bloqueio += LeftA(lvds_1.object.cd_motivo_bloqueio  [ll_linha] + space(03) , 03) + ',' 
					ls_bloqueio += LeftA(lvds_1.object.de_motivo_bloqueio  [ll_linha] + space(40) , 40) + ',' 
					ls_bloqueio += LeftA(lvds_1.object.id_permite_liberacao[ll_linha] + space(01) , 01) + ';'				
					
					If lvds_1.object.id_permite_liberacao[ll_linha] = "N" Then
						ls_retorno = "100" 		 	// Bloqueado sem permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
					End If						
										
				Next
				
			ElseIf lvds_1.RowCount() = 0 Then
				ls_retorno = '0'						// Nenhum Bloqueio
			End If			
		End If
	End If
End If
	
Destroy(lvo_Conexao)

If lb_Sucesso Then

	If ls_retorno <> "0" Then
		
		This.of_Carrega_Bloqueio(ls_Bloqueio, Ref lvds_1)
							
	End If
	
End If

Close(w_Aguarde)

// Se n$$HEX1$$e300$$ENDHEX$$o conseguiu consultar na matriz, consulta na loja
If Not lb_Sucesso Then
	
	ls_Retorno = ''
	ls_Banco   = "Banco Local"
	
	If lvds_1.Retrieve() = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta dos bloqueios no banco de dados local.")
	Else
	
		If lvds_1.RowCount() > 0 Then
			ls_Retorno = '1'					// Bloqueado com permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
			
			For ll_Row = 1 To lvds_1.RowCount()
				If lvds_1.object.id_permite_liberacao[ll_Row] = "N" Then
					ls_Retorno = "100" 		 	// Bloqueado sem permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
					Exit
				End If							
			Next
		
		ElseIf lvds_1.RowCount() = 0 Then
			ls_Retorno = '0'					// Nenhum Bloqueio
		End If
		
		lb_Sucesso = True
		
	End If
	
	//Destroy(lvds_1)
		
End If

// Verifica se conseguiu consultar na matriz ou na loja
If lb_Sucesso Then
	
	If ls_Retorno = "0" Then
		lb_Bloqueado = False
	Else		

		OpenWithParm(w_ge079_bloqueio,ls_retorno)
			
		Choose Case Message.StringParm
			Case "CANCELAR"
				lb_Bloqueado = True
			Case "DETALHES"
				lb_Bloqueado = This.of_mostra_bloqueio_nova(lvds_1,ls_Banco,Ref as_Matricula)
			Case "LIBERAR"
				If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_BLOQUEIO_CLIENTE", ref as_matricula) Then 
					lb_Bloqueado = True
				Else
					lb_Bloqueado = False
				End If
		End Choose
			
	End If
	
Else
	lb_Bloqueado = True
End If

Destroy(lvds_1)

Return lb_Bloqueado
end function

on uo_controle_bloqueio.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_controle_bloqueio.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivs_SQL_Base = "select b.id_tipo_bloqueio, " + &
			   "b.cd_motivo_bloqueio, " + &
			   "m.de_motivo_bloqueio, " + &
			   "m.id_permite_liberacao " + &
			   "from bloqueio b, motivo_bloqueio m " + &
			   "where m.cd_motivo_bloqueio = b.cd_motivo_bloqueio " + &
			   "and b.dh_liberacao is null"
end event

