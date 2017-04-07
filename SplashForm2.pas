unit SplashForm2;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TTSplashForm2 = class(TForm)
    olMensage: TLabel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    oSign: TLabel;
    Timer1: TTimer;
    oCPorc1: TLabel;
    ProgressBar2: TProgressBar;
    oLogs: TListBox;
    oCPorc2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TSplashForm2: TTSplashForm2;
  sSym: string;

implementation

uses utilesV20;
{$R *.dfm}

procedure TTSplashForm2.FormCreate(Sender: TObject);
begin
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  sSym := '/';
  self.Height := 105;
  self.ProgressBar2.Visible := false;
  self.oCPorc2.Visible := false;
end;

procedure TTSplashForm2.FormPaint(Sender: TObject);
var
  cPorc1: string;
  cPorc2: string;
begin
  if (ProgressBar1.Position <> ProgressBar1.Min) then
  begin
    if self.ProgressBar1.Visible = false then
      self.ProgressBar1.Visible := true;
    if self.oCPorc1.Visible = false then
      self.oCPorc1.Visible := true;

    cPorc1 := futilesV20.FloatToStr2
      (futilesV20.RoundD((ProgressBar1.Position / ProgressBar1.Max) * 100,
      0)) + ' %';
    self.oCPorc1.Caption := cPorc1;
  end;

  if (ProgressBar2.Position <> ProgressBar2.Min) then
  begin
    if self.ProgressBar2.Visible = false then
      self.ProgressBar2.Visible := true;
    if self.oCPorc2.Visible = false then
      // self.oCPorc2.Visible := true;
      if self.Height <> 133 then
        self.Height := 133;
    cPorc2 := futilesV20.FloatToStr2
      (futilesV20.RoundD((ProgressBar2.Position / ProgressBar2.Max) * 100,
      0)) + ' %';
    self.oCPorc2.Caption := cPorc2;
  end;
end;

procedure TTSplashForm2.Timer1Timer(Sender: TObject);
begin
  if sSym = '/' then
    sSym := '-'
  else if sSym = '-' then
    sSym := '\'
  else if sSym = '\' then
    sSym := '/';
  self.oSign.Caption := sSym;
  self.Update;
  Application.ProcessMessages;
end;

end.
