unit CntrCam;

// ToDo ///////////////////////////////////////////////////////////////////////
//todo - Dialog zur Kamera-Auswahl
//todo - Kameraauflösung 640x480 sicherstellen
//todo - Verwaltung Einstellung Kamera in Config verlegen

{
==> CamPresent: iCamControl.Camera ist in Popup-Menu enthalten und ungleich "keine"
==> - CamState: Status der Kamera, wird mit den App-Einstellungen gesichert
      - 0=camNoCam:  nicht vorhanden oder keine ausgewählt (Camera = "keine")
      - 1=camOff:    vorhanden, aber soll ausgeschaltet sein (RadioGroupCam = 0)
      - 2=camStart:  Kamera soll eingeschaltet werden
      - 3=camActive: Kamera ist eingeschaltet
==> iCamControl.Camera: die zu benutzende Kamera ("keine", wenn abgeschaltet)
    - wird nur durch das Popup-Menu in den App-Einsellungen geändert
==> Popup-Menu-Items
    - wird beim Programmstart geladen
    - Wenn CamState=2 wird bei jedem Einschaltversuch die Liste neu aufgebaut
}

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Buttons,
  Vcl.ImgList,
  Vcl.Imaging.pngimage,
  Vcl.Menus,
  VFrames,
  StdCtrls,
  ExtCtrls;

const
  WM_POINTERDOWN = $0246;
  WM_POINTERUP   = $0247;

  resWidth       = 640;
  resHeight      = 480;

type

  TPixel = packed record
    B,G,R: Byte;
  end;

  TOnMillCntr   = procedure(Tag: integer) of object;
  TOnVideoFrame = procedure(Frame: TBitMap) of object;

  TCntrBox = class(TPanel)
    private
      FOnTouchDown:  TMouseEvent;
      FOnTouchUp:    TMouseEvent;
    protected
      procedure WMPointerDown(var Msg: TMessage); message WM_POINTERDOWN;
      procedure WMPointerUp(var Msg: TMessage);   message WM_POINTERUP;
    public
      FOnMillCntr:   TOnMillCntr;
      VideoBox:      TPaintBox;
      State:         TLabel;
      property    OnTouchDown: TMouseEvent read FOnTouchDown write FOnTouchDown;
      property    OnTouchUp:   TMouseEvent read FOnTouchUp   write FOnTouchUp;
      constructor Create(AOwner: TComponent); override;
      procedure   Paint; override;
      procedure   SetFrame(Frame: TBitMap);
      procedure   MouseUpDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    published
  end;

const camOff    = 0;
      camStart  = 1;
      camActive = 2;

type
  TCamControl = class
    private
      FCntrBox1:      TCntrBox;
      FCntrBox2:      TCntrBox;
      fCamera:        string;
      fColor:         TColor;
      procedure       ProveCamPresence;
      procedure       SetCamera(Cam: string);
      procedure       SetColor(C: TColor);
      procedure       SetCntrBox1(CB: TcntrBox);
      procedure       SetCntrBox2(CB: TcntrBox);
    protected
    public
      DeviceList:     TStringList;
      State:          string;
      CamState:       integer;
      Diameter:       integer;
      fVideoImage:    TVideoImage;                                // Videodevice
      fVideoBitmap:   TBitmap;
      TagXYZ:         integer;
      TagRes:         integer;
      CamPresent:     boolean;      // choosen Cam is present in current session
      property    CntrBox1:   TCntrBox read FCntrBox1   write SetCntrBox1;
      property    CntrBox2:   TCntrBox read FCntrBox2   write SetCntrBox2;
      property    Camera:     string   read fCamera     write SetCamera;
      property    Color:      TColor   read fColor      write SetColor;
      constructor Create;
      destructor  Destroy; override;
      procedure   CamScan;
      function    SwitchCam(SwitchOn: boolean):boolean;
      procedure   InsertControls;
      procedure   OnNewVideoFrame(Sender: TObject; Width, Height: integer; DataPtr: pointer);
      procedure   RedrawFrame;
      function    GetTag(X,Y:integer; down: boolean):integer;
  end;

var
  iCamControl:   TCamControl;

implementation

