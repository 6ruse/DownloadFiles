unit uDownloadFile;

interface
uses
  System.Net.HttpClientComponent
  ,System.Classes
  ,System.SysUtils
  ,System.IOUtils
  ;

  type
    TDownloadFile = class
    strict private
      class var
        DownloadFile : TDownloadFile;

    private
      FSavePath : string ;
      FFileURL  : string ;
      FSaveFileName : string ;

      client: TNetHTTPClient;
      Data: TStringStream;
      body: string ;
      constructor Create;reintroduce;deprecated 'Don''t use this!';
      destructor Destroy ();

      function GetSavePath() : string ;
      procedure SetSavePath(Value : string) ;
    public

      property SavePath : string read GetSavePath write SetSavePath ;
      property FileURL : string read FFileURL write FFileURL ;
      property SaveFileName : string read FSaveFileName write FSaveFileName ;

      class function GetInstance() : TDownloadFile;  //точка входа

      function DownloadImage() : boolean ;  //скачать изображение с интернетов
    end;


implementation

{ TDownloadImg }

constructor TDownloadFile.Create;
begin
  client := TNetHTTPClient.Create(nil);
  data := TStringStream.Create(body, TEncoding.UTF8);
end;

destructor TDownloadFile.Destroy;
begin
  client.Free ;
  data.Free;
end;

function TDownloadFile.DownloadImage: boolean;
  var
    saveFile : string ;
begin
//скачать изображение с интернетов
  Client.Get(FileURL, Data);
  saveFile := SavePath + SaveFileName ;
  Data.SaveToFile(saveFile);
end;

class function TDownloadFile.GetInstance: TDownloadFile;
begin
  if DownloadFile = nil then
    DownloadFile := TDownloadFile.Create();
  Result := DownloadFile;
end;

function TDownloadFile.GetSavePath: string;
  var
    last : char ;
begin
  //тут можно многое учесть
  if FSavePath = emptyStr then
    FSavePath := System.IOUtils.TPath.GetTempPath;

  last := FSavePath[length(FSavePath)];
  if last <> '\'  then
    FSavePath := FSavePath + '\';

  result := FSavePath ;

end;

procedure TDownloadFile.SetSavePath(Value: string);
begin
  FSavePath := Value ;
end;

end.
