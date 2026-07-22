HA$PBExportHeader$uo_twain.sru
forward
global type uo_twain from nonvisualobject
end type
end forward

global type uo_twain from nonvisualobject
end type
global uo_twain uo_twain

type prototypes
// EZTwain library declarations for PowerScript 10
// XDefs translation of \EZTwain\VC\Eztwain.h
//-----------------------------------------------------------------
// EZTWAIN.H - interface to Easy TWAIN library
//
// 1.18		2008.07.10 Fix: DIB_ReadRow and DIB_RowBytes exported.
// 1.17		2008.02.27 Fix: Handle TWRC_CANCEL returned from MSG_ENABLEDS by some drivers.
//						(Fix contributed by forum member lpringle!)
// 1.16         2007.03.14 Fix: In TWAIN_CloseSourceManager, don't make unnecessary calls.
// 1.15     2006.05.09 Fix: If user closed the scan dialog during an Acquire,
//                     the last DIB handle, if any, was returned!
//                     Added VB\Eztwain.bas to package.
// 1.14     2004.08.06 Set XFERMECH=NATIVE as soon as DS is opened.
//                     trying to deal with scanners that default to memory xfer.
// 1.13     1999.09.08 Documented correct return codes of AcquireToFilename.
//                     - No code changes -
// 1.12     1998.09.14 Added Fix32ToFloat, allow MSG_OPENDS triplet.
//                     Added SetXferMech, XferMech.
// 1.11     1998.08.17 Added ToFix32, SetContrast, SetBrightness.
//                     Modified TWAIN_ToFix32 to round away-from-zero.
// 1.09beta 1998.07.27 Reverted from 1.08 to 1.06 and worked forward again.
// 1.06     1997.08.21 correction to message hook, fixed 32-bit exports
// 1.05     1996.11.06 32-bit conversion
// 1.04     1995.05.03 added: WriteNativeToFile, WriteNativeToFilename,
//                                            FreeNative, SetHideUI, GetHideUI, SetCurrentUnits,
//                                            GetCurrentUnits, SetCurrentResolution, SetBitDepth,
//                                            SetCurrentPixelType, SetCapOneValue.
// 1.0a     1994.06.23 first alpha version
// 0.0      1994.05.11 created
//
// EZTWAIN 1.x is not a product, and is not the work of any company involved
// in promoting or using the TWAIN standard.  This code is sample code,
// provided without charge, and you use it entirely at your own risk.
// No rights or ownership is claimed by the author, or by any company
// or organization.  There are no restrictions on use or (re)distribution.
//
// Download from:    www.eztwain.com/eztwain1.htm
//
// Support contact:  support@eztwain.com
//




        
//--------- Basic calls

FUNCTION Long TWAIN_AcquireNative(Long hwndApp, Long wPixTypes) &
   LIBRARY "EZTW32.dll"
// The minimal use of EZTWAIN.DLL is to just call this routine, with 0 for
// both params.  EZTWAIN creates a window if hwndApp is 0.
//
// Acquires a single image, from the currently selected Data Source, using
// Native-mode transfer. It waits until the source closes (if it's modal) or
// forces the source closed if not.  The return value is a handle to the
// acquired image.  Only one image can be acquired per call.
//
// Under Windows, the return value is a global memory handle - applying
// GlobalLock to it will return a (huge) pointer to the DIB, which
// starts with a BITMAPINFOHEADER.
// NOTE: You are responsible for disposing of the returned DIB - these things
// can eat up your Windows memory fast!  See TWAIN_FreeNative below.
//
// The image type can be restricted using the following masks.  A mask of 0
// means 'any pixel type is welcome'.
// Caution: You should not assume that the source will honor a pixel type
// restriction!  If you care, check the parameters of the DIB.

//CONSTANT Long TWAIN_BW = 1
//CONSTANT Long TWAIN_GRAY = 2
//CONSTANT Long TWAIN_RGB = 4
//CONSTANT Long TWAIN_PALETTE = 8
//CONSTANT Long TWAIN_ANYTYPE = 0

