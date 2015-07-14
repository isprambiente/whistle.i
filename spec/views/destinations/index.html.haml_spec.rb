require 'rails_helper'

RSpec.describe 'destinations/index', type: :view do
  before(:each) do
    assign(:destinations, [
      Destination.create!(
        user: nil,
        message: nil,
        body: 'MyText',
        detail: 'MyText',
        readed: false,
        detailed: ''
      ),
      Destination.create!(
        user: nil,
        message: nil,
        body: 'MyText',
        detail: 'MyText',
        readed: false,
        detailed: ''
      )
    ])
  end

  it 'renders a list of destinations' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
    assert_select 'tr>td', text: ''.to_s, count: 2
  end
end
