require 'rails_helper'

describe 'Dog resource', type: :feature do

  before :each do
    sign_in
  end

  it 'can create a profile' do
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Image', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'
    expect(@user.dog.count).to eq(1)
  end

  it 'can edit a dog profile' do
    dog = create(:dog, user_id: @user.id)
    visit edit_dog_path(dog)
    fill_in 'Name', with: 'Speck'
    click_button 'Update Dog'
    expect(dog.reload.name).to eq('Speck')
  end

  it 'can delete a dog profile' do
    dog = create(:dog, user_id: @user.id)
    visit dog_path(dog)
    click_link "Delete #{dog.name}'s Profile"
    expect(@user.dog.count).to eq(0)
  end

  def sign_in
    @user = create(:user)
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Log in"
  end
end
