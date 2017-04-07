unit SplashForm;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TTSplashForm = class(TForm)
    olMensage: TLabel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TSplashForm: TTSplashForm;

implementation

uses utilesV20;
{$R *.dfm}

procedure TTSplashForm.FormCreate(Sender: TObject);
begin
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
end;

end.
