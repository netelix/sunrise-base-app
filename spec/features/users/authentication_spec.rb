# frozen_string_literal: true

require 'rails_helper'
include Sunrise::SpecHelpers::DeviseFeature

RSpec.describe 'Authentication', :with_vcr do
  USER_DEVICES.each do |device|
    describe "with device: #{device[:name]}", driver: device[:name] do
      before { page.current_window.resize_to(device[:width], device[:height]) }
      let(:user) { users(:id_1) }
      let(:password) { 'azerty' }
      let(:device) { device }

      describe 'login' do
        context 'with a user with an account' do
          before do
            user.update!(password: password, admin: false)
            visit '/'
          end
          it 'logs in and is redirected to t he page where it was' do
            open_mobile_menu
            click_link 'Connexion'

            within '.ajax_modal' do
              expect(page).to have_content('Connectez-vous à votre compte')
              fill_in 'user[email]', with: user.email
              fill_in 'user[password]', with: password
              click_on 'Connexion'
            end

            wait_for_ajax

            expect(page).to have_content('Connecté(e).')

            only_for_desktop { click_on user.email }

            only_for_mobile { open_mobile_menu }
            expect(page).to have_selector(:link_or_button, 'Déconnexion')
          end
        end

        context 'with a user with a wrong password' do
          let(:password) { 'wrong_password' }
          before { visit '/' }
          it 'shows an error' do
            open_mobile_menu
            click_link 'Connexion'
            wait_for_ajax

            within '.ajax_modal' do
              expect(page).to have_content('Connectez-vous à votre compte')
              fill_in 'user[email]', with: user.email
              fill_in 'user[password]', with: password
              click_on 'Connexion'

              expect(page).to have_content(
                'Courriel ou mot de passe incorrect.'
              )
            end

            expect(page.find('.ajax_modal')).to have_content(
              'Courriel ou mot de passe incorrect.'
            )
          end
        end
      end
      describe 'log out' do
        before do
          sign_in(user)
          visit '/'
        end
        it 'closes the session and redirects to homepage' do
          only_for_desktop { click_on user.email }

          only_for_mobile { open_mobile_menu }
          click_on('Déconnexion')

          expect(page).to have_content('Déconnecté(e).')
        end
      end
    end
  end

  def open_mobile_menu
    if(device[:name] == :chrome_android_phone)
      page.find('.navbar-toggler').click
    end
  end
end
