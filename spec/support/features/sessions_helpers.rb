module Features
  module SessionsHelpers
    def sign_in_to_acp(user)
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      visit admin_dashboard_path(locale: 'en')
    end
  end
end
