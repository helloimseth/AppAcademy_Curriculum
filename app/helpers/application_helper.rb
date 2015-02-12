module ApplicationHelper

  def auth_token
    <<-HTML.html_safe
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML
  end

  def email_password_form
    <<-HTML.html_safe
      <label for="user_email">Email</label>
      <input type="text" name="user[email]">

      <br><br>

      <label for="user_password">Password</label>
      <input type="password" name="user[password]">

      <br><br>

      <input type="submit" value="Submit">
    HTML
  end

end
