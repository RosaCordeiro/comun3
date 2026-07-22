HA$PBExportHeader$uo_ajuda_convenio.sru
forward
global type uo_ajuda_convenio from nonvisualobject
end type
end forward

global type uo_ajuda_convenio from nonvisualobject
end type
global uo_ajuda_convenio uo_ajuda_convenio

forward prototypes
public function boolean of_manual_atendimento (long pl_convenio)
public function boolean of_maximiza_janela (string ps_janela)
public subroutine of_manual_atendimento_html (long pl_convenio)
public function boolean of_servidor_ajuda (ref string ps_servidor)
public subroutine of_manual_atendimento (string ps_codigo, string ps_extensao)
end prototypes

public function boolean of_manual_atendimento (long pl_convenio);String lvs_ajuda_convenio

// Verifica se o conv$$HEX1$$ea00$$ENDHEX$$nio foi selecionado
If IsNull(pl_convenio) or pl_convenio <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A fun$$HEX2$$e700e300$$ENDHEX$$o de ajuda s$$HEX1$$f300$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel nas vendas para conv$$HEX1$$ea00$$ENDHEX$$nios.", Information!)
	Return False
End If

This.of_manual_atendimento_html(pl_convenio)

Return True

end function

public function boolean of_maximiza_janela (string ps_janela);Boolean lb_Retorno

dc_uo_api lo_api
lo_api = Create dc_uo_api

lb_Retorno = lo_api.of_Maximiza_Janela(ps_janela)

Destroy(lo_api)

Return lb_Retorno
end function

public subroutine of_manual_atendimento_html (long pl_convenio);String lvs_Servidor, &
		 lvs_Exe, &
		 lvs_Arquivo_Ajuda, &
		 lvs_Ini

lvs_INI = gvo_Aplicacao.ivs_Arquivo_INI

// Verifica se o caminho do execut$$HEX1$$e100$$ENDHEX$$vel est$$HEX1$$e100$$ENDHEX$$ especificado no INI
//lvs_Exe = ProfileString(lvs_INI, "Diretorio", "Executavel_Ajuda_Convenio", "")


If of_servidor_ajuda(ref lvs_Servidor) Then

	lvs_Arquivo_Ajuda = 'http://' + lvs_Servidor + "/" + &
							  String(pl_convenio, "00000") + ".htm"
	
	dc_uo_Api lo_Api
	lo_Api = Create dc_uo_api
	lo_Api.of_Shell_Execute( lvs_Arquivo_Ajuda, '' )
	Destroy lo_Api
	
End If
end subroutine

public function boolean of_servidor_ajuda (ref string ps_servidor);Boolean lb_Sucesso

// Seleciona parametros
uo_Parametro_Filial lvo_Parametro_Filial
lvo_Parametro_Filial = Create uo_Parametro_Filial

lb_Sucesso = lvo_Parametro_Filial.of_Localiza_Parametro("DE_ENDERECO_SERVIDOR_AJUDA_CONVENIO", ref ps_servidor)

Destroy(lvo_Parametro_Filial)

Return lb_Sucesso
end function

public subroutine of_manual_atendimento (string ps_codigo, string ps_extensao);String lvs_Servidor, &
		 lvs_Exe, &
		 lvs_Arquivo_Ajuda

If of_servidor_ajuda(ref lvs_Servidor) Then

	lvs_Arquivo_Ajuda = 'http://' + lvs_Servidor + '/' + &
							  ps_codigo + "." + ps_extensao
	
	dc_uo_Api lo_Api
	lo_Api = Create dc_uo_api
	lo_Api.of_Shell_Execute( lvs_Arquivo_Ajuda, '' )
	Destroy lo_Api
	
End If
end subroutine

on uo_ajuda_convenio.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ajuda_convenio.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

