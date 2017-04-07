unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg, shellapi;

type
  TfAbout = class(TForm)
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAbout: TfAbout;

implementation
uses utilesV20;
{$R *.dfm}

procedure TfAbout.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfAbout.Label8Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://zeoslib.sourceforge.net', nil, nil,
    sw_ShowMaximized);

end;

procedure TfAbout.Label12Click(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'http://www.ertemsoft.net', nil, nil,
    sw_ShowMaximized);

end;

end.
