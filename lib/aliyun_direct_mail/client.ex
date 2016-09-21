defmodule AliyunDirectMail.Client do

  @api "https://dm.aliyuncs.com/"
  @config Application.get_env(:aliyun_direct_mail, AliyunDirectMail)
    || raise "please set :aliyun_direct_mail config "

  def generate_params(params) do
    [
      Format: Keyword.get(@config, :format, "JSON"),
      Version: "2015-11-23",
      AccessKeyId: Keyword.get(@config, :access_key_id),
      SignatureMethod: "HMAC-SHA1",
      SignatureVersion: "1.0",
      # Timestamp: Timex.now |> Timex.format!("%FT%TZ", :strftime),
      Timestamp: DateTime.utc_now |> DateTime.to_iso8601,
      SignatureNonce: UUID.uuid1,
    ] ++ params
  end

  def join_query(params) do
    params
    |> Enum.sort
    |> Enum.map(fn {k, v} -> percent_encode(k) <> "=" <> percent_encode(v) end)
    |> Enum.join("&")
  end

  def percent_encode(param) when is_list(param) do
    param
    |> join_query
    |> percent_encode
  end

  def percent_encode(param) when is_bitstring(param) do
    param
    |> URI.encode_www_form
    |> String.replace("+", "%20")
    |> String.replace("*", "%2A")
    |> String.replace("%7E", "~")
  end

  def percent_encode(param) do
    param
    |> to_string
    |> percent_encode
  end

  def generate_sign(method, params) do
    string_to_sign = method <> "&%2F&" <> percent_encode(params)
    :crypto.hmac(:sha, Keyword.get(@config, :access_key_secret) <> "&", string_to_sign)
    |> Base.encode64
  end

  def get(params) do
    http_params = generate_params(params)
    sign = generate_sign("GET", http_params)
    query = (http_params ++ [Signature: sign]) |> URI.encode_query
    url = @api <> "?" <> query
    HTTPoison.get(url)
  end
end
