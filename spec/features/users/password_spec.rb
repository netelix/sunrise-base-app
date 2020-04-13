# frozen_string_literal: true

require 'rails_helper'
require 'capybara/email/rspec'

include Sunrise::SpecHelpers::DeviseFeature

RSpec.describe 'Password', :with_vcr, type: :feature do
  USER_DEVICES.each do |device|
    describe "with device: #{device[:name]}", driver: device[:name] do
      before do
        visit '/'
        page.current_window.resize_to(device[:width], device[:height])
      end
      let(:user) { users(:id_1) }
      let(:password) { 'runergo' }
      let(:device) { device }

      describe 'recover' do
        before do
          visit '/en/login'
          clear_emails
        end
        it 'receives an email and set a new password' do
          click_link 'Mot de passe oublié ?'

          within '.ajax_modal' do
            fill_in 'user[email]', with: user.email
            click_on 'Recevoir le lien de ré-initialisation'
          end
          wait_for_ajax
          expect(page).to have_content(
            'You will receive an email with instructions on how to reset your password in a few minutes'
          )

          open_email(user.email)
          link = current_email.find('a', text: 'Réinitialiser votre mot de passe')[:href]
          expect(link).to include(Rails.configuration.action_mailer.asset_host)
          visit link.gsub(Rails.configuration.action_mailer.asset_host, '')

          expect(page).to have_content('Créer un nouveau mot de passe')
          fill_in 'user[password]', with: password
          fill_in 'user[password_confirmation]', with: password

          click_button 'Enregistrer'
          expect(page).to have_content(
            'You are now signed in'
          )
        end
      end
    end
  end
end
