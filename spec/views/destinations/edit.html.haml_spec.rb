require 'rails_helper'

RSpec.describe 'destinations/edit', type: :view do
  before(:each) do
    @destination = assign(:destination, Destination.create!(
                                          user: nil,
                                          message: nil,
                                          body: 'MyText',
                                          detail: 'MyText',
                                          readed: false,
                                          detailed: ''
    ))
  end

  it 'renders the edit destination form' do
    render

    assert_select 'form[action=?][method=?]', destination_path(@destination), 'post' do
      assert_select 'input#destination_user_id[name=?]', 'destination[user_id]'

      assert_select 'input#destination_message_id[name=?]', 'destination[message_id]'

      assert_select 'textarea#destination_body[name=?]', 'destination[body]'

      assert_select 'textarea#destination_detail[name=?]', 'destination[detail]'

      assert_select 'input#destination_readed[name=?]', 'destination[readed]'

      assert_select 'input#destination_detailed[name=?]', 'destination[detailed]'
    end
  end
end
