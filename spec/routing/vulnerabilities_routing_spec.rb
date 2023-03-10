require 'rails_helper'

RSpec.describe VulnerabilitiesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/vulnerabilities').to route_to('vulnerabilities#index')
    end

    it 'routes to #show' do
      expect(get: '/vulnerabilities/1').to route_to('vulnerabilities#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/vulnerabilities').to route_to('vulnerabilities#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/vulnerabilities/1').to route_to('vulnerabilities#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/vulnerabilities/1').to route_to('vulnerabilities#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/vulnerabilities/1').to route_to('vulnerabilities#destroy', id: '1')
    end
  end
end