SUBROUTINE TWAIN_FreeNative(Long hdib) &
   LIBRARY "EZTW32.dll"
// Release the memory allocated to a native format image, as returned by
// TWAIN_AcquireNative. (If you are coding in C or C++, this is just a call
// to GlobalFree.)
// If you use TWAIN_AcquireNative and don't free the returned image handle,
// it stays around taking up Windows (virtual) memory until your application
// terminates.  Memory required per square inch:
//             1 bit B&W       8-bit grayscale     24-bit color
// 100 dpi      1.25KB              10KB               30KB
// 200 dpi        5KB               40KB              120KB
// 300 dpi      11.25KB             90KB              270KB
// 400 dpi       20KB              160KB              480KB
//

FUNCTION Long TWAIN_AcquireToClipboard(Long hwndApp, Long wPixTypes) &
   LIBRARY "EZTW32.dll"
// Like AcquireNative, but puts the resulting image, if any, into the system
// clipboard.  Under Windows, this will put a CF_DIB item in the clipboard
// if successful.  If this call fails, the clipboard is either empty or
// contains the old contents.
// A return value of 1 indicates success, 0 indicates failure.
//
// Useful for environments like Visual Basic where it is hard to make direct
// use of a DIB handle.  In fact, TWAIN_AcquireToClipboard uses
// TWAIN_AcquireNative for all the hard work.

FUNCTION Long TWAIN_AcquireToFilename(Long hwndApp, String sFile) &
   LIBRARY "EZTW32.dll" ALIAS FOR "TWAIN_AcquireToFilename;ansi"
// Acquire an image and write it to a .BMP (Windows Bitmap) file.
// The file name and path in pszFile are used.  If pszFile is NULL or
// points to an empty string, the user is prompted with a Save File dialog.
// Return values:
// 0 success
// -1 Acquire failed OR user cancelled File Save dialog
// -2 file open error (invalid path or name, or access denied)
// -3 (weird) unable to lock DIB - probably an invalid handle.
// -4 writing BMP data failed, possibly output device is full

FUNCTION Long TWAIN_SelectImageSource(Long hwnd) &
   LIBRARY "EZTW32.dll"
// This is the routine to call when the user chooses the "Select Source..."
// menu command from your application's File menu.  Your app has one of
// these, right?  The TWAIN spec calls for this feature to be available in
// your user interface, preferably as described.
// Note: If only one TWAIN device is installed on a system, it is selected
// automatically, so there is no need for the user to do Select Source.
// You should not require your users to do Select Source before Acquire.
//
// This function posts the Source Manager's Select Source dialog box.
// It returns after the user either OK's or CANCEL's that dialog.
// A return of 1 indicates OK, 0 indicates one of the following:
//   a) The user cancelled the dialog
//   b) The Source Manager found no data sources installed
//   c) There was a failure before the Select Source dialog could be posted
// -- details --
// Only sources that can return images (that are in the DG_IMAGE group) are
// displayed.  The current default source will be highlighted initially.
// In the standard implementation of "Select Source...", your application
// doesn't need to do anything except make this one call.
//
// If you want to be meticulous, disable your "Acquire" and "Select Source"
// menu items or buttons if TWAIN_IsAvailable() returns 0 - see below.


//--------- Basic TWAIN Inquiries

FUNCTION Long TWAIN_IsAvailable() &
   LIBRARY "EZTW32.dll"
// Call this function any time to find out if TWAIN is installed on the
// system.  It takes a little time on the first call, after that it's fast,
// just testing a flag.  It returns 1 if the TWAIN Source Manager is
// installed & can be loaded, 0 otherwise. 


FUNCTION Long TWAIN_EasyVersion() &
   LIBRARY "EZTW32.dll"
// Returns the version number of EZTWAIN.DLL, multiplied by 100.
// So e.g. version 2.01 will return 201 from this call.

