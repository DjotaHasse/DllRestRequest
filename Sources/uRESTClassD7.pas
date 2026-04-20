unit uRESTClassD7;

interface

uses
  uRESTClass, Dialogs, Windows, SysUtils;

type
  TRESTGet    = function(prHost, prResource: WideString; var prParams: TParams; var prProperties: TProperties): TRESTResponse; stdcall;
  TRESTPost   = function(prHost, prResource: WideString; var prParams: TParams; var prProperties: TProperties; var prBody: TBody): TRESTResponse; stdcall;
  TRESTPut    = function(prHost, prResource: WideString; var prParams: TParams; var prProperties: TProperties; var prBody: TBody): TRESTResponse; stdcall;
  TRESTDelete = function(prHost, prResource: WideString; var prParams: TParams; var prProperties: TProperties): TRESTResponse; stdcall;

  TRESTRequestD7 = class
  private
    fUrl: WideString;
    fParams: TParams;
    fHandle: THandle;
    fResponse: TRESTResponse;
    fProperties: TProperties;
    fBody: TBody;

    procedure ClearResponse;
  public
    constructor Create; overload;
    destructor Destroy; override;

    procedure AddParam(prName,prValue: WideString; prKind: TTypeParam = pkHTTPHEADER);
    procedure ClearParams;
    procedure ClearProperties;
    procedure AddBody(prValue: WideString; prType: TContentType = ctNone);
    function Get(prURL, prResource: WideString): Boolean;
    function Post(prURL, prResource: WideString): Boolean;
    function Put(prURL, prResource: WideString): Boolean;
    function Delete(prURL, prResource: WideString): Boolean;

    property Params: TParams            read fParams                    write fParams;
    property Response: TRESTResponse    read fResponse;
    property Accept: WideString         read fProperties.Accept         write fProperties.Accept;
    property AcceptCharset: WideString  read fProperties.AcceptCharset  write fProperties.AcceptCharset;
    property AcceptEncoding: WideString read fProperties.AcceptEncoding write fProperties.AcceptEncoding;
    property UserAgent: WideString      read fProperties.UserAgent      write fProperties.UserAgent;
    property ContentType: WideString    read fProperties.ContentType    write fProperties.ContentType;
  end;

implementation

constructor TRESTRequestD7.Create;
begin
  fHandle := LoadLibrary('RESTRequest.dll');
  ClearParams;
  ClearProperties;
  ClearResponse;
end;

destructor TRESTRequestD7.Destroy;
begin
  if (fHandle > 0) then
    FreeLibrary(fHandle);
  inherited;
end;

procedure TRESTRequestD7.AddParam(prName, prValue: WideString; prKind: TTypeParam);
begin
  SetLength(fParams,Length(fParams)+1);
  fParams[Length(fParams)-1].Name  := prName;
  fParams[Length(fParams)-1].Value := prValue;
  fParams[Length(fParams)-1].Kind  := prKind;
end;

procedure TRESTRequestD7.ClearParams;
begin
  SetLength(fParams,0);
end;

function TRESTRequestD7.Get(prURL, prResource: WideString): Boolean;
var
  fGet: TRESTGet;
begin
  Result := False;
  ClearResponse;
  if (fHandle = 0) then
  begin
    MessageDlg('Erro ao carregar dll RESTRequest!',mtError,[mbOK],0);
    Exit;
  end;

  try
    @fGet := GetProcAddress(fHandle,'Get');
    if Assigned(fGet) then
    begin
      fResponse := fGet(prURL,prResource,fParams,fProperties);
      Result := True;
    end;
  except
    on e:Exception do
      MessageDlg('Erro requisição: '+e.Message,mtError,[mbOK],0);
  end;
end;

procedure TRESTRequestD7.ClearResponse;
begin
  fResponse.Headear.Code := 0;
  fResponse.Headear.Str  := '';
  fResponse.Headear.Msg  := '';
  fResponse.Headear.ContentLength   := 0;
  fResponse.Headear.ContentEncoding := '';
  fResponse.Headear.Cookie          := '';
  fResponse.Headear.Bludata.ResponseValidation := '';
  fResponse.Text := '';
end;

procedure TRESTRequestD7.AddBody(prValue: WideString; prType: TContentType);
begin
  fBody.Content     := prValue;
  fBody.ContentType := prType;
end;

procedure TRESTRequestD7.ClearProperties;
begin
  fProperties.Accept         := '';
  fProperties.AcceptCharset  := '';
  fProperties.AcceptEncoding := '';
  fProperties.UserAgent      := '';
  fProperties.ContentType    := '';
end;

function TRESTRequestD7.Post(prURL, prResource: WideString): Boolean;
var
  fPost: TRESTPost;
begin
  Result := False;
  ClearResponse;
  if (fHandle = 0) then
  begin
    MessageDlg('Erro ao carregar dll RESTRequest!',mtError,[mbOK],0);
    Exit;
  end;

  try
    @fPost := GetProcAddress(fHandle,'Post');
    if Assigned(fPost) then
    begin
      fResponse := fPost(prURL,prResource,fParams,fProperties,fBody);
      Result := True;
    end;
  except
    on e:Exception do
      MessageDlg('Erro requisição: '+e.Message,mtError,[mbOK],0);
  end;
end;

function TRESTRequestD7.Put(prURL, prResource: WideString): Boolean;
var
  fPut: TRESTPut;
begin
  Result := False;
  ClearResponse;
  if (fHandle = 0) then
  begin
    MessageDlg('Erro ao carregar dll RESTRequest!',mtError,[mbOK],0);
    Exit;
  end;

  try
    @fPut := GetProcAddress(fHandle,'Put');
    if Assigned(fPut) then
    begin
      fResponse := fPut(prURL,prResource,fParams,fProperties,fBody);
      Result := True;
    end;
  except
    on e:Exception do
      MessageDlg('Erro requisição: '+e.Message,mtError,[mbOK],0);
  end;
end;

function TRESTRequestD7.Delete(prURL, prResource: WideString): Boolean;
var
  fDelete: TRESTDelete;
begin
  Result := False;
  ClearResponse;
  if (fHandle = 0) then
  begin
    MessageDlg('Erro ao carregar dll RESTRequest!',mtError,[mbOK],0);
    Exit;
  end;

  try
    @fDelete := GetProcAddress(fHandle,'Delete');
    if Assigned(fDelete) then
    begin
      fResponse := fDelete(prURL,prResource,fParams,fProperties);
      Result := True;
    end;
  except
    on e:Exception do
      MessageDlg('Erro requisição: '+e.Message,mtError,[mbOK],0);
  end;
end;

end.
