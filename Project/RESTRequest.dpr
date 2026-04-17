library RESTRequest;

uses
  System.SysUtils,
  System.Classes,
  REST.Types,
  REST.Client,
  uRESTClass in '..\Sources\uRESTClass.pas';

{$R *.res}
var
  fRESTRequest: TRESTRequest;
  fRestClient: TRESTClient;

function Get(prHost, prResource: WideString; var prParams: TParams; var prProperties: TProperties): TRESTResponse; stdcall;
var
  i: Integer;
begin
  fRESTRequest := TRESTRequest.Create(nil);
  fRestClient  := TRESTClient.Create(nil);
  fRESTRequest.Client := fRestClient;
  try
    try
      fRestClient.BaseURL := prHost;
      fRESTRequest.Resource := prResource;
      fRESTRequest.Method := rmGET;

      fRestClient.Accept         := prProperties.Accept;
      fRestClient.AcceptCharset  := prProperties.AcceptCharset;
      fRestClient.AcceptEncoding := prProperties.AcceptEncoding;
      fRestClient.ContentType    := prProperties.ContentType;
      fRestClient.UserAgent      := prProperties.UserAgent;

      fRESTRequest.Params.Clear;
      for I := Low(prParams) to High(prParams) do
        fRESTRequest.AddParameter(prParams[i].Name,prParams[i].Value,TRESTRequestParameterKind(prParams[i].Kind));

      fRESTRequest.Execute;

      Result.Text := fRESTRequest.Response.Content;
      //Header Response
      Result.Headear.Code            := fRESTRequest.Response.StatusCode;
      Result.Headear.Str             := fRESTRequest.Response.Headers.Text;
      Result.Headear.Msg             := fRESTRequest.Response.ErrorMessage;
      Result.Headear.ContentLength   := fRESTRequest.Response.ContentLength;
      Result.Headear.ContentEncoding := fRESTRequest.Response.ContentEncoding;
      Result.Headear.Bludata.ResponseValidation := fRESTRequest.Response.Headers.Values['X-Bludata-ResponseValidation'];
      for I := 0 to fRESTRequest.Response.Headers.Count - 1 do
        if (fRESTRequest.Response.Headers.Names[i] = 'Set-Cookie') then
          Result.Headear.Cookie := Result.Headear.Cookie + fRESTRequest.Response.Headers.ValueFromIndex[i] + #13#10;
    except
      on e: Exception do
      begin
        Result.Headear.Code := fRESTRequest.Response.StatusCode;
        Result.Text := e.Message;
      end;
    end;
  finally
    fRESTRequest.Free;
    fRestClient.Free;
  end;
end;

function Post(prHost, prResource: WideString; var prParams: TParams; var prProperties: TProperties; var prBody: TBody): TRESTResponse; stdcall;
var
  i: Integer;
  wUTF8String: UTF8String;
begin
  fRESTRequest := TRESTRequest.Create(nil);
  fRestClient  := TRESTClient.Create(nil);
  fRESTRequest.Client := fRestClient;
  try
    try
      wUTF8String := UTF8Encode(prBody.Content);
      fRestClient.BaseURL := prHost;
      fRESTRequest.Resource := prResource;
      fRESTRequest.Method := rmPOST;

      fRestClient.Accept         := prProperties.Accept;
      fRestClient.AcceptCharset  := prProperties.AcceptCharset;
      fRestClient.AcceptEncoding := prProperties.AcceptEncoding;
      fRestClient.ContentType    := prProperties.ContentType;
      fRestClient.UserAgent      := prProperties.UserAgent;

      fRESTRequest.Params.Clear;
      for I := Low(prParams) to High(prParams) do
      begin
        fRESTRequest.Params.AddItem(prParams[i].Name,prParams[i].Value,TRESTRequestParameterKind(prParams[i].Kind),[poDoNotEncode]);
      end;

      if (wUTF8String <> '') then
        fRESTRequest.AddBody(wUTF8String,TRESTContentType(prBody.ContentType));

      fRESTRequest.Execute;

      Result.Text := fRESTRequest.Response.Content;
      //Header Response
      Result.Headear.Code            := fRESTRequest.Response.StatusCode;
      Result.Headear.Str             := fRESTRequest.Response.Headers.Text;
      Result.Headear.Msg             := fRESTRequest.Response.ErrorMessage;
      Result.Headear.ContentLength   := fRESTRequest.Response.ContentLength;
      Result.Headear.ContentEncoding := fRESTRequest.Response.ContentEncoding;
      Result.Headear.Bludata.ResponseValidation := fRESTRequest.Response.Headers.Values['X-Bludata-ResponseValidation'];
      for I := 0 to fRESTRequest.Response.Headers.Count - 1 do
        if (fRESTRequest.Response.Headers.Names[i] = 'Set-Cookie') then
          Result.Headear.Cookie := Result.Headear.Cookie + fRESTRequest.Response.Headers.ValueFromIndex[i] + #13#10;
    except
      on e: Exception do
      begin
        Result.Headear.Code := fRESTRequest.Response.StatusCode;
        Result.Text := e.Message;
      end;
    end;
  finally
    fRESTRequest.Free;
    fRestClient.Free;
  end;
end;

exports
  Get,
  Post;

begin
end.