FUNCTION Long TWAIN_State() &
   LIBRARY "EZTW32.dll"
// Returns the TWAIN Protocol State per the spec.
//CONSTANT Long TWAIN_PRESESSION = 1
//CONSTANT Long TWAIN_SM_LOADED = 2
//CONSTANT Long TWAIN_SM_OPEN = 3
//CONSTANT Long TWAIN_SOURCE_OPEN = 4
//CONSTANT Long TWAIN_SOURCE_ENABLED = 5
//CONSTANT Long TWAIN_TRANSFER_READY = 6
//CONSTANT Long TWAIN_TRANSFERRING = 7

//--------- DIB handling utilities ---------

FUNCTION Long TWAIN_DibDepth(Long hdib) &
   LIBRARY "EZTW32.dll"
// Depth of DIB, in bits i.e. bits per pixel.
FUNCTION Long TWAIN_DibWidth(Long hdib) &
   LIBRARY "EZTW32.dll"
// Width of DIB, in pixels (columns)
FUNCTION Long TWAIN_DibHeight(Long hdib) &
   LIBRARY "EZTW32.dll"
// Height of DIB, in lines (rows)
FUNCTION Long TWAIN_DibNumColors(Long hdib) &
   LIBRARY "EZTW32.dll"
// Number of colors in color table of DIB

FUNCTION Long TWAIN_RowSize(Long hdib) &
   LIBRARY "EZTW32.dll"

SUBROUTINE TWAIN_ReadRow(Long hdib, Long nRow, ref String prow) &
   LIBRARY "EZTW32.dll"
// Read row n of the given DIB into buffer at prow.
// Caller is responsible for ensuring buffer is large enough.
// Row 0 is the *top* row of the image, as it would be displayed.

FUNCTION Long TWAIN_CreateDibPalette(Long hdib) &
   LIBRARY "EZTW32.dll"
// Create and return a logical palette to be used for drawing the DIB.
// For 1, 4, and 8-bit DIBs the palette contains the DIB color table.
// For 24-bit DIBs, a default halftone palette is returned.

SUBROUTINE TWAIN_DrawDibToDC(Long hDC, Long dx, Long dy, Long w, Long h, Long hdib, Long sx, Long sy) &
   LIBRARY "EZTW32.dll"
// Draws a DIB on a device context.
// You should call CreateDibPalette, select that palette
// into the DC, and do a RealizePalette(hDC) first.

//--------- BMP file utilities
 
FUNCTION Long TWAIN_WriteNativeToFilename(Long hdib, String sFile) &
   LIBRARY "EZTW32.dll" ALIAS FOR "TWAIN_WriteNativeToFilename;ansi"
// Writes a DIB handle to a .BMP file
//
// hdib         = DIB handle, as returned by TWAIN_AcquireNative
// pszFile      = far pointer to NUL-terminated filename
// If pszFile is NULL or points to a null string, prompts the user
// for the filename with a standard file-save dialog.
//
// Return values:
//       0      success
//      -1      user cancelled File Save dialog
//      -2      file open error (invalid path or name, or access denied)
//      -3      (weird) unable to lock DIB - probably an invalid handle.
//      -4      writing BMP data failed, possibly output device is full

FUNCTION Long TWAIN_WriteNativeToFile(Long hdib, Long fh) &
   LIBRARY "EZTW32.dll"
// Writes a DIB to a file in .BMP format.
//
// hdib         = DIB handle, as returned by TWAIN_AcquireNative
// fh           = file handle, as returned by _open, _lopen or OpenFile
//
// Return value as for TWAIN_WriteNativeToFilename

FUNCTION Long TWAIN_LoadNativeFromFilename(String sFile) &
   LIBRARY "EZTW32.dll" ALIAS FOR "TWAIN_LoadNativeFromFilename;ansi"
