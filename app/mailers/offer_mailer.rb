class OfferMailer < ApplicationMailer
    default from: 'YuzuruOSU@example.com'

    def offer_email(provider, recipient, post)
        @provider = provider
        @recipient = recipient
        @post = post
        @url = 'http://localhost:3000/posts/'
        mail(to: @provider.email, subject: 'あなたの提供にオファーがあります！')
    end
end
