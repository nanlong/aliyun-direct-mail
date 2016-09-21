# AliyunDirectMail

**阿里云邮件发送**

## 安装

  1. 添加 `aliyun_direct_mail` 到 `mix.exs`:

    ```elixir
    def deps do
      [{:aliyun_direct_mail, github: "nanlong/aliyun_direct_mail"}]
    end
    ```

  2. 添加配置

    ```elixir
    config :aliyun_direct_mail, AliyunDirectMail,
      access_key_id: "xxxxxxxxxxxxxxxx",
      access_key_secret: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    ```

  3. 发个邮件测试一下吧

    ```elixir
    AliyunDirectMail.Mail.single_send(
      account_name: "noreply@mail.example.com",
      to_address: "test@example.com",
      subject: "This is a test email.",
      html_body: "This is a test email."
    )
    ```