// Load a .BMP file and return a DIB handle (as from AcquireNative.)
// Accepts a filename (including path & extension).
// If pszFile is NULL or points to a null string, the user is prompted.
// Returns a DIB handle if successful, otherwise NULL.

FUNCTION Long TWAIN_LoadNativeFromFile(Long fh) &
   LIBRARY "EZTW32.dll"
// Like LoadNativeFromFilename, but takes an already open file handle.


SUBROUTINE TWAIN_SetHideUI(Long fHide) &
   LIBRARY "EZTW32.dll"
FUNCTION Long TWAIN_GetHideUI() &
   LIBRARY "EZTW32.dll"
// These functions control the 'hide source user interface' flag.
// This flag is cleared initially, but if you set it non-zero, then when
// a source is enabled it will be asked to hide its user interface.
// Note that this is only a request - some sources will ignore it!
// This affects AcquireNative, AcquireToClipboard, and EnableSource.
// If the user interface is hidden, you will probably want to set at least
// some of the basic acquisition parameters yourself - see
// SetCurrentUnits, SetBitDepth, SetCurrentPixelType and
// SetCurrentResolution below.

//--------- Application Registration

SUBROUTINE TWAIN_RegisterApp(Long nMajorNum, Long nMinorNum, Long nLanguage, Long nCountry, ref String lpszVersion, ref String lpszMfg, ref String lpszFamily, ref String lpszProduct) &
   LIBRARY "EZTW32.dll"
//
// TWAIN_RegisterApp can be called *AS THE FIRST CALL*, to register the
// application. If this function is not called, the application is given a
// 'generic' registration by EZTWAIN.
// Registration only provides this information to the Source Manager and any
// sources you may open - it is used for debugging, and (frankly) by some
// sources to give special treatment to certain applications.

//--------- Error Analysis and Reporting ------------------------------------

FUNCTION Long TWAIN_GetResultCode() &
   LIBRARY "EZTW32.dll"
// Return the result code (TWRC_xxx) from the last triplet sent to TWAIN

FUNCTION Long TWAIN_GetConditionCode() &
   LIBRARY "EZTW32.dll"
// Return the condition code from the last triplet sent to TWAIN.
// (To be precise, from the last call to TWAIN_DS below)
// If a source is NOT open, return the condition code of the source manager.

SUBROUTINE TWAIN_ErrorBox(String sMsg) &
   LIBRARY "EZTW32.dll"
// Post an error message dialog with an exclamation mark, OK button,
// and the title 'TWAIN Error'.
// pszMsg points to a null-terminated message string.

SUBROUTINE TWAIN_ReportLastError(String sMsg) &
   LIBRARY "EZTW32.dll"
// Like TWAIN_ErrorBox, but if some details are available from
// TWAIN about the last failure, they are included in the message box.


//--------- TWAIN State Control ------------------------------------

FUNCTION Long TWAIN_LoadSourceManager() &
   LIBRARY "EZTW32.dll"
// Finds and loads the Data Source Manager, TWAIN.DLL.
// If Source Manager is already loaded, does nothing and returns TRUE.
// This can fail if TWAIN.DLL is not installed (in the right place), or
// if the library cannot load for some reason (insufficient memory?) or
// if TWAIN.DLL has been corrupted.

FUNCTION Long TWAIN_OpenSourceManager(Long hwnd) &
   LIBRARY "EZTW32.dll"
// Opens the Data Source Manager, if not already open.
// If the Source Manager is already open, does nothing and returns TRUE.
// This call will fail if the Source Manager is not loaded.

FUNCTION Long TWAIN_OpenDefaultSource() &
   LIBRARY "EZTW32.dll"
// This opens the source selected in the Select Source dialog.
// If a source is already open, does nothing and returns TRUE.
// Fails if the source manager is not loaded and open.
// Chamar essa fun$$HEX2$$e700e300$$ENDHEX$$o antes de tentar definir qualidades da imagem

FUNCTION Long TWAIN_EnableSource(Long hwnd) &
   LIBRARY "EZTW32.dll"
