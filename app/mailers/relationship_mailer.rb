class RelationshipMailer < ApplicationMailer
    require 'sendgrid-ruby'
    include SendGrid

    def new_follower(user, follower)
        @user = user
        @follower = follower
        mail to: user.email, subject: '【お知らせ】フォローされました'
    end

    def self.test_email
        from = Email.new(email: 'hallelujah.m0214@gmail.com') # SendGridの管理画面でSenderに登録したアドレス
        to = Email.new(email: 'hallelujah_8068@icloud.com') # 送信したいアドレス
        subject = '【お知らせ】'
        content = Content.new(type: 'text/plain', value: 'フォローされました')
        mail = Mail.new(from, subject, to, content)
    
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: mail.to_json)
    end

    def send_email(user, follower)
        @user = user
        @follower = follower
        mail to: user.email, subject: '【お知らせ】フォローされました'
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    end
end 