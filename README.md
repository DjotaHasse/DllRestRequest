## ⚙️ Como Utilizar
Adicionar a Dll da pasta Bin na pasta do executável do projeto e adicionar a pasta Sources na Library Path do Delphi antigo.

## 📖 Exemplos 

Requisição GET
``` sh
var
  fRestRequest: TRESTRequestD7;
begin
  Memo1.Lines.Clear;

  fRestRequest := TRESTRequestD7.Create;
  try
    fRestRequest.Accept         := 'Accept';
    fRestRequest.AcceptCharset  := 'AcceptCharset';
    fRestRequest.AcceptEncoding := 'AcceptEncoding';
    fRestRequest.ContentType    := 'ContentType';
    fRestRequest.UserAgent      := 'UserAgent';
    fRestRequest.AddParam('Key_Param1','Value_Param1',pkHTTPHEADER);
    fRestRequest.AddParam('Key_Param2','Value_Param2',pkHTTPHEADER);
    fRestRequest.AddParam('Key_Param3','Value_Param3',pkHTTPHEADER);
    if (fRestRequest.Get('BASE_URL','RESOURCE_URL')) then
    begin
      Memo1.Lines.Add('Result.Code: '+IntToStr(fRestRequest.Response.Headear.Code));
      Memo1.Lines.Add('Result.Text: '+fRestRequest.Response.Text);
    end;
  finally
    fRestRequest.Free;
  end;
```

Requisição POST JSON
``` sh
var
  fRestRequest: TRESTRequestD7;
  wPostData: WideString
begin
  Memo1.Lines.Clear;

  wPostData := 'YOUR_JSON';
  fRestRequest := TRESTRequestD7.Create;
  try
    fRestRequest.Accept         := 'Accept';
    fRestRequest.AcceptCharset  := 'AcceptCharset';
    fRestRequest.AcceptEncoding := 'AcceptEncoding';
    fRestRequest.ContentType    := 'ContentType';
    fRestRequest.UserAgent      := 'UserAgent';
    fRestRequest.AddParam('Key_Param1','Value_Param1',pkHTTPHEADER);
    fRestRequest.AddParam('Key_Param2','Value_Param2',pkHTTPHEADER);
    fRestRequest.AddParam('Key_Param3','Value_Param3',pkHTTPHEADER);
    fRestRequest.AddBody(wPostData,ctAPPLICATION_JSON);
    if (fRestRequest.Post('BASE_URL','RESOURCE_URL')) then
    begin
      Memo1.Lines.Add('Result.Code: '+IntToStr(fRestRequest.Response.Headear.Code));
      Memo1.Lines.Add('Result.Text: '+fRestRequest.Response.Text);
    end;
  finally
    fRestRequest.Free;
  end;
```

Requisição POST x-www-form-urlencoded
``` sh
var
  fRestRequest: TRESTRequestD7;
begin
  Memo1.Lines.Clear;

  fRestRequest := TRESTRequestD7.Create;
  try
    fRestRequest.Accept         := 'Accept';
    fRestRequest.AcceptCharset  := 'AcceptCharset';
    fRestRequest.AcceptEncoding := 'AcceptEncoding';
    fRestRequest.ContentType    := 'ContentType';
    fRestRequest.UserAgent      := 'UserAgent';
    fRestRequest.AddParam('Data','Example_Data',pkGETorPOST);
    fRestRequest.AddParam('Hash','Example_Hash',pkGETorPOST);
    fRestRequest.AddParam('AuthKey','Example_AuthKey',pkGETorPOST);
    if (fRestRequest.Post('BASE_URL','RESOURCE_URL')) then
    begin
      Memo1.Lines.Add('Result.Code: '+IntToStr(fRestRequest.Response.Headear.Code));
      Memo1.Lines.Add('Result.Text: '+fRestRequest.Response.Text);
    end;
  finally
    fRestRequest.Free;
  end;
```
