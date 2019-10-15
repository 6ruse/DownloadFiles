unit uDownloadFile;

interface
uses
  System.Net.HttpClientComponent
  ,System.Classes
  ,System.SysUtils
  ,System.IOUtils
  ,System.Net.HttpClient
  ,System.Net.URLClient
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

      function GetSaveFileName() : string ;
      function GetFileURL() : string ;
    public

      property SavePath : string read GetSavePath write SetSavePath ;
      property FileURL : string read GetFileURL write FFileURL ;
      property SaveFileName : string read GetSaveFileName write FSaveFileName ;

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
  const
    CNST_CD2 = 'content-disposition';
    CNST_CD = 'Location';
  var
    saveFile : string ;
    response: IHTTPResponse;
    response2: IHTTPResponse;
    downloadFile : string ;
    ResFileName : string ;
    hd:TNetHeaders;
    hd2:TNetHeaders;
    i,j: integer ;
    Header    : TNetHeader     ;
    Headers   : TNetHeaders    ;
begin
//скачать изображение с интернетов
  downloadFile := FileURL ;
  if downloadFile = emptyStr then
  begin
    result := false ;
    exit ;
  end;

  Header := TNetHeader.Create('Content-Type', 'application/x-www-form-urlencoded');
  Headers := Headers + [Header];

  Client.ConnectionTimeout:=1500;
  Client.ResponseTimeout:=1500;
  Client.HandleRedirects:=false;
  Client.AllowCookies:=True;
  response := Client.Get(downloadFile, Data, Headers);

  if ((FSaveFileName = emptyStr) AND (Pos('/yadi.sk/',FFileURL) > 0)) then
  begin
    try
      hd := response.GetHeaders;

      ResFileName := emptyStr ;
      for i := 0 to High(hd) do
      begin
        if UPPERCASE(hd[i].Name) = UPPERCASE(CNST_CD) then
        begin
          Data.clear ;
          Client.HandleRedirects:=true;
          response2 := Client.Get(hd[i].Value, Data, Headers);
          hd2 := response2.GetHeaders;
          for j := 0 to High(hd2) do
          begin
            if UPPERCASE(hd2[j].Name) = UPPERCASE(CNST_CD2) then
              ResFileName := copy(hd2[j].Value,pos('''''',hd2[j].Value)+4,length(hd2[j].Value));
          end;
        end ;
      end;
      if ResFileName <> emptyStr then
        SaveFileName := ResFileName ;
    except on E : Exception do
    begin
      result := false ;
      exit ;
    end;
    end;
  end;
  if ((response.StatusCode <> 200) and (response2.StatusCode <> 200)) then
  begin
    result := false ;
    exit ;
  end;

  saveFile := SavePath + SaveFileName ;
  try
    Data.SaveToFile(saveFile);
    result := true ;
  except on E: Exception do
  begin
    result := false ;
  end;
  end;
end;

function TDownloadFile.GetFileURL: string;
  const
    URG_GET_FILE = 'https://getfile.dokpub.com/yandex/get/';
begin
//проверим, вдруг этот файл с яндекст диска
  if Pos('/yadi.sk/',FFileURL) > 0  then
  begin
    result := URG_GET_FILE + FFileURL ;
  end
  else result := FFileURL ;
end;

class function TDownloadFile.GetInstance: TDownloadFile;
begin
  if DownloadFile = nil then
    DownloadFile := TDownloadFile.Create();
  Result := DownloadFile;
end;

function TDownloadFile.GetSaveFileName: string;
  function ExtractUrlFileName(const AUrl: string): string;
  var
    i: Integer;
  begin
    i := LastDelimiter('/', AUrl);
    Result := Copy(AUrl, i + 1, Length(AUrl) - (i));
  end;
begin
  if FSaveFileName = emptyStr then
    FSaveFileName := ExtractUrlFileName(FileURL);
  result := FSaveFileName ;
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
