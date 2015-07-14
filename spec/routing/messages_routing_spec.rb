require 'rails_helper'

RSpec.describe MessagesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/messages').to route_to('messages#index')
    end

    it 'routes to #list' do
      expect(get: '/messages/list.json').to route_to('messages#list', format: 'json')
    end

    it 'routes to #new' do
      expect(get: '/messages/new').to route_to('messages#new')
    end

    it 'routes to #create' do
      expect(post: '/messages').to route_to('messages#create')
    end

    it 'routes to #new as root_path' do
      expect(get: '/').to route_to('messages#new')
    end

    it 'routes to #show' do
      expect(get: '/messages/1').to route_to('messages#show', id: '1')
    end

    it 'routes to #body' do
      expect(post: '/messages/1/body').to route_to('messages#body', id: '1')
    end

    it 'routes to #detail' do
      expect(post: '/messages/1/detail').to route_to('messages#detail', id: '1')
    end

    it 'routes to #attachment' do
      expect(post: '/messages/1/attachment/1').to route_to('messages#attachment', id: '1', attachment_id: '1')
    end    

    it 'routes to #update' do
      expect(put: '/messages/1').to route_to('messages#update', id: '1')
    end
  end
end
