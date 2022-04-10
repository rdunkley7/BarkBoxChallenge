require 'rails_helper'
require 'devise'

RSpec.describe DogsController, type: :controller do

  context 'valid user signed in' do
    before :each do
      user1 = create(:user)
      2.times { create(:dog, user_id: user1.id) }
      sign_in user1
    end

    describe '#index' do
      it 'displays recent dogs' do
        get :index

        expect(assigns(:dogs).size).to eq(2)
        expect(response.status).to eq(200)
      end
    end

    describe '#create' do
      it 'successfully creates a dog' do
        params = { name: 'Bolt', description: 'A speedy boy', format: :json }

        post :create, params: { dog: params }

        expect(subject.current_user.dog.count).to eq(3)
        expect(response.status).to eq(302)
      end
    end

    describe '#update' do
      it 'update a dog info' do
        dog = Dog.last
        params = { name: 'Dusty', description: 'Likes fetch', format: :json }
        put :update, params: {id: dog.id, dog: params }

        updated_dog = Dog.find_by(id: dog.id)
        expect(updated_dog.name).to eq('Dusty')
        expect(response.status).to eq(302)
      end
    end

    describe '#destroy' do
      it 'deletes a dog from records' do
        dog = Dog.last

        delete :destroy, params: { id: dog.id}

        deleted_dog = Dog.find_by(id: dog.id)
        expect(response.status).to eq(302)
        expect(deleted_dog).not_to be_present
        expect(subject.current_user.dog.count).to eq(1)
      end
    end
  end

  context 'user not signed in' do
    context 'user not signed in' do
      it 'fails to create dog with missing user params' do
        params = { name: 'Izzy', description: 'A nice girl', format: :json }

        post :create, params: { dog: params }

        # verify if the new dog is found after creation
        new_dog = Dog.find_by(name: params[:name])
        expect(new_dog).not_to be_present
        expect(Dog.count).to eq(0)
        # redirected to sign in page
        expect(response.status).to eq(302)
      end
    end
  end
end
