require 'rails_helper'

describe MessagesController do
  let(:user){ create(:user) }
  let(:chat_group){ create(:chat_group) }
  let(:message){ build(:message)}

   before do
      sign_in user
    end

  describe 'GET #index' do
    before do
     get :index, id: message, chat_group_id: chat_group.id
    end

    it "assigns the requested @current_group " do
      current_group = build(:chat_group, id: chat_group.id)
      expect(assigns(:current_group)).to eq current_group
    end

    it "assigns the requested @current_group_members " do
      current_group = build(:chat_group, id: chat_group.id)
      current_group_members = current_group.users
      expect(assigns(:current_group_members)).to eq current_group_members
    end

    it "assigns the requested @current_user_groups " do
      current_user = build(:user)
      current_user_groups = current_user.chat_groups
      expect(assigns(:current_user_groups)).to match_array current_user_groups
    end

    it "assigns the requested @messages " do
      current_group = build(:chat_group, id: chat_group.id)
      messages = current_group.messages
      expect(assigns(:messages)).to match_array messages
    end

    it "assigns the requested @new_message " do
      new_message = build(:message, content: nil, image: nil, user_id: nil, chat_group_id: nil)
      expect(assigns(:new_message).present?).to eq true
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
      context 'success to save' do

          it 'save success' do
            create_success_params = {chat_group_id: chat_group.id, message: attributes_for(:message, chat_group_id: chat_group.id)}
            expect {
               post :create, create_success_params}.to change(Message, :count).by(1)
          end

          before do
            post :create, chat_group_id: chat_group.id, message: attributes_for(:message, chat_group_id: chat_group.id)
          end

          it 'redirect to #index' do
            expect(response).to redirect_to chat_group_messages_url(chat_group.id)
          end

          it 'has success message' do
            expect(flash[:notice]).to be_present
        end

      context 'fail to save' do
        it 'can not save in the database' do
          create_fail_params = {chat_group_id: chat_group.id, message: attributes_for(:message, chat_group_id: chat_group.id, content: '')}
          expect{
            post :create, create_fail_params}.not_to change(Message, :count)
        end

         before do
            post :create, chat_group_id: chat_group.id, message: attributes_for(:message, chat_group_id: chat_group.id, content: '')
          end

        it 'render #index after save failed' do
          expect(response).to redirect_to chat_group_messages_url(chat_group.id)
        end

        it 'has alert message' do
          expect(flash[:alert]).to be_present
        end
      end
    end
  end
end
