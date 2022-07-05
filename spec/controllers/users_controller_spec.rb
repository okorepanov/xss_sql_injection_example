# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'responses with :ok status' do
      get :index

      expect(response).to have_http_status(:ok)
    end

    context 'with users' do
      before do
        create(:user, first_name: 'John')
        create(:user, first_name: 'Smith')
      end

      it 'assigns all users' do
        get :index

        expect(response).to have_http_status(:ok)
        expect(assigns(:users).count).to eq(2)
      end

      context 'with params' do
        let(:params) { Hash[query: 'John'] }

        it 'assigns users with John' do
          get :index, params: params

          expect(response).to have_http_status(:ok)
          expect(assigns(:users).count).to eq(1)
        end
      end
    end
  end

  describe 'DELETE #delete_all' do
    it 'responses with :ok status' do
      delete :delete_all

      expect(response).to have_http_status(:ok)
    end

    context 'with users' do
      let!(:user1) { create(:user, first_name: 'John') }
      let!(:user2) { create(:user, first_name: 'Smith') }

      it 'deletes all users' do
        delete :delete_all

        expect(response).to have_http_status(:ok)
        expect(User.count).to eq(0)
      end

      context 'with params' do
        let(:params) { Hash[query: 'John'] }

        it 'deletes users with John' do
          delete :delete_all, params: params

          expect(response).to have_http_status(:ok)
          expect(User.count).to eq(1)
        end
      end
    end
  end
end
