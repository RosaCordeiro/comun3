HA$PBExportHeader$uo_ge393_twain4.sru
forward
global type uo_ge393_twain4 from nonvisualobject
end type
end forward

global type uo_ge393_twain4 from nonvisualobject
end type
global uo_ge393_twain4 uo_ge393_twain4

type prototypes
// EZTwain library declarations for PowerScript 10
// XDefs translation of \EZTwain4\VC\Eztwain.h
// EZTwain/XDefs 4.0.3.0
//-----------------------------------------------------------------
// EZTWAIN.H - Easy interface to TWAIN library
// Copyright $$HEX1$$a900$$ENDHEX$$ Atalasoft, Inc.
//
// This interface and the library which implements it, are the property of
// Atalasoft Inc and are protected by US and International copyright and trademark
// laws and treaties.  Atalasoft strives to make this software reliable,
// comprehensive, efficient, and affordable.  Do not use this software without
// obtaining a license for your use.
// 
// Sales, support and licensing information at: www.eztwain.com
//



FUNCTION Long TWAIN_Testing123(String s, Long n, Long h, Double d, Long u) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_Testing123;ansi"
// Displays a dialog box showing the parameter values received by the function.
// Pass in any valid values for the parameters - if they are faithfully
// displayed in the dialog box when you call this function, then parameter
// passing from your program to EZTwain is probably working correctly.
//
// Returns the value of the HDIB h parameter.

//--------- Top-Level Calls

SUBROUTINE TWAIN_ResetAll() &
   LIBRARY "Eztwain4.dll"
// Resets EZTwain to default/just loaded state.
// (Except diagnostic logging, which is unaffected.)
// Any global settings are reset to initial values.
// Any open files are closed.
// Any open TWAIN device is closed.
// This function is used to place EZTwain in a 'known state'
// before starting a sequence of scanning calls.

FUNCTION Long TWAIN_Acquire(Long hwndApp) &
   LIBRARY "Eztwain4.dll"
// Acquires a single image, from the currently selected Data Source.
//
// The parameter is a Win32 Window Handle.  In most applications you
// can use 0 or NULL, but on Citrix and WTS, this must be a top-level window
// or a child of a top level window.
//
// The return value is a handle to global memory containing a DIB - 
// a Device-Independent Bitmap.  Numerous EZTWAIN DIB_xxx functions can
// be used to examine, modify, and save these DIB images.
// Warning: Remember to call DIB_Free on each DIB when you are done with it!
//
// Normally only one image is acquired per call: All Acquire functions shut
// down TWAIN before returning.  Use TWAIN_SetMultiTransfer to change this.
//
// By default, the default data source (DS) is opened, displays its dialog,
// and determines all the parameters of the acquisition and transfer.
// If you want to (try to) hide the DS dialog, see TWAIN_SetHideUI.
// To set acquisition parameters, you need to do something like this:
//     TWAIN_OpenDefaultSource() -or- TWAIN_OpenSource(sourceName)
//     TWAIN_Set*        - one or more capability-setting functions
//     hdib = TWAIN_Acquire(hwnd)
//     if (hdib) then ... process image, DIB_Free(hdib); end

FUNCTION Boolean TWAIN_SelectImageSource(Long hwnd) &
   LIBRARY "Eztwain4.dll"
// Display the standard TWAIN "Select Source" dialog which
// allows the user to specify the system-wide default TWAIN device.
//
// Note this is a configuration function, it does not open or activate the device.
// See: TWAIN_GetDefaultSourceName and TWAIN_OpenDefaultSource.
//
// Note: If only one TWAIN device is installed on a system, TWAIN selects it
// automatically, so there is no need for the user to do Select Source.
// You should not require your users to do Select Source before Acquire.
//
// It returns after the user either OK's or CANCEL's the dialog.
// A return of TRUE(1) indicates OK, FALSE(0) indicates one of the following:
//   a) The user cancelled the dialog
//   b) The Source Manager found no data sources installed
//   c) There was a failure before the Select Source dialog could be posted
//
// Note: You can call (Get)DefaultSourceName to get the name of the
// current default source, after calling SelectImageSource, or any other time.

