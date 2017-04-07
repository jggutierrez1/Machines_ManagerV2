unit Base64;

interface

uses
  SysUtils, IdCoder, IdCoder3to4, IdCoderMIME;

function Base64Decode(const Text: ansiString): ansiString;
function Base64Encode(const Text: ansiString): ansiString;

implementation

function Base64Decode(const Text: ansiString): ansiString;
var
  Decoder: TIdDecoderMime;
begin
  Decoder := TIdDecoderMime.Create(nil);
  try
    Result := Decoder.DecodeString(Text);
  finally
    FreeAndNil(Decoder)
  end
end;

function Base64Encode(const Text: ansiString): ansiString;
var
  Encoder: TIdEncoderMime;
begin
  Encoder := TIdEncoderMime.Create(nil);
  try
    Result := Encoder.EncodeString(Text);
  finally
    FreeAndNil(Encoder);
  end
end;

end.
