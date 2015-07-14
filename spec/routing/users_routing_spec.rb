require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users').to route_to('users#index')
    end

    it 'routes to #list' do
      expect(get: '/users/list.json').to route_to('users#list', format: 'json')
    end

    it 'routes to #show' do
      expect(get: '/users/1').to route_to('users#show', id: '1')
    end

    it 'routes to #log' do
      expect(get: '/users/1/log.json').to route_to('users#log', id: '1', format: 'json')
    end

    it 'routes to #update' do
      expect(put: '/users/1').to route_to('users#update', id: '1')
    end

    it 'routes to #add_key' do
      expect(post: '/users/add_key').to route_to('users#add_key')
    end
  end
end