// Enables the open Data Source. This posts the source's user interface
// and allows image acquisition to begin.  If the source is already enabled,
// this call does nothing and returns TRUE.

FUNCTION Long TWAIN_DisableSource() &
   LIBRARY "EZTW32.dll"
// Disables the open Data Source, if any.
// This closes the source's user interface.
// If there is not an enabled source, does nothing and returns TRUE.

FUNCTION Long TWAIN_CloseSource() &
   LIBRARY "EZTW32.dll"
// Closes the open Data Source, if any.
// If the source is enabled, disables it first.
// If there is not an open source, does nothing and returns TRUE.

FUNCTION Long TWAIN_CloseSourceManager(Long hwnd) &
   LIBRARY "EZTW32.dll"
// Closes the Data Source Manager, if it is open.
// If a source is open, disables and closes it as needed.
// If the Source Manager is not open, does nothing and returns TRUE.

FUNCTION Long TWAIN_UnloadSourceManager() &
   LIBRARY "EZTW32.dll"
// Unloads the Data Source Manager i.e. TWAIN.DLL - releasing
// any associated memory or resources.
// This call will fail if the Source Manager is open, otherwise
// it always succeeds and returns TRUE.



FUNCTION Long TWAIN_WaitForNativeXfer(Long hwnd) &
   LIBRARY "EZTW32.dll"

SUBROUTINE TWAIN_ModalEventLoop() &
   LIBRARY "EZTW32.dll"
// Process messages until termination, source disable, or image transfer.


FUNCTION Long TWAIN_EndXfer() &
   LIBRARY "EZTW32.dll"

FUNCTION Long TWAIN_AbortAllPendingXfers() &
   LIBRARY "EZTW32.dll"


//--------- High-level Capability Negotiation Functions --------

FUNCTION Long TWAIN_NegotiateXferCount(Long nXfers) &
   LIBRARY "EZTW32.dll"
// Negotiate with open Source the number of images application will accept.
// This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
// nXfers = -1 means any number

FUNCTION Long TWAIN_NegotiatePixelTypes(Long wPixTypes) &
   LIBRARY "EZTW32.dll"
// Negotiate with the source to restrict pixel types that can be acquired.
// This tries to restrict the source to a *set* of pixel types,
// See TWAIN_AcquireNative above for some mask constants.
// --> This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
// A parameter of 0 (TWAIN_ANYTYPE) causes no negotiation & no restriction.
// You should not assume that the source will honor your restrictions, even
// if this call succeeds!

FUNCTION Long TWAIN_GetCurrentUnits() &
   LIBRARY "EZTW32.dll"
// Ask the source what its current unit of measure is.
// If anything goes wrong, this function just returns TWUN_INCHES (0).

FUNCTION Long TWAIN_SetCurrentUnits(Long nUnits) &
   LIBRARY "EZTW32.dll"
// Set the current unit of measure for the source.
// Unit of measure codes are in TWAIN.H, but TWUN_INCHES is 0.

FUNCTION Long TWAIN_GetBitDepth() &
   LIBRARY "EZTW32.dll"
// Get the current bitdepth, which can depend on the current PixelType.
// Bit depth is per color channel e.g. 24-bit RGB has bit depth 8.
// If anything goes wrong, this function returns 0.

FUNCTION Long TWAIN_SetBitDepth(Long nBits) &
   LIBRARY "EZTW32.dll"
// (Try to) set the current bitdepth (for the current pixel type).
// Se PixelType for definido 0(zero) o valor pode ser definido como 1
// Se PixelType for 4, s$$HEX1$$f300$$ENDHEX$$ deixa definir como 8.

FUNCTION Long TWAIN_GetPixelType() &
   LIBRARY "EZTW32.dll"
// Ask the source for the current pixel type.
// If anything goes wrong (it shouldn't), this function returns 0 (TWPT_BW).

