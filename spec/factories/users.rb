FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "User_#{n}" }
    sequence(:label) { |n| "Label_#{n}" }
    
    factory :admin_init do
      committee true
    end

    factory :admin do
      committee true

      after(:create) do |admin|
        rsa_key = OpenSSL::PKey::RSA.new(2048)
        cipher =  OpenSSL::Cipher::Cipher.new('des3')
        admin.priv = rsa_key.to_pem(cipher, '12345678')
        admin.pub = rsa_key.public_key.to_pem
        admin.save
      end
    end
  end
end
