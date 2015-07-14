require 'rails_helper'

RSpec.describe 'destinations/show', type: :view do
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

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
