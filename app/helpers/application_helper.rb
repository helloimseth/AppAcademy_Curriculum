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

  def log_in_button
    <<-HTML.html_safe
      <form action="#{new_session_url}" method="get">
        <button>Log In</button>
      </form>
    HTML
  end

  def log_out_button
    <<-HTML.html_safe
      <form action="#{session_url}" method="post">
        <input type="hidden" name="_method" value="delete">
        #{auth_token}
        <button>Log Out</button>
      </form>
    HTML
  end

  def submit_button
    <<-HTML.html_safe
      <input type="submit" value="Submit">
    HTML
  end

  def ugly_lyrics(lyrics)
    <<-HTML.html_safe
        <pre>&#9835; #{lyrics.chomp.gsub("\n", "\n&#9835; ")}</pre>
    HTML
  end



end
