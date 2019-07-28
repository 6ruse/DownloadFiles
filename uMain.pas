unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls
  ,uDownloadFile
  ;

type
  TFrmExample = class(TForm)
    edtURL: TEdit;
    edtSavePath: TEdit;
    btnDownload: TButton;
    edtFileName: TEdit;
    lblStatus: TLabel;
    procedure btnDownloadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExample: TFrmExample;

implementation

{$R *.dfm}

procedure TFrmExample.btnDownloadClick(Sender: TObject);
  var
    DownloadFile : TDownloadFile ;
begin
  DownloadFile := TDownloadFile.GetInstance ;
  DownloadFile.FileURL := edtURL.Text ;
  DownloadFile.SavePath := edtSavePath.Text ;
  DownloadFile.SaveFileName := edtFileName.Text ;
  if DownloadFile.DownloadImage then
    lblStatus.Caption := 'скачал успешно'
  else
    lblStatus.Caption := 'загрузка не удалась';

end;

end.
