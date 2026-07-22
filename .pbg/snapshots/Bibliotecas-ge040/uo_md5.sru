HA$PBExportHeader$uo_md5.sru
forward
global type uo_md5 from nonvisualobject
end type
end forward

global type uo_md5 from nonvisualobject
end type
global uo_md5 uo_md5

type prototypes
Function Boolean CryptAcquireContextA (ref ulong hProv, ref string pszContainer, ref string pszProvider, ulong dwProvType, ulong dwFlags) LIBRARY "advapi32.dll"  alias for "CryptAcquireContextA;Ansi";
Function Boolean CryptReleaseContext (ulong hProv, ulong dwFlags) LIBRARY "advapi32.dll" alias for "CryptReleaseContext;Ansi";
Function Boolean CryptCreateHash (ulong hProv, uint Algid, ulong hKey, ulong dwFlags, ref ulong phHash) LIBRARY "advapi32.dll" alias for "CryptCreateHash;Ansi";
Function Boolean CryptHashData (ulong hHash, ref string pbData, ulong dwDataLen, ulong dwFlags) LIBRARY "advapi32.dll" alias for "CryptHashData;Ansi";
Function Boolean CryptDestroyHash (ulong hHash) LIBRARY "advapi32.dll" alias for "CryptDestroyHash;Ansi";
Function Boolean CryptGetHashParam (ulong hHash, ulong dwParam, ref blob pbData, ref ulong pdwDataLen, ulong dwFlags) LIBRARY "advapi32.dll" alias for "CryptGetHashParam;Ansi";
Function Ulong GetLastError () Library "kernel32.dll";
end prototypes

type variables
CONSTANT ULONG PROV_RSA_FULL = 1 
CONSTANT ULONG CRYPT_VERIFYCONTEXT = 4026531840 // 0xF0000000 
CONSTANT ULONG CALG_MD5 = 32771 // 4<<13 | 0 | 3 
CONSTANT ULONG HP_HASHVAL = 2 // 0x0002 
end variables

forward prototypes
public function string of_md5 (string ps_texto)
public function string of_md5 (string ps_texto)
end prototypes

public function string of_md5 (string ps_texto);//Funcao para retornar o MD5 de uma String
//Retirada da Internet http://www.celso.cortes.nom.br/
//Retorna sempre 32 caracteres, independente da quantidade de caracteres do string original.
ulong MD5LEN = 16 
ulong hProv // provider handle 
ulong hHash // hash object handle 
ulong err_number 
String s_result, s_null 
Integer i, l, r, b 
Blob{16} bl_hash 
Blob{1} bl_byte 

SetNull (s_null) 
ulong cbHash = 0 
CHAR HexDigits[0 TO 15] = {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'} 


//Get handle to the crypto provider 

IF NOT CryptAcquireContextA(hProv, s_null, s_null, PROV_RSA_FULL, CRYPT_VERIFYCONTEXT) THEN 
	err_number = GetLastError() 
	return 'acquire context failed ' + String (err_number) 
END IF 

// Create the hash object 

IF NOT CryptCreateHash(hProv, CALG_MD5, 0, 0, hHash) THEN 
	err_number = GetLastError() 
	CryptReleaseContext(hProv, 0) 
	return 'create hash failed ' + String (err_number) 
END IF 

// Add the input to the hash 

IF NOT CryptHashData(hHash, ps_texto, Len(ps_texto), 0) THEN 
	err_number = GetLastError() 
	CryptDestroyHash(hHash) 
	CryptReleaseContext(hProv, 0) 
	return 'hashdata failed ' + String (err_number)
END IF 

// Get the hash value and convert it to readable characters 

cbHash = MD5LEN 
IF (CryptGetHashParam(hHash, HP_HASHVAL, bl_hash, cbHash, 0)) THEN 
	FOR i = 1 TO 16 
		bl_byte = BlobMid (bl_hash, i, 1) 
		b = AscA (String(bl_byte, EncodingANSI!)) 
		r = Mod (b, 16) // right 4 bits 
		l = b / 16 // left 4 bits 
		s_result += HexDigits [l] + HexDigits [r] 
	NEXT 
ELSE 
	err_number = GetLastError()
	return 'gethashparam failed ' + String (err_number) 
END IF 

// clean up and return 

CryptDestroyHash(hHash) 
CryptReleaseContext(hProv, 0) 

return s_result 
end function

on uo_md5.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_md5.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

