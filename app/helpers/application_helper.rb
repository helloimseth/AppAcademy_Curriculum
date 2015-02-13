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
end
