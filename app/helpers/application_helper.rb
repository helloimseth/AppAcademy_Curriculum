module ApplicationHelper
  def auth_token
    <<-HTML.html_safe
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
      HTML
  end

  def submit_button
    <<-HTML.html_safe
      <input type="submit"
        value="Submit">
    HTML
  end
  def login_button
    <<-HTML.html_safe
      <form action="#{session_url}"
            method="post">
            #{auth_token}
            <button>Log in</button>
      </form>

    HTML
  end

  def logout_button
    <<-HTML.html_safe
      <form action="#{session_url}"
            method="post">
            #{auth_token}
      <input type="hidden" name="_method" value="delete">
      <button>Log out</button>
      </form>
    HTML
  end
end