const

  Tags: array[0..10, 0..17] of NativeInt =                       //  0: inaktiv
   (($B,$B, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),     //  1: Nord
    ($B,$B, 0, 0, 0, 0, 0, 0,$1,$1, 0, 0, 0, 0, 0, 0, 0, 0),     //  2: NordOst
    ( 0, 0, 0, 0, 0,$8,$8, 0,$1,$1, 0,$2,$2, 0, 0, 0, 0, 0),     //  3: Ost
    ($C,$C, 0, 0, 0,$8,$8, 0, 0, 0, 0,$2,$2, 0, 0, 0,$9,$9),     //  4: Südost
    ($C,$C, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,$9,$9),     //  5: Süd
    ( 0, 0, 0, 0,$7,$7, 0, 0, 0, 0, 0, 0,$3,$3, 0, 0, 0, 0),     //  6: SüdWest
    ($D,$D, 0, 0,$7,$7, 0, 0, 0, 0, 0, 0,$3,$3, 0, 0, 0, 0),     //  7: West
    ($D,$D, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,$A,$A),     //  8: NordWest
    ( 0, 0, 0, 0, 0,$6,$6, 0, 0, 0, 0,$4,$4, 0, 0, 0,$A,$A),     //  9: Auf
    ($E,$E, 0, 0, 0,$6,$6, 0,$5,$5, 0,$4,$4, 0, 0, 0, 0, 0),     //  A: Ab
    ($E,$E, 0, 0, 0, 0, 0, 0,$5,$5, 0, 0, 0, 0, 0, 0, 0, 0));    //  B: 0.1
                                                                 //  C: 1
                                                                 //  D: 10
                                                                 //  E: 100

var Mask: array[0..10, 0..17] of array[0..32] of uint32;

//******************************************************************************
// CamControl                                                                 **
//******************************************************************************

///// CamControl.Create ////////////////////////////////////////////////////////
constructor TCamControl.Create;
var MaskImage: TPngImage;
    p0:        pByteArray;
    x,y,l,i:   integer;
    M, B:      uint32;
begin
  //--- read masq --------------------------------------------------------------
  MaskImage:= TPngImage.create;
  MaskImage.LoadFromResourceName(HInstance,'MaskImage');
  for y:=0 to 10 do begin
    for l:=0 to 31 do begin
      p0:= MaskImage.AlphaScanLine[(32*y + l)];
      for x:=0 to 17 do begin
        M:= 0; B:= 1;
        for i:= 0 to 31 do begin
          if p0[x*32+i] = 255 then M:= M + B;
          B:= B shl 1;
        end;
        Mask[y,x][l]:= M;
      end;
    end;
  end;

  //--- set start values -------------------------------------------------------
  Diameter:=      10;                                            // set diameter
  Color:=         $ff0000;                                   // set color to red
  CamState:=      camOff;
  CamScan;

  TagXYZ:=        0;                                         // no moving active
  TagRes:=        $B;                                // set resulution to 0.1mmm

  fVideoBitmap:= TBitmap.create;         // create bitmap for video manipulation
  fVideoBitmap.Height:=      resHeight;
  fVideoBitmap.Width:=       resWidth;
  fVideoBitmap.PixelFormat:= pf24bit;

  RedrawFrame;             // prepare control elements, here without cam picture
end;

///// TCamControl.Destroy //////////////////////////////////////////////////////
destructor TCamControl.Destroy;
begin
  FreeAndNil(fVideoBitmap);
  inherited Destroy;
end;

///// TCamControl.SetCamPresence ///////////////////////////////////////////////
procedure TCamControl.ProveCamPresence;
begin                                          // choosen Cam in founded cameras
  CamPresent:= ((Devicelist.Count > 0) and (Devicelist.IndexOf(Camera) >= 0));

  if CamPresent and (fVideoImage = nil) then begin
    fVideoImage:= TVideoImage.Create;  // Create instance of video image class
    fVideoImage.OnNewVideoFrame:= OnNewVideoFrame;
  end;
end;

///// TCamControl.SetCamera ////////////////////////////////////////////////////
procedure TCamControl.SetCamera(Cam: string);
begin
  fCamera:= Cam;
  ProveCamPresence;
end;

///// TCamControl.SetColor /////////////////////////////////////////////////////
procedure TCamControl.SetColor(C: TColor);
begin
  fColor:= C;
  if fVideoBitmap <> nil then RedrawFrame;
end;

