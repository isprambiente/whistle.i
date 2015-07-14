FactoryGirl.define do
  factory :message do
    sequence(:body) { |n| "message_#{n}" }
    sequence(:detail) { |n| "username, email, name, surname, date"}
    attachments_attributes [{file: ActionDispatch::Http::UploadedFile.new(tempfile: File.new("#{Rails.root}/spec/fixtures/text1.txt"), :filename => "text1.txt")}]
  end
end