FUNCTION Long TWAIN_SetCurrentPixelType(Long nPixType) &
   LIBRARY "EZTW32.dll"
// (Try to) set the current pixel type for acquisition.
// This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
// The source may select this pixel type, but don't assume it will.
//TWPT_BW          0 /* Black and White */
//TWPT_GRAY        1
//TWPT_RGB         2
//TWPT_PALETTE     3
//TWPT_CMY         4
//TWPT_CMYK        5
//TWPT_YUV         6
//TWPT_YUVK        7
//TWPT_CIEXYZ      8
//Antes de usar chamar a funcao TWAIN_OpenDefaultSource


FUNCTION Double TWAIN_GetCurrentResolution() &
   LIBRARY "EZTW32.dll"
// Ask the source for the current (horizontal) resolution.
// Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above)
// If anything goes wrong (it shouldn't) this function returns 0.0

FUNCTION Double TWAIN_GetYResolution() &
   LIBRARY "EZTW32.dll"
// Returns the current vertical resolution, in dots per *current unit*.
// In the event of failure, returns 0.0.

FUNCTION Long TWAIN_SetCurrentResolution(Double dRes) &
   LIBRARY "EZTW32.dll"
// (Try to) set the current resolution for acquisition.
// Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above)
// This is only allowed in State 4 (TWAIN_SOURCE_OPEN)
// Note: The source may select this resolution, but don't assume it will.
//	Resolu$$HEX1$$e300$$ENDHEX$$o minima que permite $$HEX1$$e900$$ENDHEX$$ 100.

FUNCTION Long TWAIN_SetContrast(Double dCon) &
   LIBRARY "EZTW32.dll"
// (Try to) set the current contrast for acquisition.
// The TWAIN standard says that the range for this cap is -1000 ... +1000

FUNCTION Long TWAIN_SetBrightness(Double dBri) &
   LIBRARY "EZTW32.dll"
// (Try to) set the current brightness for acquisition.
// The TWAIN standard says that the range for this cap is -1000 ... +1000

FUNCTION Long TWAIN_SetXferMech(Long mech) &
   LIBRARY "EZTW32.dll"
FUNCTION Long TWAIN_XferMech() &
   LIBRARY "EZTW32.dll"
// (Try to) set or get the transfer mode - one of the following:
//CONSTANT Long XFERMECH_NATIVE = 0
//CONSTANT Long XFERMECH_FILE = 1
//CONSTANT Long XFERMECH_MEMORY = 2

//--------- Low-level Capability Negotiation Functions --------

// Setting a capability is valid only in State 4 (TWAIN_SOURCE_OPEN)
// Getting a capability is valid in State 4 or any higher state.
 
FUNCTION Long TWAIN_SetCapOneValue(Long Cap, Long ItemType, Long ItemVal) &
   LIBRARY "EZTW32.dll"
// Do a DAT_CAPABILITY/MSG_SET, on capability 'Cap' (e.g. ICAP_PIXELTYPE,
// CAP_AUTOFEED, etc.) using a TW_ONEVALUE container with the given item type
// and value.  The item value must fit into 32 bits.
// Returns TRUE (1) if successful, FALSE (0) otherwise.

FUNCTION Long TWAIN_GetCapCurrent(Long Cap, Long ItemType, ref String pVal) &
   LIBRARY "EZTW32.dll" ALIAS FOR "TWAIN_GetCapCurrent;ansi"
// Do a DAT_CAPABILITY/MSG_GETCURRENT on capability 'Cap'.
// Copy the current value out of the returned container into *pVal.
// If the operation fails (the source refuses the request), or if the
// container is not a ONEVALUE or ENUMERATION, or if the item type of the
// returned container is incompatible with the expected TWTY_ type in nType,
// returns FALSE.  If this function returns FALSE, *pVal is not touched.

FUNCTION Long TWAIN_ToFix32(Double d) &
   LIBRARY "EZTW32.dll"