///// TCamControl.SetCntrBox ///////////////////////////////////////////////////
procedure TCamControl.SetCntrBox1(CB: TcntrBox);
begin
  FCntrBox1:= CB;
  RedrawFrame;
end;

procedure TCamControl.SetCntrBox2(CB: TcntrBox);
begin
  FCntrBox2:= CB;
  RedrawFrame;
end;

///// TCamControl.CamScan //////////////////////////////////////////////////////
procedure TCamControl.CamScan;
begin
  if DeviceList <> nil then DeviceList.Free;               // clear if not empty
  DeviceList := TStringList.Create;                     // get connected cameras
  fVideoImage.GetListOfDevices(DeviceList);
  ProveCamPresence;                     // list of cams changed, camera present?
end;

///// TCamControl.SwitchCam ////////////////////////////////////////////////////
function TCamControl.SwitchCam(SwitchOn: boolean):boolean;
begin
  result:= camState = camActive;
  CamScan;                                          // refresh installed cameras
  if not CamPresent then begin                           // wanted cam not found
    State:= 'Choosen Cam not found...';
    exit;
  end;
  if ( SwitchOn xor (CamState<>camActive) ) then exit;          // nothing to do

  if SwitchOn then begin

    CamState:= camStart;
    State:= 'Initializing Webcam...';
    RedrawFrame;
//???      Application.ProcessMessages;
    if fVideoImage.VideoStart(Camera) = 0
       then CamState:= camActive
       else State:= 'Activation Webcam fails...';
  end else begin
    camState:= camOff;
    fVideoImage.VideoStop;
    State:= 'Webcam/Video Device off';
  end;

  result:= camState = camActive;
  RedrawFrame;
end;

///// TCamControl.InsertControls ///////////////////////////////////////////////
procedure TCamControl.InsertControls;
var C:             TPixel;
    x, y, i, j, T: integer;
    PPicture:      ^TPixel;
    M:             uint32;
begin
  C.B:= (Color shr 16) and $ff;
  C.G:= (Color shr 8)  and $ff;
  C.R:=  Color         and $ff;

  for y:=0 to 10 do begin
    for j:= 0 to 31 do begin
      PPicture:= fVideoBitmap.Scanline[y*32+j+48];            // offset 48 lines
      inc(PPicture,32);                                     // offset 32 columbs
      for x:=0 to 17 do begin
        M:= Mask[y,x][j];
        T:= Tags[y,x];
        if T = 0 then inc(PPicture,32)                       // 1 square forward
        else begin
          for i:= 0 to 31 do begin
            if ((M and 1) <> 0) xor ((T = TagXYZ) or (T = TagRes)) then begin
              PPicture.R := (PPicture.R + C.R) shr 1;
              PPicture.G := (PPicture.G + C.G) shr 1;
              PPicture.B := (PPicture.B + C.B) shr 1;
            end;
            Inc(PPicture); M:= M shr 1;                       // 1 pixel forward
          end;
        end;
      end;
    end;
  end;
end;

///// TCamControl.RedrawFrame //////////////////////////////////////////////////
procedure TCamControl.RedrawFrame;
begin
  if CamState = camActive then exit;        // redraw will be triggered by video

  with fVideoBitmap.Canvas do begin
    Pen.Color   := clBtnFace;                                   // clear picture
    Pen.Style   := psSolid;
    Pen.Width   := 1;
    Brush.Color := clBtnFace;
    Brush.Style := bsSolid;
    Rectangle(0,0,resWidth-1,resHeight-1);
    Brush.Style := bsClear;

    Pen.Color   := clBlack;                              // black line at bottom
    MoveTo(0,resHeight-1);
    LineTo(resWidth-1,resHeight-1);
  end;

  fVideoBitmap.Canvas.Font.Size := 14;
  fVideoBitmap.Canvas.Font.Charset:= DEFAULT_CHARSET;
  fVideoBitmap.Canvas.Font.Color:= clWindowText;
  fVideoBitmap.Canvas.Font.Name:= 'Tahoma';
  fVideoBitmap.Canvas.TextOut(200,450,State);

  InsertControls;

  if assigned(FCntrBox1) then FCntrBox1.Repaint;
  if assigned(FCntrBox2) then FCntrBox2.Repaint;
end;

///// TCamControl.OnNewVideoFrame //////////////////////////////////////////////
procedure TCamControl.OnNewVideoFrame(Sender : TObject; Width, Height: integer; DataPtr: pointer);
var
  bm_center_x, bm_center_y: Integer;
