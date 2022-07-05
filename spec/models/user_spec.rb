# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#filter_by_query' do
    subject { User.filter_by_query(query: query) }

    let!(:user1) { create(:user, first_name: 'John') }
    let!(:user2) { create(:user, first_name: 'Smith') }
    let(:query) { nil }

    context 'without query' do
      it 'returns all users' do
        expect(subject).to eq([user1, user2])
      end
    end

    context 'with query' do
      let(:query) { 'John' }

      it 'filters users by John' do
        expect(subject).to eq([user1])
      end

      context 'sql injection case' do
        let(:query) { '\' OR \'\'=\'' }

        it 'sql injection succeed and returns all users' do
          expect(subject).to eq([user1, user2])
        end
      end
    end
  end

  describe '#delete_by_query' do
    subject { -> { User.delete_all_by_query(query: query) } }

    let!(:user1) { create(:user, first_name: 'John') }
    let!(:user2) { create(:user, first_name: 'Smith') }
    let(:query) { nil }

    context 'without query' do
      it 'deletes all users' do
        is_expected.to change(User, :count).to(0)
      end
    end

    context 'with query' do
      let(:query) { 'John' }

      it 'delete users with John' do
        is_expected.to change(User, :count).to(1)
                   .and change { User.all }.to([user2])
      end

      context 'sql injection case' do
        let(:query) { '\' OR \'\'=\'' }

        it 'sql injection succeed and deletes all users' do
          is_expected.to change(User, :count).to(0)
        end
      end
    end
  end
end
