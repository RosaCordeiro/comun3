HA$PBExportHeader$px_nfecabecmsg.sru
$PBExportComments$Proxy imported from Web service using Web Service Proxy Generator.
forward
    global type px_nfeCabecMsg from nonvisualobject
    end type
end forward

global type px_nfeCabecMsg from nonvisualobject
end type

type variables
    string cUF
    string versaoDados
    any AnyAttr[]
    string EncodedMustUnderstand
    string EncodedMustUnderstand12
    boolean MustUnderstand
    string Actor
    string Role
    boolean DidUnderstand
    string EncodedRelay
    boolean Relay
end variables

on px_nfeCabecMsg.create
call super::create
TriggerEvent( this, "constructor" )
end on

on px_nfeCabecMsg.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