FUNCTION Long TWAIN_AcquireToFilename(Long hwndApp, String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_AcquireToFilename;ansi"
// Acquire an image and save it to a file.
// If the filename is NULL or an empty string, the user is prompted for
// the file name using a standard Save File dialog.
//
// The minimal use of EZTwain is to call this function with both arguments NULL (0).
//
// If the filename passed as a parameter or entered by the user contains a
// standard extension (.bmp, .jpg/.jpeg, .tif/.tiff, .png, .pdf, .gif, .dcx)
// then the file is saved in the implied format.
// Otherwise the file is saved in the current SaveFormat - see TWAIN_SetSaveFormat.

// See also TWAIN_AcquireFile below.
//
// Return values:
//   0  success.
//  -1  the Acquire failed.
//  -2  file open error (invalid path or name, or access denied)
//  -3  invalid DIB, or image incompatible with file format, or...
//  -4  writing failed, possibly output device is full.
// -10  user cancelled File Save dialog


FUNCTION Long TWAIN_AcquireMultipageFile(Long hwndApp, String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_AcquireMultipageFile;ansi"
// Acquire (scan) all available images to a multipage file.
// If the filename is NULL or points to the null string, the user is
// prompted for the filename.
// If the filename ends with ".tif", ".tiff", or
// ".mpt" the file is written in TIFF format.
// If the filename ends with ".pdf" the file is written in PDF format.
// Otherwise, the default multipage format is used, as set by SetMultipageFormat.
// If it has not been set, the default multipage format is TIFF.
//
// If scanning fails or is cancelled before the first writable page
// is received, no file action is taken: The output filename is not prompted for,
// the file is not created, if it exists it is not touched.
//
// The function TWAIN_MultipageCount can be called during or after
// writing a multipage file, it reports the number of images written to the file.
// See also TWAIN_AcquireCount and TWAIN_BlankDiscardCount for other info.
//
// Return values:
//   0  success
//  -1  the Acquire failed, or the device closed or quit after 0 pages.
//      If 0 pages were written but no other error was diagnosed,
//      TWAIN_LastErrorCode will be EZTEC_0_PAGES.
//  -2  file open error (invalid path or name, or access denied)
//  -3  could not load file-format module (EZT4Tiff.dll or EZT4Pdf.dll)
//      Either the DLL was not found, or the version is out-of-date,
//      For PDF output, EZT4Jpeg.dll is also required.
//      Less likely: The device returned an invalid DIB handle, or
//      the transferred image has a bit depth of 9..15 bits per pixel (??)
//  -4  writing failed, possibly output device is full.
//  -7  Multipage support is not installed.
// -10  user cancelled - This can be during the filename prompt, if you
//      did not supply a filename, or it can be when the scanner dialog
//      is first displayed.  If the scanner dialog is visible, the user
//      can cancel during a scan and the dialog will just stay open (usually)
//      allowing another try.  If the user closed the scan dialog without
//      scanning, TWAIN_LastErrorCode will be EZTEC_USER_CANCEL.
//
// This function respects TWAIN_SetHideUI as follows:
// If SetHideUI(1), then the device UI is hidden, AcquireMultipageFile
// will transfer images until the device indicates that it has no
// more images ready.  (Technically, it goes to State 5).
// Exception: If a device seems to be one-image-at-a-time (such as a flatbed)
// the user will be asked if they want to acquire another image.
//
// If SetHideUI(0) [the default case] then the device UI is shown,
// and AcquireMultipageFile will transfer images until the user
// closes the device dialog.  (You can call SetStopOnEmpty to have
// scanning stop when the device runs out of images/paper.)
//
// This function respects SetMultiTransfer() as follows:
// If SetMultiTransfer(1), the DS is left open on return.
// Otherwise (the default case), the DS is closed and TWAIN is unloaded.
//
// If you want to set scanning parameters (resolution, pixeltype...)
// first open the source (see OpenDefaultSource or OpenSource)
// then negotiate the settings using the Capability functions, and
// then call AcquireMultipageFile.
//
// Caution: It is not recommended to use this function on webcams
// if the UI is hidden.  Some will crash, others may supply images
// endlessly (until disk full.)

FUNCTION Long TWAIN_AcquireToArray(Long hwnd, ref Long ahdib, Long nMax) &
   LIBRARY "Eztwain4.dll"
// Scan and store images in the specified array.
// Very similar to TWAIN_AcquireMultipageFile.
// A return value of N > 0 means N images were scanned and stored
// without error.
// If no (0) images were scanned and stored and there was no other error,
// the return value will be -1 and TWAIN_LastErrorCode will be EZTEC_0_PAGES.
// Any unused entries in the array are set to 0 (NULL)
// In case of error, no images are returned - the scan must be restarted.

FUNCTION Long TWAIN_AcquireImagesToFiles(Long hwndApp, String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_AcquireImagesToFiles;ansi"
// Similar to TWAIN_AcquireMultipageFile above, but writes each
// image to a separate file.  The format of the output files is
// determined by the extension of the filename, as with AcquireToFilename.
//
// If the filename is NULL or points to the null string, the user is
// prompted for the name of the first file.
//
// Files after the first are given names 'incremented' from the name
// of the first file according to this pattern:
// document.pdf increments to document1.pdf
// document99.pdf increments to document100.pdf
// document0001.tif increments to document0002.tif.
//
// Return values:
// IMPORTANT: If successful, returns the number of files written.
// Note that this could be 0 if the scanner dialog is displayed and
// the user closes the dialog without any scans.
// Otherwise, return value same as TWAIN_AcquireMultipageFile, and
// details available from TWAIN_LastErrorCode & related functions.
// 
// See also: TWAIN_AcquiredFileCount
//           TWAIN_AcquireCount
//           TWAIN_BlankDiscardCount.

FUNCTION Long TWAIN_AcquirePagesToFiles(Long hwnd, Long nPPF, String sFile) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_AcquirePagesToFiles;ansi"
// Similar to AcquireImagesToFiles, but can acquire duplex or multipage files.
//
// hwnd     = parent window. Use 0 (NULL) if you can't obtain the window handle.
//
// nPPF     = *pages* per file.
//            If the scanner is scanning duplex, 1 page = 2 images
//            otherwise 1 page = 1 image.
//
// pzFile   = filename.  We recommend including the extension to specify the format.
//            If the filename is NULL or points to the empty string, the user is
//            prompted for the name of the first file.
//
// Return: If successful, returns the number of files written.
// Otherwise, same as TWAIN_AcquireMultipageFile, with
// details available from TWAIN_LastErrorCode & related functions.

FUNCTION Long TWAIN_AcquireMultipage(Long hwnd) &
   LIBRARY "Eztwain4.dll"
// Similar to AcquireToArray and AcquireMultipageFile, but does nothing
// with the images except pass them to the callback function 
// (which you should set with SetAcquireImageCallback.)
//
// Return: 0 if successful,
// Otherwise a negative number: see AcquireMultipageFile.
//
// Details of Operation:
// If the callback returns a valid DIB handle, the returned DIB is
// freed with DIB_Free.
// Otherwise the callback's return value is ignored.
// In either case, scanning continues.
// To abort scanning the callback can call TWAIN_RecordError with an error.
// Two error codes are treated specially:
// EZTEC_NONE, which is ignored and has no effect on scanning, and
// EZTEC_USER_CANCEL which causes AcquireMultipage to abort the scan
// and return a value of -1, *after clearing* the error with TWAIN_ClearError.
// All other errors cause AcquireMultipage to abort the scan and
// return -1, leaving the error code available via TWAIN_LastErrorCode & co.
//
// This function allows EZTwain to handle the complexities of multipage
// scanning while your callback function does whatever you want done with
// each image.

FUNCTION Long TWAIN_AcquiredFileCount() &
   LIBRARY "Eztwain4.dll"
// Returns the number of files successfully written by the last call to
// AcquireImagesToFiles or AcquirePagesToFiles.

FUNCTION Long TWAIN_AcquireCompressed(Long hwndApp) &
   LIBRARY "Eztwain4.dll"
// Acquire the next available image from the open (or default) device,
// accepting a compressed memory transfer if one is selected.
// (Use TWAIN_SetCompression to select the compression algorithm.)
// 
// The DIB handle which is returned will normally reference a compressed
// DIB, which is acceptable to relatively few EZTwain functions.
// See also: DIB_IsCompressed
//
// Recommended use of this function:
// Open a device with TWAIN_OpenSource or TWAIN_OpenDefaultSource.
// Set any other scanning parameters such as PixelType, resolution, etc.
// Select memory transfer mode, using TWAIN_SetXferMech.
// Select a compression algorithm, using TWAIN_SetCompression.
// Call this function (possibly in a loop) to acquire images.


FUNCTION Long TWAIN_AcquireCount() &
   LIBRARY "Eztwain4.dll"
// Returns the number of images acquired by the last call to
// TWAIN_AcquireMultipageFile, TWAIN_AcquireImagesToFiles,
// or TWAIN_AcquirePagesToFiles.
//
// This includes only "keeper" pages - it *excludes*
// any discarded blank pages, separator pages, etc.
//
// Therefore it may differ from the value of TWAIN_MultipageCount.

FUNCTION Boolean TWAIN_PromptToContinue(Long hwnd) &
   LIBRARY "Eztwain4.dll"
// Prompt the user "Continue scanning?"
// Return TRUE(1) if yes, FALSE(0) if not.
// If the parameter is a valid Windows window-handle, that window
// is used as the parent of the prompt message box, otherwise
// the foreground window of the current task/process is used.
//
// If you have called TWAIN_SetScanAnotherPagePrompt with a (non-empty)
// string, that string is used as the prompt message.
//
// Otherwise, a standard prompt is used:
// The prompt is automatically translated based on thread locale
// (which defaults to application locale, which defaults to user locale,
//  which defaults to system locale)
// Languages: Danish, Dutch, English, French, German, Italian,
// Norwegian, Polish, Portuguese, Spanish, Swedish.
// Also Russian and Japanese, but those may not work....

SUBROUTINE TWAIN_SetScanAnotherPagePrompt(String sPrompt) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetScanAnotherPagePrompt;ansi"
// Sets the prompt message for the "Scan another page?" prompt.
// Set TWAIN_PromptToContinue above. Also this prompt is used
// by all the multipage Acquire functions in certain circumstances.

FUNCTION Long TWAIN_SetDefaultScanAnotherPagePrompt(Long fYes) &
   LIBRARY "Eztwain4.dll"
// Controls an aspect of TWAIN_AcquireMultipageFile - When used
// with a non-feeder device, with UI suppressed, that function
// asks the user if they want to scan another page, [Yes] or [No].
// This function controls which answer is the default:
// fYes = 1         [Yes] is the default button/answer*
// fYes = 0         [No] is the default button/answer.
//
// * EZTwain initial setting.
//  
// Return value: Previous value of the setting.


FUNCTION Long TWAIN_DoSettingsDialog(Long hwnd) &
   LIBRARY "Eztwain4.dll"
// Run the device's settings dialog, if this is supported, and return
// when the user closes the dialog.  See return codes below.
// 
// The purpose of this feature, which is definitely not supported by all
// devices, is to allow a human operator to define a complete device
// configuration, including settings that are proprietary and that may
// appear only in the device's UI.  This configuration can then be saved
// exactly and in toto, using the (TWAIN_)GetCustomData
//
// If a device is open, work with that device.  If no device is currently
// open, work with the default device.  (See GetDefaultSourceName)
// This is an *optional* TWAIN feature - To check if a device supports this,
// open the device and call TWAIN_GetCapBool(CAP_ENABLEDSUIONLY, FALSE) -
// if that call returns TRUE(1) then this feature is supported.
// Return values:
//    1     dialog was displayed and user clicked OK
//    0     dialog was displayed and user clicked Cancel
//   -1     dialog not displayed - some error.  Call LastErrorCode,
//          ReportLastError, or similar function for more details.

FUNCTION Boolean TWAIN_EnableSourceUiOnly(Long hwnd) &
   LIBRARY "Eztwain4.dll"
// The underlying 'asynchronous' function for TWAIN_DoSettingsDialog.
// Opens the device's settings dialog, if this is supported.
// Returns TRUE (1) if successful, FALSE (0) otherwise.
// NOTE: If successful, this call leaves the dialog open, so your
// program must run a message pump at least until the user closes it.
// If you don't understand what that means, don't call this guy.

//--------- Global Options

SUBROUTINE TWAIN_SetMultiTransfer(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_GetMultiTransfer() &
   LIBRARY "Eztwain4.dll"
// This function controls the 'multiple transfers' flag.
// By default, this feature is set to FALSE (0).
//
// If this flag is zero, the input device is closed when
// any TWAIN_AcquireXXX function finishes.
//
// If this flag is non-zero: After an Acquire, the input device
// is not closed, but is left open to allow additional images
// to be acquired.  In this case the programmer should
// close the input device after all images have been
// transferred, by calling either
//     TWAIN_CloseSource or
//     TWAIN_UnloadSourceManager
//
// See also: TWAIN_UserClosedSource()

SUBROUTINE TWAIN_SetHideUI(Boolean bHide) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_GetHideUI() &
   LIBRARY "Eztwain4.dll"
// These functions control the 'hide source user interface' flag.
// This flag is cleared initially, but if you set it non-zero, then when
// a device is enabled it will be asked to hide its user interface.
// Note that this is only a request - some devices will ignore it!
// This affects all the Acquire functions, and EnableSource.
// If the user interface is hidden, you will probably want to set at least
// some of the basic acquisition parameters yourself - see
// SetUnits, SetPixelType, SetBitDepth and SetResolution below.
// See also: HasControllableUI

SUBROUTINE TWAIN_SetStopOnEmpty(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_GetStopOnEmpty() &
   LIBRARY "Eztwain4.dll"
// These functions manage the 'Stop On Empty' flag.
// This flag is off (FALSE) by default.
// When set, multipage scanning functions stop scanning and return
// when the device indicates that no more images are 'pending',
// *even if* the scanner's dialog is being displayed.
// Note that the normal behavior when the scanner dialog is displayed
// is to continue scanning until the user closes the dialog.
// Of course, behavior varies from scanner to scanner, but with most
// ADF scanners, setting Stop On Empty will cause multipage
// scanning to stop when everything in the feeder has been scanned.

SUBROUTINE TWAIN_DisableParent(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_GetDisableParent() &
   LIBRARY "Eztwain4.dll"
// Set or get the "DisableParent" flag.
// When this flag is set (non-zero), EZTwain attempts to
// disable the parent window during any Acquire function.
// (The parent window is the window you pass to the Acquire function.
// Typically this is your main application window or dialog.)
// This flag is TRUE (1) by default.
//
// Note 1: If you set this to FALSE, your window can receive user input while
// an Acquire is in progress, and your code must be prepared for this.
// Note 2: Some TWAIN data sources will disable the parent window on their
// own, and EZTWAIN cannot prevent this.


//--------- Basic TWAIN Inquiries

FUNCTION Long TWAIN_EasyVersion() &
   LIBRARY "Eztwain4.dll"
// Returns the version number of EZTWAIN.DLL, multiplied by 100.
// So e.g. version 2.01 will return 201 from this call.
FUNCTION Long TWAIN_EasyBuild() &
   LIBRARY "Eztwain4.dll"
// Returns the build number within the version.

FUNCTION Boolean TWAIN_IsAvailable() &
   LIBRARY "Eztwain4.dll"
// Call this function any time to find out if TWAIN is installed on the
// system.  It takes a little time on the first call, after that it's fast,
// just testing a flag.  It returns 1 if the TWAIN Source Manager is
// installed & can be loaded, 0 otherwise. 

FUNCTION Boolean TWAIN_IsMultipageAvailable() &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) if EZTwain 'multipage' services are installed.
// This allows writing of multipage TIFF (if TIFF is available)
// and multipage PDF (if PDF is available).
// It also enables TWAIN_AcquireMultipageFile

FUNCTION Long TWAIN_State() &
   LIBRARY "Eztwain4.dll"
// Returns the TWAIN Protocol State per the spec.
//CONSTANT Long TWAIN_PRESESSION = 1
//CONSTANT Long TWAIN_SM_LOADED = 2
//CONSTANT Long TWAIN_SM_OPEN = 3
//CONSTANT Long TWAIN_SOURCE_OPEN = 4
//CONSTANT Long TWAIN_SOURCE_ENABLED = 5
//CONSTANT Long TWAIN_TRANSFER_READY = 6
//CONSTANT Long TWAIN_TRANSFERRING = 7

FUNCTION Boolean TWAIN_IsDone() &
   LIBRARY "Eztwain4.dll"
// Return FALSE(0) if there is a device open and it is in a state
// where more scans are available or could be requested.
// Otherwise returns TRUE (1).
//
// Informally, TRUE means 'stop asking for images' and
// FALSE means something like 'It would be appropriate
// at this time to request another image.'
//
// Yes, it sounds bizarre, but that's actually
// how TWAIN works.
//
// This call can be used for multipage scanning
// as the test at the *bottom* of a do-until loop:
//   If TWAIN_OpenDefaultSource() Then
//      TWAIN_SetMultiTransfer(1)
//      Do
//         TWAIN_AcquireToFilename(0, NextFileName())
//      Until TWAIN_IsDone()
//      TWAIN_CloseSource()
//   End If
//

FUNCTION String TWAIN_SourceName() &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SourceName;ansi"
// Returns a pointer to the name of the currently open source, if any, or
// the name of the source that was just closed.
// Should be used while a source is open, or right after a
// source has been used and then closed.

SUBROUTINE TWAIN_GetSourceName(ref String sName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetSourceName;ansi"
// Like TWAIN_SourceName, but copies current/last source name into its parameter.
// The parameter is a string variable (char array in C/C++).
// You are responsible for allocating room for 33 8-bit characters
// in the string variable before calling this function.

//--------- DIB handling utilities ---------

FUNCTION Boolean DIB_IsValid(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if parameter seems to be a valid DIB, FALSE(0) otherwise.
// A true return is not a guarantee, but a false return means something is
// seriously wrong.

FUNCTION Long DIB_Depth(Long hdib) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long DIB_BitsPerPixel(Long hdib) &
   LIBRARY "Eztwain4.dll"
// 'depth' of image - number of bits used to store one pixel

FUNCTION Long DIB_PixelType(Long hdib) &
   LIBRARY "Eztwain4.dll"
// TWAIN PixelType that describes this DIB: TWPT_BW, TWPT_GRAY, TWPT_RGB,
// TWPT_PALETTE, TWPT_CMYK, TWPT_CMY, etc.

FUNCTION Long DIB_Width(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Width of DIB, in pixels (columns)
FUNCTION Long DIB_Height(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Height of DIB, in lines (rows)

SUBROUTINE DIB_SetResolution(Long hdib, Double xdpi, Double ydpi) &
   LIBRARY "Eztwain4.dll"
SUBROUTINE DIB_SetResolutionInt(Long hdib, Long xdpi, Long ydpi) &
   LIBRARY "Eztwain4.dll"
// Sets the horizontal and vertical resolution of the DIB.

FUNCTION Double DIB_XResolution(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Horizontal (x) resolution of DIB, in DPI (dots per inch)
FUNCTION Double DIB_YResolution(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Vertical (y) resolution of DIB, in DPI (dots per inch)

FUNCTION Long DIB_XResolutionInt(Long hdib) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long DIB_YResolutionInt(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Return the nearest integer value to the x or y resolution of an image.

// Physical or 'implied' image size
FUNCTION Double DIB_PhysicalWidth(Long hdib, Long nUnits) &
   LIBRARY "Eztwain4.dll"
FUNCTION Double DIB_PhysicalHeight(Long hdib, Long nUnits) &
   LIBRARY "Eztwain4.dll"
// Return the width(height), in the specified units, of the given
// image, calculated using its pixel width(height) and X(Y) resolution.
// If the resolution is 0, these functions return 0.
// nUnits is one of the TWUN_ values - see TWAIN_GetCurrentUnits.
// nUnits=0 is inches, and nUnits=1 is centimeters(cm).

FUNCTION Long DIB_RowBytes(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Number of bytes needed to store one row of the DIB.

FUNCTION Long DIB_ColorCount(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Number of colors in color table of DIB.
// Primarily useful for B&W, gray, and palette images.
// 16-bit gray, RGB, CMY & CMYK images have no color table: DIB_ColorCount returns 0

FUNCTION Long DIB_SamplesPerPixel(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Number of 'samples' or components or color channels in each pixel.
// B&W and gray pixels have 1 sample, RGB and CMY have 3.
// CMYK has 4, and palette-color images are treated as having 3 channels.

FUNCTION Long DIB_BitsPerSample(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Number of bits per 'channel'.  For B&W and gray images this is
// the same as the DIB_Depth, because those formats have only one channel.
// For palette images, this will be 8, because the color values in a
// palette image are stored with 8 bits each for R, G, and B.
// For RGB, CMY, and CMYK images, this function returns the number of bits
// used to represent each color channel or component - almost always 8, but
// EZTwain has a limited ability to handle 16-bit per channel images.

FUNCTION Boolean DIB_IsCompressed(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Return 1(True) if image is compressed in memory 0(False) otherwise.

FUNCTION Long DIB_Compression(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Return the TWCP_xxx code representing the compression algorithm
// of this image.  Uncompressed images yield TWCP_NONE.



FUNCTION Long DIB_Size(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Return the size in memory of the given DIB.

SUBROUTINE DIB_ReadData(Long hdib, ref String pdata, Long nbMax) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ReadData;ansi"
// Read up to nbMax bytes from the given DIB into the given buffer.
// The data is read 'verbatim' from the first byte of the DIB.
// To read pixel data, see DIB_ReadRowxxx below.

SUBROUTINE DIB_ReadRow(Long hdib, Long r, ref String prow) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ReadRow;ansi"
SUBROUTINE DIB_ReadRowRGB(Long hdib, Long r, ref String prow) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ReadRowRGB;ansi"
SUBROUTINE DIB_ReadRowGray(Long hdib, Long r, ref String prow) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ReadRowGray;ansi"
SUBROUTINE DIB_ReadRowChannel(Long hdib, Long r, ref String prow, Long nChannel) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ReadRowChannel;ansi"
SUBROUTINE DIB_ReadRowSample(Long hdib, Long r, ref String prow, Long nSample) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ReadRowSample;ansi"
// Read row r of the given DIB into buffer at prow.
// Caller is responsible for ensuring buffer is large enough.
// ReadRowRGB always reads 3 bytes (24 bits) for each pixel,
// ReadRowGray and ReadRowChannel always read 1 byte (8 bits) per pixel.
// Row 0 is the *top* row of the image, as it would be displayed.
// The first variant reads the data exactly as-is from the DIB, including
// BGR pixels from 24-bit DIBs, 16-bit grayscale, 1-bit B&W, etc.
// The RGB variant unpacks every DIB pixel into 3-byte RGB pixels.
// The Gray variant converts every pixel to its 8-bit gray value.
// Channel codes are: 0=Gray(Luminance), 1=Red, 2=Green, 3=Blue.  See
// 'Component codes' below.
// Samples are the bytes of the pixel: A grayscale pixel has sample 0,
// an RGB image has samples 0, 1 and 2 (which are actually Green, Red and Blue).

SUBROUTINE DIB_ReadPixelRGB(Long hdib, Long x, Long y, ref String buffer) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ReadPixelRGB;ansi"
SUBROUTINE DIB_ReadPixelGray(Long hdib, Long x, Long y, ref String buffer) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ReadPixelGray;ansi"
SUBROUTINE DIB_ReadPixelChannel(Long hdib, Long x, Long y, ref String buffer, Long nChannel) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ReadPixelChannel;ansi"
// Read the value of the pixel at column x row y of the DIB into the buffer.
// RGB form reads 3 bytes R,G,B
// Gray form reads 1 byte of 'equivalent gray'
// Channel form reads 1 byte of channel/component, see COMPONENT_xxx codes.


SUBROUTINE DIB_WriteRow(Long hdib, Long r, String pdata) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_WriteRow;ansi"
// Write data from buffer into row r of the given DIB.
// Caller is responsible for ensuring buffer and row exist, etc.

SUBROUTINE DIB_WriteRowChannel(Long hdib, Long r, String pdata, Long nChannel) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_WriteRowChannel;ansi"
// Write data from buffer into one color channel of row r of the given DIB.
// This function should only be used on 24-bit RGB, 32-bit RGBA, 24-bit CMY,
// 32-bit CMYK, or 8-bit grayscale images.  Its behavior on any other image is undefined.
// Channels are: 0=gray, 1=Red, 2=Green, 3=Blue, 4=Alpha or
// 1=C, 2=M, 3=Y, 4=K.

SUBROUTINE DIB_WriteRowSample(Long hdib, Long r, String psrc, Long nSample) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_WriteRowSample;ansi"
// Write row of data into one sample of an image.
// Only handles 8-bit data and images with 1 or more samples of 8 bits each.
// Channels are somewhat logical properties of an image, samples are
// just the bytes in a pixel - sample 0 is byte 0, sample 1 is byte 1, etc.

// Safe versions of ReadRow and WriteRow, handy for .NET languages
SUBROUTINE DIB_WriteRowSafe(Long hdib, Long r, String pdata, Long nbMax) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_WriteRowSafe;ansi"
SUBROUTINE DIB_ReadRowSafe(Long hdib, Long nRow, ref String prow, Long nbMax) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ReadRowSafe;ansi"

FUNCTION Long DIB_Allocate(Long nDepth, Long nWidth, Long nHeight) &
   LIBRARY "Eztwain4.dll"
// Create a DIB with the given dimensions.  Resolution is set to 0.  A default
// color table is provided if depth <= 8.
// The image data is uninitialized i.e. garbage.

FUNCTION Long DIB_Create(Long nPixelType, Long nWidth, Long nHeight, Long nDepth) &
   LIBRARY "Eztwain4.dll"
// Create a DIB of the given pixel type and dimensions.
// If nDepth <= 0, uses the default depth for the given pixel type.
// Resolution is set to 0.
// For TWPT_GRAY images, a standard black-to-white color table is set.
// For TWPT_PALETTE images, a Windows-standard 256-entry color table is set.

SUBROUTINE DIB_Free(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Release the storage of the DIB.

SUBROUTINE DIB_FreeArray(ref Long ahdib, Long n) &
   LIBRARY "Eztwain4.dll"
// Release storage for n DIBs in array.

//  under consideration for EZTwain 3.4 or 4.0
//void EZTAPI DIB_FreeAll(void);
//// Free all DIB handles created by EZTwain but not yet freed.
//// This is convenient at the end of a complex scanning function, if
//// you are not keeping any DIB images in memory: Call this
//// function and it cleans everything up.  This way you do not have to
//// individually free each DIB as soon as you are done with it.
//

FUNCTION Long DIB_InUseCount() &
   LIBRARY "Eztwain4.dll"
// Return the number of DIBs 'outstanding' - allocated but not disposed of.
// Note that a DIB that is put on the clipboard becomes the property of the
// clipboard and is considered 'disposed of'.
// This function can be used to detect leaks in application DIB management.

FUNCTION Long DIB_Copy(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Create and return a byte-for-byte copy of a DIB.

FUNCTION Boolean DIB_Equal(Long hdib1, Long hdib2) &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) if the two dibs are valid, have the same parameters,
// and are the same color pixel-for-pixel.

FUNCTION Boolean DIB_AlmostEqual(Long hdib1, Long hdib2, Long nMaxErr) &
   LIBRARY "Eztwain4.dll"
// Return TRUE(1) if the two dibs are valid, have the same parameters,
// and the difference in corresponding sample values never exceeds nMaxErr.
// Used to compare two images that can differ in the low bits of their pixel values,
// such as an image before and after JPEG compression.

FUNCTION Long DIB_MaxError(Long hdib1, Long hdib2) &
   LIBRARY "Eztwain4.dll"
// return the largest difference between two samples in the two images.

SUBROUTINE DIB_SetGrayColorTable(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Fill the DIB's color table with a gray ramp - so color 0 is black, and
// the last color (largest pixel value) is white.  No effect if depth > 8.
SUBROUTINE DIB_SetColorTableRGB(Long hdib, Long i, Long R, Long G, Long B) &
   LIBRARY "Eztwain4.dll"
// Set the ith entry in the DIB's color table to the specified color.
// R G and B range from 0 to 255.

FUNCTION Boolean DIB_IsVanilla(Long hdib) &
   LIBRARY "Eztwain4.dll"
// TRUE if in this DIB, pixel value 0 means 'white'.
FUNCTION Boolean DIB_IsChocolate(Long hdib) &
   LIBRARY "Eztwain4.dll"
// TRUE if in this DIB, pixel value 0 means 'black'.

FUNCTION Long DIB_ColorTableR(Long hdib, Long i) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long DIB_ColorTableG(Long hdib, Long i) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long DIB_ColorTableB(Long hdib, Long i) &
   LIBRARY "Eztwain4.dll"
// Return the R,G, or B component of the ith color table entry of a DIB.
// If i < 0 or >= DIB_ColorCount(hdib), returns 0.

SUBROUTINE DIB_FlipVertical(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Flip (mirror) the bitmap vertically.
// Top and bottom rows are exchanged, etc.

SUBROUTINE DIB_FlipHorizontal(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Flip (mirror) the bitmap horizontally.
// Leftmost pixels become rightmost, etc.

SUBROUTINE DIB_Rotate180(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Rotate image 180 degrees

FUNCTION Long DIB_Rotate90(Long hOld, Long nSteps) &
   LIBRARY "Eztwain4.dll"
// Return a copy of hOld rotated clockwise nSteps * 90 degrees.
// If nSteps is 0, the result is a copy of hOld.
// Negative values of nSteps rotate counterclockwise.
// Note that *hOld is not destroyed*

FUNCTION Boolean DIB_InPlaceRotate90(Long hdib, Long nSteps) &
   LIBRARY "Eztwain4.dll"
// like DIB_Rotate90, but modifies the hdib.

SUBROUTINE DIB_Fill(Long hdib, Long R, Long G, Long B) &
   LIBRARY "Eztwain4.dll"
// Fill the DIB with the specified color

SUBROUTINE DIB_FillRectWithColor(Long hdib, Long x, Long y, Long w, Long h, Long R, Long G, Long B) &
   LIBRARY "Eztwain4.dll"
// Fill the specified rectangle in the image with the specified color.
// As usual, x,y,w,h are in pixels, x and y are relative to the top-left corner, and R,G,B are 0..255

SUBROUTINE DIB_FillRectWithColorAlpha(Long hdib, Long x, Long y, Long w, Long h, Long R, Long G, Long B, Long A) &
   LIBRARY "Eztwain4.dll"
// Fill the specified rectangle in the image with the specified color using transparency=A
// A = 0  is transparent (so the fill has no effect)
// A = 255 is opaque, 

SUBROUTINE DIB_Negate(Long hdib) &
   LIBRARY "Eztwain4.dll"

SUBROUTINE DIB_AdjustBC(Long hdib, Long nB, Long nC) &
   LIBRARY "Eztwain4.dll"
// *** BETA - new in 3.08b8 - use with caution.
// Adjust the brightness and/or contrast of the image.
// nB and nC are -1000 to 1000, with a value of 0 meaning 'no change'.
// Positive nB push all pixels toward white, negative toward black.
// Positive nC push all pixels away from mid-value, toward black and white.
// Negative nC pushes all pixels toward the mid-value.
// Works on grayscale, RGB, CMY(K) images - no effect on B&W and palette.

SUBROUTINE DIB_ApplyToneMap8(Long hdib, String map) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_ApplyToneMap8;ansi"
// Apply an 8-bit tone map to an image.
// For each pixel in hdib, calculate the 8-bit intensity (luminance) value of
// the pixel. Then replace the pixel's value with the nearest value
// whose intensity is map[v].

FUNCTION Boolean DIB_AutoContrast(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Automatically adjust the values in the image to make
// the dominant light color into white, and the primary dark tone into black.

SUBROUTINE DIB_Convolve(Long hdibDst, Long hdibKernel, Double dNorm, Long nOffset) &
   LIBRARY "Eztwain4.dll"
// Apply hdibKernel as a convolution kernel to hdibDst.
// At each pixel in hdibDst, hdibKernel is convolved with the neighborhood
// and the result is stored back into hdibDst.
// The point value of the convolution is normalized by dividing by dNorm, and
// then nOffset is added, before clipping to the pixel range of hdibDst.

SUBROUTINE DIB_Correlate(Long hdibDst, Long hdibKernel) &
   LIBRARY "Eztwain4.dll"
// Similar to DIB_Convolve, but performs a correlation between hdibDst and hdibKernel,
// assuming that hdibKernel is image data (preferably grayscale), and putting
// the result into hdibDst.

SUBROUTINE DIB_CrossCorrelate(Long hdibDst, Long hdibTemplate, Double dScale, Long nMin) &
   LIBRARY "Eztwain4.dll"
// Similar to DIB_Convolve, but performs a cross-correlation between hdibDst and hdibTemplate,
// assuming that hdibTemplate is grayscale image data, and putting
// the result into hdibDst.  In the output, a value of 255 signifies perfect correlation,
// 0 signifies perfect non-correlation (actually, a perfect opposite).
// All output values are divided by dScale.
// If nMin > 0, the correlation at each output pixel stops as soon as the value at that
// pixel is known to be <= nMin.  If you know that the values of interest are (say) > 200,
// setting a dMin of 128 can speed up the correlation greatly.

SUBROUTINE DIB_HorizontalDifference(Long hdib) &
   LIBRARY "Eztwain4.dll"

SUBROUTINE DIB_HorizontalCorrelation(Long hdib) &
   LIBRARY "Eztwain4.dll"
SUBROUTINE DIB_VerticalCorrelation(Long hdib) &
   LIBRARY "Eztwain4.dll"

SUBROUTINE DIB_MedianFilter(Long hdib, Long W, Long H, Long nStyle) &
   LIBRARY "Eztwain4.dll"
// Apply a median filter to hdib using an W x H neighborhood.
// nStyle is currently ignored, but should be 0 for future compatibility.

SUBROUTINE DIB_MeanFilter(Long hdib, Long W, Long H) &
   LIBRARY "Eztwain4.dll"
// Replace each pixel with the average of a W x H pixel neighborhood.
// We recommend you use odd value for W and H.

SUBROUTINE DIB_Smooth(Long hdib, Double sigma, Double opacity) &
   LIBRARY "Eztwain4.dll"
// Apply a (gaussian) smoothing filter to the image.
// sigma is the controlling parameter of the Gaussian
// G(x,y) = exp(-(x^2+y^2) / 2*sigma^2) / (2 * pi * sigma^2)
// opacity is the fraction of the filter output that is blended
// back into the image i.e. out = in*(1-opacity) + f(in)*opacity

FUNCTION Long DIB_Sobel(Long hdib, Long mode, Long Thresh) &
   LIBRARY "Eztwain4.dll"
// Return the Sobel-edge filtered image.
// mode:
//CONSTANT Long SOBEL_HORIZONTAL = 0
//CONSTANT Long SOBEL_VERTICAL = 1
//CONSTANT Long SOBEL_SUM = 2
//CONSTANT Long SOBEL_MAX = 3

FUNCTION Long DIB_ScaledCopy(Long hOld, Long w, Long h) &
   LIBRARY "Eztwain4.dll"
// Create and return a new image - which is a copy of hOld
// but scaled (resampled) to have width w and height h.
// The input image must be of type TWPT_BW, TWPT_GRAY, or TWPT_RGB.
// If the input image is of type TWPT_BW, the returned image will be
// 8-bit grayscale.
// Otherwise the output image has the same type and depth as the input.
// *Don't forget to DIB_Free the old DIB when you are done with it.

FUNCTION Boolean DIB_Resize(Long hdib, Long w, Long h) &
   LIBRARY "Eztwain4.dll"
// Scale image to new pixel dimensions.
// The resolution (DPI) values are not changed.
// Returns TRUE(1) if successful, FALSE(0) otherwise.

FUNCTION Long DIB_ScaleToGray(Long hdibOld, Long nRatio) &
   LIBRARY "Eztwain4.dll"
// Create and return a new DIB containing the hdibOld image
// converted to grayscale and reduced in width & height by nRatio.
// Works well on B&W images.

FUNCTION Long DIB_Thumbnail(Long hdibSource, Long MaxWidth, Long MaxHeight) &
   LIBRARY "Eztwain4.dll"
// Return a DIB containing a copy of hdibSource, scaled so that its width
// is no more than MaxWidth, and height is no more than MaxHeight.
// B&W images are converted to grayscale thumbnails.
// Remember to DIB_Free hdibSource and the thumbnail, when you are done with them.

FUNCTION Long DIB_Resample(Long hOld, Double xdpi, Double ydpi) &
   LIBRARY "Eztwain4.dll"
// Return a new image which is a copy of the old image, but resampled
// to the specified resolution.
// "Resampling" is the technical term for recomputing the pixels of
// an image, when you want to change the number of pixels in the image
// but not the physical size (like 8.5" x 11").
// If you resample from 300DPI to 100DPI, you will have 1/3 as many rows,
// 1/3 as many columns, 1/9 as many pixels - but the pixels will be
// marked in the image as being 3 times as 'wide' and 'tall' - so the
// physical size of the image stays the same.
// This is the same as DIB_ScaledCopy, just looked at in a different way.
// DIB_Resample will fail if the input image as either resolution <= 0,
// or if either xdpi or ydpi is <= 0.  It can also fail with insufficient memory.
// Remember to DIB_Free the old DIB when you are done with it.

FUNCTION Long DIB_RegionCopy(Long hOld, Long leftx, Long topy, Long w, Long h, Long FillByte) &
   LIBRARY "Eztwain4.dll"
// Create and return a portion of DIB hOld.  The copied region is a rectangle
// w pixels wide, h pixels high, starting at (x, y) in the hOld image,
// where (0,0) is the upper-left corner of hOld, visually.
// Pixels that don't fit into the new DIB are discarded.
// (So this function can be used to crop an image.)
// If the new DIB is taller or wider than the old, the new
// pixels are filled with bytes = fill.  Common values for
// fill are:
//                                -1 (or 255 or 0xFF) which fills with 1's producing white
//   0 which produces black fill.

FUNCTION Long DIB_AutoCrop(Long hOld, Long nOpts) &
   LIBRARY "Eztwain4.dll"
// Return a copy of its image argument, cropped to the 'actual document'
// within that image, if that can be determined by software.
// Uses RegionCopy (above).
// After this call, remember to DIB_Free(hOld) if you don't need it.

//CONSTANT Long AUTOCROP_DARK = 1
//CONSTANT Long AUTOCROP_LIGHT = 2
//CONSTANT Long AUTOCROP_EDGE = 4
//CONSTANT Long AUTOCROP_CHECK = 8
//CONSTANT Long AUTOCROP_CHECK_BACK = 16

// note, we recommend not combining AUTOCROP_CHECK with DARK, LIGHT, or EDGE options.

FUNCTION Boolean DIB_GetCropRect(Long hdib, Long nOptions, ref Long cropx, ref Long cropy, ref Long cropw, ref Long croph) &
   LIBRARY "Eztwain4.dll"
// Return a suggested crop rectangle to remove a dark border from the image.
// The rectangle is defined by an upper-left point and a width and height, in pixels.
// (As needed by DIB_RegionCopy above.)
// nOptions is currently unused and must be 0.
// DIB_AutoCrop uses this function to decide what to crop.
// A return of FALSE means no crop rectangle was found - generally this means
// that the image has content that extends to the edges, or has no definite borders
// of dark color.  For convenience, when this function returns FALSE it
// still returns a valid crop rectangle containing the entire image.

FUNCTION Long DIB_AutoDeskew(Long hOld, Long nOptions) &
   LIBRARY "Eztwain4.dll"
// Returns a copy of the image in hOld, possibly 'deskewed'.
// If it can be determined that the input image is consistently
// skewed (rotated by a small angle) then the returned image is rotated
// to eliminate that skew.
// The depth and pixel type of the image are not changed.
// The dimensions of the returned image may be slightly changed.
// nOptions is currently unused and must be 0 (zero).

FUNCTION Double DIB_DeskewAngle(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Compute and return the small clockwise rotation that would best
// 'deskew' the given image.  The return value is that angle
// in radians.  Only rotations in the range +-4 degrees are considered.

SUBROUTINE DIB_SkewByDegrees(Long hdib, Double dAngle) &
   LIBRARY "Eztwain4.dll"
// Skew the given image clockwise in place by the specified angle (in degrees)

FUNCTION Long DIB_ConvertToPixelType(Long hOld, Long nPT) &
   LIBRARY "Eztwain4.dll"
// Create and return a new DIB containing the hOld image converted
// to the specified pixel type.  Supported pixel types are:
// TWPT_BW, TWPT_GRAY, TWPT_RGB, TWPT_PALETTE, TWPT_CMY or TWPT_CMYK.
// When converting to black & white (TWPT_BW) the default conversion
// is simple thresholding - each pixel is converted to grayscale,
// then values 0..127 => Black, 128..255 => White.

FUNCTION Long DIB_ConvertToFormat(Long hOld, Long nPT, Long nBPP) &
   LIBRARY "Eztwain4.dll"
// Create and return a new DIB containing the hOld image converted
// to the specified pixel type and bits per pixel.
// Unsupported and impossible combinations cause a NULL return.

FUNCTION Long DIB_SmartThreshold(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Apply automatic, adaptive thresholding to hdib, return
// the resulting 1-bit image.  This function is optimized for
// thresholding scanned text.
// ** Remember to free the input image if you are done with it.

FUNCTION Long DIB_SimpleThreshold(Long hdib, Long nT) &
   LIBRARY "Eztwain4.dll"
// Threshold hdib against nT and return the resulting 1-bit image.
// nT should be in the range 0 to 255.
// Pixels that are darker than nT become black in the output,
// pixels that are equal to or lighter than nT become white.
// ** Remember to free the input image if you are done with it.

FUNCTION Long DIB_SetConversionThreshold(Long nT) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long DIB_ConversionThreshold() &
   LIBRARY "Eztwain4.dll"
// Set/Get the threshold used by DIB_ConvertToPixelType above
// when converting to B&W.  The default value is 128 which means '50%'.
// Pixels lighter than 50% => white, darker => black.
// DIB_SetConversionThreshold returns the previous value of the threshold.

FUNCTION Long DIB_FindAdaptiveGlobalThreshold(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Find the adaptive threshold for input image

FUNCTION Long DIB_ErrorDiffuse(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Create and return a new DIB containing the input image rendered
// to 1-bit B&W using error diffusion. The input image is not modified.

SUBROUTINE DIB_SetConversionColorCount(Long n) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long DIB_ConversionColorCount() &
   LIBRARY "Eztwain4.dll"
// Set/Get the number of colors that will be used in the next
// call to DIB_ConvertToPixelType or DIB_ConvertToFormat, if
// the output type is TWPT_PALETTE.

SUBROUTINE DIB_SwapRedBlue(Long hdib) &
   LIBRARY "Eztwain4.dll"
// For 24-bit DIB only, exchange R and B components of each pixel.

FUNCTION Long DIB_CreatePalette(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Create and return a logical palette to be used for drawing the DIB.
// For 1, 4, and 8-bit DIBs the palette contains the DIB color table.
// For 24-bit DIBs, a default halftone palette is returned.

SUBROUTINE DIB_SetColorModel(Long hdib, Long nCM) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long DIB_ColorModel(Long hdib) &
   LIBRARY "Eztwain4.dll"
//CONSTANT Long EZT_CM_RGB = 0
//CONSTANT Long EZT_CM_GRAY = 3
//CONSTANT Long EZT_CM_CMYK = 5

SUBROUTINE DIB_SetColorCount(Long hdib, Long n) &
   LIBRARY "Eztwain4.dll"

SUBROUTINE DIB_Blt(Long hdibDst, Long dx, Long dy, Long hdibSrc, Long sx, Long sy, Long w, Long h, Long uRop) &
   LIBRARY "Eztwain4.dll"
// Transfer pixels from hdibSrc into hdibDst, starting at
// (dx,dy) in the destination, and (sx,sy) in the source,
// and transferring w columns x h rows.
// Any pixels that fall outside the actual bounds of the source
// and destination DIBs are ignored.
// The operations available are:
//CONSTANT Long EZT_ROP_COPY = 0
//CONSTANT Long EZT_ROP_OR = 1
//CONSTANT Long EZT_ROP_AND = 2
//CONSTANT Long EZT_ROP_XOR = 3
//CONSTANT Long EZT_ROP_ANDNOT = 18

SUBROUTINE DIB_BltMask(Long hdibDst, Long dx, Long dy, Long hdibSrc, Long sx, Long sy, Long w, Long h, Long uRop, Long hdibMask) &
   LIBRARY "Eztwain4.dll"
// Like DIB_Blt, but hdibMask contains an 8-bit alpha mask that controls
// how hdibSrc and hdibDst pixels are blended.  hdibMask must be the
// same size as hdibSrc, and be 8-bits deep.
// NOTE: The only uRop currently supported is EZT_ROP_COPY

SUBROUTINE DIB_PaintMask(Long hdibDst, Long dx, Long dy, Long R, Long G, Long B, Long sx, Long sy, Long w, Long h, Long uRop, Long hdibMask) &
   LIBRARY "Eztwain4.dll"
// Like DIB_BltMask - but paints a solid color into the destination DIB
// using hdibMask as a mask or stencil.  The mask must be an 8-bit
// grayscale image. The each mask pixel controls how much paint is mixed
// into the corresponding destination pixel: white=100%, black=0%.
// if w == -1 or h == -1 it means "as much as possible"
// NOTE: The only uRop currently supported is EZT_ROP_COPY
// See the User Guide for details.

SUBROUTINE DIB_DrawLine(Long hdibDst, Long x1, Long y1, Long x2, Long y2, Long R, Long G, Long B) &
   LIBRARY "Eztwain4.dll"

// Draw the text string into the DIB inside the given rectangle.
// If w or h is 0, the rectangle is extended to the bottom or right of the DIB.
// Defaults:
//   Color: black (R=G=B=0)
//   BackgroundColor: 0,0,0,0 (100% transparent black)
//   Angle: 0
//   Height: 14 px
//   Face: "Arial"
//   Format: EZT_TEXT_NORMAL | EZT_TEXT_TOP | EZT_TEXT_LEFT
// See the following functions to override the default text settings.
SUBROUTINE DIB_DrawText(Long hdibDst, String sText, Long leftx, Long topy, Long w, Long h) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_DrawText;ansi"

// The following functions modify the default settings for DIB_DrawText:

// reset all text drawing parameters to default values
SUBROUTINE DIB_ResetTextDrawing() &
   LIBRARY "Eztwain4.dll"

// set the text drawing color using R G B values
SUBROUTINE DIB_SetTextColor(Long R, Long G, Long B) &
   LIBRARY "Eztwain4.dll"

// return the current text color as a 32-bit COLORREF (0x00BBGGRR)
FUNCTION Long DIB_TextColor() &
   LIBRARY "Eztwain4.dll"

// returns the current text color as R,G,B values to its three parameters.
SUBROUTINE DIB_GetTextColor(ref Long pR, ref Long pG, ref Long pB) &
   LIBRARY "Eztwain4.dll"

// Set the rotation of text within the drawing rectangle,
// in degrees clockwise from horizontal.
// NOTE: Currently only multiples of 90 degrees are supported.
SUBROUTINE DIB_SetTextAngle(Long nDegrees) &
   LIBRARY "Eztwain4.dll"

// Set the text character height in pixels.
// If you want to set the text height in physical units (inches)
// multiply the physical height in inches by the DIB_YResolution.
// Note! Some files have resolution=0, which can often be treated as 72dpi
SUBROUTINE DIB_SetTextHeight(Long nH) &
   LIBRARY "Eztwain4.dll"

// Specify a typeface - Use a typeface that is available on the host system,
// or use a standard face such as Arial, MS San Serif, MS Serif.
// You can also specify "Courier" or "Times" as shortcuts for the classic
// fixed-width and serif fonts.
// Passing NULL or the empty string resets to the default face ("Arial")
SUBROUTINE DIB_SetTextFace(String sTypeface) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_SetTextFace;ansi"

SUBROUTINE DIB_SetTextFormat(Long nFlags) &
   LIBRARY "Eztwain4.dll"
// Sets text format according to the following flags.  The default
// format is normal, top, left
//CONSTANT Long EZT_TEXT_NORMAL = 0
//CONSTANT Long EZT_TEXT_BOLD = 1
//CONSTANT Long EZT_TEXT_ITALIC = 2
//CONSTANT Long EZT_TEXT_UNDERLINE = 4
//CONSTANT Long EZT_TEXT_STRIKEOUT = 8
//CONSTANT Long EZT_TEXT_BOTTOM = 256
//CONSTANT Long EZT_TEXT_VCENTER = 512
//CONSTANT Long EZT_TEXT_TOP = 0
//CONSTANT Long EZT_TEXT_LEFT = 0
//CONSTANT Long EZT_TEXT_CENTER = 4096
//CONSTANT Long EZT_TEXT_RIGHT = 8192
//CONSTANT Long EZT_TEXT_WRAP = 16384
//CONSTANT Long EZT_TEXT_JUSTIFY = 2048

SUBROUTINE DIB_SetTextBackgroundColor(Long R, Long G, Long B, Long A) &
   LIBRARY "Eztwain4.dll"
// Set the text background color, including transparency (alpha).
// RGB are color components, 0..255
// A is the alpha channel, from 0=100% transparent to 255=100% opaque.

///////////////////////////////////////////////////////////////////////
// Image viewing services

FUNCTION Long DIB_View(Long hdib, String sTitle, Long hwndParent) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_View;ansi"
// Display the given image in a window with the given title.
// hwndParent is the window handle of the parent window - if you
// use 0 (NULL) for this parameter, EZTwain uses the active window
// of the application if there is one, or no parent window.
// By default, the window contains just an [OK] button.
// The style of the window is a resizable dialog box.
// 0    = the [Cancel] button was pressed.
// 1    = the [OK] button was pressed.

FUNCTION Boolean DIB_SetViewOption(String sOption, String sValue) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_SetViewOption;ansi"
// Same as TWAIN_SetViewOption.

FUNCTION Boolean DIB_SetViewImage(Long hdib) &
   LIBRARY "Eztwain4.dll"
// If the image viewer is open, change the displayed image to this one.

FUNCTION Boolean DIB_IsViewOpen() &
   LIBRARY "Eztwain4.dll"
// Return True if the image-view window is open, False otherwise.
// Note that the image viewer can be hidden, so it could be open
// and not be visible.

FUNCTION Boolean DIB_ViewClose() &
   LIBRARY "Eztwain4.dll"
// Close the image viewer window, if it is open.
// Only applies if the image viewer has been opened with the modeless option.
// Same as TWAIN_ViewClose.

SUBROUTINE DIB_DrawOnWindow(Long hdib, Long hwnd) &
   LIBRARY "Eztwain4.dll"
// Draw the DIB on the window.
// The image is scaled to just fit inside the window, while
// keeping the correct aspect ratio.  Any part of the window
// not covered by the image is left untouched (so it will normally
// be filled with the window's background color.)

SUBROUTINE DIB_DrawToDC(Long hdib, Long hDC, Long dx, Long dy, Long w, Long h, Long sx, Long sy) &
   LIBRARY "Eztwain4.dll"
// Draws DIB on a device context.
// You should call CreateDibPalette, select that palette
// into the DC, and do a RealizePalette(hDC) first.

///////////////////////////////////////////////////////////////////////
// Printing services

FUNCTION Boolean DIB_SpecifyPrinter(String sPrinterName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_SpecifyPrinter;ansi"
// Specify the printer to be used when printing to the 'default printer'
// with the following functions.
// This does not change the user's default printer - it just tells
// EZTwain which printer to use as 'default'.
// Setting the printer name to NULL or the empty string tells EZTwain to
// use the user's default printer as its default printer.

FUNCTION Long DIB_EnumeratePrinters() &
   LIBRARY "Eztwain4.dll"
// Return the number of available printers

FUNCTION String DIB_PrinterName(Long i) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_PrinterName;ansi"
// Return the name of the ith available printer, as found
// by a previous call to DIB_EnumeratePrinters.

FUNCTION Boolean DIB_GetPrinterName(Long i, ref String PrinterName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_GetPrinterName;ansi"
// Get the name of the ith available printer, as found by a previous
// call to DIB_EnumeratePrinters.
// You must allocate 256 characters for the printer name, and in many
// languages (especially Basic dialects) you must initialize the
// PrinterName variable with 256 spaces.

SUBROUTINE DIB_SetPrintToFit(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean DIB_GetPrintToFit() &
   LIBRARY "Eztwain4.dll"
// Get/Set the 'Print To Fit' flag.
// When this flag is non-zero, EZTwain reduces the size of images
// to fit within the printer page.  This only affects images that
// are too large to fit on the page.
// By default, this flag is FALSE (0)

FUNCTION Long DIB_Print(Long hdib, String sJobname) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_Print;ansi"
// Prompt the user with a Print Dialog, then print the DIB.
// Normally prints the DIB at 'actual size' - meaning the resolution
// values are used to convert the width and height from pixels to physical
// units (e.g. inches.)
// If the PrintToFit flag (see DIB_SetPrintToFit) is set and the image
// is larger than the printer page, the image is scaled to fit on the page.
// If the DIB has resolution values of 0, 72 DPI is assumed.
// The image is printed centered on the page.
// Return values:
//   0  success, no error
//  -2  specified printer not recognized or could not be opened
//  -3  invalid DIB handle (null, or DIB has been freed, or isn't a DIB handle)
//  -4  could not start document or start page error during printing
// -10  user cancelled a dialog (probably the Print dialog)

FUNCTION Long DIB_PrintNoPrompt(Long hdib, String sJobname) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_PrintNoPrompt;ansi"
// Identical to DIB_Print, but prints on the default printer with
// default settings - the user is not prompted.


FUNCTION Long TWAIN_PrintFile(String sFilename, String sJobname, Boolean bNoPrompt) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_PrintFile;ansi"
FUNCTION Long DIB_PrintFile(String sFilename, String sJobname, Boolean bNoPrompt) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_PrintFile;ansi"
// Print the specified file as a print job with the specified job name.
// If the filename is null or empty, the user is prompted to select a file.
// If the jobname is null or empty, the actual filename is used as the jobname.
// If bNoPrompt is non-zero (True) the job is sent to the default printer,
// If bNoPrompt is zero (False) the user is prompted with the standard Print dialog.

// Printing - Multi-Page
//

FUNCTION Long DIB_PrintArray(ref Long ahdib, Long nCount, String sJobname, Boolean bNoPrompt) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_PrintArray;ansi"
// Print the first nCount images in the array ahdib, under the given print-job name.
//
// If the job-name parameter is NULL or the empty string, the application title is used.
// If bNoPrompt is TRUE(non-zero), prints to the default printer without prompting the user,
// If bNoPrompt is FALSE(0) this function displays the standard print dialog.
//
// Return value is same as DIB_Print above.

SUBROUTINE DIB_SetNextPrintJobPageCount(Long nPages) &
   LIBRARY "Eztwain4.dll"
// If you are about to call DIB_PrintJobBegin, you can call this function
// *before* calling that one, to set the page count for the next print job.
// This allows the print dialog to enable the page-range controls, so the
// user can designate a range of pages to print.
//
// Do not call this function unless you are calling DIB_PrintJobBegin directly.
//
// A page count of 0 or less means 'unknown page count', which disables
// the page-range controls.
// If you enable print-range selection in the print dialog, EZTwain
// automatically suppresses printing of all non-selected pages.

FUNCTION Long DIB_PrintJobBegin(String sJobname, Boolean bUseDefaultPrinter) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_PrintJobBegin;ansi"
// Begin creating a multi-page print job.
//
// Jobname is the name of the print job.
// The jobname appears in the job-queue of the printer.
// In some environments it also appears on a job-separator
// page that is printed out ahead of each job.
// If Jobname is null or empty, the application title is used.
// (See TWAIN_SetAppTitle)
//
// If bUseDefaultPrinter is true (non-zero) the default printer
// is used, otherwise the user is prompted with a standard Print dialog.
//
// If you have called DIB_SetNextPrintJobPageCount (above) then the print
// dialog will offer the user the option of specifying a range of pages
// to print.  Otherwise that option is disabled and all pages are printed.
//
// If there is already a print job open when this function is called,
// it calls DIB_PrintJobEnd() to close that job before starting the new one.
//
// Return values:
//  0       success
// -2       could not open/access printer
// -4       printing output error
//-10       user cancelled Print dialog

FUNCTION Long DIB_PrintPage(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Add a page to the current print job.
//
// Only valid after a successful call to DIB_PrintJobBegin and
// before the matching DIB_PrintJobEnd.
//
// See DIB_Print for more details.
//  0       success
// -3       the DIB is null or invalid
// -4       printing output error
// -5       no print job is open

FUNCTION Long DIB_PrintJobEnd() &
   LIBRARY "Eztwain4.dll"
// End the current print job and release it for printing.
// (Some environments will start printing as soon as a page is available.)
//  0       success
// -4       printing output error
// -5       no print job is open

///////////////////////////////////////////////////////////////////////
// Clipboard functions
//
FUNCTION Boolean DIB_PutOnClipboard(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Place DIB on the clipboard (format CF_DIB)
// ** IMPORTANT ** After this call, the clipboard owns the
// DIB and you do not - do not attempt any
// further operations on the hdib handle.
// Treat this call just as you would a call to DIB_Free.
// Returns TRUE(1) for success, FALSE(0) otherwise.

FUNCTION Boolean DIB_CanGetFromClipboard() &
   LIBRARY "Eztwain4.dll"
// Return TRUE(1) if there is something on the clipboard that
// can be delivered as a DIB (by DIB_GetFromClipboard below.)
// Return FALSE(0) if not.

FUNCTION Long DIB_GetFromClipboard() &
   LIBRARY "Eztwain4.dll"
FUNCTION Long DIB_FromClipboard() &
   LIBRARY "Eztwain4.dll"
// Create and return a DIB with the contents of the clipboard.
// This is the first step of a 'paste' function for images.
// Returns NULL in case of error, or if no image on clipboard.

// Working with a DIB through a DC
//
FUNCTION Long DIB_OpenInDC(Long hdib, Long hdc) &
   LIBRARY "Eztwain4.dll"
SUBROUTINE DIB_CloseInDC(Long hdib, Long hdc) &
   LIBRARY "Eztwain4.dll"

// DIB File I/O
//
FUNCTION Long DIB_WriteToFilename(Long hdib, String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_WriteToFilename;ansi"
// Write image to file, using format implied by the filename extension.
//
// If the filename is NULL or points to a null string, the user is
// prompted for the filename and format with a standard Windows
// file-save dialog.
//
// If the final filename has a standard extension (.bmp, .jpg, .jpeg, .tif,
// .tiff, .png, .pdf, .gif, .dcx) then the file is saved in that format.
// Otherwise, the current SaveFormat is used - see TWAIN_SetSaveFormat.
//
// Return values:
//                                 0                                success
//                                -1                                user cancelled File Save dialog
//                                -2                                file open error (invalid path or name, or access denied)
//                                -3                                a) image is invalid (null or invalid DIB handle)
//      b) support for the save format is not configured
//      c) DIB format incompatible with save format e.g. B&W to JPEG.
//                                -4                                writing data failed, possibly output device is full
//  -5  other unspecified internal error

// Note: a return value of -3 indicates an invalid hdib handle, or
// 'no support for this format'.  -3 is also returned when attempting
// to write a Jpeg file from an image that is not 24-bit color or
// 8-bit grayscale.  1-bit B&W images cannot be saved as JPEG.
// 24-bit color images are 'quantized' to 8-bit color when written to GIF.
// All image types are converted to 1-bit B&W when written to DCX.
// Other internal errors will return -5, including insufficient memory.
// Check TWAIN_LastErrorCode for more details (maybe)

FUNCTION Long DIB_LoadFromFilename(String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_LoadFromFilename;ansi"
// Load an image from a file and return its handle.
// The file can be in any format supported by EZTwain Pro.
// If the file is multipage, normally this function loads page 0,
// but a preceding call to DIB_SelectPageToLoad changes that.
// A return of NULL(0) indicates failure, see TWAIN_LastErrorCode
// and related functions for more details.
// If the filename is an empty string (or NULL) the user is prompted
// with a standard file-open dialog.
// EZTwain should read any variant of its supported formats,
// except for PDF: We only claim to support reading images
// from PDFs if they were created by EZTwain Pro.

FUNCTION Long DIB_FormatOfFile(String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_FormatOfFile;ansi"
// Returns the EZT_FF_ code for the format of the specified file.
// A return < 0 indicates 'unrecognized format' or some error
// when opening or reading the file.

SUBROUTINE DIB_SelectPageToLoad(Long nPage) &
   LIBRARY "Eztwain4.dll"
// For use when loading multipage files.  Tells DIB_LoadFromFilename
// and DIB_LoadFromBuffer which page to load next, from a multipage file.
// Default is page 0 (first page in file).
// This value is reset to 0 after any call that tries to load a page.

FUNCTION Long DIB_GetFilePageCount(String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_GetFilePageCount;ansi"
FUNCTION Long DIB_FilePageCount(String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_FilePageCount;ansi"
// Return the number of pages in the specified file.
// If the file is a recognized multipage format
// (TIFF, PDF, DCX), the pages in the file are counted.
// All other recognized formats return a page count of 1.
// If the file cannot be opened, read, recognized, etc.
// this function records an error and returns -1.

FUNCTION Long DIB_LoadPage(String sFileName, Long nPage) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_LoadPage;ansi"
// Short for DIB_SelectPageToLoad, DIB_LoadFromFilename.
// Load the specified page from the specified file.
// Page 0 is the first page in a file.  Multiple
// pages are only supported in TIFF, PDF and DCX files, all other file
// formats have a single page, page 0

FUNCTION Long DIB_LoadArrayFromFilename(ref Long ahdib, Long nMax, String sFilename) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_LoadArrayFromFilename;ansi"
// Load up to nMax images as DIBs into an array, reading from the specified file.
// If filename is null or the empty string, the user is prompted to select a file.
//
// If the user is prompted and cancels, this function returns -10.
// Otherwise if successful it returns the number of pages (images) loaded.
// Otherwise it returns -1 and you should call TWAIN_ReportLastError, TWAIN_LastErrorCode,etc.
//
// If this function returns < 0, the first nMax entries of the DIB array will be NULL (0).
// If returns N >= 0, the first N entries of the DIB array will
// contain handles to DIBs representing the first N images in the file.
// The remaining nMax-N entries in the DIB array will be NULL (0).
//
// Make sure you eventually call DIB_Free on all the loaded DIBs!

FUNCTION Long DIB_LoadPagesFromFilename(ref Long ahdib, Long index0, Long nMax, String sFilename) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_LoadPagesFromFilename;ansi"
// Load up to nMax images from a specified file (or URL), starting at page index0.
// Remember pages are indexed from 0.
// Returns the number of images loaded - which can be 0 if there are no images
// in the file within the specified range.
// Returns -1 in case of error, call TWAIN_LastErrorCode & co. for more details.

FUNCTION Long DIB_FormatOfBuffer(String pBuffer, Long nBytes) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_FormatOfBuffer;ansi"
// Assuming the buffer contains something like an image file, return
// the format implied by the leading bytes.
// nBytes = number of bytes of data in buffer.

FUNCTION Long DIB_PageCountOfBuffer(String pBuffer, Long nBytes) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_PageCountOfBuffer;ansi"
FUNCTION Long DIB_BufferPageCount(String pBuffer, Long nBytes) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_BufferPageCount;ansi"
// Assuming the buffer contains something like an image file, return
// the number of pages (images technically) in it.
// nBytes = number of bytes of data in buffer.

FUNCTION Long DIB_LoadFromBuffer(String pBuffer, Long nBytes) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_LoadFromBuffer;ansi"
// Load an image from a buffer, presumably formatted like an image file.
// If DIB_SelectPageToLoad was called just before, the
// designated page is loaded from the buffer.
// nBytes = number of bytes of data in buffer.

FUNCTION Long DIB_LoadPageFromBuffer(String pBuffer, Long nBytes, Long nPage) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_LoadPageFromBuffer;ansi"
// Load the specified page from a buffer - the buffer must contain an image
// file.  If the image format is one that can hold only one image, the page
// number is ignored.
// nBytes = number of bytes of data in buffer.

FUNCTION Long DIB_LoadArrayFromBuffer(ref Long ahdib, Long nMax, String pBuffer, Long nBytes) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_LoadArrayFromBuffer;ansi"
// Load up to nMax images as DIBs into an array, reading from a file in memory.
// pBuffer is the address of the buffer (memory block) holding the file to read.
// nBytes is the number of bytes of data in the buffer.
//
// Returns the number of images loaded if successful, otherwise
// it returns -1 and you should call TWAIN_ReportLastError, TWAIN_LastErrorCode, or similar.
//
// Make sure you eventually call DIB_Free on all the loaded DIBs.

FUNCTION Long DIB_LoadFaxData(Long hdib, String pBuffer, Long nBytes, Long nFlags) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_LoadFaxData;ansi"
// Load a DIB's contents from a buffer of CCITT fax-encoded data.
// pBuffer is the address of the buffer in memory.
// nBytes is the number of bytes of data in the buffer.
// nFlags are decoding options:
// Override with flags:
//CONSTANT Long FAX_GROUP3_2D = 32
//CONSTANT Long FAX_GROUP4 = 64
//CONSTANT Long FAX_BYTE_ALIGNED = 128
//CONSTANT Long FAX_REQUIRE_EOLS = 256
//CONSTANT Long FAX_EXPECT_EOB = 512
//CONSTANT Long FAX_VANILLA = 1024
// default is Group3 1D, chocolate, not byte-aligned, EOLs not required, EOB not expected.


FUNCTION Long DIB_WriteToBuffer(Long hdib, Long nFormat, ref String pBuffer, Long nbMax) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_WriteToBuffer;ansi"
// Write the image into the buffer in the format, not more than nbMax bytes.
// The return value is the actual size of the image - this may be more or less
// than nbMax.  If the return value > nbMax, it means only part of the image
// was written, and the buffer needs to be bigger.
// If pBuffer is NULL, no data is written - the function just returns the required
// buffer size in bytes.
// A return value of <= 0 indicates an error, such as
//   The image is invalid (null or invalid DIB handle)
//   The format is unrecognized, not supported, not installed, etc.
//   You can't save that image in that format e.g. B&W image to JPEG format.
//   Insufficient memory for temporary data structures (or corrupted heap)
//   Other internal failure.
// You can call TWAIN_LastErrorCode and similar functions for more details.

FUNCTION Long DIB_WriteArrayToBuffer(ref Long ahdib, Long n, Long nFormat, ref String pBuffer, Long nbMax) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_WriteArrayToBuffer;ansi"
// A combination of DIB_WriteArrayToFilename and DIB_WriteToBuffer.
// Writes n images to a memory buffer in the specified format.
// See DIB_WriteToBuffer above for the meaning of pBuffer and nbMax.
// Return value: See DIB_WriteToBuffer above.



FUNCTION Long DIB_ToDibSection(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Converts the given DIB into a kind of bitmap called a DibSection.
// *** IMPORTANT: The input DIB is consumed and becomes invalid ***
// A DibSection is a special kind of HBITMAP.  Many languages
// and imaging classes (such as GDI+, .NET Image, Delphi TBitmap) do
// not easily accept DIBs but readily accept a DibSection/HBITMAP.

FUNCTION Long DIB_FromBitmap(Long hbm, Long hdc) &
   LIBRARY "Eztwain4.dll"
// Create a DIB with the contents of a GDI bitmap (preferably a DibSection).
// >> The input bitmap is NOT deleted - the returned DIB is a copy.
// If hdc = 0 (NULL) a default HDC is used.
// See also: DIB_ToDibSection

FUNCTION Boolean DIB_IsBlank(Long hdib, Double dDarkness) &
   LIBRARY "Eztwain4.dll"
// Return TRUE(1) if the DIB has less than dDarkness fraction of 'dark' pixels.
// Return FALSE(0) otherwise.
// A typical value of dDarkness would be 0.02 which means 2% dark pixels.
// A page with less than 2% dark pixels is probably blank.

FUNCTION Double DIB_Darkness(Long hdibFull) &
   LIBRARY "Eztwain4.dll"
// Returns the fraction of an image that consists of 'dark' pixels.
// These are pixels that would be black, if the image was converted
// to B&W using a smart thresholding.  See DIB_SmartThreshold.
// Used by DIB_IsBlank to decide if an image is blank.
// A return of 0.0 means none, 1.0 means all.  A typical office
// document is 0.02 (2%) to 0.32 (32%) dark pixels.

SUBROUTINE DIB_GetHistogram(Long hdib, Long nComponent, ref Long histo) &
   LIBRARY "Eztwain4.dll"
// Count the number of occurences of each value of the specified component
// in the given DIB (see component codes below).  Put the counts
// of each value (0..255) into the histo array.
// The histo array *must* be an array of 256 32-bit integers.
// Only works on B&W, grayscale, palette, and 24-bit RGB images.
// Example: If hdib contains 237 pixels with a grayscale value of 17, then
// this call will return histo[17] = 237.  Components are normalized
// into the range 0..255.
// Note: If hdib is a 1-bit B&W image, then histo will be all 0's, except
// for hist[0] (black) and hist[255] (white).
//
// Component codes:
//CONSTANT Long COMPONENT_GRAY = 0
//CONSTANT Long COMPONENT_RED = 1
//CONSTANT Long COMPONENT_GREEN = 2
//CONSTANT Long COMPONENT_BLUE = 3
//CONSTANT Long COMPONENT_LUMINANCE = 0
//CONSTANT Long COMPONENT_SAT = 4
//CONSTANT Long COMPONENT_HUE = 5

// For gray and B&W images, R, G, and B components are equal, and Hue and Sat are 0.


FUNCTION Long DIB_ComponentCopy(Long hdib, Long nComponent) &
   LIBRARY "Eztwain4.dll"
// Extract and return one component (channel) of the given image.
// The returned image is an 8-bit grayscale image containing the
// specified channel of the input image, with the same width,
// height, and DPI.
// 
// Note: In future this function may return a 16-bit deep image
// when given a 16 bit/channel input image.

FUNCTION Double DIB_Avg(Long hdib, Long nComp) &
   LIBRARY "Eztwain4.dll"
FUNCTION Double DIB_AvgRegion(Long hdib, Long nComp, Long leftx, Long topy, Long w, Long h) &
   LIBRARY "Eztwain4.dll"
FUNCTION Double DIB_AvgRow(Long hdib, Long nComp, Long rowy) &
   LIBRARY "Eztwain4.dll"
FUNCTION Double DIB_AvgColumn(Long hdib, Long nComp, Long colx) &
   LIBRARY "Eztwain4.dll"
// Average the values of pixels in an image, region, row or column.
// Note that row 0 is the visually top-most row of an image.
// Averages either intensity (brightness) or individual color channels,
// or saturation.
// See component codes above, for DIB_GetHistogram.
// Regardless of image format, white = 255.0 and black = 0, even
// for 1-bit B&W or 16-bit grayscale or color images.
// DOES NOT SUPPORT: 4-bit/pixel images, CMY(K) images.

FUNCTION Long DIB_GetBrightRects(Long hdib, Long w, Long h, Long t, ref Long xBlob, ref Long yBlob, ref Long wBlob, ref Long hBlob, Long nMax) &
   LIBRARY "Eztwain4.dll"
// Search the image for rectangular areas that are unusually bright.
//
// Return value: Number of rectangles found and returned.  Always <= nMax.
//
// Input parameters:
// w,h   are the minimum rectangle width & height, in pixels
// t     minimum average intensity value to be considered 'bright'
// nMax  maximum number of rectangles to return.
//
// Output parameters:
// xBlob array of long (32-bit int) values, receives x-coordinates of found rectangles
// yBlob ditto, for y-coordinates
// wBlob ditto, for widths of rectangles
// hBlob ditto, for heights of rectangles


FUNCTION Long DIB_ProjectRows(Long hdib, Long nComp) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long DIB_ProjectColumns(Long hdib, Long leftx, Long topy, Long w, Long h, Long nComp) &
   LIBRARY "Eztwain4.dll"
// These functions create and return a 1 row x N column image, containing
// the average value of the rows (columns) of the input image, in the
// specified channel (component).
// If the source image is <= 8-bit/sample, the result image is 8-bit/sample.
// If the source image is 16 bit/sample, so is the result image.

FUNCTION Long DIB_Posterize(Long hdib, Long nLevels) &
   LIBRARY "Eztwain4.dll"


//--- EXPERIMENTAL: The following functions may be removed or changed at any time.
FUNCTION Long DIB_ForwardDCT(Long hdib) &
   LIBRARY "Eztwain4.dll"

//--------- Documents
//
// The following functions provide an abstraction of a Document,
// represented by an opaque handle called an HDOC.
//
// A document is a sequence of 0 or more images. Documents can represent
// image files, or be entirely in memory, or a combination. They can be
// loaded, edited, saved, printed, and so on.
//.
// Images can be added to, deleted from, or re-ordered within a document.
// Individual images can be operated on using any of our DIB functions.
//
// Documents are modelled as containers for images, represented by DIBs.
// So for example, adding a DIB to a document does not copy the DIB, it
// places that actual image/DIB in the document.
//
// EZTwain keeps track of which DIBs are in which documents: If a DIB is
// 'freed' its destruction is deferred until no document contains it.

FUNCTION Long DOC_CreateEmpty() &
   LIBRARY "Eztwain4.dll"
// Create an empty document and return its handle.
// It has no associated file, 0 pages, and is marked unmodified.

SUBROUTINE DOC_Destroy(Long hdoc) &
   LIBRARY "Eztwain4.dll"
// Close and destroy the document object.
// Closes any associated open file.
// Does not save changes! Use DOC_Save or related functions.

FUNCTION Long DOC_ImageCount(Long hdoc) &
   LIBRARY "Eztwain4.dll"
// Return the number of images in the document.

FUNCTION Boolean DOC_IsModified(Long hdoc) &
   LIBRARY "Eztwain4.dll"
// Return TRUE if the document or any image in the document has been
// modified since the last operation that cleared the Modified flag.

SUBROUTINE DOC_SetModified(Long hdoc, Boolean bIsMod) &
   LIBRARY "Eztwain4.dll"

FUNCTION String DOC_Filename(Long hdoc) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DOC_Filename;ansi"
// Return (a pointer to) the filename associated with this document.
// If there is no associated file, returns the empty string ("")

FUNCTION Boolean DOC_SetCurPos(Long hdoc, Long i) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long DOC_CurPos(Long hdoc) &
   LIBRARY "Eztwain4.dll"
// Set/return the current position within the document.
// Intended as a way to designate an 'active' or selected page.
// The value of this property is normally >= 0 and < ImageCount, but
// can be -1 which conventionally means 'undefined' or 'no current position'.
// Operations that add, move, or remove pages may change the
// current position, see the descriptions of specific functions
// for details.

FUNCTION Long DOC_OpenReadOnly(String sFilename) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DOC_OpenReadOnly;ansi"
// Open an image file for read-only access.
//
// If the filename is NULL or the empty string, the user is prompted
// to select a file in a supported format.

// Returns NULL (0) if the file does not exist or cannot be opened.
//
// This function opens the designated file for shared read-only access,
// the file cannot be opened for writing as long as this document
// has it open.
//
// Important: The returned document can be freely modified, the
// modifications will not (and cannot) be saved back to the file.

FUNCTION Long DOC_OpenForUpdate(String sFilename) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DOC_OpenForUpdate;ansi"
// Open an image file for reading & modification.
// The designated file is opened for read/write with exclusive access:
// the file cannot be opened for reading *or* writing by anybody else.
// Changes are not written back to the file until DOC_Save is called.

SUBROUTINE DOC_Reset(Long hdoc) &
   LIBRARY "Eztwain4.dll"
// Reset the document to empty, unmodified, no associated file.

FUNCTION Boolean DOC_WriteToFile(Long hdoc, String filename) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DOC_WriteToFile;ansi"
// Write the contents of the document to the designated file.
// If the filename is NULL or the empty string, the user is prompted
// for the file (and folder) to write to.
// Does *not* clear the modified flag or associate filename with this document.
// Returns TRUE(1) if successful, FALSE(0) otherwise.

FUNCTION Boolean DOC_Save(Long hdoc) &
   LIBRARY "Eztwain4.dll"
// Save the contents of the document to the associated file.
// If no associated file, does a DOC_SaveAs.
// Clears the modified flag if successful.
// Returns TRUE(1) if successful, FALSE(0) otherwise.

FUNCTION Boolean DOC_SaveAs(Long hdoc, String filename) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DOC_SaveAs;ansi"

FUNCTION Long DOC_Image(Long hdoc, Long i) &
   LIBRARY "Eztwain4.dll"
// Return the image at position i (0..N-1) where N=ImageCount.
// If hdoc is not valid or there is no image i (or image i cannot be read)
// then this function returns NULL.

FUNCTION Boolean DOC_SetImage(Long hdoc, Long i, Long hdib) &
   LIBRARY "Eztwain4.dll"
// Set the image at position i.
// The image is *not* copied - it becomes part of the document.
// hdoc must be a valid document
// i must be >= 0 and < ImageCount(hdoc)
// hdib must be a valid DIB handle.
// Otherwise this function fails and returns FALSE(0).

FUNCTION Boolean DOC_AppendImage(Long hdoc, Long hdib) &
   LIBRARY "Eztwain4.dll"
// Such a common case of insertion it gets its own function.

FUNCTION Long DOC_ExtractImages(Long hdoc, Long i, Long n) &
   LIBRARY "Eztwain4.dll"
// Using the n images starting at position i in this document,
// create a new document containing *copies* of those images, in order.
// If there are less than n images at position i, uses as
// many as there are.
// The new document has no associated file and is marked unmodified(?)

FUNCTION Boolean DOC_DeleteImage(Long hdoc, Long i) &
   LIBRARY "Eztwain4.dll"
// Delete the ith image in the document.
// If this document is the only document containing that image, the
// image is freed/destroyed.
// Fails if there is no image at position i.
// Returns TRUE(1) if successful, FALSE(0) otherwise.

FUNCTION Boolean DOC_DeleteImages(Long hdoc, Long i, Long n) &
   LIBRARY "Eztwain4.dll"
// delete n images starting with image i in the document.
// If there are fewer than n images starting at position i, deletes
// as many as there are.

FUNCTION Boolean DOC_InsertImage(Long hdoc, Long i, Long hdib) &
   LIBRARY "Eztwain4.dll"
// Insert the image at position i in the document.
// The image is *not* copied, it becomes part of the document.
// position 0 is the first image in the document.
// position -1 is interpreted as 'at the end'.

FUNCTION Boolean DOC_InsertImageArray(Long hdoc, Long i, ref Long ahdib, Long n) &
   LIBRARY "Eztwain4.dll"
// insert n images from array ahdib at position i

FUNCTION Boolean DOC_MoveImage(Long hdoc, Long iOld, Long iNew) &
   LIBRARY "Eztwain4.dll"
// Move the image at position iOld in the document to position iNew.
// 

//--------- File Read/Write

//---- EZTwain File Format Codes
//CONSTANT Long EZT_FF_TIFF = 0
//CONSTANT Long EZT_FF_BMP = 2
//CONSTANT Long EZT_FF_JFIF = 4
//CONSTANT Long EZT_FF_PNG = 7
//CONSTANT Long EZT_FF_PDFA = 15
//CONSTANT Long EZT_FF_DCX = 97
//CONSTANT Long EZT_FF_GIF = 98
//CONSTANT Long EZT_FF_PDF = 99

// GIF and DCX support is only provided by EZTwain.
// Note: BMP support is built into EZTwain, so is always available.

SUBROUTINE TWAIN_SetFileAppendFlag(Boolean bAppend) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_GetFileAppendFlag() &
   LIBRARY "Eztwain4.dll"
// Set or get the File Append Flag.
// When this flag is non-zero and EZTwain writes to an existing TIFF, PDF or DCX
// file, the new images are *appended* to the existing file.
// When this flag is False (0), writing to any existing file replaces the file.
//
// The default state of this flag is: False (0).
//
// Note: Only TIFF, PDF, and DCX formats are affected.
// This applies to all functions that write images, primarily:
//  TWAIN_AcquireToFilename, TWAIN_AcquireMultipageFile,
//  DIB_WriteToFilename, TWAIN_BeginMultipageFile, etc.

FUNCTION Boolean TWAIN_IsJpegAvailable() &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) if JPEG/JFIF image files can be read and written.
// Returns 0 if JPEG support has not been installed.

FUNCTION Boolean TWAIN_IsPngAvailable() &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) if PNG format support is available.

FUNCTION Boolean TWAIN_IsTiffAvailable() &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) if TIFF format support is available.

FUNCTION Boolean TWAIN_IsPdfAvailable() &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) if PDF format support is available.

FUNCTION Boolean TWAIN_IsGifAvailable() &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) if GIF format support is available.

FUNCTION Boolean TWAIN_IsDcxAvailable() &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) if DCX format support is available.
// Note that DCX files can only hold 1-bit
// B&W images - EZTwain converts the image data as needed.

FUNCTION Boolean TWAIN_IsFormatAvailable(Long nFF) &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) if the specified file format support
// is available for writing and possibly reading files.
// A format is considered available if EZTwain can load
// the necessary DLLs.  See the 

FUNCTION Long TWAIN_FormatVersion(Long nFF) &
   LIBRARY "Eztwain4.dll"
// Return the format module version * 100.

FUNCTION Boolean TWAIN_IsFileExtensionAvailable(String sExt) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_IsFileExtensionAvailable;ansi"
// Return TRUE (1) if the file format corresponding to the given
// file extension ("TIF", ".gif", "jpeg", etc.) is available.
// Case does not matter, leading '.' is optional.

FUNCTION Long TWAIN_FormatFromExtension(String sExt, Long nFF) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_FormatFromExtension;ansi"
// Return the file-format code (see File Formats above) for
// the given extension.  If pzExt is unrecognized, returns nFF.
// Case does not matter, leading '.' is optional.

FUNCTION String TWAIN_ExtensionFromFormat(Long nFF, String sDefExt) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_ExtensionFromFormat;ansi"
// Return the default extension associated with a file format.(See File Formats above.)
// Note: The leading '.' is included e.g. ".bmp", ".tif", etc.
// If nFF is not a valid value, returns its second parameter.

SUBROUTINE TWAIN_GetExtensionFromFormat(Long nFF, String sDefExt, ref String szExtension) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetExtensionFromFormat;ansi"
// Return the default extension for the given file-format code, in the 3rd parameter.
// The caller is responsible for allocating a string of at least 5 characters for the 3rd parameter.
// If the file format is not recognized, returns the value of the 2nd parameter.

FUNCTION Boolean TWAIN_SetSaveFormat(Long nFF) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetSaveFormat() &
   LIBRARY "Eztwain4.dll"
// Select the default file format for DIB_WriteToFilename
// and similar functions to use, when they do not
// recognize the file extension.
// Displays a warning message if the format is not available.
// Returns TRUE (1) if ok, FALSE (0) if format is invalid or not available.
// See list of file formats above.  Some formats are not supported
// by some versions of EZTWAIN, or require external DLLs be installed.

SUBROUTINE TWAIN_SetJpegQuality(Long nQ) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetJpegQuality() &
   LIBRARY "Eztwain4.dll"
// Set the 'quality' of subsequently saved JPEG/JFIF image files.
// nQ = 100 is maximum quality & minimum compression.
// nQ = 75 is 'good' quality, the default.
// nQ = 1 is minimum quality & maximum compression.

//- Special TIFF options ------------------------------------------

SUBROUTINE TWAIN_SetTiffStripSize(Long nBytes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetTiffStripSize() &
   LIBRARY "Eztwain4.dll"
// Set/Get the size of the 'strips' that TIFF files are divided into.
// Some (bogus) TIFF readers cannot handle multiple strips, to make
// them happy set the strip size to -1.
// Default value = 32768 (subject to change, in theory.)

FUNCTION Boolean TWAIN_SetTiffImageDescription(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetTiffImageDescription;ansi"
FUNCTION Boolean TWAIN_SetTiffDocumentName(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetTiffDocumentName;ansi"
// Set the TIFF ImageDescription or DocumentName tags for output.
// These values apply only to the next TIFF file written, and are cleared
// once the file is closed.

FUNCTION Boolean TWAIN_SetTiffCompression(Long nPT, Long nComp) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetTiffCompression(Long nPT) &
   LIBRARY "Eztwain4.dll"
// Set/Get the compression mode to use when writing TIFF files.
// Set returns TRUE (1) if successful, FALSE (0) otherwise.
// nPT specifies the Pixel Type - See the TWPT_* constants.
// Different compressions apply to different pixel types - see below.
// Using nPT=-1 means 'for all applicable pixel types.'
// nComp specifies the compression, here are the codes:
//CONSTANT Long TIFF_COMP_NONE = 1
//CONSTANT Long TIFF_COMP_CCITTRLE = 2
//CONSTANT Long TIFF_COMP_CCITTFAX3 = 3
//CONSTANT Long TIFF_COMP_CCITTFAX4 = 4
//CONSTANT Long TIFF_COMP_LZW = 5
//CONSTANT Long TIFF_COMP_JPEG = 7
//CONSTANT Long TIFF_COMP_PACKBITS = 32773

// Default for BW is TIFF_COMP_CCITTFAX4
// Default for all other pixel types is TIFF_COMP_NONE.

// Setting TIFF tags explicitly, including custom/private tags:
FUNCTION Boolean TWAIN_SetTiffTagShort(Long nTagId, Integer sValue) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetTiffTagLong(Long nTagId, Long nValue) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetTiffTagString(Long nTagId, String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetTiffTagString;ansi"
FUNCTION Boolean TWAIN_SetTiffTagDouble(Long nTagId, Double dValue) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetTiffTagRational(Long nTagId, Double dValue) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetTiffTagRationalArray(Long nTagId, ref Double dValues, Long n) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetTiffTagBytes(Long nTagId, String pdata, Long nBytes) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetTiffTagBytes;ansi"
FUNCTION Boolean TWAIN_SetTiffTagUndefined(Long nTagId, String pdata, Long nBytes) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetTiffTagUndefined;ansi"
// Note: It works to use SetTiffTagDouble to set standard TIFF tags that are of
// type RATIONAL, but we recommend using SetTiffTagRational.

SUBROUTINE TWAIN_ResetTiffTags() &
   LIBRARY "Eztwain4.dll"
// The functions above allow specific TIFF tags to be set.
// Whatever value(s) you set will be used in *each image written to TIFF*
// until you call TWAIN_ResetTiffTags.
// Note that integer values are appropriately converted to 16- or 32-bit
// signed or unsigned as needed by the specific tag.

FUNCTION Boolean TWAIN_GetTiffTagAscii(String sFilename, Long nPage, Long nTag, Long nLen, ref String buffer) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetTiffTagAscii;ansi"
// Read the value of the specified tag from the given page of the given TIFF file,
// copying the string into buffer, which has room for len characters.
// Returns True(1) if successful, False(0) otherwise.

FUNCTION String TWAIN_TiffTagAscii(String sFilename, Long nPage, Long nTag) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_TiffTagAscii;ansi"
// Return the value of the specified tag from the given page of the given TIFF file,
// as a human-readable string.
// Numeric values are converted to decimal numeric representation.
// In case of failure, it returns the empty string.
// In case of error, call TWAIN_ReportLastError to display details,
// or call TWAIN_LastErrorCode and related functions.

//- PDF Specific ------------------------------------------


FUNCTION Boolean PDF_IsOneOfOurs(String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_IsOneOfOurs;ansi"
// Returns TRUE(1) if the specified PDF file was probably written by the
// EZTwain PDF module.

FUNCTION String PDF_DocumentProperty(String sFilename, String sProperty) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_DocumentProperty;ansi"
// From the given PDF file, extract the designated document property's string value,
// and return (a pointer to an internal buffer holding) that value.
// See also PDF_GetDocumentProperty below.
//
// Legal values for the Property parameter are:
//   "Title", "Author", "Subject", "Keywords", "Creator" and "Producer".
// Case matters, so use these exact strings.
//
// If the file cannot be opened and parsed as a PDF file, or if the specified property
// cannot be found and read, this function returns the empty string, and
// records an error: See TWAIN_ReportLastError and related functions.

FUNCTION Long PDF_GetDocumentProperty(String sFilename, String sProperty, ref String buffer, Long buflen) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_GetDocumentProperty;ansi"
// Same as PDF_DocumentProperty, except:
// The property value is obtained as a string and its length is calculated with strlen.
// The return value of this function is the 'strlen' of the string value found in the file -
// independent of the value of buflen.

// These functions configure or add information to the next output PDF file:
FUNCTION Boolean TWAIN_SetPdfTitle(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetPdfTitle;ansi"
FUNCTION Boolean TWAIN_SetPdfAuthor(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetPdfAuthor;ansi"
FUNCTION Boolean TWAIN_SetPdfSubject(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetPdfSubject;ansi"
FUNCTION Boolean TWAIN_SetPdfKeywords(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetPdfKeywords;ansi"
FUNCTION Boolean TWAIN_SetPdfCreator(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetPdfCreator;ansi"

// Alternate forms of TWAIN_SetPdfTitle & co:
FUNCTION Boolean PDF_SetTitle(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_SetTitle;ansi"
FUNCTION Boolean PDF_SetAuthor(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_SetAuthor;ansi"
FUNCTION Boolean PDF_SetSubject(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_SetSubject;ansi"
FUNCTION Boolean PDF_SetKeywords(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_SetKeywords;ansi"
FUNCTION Boolean PDF_SetCreator(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_SetCreator;ansi"

FUNCTION Boolean PDF_SetCompression(Long nPT, Long nComp) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long PDF_GetCompression(Long nPT) &
   LIBRARY "Eztwain4.dll"
// Select the compression algorithm to use for images with the given pixel format.
// See the TWPT_* constants for the various pixel formats.
// Note that a pixel format of -1 means 'all applicable formats'.
// Available values of nComp are:
//CONSTANT Long COMPRESSION_DEFAULT = -1
//CONSTANT Long COMPRESSION_NONE = 1
//CONSTANT Long COMPRESSION_FLATE = 5
//CONSTANT Long COMPRESSION_JPEG = 7

FUNCTION Boolean PDF_SelectPageSize(Long nPaper) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long PDF_SelectedPageSize() &
   LIBRARY "Eztwain4.dll"
// Set/Get the standard page-size for subsequent PDF output pages.
// The values are PAPER_ values defined elsewhere
// in this file, search for PAPER_A4 etc.
// EZTwain initializes this to PAPER_NONE (0).
// With PAPER_NONE selected, EZTwain writes each output image into a
// page the same size as the image.  Setting a page size tells
// EZTwain to center each output image within a page of the
// specified size, shrinking larger images to fit.
// Calling PDF_SelectPageSize(PAPER_NONE) clears the page-size
// back to the default i.e. 'no specific size'.

FUNCTION Boolean PDF_SetPDFACompliance(Long nLevel) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long PDF_GetPDFACompliance() &
   LIBRARY "Eztwain4.dll"
// Set/Get the PDF/A Compliance level.
// Level 0 is 'no particular compliance'. (*default*)
// Level 1 is PDF/A-1(b) - the PDF/A Part 1 level suitable for
// scanned documents.
// No other nLevel values are accepted at this time.
// When PDFA compliance is set to 1, PDF output is made to comply with
// ISO 19005-1 PDF/A-1.  For the most part this is invisible, but certain
// PDF settings and operations become illegal, and there are optional
// function calls that make your PDF's "more" PDF/A compliant.

FUNCTION Boolean PDF_SetAutoSearchable(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean PDF_GetAutoSearchable() &
   LIBRARY "Eztwain4.dll"
// Set/Get the global option to write searchable PDFs using OCR.
// When this option is set, each page written to PDF is automatically
// fed to currently selected OCR engine and the resulting text is
// included in the PDF to make it searchable.
//
// If this implicit OCR fails for any reason, the function that requested
// it will fail.  Use TWAIN_LastErrorCode and related functions to diagnose
// and report such errors.
//
// This option is 'smart' - if other options or function calls write
// searchable text for a page, the process is not needlessly repeated.

//-- Passwords and encryption of PDF files ------------------------
//

FUNCTION Boolean PDF_IsEncrypted(String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_IsEncrypted;ansi"
// Returns TRUE(1) if the specified PDF file is encrypted.

SUBROUTINE PDF_SetOpenPassword(String sPassword) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_SetOpenPassword;ansi"
// Set the password to be used to open subsequent PDF files.
// This password is used until reset to the empty string.
//
// Once you set a non-null OpenPassword, the user will not be prompted
// for a password when an encrypted PDF is opened for reading:
// If the OpenPassword is valid for the file, the file will be
// silently opened and decrypted.
// If the OpenPassword is not valid for the file, the function that
// is trying to read the file will fail. In this case,
// the code returned by TWAIN_LastErrorCode is EZTEC_PDF_PASSWORD

// To suppress PDF password prompting by EZTwain, set the OpenPassword
// to some extremely unlikely password string, such as " " or "1".

SUBROUTINE PDF_SetUserPassword(String sPassword) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_SetUserPassword;ansi"
// Define a user password for the next/current output PDF file.
// This turns on encryption for the file.
// When a PDF file is completed and closed, this user password is cleared.

SUBROUTINE PDF_SetOwnerPassword(String sPassword) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_SetOwnerPassword;ansi"
// Define an owner password for the next/current output PDF file.
// This turns on encryption for the file.
// When a PDF file is completed and closed, this owner password is cleared.

SUBROUTINE PDF_SetPermissions(Long nPermission) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long PDF_GetPermissions() &
   LIBRARY "Eztwain4.dll"
// Set or Get the permissions mask to be written into the next/current
// output PDF file. This mask specifies operations to be allowed or
// prevented on the file - see the PDF_PERMIT constants.
//
// Important Notes
//
// * Permissions are only written if you set a User or Owner password.
// * Acrobat honors these restrictions, but other PDF readers may not.
// * Any permissions you set only apply to the next PDF file you write.
// * The default permissions mask is 'allow everything' (-1)
// * Setting permissions=0 means 'prevent everything'
//
// You can use bitwise operations, or +/- to combine these constants.
// For example, to disallow copying text and graphics from the file:
//    PDF_SetPermissions(PDF_PERMIT_ALL - PDF_PERMIT_COPY)
//
//      named constant                                                                                value                             if restricted, Acrobat will prevent:
//CONSTANT Long PDF_PERMIT_PRINT = 4
//CONSTANT Long PDF_PERMIT_MODIFY = 8
//CONSTANT Long PDF_PERMIT_COPY = 16
//CONSTANT Long PDF_PERMIT_ANNOTS = 32
// You can also use this nPermission value, by itself:
//CONSTANT Long PDF_PERMIT_ALL = -1


//-- Writing text into PDF. ------------------------
//
// The following functions apply to the next PDF file or page that is output,
// so you make them *before* you write the PDF page they apply to.

SUBROUTINE PDF_DrawText(Double leftx, Double topy, String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_DrawText;ansi"
// Draw text into the next PDF page, x pixels from the left edge
// and y pixels down from the top of the page.
// Note 1: This is not 'native' PDF coordinates, which are
// usually in points, from the lower-left corner of the page.
// Note 2: This call only makes sense if followed at some point
// by a call that writes an image to PDF.

SUBROUTINE PDF_DrawInvisibleText(Double leftx, Double topy, String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_DrawInvisibleText;ansi"
// Like PDF_DrawText, but text is drawn in invisible mode.

SUBROUTINE PDF_SetTextVisible(Boolean bVisible) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean PDF_GetTextVisible() &
   LIBRARY "Eztwain4.dll"
// Set the visibility of the text written by subsequent PDF_DrawText
// calls. A parameter of True (non-0) means make text visible, a parameter
// of False (0) means make text invisible.

SUBROUTINE PDF_SetTextSize(Double dfs) &
   LIBRARY "Eztwain4.dll"
// Set the size of the current font, for subsequent PDF_DrawText calls.
// Normally this is a traditional size in points, like 10.
SUBROUTINE PDF_SetTextHorizontalScaling(Double dhs) &
   LIBRARY "Eztwain4.dll"

FUNCTION Boolean PDF_WriteOcrText(String text, ref Long ax, ref Long ay, ref Long aw, ref Long ah, Double xdpi, Double ydpi) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "PDF_WriteOcrText;ansi"
// Write previously OCR'd text to the next PDF output page.
// ---parameters---
// text is the text, of course - as returned by OCR_Text.
// ax and ay are arrays of x,y positions of the characters in text - as returned
// by OCR_GetCharPositions.  These are pixel coordinates relative to the top-left of the page.
// aw and ah are arrays of (width,height) information as returned by OCR_GetCharSizes.
// xdpi and ydpi are the resolution values (DPI) of the source image, required to map the text
// size from pixels into PDF font sizes.  The resolution can be obtained from the image
// using DIB_XResolution and DIB_YResolution, or you can call OCR_GetResolution at the
// same time you call OCR_GetCharPositions and OCR_GetCharSizes.

//---------------------------------------------------------

FUNCTION Long TWAIN_FormatOfFile(String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_FormatOfFile;ansi"
// Return the format of the specified file.
// See the EZT_FORMAT_ codes elsewhere in this file.
// A return value < 0 means 'unrecognized format'.

FUNCTION Long TWAIN_PagesInFile(String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_PagesInFile;ansi"
// Return the number of pages in the specified file.
// For multipage formats (TIFF, PDF, DCX), the pages are counted.
// All other recognized formats return a page count of 1.
// If the file cannot be opened, read, recognized, etc.
// this function records an error and returns -1.

FUNCTION Boolean TWAIN_PromptForOpenFilename(ref String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_PromptForOpenFilename;ansi"
// Prompt the user for a file to open.
// Returns TRUE(1) if user selected a file, FALSE(0) if user cancelled.
// If it returns TRUE, the fully-qualified filepath & name is returned
// in the buffer referenced by the parameter.
// The caller is responsible for allocating (and deallocating) the
// buffer of at least 260 characters.
// The file dialog has a file-type list, which is loaded based
// on the formats that are currently supported for loading.
// The default file-type is "any supported format".

//--------- File View Dialog

FUNCTION Long TWAIN_ViewFile(String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_ViewFile;ansi"
// Display the specified file in a viewer window that allows the
// user to browse to all pages (if more than one).
// If the file name is NULL or the null string, the user is prompted
// with a standard file-open dialog, offering all the filetypes that
// EZTwain believes it can open.
// The default dialog has an OK button only.
// Return values:
//  1   [OK] button pressed (in modal dialog)
//  1   File displayed - in case of modeless dialog.
//  0   [Cancel] button pressed
// -1   user cancelled file-open prompt (if you supplied a null filename)
// -2   error displaying dialog, opening file, etc.

FUNCTION Boolean TWAIN_SetViewOption(String sOption, String sValue) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetViewOption;ansi"
// Set various options and parameters for the viewer window.
// See TWAIN_ViewFile above.
//
// option                                                                                             form                              meaning
// title                                                                                              string                            the title (caption) of the viewer window
// left                                                                                                                                 x|x%                              left(x) coordinate of window, in pixels or as a percent of screen.
// top                                                                                                                                  y|y%                              top coordinate of window
// bottom                                                                                             y|y%
// right                                                                                              x|x%
// width                                                                                              w|w%                              width of viewer window, in pixels or as a percent of screen.
// height                                                                                             h|h%
// size                                                                                                                                 w,h                                                                 width and height together, pixels or percentages
// topleft                                                                                            x,y                                                                 x and y together, pixels or percentages
// position                                                                                           x,y,w,h                           left,top,width,height - in pixels or percentages
// pos                                                                                                                                                                    same as position
// pos.remember                                                     bool                              if true, remember viewer position between showings. Default: false.
// timeout                                                                                            n                                                                   in seconds. Currently ignored.
// visible                                                                                            bool                              if viewer is open, show or hide it.  Default: true
// ok.visible                                                       bool                              if true, include an [OK] button in the viewer. Default: true.
// cancel.visible                 bool                              if true, include a [Cancel] button. Default: false
// print.visible                  bool                              if true, include a [Print] button. Default: false.
// modeless                                                                                           bool                              if true, leave viewer open until TWAIN_ViewClose. Default: false.
// modal                                                                                              bool                              opposite of modeless.
// reset                                                                                              ...                                                                 setting this option resets all options to default value.


FUNCTION Boolean TWAIN_IsViewOpen() &
   LIBRARY "Eztwain4.dll"
// Return True if the viewer window is open, False otherwise.

FUNCTION Boolean TWAIN_ViewClose() &
   LIBRARY "Eztwain4.dll"
// If the viewer window is open (as a modeless dialog), close it.
// The viewer window is normally modal, but can be made modeless
// with TWAIN_SetViewOption("modeless", "true")
// No effect if no viewer window is open.
// Returns True(1) if it closed the viewer window, False(0) otherwise.

FUNCTION Boolean TWAIN_GetLastViewPosition(ref Long pleft, ref Long ptop, ref Long pwidth, ref Long pheight) &
   LIBRARY "Eztwain4.dll"
// Return the screen coordinates, in pixels, of the last known position of the
// viewer window (the dialog displayed by TWAIN_ViewFile and DIB_View functions.)
// The four parameters are pointers to 32-bit integers or if your language
// prefers, four 32-bit integers passed by reference.
// The four returned values are the left edge, the top edge (counting down from screen top)
// the width, and the height of the View window, the last time it was closed or resized.
//
// This function can be used in conjunction with TWAIN_SetViewOption("position","x,y,w,h") to
// remember and restore the view window position.

//--------- Multipage File Output

//CONSTANT Long MULTIPAGE_TIFF = 0
//CONSTANT Long MULTIPAGE_PDF = 1
//CONSTANT Long MULTIPAGE_DCX = 2

FUNCTION Long TWAIN_SetMultipageFormat(Long nFF) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetMultipageFormat() &
   LIBRARY "Eztwain4.dll"
// Select/query the default multipage file save format.
// The default when EZTwain is loaded is MULTIPAGE_TIFF.
// Note that if you use a recognized extension in the name
// of your multipage file - such as .tif, .pdf or .dcx, then
// the file will be written in that format.  The file
// extension overrides SetMultipageFormat.
//
// SetMultipageFormat returns:
//  0 = success,
// -1 = invalid/unrecognized format
// -3 = format is currently unavailable (missing/bad DLL)

SUBROUTINE TWAIN_SetLazyWriting(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_GetLazyWriting() &
   LIBRARY "Eztwain4.dll"
// Get/Query the value of the 'LazyWriting' flag.
// NOTE: The default value of this flag is: TRUE.
// When the LazyWriting flag is set (TRUE), multipage files
// are written by a background thread, allowing your
// program to continue executing (scanning for example).
// Only when EndMultipageFile is called does the program
// wait until all the pages of the file have actually
// been written to disk.
// This also applies to AcquireMultipageFile, which internally
// uses these multipage output functions.

FUNCTION Long DIB_WriteArrayToFilename(ref Long ahdib, Long n, String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "DIB_WriteArrayToFilename;ansi"
// Write n images from array ahdib to the specified file.
// If n is 1, this is exactly equivalent to calling DIB_WriteToFilename.
// If n > 1, this is a shortcut for calling
//    TWAIN_BeginMultipageFile,
//      TWAIN_DibWritePage (for each image)
//    TWAIN_EndMultipageFile
// ...with appropriate error handling, of course.
//
// Return values:
//                                 0                                success
//                                -1                                user cancelled File Save dialog
//                                -2                                file open error (invalid path or name, or access denied)
//                                -3                                a) image is invalid (null or invalid DIB handle)
//      b) support for the save format is not available
//      c) DIB format incompatible with save format e.g. B&W to JPEG.
//                                -4                                writing data failed, possibly output device is full
//  -5  other unspecified internal error
//  -6  a multipage file is already open
//  -7  multipage support is not installed.

FUNCTION Long TWAIN_BeginMultipageFile(String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_BeginMultipageFile;ansi"
// Create an empty multipage file of the given name.
// If the filename is NULL or points to the null string, the user
// is prompted with a standard File Save dialog.
// If the filename includes an extension (.tif, .tiff, .mpt, .pdf or .dcx)
// then the corresponding format is used for the file.
// If you do not supply an extension, the default multipage format is used.

// Return values:
//                                 0                                success
//                                -1                                user cancelled File Save dialog
//                                -2                                file open error (invalid path or name, or access denied)
//  -3  file format not available
//  -5  other unspecified internal error
//  -6  multipage file already open
//  -7  Multipage support is not installed.

FUNCTION Long TWAIN_DibWritePage(Long hdib) &
   LIBRARY "Eztwain4.dll"
//   0                            success
//  -2  internal limit exceeded or insufficient memory
//  -3  File format is not available (EZxxx DLL not found)
//  -4  Write error: Output device is full?
//  -5  invalid/unrecognized file format or 'other' - internal
//  -6  multipage file not open
//  -7  Multipage support is not installed.

FUNCTION Long TWAIN_WritePageAndFree(Long hdib) &
   LIBRARY "Eztwain4.dll"
// Like TWAIN_DibWritePage followed by DIB_Free.
// The advantage is that the write can be done on a background thread
// without making a copy of the image.

FUNCTION Long TWAIN_EndMultipageFile() &
   LIBRARY "Eztwain4.dll"
//   0                            success
//  -3  File format is not available
//  -4  Write error - drive offline, or ?? (very unlikely)
//  -5  invalid/unrecognized file format or other internal error
//  -6  multipage file not open
//  -7  Multipage support is not installed.

FUNCTION Long TWAIN_MultipageCount() &
   LIBRARY "Eztwain4.dll"
// Return the number of images (scans) written to the most recently
// started multipage file.  In other words, this returns a counter
// which is reset by BeginMultipageFile, and is incremented by DibWritePage.

FUNCTION Boolean TWAIN_IsMultipageFileOpen() &
   LIBRARY "Eztwain4.dll"
// Return True if a multipage output file is open, False otherwise.
// Only one multipage output file can be open at a time (per process.)


FUNCTION String TWAIN_LastOutputFile() &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_LastOutputFile;ansi"
// Return the name of the last file written by EZTwain.
// Useful if you pass NULL or the empty string as a filename to
// DIB_WriteToFilename or TWAIN_AcquireToFilename, etc.


SUBROUTINE TWAIN_SetOutputPageCount(Long nPages) &
   LIBRARY "Eztwain4.dll"
// Tell EZTwain how many pages you are about to write to a file.
// This is OPTIONAL: The only effect is to add PageNumber tags
// to TIFF files.  You can use nPages=0, which means "I don't know".

FUNCTION Long TWAIN_FileCopy(String sInFile, String sOutFile, Long nOptions) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_FileCopy;ansi"
// Read all the images or pages from the in file and write them to the out file.
// nOptions is currently not used and should be 0.
// The formats need not be the same, in fact this function is most often
// used to convert for example from TIFF to PDF.  If you specify a single-image
// output format (BMP, GIF, PNG, JPG) the input file must have only one page.
// Return values:
//                                 0                                success
//                                -1                                user cancelled
//                                -2                                file open error (invalid path or name, or access denied)
//  -3  file format not available or inappropriate (e.g. copying 5-page TIF to JPEG)
//  -5  other unspecified internal error
//  -7  Multipage support is not installed.

//--------- Network file transfer services
//
// These functions require EZT4Curl.dll to be
// in the same folder as Eztwain4.dll

FUNCTION Boolean UPLOAD_IsAvailable() &
   LIBRARY "Eztwain4.dll"
// TRUE(1) if uploading services are available (= EZT4Curl.dll can be loaded.)
// Returns FALSE(0) otherwise.

FUNCTION Long UPLOAD_Version() &
   LIBRARY "Eztwain4.dll"
// Return the upload module version * 100.

FUNCTION Long UPLOAD_MaxFiles() &
   LIBRARY "Eztwain4.dll"
// Return the maximum number of files that can be uploaded in one UPLOAD operation.
// i.e. UPLOAD_FilesToURL, UPLOAD_DibsSeparatelyToURL.

FUNCTION Boolean UPLOAD_AddFormField(String fieldName, String fieldValue) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "UPLOAD_AddFormField;ansi"
// Set a form field to a value in the next Upload (see below).
// The name of the field must be expected by the page/script you upload to.
// All fields set with this function are discarded and forgotten after
// the next upload that uses them.
//
// For example, suppose you have been uploading scanned documents to your server
// using a web form like this:
// <form name="form1" method="post" action="http://server.com/newdoc.php" >
// <input type="hidden" name="key" value="12345678">
// <input type="text" name="vendor id">
// <input type="file" name="file">
// <input type="submit" name="submit" value="Submit">
// </form>
//
// You might automate the upload of a just-scanned image in memory (hdib)
// with vendor id = 1290331, with code similar to this:
//    UPLOAD_AddFormField("key", "12345678")
//    UPLOAD_AddFormField("vendor id", "1290331")
//    UPLOAD_DibToURL(hdib, "http://server.com/newdoc.php", "document.pdf", "file")

FUNCTION Boolean UPLOAD_AddHeader(String header) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "UPLOAD_AddHeader;ansi"
// Add a header line to the next HTTP upload.
// You should have some understanding of HTTP protocol to use this!
// Don't include any line-break characters.
// To send a cookie, use UPLOAD_AddCookie (below).

FUNCTION Boolean UPLOAD_AddCookie(String cookie) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "UPLOAD_AddCookie;ansi"
// Add a cookie line to the next HTTP upload.
// Often used to provide session id's e.g.
//    UPLOAD_AddCookie("ASP.NET_SessionID=" & strSessionID)
// or
//    UPLOAD_AddCookie("JSESSIONID=" & strSessionID)

SUBROUTINE UPLOAD_EnableProgressBar(Boolean bEnable) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean UPLOAD_IsEnabledProgressBar() &
   LIBRARY "Eztwain4.dll"
// Enable or disable the progress-bar during uploads.
// Default state is enabled (TRUE).

FUNCTION Long UPLOAD_DibToURL(Long hdib, String URL, String fileName, String fieldName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "UPLOAD_DibToURL;ansi"
FUNCTION Long UPLOAD_DibsToURL(ref Long ahdib, Long n, String URL, String fileName, String fieldName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "UPLOAD_DibsToURL;ansi"
FUNCTION Long UPLOAD_DibsSeparatelyToURL(ref Long ahdib, Long n, String URL, String fileName, String fieldName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "UPLOAD_DibsSeparatelyToURL;ansi"
FUNCTION Long UPLOAD_FilesToURL(String files, String URL, String fieldName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "UPLOAD_FilesToURL;ansi"
// Upload an image, set of images, or some files on disk, to a script on a server,
// AS IF a form was being submitted via HTTP-POST, with a field or fields of type 'file'.
//
// Important Note - This confuses some people, don't let it happen to you!
// Only UPLOAD_FilesToURL looks for actual disk files and uploads them.
// All the other UPLOAD functions upload image data, *pretending* it is from a file - no such
// file is read, used, or created on the client machine.
//
// UPLOAD_DibsSeparatelyToURL uploads each image as a separate file, appending '1', '2', etc.
// to both the filename and the fieldname.  So if you upload n images with fileName="page.jpg"
// and fieldName="file", it will upload files as "file1"="page1.jpg", "file2=page2.jpg", etc.
//
// Similarly, UPLOAD_FilesToURL uploads multiple files, appending the counter to the fieldName.
// If you specify a fieldName of "file", UPLOAD_FilesToURL will use "file1", "file2", etc.
// Note that this applies even if you upload just one file.
//
// hdib      = handle to image to upload.
// ahdib     = address or reference to array of hdibs (image handles).
// n         = number of images in array ahdib.
// fileName  = name of (imaginary) file being uploaded.
//             Note: the extension on the filename determines the file format.
// files     = a string containing one or more filenames, separated by semicolons (;) or vertical bars (|)
// URL       = URL to POST the file to, such as http://www.eztwain.com/upload.php
// fieldName = name of the form-field. If null or blank, "file" is used.
//
// NOTE: When uploading multiple images as a single file, you must of course
// use a file format that supports multiple pages: TIFF, PDF, or DCX.
//
// Return values:
//    0    success (transaction completed)
//         Important: A success return (0) means only that the data was sent to the
//         server and a response was received, not that the receiving script
//         necessarily accepted the submitted file.  See DIB_UploadResponse below. 
//   -1                              user cancelled File Save dialog (should never happen)
//   -2                              could not write temp file - access denied, volume protected, etc.
//   -3    a) image is invalid (null or invalid DIB handle)
//         b) The DLL(s) needed to save that format failed to load
//         c) DIB format incompatible with save format e.g. uploading a B&W image as JPEG.
//         d) fileName does not have a recognized extension (.tif, .jpg, .gif, etc)
//   -4    writing data failed, maybe the disk with the temp folder is full?
//   -5    other unspecified internal error
// -100+n  libcurl returned error code n
//         for example:
// -106    could not resolve host
// -107    couldn't connect
// -126    could not open/read local file

SUBROUTINE UPLOAD_SetProxy(String hostport, String userpwd, Boolean bTunnel) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "UPLOAD_SetProxy;ansi"

FUNCTION String UPLOAD_Response() &
   LIBRARY "Eztwain4.dll" ALIAS FOR "UPLOAD_Response;ansi"
// Return the text received from the server in response to the last upload.
// You can check this text to see if the server-script accepted the upload.
// There is no predefined limit to the length of the returned string - please
// code defensively.  This call is extremely fast, 
// (See DIB_PostToURL above.)

FUNCTION Long UPLOAD_ResponseLength() &
   LIBRARY "Eztwain4.dll"
// Return the length of the last server response string, as returned
// by UPLOAD_Response.

SUBROUTINE UPLOAD_GetResponse(ref String ResponseText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "UPLOAD_GetResponse;ansi"
// Retrieve the text received from the server in response to the last upload.
// * This text is limited to 1024 characters. *
// (See DIB_PostToURL above.)

SUBROUTINE UPLOAD_ClearResponse() &
   LIBRARY "Eztwain4.dll"


//--------- Application Registration and Licensing

SUBROUTINE TWAIN_SetAppTitle(String sAppTitle) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetAppTitle;ansi"
// The short form of Application/Product name registration.
// Sets the product name as far as EZTwain and TWAIN are concerned.
// This title is used in several ways:
// As the title (caption) of any EZTwain dialog boxes / error boxes.
// In the progress box of some devices as they transfer images.
// In the 'software' field of saved image files in some formats,
// including TIFF.

SUBROUTINE TWAIN_SetApplicationKey(Long nKey) &
   LIBRARY "Eztwain4.dll"
// Unlock EZTwain Pro for use with the current application - call this AFTER
// calling RegisterApp or SetAppTitle above:  The nKey value must match
// the application title (product name) passed to one of those functions.

SUBROUTINE TWAIN_ApplicationLicense(String sAppTitle, Long nAppKey) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_ApplicationLicense;ansi"
// Unlock EZTwain using a Single Application License.

SUBROUTINE TWAIN_UniversalLicense(String sLicensee, Long nKey) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_UniversalLicense;ansi"
// Unlock EZTwain using a Universal License.

SUBROUTINE TWAIN_InHouseApplicationLicense(String sLicensee, Long nKey) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_InHouseApplicationLicense;ansi"
// Unlock EZTwain using an In-House Application License.
// (Also works with the discontinued Organization License.)

FUNCTION Boolean TWAIN_RenewTrialLicense(Long uKey) &
   LIBRARY "Eztwain4.dll"
// Renew or recreate the EZTwain Pro trial license in this computer,
// if the Key parameter is a valid trial-renewal key.
// Such keys are valid only for some number of days after issue.
// Contact EZTwain Support (support@eztwain.com) for such a key.

FUNCTION Boolean TWAIN_SingleMachineLicense(String sMsg) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SingleMachineLicense;ansi"
// If no valid EZTwain Pro license is found on this computer, prompt
// the user with a dialog box asking for a single-machine license key.
// If the user supplies a key, try to record & validate it.
// Return value:
// TRUE if EZTwain Pro is licensed for use on this computer.
// (Note this could be because of a trial license, or an organization license).
// FALSE if EZTwain Pro is not licensed for use on this computer.

SUBROUTINE TWAIN_RegisterApp(Long nMajorNum, Long nMinorNum, Long nLanguage, Long nCountry, String sVersion, String sMfg, String sFamily, String sAppTitle) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_RegisterApp;ansi"
//
// TWAIN_RegisterApp can be called *AS THE FIRST CALL*, to register the
// application. If this function is not called, the application is given a
// 'generic' registration by EZTWAIN.
// Registration only provides this information to the Source Manager and any
// sources you may open - it is used for debugging, and possibly by some
// sources to give special treatment to certain applications.

//--------- Error Analysis and Reporting ------------------------------------
//
// EZTwain Error codes
//CONSTANT Long EZTEC_NONE = 0
//CONSTANT Long EZTEC_START_TRIPLET_ERRS = 1
//CONSTANT Long EZTEC_CAP_GET = 2
//CONSTANT Long EZTEC_CAP_SET = 3
//CONSTANT Long EZTEC_DSM_FAILURE = 4
//CONSTANT Long EZTEC_DS_FAILURE = 5
//CONSTANT Long EZTEC_XFER_FAILURE = 6
//CONSTANT Long EZTEC_END_TRIPLET_ERRS = 7
//CONSTANT Long EZTEC_OPEN_DSM = 8
//CONSTANT Long EZTEC_OPEN_DEFAULT_DS = 9
//CONSTANT Long EZTEC_NOT_STATE_4 = 10
//CONSTANT Long EZTEC_NULL_HCON = 11
//CONSTANT Long EZTEC_BAD_HCON = 12
//CONSTANT Long EZTEC_BAD_CONTYPE = 13
//CONSTANT Long EZTEC_BAD_ITEMTYPE = 14
//CONSTANT Long EZTEC_CAP_GET_EMPTY = 15
//CONSTANT Long EZTEC_CAP_SET_EMPTY = 16
//CONSTANT Long EZTEC_INVALID_HWND = 17
//CONSTANT Long EZTEC_PROXY_WINDOW = 18
//CONSTANT Long EZTEC_USER_CANCEL = 19
//CONSTANT Long EZTEC_RESOLUTION = 20
//CONSTANT Long EZTEC_LICENSE = 21
//CONSTANT Long EZTEC_JPEG_DLL = 22
//CONSTANT Long EZTEC_SOURCE_EXCEPTION = 23
//CONSTANT Long EZTEC_LOAD_DSM = 24
//CONSTANT Long EZTEC_NO_SUCH_DS = 25
//CONSTANT Long EZTEC_OPEN_DS = 26
//CONSTANT Long EZTEC_ENABLE_FAILED = 27
//CONSTANT Long EZTEC_BAD_MEMXFER = 28
//CONSTANT Long EZTEC_JPEG_GRAY_OR_RGB = 29
//CONSTANT Long EZTEC_JPEG_BAD_Q = 30
//CONSTANT Long EZTEC_BAD_DIB = 31
//CONSTANT Long EZTEC_BAD_FILENAME = 32
//CONSTANT Long EZTEC_FILE_NOT_FOUND = 33
//CONSTANT Long EZTEC_FILE_ACCESS = 34
//CONSTANT Long EZTEC_MEMORY = 35
//CONSTANT Long EZTEC_JPEG_ERR = 36
//CONSTANT Long EZTEC_JPEG_ERR_REPORTED = 37
//CONSTANT Long EZTEC_0_PAGES = 38
//CONSTANT Long EZTEC_UNK_WRITE_FF = 39
//CONSTANT Long EZTEC_NO_TIFF = 40
//CONSTANT Long EZTEC_TIFF_ERR = 41
//CONSTANT Long EZTEC_PDF_WRITE_ERR = 42
//CONSTANT Long EZTEC_NO_PDF = 43
//CONSTANT Long EZTEC_GIFCON = 44
//CONSTANT Long EZTEC_FILE_READ_ERR = 45
//CONSTANT Long EZTEC_BAD_REGION = 46
//CONSTANT Long EZTEC_FILE_WRITE = 47
//CONSTANT Long EZTEC_NO_DS_OPEN = 48
//CONSTANT Long EZTEC_DCXCON = 49
//CONSTANT Long EZTEC_NO_BARCODE = 50
//CONSTANT Long EZTEC_UNK_READ_FF = 51
//CONSTANT Long EZTEC_DIB_FORMAT = 52
//CONSTANT Long EZTEC_PRINT_ERR = 53
//CONSTANT Long EZTEC_NO_DCX = 54
//CONSTANT Long EZTEC_APP_BAD_CON = 55
//CONSTANT Long EZTEC_LIC_KEY = 56
//CONSTANT Long EZTEC_INVALID_PARAM = 57
//CONSTANT Long EZTEC_INTERNAL = 58
//CONSTANT Long EZTEC_LOAD_DLL = 59
//CONSTANT Long EZTEC_CURL = 60
//CONSTANT Long EZTEC_MULTIPAGE_OPEN = 61
//CONSTANT Long EZTEC_BAD_SHUTDOWN = 62
//CONSTANT Long EZTEC_DLL_VERSION = 63
//CONSTANT Long EZTEC_OCR_ERR = 64
//CONSTANT Long EZTEC_ONLY_TO_PDF = 65
//CONSTANT Long EZTEC_APP_TITLE = 66
//CONSTANT Long EZTEC_PATH_CREATE = 67
//CONSTANT Long EZTEC_LATE_LIC = 68
//CONSTANT Long EZTEC_PDF_PASSWORD = 69
//CONSTANT Long EZTEC_PDF_UNSUPPORTED = 70
//CONSTANT Long EZTEC_PDF_BAFFLED = 71
//CONSTANT Long EZTEC_PDF_INVALID = 72
//CONSTANT Long EZTEC_PDF_COMPRESSION = 73
//CONSTANT Long EZTEC_NOT_ENOUGH_PAGES = 74
//CONSTANT Long EZTEC_DIB_ARRAY_OVERFLOW = 75
//CONSTANT Long EZTEC_DEVICE_PAPERJAM = 76
//CONSTANT Long EZTEC_DEVICE_DOUBLEFEED = 77
//CONSTANT Long EZTEC_DEVICE_COMM = 78
//CONSTANT Long EZTEC_DEVICE_INTERLOCK = 79
//CONSTANT Long EZTEC_BAD_DOC = 80
//CONSTANT Long EZTEC_OTHER_DS_OPEN = 81
//CONSTANT Long EZTEC_LIC_NO_LICENSEE = 82
//CONSTANT Long EZTEC_LIC_NO_UKEY = 83
//CONSTANT Long EZTEC_LIC_NO_APPNAME = 84



FUNCTION Long TWAIN_GetResultCode() &
   LIBRARY "Eztwain4.dll"
// Return the result code (TWRC_xxx) from the last triplet sent to TWAIN

FUNCTION Long TWAIN_GetConditionCode() &
   LIBRARY "Eztwain4.dll"
// Return the condition code from the last triplet sent to TWAIN.
// If a source is NOT open, return the condition code of the source manager.

FUNCTION Boolean TWAIN_UserClosedSource() &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) if during the last acquire the user asked
// the DataSource to close.  0 otherwise of course.
// This flag is cleared each time you start any kind of acquire,
// and it is set if EZTWAIN receives a
// MSG_CLOSEDSREQ message through TWAIN.

SUBROUTINE TWAIN_ErrorBox(String sMsg) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_ErrorBox;ansi"
// Post an error message dialog with an OK button.
// pzMsg points to a null-terminated message string.
// The box caption is the current AppTitle - see SetAppTitle.
// If messages are suppressed (see below) this function does nothing.

FUNCTION Boolean TWAIN_SuppressErrorMessages(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
// Enable or disable EZTWAIN error messages to the user.
// When bYes = FALSE(0), error messages are displayed.
// When bYes = TRUE(non-0), error messages are suppressed.
// By default, error messages are displayed.
// Returns the previous state of the flag.
//
// EZTWAIN cannot suppress messages from TWAIN or TWAIN device drivers.

SUBROUTINE TWAIN_ReportLastError(String msg) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_ReportLastError;ansi"
// If EZTwain has recorded an error and that error has not been
// reported to the user, this function displays a modal error dialog
// with information about that error.
// If msg is non-null and not the empty string, it is included
// in the dialog box.
// Many EZTwain errors record additional details, and those details
// are also inserted in the error dialog.
//
// If the recorded error is EZTEC_NONE (no error) or EZTEC_USER_CANCEL,
// no error dialog is displayed.
// If the recorded error information indicates that the user cancelled
// a TWAIN operation, *or* that the user has already seen an error
// message about the error, then no error dialog is displayed.
//
// This function *clears* the recorded error, whether or
// not it displays a message, by calling TWAIN_ClearError.

SUBROUTINE TWAIN_GetLastErrorText(ref String sMsg) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetLastErrorText;ansi"
// Get a string that describes the last error detected by EZTwain.
// Note: This function is called by TWAIN_ReportLastError.
// Note: The returned string may contain end-of-line characters.
// The parameter is a string variable (char array in C/C++).
// You are responsible for allocating room for 512 8-bit characters
// in the string variable before calling this function.

FUNCTION String TWAIN_LastErrorText() &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_LastErrorText;ansi"
// Return a string that describes the last error detected by EZTwain -
// see Notes for TWAIN_GetLastErrorText.

FUNCTION Long TWAIN_LastErrorCode() &
   LIBRARY "Eztwain4.dll"
// Return the last internal EZTWAIN error code. (see EZTEC_ codes above)

SUBROUTINE TWAIN_ClearError() &
   LIBRARY "Eztwain4.dll"
// Set the EZTWAIN internal error code to EZTEC_NONE

SUBROUTINE TWAIN_RecordError(Long code, String note) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_RecordError;ansi"
// Set the internal EZTwain error code, if it is not set already.
// This is the error info that is reported by LastErrorCode, LastErrorText,
// ReportLastError, and so on.
// The error code can be cleared by TWAIN_ClearError, and a few other
// functions also clear it.

FUNCTION Boolean TWAIN_ReportLeaks() &
   LIBRARY "Eztwain4.dll"
// Display a message box if EZTwain can detect any memory leaks.
// Currently this only counts image handles (DIBs) that have been
// allocated but never freed.
// Returns True(1) if a problem is detected, False(0) otherwise.


//--------- TWAIN State Control ------------------------------------

SUBROUTINE TWAIN_Shutdown() &
   LIBRARY "Eztwain4.dll"
// Shuts down and cleans up all EZTwain operations.
// All memory allocations are freed, all I/O operations
// are completed, any threads are terminated, and
// TWAIN is closed and unloaded.

FUNCTION Boolean TWAIN_LoadSourceManager() &
   LIBRARY "Eztwain4.dll"
// Finds and loads the Data Source Manager, TWAIN.DLL.
// If Source Manager is already loaded, does nothing and returns TRUE(1).
// This can fail if TWAIN.DLL is not installed (in the right place), or
// if the library cannot load for some reason (insufficient memory?) or
// if TWAIN.DLL has been corrupted.

FUNCTION Boolean TWAIN_OpenSourceManager(Long hwnd) &
   LIBRARY "Eztwain4.dll"
// Opens the Data Source Manager, if not already open.
// If the Source Manager is already open, does nothing and returns TRUE.
// This call will fail if the Source Manager is not loaded.

FUNCTION Boolean TWAIN_OpenDefaultSource() &
   LIBRARY "Eztwain4.dll"
// This opens the source selected in the Select Source dialog.
// If some source is already open, does nothing and returns TRUE.
// Will load and open the Source Manager if needed.
// If this call returns TRUE, TWAIN is in STATE 4 (TWAIN_SOURCE_OPEN)

// These two functions allow you to enumerate the available data sources:
FUNCTION Boolean TWAIN_GetSourceList() &
   LIBRARY "Eztwain4.dll"
// Fetches the list of sources into memory, so they can be returned
// one by one by TWAIN_GetNextSourceName, below.
// Returns TRUE (1) if successful, FALSE (0) otherwise.
// Note: In the special (and very unusual) case of an empty list,
// this function returns TRUE(1) if there was no other error.

FUNCTION Boolean TWAIN_GetNextSourceName(ref String sName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetNextSourceName;ansi"
// Copies the next source name in the list into its parameter.
// The parameter is a string variable (char array in C/C++).
// You are responsible for allocating room for 33 8-bit characters
// in the string variable before calling this function.
// Returns TRUE (1) if successful, FALSE (0) if there are no more.

FUNCTION String TWAIN_NextSourceName() &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_NextSourceName;ansi"
// Returns the next source name in the list.
// Returns the empty string when it comes to the end of the list.

FUNCTION Boolean TWAIN_GetDefaultSourceName(ref String sName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetDefaultSourceName;ansi"
// Copies the name of the TWAIN default source into its parameter.
// This is the global 'default source' as defined by TWAIN - which can
// only be set by a user in the Select Source dialog, which
// is displayed by (TWAIN_)SelectImageSource.
//
// Normally returns TRUE (1) but could return FALSE (0) if:
//   - the TWAIN Source Manager cannot be loaded & initialized or
//   - there is no current default source (e.g. no sources are installed)
//
// The parameter is a string variable (char array in C/C++).
// You are responsible for allocating room for 33 8-bit characters
// in the string variable before calling this function.

FUNCTION String TWAIN_DefaultSourceName() &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_DefaultSourceName;ansi"
// Like GetDefaultSourceName but returns a string

FUNCTION Boolean TWAIN_OpenSource(String sName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_OpenSource;ansi"
// Opens the source with the given name.
// If that source is already open, does nothing and returns TRUE.
// If another source is open, closes it and attempts to open the specified source.
// Will load and open the Source Manager if needed.

FUNCTION Boolean TWAIN_EnableSource(Long hwnd) &
   LIBRARY "Eztwain4.dll"
// Enables the open Data Source. This posts the source's user interface
// and allows image acquisition to begin.  If the source is already enabled,
// this call does nothing and returns TRUE.

FUNCTION Boolean TWAIN_DisableSource() &
   LIBRARY "Eztwain4.dll"
// Disables the open Data Source, if any.
// This closes the source's user interface.
// If successful or the source is already disabled, returns TRUE(1).

FUNCTION Boolean TWAIN_CloseSource() &
   LIBRARY "Eztwain4.dll"
// Closes the open Data Source, if any.
// If the source is enabled, disables it first.
// If successful or source is already closed, returns TRUE(1).

FUNCTION Boolean TWAIN_CloseSourceManager(Long hwnd) &
   LIBRARY "Eztwain4.dll"
// Closes the Data Source Manager, if it is open.
// If a source is open, disables and closes it as needed.
// If successful (or if source manager is already closed) returns TRUE(1).

FUNCTION Boolean TWAIN_UnloadSourceManager() &
   LIBRARY "Eztwain4.dll"
// Unloads the Data Source Manager i.e. TWAIN.DLL - releasing
// any associated memory or resources.
// If necessary, it will abort transfers, close the open source
// if any, and close the Source Manager.
// If successful, it returns TRUE(1)


FUNCTION Boolean TWAIN_EndXfer() &
   LIBRARY "Eztwain4.dll"

FUNCTION Boolean TWAIN_AbortAllPendingXfers() &
   LIBRARY "Eztwain4.dll"

//--------- High-level Capability Negotiation Functions --------

// These functions should only be called in State 4 (TWAIN_SOURCE_OPEN)

FUNCTION Boolean TWAIN_SetXferCount(Long nXfers) &
   LIBRARY "Eztwain4.dll"
// Negotiate with open Source the number of images application will accept.
// nXfers = -1 means any number
// Returns: TRUE(1) for success, FALSE(0) for failure.

//----- Unit of Measure
// TWAIN unit codes (from twain.h)
//CONSTANT Long TWUN_INCHES = 0
//CONSTANT Long TWUN_CENTIMETERS = 1
//CONSTANT Long TWUN_PICAS = 2
//CONSTANT Long TWUN_POINTS = 3
//CONSTANT Long TWUN_TWIPS = 4
//CONSTANT Long TWUN_PIXELS = 5

FUNCTION Long TWAIN_GetCurrentUnits() &
   LIBRARY "Eztwain4.dll"
// Return the current unit of measure: inches, cm, pixels, etc.
// Many TWAIN parameters such as resolution are set and returned
// in the current unit of measure.
// There is no error return - in case of error it returns 0 (TWUN_INCHES)

FUNCTION Boolean TWAIN_SetUnits(Long nUnits) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetCurrentUnits(Long nUnits) &
   LIBRARY "Eztwain4.dll"
// Set the current unit of measure for the source.
// Returns: TRUE(1) for success, FALSE(0) for failure.
// Common unit codes (TWUN_*) are given above.
// Notes:
// 1. Most sources do not support all units, some support *only* inches!
// 2. If you want to get or set resolution in DPI (dots per *inch*), make
// sure the current units are inches, or you might get Dots-Per-cm!
// 3. Ditto (same comment) for ImageLayout, see below.

FUNCTION Long TWAIN_GetBitDepth() &
   LIBRARY "Eztwain4.dll"
// Get the current bitdepth, which can depend on the current PixelType.
// Bit depth is per color channel e.g. 24-bit RGB has bit depth 8.
// If anything goes wrong, this function returns 0.

FUNCTION Boolean TWAIN_SetBitDepth(Long nBits) &
   LIBRARY "Eztwain4.dll"
// (Try to) set the current bitdepth (for the current pixel type).
// Note: You should set a PixelType, then set the bitdepth for that type.
// Returns: TRUE(1) for success, FALSE(0) for failure.

//------- TWAIN Pixel Types (from twain.h)
//CONSTANT Long TWPT_BW = 0
//CONSTANT Long TWPT_GRAY = 1
//CONSTANT Long TWPT_RGB = 2
//CONSTANT Long TWPT_PALETTE = 3
//CONSTANT Long TWPT_CMY = 4
//CONSTANT Long TWPT_CMYK = 5

FUNCTION Long TWAIN_GetPixelType() &
   LIBRARY "Eztwain4.dll"
// Ask the source for the current pixel type.
// If anything goes wrong (it shouldn't), this function returns 0 (TWPT_BW).

FUNCTION Boolean TWAIN_SetPixelType(Long nPixType) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetCurrentPixelType(Long nPixType) &
   LIBRARY "Eztwain4.dll"
// Try to set the current pixel type for acquisition.
// The source may select this pixel type, but don't assume it will.

FUNCTION Double TWAIN_GetCurrentResolution() &
   LIBRARY "Eztwain4.dll"
// Ask the source for the current (horizontal) resolution.
// Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above)
// If anything goes wrong (it shouldn't) this function returns 0.0

FUNCTION Double TWAIN_GetXResolution() &
   LIBRARY "Eztwain4.dll"
FUNCTION Double TWAIN_GetYResolution() &
   LIBRARY "Eztwain4.dll"
// Returns the current horizontal or vertical resolution, in dots per *current unit*.
// In the event of failure, returns 0.0.

FUNCTION Boolean TWAIN_SetResolution(Double dRes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetResolutionInt(Long nRes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetCurrentResolution(Double dRes) &
   LIBRARY "Eztwain4.dll"
// Try to set the current resolution (in both x & y).
// Resolution is in dots per current unit! (See TWAIN_GetCurrentUnits above)
// Note: The source may select this resolution, but don't assume it will.

// You can also set the resolution in X and Y separately, if your TWAIN
// device can handle this:
FUNCTION Boolean TWAIN_SetXResolution(Double dxRes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetYResolution(Double dyRes) &
   LIBRARY "Eztwain4.dll"

FUNCTION Boolean TWAIN_SetContrast(Double dCon) &
   LIBRARY "Eztwain4.dll"
// Try to set the current contrast for acquisition.
// The TWAIN standard *says* that the range for this cap is -1000 ... +1000

FUNCTION Boolean TWAIN_SetBrightness(Double dBri) &
   LIBRARY "Eztwain4.dll"
// Try to set the current brightness for acquisition.
// The TWAIN standard *says* that the range for this cap is -1000 ... +1000

FUNCTION Boolean TWAIN_SetThreshold(Double dThresh) &
   LIBRARY "Eztwain4.dll"
// Try to set the threshold for black and white scanning.
// Should only affect 1-bit scans i.e. PixelType == TWPT_BW.
// The TWAIN default threshold value is 128.
// After staring at the TWAIN 1.6 spec for a while, I imagine that it implies
// that for 8-bit samples, values >= nThresh are thresholded to 1, others to 0.

FUNCTION Double TWAIN_GetCurrentThreshold() &
   LIBRARY "Eztwain4.dll"
// Try to get and return the current value (MSG_GETCURRENT) of the
// ICAP_THRESHOLD capability.  If this fails for any reason, it
// will return -1.  *VERSIONS BEFORE 2.65 RETURNED 128.0*

//--------------------------------------------------------------
// Automatic post-processing of scanned pages
//
//
// Automatic deskewing of scanned pages
//
SUBROUTINE TWAIN_SetAutoDeskew(Long nMode) &
   LIBRARY "Eztwain4.dll"
// Select the 'auto-deskew' mode.
// Auto-deskew attempts to straighten up scans that are slightly crooked,
// up to about 10 degrees.
// The currently defined modes are:
//  0   - no auto deskew (default)
//  1   - turn on scanner auto-deskew if available, otherwise deskew in software.

FUNCTION Long TWAIN_GetAutoDeskew() &
   LIBRARY "Eztwain4.dll"
// Return the current AutoDeskew mode.

//--------------------------------------------------------------
// Automatic discarding of blank pages
//
SUBROUTINE TWAIN_SetBlankPageMode(Long nMode) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetBlankPageMode() &
   LIBRARY "Eztwain4.dll"
// Sets or gets the 'Skip Blank Pages' mode.
// The currently defined modes are:
//   0 = no special treatment for blank pages (default)
//   1 = blank pages are discarded by all multipage Acquire functions.
// See TWAIN_SetBlankPageThreshold below for more details.

SUBROUTINE TWAIN_SetBlankPageThreshold(Double dDarkness) &
   LIBRARY "Eztwain4.dll"
FUNCTION Double TWAIN_GetBlankPageThreshold() &
   LIBRARY "Eztwain4.dll"
// Sets or gets the blank page 'darkness' threshold.
// In 'Skip Blank Pages' mode (see above), each page of a multipage
// scan is measured for 'darkness'.  If the darkness of a page
// is below the BlankPageThreshold, it is considered blank.
// See the related functions DIB_IsBlank and DIB_Darkness.
// 
// The default BlankPageThreshold is 0.02 (= 2% dark pixels).

FUNCTION Long TWAIN_BlankDiscardCount() &
   LIBRARY "Eztwain4.dll"
// Return the number of blank pages discarded (skipped) during
// the most recent multipage scan.
// Of course this only reports pages skipped by software, not
// any pages discarded as 'blank' inside the scanner - if such
// a feature is enabled.

//--------------------------------------------------------------
// Automatic cropping of scanned pages
//
SUBROUTINE TWAIN_SetAutoCrop(Long nMode) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetAutoCrop() &
   LIBRARY "Eztwain4.dll"
// Select the AutoCrop mode.
// Auto-crop attempts to trim off black areas on the outside
// edges of each incoming image during scanning.
// It will not be effective on scanners that have white
// background outside the scanned document.
// The currently defined modes are:
//  0   - no auto crop (default)
//  1   - auto crop using EZTwain software algorithms
//  2   - use scanner autocrop if possible, otherwise no autocrop
//  3   - use scanner autocrop if possible, otherwise do software autocrop.

// Set/get the Options flags for auto-crop during scanning.
// See DIB_AutoCrop for details of these flags.
SUBROUTINE TWAIN_SetAutoCropOptions(Long nOpts) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetAutoCropOptions() &
   LIBRARY "Eztwain4.dll"

SUBROUTINE TWAIN_SetAutoCropSize(Double w, Double h, Long nUnits) &
   LIBRARY "Eztwain4.dll"
// Set the width & height for subsequent auto-crops, in the given units.
// This restricts subsequent auto-crops to select the best-match crop
// position of the specified size.
// Use this call if you know the size of the expected document.
// For units, see (TWAIN_)GetCurrentUnits.
//
// Note: This setting persists until changed! You must clear it explicitly.
// To clear, use SetAutoCropSize(0,0) or call ClearAutoCropSize (below)

SUBROUTINE TWAIN_ClearAutoCropSize() &
   LIBRARY "Eztwain4.dll"
// Clear any restrictions on auto-crop size.

// Set the range of width & height considered by the auto-crop algorithm.
// If either range is empty (min >= max) that range is not restricted during auto-crop.
SUBROUTINE TWAIN_SetAutoCropSizeRange(Double minW, Double maxW, Double minH, Double maxH, Long nUnits) &
   LIBRARY "Eztwain4.dll"

// Clear the limitations on the range of auto-crop sizes.
// Equivalent to calling SetAutoCropSizeRange(0.0,0.0,0.0,0.0);
SUBROUTINE TWAIN_ClearAutoCropSizeRange() &
   LIBRARY "Eztwain4.dll"


//--------------------------------------------------------------
// Automatic contrast adjustment of scanned pages
//
SUBROUTINE TWAIN_SetAutoContrast(Long nMode) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetAutoContrast() &
   LIBRARY "Eztwain4.dll"
// Select the AutoContrast mode.
// Automatically adjust the contrast of each image - see
// DIB_AutoContrast for more information.
// The currently defined modes are:
//  0   - no autocontrast.
//  1   - autocontrast using EZTwain software algorithms

//--------------------------------------------------------------
// Automatic OCR of scanned pages.
//
SUBROUTINE TWAIN_SetAutoOCR(Long nMode) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetAutoOCR() &
   LIBRARY "Eztwain4.dll"
// Sets or gets the auto-OCR mode
// By default this mode is 0 = OFF.
// When this mode is on (1), EZTwain applies OCR, if available, to each incoming
// scanned page or image and temporarily stores the result.  In this mode,
// if you are scanning directly to PDF format using TWAIN_AcquireToFilename
// or TWAIN_AcquireMultipageFile, the OCR'd text is also written to each
// PDF page as invisible text, to facilitate indexing and searching.
// If you are scanning individual pages you can call OCR_Text or OCR_GetText
// to retrieve the text found on the most recently scanned page.
// In this mode, any Acquire call discards any previous OCR text.
//
// The currently selected OCR engine is used: See OCR_SelectEngine and co.
// Caution: If OCR fails for some reason in auto-OCR mode, an error is recorded
// (see TWAIN_LastErrorCode, TWAIN_ReportLastError) but the scanning function
// may report success.

//
// Automatic negation of scanned pages
//
SUBROUTINE TWAIN_SetAutoNegate(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_GetAutoNegate() &
   LIBRARY "Eztwain4.dll"
// Set or get the "AutoNegate" flag: When this flag is set (non-zero)
// EZTwain automatically 'negates' any B&W scanned image that is > 80% black
// i.e. it exchanges black & white in the image.
// This flag is TRUE (1) by default.

//--------------------------------------------------------------


FUNCTION Boolean TWAIN_SetXferMech(Long mech) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_XferMech() &
   LIBRARY "Eztwain4.dll"
// Try to set or get the transfer mode - one of the following:
//CONSTANT Long XFERMECH_NATIVE = 0
//CONSTANT Long XFERMECH_FILE = 1
//CONSTANT Long XFERMECH_MEMORY = 2
//CONSTANT Long XFERMECH_FILE2 = 3
// It is normally not necessary to set the transfer mode, 
// TWAIN_Acquire, TWAIN_AcquireMultipageFile and the other general-purpose
// scanning functions will select the appropriate transfer mode, taking
// the scanner model and scan settings into account.
//
// If your application is used with a particularly wide variety of scanners,
// you may encounter a user with a scanning problem that is resolved by forcing
// memory transfer mode. To address this, offer a field-settable option that
// adds this call as part of scan-parameter setting:
// TWAIN_SetXferMech(XFERMECH_MEMORY)
//

FUNCTION Boolean TWAIN_SupportsFileXfer() &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if the open DS claims to support file transfer mode (XFERMECH_FILE)
// Returns FALSE(0) otherwise.
// This mode is optional.  If TRUE, you can use AcquireFile.

FUNCTION Boolean TWAIN_SetPaperSize(Long nPaper) &
   LIBRARY "Eztwain4.dll"
// During the next scan, request that the scanner scan the specified paper size.
// Most scanners support the first few paper sizes, excluding any that are
// larger than their physical scan capacity.
// To determine the paper sizes supported by a particular scanner, see
// "Working with Capabilities" in the EZTwain User Guide.
//
// Note - These are synonyms for the TWSS_* constants in TWAIN.H
//CONSTANT Long PAPER_NONE = 0
//CONSTANT Long PAPER_A4LETTER = 1
//CONSTANT Long PAPER_A4 = 1
//CONSTANT Long PAPER_B5LETTER = 2
//CONSTANT Long PAPER_JISB5 = 2
//CONSTANT Long PAPER_USLETTER = 3
//CONSTANT Long PAPER_USLEGAL = 4
//CONSTANT Long PAPER_A5 = 5
//CONSTANT Long PAPER_B4 = 6
//CONSTANT Long PAPER_ISOB4 = 6
//CONSTANT Long PAPER_B6 = 7
//CONSTANT Long PAPER_ISOB6 = 7
//CONSTANT Long PAPER_USLEDGER = 9
//CONSTANT Long PAPER_USEXECUTIVE = 10
//CONSTANT Long PAPER_A3 = 11
//CONSTANT Long PAPER_B3 = 12
//CONSTANT Long PAPER_ISOB3 = 12
//CONSTANT Long PAPER_A6 = 13
//CONSTANT Long PAPER_C4 = 14
//CONSTANT Long PAPER_C5 = 15
//CONSTANT Long PAPER_C6 = 16
//CONSTANT Long PAPER_4A0 = 17
//CONSTANT Long PAPER_2A0 = 18
//CONSTANT Long PAPER_A0 = 19
//CONSTANT Long PAPER_A1 = 20
//CONSTANT Long PAPER_A2 = 21
//CONSTANT Long PAPER_A7 = 22
//CONSTANT Long PAPER_A8 = 23
//CONSTANT Long PAPER_A9 = 24
//CONSTANT Long PAPER_A10 = 25
//CONSTANT Long PAPER_ISOB0 = 26
//CONSTANT Long PAPER_ISOB1 = 27
//CONSTANT Long PAPER_ISOB2 = 28
//CONSTANT Long PAPER_ISOB5 = 29
//CONSTANT Long PAPER_ISOB7 = 30
//CONSTANT Long PAPER_ISOB8 = 31
//CONSTANT Long PAPER_ISOB9 = 32
//CONSTANT Long PAPER_ISOB10 = 33
//CONSTANT Long PAPER_JISB0 = 34
//CONSTANT Long PAPER_JISB1 = 35
//CONSTANT Long PAPER_JISB2 = 36
//CONSTANT Long PAPER_JISB3 = 37
//CONSTANT Long PAPER_JISB4 = 38
//CONSTANT Long PAPER_JISB6 = 39
//CONSTANT Long PAPER_JISB7 = 40
//CONSTANT Long PAPER_JISB8 = 41
//CONSTANT Long PAPER_JISB9 = 42
//CONSTANT Long PAPER_JISB10 = 43
//CONSTANT Long PAPER_C0 = 44
//CONSTANT Long PAPER_C1 = 45
//CONSTANT Long PAPER_C2 = 46
//CONSTANT Long PAPER_C3 = 47
//CONSTANT Long PAPER_C7 = 48
//CONSTANT Long PAPER_C8 = 49
//CONSTANT Long PAPER_C9 = 50
//CONSTANT Long PAPER_C10 = 51
//CONSTANT Long PAPER_USSTATEMENT = 52
//CONSTANT Long PAPER_BUSINESSCARD = 53

FUNCTION Boolean TWAIN_GetPaperDimensions(Long nPaper, Long nUnits, ref Double pdW, ref Double pdH) &
   LIBRARY "Eztwain4.dll"
// Retrieve the width and height of a standard paper size.
// 1st parameter is a PAPER_ code.
// 2nd parameter is a unit code, TWUN_INCHES, TWUN_CENTIMETERS, etc.
// 3rd & 4th parameter are pointers to double variables that receive the width
// and height of the specified paper size, in the specified units.
// Returns TRUE(1) if successful, FALSE(0) otherwise.

//-------- Document Feeder -------

FUNCTION Boolean TWAIN_HasFeeder() &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if the source indicates it has a document feeder.
// Note: A FALSE(0) is returned if the source does not handle this inquiry.

FUNCTION Boolean TWAIN_ProbablyHasFlatbed() &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if we think the source has a flatbed available.
// It's a good guess but not a guarantee - we could be wrong.

FUNCTION Boolean TWAIN_IsFeederSelected() &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if the document feeder is selected.

FUNCTION Boolean TWAIN_SelectFeeder(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
// (Try to) select or deselect the document feeder.
// The document feeder, if any, is selected if bYes is non-zero.
// The flatbed, if any, is selected if bYes is zero.
// Note: A few of the scanners that have both a flatbed and 
// a feeder ignore this request in some circumstances.
// Returns TRUE(1) if successful, FALSE(0) otherwise.

FUNCTION Boolean TWAIN_IsAutoFeedOn() &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if automatic feeding is enabled, otherwise FALSE(0).
// Make sure the feeder is selected before calling this function.

FUNCTION Boolean TWAIN_SetAutoFeed(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
// (Try to) turn on/off automatic feeding thru the feeder.
// Returns TRUE(1) if successful, FALSE(0) otherwise.
// Note: TWAIN_AcquireMultipageFile calls TWAIN_SetAutoFeed(True).

FUNCTION Boolean TWAIN_IsFeederLoaded() &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if there are documents in the feeder.
// Make sure the feeder is selected before calling this function.

FUNCTION Boolean TWAIN_IsPaperDetectable() &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if the open device (better have one open!)
// is capable of detecting paper in its feeder.
// If not, returns FALSE.
// Displays an error dialog if called with no scanner open.

FUNCTION Boolean TWAIN_SetAutoScan(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
// Setting this to TRUE gives the scanner permission to 'scan ahead'
// i.e. to pull pages from the feeder and scan them before 
// they have been requested.  On high-speed scanners, you may
// have to enable AutoScan to achieve the maximum scanning rate.
// Returns TRUE(1) if successful, FALSE(0) otherwise.
// This call will fail on most flatbeds & cameras, and some 'feeder'
// scanners.
// TWAIN_AcquireMultipageFile calls TWAIN_SetAutoScan(True).

//-------- Duplex Scanning -------

FUNCTION Boolean TWAIN_CanDoDuplex() &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if the device supports duplex scanning,
// FALSE(0) otherwise.

FUNCTION Long TWAIN_GetDuplexSupport() &
   LIBRARY "Eztwain4.dll"
// Query the device for duplex scanning support.
//   Return values:
// 0    = no support (or error, or query not recognized)
// 1    = 1-pass duplex
// 2    = 2-pass duplex

FUNCTION Boolean TWAIN_EnableDuplex(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
// Enable (bYes not 0) or disable (bYes=0) duplex scanning.
// Returns TRUE(1) if successful, FALSE(0) otherwise.

FUNCTION Boolean TWAIN_IsDuplexEnabled() &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if the device supports duplex scanning
// and duplex scanning is enabled.  FALSE(0) otherwise.

//--------- Other 'exotic' capabilities --------

FUNCTION Long TWAIN_HasControllableUI() &
   LIBRARY "Eztwain4.dll"
// Return 1 if source claims UI can be hidden (see SetHideUI above)
// Return 0 if source says UI *cannot* be hidden
// Return -1 if source (pre TWAIN 1.6) cannot answer the question.

FUNCTION Boolean TWAIN_SetIndicators(Boolean bVisible) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_GetIndicators() &
   LIBRARY "Eztwain4.dll"
// Set/Get the value of CAP_INDICATORS.
// This is set & read from the open Source if a source is open, otherwise
// these functions set & report the value that will be used the next time
// a source is opened.
//
// Default is TRUE, which gives the device permission to show a progress
// box or similar, but does not require it.

FUNCTION Long TWAIN_Compression() &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetCompression(Long compression) &
   LIBRARY "Eztwain4.dll"
// Set/Get compression style for transferred data
// Set returns TRUE(1) for success, FALSE(0) for failure.

FUNCTION Boolean TWAIN_Tiled() &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetTiled(Boolean bTiled) &
   LIBRARY "Eztwain4.dll"
// Set/Get whether source does memory xfer via strips or tiles.
// bTiled = TRUE if it uses tiles for transfer.
// Set returns: TRUE(1) for success, FALSE(0) for failure.

FUNCTION Long TWAIN_PlanarChunky() &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetPlanarChunky(Long shape) &
   LIBRARY "Eztwain4.dll"
// Set/Get current pixel shape (TWPC_CHUNKY or TWPC_PLANAR), or -1.
// Set returns TRUE(1) for success, FALSE(0) for failure.

//CONSTANT Long CHUNKY_PIXELS = 0
//CONSTANT Long PLANAR_PIXELS = 1

FUNCTION Long TWAIN_PixelFlavor() &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetPixelFlavor(Long flavor) &
   LIBRARY "Eztwain4.dll"
// Set/Get pixel 'flavor' - whether a '0' pixel value means black or white:
// Set returns: TRUE(1) for success, FALSE(0) for failure.

//CONSTANT Long CHOCOLATE_PIXELS = 0
//CONSTANT Long VANILLA_PIXELS = 1


FUNCTION Boolean TWAIN_SetLightPath(Boolean bTransmissive) &
   LIBRARY "Eztwain4.dll"
// Tries to select transparent or reflective media on the open source.
// A parameter of TRUE(1) means transparent, FALSE(0) means reflective.
// Returns: TRUE(1) for success, FALSE(0) for failure.

FUNCTION Boolean TWAIN_SetAutoBright(Boolean bOn) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetGamma(Double dGamma) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetShadow(Double d) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetHighlight(Double d) &
   LIBRARY "Eztwain4.dll"
// Set auto-brightness, gamma, shadow, and highlight values.
// Refer to the TWAIN specification for definitions of these settings.
// Returns: TRUE(1) for success, FALSE(0) for failure.

//--------- Image Layout (Region of Interest) --------

SUBROUTINE TWAIN_SetRegion(Double L, Double T, Double R, Double B) &
   LIBRARY "Eztwain4.dll"
// Specify the region to be acquired, in current unit of measure.
// This is the recommended most-general way to scan a region.
// Tries to use TWAIN_SetImageLayout and TWAIN_SetFrame (see below).
// If the device ignores those, the specified region is extracted
// after each scan completes, by software cropping. (DIB_RegionCopy)
// In other words, this call should *always* produce scans of
// the requested region, unless you specify a region in inches or
// centimeters and the device is a camera whose only unit is pixels.

SUBROUTINE TWAIN_ResetRegion() &
   LIBRARY "Eztwain4.dll"
// Clear any region set with TWAIN_SetRegion above.

FUNCTION Boolean TWAIN_SetImageLayout(Double L, Double T, Double R, Double B) &
   LIBRARY "Eztwain4.dll"
// Specify the area to scan, sometimes called the ROI (Region of Interest)
// Returns: TRUE(1) for success, FALSE(0) for failure.
// This call is only valid in State 4.
// L, T, R, B = distance to left, top, right, and bottom edge of
// area to scan, measured in the current unit of measure,
// from the top-left corner of the 'original page' (TWAIN 1.6 8-22)

FUNCTION Boolean TWAIN_GetImageLayout(ref Double L, ref Double T, ref Double R, ref Double B) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_GetDefaultImageLayout(ref Double L, ref Double T, ref Double R, ref Double B) &
   LIBRARY "Eztwain4.dll"
// Get the current or default (power-on) area to scan.
// Returns: TRUE(1) for success, FALSE(0) for failure.
// This call is valid in States 4-6.
// Supposedly the returned values (see above)
// are in the current unit of measure (ICAP_UNITS), but I observe that
// many DS's ignore ICAP_UNITS when dealing with Image Layout.

FUNCTION Boolean TWAIN_ResetImageLayout() &
   LIBRARY "Eztwain4.dll"
// Reset the area to scan to the default (power-on) settings.
// This call is only valid in State 4.
// Returns: TRUE(1) for success, FALSE(0) for failure.


// Closely related:
FUNCTION Boolean TWAIN_SetFrame(Double L, Double T, Double R, Double B) &
   LIBRARY "Eztwain4.dll"
// This is an alternative way to set the scan area.
// Some scanners will respond to this instead of SetImageLayout.
// Returns: TRUE(1) for success, FALSE(0) for failure.
// This call is only valid in State 4.
// L, T, R, B = distance to left, top, right, and bottom edge of
// area to scan, measured in the current unit of measure,


//--------- Tone Response Curves --------

FUNCTION Boolean TWAIN_SetGrayResponse(ref Long pcurve) &
   LIBRARY "Eztwain4.dll"
// Define a translation of gray pixel values.
// When device digitizes a pixel with value V, that
// pixel is translated to value pcurve[V] before it
// is returned to the application.
// Device must be open (State 4),
// Current PixelType must be TWPT_GRAY or TWPT_RGB,
// current BitDepth should be 8.
// pcurve must be a table (array, vector) of 256 entries.
// Returns: TRUE(1) for success, FALSE(0) for failure.

FUNCTION Boolean TWAIN_SetColorResponse(ref Long pred, ref Long pgreen, ref Long pblue) &
   LIBRARY "Eztwain4.dll"
// Define a translation of color values.
// Like TWAIN_SetGrayResponse (above) but separate translation can
// be applied to each color channel.
// Returns: TRUE(1) for success, FALSE(0) for failure.

FUNCTION Boolean TWAIN_ResetGrayResponse() &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_ResetColorResponse() &
   LIBRARY "Eztwain4.dll"
// These two functions reset the response curve to map every
// value V to itself i.e. a 'do nothing' translation.
// Returns: TRUE(1) for success, FALSE(0) for failure.

//--------- Barcode Recognition -------

FUNCTION Boolean BARCODE_IsAvailable() &
   LIBRARY "Eztwain4.dll"
// TRUE(1) if barcode recognition is available.
// Returns FALSE(0) otherwise.

FUNCTION Long BARCODE_Version() &
   LIBRARY "Eztwain4.dll"
// Return the barcode module version * 100.

// Barcode recognition engines supported by EZTwain:
//CONSTANT Long EZBAR_ENGINE_NONE = 0
//CONSTANT Long EZBAR_ENGINE_NATIVE = 1
//CONSTANT Long EZBAR_ENGINE_AXTEL = 2
//CONSTANT Long EZBAR_ENGINE_LEADTOOLS15 = 3
//CONSTANT Long EZBAR_ENGINE_BLACKICE = 4
//CONSTANT Long EZBAR_ENGINE_LEADTOOLS16 = 5
//CONSTANT Long EZBAR_ENGINE_INBARCODE = 6

//CONSTANT Long EZBAR_ENGINE_LEADTOOLS = 3

// The Axtel barcode engine has been discontinued by Axtel.
// The LEADTOOLS engine must be separately licensed from LEADTOOLS - www.leadtools.com
// The Black Ice barcode engine must be separately licensed from Black Ice. 

FUNCTION Boolean BARCODE_IsEngineAvailable(Long nEngine) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean BARCODE_SelectEngine(Long nEngine) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long BARCODE_SelectedEngine() &
   LIBRARY "Eztwain4.dll"

FUNCTION String BARCODE_EngineName(Long nEngine) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "BARCODE_EngineName;ansi"
// Returns the short name ("None", "Native", "Axtel", etc.) of the specified
// engine, or the empty string if nEngine is not a recognized barcode engine code.

SUBROUTINE BARCODE_SetLicenseKey(String sKey) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "BARCODE_SetLicenseKey;ansi"
// Supply your license key for the currently selected engine.
// The native barcode engine does not currently require a key.
// For LeadTools, this is a 1D Barcode Module key obtained from LeadTools

FUNCTION Long BARCODE_ReadableCodes() &
   LIBRARY "Eztwain4.dll"
// Return the sum of the barcode types recognized by the current selected engine.
//
// Barcode types:
//CONSTANT Long EZBAR_EAN_13 = 1
//CONSTANT Long EZBAR_EAN_8 = 2
//CONSTANT Long EZBAR_UPCA = 4
//CONSTANT Long EZBAR_UPCE = 8
//CONSTANT Long EZBAR_CODE_39 = 16
//CONSTANT Long EZBAR_CODE_39FA = 32
//CONSTANT Long EZBAR_CODE_128 = 64
//CONSTANT Long EZBAR_CODE_I25 = 128
//CONSTANT Long EZBAR_CODA_BAR = 256
//CONSTANT Long EZBAR_UCCEAN_128 = 512
//CONSTANT Long EZBAR_CODE_93 = 1024
//CONSTANT Long EZBAR_ANY = -1

FUNCTION String BARCODE_TypeName(Long nType) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "BARCODE_TypeName;ansi"
// Return a human-readable name for the specified barcode type/symbology.

FUNCTION Boolean BARCODE_SetDirectionFlags(Long nDirFlags) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long BARCODE_GetDirectionFlags() &
   LIBRARY "Eztwain4.dll"
FUNCTION Long BARCODE_AvailableDirectionFlags() &
   LIBRARY "Eztwain4.dll"
// Set/Get the directions the engine will scan for barcodes.
// The default is left-to-right ONLY.
// Scanning for barcodes in multiple directions can slow the
// recognition process.  BARCODE_SetDirectionFlags will return TRUE if
// completely successful, FALSE if any direction is invalid or not supported.
// Setting the direction flags to -1 is interpreted as "select all supported
// directions."

// Barcode direction flags - can be or'ed together
//CONSTANT Long EZBAR_LEFT_TO_RIGHT = 1
//CONSTANT Long EZBAR_RIGHT_TO_LEFT = 2
//CONSTANT Long EZBAR_TOP_TO_BOTTOM = 4
//CONSTANT Long EZBAR_BOTTOM_TO_TOP = 8
//CONSTANT Long EZBAR_DIAGONAL = 16
// some common combinations:
//CONSTANT Long EZBAR_HORIZONTAL = 3
//CONSTANT Long EZBAR_VERTICAL = 12

SUBROUTINE BARCODE_SetZone(Long x, Long y, Long w, Long h) &
   LIBRARY "Eztwain4.dll"
// Restrict barcode recognition to one zone (in pixels) of each image.
// Coordinates are left pixel, top pixel, width and height in pixels.

SUBROUTINE BARCODE_NoZone() &
   LIBRARY "Eztwain4.dll"
// Cancel any zone restriction - subsequent barcode recognition
// applies to the entire image.

FUNCTION Long BARCODE_Recognize(Long hdib, Long nMaxCount, Long nType) &
   LIBRARY "Eztwain4.dll"
// Find and recognize barcodes in the given image.
// Don't look for more than nMaxCount barcodes (-1 means 'any number')
// Expect barcodes of the specified type (-1 means 'any recognized type')
// You can add or 'or' together barcode types.
//
// Return values:
//   n>0    n barcodes found
//   0      no barcodes found
//  -1      barcode services not available.
//                                -2                                                                  -not used-
//  -3      invalid or null image
//                                -4                                                                  memory error (low memory?)
//  -5                                                              internal error, or error from 3rd party barcode engine.

FUNCTION String BARCODE_Text(Long n) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "BARCODE_Text;ansi"
// Return the text of the nth barcode recognized by the last BARCODE_Recognize.
// barcodes are numbered from 0.
// If there is any problem of any kind, returns the empty string.

FUNCTION Boolean BARCODE_GetText(Long n, ref String Text) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "BARCODE_GetText;ansi"
// Get the text of the nth barcode recognized by the last BARCODE_Recognize.
// Please allow 64 characters in your text buffer.  Use a smaller buffer
// only if you *know* that the barcode type is limited to shorter strings.

FUNCTION Long BARCODE_Type(Long n) &
   LIBRARY "Eztwain4.dll"
// Return the type (symbology) of the nth barcode recognized.

FUNCTION Boolean BARCODE_GetRect(Long n, ref Double L, ref Double T, ref Double R, ref Double B) &
   LIBRARY "Eztwain4.dll"
// Get the rectangle bounding the nth barcode found in the last BARCODE_Recognize.
// Returns TRUE(1) if successful, FALSE(0) otherwise.  The only likely cause
// of a FALSE return would be an invalid value of n, or a null reference.
// L    = left edge
// T    = top edge
// R    = right edge
// B    = bottom edge
// Note: Returned coordinates are in pixels, relative to the upper-left corner
// of the image given to BARCODE_Recognize.

//--------- OCR (Optical Character Recognition) -------

// Note: Requires the Transym OCR engine (TOCR) which must be separately
// licensed from Transym - See www.transym.com

FUNCTION Boolean OCR_IsAvailable() &
   LIBRARY "Eztwain4.dll"
// TRUE(1) if OCR recognition is available in some form.
// Returns FALSE(0) otherwise.

FUNCTION Long OCR_Version() &
   LIBRARY "Eztwain4.dll"
// Returns version * 100 of the EZTwain OCR module.

// ----- OCR engines supported by EZTwain -----
//CONSTANT Long EZOCR_ENGINE_NONE = 0
//CONSTANT Long EZOCR_ENGINE_TRANSYM = 1

FUNCTION Boolean OCR_IsEngineAvailable(Long nEngine) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean OCR_SelectEngine(Long nEngine) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long OCR_SelectedEngine() &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean OCR_SelectDefaultEngine() &
   LIBRARY "Eztwain4.dll"

FUNCTION String OCR_EngineName(Long nEngine) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "OCR_EngineName;ansi"
// Returns the short name ("None", "Transym TOCR") of the specified
// engine, or the empty string if nEngine is not a recognized OCR engine code.

SUBROUTINE OCR_SetEngineKey(String sKey) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "OCR_SetEngineKey;ansi"
// Set the license key to be passed to the OCR engine.
// * If you are using the reseller version of Transym's TOCR, pass the
//   RegNo provided by Transym, as a string e.g. "0123-4567-89AB-CDEF"

SUBROUTINE OCR_SetEnginePath(String sPath) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "OCR_SetEnginePath;ansi"
// Set the directory of the OCR engine.
// If the OCR engine file(s) needed by EZTwain are not found
// in that directory, the engine will be treated as "not available".
// An empty engine path (the default) tells EZTwain to search
// for the OCR engine files using the Windows default search
// for executables.

SUBROUTINE OCR_SetLineBreak(String sEOL) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "OCR_SetLineBreak;ansi"
// Set the character sequence to use for line breaks in
// the returned OCR'd text (as returned by OCR_Text and OCR_GetText).
// ..
// The default OCR line break is \n (LF, 0x0A)
// Other commonly used line breaks are \r (CR, 0x0D) or CRLF.
// Set this *before* doing OCR - it does not modify already
// recognized text.

FUNCTION Long OCR_RecognizeDib(Long hdib) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long OCR_RecognizeDibZone(Long hdib, Long x, Long y, Long w, Long h) &
   LIBRARY "Eztwain4.dll"
// Find and recognize text in the given image, or
// in a designated zone of an image.
// Coordinates are left pixel, top pixel, width & height in pixels.
//
// Return values:
//   0                                                              no error, but no text found
//   n > 0                        n characters found (including spaces and returns)
//  -1                                                              OCR services not available
//  -3                                                              invalid or null image
//  -5                                                              internal error or error returned by OCR engine
//
// In case of error, call TWAIN_ReportLastError to display details,
// or call TWAIN_LastErrorCode and related functions.

FUNCTION String OCR_Text() &
   LIBRARY "Eztwain4.dll" ALIAS FOR "OCR_Text;ansi"
// Return the text found by the last OCR_RecognizeDib
// If there is any problem of any kind, returns the empty string.

FUNCTION Long OCR_GetText(ref String TextBuffer, Long nBufLen) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "OCR_GetText;ansi"
// Read the text recognized by the last OCR_RecognizeDib
// into the TextBuffer, which is allocated to hold nBufLen chars.
// Returns the number of characters actually returned.
// Always appends a trailing 0 (NUL).
// Will return 0 if the available text does not fit.

FUNCTION Long OCR_TextLength() &
   LIBRARY "Eztwain4.dll"
// Returns the number of characters in OCR_Text.
// Does not count the terminal NUL,
// for those of you working with C-style strings.

FUNCTION Long OCR_TextOrientation() &
   LIBRARY "Eztwain4.dll"
// Returns the orientation of the text found by the last OCR_RecognizeDib.
// The value is the number of degrees clockwise that the input
// image was auto-rotated before OCR was performed.
// Currently, the returned value is always a multiple of 90, so
// the only possible values are 0, 90, 180 and 270.
// Example: If the original was turned 90 degrees clockwise before scanning,
// it will be auto-rotated 90 degrees *counter-clockwise* before OCR, so
// then the value of this function will be 270.

FUNCTION Boolean OCR_GetCharPositions(ref Long charx, ref Long chary) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean OCR_GetCharSizes(ref Long charw, ref Long charh) &
   LIBRARY "Eztwain4.dll"
// Return the coordinates or sizes of the characters found by the last
// OCR_RecognizeDib call.
// For each character of the string returned by OCR_Text or OCR_GetText,
// these functions return the x and y coordinates in the array charx and chary,
// and the width and height in the arrays charw and charh.
// So (charx[i],chary[i]) will be the position of the ith character.
// Coordinates are for the top-left corner of the character, relative
// to the top-left corner of the OCR'd image.
// Width and height are in pixels.
//
// Please make *sure* that you pass in (the address/reference of)
// two arrays allocated to hold n values, where n is the return
// value from the last call to OCR_Recognize.

SUBROUTINE OCR_GetResolution(ref Double xdpi, ref Double ydpi) &
   LIBRARY "Eztwain4.dll"
// Return the resolution (in DPI) of the last image given to OCR_RecognizeDib.
// Useful for translating pixel coordinates and sizes into physical (inch) values.

SUBROUTINE OCR_ClearText() &
   LIBRARY "Eztwain4.dll"
// Clear any currently stored OCR text.

FUNCTION Boolean OCR_WritePage(Long hdib) &
   LIBRARY "Eztwain4.dll"
// If an OCR engine is selected and available, and there is
// a PDF file open for writing (by TWAIN_BeginMultipageFile), then
// this function OCRs the image, and writes both the image and
// the text to the output PDF.
//
// Returns TRUE if successful, FALSE otherwise:
// In case of error, call TWAIN_ReportLastError to display details,
// or call TWAIN_LastErrorCode and related functions.

FUNCTION Boolean OCR_WriteTextToPDF() &
   LIBRARY "Eztwain4.dll"
// Write the text from the last OCR to the next PDF page.
// Returns TRUE if successful, FALSE in case of error.
// If there is no OCR text to write, does nothing & returns TRUE.

SUBROUTINE OCR_SetAutoRotatePagesToPDF(Boolean bYes) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean OCR_GetAutoRotatePagesToPDF() &
   LIBRARY "Eztwain4.dll"
// Get/Get a global option 'Auto Rotate Pages to PDF' that affects
// output of OCR'd text and images to PDF.
//
// When this option is set, OCR_WritePage and OCR_WriteTextToPDF use the
// orientation of any OCR'd text to rotate each page so text is 'upright'.
// This requires rotating both the text and image on each affected page.
// Of course any functions that call those functions are also affected.

//--------- Fun With Containers --------

// Capability values are passed thru the TWAIN API in complex global
// memory structures called 'containers'.  EZTWAIN abstracts these
// containers with a handle (an integer) called an HCONTAINER.
// If you are coding in VB or similar, this is a 32-bit integer.
// The following functions provide reasonably comprehensive access
// to the contents of containers.  See also TWAIN_Get, TWAIN_Set.
//
// There are four shapes of containers, which I call 'formats'.
// Depending on its format, a container holds some 'items' - these
// are simple data values, all the same type in a given container.
// Item types are enumerated by TWTY_*

// Container formats, same codes as in TWAIN.H
//CONSTANT Long TWON_ARRAY = 3
//CONSTANT Long TWON_ENUMERATION = 4
//CONSTANT Long TWON_ONEVALUE = 5
//CONSTANT Long TWON_RANGE = 6


SUBROUTINE CONTAINER_Free(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Free the memory and resources of a capability container.

FUNCTION Long CONTAINER_Copy(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Create an exact copy of the container.

FUNCTION Boolean CONTAINER_Equal(Long hconA, Long hconB) &
   LIBRARY "Eztwain4.dll"
// Return TRUE (1) iff all properties of hconA and hconB are the same.

FUNCTION Long CONTAINER_Format(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Return the 'format' of this container: TWON_ONEVALUE, etc.

FUNCTION Long CONTAINER_ItemCount(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Return the number of values in the container.
// For a ONEVALUE, return 1.

FUNCTION Long CONTAINER_ItemType(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Return the item type (what exact kind of values are in the container.)
// See the TWTY_* definitions in TWAIN.H

FUNCTION Long CONTAINER_TypeSize(Long nItemType) &
   LIBRARY "Eztwain4.dll"
// Return the size in bytes of an item of the specified type (TWTY_*)

SUBROUTINE CONTAINER_GetStringValue(Long hcon, Long n, ref String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "CONTAINER_GetStringValue;ansi"
FUNCTION Double CONTAINER_FloatValue(Long hcon, Long n) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_IntValue(Long hcon, Long n) &
   LIBRARY "Eztwain4.dll"
FUNCTION String CONTAINER_StringValue(Long hcon, Long n) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "CONTAINER_StringValue;ansi"
// Get the value of the nth item in the container.
// n is forced into the range 0 to ItemCount(hcon)-1.
// For string values, if the container items are not strings, they
// are converted to an equivalent string (e.g. "TRUE", "23", "2.37", etc.)


FUNCTION Boolean CONTAINER_ContainsValue(Long hcon, Double d) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean CONTAINER_ContainsValueInt(Long hcon, Long n) &
   LIBRARY "Eztwain4.dll"
// Return TRUE(1) if the value is one of the items in the container.
FUNCTION Long CONTAINER_FindValue(Long hcon, Double d) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_FindValueInt(Long hcon, Long n) &
   LIBRARY "Eztwain4.dll"
// Return the 0-origin index of the value in the container.
// Return -1 if not found.

FUNCTION Double CONTAINER_CurrentValue(Long hcon) &
   LIBRARY "Eztwain4.dll"
FUNCTION Double CONTAINER_DefaultValue(Long hcon) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_CurrentValueInt(Long hcon) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_DefaultValueInt(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Return the container's current or power-up (default) value.
// Array containers do not have these and will return -1.0.
// OneValue containers always return their (one) value.

FUNCTION Long CONTAINER_DefaultIndex(Long hcon) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_CurrentIndex(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Return the index of the Default or Current value.
// Works on Enumerations, Ranges and OneValues.
// (Always returns 0 for a OneValue)
// Returns -1 for an Array.


FUNCTION Double CONTAINER_MinValue(Long hcon) &
   LIBRARY "Eztwain4.dll"
FUNCTION Double CONTAINER_MaxValue(Long hcon) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_MinValueInt(Long hcon) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_MaxValueInt(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Return the smallest/largest value in the container.
// For a OneValue, this is just the value.
// For a Range, these are the Min and Max values of the range.
// For an Array or Enumeration, the container is searched to find
// the smallest/largest value.

FUNCTION Double CONTAINER_StepSize(Long hcon) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_StepSizeInt(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Return the 'step' value of a Range container.
// Returns -1 if the container is not a Range.

// The following four functions create containers from scratch:
// nItemType is one of the TWTY_* item types from TWAIN.H
// nItems is the number of items, in an array or enumeration.
// dMin, dMax, dStep are the beginning, ending, and step value of a range.
FUNCTION Long CONTAINER_OneValue(Long nItemType, Double dVal) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_Range(Long nItemType, Double dMin, Double dMax, Double dStep) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_Array(Long nItemType, Long nItems) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long CONTAINER_Enumeration(Long nItemType, Long nItems) &
   LIBRARY "Eztwain4.dll"

FUNCTION Boolean CONTAINER_SetItem(Long hcon, Long n, Double dVal) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean CONTAINER_SetItemInt(Long hcon, Long n, Long nVal) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean CONTAINER_SetItemString(Long hcon, Long n, String sVal) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "CONTAINER_SetItemString;ansi"
FUNCTION Boolean CONTAINER_SetItemFrame(Long hcon, Long n, Double l, Double t, Double r, Double b) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean CONTAINER_GetItemFrame(Long hcon, Long n, ref Double L, ref Double T, ref Double R, ref Double B) &
   LIBRARY "Eztwain4.dll"
// Set(or get) the nth item of the container to dVal or pzText, or frame(l,t,r,b).
// NOTE: A OneValue is treated as an array with 1 element. 
// Return TRUE(1) if successful. FALSE(0) for error such as:
//    The container is not an array, enumeration, or onevalue
//    n < 0 or n >= CONTAINER_ItemCount(hcon)
//    the value cannot be represented in this container's ItemType.
// Frame operations fail if the CONTAINER_ItemType is not TWTY_FRAME.

FUNCTION Boolean CONTAINER_SelectCurrentValue(Long hcon, Double dVal) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean CONTAINER_SelectCurrentItem(Long hcon, Long n) &
   LIBRARY "Eztwain4.dll"
// Select the current value within an enumeration or range,
// by specifying either the value, or its index.
// Returns TRUE(1) if successful, FALSE(0) otherwise.
// This will fail if:
//    The container is not an enumeration or range.
//    dVal is not one of the values in the container
//    n < 0 or n >= CONTAINER_ItemCount(hcon)

FUNCTION Boolean CONTAINER_SelectDefaultValue(Long hcon, Double dVal) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean CONTAINER_SelectDefaultItem(Long hcon, Long n) &
   LIBRARY "Eztwain4.dll"
// Select the default value in an enumeration or range.
// We're not sure what this would be good for, since an application
// cannot change the default value of a capability - that value is
// determined by the device TWAIN driver.
// So these functions are for logical completeness only.

FUNCTION Boolean CONTAINER_DeleteItem(Long hcon, Long n) &
   LIBRARY "Eztwain4.dll"
// Delete the nth item from an Array or Enumeration container.
// Returns TRUE(1) for success, FALSE(0) otherwise. Failure causes:
//   invalid container handle
//   container is not an array or enumeration
//   n < 0 or n >= ItemCount(hcon)

FUNCTION Boolean CONTAINER_InsertItem(Long hcon, Long n, Double dVal) &
   LIBRARY "Eztwain4.dll"
// Insert an item with value dVal into the container at position n.
// If n < 0, the item is inserted at the end of the container.
// Return TRUE(1) on success, FALSE(0) on failure.
// Possible causes of failure:
//   NULL or invalid container handle
//   container format is not enumeration or array
//   memory allocation failed - heap corrupted, or out of memory.

//--- Very low level CONTAINER functions you probably won't need:
FUNCTION Long CONTAINER_Wrap(Long nFormat, Long hcon) &
   LIBRARY "Eztwain4.dll"
// Wrap a TWAIN container handle into an HCONTAINER object.
// Note: *Do Not* free the hcon - it is now owned by the HCONTAINER.
FUNCTION Long CONTAINER_Unwrap(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Unwrap a TWAIN container from an HCONTAINER object - free the
// HCONTAINER and return the original TWAIN container handle.
FUNCTION Long CONTAINER_Handle(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Retrieve the handle of the TWAIN container wrapped in our HCONTAINER
FUNCTION Boolean CONTAINER_IsValid(Long hcon) &
   LIBRARY "Eztwain4.dll"
// Return TRUE if the argument seems to be a valid HCONTAINER object.

//--------- Low-level Capability Negotiation Functions --------

// Setting a capability is valid only in State 4 (TWAIN_SOURCE_OPEN)
// Getting a capability is valid in State 4 or any higher state.

FUNCTION Boolean TWAIN_IsCapAvailable(Long uCap) &
   LIBRARY "Eztwain4.dll"
// Test if open device responds to a 'Get' on a capability.
// Only valid in State 4 or higher.
// Returns TRUE(1) if the capability can be queried, FALSE(0) if not.

FUNCTION Long TWAIN_Get(Long uCap) &
   LIBRARY "Eztwain4.dll"
// Issue a DAT_CAPABILITY/MSG_GET to the open source.
// Return a capability 'container' - the 'MSG_GET' value of the capability.
// Use CONTAINER_* functions to examine and modify the container object.
// Use CONTAINER_Free to release it when you are done with it.
// A return value of 0 indicates failure:  Call GetConditionCode
// or ReportLastError above.

FUNCTION Long TWAIN_GetDefault(Long uCap) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetCurrent(Long uCap) &
   LIBRARY "Eztwain4.dll"
// Issue a DAT_CAPABILITY/MSG_GETDEFAULT or MSG_GETCURRENT.  See Get above.

FUNCTION Boolean TWAIN_Set(Long uCap, Long hcon) &
   LIBRARY "Eztwain4.dll"
// Issue a DAT_CAPABILITY/MSG_SET to the open source,
// using the specified capability and container.
// Return value as for TWAIN_DS

FUNCTION Boolean TWAIN_Reset(Long uCap) &
   LIBRARY "Eztwain4.dll"
// Issue a MSG_RESET on the specified capability.
// State must be 4.  Returns TRUE(1) if successful, FALSE(0) otherwise.

FUNCTION Long TWAIN_QuerySupport(Long uCap) &
   LIBRARY "Eztwain4.dll"
// Issue a MSG_QUERYSUPPORT on the specified capability.
// State must be 4 or higher.  Returns the integer value that the device
// returned, which can be 0.
// A return < 0 indicates an error.

FUNCTION Boolean TWAIN_SetCapability(Long cap, Double dValue) &
   LIBRARY "Eztwain4.dll"
// The most general capability-setting function, it negotiates
// with the open device to set the given capability to the specified value.
// If successful, returns TRUE(1), otherwise FALSE(0).
// There must be a device open and in state 4, or an error is recorded.
// (See TWAIN_ReportLastError.)

FUNCTION Boolean TWAIN_SetCapString(Long cap, String sValue) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetCapString;ansi"
// Set the value of a capability that takes a string value.
// You don't need to specify the 'itemType', EZTwain asks the driver
// which itemType it wants.

FUNCTION Boolean TWAIN_SetCapBool(Long cap, Boolean bValue) &
   LIBRARY "Eztwain4.dll"
// Shorthand for TWAIN_SetCapOneValue(cap, TWTY_BOOL, bValue);

FUNCTION Boolean TWAIN_GetCapBool(Long cap, Boolean bDefault) &
   LIBRARY "Eztwain4.dll"
FUNCTION Double TWAIN_GetCapFix32(Long cap, Double dDefault) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetCapUint16(Long cap, Long nDefault) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetCapUint32(Long cap, Long lDefault) &
   LIBRARY "Eztwain4.dll"
// Issue a DAT_CAPABILITY/MSG_GETCURRENT on the specified capability,
// assuming the value type is Bool, Fix32, etc..
// If successful, return the returned value.  Otherwise return bDefault.
// This is only valid in State 4 (TWAIN_SOURCE_OPEN) or higher.

FUNCTION Boolean TWAIN_SetCapFix32(Long Cap, Double dVal) &
   LIBRARY "Eztwain4.dll"
FUNCTION Boolean TWAIN_SetCapOneValue(Long Cap, Long ItemType, Long ItemVal) &
   LIBRARY "Eztwain4.dll"
// Do a DAT_CAPABILITY/MSG_SET, on capability 'Cap' (e.g. ICAP_PIXELTYPE,
// CAP_AUTOFEED, etc.) using a TW_ONEVALUE container with the given item type
// and value.  Use SetCapFix32 for capabilities that take a FIX32 value,
// use SetCapOneValue for the various ints and uints.  These functions
// do not support FRAME or STR items.
// Return Value: TRUE (1) if successful, FALSE (0) otherwise.

FUNCTION Boolean TWAIN_SetCapFix32R(Long Cap, Long Numerator, Long Denominator) &
   LIBRARY "Eztwain4.dll"
// Just like TWAIN_SetCapFix32, but uses the value Numerator/Denominator
// This is useful for languages that make it hard to pass double parameters.

FUNCTION Boolean TWAIN_GetCapCurrent(Long Cap, Long ItemType, ref String pVal) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetCapCurrent;ansi"
// Do a DAT_CAPABILITY/MSG_GETCURRENT on capability 'Cap'.
// Copy the current value out of the returned container into *pVal.
// If the operation fails (the source refuses the request), or if the
// container is not a ONEVALUE or ENUMERATION, or if the item type of the
// returned container is incompatible with the expected TWTY_ type in nType,
// returns FALSE.  If this function returns FALSE, *pVal is not touched.

FUNCTION Long TWAIN_ToFix32(Double d) &
   LIBRARY "Eztwain4.dll"
// Convert a floating-point value to a 32-bit TW_FIX32 value that can be passed
// to e.g. TWAIN_SetCapOneValue
FUNCTION Long TWAIN_ToFix32R(Long Numerator, Long Denominator) &
   LIBRARY "Eztwain4.dll"
// Convert a rational number to a 32-bit TW_FIX32 value.
// Returns a TW_FIX32 value that approximates Numerator/Denominator

FUNCTION Double TWAIN_Fix32ToFloat(Long nfix) &
   LIBRARY "Eztwain4.dll"
// Convert a TW_FIX32 value (as returned from some capability inquiries)
// to a double (floating point) value.


//--------- Custom DS Data
//
// The following functions support the CUSTOMDSDATA feature
// introduced in TWAIN 1.7.  This is an optional feature - many document
// scanners support it, and some flatbeds.  It allows an application to
// capture a snapshot of a particular device's settings, and then to restore
// that state at a later time.  It is particularly useful in conjunction
// with TWAIN_DoSettingsDialog, q.v.
//
// Note: The format of the custom data is not defined or restricted by TWAIN
// so typically differs between vendors and even between scanner models.
// It is also *not* restricted to be ANSI text, although most vendors seem to
// use a text format.
//
// To find out if a device supports this feature, open the device and see if
// TWAIN_GetCapBool(CAP_CUSTOMDSDATA, FALSE) returns TRUE.
//
// These are valid only in TWAIN_State() = 4 (TWAIN_SOURCE_OPEN)
//
FUNCTION Boolean TWAIN_GetCustomDataToFile(String sFilename) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetCustomDataToFile;ansi"
FUNCTION Boolean TWAIN_SetCustomDataFromFile(String sFilename) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetCustomDataFromFile;ansi"
// Get or Set the 'custom data' of the currently open device, if supported,
// by writing it to, or reading it from, a file.
//
// If the device supports it, Get will save the entire settings-state of
// the device into the file. Set will restore all settings of the device
// from those saved in the file.
//
// Both functions return TRUE(1) if successful, FALSE(0) otherwise.
// These functions record an error and return FALSE if called outside State 4.
// In case of failure, call LastErrorCode, ReportLastError, etc. for details.
// No file extension is assumed, you should provide one, such as ".dat".

FUNCTION Boolean TWAIN_SetCustomData(String data, Long nbytes) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetCustomData;ansi"
// Same as TWAIN_SetCustomDataFromFile, but from a buffer in memory.

FUNCTION Long TWAIN_GetCustomData(ref String buffer, Long bufsize) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetCustomData;ansi"
// Read device custom data into a buffer in memory, up to bufsize bytes.
// Returns the size of the actual data, if successful.
// Returns 0 if the device doesn't support this, no device open, etc.

FUNCTION String TWAIN_CustomData() &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_CustomData;ansi"
// Reads the custom data from the device and returns a pointer to it.
// This works best if you know the custom data is 8-bit text.

//--------- Extended Image Info
//
// The following functions support the 'Extended Image Info' feature of TWAIN,
// which is implemented by only a few TWAIN drivers.  This consists of special
// information, sometimes called 'metadata' which can be collected about
// each scanned image, in addition to the image itself.
// Examples of extended image info include
// TWEI_BARCODETEXT - text of a barcode found in the scan
// TWEI_SKEWORIGINALANGLE - the amount of 'skew' in the original raw scan
// See the TWAIN Specification (version 1.9 or later) for details.

FUNCTION Boolean TWAIN_IsExtendedInfoSupported() &
   LIBRARY "Eztwain4.dll"
// Asks the currently open device if it supports Extended Image Info.
// Returns TRUE(1) if yes, FALSE(0) if not.

FUNCTION Boolean TWAIN_EnableExtendedInfo(Long eiCode, Boolean enabled) &
   LIBRARY "Eztwain4.dll"
// Enable or disable collection of a particular kind of extended image info.
// Each type of information is represented by an integer constant with
// prefix TWEI_ see the list of constants elsewhere in this file.
// There is a limit to how many different info types can be enabled at the
// same time.  If this limit is exceeded, this function returns FALSE
// and has no effect.  Otherwise (if successful) it returns TRUE.

FUNCTION Boolean TWAIN_IsExtendedInfoEnabled(Long eiCode) &
   LIBRARY "Eztwain4.dll"
// Return TRUE if the specified extended image type is enabled
// (for collection)

SUBROUTINE TWAIN_DisableExtendedInfo() &
   LIBRARY "Eztwain4.dll"
// Disables all extended image info - none is collected after this.

// After a successful scan, you can use the following functions to
// retrieve the extended image info associated with that scan:
FUNCTION Long TWAIN_ExtendedInfoItemCount(Long eiCode) &
   LIBRARY "Eztwain4.dll"
// Return the number of items of data available of the given info type.

FUNCTION Long TWAIN_ExtendedInfoItemType(Long eiCode) &
   LIBRARY "Eztwain4.dll"
// Return a number indicating the type of data returned for the specified extended info.
// Returns the same TWTY_ codes as CONTAINER_ItemType.

FUNCTION Long TWAIN_ExtendedInfoInt(Long eiCode, Long n) &
   LIBRARY "Eztwain4.dll"
// Return the (integer) value of the 'nth' item of the specified extended info.
// Note: n=0 for first item.

FUNCTION Double TWAIN_ExtendedInfoFloat(Long eiCode, Long n) &
   LIBRARY "Eztwain4.dll"
// Return the (floating point) value of the 'nth' item of the specified extended info.
// Note: n=0 for first item.

FUNCTION Boolean TWAIN_GetExtendedInfoString(Long eiCode, Long n, ref String Buffer, Long Bufsize) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetExtendedInfoString;ansi"
// Read the (string) value of the nth item of the specified info type into Buffer,
// which has been allocated by the caller to hold Bufsize characters.
// Note: n=0 for first item.
// Note that the value returned is ASCII (byte) text, not unicode, and *always*
// includes an ending 0 byte, even if it must be truncated to fit.
// Returns TRUE if the data was retrieved and could fit in the buffer.
// Returns FALSE otherwise.

FUNCTION String TWAIN_ExtendedInfoString(Long eiCode, Long n) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_ExtendedInfoString;ansi"
// As above, but the string is returned as a temporary pointer to a
// 0-terminated ASCII string.
// In case of any failure, returns the empty string ("").

FUNCTION Boolean TWAIN_GetExtendedInfoFrame(Long eiCode, Long n, ref Double L, ref Double T, ref Double R, ref Double B) &
   LIBRARY "Eztwain4.dll"
// Fetch the TW_FRAME value of the 'nth' item of the specified extended info.
// Note: n=0 for first item.
// This is rarely used, but is here for completeness.

// Extended Image Info codes
//CONSTANT Long TWEI_MIN = 4608

//CONSTANT Long TWEI_BARCODEX = 4608
//CONSTANT Long TWEI_BARCODEY = 4609
//CONSTANT Long TWEI_BARCODETEXT = 4610
//CONSTANT Long TWEI_BARCODETYPE = 4611
//CONSTANT Long TWEI_DESHADETOP = 4612
//CONSTANT Long TWEI_DESHADELEFT = 4613
//CONSTANT Long TWEI_DESHADEHEIGHT = 4614
//CONSTANT Long TWEI_DESHADEWIDTH = 4615
//CONSTANT Long TWEI_DESHADESIZE = 4616
//CONSTANT Long TWEI_SPECKLESREMOVED = 4617
//CONSTANT Long TWEI_HORZLINEXCOORD = 4618
//CONSTANT Long TWEI_HORZLINEYCOORD = 4619
//CONSTANT Long TWEI_HORZLINELENGTH = 4620
//CONSTANT Long TWEI_HORZLINETHICKNESS = 4621
//CONSTANT Long TWEI_VERTLINEXCOORD = 4622
//CONSTANT Long TWEI_VERTLINEYCOORD = 4623
//CONSTANT Long TWEI_VERTLINELENGTH = 4624
//CONSTANT Long TWEI_VERTLINETHICKNESS = 4625
//CONSTANT Long TWEI_PATCHCODE = 4626
//CONSTANT Long TWEI_ENDORSEDTEXT = 4627
//CONSTANT Long TWEI_FORMCONFIDENCE = 4628
//CONSTANT Long TWEI_FORMTEMPLATEMATCH = 4629
//CONSTANT Long TWEI_FORMTEMPLATEPAGEMATCH = 4630
//CONSTANT Long TWEI_FORMHORZDOCOFFSET = 4631
//CONSTANT Long TWEI_FORMVERTDOCOFFSET = 4632
//CONSTANT Long TWEI_BARCODECOUNT = 4633
//CONSTANT Long TWEI_BARCODECONFIDENCE = 4634
//CONSTANT Long TWEI_BARCODEROTATION = 4635
//CONSTANT Long TWEI_BARCODETEXTLENGTH = 4636
//CONSTANT Long TWEI_DESHADECOUNT = 4637
//CONSTANT Long TWEI_DESHADEBLACKCOUNTOLD = 4638
//CONSTANT Long TWEI_DESHADEBLACKCOUNTNEW = 4639
//CONSTANT Long TWEI_DESHADEBLACKRLMIN = 4640
//CONSTANT Long TWEI_DESHADEBLACKRLMAX = 4641
//CONSTANT Long TWEI_DESHADEWHITECOUNTOLD = 4642
//CONSTANT Long TWEI_DESHADEWHITECOUNTNEW = 4643
//CONSTANT Long TWEI_DESHADEWHITERLMIN = 4644
//CONSTANT Long TWEI_DESHADEWHITERLAVE = 4645
//CONSTANT Long TWEI_DESHADEWHITERLMAX = 4646
//CONSTANT Long TWEI_BLACKSPECKLESREMOVED = 4647
//CONSTANT Long TWEI_WHITESPECKLESREMOVED = 4648
//CONSTANT Long TWEI_HORZLINECOUNT = 4649
//CONSTANT Long TWEI_VERTLINECOUNT = 4650
//CONSTANT Long TWEI_DESKEWSTATUS = 4651
//CONSTANT Long TWEI_SKEWORIGINALANGLE = 4652
//CONSTANT Long TWEI_SKEWFINALANGLE = 4653
//CONSTANT Long TWEI_SKEWCONFIDENCE = 4654
//CONSTANT Long TWEI_SKEWWINDOWX1 = 4655
//CONSTANT Long TWEI_SKEWWINDOWY1 = 4656
//CONSTANT Long TWEI_SKEWWINDOWX2 = 4657
//CONSTANT Long TWEI_SKEWWINDOWY2 = 4658
//CONSTANT Long TWEI_SKEWWINDOWX3 = 4659
//CONSTANT Long TWEI_SKEWWINDOWY3 = 4660
//CONSTANT Long TWEI_SKEWWINDOWX4 = 4661
//CONSTANT Long TWEI_SKEWWINDOWY4 = 4662
//CONSTANT Long TWEI_BOOKNAME = 4664
//CONSTANT Long TWEI_CHAPTERNUMBER = 4665
//CONSTANT Long TWEI_DOCUMENTNUMBER = 4666
//CONSTANT Long TWEI_PAGENUMBER = 4667
//CONSTANT Long TWEI_CAMERA = 4668
//CONSTANT Long TWEI_FRAMENUMBER = 4669
//CONSTANT Long TWEI_FRAME = 4670
//CONSTANT Long TWEI_PIXELFLAVOR = 4671
//CONSTANT Long TWEI_ICCPROFILE = 4672
//CONSTANT Long TWEI_LASTSEGMENT = 4673
//CONSTANT Long TWEI_SEGMENTNUMBER = 4674
//CONSTANT Long TWEI_MAGDATA = 4675
//CONSTANT Long TWEI_MAGTYPE = 4676
//CONSTANT Long TWEI_PAGESIDE = 4677
//CONSTANT Long TWEI_FILESYSTEMSOURCE = 4678

//CONSTANT Long TWEI_MAX = 4678


//--------- Lowest-level functions for TWAIN protocol --------


FUNCTION Boolean TWAIN_DS(Long DG, Long DAT, Long MSG, ref String pData) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_DS;ansi"
// Pass the triplet (DG, DAT, MSG, pData) to the open data source if any.
// Returns TRUE(1) if the result code is TWRC_SUCCESS, FALSE(0) otherwise.
// The last result code can be retrieved with TWAIN_GetResultCode(), and the
// corresponding condition code can be retrieved with TWAIN_GetConditionCode().
// If no source is open this call will fail, result code TWRC_FAILURE,
// condition code TWCC_NODS.

FUNCTION Boolean TWAIN_Mgr(Long DG, Long DAT, Long MSG, ref String pData) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_Mgr;ansi"
// Pass a triplet to the Data Source Manager (DSM).
// Returns TRUE(1) for success, FALSE(0) otherwise.
// See GetResultCode, GetConditionCode, and ReportLastError functions
// for diagnosing and reporting a TWAIN_Mgr failure.
// If the Source Manager is not open, this call fails setting result code
// TWRC_FAILURE, and condition code=TWCC_SEQERROR (triplet out of sequence).


//---------  Diagnostic Logging

SUBROUTINE TWAIN_LogFile(Long fLog) &
   LIBRARY "Eztwain4.dll"
// Turn logging eztwain.log on or off.
// By default the log file is written to C:\ but this
// can be overridden, see TWAIN_SetLogFolder below.
//
// fLog = 0    close log file and turn off logging
// The following flags can be combined to enable logging:
// 1            basic logging of TWAIN and EZTwain operations.
// 2            flush log constantly (use if EZTwain crashes)
// 4            log Windows messages flowing through EZTwain
//CONSTANT Long EZT_LOG_ON = 1
//CONSTANT Long EZT_LOG_FLUSH = 2
//CONSTANT Long EZT_LOG_DETAIL = 4


FUNCTION Boolean TWAIN_SetLogFolder(String sFolder) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetLogFolder;ansi"
// Specify the folder (directory) where the log file
// should be placed.  Default is "c:\" - the root of the C: drive.
// EZTwain appends a trailing 'slash' if needed.
// Passing NULL or "" resets to the default: "c:\"
//
// If the file cannot be created in this folder, EZTwain tries
// to create it in the Windows temp folder - this varies somewhat
// by Windows version, search for the Windows API call GetTempPath.

FUNCTION Boolean TWAIN_SetLogName(String sName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_SetLogName;ansi"
// Set the filename or path & filename of the EZTwain log file.
// If there is a log file open, it is closed, renamed & re-opened.
// The default extension is ".log".
// The default log filename is "eztwain.log".
//
// You can specify a fully-qualified filename, which changes
// both the folder and filename for logging:
// TWAIN_SetLogName("c:\temp\scan2tape.log")

FUNCTION String TWAIN_LogFileName() &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_LogFileName;ansi"
// Return the (fully qualified) file path and name for logging.

SUBROUTINE TWAIN_WriteToLog(String sText) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_WriteToLog;ansi"
// Write text to the EZTwain log file (c:\eztwain.log)
// If the text does not end with a newline, one is supplied.
// If logging is turned off, this call has no effect.
// Logging is controlled by TWAIN_LogFile - see above.


//--------- Advanced / Exotic --------

// Functions to do a memory transfer in individual blocks:
FUNCTION Boolean TWAIN_BeginAcquireMemory(Long hwnd, Long nRows) &
   LIBRARY "Eztwain4.dll"
// Begin a memory transfer.
// Returns TRUE(1) if the transfer is ready to proceed (using
// TWAIN_AcquireMemoryBlock, below.)
// Returns FALSE(0) if the transfer could not be started for some reason.
//
// Loads TWAIN if necessary, opens the default source if no source is open.
// If it opens a source, it negotiates any 'pending' settings (resolution,
// pixel type, etc.) that were specified before the device was open.
// Enables the device if not already enabled.
// Waits for a 'transfer ready' message from the device.
// Tells the driver to begin transferring in blocks of nRows rows or less.
// If nRows is <= 0, lets the driver pick the optimal block size.

FUNCTION Long TWAIN_AcquireMemoryBlock() &
   LIBRARY "Eztwain4.dll"
// Acquire the next block of data in a memory transfer.
// If there is an error or there is no more data, returns NULL(0).
// Only valid after a successful call to TWAIN_BeginAcquireMemory (above.)
// Asks the device to deliver another block of pixels, and returns
// those pixels as a DIB represented by its handle.  This is the same
// image format returned by TWAIN_Acquire, TWAIN_AcquireMemory, etc.
// See the DIB_* functions for what can be done with the returned handle.

FUNCTION Boolean TWAIN_EndAcquireMemory() &
   LIBRARY "Eztwain4.dll"
// Clean up after a block-by-block memory transfer.
// Only valid after a successful call to TWAIN_BeginAcquireMemory (above.)
// Frees any temporary storage, and tells the device the transfer
// is over.  In Multi-transfer mode, the device will move to
// State 6 if more images are available, or State 5 if not.
// In single-transfer mode (the default) the device is automatically closed.


FUNCTION Boolean TWAIN_AcquireFile(Long hwndApp, Long nFF, String sFileName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_AcquireFile;ansi"
// Acquire an image directly to a file using File Transfer Mode.
// Be warned: File Transfer Mode is unusual. TWAIN drivers are not required
// to support it! If they do support it, the only required file format is BMP.
// We recommend not using this function unless you understand the issues
// and have a compelling reason for using this mode.
//
//---- Aliases for TWAIN File Formats
//CONSTANT Long TWAIN_FF_TIFF = 0
//CONSTANT Long TWAIN_FF_PICT = 1
//CONSTANT Long TWAIN_FF_BMP = 2
//CONSTANT Long TWAIN_FF_XBM = 3
//CONSTANT Long TWAIN_FF_JFIF = 4
//CONSTANT Long TWAIN_FF_FPX = 5
//CONSTANT Long TWAIN_FF_TIFFMULTI = 6
//CONSTANT Long TWAIN_FF_PNG = 7
//CONSTANT Long TWAIN_FF_SPIFF = 8
//CONSTANT Long TWAIN_FF_EXIF = 9
//CONSTANT Long TWAIN_FF_PDF = 10
//CONSTANT Long TWAIN_FF_JP2 = 11
//CONSTANT Long TWAIN_FF_JPN = 12
//CONSTANT Long TWAIN_FF_JPX = 13
//CONSTANT Long TWAIN_FF_DEJAVU = 14
//CONSTANT Long TWAIN_FF_PDFA = 15
//
// * Unlike AcquireToFilename, this function uses TWAIN File Transfer Mode.
// * The image is written to disk by the Data Source, not by EZTWAIN.
// * Warning: This mode is -not- supported by all TWAIN devices.
// 
// Use TWAIN_SupportsFileXfer to see if the open DS supports File Transfer.
//
// You can use TWAIN_Get(ICAP_IMAGEFILEFORMAT) to get an enumeration of
// the available file formats, and CONTAINER_ContainsValue to check for
// a particular format you are interested in.
//
// If the filename is NULL or an empty string, this functions prompts for
// the file name in a standard Save File dialog.
//
// Note Boolean return value!
//  TRUE(1) for success
//  FALSE(0) for failure - use GetResultCode/GetConditionCode for details.
//  If the user cancels the Save File dialog, GetResultCode will be TWRC_CANCEL

FUNCTION Long TWAIN_SetImageReadyTimeout(Long nSec) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetImageReadyTimeout() &
   LIBRARY "Eztwain4.dll"
// Set the maximum seconds to wait for an image-ready notification,
// (when one is expected i.e. after an enable) before posting a
// dialog that says 'Waiting for <device>' - with a Cancel button.
// Returns the previous setting.
// ** Default is -1 which disables this feature.
// With certain scanners there is a long delay between when the scanner
// is enabled and when it says "ready to scan".  Also, we have found
// a few scanners that intermittently fail to send "ready to scan" - by
// setting this timeout, you give your users a way to recover from
// this failure (otherwise the application has to be forcibly terminated.)

SUBROUTINE TWAIN_AutoClickButton(String sButtonName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_AutoClickButton;ansi"
// Calling this function before scanning tells EZTwain to attempt to
// automatically press a button when the device dialog appears.
// If you pass a null button name, EZTwain tries a number
// of likely choices (in English) including:
// "Scan" "Capture" "Acquire" "Scan Now" "Start Scan"  "Start Scanning"
// Case is ignored in the comparison ("SCAN" and "scan" are equivalent.)
// This function is useful when you want to automate operation of
// a device that insists on showing its user interface. 

SUBROUTINE TWAIN_BreakModalLoop() &
   LIBRARY "Eztwain4.dll"
// Expert: If EZTwain is hung inside an Acquire or GetMessage loop waiting for
// something to happen, this function will break the loop, as if the pending
// transfer had failed.  TWAIN_State() will be valid, and you will need to
// call appropriate functions to transition TWAIN as desired.

SUBROUTINE TWAIN_EmptyMessageQueue() &
   LIBRARY "Eztwain4.dll"
// Expert: Get and process any pending Windows messages for this thread.
// For example, keystrokes or mouse clicks.  Calling this during
// long processes will allow the user to interact with the UI.
// Use only if you understand the message pump.

FUNCTION String TWAIN_BuildName() &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_BuildName;ansi"
// Return a string describing the build of EZTWAIN e.g. "Release - Build 6"

SUBROUTINE TWAIN_GetBuildName(ref String sName) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetBuildName;ansi"
// Like TWAIN_BuildName, but copies the build string into its parameter.
// The parameter is a string variable (char array in C/C++).
// You are responsible for allocating room for 128 8-bit characters
// in the string variable before calling this function.

FUNCTION Long TWAIN_GetSourceIdentity(ref String ptwid) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetSourceIdentity;ansi"

FUNCTION Long TWAIN_GetImageInfo(ref String ptwinfo) &
   LIBRARY "Eztwain4.dll" ALIAS FOR "TWAIN_GetImageInfo;ansi"
// Issue a DG_IMAGE / DAT_IMAGEINFO / MSG_GET placing the returned data
// at ptwinfo.  The returned structure is a TW_IMAGEINFO - see twain.h.

FUNCTION Long TWAIN_SelfTest(Long f) &
   LIBRARY "Eztwain4.dll"
// Perform internal self-test.
//   f      ignored for now
// Return value:
//   0      success
//   other  internal test failed.

SUBROUTINE TWAIN_SetQAMode(Long nMode) &
   LIBRARY "Eztwain4.dll"
FUNCTION Long TWAIN_GetQAMode() &
   LIBRARY "Eztwain4.dll"
// Used to run validation/regression tests on the library.

FUNCTION Boolean TWAIN_Blocked() &
   LIBRARY "Eztwain4.dll"
// Returns TRUE(1) if processing is inside TWAIN (Source Manager or a DS)
// FALSE(0) otherwise.  If the former, making any TWAIN call will
// fail immediately or deadlock the application (Not recommended.)


// ----------------------------------------------------
// Deprecated - still work, don't use in new code.
// ----------------------------------------------------


// From twain.h:
//****************************************************************************
//* Capabilities                                                             *
//****************************************************************************

//CONSTANT Long CAP_CUSTOMBASE = 32768

// all data sources are REQUIRED to support these caps 
//CONSTANT Long CAP_XFERCOUNT = 1

// image data sources are REQUIRED to support these caps 
//CONSTANT Long ICAP_COMPRESSION = 256
//CONSTANT Long ICAP_PIXELTYPE = 257
//CONSTANT Long ICAP_UNITS = 258
//CONSTANT Long ICAP_XFERMECH = 259

// all data sources MAY support these caps 
//CONSTANT Long CAP_AUTHOR = 4096
//CONSTANT Long CAP_CAPTION = 4097
//CONSTANT Long CAP_FEEDERENABLED = 4098
//CONSTANT Long CAP_FEEDERLOADED = 4099
//CONSTANT Long CAP_TIMEDATE = 4100
//CONSTANT Long CAP_SUPPORTEDCAPS = 4101
//CONSTANT Long CAP_EXTENDEDCAPS = 4102
//CONSTANT Long CAP_AUTOFEED = 4103
//CONSTANT Long CAP_CLEARPAGE = 4104
//CONSTANT Long CAP_FEEDPAGE = 4105
//CONSTANT Long CAP_REWINDPAGE = 4106
//CONSTANT Long CAP_INDICATORS = 4107
//CONSTANT Long CAP_SUPPORTEDCAPSEXT = 4108
//CONSTANT Long CAP_PAPERDETECTABLE = 4109
//CONSTANT Long CAP_UICONTROLLABLE = 4110
//CONSTANT Long CAP_DEVICEONLINE = 4111
//CONSTANT Long CAP_AUTOSCAN = 4112
//CONSTANT Long CAP_THUMBNAILSENABLED = 4113
//CONSTANT Long CAP_DUPLEX = 4114
//CONSTANT Long CAP_DUPLEXENABLED = 4115
//CONSTANT Long CAP_ENABLEDSUIONLY = 4116
//CONSTANT Long CAP_CUSTOMDSDATA = 4117
//CONSTANT Long CAP_ENDORSER = 4118
//CONSTANT Long CAP_JOBCONTROL = 4119
//CONSTANT Long CAP_ALARMS = 4120
//CONSTANT Long CAP_ALARMVOLUME = 4121
//CONSTANT Long CAP_AUTOMATICCAPTURE = 4122
//CONSTANT Long CAP_TIMEBEFOREFIRSTCAPTURE = 4123
//CONSTANT Long CAP_TIMEBETWEENCAPTURES = 4124
//CONSTANT Long CAP_CLEARBUFFERS = 4125
//CONSTANT Long CAP_MAXBATCHBUFFERS = 4126
//CONSTANT Long CAP_DEVICETIMEDATE = 4127
//CONSTANT Long CAP_POWERSUPPLY = 4128
//CONSTANT Long CAP_CAMERAPREVIEWUI = 4129
//CONSTANT Long CAP_DEVICEEVENT = 4130
//CONSTANT Long CAP_SERIALNUMBER = 4132
//CONSTANT Long CAP_PRINTER = 4134
//CONSTANT Long CAP_PRINTERENABLED = 4135
//CONSTANT Long CAP_PRINTERINDEX = 4136
//CONSTANT Long CAP_PRINTERMODE = 4137
//CONSTANT Long CAP_PRINTERSTRING = 4138
//CONSTANT Long CAP_PRINTERSUFFIX = 4139
//CONSTANT Long CAP_LANGUAGE = 4140
//CONSTANT Long CAP_FEEDERALIGNMENT = 4141
//CONSTANT Long CAP_FEEDERORDER = 4142
//CONSTANT Long CAP_REACQUIREALLOWED = 4144
//CONSTANT Long CAP_BATTERYMINUTES = 4146
//CONSTANT Long CAP_BATTERYPERCENTAGE = 4147

// image data sources MAY support these caps 
//CONSTANT Long ICAP_AUTOBRIGHT = 4352
//CONSTANT Long ICAP_BRIGHTNESS = 4353
//CONSTANT Long ICAP_CONTRAST = 4355
//CONSTANT Long ICAP_CUSTHALFTONE = 4356
//CONSTANT Long ICAP_EXPOSURETIME = 4357
//CONSTANT Long ICAP_FILTER = 4358
//CONSTANT Long ICAP_FLASHUSED = 4359
//CONSTANT Long ICAP_GAMMA = 4360
//CONSTANT Long ICAP_HALFTONES = 4361
//CONSTANT Long ICAP_HIGHLIGHT = 4362
//CONSTANT Long ICAP_IMAGEFILEFORMAT = 4364
//CONSTANT Long ICAP_LAMPSTATE = 4365
//CONSTANT Long ICAP_LIGHTSOURCE = 4366
//CONSTANT Long ICAP_ORIENTATION = 4368
//CONSTANT Long ICAP_PHYSICALWIDTH = 4369
//CONSTANT Long ICAP_PHYSICALHEIGHT = 4370
//CONSTANT Long ICAP_SHADOW = 4371
//CONSTANT Long ICAP_FRAMES = 4372
//CONSTANT Long ICAP_XNATIVERESOLUTION = 4374
//CONSTANT Long ICAP_YNATIVERESOLUTION = 4375
//CONSTANT Long ICAP_XRESOLUTION = 4376
//CONSTANT Long ICAP_YRESOLUTION = 4377
//CONSTANT Long ICAP_MAXFRAMES = 4378
//CONSTANT Long ICAP_TILES = 4379
//CONSTANT Long ICAP_BITORDER = 4380
//CONSTANT Long ICAP_CCITTKFACTOR = 4381
//CONSTANT Long ICAP_LIGHTPATH = 4382
//CONSTANT Long ICAP_PIXELFLAVOR = 4383
//CONSTANT Long ICAP_PLANARCHUNKY = 4384
//CONSTANT Long ICAP_ROTATION = 4385
//CONSTANT Long ICAP_SUPPORTEDSIZES = 4386
//CONSTANT Long ICAP_THRESHOLD = 4387
//CONSTANT Long ICAP_XSCALING = 4388
//CONSTANT Long ICAP_YSCALING = 4389
//CONSTANT Long ICAP_BITORDERCODES = 4390
//CONSTANT Long ICAP_PIXELFLAVORCODES = 4391
//CONSTANT Long ICAP_JPEGPIXELTYPE = 4392
//CONSTANT Long ICAP_TIMEFILL = 4394
//CONSTANT Long ICAP_BITDEPTH = 4395
//CONSTANT Long ICAP_BITDEPTHREDUCTION = 4396
//CONSTANT Long ICAP_UNDEFINEDIMAGESIZE = 4397
//CONSTANT Long ICAP_IMAGEDATASET = 4398
//CONSTANT Long ICAP_EXTIMAGEINFO = 4399
//CONSTANT Long ICAP_MINIMUMHEIGHT = 4400
//CONSTANT Long ICAP_MINIMUMWIDTH = 4401
//CONSTANT Long ICAP_FLIPROTATION = 4406
//CONSTANT Long ICAP_BARCODEDETECTIONENABLED = 4407
//CONSTANT Long ICAP_SUPPORTEDBARCODETYPES = 4408
//CONSTANT Long ICAP_BARCODEMAXSEARCHPRIORITIES = 4409
//CONSTANT Long ICAP_BARCODESEARCHPRIORITIES = 4410
//CONSTANT Long ICAP_BARCODESEARCHMODE = 4411
//CONSTANT Long ICAP_BARCODEMAXRETRIES = 4412
//CONSTANT Long ICAP_BARCODETIMEOUT = 4413
//CONSTANT Long ICAP_ZOOMFACTOR = 4414
//CONSTANT Long ICAP_PATCHCODEDETECTIONENABLED = 4415
//CONSTANT Long ICAP_SUPPORTEDPATCHCODETYPES = 4416
//CONSTANT Long ICAP_PATCHCODEMAXSEARCHPRIORITIES = 4417
//CONSTANT Long ICAP_PATCHCODESEARCHPRIORITIES = 4418
//CONSTANT Long ICAP_PATCHCODESEARCHMODE = 4419
//CONSTANT Long ICAP_PATCHCODEMAXRETRIES = 4420
//CONSTANT Long ICAP_PATCHCODETIMEOUT = 4421
//CONSTANT Long ICAP_FLASHUSED2 = 4422
//CONSTANT Long ICAP_IMAGEFILTER = 4423
//CONSTANT Long ICAP_NOISEFILTER = 4424
//CONSTANT Long ICAP_OVERSCAN = 4425
//CONSTANT Long ICAP_AUTOMATICBORDERDETECTION = 4432
//CONSTANT Long ICAP_AUTOMATICDESKEW = 4433
//CONSTANT Long ICAP_AUTOMATICROTATE = 4434
//CONSTANT Long ICAP_JPEGQUALITY = 4435

// Container and Extended Info item types:
//CONSTANT Long TWTY_INT8 = 0
//CONSTANT Long TWTY_INT16 = 1
//CONSTANT Long TWTY_INT32 = 2
//CONSTANT Long TWTY_UINT8 = 3
//CONSTANT Long TWTY_UINT16 = 4
//CONSTANT Long TWTY_UINT32 = 5
//CONSTANT Long TWTY_BOOL = 6
//CONSTANT Long TWTY_FIX32 = 7
//CONSTANT Long TWTY_FRAME = 8
//CONSTANT Long TWTY_STR32 = 9
//CONSTANT Long TWTY_STR64 = 10
//CONSTANT Long TWTY_STR128 = 11
//CONSTANT Long TWTY_STR255 = 12
//CONSTANT Long TWTY_STR1024 = 13
//CONSTANT Long TWTY_UNI512 = 14

// ICAP_ORIENTATION values (OR_ means ORientation) 
//CONSTANT Long TWOR_ROT0 = 0
//CONSTANT Long TWOR_ROT90 = 1
//CONSTANT Long TWOR_ROT180 = 2
//CONSTANT Long TWOR_ROT270 = 3



// EZTwain History: See History.txt

end prototypes

type variables
String is_Dispositivo
String is_autorizacao
String is_tipo
String is_caminho
String is_caminho_pre = "C:\sistemas\dll\twain\pre"
String is_retorno
String is_caminho_ftp
String is_ip_ftp = '10.0.4.30'
String is_usuario_ftp
String is_acesso_ftp
String is_info_ftp
String is_arquivo_digitalizado

DateTime idh_emissao
Date idh_movimento
Date idh_movimento_ftp

Boolean ib_envia_ftp = False

end variables

forward prototypes
public function boolean of_grava (long pl_handle)
public function boolean of_trata_retorno (long pl_retorno, ref string ps_msg)
public subroutine of_inicializa ()
public function boolean of_verifica_driver ()
public function boolean of_previsualizar (long pl_handle)
public function boolean of_envia_ftp (string ps_caminho, string ps_arquivo, ref string ps_msg_ftp)
public function boolean of_verifica_arquivos ()
public function boolean of_selecao_dispositivo (boolean ps_troca_dispositivo, long pl_handle)
end prototypes

public function boolean of_grava (long pl_handle);Boolean lb_sucesso
Long ll_retorno
Long ll_controle
Long ll_contador
String ls_erro
String ls_arquivo
String ls_caixa

If This.is_Tipo = 'CAIXA' Then
	ls_caixa 		= Trim(gf_captura_valor(This.is_autorizacao, '|', 1, false))
	ll_controle	= Long(Trim(gf_captura_valor(This.is_autorizacao, '|', 2, false)))
	
	Select max(nr_contador_anexos) Into :ll_contador
	From controle_caixa
	Where cd_caixa          = :ls_Caixa
	  and nr_controle_caixa = :ll_Controle
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(ll_contador) Then ll_contador = 0
			ll_contador ++
		Case 100
			ll_contador = 1
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o contador anexos")
			Return False
	End Choose
	ls_arquivo = ls_caixa + String(ll_controle,'00000') + String(ll_contador,'000')
	This.is_caminho = "C:\Sistemas\RL\docs"
Else
	ls_arquivo = This.is_autorizacao
End If

TWAIN_SetFileAppendFlag(FALSE)

Open(w_Janela_Aguarde)
w_Janela_Aguarde.Wf_Mensagem("Digitalizando Imagem...")			

IF NOT TWAIN_SetAutoScan(FALSE) THEN
	MessageBox("EZTwain", "SetAutoScan(FALSE) failed - scanner cannot single-scan?")
END IF
TWAIN_AutoClickButton("")
ll_retorno = TWAIN_AcquireToFilename(pl_handle, This.is_caminho + '\' + ls_arquivo + '.pdf')
If of_trata_retorno(ll_retorno, Ref ls_erro) Then
	lb_sucesso = True
Else
	lb_sucesso = False
End If

Close(w_Janela_Aguarde)

If lb_sucesso Then
	If This.is_Tipo = 'CAIXA' Then
		Update controle_caixa
		Set nr_contador_anexos = :ll_contador
		Where cd_caixa          = :ls_Caixa
		  and nr_controle_caixa = :ll_Controle
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()	
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do contador de anexos")
			Return False
		Else
			SqlCa.of_Commit()
		End If			
	End If	
	
	Return True	
Else
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_erro, StopSign! )	
	Return False
End If
end function

public function boolean of_trata_retorno (long pl_retorno, ref string ps_msg);Long ll_erro_twain

Choose Case pl_retorno
	Case 0
		Return True
	case -1
		ps_msg = 'Falha na digitaliza$$HEX2$$e700e300$$ENDHEX$$o! Retorno fun$$HEX2$$e700e300$$ENDHEX$$o -1 '		
	case -2
		ps_msg = 'Erro ao abrir o arquivo. Retorno fun$$HEX2$$e700e300$$ENDHEX$$o -2 '
	case -3
		ps_msg = 'Formato incompat$$HEX1$$ed00$$ENDHEX$$vel. Retorno fun$$HEX2$$e700e300$$ENDHEX$$o -3 '
	case -4
		ps_msg = 'Falha ao gravar o arquivo. Retorno fun$$HEX2$$e700e300$$ENDHEX$$o -4 '
	case -10 
		ps_msg = 'Cancelado pelo operador! Retorno fun$$HEX2$$e700e300$$ENDHEX$$o -10 '
	case else
		ps_msg = 'Erro desconhecido na digitaliza$$HEX2$$e700e300$$ENDHEX$$o! Retorno fun$$HEX2$$e700e300$$ENDHEX$$o: ' + String(pl_retorno)
End Choose
 
ll_erro_twain = TWAIN_LastErrorCode()
IF ll_erro_twain <> 0 Or pl_retorno <> 0 THEN
	TWAIN_ReportLastError("Unable to scan.")
	ps_msg = ps_msg + 'C$$HEX1$$f300$$ENDHEX$$digo erro Twain: ' + String(ll_erro_twain)
	Return False
END IF

Return True
end function

public subroutine of_inicializa ();TWAIN_UniversalLicense("CIA Latino Americana de Medicamentos", -748946435) 
SetNull(is_Autorizacao) 
SetNull(is_Dispositivo)
SetNull(is_Tipo)
SetNull(is_Caminho)
SetNull(is_retorno)
SetNull(is_caminho_ftp)
SetNull(is_usuario_ftp)
SetNull(is_acesso_ftp)
SetNull(is_info_ftp)
SetNull(is_arquivo_digitalizado)

SetNull(idh_emissao)
SetNull(idh_movimento)
SetNull(idh_movimento_ftp)

ib_envia_ftp = False
end subroutine

public function boolean of_verifica_driver ();String	ls_Path_dll = 'C:\sistemas\dll\twain'
String ls_Baixar[]
String ls_Validar[]
Boolean lb_Sucesso

ls_Validar = {"Eztwain4.dll", "EZT4Curl.dll", "EZT4Dcx.dll", "EZT4Gif.dll", "EZT4Jpeg.dll", "EZT4Ocr.dll", "EZT4Pdf.dll", "EZT4Png.dll", "EZT4Symbol.dll", "EZT4Tiff.dll"}
ls_Baixar  = {'twain4.zip'}

dc_uo_api lo_api
lo_api = Create dc_uo_api

If Not FileExists(ls_Path_dll) Then
	CreateDirectory(ls_Path_dll)
End If

If FileExists(gvo_Aplicacao.ivs_Path_Sistema + '\twain4.zip') Then		
	FileDelete(ls_Path_dll + '\Eztwain4.dll')
	FileDelete(ls_Path_dll + '\EZT4Curl.dll')
	FileDelete(ls_Path_dll + '\EZT4Dcx.dll')
	FileDelete(ls_Path_dll + '\EZT4Gif.dll')
	FileDelete(ls_Path_dll + '\EZT4Jpeg.dll')
	FileDelete(ls_Path_dll + '\EZT4Ocr.dll')
	FileDelete(ls_Path_dll + '\EZT4Pdf.dll')
	FileDelete(ls_Path_dll + '\EZT4Png.dll')		
	FileDelete(ls_Path_dll + '\EZT4Symbol.dll')
	FileDelete(ls_Path_dll + '\EZT4Tiff.dll')
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\Eztwain4.dll')		
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Curl.dll')
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Dcx.dll')
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Gif.dll')
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Jpeg.dll')
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Ocr.dll')
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Pdf.dll')
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Png.dll')
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Symbol.dll')
	FileDelete(gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Tiff.dll')				

	If lo_api.of_unzip(gvo_Aplicacao.ivs_Path_Sistema + '\twain4.zip', ls_path_dll+'\') Then
		lo_api.of_delete_file(gvo_Aplicacao.ivs_Path_Sistema + '\twain4.zip',False)
	End If	
Else
	If Not FileExists(ls_Path_dll + '\Eztwain4.dll') Then
		If Not(gf_Download_Matriz(ls_Validar, ls_Baixar, ls_Path_dll, "dll_twain", True)) Then
			MessageBox('EZTwain','Problemas ao tentar baixar as dlls Twain!',StopSign!)
			Return False		
		End If
	End If
End If

If Not FileExists(gvo_Aplicacao.ivs_Path_Sistema + '\Eztwain4.dll') Then
	If Not lo_api.of_copy_file(ls_Path_dll + '\Eztwain4.dll', gvo_Aplicacao.ivs_Path_Sistema + '\Eztwain4.dll', true) Then Return False
	If Not lo_api.of_copy_file(ls_Path_dll + '\EZT4Curl.dll', gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Curl.dll', true) Then Return False
	If Not lo_api.of_copy_file(ls_Path_dll + '\EZT4Dcx.dll', gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Dcx.dll', true) Then Return False
	If Not lo_api.of_copy_file(ls_Path_dll + '\EZT4Gif.dll', gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Gif.dll', true) Then Return False
	If Not lo_api.of_copy_file(ls_Path_dll + '\EZT4Jpeg.dll', gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Jpeg.dll', true) Then Return False
	If Not lo_api.of_copy_file(ls_Path_dll + '\EZT4Ocr.dll', gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Ocr.dll', true) Then Return False
	If Not lo_api.of_copy_file(ls_Path_dll + '\EZT4Pdf.dll', gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Pdf.dll', true) Then Return False
	If Not lo_api.of_copy_file(ls_Path_dll + '\EZT4Png.dll', gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Png.dll', true) Then Return False
	If Not lo_api.of_copy_file(ls_Path_dll + '\EZT4Symbol.dll', gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Symbol.dll', true) Then Return False
	If Not lo_api.of_copy_file(ls_Path_dll + '\EZT4Tiff.dll', gvo_Aplicacao.ivs_Path_Sistema + '\EZT4Tiff.dll', true) Then Return False
End If

Destroy(lo_api)

If TWAIN_IsAvailable() then // verifica driver Twain est$$HEX1$$e100$$ENDHEX$$ instalado no PDV
	CreateDirectory(This.is_caminho_pre)	
	Return True
Else
	MessageBox("EZTwain", "Driver Twain n$$HEX1$$e300$$ENDHEX$$o instalado.", StopSign!)		
	Return False
End If
end function

public function boolean of_previsualizar (long pl_handle);Boolean lb_sucesso

String		ls_nome_frente, &
			ls_nome_verso, &
			ls_erro, &
			ls_handle
			
Long ll_retorno

If IsNull(pl_handle) Then
	ls_handle = 'NULO'
Else
	ls_handle = String(pl_handle)
End If

 TWAIN_SetHideUI(FALSE)  //TRUE - Esconde interface do scanner
 TWAIN_SetFileAppendFlag(FALSE) //retirar para jpg. //Substituir o arquivo se j$$HEX1$$e100$$ENDHEX$$ existir
 TWAIN_SetJpegQuality(20) 
 
Open(w_Janela_Aguarde)
w_Janela_Aguarde.Wf_Mensagem("Conectando ao dispositivo...")	
 
gvo_aplicacao.of_grava_log("Digitalizacao: Vai abrir o dispositivo.") 
IF TWAIN_OpenDefaultSource() THEN
	//TWAIN_SelectFeeder(TRUE)
	// Not guaranteed to work, check return = 1
	//TWAIN_SetPixelType(1)
	TWAIN_SetXferCount(1) //seta quantas imagens o aplicativo vai aceitar	
	TWAIN_SetCurrentPixelType(1)
	TWAIN_SetBitDepth(8)
	//TWAIN_SetResolution(150)
	TWAIN_setCurrentResolution(200)
	//TWAIN_SetAutoDeskew(1) //tenta acertar imagens distorcidas
	// TWAIN_SetPaperSize(1)  com a xerox(3655i) que temos, com essa propriedade ocorre erro na digitalizacao.
	If Trim(Upper(is_Tipo)) = 'CAIXA' Then
		TWAIN_SetPaperSize(1)
		//TWAIN_SetRegion(0.0, 0.0, 8.5, 11.7)		
	End If
//	IF NOT TWAIN_SetAutoScan(FALSE) THEN
//		MessageBox("EZTwain", "SetAutoScan(FALSE) failed - scanner cannot single-scan?")
//	END IF
	//TWAIN_AutoClickButton("Digitalizar")			
	// If you can't get a Window handle, use 0:   //fun$$HEX2$$e700e300$$ENDHEX$$o handle do powerbuilder sempre retorna zero para janela, ent$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o uso mais.
	w_Janela_Aguarde.Wf_Mensagem("Gerando pr$$HEX1$$e900$$ENDHEX$$-visualiza$$HEX2$$e700e300$$ENDHEX$$o...")
	gvo_aplicacao.of_grava_log("Digitalizacao: Vai fazer a digitalizacao, caminho: " + This.is_caminho_pre+"\pre.pdf" + " Valor handle: " + ls_handle )
	ll_retorno = TWAIN_AcquireToFilename(pl_handle, This.is_caminho_pre+"\pre.pdf")
	If of_trata_retorno(ll_retorno, Ref ls_erro) Then
		gvo_aplicacao.of_grava_log("Digitalizacao: Digitalizou com sucesso!")
		lb_sucesso = True
	Else
		lb_sucesso = False
	End If
	
	TWAIN_DisableSource()
	TWAIN_CloseSource()	
ELSE
	ls_erro = 'Erro ao conectar ao dispositivo.'
END IF
 
Close(w_Janela_Aguarde)

If lb_sucesso Then
	Return true
Else
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_erro, StopSign! )	
	Return False
End If
end function

public function boolean of_envia_ftp (string ps_caminho, string ps_arquivo, ref string ps_msg_ftp);String ls_Msg, ls_msg_aux
Boolean lb_sucesso

dc_uo_ftp lo_Ftp
lo_Ftp = Create dc_uo_ftp

lo_Ftp.of_DesConecta_Ftp()

Open(w_Aguarde)
w_Aguarde.Title = "Arquivo sendo enviado para o servidor FTP"

Try
	//FTP para MATRIZ				
	If lo_Ftp.of_Conecta_Ftp( This.is_info_ftp, This.is_ip_ftp, This.is_usuario_ftp, This.is_acesso_ftp, Ref ls_Msg ) Then			
		
		lb_Sucesso = lo_Ftp.of_Ftp_Set_Dir( "/", ref ls_Msg) > 0
	
		If lo_Ftp.of_Ftp_Set_Dir( "/" + This.is_Caminho_ftp, ref ls_Msg) <= 0 Then
			/* Tentar criar a estrutura necess$$HEX1$$e100$$ENDHEX$$rio no FTP */			
			lo_Ftp.of_Ftp_Cria_Dir( String( This.idh_movimento_ftp, 'YYYY' )			, Ref ls_Msg )
			ls_msg_aux += ' - ' + ls_Msg
			lo_Ftp.of_Ftp_Cria_Dir( String( This.idh_movimento_ftp, 'YYYY/MM' )			, Ref ls_Msg )
			ls_msg_aux += ' - ' + ls_Msg
			lo_Ftp.of_Ftp_Cria_Dir( String( This.idh_movimento_ftp, 'YYYY/MM/DD' )			, Ref ls_Msg )		
			ls_msg_aux += ' - ' + ls_Msg

			lo_Ftp.of_Ftp_Cria_Dir( This.is_Caminho_ftp, Ref ls_Msg )
			/******/
			lb_Sucesso = lo_Ftp.of_Ftp_Set_Dir( "/", ref ls_Msg) > 0
			If Not lb_sucesso Then ls_msg_aux += ' - ' + ls_Msg
			
			lb_Sucesso = lo_Ftp.of_Ftp_Set_Dir( "/" + This.is_Caminho_ftp , ref ls_Msg) > 0
			If Not lb_sucesso Then ls_msg_aux += ' - ' + ls_Msg
		End If
		
		If lb_Sucesso Then
			lb_sucesso = lo_Ftp.of_Ftp_PutFile( ps_caminho+'\'+ps_arquivo, ps_arquivo, Ref ls_Msg )
			If Not lb_sucesso Then ls_msg_aux += ' - ' + ls_Msg
		End If
		If lb_sucesso Then 
			SetNull(ls_Msg)
		Else
			ls_msg = ls_msg_aux
		End If
	Else
		ls_Msg = "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor '" + This.is_ip_ftp + "'."
		lb_Sucesso = False
	End If			

Catch( Exception e )
	ls_Msg = e.GetMessage()
	lb_Sucesso = False
	
Finally
	lo_Ftp.of_DesConecta_Ftp()	
	Destroy(lo_ftp)
	Close(w_Aguarde)	
	ps_msg_ftp = ls_Msg
	Return lb_Sucesso	
End Try
end function

public function boolean of_verifica_arquivos ();//Verifica arquivos que n$$HEX1$$e300$$ENDHEX$$o foram enviados ao FTP e faz o envio
String ls_Arquivos[]
String ls_arquivo
String ls_temp
String ls_msg
Long ll_Arquivo

SetNull(This.idh_movimento_ftp)

If This.is_Tipo = 'CAIXA' Then
	//0013000535900320170719.pdf
	
	gf_dir_list( This.is_caminho, '*.pdf', 0+1, Ref ls_Arquivos )
	
	//gf_dir_list(ls_Dir + "\", '*.zip', 0+1, Ref ls_Arquivos)

	If UpperBound( ls_Arquivos ) = 0 Then Return True	
	
	For ll_Arquivo = 1 To UpperBound( ls_Arquivos )
		 ls_Arquivo = ls_Arquivos[ll_Arquivo]
		 
		 If LenA(ls_Arquivo) <> 26 Then //se o tamanho do nome do arquivo for outro n$$HEX1$$e300$$ENDHEX$$o envia.
		 	Continue
		Else
			ls_temp = Trim(MidA(ls_Arquivo, 1, PosA(ls_Arquivo,'.')-1))				
			ls_temp = RightA(ls_temp, 8)
			ls_temp = String (ls_temp, '@@@@/@@/@@')
			This.idh_movimento_ftp = date(ls_temp)
			
			This.is_caminho_ftp = 	String( This.idh_movimento_ftp, 'YYYY/MM/DD/' ) + String( gvo_Parametro.Cd_Filial, '0000' )
			This.is_usuario_ftp = 		'caixafilial'
			This.is_acesso_ftp = 		'Spum@qa8res#'
			This.is_info_ftp = 			'DIGITALIZACAO'
			
			If This.of_envia_ftp(This.is_caminho, ls_arquivo, Ref ls_msg) Then //Move arquivo para pasta enviadas.
				CreateDirectory(This.is_caminho+'\enviados')
				FileMove(This.is_caminho+'\'+ls_arquivo, This.is_caminho+'\enviados\'+ls_arquivo)
			End If				
			
		End If		 
	Next

End If

Return True
end function

public function boolean of_selecao_dispositivo (boolean ps_troca_dispositivo, long pl_handle);String ls_dispositivo

////ls_dispositivo = Space(32)
//If ps_troca_dispositivo Then
//	If Not TWAIN_SelectImageSource(0) Then////seta dispositovo default	
//		Return False
//	End If
//Else
//	ls_dispositivo = TWAIN_SourceName()
//	
//	If IsNull(ls_dispositivo) Or Trim(ls_dispositivo) = '' Then
//		If Not TWAIN_SelectImageSource(0) Then Return False
//	End If
//End If

TWAIN_SetLogFolder('C:\Sistemas\DLL\twain')
TWAIN_LogFile(1)

If Not gvo_aplicacao.ib_Selecionou_Scanner Then
	If Not TWAIN_SelectImageSource(pl_handle) Then////seta dispositovo default	
		Return False	
	End If
	gvo_aplicacao.ib_Selecionou_Scanner = True
End If

Return True
end function

on uo_ge393_twain4.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge393_twain4.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

