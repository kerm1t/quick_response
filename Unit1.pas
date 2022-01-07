unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  , qr, bitstr, ec, ExtCtrls, StdCtrls
  ;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    btnQR: TButton;
    Image1: TImage;
    procedure btnQRClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.btnQRClick(Sender: TObject);
var pQR: QRCodePtr;
  msg: String;
  data: ByteBufferPtr;
  j, dataLen: Integer;
  qrError: Integer;
  preferredVersion, preferredLevel, preferredMaskPattern: Integer;
begin
  msg := memo1.Text;
  preferredVersion := QRVersionAny;
  preferredLevel := ECLevelAny;
  preferredMaskPattern := MaskPatternAny;

  dataLen := Length(msg);
  GetMem(data, dataLen);
  for j := 1 to Length(msg) do
    data^[j - 1] := ord(msg[j]);
 
  pQR := New(QRCodePtr, Init);
  pQR^.SetPreferredLevel(preferredLevel);
  PQR^.SetPreferredVersion(preferredVersion);
  pQR^.SetPreferredMaskPattern(preferredMaskPattern);
  qrError := pQR^.Make(data, dataLen);

  image1.Picture := nil;
  image1.Picture.bitmap.Width := pQR^.QRSize;
  image1.Picture.bitmap.height := pQR^.QRSize;

  pQR^.SaveImg(Image1.Canvas);
  Dispose(pQr);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  position := poScreenCenter;
  Memo1.Text := 'Peek a boo';
end;

end.