begin
  // Retreive latest video image
  if camState < camActive then exit;

  fVideoImage.GetBitmap(fVideoBitmap);

  with fVideoBitmap do begin
    InsertControls;

    // Paint a crosshair onto video image
    bm_center_x:= resWidth div 2;
    bm_center_y:= resHeight div 2;

    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Width   := 1;
    Canvas.Pen.Color:= Color;
    Canvas.moveto(0, bm_center_y);
    Canvas.lineto(Width,  bm_center_y);
    Canvas.moveto(bm_center_x, 0);
    Canvas.lineto(bm_center_x, Height);
    Canvas.ellipse(bm_center_x - Diameter, bm_center_y - Diameter,
        bm_center_x + Diameter, bm_center_y + Diameter);
                                                  // Weiterleitung an Videoboxen
    if assigned(FCntrBox1) then FCntrBox1.SetFrame(fVideoBitmap);
    if assigned(FCntrBox2) then FCntrBox2.SetFrame(fVideoBitmap);
  end;
end;

///// TCamControl.GetTag ///////////////////////////////////////////////////////
function TCamControl.GetTag(X,Y:integer; down: boolean):integer;
begin
  result:= 0;
  X:= X - 32; if (X < 0) or (X > 575) then exit;
  Y:= Y - 48; if (Y < 0) or (Y > 351) then exit;
  result:= Tags[Y div 32, X div 32];
  if result > $A then TagRes:= result else                  // switch resolution
    if down then TagXYZ:= result                           // movement X, Y or Z
    else begin
      TagXYZ:= 0;
      result:= result+ 256;
    end;
  if camState < camActive then RedrawFrame;
end;

//******************************************************************************
// TCntrBox
//******************************************************************************

///// TCntrBox.Create //////////////////////////////////////////////////////////
constructor TCntrBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  with iCamControl do                                  // register to CamControl
    if CntrBox1 = nil then CntrBox1:= self else
      if CntrBox2 = nil then CntrBox2:= self;

  VideoBox:= TPaintBox.Create(self);
  with VideoBox do begin
    Parent:=  self;
    Name:=    'VideoBox';
    Height:=  480;
    Width:=   640;
    OnMouseUp:=   TCntrBox(self).MouseUpDown;
    OnMouseDown:= TCntrBox(self).MouseUpDown;
  end;
end;

///// TCntrBox.SetFrame ////////////////////////////////////////////////////////
procedure TCntrBox.SetFrame(Frame: TBitMap);
begin
  VideoBox.Canvas.Draw(0, 0, Frame);
end;

///// TCntrBox.Paint ///////////////////////////////////////////////////////////
procedure TCntrBox.Paint;
begin
  SetFrame(iCamControl.fVideoBitmap);                        // get latest frame
  inherited Paint;
end;

///// TCntrBox.MouseUpDown /////////////////////////////////////////////////////
procedure TCntrBox.MouseUpDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var T: integer;
begin
  if Button <> mbLeft then exit;
  T:= iCamControl.GetTag(X,Y,ssLeft in Shift);
  if assigned(FOnMillCntr) then FOnMillCntr(T);
end;

///// TCntrBox.WMPointerDown ///////////////////////////////////////////////////
procedure TCntrBox.WMPointerDown(var Msg: TMessage);
var T: integer;
    P: TPoint;
begin
  P.X:= Msg.LParamLo;
  P.Y:= Msg.LParamHi;
  P:= ScreenToClient(P);
  T:= iCamControl.GetTag(P.X,P.Y,true);
  if assigned(FOnMillCntr) then FOnMillCntr(T);
  Msg.Result := DefWindowProc(Handle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

///// TCntrBox.WMPointerUp /////////////////////////////////////////////////////
procedure TCntrBox.WMPointerUp(var Msg: TMessage);
var T: integer;
    P: TPoint;
begin
  P.X:= Msg.LParamLo;
  P.Y:= Msg.LParamHi;
  P:= ScreenToClient(P);
  T:= iCamControl.GetTag(P.X,P.Y,false);
  if assigned(FOnMillCntr) then FOnMillCntr(T);
  Msg.Result := DefWindowProc(Handle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

begin
  iCamControl:= TCamControl.Create;                   // initalize camera system
end.

