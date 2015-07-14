require 'rails_helper'

RSpec.describe 'messages/index', type: :view do
  before(:each) do
    assign(:messages, [
      Message.create!(
        title: 'Title'
      ),
      Message.create!(
        title: 'Title'
      )
    ])
  end

  it 'renders a list of messages' do
    render
    assert_select 'tr>td', text: 'Title'.to_s, count: 2
  end
end