// Convert a floating-point value to a 32-bit TW_FIX32 value that can be passed
// to e.g. TWAIN_SetCapOneValue

FUNCTION Double TWAIN_Fix32ToFloat(Long nfix) &
   LIBRARY "EZTW32.dll"
// Convert a TW_FIX32 value (as returned from some capability inquiries)
// to a double (floating point) value.

//--------- Lowest-level functions for TWAIN protocol --------


FUNCTION Long TWAIN_DS(Long DG, Long DAT, Long MSG, ref String pData) &
   LIBRARY "EZTW32.dll" ALIAS FOR "TWAIN_DS;ansi"
// Passes the triplet (DG, DAT, MSG, pData) to the open data source if any.
// Returns 1 (TRUE) if the result code is TWRC_SUCCESS, 0 (FALSE) otherwise.
// The last result code can be retrieved with TWAIN_GetResultCode(), and the corresponding
// condition code can be retrieved with TWAIN_GetConditionCode().
// If no source is open this call will fail, result code TWRC_FAILURE, condition code TWCC_NODS.

FUNCTION Long TWAIN_Mgr(Long DG, Long DAT, Long MSG, ref String pData) &
   LIBRARY "EZTW32.dll" ALIAS FOR "TWAIN_Mgr;ansi"
// Passes a triplet to the Data Source Manager (DSM).
// Returns 1 (TRUE) if the result code is TWRC_SUCCESS, 0 (FALSE) otherwise.
// The last result code can be retrieved with TWAIN_GetResultCode(), and the corresponding
// condition code can be retrieved with TWAIN_GetConditionCode().
// If the Source Manager is not open, this call will fail, and set the result code to TWRC_FAILURE,
// with a condition code of TWCC_SEQERROR (triplet out of sequence).




end prototypes

type variables
String ivo_Dispositivo
end variables

forward prototypes
public function boolean of_selecao_dispositivo ()
public function boolean of_captura_epharma (long pl_handle, datetime pdt_emissao, string ps_autorizacao, ref string ps_caminho, ref string ps_nome_arquivo)
end prototypes

public function boolean of_selecao_dispositivo ();TWAIN_SelectImageSource(0) ////seta dispositovo default

//    string Name
//    IF TWAIN_GetSourceList() THEN
//        Name = Space(64)
//        DO WHILE TWAIN_GetNextSourceName(Name)
//            Name = trim (Name)
//            MessageBox("EZTwain", Name)
//            Name = Space(64)
//        LOOP
//    ELSE
//        MessageBox("EZTwain", "No TWAIN devices found.")
//    END IF
//
//This.ivo_dispositivo = name

Return True
end function

public function boolean of_captura_epharma (long pl_handle, datetime pdt_emissao, string ps_autorizacao, ref string ps_caminho, ref string ps_nome_arquivo);//This.of_selecao_dispositivo()

//TWAIN_SelectImageSource(pl_handle)
String		ls_nome_frente, &
			ls_nome_verso, &
			ls_erro

if TWAIN_IsAvailable() = 1 then // verifica se o dispositivo esta disponivel para uso 
	long ll_retorno
			
	CreateDirectory("C:\Sistemas\RL\ePharma")		
	CreateDirectory("C:\Sistemas\RL\ePharma\Receitas")
	CreateDirectory("C:\Sistemas\RL\ePharma\Receitas\Enviadas")
		
	ps_caminho = "C:\Sistemas\RL\ePharma\Receitas\"
	ps_nome_arquivo = ps_autorizacao + "_" + 	String(pdt_emissao, "yyyymmdd") + String(pdt_emissao, "hhmmss") + "-a.bmp"

