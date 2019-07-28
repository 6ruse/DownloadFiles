program ExampleDownloadImg;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  uDownloadFile in 'uDownloadFile.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmExample, FrmExample);
  Application.Run;
end.
