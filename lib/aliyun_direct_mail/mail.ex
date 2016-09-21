defmodule AliyunDirectMail.Mail do

  @doc """
  单一发信接口
  """
  def single_send(opts \\ []) do
    account_name = Keyword.get(opts, :account_name) || raise "plase set account_name"
    to_address = Keyword.get(opts, :to_address) || raise "please set to_address"
    subject = Keyword.get(opts, :subject) || raise "please set subject"
    html_body = Keyword.get(opts, :html_body) || raise "please set html_body"
    from_alias = account_name |> String.split("@") |> List.first

    params = [
      Action: "SingleSendMail",
      ReplyToAddress: Keyword.get(opts, :reply_to_address, true),
      AddressType: Keyword.get(opts, :address_type, 0),
      FromAlias: Keyword.get(opts, :from_alias, from_alias),
      TextBody: Keyword.get(opts, :text_body, ""),
      AccountName: account_name,
      ToAddress: to_address,
      Subject: subject,
      HtmlBody: html_body,
    ]

    AliyunDirectMail.Client.get(params)
  end

  @doc """
  批量发信接口
  """
  def batch_send() do

  end
end