//    TWAIN_SetHideUI(0)
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Posicione a FRENTE dos documentos no Scanner e clique no OK.", Question!, OKCancel!, 1) = 1 Then
		if TWAIN_OpenDefaultSource()  = 1 then	
	
			ll_retorno = TWAIN_SetCurrentPixelType(0)
			ll_retorno = TWAIN_SetBitDepth(1)		
			ll_retorno = TWAIN_setCurrentResolution(300);
			ll_retorno = TWAIN_GetBitDepth()
			
			ls_nome_frente = ps_autorizacao + "_" + 	String(pdt_emissao, "yyyymmdd") + String(pdt_emissao, "hhmmss") + "-a_FRENTE.bmp"
			
			if TWAIN_AcquireToFilename(pl_handle, ps_caminho + ls_nome_frente) <> 0 then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma imagem foi digitalizada!")				
				Return False
			End if						
			TWAIN_CloseSource()					
		Else
			MessageBox("EZTwain", "Falha ao conectar ao Scanner ou Scanner est$$HEX1$$e100$$ENDHEX$$ ocupado.")	
			Return False		
		End If					
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma imagem foi digitalizada!")
		Return False
	End If

	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Posicione o VERSO dos documentos no Scanner e clique no OK.", Question!, OKCancel!, 1) = 1 Then	
		if TWAIN_OpenDefaultSource()  = 1 then		
			ll_retorno = TWAIN_SetCurrentPixelType(0)
			ll_retorno = TWAIN_SetBitDepth(1)		
			ll_retorno = TWAIN_setCurrentResolution(300);
			ll_retorno = TWAIN_GetBitDepth()
			
			ls_nome_verso = ps_autorizacao + "_" + 	String(pdt_emissao, "yyyymmdd") + String(pdt_emissao, "hhmmss") + "-a_VERSO.bmp"
			
			if TWAIN_AcquireToFilename(pl_handle, ps_caminho + ls_nome_verso) <> 0 then 
				FileDelete(ps_caminho + ls_nome_frente)				
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma imagem foi digitalizada!")								
				Return False
			End if						
			TWAIN_CloseSource()							
		Else
			FileDelete(ps_caminho + ls_nome_frente)							
			MessageBox("EZTwain", "Falha ao conectar ao Scanner ou Scanner est$$HEX1$$e100$$ENDHEX$$ ocupado.")	
			Return False		
		End If		
	Else
		FileDelete(ps_caminho + ls_nome_frente)						
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma imagem foi digitalizada!")		
		Return False
	End If

		
//		if TWAIN_AcquireToFilename(pl_handle, ps_caminho + ps_nome_arquivo) <> 0 then 
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma imagem foi digitalizada!")				
//			Return False
//		End if
//		TWAIN_CloseSource()		
		
	dc_uo_zip lo_Zip
	lo_Zip = Create dc_uo_zip
	
	ls_erro = lo_zip.of_zip(ps_caminho + ls_nome_frente,ps_caminho + ps_nome_arquivo + '.zip')
	
	If ls_Erro <> "" Then
		FileDelete(ps_caminho + ls_nome_frente)
		FileDelete(ps_caminho + ls_nome_verso)			
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao tentar compactar arquivo ' + ls_nome_frente + '~r~r' + ls_Erro, StopSign! )
		//verificar o que fazer.		
		Return False
	Else
		FileDelete(ps_caminho + ls_nome_frente)
	End If		
	
	ls_erro = lo_zip.of_zip(ps_caminho + ls_nome_verso,ps_caminho + ps_nome_arquivo + '.zip')
	
	If ls_Erro <> "" Then
		FileDelete(ps_caminho + ls_nome_frente)
		FileDelete(ps_caminho + ls_nome_verso)					
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao tentar compactar arquivo ' + ls_nome_verso + '~r~r' + ls_Erro, StopSign! )
		//verificar o que fazer.		
		Return False
	Else
		FileDelete(ps_caminho + ls_nome_verso)
	End If	
	
	Destroy(lo_zip)		

else 
	MessageBox("EZTwain", "Scanner n$$HEX1$$e300$$ENDHEX$$o Localizado.")	
	Return False
end if 
	 
Return true
end function

on uo_twain.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_twain.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

